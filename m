Return-Path: <linux-kernel+bounces-325851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F370975EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F50028550B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445B3548E0;
	Thu, 12 Sep 2024 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3wzHZkV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC6250EC;
	Thu, 12 Sep 2024 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108788; cv=none; b=tuE7Qt4zOCZ4W7lYWHkorpM2Zifozjt9LtcgFtNkMXLTthysPWt9i+hhaC1Gm8C4nWPCg/+STqD3GSmVCSrNCW1R6UnINWe0HuOhFq1DEhvVmPvnp5OgXKU/4dK1MdSZev36e4gvGYz+r5zTdhG0REAoHGH0uF44gtyK8ngW97U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108788; c=relaxed/simple;
	bh=e9tPhNw4DSM9H3ZLRGgjVmdzOAKR+agI9f7RkvinmHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=LqpZhfVtpzVetrScz+xEvZbJV4hcMY3M0JKKVpViHCBoqyP3I9s34OYY42P3RTAE/ecY0YrD9F8MNvP6mlWouBvhk7+j+uxeAEpb2td9qsnnW1t4oB/dSQy71v2lyleuV8w73Q9TjkImW0lT5UV05lm7AU8RO9V5SrY8Zs8ZKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3wzHZkV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8ce5db8668so74943366b.1;
        Wed, 11 Sep 2024 19:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726108785; x=1726713585; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/kkkBe9iezBDeEgawr9D7kOffi9AK834GJ+Uv7qWW8=;
        b=K3wzHZkVGguWI1T+a8Chzn3GmNoqZaWNTobWxEnjHZaW9oqPM0sWjhUCWXiNHqxHP3
         kpdMu753DAbrLzSDWnualqoHwH37qcvBjC7ZpNpJ+upnkLfqcO4Io8b3ay09l9e2Eyq/
         mj9yH2HryT69gNqVSIvq2hVEC/bKCGS/Cb/YSNwFvdT5vKGF2Y1a4HhIB3ucpvDc0Isn
         uLKUQRPSGdzqzdWKWr7+enYStUGjMtIfMLblo2iM/XuhtJhOrSaySPDpG7yQhOeGgsuV
         c82Ld1G0QKrfi15SJvkXGcYrO4vXEMQciFGA80eJTxzoJpHNfiTDAo8D6FGlCV18xn+A
         b+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726108785; x=1726713585;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/kkkBe9iezBDeEgawr9D7kOffi9AK834GJ+Uv7qWW8=;
        b=uu7EVPSqPl/ErHhNvG2MGxAYONpLyNKSwPZBMrsFJKuHBOBPt3F2XIJWQlbixbMPwE
         LGE78XeUQlb0yrbBSWoIkQJh8idiyavBVbOCTKG/WDoW63FqbwtqyBeKozQSiS64krhR
         MfHbddgvCzFBuKj33V9CozADnzH3DYBJqNXooTdHtn6fCDjtiNcdCNPKfSPdIMc5G0HL
         cJCFTxrTo840dBc1Zew4gNgaST77wpR1RyJruEYuvoAdsmgF9HbqZqh1obibpmlXLPh7
         lDDV7Xsz0uFSurVZYbQdRvnefhBePGSWfiM8Oa0ZnKAR2oEfSZfT9j6PDD8RGiafzw5k
         r+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVCbAaIgPtb6iKQesSZ8MXY90SFJF2d4ilnZNfBlzg1EOAeZZqzyFwpoEDa+LIEuckj0yasHaJL5LvGrOrZ@vger.kernel.org, AJvYcCWMH/J+gSQXrcN7pQs4paCBNwsjCMlxzVxK1rISfXHEQWY7uWztoa1luYspWXTTeEhnL+93k+kW4O5hNuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xK5oi3h9hL4nsnfYrU+fHrxp6cDFm81Mo2DFUuJ0IBepb81X
	7lu12TPcvhm3wg50cfq34CVvvgYEOcPaJrOM97jY5xdkWkgX9f5tdr/KRhA30NzqFXsbp5E0m2X
	hdTSHOWfM4ZSmGpM31SBCXDWlTNs=
X-Google-Smtp-Source: AGHT+IFt4V8e236rRYDmApHPERZeFERsGtFTWd5FkFJ7PPhgLtzf+6ih0bwQGygY9Sh14JzyV5nfIMKwNbll/Qs96SM=
X-Received: by 2002:a17:907:f75a:b0:a7a:a0c2:8be9 with SMTP id
 a640c23a62f3a-a9029432e30mr139276566b.18.1726108784683; Wed, 11 Sep 2024
 19:39:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuHtb43Ar21ZptNz@p100> <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
 <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de> <CAHbLzkotBTOf0OrPSN4o=UEvRXjT=L=NSZn_=FBA6nG51ppjYg@mail.gmail.com>
 <75ihgmlcmou7yatoeva5sezbf6stow4gtdyurwzj5fxghjq7yw@o3u5wudjdnkk>
In-Reply-To: <75ihgmlcmou7yatoeva5sezbf6stow4gtdyurwzj5fxghjq7yw@o3u5wudjdnkk>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 11 Sep 2024 19:39:31 -0700
Message-ID: <CAHbLzkp8e2MuawOMQVqiA3bAOY-z5sG0ozT-nMG7F8+siMn-5w@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable stack
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Yang Shi <shy828301@gmail.com>, 
	Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:42=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Yang Shi <shy828301@gmail.com> [240911 21:08]:
> > On Wed, Sep 11, 2024 at 5:50=E2=80=AFPM Helge Deller <deller@gmx.de> wr=
ote:
> > >
> > > On 9/12/24 01:05, Liam R. Howlett wrote:
> > > > * Yang Shi <shy828301@gmail.com> [240911 18:16]:
> > > >> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> > > >> <Liam.Howlett@oracle.com> wrote:
> > > >>>
> > > >>> * Helge Deller <deller@kernel.org> [240911 15:20]:
> > > >>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> > > >>>> sufficient to map memory for usage as stack on all architectures=
.
> > > >>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDO=
WN
> > > >>>> has to be used.
> > > >>>> To clarify, here is the relevant info from the mmap() man page:
> > > >>>>
> > > >>>> MAP_GROWSDOWN
> > > >>>>     This flag is used for stacks. It indicates to the kernel vir=
tual
> > > >>>>     memory system that the mapping should extend downward in mem=
ory.  The
> > > >>>>     return address is one page lower than the memory area that i=
s
> > > >>>>     actually created in the process's virtual address space.  To=
uching an
> > > >>>>     address in the "guard" page below the mapping will cause the=
 mapping
> > > >>>>     to grow by a page. This growth can be repeated until the map=
ping
> > > >>>>     grows to within a page of the high end of the next lower map=
ping,
> > > >>>>     at which point touching the "guard" page will result in a SI=
GSEGV
> > > >>>>     signal.
> > > >>>>
> > > >>>> MAP_STACK (since Linux 2.6.27)
> > > >>>>     Allocate the mapping at an address suitable for a process or=
 thread
> > > >>>>     stack.
> > > >>>>
> > > >>>>     This flag is currently a no-op on Linux. However, by employi=
ng this
> > > >>>>     flag, applications can ensure that they transparently obtain=
 support
> > > >>>>     if the flag is implemented in the future. Thus, it is used i=
n the
> > > >>>>     glibc threading implementation to allow for the fact that
> > > >>>>     some architectures may (later) require special treatment for
> > > >>>>     stack allocations. A further reason to employ this flag is
> > > >>>>     portability: MAP_STACK exists (and has an effect) on some
> > > >>>>     other systems (e.g., some of the BSDs).
> > > >>>>
> > > >>>> The reason to suggest this change is, that on the parisc archite=
cture the
> > > >>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN fla=
g will not
> > > >>>> work. Note that there exists no MAP_GROWSUP flag.
> > > >>>> By changing the behaviour of MAP_STACK to mark the memory area w=
ith the
> > > >>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on t=
he
> > > >>>> architecture) the MAP_STACK flag does exactly what people would =
expect on
> > > >>>> all platforms.
> > > >>>>
> > > >>>> This change should have no negative side-effect, as all code whi=
ch
> > > >>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> > > >>>>
> > > >>>> Signed-off-by: Helge Deller <deller@gmx.de>
> > > >>>>
> > > >>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > >>>> index bcb201ab7a41..66bc72a0cb19 100644
> > > >>>> --- a/include/linux/mman.h
> > > >>>> +++ b/include/linux/mman.h
> > > >>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > > >>>>        return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN=
 ) |
> > > >>>>               _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED   =
 ) |
> > > >>>>               _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC     =
 ) |
> > > >>>> +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     =
) |
> > > >>>
> > > >>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this wi=
ll
> > > >>> change the user interface to create a vma that will grow.  I'm no=
t
> > > >>> entirely sure this is okay?
> > > >>
> > > >> AFAICT, I don't see this is a problem. Currently huge page also sk=
ips
> > > >> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> > > >> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> > > >> stack.
> > > >
> > > > If someone is using MAP_STACK to avoid having a huge page, they wil=
l
> > > > also get a mapping that grows - which is different than what happen=
s
> > > > today.
> > > >
> > > > I'm not saying that's right, but someone could be abusing the exist=
ing
> > > > flag and this will change the behaviour.
> > >
> > > Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exact=
ly that?
> > > Why abusing MAP_STACK for that?
> >
> > Different sources and reports showed having huge pages for stack
> > mapping hurts performance. A lot of applications, for example, pthread
> > lib, allocate stack with MAP_STACK and they don't call MADV_NOHUGEPAGE
> > on stack mapping.
> >
>
> It makes sense to have a stack with NOHUGEPAGE, but does anyone use
> MAP_STACK to avoid the extra syscall to madv to set it on mappings that
> are NOT stacks which would now become stack-like with this change?

AFAICT, I'm not aware of such usecase. It is definitely not
recommended and misuse of MAP_STACK. I don't see how we can prevent
this in kernel other than document it properly.

>
> ...
> > > >>>>               _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAG=
E) |
> > > >>>>               arch_calc_vm_flag_bits(flags);
> > > >>>>   }
> > >

