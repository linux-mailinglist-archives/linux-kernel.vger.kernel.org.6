Return-Path: <linux-kernel+bounces-521557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85167A3BF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80514179182
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9191EFFA2;
	Wed, 19 Feb 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kko0haXA"
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E481D6DC5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969730; cv=none; b=l+lyoCCz//UYyD+RV2XxsO6zESHHfGhdw8rNHkenmzSwFYVpRBqiSMR8wJNr6N6wI78RMNRQifvDqpsBoCfOSms7wzxOq3Fkab2et6sY5VE+h8Pjzb+ROo2MEE4auuoPBWxPoCjiWNsbisQkYdr74/lYfBgNF+RKNIrPZLGMbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969730; c=relaxed/simple;
	bh=eeTZCCgdaqFJ3bnGpZOk2P/FIXNGp94xTCFjKijwb7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCgLiXceEB4psbUk6mNbTre/O0QEclnq+ZEBTsiuXDQ7njPiZA3Rxdp/eH4kRQY+Of/29nvU06x9+OfibNdeH+kxSA2+YAwVpxjLzbOB2NFJ62qovgB9/VGt12vIYTxQZ2Fef3KggKE57/sitJ9UV3EMI5Hi8xgy1Pnb7EqpvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kko0haXA; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b864496708so2073469285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739969727; x=1740574527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzDdFyfmHOJuJt4qhZZS1RtuCn1nriy1Y4zi8I6ANzI=;
        b=kko0haXAbtivy8tOBBJlNo8aIi64ZNjC/sSUHaIVtvksPB67r3KPfGBU8Np/ELu6t2
         ohce2a6x4b0suM1hP0VSTHSkmJlGjHr4/FR9lTfkIPIva3F9QlCFNwAuVFUVGuqBlVjk
         g5DJNpf53+p4kJ1AJDC1o4DI8w8TkFo9khdtqJZ81XrGb7psaumNI3GIKxgD2tU/V/0q
         7ZTsfdJMUMLHrPa11A5nrMjb7RYxFbXCtMBERCZzXM8Kfl16FEmKvp7+uRpxaaP9x/4m
         l2qiX7XMPh4rvQFXXEAfhKYuaTHJQ/N3ss8j7UEtCMzdsMgPkd39Iaxy7enBfxaiztda
         hGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969727; x=1740574527;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzDdFyfmHOJuJt4qhZZS1RtuCn1nriy1Y4zi8I6ANzI=;
        b=tU0DNfqDqqHsuLuTqYkpyErznjRCXvU2Aw+ic9wh85HHH+xnzKOtNBkDYa0iN+XV9J
         gaCrZPoV8okHR0iWAhOYT8SoaTbBTk9g11a4cMLVhpq48EcSOZOuMcRJNBwqp06+KwUw
         kqKuI3o1ovVH7aQDp4S2dU4cUKi7Zhc4DVTVcBp1m0jwwmbJMzUQILcDAyFOJM/GceYI
         udTz2U8NNxnZALSLYs/V81psUmwy+7EUYwiDHIXCqnkrMBL/DkfMybIKClXhPprPVdsj
         USpmGuPp2U7fQqFtVBP9id77QGnsp4CJCAAshPEJZ7a/5squyykSeR8vo01vFO05o9sb
         pnNw==
X-Gm-Message-State: AOJu0YyEa05Uka3ALIzeAyxk27/LTVa8wKnjNmJn2xfj6o72Swy1tmtg
	RrW30U6bKs93+WJkGHqltEjavLuoV0z5UGt0QqWTDjpi92nx55XBGNZLQmAL9ABhkxzOV05Eju5
	WKt/y3ycm3g==
X-Google-Smtp-Source: AGHT+IHCyPuA21x22mhemB0CjAcK5OZqSXzGjRnCiufJfTH4Nk4Lgn+bj7sWSPXQSbeJQ7hTT5dphid9tQG+AQ==
X-Received: from qkdd16.prod.google.com ([2002:a05:620a:a510:b0:7c0:81e3:4f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:640b:b0:7c0:b018:5938 with SMTP id af79cd13be357-7c0b0185e03mr923164385a.7.1739969727418;
 Wed, 19 Feb 2025 04:55:27 -0800 (PST)
Date: Wed, 19 Feb 2025 12:55:19 +0000
In-Reply-To: <20250219125522.2535263-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219125522.2535263-2-edumazet@google.com>
Subject: [PATCH V2 1/4] posix-timers: Make next_posix_timer_id an atomic_t
From: Eric Dumazet <edumazet@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on a global and shared hash_lock
to protect sig->next_posix_timer_id, make it atomic.

This allows the following patch to use RCU.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/sched/signal.h | 2 +-
 kernel/time/posix-timers.c   | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d5d03d919df8..72649d7fce2a 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,7 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	unsigned int		next_posix_timer_id;
+	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1b675aee99a9..204a351a2fd3 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -105,13 +105,14 @@ static int posix_timer_add(struct k_itimer *timer)
 	 * a plan to handle the resulting CRIU regression gracefully.
 	 */
 	for (cnt = 0; cnt <= INT_MAX; cnt++) {
-		spin_lock(&hash_lock);
-		id = sig->next_posix_timer_id;
+		id = atomic_inc_return(&sig->next_posix_timer_id) - 1;
 
-		/* Write the next ID back. Clamp it to the positive space */
-		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+		/* Clamp id to the positive space */
+		id &= INT_MAX;
 
 		head = &posix_timers_hashtable[hash(sig, id)];
+
+		spin_lock(&hash_lock);
 		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
-- 
2.48.1.601.g30ceb7b040-goog


