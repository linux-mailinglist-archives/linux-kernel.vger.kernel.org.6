Return-Path: <linux-kernel+bounces-396083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD69BC7C0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B6C1C221EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD241FF035;
	Tue,  5 Nov 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3A/xdnK2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0K/x4L58"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882E01D63D6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730794474; cv=none; b=uyf8JthdPXbI37EI0wKRuRO+AjcPBFKm6rDrIFUQ/HLqbbKpzA6igEo76j6ubM+qM79hQmlOvSnT65UGaLkM+DJUIEtMhO4+SJxgoXJVNoAj/p6Tja7xPpYA36hox5+Xz4Mj0iUa9+ATf5fhdRIP5cnSby0l+mPSgRDZBW6upOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730794474; c=relaxed/simple;
	bh=d5QhPPnuwFRqvAZPc7n18otmDSMhVsX2cz6TUCAyzCA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OQ9WJjOk7+h2lkz7l+Szde1j+cOgUA+lH+I6PJcTyGEKP7t1iu/Eg+aYyTg41IznGEWfL5Sddt7uNIagCdBu87lv3rS1vdaTb6qXRASHZGccCAlDouTFJlx7i2rDPGc+kKTGyemZfY7mXCf0jT5TVgfwhufOvlsWeJ+nMbMCE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3A/xdnK2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0K/x4L58; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241105064212.974053438@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730794470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=v3QgMEUqhJ+KNqE09QiLEnjnbzGnnD0fCdI08LxtvpE=;
	b=3A/xdnK2E5j2HsHAZnjzUhiQPQ/jx80yleOGjchV/bcbsu5qnk3L85amIEk+4nbahQMzsu
	Ip0oX5CsbuAIqG7WL1xxrkbOZS+XLVUv1Qy+dkfvYAMf3RaKMQB2HuMV3Y5NdBZDMGYkE3
	lT3VFBzmbdKQ9AD23w96qEXu00w9Pm0XzQBt+GqxodBjFgfNxPofxKDGsIxGtXAiIu+OCe
	mwcQK6vCnBKebXWnLd42waR9+ks8NEUEtNlrzVSGsSybxwExaCIaxKW2EsJdZ1LzmrcAUl
	DLF7G22zExXLmAQKH0LV94i6zcsmOLtVyh/JyDEudRdwTaZF1ZJ4YNmNtL3hmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730794470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=v3QgMEUqhJ+KNqE09QiLEnjnbzGnnD0fCdI08LxtvpE=;
	b=0K/x4L58B5XfFD57A7Cm8R8wFOviZbZpdJxYVTbWaWAo5PbPzMIPyE4oKIZmaUW1rud0JL
	QSu4WdJa66avLJAg==
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
Subject: [patch V7 01/21] posix-cpu-timers: Correctly update timer status in
 posix_cpu_timer_del()
References: <20241105063544.565410398@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  5 Nov 2024 09:14:29 +0100 (CET)

If posix_cpu_timer_del() exits early due to task not found or sighand
invalid, it fails to clear the state of the timer. That's harmless but
inconsistent.

These early exits are accounted as successful delete. Move the update of
the timer state into the success return path, so all "successful" deletions
are handled.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V7: New patch
---
 kernel/time/posix-cpu-timers.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -493,20 +493,20 @@ static int posix_cpu_timer_del(struct k_
 		 */
 		WARN_ON_ONCE(ctmr->head || timerqueue_node_queued(&ctmr->node));
 	} else {
-		if (timer->it.cpu.firing) {
+		if (timer->it.cpu.firing)
 			ret = TIMER_RETRY;
-		} else {
+		else
 			disarm_timer(timer, p);
-			timer->it_status = POSIX_TIMER_DISARMED;
-		}
 		unlock_task_sighand(p, &flags);
 	}
 
 out:
 	rcu_read_unlock();
-	if (!ret)
-		put_pid(ctmr->pid);
 
+	if (!ret) {
+		put_pid(ctmr->pid);
+		timer->it_status = POSIX_TIMER_DISARMED;
+	}
 	return ret;
 }
 


