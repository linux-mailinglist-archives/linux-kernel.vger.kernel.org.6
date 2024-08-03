Return-Path: <linux-kernel+bounces-273524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71F5946A3E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463B61F217DE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38A15444F;
	Sat,  3 Aug 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKjXD72F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="it+iT/aJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7F153BE3
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697613; cv=none; b=hTxbS2g1myUql92MboNa2R20clIaunsSc5G2GXddFqPuh5PY/AjsSyR+DAFmarPrpzhEEv5cZiBntm8t3ZaKC4KTK/rUIRxx3qSXxwMptF4uXrn4g9gKxzPekF05tFtUCqpq7P8KG25sy7THwGBQtzHaEh4mvWZz84rB81tShX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697613; c=relaxed/simple;
	bh=j6eUT3vMa7INHhKN2Rt62eI7QdM0uoo+HWJd5AY2QLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R6Cb216Mosc8i+TZZ69b3OpuLUU6m7up6AOmqUAYuIL2LTODKKqb5fbR894nEh60xkZ0tM7PoJ+ykS3XpnP5wRs6kylZL+pResg2+FAX3Z4Iz8BTogvAVKrvZLqYs1ZOwfqUd1uLrPA9xE1sdfzDoGF5p1zYhP14PJqGG3hwwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKjXD72F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=it+iT/aJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722697610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RXzw64cuXijvTqTTPhYLyITFgDzXlMYaOHmo2Dq7DeU=;
	b=WKjXD72FI/oGga3sG9wFX7Vc8piB3d++6rxfznHriEQB3h/MuSmKIrx37uMDvAtkBbqxka
	N8yDY+mRdgu/C9L3LasWAaWO7sZ3n1o8bSv1Jk/UHEU/x4hvqPEN/NKS1fCDxvu+VMoqlJ
	+3RvBdyRLsEC6risW0YGXP0uHOzT4mhVTmPRfeUP6ohBVpM4w2Ewpq/epY5O725pbnJs2M
	Nw9HjBsaPO3b+8N5M/STXpCeR/xiXmvs0v4lqSQtgmPEPvebZ8BqsfeaFdZeuH6XJbrB0V
	Qy1tPl2LfA7cFMr+gJDem5Wmf71ft5JX30MJUPEbTTBwE6CeZxnB+LhUduJ5Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722697610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RXzw64cuXijvTqTTPhYLyITFgDzXlMYaOHmo2Dq7DeU=;
	b=it+iT/aJ4+4mzLln/5Kp2iXOv5wQsD0g43A2CUL4DYPeyQVcx6J6boOlaJDz4lpEZ5Vodi
	jMMXFwfdc9ceXSBA==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Cc@tglx.smtp.subspace.kernel.org:John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] timekeeping: Fix bogus clock_was_set() invocation in
 do_adjtimex()
Date: Sat, 03 Aug 2024 17:06:49 +0200
Message-ID: <878qxd7iie.ffs@tglx>
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
 

