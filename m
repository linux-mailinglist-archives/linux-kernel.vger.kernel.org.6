Return-Path: <linux-kernel+bounces-273526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CF946A41
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A777A1F217CA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB7C15444F;
	Sat,  3 Aug 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gdhT7jzG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QG8fPnl2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1931EA73
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697674; cv=none; b=cZxn7yQe+CuG5Q7de2azlVI+y6s55AEIjtU/6ayb4Sn/hI7b81l9/75VbK1ojQdwqnVyIlzt8UvFCKgb2TpVcADvXo2ruTsjpqN4CHeUvdzbj+nC/a/CZuJEIOLlVUKSr6j0C6iZ59MbzuBR47erRmrxyYIKoNx9cqciSCiYn8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697674; c=relaxed/simple;
	bh=j6eUT3vMa7INHhKN2Rt62eI7QdM0uoo+HWJd5AY2QLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hf6lpepP7wm5qVBNIvrrR+G7oAshdKa1m3o+mUsXNn/GYU7b+mGj7mO6WCf0+9r2x5aAQcsUnNiJ5Oj//+M7twZlT0onK4LnYo2ba6tI9ekWK7GQ6eKrrYv09H8xSxPim9TLRHv7p4dhjrEI4EDNq8haPwMff6K5bEvfmS27kMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gdhT7jzG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QG8fPnl2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722697672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RXzw64cuXijvTqTTPhYLyITFgDzXlMYaOHmo2Dq7DeU=;
	b=gdhT7jzGyks9Zbn+F6/G9rnHCj7EbOvKjWe9wr3P31F/HOL5DgUg5DdNjwmgWx7FBhy3KC
	MNU+rTAvpikcCBNW2R//DP69cLzFmhRpalkzdKZxYZVtPKcvoOD/UXAiNGSj5Z7nE+kbYm
	4/P+kfF1cRCSWiR+8fCdcTo18s8BHNEMAUMoR+2sPh1yJddbiSxzEKxXmxlJofiCpTfkIf
	deWYaYzGQwc2ssTXa/XSP/CUBEyHLUhV7RyLVWTdVOz8TZtT0A85yuaoNduA22fbHmvuz4
	R/VplZzCkaGQgk1ldnGsapbdJKRT8lmcGMZvDikU1vHWymGzhNczyBiVr5icJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722697672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RXzw64cuXijvTqTTPhYLyITFgDzXlMYaOHmo2Dq7DeU=;
	b=QG8fPnl2S7Cw8p4Nx3CrKyWO3czFYKW1sKxd2V3al70HtFfksZ90zboJxMfmqV3tKjz3Vd
	YZrENvYGwSkscLAg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>
Subject: [PATCH] timekeeping: Fix bogus clock_was_set() invocation in
 do_adjtimex()
Date: Sat, 03 Aug 2024 17:07:51 +0200
Message-ID: <877ccx7igo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The addition of the bases argument to clock_was_set() fixed up all call
sites correctly except for do_adjtimex(). This uses CLOCK_REALTIME
instead of CLOCK_SET_WALL as argument. CLOCK_REALTIME is 0.

As a result the effect of that clock_was_set() notification is incomplete
and might result in timers expiring late because the hrtimer code does
not re-evaluate the affected clock bases.

Use CLOCK_SET_WALL instead of CLOCK_REALTIME to tell the hrtimers code
which clock bases need to be re-evaluated.

Fixes: 17a1b8826b45 ("hrtimer: Add bases argument to clock_was_set()")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/time/timekeeping.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2606,7 +2606,7 @@ int do_adjtimex(struct __kernel_timex *t
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set(CLOCK_REALTIME);
+		clock_was_set(CLOCK_SET_WALL);
 
 	ntp_notify_cmos_timer();
 

