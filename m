Return-Path: <linux-kernel+bounces-386509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C39B4459
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D7228384E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EBF2038B3;
	Tue, 29 Oct 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y7wsuNf3"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4081F7565
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730191042; cv=none; b=OjfQFLlXynXQMdedyelLXouFrByboX9eAWEFxzEo4Kpfm6STCmMgB25Bf2Wg6M+S/fbuas5KiilB4K5+EZorYTRy+OwQtKCrxO3nIcApCo9zbm4H/OAjyXSFMNKwBObmLRXDCyTrhoNEQeFn2Y95vJfq6BS9S+4vz8JbI/AfgGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730191042; c=relaxed/simple;
	bh=8PDWwXXlGAhr8gc3ab3PxwKr8FzRu+PtmgT/1cXgoSQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LgvS9bqZzfMTBdr+TkNAM3wvXP6PI1ZNXnnzBn+D5H4lamC/QDJRvGt6tda350NL+9rBo6/P4oVJD8WvPfW1yiSKU2R7ZA7/mQcyMlBzny+TNOZFFfhGeRltsPQXaNXNQKD1v5Z6TRejUncMO3vbA6MWbFoLIpATUyQigqaMJQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y7wsuNf3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5c999f254aeso4483399a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730191037; x=1730795837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zhSkLyvcAgLlS+6T/t43F9F3pPfA6xXjKxWozXWQfL4=;
        b=y7wsuNf387VlP78s6cN369JTbU4K1mYScgB/WQCOec8Eh1O408dIbsvmFyiB0QxDg7
         y92k4xBAR4vZm1jqawmny0AeRpwZQ9zygczf0epQSi2v9+IzKim1k6SH5txpt9y7Fbx7
         jQm6sN2q/aNG6N/hhmJOVDEfAhU4Ztmtq6HWv5M3UnwVl/wsKgqFuXUxYUujZpeYOSwF
         GKXB9EHz/CtUW7dYVeDYKgvmOMvVJMq1evdQ5wDMrPrcKFnffAeEtaAjnBcPMJJJAEGd
         wPPLmPMEgLaaGO9IeTvwL3zrwvs1qBvXE7ZtQb3j4bZ+o9mogTwMbToHDYptsNiTC27z
         +K3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730191037; x=1730795837;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zhSkLyvcAgLlS+6T/t43F9F3pPfA6xXjKxWozXWQfL4=;
        b=gohcHaAtJLmt+kSWdiIIwb9djrvn/j+SzhJs/pZWGUzLk2xSBUO1Bu9Qv1vlyyLQ7R
         wkbUTncx18crCoj3s/iM4M7TWYMOtdh2qgy3cp/PWBkUAxRx7j6jRP+YDNWrQvlEj1Sx
         0zdluJd4wtJUcUYi/NBNHrlMK0SMqIB4jKOkavNg1CrSInuvFnicnEhdrWUX6gQW3get
         6OgZrFZvTIUMMAM2d49qbUNzpONbB8zQ3MLLjfxMnnBq1+uDBOt6zLY8G8qvk5ws6/p0
         MptwZ4MQqLVhrpBSk8V5eAbeNFnNU0cEuC4IRgm6HGfaBI6P17g2CMxayXvowGl+ZRIc
         loXA==
X-Forwarded-Encrypted: i=1; AJvYcCXUd4aAfBSUThz/tc9GjZ1NZYOBrw7o5x5esnuxtykuCDXPJN8KYDD1TTW07QEAiCCL3Xk/1cpEIY4TxQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgEjEGwV+7y/9cDOhs+Dwi4i5VWJuACYn0Z+okiYHHanUFVGx/
	B0AQm/DkVEGLeZwZGUGcfrFEfJJDYErR9qSlJ1Hy5AxdFjH6LPjXkfInmrunwohAB6b37P+Qug=
	=
X-Google-Smtp-Source: AGHT+IE3m+MNFPeSyS55m3mG0ou8bq1GSe138CH9xCkSGmigEtytsEpGbURdWx2wTUxazvmebjMO0deF6g==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:7cc7:9e06:a6d2:add7])
 (user=elver job=sendgmr) by 2002:a05:6402:4021:b0:5cb:def2:be06 with SMTP id
 4fb4d7f45d1cf-5cbdef2c080mr1989a12.0.1730191037134; Tue, 29 Oct 2024 01:37:17
 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:36:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029083658.1096492-1-elver@google.com>
Subject: [PATCH] kcsan, seqlock: Support seqcount_latch_t
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

While fuzzing an arm64 kernel, Alexander Potapenko reported:

| BUG: KCSAN: data-race in ktime_get_mono_fast_ns / timekeeping_update
|
| write to 0xffffffc082e74248 of 56 bytes by interrupt on cpu 0:
|  update_fast_timekeeper kernel/time/timekeeping.c:430 [inline]
|  timekeeping_update+0x1d8/0x2d8 kernel/time/timekeeping.c:768
|  timekeeping_advance+0x9e8/0xb78 kernel/time/timekeeping.c:2344
|  update_wall_time+0x18/0x38 kernel/time/timekeeping.c:2360
|  tick_do_update_jiffies64+0x164/0x1b0 kernel/time/tick-sched.c:149
|  tick_nohz_handler+0xa4/0x2a8 kernel/time/tick-sched.c:232
|  __hrtimer_run_queues+0x198/0x33c kernel/time/hrtimer.c:1691
|  hrtimer_interrupt+0x16c/0x630 kernel/time/hrtimer.c:1817
|  timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
|  arch_timer_handler_phys+0x60/0x74 drivers/clocksource/arm_arch_timer.c:692
|  handle_percpu_devid_irq+0xd8/0x1ec kernel/irq/chip.c:942
|  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
|  handle_irq_desc kernel/irq/irqdesc.c:692 [inline]
|  generic_handle_domain_irq+0x5c/0x7c kernel/irq/irqdesc.c:748
|  gic_handle_irq+0x78/0x1b0 drivers/irqchip/irq-gic-v3.c:843
|  call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
|  do_interrupt_handler+0x74/0xa8 arch/arm64/kernel/entry-common.c:310
|  __el1_irq arch/arm64/kernel/entry-common.c:536 [inline]
|  el1_interrupt+0x34/0x54 arch/arm64/kernel/entry-common.c:551
|  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
|  el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
|  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline]
|  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline]
|  kvm_arch_vcpu_ioctl_run+0x8d4/0xf48 arch/arm64/kvm/arm.c:1259
|  kvm_vcpu_ioctl+0x650/0x894 virt/kvm/kvm_main.c:4487
|  __do_sys_ioctl fs/ioctl.c:51 [inline]
|  __se_sys_ioctl fs/ioctl.c:893 [inline]
|  __arm64_sys_ioctl+0xf8/0x170 fs/ioctl.c:893
|  [...]
|
| read to 0xffffffc082e74258 of 8 bytes by task 5260 on cpu 1:
|  __ktime_get_fast_ns kernel/time/timekeeping.c:372 [inline]
|  ktime_get_mono_fast_ns+0x88/0x174 kernel/time/timekeeping.c:489
|  init_srcu_struct_fields+0x40c/0x530 kernel/rcu/srcutree.c:263
|  init_srcu_struct+0x14/0x20 kernel/rcu/srcutree.c:311
|  kvm_dev_ioctl+0x304/0x908 virt/kvm/kvm_main.c:1185
|  __do_sys_ioctl fs/ioctl.c:51 [inline]
|  __se_sys_ioctl fs/ioctl.c:893 [inline]
|  __arm64_sys_ioctl+0xf8/0x170 fs/ioctl.c:893
|  [...]
|
| value changed: 0x000002f875d33266 -> 0x000002f877416866
|
| Reported by Kernel Concurrency Sanitizer on:
| CPU: 1 UID: 0 PID: 5260 Comm: syz.2.7483 Not tainted 6.12.0-rc3-dirty #78

This is a false positive data race between a seqcount latch writer and a
reader accessing stale data.

Unlike the regular seqlock interface, the seqcount_latch interface for
latch writers never has a well-defined critical section.

To support with KCSAN, optimistically declare that a fixed number of
memory accesses after raw_write_seqcount_latch() are "atomic". Latch
readers follow a similar pattern as the regular seqlock interface. This
effectively tells KCSAN that data races on accesses to seqcount_latch
protected data should be ignored.

Reviewing current raw_write_seqcount_latch() callers, the most common
patterns involve only few memory accesses, either a single plain C
assignment, or memcpy; therefore, the value of 8 memory accesses after
raw_write_seqcount_latch() is chosen to (a) avoid most false positives,
and (b) avoid excessive number of false negatives (due to inadvertently
declaring most accesses in the proximity of update_fast_timekeeper() as
"atomic").

Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Fixes: 88ecd153be95 ("seqlock, kcsan: Add annotations for KCSAN")
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/seqlock.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index fffeb754880f..e24cf144276e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -614,6 +614,7 @@ typedef struct {
  */
 static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *s)
 {
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	/*
 	 * Pairs with the first smp_wmb() in raw_write_seqcount_latch().
 	 * Due to the dependent load, a full smp_rmb() is not needed.
@@ -631,6 +632,7 @@ static __always_inline unsigned raw_read_seqcount_latch(const seqcount_latch_t *
 static __always_inline int
 raw_read_seqcount_latch_retry(const seqcount_latch_t *s, unsigned start)
 {
+	kcsan_atomic_next(0);
 	smp_rmb();
 	return unlikely(READ_ONCE(s->seqcount.sequence) != start);
 }
@@ -721,6 +723,13 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
 	smp_wmb();	/* prior stores before incrementing "sequence" */
 	s->seqcount.sequence++;
 	smp_wmb();      /* increment "sequence" before following stores */
+
+	/*
+	 * Latch writers do not have a well-defined critical section, but to
+	 * avoid most false positives, at the cost of false negatives, assume
+	 * the next few memory accesses belong to the latch writer.
+	 */
+	kcsan_atomic_next(8);
 }
 
 #define __SEQLOCK_UNLOCKED(lockname)					\
-- 
2.47.0.163.g1226f6d8fa-goog


