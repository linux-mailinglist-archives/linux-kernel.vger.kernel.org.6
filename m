Return-Path: <linux-kernel+bounces-413222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4912D9D154F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19909B25F10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0291B6CFC;
	Mon, 18 Nov 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nK40frOo"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348452F9B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947051; cv=none; b=u945viLAZ9sU+Y0DcgRs0lM3zQ0wTH8+q9OQiWnVwv43e3Rei0NggcVwHwE/jgcJAbNlbTCDlw64wu6vzJ98WMq9RqE5nJaowHNCYyQz1TydONpax/Z54zF0uNfrqo7iwI5TcW0yY78RCbDW4mXNpEVkeGj8Hy6Trg8rEUCy7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947051; c=relaxed/simple;
	bh=Rzrk7NRObvGTpzGoTrqEGc8y+Ku7lQ2ZOutSUE561Kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud0LXGGdMtbGXq3sk5l53banEVj5aYWt3Sd2kYjll/IWhcodkREmZKcsmUadEJRHpVP4hDCYvF+hGsTZYuxhi15a2nnE7kGZjVrZtbUYYrBkoRVatDjkI/O2VwcsnGdOpxFkWnRqz94y4U+CVSRtKEnFIe8ou5qz5sgGWkSDYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nK40frOo; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4608dddaa35so619321cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731947048; x=1732551848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8j8A9TEvQ309R/AqZCZsNZN5dSZhCEUwO8WMgBqgnk=;
        b=nK40frOogpx21UgXZ0jZGu40l7JsAAt2FZg27LyOh25D11rL6NKmDPtcSIWdRpCEXm
         Au4S35Hgx6ONM08xpfQasJNeP1M9Yjh30qeOMZOHAyiTUMle0oEeqLkVYHEsZDD25wT5
         BD3ttbrZSoOIWFcLKA/tuG1iCjIwC+/atSzS+p9wKfTDXpOnVbbTnUGK2eImj9NhbUOR
         KiZrwMW6u/9di7dviznjyORN5zf+ZJRgNi+P5QdN8z9ICbU42sDrEY9q48BoDO89Aw0r
         8Wx6XltTMFvQYOPWtOiqfCa6gErp21DPbaqJ4MJdBKkCLvfdbuRNItd12aSq9QDRQ3jN
         iNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947048; x=1732551848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8j8A9TEvQ309R/AqZCZsNZN5dSZhCEUwO8WMgBqgnk=;
        b=xIDMKGoqKr93i6U3hvN8k5SodP/fCuVFDrSkKegeoDECtpNzQTmm9JYXRey8PYDMlo
         bbHByAIThKnx2mlsVmBZEsEKUZ1BRRwEewNKUnNPU9pM8j3Z7eK3qBotXSukAjNAQa70
         MsLOPMZsxu972YIiqCfivRCRFEpDuVRVXIdlJwEJdYoOaLP4kmpTFBDFOLA/UzwMCWI4
         nVLQ3gzdU70NsxhFYucrChiXcOBygLkf+/j/9bN0X7QlheZynhtLlKDVbPZ1DCegiq+F
         2LSXKW/nEK3uom19xA4bZezm4+OBX15lnXb9pw0mldrCTj4bIK1td3LkRRGbHYeRwKqv
         aCVA==
X-Forwarded-Encrypted: i=1; AJvYcCU9CRxZwutildwmMYK25XO5OLr2jCtmweeyZF1GatHe74aIIRIsINudeJkStc68z3f1gaXt0vwGKbifzYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxbqhYhKQdqADzULK6MjQWlOxy2RvndBZVLp5ryKCCMxHqQEVe
	sw9jAWthJ55xl4HIb8CniU4KdcPoh3WLz46tAgLj7MinC7paUQ0uSLydATp+KZT3w67Viw5Jy73
	/N+wGM+M3gUbSVYjf4R7HZ/JR6rM4tzfOB1zB
X-Gm-Gg: ASbGncubSH8SU0xnAH7HrjAQfdoL5nVOmofbYe4hn5U8HqwAWn9qfEXgVgQVjoHZT6N
	13/JQ91ojz552GqyLxCo5NwbSkZEJpjQ=
X-Google-Smtp-Source: AGHT+IGP3CXNivDiWSBXoE7dzuqgigM+ihRudnRSxiIU1MbvnX8eMbSVUqPr9MnjNVmCcSfBYkoVvaOPDQQiG8GHKIU=
X-Received: by 2002:a05:622a:341:b0:461:358e:d635 with SMTP id
 d75a77b69052e-46370107ddamr6583751cf.18.1731947047774; Mon, 18 Nov 2024
 08:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241117080931.600731-1-surenb@google.com> <20241117080931.600731-4-surenb@google.com>
 <8e651b4d-ecdf-4b73-9ca9-c3537da63122@lucifer.local>
In-Reply-To: <8e651b4d-ecdf-4b73-9ca9-c3537da63122@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 Nov 2024 08:23:56 -0800
Message-ID: <CAJuCfpEndxOkTZ0r+MdQWv05tb5koC1KnUWfVszZi2L8FUZh6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: mark vma as detached until it's added into vma tree
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:10=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> So, this causes VMAs which are already attached to be marked attached
> again, and when the check added in "mm: make vma cache
> SLAB_TYPESAFE_BY_RCU", which is:
>
> static inline void vma_mark_attached(struct vm_area_struct *vma)
> {
>         /* vma shoudn't be already attached */
>         VM_BUG_ON_VMA(!vma->detached, vma); <-------- here
>
>         ...
> }
>
> Is executed, it fails and asserts on boot, as per the below (I ran
> addr2line and identified this as the cause).
>
> [    0.615256] vma ffff88810086e000 start 00007ffedf98e000 end 00007fffff=
fff000 mm ffff888101bf0000
> [    0.615256] prot 8000000000000025 anon_vma ffff88810026c000 vm_ops 000=
0000000000000
> [    0.615256] pgoff 7fffffffe file 0000000000000000 private_data 0000000=
000000000
> [    0.615256] flags: 0x118173(read|write|mayread|maywrite|mayexec|growsd=
own|seqread|randread|account)
> [    0.616232] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [    0.616416] CPU: 3 UID: 0 PID: 1 Comm: init Not tainted 6.12.0-rc6+ #9
> [    0.616618] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S Arch Linux 1.16.3-1-1 04/01/2014
> [    0.616914] RIP: 0010:commit_merge+0x361/0x390
> [    0.617059] Code: 28 e9 58 fd ff ff 49 39 44 24 10 72 c7 e9 81 fe ff f=
f 48 39 57 10 0f 82 1d ff ff ff e9 1c ff ff ff 48 89 c7 e8 70 0
> [    0.617609] RSP: 0018:ffffc90000013a48 EFLAGS: 00010292
> [    0.617778] RAX: 0000000000000138 RBX: ffffc90000013b68 RCX: 000000000=
0000000
> [    0.617995] RDX: 0000000000000003 RSI: ffffc900000138d0 RDI: 000000000=
0000001
> [    0.618209] RBP: 0000000000000000 R08: 00000000ffffdfff R09: ffffffff8=
2b089a8
> [    0.618429] R10: 0000000000000003 R11: 30203a7367616c66 R12: 000000000=
0000000
> [    0.618653] R13: 0000000000000001 R14: 0000000000000000 R15: ffffc9000=
0013a58
> [    0.618846] FS:  0000000000000000(0000) GS:ffff888263d80000(0000) knlG=
S:0000000000000000
> [    0.619041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.619186] CR2: 0000000000000000 CR3: 0000000101c74000 CR4: 000000000=
0750ef0
> [    0.619357] PKRU: 55555554
> [    0.619425] Call Trace:
> [    0.619491]  <TASK>
> [    0.619546]  ? __die_body.cold+0x19/0x2a
> [    0.619644]  ? die+0x29/0x50
> [    0.619719]  ? do_trap+0xc5/0x110
> [    0.619808]  ? do_error_trap+0x60/0x80
> [    0.619901]  ? commit_merge+0x361/0x390
> [    0.619995]  ? exc_invalid_op+0x51/0x70
> [    0.620092]  ? commit_merge+0x361/0x390
> [    0.620185]  ? asm_exc_invalid_op+0x1a/0x20
> [    0.620288]  ? commit_merge+0x361/0x390
> [    0.620383]  ? commit_merge+0x360/0x390
> [    0.620478]  vma_expand+0xd0/0x1a0
> [    0.620563]  relocate_vma_down+0xe8/0x1e0
> [    0.620664]  setup_arg_pages+0x1f6/0x360
> [    0.620783]  load_elf_binary+0x37b/0x1720
> [    0.620912]  ? __kernel_read+0x187/0x2e0
> [    0.621038]  ? load_misc_binary+0x225/0x2f0
> [    0.621173]  bprm_execve+0x22e/0x5b0
> [    0.621288]  kernel_execve+0x10b/0x140
> [    0.621406]  try_to_run_init_process+0xa/0x2e
> [    0.621545]  ? __pfx_kernel_init+0x10/0x10
> [    0.621675]  kernel_init+0xde/0x130
> [    0.621796]  ret_from_fork+0x2c/0x50
> [    0.621914]  ? __pfx_kernel_init+0x10/0x10
> [    0.622046]  ret_from_fork_asm+0x1a/0x30
> [    0.622174]  </TASK>
> [    0.622248] Modules linked in:
> [    0.622356] ---[ end trace 0000000000000000 ]---
> [    0.622502] RIP: 0010:commit_merge+0x361/0x390
> [    0.622643] Code: 28 e9 58 fd ff ff 49 39 44 24 10 72 c7 e9 81 fe ff f=
f 48 39 57 10 0f 82 1d ff ff ff e9 1c ff ff ff 48 89 c7 e8 70 0
> [    0.623213] RSP: 0018:ffffc90000013a48 EFLAGS: 00010292
> [    0.623381] RAX: 0000000000000138 RBX: ffffc90000013b68 RCX: 000000000=
0000000
> [    0.623596] RDX: 0000000000000003 RSI: ffffc900000138d0 RDI: 000000000=
0000001
> [    0.623825] RBP: 0000000000000000 R08: 00000000ffffdfff R09: ffffffff8=
2b089a8
> [    0.624045] R10: 0000000000000003 R11: 30203a7367616c66 R12: 000000000=
0000000
> [    0.624268] R13: 0000000000000001 R14: 0000000000000000 R15: ffffc9000=
0013a58
> [    0.624484] FS:  0000000000000000(0000) GS:ffff888263d80000(0000) knlG=
S:0000000000000000
> [    0.624746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.624926] CR2: 0000000000000000 CR3: 0000000101c74000 CR4: 000000000=
0750ef0
> [    0.625149] PKRU: 55555554
> [    0.625244] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x0000000b
> [    0.625545] Kernel Offset: disabled
> [    0.625658] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x0000000b ]---
>
> If I add code to detach first in relocate_vma_down(), then
> expand_downwards() has the same issue. It seems this code doesn't account
> for such cases.
>
> If I add code to fix _this_ then a VMA merge triggers it and... I think
> this is just fundamentally broken...
>
> There are cases where we change the size of an existing VMA and overwrite
> stuff in the maple tree, this is normal, and we do it to an attached VMA.
>
> So actually perhaps... we should just drop this check altogether?
>
> My workarounds are essentially to mark detached immediately prior to
> vma_iter_store() which seems to defeat the purpose :P

I realized that this assertion was added at a later stage of the patch
and I tested it using the same config that I use for performance
testing, which did not have CONFIG_DEBUG_VM enabled. Sorry about that.
I didn't realize we are modifying and reinserting the vma without
marking it detached, however these cases are not an issue for vma
reuse because we do not free the vma in the process. I think the
following should work fine:

static inline void vma_mark_attached(struct vm_area_struct *vma)
{
        /* If vma is write-locked then it's already attached */
        if (down_write_trylock(&vma->vm_lock.lock)) {
                vma->detached =3D false;
                up_write(&vma->vm_lock.lock);
        }
}

I'll think some more about edge cases and will post the new patchset
with the fix.
Thanks for reviewing and testing, Lorenzo!
Suren.

>
> On Sun, Nov 17, 2024 at 12:09:29AM -0800, Suren Baghdasaryan wrote:
> > Current implementation does not set detached flag when a VMA is first
> > allocated. This does not represent the real state of the VMA, which is
> > detached until it is added into mm's VMA tree. Fix this by marking new
> > VMAs as detached and resetting detached flag only after VMA is added
> > into a tree.
> > Introduce vma_mark_attached() to make the API more readable and to
> > simplify possible future cleanup when vma->vm_mm might be used to
> > indicate detached vma and vma_mark_attached() will need an additional
> > mm parameter.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm.h               | 27 ++++++++++++++++++++-------
> >  kernel/fork.c                    |  4 ++++
> >  mm/memory.c                      |  2 +-
> >  mm/vma.c                         |  6 +++---
> >  mm/vma.h                         |  2 ++
> >  tools/testing/vma/vma_internal.h | 17 ++++++++++++-----
> >  6 files changed, 42 insertions(+), 16 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 737c003b0a1e..dd1b6190df28 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -808,12 +808,21 @@ static inline void vma_assert_locked(struct vm_ar=
ea_struct *vma)
> >               vma_assert_write_locked(vma);
> >  }
> >
> > -static inline void vma_mark_detached(struct vm_area_struct *vma, bool =
detached)
> > +static inline void vma_mark_attached(struct vm_area_struct *vma)
> > +{
> > +     vma->detached =3D false;
> > +}
>
> We should definitely add the
>
>         VM_BUG_ON_VMA(!vma->detached, vma);
>
> Check that is added in "mm: make vma cache SLAB_TYPESAFE_BY_RCU" here
> instead, if we want it.
>
> But as per above I'm not sure we do...
>
> > +
> > +static inline void vma_mark_detached(struct vm_area_struct *vma)
> >  {
> >       /* When detaching vma should be write-locked */
> > -     if (detached)
> > -             vma_assert_write_locked(vma);
> > -     vma->detached =3D detached;
> > +     vma_assert_write_locked(vma);
> > +     vma->detached =3D true;
> > +}
>
> Do we want to assert it was attached before? Then again given the attache=
d
> assert probably not :>)
>
> > +
> > +static inline bool is_vma_detached(struct vm_area_struct *vma)
> > +{
> > +     return vma->detached;
> >  }
> >
> >  static inline void release_fault_lock(struct vm_fault *vmf)
> > @@ -844,8 +853,8 @@ static inline void vma_end_read(struct vm_area_stru=
ct *vma) {}
> >  static inline void vma_start_write(struct vm_area_struct *vma) {}
> >  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> >               { mmap_assert_write_locked(vma->vm_mm); }
> > -static inline void vma_mark_detached(struct vm_area_struct *vma,
> > -                                  bool detached) {}
> > +static inline void vma_mark_attached(struct vm_area_struct *vma) {}
> > +static inline void vma_mark_detached(struct vm_area_struct *vma) {}
> >
> >  static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_stru=
ct *mm,
> >               unsigned long address)
> > @@ -878,7 +887,10 @@ static inline void vma_init(struct vm_area_struct =
*vma, struct mm_struct *mm)
> >       vma->vm_mm =3D mm;
> >       vma->vm_ops =3D &vma_dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > -     vma_mark_detached(vma, false);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     vma->detached =3D true;
> > +#endif
> >       vma_numab_state_init(vma);
> >       vma_lock_init(vma);
> >  }
> > @@ -1073,6 +1085,7 @@ static inline int vma_iter_bulk_store(struct vma_=
iterator *vmi,
> >       if (unlikely(mas_is_err(&vmi->mas)))
> >               return -ENOMEM;
> >
> > +     vma_mark_attached(vma);
> >       return 0;
> >  }
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 7823797e31d2..f0cec673583c 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -465,6 +465,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_=
struct *orig)
> >       data_race(memcpy(new, orig, sizeof(*new)));
> >       vma_lock_init(new);
> >       INIT_LIST_HEAD(&new->anon_vma_chain);
> > +#ifdef CONFIG_PER_VMA_LOCK
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     new->detached =3D true;
> > +#endif
> >       vma_numab_state_init(new);
> >       dup_anon_vma_name(orig, new);
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 209885a4134f..d0197a0c0996 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -6279,7 +6279,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
> >               goto inval;
> >
> >       /* Check if the VMA got isolated after we found it */
> > -     if (vma->detached) {
> > +     if (is_vma_detached(vma)) {
> >               vma_end_read(vma);
> >               count_vm_vma_lock_event(VMA_LOCK_MISS);
> >               /* The area was replaced with another one */
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 8a454a7bbc80..73104d434567 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -295,7 +295,7 @@ static void vma_complete(struct vma_prepare *vp, st=
ruct vma_iterator *vmi,
> >
> >       if (vp->remove) {
> >  again:
> > -             vma_mark_detached(vp->remove, true);
> > +             vma_mark_detached(vp->remove);
> >               if (vp->file) {
> >                       uprobe_munmap(vp->remove, vp->remove->vm_start,
> >                                     vp->remove->vm_end);
> > @@ -1220,7 +1220,7 @@ static void reattach_vmas(struct ma_state *mas_de=
tach)
> >
> >       mas_set(mas_detach, 0);
> >       mas_for_each(mas_detach, vma, ULONG_MAX)
> > -             vma_mark_detached(vma, false);
> > +             vma_mark_attached(vma);
> >
> >       __mt_destroy(mas_detach->tree);
> >  }
>
> This is on a subtle error handling code path, we should definitely do som=
e
> careful checking of this (it might be nice to add some to the vma.c
> userland tests...)
>
> > @@ -1295,7 +1295,7 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >               if (error)
> >                       goto munmap_gather_failed;
> >
> > -             vma_mark_detached(next, true);
> > +             vma_mark_detached(next);
> >               nrpages =3D vma_pages(next);
> >
> >               vms->nr_pages +=3D nrpages;
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 388d34748674..2e680f357ace 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -162,6 +162,7 @@ static inline int vma_iter_store_gfp(struct vma_ite=
rator *vmi,
> >       if (unlikely(mas_is_err(&vmi->mas)))
> >               return -ENOMEM;
> >
> > +     vma_mark_attached(vma);
> >       return 0;
> >  }
> >
> > @@ -385,6 +386,7 @@ static inline void vma_iter_store(struct vma_iterat=
or *vmi,
> >
> >       __mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
> >       mas_store_prealloc(&vmi->mas, vma);
> > +     vma_mark_attached(vma);
> >  }
> >
> >  static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_i=
nternal.h
> > index 11c2c38ca4e8..2fed366d20ef 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -414,13 +414,17 @@ static inline void vma_lock_init(struct vm_area_s=
truct *vma)
> >       vma->vm_lock_seq =3D UINT_MAX;
> >  }
> >
> > +static inline void vma_mark_attached(struct vm_area_struct *vma)
> > +{
> > +     vma->detached =3D false;
> > +}
> > +
> >  static inline void vma_assert_write_locked(struct vm_area_struct *);
> > -static inline void vma_mark_detached(struct vm_area_struct *vma, bool =
detached)
> > +static inline void vma_mark_detached(struct vm_area_struct *vma)
> >  {
> >       /* When detaching vma should be write-locked */
> > -     if (detached)
> > -             vma_assert_write_locked(vma);
> > -     vma->detached =3D detached;
> > +     vma_assert_write_locked(vma);
> > +     vma->detached =3D true;
> >  }
> >
> >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > @@ -431,7 +435,8 @@ static inline void vma_init(struct vm_area_struct *=
vma, struct mm_struct *mm)
> >       vma->vm_mm =3D mm;
> >       vma->vm_ops =3D &vma_dummy_vm_ops;
> >       INIT_LIST_HEAD(&vma->anon_vma_chain);
> > -     vma_mark_detached(vma, false);
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     vma->detached =3D true;
> >       vma_lock_init(vma);
> >  }
> >
> > @@ -457,6 +462,8 @@ static inline struct vm_area_struct *vm_area_dup(st=
ruct vm_area_struct *orig)
> >       memcpy(new, orig, sizeof(*new));
> >       vma_lock_init(new);
> >       INIT_LIST_HEAD(&new->anon_vma_chain);
> > +     /* vma is not locked, can't use vma_mark_detached() */
> > +     new->detached =3D true;
> >
> >       return new;
> >  }
> > --
> > 2.47.0.338.g60cca15819-goog
> >

