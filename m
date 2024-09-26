Return-Path: <linux-kernel+bounces-340006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7D6986D36
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A342864F6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3718952E;
	Thu, 26 Sep 2024 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPCSVI4D"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B5190686
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334313; cv=none; b=CSDw4poHP/+A/dWJDeTbLMorlO9oOlu5VZ25kEt2hz8hxtklIpIIxakJOV6l/Vr54SoBq2ksKA5KJ6q5edq2S66B/ix1GPlky5eIOKxwkQ1N3oMatTlgrSogp1KGSjGCdzaq46Td5Q2rmnFOfYruoBna61a95XAHm9XfLqu9u4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334313; c=relaxed/simple;
	bh=qkiozs+PicwkM4zvjFeuqGTZHMv9yUeqv+Y5KXZnzHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoGSlEv9y1rSZV4K2iAjKsJ7n4l1cbc9Olw9aTATpRRTZuxURuRhL0KgEKPXUM0xew/8mMpmDquG29wQ69Da5+Bvl4rwf5lad9Xb18tgkiK1kudxuWRz8JZu8D01cjsmEu/b2wS7BAN//h4tjQnkfnaZE1XKBIIV2KJc81e1doM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPCSVI4D; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f75b13c2a8so6781271fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727334310; x=1727939110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKJ7gedvu12Wl574yGIqo8G9G+85Xzvxr/CDmz1EyCQ=;
        b=MPCSVI4DR9MtmffP1qDe2N/7t/QL7vD+0Q8cVKYgkxe8/wiaz8GiCFx8g27DtKjKs7
         iDTFTj3RF6rFOhqfOcL8IDAJF87DL52LLIH+cKN9fCv4t6eZzKBOiA+qY9LOixLu4hzV
         ErcwluZF+evrqG7I/NXWw4+Gse3hVVF0qniLg9E5nIr4b1AsKKeLMheZN96LhYtigNGr
         r64g+VJmWz2GTo8zdYXv9ayJ3stN+HInFlsVYQhE5y6NZu6GW1NJc3/0ZX+YDrb03bhj
         trjy+bE7OQZ0+2Gr7HmqrV0ULcz1dlVxUd8LlxjJY4AzYzfb0rvegQKpaGCtlvK4hq5U
         mBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727334310; x=1727939110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKJ7gedvu12Wl574yGIqo8G9G+85Xzvxr/CDmz1EyCQ=;
        b=ZwBTQSzcEwCpLYENgp+lgUUchqVPn0dO85dbkw4xguSBprFlYbBicQ1mgXuqNPn6c7
         PzMhX8hwe2Ut9sozPBRKjelIlf2eu/0pmKYezCktfRr6GcHcXXi+EJoRA5aX0IMn/N63
         jehchrx25bRFMTw/docw+ZRzsMH+n3h2CwgR4+j3H7cm7bvSo2KTeYyY6n6dmBI8fqbc
         xF52qePnSkGrueuxVD+mTt6MjNSxyjMKxOW5FglijJHJ9N/ekxJ/I+yOC9qmx/TF1HR+
         ZBZOah7ydb0gJBSuzoJkyYB4+YID0P07g3JzRRsCYehbRoid4YkS2g8yrSmrfQjPFtO1
         deTg==
X-Forwarded-Encrypted: i=1; AJvYcCWgD/fjvcFI/MoozEF/V/Eyd+Sfg36ZsTPSWiOr2S5NQCz4wbynQhD/WApLIuxoIUZFFM/GAt1U7aRJElw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcICChRO7BccUV5KKWvVIBdib74erqVWdcRNfT+GVL/0NKmhmK
	EymO8UI9oVodXrQjF4PJy3dTpOgZpQyAWNxudua6OQCKMhw9MQdUv2ErP9ESNHSgeS5fS6QOMgZ
	wV8+7nMVhm2gL/+SaZO43MyoD3O2CVsr+ibTH
X-Google-Smtp-Source: AGHT+IGMv2aiwvI/PHfmt7d4FswNznQUp6jq5vso3Nm15PfuvwWdGqKbR47IQAkt+BMNG4jwLYEEqQqqzfhSUA5fEZw=
X-Received: by 2002:a2e:5152:0:b0:2f7:4e8c:9bfa with SMTP id
 38308e7fff4ca-2f91ca6eee3mr27487461fa.33.1727334309680; Thu, 26 Sep 2024
 00:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66eb52dc.050a0220.92ef1.0006.GAE@google.com> <70b5789b-7d77-4389-b2de-6c4219f28d32@I-love.SAKURA.ne.jp>
 <CACT4Y+Z+zyUipyMceoPS_=LFEfvTURXFRMmLUTZJz1K0b+xsaA@mail.gmail.com>
In-Reply-To: <CACT4Y+Z+zyUipyMceoPS_=LFEfvTURXFRMmLUTZJz1K0b+xsaA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 26 Sep 2024 09:04:55 +0200
Message-ID: <CACT4Y+ZTMyd4SZQRuTSwHSNY_ZxuZOk90ekMJLhzerJ-3wzROQ@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: BUG: stack guard page was hit in corrupted
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	syzkaller <syzkaller@googlegroups.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+d5db198a0f40411f24c3@syzkaller.appspotmail.com>, 
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sept 2024 at 08:48, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 23 Sept 2024 at 16:04, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > This bug suggests code added by commit 6cd0dd934b03 ("kcov: Add interru=
pt handling self test").
> >
> > The location that triggers page fault looks like
> >
> >   pos =3D READ_ONCE(area[0]) + 1;
> >
> > in __sanitizer_cov_trace_pc().
> > When is t->kcov_area initialized with appropriate buffer
> > after selftest() does current->kcov_mode =3D KCOV_MODE_TRACE_PC ?
> >
> > At commit de5cb0dcb74c ("Merge branch 'address-masking'"):
> > $ ./scripts/faddr2line vmlinux-de5cb0dc asm_exc_page_fault+0x26/0x30 sc=
hed_clock+0xb/0x60 __sanitizer_cov_trace_pc+0x53/0x70 sched_clock+0xb/0x60 =
lock_pin_lock+0x1a9/0x2d0 preempt_schedule_irq+0x51/0x90 __schedule+0x2f2/0=
x5920 lockdep_hardirqs_on+0x7c/0x110 preempt_schedule_thunk+0x1a/0x30 preem=
pt_schedule_common+0x44/0xc0 preempt_schedule_thunk+0x1a/0x30 __pfx___sched=
ule+0x10/0x10 vprintk_emit+0x39e/0x6f0 __pfx_vprintk_emit+0x10/0x10 __debug=
fs_create_file+0x40e/0x660 __pfx_lock_release+0x10/0x10 preempt_schedule_ir=
q+0x51/0x90 irqentry_exit+0x36/0x90 asm_sysvec_apic_timer_interrupt+0x1a/0x=
20 __wake_up_klogd.part.0+0x99/0xf0 vprintk+0x86/0xa0 kcov_init+0xcc/0x120 =
kcov_init+0xb3/0x120
> > asm_exc_page_fault+0x26/0x30:
> > asm_exc_page_fault at arch/x86/include/asm/idtentry.h:623
> >
> > sched_clock+0xb/0x60:
> > __preempt_count_add at arch/x86/include/asm/preempt.h:79
> > (inlined by) sched_clock at arch/x86/kernel/tsc.c:283
> >
> > __sanitizer_cov_trace_pc+0x53/0x70:
> > __sanitizer_cov_trace_pc at kernel/kcov.c:222
> >
> > sched_clock+0xb/0x60:
> > __preempt_count_add at arch/x86/include/asm/preempt.h:79
> > (inlined by) sched_clock at arch/x86/kernel/tsc.c:283
> >
> > lock_pin_lock+0x1a9/0x2d0:
> > __lock_pin_lock at kernel/locking/lockdep.c:5593
> > (inlined by) lock_pin_lock at kernel/locking/lockdep.c:5915
> >
> > preempt_schedule_irq+0x51/0x90:
> > native_save_fl at arch/x86/include/asm/irqflags.h:26
> > (inlined by) arch_local_save_flags at arch/x86/include/asm/irqflags.h:8=
7
> > (inlined by) arch_irqs_disabled at arch/x86/include/asm/irqflags.h:147
> > (inlined by) preempt_schedule_irq at kernel/sched/core.c:6997
> >
> > __schedule+0x2f2/0x5920:
> > __schedule at kernel/sched/core.c:6579
> >
> > lockdep_hardirqs_on+0x7c/0x110:
> > lockdep_hardirqs_on at kernel/locking/lockdep.c:4465
> >
> > preempt_schedule_thunk+0x1a/0x30:
> > preempt_schedule_thunk at arch/x86/entry/thunk.S:12
> >
> > preempt_schedule_common+0x44/0xc0:
> > __preempt_count_sub at arch/x86/include/asm/preempt.h:84
> > (inlined by) preempt_schedule_common at kernel/sched/core.c:6855
> >
> > preempt_schedule_thunk+0x1a/0x30:
> > preempt_schedule_thunk at arch/x86/entry/thunk.S:12
> >
> > __pfx___schedule+0x10/0x10:
> > __schedule at kernel/sched/core.c:6533
> >
> > vprintk_emit+0x39e/0x6f0:
> > vprintk_emit at kernel/printk/printk.c:2356
> >
> > __pfx_vprintk_emit+0x10/0x10:
> > vprintk_emit at kernel/printk/printk.c:2356
> >
> > __debugfs_create_file+0x40e/0x660:
> > end_creating at fs/debugfs/inode.c:409
> > (inlined by) __debugfs_create_file at fs/debugfs/inode.c:450
> >
> > __pfx_lock_release+0x10/0x10:
> > lock_release at kernel/locking/lockdep.c:5830
> >
> > preempt_schedule_irq+0x51/0x90:
> > native_save_fl at arch/x86/include/asm/irqflags.h:26
> > (inlined by) arch_local_save_flags at arch/x86/include/asm/irqflags.h:8=
7
> > (inlined by) arch_irqs_disabled at arch/x86/include/asm/irqflags.h:147
> > (inlined by) preempt_schedule_irq at kernel/sched/core.c:6997
> >
> > irqentry_exit+0x36/0x90:
> > irqentry_exit at kernel/entry/common.c:357
> >
> > asm_sysvec_apic_timer_interrupt+0x1a/0x20:
> > asm_sysvec_apic_timer_interrupt at arch/x86/include/asm/idtentry.h:702
> >
> > __wake_up_klogd.part.0+0x99/0xf0:
> > __wake_up_klogd at kernel/printk/printk.c:4495
> >
> > vprintk+0x86/0xa0:
> > vprintk at kernel/printk/printk_safe.c:69
> >
> > kcov_init+0xcc/0x120:
> > selftest at kernel/kcov.c:1090
> > (inlined by) kcov_init at kernel/kcov.c:1117
> >
> > kcov_init+0xb3/0x120:
> > selftest at kernel/kcov.c:1088
> > (inlined by) kcov_init at kernel/kcov.c:1117
>
>
> The call chain here seems to be:
>
> asm_sysvec_apic_timer_interrupt
>
> irqentry_exit (calls next function inside of instrumentation_begin/end
> thus undetected statically)
> irqentry_exit_cond_resched
> raw_irqentry_exit_cond_resched
> preempt_schedule_irq
> [some locking function]
> lock_pin_lock
> sched_clock
> __sanitizer_cov_trace_pc
> [BOOM]
>
> All functions in the scheduler and lockdep (preempt_schedule_irq,
> lock_pin_lock) are not instrumented due to KCOV_INSTRUMENT :=3D n in
> Makefiles.
>
> But sched_clock is instrumented. It has notrace, but no noinstr.
>
> Should notrace imply noinstr? Or should we mark sched_clock as noinstr as=
 well?

We shouldn't mark sched_clock as noinstr b/c there is already
sched_clock_noinstr.
So another option is to call sched_clock_noinstr from lock_pin_lock,
which looks reasonable.

So far I can't reproduce this locally.


> > On 2024/09/19 7:23, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of=
 git:..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D153e7fc79=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc78e7c8f4=
1d443e6
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd5db198a0f4=
0411f24c3
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils f=
or Debian) 2.40

