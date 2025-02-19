Return-Path: <linux-kernel+bounces-521719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770F8A3C17B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F713BDD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2361F5608;
	Wed, 19 Feb 2025 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KRamccdO"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A8F1F417A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973784; cv=none; b=FtbE4xcRaHayund9ZfFmA5BFsjJ327qcx54kDHxX54XzYmODpoPCFneGSpN+bi1WFyOJZnk4l7ordwEBs7qZ1ZbVR1lkq7Pu96Vxq2Wsq4LHCqEAYD8wOsiB4wlU5XwyN3FvEhjouOApFWdI04D/JY3RJmtW9huZPRoneJ5o5Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973784; c=relaxed/simple;
	bh=LjNeeGPZTSfwAfwVgmY6/aONFof+BNi8pWf8VZUD+9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=JYdbW8kAHAiLTdJvZGc6jalyQ9ihsSiid5d5+ukauCrLrUIpY7kBasNO0zzOTyyw04o3qyo9rjm3aCxVM7B7/d4zpZDWtpFdpoY1ho7Q4dPLcNhiOHDzmYy+bpmiiWc8swi8Gv3x5/pharisb0/bsl+5NgnHLQGu/g7uVpDH4xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KRamccdO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250219140259euoutp02ac4e17eb84469f1de538202e1de5be05~loO8gKBkq0188601886euoutp02F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250219140259euoutp02ac4e17eb84469f1de538202e1de5be05~loO8gKBkq0188601886euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739973779;
	bh=GvH+KGxOLMWPvCT3kvkzzW6sq/iRIHCpZUQmHgtdxxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRamccdODI4xtJOXEfZlia2Vbb7GGNxdNFQKN/vIpgq4DQuEo12Vo/PkKht5UAHtr
	 S25SU5b3npyIeovR1tkcJPGnVZTcCB6mQLvf2L5Yug7x8Nn6jriIZTvEQPatQuN+y0
	 vNXAhWqBWw/ZFLrgq+szp080vk28lL/vkAXq4EHI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250219140259eucas1p162c6901df4144326dfee8ecfed7fc319~loO8KKLAk1249312493eucas1p1f;
	Wed, 19 Feb 2025 14:02:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 2A.73.20821.394E5B76; Wed, 19
	Feb 2025 14:02:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250219140259eucas1p114dbcacffe3b479d15cd800c7efbede2~loO7o8Igp2157921579eucas1p1_;
	Wed, 19 Feb 2025 14:02:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250219140258eusmtrp20bd4ced874c2d935b75951953f5dda95~loO7mH8422432224322eusmtrp2p;
	Wed, 19 Feb 2025 14:02:58 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-32-67b5e493763b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.52.19654.294E5B76; Wed, 19
	Feb 2025 14:02:58 +0000 (GMT)
Received: from AMDC4942.home (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250219140257eusmtip2a2ebe2aba18fc2a9d6c1ef6da5b11e34~loO6S3NLf0697406974eusmtip2J;
	Wed, 19 Feb 2025 14:02:57 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org,
	wefu@redhat.com, jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, frank.binns@imgtec.com,
	matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	ulf.hansson@linaro.org, jszhang@kernel.org, p.zabel@pengutronix.de,
	m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, Michal Wilczynski
	<m.wilczynski@samsung.com>
Subject: [PATCH v5 07/21] riscv: Enable PM_GENERIC_DOMAINS for T-Head SoCs
Date: Wed, 19 Feb 2025 15:02:25 +0100
Message-Id: <20250219140239.1378758-8-m.wilczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250219140239.1378758-1-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xbVRzOuff23tKl7FKIO4FlhPoIjvGYWfRkE2TEmes2jNOpU2JYdTcd
	Eyi2INvCAqRQHitOeYxRwM66CAKFgm0F5OEQKK+Wx1yZC5RJWHiEh4WxZA+ZlNvp/vt+5/ed
	75H8+LjITPry4xKTWXmiJF5MCghz74Ph4KIZkzSso84P9Y3rMGR6pKFQXbsNQ9puGw85xowY
	+mN9hUT1d0coNNeeSSB7dSWFlL0NJJrXOEjkVDt46EZrBYnWCroBMq9lkUjfPUmhhnUthr53
	mgh0rbkVIFXejzw0OnAITTr6CDR/Q40jlWY7etLWTKENeyOBypc7KWRc/JaHLPqPUFZnMRG5
	i1m5lU0xi/PzBPN77j2Kab9/lWBaNJMUo24ZAkxTTR7JTNjbSOa7/mPM1EULxvx8LZ3J0vdi
	zKV/wpiVjpsk87WxBjBjynHqXdEngtdPsfFxX7Hy0IiTgtPl+iEsqdjjrPrXETIDDFL5wIMP
	6X0wx1qC5wMBX0RXA9hvzATccA/AqeUWkhvWAFxdd5JPv2Q+eIRxiyoAa+4PENywCGB1ewPm
	YpH0K/BOlZbnWvjQ2QTM7uGEcXoWQPNMxZaWN30YZpY1b0Uh6Bdhrm6I58JC+g3YM6LEOD9/
	2HnduhmRz/egI2HHqC9H8YL9ZTOEC+ObFKWpfKsFpBsFsF5X4c76Jqz962+cw95wwWJ0194J
	n7Ro3foyeMe06uakwRa1xY0PwAnbQ9Lli9Mvw4bWUBeE9EG4PCDhoCe8teTFJfCEheZSnHsW
	wlyViNN4CZaoC/7ztFWb3Z4MnPxzlvoGBGie6aJ5povmf9urAK8BO9gURYKUVexNZFNDFJIE
	RUqiNORzWUIT2DztwQ3LajOoXHCGdAGMD7oA5ONiH6Eq3SgVCU9Jzp1n5bJYeUo8q+gCfnxC
	vEOo68yWimipJJn9gmWTWPnTLcb38M3AUlv9DNHBi8He5dGiArW29mPVUl+OebWqxKGylQcG
	JY3FdYdF2S70HJjOiRrfxpvc91ujM/fgRKp16VBg7XQhdvEEr+vDPUf9xaX9CdGepf5pj28X
	fpmXD+RFvcdj6+Zuex2LCR+TDs75RBlaRXab4eh7l+tir69+VmGYNQTMvNVXuTOo7Pki7Z76
	C/qIE6oj2z2Oh58fLlaOnNkv3chVR9l56a/BeYvsZtBzzPSlXxqH3zm8e6ryp4jkgG3Sc5Gm
	htG0jIeBQLhg912RPb7r98FA2qdNZeFTJ8+8f1aXaKVmHa+2wfGqK6lvl4T+0KG6vCvG+kKE
	SUwFX9k/JRXlDcpixITitGTvblyukPwLpsZf0EkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xe7qTnmxNN5j2yNjixPVFTBZbf89i
	t1iz9xyTxfwj51gt7l3awmRx5et7Not1Ty+wW7zY28hicW3FXHaL5mPr2SxezrrHZvGx5x6r
	xeVdc9gsPvceYbTY9rmFzWLtkbvsFuu/zmeyWPhxK4vFkh27GC3aOpexWlw85Wpx994JFouX
	l3uYLdpm8Vv837OD3eLftY0sFrPf7We32PJmIqvF8bXhFi37p7A4yHm8v9HK7vHm5UsWj8Md
	X9g99n5bwOKxc9Zddo+enWcYPTat6mTzuHNtD5vHvJOBHve7jzN5bF5S79Gy9hiTR/9fA4/3
	+66yefRtWcXocan5OnuAUJSeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6d
	TUpqTmZZapG+XYJexuy1Z5gKpnBW9Oy+wNbAeJq9i5GTQ0LARKLx52+mLkYuDiGBpYwS+3om
	M0MkZCSudb9kgbCFJf5c62IDsYUEXjFKbG02ALHZBIwkHiyfzwpiiwgsZpHYu68SZBCzwFtG
	ieszN4I1Cwt4STTO3AG2jUVAVaJj0RmwBl4Be4mjF5qZIBbIS+w/eBZoMQcHp4CDxL6LUhC7
	7CXO9d2HKheUODnzCdhIZqDy5q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xkV5xYm5xaV66
	XnJ+7iZGYHLZduznlh2MK1991DvEyMTBeIhRgoNZSYS3rX5LuhBvSmJlVWpRfnxRaU5q8SFG
	U6CzJzJLiSbnA9NbXkm8oZmBqaGJmaWBqaWZsZI4L9uV82lCAumJJanZqakFqUUwfUwcnFIN
	TGYTp+i2JQRIZ+xJ+bzo9sb3f//wNc1UbZ3U+KNH55+PxcM0My1O9SdCSw6oFWtzVS6ZHJ10
	Oj0hQdb8CKuuxqw7Lw4udNL8kiH73aFzNn9V99xtKo95zMLm3m3O8TNT/H21OlxtWdJOfT2D
	uWdbnS8xCv45/m9nWcrunb0c+Y/OV81v3q1SfNNC5k/rlEW6HS1GJfXVm8NS4++srju/zmSS
	gFou4wbjB9Ep7/6/vBz1fZ2dssr3NsaJ+7YX6ztPuiKu/vJxSN303R06nj3/k4Ui/Rn1ZzHu
	Tpru4LrsyNzXO4ombv22VejwVdWeuSerZl9XVFfeda/31daES1flzfx3/Jrx5kn6gcWbBbNu
	JSqxFGckGmoxFxUnAgAaQ0SqtwMAAA==
X-CMS-MailID: 20250219140259eucas1p114dbcacffe3b479d15cd800c7efbede2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250219140259eucas1p114dbcacffe3b479d15cd800c7efbede2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250219140259eucas1p114dbcacffe3b479d15cd800c7efbede2
References: <20250219140239.1378758-1-m.wilczynski@samsung.com>
	<CGME20250219140259eucas1p114dbcacffe3b479d15cd800c7efbede2@eucas1p1.samsung.com>

T-Head SoCs feature separate power domains (power islands) for major
components like the GPU, Audio, and NPU. To manage the power states of
these components effectively, the kernel requires generic power domain
support.

This commit enables `CONFIG_PM_GENERIC_DOMAINS` for T-Head SoCs,
allowing the power domain driver for these components to be compiled and
integrated. This ensures proper power management and energy efficiency
on T-Head platforms.

By selecting `PM_GENERIC_DOMAINS`, we provide the necessary framework
for the power domain drivers to function correctly on RISC-V
architecture with T-Head SoCs.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 1916cf7ba450..83833ded8908 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -53,6 +53,7 @@ config ARCH_THEAD
 	bool "T-HEAD RISC-V SoCs"
 	depends on MMU && !XIP_KERNEL
 	select ERRATA_THEAD
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the RISC-V based T-HEAD SoCs.
 
-- 
2.34.1


