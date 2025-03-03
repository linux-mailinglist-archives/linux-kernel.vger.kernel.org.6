Return-Path: <linux-kernel+bounces-542068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45950A4C53B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908E8163FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A223E259;
	Mon,  3 Mar 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F4GYBLVw"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD0214A9F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015525; cv=none; b=StKER4//RW+/bpBNb+Lp4p/qnfA8xnDSyAE8S0mSrWMaq1bcpaTQyHbHMfoscogCEp7pv2FJGWY+Lwk0+6F6UDII/qNCtCrYPTBFwUTlLOIW/xLcgWBrlDR9Lp2ZH3eAX/Gkk3ZnKd7vQi/goSE2qfYK68eG7tF0E/YJhZFez94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015525; c=relaxed/simple;
	bh=b/7+B7Xw+scOE+xMehwbW9cFh2XavGw2CnyoMRjt2m8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=USXCEoHn/243ml+9lwmrU+u7GQ5TX4qHR9sxCVgVSd8z9NwKGK3lzVtj0szcWxlhBmxGyUhk2g4kEucfrri1BxEwy6h9drqqJs5fPDbYnkjI+ABN6IRITnQ9A4ztYCTcAL3Ppf9SgNB2h5OR9XBa979E3kHvxqIfR3ILtuSz/zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F4GYBLVw; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250303152521euoutp028a4950da8f4c6ae01aedba7b6f0fc211~pVGR0hfIv1521915219euoutp02Z
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 15:25:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250303152521euoutp028a4950da8f4c6ae01aedba7b6f0fc211~pVGR0hfIv1521915219euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741015521;
	bh=4stoFuPq5qXUksDW/IN1GgEPfCG/npBGTMYNy8vu1+0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=F4GYBLVwDUeHAZhah+6v0pN8/xmMA5UJpvQWYtEbUahg79toG3jeMN5EuK9d0PrZF
	 HYtp9AFwu3e1APZdGy9Mn1L6lIlP29/YC0pel0hAxOY9g/ORO/9yH6KupU+h8RHko6
	 Cre6GH4kNXX3nrgY/DD0qTR9D9621jvm78mMnOYE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303152520eucas1p2ee8f847ebcfbd9a3302a5ccb19078639~pVGRc2pi60632706327eucas1p2T;
	Mon,  3 Mar 2025 15:25:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CB.79.20397.0E9C5C76; Mon,  3
	Mar 2025 15:25:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c~pVGRH8s0x0643406434eucas1p2N;
	Mon,  3 Mar 2025 15:25:20 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303152520eusmtrp1472538aa2de94f3065337b869a8a1c9b~pVGRHSZGY0903609036eusmtrp1K;
	Mon,  3 Mar 2025 15:25:20 +0000 (GMT)
X-AuditID: cbfec7f5-e59c770000004fad-b4-67c5c9e03c09
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4B.E0.19654.0E9C5C76; Mon,  3
	Mar 2025 15:25:20 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250303152519eusmtip1c3f4f43f5880b77bd3355a9070e8b4b4~pVGQcsgEn0560605606eusmtip1w;
	Mon,  3 Mar 2025 15:25:19 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, wefu@redhat.com, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 0/2] TH1520 SoC: Add Reset Controller Support
Date: Mon,  3 Mar 2025 16:25:09 +0100
Message-Id: <20250303152511.494405-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRT2u/fu7ZY2t9XoiCkar3YoxLhE1mBmPYfByGtY3NmM3c3stinF
	1IiUEMVmi4TVWtvEtiU7apW2LcYarxBlp8mrqVFkJpmK7a7Hf9/v+75zznfO/ChcoOcFUHsU
	saxSIZEFk15Eed0PxzRng0063Zg7lzFWOjCmoNbBY1qemjHmU2UKwXzWtpDMM0s+yRTXNnsw
	Jd8LMKa5pZ5gBu9WeDCp1hxCNFxsMqST4tTiOkx8qn+6+EvVC1J80mxA4m+mwDXkZq/5u1nZ
	njhWGRa5wyva8fEWvs/oGd9qcqJkpPXIQJ4U0LNAk1fEy0BelIDWIzCW6JFLENA9CKr6hZzw
	DcHppkHen4qKDh3JCUUI7uRZ3I8OBJqb14dcJD0TnEUFQ339aB2Cd+l9uEvAaRlYOot/z6Co
	kbQI8j8nuGiCngjtJXbMhfl0JGRdLHXnCwJr9SOc432h4XwbwbUJgsNlebirP9D1FNgbm3Gu
	YAm8tlS5i0dCu93sxmPhYXYmweEYcJZ9dfuT4E6m3Y0j4K2jj3Rlw+kQKLGEcfQicLT8HIoM
	tA+86vTlIvjAmXINztF8OHZUwLknwdnME3+HOvTlGIfFkPu+1H3cbXA19QeRhcZp/1tM+99i
	2n8ZLiHcgPxZtUouZVXhCnZ/qEoiV6kV0tBdMXIT+v2ZHg7Yv1cgfXt3aA3CKFSDgMKD/fhN
	aTapgL9bknCAVcZsV6plrKoGjaGIYH/+ZesRqYCWSmLZvSy7j1X+UTHKMyAZM/fJQJFkW/Cc
	6R8h9Qms/jQlwv/N2Obwo4ZFj6PaGqpzLidEBbD6L/db16+NTXkru97V0xdYfCREPizx6zqb
	M61weYitcEbmYP6NBytz2bK8QEm3oc1j3nsIe1Iv3JAxSr01/fysLj27fqv6Y2V8d4TGUBDC
	l9/e1GTgHY8V6RI9n4gnPVrasOtaxePabGyqzuflgGBZ59Sn1ufCrPTqyP6u7Bdma68QGsfP
	8TZrfl7ZkrgieXYHYRpF+268qvNevCBHlkWd29m6EF91sKdeZKqNOtRTSK+dXBQX55dyb+6y
	3s2rl1Lt3vGi6DTj6O4Lq+bdiphwP3Fgy4e60tcrjwf5BhOqaMkMIa5USX4BAKsSp7sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xu7oPTh5NN/iwX85izd5zTBbzj5xj
	tbh3aQuTxYu9jSwWL2fdY7O4vGsOm8XaI3fZLdZ/nc9kcffeCRaL/3t2sFu07J/C4sDtsWlV
	J5tHy9pjTB79fw083u+7yubRt2UVo8fnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
	lnqGxuaxVkamSvp2NimpOZllqUX6dgl6Geeeb2QuWMNZ8WjTA8YGxlnsXYycHBICJhI73ixl
	62Lk4hASWMoo8evYejaIhIzEte6XLBC2sMSfa11gcSGBV4wSm05wg9hsAkYSD5bPZwVpFhFY
	zyjReXUTE0iCWSBP4vWGbqANHBzCAg4Sc15WgoRZBFQlXq0/DlbCK2AnMWHeZqgj5CX2HzzL
	DBEXlDg58wkLxBh5ieats5knMPLNQpKahSS1gJFpFaNIamlxbnpusZFecWJucWleul5yfu4m
	RmBMbDv2c8sOxpWvPuodYmTiYDzEKMHBrCTCe6v9aLoQb0piZVVqUX58UWlOavEhRlOg+yYy
	S4km5wOjMq8k3tDMwNTQxMzSwNTSzFhJnJftyvk0IYH0xJLU7NTUgtQimD4mDk6pBqapuU5z
	lpcdnnGsy1Rk5+ole4MXJv3e7D2/eN0LibcWN46K5tef3XZe9f8S1ccpB7eElt98dINbP/3F
	/dtxfa/8dVdM/vlKyTuQ+2DcksKS6Iepa658Ej16pPtKy0cl5T8RtgrpBwyZA6cfUNqknHpA
	co5B0pHVP9YbXyj/5jmza/EzmzW3Sp/ozreIub7xUfjxtY9Cdy7ekeo46VeH15z5t9m3HlWX
	vfrrYOG9G4rfjv4s+nnj3vo9Va4qO3/6bjWYVxqlrHzqYYLIAuEnU/tX6LV467Ma7z9nsnW/
	ybTdbe6POMJqdab6HUws//1P6+/DulB535C4KRraqvfWp0/9zWBT7STZwjAlYSnTcg5LViWW
	4oxEQy3mouJEAOMygpYSAwAA
X-CMS-MailID: 20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c
References: <CGME20250303152520eucas1p250f2e6d8eaf1172d8813b04ceb88679c@eucas1p2.samsung.com>

This patch series adds reset controller support for the T-Head TH1520 SoC,
which is used in boards like the LicheePi 4A. While part of a broader effort to
enable the Imagination BXM-4-64 GPU upstream, these patches focus on providing
a dedicated reset controller driver and the corresponding Device Tree
nodes/bindings.

Bigger series cover letter:
https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

Michal Wilczynski (2):
  dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller
  reset: thead: Add TH1520 reset controller driver

 .../bindings/reset/thead,th1520-reset.yaml    |  44 ++++++
 MAINTAINERS                                   |   3 +
 drivers/reset/Kconfig                         |  10 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-th1520.c                  | 135 ++++++++++++++++++
 .../dt-bindings/reset/thead,th1520-reset.h    |  16 +++
 6 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
 create mode 100644 drivers/reset/reset-th1520.c
 create mode 100644 include/dt-bindings/reset/thead,th1520-reset.h

-- 
2.34.1


