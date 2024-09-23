Return-Path: <linux-kernel+bounces-336032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E797EE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24BE282916
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0A80BFF;
	Mon, 23 Sep 2024 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1Z/9nV+"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855B1E515
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105748; cv=none; b=XLviOIk1rBvl41HRo/WwzqIOL3ZfPebUcLJrsGpaGupb5xjJUkpcWaHkN2WwKdZYgi8BstaweWaOQo/O6ua/XoxsJ7SR8H6h0bZI7jPcgiiNoNc9Z+b0pg3b1VhpGT6THPBoBDsLR4m4KKQoZlCt2rUVpXd5UEVcGwDl9xoNuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105748; c=relaxed/simple;
	bh=VRGPDRmB9nJi9jBl9qjzBZeAzQSekiWLYp2PNxF7UKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsOwKgfbZzujBmTPkO4zsv6Vz0VbvnZlIUzKVa+huNc9bGQ6ozq7kIOxseXMOgtVqVuoGk8/zsdnVjxdl/NGPVYK6DxIZQcAp/3jWvA7wiqstkJ2Fz6oPMJngokNcPSGFYHmJnMSOZnAeD1i4PbHvOUJZLZOqYLA4b2x7bSgb1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1Z/9nV+; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-846c5995a6fso1108593241.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727105745; x=1727710545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXrAGmFueWM5YytEy96ZiRUN6nOMakcrPk1l4nuEcQU=;
        b=S1Z/9nV+cc2hnPj9B4Ya7Vb0Im/VsKLtar9mXz25mYTvJD+sq+1WetH6hol2U7ZUbt
         Re0FI2jX4ZSfYy5RHl9jl4p0JIlIvyjq78eiNoR10o0iinZfvG4CLmJE9/HnP+E3dVyr
         vipmiy+9Mp3/DvXfqaPZQmdkazCmPxuAqmBkRjaodEt8Ipp2NvLCPZQr2/dJgw275boX
         AG2L9HI6UliDmiyIu6V+id7K+mKQDR6UWEmnN1Pp4YnQ/QUYKxoaOggroMmV3gimpQfb
         dxsN7T9hspDqSQ49gKqOsgFhinxVuKkwZkzg5H2M3rESrg7q2wR1P0YxTMb5zp8eeB6j
         0y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105745; x=1727710545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXrAGmFueWM5YytEy96ZiRUN6nOMakcrPk1l4nuEcQU=;
        b=WyFo8+sgjNGHqwBeAFNfT1746TBVUzeniWI5zXnMUK9Qdvw0+OzNGZECzPlsDPpr3q
         cz0SyQ75uMmKLUhMPn+wP139yIF6bcwFS7ryImpOA4jTD6PCl7YZhAtTNGz7wMt2rK53
         t0JWgCBr/nC2x4jq1KwTj6i6pfFFMkARYNAf2cUT6V1s1LY3togGPJbgmNLpL0RZUhpP
         PMK6QYYpTCUoOQkkxCpFIcN2kXhfeWajNlIZ1k2BJUnKOg7488vVGunRKJZYgv+aEfU+
         U6xlGLJpvLn7SsBEIGh8NLyqP2/wZM/nL9Y+841hbOBnPFzHG8IBT9iqu7Se2hyL/y5S
         H03A==
X-Forwarded-Encrypted: i=1; AJvYcCWVV4xKxtSZEhNckXgXl74aBk4+rN+ixv3LhKvRWeqPHGkACObm5YzUS0ke0Saj8BVYrvJMVVYsHOL6C48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eb3vE9nj77nAXaB5OIHe5VJeILhaIt8+Z8t0HuNy4sHJtAjj
	Hd7mCry8XqLoBQ9tdUTGTcTfMmaGUgBgBGtxMGebBqzWG1QAqSSJjHTwXRcqGmdDE/a0A8AhTYz
	wfMu8lRuJbGwdFyA1I3DQvxGnYUw=
X-Google-Smtp-Source: AGHT+IH9GQKnphCafHZMSRLrNhU3B8R/CoHeOdgwljGfcKMJcggbdT0zd3vFgDwFtBc1mBUQSl61BnRO+IQRsxxjE6c=
X-Received: by 2002:a05:6122:1692:b0:4f3:828:7a47 with SMTP id
 71dfb90a1353d-503e045928dmr7393256e0c.6.1727105745277; Mon, 23 Sep 2024
 08:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922164702.49615-1-kdipendra88@gmail.com> <CAAYit8TfBD40aRchLiOWsvqwpAR0x6nW9zObza4vLVzg93N+eA@mail.gmail.com>
 <87139a89-4256-fceb-5ca2-c1077b036eef@redhat.com>
In-Reply-To: <87139a89-4256-fceb-5ca2-c1077b036eef@redhat.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 21:20:33 +0545
Message-ID: <CAEKBCKMv4-dhWU=a2UnX2rBcQjVTJcF+wg6z6f3qtjA4td-62Q@mail.gmail.com>
Subject: Re: [PATCH] Return error code for failure input for sscanf in parse_cblock_range()
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ming-Hung Tsai <mingnus@gmail.com>, agk@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 23 Sept 2024 at 20:55, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Mon, 23 Sep 2024, Ming-Hung Tsai wrote:
>
> > On Mon, Sep 23, 2024 at 12:47=E2=80=AFAM Dipendra Khadka <kdipendra88@g=
mail.com> wrote:
> > >
> > > Smatch reported following:
> > > '''
> > > drivers/md/dm-cache-target.c:3204 parse_cblock_range() warn: sscanf d=
oesn't return error codes
> > > drivers/md/dm-cache-target.c:3217 parse_cblock_range() warn: sscanf d=
oesn't return error codes
> > > '''
> > >
> > > Since, the only negative value that is returned by sscanf is -1.
> > > Returning -ENVAL when sscanf returns -1.
> > >
> > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > > ---
> > >  drivers/md/dm-cache-target.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-targe=
t.c
> > > index 17f0fab1e254..c35d65e310d6 100644
> > > --- a/drivers/md/dm-cache-target.c
> > > +++ b/drivers/md/dm-cache-target.c
> > > @@ -3200,8 +3200,8 @@ static int parse_cblock_range(struct cache *cac=
he, const char *str,
> > >          * Try and parse form (ii) first.
> > >          */
> > >         r =3D sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
> > > -       if (r < 0)
> > > -               return r;
> > > +       if (r =3D=3D -1)
> > > +               return -EINVAL;
> > >
> > >         if (r =3D=3D 2) {
> > >                 result->begin =3D to_cblock(b);
> > > @@ -3213,8 +3213,8 @@ static int parse_cblock_range(struct cache *cac=
he, const char *str,
> > >          * That didn't work, try form (i).
> > >          */
> > >         r =3D sscanf(str, "%llu%c", &b, &dummy);
> > > -       if (r < 0)
> > > -               return r;
> > > +       if (r =3D=3D -1)
> > > +               return -EINVAL;
> > >
> > >         if (r =3D=3D 1) {
> > >                 result->begin =3D to_cblock(b);
> >
> >
> > Could you please clarify how to reproduce unexpected results? From
> > what I observe, the kernel's sscanf doesn't return -1 on an empty
> > input. Even if a negative value other than -EINVAL is returned, it is
> > handled by the callers.
> >
> > Hank
>
> I applied the patch, but I deleted the conditions "if (r =3D=3D -1) retur=
n
> -EINVAL;"
>
> sscanf in the kernel doesn't return negative numbers.
>

Do I have to send v2 with
if (r !=3D 2)
 return -EINVAL;

or what should I do now?
> Mikulas

Best Regards,
Dipendra

