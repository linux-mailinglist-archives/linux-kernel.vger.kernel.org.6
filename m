Return-Path: <linux-kernel+bounces-318095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A066A96E84B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AB286664
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC638384;
	Fri,  6 Sep 2024 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPMsbbGH"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA22B1B969
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593728; cv=none; b=dTR6SKb2zdfIyqWuepBj9pFm5ivhwxz3EMZG7roBuZaDpODHQY1hrRtVT+NrlzDzzF3tzDHcADMOV2GNi1f5U5qQqpGDARRUPRsTsnax0VFI1H9XflsZq/WvtYBoDd8qcI+qPysWhzpaTt2L9FtodFrsA+oDlwQ9qpxF3kMAEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593728; c=relaxed/simple;
	bh=skzCl0pMNTyTvuDyqXvLLCvghbGETSY4Hcnpja4S17s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFpIfEYK64JrHpR4HlWBlxg5+yvS2p+G3kPYM4kl7EyB+ShXEFSBI7csIBAq+55s8ZYPMzLqxlL8Zfw2KzSOaE/4XYM7zw0czHKBh5DH5KDRw2yNmwhzOkd/Olw723wFhUhkpXgdtfJIYa/LxSGgUPw48USbxpQwQHELRvHzfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPMsbbGH; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f9e39c55so1097667a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725593726; x=1726198526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhuYj790wDLfRfrUaika0uMYzKXg4fII2xntIbGsGSs=;
        b=IPMsbbGHiCGjoOi7NshLv0x8VotkpPSX/Xc/My3fLlMxcb+AvWZGN1FeHMEBOyhfZ7
         PNa3W1ot2iHld6/FuNo6LNk4P2lP7DA1+sBMKWvHSIAI35d1k2l2xhtxbdwS4XvRL2Dl
         7hdPnuZzpjXXtLAo2KDzK8zgGOZ4txeSxcmVf6mO+TEkqabxi4/PmlLuWK8VdHfd7M0w
         7fG7i7pcLE+OhXuVGwV9FsWBCuCDGMCXtlQJn4TaGKYWBs586d9ijjtZCu4H1RnC4QCi
         RjUmm8ltpqPCnD2AnN/Py0ad1uBQD8A5Ifrxvja/MJ2Suizz+THXTg5b1C2IJg4wu6Uw
         o+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725593726; x=1726198526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IhuYj790wDLfRfrUaika0uMYzKXg4fII2xntIbGsGSs=;
        b=Qj8SSdHAXZVSS8/Bja1cmMomcxAiwwW+SoL6x7+PRaLmEJEQNSNWk3eigIQ1fl3wys
         0NF7net3bftp3fxelA4XVK3u5nj1N031McdN9bo84FgdJFJ0GEljM3f2FqGQPdAmTdVf
         lcZXnAFD9l3rebzthngGtcmQokpZOwyAB1evJLwI0mxEn4c+PWLJv0MCPR2rzonhUMuS
         gHZSceTGCXpr7VwqP2G5daUnXvvFww1Tbc7yUOf1JUFP6tG5OErYfKoyl43qywcZoo9S
         CMnnLqfOd2rwujPWmzz0A6HqXHfyCPh0gQi57Z+khtQRfGBwY+ly3Y4sFM67fr1+3wcC
         tZPw==
X-Forwarded-Encrypted: i=1; AJvYcCUJaZ9+9n1mRT7VI4sPC6aZsVfbsXgKBg5mFsDsOGwliCyj+UUOq0q9VNcNDYGMd2PNot1SAWcwxnwnNE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkM5+LbyQua9FdpPYJ1IxRRDDno8DGoGN/BGn7HUg7L/QoknA
	7mOAoSnmw8rtNshZeR1bmOwfVmnrhVz1W6l9uog4pHq17vzzrML6lJNxA0My+qVT5CLJXsQzHOF
	wSAYDLAFpNb5buH75L+wm8BXhcAY=
X-Google-Smtp-Source: AGHT+IFdboao3qNZkxuDUbHVJ4PM6zjbRZc22bL5X5Tp6/gOTzAoRIWcICCop5130io2oNLVIWOxQyb8NP8EamXmsj0=
X-Received: by 2002:a17:90b:384a:b0:2d8:b6a6:bc2b with SMTP id
 98e67ed59e1d1-2d8b6a6bffamr19518963a91.21.1725593725981; Thu, 05 Sep 2024
 20:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905095216.7888-1-wangyibo@uniontech.com> <50595531-87b0-4420-9624-948810066a6e@redhat.com>
In-Reply-To: <50595531-87b0-4420-9624-948810066a6e@redhat.com>
From: Lucien Wang <lcnwed@gmail.com>
Date: Fri, 6 Sep 2024 11:35:15 +0800
Message-ID: <CAHViUT1xrR5c4c9dbMOwO=dFGKFnxYZw8abpHa0hvkuTW-eX4g@mail.gmail.com>
Subject: Re: [PATCH] mm: move bad zone checking before getting it
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, trivial@kernel.org, 
	Wang Yibo <wangyibo@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.09.24 11:52, Wang Yibo wrote:
> > When flags from gfp_zone() has an error combination, VM_BUG_ON() should=
 firt know it before use it.
>
> s/firt/first/
>
> Please break long lines. (checkpatch.pl should have warned you)
>
> >
> > Signed-off-by: Wang Yibo <wangyibo@uniontech.com>
> > ---
> >   include/linux/gfp.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index f53f76e0b17e..ca61b2440ab3 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -133,10 +133,11 @@ static inline enum zone_type gfp_zone(gfp_t flags=
)
> >   {
> >       enum zone_type z;
> >       int bit =3D (__force int) (flags & GFP_ZONEMASK);
> > +     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
>
> Better use VM_WARN_ON_ONCE() instead while at it.
>
> >
> >       z =3D (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> >                                        ((1 << GFP_ZONES_SHIFT) - 1);
> > -     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > +
>
> Unrelated whitespace change.
>
> >       return z;
> >   }
> >
>
> But I don't see why we would want this change? It's not like the kernel
> would crash when calculating z.
>
> Or is there some change in behavior I am missing?

On Thu, Sep 5, 2024 at 9:13=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.09.24 12:48, Wang Yibo wrote:
> > When flags in gfp_zone() has an error combination,
> > VM_BUG_ON() should first know it before use it.
> >
> > Signed-off-by: Wang Yibo <wangyibo@uniontech.com>
> > ---
> >   include/linux/gfp.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index f53f76e0b17e..ca61b2440ab3 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -133,10 +133,11 @@ static inline enum zone_type gfp_zone(gfp_t flags=
)
> >   {
> >       enum zone_type z;
> >       int bit =3D (__force int) (flags & GFP_ZONEMASK);
> > +     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> >
> >       z =3D (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> >                                        ((1 << GFP_ZONES_SHIFT) - 1);
> > -     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > +
>
> I'm afraid you either missed half my review comments or your answer to
> my mail did not make it to my inbox.

I did not read your first email carefully,Sorry for that.
I will reply to your comments based on your last email.

>
> --
> Cheers,
>
> David / dhildenb
>

>
> --
> Cheers,
>
> David / dhildenb
>

