Return-Path: <linux-kernel+bounces-378162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBA9ACC35
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F5AB235DC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59F1C1AD8;
	Wed, 23 Oct 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="IrbZQf0D"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9581BD039
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693453; cv=none; b=sLUma9EZdArYllLJQ9dg9/xhju2b/iBfITELU7JquktpvCksli9bbxvBUn6pZxKTQUUN2uFOikj48pR0iw+DERMLoyXuRV1UzBSByrLzpQRsniRK7Nd3Nzj/f4TMM8AP9DNpH6Fg4gnjdVxyAFX5QYCGDhEKzigzoVZs3w8AtqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693453; c=relaxed/simple;
	bh=1v7sVqBzrNoj9xYwEa6etrISNUcXjjJZhJ8KkWCVaqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KaD6otVRM49nrblto6Iv/wXVW2eHiziVjMgWJPjs4zQJlIaywsrdFcJMGlompVLg1xB+BCNM6yFP9iL/rMaq518d6Hxmlbj/gkbNv6QVg18wuQ0JGWu2UYYTEbIfxliEhXghnHbiZ99OCbdQBTNQe53LLUJBt0T6Ioyb46Je7fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=IrbZQf0D; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5273240008;
	Wed, 23 Oct 2024 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729693444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pobBfVHQuhQp9iPhrHMIYtYyXnZXUXpAqAVOpIsuqJQ=;
	b=IrbZQf0D2KTNV4ONn6ymWvmtty1k18XkkFKdYDBtEx+MPDmckHHQNGvVGmoCsPx+SVFkuz
	Ub2cw0tzOdJMA+c+iho+Ix583FbabJG4fZC+hQpB3rKX3sFnG4kZFC4Txm/WuPKxM8BCpe
	UnZtvOKFrw3iNM7KfufT7IuHVGyjfhML2vb8MMDfu0w6JaxA9iMuzhxGDomNZy0lseec9d
	TD9OkuKq2bGoHkBF6/7ow6bR4zEBPPvuEtIYUqVEqvZpezOqRVZXmXuFcKv6FHB9x3qSYC
	1TJzeFB/JkurcJwfgPmsBEUoKO+OaqdUPqnMEHi4IPiBCX310SeMBs/MPIkWAQ==
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Date: Wed, 23 Oct 2024 16:24:02 +0200
Subject: [PATCH] m68k: coldfire: Enable DMA timer 0 support for M5441x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-m5441x-dma-hrtimer-v1-1-d476ecb0f027@yoseli.org>
X-B4-Tracking: v=1; b=H4sIAAEHGWcC/x3MQQqAIBBA0avErBtQ04quEi2kxpyFFWNEEN09a
 fkW/z+QSZgyDNUDQhdn3rcCXVcwR7+thLwUg1HGamUaTM5afeOSPEY5OZFgCCb0zqq+az2U8BA
 KfP/TcXrfD2RQtJ9kAAAA
X-Change-ID: 20241023-m5441x-dma-hrtimer-ff2f8540876a
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
 Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729693443; l=5682;
 i=jeanmichel.hautbois@yoseli.org; s=20240925; h=from:subject:message-id;
 bh=1v7sVqBzrNoj9xYwEa6etrISNUcXjjJZhJ8KkWCVaqQ=;
 b=4j2shDuTo1LFJRVAH7sUGG0oL2lnvD+bA+jt9n6lHsp4g8LhSdiahHAloOkaJ+iWDI6nLjHZW
 3T/2T4Z1l4lDBFvSWvtSs26XgwTQrqE0PXxsbVyF8uUxr8D9uIG5P+5
X-Developer-Key: i=jeanmichel.hautbois@yoseli.org; a=ed25519;
 pk=MsMTVmoV69wLIlSkHlFoACIMVNQFyvJzvsJSQsn/kq4=
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

In order to use high resolution timers, the M5441x can use the DMA
timers. It has four of it, but let's use the first one only, as it is
based on the existing driver for the MCF523x.

While enabling the clock, fix a small typo in the comments too (timers
where starting at 1 and not 0).

With this commit, it is now possible to use high resolution timers, and
have sub-ms resolution in the kernel timestamps.

Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
---
 arch/m68k/coldfire/Makefile       |  2 +-
 arch/m68k/coldfire/dma_timer.c    | 34 ++++++++++++++++++++++------------
 arch/m68k/coldfire/m5441x.c       |  4 ++--
 arch/m68k/include/asm/m5441xsim.h |  8 ++++++++
 4 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/arch/m68k/coldfire/Makefile b/arch/m68k/coldfire/Makefile
index c56bc0dc7f2e338c8275cfd15656f80e78825254..e6bd32a489155a567d63468ff9eff8a344fd7764 100644
--- a/arch/m68k/coldfire/Makefile
+++ b/arch/m68k/coldfire/Makefile
@@ -29,7 +29,7 @@ obj-$(CONFIG_M5307)	+= m5307.o intc.o reset.o
 obj-$(CONFIG_M53xx)	+= m53xx.o intc-simr.o reset.o
 obj-$(CONFIG_M5407)	+= m5407.o intc.o reset.o
 obj-$(CONFIG_M54xx)	+= m54xx.o intc-2.o
-obj-$(CONFIG_M5441x)	+= m5441x.o intc-simr.o reset.o
+obj-$(CONFIG_M5441x)	+= m5441x.o intc-simr.o reset.o dma_timer.o
 
 obj-$(CONFIG_COLDFIRE_PIT_TIMER) += pit.o
 obj-$(CONFIG_COLDFIRE_TIMERS)	 += timers.o
diff --git a/arch/m68k/coldfire/dma_timer.c b/arch/m68k/coldfire/dma_timer.c
index 91e6728f51ed650f24c6ad4dd7d4d7d7bc6e5adc..184075c5164db84dde985420600649bc1d72b8e8 100644
--- a/arch/m68k/coldfire/dma_timer.c
+++ b/arch/m68k/coldfire/dma_timer.c
@@ -9,23 +9,33 @@
 
 #include <linux/clocksource.h>
 #include <linux/io.h>
+#include <linux/sched/clock.h>
 
 #include <asm/machdep.h>
 #include <asm/coldfire.h>
 #include <asm/mcfpit.h>
 #include <asm/mcfsim.h>
 
+#ifndef CONFIG_M5441x
 #define DMA_TIMER_0	(0x00)
 #define DMA_TIMER_1	(0x40)
 #define DMA_TIMER_2	(0x80)
 #define DMA_TIMER_3	(0xc0)
 
-#define DTMR0	(MCF_IPSBAR + DMA_TIMER_0 + 0x400)
-#define DTXMR0	(MCF_IPSBAR + DMA_TIMER_0 + 0x402)
-#define DTER0	(MCF_IPSBAR + DMA_TIMER_0 + 0x403)
-#define DTRR0	(MCF_IPSBAR + DMA_TIMER_0 + 0x404)
-#define DTCR0	(MCF_IPSBAR + DMA_TIMER_0 + 0x408)
-#define DTCN0	(MCF_IPSBAR + DMA_TIMER_0 + 0x40c)
+#define DTMR	(MCF_IPSBAR + DMA_TIMER_0 + 0x400)
+#define DTXMR	(MCF_IPSBAR + DMA_TIMER_0 + 0x402)
+#define DTER	(MCF_IPSBAR + DMA_TIMER_0 + 0x403)
+#define DTRR	(MCF_IPSBAR + DMA_TIMER_0 + 0x404)
+#define DTCR	(MCF_IPSBAR + DMA_TIMER_0 + 0x408)
+#define DTCN	(MCF_IPSBAR + DMA_TIMER_0 + 0x40c)
+#else
+#define DTMR	(MCFDMATIMER_BASE0 + 0x0)
+#define DTXMR	(MCFDMATIMER_BASE0 + 0x2)
+#define DTER	(MCFDMATIMER_BASE0 + 0x3)
+#define DTRR	(MCFDMATIMER_BASE0 + 0x4)
+#define DTCR	(MCFDMATIMER_BASE0 + 0x8)
+#define DTCN	(MCFDMATIMER_BASE0 + 0xc)
+#endif
 
 #define DMA_FREQ    ((MCF_CLK / 2) / 16)
 
@@ -37,7 +47,7 @@
 
 static u64 cf_dt_get_cycles(struct clocksource *cs)
 {
-	return __raw_readl(DTCN0);
+	return __raw_readl(DTCN);
 }
 
 static struct clocksource clocksource_cf_dt = {
@@ -56,10 +66,10 @@ static int __init init_cf_dt_clocksource(void)
 	 * get a ~213 ns resolution and the 32bit register will overflow almost
 	 * every 15 minutes.
 	 */
-	__raw_writeb(0x00, DTXMR0);
-	__raw_writeb(0x00, DTER0);
-	__raw_writel(0x00000000, DTRR0);
-	__raw_writew(DMA_DTMR_CLK_DIV_16 | DMA_DTMR_ENABLE, DTMR0);
+	__raw_writeb(0x00, DTXMR);
+	__raw_writeb(0x00, DTER);
+	__raw_writel(0x00000000, DTRR);
+	__raw_writew(DMA_DTMR_CLK_DIV_16 | DMA_DTMR_ENABLE, DTMR);
 	return clocksource_register_hz(&clocksource_cf_dt, DMA_FREQ);
 }
 
@@ -76,7 +86,7 @@ static unsigned long long cycles2ns(unsigned long cycl)
 
 unsigned long long sched_clock(void)
 {
-	unsigned long cycl = __raw_readl(DTCN0);
+	unsigned long cycl = __raw_readl(DTCN);
 
 	return cycles2ns(cycl);
 }
diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
index 405e9d5c832c0d41978615a646de21f2fce61afb..feba222b99a813999b087501c3ff677f38366657 100644
--- a/arch/m68k/coldfire/m5441x.c
+++ b/arch/m68k/coldfire/m5441x.c
@@ -154,6 +154,7 @@ static struct clk * const enable_clks[] __initconst = {
 	&__clk_0_25, /* uart1 */
 	&__clk_0_26, /* uart2 */
 	&__clk_0_27, /* uart3 */
+	&__clk_0_28, /* tmr.0 */
 
 	&__clk_0_33, /* pit.1 */
 	&__clk_0_37, /* eport */
@@ -167,8 +168,7 @@ static struct clk * const disable_clks[] __initconst = {
 	&__clk_0_14, /* i2c.1 */
 	&__clk_0_22, /* i2c.0 */
 	&__clk_0_23, /* dspi.0 */
-	&__clk_0_28, /* tmr.1 */
-	&__clk_0_29, /* tmr.2 */
+	&__clk_0_29, /* tmr.1 */
 	&__clk_0_30, /* tmr.2 */
 	&__clk_0_31, /* tmr.3 */
 	&__clk_0_32, /* pit.0 */
diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5441xsim.h
index f48cf63bd7822fd53c33788128f984585c0c421a..e49f1d83a787f51c3666d595a7b753b2a93f64c9 100644
--- a/arch/m68k/include/asm/m5441xsim.h
+++ b/arch/m68k/include/asm/m5441xsim.h
@@ -101,6 +101,14 @@
 #define MCFINT2_PIT3		16
 #define MCFINT2_RTC		26
 
+/*
+ * DMA timer module.
+ */
+#define MCFDMATIMER_BASE0	0xFC070000	/* Base address of DMA timer 0 */
+#define MCFDMATIMER_BASE1	0xFC074000	/* Base address of DMA timer 1 */
+#define MCFDMATIMER_BASE2	0xFC078000	/* Base address of DMA timer 2 */
+#define MCFDMATIMER_BASE3	0xFC07C000	/* Base address of DMA timer 3 */
+
 /*
  *  PIT timer module.
  */

---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20241023-m5441x-dma-hrtimer-ff2f8540876a

Best regards,
-- 
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>


