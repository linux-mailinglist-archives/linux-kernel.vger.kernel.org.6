Return-Path: <linux-kernel+bounces-444508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF89F0800
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BC728259B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D2E1B21A6;
	Fri, 13 Dec 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfBm5hEP"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7F1B0F2F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082620; cv=none; b=Jwsu/iclZZplx4BUcFA5IK0Oyp957k2dMRkXDZEkFM2Wgdi7WGZCMzAalhzQwywDM/MdrgW8fKDrG3yozOTHLoTGeHqxJJgdAoM7udJD4QTCCwZmyEjaqbOrhYueotl98NDRoscrVX/s3mTuR/eYKAdiUfldjnn5hBce4L1p+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082620; c=relaxed/simple;
	bh=kEsTREYesetcDzWyMbGm8R057oYxAfJiNDHE3KZizEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Re9GYtJ9DdnPEFnzhrpiLzBAJ6EgUD6+dQaqDM4ls8goPCyH7Whjj81Mu8OhB7II4cY0j/EbfZ88nrwQ16dMC9OOOpc1mvfVgFrhs21XbWEeB2foCnzlfWyyMwcsXtOTvx0D/lNYebPST4aVBqK4HAuknx6srGYgBr0YJnnykXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfBm5hEP; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85c4b4cf73aso292380241.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734082617; x=1734687417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3XXJHW5LnEyEta6X/firnxrZkn91cljZSj6HOtEdXU=;
        b=JfBm5hEPvLH5bd6o48ei+7F0AnBhMCN5ghGKFUEK9mr56yrfkbnmiLiWbILCXBMlft
         X0Pxh0e40tl7FvJ0BorakGbDNNG8dbInbD/UPdAQU8N/H0sz8DJiXnYqfnTrH7W3lmJr
         NCHdNY8/n4at3ErwJXav+eSbjLUU2A3Ry8hPa/0f9tGChEjCJxug1PWA0A93M7V6IRC2
         vbfEj8RRun+CqliCGQQFU6pA9q/55I1PJBZ2NH1CVVDTMpuLjSo0bPmFhlgt5ljijQRf
         xS0EDw3N2djdsqp4GAbWlKgmWspwosZbTXaKlzXp+83a9nL3wRpdoXp2ApW93YW9cvm8
         q07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734082617; x=1734687417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3XXJHW5LnEyEta6X/firnxrZkn91cljZSj6HOtEdXU=;
        b=L7VXuL+vLobuTFJL6US7RQjfXJyv9CHkbDJh1gUOdJ4kajx75N3mezT268OtXAG3P3
         vApzyoe0X5OMUy9alORVjw23hCeTZ2lw8BCSraSQ3m8fVKH+odM5muNJjQptmJnHtjtR
         UqCfp7x/0ugqdWaKIDnULdKEV0ypv/QBFQKYkg3O31E3Ey2/qAPvDVoV2xI91IVFKs+E
         g663hoaxdxvhVBFDM0INfMeV3IbOg2MhDUAr+cXoLu8yglMXCpp48UZJ5IX1Iblmy9oQ
         gTVLThle3QxQD3YJdrCXo8tHB4ELcWN0ToTaUTBbFdkSSx/ergdLWy3r6eBAEz/uVRN2
         +QJA==
X-Forwarded-Encrypted: i=1; AJvYcCXqhgvTgGvBzJ6KxxwjqpxdGXUPz6wvx+w/FA2EWMJhQt7oI4TM4wdiaU2j+DiIzh2Mrt5NzaU/Ey1G/xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShvHKr4tj36nizYC0c0eL7JP0ldT1m4ji+RpVjJj5nXrk4L8V
	8OOTa84qCGmYUdracoYvQjYeEVQLEeOp/jM79C0/aGXK8GYKMzHgpmCveLNZS7Q0i7R26GBn5Ih
	x4p7b8EwO3W322QON8xI0jqOyHX1TZT4RFWus
X-Gm-Gg: ASbGncuf0PP2OIP3h98+U2ZEf5kSdI4XL4O9pDhQEoQe1wdVUZH4yrzU3GPrYFMSf2w
	3Czx+Z5lZ5FpELJP/TMo71pgCW8Mioj1MJsklMCVuJAXMnaq8XVCkPD2107PYRKiji+kzDqQ=
X-Google-Smtp-Source: AGHT+IE3r8tCj94yDViV8T0hug96B5mFZ4NL+7fdwhKNHFFk8OfSbcKbHILSNoIgVb2TRCHYLfw95G8EYPD4MIShBHU=
X-Received: by 2002:a05:6102:1044:b0:4b2:5ecf:d128 with SMTP id
 ada2fe7eead31-4b25ecff079mr1116441137.23.1734082616712; Fri, 13 Dec 2024
 01:36:56 -0800 (PST)
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
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 13 Dec 2024 02:36:19 -0700
Message-ID: <CAOUHufb3dML6mdySFyaoiaxVfLzGAG8EetP880h2JZTMKm3hDQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update MEMORY MAPPING section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 2:18=E2=80=AFAM Lorenzo Stoakes
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
> My intent throughout has strictly been to HELP Jeff, to both ensure that
> mseal is as good as it can be, and that he can be a productive and
> successful member of the community.
>
> This is, and has always been, my only intent and desire here - so things
> are actually quite entirely the opposite of what you seem to think they
> are.
>
> My point here is solely that this is just an area that he needs to work o=
n
> and I'm not enitrely sure it'd be helpful until he has done so, this is
> all.

Thanks for clarifying. It was just miscommunication.

