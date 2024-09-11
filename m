Return-Path: <linux-kernel+bounces-325667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903AB975CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CEE28532E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6CF17A583;
	Wed, 11 Sep 2024 22:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp6RF2dr"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E48F6D;
	Wed, 11 Sep 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726092997; cv=none; b=aSbD9Ok/IBe31ZyaPlEspVlolCn9rnPEBLZIZYemegVcl1bOR07ULDZ/mAgrIkhgM/kz0vF9lq7RbjMsg6+gobBkDSFhD+BsFHLrNQ9wz4YPxnXPCbxcV9AyP74PmQ24RXQN5dXzAyYvrrEWf3Fkt5ERMPiUcVw6Xjfj+h80orA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726092997; c=relaxed/simple;
	bh=nl+kL7QgQxM/QUylOUhcTwlwjC59U57scFHXoXnN1Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EEgEQNrFlNwYX15sQjx/tZFwCMb5W2njnf3Z7TL+qdClbRiy6Kat+je2GO5tWSB3NRvpgUsLu+T+PhRMqsGavsFiQpxcCX8mPkySd/bVch7qtdYe+m8IKdS7YuyhtpwPPDRm+RAI5IsW3y8pfb8bKDdXt8deZ17U72PTPo8H1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp6RF2dr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so39564266b.3;
        Wed, 11 Sep 2024 15:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726092994; x=1726697794; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9KvCVXqC1SfozHPy8UXikKOVlQVR0hTerU6v2f3sjM=;
        b=Fp6RF2drSRlaOALq02ChN8K/iyt12EGgwnh7bWbHOZjXy9KLJoBZky3sBg8RM+4v/i
         HKCmCEQWrL/TheneSFuZmgiUPuvvceKSR4M5Xa03xyROEPYh8eaNmeurctEPkIoloJFY
         BOcvdmI2RDLuZsNKJ8Fzt6+JbFVE5u5OTmzYFjGe3lwHQGlUeAQACrrbhm+ndiDedd08
         TrwNFx9hnhRtArSWpC7l0T8c/+VF/S9wbxOIhNeIvqWsOAHkKIdILZfYKoo4dDMbqgN7
         MK8drTSIViyCDnqBsDny7vq4+3rs3ApLPV5/ZnQYWnOtCnuwAsZsP6/oFHhXb79tppPI
         CGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726092994; x=1726697794;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9KvCVXqC1SfozHPy8UXikKOVlQVR0hTerU6v2f3sjM=;
        b=nNCdVRHNcbiS0WmiAvI6ghXexgdlPmcp6SwfWffnhBGtgxlGTtfO/2OQYTFe7DYGos
         vzgnHs+zOKySdgO/kBH35PzETvzZjPrZtPMLdKhrcMKee929TfidK6IPSKg0qBcwZy9Z
         KkXugAE3/hZGyPZZf4zZl8WUvMTD2zVzMGxMnMdtbIsTpe5sQueeMFNbjPBawXjw1Z5g
         6TjvpgH63GBw+caO/YRJ4dwYrhHecdIjZMA1w1KyMtv4k847iHgMD3ZeHZyEwjaYQ1Ez
         9yenjniL96u4xIdDkx+h7CiPkK5RaQZtAH6uN/hcm4NE/zAKlzQMNN6LgarGNELtjfw2
         j0vw==
X-Forwarded-Encrypted: i=1; AJvYcCV3uYpSDshqZXvpw919kv/1CpR9tuprYDEwIacpJ3dZ8piyJZDjLwZ97hcCyEI0bcNGgd+5Gz2IfVbGEzAX@vger.kernel.org, AJvYcCWdi0Ry9uVMTlxHS1pBPp/HLgHfTxdeoEHYv/1ro+AIsZAeT88c91b6r8NkGPdhmcD59zbg3iXdRejX0Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEP015n7j14+ikhX/N01K9yq1NVA9NcLH6hgNZ1d1VQQsGuCzj
	Lejj+IY/oAb0150miCG+iyQAph3XrSXPjokSkyUB74zmldIWeB41IV4rOs6RI70QqNm8ZfFRc3r
	jek+vFjS+AYP0NGMycBKvDl7p2x4=
X-Google-Smtp-Source: AGHT+IH4uI7X6FGBbu6IrwSTM4Xlg2+1p0zQzS2IwH39YPGtrb3oFgSwcFZ1aZH7zm/b4kgO9kBs2EVF+EDvbeCfojg=
X-Received: by 2002:a17:907:e29f:b0:a86:7b01:7dcc with SMTP id
 a640c23a62f3a-a9029435ad1mr83653666b.18.1726092993971; Wed, 11 Sep 2024
 15:16:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuHtb43Ar21ZptNz@p100> <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
In-Reply-To: <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 11 Sep 2024 15:16:22 -0700
Message-ID: <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable stack
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Helge Deller <deller@kernel.org>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Helge Deller <deller@kernel.org> [240911 15:20]:
> > This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> > sufficient to map memory for usage as stack on all architectures.
> > Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
> > has to be used.
> > To clarify, here is the relevant info from the mmap() man page:
> >
> > MAP_GROWSDOWN
> >    This flag is used for stacks. It indicates to the kernel virtual
> >    memory system that the mapping should extend downward in memory.  Th=
e
> >    return address is one page lower than the memory area that is
> >    actually created in the process's virtual address space.  Touching a=
n
> >    address in the "guard" page below the mapping will cause the mapping
> >    to grow by a page. This growth can be repeated until the mapping
> >    grows to within a page of the high end of the next lower mapping,
> >    at which point touching the "guard" page will result in a SIGSEGV
> >    signal.
> >
> > MAP_STACK (since Linux 2.6.27)
> >    Allocate the mapping at an address suitable for a process or thread
> >    stack.
> >
> >    This flag is currently a no-op on Linux. However, by employing this
> >    flag, applications can ensure that they transparently obtain support
> >    if the flag is implemented in the future. Thus, it is used in the
> >    glibc threading implementation to allow for the fact that
> >    some architectures may (later) require special treatment for
> >    stack allocations. A further reason to employ this flag is
> >    portability: MAP_STACK exists (and has an effect) on some
> >    other systems (e.g., some of the BSDs).
> >
> > The reason to suggest this change is, that on the parisc architecture t=
he
> > stack grows upwards. As such, using solely the MAP_GROWSDOWN flag will =
not
> > work. Note that there exists no MAP_GROWSUP flag.
> > By changing the behaviour of MAP_STACK to mark the memory area with the
> > VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
> > architecture) the MAP_STACK flag does exactly what people would expect =
on
> > all platforms.
> >
> > This change should have no negative side-effect, as all code which
> > used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> >
> > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > index bcb201ab7a41..66bc72a0cb19 100644
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> >       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> >              _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> >              _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
> > +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
>
> Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
> change the user interface to create a vma that will grow.  I'm not
> entirely sure this is okay?

AFAICT, I don't see this is a problem. Currently huge page also skips
the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
__thp_vma_allowable_orders() returns 0 if the vma is a temporary
stack.

>
>
> That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
> change you'd get VM_NOHUGEPAGE | VM_GROWS<something>
>
> >              _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
> >              arch_calc_vm_flag_bits(flags);
> >  }
> >
>

