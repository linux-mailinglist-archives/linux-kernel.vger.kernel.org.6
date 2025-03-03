Return-Path: <linux-kernel+bounces-541923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E9A4C373
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF931893212
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4ED2139DB;
	Mon,  3 Mar 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b0jxFdoy"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6A20F086
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012598; cv=none; b=JRnLjk/BhNEirrWOvRq54H6bOmkmkUQ8uEghatL/45XoTZ9Jn4lCQlf36i6KCvSaXjKFnRmHPVwBTZk9NXHCoV+cv0XXnFUSytYQctTLdqLaxxvCil3h9OEBC13op5Cg61DHI5gCxtEkTBTCw7epPgLvVP2Y9kpGr+4w5PouGR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012598; c=relaxed/simple;
	bh=I/74DaK6OwRQxqLGBF1ylRLIPNLrG2psU7QD8Iv7Pnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cUM9cbaFQEJ/oOKfe9ET3fihPhnlNWpqRry4jUHt5u/eiHJXA7kG4XTbVvj+NJWZ1OeVYq1e25OGXio1FaY4GwZgaW3ILluDZMho28vXws4l1y0xihQowbosoDrONRTL2jOGniJGjEb8DvgEOYqzEXE5yxejPfKaPR4mPnkRjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b0jxFdoy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250303143635euoutp0213369683ce14d41a2495f3aee0768c75~pUbshVKMK2659126591euoutp02h
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:36:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250303143635euoutp0213369683ce14d41a2495f3aee0768c75~pUbshVKMK2659126591euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741012595;
	bh=pTjIhab8FRPR9yXV/fmQexbnMHTD4v3PKosSwFKK0e4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=b0jxFdoyc43MHMRFKwa1VHx4XZT/eOv7H6+dZpdH5/juf2W44WVVAPu+nDJxaTOWW
	 INT3I//iX6ekTonAyQONmx/wN9xB1a86BpgPA8gPJUcHXgK6fk0ffmRAS1GsvZK6Qb
	 MxiBhPLlsdy6TYVBnA8uv6x+wtFi09AZl4rHxIxA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250303143634eucas1p203aef65baec1b28baa23e41bdcbfbdef~pUbsDPrX42682126821eucas1p2s;
	Mon,  3 Mar 2025 14:36:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id A9.8D.20409.27EB5C76; Mon,  3
	Mar 2025 14:36:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250303143634eucas1p269281f72bdc4d764edd54b9427f68787~pUbrokfQM2682126821eucas1p2r;
	Mon,  3 Mar 2025 14:36:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250303143634eusmtrp194320dd4bcc931db79a659cb79d181c8~pUbrmn-s01014710147eusmtrp1l;
	Mon,  3 Mar 2025 14:36:34 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-99-67c5be722ace
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B4.89.19654.17EB5C76; Mon,  3
	Mar 2025 14:36:34 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250303143633eusmtip28a4429ddccd06e468ba9ba46be450def~pUbqqIMVy2026320263eusmtip2j;
	Mon,  3 Mar 2025 14:36:33 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, jszhang@kernel.org,
	p.zabel@pengutronix.de, m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Michal
	Wilczynski <m.wilczynski@samsung.com>
Subject: [PATCH v1 0/4] Add T-Head TH1520 VO clock support for LicheePi 4A
 GPU enablement
Date: Mon,  3 Mar 2025 15:36:25 +0100
Message-Id: <20250303143629.400583-1-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7djPc7pF+46mG3QeULB4ducrq8XW37PY
	LdbsPcdkMf/IOVaLe5e2MFm82NvIYtF8bD2bxctZ99gsPvbcY7W4vGsOm8W2zy1sFmuP3GW3
	WP91PpPFxVOuFnfvnWCxeHm5h9mibRa/xf89O9gt/l3byGLRsn8Ki4OIx/sbreweb16+ZPE4
	3PGF3ePeiWmsHptWdbJ5bF5S79Gy9hiTR/9fA4/3+66yefRtWcXocan5OrvH501yATxRXDYp
	qTmZZalF+nYJXBn7phcUXOSpaHi7iqmBcStXFyMnh4SAicS0b98Yuxi5OIQEVjBKrGtsZ4Vw
	vjBKnJ/+kxnC+cwo8bH3OTNMS8O5RewQieVALVPfs4EkhATeMEpMvcAIYrMJGEk8WD4fbJSI
	wB4mie/fIUYxC6xilHjy7SM7SJWwQLTEkgkNYDaLgKrExEOtLCA2r4CdxJX2xVDr5CX2HzzL
	DBEXlDg58wlYDTNQvHnrbLChEgL7OSX2rn/MCtHgIrH9RAcjhC0s8er4FnYIW0bi9OQeFgg7
	X+LB1k9QC2okdvYch7KtJe6c+wX0DgfQAk2J9bv0IcKOEj+vzwELSwjwSdx4KwhxAp/EpG3T
	mSHCvBIdbUIQ1WoSU3t64ZaeW7GNCcL2kHj+YCsjJKxiJT4dnc44gVFhFpLHZiF5bBbCDQsY
	mVcxiqeWFuempxYb5aWW6xUn5haX5qXrJefnbmIEpsrT/45/2cG4/NVHvUOMTByMhxglOJiV
	RHhvtR9NF+JNSaysSi3Kjy8qzUktPsQozcGiJM67aH9rupBAemJJanZqakFqEUyWiYNTqoGp
	Kvf30c9JD9e6JXSxOz5IOKKxJH6qhfbvVTml3gwPCmOfFy48+efTmml1sa6h/7lmb1uklPgq
	sHamsJ5p4OIsp9rfji/4c879FtppE/pk14Uf9hU3nNO1lc/bFCnWS6+uF1wVaDFd9VbG4lPq
	JgbsKVVMSin2S3rSXGyL9SfHRQl4zRF4fvLM+UWfVAX3W3Dl2F+0b2ivUru0ONHP/tIprlN5
	t5/1cD+SrWb8cfvilmVV3bdXOlm2eR0yXv0vKPhj9r/ULx+3HL/Kc3Rii8SLksnrr4adDCgz
	TZ2TtX9J35r2XZN62YUvGj0Umyb7OXv626y7FnnzDzmarVBnXcjx8lN2y5WFfxnLsm0WGnUo
	sRRnJBpqMRcVJwIA2loBZQQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7pF+46mG0w/xGzx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	sf7rfCaLi6dcLe7eO8Fi8fJyD7NF2yx+i/97drBb/Lu2kcWiZf8UFgcRj/c3Wtk93rx8yeJx
	uOMLu8e9E9NYPTat6mTz2Lyk3qNl7TEmj/6/Bh7v911l8+jbsorR41LzdXaPz5vkAnii9GyK
	8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL2TS8ouMhT
	0fB2FVMD41auLkZODgkBE4mGc4vYuxi5OIQEljJKrDuzmRkiISNxrfslC4QtLPHnWhcbiC0k
	8IpRoudkFYjNJmAk8WD5fFaQZhGBC0wSu9atZgJxmAXWMUpM2b6DCaRKWCBS4v33hWCTWARU
	JSYeagWzeQXsJK60L4baJi+x/+BZZoi4oMTJmU+AajiABqlLrJ8nBBJmBipp3jqbeQIj/ywk
	VbMQqmYhqVrAyLyKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMKK3Hfu5ZQfjylcf9Q4xMnEw
	HmKU4GBWEuG91X40XYg3JbGyKrUoP76oNCe1+BCjKdDVE5mlRJPzgSklryTe0MzA1NDEzNLA
	1NLMWEmcl+3K+TQhgfTEktTs1NSC1CKYPiYOTqkGppCtrvvNv70z1Y45pLXhVvPF+pdawdMf
	MLXv25g965HNx4tzHjEsT1kkldzh9TclP1ujZCnPl91Gj+wYdRQj7q8WfDp36qZKiclxP5xE
	JS9frhPlEggSe5yZrLTbZ+ME9qP9bwT28qjmbZlSzLn7UE5o/H/HQuk1sha2687/WdbCqPBS
	SlDq2iEWSYPwfPYZJb8+VTHe2+CePEMm4PySJTrLW26rH/rQLTqrP5zh6E7nl5MfJEtNrbhl
	J3+oaKJVjr4A7wyB01efPv/GWmHXpMp3826oWOeUG+Er1+bItPHGdzre27uh377dxyXmUUnE
	92jLk9GZD1bxt9p2+BbvWBcQ+JFXQ3em04t7vuEZSizFGYmGWsxFxYkACo1pLXEDAAA=
X-CMS-MailID: 20250303143634eucas1p269281f72bdc4d764edd54b9427f68787
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143634eucas1p269281f72bdc4d764edd54b9427f68787
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143634eucas1p269281f72bdc4d764edd54b9427f68787
References: <CGME20250303143634eucas1p269281f72bdc4d764edd54b9427f68787@eucas1p2.samsung.com>

This is a subset of a larger patch series enabling the Imagination BXM-4-64 GPU
on the LicheePi 4A board, which is powered by the T-HEAD TH1520 SoC. While the
full series includes power-domain, reset, and firmware changes, this part
focuses solely on the clock subsystem needed for the GPU and other VO (video
output) blocks. By merging these clock patches independently, we prepare the
groundwork for future GPU integration via the `drm/imagination` driver.

The T-HEAD TH1520 SoC features multiple clock controllers. Initially, only the
AP clock controller was supported upstream. The patches below add support for
the VO (video output) clock controller, which manages GPU-related gates, HDMI,
and other multimedia clocks. Additionally, they introduce a mechanism to
provide no-op operations for the GPU's "mem" clock gate (documented as
“Reserved” in the hardware manual) and coordinate the GPU CLKGEN reset in the
clock driver.

Bigger series cover letter:

https://lore.kernel.org/all/20250219140239.1378758-1-m.wilczynski@samsung.com/

Michal Wilczynski (4):
  dt-bindings: clock: thead: Add TH1520 VO clock controller
  clk: thead: Add clock support for VO subsystem in T-Head TH1520 SoC
  clk: thead: Add support for custom ops in CCU_GATE_CLK_OPS macro
  clk: thead: Add GPU clock gate control with CLKGEN reset support

 .../bindings/clock/thead,th1520-clk-ap.yaml   |  33 +-
 drivers/clk/thead/clk-th1520-ap.c             | 298 ++++++++++++++++--
 .../dt-bindings/clock/thead,th1520-clk-ap.h   |  34 ++
 3 files changed, 334 insertions(+), 31 deletions(-)

-- 
2.34.1


