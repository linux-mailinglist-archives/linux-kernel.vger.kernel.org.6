Return-Path: <linux-kernel+bounces-332743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F6697BE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100C9B21D24
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565081C0DCB;
	Wed, 18 Sep 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="KarTdo96"
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913A1BF7E4
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670915; cv=none; b=bQaxdftZME5nvQvoleWtKv6c3GrWSTso+6sYrLX0mMvKbG0ykrwrXcrxY9GZPWa1PPvqnrNEDxl1a7Bhz48n9I6iv00KGT0kcGCGXzDRBEE6jNfwO9WuB9kkf+gBFCEguv+2lb4xiAiwSCBk8/8aFqtsvK3e9YAmPi83X2clr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670915; c=relaxed/simple;
	bh=z4A5ImFOhhsYVJl1a2DysNWZvJbp7INZWxwT1oiHKuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JHOEwvxmYaDkQzqi9ZC+vNxGpI/c/CfV6i7Pn+WGgpvNFGw56vmkBV9PK36daXEDOo2qlEa2ECnDq8bc22+Rk/JeAfEuHytJ0A3Titxm2usENyabDBFYur8IxTCFrRUCcTVIfoDzy53u6y7M6spROMm08RZwth1RycPmH58G8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=KarTdo96; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1726670913;
	bh=rHGh9AkPCqgf6FHo9gjomoSr9sUI+Gct2Gxl1BA1iik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=KarTdo96tJnXV5pcjOxL85+uGo2LyUvpel3Enlvg+u4vybrWPZa7f4npjfDPZPmBt
	 ZjFEdSKSsm8U3sTlr0ID3XNrjNUtVutcPiu/m490eeKaJFEVarIYCldhqlcSLtDBxI
	 zw21l4iL9y0YE/KbU2fE9C/JhtL+oJvdOWMOZSo1ijhZus2CtpuZJbkbZm+ufPYCLz
	 jFSFoZqBBzrDZ27b0IPm77ycSLMPXcFCcf/FfjFDS5/efO0SnHyiaq+NHQWREb2bPj
	 6LcmBPinGbvHOPLxhy1vwPOdmSyMch1O9wBtVBqVJWqJQYl41wV75GMx9BlvQuYWu0
	 eM4HKA3JQUM2g==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id 57759800118;
	Wed, 18 Sep 2024 14:48:31 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 18 Sep 2024 22:48:13 +0800
Subject: [PATCH 1/2] lib: devres: Simplify API devm_iounmap()
 implementation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-fix_lib_devres-v1-1-e696ab5486e6@quicinc.com>
References: <20240918-fix_lib_devres-v1-0-e696ab5486e6@quicinc.com>
In-Reply-To: <20240918-fix_lib_devres-v1-0-e696ab5486e6@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-ORIG-GUID: TKofihg4yNJnelGGLeRQ4KJURY6cv7JC
X-Proofpoint-GUID: TKofihg4yNJnelGGLeRQ4KJURY6cv7JC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_10,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409180096
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify devm_iounmap() implementation by dedicated API devres_release()
compared with current solution, namely, devres_destroy() + iounmap()
devres_release() has the following advantages:

- it is simpler if devm_iounmap()'s parameter @addr is valid, namely
  @addr was ever returned by one of devm_ioremap() variants.

- it can avoid unnecessary iounmap(@addr) if @addr is not valid.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 lib/devres.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 4fc152de6d8b..68ffcd5d9358 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -115,9 +115,8 @@ EXPORT_SYMBOL(devm_ioremap_wc);
  */
 void devm_iounmap(struct device *dev, void __iomem *addr)
 {
-	WARN_ON(devres_destroy(dev, devm_ioremap_release, devm_ioremap_match,
+	WARN_ON(devres_release(dev, devm_ioremap_release, devm_ioremap_match,
 			       (__force void *)addr));
-	iounmap(addr);
 }
 EXPORT_SYMBOL(devm_iounmap);
 

-- 
2.34.1


