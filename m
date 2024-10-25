Return-Path: <linux-kernel+bounces-382556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548879B0FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4371C21389
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586471B21B1;
	Fri, 25 Oct 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Y90KFY05"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C073E20C334
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888278; cv=none; b=e8Ex/m+BQ+9K9m8PwfkBprnXX1iOpKfjhHstmz5/0cG+DtXsA3gLRyajsBk1uFGvPR9Gt1zXdU2axM2I4ppViK9gn0py7CtplUDb4q7oIUHF6fJ4MKOylpit5lnOyTf5DaywM/cEoY16wDHDX6KoAiTAOskvRbWKm0xcatCo8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888278; c=relaxed/simple;
	bh=P1IJsmpHB3Q1eJ3SB8SlU+SfAx9yj12DUXfZBRBa8Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CP3w5PVxo6k1KOVgZGNhfjkiSTe3z2X/O6JAFyUj5TWqJrGCzYxSN7MNU/WCwNIJPCIGETki+y1+bvw3J5P2v5c9+0ydwobpNKwLFTcJW2QNnOq8YO2VyprdiYdPTd33NnJVbFXwDxMrmsAjaEOSpYlVMtuK4HqLDdrJFtPqZi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Y90KFY05; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=maiPHQEsP2ZhbgTpeL3psEjH7WhKCr5eiT8qVy+e+n4=; b=Y90KFY05jzQDyUU7
	xjS3IRlUcq+uTRhNhbMHPw7CjfBNe36uT577Jle2bSI3auEj+VQ45ChuW9yo64qRG8nYbtfXS1Ye9
	sYYN6HgkVoG9hsWd0rhdMfj7ewDsH7JZ+jDJ2TVJPK5SbUSfIjJ3ui6LEJX8yIG106c3Asih+NgnB
	3I/hkMyIaN/TM3X8Teax3gE1GKPu1RDgWUSGmeXleCVJchDlFDA7nOjVQ7oBBOFgI7uyWoF94PMWz
	4PB5kLj2kLIV3NJYlhlkej8vOrq1WQO6aaNq0fRu30q8ixnPwYhxqyEt5wJZ9NdkjgGQ3mopdq5P2
	0mRBsTjHuymb366IVg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t4Qxa-00Dbtp-0W;
	Fri, 25 Oct 2024 20:31:02 +0000
From: linux@treblig.org
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] clocksource: Remove unused dw_apb_clockevent functions
Date: Fri, 25 Oct 2024 21:31:01 +0100
Message-ID: <20241025203101.241709-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

dw_apb_clockevent_pause(), dw_apb_clockevent_resume() and
dw_apb_clockevent_stop() have been unused since 2021's
commit 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated
platform")

Remove them.

(Some of the other clockevent functions are still called by
dw_apb_timer_of.c  so I guess it is still in use?)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/clocksource/dw_apb_timer.c | 39 ------------------------------
 include/linux/dw_apb_timer.h       |  3 ---
 2 files changed, 42 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index f5f24a95ee82..3a55ae5fe225 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -68,25 +68,6 @@ static inline void apbt_writel_relaxed(struct dw_apb_timer *timer, u32 val,
 	writel_relaxed(val, timer->base + offs);
 }
 
-static void apbt_disable_int(struct dw_apb_timer *timer)
-{
-	u32 ctrl = apbt_readl(timer, APBTMR_N_CONTROL);
-
-	ctrl |= APBTMR_CONTROL_INT;
-	apbt_writel(timer, ctrl, APBTMR_N_CONTROL);
-}
-
-/**
- * dw_apb_clockevent_pause() - stop the clock_event_device from running
- *
- * @dw_ced:	The APB clock to stop generating events.
- */
-void dw_apb_clockevent_pause(struct dw_apb_clock_event_device *dw_ced)
-{
-	disable_irq(dw_ced->timer.irq);
-	apbt_disable_int(&dw_ced->timer);
-}
-
 static void apbt_eoi(struct dw_apb_timer *timer)
 {
 	apbt_readl_relaxed(timer, APBTMR_N_EOI);
@@ -284,26 +265,6 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 	return dw_ced;
 }
 
-/**
- * dw_apb_clockevent_resume() - resume a clock that has been paused.
- *
- * @dw_ced:	The APB clock to resume.
- */
-void dw_apb_clockevent_resume(struct dw_apb_clock_event_device *dw_ced)
-{
-	enable_irq(dw_ced->timer.irq);
-}
-
-/**
- * dw_apb_clockevent_stop() - stop the clock_event_device and release the IRQ.
- *
- * @dw_ced:	The APB clock to stop generating the events.
- */
-void dw_apb_clockevent_stop(struct dw_apb_clock_event_device *dw_ced)
-{
-	free_irq(dw_ced->timer.irq, &dw_ced->ced);
-}
-
 /**
  * dw_apb_clockevent_register() - register the clock with the generic layer
  *
diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
index 82ebf9223948..f8811c46b89e 100644
--- a/include/linux/dw_apb_timer.h
+++ b/include/linux/dw_apb_timer.h
@@ -34,9 +34,6 @@ struct dw_apb_clocksource {
 };
 
 void dw_apb_clockevent_register(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_pause(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_resume(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_stop(struct dw_apb_clock_event_device *dw_ced);
 
 struct dw_apb_clock_event_device *
 dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
-- 
2.47.0


