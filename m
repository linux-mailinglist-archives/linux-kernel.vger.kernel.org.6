Return-Path: <linux-kernel+bounces-282111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B494DFB8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B3B1C20D4B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D25213A3E0;
	Sun, 11 Aug 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="AYU/Bp/H"
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253F13A864
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723343206; cv=none; b=Z4uOhkFp23BP5P93Or5YaFrlQmA9pWV9W9fwGlDnclOfAr30HRFtYWYK3AdQX0edLrJ5c3o+/VWHeo2qvRhbwUceTrO6ps6WF/yP7D/FyP55Ue0hSG/echteOydQ7WNC3VwIi3QYh/fV0uLMaRLX51L1IGlsbsEiC++ZrxTview=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723343206; c=relaxed/simple;
	bh=0srK2amBNBPpRL7zUQgBlwVH0SP62Y8T1gyEl+kTpgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWPRPIzimhnDaAhNFSYPwwsG4oYODRIAHvKAXZTBil4AUADWv28E1sNnBOizVXZpceXjwKHXp37lWZVEdk8GWaVNHEH44yuLFZxq0cLWaG3slEfvBRZ/lFsfsukcO4ntHudpl9FW5075OJN6qige825btAm9jryntSAdpG7RKU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=AYU/Bp/H; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1723343205;
	bh=WQ+DL7U2PXrVJLMzKegAiM9gtbkwlGcLGWms6yVndZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
	b=AYU/Bp/Hkg3PcU4ShtCrzOGaBuke9Lni6LBsXZpBnWJKmL9P7fmh6HyEWv/NMIkvy
	 havL2znliZS2bGsGlqODN/1gtz/DHSKfS3LVt065/P7/5zwVXOa6xWcIQISkbwjM7E
	 Ril918a6Hl9a006wZPuhq7rSSzq1S9KQUg1xeSEAikHB8um4ZBWBGtXYm3X+BHQHW1
	 uGjcgp4ZBsAm2KvRn+wAAqqCfIvFy74luoYnBoRdipKvev4vvibtV9jatGCID0J82a
	 NRb5dkyx4m2zFuYIyzBGFqNAFlJLx546elBAdf1kfc7JOiVU89tA8UeJcxvCDaX7YI
	 BFV0XY8ySP+Pw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id B56EF1349BCD;
	Sun, 11 Aug 2024 02:26:41 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 11 Aug 2024 10:25:14 +0800
Subject: [PATCH 23/27] libnvdimm: Make device_find_child()'s match function
 take a const pointer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240811-const_dfc_done-v1-23-9d85e3f943cb@quicinc.com>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
In-Reply-To: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Proofpoint-GUID: hXG6MO5fKuNuBZ_TJy-B9JCnuCOPLD2b
X-Proofpoint-ORIG-GUID: hXG6MO5fKuNuBZ_TJy-B9JCnuCOPLD2b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_01,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=922
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2408110017
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In order to adapt for constified device_find_child(), make
namespace_match() as its match function take a const pointer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/nvdimm/claim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 030dbde6b088..b33fa340068b 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -67,9 +67,9 @@ bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 	return claimed;
 }
 
-static int namespace_match(struct device *dev, void *data)
+static int namespace_match(struct device *dev, const void *data)
 {
-	char *name = data;
+	const char *name = data;
 
 	return strcmp(name, dev_name(dev)) == 0;
 }

-- 
2.34.1


