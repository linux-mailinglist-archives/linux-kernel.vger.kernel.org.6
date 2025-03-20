Return-Path: <linux-kernel+bounces-570498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60403A6B16C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2673AD68D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6421D3FB;
	Thu, 20 Mar 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKpAPPGS"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE815C158
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511922; cv=none; b=qRj8vg3Hw3sAsEv264K0G94MHgl6Nl6sRn6kdrIl9mWXzVMwtUYRuMJ1A4rEVoaCjdbL6aLtTiwWXU8V1Pv2hmMJZH786imiUhJ/FENFanZC16az882aMFmQDywt1yEb21Whfg2zUE5Tf78G2O/x3I7ozAkWYWhmKnskso2q9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511922; c=relaxed/simple;
	bh=a3F3/YThNQpd/Nr1lm/QwiAgsBoKdi/szgr9FM339co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBzyinLKA252N6WSHukVQFePry6zKc0Kyb3YWUwvqMJ1WJ+SjrAUWOqWZY8dYdPIqeUUXBDYIr7O1ODK7y3ys11SRi7nmJrCmqoUWBxnoaiZgnzw/C82+Tw2qnKuneNtxxOjrHmhvklhn6mgBG1oVwNMWx0BUdydjgonVK0EGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKpAPPGS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso2108a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742511919; x=1743116719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny+GX9yVAovZ4kewf1rPe2k5PehefNSsdrKKMi2rCUM=;
        b=aKpAPPGSpKO19owpTZjS3l+4Es0yrUDYUcKzXiQjTEvprMnWYDnAQg5ZY8svJu7xqc
         zdi/YO+dWS24LbzETLszZfqsN9Sdn2EDAs/UjuQvXIORAMbN/x3gGUwEsu9MNC2+ICjD
         /Hx6+HquD1g1Ki5dy87pLBhmDeyukYTCgLnCSbCfPGYOfUDRZNYZNp/4k3PDg5bXhQDZ
         ZDLDyWH7GgKU2UtTKrM2Ro/mJuIHWs8Qx0h5GlrTLxAUdkvBIaoASndCwN+cERBh1zfS
         YCuZREdc9gL6A+VYbug9UajeMX0nO3hYvwOlw2yWGwkq/rPdo9ngcAzaxp4IG8wePnht
         AIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742511919; x=1743116719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny+GX9yVAovZ4kewf1rPe2k5PehefNSsdrKKMi2rCUM=;
        b=R3vJmy/5Ze6WBsGj3RIiXsV9YXwKgY6FCHoJZsN+Nj5bI1VH5hznv9O8GoPHYP0bTu
         c9tV+3wuDZybApYh5MUGd4Qk8mkvUOwBvCj5mPDo3QVLnLacNrz7wOUJ9OxCuDOa5gtv
         Mp+FDQap7nsdxViZ+do6gnFWUF5qNa2KifQf9+8D5YcW/AqKVaNQ9wx4uetaruKXk320
         r2iRYWFXUwpJk6dKX27ZWoGMrzqV3unMFs+lpr3O6Cg/9eMGumCXBCVDMh/b1jW09SSQ
         nDkFToubt7oJEDXpvpldTX8tjTkVZFf2Q2ZqTKWCh5gWLrJgqQzZf2HKQZRpxr+qtRre
         MvDA==
X-Forwarded-Encrypted: i=1; AJvYcCVPORHHWhgGDic3o6RisN6f7thVlwS5U82t86zyw3K+yDgAiW1GSpFyKeHk5liyqE4sZoDOeGGLi7kj1nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw91/cDGEYPh1eV3GefboANv5sUdp8MbClzNICI1oN1YCS5PyU3
	GP1/mUclE1Jv7DvPH3dwy9BFwBGfPh5bd0rfBxQApgSjDSxY1hrV/LCpP0YOUeWavLUmldDu73U
	BmRZBlm8TAT8MDBuWnNRtgBROeCuJk+ZVExCm
X-Gm-Gg: ASbGncsXuI4LqoDaLvlZNxBjxWNH8RW5/1+R3GNuy+TSQroefNEyh3LjCGB9bExogF7
	J3ZG+xsHYy12mld4u3jKEZqZtvcjpYaKeA52ZnzupjbGeyCSdAzbYjnSn1Dy/Vch6T06VnwGfvr
	qwv/Ys6Bknt0L71QIXcjDYqaXYGvuaxC9YRBQJQu7msf+lFgH0KbK/mQ==
X-Google-Smtp-Source: AGHT+IF5CK6kwBwnNBgPnJcgDWcZ3GUQUpPhOpTKtwb7ZWImMZjh8oACjRLggDzbt4l/0qzanepIPk+n4k3et23fQF4=
X-Received: by 2002:aa7:d497:0:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5ebcfee002emr19933a12.7.1742511918624; Thu, 20 Mar 2025
 16:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67dc67f0.050a0220.25ae54.001e.GAE@google.com> <qn7ncujf5gkfmohf5qp3fdakrymhoapkscafqp5t2gulmgdqai@tuhu2igx33k4>
 <CAG48ez0S4hJyqY=zZB_AWqFKtD7KjipR22F_wz1QvWNY=3RDWA@mail.gmail.com> <332b3149-0e84-4bf8-9542-89d68b0a9680@lucifer.local>
In-Reply-To: <332b3149-0e84-4bf8-9542-89d68b0a9680@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 21 Mar 2025 00:04:42 +0100
X-Gm-Features: AQ5f1Jp4nawavgqm2yUblZqtBydiZDSZ7_Jv04KZ6mtjQzD0tGgC7wPOtBY_Qkg
Message-ID: <CAG48ez0JUBPrb5Mh13Z__OeQ+w+uuhfEmj2FRReCpCT-2O-uyw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in vma_merge_existing_range
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pedro Falcato <pfalcato@suse.de>, 
	syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Mar 20, 2025 at 09:11:33PM +0100, Jann Horn wrote:
> > On Thu, Mar 20, 2025 at 9:02=E2=80=AFPM Pedro Falcato <pfalcato@suse.de=
> wrote:
> > > On Thu, Mar 20, 2025 at 12:09:36PM -0700, syzbot wrote:
[...]
> > > Ahh, fun bug. This *seems* to be the bug:
> > >
> > > First, in vma_modify:
> > >
> > >         merged =3D vma_merge_existing_range(vmg);
> > >         if (merged)
> > >                 return merged;
> > >         if (vmg_nomem(vmg))
> > >                 return ERR_PTR(-ENOMEM);
> > >
> > > then, all the way up to userfaultfd_release_all (the return value pro=
pagates
> > > vma_modify -> vma_modify_flags_uffd -> userfaultfd_clear_vma):
[...]
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 71ca012c616c..b2167b7dc27d 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -1517,8 +1517,16 @@ static struct vm_area_struct *vma_modify(struc=
t vma_merge_struct *vmg)
> > >         merged =3D vma_merge_existing_range(vmg);
> > >         if (merged)
> > >                 return merged;
> > > -       if (vmg_nomem(vmg))
> > > +       if (vmg_nomem(vmg)) {
> > > +               /* If we can avoid failing the whole modification
> > > +                * due to a merge OOM and validly keep going
> > > +                * (we're modifying the whole VMA), return vma intact=
.
> > > +                * It won't get merged, but such is life - we're avoi=
ding
> > > +                * OOM conditions in other parts of mm/ this way */
> > > +               if (start <=3D vma->vm_start && end >=3D vma->vm_end)
> > > +                       return vma;
>
> I do not like this solution at all, sorry.
>
> I mean I get what you're doing and it's smart to try to find a means out =
of
> this in general :) but let me explain my reasoning:
>
> For one this is uffd's fault, and the fix clearly needs to be there.

I mean... this worked fine back in, for example, 5.4 -
userfaultfd_release() would loop over the VMAs, change some stuff in
some of them, and merge them where possible, and there was no way
anything could fail. It's the VMA subsystem that changed its API...

> But also, we _can't be sure_ vma is valid any more. The second it goes of=
f
> to vma_merge_existing_range() it might be removed, which is why it's
> critical to only use 'merged'.
>
> Now you might be able to prove that _right now_ it'd be ok, if you do thi=
s
> check, because vma_complete() does the delete and only if either
> vma_iter_prealloc() or dup_anon_vma() fails would we return -ENOMEM and
> these happen _before_ vma_complete(), but that's an _implementation detai=
l_
> and now we've made an assumption that this is the case here.
>
> An implicit effectively precondition on something unexpressed like that i=
s
> asking for trouble, really don't want to go that way.
>
>
> > >                 return ERR_PTR(-ENOMEM);
> > > +       }
>
> >
> > Along the lines of your idea, perhaps we could add a parameter "bool
> > never_fail" to vma_modify() that is passed through to
> > vma_merge_existing_range(), and guarantee that it never fails when
> > that parameter is set? Then we could also check that never_fail is
> > only used in cases where no split is necessary. That somewhat avoids
> > having this kind of check that only ever runs in error conditions...
>
> Yeah hmmm, again this is _not where the problem is_. And we're doing it f=
or
> _one case only_, who _must_ succeed. Right?

It seems to me like it is... theoretically very reasonable of
userfaultfd to expect to have a "reliably change the flags of an
entire VMA" operation, and if the normal VMA code doesn't provide that
because of maple tree internals in the merging case, then it would be
reasonable for the VMA code to provide an alternative that does
provide this?

> Buuuut then again, we could add a _feature_ (it'd be something in VMG not=
 a
> bool, hey what are helper structs for right? :P)
>
> We coould add a special mode that says we __GFP_NOFAIL, we do that in
> vms_abort_munmap_vmas() and man that was under similar circumstances (hey
> remember that fun Liam? :)
>
> But at the same time, it feels icky, and we probably don't want to
> proliferate this pattern too much.
>
> So I'd kind of rather prefer a _general_ no-fail unmap that the uffd
> release code could invoke.
>
> Perhaps we could genericise the vms_abort_munmap_vmas():
>
>         mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
>
> And make that available or some form of it, to do the 'simplest' thing in
> this scenario.

The userfaultfd release code doesn't want an "unmap" operation. It
just wants to remove the __VM_UFFD_FLAGS flags and set the
vma->vm_userfaultfd_ctx pointer to NULL.
The VMA code then sometimes sees an opportunity to merge with adjacent
VMAs; and this merging is what's failing.
So if we're willing to tolerate having adjacent VMAs that are
mergeable but aren't merged after an allocation failure, then instead
of using __GFP_NOFAIL for the merge, we could also just ignore merge
failures, at least when some "never fail" flag is set?

[...]
> Another possible solution is to add a flag that _explicitly asserts and
> documents_ that you require that no VMA be removed before attempting to
> allocate.
>
> Or we could make that an _explicit_ assumption?

I don't think I understand this part. What VMA removal and allocation
are you talking about?

> And then the uffd code itself could cache vma and take Pedro's solution o=
n
> that basis?
>
> void userfaultfd_release_all(struct mm_struct *mm,
>                              struct userfaultfd_ctx *ctx)
> {
>         ...
>
>                 for_each_vma(vmi, vma) {
>                         struct vm_area_struct *old =3D vma;
>
>                         ...
>
>                         vma =3D userfaultfd_clear_vma(&vmi, prev, vma,
>                                     vma->vm_start, vma->vm_end);
>                         if (IS_ERR(vma)) {
>                                 BUG_ON(vma !=3D -ENOMEM); /* Sorry Linus!=
 */
>
>                                 /*
>                                 * OK we assert above that vma must remain=
 intact if we fail to allocate,
>                                 * We are in an extreme memory pressure st=
ate, we simply cannot clear this VMA. Move on.
>                                 */
>                                 prev =3D old;
>                         }
>
>                         ...
>                 }
> }
>
> I mean it's going to be dirty whichever way round we do this.
>
> Thoughts guys?

I guess my main thought on this is: I would prefer it if we keep any
code that runs only in near-impossible cases as simple as possible,
because issues in those codepaths will take longer to find.

