Return-Path: <linux-kernel+bounces-357562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A09C99728F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7731C2348D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E721D359E;
	Wed,  9 Oct 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCLmuMPQ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467B1DF730
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493409; cv=none; b=Q63576gopiPrld2ct5956n5oVfvQOJ2WVf9UL3pP30E85zkGuLJS4dL7gNWxiTcRGiBHN2X+GPLyOjc43jVZUoz0ubOyQX2cqywx9iOsCJ4qFwEcL60DiehrGXwEEndLbIPB9/gWrkJJSukY+ZkGEmohQjOHrGLAgdEBtej1sZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493409; c=relaxed/simple;
	bh=il/b3AvZzWJBRYKtEb/2HkenoGGf4dTZi4thDrQuPh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iA1eDsqJnDRFSmWSTxwiv0brkyAcsMp66u9jmVHZUh5/mhGpj0rjbQ5IPfAe26xDSqZAfQnAzzfJJiiDxi0cNC6JL7navuFbppSZ7NnU6VLCiWQvjQFAq1x1vddPYl6QaYUtJdVSApOvfXVZRx7DsR19MO0iClhzy6U97e6hQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCLmuMPQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431141cb4efso11225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728493406; x=1729098206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ec63M9Z2mnZ2BK+SUFLWuoDF9eppHWtyWp+65Wr+50=;
        b=WCLmuMPQAMDelEAbVGAx86R4SlBOdV9OzF/xIuz34tScVxzt9sO6Hclm3dgnah8TyK
         9dcAt25Q+WN05jkZ0HuJ6jNfnR9MU9w4sRpKuqma/GnauyKaJ5ySRD4okbdzEM4gEbkw
         Zqrv2MIxLMJbJkF2XfIU6ugbHT0IZT8MhBO40PZuuQufyMw4Fk0bDYwcA9oKXuoSVDze
         iJXQUeCodtzVS0S1it2rkv/U1bKuGj/Rcbmdjx7Samsz5q659otKcdXcZdwg9sB1X1sX
         LPdJBRunQ3R4zmzadIoFx0Ut2XGWykrE572nOO/jOxEZ7dwMnxpXOwJtp6YDqfCtHw9n
         dYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493406; x=1729098206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ec63M9Z2mnZ2BK+SUFLWuoDF9eppHWtyWp+65Wr+50=;
        b=E/nq9S0mS0q6Jy1CpnqAanOSbe0kXFvfbhIQh4FPAkGdcbHHFOTcUXdZBmB4xd6wIB
         CswEJ1wFxI1Qim+FILvK52JI1C4KxEbv5n8Piwf6KSqnnRiBQQsnr6tnSG16pOLlSaze
         iPFq4sw3mZ3cFKlE/3BY39stlxb4K5qzx9N4kXXoJMw/AgnrvAWren12x0cHmTpYG4Bq
         KgISDVfH6aYxmlw4UGyplyZvQdxMZHvn706xBFW/UbuXG/bO3Rgfv7yJj9YqFxnAmDm2
         F+kiIuekTAsNPB4r5oY7od1/KQiVlWwhswu2tcgQwGBQ52dC4uDiiMPpbEaOrzdCtNmr
         2oNA==
X-Forwarded-Encrypted: i=1; AJvYcCV7lcFryAS4lGQa6yvqUW/46UP7C4soGCNuiFEOQoy7xmhjjot7JkgtEfZmIfOHGaiwsxK7M56q86Qgx40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKpHvV6SM0M5W5QWbTa+hCuabKFHElVTqL01X3mc88LjS086C
	Yd4LWH8KO5M5mUNtwxOfWj5Y+lFUS/cuvzxhsE87h8qC4EH5+XXm654Ez1FC/8yHQ1BglLPhLBs
	2LcygoGkSW+PWOQCcZdlEqZzsxQ74nOHOE2y9
X-Google-Smtp-Source: AGHT+IH3gl8juZOigw+MxQlp2jNC2mCofepON7jhbWcSWQ/mk8khIIP1Uw/HQRJPdHyuneyy1GivHmlFb8tRVjjzCKM=
X-Received: by 2002:a05:600c:b8a:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-43058cf488cmr5665585e9.2.1728493405368; Wed, 09 Oct 2024
 10:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-stack-gap-inaccessible-v1-1-848d4d891f21@google.com>
 <1eda6e90-b8d1-4053-9757-8f59c3a6e7ee@lucifer.local> <CAG48ez2v=r9-37JADA5DgnZdMLCjcbVxAjLt5eH5uoBohRdqsw@mail.gmail.com>
 <3d334639-feb9-474d-a4ed-6aa6d2afb33d@lucifer.local>
In-Reply-To: <3d334639-feb9-474d-a4ed-6aa6d2afb33d@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Wed, 9 Oct 2024 19:02:47 +0200
Message-ID: <CAG48ez3uFHMoXCD2ys0rp9VZ=_yfO_819kNBensYue=+Tq-dew@mail.gmail.com>
Subject: Re: [PATCH] mm: Enforce a minimal stack gap even against inaccessible VMAs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>, 
	Vlastimil Babka <vbabka@suse.cz>, Ben Hutchings <ben@decadent.org.uk>, Willy Tarreau <w@1wt.eu>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:53=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Tue, Oct 08, 2024 at 04:20:13PM +0200, Jann Horn wrote:
> > Though, while writing the above reproducer, I noticed another dodgy
> > scenario regarding the stack gap: MAP_FIXED_NOREPLACE apparently
> > ignores the stack guard region, because it only checks for VMA
> > intersection, see this example:
[snip]
> > That could also be bad: MAP_FIXED_NOREPLACE exists, from what I
> > understand, partly so that malloc implementations can use it to grow
> > heap memory chunks (though glibc doesn't use it, I'm not sure who
> > actually uses it that way). We wouldn't want a malloc implementation
> > to grow a heap memory chunk until it is directly adjacent to a stack.
>
> It seems... weird to use it that way as you couldn't be sure you weren't
> overwriting another VMA.

Here I'm talking about MAP_FIXED_NOREPLACE, not MAP_FIXED.
MAP_FIXED_NOREPLACE is supposed to be sort of like calling mmap() with
an address hint, except that if creating the VMA at the provided hint
is not possible, it fails. I remember Daniel Micay talking about using
it in his memory allocator at some point...

> > > > @@ -1155,10 +1157,47 @@ int expand_downwards(struct vm_area_struct =
*vma, unsigned long address)
> > > >       /* Enforce stack_guard_gap */
> > > >       prev =3D vma_prev(&vmi);
> > > >       /* Check that both stack segments have the same anon_vma? */
> > > > -     if (prev) {
> > > > -             if (!(prev->vm_flags & VM_GROWSDOWN) &&
> > > > -                 vma_is_accessible(prev) &&
> > > > -                 (address - prev->vm_end < stack_guard_gap))
> > > > +     if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
> > > > +         (address - prev->vm_end < stack_guard_gap)) {
> > > > +             /*
> > > > +              * If the previous VMA is accessible, this is the nor=
mal case
> > > > +              * where the main stack is growing down towards some =
unrelated
> > > > +              * VMA. Enforce the full stack guard gap.
> > > > +              */
> > > > +             if (vma_is_accessible(prev))
> > > > +                     return -ENOMEM;
> > > > +
> > > > +             /*
> > > > +              * If the previous VMA is not accessible, we have a p=
roblem:
> > > > +              * We can't tell what userspace's intent is.
> > > > +              *
> > > > +              * Case A:
> > > > +              * Maybe userspace wants to use the previous VMA as a
> > > > +              * "guard region" at the bottom of the main stack, in=
 which case
> > > > +              * userspace wants us to grow the stack until it is a=
djacent to
> > > > +              * the guard region. Apparently some Java runtime env=
ironments
> > > > +              * and Rust do that?
> > > > +              * That is kind of ugly, and in that case userspace r=
eally ought
> > > > +              * to ensure that the stack is fully expanded immedia=
tely, but
> > > > +              * we have to handle this case.
> > >
> > > Yeah we can't break userspace on this, no doubt somebody is relying o=
n this
> > > _somewhere_.
> >
> > It would have to be a new user who appeared after commit 1be7107fbe18.
> > And they'd have to install a "guard vma" somewhere below the main
> > stack, and they'd have to care so much about the size of the stack
> > that a single page makes a difference.
>
> You did say 'Apparently some Java runtime environments and Rust do that'
> though right? Or am I misunderstanding?

Ah, sorry, the context for this is in the commit message of commit
561b5e0709e4, and the upstream discussion leading up to it
(https://lore.kernel.org/all/1499126133.2707.20.camel@decadent.org.uk/T/).

So before commit 1be7107fbe18, these workloads worked fine despite the
kernel unconditionally enforcing a single-page gap; and only when
1be7107fbe18 changed that gap to be 1MB, people started seeing issues,
which 561b5e0709e4 was supposed to address.

So my idea with this patch was to revert the behavior for such
workloads to the pre-1be7107fbe18 situation.

