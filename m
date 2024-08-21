Return-Path: <linux-kernel+bounces-296253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083B295A836
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56902837B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F917D35C;
	Wed, 21 Aug 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QTNp2W8u"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0327183CA8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282822; cv=none; b=AiWlIZKv//g5uKJ3qvhVR/1uVbnL6eVk0HIWgjP3X4SQeNShqt1/jnCOoSISJzVLOO31iNklcFhTtyTnGgBkfoNCIMVHFivPpYI9GLLIQLB6iBffuYHQgt2f1Xc5HU4Aj6Ia16e6ivpbG6xANgG5XsE0EcHQIQ588kNaw/0z1HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282822; c=relaxed/simple;
	bh=jPs5bhw2LqCImzZAB/9qt6gALyVn6+cFOa2QwNPKjzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=EdQJLWALg4//Vph/DuguyLdjHZJs3mT/z7xs4517KwuYKXlQJk9rSBnsPW7/fvM1NmEaanS9af0Uqxrv37hOTtq7erAD41UKDe7ZxCcUBKBIp2ducr10OovzuUzO08OkZBQ7gOSRBExh4rar7AT41AlZaP9jbg+04rGy95F1rYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QTNp2W8u; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240821232657epoutp02f847c0bf0c6abadca30b1a8d0951c2fd~t4hZZ4_FT3234132341epoutp02Y
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:26:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240821232657epoutp02f847c0bf0c6abadca30b1a8d0951c2fd~t4hZZ4_FT3234132341epoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724282818;
	bh=hoicPC/VzmDis71v8IRNcpF+6JTBo0KNNr3/qD2gd+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTNp2W8u7VgDhPUKAImi/sh9OjWBK6z2IkygEZ3TCZk9vuLqiIBvOVk40S3zLR3kz
	 skde19JGOvWKPugXxvu1IJwCf019LM18W4395hrrlTVURWO3+il7vly3VCi6g5DH+K
	 xKhBecOd/xbKVX6SajI0q7eAKnVR/QyY4w7GB+pE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240821232657epcas2p11db759152401d89e4d2a94b906014e17~t4hYtshhm2473424734epcas2p1z;
	Wed, 21 Aug 2024 23:26:57 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wq2Xw6B6rz4x9Pv; Wed, 21 Aug
	2024 23:26:56 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.AF.10431.0C776C66; Thu, 22 Aug 2024 08:26:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240821232656epcas2p27c080a6d52524b222428931697390aad~t4hX4uElp1271312713epcas2p2Q;
	Wed, 21 Aug 2024 23:26:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240821232656epsmtrp24f22e35f6ec2c535714e0a48ef5e91cb~t4hX321HY2801228012epsmtrp2U;
	Wed, 21 Aug 2024 23:26:56 +0000 (GMT)
X-AuditID: b6c32a45-da1ff700000028bf-9a-66c677c0bda9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7F.F7.07567.0C776C66; Thu, 22 Aug 2024 08:26:56 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.60]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240821232656epsmtip2a6e76c4e2fa0b8a5245a63603010f03c~t4hXqrfQb2565325653epsmtip2c;
	Wed, 21 Aug 2024 23:26:56 +0000 (GMT)
From: Sunyeal Hong <sunyeal.hong@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sunyeal Hong <sunyeal.hong@samsung.com>
Subject: [PATCH v9 3/4] clk: samsung: clk-pll: Add support for pll_531x
Date: Thu, 22 Aug 2024 08:26:51 +0900
Message-ID: <20240821232652.1077701-4-sunyeal.hong@samsung.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821232652.1077701-1-sunyeal.hong@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmhe6B8mNpBo9O6Vo8mLeNzWLN3nNM
	Fte/PGe1mH/kHKvF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxf89O9gtDr9pZ7X4
	d20ji0XTsvVMDnwe72+0sntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2Tm
	pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3amkUJaYUwoUCkgsLlbSt7Mpyi8t
	SVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7ofXqFteCpWMXMF7oNjN+E
	uhg5OSQETCQubX7A1sXIxSEksINRorP3LhOE84lR4s+KD8wQzjdGiY6Tq5hhWmad+g3VspdR
	4mt/H5TzkVHi4qFDQP0cHGwCuhJ//jmAxEUE9jBJbDm/BGwus8BZRom7cxawg4wSFnCX+Phg
	PpjNIqAqce74ZCYQm1fAXuJ890VWiHXyEhfXPGcDsTkFHCSmTj/GDlEjKHFy5hMWEJsZqKZ5
	62ywWyUE5nJIXL21HqrZReLSrrlsELawxKvjW9ghbCmJz+/2QsXzJSZff8sE0dzAKHHtXzfU
	o/YSi878ZAd5h1lAU2L9Ln0QU0JAWeLILai9fBIdh/+yQ4R5JTraoIGqJvHpymWoITISx048
	g7I9JO6tfQUN0smMEo9fT2SewKgwC8k7s5C8Mwth8QJG5lWMYqkFxbnpqcVGBYbwKE7Oz93E
	CE64Wq47GCe//aB3iJGJg/EQowQHs5IIb9K9o2lCvCmJlVWpRfnxRaU5qcWHGE2BgT2RWUo0
	OR+Y8vNK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJITyxJzU5NLUgtgulj4uCUamCSKpq99YLo
	B5s5Wtt/Mrfl6KgZfmdYsuLDCT/J7mfqvQfMDVbfdBG24Tl9Md/MzrVLtDxr6eLg3dN17F+t
	PZTTdntO2bS2M1rMiddTr85S3fekNyFzi/z3zKSWFq2d3v2371tYanW+Sz1+u2T99sOCpi0K
	mwLzt1yIu66bI5c7bfHKU3PehDT2iv/nCrgrp3l0pmvKuRqvooOFPOxLMx9YMBUq3ff+OCVi
	zhm7i4YH3CSFPAV3BLp/nFo18z+DseT5U51/fM/7yujPMeV+P40tdealzg1KsocdjGxvHua+
	tKnlyGNlLmWlRTH6t2SVd7c+9UwN9V4oaJl6XaclvyCERSyhKM9IV8/86+4iYyWW4oxEQy3m
	ouJEAMq3WHJBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSvO6B8mNpBo9W8Fk8mLeNzWLN3nNM
	Fte/PGe1mH/kHKvF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxf89O9gtDr9pZ7X4
	d20ji0XTsvVMDnwe72+0sntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZfQ+
	vcJa8FSsYuYL3QbGb0JdjJwcEgImErNO/WbrYuTiEBLYzSixvXMPC0RCRmJjw392CFtY4n7L
	EVaIoveMEgtu7AVyODjYBHQl/vxzAImLCBxikpj4+SkLiMMscJlR4tjdycwg3cIC7hIfH8wH
	m8QioCpx7vhkJhCbV8Be4nz3RVaIDfISF9c8ZwOxOQUcJKZOPwZWLwRUs3d5OwtEvaDEyZlP
	wGxmoPrmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brJhgWFearlecWJucWleul5yfu4mRnBk
	aGnsYLw3/5/eIUYmDsZDjBIczEoivEn3jqYJ8aYkVlalFuXHF5XmpBYfYpTmYFES5zWcMTtF
	SCA9sSQ1OzW1ILUIJsvEwSnVwBT9WbvezuXhUqMlwdNiXt8K7w8wORjWcvaw00H9H6d7Zlhf
	7uJ6Emlsf9k3Ye2UHX0C5/ac+J7a9iTdPE2s7FjNuxesv951C81d16KwWvhRo43LEwnuppwN
	p1h8PzbKlOgo8/92rV7162fdWzvzIxz3/A+w97RyTfI3srP4vfX1+aiOSzeq7ydN3c634rPA
	G4XVfEx/Hgg+z5rIqmuuP8t36w/Zj7NNZx6a/MV5Zdp0pg8RQk6pbTc/fsuu1D++mDNd75On
	YMT28iYTh0k/bpXvnVIicKKRS0PmzG6rDdc2ZjzY8N6298qbMuUPBpzyIXG6PcvW5RR7hH+f
	1PIz9mznhrYv2e+cZgumqBl3NyuxFGckGmoxFxUnAgAeMZU++wIAAA==
X-CMS-MailID: 20240821232656epcas2p27c080a6d52524b222428931697390aad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240821232656epcas2p27c080a6d52524b222428931697390aad
References: <20240821232652.1077701-1-sunyeal.hong@samsung.com>
	<CGME20240821232656epcas2p27c080a6d52524b222428931697390aad@epcas2p2.samsung.com>

pll531x PLL is used in Exynos Auto v920 SoC for shared pll.
pll531x: Integer/fractional PLL with mid frequency FVCO (800 to 3120 MHz)

PLL531x
FOUT = (MDIV x FIN)/(PDIV x 2^SDIV) for integer PLL
FOUT = (MDIV + F/2^32-F[31]) x FIN/(PDIV x 2^SDIV) for fractional PLL

Signed-off-by: Sunyeal Hong <sunyeal.hong@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/clk/samsung/clk-pll.c | 44 +++++++++++++++++++++++++++++++++++
 drivers/clk/samsung/clk-pll.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 4be879ab917e..a6c81075417a 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1261,6 +1261,47 @@ static const struct clk_ops samsung_pll2650xx_clk_min_ops = {
 	.recalc_rate = samsung_pll2650xx_recalc_rate,
 };
 
+/*
+ * PLL531X Clock Type
+ */
+/* Maximum lock time can be 500 * PDIV cycles */
+#define PLL531X_LOCK_FACTOR		(500)
+#define PLL531X_MDIV_MASK		(0x3FF)
+#define PLL531X_PDIV_MASK		(0x3F)
+#define PLL531X_SDIV_MASK		(0x7)
+#define PLL531X_FDIV_MASK		(0xFFFFFFFF)
+#define PLL531X_MDIV_SHIFT		(16)
+#define PLL531X_PDIV_SHIFT		(8)
+#define PLL531X_SDIV_SHIFT		(0)
+
+static unsigned long samsung_pll531x_recalc_rate(struct clk_hw *hw,
+						 unsigned long parent_rate)
+{
+	struct samsung_clk_pll *pll = to_clk_pll(hw);
+	u32 pdiv, sdiv, fdiv, pll_con0, pll_con8;
+	u64 mdiv, fout = parent_rate;
+
+	pll_con0 = readl_relaxed(pll->con_reg);
+	pll_con8 = readl_relaxed(pll->con_reg + 20);
+	mdiv = (pll_con0 >> PLL531X_MDIV_SHIFT) & PLL531X_MDIV_MASK;
+	pdiv = (pll_con0 >> PLL531X_PDIV_SHIFT) & PLL531X_PDIV_MASK;
+	sdiv = (pll_con0 >> PLL531X_SDIV_SHIFT) & PLL531X_SDIV_MASK;
+	fdiv = (pll_con8 & PLL531X_FDIV_MASK);
+
+	if (fdiv >> 31)
+		mdiv--;
+
+	fout *= (mdiv << 24) + (fdiv >> 8);
+	do_div(fout, (pdiv << sdiv));
+	fout >>= 24;
+
+	return (unsigned long)fout;
+}
+
+static const struct clk_ops samsung_pll531x_clk_ops = {
+	.recalc_rate = samsung_pll531x_recalc_rate,
+};
+
 static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 				const struct samsung_pll_clock *pll_clk)
 {
@@ -1394,6 +1435,9 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		else
 			init.ops = &samsung_pll2650xx_clk_ops;
 		break;
+	case pll_531x:
+		init.ops = &samsung_pll531x_clk_ops;
+		break;
 	default:
 		pr_warn("%s: Unknown pll type for pll clk %s\n",
 			__func__, pll_clk->name);
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index ffd3d52c0dec..ce9d6f21f993 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -41,6 +41,7 @@ enum samsung_pll_type {
 	pll_0516x,
 	pll_0517x,
 	pll_0518x,
+	pll_531x,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.45.2


