Return-Path: <linux-kernel+bounces-244630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5523992A723
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88091F21712
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D8146D6D;
	Mon,  8 Jul 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c+XewDKp"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33D61E86A
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455493; cv=none; b=iKU6OxwlGj8O3LepjsD9NrLItU20bkpSh7y/3UtNrv3SMjbRwMgt6rg0S7q/OLYvtAuzyh0mpMjIMe7LDIzvcroqpyQ50+iKcHg4UmpTc8/ECrD9UY8dBGc/tLnDWlbbQu1o88t7Zy23GsPuDtVoCXygYpyZ8/qYWaIA0Q1tALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455493; c=relaxed/simple;
	bh=IX6j/yir9WH4Y/FDfqFmEucYbZspy30XRytXoCTmG4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PbH9pUmujsgQqNEBARV0jN0Ag+rVky5/vF1eGUrkS8dBb2IzGvvpkwIF0MygInylz9528q4hlgmrwsGEX/5//Xy8/BAOBxqKrfj07u/Z8qSkaZYMcJxxxgw6xZP4mXFul8kwQU0BMwMSLoh0O9NzoaManxQoi8cU6f6JUDLv0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c+XewDKp; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-447df43324fso502051cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720455491; x=1721060291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PBAQem0cF7wTCAm7Va1RSuppap0iOvlnk+12A4PzYE=;
        b=c+XewDKpb3P6YoXBoFfBkPwRwKJFwjGCL3a0bjEMRMEcCvLZ5F1BL66f5qrh6uNuD1
         pZjK4Yp1arAqdRl7SM+8jTt+aeOw+3Jr+k/gWh/3/hQAqRtLIWUYJF9kOERFvpf34Ck6
         pC/+CPOKBr5scdHIN9FZ8J/Z7gya9WzhH7g/c6ewT1VnuEnzw5ZutrcgQaihnq66LVkP
         02oKQ6U+bXIIEagxxl2aOvm1apMGttXCfRqXfRS912pk+l+xeItmTmhmscIB8Av2GIAN
         XD2F1lVLJxzIP9eAz1PJakI/wYOrzdz1FgTOVRhigIksOkxi31s1atKvpSGDcip+3Kon
         yJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455491; x=1721060291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PBAQem0cF7wTCAm7Va1RSuppap0iOvlnk+12A4PzYE=;
        b=EtlcDFFrWTjMsAgcPRSkbHNpNOkd/9/LW2lFUWzUr5s2acvWYfIsV821j4d6pZAGUi
         GrwCg5kTJpA6+JsCwTXI7S0mz6WtfBSDYW2pycJ0k9ZQYlWw7qqgc92xIBbUKTvnj9Af
         KsFbpBzogWjzOAXjpi25BVpegcBYGkMCYR1DyLtdC/5CsnMFiBr9apL1Cw9zpq4tql/z
         xzlaXNbwtUb5KgSDCyoOFFNmwR2RzFij/X5n0bZONqWM8sY2y2mQIW2N0Rpkw3Rz0wJb
         jGkWHw+T/ZRnBumAKrb/n3EyphUcVY1C/EXnkccIng/Fg8w025f6kuoB9nPn+5uxF1Mz
         mAyw==
X-Forwarded-Encrypted: i=1; AJvYcCWzWI1LSRDWAeo5bSP7e00UZx4Q0cJTAaNwiynjlMPT2BE+an9D15LU5A1Oa1qbUNADIHQFAmXXEeybNOw0LtHNyNepwBqEoo1Jh1ka
X-Gm-Message-State: AOJu0YwgmM74QYAvKeZoZ1xhgXOcHPbnO+wHNjmYGwl0PczD4+qkUyQQ
	l+0ZIZTbBNNY9DJoX65hib0WoUdiq1EuxiosBVfwl2XkPq4TqkY42FM/Vl5QTcVJfR+TKjrqBLl
	BMVh6DBZh0F0/yKN+l/aZeAPIPmmryCchWtfW
X-Google-Smtp-Source: AGHT+IHi+IWF1ZgStNdLQo8ikEX6DJSqCsuQ043sS/L3Us0b98GZnJwgAviB24/eaMcsMz8+p039RkyuN07FEV22Yq0=
X-Received: by 2002:ac8:7ef7:0:b0:447:f914:8719 with SMTP id
 d75a77b69052e-447f9148dc8mr668261cf.2.1720455490297; Mon, 08 Jul 2024
 09:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
In-Reply-To: <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 8 Jul 2024 10:17:31 -0600
Message-ID: <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 8:34=E2=80=AFAM Bharata B Rao <bharata@amd.com> wrot=
e:
>
> Hi Yu Zhao,
>
> Thanks for your patches. See below...
>
> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> > Hi Bharata,
> >
> > On Wed, Jul 3, 2024 at 9:11=E2=80=AFAM Bharata B Rao <bharata@amd.com> =
wrote:
> >>
> <snip>
> >>
> >> Some experiments tried
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> 1) When MGLRU was enabled many soft lockups were observed, no hard
> >> lockups were seen for 48 hours run. Below is once such soft lockup.
> >
> > This is not really an MGLRU issue -- can you please try one of the
> > attached patches? It (truncate.patch) should help with or without
> > MGLRU.
>
> With truncate.patch and default LRU scheme, a few hard lockups are seen.

Thanks.

In your original report, you said:

  Most of the times the two contended locks are lruvec and
  inode->i_lock spinlocks.
  ...
  Often times, the perf output at the time of the problem shows
  heavy contention on lruvec spin lock. Similar contention is
  also observed with inode i_lock (in clear_shadow_entry path)

Based on this new report, does it mean the i_lock is not as contended,
for the same path (truncation) you tested? If so, I'll post
truncate.patch and add reported-by and tested-by you, unless you have
objections.

The two paths below were contended on the LRU lock, but they already
batch their operations. So I don't know what else we can do surgically
to improve them.

> First one is this:
>
> watchdog: Watchdog detected hard LOCKUP on cpu 487
> CPU: 487 PID: 11525 Comm: fio Not tainted 6.10.0-rc3 #27
> RIP: 0010:native_queued_spin_lock_slowpath+0x81/0x300
> Call Trace:
>    <NMI>
>    ? show_regs+0x69/0x80
>    ? watchdog_hardlockup_check+0x1b4/0x3a0
> <SNIP>
>    ? native_queued_spin_lock_slowpath+0x81/0x300
>    </NMI>
>    <TASK>
>    ? __pfx_folio_activate_fn+0x10/0x10
>    _raw_spin_lock_irqsave+0x5b/0x70
>    folio_lruvec_lock_irqsave+0x62/0x90
>    folio_batch_move_lru+0x9d/0x160
>    folio_activate+0x95/0xe0
>    folio_mark_accessed+0x11f/0x160
>    filemap_read+0x343/0x3d0
> <SNIP>
>    blkdev_read_iter+0x6f/0x140
>    vfs_read+0x25b/0x340
>    ksys_read+0x67/0xf0
>    __x64_sys_read+0x19/0x20
>    x64_sys_call+0x1771/0x20d0
>
> This is the next one:
>
> watchdog: Watchdog detected hard LOCKUP on cpu 219
> CPU: 219 PID: 2584763 Comm: fs_racer_dir_cr Not tainted 6.10.0-rc3 #27
> RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> Call Trace:
>    <NMI>
>    ? show_regs+0x69/0x80
>    ? watchdog_hardlockup_check+0x1b4/0x3a0
> <SNIP>
>    ? native_queued_spin_lock_slowpath+0x2b4/0x300
>    </NMI>
>    <TASK>
>    _raw_spin_lock_irqsave+0x5b/0x70
>    folio_lruvec_lock_irqsave+0x62/0x90
>    __page_cache_release+0x89/0x2f0
>    folios_put_refs+0x92/0x230
>    __folio_batch_release+0x74/0x90
>    truncate_inode_pages_range+0x16f/0x520
>    truncate_pagecache+0x49/0x70
>    ext4_setattr+0x326/0xaa0
>    notify_change+0x353/0x500
>    do_truncate+0x83/0xe0
>    path_openat+0xd9e/0x1090
>    do_filp_open+0xaa/0x150
>    do_sys_openat2+0x9b/0xd0
>    __x64_sys_openat+0x55/0x90
>    x64_sys_call+0xe55/0x20d0
>    do_syscall_64+0x7e/0x130
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> When this happens, all-CPU backtrace shows a CPU being in
> isolate_lru_folios().
>
> >
> >> kernel: watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:270164=
9]
> >> kernel: CPU: 29 PID: 2701649 Comm: fio Tainted: G             L
> >> 6.10.0-rc3-mglru-irqstrc #24
> >> kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> >> kernel: Call Trace:
> >> kernel:  <IRQ>
> >> kernel:  ? show_regs+0x69/0x80
> >> kernel:  ? watchdog_timer_fn+0x223/0x2b0
> >> kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
> >> <SNIP>
> >> kernel:  </IRQ>
> >> kernel:  <TASK>
> >> kernel:  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> >> kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
> >> kernel:  _raw_spin_lock+0x38/0x50
> >> kernel:  clear_shadow_entry+0x3d/0x100
> >> kernel:  ? __pfx_workingset_update_node+0x10/0x10
> >> kernel:  mapping_try_invalidate+0x117/0x1d0
> >> kernel:  invalidate_mapping_pages+0x10/0x20
> >> kernel:  invalidate_bdev+0x3c/0x50
> >> kernel:  blkdev_common_ioctl+0x5f7/0xa90
> >> kernel:  blkdev_ioctl+0x109/0x270
> >> kernel:  x64_sys_call+0x1215/0x20d0
> >> kernel:  do_syscall_64+0x7e/0x130
> >>
> >> This happens to be contending on inode i_lock spinlock.
> >>
> >> Below preemptirqsoff trace points to preemption being disabled for mor=
e
> >> than 10s and the lock in picture is lruvec spinlock.
> >
> > Also if you could try the other patch (mglru.patch) please. It should
> > help reduce unnecessary rotations from deactivate_file_folio(), which
> > in turn should reduce the contention on the LRU lock for MGLRU.
>
> Currently testing is in progress with mglru.patch and MGLRU enabled.
> Will get back on the results.

Thank you.

