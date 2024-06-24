Return-Path: <linux-kernel+bounces-226971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1627991468B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C279F280E06
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139513210F;
	Mon, 24 Jun 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcIWAbuZ"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724B640BE5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719221958; cv=none; b=X/WjJKGq2J/VoQIHO7qk0pybSdDDMtkbvtMLojU6eki6Hmz4a4Qcp1mNm+YSJ4nBnu0qqHUSmbtQEBj/KB0eNAoFqRimJNLVrb8WvaQLSdjjnfeawuqc0R4TgXSYHz2vSsbzh8X2+cGGNUv0oSHHZ4VrxjGOIqXUYELeahjYomk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719221958; c=relaxed/simple;
	bh=6o8PP5ssnEcM/k9GK62CjBrCUTcoPNsBfR+m1bR0Lw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=NTy5EU9ihiNI2o3wsDFJCcS3cCfcFxxmYishxdvJMOKkDANqQpGHmZrL9l41sE3wwtRcCFPvUvNt68Efj6IuozApptO+VInJq19NjVM8Hhpflg64RAy9AAKuulUzYWk38kq63n/1ytrS1RiVLAKMbwZKw7Uva0sSYbEfUs9zCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcIWAbuZ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80d68861bf9so1063489241.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719221955; x=1719826755; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IoWqpu6r3gUVAVjJpJT9iCQKouKBD1EH5Hld1KMrMpM=;
        b=PcIWAbuZlRzsDhME7P5vS9DihhnV59BGEV60hd1xpWwFrXEX1jb/Ht2B7hdV3hHnxs
         wT32knwEGNe8vaRBZVw2W8pi97iMmA53FYEsQUyHRcvmhlyeG5colHiZpbPRIcRgE4t2
         tRbG4j/sIxseySh7Ialg4HYk26o0xwL/yIPGFoxllnoQFLwV99moAxu+UmfseoPpdFNU
         PlKzUaRm0Byz4nBJJE1OekdP3uclYcrWOZjp05ty8wnGAjZ3Ew+fDNBF1CcG1QO97nbt
         QOhmNNG2tKruESsthXmP8/MJavfkwATdEjOxWlH+Q6RMMn42iGDhplSDEjBR0ijT2Tkm
         0SUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719221955; x=1719826755;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoWqpu6r3gUVAVjJpJT9iCQKouKBD1EH5Hld1KMrMpM=;
        b=ZZIDnauZCJ4IgK/iBvnA8fXSjcwin2HkcLmDt58+JUS8KzQx3/mfqG12HeQw6vfWN9
         ElwO1CQTYjMfRNyCwLmaNKweRi6OZjxPS4N9DF2LfIqMP2m31Sa5nnMghvPqfScTb0Rc
         MRamVgi+EMk2Q+tOsStOZ6JqpuTMtyKsZhZyhN2XNbibrmQX1vD2Qj9BExFkuoGKO8lA
         ejB3kVrWTXFO54Rc6X8hId2LPO407oNBNH1S2FfvXBq7oHV+zIg4zRrVBM3q3O/hDCum
         8AESi5aJX2EI1S5uTpyFJR3v7JWLpL4wNH1dvjBjo+HcWDa0+gcQa7icTtT3OPA2iMKM
         qAmg==
X-Forwarded-Encrypted: i=1; AJvYcCV5NOzTk1wOTq5o62mnpk3DcM6LGtkxxURMaSVI0QxUz8G73FPk4bbGGWhUZpwRIwccKXQAsZZKlSql1JohCnECUrAz27iBC0HkmYgJ
X-Gm-Message-State: AOJu0Yxh0aTVjo8veaTuXBHQEsfpS2MSb/NLMlSQtb0wRviE+3eFjy84
	2sQOVKnEbZZpa4+mEM0sdeREJPsjO0OVQKdPYb092sLEwtOqR5v9t9HmpaBm3uPz9Zbbpk8y9jj
	6/03KtjEo5U9vA6b2d40hEZasNx1ThITpQ2jg
X-Google-Smtp-Source: AGHT+IHCUgNT5G+QF2omWXK3OQoPtsprTqEOTdUMRsBani2GJwAGTlfM9odozZN4RQihJXk6g3Dpe2OnZTSS5dadaiM=
X-Received: by 2002:a67:fb88:0:b0:48f:4396:38a2 with SMTP id
 ada2fe7eead31-48f52ba2552mr3288434137.34.1719221955135; Mon, 24 Jun 2024
 02:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008d1e5a061b666b11@google.com> <CANpmjNORLNHsWamYPU=rS7ftjZndchiEYHXznUS_RyR1edvrCA@mail.gmail.com>
 <3sldogk6uc4vxas366obosrgz6jwd4sms7edvsayt6l47aoieu@n5a4lee2rjnc>
In-Reply-To: <3sldogk6uc4vxas366obosrgz6jwd4sms7edvsayt6l47aoieu@n5a4lee2rjnc>
From: Marco Elver <elver@google.com>
Date: Mon, 24 Jun 2024 11:38:36 +0200
Message-ID: <CANpmjNM0NDhCANjUGRdF4STcqCdCX45OUmS5Ub0xDNtamkWCcw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mtree_range_walk /
 rcu_segcblist_enqueue (2)
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Marco Elver <elver@google.com>, 
	syzbot <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz, 
	RCU <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Jun 2024 at 19:31, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> * Marco Elver <elver@google.com> [240621 11:29]:
> > [+Cc rcu folks]
> >
> > On Fri, 21 Jun 2024 at 15:29, syzbot
> > <syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    50736169ecc8 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=164ec02a980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=704451bc2941bcb0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9bb7d0f2fdb4229b9d67
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/e4cbed12fec1/disk-50736169.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/d50b5dcae4cd/vmlinux-50736169.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/f2c14c5fcce2/bzImage-50736169.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+9bb7d0f2fdb4229b9d67@syzkaller.appspotmail.com
> > >
> > > ==================================================================
> > > BUG: KCSAN: data-race in mtree_range_walk / rcu_segcblist_enqueue
> > >
> > > write to 0xffff888104077308 of 8 bytes by task 12265 on cpu 1:
> > >  rcu_segcblist_enqueue+0x67/0xb0 kernel/rcu/rcu_segcblist.c:345
> > >  rcutree_enqueue kernel/rcu/tree.c:2940 [inline]
> > >  call_rcu_core kernel/rcu/tree.c:2957 [inline]
> > >  __call_rcu_common kernel/rcu/tree.c:3093 [inline]
> > >  call_rcu+0x1bd/0x430 kernel/rcu/tree.c:3176
> > >  ma_free_rcu lib/maple_tree.c:197 [inline]
> > >  mas_free lib/maple_tree.c:1304 [inline]
> > >  mas_replace_node+0x2f8/0x440 lib/maple_tree.c:1741
> > >  mas_wr_node_store lib/maple_tree.c:3956 [inline]
> > >  mas_wr_modify+0x2bc3/0x3c90 lib/maple_tree.c:4189
> > >  mas_wr_store_entry+0x250/0x390 lib/maple_tree.c:4229
> > >  mas_store_prealloc+0x151/0x2b0 lib/maple_tree.c:5485
> > >  vma_iter_store mm/internal.h:1398 [inline]
> > >  vma_complete+0x3a7/0x760 mm/mmap.c:535
> > >  __split_vma+0x623/0x690 mm/mmap.c:2440
> > >  split_vma mm/mmap.c:2466 [inline]
> > >  vma_modify+0x198/0x1f0 mm/mmap.c:2507
> > >  vma_modify_flags include/linux/mm.h:3347 [inline]
> > >  mprotect_fixup+0x335/0x610 mm/mprotect.c:637
> > >  do_mprotect_pkey+0x673/0x9a0 mm/mprotect.c:820
> > >  __do_sys_mprotect mm/mprotect.c:841 [inline]
> > >  __se_sys_mprotect mm/mprotect.c:838 [inline]
> > >  __x64_sys_mprotect+0x48/0x60 mm/mprotect.c:838
> > >  x64_sys_call+0x26f5/0x2d70 arch/x86/include/generated/asm/syscalls_64.h:11
> > >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > read to 0xffff888104077308 of 8 bytes by task 12266 on cpu 0:
> > >  mtree_range_walk+0x140/0x460 lib/maple_tree.c:2774
> > >  mas_state_walk lib/maple_tree.c:3678 [inline]
> > >  mas_walk+0x16e/0x320 lib/maple_tree.c:4909
> > >  lock_vma_under_rcu+0x84/0x260 mm/memory.c:5840
> > >  do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
> > >  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
> > >  exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
> > >  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 0 PID: 12266 Comm: syz-executor.3 Not tainted 6.10.0-rc4-syzkaller-00148-g50736169ecc8 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
> > > ==================================================================
> >
> > This is not an ordinary data race. I suspect this to be an incorrect
> > use of RCU, resulting in some kind of use-after-free / type-confusion.
> >
> > The access within rcu_segcblist_enqueue() is to maple_node::rcu (at
> > offset 8 into maple_node). The racing access in mtree_range_walk() is
> > to either maple_node::mr64::pivot[0] or maple_node::ma64::pivot[0]
> > (both also offset 8 into maple_node).
>
> Since it's not freed and the reader holds the RCU read lock, there is no
> use-after-free risk here.
>
> Both are at offset 8 of the node, but there is no type confusion.
>
> This is a false positive, which I can explain.
>
> The reader at mtree_range_walk() at 2774 reads piv[0] at offset 8, but
> will validate the information by checking the parent pointer at offset 0
> prior to using the value.  In this case the check is on line 2793: if
> (unlikely(ma_dead_node(node)))...
>
> In the case of the reader having stale data, the data is thrown away and
> the walk is started again.  This node is already taken out of the tree
> and will not be encountered again.
>
> Note that all types have the same parent pointer (of undefined type
> struct maple_pnode *, to catch type confusion at compile time) at offset
> 0.
>
> On the writer side, the struct maple_pnode *parent is set to the address
> of the node itself.  When this happens,
> lib/maple_tree.c:mte_set_node_dead() is called to set the parent parent
> pointer and smp_wmb();  This corresponds to ma_dead_node() or
> mte_dead_node() that uses smp_rmb(); prior to reading the parent
> pointer.

Thanks for the explanation.

> I ran though this all with Paul (embarrassingly, a while back), and I
> believe (if my notes are correct..) the fix I need here is to use
> rcu_assign_pointer() in mte_set_node_dead() to make the checks here
> happy.

I see - though rcu_assign_pointer() isn't directly affecting the data
race reported here. The read of pivot[0] at lib/maple_tree.c:2774 will
always remain data-racy against the write inside
rcu_segcblist_enqueue() after a reuse. Assuming the
read-then-revalidate pattern makes the data race benign, the only
thing that may be helpful is explicitly mark the data-racy access
(more documentation about it at [1]):

  /*
   * ... explanation ...
   */
  if (data_race(pivots[0] >= mas->index)) {

The only benefit would be to clearly document what is happening (helps
tooling like KCSAN to shut up about it, but also humans trying to grok
what's going on because it's not obvious). I wouldn't mind sending a
patch, but would just end up copying your explanation, so I'll leave
it to you what to do with it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/access-marking.txt

Thanks,
-- Marco

