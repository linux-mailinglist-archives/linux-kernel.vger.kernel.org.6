Return-Path: <linux-kernel+bounces-433472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4BE9E58DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA85164BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FE21A421;
	Thu,  5 Dec 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JWI4XGo2"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363D31B0F22
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410135; cv=none; b=afkNzGF+w2+KAkGwt98IxYy4mWEOjAkrALzVE2LcZhhVW1rTE+tX4hYpjvVlRNdIP+WrQvsl2sdMo9UzP6OmL9FpivjW+KkUJpFoV3kf4ctBhYbzOAnHQHR7HAcM0eRU0p6I8KblHpq2y5HeiBarH8axHbrIyhnoQpend9PFgSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410135; c=relaxed/simple;
	bh=N2SeMJpPGbddLhpyjmtwQUIsUgW6F2QSmzy0XUSPXfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qzb8lh6rEbt7pXQyz89ShjX6RJevbYgiG3GxYRUui0GinL0Rg/OdQOJoXQbUZOjs7mVGTvv0tqiC0GCPorw2BR9h1auaYF7NDF86GOPu4jq6Y78ISd6lhTThAn0FCnw2exirwghNVmnzAvN8SR70arxQE1EXLqcgSAj9tiZ2e4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JWI4XGo2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46687f60b73so255311cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 06:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733410131; x=1734014931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjTym21kMjXxfknSCULnhjE4yJ07J6pa/euFI3Nd5Gg=;
        b=JWI4XGo2hAP6T6guy9LwltatqplHzRF6lMcVfuIaFma+YqHz3mGXKErGja1lMRnpD4
         mb8fAxT/ZSBN1UUeZDflC2cRadAm3ZZotvS8c8MLqCqWDKoOBWXuzumsz/ZOjdJkOLdO
         euLiUlXJLgJFo/UGpEf2tC6GBLKVTn/6BDPKSxXklraemkPXjvv3zjHuccXZMGsnGP/N
         6pjgQ1iwkCEomnC3kw9UfFFX7Kebs/DLeKoio2bysqJ97yb3ctmw1jqqlt3ANPnsUMKg
         2TY9HN8fePLWUbNDXTuN4JHdRivGcbiLDocIKgXWFA6b5Ly06uoIm4i2BOXZq1vQnBMw
         JvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733410131; x=1734014931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjTym21kMjXxfknSCULnhjE4yJ07J6pa/euFI3Nd5Gg=;
        b=wg7AmKQzCDWFbE53RoWt+B32epJqZvF0KX8uawbZU6+vabGm+JExVUa1PQ5hKfmdYc
         RDkHQhdZns+pvPyZU3vFpkb/9HJ92ZKxNEXicEmiOxdUCbEtXmJ2xObYatVmSvy/g089
         +HylYu4AixMERvFYzmHw6x9KyW77Kzkq1apDc/+beUDjEEj0Tbfo1J5oosz+OmUlhwbE
         hR1rFcfoF2RTfLfRSJMZsWJ+nzfEeb5Sr5mbD4IGTgMRWHWjnNmYTl46hbMV/GlWL4M5
         vQVUku6UxM2lHhvEbaRb+nbZ98m7yDgPYc010dwLBtTEFoFAFBYKNGhYrm8AuS8x2sBb
         x3pw==
X-Forwarded-Encrypted: i=1; AJvYcCWgy0kZxwU3ltFtroX5KIAVWTq6wTCvwCH42Z6GOL49wiuBx9qnQFkEqOpC9ICkMMMUujnhS1S1xBcjQKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlDYDnhdg4jk1/UnDU6WJHT3oLgZMvzd9O68kVTvRVLzueOrT2
	j91+eT+/87SixJTSJwKfDY+8P89ILh6kajdcveOJDznO1+mW+/kox6lZH/Gp9uIRcX7IXX9d3Dr
	+GfiluaIgWqntdvphmkGuwJQ3AUwKrzECN3/yxr3ziOZVt9Wz+nekmbF3Ow==
X-Gm-Gg: ASbGncsOSvRfo2DT80cOi9uwDOlbafxJBK03dGDb8bpwidFsSmGKRdYIXOcW8NUfBkE
	QpdXKMYMYc8E5nBMdIQ5s1lJCA1M/RW0=
X-Google-Smtp-Source: AGHT+IEo/e8fIFYI1rnqNhQXA8pP4V80wB0CTsiZ1cwJ96wA3BSxRx75lRvtghC2skrlzdXGA7w5+tTiVNQv8JHMayw=
X-Received: by 2002:a05:622a:5599:b0:466:8356:8b71 with SMTP id
 d75a77b69052e-467298d94ebmr3190621cf.19.1733410130723; Thu, 05 Dec 2024
 06:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204075248.384215-1-hao.ge@linux.dev> <20241204083448.387862-1-hao.ge@linux.dev>
 <CAJuCfpF5Yo3Bz1OUy=rfd5-0DRZsWSRaekR3Y-f5TRatdXWkVQ@mail.gmail.com>
 <e5d6cb44-9a86-ee94-9210-d56acee483c4@linux.dev> <CAJuCfpFHEpFw61ZtqHzgYrpiHn1k86h2LwzZf+C4=sfpULY4TQ@mail.gmail.com>
 <6dab626e-acee-9f4e-c97b-7a225882edff@linux.dev> <b2f45c47-37e0-c9cf-27ee-68408b2b2d4c@linux.dev>
In-Reply-To: <b2f45c47-37e0-c9cf-27ee-68408b2b2d4c@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 5 Dec 2024 06:48:38 -0800
Message-ID: <CAJuCfpF8ftPcd24y2L4C_37GDMC4iaDDh8SicwspwmVAkB=3fQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/alloc_tag: fix vm_module_tags_populate's KASAN
 poisoning logic
To: Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 7:20=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
> Hi Suren
>
>
> On 12/5/24 10:14, Hao Ge wrote:
> > Hi Suren
> >
> >
> > On 12/5/24 03:33, Suren Baghdasaryan wrote:
> >> On Wed, Dec 4, 2024 at 7:08=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote=
:
> >>> Hi Suren
> >>>
> >>>
> >>> Thank you for your review.
> >>>
> >>>
> >>> On 12/4/24 22:39, Suren Baghdasaryan wrote:
> >>>> On Wed, Dec 4, 2024 at 12:35=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wr=
ote:
> >>>>> From: Hao Ge <gehao@kylinos.cn>
> >>>>>
> >>>>> After merge commit 233e89322cbe ("alloc_tag:
> >>>>> fix module allocation tags populated area calculation"),
> >>>>> We still encountered a KASAN bug.
> >>>>>
> >>>>> This is because we have only actually performed
> >>>>> page allocation and address mapping here.
> >>>>> we need to unpoisoned portions of underlying memory.
> >>>>>
> >>>>> Because we have a change in the size here,we need to
> >>>>> re-annotate poisoned and unpoisoned portions of underlying memory
> >>>>> according to the new size.
> >>>>>
> >>>>> Here is the log for KASAN:
> >>>>>
> >>>>> [    5.041171][    T1]
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>> [    5.042047][    T1] BUG: KASAN: vmalloc-out-of-bounds in
> >>>>> move_module+0x2c0/0x708
> >>>>> [    5.042723][    T1] Write of size 240 at addr ffff80007e510000
> >>>>> by task systemd/1
> >>>>> [    5.043412][    T1]
> >>>>> [    5.043523][   T72] input: QEMU QEMU USB Tablet as
> >>>>> /devices/pci0000:00/0000:00:01.1/0000:02:001
> >>>>> [    5.043614][    T1] CPU: 0 UID: 0 PID: 1 Comm: systemd Not
> >>>>> tainted 6.13.0-rc1+ #28
> >>>>> [    5.045560][    T1] Hardware name: QEMU KVM Virtual Machine,
> >>>>> BIOS 0.0.0 02/06/2015
> >>>>> [    5.046328][    T1] Call trace:
> >>>>> [    5.046670][    T1]  show_stack+0x20/0x38 (C)
> >>>>> [    5.047127][    T1]  dump_stack_lvl+0x80/0xf8
> >>>>> [    5.047533][    T1]
> >>>>> print_address_description.constprop.0+0x58/0x358
> >>>>> [    5.048092][   T72] hid-generic 0003:0627:0001.0001:
> >>>>> input,hidraw0: USB HID v0.01 Mouse [QEMU 0
> >>>>> [    5.048126][    T1]  print_report+0xb0/0x280
> >>>>> [    5.049682][    T1]  kasan_report+0xb8/0x108
> >>>>> [    5.050170][    T1]  kasan_check_range+0xe8/0x190
> >>>>> [    5.050685][    T1]  memcpy+0x58/0xa0
> >>>>> [    5.051135][    T1]  move_module+0x2c0/0x708
> >>>>> [    5.051586][    T1] layout_and_allocate.constprop.0+0x308/0x5b8
> >>>>> [    5.052219][    T1]  load_module+0x134/0x16c8
> >>>>> [    5.052671][    T1]  init_module_from_file+0xdc/0x138
> >>>>> [    5.053193][    T1]  idempotent_init_module+0x344/0x600
> >>>>> [    5.053742][    T1] __arm64_sys_finit_module+0xbc/0x150
> >>>>> [    5.054289][    T1]  invoke_syscall+0xd4/0x258
> >>>>> [    5.054749][    T1] el0_svc_common.constprop.0+0xb4/0x240
> >>>>> [    5.055319][    T1]  do_el0_svc+0x48/0x68
> >>>>> [    5.055743][    T1]  el0_svc+0x40/0xe0
> >>>>> [    5.056142][    T1]  el0t_64_sync_handler+0x10c/0x138
> >>>>> [    5.056658][    T1]  el0t_64_sync+0x1ac/0x1b0
> >>>>>
> >>>>> Fixes: 233e89322cbe ("alloc_tag: fix module allocation tags
> >>>>> populated area calculation")
> >>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >>>> Thanks for the fix!
> >>>>
> >>>>> ---
> >>>>> v2: Add comments to kasan_unpoison_vmalloc like other places.
> >>>>>
> >>>>> commit 233e89322cbe ("alloc_tag: fix module allocation
> >>>>> tags populated area calculation") is currently in the
> >>>>> mm-hotfixes-unstable branch, so this patch is
> >>>>> developed based on the mm-hotfixes-unstable branch.
> >>>>> ---
> >>>>>    lib/alloc_tag.c | 13 +++++++++++++
> >>>>>    1 file changed, 13 insertions(+)
> >>>>>
> >>>>> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >>>>> index 4ee6caa6d2da..f885b3f3af0e 100644
> >>>>> --- a/lib/alloc_tag.c
> >>>>> +++ b/lib/alloc_tag.c
> >>>>> @@ -421,7 +421,20 @@ static int vm_module_tags_populate(void)
> >>>>> __free_page(next_page[i]);
> >>>>>                           return -ENOMEM;
> >>>>>                   }
> >>>>> +
> >>>>> +               kasan_poison_vmalloc((void *)module_tags.start_addr=
,
> >>>>> + vm_module_tags->nr_pages << PAGE_SHIFT);
> >>>>> +
> >>>>>                   vm_module_tags->nr_pages +=3D nr;
> >>>>> +
> >>>>> +               /*
> >>>>> +                * Mark the pages as accessible, now that they are
> >>>>> mapped.
> >>>>> +                * With hardware tag-based KASAN, marking is
> >>>>> skipped for
> >>>>> +                * non-VM_ALLOC mappings, see
> >>>>> __kasan_unpoison_vmalloc().
> >>>>> +                */
> >>>>> +               kasan_unpoison_vmalloc((void
> >>>>> *)module_tags.start_addr,
> >>>>> + vm_module_tags->nr_pages << PAGE_SHIFT,
> >>>>> + KASAN_VMALLOC_PROT_NORMAL);
> >>>> Instead of poisoning [module_tags.start_addr,
> >>>> vm_module_tags->nr_pages], incrementing vm_module_tags->nr_pages and
> >>>> the unpoisoning [module_tags.start_addr, vm_module_tags->nr_pages]
> >>>> could we simply poisons the additional area like this:
> >>>>
> >>>>                   kasan_unpoison_vmalloc((void
> >>>> *)module_tags.start_addr +
> >>>> (vm_module_tags->nr_pages << PAGE_SHIFT),
> >>>>                                          nr << PAGE_SHIFT,
> >>>> KASAN_VMALLOC_PROT_NORMAL);
> >>>>                  vm_module_tags->nr_pages +=3D nr;
> >>>> ?
> >>>
> >>> I had considered making such modifications earlier.
> >>>
> >>> But considering the following situation,
> >>>
> >>> A module tags spans across the regions of [module_tags.start_addr,
> >>> vm_module_tags->nr_pages] and [module_tags.start_addr +
> >>> vm_module_tags->nr_pages, ...].
> >>>
> >>> It may result in false positives for out-of-bounds errors.
> >> Sorry, maybe I'm missing something but I don't see why poisoning only
> >> newly mapped area would lead to false positives. Could you please
> >> clarify?
> >
> >
> > Because KASAN may perceive the two as distinct address spaces, despite
> > their addresses being contiguous.
> >
> > So, when a module tag spans across these two contiguous address
> > spaces, KASAN may incorrectly consider it as an out-of-bounds access.
> >
> >
> >> Also, if you do need to unpoison and then poison, using phys_end and
> >> new_end would be better, like this:
> >>
> >> kasan_poison_vmalloc((void *)module_tags.start_addr,
> >>                                        phys_end -
> >> module_tags.start_addr)
> >>
> >> kasan_unpoison_vmalloc((void *)module_tags.start_addr,
> >>                                            new_end -
> >> module_tags.start_addr,
> >> KASAN_VMALLOC_PROT_NORMAL);
> >
> > OK, the next version will include.
>
> After verification and consideration, I have found that this
> modification may still pose problems.
>
> Because we haven't ensured that  new_end is page-aligned,
>
> So, we've only made the region from||module_tags.start_addr
> tonew_endaccessible.

Correct and the area [module_tags.start_addr, new_end] is the one that
should be considered valid/accessible. We fault-in a physical page
that includes new_end and might cover some area after that address but
accessing the addresses above new_end is technically out-of-bounds
(there are no valid codetags there).

>
> Using this example, in reality,end equals 0xffff80007e5100f0:
>
> Write of size 240 at addr ffff80007e510000 by task systemd/1
>
> When we access other memory within the same page as0xffff80007e5100f0,
> KASAN warnings will also be issued due to the lack of unpoisoned
> portions in that memory.

Will you get a KASAN warning if you access memory below new_end?
Warnings above that address I think should be considered as expected
(even though we have a valid physical page there).
Does that make sense?

>
> Based on that, I would suggest sticking with the V2 version.
>
>
> Thanks
>
> Best Regards
>
> Hao
>
> >
> >
> > Thanks
> >
> > Best regards
> >
> > Hao
> >
> >
> >>>
> >>>>>           }
> >>>>>
> >>>>>           return 0;
> >>>>> --
> >>>>> 2.25.1
> >>>>>

