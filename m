Return-Path: <linux-kernel+bounces-552635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE0FA57C23
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1564E18915D7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA176214203;
	Sat,  8 Mar 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dm73b3UJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Wo6uJ4g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CB2135B5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452527; cv=none; b=s8dRn72CIjlL/R1/DWOAK8p/fvPC8El7plVANcRli1SMUrkRII9g//5sIN9VBzjqAv8wXS/Qw5Q4aRQj6KL5jsat20f24LqZp0thnC+H8+CreJBykUDwLwTVE6jQLooBxKL22ANwtmPYnHZnrkPivpVbSJ4oRqXCtCVQoURBMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452527; c=relaxed/simple;
	bh=xrw28x75dV9mWlVJTIBGY8ufeGt1CIsJt1X57Uiqwf8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=uDTAP+wkd1OXQhDu6YQ1kCLPp40rAtFtKNP+3kUwr613C4GxT93jtB3UWD17/bLa+nfqGC7idCrjKh123yNHOqGT0iKwcJzVEuXXUMdYUaEBt+lLZdZNlYUxbs+pQFtFGgxHfRUQO4giHJK7OD8Cglyz/OOyxfWE2T/LwcHEQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dm73b3UJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Wo6uJ4g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.403223080@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VWSKY1Cn7k9ladpPLF+g4at2C4cmmfpJ9GlzmcEqQkc=;
	b=dm73b3UJxmRk/X3PBRMHE7bTFGveq47pPzh+yU+vAx+G3MWbFQRNVz0RKRns/SSlwedA9p
	rgTnVMuXkXU+1RCggiRVWn6LjoOW88phRPfqIp3nfW4jSxyfxidOpmgi7/nq1NtLZES/do
	8rrxu5hupL8d7B8Lc9W/dbi45s7Ku8ToBOKUY9iHJF7rJXwXoZvUrFF/g7z+YFfr/AO5tY
	v9OXYYscoCmbxHV9XZF2VcP3Z/dleAViWPsie2dY2W70esJqDkrTHYJnzq/R0Jmz+IYj01
	g6wXERa27/f4zHdJgGxNpXS3IrJTYxVJ8iC12AwPoaEMjuKk6a8OwuEfhAUP6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VWSKY1Cn7k9ladpPLF+g4at2C4cmmfpJ9GlzmcEqQkc=;
	b=9Wo6uJ4g5Ge+OtjmgE4umaV68ErwmEe9bBNDVbj0srhaOMnCcwQZToZS0eV76v/+LBqPSN
	bdgssfjdVQB+xJAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 15/18] posix-timers: Make per process list RCU safe
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:43 +0100 (CET)

Preparatory change to remove the sighand locking from the /proc/$PID/timers
iterator.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/posix-timers.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -518,7 +518,7 @@ static int do_timer_create(clockid_t whi
 		 * Store the unmodified signal pointer to make it valid.
 		 */
 		WRITE_ONCE(new_timer->it_signal, current->signal);
-		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+		hlist_add_head_rcu(&new_timer->list, &current->signal->posix_timers);
 	}
 	/*
 	 * After unlocking @new_timer is subject to concurrent removal and
@@ -1004,7 +1004,7 @@ static void posix_timer_delete(struct k_
 		unsigned long sig = (unsigned long)timer->it_signal | 1UL;
 
 		WRITE_ONCE(timer->it_signal, (struct signal_struct *)sig);
-		hlist_del(&timer->list);
+		hlist_del_rcu(&timer->list);
 		posix_timer_cleanup_ignored(timer);
 	}
 


