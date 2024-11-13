Return-Path: <linux-kernel+bounces-408203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4579C7C0E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E80BAB2B603
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3152204001;
	Wed, 13 Nov 2024 19:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLLO23oB"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A315ADA4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524751; cv=none; b=R96KFpWrz2h+BQWmz45NDLImZGhLIr1ezU29/7Cmqng1pjuQRzLRMVhCVD8Hanhq7bw7Ryj5AcouY/0e2aYbaeLKeM0yHB8d/yj/qv9hcNdxLbRgkJmmqVMmt7vmOxCq/IIqjihibLMXrL1fSgODtOmipV50c++Kt9L0wpfPjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524751; c=relaxed/simple;
	bh=yFFKPCUl7Hbd5w1E4KrnQGiuAKcg55RHbITCypZrcPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hehU+9dGGK0LZKPUCjhSBwQOhg0fRYl+DduJd6KNpTU6pCiWa7K6vU/6Tc6DCqlzZb/EhclwtcTSqvanNUuYbV2yogkjISmPbYRBTe8qleb/cW/9U410Eab+KM7GG7D0UDRf26UrGYDIxJis1FiYyXeaC7AlrGsHvaW7UthqWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLLO23oB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460a8d1a9b7so350961cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731524748; x=1732129548; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L2eSjt39DWBZHReFjtJm4KZ8bjjYkrHutw63mTeJbg=;
        b=bLLO23oBBDGGH2H3+rBzX3G9L+O2dSc6p1bco2WRIs5U/2HOtEDgzaa3Czosj5mj7w
         0op80hoe4eXpHzSYCjJQ27SZQDf7FC9+9O9237A4Ir8TtzmCkTYJ3GYxek5OjlIVybvw
         i0xVtspR4vY4zfg6bMWTR08gh3vyjTVb9QccmYZqRCnQFnmX9yCRfUq5uZvluBbKFbda
         nEOyISHduFq8QrKNJwmvH54YovkPkV2sdylfNTNceNdSE9QHj+55ISgr8POnl7VKrjoJ
         U2ZWYkkZdHSJuTghv47Ss61I/5h1LpihSyhlz39rpMftuUaMAD89/aGgALZ0p/9toRZb
         Fivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524748; x=1732129548;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1L2eSjt39DWBZHReFjtJm4KZ8bjjYkrHutw63mTeJbg=;
        b=sirPw3L733+IA3B47cPMBPK5Lom97XGlGN4yO6L+A+CNEN/49fItg18xKZOTyyxHpl
         TrKmfC7+IpeCS9ja3pxkBCd0QBTJ1A/ORlMggrN88XCdrLW0lcvOK27yeA++n7odOS1a
         qFotyEQYWoH2OA+SV18zr1mnq3EHBx6Zagm5GWqHXqSi/no8ZJH0a3ZxO05jDCVTu/0Z
         vuV0u558KeI0anB09nOptLNqhO/+7DDj8KPuJsgD+mkLWogRD71HZPnF4IJQHCbnXHP+
         dP+dMmAcoXDghWkLZJihx0RGggVyJx+pTQDPxdc3kUKdReSeCWJJRyujUDv7V5fEZaiY
         PqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYVfzLrgKeEaknP40S7AWklv/Ix00XcuKrCUhYEkjRfjCLLiqBLJ8eOU8CIn6WFJEDI8jeJ7Wg/OWc5hs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MG3T/0KReoPapLJPjNL6+A40mJLAjfXqVBEkzkVAD+Ev4/Ye
	nzzGlKBPp19fZy7s6x6Q1x7ky7tyqAimAmUdfKepLointRTLSeCzT4SWRQmPC402N4doqro09L2
	jyHbDvme5RkXF8PwyBwEDluxyHRE/z5l6ChA+
X-Gm-Gg: ASbGncu0ux73oMOm2DsLedwHIWnz1AUsblXxWJGi3IPUZVPlJH0ji/mpayGYnDNC1AN
	5Z4zRGz9AVzqurlA6q04gEw8lnvCYJXavYnIvzSHMc9gvpFnwcl80HAlXLIuVwQ==
X-Google-Smtp-Source: AGHT+IHoHO98WMRzNyetaySvO8OR0gF0FQUXeoenh0wgXvlww7UjEdrjlOKFkAWdqi7CtycVgmyp+eC83bjW3/I1rS0=
X-Received: by 2002:a05:622a:1817:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-463572a9c71mr83811cf.28.1731524748240; Wed, 13 Nov 2024
 11:05:48 -0800 (PST)
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
 <aa4i3inhnkyi6yazttb55khbm7swt7xq2sklmhp5y63kxw7bsc@i4wlyyzoo7h3> <CAJuCfpF_fEVwyDAStueNoEW=MNS5MoLPc1RaQMaOHZxODmw_0A@mail.gmail.com>
In-Reply-To: <CAJuCfpF_fEVwyDAStueNoEW=MNS5MoLPc1RaQMaOHZxODmw_0A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 13 Nov 2024 11:05:36 -0800
Message-ID: <CAJuCfpFd1-hH=gmzyosZiebp8X=F9h-jTt1dXiMpZovsL8O=rQ@mail.gmail.com>
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

On Wed, Nov 13, 2024 at 7:47=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Nov 13, 2024 at 7:29=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [241113 10:25]:
> > > On Wed, Nov 13, 2024 at 7:23=E2=80=AFAM 'Liam R. Howlett' via kernel-=
team
> > > <kernel-team@android.com> wrote:
> > > >
> > > > * Matthew Wilcox <willy@infradead.org> [241113 08:57]:
> > > > > On Wed, Nov 13, 2024 at 07:38:02AM -0500, Liam R. Howlett wrote:
> > > > > > > Hi, I was wondering if we actually need the detached flag. Co=
uldn't
> > > > > > > "detached" simply mean vma->vm_mm =3D=3D NULL and we save 4 b=
ytes? Do we ever
> > > > > > > need a vma that's detached but still has a mm pointer? I'd ho=
pe the places
> > > > > > > that set detached to false have the mm pointer around so it's=
 not inconvenient.
> > > > > >
> > > > > > I think the gate vmas ruin this plan.
> > > > >
> > > > > But the gate VMAs aren't to be found in the VMA tree.  Used to be=
 that
> > > > > was because the VMA tree was the injective RB tree and so VMAs co=
uld
> > > > > only be in one tree at a time.  We could change that now!
> > > >
> > > > \o/
> > > >
> > > > >
> > > > > Anyway, we could use (void *)1 instead of NULL to indicate a "det=
ached"
> > > > > VMA if we need to distinguish between a detached VMA and a gate V=
MA.
> > > >
> > > > I was thinking a pointer to itself vma->vm_mm =3D vma, then a check=
 for
> > > > this, instead of null like we do today.
> > >
> > > The motivation for having a separate detached flag was that vma->vm_m=
m
> > > is used when read/write locking the vma, so it has to stay valid even
> > > when vma gets detached. Maybe we can be more cautious in
> > > vma_start_read()/vma_start_write() about it but I don't recall if
> > > those were the only places that was an issue.
> >
> > We have the mm form the callers though, so it could be passed in?
>
> Let me try and see if something else blows up. When I was implementing
> per-vma locks I thought about using vma->vm_mm to indicate detached
> state but there were some issues that caused me reconsider.

Yeah, a quick change reveals the first mine explosion:

[    2.838900] BUG: kernel NULL pointer dereference, address: 0000000000000=
480
[    2.840671] #PF: supervisor read access in kernel mode
[    2.841958] #PF: error_code(0x0000) - not-present page
[    2.843248] PGD 800000010835a067 P4D 800000010835a067 PUD 10835b067 PMD =
0
[    2.844920] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[    2.846078] CPU: 2 UID: 0 PID: 1 Comm: init Not tainted
6.12.0-rc6-00258-ga587fcd91b06-dirty #111
[    2.848277] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    2.850673] RIP: 0010:unmap_vmas+0x84/0x190
[    2.851717] Code: 00 00 00 00 48 c7 44 24 48 00 00 00 00 48 c7 44
24 18 00 00 00 00 48 89 44 24 28 4c 89 44 24 38 e8 b1 c0 d1 00 48 8b
44 24 28 <48> 83 b8 80 04 00 00 00 0f 85 dd 00 00 00 45 0f b6 ed 49 83
ec 01
[    2.856287] RSP: 0000:ffffa298c0017a18 EFLAGS: 00010246
[    2.857599] RAX: 0000000000000000 RBX: 00007f48ccbb4000 RCX: 00007f48ccb=
b4000
[    2.859382] RDX: ffff8918c26401e0 RSI: ffffa298c0017b98 RDI: ffffa298c00=
17ab0
[    2.861156] RBP: 00007f48ccdb6000 R08: 00007f48ccdb6000 R09: 00000000000=
00001
[    2.862941] R10: 0000000000000040 R11: ffff8918c2637108 R12: 00000000000=
00001
[    2.864719] R13: 0000000000000001 R14: ffff8918c26401e0 R15: ffffa298c00=
17b98
[    2.866472] FS:  0000000000000000(0000) GS:ffff8927bf080000(0000)
knlGS:0000000000000000
[    2.868439] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.869877] CR2: 0000000000000480 CR3: 000000010263e000 CR4: 00000000007=
50ef0
[    2.871661] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[    2.873419] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[    2.875185] PKRU: 55555554
[    2.875871] Call Trace:
[    2.876503]  <TASK>
[    2.877047]  ? __die+0x1e/0x60
[    2.877824]  ? page_fault_oops+0x17b/0x4a0
[    2.878857]  ? exc_page_fault+0x6b/0x150
[    2.879841]  ? asm_exc_page_fault+0x26/0x30
[    2.880886]  ? unmap_vmas+0x84/0x190
[    2.881783]  ? unmap_vmas+0x7f/0x190
[    2.882680]  vms_clear_ptes+0x106/0x160
[    2.883621]  vms_complete_munmap_vmas+0x53/0x170
[    2.884762]  do_vmi_align_munmap+0x15e/0x1d0
[    2.885838]  do_vmi_munmap+0xcb/0x160
[    2.886760]  __vm_munmap+0xa4/0x150
[    2.887637]  elf_load+0x1c4/0x250
[    2.888473]  load_elf_binary+0xabb/0x1680
[    2.889476]  ? __kernel_read+0x111/0x320
[    2.890458]  ? load_misc_binary+0x1bc/0x2c0
[    2.891510]  bprm_execve+0x23e/0x5e0
[    2.892408]  kernel_execve+0xf3/0x140
[    2.893331]  ? __pfx_kernel_init+0x10/0x10
[    2.894356]  kernel_init+0xe5/0x1c0
[    2.895241]  ret_from_fork+0x2c/0x50
[    2.896141]  ? __pfx_kernel_init+0x10/0x10
[    2.897164]  ret_from_fork_asm+0x1a/0x30
[    2.898148]  </TASK>

Looks like we are detaching VMAs and then unmapping them, where
vms_clear_ptes() uses vms->vma->vm_mm. I'll try to clean up this and
other paths and will see how many changes are required to make this
work.

>
> >
> > >
> > > >
> > > > Either way, we should make it a function so it's easier to reuse fo=
r
> > > > whatever we need in the future, wdyt?
> > > >
> > > > To unsubscribe from this group and stop receiving emails from it, s=
end an email to kernel-team+unsubscribe@android.com.
> > > >

