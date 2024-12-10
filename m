Return-Path: <linux-kernel+bounces-440236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD199EBA96
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B10E283AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2071226861;
	Tue, 10 Dec 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iq6DqBON"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EE8633A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861102; cv=none; b=NVRle1iKQ6hyLl4La5TRb5yt0kRn3S0Z69/KerSrq/2qRj1VWriIV8YskJ+ucgdeDLzdEZJumm8g13EK4VGCYKwzl5ID6yTsqFuBGzQub5UeHS3qW6O3Jou4EmMznHBwKjR/5Oq0sXRaPiNaVmNm7ZBLmvhT//nBY376WvhdQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861102; c=relaxed/simple;
	bh=pVihG2k3Wf9noCLvMVNiq+2m2L3Yw+QdBE8U1EDwUvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyPNbU1JV1Ld09ldslJF0DzgPmWEs+UcLRhbgmY7fnSmxa7PNZ/2qvPA9CU9Qxbp+QhNqPnF22NyjjJlcEaZV8ziSN79hfbXB0nLftVT7B7qbBZm2752+E4SW9aNs9PpcPOnOKcnvtL/7k7ZFcljDc6loEJKIydxfd3DOJr8dyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iq6DqBON; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4674c22c4afso49191cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861098; x=1734465898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElX6nYpuKJrDV0pc4OpulsSSDetIZuD81S4aXyfJqX0=;
        b=Iq6DqBON0XiiVnzeC3SdVnfgjpT847oec/VEHhDMzBnR6g/r2XTfgg2krvMOvyFzyo
         NLevhnHmPnkE0zzllnudcI/B3GBRnBNhZscqR+9n4sEuZCOpQDIUIaSKHSMStpq7In8z
         ZiHmsrhNexw7ySsZAm9pcDdnrswJw8un2auVQ34o8dkLnZ7wH4AesYhks+EX60rTWIPA
         qWxFkcgXzx8c+BESpMSbQ/DtNzK8V3X2R5YOqSWf0PrvaJBCWHnPOL/XyO6lYCO9pvCo
         ngl0riTmLP1JMbA4+tfJMyfh/W4CFWrsmKY2B6/A4FJBh7CfbkQnw7/uxs2cel1IA0zR
         DHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861098; x=1734465898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElX6nYpuKJrDV0pc4OpulsSSDetIZuD81S4aXyfJqX0=;
        b=Qt8ODjj0NdzXKKy9+fAuHOy2G05LROLeYdtT3CGq8yFUvj/Ms0VilexFSMEbmR2APO
         /CRkOEJg8xZnUJK3CL/BO6lmqIqKVnE5EfUBnEZfxorZQL4XLI+0xwuXi0Ets1epbic/
         6zMG75Ea6S5boAO3o/YLx+dgXf0OW04MA52jPcx7DSR3rj8/TFnfMjTLM/jCbNRMcjoL
         k2hsusTYTP0uV0vVFXaX7feysD8n0o5MHwDO/CSXyxbV1LNgeZeKWOmCSD6qVICfcMG5
         jsFIRWUFzxekv7bczuAiAaHmLRW6HmXF973dcf44F9gggtyuIlBj7jxBYo1q4hpPQZus
         Q+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUAH0I7VGt3NF1OM3f0Nwp/ybxERUJqJXtJZaU/AziF+awe4G2OB//Fag3sb9b88f/g549hTvkMcWqX/OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx10U5s92acC7Rj5uFi6XOKBTzhik+GHCsr46hG5+hiOg/dRTvq
	0lewBCt7BzT7PbcaOQxJKA0UQDBOqbdJGLS8l98iXVuQTsVQiKskbYsRKv6doXYLRVdtcty+NcA
	73PXeeP5u4jWdM9UwPhYmwtQZpWYswkIiUv+y
X-Gm-Gg: ASbGncsZEbKyiFF0yn4U5PFH1C9gNBRiLQh0J9jIwB52hy1uWD6xCgXsZzRf1WQXl9U
	mb7ywPhp7X33HfWnQbuNLz19YIydxRei/iYPcvO6YbdCdDK0T8G3KIiFEPm/L3mX2HQ==
X-Google-Smtp-Source: AGHT+IEIKNH0Ljf5W4g96ElO4XMuriu4QCUkQk9LSurEQVYYhaNVqay5itq++uHd+wOww7VPTebvjGcR90oOSxY21T8=
X-Received: by 2002:a05:622a:4812:b0:465:18f3:79c8 with SMTP id
 d75a77b69052e-467890e41a0mr342631cf.13.1733861098230; Tue, 10 Dec 2024
 12:04:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210041515.765569-1-hao.ge@linux.dev> <20241210065304.781620-1-hao.ge@linux.dev>
 <CAJuCfpGVTyKJ5yMQUqvNXRfBnBYj+dhUEqq0YAddtrqcWP27yw@mail.gmail.com>
 <1fe9eca1-68d0-aaf9-f335-4a9a58c8a88e@linux.dev> <CAJuCfpE_8YXOGaF_KufJ+b+b+WSTUCZ6u+7Gd0bPOOWgs0sHRg@mail.gmail.com>
 <edac9431-8503-c8ad-2e4c-aaf71c6f4f08@linux.dev>
In-Reply-To: <edac9431-8503-c8ad-2e4c-aaf71c6f4f08@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 10 Dec 2024 12:04:46 -0800
Message-ID: <CAJuCfpE_Vr63QHpwG7G71iabN_kFyacbYtc-9vCC8iF=nu4mmA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/alloc_tag: Add kasan_alloc_module_shadow when
 CONFIS_KASAN_VMALLOC disabled
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, greearb@candelatech.com, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 11:37=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> On 12/11/24 03:20, Suren Baghdasaryan wrote:
> > On Tue, Dec 10, 2024 at 10:46=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrot=
e:
> >> Hi Suren
> >>
> >>
> >> Thanks for your review.
> >>
> >>
> >> On 12/11/24 01:55, Suren Baghdasaryan wrote:
> >>> On Mon, Dec 9, 2024 at 10:53=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wro=
te:
> >>>> From: Hao Ge <gehao@kylinos.cn>
> >>>>
> >>>> When CONFIG_KASAN is enabled but CONFIG_KASAN_VMALLOC
> >>>> is not enabled, we may encounter a panic during system boot.
> >>>>
> >>>> Because we haven't allocated pages and created mappings
> >>>> for the shadow memory corresponding to module_tags region,
> >>>> similar to how it is done for execmem_vmalloc.
> >>>>
> >>>> The difference is that our module_tags are allocated on demand,
> >>>> so similarly,we also need to allocate shadow memory regions on deman=
d.
> >>>> However, we still need to adhere to the MODULE_ALIGN principle.
> >>>>
> >>>> Here is the log for panic:
> >>>>
> >>>> [   18.349421] BUG: unable to handle page fault for address: fffffbf=
ff8092000
> >>>> [   18.350016] #PF: supervisor read access in kernel mode
> >>>> [   18.350459] #PF: error_code(0x0000) - not-present page
> >>>> [   18.350904] PGD 20fe52067 P4D 219dc8067 PUD 219dc4067 PMD 1024950=
67 PTE 0
> >>>> [   18.351484] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
> >>>> [   18.351961] CPU: 5 UID: 0 PID: 1 Comm: systemd Not tainted 6.13.0=
-rc1+ #3
> >>>> [   18.352533] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)=
, BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> >>>> [   18.353494] RIP: 0010:kasan_check_range+0xba/0x1b0
> >>>> [   18.353931] Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84=
 dd 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 c2 0f 84 c1 00 00=
 00 <48> 83 38 00 74 ed 48 8d 50 08 eb 0d 48 83 c0 01 48 39 d0 0f 84 90
> >>>> [   18.355484] RSP: 0018:ff11000101877958 EFLAGS: 00010206
> >>>> [   18.355937] RAX: fffffbfff8092000 RBX: fffffbfff809201e RCX: ffff=
ffff82a7ceac
> >>>> [   18.356542] RDX: fffffbfff8092018 RSI: 00000000000000f0 RDI: ffff=
ffffc0490000
> >>>> [   18.357153] RBP: fffffbfff8092000 R08: 0000000000000001 R09: ffff=
fbfff809201d
> >>>> [   18.357756] R10: ffffffffc04900ef R11: 0000000000000003 R12: ffff=
ffffc0490000
> >>>> [   18.358365] R13: ff11000101877b48 R14: ffffffffc0490000 R15: 0000=
00000000002c
> >>>> [   18.358968] FS:  00007f9bd13c5940(0000) GS:ff110001eb480000(0000)=
 knlGS:0000000000000000
> >>>> [   18.359648] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [   18.360178] CR2: fffffbfff8092000 CR3: 0000000109214004 CR4: 0000=
000000771ef0
> >>>> [   18.360790] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000=
000000000000
> >>>> [   18.361404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000=
000000000400
> >>>> [   18.362020] PKRU: 55555554
> >>>> [   18.362261] Call Trace:
> >>>> [   18.362481]  <TASK>
> >>>> [   18.362671]  ? __die+0x23/0x70
> >>>> [   18.362964]  ? page_fault_oops+0xc2/0x160
> >>>> [   18.363318]  ? exc_page_fault+0xad/0xc0
> >>>> [   18.363680]  ? asm_exc_page_fault+0x26/0x30
> >>>> [   18.364056]  ? move_module+0x3cc/0x8a0
> >>>> [   18.364398]  ? kasan_check_range+0xba/0x1b0
> >>>> [   18.364755]  __asan_memcpy+0x3c/0x60
> >>>> [   18.365074]  move_module+0x3cc/0x8a0
> >>>> [   18.365386]  layout_and_allocate.constprop.0+0x3d5/0x720
> >>>> [   18.365841]  ? early_mod_check+0x3dc/0x510
> >>>> [   18.366195]  load_module+0x72/0x1850
> >>>> [   18.366509]  ? __pfx_kernel_read_file+0x10/0x10
> >>>> [   18.366918]  ? vm_mmap_pgoff+0x21c/0x2d0
> >>>> [   18.367262]  init_module_from_file+0xd1/0x130
> >>>> [   18.367638]  ? __pfx_init_module_from_file+0x10/0x10
> >>>> [   18.368073]  ? __pfx__raw_spin_lock+0x10/0x10
> >>>> [   18.368456]  ? __pfx_cred_has_capability.isra.0+0x10/0x10
> >>>> [   18.368938]  idempotent_init_module+0x22c/0x790
> >>>> [   18.369332]  ? simple_getattr+0x6f/0x120
> >>>> [   18.369676]  ? __pfx_idempotent_init_module+0x10/0x10
> >>>> [   18.370110]  ? fdget+0x58/0x3a0
> >>>> [   18.370393]  ? security_capable+0x64/0xf0
> >>>> [   18.370745]  __x64_sys_finit_module+0xc2/0x140
> >>>> [   18.371136]  do_syscall_64+0x7d/0x160
> >>>> [   18.371459]  ? fdget_pos+0x1c8/0x4c0
> >>>> [   18.371784]  ? ksys_read+0xfd/0x1d0
> >>>> [   18.372106]  ? syscall_exit_to_user_mode+0x10/0x1f0
> >>>> [   18.372525]  ? do_syscall_64+0x89/0x160
> >>>> [   18.372860]  ? do_syscall_64+0x89/0x160
> >>>> [   18.373194]  ? do_syscall_64+0x89/0x160
> >>>> [   18.373527]  ? syscall_exit_to_user_mode+0x10/0x1f0
> >>>> [   18.373952]  ? do_syscall_64+0x89/0x160
> >>>> [   18.374283]  ? syscall_exit_to_user_mode+0x10/0x1f0
> >>>> [   18.374701]  ? do_syscall_64+0x89/0x160
> >>>> [   18.375037]  ? do_user_addr_fault+0x4a8/0xa40
> >>>> [   18.375416]  ? clear_bhb_loop+0x25/0x80
> >>>> [   18.375748]  ? clear_bhb_loop+0x25/0x80
> >>>> [   18.376119]  ? clear_bhb_loop+0x25/0x80
> >>>> [   18.376450]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >>>>
> >>>> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags populate=
d area calculation")
> >>>> Reported-by: Ben Greear <greearb@candelatech.com>
> >>>> Closes: https://lore.kernel.org/all/1ba0cc57-e2ed-caa2-1241-aa5615be=
e01f@candelatech.com/
> >>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >>>> ---
> >>>> v2: Add comments to facilitate understanding of the code.
> >>>>       Add align nr << PAGE_SHIFT to MODULE_ALIGN,even though kasan_a=
lloc_module_shadow
> >>>>       already handles this internally,but to make the code more read=
able and user-friendly
> >>>>
> >>>> commit 233e89322cbe ("alloc_tag: fix module allocation
> >>>> tags populated area calculation") is currently in the
> >>>> mm-hotfixes-unstable branch, so this patch is
> >>>> developed based on the mm-hotfixes-unstable branch.
> >>>> ---
> >>>>    lib/alloc_tag.c | 12 ++++++++++++
> >>>>    1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >>>> index f942408b53ef..bd3ee57ea13f 100644
> >>>> --- a/lib/alloc_tag.c
> >>>> +++ b/lib/alloc_tag.c
> >>>> @@ -10,6 +10,7 @@
> >>>>    #include <linux/seq_buf.h>
> >>>>    #include <linux/seq_file.h>
> >>>>    #include <linux/vmalloc.h>
> >>>> +#include <linux/math.h>
> >>>>
> >>>>    #define ALLOCINFO_FILE_NAME            "allocinfo"
> >>>>    #define MODULE_ALLOC_TAG_VMAP_SIZE     (100000UL * sizeof(struct =
alloc_tag))
> >>>> @@ -422,6 +423,17 @@ static int vm_module_tags_populate(void)
> >>>>                           return -ENOMEM;
> >>>>                   }
> >>>>                   vm_module_tags->nr_pages +=3D nr;
> >>>> +
> >>>> +               /*
> >>>> +                * Kasan allocates 1 byte of shadow for every 8 byte=
s of data.
> >>>> +                * When kasan_alloc_module_shadow allocates shadow m=
emory,
> >>>> +                * it does so in units of pages.
> >>>> +                * Therefore, here we need to align to MODULE_ALIGN.
> >>>> +                */
> >>>> +               if ((phys_end & (MODULE_ALIGN - 1)) =3D=3D 0)
> >>> phys_end is calculated as:
> >>>
> >>> unsigned long phys_end =3D ALIGN_DOWN(module_tags.start_addr, PAGE_SI=
ZE) +
> >>>                                              (vm_module_tags->nr_page=
s
> >>> << PAGE_SHIFT);
> >>>
> >>> and therefore is always PAGE_SIZE-aligned. PAGE_SIZE is always a
> >>> multiple of MODULE_ALIGN, therefore phys_end is always
> >> When CONFIG_KASAN_VMALLOC is not enabled
> >>
> >> #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
> > Ah, sorry, I misread this as (PAGE_SIZE >> KASAN_SHADOW_SCALE_SHIFT)
> > and assumed MODULE_ALIGN is always multiple of PAGE_SIZE. Now it makes
> > more sense. However I'm still not sure about this condition:
> >
> > if ((phys_end & (MODULE_ALIGN - 1)) =3D=3D 0)
> >
> > What if page_end is not MODULE_ALIGN-aligned. We will be skipping
> > kasan_alloc_module_shadow().
>
>
> Theoretically, this scenario does not exist.
>
>
> Please refer to the following:
>
> https://elixir.bootlin.com/linux/v6.13-rc2/source/arch/x86/mm/init.c#L107=
2
>
> They would all comply with MODULE_ALIGN.

Well, not all. The original execmem_vmap() called from
alloc_mod_tags_mem() will indeed return MODULE_ALIGN-aligned address,
therefore the original phys_end is MODULE_ALIGN-aligned. But as
phys_end grows it can become misaligned. Let's modify my example:

module_tags.start_addr =3D 0x8000; (returned by execmem_vmap())
// we need to allocate 1 page (nr =3D 1)
phys_end  =3D 0x8000; // MODULE_ALIGN'ed, so we allocate a shadow page
// tags covered area is [0x8000-0x9000]
// our shadows memory represents the area [0x8000-0x10000]

// now we allocate 8 more pages (nr =3D 8)
phys_end =3D 0x9000; // not MODULE_ALIGN'ed, we skip allocating shadow page=
s
// tags covered area is [0x8000-0x11000]
// but our shadows memory still represents the area [0x8000-0x10000]


>
>
> > For example, say module_tags.start_addr =3D=3D 0x1018 (4096+24), origin=
al
> > phys_end will be 0x1000 (4096) and say we allocated one page (nr =3D=3D
> > 1), tags area is [0x1000-0x2000]. phys_end is not MODULE_ALIGN-aligned
> > and we will skip kasan_alloc_module_shadow(). IIUC, this is already
> > incorrect.
> > Now, say the next time we allocate 8 pages. phys_end this time is
> > 0x2000 and the new tags area spans [0x1000-0xA000], we skip
> > kasan_alloc_module_shadow() again. Next time we allocate pages,
> > phys_end is 0xA000 and it again is not MODULE_ALIGN-aligned, we skip
> > again. You see my point?
> >
> >> https://elixir.bootlin.com/linux/v6.13-rc2/source/include/linux/execme=
m.h#L11
> >>
> >> and On x86, KASAN_SHADOW_SCALE_SHIFT is set to 3
> >>
> >> https://elixir.bootlin.com/linux/v6.13-rc2/source/arch/x86/include/asm=
/kasan.h#L7
> >>
> >> As mentioned in my comment, Kasan allocates 1 byte of shadow for every=
 8
> >> bytes of data
> >>
> >> So, when you allocate a shadow page through kasan_alloc_module_shadow,
> >> it corresponds to eight physical pages in our system.
> >>
> >> So, we need MODULE_ALIGN to ensure proper alignment when allocating
> >> shadow memory for modules using KASAN.
> >>
> >> Let's take a look at the kasan_alloc_module_shadow function again
> >>
> >> As I mentioned earlier,Kasan allocates 1 byte of shadow for every 8
> >> bytes of data.
> >>
> >> Assuming phys_end is set to 0 for the sake of this example, if you
> >> allocate a single shadow page,
> >>
> >> the corresponding address range it can represent would be [0, 0x7FFFF]=
.
> >>
> >> So, it is incorrect to call kasan_alloc_module_shadow every time a pag=
e
> >> is allocated, as it can trigger warnings in the system.
> >>
> >> https://elixir.bootlin.com/linux/v6.13-rc2/source/mm/kasan/shadow.c#L5=
99
> >>
> >> Thanks
> >>
> >> Best Regards Hao
> >>
> >>> MODULE_ALIGN-aligned and the above condition is not needed.
> >>>
> >>>> +                       kasan_alloc_module_shadow((void *)phys_end,
> >>>> +                                                 round_up(nr << PAG=
E_SHIFT, MODULE_ALIGN),
> >>> Here again, (nr << PAGE_SHIFT) is PAGE_SIZE-aligned and PAGE_SIZE is =
a
> >>> multiple of MODULE_ALIGN, therefore (nr << PAGE_SHIFT) is always
> >>> multiple of MODULE_ALIGN and there is no need for round_up().
> >>>
> >>> IOW, I think this patch should simply add one line:
> >>>
> >>>                   vm_module_tags->nr_pages +=3D nr;
> >>> +               kasan_alloc_module_shadow((void *)phys_end, nr <<
> >>> PAGE_SHIFT, GFP_KERNEL);
> >>>
> >>> Am I missing something?
> >>>
> >>
> >>>> +                                                 GFP_KERNEL);
> >>>>           }
> >>>>
> >>>>           /*
> >>>> --
> >>>> 2.25.1
> >>>>

