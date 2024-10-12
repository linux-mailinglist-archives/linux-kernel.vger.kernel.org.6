Return-Path: <linux-kernel+bounces-362541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735C99B61B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA971F2211B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F0754BD4;
	Sat, 12 Oct 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pg8/nAhK"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDF726AD0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728752150; cv=none; b=i8/RMuIwpqf5zMDNvRL+8Xh4p7XTwjXje9zqkOSXYq76bQNI8N8KySYV8jMAWthHW5hRGiWl0vGlQ3kAdnrTzhQfaXxNVYi5wRyBHMytP4StN7/vL/r7uENNK4SDH/EZbqmYnmoDdITl51xSj1MOZm8JghisdoMhyrgoxKUtBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728752150; c=relaxed/simple;
	bh=IvfIGSE5Zhzl9MNMGcYJyKUIosKcosBlDvU3cXoxKN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MxlLWxOSRDPGYQmDPzuWP1o+bSUAtAS2ZU9j4I9wgG7gtzk+Rpa5Dz7BuFFwrQLoyh1mEx6hIFLxPozY8eIP7dvYVYFphZxxFY1ydENxi+Q2XsGmsZ2V30Y0yHyOXIh36VPqKHfOFRix66Wh/lSNa96ANKlcMStFo30rZMWyuG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pg8/nAhK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370d76c15so6414767b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728752147; x=1729356947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLmChewCB9yi9IONVK995ficZfEp2BUT5dzahzhUryw=;
        b=pg8/nAhKUtmRBeKOLXYy/OLXFAsvaGc7F3oxApPcyAXpAYlbAgRP/i6lpImVYX7NUW
         pv6i0KymRaV904Sjdmtp97iE79AJUuBKqPK/XXQ3VrCbL5ABOytfWxZ6rZFXsEI+IZ1H
         gchr8wN2XO2FDANSGb5uyPyXwHMenB6JRYZtr8KdR62xfp1vACrGPyER8N/LpPHXoiyT
         TkuPp/EdJqYaeJeOZMiG4rKtMsFl9yUvyvFZmcc+hTkTEy0w3Uvssx4HgmaeRb59gz/O
         C4QcaQmF3p91Dxzc2xlVB8XIqEj28fdNXlGiBC5d6aeuE8QQ61zSYK2T3l1uVXmgtdXW
         /x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728752147; x=1729356947;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLmChewCB9yi9IONVK995ficZfEp2BUT5dzahzhUryw=;
        b=Ae7DtLp0poL81j61+2ztK7Hga7l5aNMBvAYuIko1JHFZ4lK45uzk5z9d5j3DCqeb+y
         /M+tQo2SUiNXmER2tQxLTEFREcHv9KfYTtvup0Bh3hkfaGretS46+p0i0o5NC111x1lG
         CQfvyZbNZi7+/xHSlnfjx0gl0VhjwiYWAH2As1rA58I+HPEpWGDh0SUyeIH/d6BDnlzH
         kiSf/n8BnB2+Nr/rqFdID6zSLMgxmEUxTPWDvgvq3GshoFhRUiosc62wMdluo8LS0bCp
         nUDRp/7ZEoRQD+STfve0nFZd9+CRAIPQeRBOaupfnbFS2PtB4yjKw5O16O+405jSuh5m
         4eZQ==
X-Gm-Message-State: AOJu0Ywj0sxVDCp1omL0Dfsgf/CdmeXAaEA4ALkcwjX1HD2iK8JgNrvw
	yAnan8j2R9wVvZ4p/akhMUkwShlv2KTWfK1ERJFbKs1NNjq75J2ksQycAiGlCF9gZfaTk6wadoa
	wsT70pHUZJpVBBV5KQ10wJUhp3q7qq6G6l+e7AsxzLS5jGfcbEQxjiDQ/r3VuWDH9Ux/AX0EYPt
	OfbB7yS4aeX+wAKfBtHQWLskJXhWcbR44afVsoLeKjPAUz
X-Google-Smtp-Source: AGHT+IFwP1k62dgavCK1OcxQ5vmFalqXpIiuuGeHntYK9y0hAL/FOPStxsggjRe1WBmEXjQERodCCrvhBkA6
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:4383:b0:6d4:30f0:3a74 with SMTP
 id 00721157ae682-6e347c61126mr242597b3.6.1728752147203; Sat, 12 Oct 2024
 09:55:47 -0700 (PDT)
Date: Sat, 12 Oct 2024 09:54:37 -0700
In-Reply-To: <202410121433.jYN4ypTb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <202410121433.jYN4ypTb-lkp@intel.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012165523.2856425-1-jstultz@google.com>
Subject: [PATCH] locking: Fix warning from missing argument documentation
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Metin Kaya <metin.kaya@arm.com>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

The kernel test robot complained the commit 8d8fcb8c6a67
("locking/mutex: Remove wakeups from under mutex::wait_lock"),
currently only in Peter's git tree, didn't update the kernel doc
for the new wake_q argument added.

So fix this up.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Metin Kaya <metin.kaya@arm.com>
Fixes: 8d8fcb8c6a67 ("locking/mutex: Remove wakeups from under mutex::wait_lock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410121433.jYN4ypTb-lkp@intel.com/
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/locking/rtmutex.c     | 2 ++
 kernel/locking/rtmutex_api.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 8ada6567a141..c7de80ee1f9d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1680,6 +1680,7 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
  * @state:	The task state for sleeping
  * @chwalk:	Indicator whether full or partial chainwalk is requested
  * @waiter:	Initializer waiter for blocking
+ * @wake_q:	The wake_q to wake tasks after we release the wait_lock
  */
 static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				       struct ww_acquire_ctx *ww_ctx,
@@ -1815,6 +1816,7 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 /**
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying RT mutex
+ * @wake_q:	The wake_q to wake tasks after we release the wait_lock
  */
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
 					   struct wake_q_head *wake_q)
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 747f2da16037..2bc14c049a64 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -275,6 +275,7 @@ void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
  * @lock:		the rt_mutex to take
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
+ * @wake_q:		the wake_q to wake tasks after we release the wait_lock
  *
  * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
  * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
-- 
2.47.0.rc1.288.g06298d1525-goog


