Return-Path: <linux-kernel+bounces-440197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E9A9EBA01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64BD81676B6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0A5214237;
	Tue, 10 Dec 2024 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2JVnHZ0e"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E423ED63
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858453; cv=none; b=QN7D/Ba0g6K3JI9759Fdq7+3uODCh652tQrtSCdxBBzDVZCMW/ZkEL7Pv9zElk04I/jIxY71HDuk/MeFpeyjCwtc2X35xYp8th8+9n7FsbCM+CEc6pCFX7qZ+sSKE1iXV/VD/+Th+XW2MizM0hcUs8pskLUtoDPTVEG2VJ7aoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858453; c=relaxed/simple;
	bh=ScCLEe07/DyUPtVU932CzuP8pHsg6hw+0MOm4m8FAQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KjngVc3f8IsNOHfUqStnsoqB71g4RAuISbd1yf1/DEVkcTd+E9WO79Pck3qTRx/+1375FjHT0QJ0krqtqomrIJwzC1SCV653LswoTv+K0bARM2gLeGGzT8DIpYKYPTEdEP3qPiv0B1gIWhH/N5ikVwpIYRCJacqXBonArqkB5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2JVnHZ0e; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4674c22c4afso35411cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733858451; x=1734463251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+IdBCNA0sBoiQ5j26byPT4edokQ7fyNGTHS+mpHjpk=;
        b=2JVnHZ0e8OB1e+JNbCHq3lle+JehzEQN9LSlA938stXHp6ZNHo7MwH0aURLngELtyG
         ZHtTa0kPwRQZJ5Gce7e6uRhJ4xN1Tctzs52MtPvoYt3+PuZHd5wpyMe2/EIupDHHXAVC
         3C+zquJTvTMC90OIjPPNO4W8cXmrdbFfVEq1HFlMiM4EWy/HUqDSJCDdfLvPZEfeHGYX
         FDl/ALbD0HvUevuQtghMGgFJrx8s1M3gjf66PZQX27WsASLARyJbmpzn/faHJmCY5zeh
         DZhr+S+4ehybrMmU3MR+pdrEx0m4SQWXp1P4BJ/E1cQl7tgbkaYwtE1UQibdBtwYIdGr
         YMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858451; x=1734463251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+IdBCNA0sBoiQ5j26byPT4edokQ7fyNGTHS+mpHjpk=;
        b=ut/Fg+ZdkUQYYrJAkNlGqtnKN54kDmsphvyvc785rcKjrXnDgJEezVVDc/VsWDXwdQ
         Yv1zdU7WcbAKBRmhruz+Os71iMM3M0aBz5n0urxnc+jAVX2T1kLJJ/TTgSYBEpFmFo8p
         7iAVubqHG71o4BEav1De1rBqnTjsfR4KIQIWxQus3C1lGN0awU3iNPOBPJTqBFoRdd6U
         94sHoKTFCUiiQhsofmuOnADufdvWvVPFYtkiIfQFa20Upme+YY6e4Y9mlEDWYayvYsfI
         bOArktTOlJNR1k7LqRf8A/SwlqTV3CfWxtMke5Dh64OplP9s8iUFe9OmGULucX7eVNLN
         BkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWV1wtITVDPg0QMArPCQXLVlVNHPmgPeE9ZTQqh0WeU6V214F8Y58uFF8gvVN1KBBG/uUsJ7IM9zrEO4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/4TadGhBbr6H+/6roBb2uMAgw9P4yUBXwRtZPvtrINULxIY/
	gH7heqd2fHh3mzZ/I1SeTtrOlO9h6cmTlMz1XyBNoo5/W7ybye2qIlhHcSTjMitbVJhP2GeX/7A
	hLqafdwa3yETeHF0UB0eYiARRKe1zJEBnwyWd
X-Gm-Gg: ASbGncsW1WhCaa9+uKjwxyBC+APsIY77CVtwObBp6KIZ1B6OdvEmDRo07bhJDzn/pT6
	gTXbz0bg5DLeUq3QHexmVd4wVvVpAKnWc+16nDFnxyVujZPORh1VTpoGKdnEKtImOTg==
X-Google-Smtp-Source: AGHT+IGb/LQpEWuqCFB7SkvhdAooq6dUVVcGcvvr3qQCFsJ/Cp1LjqqqeO2wkDCfMcQ6Lt3CUBSgc0JZTX0MZ/jl+w0=
X-Received: by 2002:ac8:514f:0:b0:466:8646:c72 with SMTP id
 d75a77b69052e-4678912581amr77531cf.25.1733858450545; Tue, 10 Dec 2024
 11:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210041515.765569-1-hao.ge@linux.dev> <20241210065304.781620-1-hao.ge@linux.dev>
 <CAJuCfpGVTyKJ5yMQUqvNXRfBnBYj+dhUEqq0YAddtrqcWP27yw@mail.gmail.com> <1fe9eca1-68d0-aaf9-f335-4a9a58c8a88e@linux.dev>
In-Reply-To: <1fe9eca1-68d0-aaf9-f335-4a9a58c8a88e@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 11:20:39 -0800
Message-ID: <CAJuCfpE_8YXOGaF_KufJ+b+b+WSTUCZ6u+7Gd0bPOOWgs0sHRg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/alloc_tag: Add kasan_alloc_module_shadow when
 CONFIS_KASAN_VMALLOC disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, greearb@candelatech.com, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:46=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> Thanks for your review.
>
>
> On 12/11/24 01:55, Suren Baghdasaryan wrote:
> > On Mon, Dec 9, 2024 at 10:53=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote=
:
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> When CONFIG_KASAN is enabled but CONFIG_KASAN_VMALLOC
> >> is not enabled, we may encounter a panic during system boot.
> >>
> >> Because we haven't allocated pages and created mappings
> >> for the shadow memory corresponding to module_tags region,
> >> similar to how it is done for execmem_vmalloc.
> >>
> >> The difference is that our module_tags are allocated on demand,
> >> so similarly,we also need to allocate shadow memory regions on demand.
> >> However, we still need to adhere to the MODULE_ALIGN principle.
> >>
> >> Here is the log for panic:
> >>
> >> [   18.349421] BUG: unable to handle page fault for address: fffffbfff=
8092000
> >> [   18.350016] #PF: supervisor read access in kernel mode
> >> [   18.350459] #PF: error_code(0x0000) - not-present page
> >> [   18.350904] PGD 20fe52067 P4D 219dc8067 PUD 219dc4067 PMD 102495067=
 PTE 0
> >> [   18.351484] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >> [   18.351961] CPU: 5 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0-r=
c1+ #3
> >> [   18.352533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), =
BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >> [   18.353494] RIP: 0010:kasan_check_range+0xba/0x1b0
> >> [   18.353931] Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 d=
d 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 c2 0f 84 c1 00 00 0=
0 <48> 83 38 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 d0 0f 84 90
> >> [   18.355484] RSP: 0018:ff11000101877958 EFLAGS: 00010206
> >> [   18.355937] RAX: fffffbfff8092000 RBX: fffffbfff809201e RCX: ffffff=
ff82a7ceac
> >> [   18.356542] RDX: fffffbfff8092018 RSI: 00000000000000f0 RDI: ffffff=
ffc0490000
> >> [   18.357153] RBP: fffffbfff8092000 R08: 0000000000000001 R09: fffffb=
fff809201d
> >> [   18.357756] R10: ffffffffc04900ef R11: 0000000000000003 R12: ffffff=
ffc0490000
> >> [   18.358365] R13: ff11000101877b48 R14: ffffffffc0490000 R15: 000000=
000000002c
> >> [   18.358968] FS:  00007f9bd13c5940(0000) GS:ff110001eb480000(0000) k=
nlGS:0000000000000000
> >> [   18.359648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [   18.360178] CR2: fffffbfff8092000 CR3: 0000000109214004 CR4: 000000=
0000771ef0
> >> [   18.360790] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000=
0000000000
> >> [   18.361404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000=
0000000400
> >> [   18.362020] PKRU: 55555554
> >> [   18.362261] Call Trace:
> >> [   18.362481]  <TASK>
> >> [   18.362671]  ? __die+0x23/0x70
> >> [   18.362964]  ? page_fault_oops+0xc2/0x160
> >> [   18.363318]  ? exc_page_fault+0xad/0xc0
> >> [   18.363680]  ? asm_exc_page_fault+0x26/0x30
> >> [   18.364056]  ? move_module+0x3cc/0x8a0
> >> [   18.364398]  ? kasan_check_range+0xba/0x1b0
> >> [   18.364755]  __asan_memcpy+0x3c/0x60
> >> [   18.365074]  move_module+0x3cc/0x8a0
> >> [   18.365386]  layout_and_allocate.constprop.0+0x3d5/0x720
> >> [   18.365841]  ? early_mod_check+0x3dc/0x510
> >> [   18.366195]  load_module+0x72/0x1850
> >> [   18.366509]  ? __pfx_kernel_read_file+0x10/0x10
> >> [   18.366918]  ? vm_mmap_pgoff+0x21c/0x2d0
> >> [   18.367262]  init_module_from_file+0xd1/0x130
> >> [   18.367638]  ? __pfx_init_module_from_file+0x10/0x10
> >> [   18.368073]  ? __pfx__raw_spin_lock+0x10/0x10
> >> [   18.368456]  ? __pfx_cred_has_capability.isra.0+0x10/0x10
> >> [   18.368938]  idempotent_init_module+0x22c/0x790
> >> [   18.369332]  ? simple_getattr+0x6f/0x120
> >> [   18.369676]  ? __pfx_idempotent_init_module+0x10/0x10
> >> [   18.370110]  ? fdget+0x58/0x3a0
> >> [   18.370393]  ? security_capable+0x64/0xf0
> >> [   18.370745]  __x64_sys_finit_module+0xc2/0x140
> >> [   18.371136]  do_syscall_64+0x7d/0x160
> >> [   18.371459]  ? fdget_pos+0x1c8/0x4c0
> >> [   18.371784]  ? ksys_read+0xfd/0x1d0
> >> [   18.372106]  ? syscall_exit_to_user_mode+0x10/0x1f0
> >> [   18.372525]  ? do_syscall_64+0x89/0x160
> >> [   18.372860]  ? do_syscall_64+0x89/0x160
> >> [   18.373194]  ? do_syscall_64+0x89/0x160
> >> [   18.373527]  ? syscall_exit_to_user_mode+0x10/0x1f0
> >> [   18.373952]  ? do_syscall_64+0x89/0x160
> >> [   18.374283]  ? syscall_exit_to_user_mode+0x10/0x1f0
> >> [   18.374701]  ? do_syscall_64+0x89/0x160
> >> [   18.375037]  ? do_user_addr_fault+0x4a8/0xa40
> >> [   18.375416]  ? clear_bhb_loop+0x25/0x80
> >> [   18.375748]  ? clear_bhb_loop+0x25/0x80
> >> [   18.376119]  ? clear_bhb_loop+0x25/0x80
> >> [   18.376450]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>
> >> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populated =
area calculation")
> >> Reported-by: Ben Greear <greearb@candelatech.com>
> >> Closes: https://lore.kernel.org/all/1ba0cc57-e2ed-caa2-1241-aa5615bee0=
1f@candelatech.com/
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> ---
> >> v2: Add comments to facilitate understanding of the code.
> >>      Add align nr << PAGE_SHIFT to MODULE_ALIGN,even though kasan_allo=
c_module_shadow
> >>      already handles this internally,but to make the code more readabl=
e and user-friendly
> >>
> >> commit 233e89322cbe ("alloc_tag: fix module allocation
> >> tags populated area calculation") is currently in the
> >> mm-hotfixes-unstable branch, so this patch is
> >> developed based on the mm-hotfixes-unstable branch.
> >> ---
> >>   lib/alloc_tag.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> index f942408b53ef..bd3ee57ea13f 100644
> >> --- a/lib/alloc_tag.c
> >> +++ b/lib/alloc_tag.c
> >> @@ -10,6 +10,7 @@
> >>   #include <linux/seq_buf.h>
> >>   #include <linux/seq_file.h>
> >>   #include <linux/vmalloc.h>
> >> +#include <linux/math.h>
> >>
> >>   #define ALLOCINFO_FILE_NAME            "allocinfo"
> >>   #define MODULE_ALLOC_TAG_VMAP_SIZE     (100000UL * sizeof(struct all=
oc_tag))
> >> @@ -422,6 +423,17 @@ static int vm_module_tags_populate(void)
> >>                          return -ENOMEM;
> >>                  }
> >>                  vm_module_tags->nr_pages +=3D nr;
> >> +
> >> +               /*
> >> +                * Kasan allocates 1 byte of shadow for every 8 bytes =
of data.
> >> +                * When kasan_alloc_module_shadow allocates shadow mem=
ory,
> >> +                * it does so in units of pages.
> >> +                * Therefore, here we need to align to MODULE_ALIGN.
> >> +                */
> >> +               if ((phys_end & (MODULE_ALIGN - 1)) =3D=3D 0)
> > phys_end is calculated as:
> >
> > unsigned long phys_end =3D ALIGN_DOWN(module_tags.start_addr, PAGE_SIZE=
) +
> >                                             (vm_module_tags->nr_pages
> > << PAGE_SHIFT);
> >
> > and therefore is always PAGE_SIZE-aligned. PAGE_SIZE is always a
> > multiple of MODULE_ALIGN, therefore phys_end is always
>
> When CONFIG_KASAN_VMALLOC is not enabled
>
> #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)

Ah, sorry, I misread this as (PAGE_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
and assumed MODULE_ALIGN is always multiple of PAGE_SIZE. Now it makes
more sense. However I'm still not sure about this condition:

if ((phys_end & (MODULE_ALIGN - 1)) =3D=3D 0)

What if page_end is not MODULE_ALIGN-aligned. We will be skipping
kasan_alloc_module_shadow().
For example, say module_tags.start_addr =3D=3D 0x1018 (4096+24), original
phys_end will be 0x1000 (4096) and say we allocated one page (nr =3D=3D
1), tags area is [0x1000-0x2000]. phys_end is not MODULE_ALIGN-aligned
and we will skip kasan_alloc_module_shadow(). IIUC, this is already
incorrect.
Now, say the next time we allocate 8 pages. phys_end this time is
0x2000 and the new tags area spans [0x1000-0xA000], we skip
kasan_alloc_module_shadow() again. Next time we allocate pages,
phys_end is 0xA000 and it again is not MODULE_ALIGN-aligned, we skip
again. You see my point?

>
> https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/execmem.h=
#L11
>
> and On x86, KASAN_SHADOW_SCALE_SHIFT is set to 3
>
> https://elixir.bootlin.com/linux/v6.13-rc2/source/arch/x86/include/asm/ka=
san.h#L7
>
> As mentioned in my comment, Kasan allocates 1 byte of shadow for every 8
> bytes of data
>
> So, when you allocate a shadow page through kasan_alloc_module_shadow,
> it corresponds to eight physical pages in our system.
>
> So, we need MODULE_ALIGN to ensure proper alignment when allocating
> shadow memory for modules using KASAN.
>
> Let's take a look at the kasan_alloc_module_shadow function again
>
> As I mentioned earlier,Kasan allocates 1 byte of shadow for every 8
> bytes of data.
>
> Assuming phys_end is set to 0 for the sake of this example, if you
> allocate a single shadow page,
>
> the corresponding address range it can represent would be [0, 0x7FFFF].
>
> So, it is incorrect to call kasan_alloc_module_shadow every time a page
> is allocated, as it can trigger warnings in the system.
>
> https://elixir.bootlin.com/linux/v6.13-rc2/source/mm/kasan/shadow.c#L599
>
> Thanks
>
> Best Regards Hao
>
> > MODULE_ALIGN-aligned and the above condition is not needed.
> >
> >> +                       kasan_alloc_module_shadow((void *)phys_end,
> >> +                                                 round_up(nr << PAGE_=
SHIFT, MODULE_ALIGN),
> > Here again, (nr << PAGE_SHIFT) is PAGE_SIZE-aligned and PAGE_SIZE is a
> > multiple of MODULE_ALIGN, therefore (nr << PAGE_SHIFT) is always
> > multiple of MODULE_ALIGN and there is no need for round_up().
> >
> > IOW, I think this patch should simply add one line:
> >
> >                  vm_module_tags->nr_pages +=3D nr;
> > +               kasan_alloc_module_shadow((void *)phys_end, nr <<
> > PAGE_SHIFT, GFP_KERNEL);
> >
> > Am I missing something?
> >
>
>
> >> +                                                 GFP_KERNEL);
> >>          }
> >>
> >>          /*
> >> --
> >> 2.25.1
> >>

