Return-Path: <linux-kernel+bounces-170773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0BE8BDBCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F788B22AEA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2CB78C86;
	Tue,  7 May 2024 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Q/TNNkzH"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAC6D1CC
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715064296; cv=none; b=Xjla8RwIwEYovn9vBOJjefJYtksjXzq2PFNW7R6+qvTCrjYLHmpZbhetQ4PHDdilmU5rE5tU67Lr99+ew6M3umLEMlMuITnFO2G+1NqHDnBXAjXY+fGdYdvsE3gP6DouzTBQqzrE4nU+03jMky/XWWpLOYQcQU6Kw8f6I+PYDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715064296; c=relaxed/simple;
	bh=bIr96LxzE/mBBQAf30AeCPbs77++Uq1+5Mkr6CTLumk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=bcno3dR5+5LCfVl1T21rjJIKb4gZ3lA9EpJ79uT0m3ojwq3Y7hhMsxLsJti+KB958WjU6eFO4Ovw4A+Wn1n3TRdULr/QHAQGBV53kp9nWxo5os6RiNU5j3w3NljOsinfYrzde8ZgZkSj61n5Ma9y2SevIOIOLV7AeGqm2Gy8fYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Q/TNNkzH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240507064446euoutp0177d1bf847cca1ac3c7b52771845abf85~NIeG6UDr62308023080euoutp01w
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 06:44:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240507064446euoutp0177d1bf847cca1ac3c7b52771845abf85~NIeG6UDr62308023080euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715064286;
	bh=ihBifNfNyNRL0omOGoA7M6GHq/5MHdBh1bGVpG9xKZ4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Q/TNNkzHFq2zSySNEApGAX/2lUW10ua+mACP4COx20+7WTA4wBY/SsGOt0t59NFxQ
	 gIqH5YLH21qYd8TYQhatRhrNNvIe1PG8Bo3bhMVMttiIb/Zz0bjCWDvwW8Au+AKocO
	 VfuOBoF0k89pTTkY0NuFZKrD3FZVdZgIc01PwfEk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240507064445eucas1p2d506f698369c8b112c4e2bec500e492f~NIeGbY_n90938309383eucas1p2U;
	Tue,  7 May 2024 06:44:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id EC.9D.09624.DDDC9366; Tue,  7
	May 2024 07:44:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240507064445eucas1p1bfc17da4f824ef46567774634482f12f~NIeGL8hiY3062730627eucas1p1Q;
	Tue,  7 May 2024 06:44:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240507064445eusmtrp28ab9f5c768f66e26c2a4b57a7f10f720~NIeGLS-sI2837728377eusmtrp2b;
	Tue,  7 May 2024 06:44:45 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-90-6639cddd8258
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 78.33.09010.DDDC9366; Tue,  7
	May 2024 07:44:45 +0100 (BST)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240507064445eusmtip1792a0627ab86b07a87c5651e264d07d0~NIeFxK4Fq0479904799eusmtip1n;
	Tue,  7 May 2024 06:44:45 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Russell King
	<linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clkdev: fix potential NULL pointer dereference
Date: Tue,  7 May 2024 08:44:34 +0200
Message-Id: <20240507064434.3213933-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWy7djP87p3z1qmGcx9b2ax6fE1VouPPfdY
	LS7vmsNmcWjqXkaLtUfusltcPOVq8e/aRhYHdo/L1y4ye7y/0crusWlVJ5vH5iX1Hn1bVjF6
	fN4kF8AWxWWTkpqTWZZapG+XwJVxfPVhloJnohUfXt9jbWCcLtTFyMkhIWAi0fb7OFMXIxeH
	kMAKRok1O9+xQDhfGCW+9FxmhXA+M0pcffOODabl6dEOqJbljBKXv19ihmuZ/GISI0gVm4Ch
	RNfbLrAOEYFkiQtfvoPNZQbpeH39LytIQljAXqLz/01mEJtFQFWi68c8dhCbFyi+8vpdRoh1
	8hL7D55lhogLSpyc+YQFxGYGijdvnQ22WUJgKYfE+6cX2CEaXCSmfm2GahaWeHV8C1RcRuL/
	zvlMEA3tjBILft+HciYwSjQ8vwXVYS1x59wvoLs5gFZoSqzfpQ8RdpT4tH4RI0hYQoBP4sZb
	QYgj+CQmbZvODBHmlehog4aqmsSs4+vg1h68cIkZwvaQWPR0B5gtJBArce7AbZYJjAqzkLw2
	C8lrsxBuWMDIvIpRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw7Zz+d/zTDsa5rz7qHWJk
	4mA8xCjBwawkwnu03TxNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9qinyqkEB6YklqdmpqQWoR
	TJaJg1OqgUnnPR9H565H2XFp5sdjWq/Me56+VELBTfW7062uWZPqS1J3SksWxe6Xu/93qXLE
	V6m1ISenXbvfP0dmbnZF1C8Tw3NxwTtXxJaKxGjG750VdTZK6HtAQs2uDa3XntdZel3dlbo2
	XHrT/0yPZwvfys17H7yAzciWredWmq9iqIkZ88m6TL4rlaEbNy0umSma+Ts9c8fkxem5v+wb
	zPfX+c/+5bP4D5etgvWLs9/XnRZayfT5vKbQd5u9G67rKU/bpf7kiW6ikaoIo5dB446H8rM8
	Co7ZzFz7N8v0hmrIxkWnQ/zX399xX0r6Wnlk+Fnf45VuoU3iv8M57tzNPXrq09tPfZZZM8yM
	xHqSfv85Ea/EUpyRaKjFXFScCACCjSr1qgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsVy+t/xu7p3z1qmGRx9oG6x6fE1VouPPfdY
	LS7vmsNmcWjqXkaLtUfusltcPOVq8e/aRhYHdo/L1y4ye7y/0crusWlVJ5vH5iX1Hn1bVjF6
	fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
	oJdxfPVhloJnohUfXt9jbWCcLtTFyMkhIWAi8fRoB1MXIxeHkMBSRolvt3rZIRIyEienNbBC
	2MISf651sUEUfWKUuH7jFzNIgk3AUKLrLUiCk0NEIFVi/9GX7CBFzAIrGSXuzL8M1i0sYC/R
	+f8mWAOLgKpE1495YBt4geIrr99lhNggL7H/4FlmiLigxMmZT1hAbGagePPW2cwTGPlmIUnN
	QpJawMi0ilEktbQ4Nz232EivODG3uDQvXS85P3cTIzDYtx37uWUH48pXH/UOMTJxMB5ilOBg
	VhLhPdpunibEm5JYWZValB9fVJqTWnyI0RTovonMUqLJ+cB4yyuJNzQzMDU0MbM0MLU0M1YS
	5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYLI/OdHUJfF4hNz1K3+LHjyYWSwSKVexvkjq8K0b
	Scrbnsu0BXA9XZzz1vDg4YREGxejBVz1fVcFLJNvcx/2vPNFueV/gHzbHSfV1T+W8Te9ELkZ
	wPAv4egiV3OFzjbmrAV+a9663p98c1L8d9G5W1ceKP2yrfTvix+nvn3h0ffmZrn4/EnHaS9n
	B7n23bMPTY0QusPYcSe0VNBr05npErybjqoLlv9rXJwos/WAFNONDedPxu4xbc/KfDxv6tXL
	bcGyiSaHSiLu7F9vFpmY9Htd8bOi24+/XrCtVzWvM/TzKJTQdeWTfSNu4vq7z9U/7cCs664L
	fnPK6lRx/m1La2w567L31t9na6Xrg17ntCixFGckGmoxFxUnAgD/eMoY/wIAAA==
X-CMS-MailID: 20240507064445eucas1p1bfc17da4f824ef46567774634482f12f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240507064445eucas1p1bfc17da4f824ef46567774634482f12f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240507064445eucas1p1bfc17da4f824ef46567774634482f12f
References: <CGME20240507064445eucas1p1bfc17da4f824ef46567774634482f12f@eucas1p1.samsung.com>

dev_fmt argument is optional, so avoid dereferencing it unconditionally.

Fixes: 4d11c62ca8d7 ("clkdev: report over-sized strings when creating clkdev entries")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

This fixes the following kernel panic observed on Samsung Exynos542x
SoCs family:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[00000000] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-00001-g4d11c62ca8d7 #14975
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at vsnprintf+0x4c/0x3c8
LR is at init_stack+0x1dd6/0x2000
pc : [<c0c09d3c>]    lr : [<c1301dd6>]    psr: 800000d3
..
Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000406a  DAC: 00000051
..
Process swapper/0 (pid: 0, stack limit = 0x(ptrval))
Stack: (0xc1301c70 to 0xc1302000)
..
 vsnprintf from va_format.constprop.0+0x70/0x160
 va_format.constprop.0 from pointer+0x454/0x670
 pointer from vsnprintf+0x228/0x3c8
 vsnprintf from vprintk_store+0x100/0x428
 vprintk_store from vprintk_emit+0x6c/0x328
 vprintk_emit from vprintk_default+0x24/0x2c
 vprintk_default from _printk+0x28/0x4c
 _printk from vclkdev_alloc+0xf0/0x110
 vclkdev_alloc from clkdev_hw_create+0x28/0x88
 clkdev_hw_create from clk_hw_register_clkdev+0x38/0x3c
 clk_hw_register_clkdev from samsung_clk_register_fixed_rate+0xa4/0xd4
 samsung_clk_register_fixed_rate from exynos5x_clk_init+0xf0/0x2b0
 exynos5x_clk_init from of_clk_init+0x15c/0x228
 of_clk_init from time_init+0x24/0x30
 time_init from start_kernel+0x4b8/0x620
 start_kernel from 0x0
Code: e09e9001 e1a05002 e28da01c 2a000086 (e5d50000)
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/clk/clkdev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index ddacab7863d0..d2801ae70e34 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -194,10 +194,12 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	return &cla->cl;
 
 fail:
-	fmt.fmt = dev_fmt;
-	fmt.va = &ap_copy;
-	pr_err("%pV:%s: %s ID is greater than %zu\n",
-	       &fmt, con_id, failure, max_size);
+	if (dev_fmt) {
+		fmt.fmt = dev_fmt;
+		fmt.va = &ap_copy;
+		pr_err("%pV:%s: %s ID is greater than %zu\n",
+		       &fmt, con_id, failure, max_size);
+	}
 	va_end(ap_copy);
 	kfree(cla);
 	return NULL;
-- 
2.34.1


