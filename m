Return-Path: <linux-kernel+bounces-268529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F7B9425CF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E39128265D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC592E822;
	Wed, 31 Jul 2024 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="psteKoRz"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D498B2E403
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722404202; cv=none; b=nwvaGMMJQeacCtpS7qt2kKlLOVPTBi56yfL4vHRuGaUx26+cFIbR/kUvwvJIe3ugmTITPT5ew6LglkyPvPAvBYX31of1M/4E2aAvayOUcceI3UIlrkeenxbv+pchhMGWsVorwQxhceA6RsjAJEuCu+KUoIJsHsaNxnz+hNcmMWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722404202; c=relaxed/simple;
	bh=GwwEncqeMSTHDckwjej7TuEbpg3lQD/hCJNLJIbU+Es=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=C19ucsbmk1A193RDNgsH2DyeoeWVoxvJVu3gGNnQ/IjBbH73EZKejJshLHYk2DvfvCJElwkw+GeuR0njXT6RRPlS9GcgezjcIipBHuNcOyuQIAxeySHocax73Gfvy7+U718H/q5+t5GlY70McXR8ZEAdPZMPQjWN1X6RB1JaeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=psteKoRz; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240731053637epoutp0395f2b4149595be25811830445144e28b~nNX3-oHNr2273422734epoutp03f
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:36:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240731053637epoutp0395f2b4149595be25811830445144e28b~nNX3-oHNr2273422734epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722404197;
	bh=j/tEllXsbu7xRFKqSrll3TR5x39lxdLlv0YDia1J/dc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=psteKoRz3vcfg+lET8qGqUOsKS0Fen45+RdR1v2XqTxcOtBPPgUA8hrh6UaTYJ/Mb
	 rC0p4mbrZwEIEWyaD5KjdzBZR+Imq+BmWNkr9JimWB1JMVDlxdzLWotiNR7Vlafgir
	 YAqnQNOc/H/1D6GcGJPxkUf+QZH6g+XC392WnOYE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240731053637epcas1p4274afd2769ba76ef624c547226b7054f~nNX3suW573117731177epcas1p4W;
	Wed, 31 Jul 2024 05:36:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.247]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WYgnc5JfFz4x9Py; Wed, 31 Jul
	2024 05:36:36 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.59.10258.46DC9A66; Wed, 31 Jul 2024 14:36:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240731053636epcas1p45b75f5d5256ba9360feda929d04a0106~nNX2swetO3117731177epcas1p4T;
	Wed, 31 Jul 2024 05:36:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240731053636epsmtrp17640a2c750182cf5d51f89d88f606dfe~nNX2sMb1t3018130181epsmtrp1G;
	Wed, 31 Jul 2024 05:36:36 +0000 (GMT)
X-AuditID: b6c32a38-9ebb870000002812-79-66a9cd643777
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.8D.08964.46DC9A66; Wed, 31 Jul 2024 14:36:36 +0900 (KST)
Received: from VDBS1327.vd.sec.samsung.net (unknown [168.219.243.39]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240731053636epsmtip2cc5e16dc5a5a6891afb55f3200771607~nNX2hKVGY2164221642epsmtip2m;
	Wed, 31 Jul 2024 05:36:36 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, Manjae Cho
	<manjae.cho@samsung.com>
Subject: [PATCH] staging: rtl8723bs: Improve MAR register definition and
 usage
Date: Wed, 31 Jul 2024 14:36:21 +0900
Message-Id: <20240731053620.783572-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJKsWRmVeSWpSXmKPExsWy7bCmrm7K2ZVpBld/Klk0L17PZnF51xw2
	iyOfUy1eH7/B5sDisX/uGnaPF5tnMnr0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZeuq2S
	d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
	fnGJrVJqQUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbcpyYFv3krDq57zNTA+JW7i5GT
	Q0LARGLmh4eMILaQwA5GiT/vsrsYuYDsT4wSbzY+ZYNIfGOU+DovE6Zh7bPdjBBFexklTu2b
	zwLh/GKU+LZrCpDDwcEmoCkxfa0fSIOIgJzEk9t/mEFsZoE0iVVXX4MNFRYIkGh5fJMdxGYR
	UJX4/ugNG0grr4CNxKFFhRC75CVmXvoOVsIrIChxcuYTFogx8hLNW2czg6yVENjELvHq+xZW
	iAYXibaVnWwQtrDEq+Nb2CFsKYmX/W1QdrHE0j+bWCDsGomnrTOgbGOJn+c+MYPcwAx0/vpd
	+hC7+CTefe1hBQlLCPBKdLQJQVSrSJxftYEJIiwl0XDQECLsIbFu3kMmSKjFSpzecpJxAqPc
	LCQPzELywCyEXQsYmVcxiqUWFOempxYbFpjA4zA5P3cTIziNaVnsYJz79oPeIUYmDsZDjBIc
	zEoivEInV6YJ8aYkVlalFuXHF5XmpBYfYjQFhuhEZinR5HxgIs0riTc0sTQwMTMysTC2NDZT
	Euc9c6UsVUggPbEkNTs1tSC1CKaPiYNTqoFJnffnZSnhc1kCWmpm1msm6Mko8xZlv4itWndo
	f13hMtXtTfzP88+4zL5YX3rhz/vbCtbztA2XPXA2Wfpk8sYKKyaNHZcW3DoQotaoqWk1gXlX
	XoNrU1vhlrhXpV9/Kh/sfH9f+lFXSsn/PbkLXx5yfC7ktpF7KrN99RXvRww6XzS3hUQHJM1Z
	fy+Ljd+9QLT++M1HijoT2rwLDT1an+mv/O/8MGJJvpDqiWVe+1P2sV/yS5QQ/aRYIH13qdju
	S66LDorP7NsiEvtEb5vHTJ+JNjnpni1PZj4vOVN/Yc9aDbYnr7XrjASbDi29n5Gfq5dh1FXs
	o6P2k5/zyvWekNBZG8+Ub3DY/S6jWepq1GQlluKMREMt5qLiRAAqZZkc7AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGLMWRmVeSWpSXmKPExsWy7bCSvG7K2ZVpBhcnCFg0L17PZnF51xw2
	iyOfUy1eH7/B5sDisX/uGnaPF5tnMnr0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxtynJgW/
	eSsOrnvM1MD4lbuLkZNDQsBEYu2z3YxdjFwcQgK7GSUObl3DBJGQkrjf1sTcxcgBZAtLHD5c
	DFHzg1Fi3abLjCBxNgFNielr/UDKRQTkJJ7c/sMMYjMLZEh8+3KGDcQWFvCT6OvvZgexWQRU
	Jb4/esMG0sorYCNxaFEhxCZ5iZmXvoOV8AoISpyc+YQFYoy8RPPW2cwTGPlmIUnNQpJawMi0
	ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOOi0NHcwbl/1Qe8QIxMH4yFGCQ5mJRFe
	oZMr04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUwFawz
	cDp6I8KjfL6mX3TEpMiwQy3hoeL/vL4b7V8y7eq6tRuV1vX7XJ3EY9T8wORJYK646l5FKb/H
	y3yTTP8GbF2hc83NtfW79ed617knRcveqzvuy5/m0xGocKCh4+ml+ssT9us4+RyfofJ7ls/c
	CI316uIcrwQ89X3v/y5oYrR3ePOv/MCvOZkMp16VHlA2evrI/rbm65Wq7SHPu3ot7nIErf8m
	yG937s/hjcFenT8eBnky/JpqzvqIm2VqnNauda7VX1f1ZmSz8Sl4yBzsfPpgXuDLaxM4ZKYn
	R/qk7bge0OkZWXLk8+SwuaUhB19eujFrVY2o+LtnJ56f5FJZui6/uGriNO5EJ5mwyIfOSizF
	GYmGWsxFxYkAVvDd9akCAAA=
X-CMS-MailID: 20240731053636epcas1p45b75f5d5256ba9360feda929d04a0106
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240731053636epcas1p45b75f5d5256ba9360feda929d04a0106
References: <CGME20240731053636epcas1p45b75f5d5256ba9360feda929d04a0106@epcas1p4.samsung.com>

This patch improves the usage of the MAR register by updating the
relevant
macro definitions and ensuring consistent usage across the codebase.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>

---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c    | 4 ++--
 drivers/staging/rtl8723bs/include/hal_com_reg.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index c9cd6578f7f8..9493562c1619 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -380,8 +380,8 @@ static void _InitWMACSetting(struct adapter *padapter)
 	rtw_write32(padapter, REG_RCR, pHalData->ReceiveConfig);
 
 	/*  Accept all multicast address */
-	rtw_write32(padapter, REG_MAR, 0xFFFFFFFF);
-	rtw_write32(padapter, REG_MAR + 4, 0xFFFFFFFF);
+	rtw_write32(padapter, MAR0, 0xFFFFFFFF);
+	rtw_write32(padapter, MAR4, 0xFFFFFFFF);
 
 	/*  Accept all data frames */
 	value16 = 0xFFFF;
diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
index 9a02ae69d7a4..baf326d53a46 100644
--- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
+++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
@@ -151,6 +151,9 @@
 #define REG_BSSID						0x0618
 #define REG_MAR							0x0620
 
+#define MAR0		REG_MAR		/* Multicast Address Register, Offset 0x0620-0x0623 */
+#define MAR4		(REG_MAR + 4)	/* Multicast Address Register, Offset 0x0624-0x0627 */
+
 #define REG_MAC_SPEC_SIFS				0x063A
 /*  20100719 Joseph: Hardware register definition change. (HW datasheet v54) */
 #define REG_RESP_SIFS_CCK				0x063C	/*  [15:8]SIFS_R2T_OFDM, [7:0]SIFS_R2T_CCK */
-- 
2.25.1


