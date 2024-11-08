Return-Path: <linux-kernel+bounces-402145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AEF9C246A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2F92859C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E3822460F;
	Fri,  8 Nov 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k+HlvGCX"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A71A9B3F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088133; cv=none; b=skAQVnNnMBd2WjlczEho2d+2MwQRS8DIUHrCuRJnknu8tmF1iQX4g8uUIsSvHxSEnIGT9wpVgvggJipfUnuqQ9I2eIOJcF96TK2xKEXvHHRlJpZ6hQHkmWwOt0ga2Z/J6Cvnk2lcfGz3s3STEvPxABaEZjxIwaT6BtbwxXahJWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088133; c=relaxed/simple;
	bh=mXiHMP//La9C+ginQ4TENC1F1LlUlL0LuRlSUjujvGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyFwWc3wrMgMCWcc8HBNJeEXKCGrDq0lmYgzdMbx6M7tVmeQ3QW5MelzGljcixezT5E0K5d5eQY0FPqLZkNDa6xqo8Cg/riUiy06HqDPvjR79IXXIPT173mEhw1BjsaSl3Y+mD2Hm8rMBCvLnWxZsg8qUStDqr9B7El12VVm0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=k+HlvGCX; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83abcfb9f37so99135639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 09:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731088130; x=1731692930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkhFTRyVD6Ai5buzZVqIBspp22Sj1YPI/QUIN0IDlwE=;
        b=k+HlvGCXXskSa2NLCu01/af+0iaLwfZbWg0QZ9vNah6FPwTDrf8xpWwz6uSBZc0yQI
         /Ee3nF63qQOfdWfzWJ02r+snXnigpvDCwrFXhJHAZ2JZkAav3rgY75AP0lcCeNIdfuGf
         g+TOImhr1PN4SmFug+KvaO3ZhyIqf+UcRaVnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731088130; x=1731692930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkhFTRyVD6Ai5buzZVqIBspp22Sj1YPI/QUIN0IDlwE=;
        b=LQlJwk3cp5pbHGKUjvibxqrZPJTkinpHzwp6W8uLbJf/JHaGCUMhD0/2tm27Ooxtu7
         wVWjwiZTlKEz/j//2or0OLb2L5CY95T3Litn3fI+RTp4ACZdTQARCzPUEE9hRcg4S20n
         rHBsEuCN+09o1mlTY8M1fuPRdS4epmja5/GdnpWi2UKoKdSMpszy460SlF/3MXUkT8Yl
         Sjdm0bp0ZNkZML76Pjz9w4VZep6lld+wrPCYHqm83k3eEVYk6tJ/Pu4eM/bdttktGQjB
         xJhbTshOedBGBR0YS4Xn24ONF8IGRieGtpuJUUpsjFdAe/fVVqRJg8+fxh6TOEBKuwdZ
         CiHA==
X-Gm-Message-State: AOJu0YwhHEMc2q+zFk2xO8UIXiEvrqYZnitw7xl43zfWUCjrocsesjf6
	mdt/OiEzz5F4wE9ugGGTqnK2vfcj8Tv8wpToOfDyH1sXh7zsUsVQ1ND8z32LUqCCEl+9uFJqcta
	3
X-Google-Smtp-Source: AGHT+IH7qp3KyZU76qy5nhetPGEkO2NbGz06FSbdDuJtL6kVE65IlB0C4+J5Zpeicu7VIBHMW2BwYw==
X-Received: by 2002:a05:6e02:1706:b0:3a6:acdf:1a19 with SMTP id e9e14a558f8ab-3a6f1a22195mr46094365ab.18.1731088130471;
        Fri, 08 Nov 2024 09:48:50 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de5f8e41easm918119173.136.2024.11.08.09.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 09:48:50 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC 2/3] tick-sched: Keep tick on if hrtimer is due imminently
Date: Fri,  8 Nov 2024 17:48:35 +0000
Message-ID: <20241108174839.1016424-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
In-Reply-To: <20241108174839.1016424-1-joel@joelfernandes.org>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In highres mode, the kernel only considers timer wheel events when
considering whether to keep the tick on (via get_next_interrupt()).

This seems odd because it consider several other reasons to keep the
tick on. Further, turning off the tick does not help because once idle
exit happens due to that imminent hrtimer interrupt, the tick hrtimer
interrupt is requeued. That means more hrtimer rbtree operations for not
much benefit.

Ideally we should not have to do anything because the cpuidle governor
should not try to the stop the tick because it knows about this
situation, but apparently it still does try to stop the tick.

To be more efficient, check for any immminent non-sched hrtimer event
and keep the tick on if we know such events exist.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/time/tick-sched.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 52a4eda664cf..4aa64266f2b0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -890,7 +890,7 @@ u64 get_jiffies_update(unsigned long *basej)
  */
 static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 {
-	u64 basemono, next_tick, delta, expires;
+	u64 basemono, next_tick, delta, expires, delta_hr, next_hr_wo;
 	unsigned long basejiff;
 	int tick_cpu;
 
@@ -932,7 +932,10 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * force prod the timer.
 	 */
 	delta = next_tick - basemono;
-	if (delta <= (u64)TICK_NSEC) {
+	next_hr_wo = hrtimer_next_event_without(&ts->sched_timer);
+	delta_hr = next_hr_wo - basemono;
+
+	if (delta <= (u64)TICK_NSEC || delta_hr <= (u64)TICK_NSEC) {
 		/*
 		 * We've not stopped the tick yet, and there's a timer in the
 		 * next period, so no point in stopping it either, bail.
-- 
2.47.0.277.g8800431eea-goog


