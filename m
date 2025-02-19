Return-Path: <linux-kernel+bounces-521559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F34A3BF30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678437A6803
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DD71F2C5F;
	Wed, 19 Feb 2025 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VysxrqJM"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057DB1EA7C0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969732; cv=none; b=X1/WOeZZaj2fu2u1F3S8+KWZxFMckXKY9vIfqwGwqHghvyyOANozl2k/a/86sWlkGrBuMLxtPhX5x+1g4dOrC4MPnpm57mF58AgYO91RwixuuVWwgCNVoyRkVkzNmriRt/POrdYB9AWcAdWcm4m68I3Ra96nh0pKj75m/urp/Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969732; c=relaxed/simple;
	bh=QLuPInGSc5zXtylSkq0HN/KMtYy4Iqlr4IbFwCsJu5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mlH8nFsx/kpCTrNt8ASRTsIZhSvtOJmoeXIUdqr2fFVcWwTfyBF2I2y+DNsqtv8WSm/m90PI1w4S9k3SwZj1yhMp5DCQ9Ai2TOHiVDAUSIOwsGHXj6sZfKJBV1ZToQ5MGPf4ja4bqlJUhG1BT58CCfMOgeITetZaYNLrj9MATPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VysxrqJM; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-471f1b00de4so60123541cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739969730; x=1740574530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HrQ8DVgfppL9aNYS6t8dxTdjM8ZQud5z1rQs/qyCubM=;
        b=VysxrqJMKXWWM/pXktchxfP8Ol2K+7A7uMZReww9qqfH2Vsk5YZRkpHLYr1G6OXv6l
         ta47as8sxvlvyvZi3I+Uhr7pFLOfjhGyv/m+a2rsRZ7JvmW2Py7EzBg2eQDAgxFGnSwT
         n9dPXu6JK/vSBjr9Urofj9YMuqRkTC+hHEX4QygnhBxI3jJJstyZqPHhg6KJpRDasCdh
         jLISJXLM0DX+xLaEFMcJci6zShEYP2OSAek1IEMoGjzlvUO8LA8L2GRZ1jfN+yMwdwW6
         PlZvpIK5ehDw+jPTmQK134lXiO6IbXH6KlDCZJW1Sx/brYQdaJa08trGDgwuydhsKPni
         v4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969730; x=1740574530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrQ8DVgfppL9aNYS6t8dxTdjM8ZQud5z1rQs/qyCubM=;
        b=WERkCq8PPqugOq0H9RIJjtPq4eNSMVQyvn3RAKeZWAmlkN+hXArvcw7ZLLsNG4WWWo
         sU26zHnpA5/BbN6SonqnVrDGgE6lRT1ylPBnlOl9kbMgAIEaP4bs9RludSAfIOXLgnCo
         AX82MhP+CvrNRihm8mU0/1CYyic9ilJRAiM6bzb3jERWjxJCX1JgAulvOX/O51NxwgPN
         fKqxiQPDTsVYuVzdwCVXnFIafQA/uCFaIVn72fjUBdd6noKNDqup2qcgslMQ7P3jEa4E
         n2ejj+gAIsPhxjIrbbkaO7BCVBy9rELqaWSfbV6o9RTFKbRRyC3qqEjT02+NqL7ubxNz
         HdVg==
X-Gm-Message-State: AOJu0YyezmDOvY0wFQjb2tYSZmZtPLfD4sYMlN2wz5A4hfwZJ3sKVjhL
	X8jXYlYcr2cCRDIWsuRNbz7IxCrnz16bKNee6tHvBsU55hlfwP7sOBSpOe7osVjuC4N22DzjcKB
	YZ/5u3lZS7A==
X-Google-Smtp-Source: AGHT+IG8L92/+/kY+K+afU01nQid/gl9V3DEdxYtHBqm5UumelJoCh8TZfFk4mvgqJcNvZ7RYpiFrEhBPdmeeA==
X-Received: from qtbca21.prod.google.com ([2002:a05:622a:1f15:b0:471:fecd:df28])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c08:b0:472:1225:bd98 with SMTP id d75a77b69052e-4721225c536mr6250861cf.50.1739969730016;
 Wed, 19 Feb 2025 04:55:30 -0800 (PST)
Date: Wed, 19 Feb 2025 12:55:21 +0000
In-Reply-To: <20250219125522.2535263-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219125522.2535263-4-edumazet@google.com>
Subject: [PATCH V2 3/4] posix-timers: Initialise timer->it_signal in posix_timer_add()
From: Eric Dumazet <edumazet@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of leaving a NULL value in timer->it_signal,
set it to the current sig pointer, but with the low order bit set.

This fixes a potential race, in the unlikely case a thread
was preempted long enough that other threads created more than
2^31 itimers.

Rename __posix_timers_find() to posix_timers_find()

Mask the low order bit in posix_timers_find().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/time/posix-timers.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 1f73ea955756..ed27c7eab456 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -72,15 +72,22 @@ static int hash(struct signal_struct *sig, unsigned int nr)
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
 }
 
-static struct k_itimer *__posix_timers_find(struct hlist_head *head,
+static struct signal_struct *posix_sig_owner(const struct k_itimer *timer)
+{
+	/* timer->it_signal can be set concurrently */
+	unsigned long val = (unsigned long)READ_ONCE(timer->it_signal);
+
+	return (struct signal_struct *)(val & ~1UL);
+}
+
+static struct k_itimer *posix_timers_find(struct hlist_head *head,
 					    struct signal_struct *sig,
 					    timer_t id)
 {
 	struct k_itimer *timer;
 
 	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
-		/* timer->it_signal can be set concurrently */
-		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
+		if ((posix_sig_owner(timer) == sig) && (timer->it_id == id))
 			return timer;
 	}
 	return NULL;
@@ -90,8 +97,14 @@ static struct k_itimer *posix_timer_by_id(timer_t id)
 {
 	struct signal_struct *sig = current->signal;
 	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+	struct k_itimer *timer;
 
-	return __posix_timers_find(head, sig, id);
+	hlist_for_each_entry_rcu(timer, head, t_hash) {
+		/* timer->it_signal can be set concurrently */
+		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
+			return timer;
+	}
+	return NULL;
 }
 
 static int posix_timer_add(struct k_itimer *timer)
@@ -113,8 +126,9 @@ static int posix_timer_add(struct k_itimer *timer)
 		head = &posix_timers_hashtable[hash(sig, id)];
 
 		spin_lock(&hash_lock);
-		if (!__posix_timers_find(head, sig, id)) {
+		if (!posix_timers_find(head, sig, id)) {
 			timer->it_id = (timer_t)id;
+			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
 			return id;
@@ -453,7 +467,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	}
 	/*
 	 * After succesful copy out, the timer ID is visible to user space
-	 * now but not yet valid because new_timer::signal is still NULL.
+	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create
 	 * callback.
@@ -463,7 +477,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		goto out;
 
 	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
+	/* This makes the timer valid in the hash table, clearing low order bit. */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
 	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
-- 
2.48.1.601.g30ceb7b040-goog


