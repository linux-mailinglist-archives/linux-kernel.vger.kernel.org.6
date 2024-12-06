Return-Path: <linux-kernel+bounces-435557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815629E7950
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2A71886B79
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9711DA31D;
	Fri,  6 Dec 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ear1Nysq"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC27B192B76
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514807; cv=none; b=cKSXOIXX0A7qzSX9NwiZdwADcjT3yo/nG8pGtj9kC1Xg0cyqojUgix9etD04qgIVNwx2ylcbIZxygdCnOIR3l8Cx51DoiqCeuV3e3fAXYH3M4VnAq71ZPrc8TtGB3ld4M8lYkCk3hbUq+gA/5LjBWmfFFZwg7OySDfhp1EHaNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514807; c=relaxed/simple;
	bh=+UJaKlCLM1eBrOkIcwMg7qDlcZEJbIkUlLbxpr8c1ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvN6pntLh/AwvAR+29PjXh4KwdZHyzoOsDna3qQ9zej4rqdGMliJ2Z3BATDacG9I9zDU/JbiN9qGc21MFrUrJ+tBdx/h362+ktarX3+u2Ymo52y8j6eZFSxg/ERdutLnISopfHMlBsefL52qhsuTlojo4ap50nxhSf60k9D1WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ear1Nysq; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-268d0979e90so340040fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733514805; x=1734119605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kD0PG/Son46c2udECUUzy+txrtNMIZH1gjXmstMo4Js=;
        b=ear1NysqeFhIo/+1m395I8RMI71d9VhQkv6CF8zo8w8adBf5/C0d3FBVgmtWy3kyMQ
         VXu2XDBBdwneahNiUG1fNPFuAcf5qej2R+F6cadpEKZ/C7qwT7uoMY1yTvCYWyr4NF3S
         YEVT71NS9y2Fx3Lr481+SPFw5FdemNkReMAvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514805; x=1734119605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD0PG/Son46c2udECUUzy+txrtNMIZH1gjXmstMo4Js=;
        b=smbjD/0pwa/2QPhxDPldaR2PIC1uhT5clbEMEG59i2j7YkiWC6rxV2R7KmY1YugzZe
         gq5CSjaIKnd9tCWdITLRo7C93bDNNgyQPkjH0LbuoVBy6/LRQpZx9Gtw61V38gYk6lzc
         ftW/HLdh4a+qIi/1IBKXTA6J1h5B8VmFEkOVTKWtyyGqTnt+jl/uS/xnvkoIoLr++QE0
         C2TLz8RnQYFgcFOyeN5NJ9MwTbgrBmoMD/eTq+h3za/i+3DBooKxJ1N40O+V4xauw5Xx
         h5izGTDUBRUtD1xDLCN27o/CQUzk4sYQfKYLqsLNKw+uzWn+bHtEvUoqOkzuVjqYfkqw
         DGQw==
X-Forwarded-Encrypted: i=1; AJvYcCXYJ1QH7qXW2z330Fx8eZgFhcRidOo8rE9otHy15vG0d2OkHEQ3wPJQrNCmnE4YC6BZEmdRcvTHmvJCt78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzakFApafGVGgYdp2BvXLgmbjEDEdOU9WAxxPfKfA1gGcDS4b
	m1GrXVs+4915i025tI/Ue/rErsDlizdSX8iKpqKcegCABhK9vKcLpOV1ipEJHmlFZqqevc8j/Me
	b2JgQi9r6YUFO6uOcT/lPcDiSWyeK2MkqyHuC
X-Gm-Gg: ASbGncsnENQlvMrB3mHyIrz7VWFzGlrrwvKigyo2peE8/AOKaQquhrwCacbfLuAcynD
	wHiv5w0rIKun6QplBBKYV035CXkWPBlyn+/MkyMHlCDLP7PxEx38sXGpHvdE=
X-Google-Smtp-Source: AGHT+IFSeXugZN7WIOwQr8YQLq8LU3bDv7Zj73/Xx2iLMaJeWot5Rr5Xvi0Wz4axw+70GUka05MUK/Yl5vgeFS0FbSQ=
X-Received: by 2002:a05:6830:6586:b0:715:7a24:32c6 with SMTP id
 46e09a7af769-71dcf6c2979mr910230a34.6.1733514804898; Fri, 06 Dec 2024
 11:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
 <20241206193309.3026213-1-jeffxu@google.com> <456abc34-9071-46f0-8c70-62377484dbf0@lucifer.local>
In-Reply-To: <456abc34-9071-46f0-8c70-62377484dbf0@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 6 Dec 2024 11:53:13 -0800
Message-ID: <CABi2SkUeALssNiEwcUHNQ7AUWY2UvScJmw4LJWo5+fV94_42Jg@mail.gmail.com>
Subject: Re: [PATCH] mseal: remove can_do_mseal
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, keescook@chromium.org, 
	pedro.falcato@gmail.com, rdunlap@infradead.org, Jeff Xu <jeffxu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:39=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Dec 06, 2024 at 07:33:09PM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > Hi Andrew,
> >
> > Is that possible to squash this change on top of
> > "mseal: move can_do_mseal to mseal.c" on the mm-unstable ?
> >
> > This is the first time I m doing this, because I saw dev did this befor=
e,
> > and saying this is the prefered approach.
> >
> > I could also send v2 which is what I usually do.
> >
> > Thanks
> > -Jeff
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Hi Jeff,
>
> Fix-patches and the like are usually for stuff that's been taken and this=
, I
> don't believe has (I might be wrong actually).
>
sure.

> But anyway, as a reviewer it's easier for me to deal with a v2 in this ca=
se, I
> am not going to give tags to the original version of this and want to mak=
e it
> explicit I am only giving them to the corrected version.
>
> So from my perspective could you do a favour and send as a v2 as it makes=
 my
> life easier anyway? :)
>
sure.

> Thanks, Lorenzo
>
> > ---
> >  mm/mseal.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index e167220a0bf0..08e6f328d9c7 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -225,9 +225,9 @@ int do_mseal(unsigned long start, size_t len_in, un=
signed long flags)
> >       unsigned long end;
> >       struct mm_struct *mm =3D current->mm;
> >
> > -     ret =3D can_do_mseal(flags);
> > -     if (ret)
> > -             return ret;
> > +     /* Verify flags not set. */
> > +     if (flags)
> > +             return -EINVAL;
> >
> >       start =3D untagged_addr(start);
> >       if (!PAGE_ALIGNED(start))
> > --
> > 2.47.0.338.g60cca15819-goog
> >

