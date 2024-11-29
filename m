Return-Path: <linux-kernel+bounces-420855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5581E9D83EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28D0B28999
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461CE192D87;
	Mon, 25 Nov 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMj66Qtp"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8591925A6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732531502; cv=none; b=FV072EE/nsThVJvQ4GbsNk3V7a/JCbz2CbY/HJziRe6FHomN10fl2C+8nLvlVCKqGXWAuSx8YazU8E3FDPBnkYYQW6yQerFmd1qnK/BVfxfJ7nkxmd9bUW70LefFHTN1aU349H39DhlqFcv3qNE1RuMtOtVqSOCNWeL830vQhLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732531502; c=relaxed/simple;
	bh=kZdaHAQtCHnFnRq3H97r0Ug52tXwPXrGYKr2qs1glFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYmDt9uPtZf8HgQcsLO2zbGn85RjjooAE9m1FUizk0CxXycbopJbSSEB9fNuME2pv5bu7mT3V2WYZEGDJcltOQOfcjZDyKAIwvIahA+V4CavTibobC6580CZ/yl8rxcAk+nZDhf9Fz9mBcMRNv66xsTlZL2nWm8cYSY1kQ6s918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMj66Qtp; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea47651a10so250279b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732531500; x=1733136300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2ywDb4pqcHbTILd3FflHBb9fI4CP4o/IDmngu0zY28=;
        b=OMj66QtpuQRD96RiRmlnRtpz/20HkvtwAbuKCpv1AjF9m47AE+iGCP0xfP0WWX12ch
         3U6k2yVFD/d7+OX9VYMTTRgumU53tJSNZWa3bmL74xWb2RvjMHD3bBZVVABz5DDRf7s0
         OmxlNhOsjHH8SOwgN3rtGXS4TyzIpyL7qYDuuN4RV8CT1niyL9K4clUfxHe8kzfnfBz3
         gXjgphODpw8HTeSmxkffoppzobNgUXK8inS4MT/hYVYuPR0VmbAylnqOkFZCzlyZ9fjl
         uItT5RhxjPrtRbV7jhW3n7nV2XJUlYbfjJ5gtuTpM1r/RZqcSA6oANW7T3gXsBVEKOMT
         OPEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732531500; x=1733136300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2ywDb4pqcHbTILd3FflHBb9fI4CP4o/IDmngu0zY28=;
        b=HkKbI510p0BCtTKL+D+WYmd7crugTB7XmPftl+CM4GdEJoiDuSMUVtLfmU2kCpdu5K
         sjWIXEt5mRTcC8Lfus13ztvCp+ppD96nuTGx9JrzVuEptlDD7XP19i5mY0mRISOrrveW
         17mqlI1nYLVbZhJLCZSkn63T8WYYVm1YIjClNSG82u3suNSuAWM8p7rNoEfLmsOBmpet
         J13GNFj4dDK/McvZCqbPCwm7NHXsDoiWSlNTFMD8cgJi7reskJng5pr92YeF+SQ5s73F
         P78pSp+Du2k6Sm/KuGdlB4vYkzgW7mnZU5y80mQNnYUTrPcDAlHi9XwPFL1t8/Fg75pD
         dTcw==
X-Forwarded-Encrypted: i=1; AJvYcCWZWIqXXJSohpp3PuwzejcnBUciDeC/F3IrnQ6LHheBPBY5OqT1363wDYE4prYlaKiddZnhdbFcbldqFvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoCPCpao+We3V5mka5zh6n9N9fqMhWg+reUgA0XY0jfCeCkiRO
	9zGFnTbMSW9LL+grCuoUu1qRkejd99tT9HRCINGZsTubVJVcWZsTYlOlFHGhHlc3qyN5nAI13JV
	AikAPJEkGPCz/k3Z0ojS4LK1DCGbn1VmOuVzp
X-Gm-Gg: ASbGncuoVXSZeUdOiqWea5h4yBcnVtTiJdEPzfuBSBBVqj8SKe1Igu2QHTV8ynpsuFz
	4Z5u+l0+daLat6Y0Ivgc2QaHAFS9uhYz0zreU3wy3/knv/0gvwHp2aSuPBU4mlw==
X-Google-Smtp-Source: AGHT+IH8TwjCvQn3Y6hEpYBfkn+q5l9OPxBB2DzQD1EFl2WttTCP0fZZCnC5hlT6wr5ifs2eGd9Q1HKmy9NrK+jFSMo=
X-Received: by 2002:a05:6808:1882:b0:3e6:1057:21af with SMTP id
 5614622812f47-3e915af0592mr8691789b6e.41.1732531499790; Mon, 25 Nov 2024
 02:44:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67432dee.050a0220.1cc393.0041.GAE@google.com> <Z0OaHcMWcRtohZfz@casper.infradead.org>
 <b57b3d18-7a70-4efa-a356-809c6ab29c02@suse.com>
In-Reply-To: <b57b3d18-7a70-4efa-a356-809c6ab29c02@suse.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 25 Nov 2024 11:44:48 +0100
Message-ID: <CANp29Y7KjqP9h1ONFG5LW=3Nc0RWgcdj4PmAszqze0azPpvdLg@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: Qu Wenruo <wqu@suse.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 1:30=E2=80=AFAM 'Qu Wenruo' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
>
> =E5=9C=A8 2024/11/25 07:56, Matthew Wilcox =E5=86=99=E9=81=93:
> > On Sun, Nov 24, 2024 at 05:45:18AM -0800, syzbot wrote:
> >>
> >>   __fput+0x5ba/0xa50 fs/file_table.c:458
> >>   task_work_run+0x24f/0x310 kernel/task_work.c:239
> >>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> >>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
> >>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
> >>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >>   syscall_exit_to_user_mode+0x13f/0x340 kernel/entry/common.c:218
> >>   do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
> >>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > This is:
> >
> >          VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> >
> > ie we've called __folio_start_writeback() on a folio which is already
> > under writeback.
> >
> > Higher up in the trace, we have the useful information:
> >
> >   page: refcount:6 mapcount:0 mapping:ffff888077139710 index:0x3 pfn:0x=
72ae5
> >   memcg:ffff888140adc000
> >   aops:btrfs_aops ino:105 dentry name(?):"file2"
> >   flags: 0xfff000000040ab(locked|waiters|uptodate|lru|private|writeback=
|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> >   raw: 00fff000000040ab ffffea0001c8f408 ffffea0000939708 ffff888077139=
710
> >   raw: 0000000000000003 0000000000000001 00000006ffffffff ffff888140adc=
000
> >   page dumped because: VM_BUG_ON_FOLIO(folio_test_writeback(folio))
> >   page_owner tracks the page as allocated
> >
> > The interesting part of the page_owner stacktrace is:
> >
> >    filemap_alloc_folio_noprof+0xdf/0x500
> >    __filemap_get_folio+0x446/0xbd0
> >    prepare_one_folio+0xb6/0xa20
> >    btrfs_buffered_write+0x6bd/0x1150
> >    btrfs_direct_write+0x52d/0xa30
> >    btrfs_do_write_iter+0x2a0/0x760
> >    do_iter_readv_writev+0x600/0x880
> >    vfs_writev+0x376/0xba0
> >
> > (ie not very interesting)
> >
> >> Workqueue: btrfs-delalloc btrfs_work_helper
> >> RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:311=
9
> >> Call Trace:
> >>   <TASK>
> >>   process_one_folio fs/btrfs/extent_io.c:187 [inline]
> >>   __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
> >>   submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
> >>   submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
> >>   run_ordered_work fs/btrfs/async-thread.c:245 [inline]
> >>   btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
> >>   process_one_work kernel/workqueue.c:3229 [inline]
> >
> > This looks like a race?
> >
> > process_one_folio() calls
> > btrfs_folio_clamp_set_writeback calls
> > btrfs_subpage_set_writeback:
> >
> >          spin_lock_irqsave(&subpage->lock, flags);
> >          bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sector=
size_bits)
> > ;
> >          if (!folio_test_writeback(folio))
> >                  folio_start_writeback(folio);
> >          spin_unlock_irqrestore(&subpage->lock, flags);
> >
> > so somebody else set writeback after we tested for writeback here.
>
> The test VM is using X86_64, thus we won't go into the subpage routine,
> but directly call folio_start_writeback().
>
> >
> > One thing that comes to mind is that _usually_ we take folio_lock()
> > first, then start writeback, then call folio_unlock() and btrfs isn't
> > doing that here (afaict).  Maybe that's not the source of the bug?
>
> We still hold the folio locked, do submission then unlock.
>
> You can check extent_writepage(), where at the entrance we check if the
> folio is still locked.
> Then inside extent_writepage_io() we do the submission, setting the
> folio writeback inside submit_one_sector().
> Eventually unlock the folio at the end of extent_writepage(), that's for
> the uncompressed writes.
>
> There are a lot of special handling for async submission (compression),
> but it  still holds the folio locked, do compression and submission, and
> unlock, just all in another thread (this case).
>
> So it looks like something is wrong when transferring the ownership of
> the page cache folios to the compression path, or some not properly
> handled error path.
>
> Unfortunately I'm not really able to reproduce the case using the
> reproducer...

I've just tried to reproduce locally using the downloadable assets and
the kernel crashed ~ after 1 minute of running the attached C repro.

[   87.616440][ T9044] ------------[ cut here ]------------
[   87.617126][ T9044] kernel BUG at mm/page-writeback.c:3119!
[   87.619308][ T9044] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PT=
I
[   87.620174][ T9044] CPU: 1 UID: 0 PID: 9044 Comm: kworker/u10:6 Not
tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0

Here are the instructions I followed:
https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#run-a=
-c-reproducer

--=20
Aleksandr

>
> Thanks,
> Qu
>
>
>
> >
> > If it is, should we have a VM_BUG_ON_FOLIO(!folio_test_locked(folio), f=
olio)
> > in __folio_start_writeback()?  Or is there somewhere that can't lock th=
e
> > folio before starting writeback?
> >
>

