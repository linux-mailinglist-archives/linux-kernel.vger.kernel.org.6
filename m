Return-Path: <linux-kernel+bounces-325799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDA975E55
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BC181F22A32
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ACF17C61;
	Thu, 12 Sep 2024 01:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YztgrI7k"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0C5227;
	Thu, 12 Sep 2024 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103166; cv=none; b=nKZ6uzAV7ElItzqTSNQBDY0ckfibGSaYxxvFbhYP3KStF/VVYXoHazcMq9MpE2ew6hWY0ZlKO0KPXxfoIt7oxDSO5ugAWbN1/I2EUwzUgHqGvT1WpoO06bmkjQbAdV/gcqlzTlVgttj9AFW2uf4jUWWriOWdCNCx7g2aUOEuSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103166; c=relaxed/simple;
	bh=KB1ffsa8Mhe9sfRHR4l9S6AxDPtkxl6VDsXcYG3bkpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=W8zK5g5LgRkH/VVIfuTGufvxEFiyYLk1gqrmazl/9zKs0/abPb/YSFsG/Rui99C9I2LMVqW5osJxJej3nyCNvGKq+0jFw7NI9SVmCpilwOapCo8oF9X8pW10nvr7J4IXPeM2PNPs7B66B88F0caQNlrifuFw/1yALVvWdilksZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YztgrI7k; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso65749566b.1;
        Wed, 11 Sep 2024 18:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726103162; x=1726707962; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrZwj4wQdjgaXXXSNnDTmsMPVIiHBnnCTDIjF/U8aa4=;
        b=YztgrI7khWjfRkPkQwd+Tjptx5TqiE7Xt+F1xcHUWzXbHgONjbgGxjrjQgjS4O6fOO
         PaoI9nvEDzwe68JpOVHrW0awkPqqm238Xjh5ufRsXFSAIgDLV+wLJq1XGQ9lPxP4p262
         x4EBsGWr1gJtbUP499JZgI0kwAtzx65Zu98FVUBwrkn8Asi14jDbuehHt1uONvY15FIv
         4v83dDHh/Ecmt0utO8L614Er/PJZmfRrXtlfc1asCKlkclcTkFNfYt//F9DG2ABnsama
         ROptHc63KfqeSxKGNu8YfcFDTdr6x0k4ixB8VPr76h5tCSPZ7I0GZ+lCMx2UlJTtExnQ
         8CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726103162; x=1726707962;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrZwj4wQdjgaXXXSNnDTmsMPVIiHBnnCTDIjF/U8aa4=;
        b=nqYJD7HTWzZPqbA+9bH26dFrAh/7XryeFin62x5+gZwlfz3iQe5H8eBuUjr2uV0B+G
         7vOEK0/58hapimxZeMj5tisTe1uG/iZ/F84SvDeG0Xq0L41aIPER11wlALBBTSGywFJP
         8jZW7GluNrEGJzA7rnMpox6RNDINPaZ1nKMYikuXC0v7VNg5zBRfn4RT/36Fk6SYZxGU
         4m/lW0JvpATKzi88IYGRXfrOSov2zU6mf/d825d5NADqgScerVm6MfO1pBUXT+X0AOHB
         TNJL5DqpRqd+HqZyx7OB48mKYRJX/ablQRAVMFbvrgEnhUnJ3MfKp9oeL15M4jaUmLGo
         jNTw==
X-Forwarded-Encrypted: i=1; AJvYcCV9dMU8mtEeE0oo8XFJehDyYKGVS7tN0mWEgyOetZjQTecuMeJ5/3KmAKWhk5x0B0LWzfnXc6MpHNKSS/OW@vger.kernel.org, AJvYcCW4EE2Hvnyjv0/HLz0+uLhOSBS/Q5A6bZf1keuL8ODfZ8d6beP/hvqKfbdY+kd0TGDH2G+tYsX0x5POVPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRkyBLQhVIsPqfBovibsVH7d6X3A3lXqBSWf/AeZfsEbNDqnGF
	HqtXE8uzP1X/Eq32BrDoKWFAHC/tMEPsSHi6T+8VJQBm/30Ye0gBhUsirwEi87/iZkK5ffJ0V8F
	6xRMDkVJFTwKxXZ934rfuJsIzE9o=
X-Google-Smtp-Source: AGHT+IFU3z5geBinTSVxuibVuYzAD6NH0xoQrh/U/I2MD9xbSObBDDyYKTBsRbWAhk2LIf++Ez/EA1zfetUS77u2J8c=
X-Received: by 2002:a17:906:6a19:b0:a8d:ee9:3888 with SMTP id
 a640c23a62f3a-a8ffae3b788mr568705366b.32.1726103162059; Wed, 11 Sep 2024
 18:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZuHtb43Ar21ZptNz@p100> <focr7orndhsr7vhownfdhrpctwztloz54bfbg2wnd4xmqtcymu@26pn5wteugl6>
 <CAHbLzkqhc2yT=rh6ZkjaRJ8RF_NrZM6bXd-nau6jJjbow8vogw@mail.gmail.com> <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
In-Reply-To: <tvllphck5fky6zqhkpcomjj5zuncgligdqapwkv5qwqamtjfc7@3geizoueze4d>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 11 Sep 2024 18:05:50 -0700
Message-ID: <CAHbLzkpUXqx-z55NhDRnWp2T8s0DgJaofyAfQeu-7g0QskJuew@mail.gmail.com>
Subject: Re: [PATCH] [RFC] mm: mmap: Allow mmap(MAP_STACK) to map growable stack
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Yang Shi <shy828301@gmail.com>, 
	Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 4:05=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Yang Shi <shy828301@gmail.com> [240911 18:16]:
> > On Wed, Sep 11, 2024 at 12:49=E2=80=AFPM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Helge Deller <deller@kernel.org> [240911 15:20]:
> > > > This is a RFC to change the behaviour of mmap(MAP_STACK) to be
> > > > sufficient to map memory for usage as stack on all architectures.
> > > > Currently MAP_STACK is a no-op on Linux, and instead MAP_GROWSDOWN
> > > > has to be used.
> > > > To clarify, here is the relevant info from the mmap() man page:
> > > >
> > > > MAP_GROWSDOWN
> > > >    This flag is used for stacks. It indicates to the kernel virtual
> > > >    memory system that the mapping should extend downward in memory.=
  The
> > > >    return address is one page lower than the memory area that is
> > > >    actually created in the process's virtual address space.  Touchi=
ng an
> > > >    address in the "guard" page below the mapping will cause the map=
ping
> > > >    to grow by a page. This growth can be repeated until the mapping
> > > >    grows to within a page of the high end of the next lower mapping=
,
> > > >    at which point touching the "guard" page will result in a SIGSEG=
V
> > > >    signal.
> > > >
> > > > MAP_STACK (since Linux 2.6.27)
> > > >    Allocate the mapping at an address suitable for a process or thr=
ead
> > > >    stack.
> > > >
> > > >    This flag is currently a no-op on Linux. However, by employing t=
his
> > > >    flag, applications can ensure that they transparently obtain sup=
port
> > > >    if the flag is implemented in the future. Thus, it is used in th=
e
> > > >    glibc threading implementation to allow for the fact that
> > > >    some architectures may (later) require special treatment for
> > > >    stack allocations. A further reason to employ this flag is
> > > >    portability: MAP_STACK exists (and has an effect) on some
> > > >    other systems (e.g., some of the BSDs).
> > > >
> > > > The reason to suggest this change is, that on the parisc architectu=
re the
> > > > stack grows upwards. As such, using solely the MAP_GROWSDOWN flag w=
ill not
> > > > work. Note that there exists no MAP_GROWSUP flag.
> > > > By changing the behaviour of MAP_STACK to mark the memory area with=
 the
> > > > VM_STACK bit (which is VM_GROWSUP or VM_GROWSDOWN depending on the
> > > > architecture) the MAP_STACK flag does exactly what people would exp=
ect on
> > > > all platforms.
> > > >
> > > > This change should have no negative side-effect, as all code which
> > > > used mmap(MAP_GROWSDOWN | MAP_STACK) still work as before.
> > > >
> > > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > >
> > > > diff --git a/include/linux/mman.h b/include/linux/mman.h
> > > > index bcb201ab7a41..66bc72a0cb19 100644
> > > > --- a/include/linux/mman.h
> > > > +++ b/include/linux/mman.h
> > > > @@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
> > > >       return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
> > > >              _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> > > >              _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
> > > > +            _calc_vm_trans(flags, MAP_STACK,      VM_STACK     ) |
> > >
> > > Right now MAP_STACK can be used to set VM_NOHUGEPAGE, but this will
> > > change the user interface to create a vma that will grow.  I'm not
> > > entirely sure this is okay?
> >
> > AFAICT, I don't see this is a problem. Currently huge page also skips
> > the VMAs with VM_GROWS* flags set. See vma_is_temporary_stack().
> > __thp_vma_allowable_orders() returns 0 if the vma is a temporary
> > stack.
>
> If someone is using MAP_STACK to avoid having a huge page, they will
> also get a mapping that grows - which is different than what happens
> today.

Yes, I agree. My point is no huge page + grow is fine.

>
> I'm not saying that's right, but someone could be abusing the existing
> flag and this will change the behaviour.

If you mean we will have more grow mapping but they are actually
unnecessary, then I agree someone could abuse the flag.

>
> >
> > >
> > >
> > > That is mmap(MAP_STACK) would set VM_NOHUGEPAGE right now, with this
> > > change you'd get VM_NOHUGEPAGE | VM_GROWS<something>
> > >
> > > >              _calc_vm_trans(flags, MAP_STACK,      VM_NOHUGEPAGE) |
> > > >              arch_calc_vm_flag_bits(flags);
> > > >  }
> > > >
> > >

