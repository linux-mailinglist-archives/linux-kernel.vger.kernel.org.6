Return-Path: <linux-kernel+bounces-339978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E5C986CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88329B25BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0E18953C;
	Thu, 26 Sep 2024 06:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ficWLZ6Q"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E117554A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333349; cv=none; b=kPSv3MlZvm67COED3AEyBM0EiDhzYeD1FgZxKDoR/53DNQaGiSS0VzTfZX/6R07qLg2boisKduVxNA5x/7jPRZy9ND/T7JDC4rHmn7UYDu4DqHULaMjEJC6RrXnWQHtQiJMAzmiUXCoYrmyWlFC/mlxKa9E7LWVFFQ9mI7WQo0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333349; c=relaxed/simple;
	bh=CX6PXLaPn1eLcm7WxEXyhAcAVgX8pKdkTIoWfJ5ssec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH+tkpF2Z/fen6FFYaabfcWgKnuENmU3RBR1rc4czAJlVU6N8as0OfsPDRrb8Rm/YIsI+QYroZtLw8RuUmfYzMtvMcDxIZo+xEd+SzPcTTbsoPA5U7EK8VPtbh2iLmVmE4ycOeWAzsixWTVSodd/2b1HGy+VppaV2HhRONu3MoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ficWLZ6Q; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f74e613a10so10079151fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727333345; x=1727938145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W2SVr9rIakQ5SLsJbHka14vugewuGOn9/YcXH1sarU=;
        b=ficWLZ6Q/2IQkgR2ttQRaOyfQBAnryk1AT3mcOMI3Ng1BXiDvzvALjjpPO9iKv8LoB
         6Q5hBi6117XQtTgWmZCPD8AheP9EZecAgKjMdTV1kJm7hPFANQ0IUanvzfDZ9Z+MsAmh
         j32XMdbvVQRpySFj662sDMhXqAiaUBfoM+KzbnLygKKiGkF9S/PwD52TkvAiDrVKX/wz
         31FsQj4+WZ18fMdkl3DFCsTfj3vWMLDUEEZ3UICD8QTLjCNYWYHPZM4A2nCxM0r+6gf2
         ROAc1bF95akwwvylj4a4Jy2dJNzuQWiPwYbT0d7UaNLPB6nXqusBbRP3M13ni1/xToac
         g+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333345; x=1727938145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W2SVr9rIakQ5SLsJbHka14vugewuGOn9/YcXH1sarU=;
        b=hhpmTh2emAsbEdpJjoJBa0EFJfstx3EIK+EnKZYQQZjgJVSSAiXrpc/PunWDE2soB6
         DRfM69jU5ZNfLF9++jJW7OVF1hZvkVKcJKAo7Y5vyp3uj22ywecoD7qpqcqcUg/1XXs2
         PY0ua5eCDtNreKPdlA88aGoOn6GTy8vex9G6GQ4BkTn++sZrEZV9lMUAGVcGpB+o+BAe
         9ORIrhu+u/cnnxioBEa0rFuxk9uT8GV2TRHnb9ioMgkIZptSnhd+MD0Lr8tODsa08u3N
         SQGREzncS0cHY6lBoTsQi76wHtl+X2snGtQnlM0zLA0hLe9r+QE/FX2tbWL73bOH74Zw
         jkqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfT5CHD0FwHwXPCUu7Qh+acIxVvcr4iAdjyBLyWx0TZ97pZBe/bZmO3xx3pNQn67Tz74ZBDgsg5d/36B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsLZ7wW59QjMjfsaP8iW6c322sO09rxZETvtaY1ffrOX8g0v3k
	++uFMIJ1JGpHOaRxH/UF1BhX+0nLWZBhZ9azMh87X95KO3QcByPdOpM1uvkstmD+ic7Wux2lyMY
	CmwTMHrpnwf/x+ZNbvMYVb0RmXOdkqfMubQ9Y
X-Google-Smtp-Source: AGHT+IGLmmr8tLwPIKp46mXanYQ2w/gis2id36flPZGgRNYPeznzMuC5bgjyNuS+1dVWWz3e+t27Dz5wmXMfPh/OkKs=
X-Received: by 2002:a2e:bc07:0:b0:2f7:7fe7:ca94 with SMTP id
 38308e7fff4ca-2f9156370famr48783401fa.1.1727333345156; Wed, 25 Sep 2024
 23:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66eb52dc.050a0220.92ef1.0006.GAE@google.com> <70b5789b-7d77-4389-b2de-6c4219f28d32@I-love.SAKURA.ne.jp>
In-Reply-To: <70b5789b-7d77-4389-b2de-6c4219f28d32@I-love.SAKURA.ne.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 26 Sep 2024 08:48:53 +0200
Message-ID: <CACT4Y+Z+zyUipyMceoPS_=LFEfvTURXFRMmLUTZJz1K0b+xsaA@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: BUG: stack guard page was hit in corrupted
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	syzkaller <syzkaller@googlegroups.com>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>
Cc: syzbot <syzbot+d5db198a0f40411f24c3@syzkaller.appspotmail.com>, 
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Sept 2024 at 16:04, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> This bug suggests code added by commit 6cd0dd934b03 ("kcov: Add interrupt=
 handling self test").
>
> The location that triggers page fault looks like
>
>   pos =3D READ_ONCE(area[0]) + 1;
>
> in __sanitizer_cov_trace_pc().
> When is t->kcov_area initialized with appropriate buffer
> after selftest() does current->kcov_mode =3D KCOV_MODE_TRACE_PC ?
>
> At commit de5cb0dcb74c ("Merge branch 'address-masking'"):
> $ ./scripts/faddr2line vmlinux-de5cb0dc asm_exc_page_fault+0x26/0x30 sche=
d_clock+0xb/0x60 __sanitizer_cov_trace_pc+0x53/0x70 sched_clock+0xb/0x60 lo=
ck_pin_lock+0x1a9/0x2d0 preempt_schedule_irq+0x51/0x90 __schedule+0x2f2/0x5=
920 lockdep_hardirqs_on+0x7c/0x110 preempt_schedule_thunk+0x1a/0x30 preempt=
_schedule_common+0x44/0xc0 preempt_schedule_thunk+0x1a/0x30 __pfx___schedul=
e+0x10/0x10 vprintk_emit+0x39e/0x6f0 __pfx_vprintk_emit+0x10/0x10 __debugfs=
_create_file+0x40e/0x660 __pfx_lock_release+0x10/0x10 preempt_schedule_irq+=
0x51/0x90 irqentry_exit+0x36/0x90 asm_sysvec_apic_timer_interrupt+0x1a/0x20=
 __wake_up_klogd.part.0+0x99/0xf0 vprintk+0x86/0xa0 kcov_init+0xcc/0x120 kc=
ov_init+0xb3/0x120
> asm_exc_page_fault+0x26/0x30:
> asm_exc_page_fault at arch/x86/include/asm/idtentry.h:623
>
> sched_clock+0xb/0x60:
> __preempt_count_add at arch/x86/include/asm/preempt.h:79
> (inlined by) sched_clock at arch/x86/kernel/tsc.c:283
>
> __sanitizer_cov_trace_pc+0x53/0x70:
> __sanitizer_cov_trace_pc at kernel/kcov.c:222
>
> sched_clock+0xb/0x60:
> __preempt_count_add at arch/x86/include/asm/preempt.h:79
> (inlined by) sched_clock at arch/x86/kernel/tsc.c:283
>
> lock_pin_lock+0x1a9/0x2d0:
> __lock_pin_lock at kernel/locking/lockdep.c:5593
> (inlined by) lock_pin_lock at kernel/locking/lockdep.c:5915
>
> preempt_schedule_irq+0x51/0x90:
> native_save_fl at arch/x86/include/asm/irqflags.h:26
> (inlined by) arch_local_save_flags at arch/x86/include/asm/irqflags.h:87
> (inlined by) arch_irqs_disabled at arch/x86/include/asm/irqflags.h:147
> (inlined by) preempt_schedule_irq at kernel/sched/core.c:6997
>
> __schedule+0x2f2/0x5920:
> __schedule at kernel/sched/core.c:6579
>
> lockdep_hardirqs_on+0x7c/0x110:
> lockdep_hardirqs_on at kernel/locking/lockdep.c:4465
>
> preempt_schedule_thunk+0x1a/0x30:
> preempt_schedule_thunk at arch/x86/entry/thunk.S:12
>
> preempt_schedule_common+0x44/0xc0:
> __preempt_count_sub at arch/x86/include/asm/preempt.h:84
> (inlined by) preempt_schedule_common at kernel/sched/core.c:6855
>
> preempt_schedule_thunk+0x1a/0x30:
> preempt_schedule_thunk at arch/x86/entry/thunk.S:12
>
> __pfx___schedule+0x10/0x10:
> __schedule at kernel/sched/core.c:6533
>
> vprintk_emit+0x39e/0x6f0:
> vprintk_emit at kernel/printk/printk.c:2356
>
> __pfx_vprintk_emit+0x10/0x10:
> vprintk_emit at kernel/printk/printk.c:2356
>
> __debugfs_create_file+0x40e/0x660:
> end_creating at fs/debugfs/inode.c:409
> (inlined by) __debugfs_create_file at fs/debugfs/inode.c:450
>
> __pfx_lock_release+0x10/0x10:
> lock_release at kernel/locking/lockdep.c:5830
>
> preempt_schedule_irq+0x51/0x90:
> native_save_fl at arch/x86/include/asm/irqflags.h:26
> (inlined by) arch_local_save_flags at arch/x86/include/asm/irqflags.h:87
> (inlined by) arch_irqs_disabled at arch/x86/include/asm/irqflags.h:147
> (inlined by) preempt_schedule_irq at kernel/sched/core.c:6997
>
> irqentry_exit+0x36/0x90:
> irqentry_exit at kernel/entry/common.c:357
>
> asm_sysvec_apic_timer_interrupt+0x1a/0x20:
> asm_sysvec_apic_timer_interrupt at arch/x86/include/asm/idtentry.h:702
>
> __wake_up_klogd.part.0+0x99/0xf0:
> __wake_up_klogd at kernel/printk/printk.c:4495
>
> vprintk+0x86/0xa0:
> vprintk at kernel/printk/printk_safe.c:69
>
> kcov_init+0xcc/0x120:
> selftest at kernel/kcov.c:1090
> (inlined by) kcov_init at kernel/kcov.c:1117
>
> kcov_init+0xb3/0x120:
> selftest at kernel/kcov.c:1088
> (inlined by) kcov_init at kernel/kcov.c:1117


The call chain here seems to be:

asm_sysvec_apic_timer_interrupt

irqentry_exit (calls next function inside of instrumentation_begin/end
thus undetected statically)
irqentry_exit_cond_resched
raw_irqentry_exit_cond_resched
preempt_schedule_irq
[some locking function]
lock_pin_lock
sched_clock
__sanitizer_cov_trace_pc
[BOOM]

All functions in the scheduler and lockdep (preempt_schedule_irq,
lock_pin_lock) are not instrumented due to KCOV_INSTRUMENT :=3D n in
Makefiles.

But sched_clock is instrumented. It has notrace, but no noinstr.

Should notrace imply noinstr? Or should we mark  sched_clock as noinstr as =
well?



> On 2024/09/19 7:23, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of g=
it:..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D153e7fc7980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc78e7c8f41d=
443e6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd5db198a0f404=
11f24c3
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40

