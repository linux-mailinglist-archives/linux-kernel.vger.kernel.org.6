Return-Path: <linux-kernel+bounces-281410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47E94D6B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 20:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BAE1C21CA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C03713C8F4;
	Fri,  9 Aug 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU/OclpH"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075B217557
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723229612; cv=none; b=lzA0ge91fZUQgMuEH/xcvIm76yB7FFQaB0eOdmJXYO99NrYJ8GKQquCWVrsPvpTQkhNqnQFb/ouDcNBPIekZLWE/ZpcphgN0CSqz/mRMTJtngIRYWytmOEjE9eX6YsrjMJ8wDMD6JhTvNnayswuCXsdjTP7lIRiwVHUAtTGcavE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723229612; c=relaxed/simple;
	bh=b6q8ovL/LTwCVdY06z+PIl+e6PJRzJB+ZeGn5ZQTjVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=W0NN/rAwTtgkjbcHw2aLAzpSpMqaqAo19DvM6gnJ1zzNFYe8lAj8nIHw/gJyFccyc1CXqX8wsdZ8RBjbNEGmjjkAri/hjBCSQ+4an+8LA0luZCsQJsoVc33Fgyb/ui/qrgZ3mD61Bw1tuubD2Q00wey5E/sE48uoVZj8OIrnhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nU/OclpH; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-492a8333cb1so948639137.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723229610; x=1723834410; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFd6Ev453/aDjLObVzNphCwMYt1CKpC7GnDFLP288fM=;
        b=nU/OclpHVSn4J0ZsdsrwUoyeI5X2uxGJ267NVLSV518mn2v9xwuY/wPUuqUW7KfCtm
         6sWjTBt9ennyUisk06X5H0ieNC30u9Fj5Rlmz57It1E6kjuHrfS7XFiYLi6c/OewQAE5
         JkF/5Dv1hiEs4l+e8u0UNQSg97HP4xmJj31F4qQNUDzsc2IedcC0SIxRPf8tecl/N2my
         9ybwPzUMwwl2utwlKy1XbfUbwPgVbDOIF5S+gdH5tGeqKfJ4NAc/De44maNxukYjc8u5
         1Ew/Z3PX8mRx4xjsF0ILT02bT6A0mzFJV6iP436AjNomXkdKpQ4OmkRMA6sSSx8SPOT0
         GOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723229610; x=1723834410;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFd6Ev453/aDjLObVzNphCwMYt1CKpC7GnDFLP288fM=;
        b=ROaEl3gx/PZzVGNcuzqFpacsMLba+W+b9hd8Soijijp8n1rsRs/HvE3QSWlDsL4sJK
         XE53x1MKUO2GTyJGQZ7R0ZhACD/q4crmmOkCab2AzBldeCcwIx6clZONRNtMZLeM6mjr
         ugJ0ErIA99H1qsx7FQtPhN1Gg0haiYCbKOy/QhXeF6ubQEn5LjUqKL66GK6AnedwNnPw
         BKsBV3ec3he9m2qSL5HzhE8uu3NdkLW4LLyV6rip6nS0CyoSzZ4FDzHn2B3tIa+gL56F
         osadJg5gpxwQs+d/lronxIXpTqAHkA2k4WiKjcRsjztp94lg224Cy4q2UNohILZ36Cgs
         nooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVixLv+vY6iVYrL92Aab71Z1qkDGtJdZLUib1ezRKmIqfZgogPCeu0cV0jVzRiw8/B36Z550QFfTwAn2Fobjju1/JwuhNrUNpT10TBh
X-Gm-Message-State: AOJu0YwWbbXfRWTUgBcUvVucU13on3MXE07jkxK3kCjzkxy8pRhh/V9b
	Hc4fiJDZsfXdlAq80zwjpjpkQBniRRhdGfdX10ZNUzPTGijV2HlFbuY/K1GL765yQORodjupxyZ
	pHTewlKwLpfC01w8ExquxiPN5X9M=
X-Google-Smtp-Source: AGHT+IHjO2laCrD83xGgSKk32SS9gnG4HIGJIclIXUNutnOZzhTtxjLuWCIlNr0AsBryPANi7e+skoBuCZ0o3f2w8Oo=
X-Received: by 2002:a05:6102:dc9:b0:48f:df47:a4a8 with SMTP id
 ada2fe7eead31-495d8605e99mr2764146137.29.1723229609875; Fri, 09 Aug 2024
 11:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com> <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
 <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
In-Reply-To: <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Fri, 9 Aug 2024 19:53:18 +0100
Message-ID: <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with can_modify_vma
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, jeffxu@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 5:48=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > We were doing an extra mmap tree traversal just to check if the entir=
e
> > > range is modifiable. This can be done when we iterate through the VMA=
s
> > > instead.
> > >
> > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > ---
> > >  mm/mmap.c | 13 +------------
> > >  mm/vma.c  | 23 ++++++++++++-----------
> > >  2 files changed, 13 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 4a9c2329b09..c1c7a7d00f5 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> > >             unsigned long start, unsigned long end, struct list_head =
*uf,
> > >             bool unlock)
> > >  {
> > > -   struct mm_struct *mm =3D vma->vm_mm;
> > > -
> > > -   /*
> > > -    * Check if memory is sealed before arch_unmap.
> > > -    * Prevent unmapping a sealed VMA.
> > > -    * can_modify_mm assumes we have acquired the lock on MM.
> > > -    */
> > > -   if (unlikely(!can_modify_mm(mm, start, end)))
> > > -           return -EPERM;
> > > -
> > > -   arch_unmap(mm, start, end);
> > > -   return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> > > +   return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, =
unlock);
> > >  }
> > >
> > >  /*
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index bf0546fe6ea..7a121bcc907 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> > >             if (end < vma->vm_end && mm->map_count >=3D sysctl_max_ma=
p_count)
> > >                     goto map_count_exceeded;
> > >
> > > +           /* Don't bother splitting the VMA if we can't unmap it an=
yway */
> > > +           if (!can_modify_vma(vma)) {
> > > +                   error =3D -EPERM;
> > > +                   goto start_split_failed;
> > > +           }
> > > +
> >
> > Would this check be better placed in __split_vma()?  It could replace
> > both this and the next chunk of code.
>
> not quite.

Yeah, I was going to say that splitting a sealed VMA is okay (and we
allow it on mlock and madvise).

>
> >
> > >             error =3D __split_vma(vmi, vma, start, 1);
> > >             if (error)
> > >                     goto start_split_failed;
> > > @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> > >      */
> > >     next =3D vma;
> > >     do {
> > > +           if (!can_modify_vma(vma)) {
> > > +                   error =3D -EPERM;
> > > +                   goto modify_vma_failed;
> > > +           }
> > > +
>
> This chunk would need to be moved below the end check so that we catch
> full vma unmaps.

Why below the end check? I believe we can avoid the split? Is there
something I'm missing?
But I did find a bug, what I really seem to want is:

 +           if (!can_modify_vma(next)) {
instead of (vma). It's somewhat concerning how the mseal selftests
didn't trip on this?

--=20
Pedro

