Return-Path: <linux-kernel+bounces-247862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6669592D5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A92285452
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94E194C6F;
	Wed, 10 Jul 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/jh//GD"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14F1922C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627622; cv=none; b=WCpnZ+Wra0TWMQDIvwIiQxHA6SmyKBvMfGUAoQ7gGwCpJfZY1Tg/9Utyec3+OWpBCEBtvQoLrXxlYOd0dwZJN1BoxPPJB7dU/yp0vmqARsUaasuWtiqTjrB7CU7Pfrv/whggHDAetmG85sNTOp+UTNmseINKygrqF/T97eFH1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627622; c=relaxed/simple;
	bh=BnK96PQxtuG60DRvHzoqWDIQOXQm+SPpSv1Nr+RugEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=CY9wUS9qbMBFbboB/ebBHQNr63ClsKa49yXGfXO0v8xBnRi7uuhl5VLppOMSb/xOq+FwnqQRIwDoBG+9QTBftPCUR71tKhg8Sy5Jo4A2m8AATDlhI3V/SV1wuVbuA1v6IFX2Ma0uNSC9FtY4yMDyUCDT/vWFvl5NxuT2EEPiB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/jh//GD; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-704473c0698so708282a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720627620; x=1721232420; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn9Zi1KqPp5aaxLNBj+DM807b8H8qBITowNXvBGV8jI=;
        b=I/jh//GDiIVsC0Wm0qTgC0/hlNDLMLMshHaEu6ert/tDJU1FoYSaF+BhUcYYYGhAVf
         J+8e5xBF6KkG6zw8VPbTC4IxiZFAfWJLjdkFwlz6gN/LA3JuIyyOVopsE92BYHdRglwE
         SDN48lKU5j7PozGHaC8aW1Hsxch2lUZfMj2lDpMq5t3Q6JAPqI2HfLuNjgq3JsuMCOE7
         tnzHMsWxt4/xQ8jra/9o4GN35AggT48uuwGEZqcwGJ+PLUsHW/Ihp7BUa4q2yqRAacad
         0qLQgOnLaZIy+wByW0bgbsmdMti3MLJcj4WhR/WBVYTAPHKSjDiBQlQK/Vg+Yjw5n0Jt
         HnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627620; x=1721232420;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yn9Zi1KqPp5aaxLNBj+DM807b8H8qBITowNXvBGV8jI=;
        b=luqOpSyAOGb4Kus3MgcMwRfpjM2dOApSL0ktYcZkOF3gObJY+6JAtZB47U6hMvk6f4
         /FkiVVdBr/UmQWrt4G/FeepKr1H6H2MwIP57fDMtMuMecadMulZB1k0bKhy8h+5p9Evf
         RYf1PIRb0JK8XQhpyMnktLTW5tiHVmrpOAagkS40qJAq8xdCfch4epbUnP0M2Q5TtshU
         aGvqKavUCTAdKq/A//0O0gxsRwx81zMMdLyBwJJ7yDF8OAzLPQwEkN9Kc9S1NXS2t01E
         /HL9UwArMKfT0EyGJTV5JdV5XN5bn7lz+7/6XVkA81l8QRRxcWjV435UlgnxbDGIxNaZ
         nEFA==
X-Forwarded-Encrypted: i=1; AJvYcCXNwUy09xNAMPAnjCVvUuA/At0IAE8i0Vqow/dvxgcpj8vmSX6TI9zwGcyP0HF3hkRilcXR58E5jH8cQCDr+6d66lGjdIf9CJJNpdDq
X-Gm-Message-State: AOJu0YwVwzG7dEkbWi5jIxJi19PxMqa9LklSEzDsF9ALqMvWVI0UmmKU
	x5383kFS77c5D8VnxOpk46QTxK0SpPJ2i6mBRwRJhQrX64UvoVojyhA3EQzipA5MvH6FBgzBKdV
	eiZuAu0PzIAWOAti9NmxiQTvd/s3gIIBck/3r
X-Google-Smtp-Source: AGHT+IFZMhd3IwcTT5MRRD5rKcqIqs3l1YV7f+9GXdgWrMHusgkuEPHllYjtToXd2RmT45movpPujJPp8yOAIEehbh8=
X-Received: by 2002:a9d:6ac7:0:b0:701:ff2a:e50c with SMTP id
 46e09a7af769-70375a07e4dmr6764092a34.13.1720627619855; Wed, 10 Jul 2024
 09:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-3-Liam.Howlett@oracle.com> <f9b7c816-b0a4-4e9c-a5c6-0cc5990e56d2@lucifer.local>
 <fftle4xpq4vqskgf4tdlczs3wnlzdoj4obhmmsj4wlc6sylo7i@xzeyqg5kvxsk>
In-Reply-To: <fftle4xpq4vqskgf4tdlczs3wnlzdoj4obhmmsj4wlc6sylo7i@xzeyqg5kvxsk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 09:06:48 -0700
Message-ID: <CAJuCfpEkpXp-TsU=we-nH=9+QzN8Cnu5Xev9we=ZQeKvLASd-Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] mm/mmap: Introduce abort_munmap_vmas()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	sidhartha.kumar@oracle.com, "Paul E . McKenney" <paulmck@kernel.org>, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 11:12=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240705 13:02]:
> > On Thu, Jul 04, 2024 at 02:27:04PM GMT, Liam R. Howlett wrote:
> > > Extract clean up of failed munmap() operations from
> > > do_vmi_align_munmap().  This simplifies later patches in the series.
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


> > > ---
> > >  mm/mmap.c | 25 ++++++++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 28a46d9ddde0..d572e1ff8255 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -2586,6 +2586,25 @@ struct vm_area_struct *vma_merge_extend(struct=
 vma_iterator *vmi,
> > >                      vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> > >  }
> > >
> > > +/*
> > > + * abort_munmap_vmas - Undo any munmap work and free resources
> > > + *
> > > + * Reattach detached vmas, free up maple tree used to track the vmas=
.
> > > + */
> > > +static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> > > +{
> > > +   struct vm_area_struct *vma;
> > > +   int limit;
> > > +
> > > +   limit =3D mas_detach->index;
> >
> > This feels like a change to existing behaviour actually, I mean a sensi=
ble
> > one - as you are not just walking the tree start-to-end but rather only
> > walking up to the point that it has been populated (assuming I'm not
> > missing anything, looks to me like mas_for_each is _inclusive_ on max).
>
> This is not the main tree, but the detached tree.  It only contains the
> vmas that are going to be freed (or, rather aborted from being freed).
>
> I see what you mean that the end in the abort code below would be one
> beyond the tree walk.  The new abort code uses the index (from the
> previous write) as the limit.
>
> All that really matters is that we go to a number high enough to cover
> all vmas that were detached.  I used 'end' in the below code because I
> knew it would cover all of the vmas added (we actually start at index
> 0).
>
> The value of 'mas_detach->index' is used in the new code because I knew
> that's as far as I had to go, and I could limit the arguments passed
> to the function.
>
> I think that I'll actually change limit to ULONG_MAX in another revision
> because I like that better than expecting the index to have not been
> touched by others.
>
> >
> > Maybe  worth mentioning in commit msg?
>
> Yes, good idea.  Thanks for catching this.
>
> >
> > > +   mas_set(mas_detach, 0);
> > > +   /* Re-attach any detached VMAs */
> > > +   mas_for_each(mas_detach, vma, limit)
> > > +           vma_mark_detached(vma, false);
> > > +
> > > +   __mt_destroy(mas_detach->tree);
> > > +}
> > > +
> > >  /*
> > >   * do_vmi_align_munmap() - munmap the aligned region from @start to =
@end.
> > >   * @vmi: The vma iterator
> > > @@ -2740,11 +2759,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, =
struct vm_area_struct *vma,
> > >  userfaultfd_error:
> > >  munmap_gather_failed:
> > >  end_split_failed:
> > > -   mas_set(&mas_detach, 0);
> > > -   mas_for_each(&mas_detach, next, end)
> > > -           vma_mark_detached(next, false);
> > > -
> > > -   __mt_destroy(&mt_detach);
> > > +   abort_munmap_vmas(&mas_detach);
> > >  start_split_failed:
> > >  map_count_exceeded:
> > >     validate_mm(mm);
> > > --
> > > 2.43.0
> > >
> >
> > This looks fine though, feel free to add:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks.
>

