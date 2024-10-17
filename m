Return-Path: <linux-kernel+bounces-370058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE89A26CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CB01F2698D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11AA1DE880;
	Thu, 17 Oct 2024 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Z22CHj4q"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499261DDC14
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179311; cv=none; b=A3ArBJXJIP+c6fhL9W5nCqyNsuyVCeeJ1lhEmE61P7KZH/byPQTTd6y7cPGMIJNHsPzJN3wyeLic1NqXmo1i3RFALOmG/dZDTFdi6J/Md30wszwt4yghk8rHR8ZrMeYq8HCHaRUBXWxZthUlTKKvfJ8CEFIbCvBi6cdQJ5wgG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179311; c=relaxed/simple;
	bh=Wgz89BkETBsknJ1bG4vgcyNpx9ZR5zoPyUv+MpPSScY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R0M7SyTVyDM7rvsTcnp5Wiiagfb/fiOl35JRxGxHOEob5l/FKnO3ddZpS+tjA8zzJgNiZZkgK+HCKY+2Q/gCR4Omoa9cLOdhVFCsJdlcQ10SDYieW7x9rnhOx/BtxCboHky9icjxHvQ+MroD5jhZHC1+yYvbordHAnfZ9BNXuDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Z22CHj4q; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1729179305;
	bh=NgwwknkJJpfTdCab9EonH5stt9SEBiaDmBUnx2avHas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=Z22CHj4qy4K5pzQlckk2mMxF4CyM99qmrdT31PkhM7klomuX3EPTbQlV/a0Jl+X7K
	 YVAVj+AXo40AJQSOdwgb1r6cZOyOqlpaN1VUulziSDAw2DTYxt+N0EXPK0xL9Znek1
	 Pgmu58mZkaOB7hkBEoQ6X2O0nOh3kCFS2zQSsGqimpqaD+OUCUJoZn7OIT9Dbt4lqZ
	 LpVTGrFtiFvPDiP5jxh8maisFUj8lMtS+C1pRX+FrIrHa/s8h7wu6tKqjnpe7RGMIo
	 Duq+Fm+OzTnUeehCPgoRnfM/tARnFBPxPtGwhMvrmWk0dMzjJ7x1pUGa1TeM7ZLSQE
	 Wr42jiPhc8JOw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 8A5929604EF;
	Thu, 17 Oct 2024 15:35:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 17 Oct 2024 23:34:49 +0800
Subject: [PATCH] kernel/resource: Simplify API __devm_release_region()
 implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-release_region_fix-v1-1-84a3e8441284@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJguEWcC/x2M7QpAQBBFX0Xz29Z+yMarSNq4mBKaLSl5d5Of5
 3bueShDGJna4iHBxZmPXcGVBY1r2hcYnpTJW18566IRbEgZg2BRdZj5Nj6lODch1BGW9HgKdP6
 jXf++H3thKstkAAAA
To: Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: UXufjuedCGInnPlTHJBjJcXuuGK9x5-k
X-Proofpoint-GUID: UXufjuedCGInnPlTHJBjJcXuuGK9x5-k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_18,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 mlxlogscore=950 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410170107
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify __devm_release_region() implementation by dedicated
API devres_release() which have below advantages than current
__release_region() + devres_destroy():

It is simpler if __devm_release_region() is undoing what
__devm_request_region() did, otherwise, it can avoid wrong and
undesired __release_region().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
linux-next tree has similar fixes as shown below:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ee4dcafda9576910559f0471a3d6891daf9ab92
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
---
 kernel/resource.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..8d619c449a73 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1673,8 +1673,7 @@ void __devm_release_region(struct device *dev, struct resource *parent,
 {
 	struct region_devres match_data = { parent, start, n };
 
-	__release_region(parent, start, n);
-	WARN_ON(devres_destroy(dev, devm_region_release, devm_region_match,
+	WARN_ON(devres_release(dev, devm_region_release, devm_region_match,
 			       &match_data));
 }
 EXPORT_SYMBOL(__devm_release_region);

---
base-commit: 9bd133f05b1dca5ca4399a76d04d0f6f4d454e44
change-id: 20241017-release_region_fix-2aa7f93367e0

Best regards,
-- 
Zijun Hu <quic_zijuhu@quicinc.com>


