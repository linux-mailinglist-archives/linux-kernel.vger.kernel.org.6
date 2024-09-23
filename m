Return-Path: <linux-kernel+bounces-336080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D297EEDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563F91F21E33
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648019E96A;
	Mon, 23 Sep 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHBjyNNW"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B100577107
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107562; cv=none; b=C4P3dJrAVJ1VhI8A1Ef9gjvIx3UA/fjAH39z9aPh9+BMjwenneeq76NFwHA64NrX5UHR0GT1ia248LbIVvAnUDByLiJxuZbsNa9QYgbEbbyrOfmIK6YOjrJzdmnpV/WRZjS0WVx0lmSLYW5bT194+z5VdDVn+T2+dJngrtt+45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107562; c=relaxed/simple;
	bh=B6nj2YLT4D/wlqqzFmJa2BxfrWUGYUdzA6f5p6Tagew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNjNemt4FdwMePVMDBHXjWeSFzxSo0HpfMoDLlMWuv5qGgu+AhEomXeMmzNDbAfPdxpnvcEdEvCX60GIE0vp/t6qUDy6Z0iyEiJ39LhRF2RdeHVV99qqHpI7W0YsXujO/qGNnjgFq3ExAgAXyWM3SVwBlb5W6FrKr8JxovK73hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHBjyNNW; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-502bb7cc965so970838e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727107559; x=1727712359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjP2FVA9GyHqcqrVlHf4sMId3XeNp2zxUyT00XEy7YQ=;
        b=NHBjyNNWMlqd2f1oaFvmE4JdMVFapLrK6hpBu7IvEnOylosxtiDPHZC11tk2mfry+d
         WUmpXoxtbA3ilL8GQDK1nX/UQm5Sh4wQMQmfOuiQkVQDH+KOIpzzNvUFvVE+YbHTrrhi
         IdV96rcuRH/oyVscUTXN0sFqjeGoxSU3HVxszfmCiFWr+8hC7NTojEPdGI5/U9AedRYc
         itOMtSeeWFWvLafUDJhJ7hJ210LWmXmaUjMTm0YCvSjnQc47gLTVqKWysL3tnVdSJLnC
         8IBzl/7THGlcFdpJEayI4KPvIbimyBLnkyFyi85xSv6eK5b0Y+f6knPl4WiFrF5pI9yf
         nnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107559; x=1727712359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjP2FVA9GyHqcqrVlHf4sMId3XeNp2zxUyT00XEy7YQ=;
        b=VpdSNRoAZyUoHtxSA2ong6HeuKEXqwIbyXZsREXTSImqSMofrCyWvbfCKBDVkWtKZJ
         tK6xkkVRVg5xiGJbZiRDvVdcX8waVwxlDbNf8t1cXsCglgaH9LZfQF1qtJxmhQ0UnbDY
         W6Pausm5/cVP8eWvzajSzpQ8vtARUiJOPOtoPdC+7IYJbujMVNTsnHNpnGc8eBCtzTKa
         uV6gAzuOyTkYXlr1jo6dhg4bLOkxotxrqmwHsnlkOCaeTOxdpfcWmD1liizm1E3of26F
         UM8xSG0BsRDo9gWQHd5SKV6RN83sDF6ao+S43PcMmW6tsu99/Xts+7LIBMQBAwplgOAl
         C+dw==
X-Forwarded-Encrypted: i=1; AJvYcCUQe7S4DW5Z6wphmDB9bZo0Z4k230x/tbkIgNpxJWKIdei0u+Qp866GE1MQnLZBNaVTObnByevaiVlQ1Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhINWJZUd7tZjPWpJljAB1bFe2UClMH+jVrq0fg8dbFF9YbJ8V
	DyU8YYifstqFfgnEZAxElvF381CjBiBYfmkHaFg+l5iO7p0AABx3uyIHDXswit//J16gtqkKq1R
	sLmr2cnejEPWBD7pXponll/lJldY=
X-Google-Smtp-Source: AGHT+IEUg2zXAfe1tkR8PdEPwTh7fron36ChAGsRCD55XcwH8aCFU7+yHgfNiQZvwn9eMgeSstUj4zvz+ZqjMe7+aGA=
X-Received: by 2002:a05:6122:907:b0:4f5:2c0c:8528 with SMTP id
 71dfb90a1353d-503e05501f1mr7220010e0c.11.1727107559294; Mon, 23 Sep 2024
 09:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922164702.49615-1-kdipendra88@gmail.com> <CAAYit8TfBD40aRchLiOWsvqwpAR0x6nW9zObza4vLVzg93N+eA@mail.gmail.com>
 <87139a89-4256-fceb-5ca2-c1077b036eef@redhat.com> <CAEKBCKMv4-dhWU=a2UnX2rBcQjVTJcF+wg6z6f3qtjA4td-62Q@mail.gmail.com>
 <28e1f99d-eb8e-2357-0afb-a9bb0d5b0a06@redhat.com>
In-Reply-To: <28e1f99d-eb8e-2357-0afb-a9bb0d5b0a06@redhat.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 21:50:47 +0545
Message-ID: <CAEKBCKOOm1UETLTgONr=eG8GY1MLkKdG_G=o8Wh0y1079Q1MeQ@mail.gmail.com>
Subject: Re: [PATCH] Return error code for failure input for sscanf in parse_cblock_range()
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Ming-Hung Tsai <mingnus@gmail.com>, agk@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Sept 2024 at 21:45, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Mon, 23 Sep 2024, Dipendra Khadka wrote:
>
> > Hi,
> >
> > On Mon, 23 Sept 2024 at 20:55, Mikulas Patocka <mpatocka@redhat.com> wr=
ote:
> > >
> > >
> > >
> > > On Mon, 23 Sep 2024, Ming-Hung Tsai wrote:
> > >
> > > > On Mon, Sep 23, 2024 at 12:47=E2=80=AFAM Dipendra Khadka <kdipendra=
88@gmail.com> wrote:
> > > > >
> > > > > Smatch reported following:
> > > > > '''
> > > > > drivers/md/dm-cache-target.c:3204 parse_cblock_range() warn: ssca=
nf doesn't return error codes
> > > > > drivers/md/dm-cache-target.c:3217 parse_cblock_range() warn: ssca=
nf doesn't return error codes
> > > > > '''
> > > > >
> > > > > Since, the only negative value that is returned by sscanf is -1.
> > > > > Returning -ENVAL when sscanf returns -1.
> > > > >
> > > > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > > > > ---
> > > > >  drivers/md/dm-cache-target.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-t=
arget.c
> > > > > index 17f0fab1e254..c35d65e310d6 100644
> > > > > --- a/drivers/md/dm-cache-target.c
> > > > > +++ b/drivers/md/dm-cache-target.c
> > > > > @@ -3200,8 +3200,8 @@ static int parse_cblock_range(struct cache =
*cache, const char *str,
> > > > >          * Try and parse form (ii) first.
> > > > >          */
> > > > >         r =3D sscanf(str, "%llu-%llu%c", &b, &e, &dummy);
> > > > > -       if (r < 0)
> > > > > -               return r;
> > > > > +       if (r =3D=3D -1)
> > > > > +               return -EINVAL;
> > > > >
> > > > >         if (r =3D=3D 2) {
> > > > >                 result->begin =3D to_cblock(b);
> > > > > @@ -3213,8 +3213,8 @@ static int parse_cblock_range(struct cache =
*cache, const char *str,
> > > > >          * That didn't work, try form (i).
> > > > >          */
> > > > >         r =3D sscanf(str, "%llu%c", &b, &dummy);
> > > > > -       if (r < 0)
> > > > > -               return r;
> > > > > +       if (r =3D=3D -1)
> > > > > +               return -EINVAL;
> > > > >
> > > > >         if (r =3D=3D 1) {
> > > > >                 result->begin =3D to_cblock(b);
> > > >
> > > >
> > > > Could you please clarify how to reproduce unexpected results? From
> > > > what I observe, the kernel's sscanf doesn't return -1 on an empty
> > > > input. Even if a negative value other than -EINVAL is returned, it =
is
> > > > handled by the callers.
> > > >
> > > > Hank
> > >
> > > I applied the patch, but I deleted the conditions "if (r =3D=3D -1) r=
eturn
> > > -EINVAL;"
> > >
> > > sscanf in the kernel doesn't return negative numbers.
> > >
> >
> > Do I have to send v2 with
> > if (r !=3D 2)
> >  return -EINVAL;
> >
> > or what should I do now?
> > > Mikulas
> >
> > Best Regards,
> > Dipendra
>
> You can do nothing :)
>
> I fixed the patch and I'll send it to Linus in this merge window.
>

Oh, ok. Thank you for your time.

> Mikulas

Best Regards,
Dipendra.

