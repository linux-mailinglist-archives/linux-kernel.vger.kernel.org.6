Return-Path: <linux-kernel+bounces-444305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F098B9F046F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B82B188A2F6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471DB18A6BC;
	Fri, 13 Dec 2024 05:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="06dRKd61"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786311898ED
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 05:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734069064; cv=none; b=KsMlwCzq6+WT2bMi7R5sO70qtqO5wJUx0gjRYRFJ2Ib0VgKy48O9OApVNzl2dhT1+Xqz5gbME07/2889hRLFJ/t4W6H474iH3Moh/epLmKpamsVhwdZG+5T4EFnQkvV4XNPfaM0QYtNnUT/IM+zv/EUVKFi5n/rjYUL6cWkBBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734069064; c=relaxed/simple;
	bh=NvRLWK6YOIB//i1B4SP8ooailN6fU4KENN/hvb0JU10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMIBvJfrzaM/odTbNWY+1EzULoUdGYVi1OEdZM3KVmwhMrO0huPYKy37EITVT6R8Pl3cyMu+ScKLkyS3aJgj1cSK21Mae/NeKUkluh6lToxjhkiG7VJiSm+VCGH/+ToJgyHc9wcIVQGW4WihLYhNTUGQYBhmls57JVvTWrgV2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=06dRKd61; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4b24bc0cc65so762338137.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734069059; x=1734673859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1pi4Bm8p0bfLXi2mAJqGR7jkl/IYPNq3XoUf1+4fLE=;
        b=06dRKd613sp5yttl1nSXw8Q4DlGT7p1rj+mOaKTR5+ku+GhtdE4rdL98uzmJ8oeKcT
         p59BztYEp5h+0dDEMDDpFCOJxcugrMjWUyTESOvvtEAbHImq/kaI6uUfbzIg4bpqAG/4
         +t5+jLq2YbX+gK6r3kQ4oDS6C2gfTm4rlLkq8um8Zl3evGlM5y4wxPH3RtBpT//WKKbJ
         pWyC1G8OY7wq3BpqdAt0XnJn7ENTUcTndx3n89djRe65Vod7IExQYAPmMwtrw2mOV+/W
         9sbU/VuP+9UrW5SJlTN/X2pZnOvc8KCnznX0p8zf4UfLjDiO/vDWm/oOoEMCMxps+IgL
         p1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734069059; x=1734673859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1pi4Bm8p0bfLXi2mAJqGR7jkl/IYPNq3XoUf1+4fLE=;
        b=qEaxWxe8HCRtuIhSAeS+rJFNecazqffP4HLXq+Qa2iXEd09VQXw8mlG8fe7CPrppaJ
         Vc86Wkkt3eohiG+Y9kXvj56frQLc7Uo2BIsa/uxLupKiyum5wFfmAsdEdpLDMKnc4V43
         U4KKdFwZlQXuXvdHqeXX+MeTPIP58bw55t5AI9h2gn7t8i9ctC/NhMTu5Z/f9h7kJXFw
         mgD4CPySl818i0js7+aXzP4vG8KOCSzg7cueiaUE5B/VRhXpMRb4Lah8yFNHoszQVc8V
         MTQEBSO+dYbRKVtOTyE139CgbwwzUcY48Zk8RB3HpWe8LnXRu8VGXXG44XQA7Q1bVOy4
         XmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX+IP+As4PiHa2seN3NcWP4k47gSUVuOYK/mM7RTQiqmR6cPZswoqHBWQNLTSZot1BXHHjgv9DQ5U9lVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNM6gyJ89CLaBfsI+kdxqMSGrPwc6iYMMqTMmIlTiQysPO8+Pl
	qAl03pdLwnrS7qtAy3+7u3PR9CFABta596o6p2NpIK4eZbEJpjObg2vFdV/WNIBbY/yPzKfOphu
	+knUdeJd/HYXcPhyTwSD50Zvo8VV8/wAVqKGf
X-Gm-Gg: ASbGncsCmhj3F/LsGHScTo/xRmJZQ/72YkTrag+hdS1Gj9D9IDjV+3sOLClvbvFQPCp
	FPjrdhqcP8KVc95hNKRS5yDR0thnp9da3gFFCxXkUTQKyDn1ufUyRry0Ea5nFx9r7RPHIVYA=
X-Google-Smtp-Source: AGHT+IEu2Oib6VYKcn5uKqwxJs9eWc+HYKWzUG6wFe6xGaxUShvZ1zFkkTXthYtahXmlPHiAA/ESdqg1GZCRDZphRqA=
X-Received: by 2002:a05:6102:3e27:b0:4b0:2d7c:43ca with SMTP id
 ada2fe7eead31-4b25ddc752dmr1543399137.18.1734069058939; Thu, 12 Dec 2024
 21:50:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com> <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
In-Reply-To: <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 12 Dec 2024 22:50:19 -0700
Message-ID: <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Xu <jeffxu@chromium.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Dec 11, 2024 at 10:36:42AM -0800, Jeff Xu wrote:
> > On Wed, Dec 11, 2024 at 2:53=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Update the MEMORY MAPPING section to contain VMA logic as it makes no
> > > sense to have these two sections separate.
> > >
> > > Additionally, add files which permit changes to the attributes and/or
> > > ranges spanned by memory mappings, in essence anything which might al=
ter
> > > the output of /proc/$pid/[s]maps.
> > >
> > > This is necessarily fuzzy, as there is not quite as good separation o=
f
> > > concerns as we would ideally like in the kernel. However each of thes=
e
> > > files interacts with the VMA and memory mapping logic in such a way a=
s to
> > > be inseparatable from it, and it is important that they are maintaine=
d in
> > > conjunction with it.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  MAINTAINERS | 23 ++++++++---------------
> > >  1 file changed, 8 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 68d825a4c69c..fb91389addd7 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -15071,7 +15071,15 @@ L:     linux-mm@kvack.org
> > >  S:     Maintained
> > >  W:     http://www.linux-mm.org
> > >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > +F:     mm/mlock.c
> > >  F:     mm/mmap.c
> > > +F:     mm/mprotect.c
> > > +F:     mm/mremap.c
> > > +F:     mm/mseal.c
> > > +F:     mm/vma.c
> > > +F:     mm/vma.h
> > > +F:     mm/vma_internal.h
> > > +F:     tools/testing/vma/
> > >
> > Will  madvise be here too ?
>
> No. We had a long discussion about this on another version of this patch =
:)
> it's blurry lines but it, in the end, is too much related to things other
> than VMA logic.
>
> We probably need better separation of stuff, but that's another thing...
>
> > I'd like to be added as a reviewer on mm/mseal.c.  Is there any way to
> > indicate this from this file ?
>
> This is something we can consider in the future, sure.

What'd be the downsides of having an additional reviewer? Especially
the one who wrote the code...

> However at this time you have had really significant issues in engaging
> with the community on a regular basis

I'm not aware that this can disqualify anyone from being a reviewer of
a specific file.

> so I think the community is unlikely
> to be open to this until you have improved in this area.

I do not know Jeff personally, but I think the community should make
anyone who wants to contribute feel welcome.

> You will, of course, remain cc'd on any mseal changes regardless, so
> functionally nothing will differ.
>
> And equally, this change doesn't alter my or Liam's role, we will apply t=
he
> same review regardless.
>
> The purpose of this change is, as the message says, to ensure the integri=
ty
> and maintainership of logic relating to memory mapping, and mseal is real=
ly
> entirely a VMA operation so has to be included as a result.
>
> So it is administrative in nature, ultimately.

Sorry -- I couldn't make out what you are trying to say here. So I'd
like to ask bluntly: is there any previous disagreement between you
and Jeff to make you reject his request? If so, I think we'd need a
3rd party (probably Andrew) to review his request. If not, I'd urge
you to use his help.

