Return-Path: <linux-kernel+bounces-208571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352CE9026EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AC01C20993
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A3E14F9CD;
	Mon, 10 Jun 2024 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JQZPudCM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38II87pf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363981482EE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037741; cv=none; b=RD1tu75idrYH1x6tTGmiYhh1uJbpJeq3AdGmWvxg9T0C8Wk1cg3RdPY/tHtyv1U/Q09FrKV34sQyyThd3xhr8CtgzqYnkVNU5mD6ErStypjGEPZ1ZOk+3FvWc8C3GnN/Aed9RMRKmf0OIVb3PMVigxOcBmLCH4xTrz/Rl/gYD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037741; c=relaxed/simple;
	bh=gUItmgDH5rsS1e6yVmaYPpvSzF4y549YIibjLNxq98E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lEMfoyZDKLfOXbJwPgCfLFMJteUdAGIuR8MiDUgnM3C8EpMfugLMQLq4fFlJ76yaAX1cLcaBdqZnGvE5adyO6yQqPXxrJUlPCav7o8Bn0yYe728P3bMpImGkCPLUnX7G343QjbIdFvx4mQTXZnH/pJkPEIdmbUcPP/QPLWG4XD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JQZPudCM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38II87pf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164025.971657046@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AfHYSU/HugM7h61r392aP8dR7dmyLHuDBcUa2xZEhTQ=;
	b=JQZPudCMNolibX4vURulBU39MhGyWu3HXCZHw+FyLSu2rJjt3v0EFcAeQrbMEV6CH5XhPA
	aQpAtZagWpZ2YLcRWz/jd1EOgNKDhFveJ/IP0B8EBQDLrDf8271t5W2cdwQRN/xePxjLiD
	Oj/vt9/0QwzS2luBqHZYegq88UrQRXddfcMvSkzxw9II8Hu8q/JCqdO0+EwLetscpr+EcZ
	NqCVHHQGsnwxGZAf17vThiezgLOehoy4iBqimnFaZed00y2CAotgm0IT5WsaWRBuJBWst7
	IecLSjlXGvj2UINgr2Vuc+A+8P+g/z9ybTnlGGQ/CS6H7PdtEDvj4bWVsr6yQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AfHYSU/HugM7h61r392aP8dR7dmyLHuDBcUa2xZEhTQ=;
	b=38II87pfUGOm2DJSi/XlcrNEwOiFG35nAjbqtztPqdpqv3MYV3AUF8UiABpvO97g7LZ+4U
	L2H6rU7kIN6OFaCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 08/51] posix-cpu-timers: Save interval only for armed
 timers
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:15 +0200 (CEST)

There is no point to return the interval for timers which have been
disarmed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out into new patch to make review simpler - Frederic
---
 kernel/time/posix-cpu-timers.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -809,17 +809,15 @@ static void posix_cpu_timer_get(struct k
 
 	rcu_read_lock();
 	p = cpu_timer_task_rcu(timer);
-	if (p) {
+	if (p && cpu_timer_getexpires(&timer->it.cpu)) {
 		itp->it_interval = ktime_to_timespec64(timer->it_interval);
 
-		if (cpu_timer_getexpires(&timer->it.cpu)) {
-			if (CPUCLOCK_PERTHREAD(timer->it_clock))
-				now = cpu_clock_sample(clkid, p);
-			else
-				now = cpu_clock_sample_group(clkid, p, false);
+		if (CPUCLOCK_PERTHREAD(timer->it_clock))
+			now = cpu_clock_sample(clkid, p);
+		else
+			now = cpu_clock_sample_group(clkid, p, false);
 
-			__posix_cpu_timer_get(timer, itp, now);
-		}
+		__posix_cpu_timer_get(timer, itp, now);
 	}
 	rcu_read_unlock();
 }


