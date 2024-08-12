Return-Path: <linux-kernel+bounces-283284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3A94EF91
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2116C1F23026
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA65914C5A4;
	Mon, 12 Aug 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Soatas2s"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A6517C9EB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473013; cv=none; b=ht0IIJe6Xu1v3+lqPPiTi1Bc0eo/XqF7n+kiKTPdn3rVmySSfpRWyQjg1GMRxgLZDu5NxQK9IzmqLag6tHhUO8VhYMR2sxXlEHZ7mExQckF4JjIfn0mR47spOjKf+P1rne8dQ5Y6/cQnNH+f9HO09rJTzQ9PpwflWJHKK2AJIc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473013; c=relaxed/simple;
	bh=cxxMgX14Pj0MJ7A4WPkHJPa57eS+Q9Yp4Eoc6EdOvZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ktcgegBmzKa6LMtPD9gsAKmVZ+AlnAWrv28gB14ZMf03LVioKLIhD+4AmHKNp8JS6aK+863nLQ8VQuKVXUHhgSvWAqG/6ad8EKU47g/qA41+57LiG9f92dCKZ2ISLOarrOj+bCh+H09ZkfS73Lre7+KWRaluhUcb4nz5PAL7GyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Soatas2s; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so14318a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723473010; x=1724077810; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgmtalDDpDr/MN1t4TqgaC8ETll2KaDq52qckxLfkss=;
        b=Soatas2srRYFRakPFA9Q0isAXwDytkKpeLpPGMKfA2r8N5Xttaw5yzAUY2vw2arsIt
         pOerf1aIiY05k5yY6HvDgVqIybBL5hojKvVRQgzKYKRXib2ieI9cKGuREJULfaHq5ZtS
         yFhFSmH/cnNV0ADr2mMzF6B5XrQPqV/BSJCziZW5wCuvqki07HlinacC7kQuVZ5LbcaH
         Ey24tMA2yOhdILvsZco5kfyBafYRf91NzDrZFw9B29Wu1JIeMYVKQxJkQT9eeVKcJNGG
         +xGdDpbHZo4+pdfdaM1O17J0EkccoxnPTMGVAwifl5Lk6vk7hAC/OA5110mr4CxQGvqp
         alEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473010; x=1724077810;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgmtalDDpDr/MN1t4TqgaC8ETll2KaDq52qckxLfkss=;
        b=dDXw2I9LtApF3bkr5D29AJboibnrTPMBSzF6saFxdYXjIGW9zwZdXGjzeA2IvyPOte
         fE1eOVpSv7qHJ/YtKKpvJqY4eLfv1cealAoBDusfuUNkYB2XZCKlQHD6uUVoWKkay7Um
         FsMJJGaj2AYRzuQM5K1YJFKSqne4uOc8EU1eKssBE0pRwrAEWExkEsV7ZLGS/MYtTdwX
         ek9obf53saI6OV8NGrseAfwNf0tYLV2hIJkwSPluUG/rTawv8KTNG+KT7okdFSo3X/Kd
         jJRIPLSPWWP+2kIffHo3ghvbQJhaodshO9I4SA0XRm/xUUKdydlwRp5qwabcAWCGS0S7
         wolw==
X-Forwarded-Encrypted: i=1; AJvYcCUhNaYceg+TdfhmEjeV9TjcGabQhDMqtl/MLqZJfqPShPWVoojImjkvEFp7K/9mSgnAvcIrx8jKlmVS0vUo/2PMOVkGOqE2ZgFHCeu3
X-Gm-Message-State: AOJu0YwymHWo7pYrO2iAv7A8nEhcaTuHGXtYIlCo7eNevIeU/XRpVK58
	Rui/fWGd+t0xKH4AQtk5lGbf/oJEhhuJHMIOimVaeL+VjOWkwazO5NYW5BGkSe2pAaVlrVdujFs
	DsAvNHL4dUTSPp0DPtDem8lxLCTNiPOAhpiPf
X-Google-Smtp-Source: AGHT+IGRJXeBEjboJZFkfR+yCIyyvKdUM/p3cp8P7yhd6aGpDPBM0Xw0RiUE2SdGQ77/srGD5rh3AQKZhRUMoF/azP4=
X-Received: by 2002:a05:6402:27c9:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5bd1b3d0b41mr208907a12.3.1723473009940; Mon, 12 Aug 2024
 07:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com> <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
 <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
 <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com> <ljhdwgkfzjgdehfjgvdxa4wyxx4d32kpqqz2pwjse65rasuaeo@nncsuq3ku53o>
In-Reply-To: <ljhdwgkfzjgdehfjgvdxa4wyxx4d32kpqqz2pwjse65rasuaeo@nncsuq3ku53o>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 12 Aug 2024 07:30:00 -0700
Message-ID: <CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaLxO7o7Cv9A@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with can_modify_vma
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, jeffxu@google.com, 
	Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Kees who commented on mseal() series before. Please keep Kees in the
cc for future response to this series.

On Fri, Aug 9, 2024 at 12:25=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Pedro Falcato <pedro.falcato@gmail.com> [240809 14:53]:
> > On Fri, Aug 9, 2024 at 5:48=E2=80=AFPM Liam R. Howlett <Liam.Howlett@or=
acle.com> wrote:
> > >
> > > * Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> > > > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > > > We were doing an extra mmap tree traversal just to check if the e=
ntire
> > > > > range is modifiable. This can be done when we iterate through the=
 VMAs
> > > > > instead.
> > > > >
> > > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > > ---
> > > > >  mm/mmap.c | 13 +------------
> > > > >  mm/vma.c  | 23 ++++++++++++-----------
> > > > >  2 files changed, 13 insertions(+), 23 deletions(-)
> > > > >
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 4a9c2329b09..c1c7a7d00f5 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi=
, struct vm_area_struct *vma,
> > > > >             unsigned long start, unsigned long end, struct list_h=
ead *uf,
> > > > >             bool unlock)
> > > > >  {
> > > > > -   struct mm_struct *mm =3D vma->vm_mm;
> > > > > -
> > > > > -   /*
> > > > > -    * Check if memory is sealed before arch_unmap.
> > > > > -    * Prevent unmapping a sealed VMA.
> > > > > -    * can_modify_mm assumes we have acquired the lock on MM.
> > > > > -    */
> > > > > -   if (unlikely(!can_modify_mm(mm, start, end)))
> > > > > -           return -EPERM;
> > > > > -
> > > > > -   arch_unmap(mm, start, end);
> > > > > -   return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlo=
ck);
> > > > > +   return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, =
uf, unlock);
> > > > >  }
> > > > >
> > > > >  /*
> > > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > > index bf0546fe6ea..7a121bcc907 100644
> > > > > --- a/mm/vma.c
> > > > > +++ b/mm/vma.c
> > > > > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi=
, struct vm_area_struct *vma,
> > > > >             if (end < vma->vm_end && mm->map_count >=3D sysctl_ma=
x_map_count)
> > > > >                     goto map_count_exceeded;
> > > > >
> > > > > +           /* Don't bother splitting the VMA if we can't unmap i=
t anyway */
> > > > > +           if (!can_modify_vma(vma)) {
> > > > > +                   error =3D -EPERM;
> > > > > +                   goto start_split_failed;
> > > > > +           }
> > > > > +
> > > >
> > > > Would this check be better placed in __split_vma()?  It could repla=
ce
> > > > both this and the next chunk of code.
> > >
> > > not quite.
> >
> > Yeah, I was going to say that splitting a sealed VMA is okay (and we
> > allow it on mlock and madvise).
>
> splitting a sealed vma wasn't supposed to be okay.. but it is Jeff's
> feature.  Jeff?
>
Splitting a sealed VMA is wrong.
Whoever wants to split a sealed VMA should  answer this question
first: what is the use case for splitting a sealed VMA?

The V2 series doesn't have selftest change which indicates lack of
testing. The out-of-loop check is positioned nearer to the API entry
point and separated from internal business logic, thereby minimizing
the testing requirements. However, as we move the sealing check
further inward and intertwine it with business logic, greater test
coverage becomes necessary to ensure  the correctness of  sealing
is preserved.




-Jeff
















> >
> > >
> > > >
> > > > >             error =3D __split_vma(vmi, vma, start, 1);
> > > > >             if (error)
> > > > >                     goto start_split_failed;
> > > > > @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi=
, struct vm_area_struct *vma,
> > > > >      */
> > > > >     next =3D vma;
> > > > >     do {
> > > > > +           if (!can_modify_vma(vma)) {
> > > > > +                   error =3D -EPERM;
> > > > > +                   goto modify_vma_failed;
> > > > > +           }
> > > > > +
> > >
> > > This chunk would need to be moved below the end check so that we catc=
h
> > > full vma unmaps.
> >
> > Why below the end check? I believe we can avoid the split? Is there
> > something I'm missing?
> > But I did find a bug, what I really seem to want is:
> >
> >  +           if (!can_modify_vma(next)) {
>
> Good catch.
>
> > instead of (vma). It's somewhat concerning how the mseal selftests
> > didn't trip on this?
>
> the end check will call split and will fail in there, if you move the
> code as I suggested.
>
> That means, if we aren't splitting, we still have to check the vma, so
> the check is necessary.
>
>

