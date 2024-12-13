Return-Path: <linux-kernel+bounces-445044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EAB9F1047
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA79F16BDA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D181E1C09;
	Fri, 13 Dec 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KSFfNtSt"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8199A19F40E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102321; cv=none; b=PtTia0EyTBj1agHyS8LsM0cp17a+Az9HWj651Is3VD/ZTTmbjlVnrw6PpbIi2WA3YMPie3n3fso8hydz4kSri7P89l9HejxlhLs9LWue9Y3QoEeCyuXtOZ9Abh0iTYtiuHxCzMCxZYwXZdHQ3ODJH8yzKDO7cEesbaG+qz9zTNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102321; c=relaxed/simple;
	bh=1zxXbyGi2gfjPADB4w1rcj0ZhcVZvWt+WV2Nrlh5PyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfPQGmwD4hqeMiardHmxwhRwpjoN9h23pEu5xfuCP4Ggt2zi+WQiddZhWhcXxfUJldWACrX3oNw+P/6LS0gxN9j78/lgsjRD1BxPfVeUpJO9wd4O6dIOvZY1BkvnDPpvX0qHVMLQU5uawKiAs4JrHbxyec6cWYUxmcXJ9Dkqkis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KSFfNtSt; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f2d8e590e2so78261eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734102318; x=1734707118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK1Wn/2TaTQiTjolBHB4TPR3OYstJinGPMBetUH/Dj4=;
        b=KSFfNtStbpXv2ntr9QV1lgxTLSLr5I5l3vtAd+lo+Wc+Qy7BtrskqD/pobfoK97fLe
         HjutP+XhwJomxzCX25W92mr2d/k0pcPt/XcQePwObW/zczn/jKcvK21mljWPYMAg9MRM
         GkhtIk0LHLp3sdP2zzw2sTzoF8iNkiBXEtc08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734102318; x=1734707118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK1Wn/2TaTQiTjolBHB4TPR3OYstJinGPMBetUH/Dj4=;
        b=cXZnApotI3o5amb0QFM7w6+owiwdA31p0/kHdiINvYULeQ7d+MPofyNxW/iyF45IWv
         M/64y/iWuneySb0LesF9a75NBbn+j/lvpxNnX0UYwWtMbF14nSI9vj6Zxw8qipHNUb7X
         hg9ochjDrUEXWEARxgW3Em4eoUFECJ5g99BdmAnJQFd6QKEVf7Hz44hrIrefYJSwlR2L
         3IQflz995Fhws2hu7tAq5nhGsidEyePnhCpD5JZBUnRrmGvQ2n2f/K/KcxdhOefKGAr7
         2v4bi32c3nBWw8bZ1BUO3aMqQp+PJbOMG4lfeo27uLuiMiMHxfuHt3CocL5BEaYmL9GN
         u6+g==
X-Forwarded-Encrypted: i=1; AJvYcCXVNE91XBSecAqHHm4r9hoE3qsUWNlxVILopdX39IND7t0MiymalUnBHfI1Xv9JZqST1iXLhMRqR3fmfVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+QgdWeAZsbEWZcBbingcWfpG7cvGe1uyooYzOmFhDNbivJb9
	iUnMRbJCvxpnnZkJZ4DMXrsT4dWA8dvXd89S4AKICiaOkRWtpvEFGnm/DYTpr7j4HXrfto0nEFV
	4oJWuVreI4pwLHEmPAFKivizUT+htRcVWe1Yh
X-Gm-Gg: ASbGncscUToZuI8wJ9nDhG/XgYI9slamuzKS/PfUpGb0sKHeTAUg7fQvfAyVlqMG+LO
	C9PELO1pgcKs+a6r/f7D9laYYhORodh0gyLbwYnBeO+JsbXVHDChfyBWMHR2aUwVqlWVykZE=
X-Google-Smtp-Source: AGHT+IEVaDSbGLsumhW9zXC/ZGG4dC4b8hhxKUeGWallISgNNzKOFa2dE5kEKicyUo55GFO/OF4gSokCqcgH4hZRJVc=
X-Received: by 2002:a05:6871:5209:b0:29e:5525:f4fd with SMTP id
 586e51a60fabf-2a3ac9824c5mr578830fac.14.1734102318525; Fri, 13 Dec 2024
 07:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105315.21756-1-lorenzo.stoakes@oracle.com>
 <CABi2SkXTSi8HKTyE1WoL3qqOTk4KDnF1-RkSOX+ne=cEFJL4qg@mail.gmail.com>
 <a2c43cfe-5c99-481a-b599-fca8b4fe1e38@lucifer.local> <CAOUHufYCF0i_aJZPceMXfcTZUcZsCY9fBuMr=25q1bROWx5nsg@mail.gmail.com>
 <cb5eea98-2515-4b06-8f65-515842e1081b@lucifer.local>
In-Reply-To: <cb5eea98-2515-4b06-8f65-515842e1081b@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 13 Dec 2024 07:05:06 -0800
Message-ID: <CABi2SkXgTnjiTnBF-dwsf1Wvjo0FngOyHAMw6ba0MAKf1Wr9PQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Yu Zhao <yuzhao@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Fri, Dec 13, 2024 at 1:18=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Dec 12, 2024 at 10:50:19PM -0700, Yu Zhao wrote:
> > On Wed, Dec 11, 2024 at 11:57=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 10:36:42AM -0800, Jeff Xu wrote:
> > > > On Wed, Dec 11, 2024 at 2:53=E2=80=AFAM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > Update the MEMORY MAPPING section to contain VMA logic as it make=
s no
> > > > > sense to have these two sections separate.
> > > > >
> > > > > Additionally, add files which permit changes to the attributes an=
d/or
> > > > > ranges spanned by memory mappings, in essence anything which migh=
t alter
> > > > > the output of /proc/$pid/[s]maps.
> > > > >
> > > > > This is necessarily fuzzy, as there is not quite as good separati=
on of
> > > > > concerns as we would ideally like in the kernel. However each of =
these
> > > > > files interacts with the VMA and memory mapping logic in such a w=
ay as to
> > > > > be inseparatable from it, and it is important that they are maint=
ained in
> > > > > conjunction with it.
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > ---
> > > > >  MAINTAINERS | 23 ++++++++---------------
> > > > >  1 file changed, 8 insertions(+), 15 deletions(-)
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index 68d825a4c69c..fb91389addd7 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -15071,7 +15071,15 @@ L:     linux-mm@kvack.org
> > > > >  S:     Maintained
> > > > >  W:     http://www.linux-mm.org
> > > > >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > +F:     mm/mlock.c
> > > > >  F:     mm/mmap.c
> > > > > +F:     mm/mprotect.c
> > > > > +F:     mm/mremap.c
> > > > > +F:     mm/mseal.c
> > > > > +F:     mm/vma.c
> > > > > +F:     mm/vma.h
> > > > > +F:     mm/vma_internal.h
> > > > > +F:     tools/testing/vma/
> > > > >
> > > > Will  madvise be here too ?
> > >
> > > No. We had a long discussion about this on another version of this pa=
tch :)
> > > it's blurry lines but it, in the end, is too much related to things o=
ther
> > > than VMA logic.
> > >
> > > We probably need better separation of stuff, but that's another thing=
...
> > >
> > > > I'd like to be added as a reviewer on mm/mseal.c.  Is there any way=
 to
> > > > indicate this from this file ?
> > >
> > > This is something we can consider in the future, sure.
> >
> > What'd be the downsides of having an additional reviewer? Especially
> > the one who wrote the code...
> >
> > > However at this time you have had really significant issues in engagi=
ng
> > > with the community on a regular basis
> >
> > I'm not aware that this can disqualify anyone from being a reviewer of
> > a specific file.
> >
> > > so I think the community is unlikely
> > > to be open to this until you have improved in this area.
> >
> > I do not know Jeff personally, but I think the community should make
> > anyone who wants to contribute feel welcome.
>
> This is very unfair.
>
> I have personally spent several hours doing my best to try to provide
> advice and review strictly to help Jeff get series into the kernel, perha=
ps
> more than anybody else.
>
Thanks for your help (and others ) on reviewing mseal_test.c.

For the reference: I sent RFC [1] to follow up on refactor work of
selftest. To save your review time, I made minimal changes using two
test cases, and intended as a baseline/pattern for remaining
refactoring work for mseal_test.c.  If you have time to give your
comments about the RFC before the holiday break, great! I can start
refactoring the other mseal_test.  Otherwise, the after-holiday will
be fine too.

[1] https://lore.kernel.org/all/20241211053311.245636-1-jeffxu@google.com/

Best regards,
-Jeff

