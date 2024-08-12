Return-Path: <linux-kernel+bounces-283527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D6F94F5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125B01C21D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3618953D;
	Mon, 12 Aug 2024 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmQDhcaJ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FA2188007
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484334; cv=none; b=rcYq8j1GzvqPNNJJGPFumHynmclVnj2aTErZbezCJhOlY2tdvpLSm2hd54xE2okLjsLoUQQK7Yf4XAeP7lXR7NULFB/rJiogkblrPgjBAChJbypZKbIseyrpUaZImAM5gqXNYWxjplyzhtCFP/xltEkQnezFwwO+/95Wn++RRJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484334; c=relaxed/simple;
	bh=O48/e4tZjW2G3lSDE/n0MdN2rfA8TAnDQpxX6eg0gZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CEfQ38ndpEYaecwB3iEYIec+3n3x2vhse6H9kQRPqzRJYvBmmlPKj/cxl031nrBaK1x75oJPjSZw379lVtkUl2iNdHOrTcF4vrg1RGP8AV2k/mjHzwk9wzB+Z6lIeXYEAeIQadvIx/6FGC6e4tMmbOX9oN41izkTpDA+RBHaW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmQDhcaJ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso1172a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723484331; x=1724089131; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iprzuAC7oR9BJI+gBUXU0X3c3yh4bHJSPdkmpXidPj0=;
        b=rmQDhcaJBibQM0pYNmlfa8CjJjsJEmWBC/v/vLhW3FfI+WPEwN08gKCQStxaianQ5s
         pXq+rswUFMPZOv+0kMsR1M/rth54W2V2Qs/C3EJO/4XksCfbkpKVbwjUaXOXnh5ycp9z
         S7RQPNZUbfPYA+SnL8m/i92i3NyqZUohloDQsB2FXZXEwgUcl9PjFmnCGbfhdY3ec8VJ
         d4ZZkqJtgvO/031UVTfEqrRSfl6r0b/Ukk2jg7mTeDYVZm29yNWF1Q3Gz6ogQq+J1YYa
         cGRBAnXRm0lk3NJ9h56v4Lx0jv2Xmhbp0U0JRwT0VSrLiOaazeu0Sd942AVGe5neNeFn
         bgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484331; x=1724089131;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iprzuAC7oR9BJI+gBUXU0X3c3yh4bHJSPdkmpXidPj0=;
        b=FWbzLeaApAK0JigBFJ9BpIIKUWvYa4zlhp/8kiVfIKGLgiyjsA2lF/WJQHJ8GnpUdr
         u8XrGD5frfLsyAnrGLeeYOu5tlREfD3WE3XmEg1L7G/4P8CyyUfElboahuLzOSgUqqNM
         Pjadh2bRI/OLgxu3UmoRL/3qEmBvC9qazEBx0dBTacBwo4b+WNlFC44WxhwZHtdhYivi
         gSV379GaqlXm79wJt/Lr4LaSSd2ZcH7opPGGe4sImg8AzB3QErXbwpT+5FMXsaIkz9KH
         YsSv9sWNxS5fcP2/BpHn5JUBCYgZ+J9clgUogA2o7u6QQoYbM4Iu+8FmhHUOhCZF5gnB
         agEg==
X-Forwarded-Encrypted: i=1; AJvYcCW4D8fMrfPMCls6+NVz/1GaguxZJN1WkeztphsMVLYDblnRDeFVEYh8RuhrIUyQUNOdJfBKIRX4ufgBKAxF8k7YEoBrpjF81ve0NYT6
X-Gm-Message-State: AOJu0YwXS9qvysI+za6FurBOtpbjiHeMlZWpC+7/ZcUGMT8GJwnrlPcx
	ns4wvRxE7pP9XpOB9zF8FYYYe80YqVIeDXkvOdoGExehYsXD6UWtgtL97hMf2snHktWvxmq81aB
	KVFhD6M66FRfs/3ib/biJ0r5QED5RXCNCSrO1
X-Google-Smtp-Source: AGHT+IHQyiPoaLvh95T/Ee6BxrCTzWeICyjqvFWYxngktv84QD/h42ujbUo/+38BhKZ0wfTKWHhTPsc4CGsp2V2mTzo=
X-Received: by 2002:a05:6402:3591:b0:5a7:7f0f:b70b with SMTP id
 4fb4d7f45d1cf-5bd4719d47emr1307a12.0.1723484330426; Mon, 12 Aug 2024 10:38:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com> <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
 <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
 <CAKbZUD2VV=FOeGhCOb3o5CKBiaV+6JSPoDRwzV1-3t2hZX7rQw@mail.gmail.com>
 <ljhdwgkfzjgdehfjgvdxa4wyxx4d32kpqqz2pwjse65rasuaeo@nncsuq3ku53o>
 <CALmYWFvURJBgyFw7x5qrL4CqoZjy92NeFAS750XaLxO7o7Cv9A@mail.gmail.com> <ko3pjllsgufbz33hqvwdpdsyxvgrgzqiodxexnpcng3mssffeh@dfgfkqlg46xa>
In-Reply-To: <ko3pjllsgufbz33hqvwdpdsyxvgrgzqiodxexnpcng3mssffeh@dfgfkqlg46xa>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 12 Aug 2024 10:38:11 -0700
Message-ID: <CALmYWFu5CXiJKict9EqtEbaBNB80rU=p3izWE3Jgd6OWoY0Tig@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with can_modify_vma
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, 
	torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 9:58=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@google.com> [240812 10:30]:
> > + Kees who commented on mseal() series before. Please keep Kees in the
> > cc for future response to this series.
> >
> > On Fri, Aug 9, 2024 at 12:25=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Pedro Falcato <pedro.falcato@gmail.com> [240809 14:53]:
> > > > On Fri, Aug 9, 2024 at 5:48=E2=80=AFPM Liam R. Howlett <Liam.Howlet=
t@oracle.com> wrote:
> > > > >
> > > > > * Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> > > > > > * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > > > > > > We were doing an extra mmap tree traversal just to check if t=
he entire
> > > > > > > range is modifiable. This can be done when we iterate through=
 the VMAs
> > > > > > > instead.
> > > > > > >
> > > > > > > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > > > > > > ---
> > > > > > >  mm/mmap.c | 13 +------------
> > > > > > >  mm/vma.c  | 23 ++++++++++++-----------
> > > > > > >  2 files changed, 13 insertions(+), 23 deletions(-)
> > > > > > >
> > > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > > index 4a9c2329b09..c1c7a7d00f5 100644
> > > > > > > --- a/mm/mmap.c
> > > > > > > +++ b/mm/mmap.c
> > > > > > > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator =
*vmi, struct vm_area_struct *vma,
> > > > > > >             unsigned long start, unsigned long end, struct li=
st_head *uf,
> > > > > > >             bool unlock)
> > > > > > >  {
> > > > > > > -   struct mm_struct *mm =3D vma->vm_mm;
> > > > > > > -
> > > > > > > -   /*
> > > > > > > -    * Check if memory is sealed before arch_unmap.
> > > > > > > -    * Prevent unmapping a sealed VMA.
> > > > > > > -    * can_modify_mm assumes we have acquired the lock on MM.
> > > > > > > -    */
> > > > > > > -   if (unlikely(!can_modify_mm(mm, start, end)))
> > > > > > > -           return -EPERM;
> > > > > > > -
> > > > > > > -   arch_unmap(mm, start, end);
> > > > > > > -   return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, =
unlock);
> > > > > > > +   return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, e=
nd, uf, unlock);
> > > > > > >  }
> > > > > > >
> > > > > > >  /*
> > > > > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > > > > index bf0546fe6ea..7a121bcc907 100644
> > > > > > > --- a/mm/vma.c
> > > > > > > +++ b/mm/vma.c
> > > > > > > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator =
*vmi, struct vm_area_struct *vma,
> > > > > > >             if (end < vma->vm_end && mm->map_count >=3D sysct=
l_max_map_count)
> > > > > > >                     goto map_count_exceeded;
> > > > > > >
> > > > > > > +           /* Don't bother splitting the VMA if we can't unm=
ap it anyway */
> > > > > > > +           if (!can_modify_vma(vma)) {
> > > > > > > +                   error =3D -EPERM;
> > > > > > > +                   goto start_split_failed;
> > > > > > > +           }
> > > > > > > +
> > > > > >
> > > > > > Would this check be better placed in __split_vma()?  It could r=
eplace
> > > > > > both this and the next chunk of code.
> > > > >
> > > > > not quite.
> > > >
> > > > Yeah, I was going to say that splitting a sealed VMA is okay (and w=
e
> > > > allow it on mlock and madvise).
> > >
> > > splitting a sealed vma wasn't supposed to be okay.. but it is Jeff's
> > > feature.  Jeff?
> > >
> > Splitting a sealed VMA is wrong.
> > Whoever wants to split a sealed VMA should  answer this question
> > first: what is the use case for splitting a sealed VMA?
>
> If we lower the checks to __split_vma() and anywhere that does entire
> vma modifications, then we would avoid modifications of the vma.  This
> particular loop breaks on the final vma, if it needs splitting, so we'd
> still need the check in the main loop to ensure the full vma isn't
> mseal()'ed.  Splitting the start/end could be covered by the
> __split_vma() function.
>
> >
> > The V2 series doesn't have selftest change which indicates lack of
> > testing. The out-of-loop check is positioned nearer to the API entry
> > point and separated from internal business logic, thereby minimizing
> > the testing requirements. However, as we move the sealing check
> > further inward and intertwine it with business logic, greater test
> > coverage becomes necessary to ensure  the correctness of  sealing
> > is preserved.
>
> I would have expected more complete test coverage and not limited to
> what is expected to happen with an up front test.  Changes may happen
> that you aren't Cc'ed on (or when you are away, etc) that could cause a
> silent failure which could go undetected for a prolonged period of time.
>
> If splitting a vma isn't okay, then it would be safer to test at least
> in some scenarios in the upstream tests.  Ideally, all tests are
> upstream so everyone can run the testing.
>
We will want to be careful about our expectation of  test coverage
offered in selftest. When adding mseal, I added 40+ test cases to
ensure mseal didn't regress on existing mm api, i.e. you can take the
mseal test , make a small modification (removing seal=3D1) and run on an
old version of kernel and they will pass. I think it is wrong to
expect the selftest is all it takes to find a regression if the dev is
doing a  *** major design/feature change ***. While it is possible to
write test cases to guide all future changes, doing so requires much
bigger effort with diminishing returns, essentially  it is testing an
"impossible to reach cases" in existing code.

Thanks
-Jeff

> Thanks,
> Liam

