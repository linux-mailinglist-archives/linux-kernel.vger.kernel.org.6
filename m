Return-Path: <linux-kernel+bounces-395190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A84489BBA26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF11F22B06
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8861C302C;
	Mon,  4 Nov 2024 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pr/dd4B8"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9D20326
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737166; cv=none; b=kqgoEeFn7I65C6yRSQH+SDe8eoW+qeRUeHGxOMKVnEhRf7eRK1AlvfZatSrqAuLzmIhPZ8Btm1NulvnDDwJzRpUHw6gQTc+I4yYEjkNM/FQAw5hoEClnhYZtNoo9tZg2h00Z2LCT9a5ZXKrnyZrkkGCNFzyYhHDn5XYPtH723s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737166; c=relaxed/simple;
	bh=jrqYbfU3kLXg9TCUgNlKmrq3XYMv2tBzcgkY+v0BBsw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r811A9m5LbXHGc/bum3FNZkskwPShxSRcIFxerxciIRfpvEFkQonTD3BLQwayKwY7ljJSAhvGdCnWW7iyheLDpZCux24aDOnKbSTSeUIxk2MO2pgpoag/GUeyx4iSr6spBGD5SnMFy9GuN6qzLoPYPRi78YAMeJ4yIdxqt+0thM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pr/dd4B8; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a99fc3e2285so293339666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730737163; x=1731341963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N1OEU5djaBFZZONmKjr46m7cvs5PfysB7luuY22l5uM=;
        b=pr/dd4B8Aq63gl1DyRELObW0x0OFulmYkApPxerafpz9NMEG5oKpRbfWfXT3BEcc+L
         41O0ov7eNgu4j129buAYq0nfpxkMn6aOwDD3/JE0JPnEdxG6xMtcvm0fXGH+6iYgUlHl
         n3xm87OVYHmqL+H+5sqRYm8OW17fSX8PGcfwX0/pL3G+tzT3HEe74Y2z0reb0ZK1u2r9
         AOGZIRVsyVTSKzrHBAHxk59fuAUywpUJdbjmIY9eLI3HAY120Mjzsrdo5TByJJq9bzTq
         jCYhe3wHn8qRJ8cm+41DlKK+jyfvQEzJnw0e8Z7K6UZ+ppQNAWEl+lzQo558pf0XLxfI
         gPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730737163; x=1731341963;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1OEU5djaBFZZONmKjr46m7cvs5PfysB7luuY22l5uM=;
        b=cuN14WIGXAikl6xJJQQ7g4OZBzwmNnPeKhh8Zmo19JD1IB5Um5LprZ6cQmNtqvM1s4
         FQ4lHANW/q78GRmknir90ol+9bVyYw7aGS/5QC0huJRqW4J7FbQuPzNvogvtwmG7oO+k
         z9TYrrOAbMF2Fc/754MUbTOS7W06K+NotwTF5RS33RMyZ/US+3EnLqtJjh5HFrengfzE
         ybyfOXS8h5QbW3/CNwatPBxYI8i7b7TvOqp0hbMixbX7J+D/9gMqrV0VYoPumgo0QNEA
         oropp1fG/qVBKBuw9mTXJW7scOkW+PjVvU1/ek4Aw8qr5r7NRXYTor89hEN5oV7wrgK5
         iN0w==
X-Forwarded-Encrypted: i=1; AJvYcCUGlWpDKVlO6l+QjYHHDbt3phx06uqaUmByrskiSj4mjp1yxiF+h1IurJxsraDEVshAFoZkTB01IClpiUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywfg/PqnDNyE7TtIQVnueI4Lg0UEL9ftazbTlQd+wabk5wmQgd
	Sk1zeMoOlrYeWp1hqlbh1g0N2+xT/z/3N4HnlY7o7dZVwI6Hiu53bOG2U94CLc+u36eUA+enjA=
	=
X-Google-Smtp-Source: AGHT+IEemdf5ls1qTr+1lYgf8rD4PrkRvDN7i6rkhtM2PSQmFvVOwUVEKALeEWFcTD8FNAC3A4HuuJL+Sg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dc4d:3b27:d746:73ee])
 (user=elver job=sendgmr) by 2002:a17:906:1753:b0:a99:ec71:a131 with SMTP id
 a640c23a62f3a-a9e50869b05mr391566b.1.1730737163168; Mon, 04 Nov 2024 08:19:23
 -0800 (PST)
Date: Mon,  4 Nov 2024 16:43:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104161910.780003-1-elver@google.com>
Subject: [PATCH v2 0/5] kcsan, seqlock: Support seqcount_latch_t
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While fuzzing an arm64 kernel, Alexander Potapenko reported:

| BUG: KCSAN: data-race in ktime_get_mono_fast_ns / timekeeping_update
|
| write to 0xffffffc082e74248 of 56 bytes by interrupt on cpu 0:
|  update_fast_timekeeper kernel/time/timekeeping.c:430 [inline]
|  timekeeping_update+0x1d8/0x2d8 kernel/time/timekeeping.c:768
|  timekeeping_advance+0x9e8/0xb78 kernel/time/timekeeping.c:2344
|  update_wall_time+0x18/0x38 kernel/time/timekeeping.c:2360
|  [...]
|
| read to 0xffffffc082e74258 of 8 bytes by task 5260 on cpu 1:
|  __ktime_get_fast_ns kernel/time/timekeeping.c:372 [inline]
|  ktime_get_mono_fast_ns+0x88/0x174 kernel/time/timekeeping.c:489
|  init_srcu_struct_fields+0x40c/0x530 kernel/rcu/srcutree.c:263
|  init_srcu_struct+0x14/0x20 kernel/rcu/srcutree.c:311
|  [...]
|
| value changed: 0x000002f875d33266 -> 0x000002f877416866
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 UID: 0 PID: 5260 Comm: syz.2.7483 Not tainted 6.12.0-rc3-dirty #78

This is a false positive data race between a seqcount latch writer and a reader
accessing stale data. Since its introduction, KCSAN has never understood the
seqcount_latch interface (due to being unannotated).

Unlike the regular seqlock interface, the seqcount_latch interface for latch
writers never has had a well-defined critical section, making it difficult to
teach tooling where the critical section starts and ends.

This series introduces an instrumentable (non-raw) seqcount_latch interface,
with which we can clearly denote writer critical sections. This both helps
readability and tooling like KCSAN to understand when the writer is done
updating all latch copies.

Changelog
=========

v2:
* New interface, courtesy of Peter Zijlstra. This simplifies things and we
  avoid instrumenting the raw interface which is now reserved for noinstr
  functions.
* Fix for read_seqbegin/retry() found during testing of new changes.

v1: https://lkml.kernel.org/r/20241029083658.1096492-1-elver@google.com

Marco Elver (5):
  time/sched_clock: Swap update_clock_read_data() latch writes
  time/sched_clock: Broaden sched_clock()'s instrumentation coverage
  kcsan, seqlock: Support seqcount_latch_t
  seqlock, treewide: Switch to non-raw seqcount_latch interface
  kcsan, seqlock: Fix incorrect assumption in read_seqbegin()

 Documentation/locking/seqlock.rst |  2 +-
 arch/x86/kernel/tsc.c             |  5 +-
 include/linux/rbtree_latch.h      | 20 ++++---
 include/linux/seqlock.h           | 98 +++++++++++++++++++++++--------
 kernel/printk/printk.c            |  9 +--
 kernel/time/sched_clock.c         | 34 +++++++----
 kernel/time/timekeeping.c         | 12 ++--
 7 files changed, 123 insertions(+), 57 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog

