Return-Path: <linux-kernel+bounces-409634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E249C8F96
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3591F20FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF11990C4;
	Thu, 14 Nov 2024 16:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNj54mrH"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208118A92A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601141; cv=none; b=J9lyrA0GRYtSRJaYxHMimEAgtqRZqjcDwQ/wkfx5Ct1DDPgjLxremb30JZ9toD/P3D0lFc5uj+AjbY7YuTBptsLW4WCtQnv53taoxHj/to0L51Z2tBJjUUj/lUIGVxKxiYsjkD6vDpzerZta9aJAOFNdVv5UNEUp7PDtXPQfrQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601141; c=relaxed/simple;
	bh=60e54OKonhowHbWNRMiLy693DPV+mWc2iL1olH8CF74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j9kqU4Q2t37bKXCCk1WjZ0XcAi3nC+IeBWNUWomA/I3HDSdiBTynzB+paIt5+C0NnmWngnNJbsvxxp0vH5oimRdo9PQeP8HCFI9ybJECaa53LbCQwiI6xOwZNeURewyfHjgFyXZjoGAPoMvpqhNzjmV1Dyau1/4hVMV+nOjbNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNj54mrH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4635b03a3cdso172391cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731601138; x=1732205938; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKBFPyDpG0DZLpYX58E37SKTdIlh5Yx8PAsqBjBLq3c=;
        b=zNj54mrHqhXEA95AFqJAEoZC7qF1frvnMtx/bFF5TaL/0dH8+RJ5oAlzWhQuS4yWrv
         hrxGorbT4c0VIrXD742acgdcAyun+L4bI2M6yuCWOOUwKqBbLmDZ8eDH9/ea/ugFVv9b
         eTEtw4xsa+MJQ/Pi9v9Ldtc2XO7YdfGQzCddeW1l8fOj1MY3NwqfA2B/3ONpHvbDFWAJ
         mz9ImZdxs6+h+KwqQnmx2o78Ts39bwMLBK3A+KOyyeu7SzsN7MsgOOf2GyrTtCzcLzzv
         JiWO7EN9WLzYQ2MT0OQ40qsC2CteW9aXUKLn0yjQ0LjKLtPp7cElkMTlTqHEEsFJ6wkc
         nlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731601138; x=1732205938;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKBFPyDpG0DZLpYX58E37SKTdIlh5Yx8PAsqBjBLq3c=;
        b=ibSyLo1yGIPG4dZfB7YwfY2MCMj7LLkiy9vLdUVPeDSsdldau92Rc4S975ilEWebx5
         TILWgCI13yaBHv7LNdZijRlqcz3kmKYe1cuR/k1Yl+CjKs4Y3kuwbxoqeT5eDwlMNgtW
         J0Zl07Gnl/Lr6iTUGm3AHb9x8aWSnnL8UEdriZTVJ5AtwWV5YKwk9mX7Mu6Sa+LBJoHs
         z/ifZj6vT0f8aS4qXmMDn1Stbq/Q/ZHNSwussBFVtXysjF5LRaFhywCodoDv9OQS8SBs
         W94WUmqKWWtO6SIJV0CtiTEfIEp0KdPBQYM1ZaKRZqjacQzevVcQIoh6UlOlJt4w7gEr
         hSng==
X-Forwarded-Encrypted: i=1; AJvYcCWeVgF2uVmQRu08OlInbeJl/B0wcI5WxQXqC/P8nr546yyrt8tUcJ4etvZkGQnhvn+Q5I1ZNBG/xE+G/kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL2nNk/hcIPKzRnX9zSKbL/gtkIli6t8ZJseQzX7b1JAt58Dc6
	OvsSC7uo+BDcfvk/4VSyYDN8mXJGddwM6mN5LCdS2OfeRsfarXNaD8vukjGoTp71IevopD3LNwf
	5E8OvnKQejHny6lLBp0XuYnuxck6QNeTG0Npv
X-Gm-Gg: ASbGncsl3reqC2O58hl/K0GRhE5k+nAiiFn8XwU6aXewRUVUxxhCVaZ6TnsJj4ti6Sc
	0jP10hTUuFcO5XI8aj8iJoHlPxK2HN4zijDy9lMFzSm7oQc8PjMU6M9+hZfsZCg==
X-Google-Smtp-Source: AGHT+IHqYIg7U+CrWVjFtXE+tQkUDF5NR0AG+Em2XDri9p3SsXmXob/NyUrItbaDN5cKZUD/VTFF5tH6/FiAskeGJ+I=
X-Received: by 2002:a05:622a:3ca:b0:460:f093:f259 with SMTP id
 d75a77b69052e-463572ad5c8mr3719181cf.22.1731601138301; Thu, 14 Nov 2024
 08:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com> <20241112194635.444146-5-surenb@google.com>
 <54b8d0b9-a1c7-4c1b-a588-2e5308a977fb@suse.cz> <sdfh56itaffzhpk4rft2tsjm7r44auhjomfthzgxzrmj5632eq@noi2uhgp3a3h>
 <ZzSwM5qwStadOZvv@casper.infradead.org> <k26pa6fhn2j6bgfwtcdp6u5vk25mkclitzvqqeqvji77k4lqop@yowwrqusmdyp>
 <CAJuCfpHjuMWCzeONq2YOOkr1JGH=E=xn=BAcjQyo_=P1cz=crA@mail.gmail.com>
 <aa4i3inhnkyi6yazttb55khbm7swt7xq2sklmhp5y63kxw7bsc@i4wlyyzoo7h3>
 <CAJuCfpF_fEVwyDAStueNoEW=MNS5MoLPc1RaQMaOHZxODmw_0A@mail.gmail.com> <CAJuCfpFd1-hH=gmzyosZiebp8X=F9h-jTt1dXiMpZovsL8O=rQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFd1-hH=gmzyosZiebp8X=F9h-jTt1dXiMpZovsL8O=rQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 14 Nov 2024 08:18:47 -0800
Message-ID: <CAJuCfpGMQpHroxzzrR_pwLKRS=znchqNQK7EoWVEudACNnC_Cg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 11:05=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Wed, Nov 13, 2024 at 7:47=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 7:29=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Suren Baghdasaryan <surenb@google.com> [241113 10:25]:
> > > > On Wed, Nov 13, 2024 at 7:23=E2=80=AFAM 'Liam R. Howlett' via kerne=
l-team
> > > > <kernel-team@android.com> wrote:
> > > > >
> > > > > * Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> > > > > > On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote=
:
> > > > > > > > Hi, I was wondering if we actually need the detached flag. =
Couldn't
> > > > > > > > "detached" simply mean vma->vm_mm =3D=3D NULL and we save 4=
 bytes? Do we ever
> > > > > > > > need a vma that's detached but still has a mm pointer? I'd =
hope the places
> > > > > > > > that set detached to false have the mm pointer around so it=
's not inconvenient.
> > > > > > >
> > > > > > > I think the gate vmas ruin this plan.
> > > > > >
> > > > > > But the gate VMAs aren't to be found in the VMA tree.  Used to =
be that
> > > > > > was because the VMA tree was the injective RB tree and so VMAs =
could
> > > > > > only be in one tree at a time.  We could change that now!
> > > > >
> > > > > \o/
> > > > >
> > > > > >
> > > > > > Anyway, we could use (void *)1 instead of NULL to indicate a "d=
etached"
> > > > > > VMA if we need to distinguish between a detached VMA and a gate=
 VMA.
> > > > >
> > > > > I was thinking a pointer to itself vma->vm_mm =3D vma, then a che=
ck for
> > > > > this, instead of null like we do today.
> > > >
> > > > The motivation for having a separate detached flag was that vma->vm=
_mm
> > > > is used when read/write locking the vma, so it has to stay valid ev=
en
> > > > when vma gets detached. Maybe we can be more cautious in
> > > > vma_start_read()/vma_start_write() about it but I don't recall if
> > > > those were the only places that was an issue.
> > >
> > > We have the mm form the callers though, so it could be passed in?
> >
> > Let me try and see if something else blows up. When I was implementing
> > per-vma locks I thought about using vma->vm_mm to indicate detached
> > state but there were some issues that caused me reconsider.
>
> Yeah, a quick change reveals the first mine explosion:
>
> [    2.838900] BUG: kernel NULL pointer dereference, address: 00000000000=
00480
> [    2.840671] #PF: supervisor read access in kernel mode
> [    2.841958] #PF: error_code(0x0000) - not-present page
> [    2.843248] PGD 800000010835a067 P4D 800000010835a067 PUD 10835b067 PM=
D 0
> [    2.844920] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [    2.846078] CPU: 2 UID: 0 PID: 1 Comm: init Not tainted
> 6.12.0-rc6-00258-ga587fcd91b06-dirty #111
> [    2.848277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    2.850673] RIP: 0010:unmap_vmas+0x84/0x190
> [    2.851717] Code: 00 00 00 00 48 c7 44 24 48 00 00 00 00 48 c7 44
> 24 18 00 00 00 00 48 89 44 24 28 4c 89 44 24 38 e8 b1 c0 d1 00 48 8b
> 44 24 28 <48> 83 b8 80 04 00 00 00 0f 85 dd 00 00 00 45 0f b6 ed 49 83
> ec 01
> [    2.856287] RSP: 0000:ffffa298c0017a18 EFLAGS: 00010246
> [    2.857599] RAX: 0000000000000000 RBX: 00007f48ccbb4000 RCX: 00007f48c=
cbb4000
> [    2.859382] RDX: ffff8918c26401e0 RSI: ffffa298c0017b98 RDI: ffffa298c=
0017ab0
> [    2.861156] RBP: 00007f48ccdb6000 R08: 00007f48ccdb6000 R09: 000000000=
0000001
> [    2.862941] R10: 0000000000000040 R11: ffff8918c2637108 R12: 000000000=
0000001
> [    2.864719] R13: 0000000000000001 R14: ffff8918c26401e0 R15: ffffa298c=
0017b98
> [    2.866472] FS:  0000000000000000(0000) GS:ffff8927bf080000(0000)
> knlGS:0000000000000000
> [    2.868439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.869877] CR2: 0000000000000480 CR3: 000000010263e000 CR4: 000000000=
0750ef0
> [    2.871661] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [    2.873419] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [    2.875185] PKRU: 55555554
> [    2.875871] Call Trace:
> [    2.876503]  <TASK>
> [    2.877047]  ? __die+0x1e/0x60
> [    2.877824]  ? page_fault_oops+0x17b/0x4a0
> [    2.878857]  ? exc_page_fault+0x6b/0x150
> [    2.879841]  ? asm_exc_page_fault+0x26/0x30
> [    2.880886]  ? unmap_vmas+0x84/0x190
> [    2.881783]  ? unmap_vmas+0x7f/0x190
> [    2.882680]  vms_clear_ptes+0x106/0x160
> [    2.883621]  vms_complete_munmap_vmas+0x53/0x170
> [    2.884762]  do_vmi_align_munmap+0x15e/0x1d0
> [    2.885838]  do_vmi_munmap+0xcb/0x160
> [    2.886760]  __vm_munmap+0xa4/0x150
> [    2.887637]  elf_load+0x1c4/0x250
> [    2.888473]  load_elf_binary+0xabb/0x1680
> [    2.889476]  ? __kernel_read+0x111/0x320
> [    2.890458]  ? load_misc_binary+0x1bc/0x2c0
> [    2.891510]  bprm_execve+0x23e/0x5e0
> [    2.892408]  kernel_execve+0xf3/0x140
> [    2.893331]  ? __pfx_kernel_init+0x10/0x10
> [    2.894356]  kernel_init+0xe5/0x1c0
> [    2.895241]  ret_from_fork+0x2c/0x50
> [    2.896141]  ? __pfx_kernel_init+0x10/0x10
> [    2.897164]  ret_from_fork_asm+0x1a/0x30
> [    2.898148]  </TASK>
>
> Looks like we are detaching VMAs and then unmapping them, where
> vms_clear_ptes() uses vms->vma->vm_mm. I'll try to clean up this and
> other paths and will see how many changes are required to make this
> work.

Ok, my vma->detached deprecation effort got to the point that my QEMU
boots. The change is not pretty and I'm quite sure I did not cover all
cases yet (like hugepages):

 arch/arm/kernel/process.c             |   2 +-
 arch/arm64/kernel/vdso.c              |   4 +-
 arch/loongarch/kernel/vdso.c          |   2 +-
 arch/powerpc/kernel/vdso.c            |   2 +-
 arch/powerpc/platforms/pseries/vas.c  |   2 +-
 arch/riscv/kernel/vdso.c              |   4 +-
 arch/s390/kernel/vdso.c               |   2 +-
 arch/s390/mm/gmap.c                   |   2 +-
 arch/x86/entry/vdso/vma.c             |   2 +-
 arch/x86/kernel/cpu/sgx/encl.c        |   2 +-
 arch/x86/um/mem_32.c                  |   2 +-
 drivers/android/binder_alloc.c        |   2 +-
 drivers/gpu/drm/i915/i915_mm.c        |   4 +-
 drivers/infiniband/core/uverbs_main.c |   4 +-
 drivers/misc/sgi-gru/grumain.c        |   2 +-
 fs/exec.c                             |   2 +-
 fs/hugetlbfs/inode.c                  |   3 +-
 include/linux/mm.h                    | 111 +++++++++++++++++---------
 include/linux/mm_types.h              |   6 --
 kernel/bpf/arena.c                    |   2 +-
 kernel/fork.c                         |   6 +-
 mm/debug_vm_pgtable.c                 |   2 +-
 mm/internal.h                         |   2 +-
 mm/madvise.c                          |   4 +-
 mm/memory.c                           |  39 ++++-----
 mm/mmap.c                             |   9 +--
 mm/nommu.c                            |   6 +-
 mm/oom_kill.c                         |   2 +-
 mm/vma.c                              |  62 +++++++-------
 mm/vma.h                              |   2 +-
 net/ipv4/tcp.c                        |   4 +-
 31 files changed, 164 insertions(+), 136 deletions(-)

Many of the unmap_* and zap_* functions should get an `mm` parameter
to make this work.
So, if we take this route, it should definitely be a separate patch,
which will likely cause some instability issues for some time until
all the edge cases are ironed out. I would like to proceed with this
patch series first before attempting to deprecate vma->detached. Let
me know if you have objections to this plan.

>
> >
> > >
> > > >
> > > > >
> > > > > Either way, we should make it a function so it's easier to reuse =
for
> > > > > whatever we need in the future, wdyt?
> > > > >
> > > > > To unsubscribe from this group and stop receiving emails from it,=
 send an email to kernel-team+unsubscribe@android.com.
> > > > >

