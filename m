Return-Path: <linux-kernel+bounces-215434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8839092A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A251A1F22716
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969EB19FA93;
	Fri, 14 Jun 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N5JLT/p6"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA33801
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718391665; cv=none; b=R29sAFvVr2x/6K+hfFVfPmJJqXms5j853oDlAJ17eQZCPhg+n+2YdWuGLyx5kdQGXmheOeBkZR6iC4O+yUJP/CYpM+m6tjoW99olsrjNMnRqU7N+t5qMA51G36qi5alQdmXJCsrQa2xsc4NunBZPKVKHYvcLyPKiVN/DTBz+JAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718391665; c=relaxed/simple;
	bh=nM/t35fRl1D7ZRJAjSAgj6BecWlmdzikKsCjXAGaEsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egPZwVU0h+0n1Wy/ahczzYTxsyligavn5ZZcdTxqRaAh2Yb8bCnz/oiF8Og6ygLTM+tSc87624szt9SkYLudm27WN64AFS73fqK6jdg6FGSwBV9BHy63eQ4OA/wB8aJjs6dUad4zzPYgGPCpuWqFBzyX+vErAZufajgshutf0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N5JLT/p6; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c9f6338a4so1183537fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718391662; x=1718996462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1ZALSntPjOYxQT4K20rIUTbBjioOSB3dIGMzglARe4=;
        b=N5JLT/p6GSZ8f0wk/VXtYdm0Qbud35oWhKwUNLmZM9/go1WJ6m7RTqP7AFACNMRxCz
         4ZDSKKf6IQtw0ODh9DfUhCILFWbs0ODbQ+XszXxOAhJdoZopSdPvlyw4DPtkCY/LvRON
         Dg+piS5lKl7kmBsnVQSRTLVsFpS9r6RmctWZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718391662; x=1718996462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1ZALSntPjOYxQT4K20rIUTbBjioOSB3dIGMzglARe4=;
        b=fHvRAp8LO2+EaVGyipQ/Vg+oSdDU6XMpXmjPdAPWl3hXxNyAwXJcwcS/YZKBXXEIrW
         Ds5rgLL6c4qIrEhQAwFlDdJ/YxJiFkf9U/G+XlPNE4yovkc84DSSWhCL4SDbhNWGY3FW
         uNRDObriroER0vfMa8TtDywwBHGYaBweCE/lpfe+0jAjcv0u3T/XBmLz3FUH6bjiejGE
         Obo3Bv4xWrhTxl4Zk1XQ8EpQxI4hiXyBf0zvhtyT5UuQL76oDQPWiESpcq0ss20OuSna
         A+uoUb/RvOPB35bMfMhErLuf/+j1Ckca0+HQmJixeAzyC5DqSc3a6sWljI6EBYlgB1pZ
         e7Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXUU19qfdKegLdAngE3e7yd2af/4iHe/+lXsxlogZy0xpWURg8/xKg7zdLu8KM9Z8vke/NFTFkt8rB8HZlfZGLyDEUuvvWKPyGbplw8
X-Gm-Message-State: AOJu0YwsyzP+VzrWmU4gw8jFRLPYBDB27BIxTWeWO8GXfTRxDhnTM1sW
	rSqMbHEXtLD3MM/7xcS76o3PT7uO5p7o1nLTaWswmYOkj4bxYiD44DclMmxTBPZGtc+kX7X4puR
	NCbZjqB1fyHhGVWbdE3FYzfgHMJLFLRiLB65x
X-Google-Smtp-Source: AGHT+IE5vSXJUDHmMRMjvi9lHMyHeYOC81ficWEmhdAwNyfxFAeAm8r2tME4kjQms/HqWO0W6fLsMjVrn5UOgIjFfoQ=
X-Received: by 2002:a05:6870:41d4:b0:254:a09c:6ddf with SMTP id
 586e51a60fabf-2584298e0ffmr4078582fac.24.1718391661719; Fri, 14 Jun 2024
 12:01:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614182327.752156-1-jeffxu@google.com> <20240614182327.752156-2-jeffxu@google.com>
 <CAG48ez0c3PyXhaW78tCXW0_e45YJtfOGj=shKZrLu5RZJ66vGg@mail.gmail.com>
In-Reply-To: <CAG48ez0c3PyXhaW78tCXW0_e45YJtfOGj=shKZrLu5RZJ66vGg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 14 Jun 2024 12:00:49 -0700
Message-ID: <CABi2SkX9koX7-bEwt5uo-QpC4yvHr_GMkGXZbPPN5G1PUL1AVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] /proc/pid/smaps: add mseal info for vma
To: Jann Horn <jannh@google.com>
Cc: akpm@linux-foundation.org, sroettger@google.com, rdunlap@infradead.org, 
	david@redhat.com, adhemerval.zanella@linaro.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:43=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
>
> Hi!
>
> On Fri, Jun 14, 2024 at 8:24=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > Add sp in /proc/pid/smaps to indicate vma is sealed
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/filesystems/proc.rst | 1 +
> >  fs/proc/task_mmu.c                 | 3 +++
> >  include/linux/mm.h                 | 5 +++++
> >  mm/internal.h                      | 5 -----
> >  4 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesys=
tems/proc.rst
> > index 7c3a565ffbef..400217a1589c 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -571,6 +571,7 @@ encoded manner. The codes are the following:
> >      um    userfaultfd missing tracking
> >      uw    userfaultfd wr-protect tracking
> >      ss    shadow stack page
> > +    sp    sealed page
>
> Nit: Why "page"? The sealing is a property of the VMA, not of the
> pages mapped into it. Maybe "sealed area" and an abbreviation like
> "sl" would make sense?
>
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 587d34879865..8600564898fa 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -314,6 +314,11 @@ extern unsigned int kobjsize(const void *objp);
> >  #define VM_NOHUGEPAGE  0x40000000      /* MADV_NOHUGEPAGE marked this =
vma */
> >  #define VM_MERGEABLE   0x80000000      /* KSM may merge identical page=
s */
> >
> > +#ifdef CONFIG_64BIT
> > +/* VM is sealed, in vm_flags */
> > +#define VM_SEALED      _BITUL(63)
> > +#endif
> > +
> >  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> >  #define VM_HIGH_ARCH_BIT_0     32      /* bit only usable on 64-bit ar=
chitectures */
> >  #define VM_HIGH_ARCH_BIT_1     33      /* bit only usable on 64-bit ar=
chitectures */
>
> Other 64-bit flags are defined further down; maybe it would make sense
> to move this definition below the definition of VM_ALLOW_ANY_UNCACHED,
> so that the definitions are sorted by the number of the bit?

Sure.  I will update.

Thanks!
-Jeff

