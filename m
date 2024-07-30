Return-Path: <linux-kernel+bounces-268379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143509423EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EC31C22C57
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCB5523A;
	Wed, 31 Jul 2024 00:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hN9IFKrl"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7724C8E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386622; cv=none; b=Q1s7pyq/LFKXxxKTwbTBrR4yrRIMTx4n4uI3ht6lwZ5somEdc4w08Jkxjhe/r84Jhxk2U2a7mIF2pDnAXmpdt6O9hEY5/pRhFhp2EFyfksPk0u9zqpjkh9F1oxf9L+xHbI0euevAwdckfKc+rCkp2qQ6YQAh2ECfq82vPCd4QQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386622; c=relaxed/simple;
	bh=B8nS+HrchXt/TOq7CuC6gM8fOzsr+yNKA1+6iyCftCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=LCY1ILPZ/8daOsggC5JTfbZA32zl0cpHp/SS+rhhPo9yrMvYyqJt50okr1/C7kRgmcN7JPaJSr3mAQeY+Ny1HqmuMAQSALsreK8VUItx63XhIbpSnlYTsySONAf14D9hTFO4s55u2vpAis8lBTkq29pabVpzk6aPscgP9T5nIMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hN9IFKrl; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240731004337epoutp0303e2d9a83b8469f00a64dcc8b077a2ab~nJYDS30Lx0031700317epoutp03J
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:43:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240731004337epoutp0303e2d9a83b8469f00a64dcc8b077a2ab~nJYDS30Lx0031700317epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722386617;
	bh=a3IzWK5fitZJcQaGmkzyEQOcVdVpt6d41Zx8xDRd+Mg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hN9IFKrlYzE1hZNQ57E3RtPqI7Ug4i9vMNMr5CTJ0EJ4xQdfrVlBTEvv6MCUJNChD
	 9pBddJPKQXQJXUtNbqD/g2dM4JYmrYygg7rfOB0Lwv+hTNKQ33hvLOXQ/WezHHG7SL
	 Ac1DIBJqq0AuBhxzankhsniiDmmpUL0JVOtybUaM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240731004337epcas1p3290553a74b02376cfed9220c20607cf3~nJYDBfu461919819198epcas1p3H;
	Wed, 31 Jul 2024 00:43:37 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.227]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WYYHX5qDfz4x9Q3; Wed, 31 Jul
	2024 00:43:36 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DB.F9.19509.8B889A66; Wed, 31 Jul 2024 09:43:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240731004335epcas1p382229e79bdaf3f2d48b0f3faa7414ea6~nJYBdGAZh2218522185epcas1p3d;
	Wed, 31 Jul 2024 00:43:35 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731004335epsmtrp2372edfe6c42e4f748b0252ea939bdd9c~nJYBcfOB62816828168epsmtrp2M;
	Wed, 31 Jul 2024 00:43:35 +0000 (GMT)
X-AuditID: b6c32a4c-9ebcba8000004c35-1b-66a988b88e3a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.31.08456.7B889A66; Wed, 31 Jul 2024 09:43:35 +0900 (KST)
Received: from VDBS1327.vd.sec.samsung.net (unknown [168.219.243.39]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240731004335epsmtip129d22900c31bac57eaf2f21dc0c8616d~nJYBOktVm2059420594epsmtip1x;
	Wed, 31 Jul 2024 00:43:35 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Manjae Cho
	<manjae.cho@samsung.com>
Subject: [PATCH v2] staging: rtl8723bs: Improve MAR register definition and
 usage
Date: Wed, 31 Jul 2024 08:10:48 +0900
Message-Id: <20240730231046.412876-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmnu6OjpVpBsva9SyaF69ns7i8aw6b
	xZHPqRavj99gc2Dx2D93DbvHi80zGT36tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/JTMv3VbJ
	OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
	v7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO+PK6gaWgl7Oij2fW1gbGE+xdzFy
	ckgImEhM3fqcqYuRi0NIYA+jxNmObVDOJ0aJP+3XoJxvjBJdt/awwLRM2L2QDSKxl1Fi8s6/
	UFW/GCU+3t7K2MXIwcEmoCkxfa0fSIOIgJzEk9t/mEFsZoE0iVVXX7OB2MICwRIvdu5nBbFZ
	BFQl/r5qYgZp5RWwkTh0Mg9il7zEzEvfwU7lFRCUODnzCQvEGHmJ5q2zmUHWSghsYpfoPfiR
	CaLBRWLDnvVQhwpLvDq+BepPKYnP7/ayQdjFEkv/bIKqqZF42joDyjaW+HnuE9gNzEDnr9+l
	D7GLT+Ld1x5WkLCEAK9ER5sQRLWKxPlVG5ggwlISDQcNIcIeEjeubgMLCwnESjw6HTGBUW4W
	kvtnIbl/FsKqBYzMqxilUguKc9NTkw0LDHXzUsvhMZmcn7uJEZzStHx2MH5f/1fvECMTB+Mh
	RgkOZiUR3vgrS9OEeFMSK6tSi/Lji0pzUosPMZoCA3Uis5Rocj4wqeaVxBuaWBqYmBmZWBhb
	GpspifOeuVKWKiSQnliSmp2aWpBaBNPHxMEp1cC0+uGfCQ0ebz5n/1rBZHHq7uEjJ9y4IzTk
	SznWhO+Ld8y9NvmEstB1b8m57G/anrTw8p7e+1xFz+SOyeIXXntk0865vtrEXjZrRm+9ZS2r
	Ne+OvkPq9vHZUdPPXXgquHzHiboDDWe28H2X4ojco/4vZO/H9bfyRSV/tPvl7Fe2CJ4m+fpA
	xrLcZdwXlj0MXvT//RWLybaT1df/2HX7rPjN79wq3Atmpv8WcN81cYOOb8nUO5tKjPauuc/l
	EeaWPkfa0HdFhlLwtp7PsdLfleavlS88/OchA8e/RRKamm4z1ybrVJ9Kmp7R8/dK1ew3vKXR
	C6Y2yrqfDXrt7zX1UaPEz8+fDaOtF89PW7DjS0xYmhJLcUaioRZzUXEiAA9kw6XyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnO72jpVpBn8uqVo0L17PZnF51xw2
	iyOfUy1eH7/B5sDisX/uGnaPF5tnMnr0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxpXVDSwF
	vZwVez63sDYwnmLvYuTkkBAwkZiweyFbFyMXh5DAbkaJe3tPskAkpCTutzUxdzFyANnCEocP
	F0PU/GCU+H9hIitInE1AU2L6Wj+QchEBOYknt/8wg9jMAhkS376cYQOxhQUCJe6sfs4KYrMI
	qEr8fQUxklfARuLQyTyITfISMy99BzuHV0BQ4uTMJywQY+QlmrfOZp7AyDcLSWoWktQCRqZV
	jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBYaeltYNxz6oPeocYmTgYDzFKcDArifDG
	X1maJsSbklhZlVqUH19UmpNafIhRmoNFSZz32+veFCGB9MSS1OzU1ILUIpgsEwenVAPT6bKb
	OzNmJtnuCNpfsXb5qXdql94XGLpPiorUtpyeIPAvqlu/eOuHd3OjdrMGqIWmHN+xOaTm1Stm
	Ne59UXXff8+vc5i/L/U4u/y+LYUR3gIMjVXeQmVmfD+WsZcz7nFOqz/WPfGsmpiVVcRlz8R1
	K7/nlyYzzt0VsYjvx+Uzco5Vi57/XBQa/1RUOTx+6sMgfQmOZXEOBlxvorNYErd1/2OfLfpW
	wLyaT6jr8NeNmiwFMsorVBjYnt9YraynGCZwOks7ymb/+YU+eW5/lwT9Z/skkZTOb/ZupRXP
	RN9NTjqz8lY5bLGLVLyz8kUB15JZxSbH22w+GV/wkjL7J1OwTXBvWPYf/tAPU6/mPVViKc5I
	NNRiLipOBAAKu6WEqgIAAA==
X-CMS-MailID: 20240731004335epcas1p382229e79bdaf3f2d48b0f3faa7414ea6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240731004335epcas1p382229e79bdaf3f2d48b0f3faa7414ea6
References: <CGME20240731004335epcas1p382229e79bdaf3f2d48b0f3faa7414ea6@epcas1p3.samsung.com>

This patch improves the usage of the MAR register by updating the relevant
macro definitions and ensuring consistent usage across the codebase.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
---
v2: Fix line length

 drivers/staging/rtl8723bs/include/hal_com_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index baf326d53a46..93aa391fa749 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -151,8 +151,8 @@
 #define REG_BSSID						0x0618
 #define REG_MAR							0x0620
 
-#define MAR0						REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
-#define MAR4						(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
+#define MAR0		REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
+#define MAR4		(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
 
 #define REG_MAC_SPEC_SIFS				0x063A
 /*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */
-- 
2.25.1


