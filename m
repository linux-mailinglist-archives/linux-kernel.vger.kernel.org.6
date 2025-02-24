Return-Path: <linux-kernel+bounces-528679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A70FA41A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E604161ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6505E255E44;
	Mon, 24 Feb 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CCVKzGbW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4PtCWUJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6D254B18
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392138; cv=none; b=BEqyIunFbFR4eVtCQt5YryqLLiG/5DolbaQSQuyPyyH3nlGIICjIJcyJH7F9ghurK7jFzwoN0h6OTbOgkjGw7Tt71KA8qzlzMjj/c0n5QlAUw2+ElpRPd3LKmdnuMiDkkTOqpTrTcsAxx/S+Rf+mcdQhkvNJmHiy0JOFzXTkT9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392138; c=relaxed/simple;
	bh=z2LcqZOrO+c2z55Y2Ou512MgbA+rp3d9GPeexhEBsYM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=LfPxNfIFp5/r6fbAsRxfWe+MTm2AXlLaQ+AG6kgVqlgIyD7uPrCKY10+0WBfiK/79BJgUKQRK6DsFKSISrAZGJxqJp+vtxTEmMmoLw7oC/PPxl0v8qIxj1w0E1B1ATjLbhATo1eQ01mkCoNpQIOtpTPM/wa8Xm4/efcZiA1kgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CCVKzGbW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4PtCWUJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.476200215@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TgnqdEMmZ/WqLTYhEIxPYDCSyTBkXav7b/iu1bARJec=;
	b=CCVKzGbWMXJ7ILTK2K4HmV8q4LRuBWCnJWNP3rJt9G2XXnTHScbXfnHgIVpFeIFvIFTU37
	7QZ9iyLEfv1iBzq6WapCNlN3Owwif/i32YRg64uPJYLrQeYerDIRMLaEomrP5ukQpX0IDz
	JRUlMJ8ekAuOrLMCPqbirZvJ6aeRrATnOw4NJmK8VJaULV2NDv8OQMdm33MSl5YKE34WgV
	JiXx+CYpZVTBGs/jcU0HbbwG5e341/3xAtbr+OCIsC4cRQlci7n0enjNYFu6QPpkRDMfG5
	UoQsH30nHJdVfUSl2Spx5yiJrVx/eMDdGGohRxrBkVZ+EGUswkH/H0EgxyCSlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=TgnqdEMmZ/WqLTYhEIxPYDCSyTBkXav7b/iu1bARJec=;
	b=Y4PtCWUJAmEUOU5lxznK9LTtRCp1n0dTguuqAl/Nf0Stk1pusSu2OABnYozJx+lu57sqpc
	N67ZQ2hErpUdM3BQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 08/11] posix-timers: Make per process list RCU safe
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:35 +0100 (CET)

Preparatory change to remove the sighand locking from the /proc/$PID/timers
iterator.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -496,7 +496,7 @@ static int do_timer_create(clockid_t whi
 	 * unmodified signal pointer to make it valid.
 	 */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
-	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+	hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
@@ -1072,7 +1072,7 @@ static int posix_timer_delete(struct k_i
 		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
 
 		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
-		hlist_del(&timer->list);
+		hlist_del_rcu(&timer->list);
 		posix_timer_cleanup_ignored(timer);
 	}
 


