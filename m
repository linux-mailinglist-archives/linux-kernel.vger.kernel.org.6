Return-Path: <linux-kernel+bounces-515086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3A6A35FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC2D188D770
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443DB265CD6;
	Fri, 14 Feb 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9pvQvY/"
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C80265CB4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541558; cv=none; b=Kk3DyXWmugjp8hyZU1S4lNA40Qugn1tr9dDIyBqA4QYh1euWTvR3Gawk7BVrkBdlKTlMKKxCCDew++px5owdZS62x0ImChpj0ZqZd6finCeFt3si3TmeMQw4buP2ipdXct3HpIh/wetBu2sPg1EkgyVUgYiRpCo/kvbo26ckczU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541558; c=relaxed/simple;
	bh=eeTZCCgdaqFJ3bnGpZOk2P/FIXNGp94xTCFjKijwb7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r+y4TSKrMnp2IToxqX4GSAd/+PgFAGTiMMagRElsOmiCYf8994XgVAbo3oIXbF2UmDVcwJQHneOCAvZfkydHtR0hlB+stsNTli/S9XkgRHTq/Pe8M8yWvJClw0yXGi+i+SNjiHgDaEKqJpncIC8ATLq8Js7n8kfu4qKbLfR8BfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9pvQvY/; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4ba9a0100a7so405446137.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739541555; x=1740146355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzDdFyfmHOJuJt4qhZZS1RtuCn1nriy1Y4zi8I6ANzI=;
        b=f9pvQvY/0nSCsDpYfrfFS9uz0UrXSKWsIz3jYQ9p650XmQla13cvJBIYy2Rk54UKsw
         kBgD1PcTwCtYq/mCUrCzwddKRHESjNmyW5MrujdMmdxcSIzCB+VHLV+n3B8dhdN/3lz+
         LR47FlEJKDIJZJuMyYmYr/5n2NtFgWaCrgzIXslMVXzUCv//VyUC6+C1pYg9Y4czACXh
         QdszHXXDtj12kjmhK6jfaBcjLbXlptH4CiHwqBqK2Le2oLPnluXPOFhHgBKHNkw0/VsY
         RmqtD9QL6owlYrKmStfM1PnDoZthJW8v4HXBl9d7sKhRTUU2PNvv6gvEeulD7nmNx1+6
         2Xig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739541555; x=1740146355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzDdFyfmHOJuJt4qhZZS1RtuCn1nriy1Y4zi8I6ANzI=;
        b=mDUajxbKuR+2W7X5vGYLpuECq1U+tB7xRjNRuUSqSzS81NxjCcam1RXMuB+M6UprW8
         8e1RfsRrJ+yj7Bgt0BybcbgwZFzki1I6PXAZwe/Pl81+7ShYyX3seUBdJtRH6W71l1Az
         XqOf18nNjjeDQF8uvCyqov/91N+fwFPWNG5DJcRF1bdCS0SLWeZhTUbRoC/H1zt2jmN9
         l5hpYQvBj4aD9IpnRlC1y9jqZymfODpzUgnVav9uLz6JoCkyygcs6CSlElMDVtUE7sCz
         JoT5xHKf7FyfcrSwGHO7bYns+/li7ETqwNkTZSL+1HJJI1qVcUaRLeeHbyiu7PVvANF8
         gFEA==
X-Gm-Message-State: AOJu0Yy3RUf1bpKwcDbbJAI0i+ofrN/+hU15yU2py7S1k4gBDAiGs9+2
	Xa3dQ73lOoS6+TGimyUZwSZ8G7gr9FL99wasZ8ArzxozgumjZDE6E+6bP282B3ComEl3XKwuRAn
	CaazMXRqmOQ==
X-Google-Smtp-Source: AGHT+IFENciHSa2g6hQHsURgowLSjE6iIAIM4cSi0EY4/omVpg5j91N9vZV4rJxmleL8tD6MAFqsjkLhE1cHHw==
X-Received: from vsbib7.prod.google.com ([2002:a05:6102:2b87:b0:4bb:e1c9:70ee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:290d:b0:4bb:dba6:99b7 with SMTP id ada2fe7eead31-4bbf222750dmr9789437137.13.1739541554918;
 Fri, 14 Feb 2025 05:59:14 -0800 (PST)
Date: Fri, 14 Feb 2025 13:59:10 +0000
In-Reply-To: <20250214135911.2037402-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214135911.2037402-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214135911.2037402-2-edumazet@google.com>
Subject: [PATCH 1/2] posix-timers: Make next_posix_timer_id an atomic_t
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


