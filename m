Return-Path: <linux-kernel+bounces-325800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57F975E58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6CC283ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113091AACA;
	Thu, 12 Sep 2024 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7L6DjL5"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63DF5227;
	Thu, 12 Sep 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103318; cv=none; b=h6x6eSCwNmsQA89pEPfWDg+ayH8s+DZfJOLObYzYy+87GHIpkHhpZKMOerNu800mMyvQf6wl6rhggQGaW4DssKHxxSEUbtUAiSRA77pyLzo47ybcTbc7JYflI/X/ngeBs7+STW3u4stQuxMLqHiMQ2OM2Nmmce9IgQ+47B2c1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103318; c=relaxed/simple;
	bh=ldeP0fDNDdwMkQ8B/xI861UnLI/En7pbroQqADDgQCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS40o9Ix6INDEWcmA2ortGEiWtQzqMMOQ6s6N12034dHDj9p2eKsEAmpUtxC28YIUr3uN1YHZL1l12j5+Q8/AbKdpjKcKnZc5eOHYRt2To17UrTqi9pa0ArtdJ0p+8z2TsLr91Xmm2KvARWoU7u1Cg07ZYarX3xLRUoY2N1X754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7L6DjL5; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so54043866b.2;
        Wed, 11 Sep 2024 18:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726103315; x=1726708115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcDVTvtgjgyED80cdWwepObDNGz7pJtl8u4QlhG26f4=;
        b=H7L6DjL52QzlbsmlnFcyISxf6gNozV/KelG4vaoCchmFiggSoxB6fwwUGpUbWci1vn
         6l01vgyW0xGNZl23d9PaR7Prw6CZFPsD/QwrI2esIii7rEpblbzj6AT0LX2Y3xk0IlkD
         DsqgujmLTYjDyuOy4koDueyE3fqSvnxuuZCnzSbc2ZVcHIhnrCbek316DNLB+IEAxBwI
         1erB8iMb6Rw6d7vn7CWFsITueBAuKbFDCev9Tt3KlHp/GorTCh6hqszM3+hyC0+p7MbS
         VmsG/WrE3eS5vS3P2jb4UGjXAWyGmlLUTLemsCnAkRDbQv15S5KBbCiGmGLxMEKDYESB
         MDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726103315; x=1726708115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcDVTvtgjgyED80cdWwepObDNGz7pJtl8u4QlhG26f4=;
        b=pWQEGGNp8bjklvg2NrYWSzG2uB9cxBEZBlzCPcGEI10IiUH4BP3FYrDaTGe4HraqFy
         WblNEw205kgQnqoar2fsMDsc2WZ1K3vcn/aGJ62Z7uZu4+4T9mQDaFNi4N8SShP5eDG9
         ScJwWtTbuFm7sdSSsIt5ZABoX8EFGNxvycaEZUdByxUm3ddVa8EVmEokIlSdMSpxhXec
         mE3tyklD309rMLEKxMK19VJMkh1QC612l5IGdD2BkjDkvulIdIkkAU/qd3DLgyFEcaKN
         IDcXrebnkyAPrBjlN2n7rxP3OyTrWQzSFl/O71A1BdcxaR9tF8K+n9s7hBL8MTMolGjQ
         o6CA==
X-Forwarded-Encrypted: i=1; AJvYcCUNUFzlSsBQr3BVbWNthzydsLscpgODDcvNQtCaXLht8sHf2zKHjfH9VvmIb0gBeH/pKfa05TFf7xQ5U4s=@vger.kernel.org, AJvYcCXctOyWgINfVxB0iPBuKhVDf//CZJoI+qOtpIeMrEC1mgXzpiU1f2LJoRzuZx9gTrHGVXeuHVYUQR9xW61h@vger.kernel.org
X-Gm-Message-State: AOJu0YxnIk4vVorlQgqPUeJNtaeLLw6KavlH2LJAxy4J1tJCHOCiHZEH
	8SF6VKVcIG+DmJa0nnHBkDbT7GY6qs5vSxSThHQ9WoWw560gI3gj4zDZjJ18Hp8rYy8PM834ku9
	oaLnXXA/HAepYdmEYDyEY6XSHFq0=
X-Google-Smtp-Source: AGHT+IGuNHOwOxJr0yfxP7DuKyaFe2n8orJM8Wx7yZsuWqL16QoRup0udjib4V4TG14i+Rj1oiO2AzEZw1rxrAKnR1Q=
X-Received: by 2002:a17:907:efcb:b0:a77:f2c5:84a9 with SMTP id
 a640c23a62f3a-a9029504f45mr115830966b.18.1726103314913; Wed, 11 Sep 2024
 18:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuHtb43Ar21ZptNz@p100> <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
 <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d> <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
In-Reply-To: <95c4efe9-e92a-46fe-bf41-9141e125332d@gmx.de>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 11 Sep 2024 18:08:23 -0700
Message-ID: <CAHbLzkotBTOf0OrPSN4o=UEvRXjT=L=NSZn_=FBA6nG51ppjYg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable stack
To: Helge Deller <deller@gmx.de>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Helge Deller <deller@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 5:50=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> On 9/12/24 01:05, Liam R. Howlett wrote:
> > * Yang Shi <shy828301@gmail.com> [240911 18:16]:
> >> On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> >> <Liam.Howlett@oracle.com> wrote:
> >>>
> >>> * Helge Deller <deller@kernel.org> [240911 15:20]:
> >>>> This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> >>>> sufficient to map memory for usage as stack on all architectures.
> >>>> Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
> >>>> has to be used.
> >>>> To clarify, here is the relevant info from the mmap() man page:
> >>>>
> >>>> MAP_GROWSDOWN
> >>>>     This flag is used for stacks. It indicates to the kernel virtual
> >>>>     memory system that the mapping should extend downward in memory.=
  The
> >>>>     return address is one page lower than the memory area that is
> >>>>     actually created in the process's virtual address space.  Touchi=
ng an
> >>>>     address in the "guard" page below the mapping will cause the map=
ping
> >>>>     to grow by a page. This growth can be repeated until the mapping
> >>>>     grows to within a page of the high end of the next lower mapping=
,
> >>>>     at which point touching the "guard" page will result in a SIGSEG=
V
> >>>>     signal.
> >>>>
> >>>> MAP_STACK (since Linux 2.6.27)
> >>>>     Allocate the mapping at an address suitable for a process or thr=
ead
> >>>>     stack.
> >>>>
> >>>>     This flag is currently a no-op on Linux. However, by employing t=
his
> >>>>     flag, applications can ensure that they transparently obtain sup=
port
> >>>>     if the flag is implemented in the future. Thus, it is used in th=
e
> >>>>     glibc threading implementation to allow for the fact that
> >>>>     some architectures may (later) require special treatment for
> >>>>     stack allocations. A further reason to employ this flag is
> >>>>     portability: MAP_STACK exists (and has an effect) on some
> >>>>     other systems (e.g., some of the BSDs).
> >>>>
> >>>> The reason to suggest this change is, that on the parisc architectur=
e the
> >>>> stack grows upwards. As such, using solely the MAP_GROWSDOWN flag wi=
ll not
> >>>> work. Note that there exists no MAP_GROWSUP flag.
> >>>> By changing the behaviour of MAP_STACK to mark the memory area with =
the
> >>>> VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
> >>>> architecture) the MAP_STACK flag does exactly what people would expe=
ct on
> >>>> all platforms.
> >>>>
> >>>> This change should have no negative side-effect, as all code which
> >>>> used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> >>>>
> >>>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>>>
> >>>> diff --git a/include/linux/mman.h b/include/linux/mman.h
> >>>> index bcb201ab7a41..66bc72a0cb19 100644
> >>>> --- a/include/linux/mman.h
> >>>> +++ b/include/linux/mman.h
> >>>> @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> >>>>        return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> >>>>               _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> >>>>               _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
> >>>> +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
> >>>
> >>> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
> >>> change the user interface to create a vma that will grow.  I'm not
> >>> entirely sure this is okay?
> >>
> >> AFAICT, I don't see this is a problem. Currently huge page also skips
> >> the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> >> __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> >> stack.
> >
> > If someone is using MAP_STACK to avoid having a huge page, they will
> > also get a mapping that grows - which is different than what happens
> > today.
> >
> > I'm not saying that's right, but someone could be abusing the existing
> > flag and this will change the behaviour.
>
> Wouldn't a plain mmap() followed by madvise(MADV_NOHUGEPAGE) do exactly t=
hat?
> Why abusing MAP_STACK for that?

Different sources and reports showed having huge pages for stack
mapping hurts performance. A lot of applications, for example, pthread
lib, allocate stack with MAP_STACK and they don't call MADV_NOHUGEPAGE
on stack mapping.

>
> Helge
>
> >>> That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
> >>> change you'd get VM_NOHUGEPAGE | VM_GROWS<something>
> >>>
> >>>>               _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
> >>>>               arch_calc_vm_flag_bits(flags);
> >>>>   }
>

