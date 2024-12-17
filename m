Return-Path: <linux-kernel+bounces-449225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71F59F4BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6E517A6F48
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8181F668A;
	Tue, 17 Dec 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="eCwRMo7/"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E31F6675
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440877; cv=none; b=QTdpRzEptNsMZCst6NAmjPMHtNTrKonAHOMbzYjgwq6Xt9M1x/i8CFhXZ41bxyqOTGZER0P5Y7eM9sGKOR0UOuyk8iSoZCY/mxZJHR8WmQaaNehNHapd7ruVzfXy0o+4KTvnKmBNI7nMLCREaPLXvM2uHJE2cABBaKWJ3xHv6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440877; c=relaxed/simple;
	bh=uSgl6tmpjcKrpfU+/rRT4WEOic2miN6oQ63t67Qe7qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooBrCZJBHaZ28h5hLEJFrWZ0nNHtH52bPLdJwMSnjY9aoQctco87ASn26wPvjuJWywlWwbxLWyY5WOayzfdO/pArat0hVR1QmzPXhqKbZHvoFU+5IAHqegBQ2sPuF4E7BWge36Q3nfM33r0MwSkRqW6ze2KRGnzAuuP6Ux/oM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=eCwRMo7/; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734440875;
	bh=lxh3lTkHEDaNLjOBBiXkDjAykRGLwhRpR2ibcxXXYlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=eCwRMo7/LgSVvktxSqbGgcZApkt6SkauMZqQMw6KZx84xgPXcAymXEFYIaDiH9ilX
	 nFNutISArw21RKc6VG+vHDd//zCabk48QAARiu21Ppo/pvZXKatyFLrz/caX8LOLZp
	 8Uq16hikiy7OAVtgEXIDbWlOP2wX6JzFv6PhxrTB2Npc+OZuoGKn2mRFNkeSKQaXa2
	 Y7lN3itTnelKmiHed/RSxuCsf7VO+UNnNF4SNSbmxc6Qtj2tzTs3Hwo+WBePX0Xf0y
	 W2bIVNU3ZtPOcrDVDvxV1lAN6xMHSpnNNVM9gCxH7jkXpl0wZzOXHvY2IEQNEMSEmJ
	 J+cfT3JH5Ytzw==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 5801F96011C;
	Tue, 17 Dec 2024 13:07:51 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 17 Dec 2024 21:07:26 +0800
Subject: [PATCH v3 2/7] of: Do not expose of_alias_scan() and correct its
 comments
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-of_core_fix-v3-2-3bc49a2e8bda@quicinc.com>
References: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
In-Reply-To: <20241217-of_core_fix-v3-0-3bc49a2e8bda@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Grant Likely <grant.likely@secretlab.ca>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: F6TYqueI41j27AqSVFER4prK9RSNzbsV
X-Proofpoint-ORIG-GUID: F6TYqueI41j27AqSVFER4prK9RSNzbsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_07,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170105
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For of_alias_scan():
- Do not expose it since it has no external callers.
- Correct its comments shown below:
  1) Replace /* with /** to start comments since it is not a API.
  2) Delete return value descriptions since it is a void function.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/base.c       | 5 ++---
 drivers/of/of_private.h | 2 ++
 drivers/of/pdt.c        | 2 ++
 include/linux/of.h      | 1 -
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 969b99838655534915882abe358814d505c6f748..5485307e2a3a3d3a216d271c60bdfc346dd38460 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1806,14 +1806,13 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 		 ap->alias, ap->stem, ap->id, np);
 }
 
-/**
+/*
  * of_alias_scan - Scan all properties of the 'aliases' node
  * @dt_alloc:	An allocator that provides a virtual address to memory
  *		for storing the resulting tree
  *
  * The function scans all the properties of the 'aliases' node and populates
- * the global lookup table with the properties.  It returns the
- * number of alias properties found, or an error code in case of failure.
+ * the global lookup table with the properties.
  */
 void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 {
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index ea5a0951ec5e107bab265ab5f6c043e2bfb15ecc..3433ccd330e84fd3a4b54638e0e922069757c8f0 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -119,6 +119,8 @@ extern void *__unflatten_device_tree(const void *blob,
 			      void *(*dt_alloc)(u64 size, u64 align),
 			      bool detached);
 
+void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
+
 /**
  * General utilities for working with live trees.
  *
diff --git a/drivers/of/pdt.c b/drivers/of/pdt.c
index 7eda43c66c916198b1c2d8fc5043fcb1edaede7a..cb0cb374b21ff89323e11f34bd767b183e7a401e 100644
--- a/drivers/of/pdt.c
+++ b/drivers/of/pdt.c
@@ -19,6 +19,8 @@
 #include <linux/of.h>
 #include <linux/of_pdt.h>
 
+#include "of_private.h"
+
 static struct of_pdt_ops *of_pdt_prom_ops __initdata;
 
 #if defined(CONFIG_SPARC)
diff --git a/include/linux/of.h b/include/linux/of.h
index f921786cb8ac782286ed5ff4425a35668204d050..d451c46132b01efe6d4e0b6cf83a3e2084bb3ec6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -397,7 +397,6 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 				    uint32_t *args,
 				    int size);
 
-extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(const struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 

-- 
2.34.1


