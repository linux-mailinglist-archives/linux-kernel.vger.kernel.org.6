Return-Path: <linux-kernel+bounces-436666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B259E8931
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7571E1882C2B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B41570815;
	Mon,  9 Dec 2024 02:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ydizB2N1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7794D8CB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733711362; cv=none; b=FVkbnpz8bmp9mcXQv411cLQsbwKB4SjTJ95Lt1KIA0GL7NLH+1fZCaz5+YQC+fGx2+fhgWPEQBCZEatLAz9V2qRage9YopSwBdGFgY0S3RjqaRrf7PuStnMmxQ9PiEL995r91NL2CDrN1VelMmtFtQwqfnzYauNtgOsufcXCG9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733711362; c=relaxed/simple;
	bh=ka9+j8P1UyfdFOngKJs0khOivaTg1zLeITHqI6Ru1tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dU9NRcQdxGs5zkOVUljiDZB+3RVyATJonwX8Ed7zdD2pUYJrN7Mds/e6MPsCxag0EyhIvlsSnRRDIHwmsvBvLZEsbrD9yOsri+NsAN7YOunZuf2+2id9nuLWA7zD99xO5K3qF9ap0u/Zb1fkCNN4RW9Zwhaj2TnL4x9usRFc86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ydizB2N1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215740b7fb8so127285ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 18:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733711360; x=1734316160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka9+j8P1UyfdFOngKJs0khOivaTg1zLeITHqI6Ru1tI=;
        b=ydizB2N1jpiBrmz7uIWRFnuLtfb9URfvB//7gGQHA8VOI5Qd3HgZPzF5ckDF7NELzE
         EDvHrbdWmqxMJU+RVSV1pAsAP2eudI24JREwOfGeNZkwMyJ8FO3oMuivF7shLgUG68Bv
         4nKyXn2J7/oiuHw3+eC1rzdsYqDm6tN1BYw0L4nwOqW4gql/Fc1tBqHV+SfwhyamzaCK
         r74DKHnGKHHUqijG9pUVZwLYTWi44mMr84XCdcSQfOaMI6RyqhZsjI/GwEukl73/LQdF
         xjL1tqtCNp4uYnthzNh410OLB93Vqc8TMGlT1IPld2YOElaImYQzY3apSgiN3b6qmYL2
         BrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733711360; x=1734316160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka9+j8P1UyfdFOngKJs0khOivaTg1zLeITHqI6Ru1tI=;
        b=GRFOSIuffrX76f5CCiF1i4YoEE86sxWgbwt1kYIsfQ93uV3EBrOIuC0WnNm2VnUm0g
         aWoKML+/7qycHjryXL+3ziH5sMFhe5qNswAk5qWaFFS6RBlLVd5LXt7UrhKthP2oU1lW
         Inq2DGIeqNGJkvsTk2eCUYKVFtvU8ITifvyY487PdxWh4YdLaiy24DoxCxCdts+oHTYG
         VreIilIAMBCIQNgC8fEuUxC9NJ66xxGBtZCsD8peLawWnDp5FIpsi+dE2w15MEqGV7N2
         lxlBmbCPjvw9RU42sfSEzfOrt4VunXVsStdyHIHC/x4m1uGwITeCiMnF34t7aixgagph
         oqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlHBBFMsax10DXsIfbC1uzDJgNJdg+9nr0Voop+p48U+sVTm0SgnVRWugtNzh/zB4sCAD+m98/x+5mLoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNiBjfLevNb/ka3w7UmY6Y6KBrzBcd7PyhDPT+o9cS2egSRF/r
	cktKrG8GnIC3Zc+9sd9IvBEdgBA4Iwds604dVNQL/25mFCWNwqeEq7iMsRP6PpW1UGmhZLbGpeH
	ukf5aW+3o6JKW6EE+AfJ11QOS8d1HyP216D14
X-Gm-Gg: ASbGncvG6EnVRzK3dpySEWmzlDouimSDSfBCkgx27b9Vzc3AMesyEHWPWUf/T3FKXgW
	4Lv2KtfrokCFLnAC4G+zlI0sGtLlU2kY=
X-Google-Smtp-Source: AGHT+IH1tl+NeR9OKA53arvCmHwV/ON+NaNlZw58Bl3GW7p5kZDh1MVGbMUuFDtmVn12tDIvOHNo3XiUvQQrZxbb9pc=
X-Received: by 2002:a17:902:f611:b0:215:9327:5aed with SMTP id
 d9443c01a7336-2162a9d6029mr2697315ad.20.1733711359668; Sun, 08 Dec 2024
 18:29:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206152032.1222067-1-bgeffon@google.com> <CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com>
 <04b1f6c2-32be-4bc0-af0a-919c9c1ee33f@lucifer.local>
In-Reply-To: <04b1f6c2-32be-4bc0-af0a-919c9c1ee33f@lucifer.local>
From: Brian Geffon <bgeffon@google.com>
Date: Sun, 8 Dec 2024 18:28:40 -0800
Message-ID: <CADyq12ystJ2D1+ze5cvHkj9juk1H+LbTwM6t7vCJKiWGKy3h5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mremap: Fix newaddr hint with MREMAP_DONTUNMAP
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Marco Vanotti <mvanotti@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 10:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Dec 06, 2024 at 07:42:51PM +0100, Jann Horn wrote:
> > +mmap maintainers (maybe mm/mremap.c should be added to the file
> > pattern for "MEMORY MAPPING" in "MAINTAINERS"? I'm not sure)
>
> Yeah I think it's actually right to group together _all_ VMA-related oper=
ations
> under the VMA entry, because we have interaction between them all mprotec=
t,
> mlock, etc. etc. etc.
>
> I will send a patch in a second for this, because we do keep getting bitt=
en by
> this.
>
> >
> > On Fri, Dec 6, 2024 at 4:20=E2=80=AFPM Brian Geffon <bgeffon@google.com=
> wrote:
> > > mmap(2) allows for a destination address to be specified without
> > > MAP_FIXED and in this situation it's a hint to get_unmapped_area().
> > > This address need not be page aligned because get_unmapped_area() wil=
l
> > > align the hint.
> > >
> > > In the case of mremap(2) with MREMAP_DONTUNMAP it shares a code path
> > > with MREMAP_FIXED in mremap_to(), which means this function can be
> > > called in 3 different scenarios: MREMAP_FIXED only, MREMAP_DONTUNMAP
> > > only, or MREMAP_FIXED | MREMAP_DONTUNMAP. In the second case when onl=
y
> > > MREMAP_DONTUNMAP is specified we don't need to do alignment or size
> > > checks on newaddr because they will be passed to get_unmapped_area() =
and
> > > dealt with appropriately.
> > >
> > > This patch corrects that behavior to match what non-MREMAP_DONTUNMAP
> > > mremap(2) and mmap(2) do. This odd behavioral difference was reported=
 by
> > > Marco Vanotti. Additionally, I've included a self test to validate th=
is
> > > behavior.
>
> Yeah if this is user-facing - I don't think we can change this. Can we do=
 any v2
> as an RFC for now until we can get a chance to look at this? And please c=
c- the
> VMA/mmap maintainers on future revisions (sorry this wasn't at all clear,=
 we
> need to update MAINTAINERS here).

Sure, I'll mail the next series as an RFC in the next few days. This
behavior was not introduced intentionally.

>
> Thanks!
>
> >
> > Marco pointed me to this; I had no idea mremap() had this undocumented
> > behavior where it takes a hint address. The mremap() manpage is
> > currently wrong about this, it sort of implies that the new_address
> > argument is only used if MREMAP_FIXED is set.
> >
> > Marco also noticed that upstream glibc now assumes this behavior:
> > https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D6c40cb0e9f893d=
49dc7caee580a055de53562206
> >
> > Debian also has a test that explicitly checks for this behavior:
> > https://sources.debian.org/src/glibc/2.40-4/debian/patches/git-updates.=
diff/?hl=3D22820#L22818
> >
> > I guess it's too late to remove that behavior at this point, and the
> > right thing to do is to update the manpage?
>
> Yeah, if user-facing we can't fundamentally change behaviour even if it's
> strange I'd say.

Definitely, no matter what happens we'll need a man page update. I
think to make things consistent we'll probably want to consider
allowing all variants of mremap(2) (without MREMAP_FIXED) to use
newaddr as a hint, like mmap(2). But I'll mail the RFC with much more
detail in the cover letter about the history and impact.

Brian

