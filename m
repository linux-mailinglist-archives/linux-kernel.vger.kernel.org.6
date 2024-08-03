Return-Path: <linux-kernel+bounces-273523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC3946A3D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88ECAB21142
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C30F153837;
	Sat,  3 Aug 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwAP1SsY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VUxQmzTY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058E15382F
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697542; cv=none; b=mJKzVu2UgqJUbsWY/Yl0e+ZkdhOU6j9NoX4Wq620AWtZXDktG3IIrwpsueXR7N0GpLLuoY8QNFJt4GL6SeOvfdvngOydfTf9wk3c2dHouKrKP3ebct5HTn1wS8hTi4IB6yfqwfhKSXQ9WW5WiGWqbcHru1TJxo2jIzT0h1obVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697542; c=relaxed/simple;
	bh=j6eUT3vMa7INHhKN2Rt62eI7QdM0uoo+HWJd5AY2QLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QKlYTMPUC2w5fFd7tia65HNULsdkI0vDxDjL2KMcQF8ZXAGo9S2bNM8fb5Lux+fxmQ2Y63Lh8FFOFDdfnK9JGk3Lz/pQI3UQ/TkP9k62Epjw4YTefxnrcgGXU37DepDN4zXIx9n8R1I+rBY1YAAuCjU8kYYGXDsq+xQwEihm/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwAP1SsY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VUxQmzTY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722697538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RXzw64cuXijvTqTTPhYLyITFgDzXlMYaOHmo2Dq7DeU=;
	b=NwAP1SsYkLxoBPOd6uTSnNJpD2XSzHcDwCA92NSq2KoH4U4g80D8Tc3kyrSHe7EcD7wyZt
	AyzDTE3PSrE9a2gljxkmyxcv4Mrsr3aTVEROZ6e/bXz/vm7ddLfRWl11gdcAc/Xr4r0pwt
	+TMgXoZgl8/KdRWZ3innknkvK7PPoGIFKXoK9r6gRiiJ+Efu2AYk/gCxn9ijh2n//5BJkF
	caUgShXmFAsbMs34vcFc/mB+K7iDm4UJ81i+D2cykm2jwqi4wymu+MAS5Z1cmPcAdaSy97
	hfY0gDf7PHjs/Jf6GNepijUSeLC1OXBpPW1v7xEaVXYxNFnX3vfHcKK7lUPX9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722697538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=RXzw64cuXijvTqTTPhYLyITFgDzXlMYaOHmo2Dq7DeU=;
	b=VUxQmzTYDA1yqmfsjkxZl8BIjPqBA7DLYU3ZZgUFWrWNguHUkkr2UdA2XJ7fVvc7OOfItu
	vXZi3eHUjM5K1WDg==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Cc@tglx.smtp.subspace.kernel.org:John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] timekeeping: Fix bogus clock_was_set() invocation in
 do_adjtimex()
Date: Sat, 03 Aug 2024 17:05:37 +0200
Message-ID: <87a5ht7ike.ffs@tglx>
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
 

