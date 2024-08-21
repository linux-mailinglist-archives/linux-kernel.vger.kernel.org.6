Return-Path: <linux-kernel+bounces-296255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA6B95A837
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1F51C220D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181D17DFE4;
	Wed, 21 Aug 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZcsiOPCq"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989AE1836ED
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282823; cv=none; b=dsnQjl0HKB/pxtQDxLGeR5hFSfaxE7etT8R3bDfiGfR5mJjN/8sxxMUAxvKoZ6rCzxv6Q2r3wnUTqtSGspHu2dXvNlT8Z8w+ZvwQH/6h1SK6ONW2972rszojI9XK1DmW4KD3O7o3rX7ip/ARu+BsO5lpWM/J9SDMiFy9thojHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282823; c=relaxed/simple;
	bh=V6EfJdV8XY0qKgNr+X/hW0XUTNebiXWJsSp8YPMg6Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=fzVyGSq78Pm26yKSdTQUN4FWaa9ozd51kbSE0DMz5Nej96T5kbhKnCxcsCQ3RHuSLduzEneDBMNPlcFIMs7e/ajgcNHrFAbVWK7501riwiSD49GGVqpTZ7Ybe/l24wU11X5kWnBJHXTLe4D5ABWZuwO7DtzUQwAgT/HF2QwAKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZcsiOPCq; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240821232657epoutp04f83f6adefbb0c7e10c13b1a81b7c8e67~t4hY_bj-X1797017970epoutp042
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:26:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240821232657epoutp04f83f6adefbb0c7e10c13b1a81b7c8e67~t4hY_bj-X1797017970epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724282817;
	bh=5KJLYwAJevQB/2Q++XZPLB1XPTDUsIWY7J6aokkLmow=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ZcsiOPCqaoPWLswEMMAK21dVsyJof2pjqq+OvRRPrmqs8LXZnJQpJqjRtuTOFytaa
	 /n1Et/M39MuEUbYwOllyMkr5zqHKJTQd7dIZeD0fw6/n+R/C8MSBbPIJb5nyKgkK67
	 KElPutneFz/lBXw0pskiNbGV0JjPLFkQOsShj0y8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20240821232656epcas2p1926b9ded936e2b0fe31d23c1b08ccfab~t4hYaz4bh2086820868epcas2p1Y;
	Wed, 21 Aug 2024 23:26:56 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.89]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Wq2Xw44Gfz4x9Pw; Wed, 21 Aug
	2024 23:26:56 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.85.08901.0C776C66; Thu, 22 Aug 2024 08:26:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240821232656epcas2p2596e2a1f31bf02084d9e4cd0fc80ce14~t4hXorD6X1271312713epcas2p2O;
	Wed, 21 Aug 2024 23:26:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240821232656epsmtrp2ab74761ca3e6afbadc73b940dca89e8f~t4hXm6ZPg2801228012epsmtrp2Q;
	Wed, 21 Aug 2024 23:26:56 +0000 (GMT)
X-AuditID: b6c32a43-a61b8700000022c5-17-66c677c017ff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.85.08964.FB776C66; Thu, 22 Aug 2024 08:26:55 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.60]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240821232655epsmtip20fff5940c20a57b135d2ea2cb6cd1078~t4hXXWSgE2250822508epsmtip2Q;
	Wed, 21 Aug 2024 23:26:55 +0000 (GMT)
From: Sunyeal Hong <sunyeal.hong@samsung.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki
	<s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sunyeal Hong <sunyeal.hong@samsung.com>
Subject: [PATCH v9 0/4] initial clock support for exynosauto v920 SoC
Date: Thu, 22 Aug 2024 08:26:48 +0900
Message-ID: <20240821232652.1077701-1-sunyeal.hong@samsung.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmqe6B8mNpBr8PyFo8mLeNzWLN3nNM
	Fte/PGe1mH/kHKvF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxf89O9gtDr9pZ7X4
	d20ji0XTsvVMDnwe72+0sntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2Tm
	pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3amkUJaYUwoUCkgsLlbSt7Mpyi8t
	SVXIyC8usVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7Yt8ig4IRAxbH2rawNjN94
	uhg5OSQETCRezb/B0sXIxSEksINRYuXVn8wgCSGBT4wSnZOkIOxvjBLrm0VhGv6d3MIM0bCX
	UWJDy3pGCOcjo8SBeQeAHA4ONgFdiT//HEDiIgJ7mCS2nF/CBOIwC5xllLg7ZwE7yChhAVeJ
	82fmsILYLAKqEhPv3mcBsXkF7CU2NPxmg1gnL3FxzXM2iLigxMmZT8BqmIHizVtng50hIdDK
	ITHh9AkmiAYXiZurP7BC2MISr45vYYewpSQ+v9sLNTRfYvL1t0wQzQ2MEtf+dTNDJOwlFp35
	yQ7yArOApsT6XfogpoSAssSRW1B7+SQ6Dv9lhwjzSnS0CUE0qkl8unIZaoiMxLETz6BsD4mV
	fcugIRorcaD7NesERvlZSL6ZheSbWQh7FzAyr2IUSy0ozk1PTTYqMITHaXJ+7iZGcErVct7B
	eGX+P71DjEwcjIcYJTiYlUR4k+4dTRPiTUmsrEotyo8vKs1JLT7EaAoM34nMUqLJ+cCknlcS
	b2hiaWBiZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA9Nl03o7+Ql/vT/Mf7Fo
	xUnVY49mv5uWmapgmhy93jrERWFmS+aH8vlzmERO3q01a9qy9HfuURfV9oVKHg/l+x+aLT0Q
	9cbI8lDzw46N7OtDJsucEbnWVfGJp6vulcXZp2HsKleyVUJOfAw0i3lxN2Bt3J+wuG+XLq44
	dttANICv9YyTuNG/hmwpactpSyQd6oIkZIpUtlxd9/dYsUKq8ew3W69vFhWdLd8i7L6164bR
	y4ki8pyVf2YvfnZNaJk9F+v+jADumCe3Etu+vKyc1HjEseVp0Yycb1VdyR/rXSYmrrbIVJI4
	WX3hn6d2+rrQR03Fb6IDHzrMcj8uJVTupq/itPTK/ZKy39vdeBhDNiixFGckGmoxFxUnAgD+
	Ip3iMgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvO7+8mNpBj+vWlo8mLeNzWLN3nNM
	Fte/PGe1mH/kHKvF+fMb2C02Pb7GavGx5x6rxeVdc9gsZpzfx2Rx8ZSrxf89O9gtDr9pZ7X4
	d20ji0XTsvVMDnwe72+0sntsWtXJ5rF5Sb1H35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZexb
	ZFBwQqDiWPtW1gbGbzxdjJwcEgImEv9ObmHuYuTiEBLYzSgxcfdnRoiEjMTGhv/sELawxP2W
	I6wQRe8ZJf52fGbpYuTgYBPQlfjzzwEkLiJwiEli4uenLCAOs8BlRoljdyczg3QLC7hKnD8z
	hxXEZhFQlZh49z4LiM0rYC+xoeE3G8QGeYmLa56zQcQFJU7OfAJWwwwUb946m3kCI98sJKlZ
	SFILGJlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEB7qW5g7G7as+6B1iZOJgPMQo
	wcGsJMKbdO9omhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5O
	qQYmxrj0xFlPW/UO2auXrG5f+92uIPZRqlFOzZxzm29PSJJPSjR5HtMUFande9L+7wRLtpLM
	uvufpF+FlNsHR1XdTTtf32/PIq92TJ/v09LwBW6qC/pTLmtP3n5u3bO3+k9/XkzaZHwo78gj
	qXU746838L4UfTnXX2XDIzepF8qWr1JXTj/SP/Hoh4yznb21E7Y9fKRwo0hnpdLCjqyI+Ws3
	7H9bqptmn7yXM658q8y+N8H35i95pftpPzcDe9K8D03MNSWOziI/GiW707IaEv6WRFmxSwpt
	m/puYd/UlRqX5G3mzvuR9YTzInPMzMl/81vvPAjU+WseKTfxBselGQ8nis3epR5xnLF44Sf/
	NVnFSizFGYmGWsxFxYkASz73ieMCAAA=
X-CMS-MailID: 20240821232656epcas2p2596e2a1f31bf02084d9e4cd0fc80ce14
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240821232656epcas2p2596e2a1f31bf02084d9e4cd0fc80ce14
References: <CGME20240821232656epcas2p2596e2a1f31bf02084d9e4cd0fc80ce14@epcas2p2.samsung.com>

This patchset adds initial clock driver support for Exynos Auto v920 SoC.
This driver uses HW Auto Clock gating. So all gate clocks did not register.

Below CMU blocks are supported in this patchset and remains will be implemented later.

- CMU_TOP
- CMU_PERIC0/1
- CMU_MISC
- CMU_HSI0/1

Changes in v9:
 - Modify the parent clock name of peric0_cmu to match the device tree

Changes in v8:
 - Resend it because v7 includes other SoC patches

Changes in v7:
 - Combine duplicate clock description

Changes in v6:
 - Add peric1, mis and hsi0/1 in the bindings document

Changes in v5:
 - Change CMU_TOP odd numbering
 - Move the descriptions and names common clocks properties

Changes in v4:
 - Change PLL_531x fdiv type and mask bit
 - Change PLL_531x mdiv type

Changes in v3:
 - Change SoC name from Exynos Auto to ExynosAuto
 - Change the makefile order to the bottom of exynosautov9
 - Add PLL_531x formula for integer PLL

Changes in v2:
 - Fix typo from v209 to v920
 - Change USI clock to appropriate
 - Merge headers into binding patches
 - Change clock-name to the recommended name

Sunyeal Hong (4):
  dt-bindings: clock: add ExynosAuto v920 SoC CMU bindings
  arm64: dts: exynos: add initial CMU clock nodes in ExynosAuto v920
  clk: samsung: clk-pll: Add support for pll_531x
  clk: samsung: add top clock support for ExynosAuto v920 SoC

 .../clock/samsung,exynosautov920-clock.yaml   |  162 +++
 .../arm64/boot/dts/exynos/exynosautov920.dtsi |   40 +-
 drivers/clk/samsung/Makefile                  |    1 +
 drivers/clk/samsung/clk-exynosautov920.c      | 1173 +++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |   44 +
 drivers/clk/samsung/clk-pll.h                 |    1 +
 .../clock/samsung,exynosautov920.h            |  191 +++
 7 files changed, 1599 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
 create mode 100644 drivers/clk/samsung/clk-exynosautov920.c
 create mode 100644 include/dt-bindings/clock/samsung,exynosautov920.h

-- 
2.45.2


