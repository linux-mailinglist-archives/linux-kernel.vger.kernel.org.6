Return-Path: <linux-kernel+bounces-208580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F689026F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BC4B26171
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C12153820;
	Mon, 10 Jun 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U91obDz2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UHm0AVah"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F641527BF
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037748; cv=none; b=inke3Wp6wFcVE7u7BCURKk8yNuJOQoZxOzDy82AK3mYwff3GQEwu+R2DgeSEDcfpyEyUkqUZUTHQnPemp6WqSqhlaC27FYjQY7GSjCWitIhBbDAe9LhmN7B9RiZYygY7nMyHGoQkCFDXSmI+sz0Bp9RzWwgLckFs2fLJW3MU/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037748; c=relaxed/simple;
	bh=dqa4y3Sy5EE+IYLFY+hDqiZngky6H6vw41xP99gkF3Q=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oRbwmrjnAxNBnVcEPLjtPb2KPKPe1bcI5t4kXlKufUmdse4Ct2Wq+oySGroON78t6g+BUm+J99VYTOJdJH1pa5fFWXy8p0KvFyQDOxoQkOGWfrcNutVh4faGZQ+Sns/y01qNJXg0xybTg/WfL8wO/KROYjUsF9odNNhM2YunGvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U91obDz2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UHm0AVah; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.426847875@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4hHoBY9MrEXBowGP0DzQQAtC7OGDF1Jxkr/5VDlxgmk=;
	b=U91obDz21B8Sq8Qh+XkgBXNEQA37Wj2rCT6IZnB00VQzm+jIr9miuLo+qE8MVff9SUMEoF
	iJXDQLLQ6YjTeDXg9ThXTUyUF7IEnF1v/h0VO6WUTxjTEbg/OzYQU0aTWmMYV+NvLJsQNo
	qUY5lDVZEn0yry4Y8Nrx0CgCl4Kkw6PMjIgrYSyX4m2jdsPsiXkDlLN9JYLUWbfs3WkuEH
	53Xdr0MpwidmYKQuMtmpnUqV/DkmLhgjKxPif4wDQ/Y/ykkHSx3TKwGLNyVw0oimf+oA84
	1H8lKb11XngZsKp+/6f7+SrR3/1LGeMbo792FcKKRyGsPwwCbQjrleLLztFewQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4hHoBY9MrEXBowGP0DzQQAtC7OGDF1Jxkr/5VDlxgmk=;
	b=UHm0AVahaTPWcbf1+eBHm9ETbkZsQNJ6OwYzyxh544qI+1W51u+ykPOBSbSj5KFpF9MVD1
	EkSgqaHM6A26CRBQ==
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
Subject: [patch V3 15/51] posix-cpu-timers: Remove incorrect comment in
 posix_cpu_timer_set()
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:23 +0200 (CEST)

A leftover from historical code which describes fiction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/posix-cpu-timers.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -689,13 +689,8 @@ static int posix_cpu_timer_set(struct k_
 			__posix_cpu_timer_get(timer, old, now);
 	}
 
+	/* Retry if the timer expiry is running concurrently */
 	if (unlikely(ret)) {
-		/*
-		 * We are colliding with the timer actually firing.
-		 * Punt after filling in the timer's old value, and
-		 * disable this firing since we are already reporting
-		 * it as an overrun (thanks to bump_cpu_timer above).
-		 */
 		unlock_task_sighand(p, &flags);
 		goto out;
 	}


