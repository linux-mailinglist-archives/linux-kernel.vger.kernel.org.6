Return-Path: <linux-kernel+bounces-403380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83369C34C7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F4D1F2117D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E72156880;
	Sun, 10 Nov 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isISRmHw"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9518E1F;
	Sun, 10 Nov 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731274227; cv=none; b=IJLbMgwKRZo7qjP5Tgq8mqUz9ACLFjDLOv183FWqWq8U0jnqyn0+q+gKA3jzlVngCqYbJFC1QXFNq0Mr3nvfhVbPLgdtolnI6YhNUUZ0Di9hBHU1uy+R0zRwsbt9b48WRz4puQ24kI7nqmHu8NiSkSw8yieHUDGOELjQTr+dkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731274227; c=relaxed/simple;
	bh=NAp6CJ5kYLjJB1R58kJpoIq4+i44S3eM82Tj+brt4SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxWN7SPuzWb8XWk9whRogCqQbhzuCcKY6KJ987dj9XRVRrT20UAlrc917CkYZVrZm6sOTZo3R+rS6gfUdqP9ZCz843MXJttAB54LPaNHMhQaAylvQtaKM4jylljLdiATdBrtZG31KvkLIvav7zei7blFjwhZZJBS8hh10R+5PkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isISRmHw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso49199501fa.3;
        Sun, 10 Nov 2024 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731274224; x=1731879024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN4q1YU72uIu7Vmji1epheMoLR4ByHXyKn9kCj69B2I=;
        b=isISRmHwM6KS5jp9Hi/wIbb64YCxn6nKjW/V0BB/SRGCB6DaUfefbZBpwbHMWbRj3P
         rp29IhyVdZy2iEvSxwGSlcaNUWjcoV5LNh4Xo1j3yO313iuhdcOvaNkCPF1EOUMn2HbN
         DcNu1agBHaXzypoogwjW1VZgfpHV7wzLd2hEb5gvSp/GHNsQPu8DEJgvhrBrBxgCotk5
         LY3ErnIXzvKvl7TvBhLSzVVvZ/LRq2FHceOPJagpHqMd+N0wcgB126N3co2cNHiMHP3j
         XIxJIFvvrEw8nOdTKbqX7qxRiOwEbaZG0cqAMHQNneOJ7ArH/+OliYvH8WQbNHGpsC6Q
         OaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731274224; x=1731879024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN4q1YU72uIu7Vmji1epheMoLR4ByHXyKn9kCj69B2I=;
        b=Q4S5Yeni9JV6qwpyr1+fNXLM0KjnMbV3HKWYzoL+0oHweuOJ78NuQApTf6LlS+jqv6
         fW6kwsDyKmFO46NtGqNOxhiZArnjYBZ9sZne13hucH31EyWLlqteXlcQ8nj1BYzT3kXY
         a/1COpw9VSPdVJ1UIrC19kGirzdliJMMXxXw0BUZTOwua/CXYinPY/np5Kn6mylGpA3d
         U7mi2DffSV1R9PDGVqlO6kYXZzpoc0Uu5gQkDhlFsnjRovDxRE0ayPR2AdS1H3Sg6FSi
         aw4t18+zyoh0nyUoPnqgsnUMV8df5BwiVrbKYvWdvGEaWZDubXL9VkMdZ0rsNsuxyKM6
         h8/A==
X-Forwarded-Encrypted: i=1; AJvYcCVNBlAln2IDURZTifn28rGGajqnkX7V0J4MJFh2Si8iqy52VCiSGqQMvn9a7B9QTCKhnDi5ayusxpc=@vger.kernel.org, AJvYcCVVxwvuev3fiv/nxBw4nnJTpcYGzB9Z0Di2cRvfA3wMVdpzlpz6E55drZh9PELbJSNc6sr6WWJywfUijPa/@vger.kernel.org, AJvYcCXVnuWCJMuRYVz0tiZylR9aPfkAjx/FV3BTMVXIjWpDnCMeRN9feVumTWM4FjzeswMJWeQb4XTg5EUmVGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDUpEMAKf2BA93mvpyCs4tGshRrA67K4SydetAF4GtRBI+olGO
	bMmc2QAH/Md4dHEXMh6+nIzjtazjv0RUcvu3y+a8EJZMFs52MPhrrCdlCBVx3uPLp9I5WJYlOah
	CgyroMNmAQCPUdHLUKNYrgM1ta2+y+v5M
X-Google-Smtp-Source: AGHT+IEB2c2gTPIdbZH8GDNnzG26Sq467ivd/3rexJAdoaplRtu5vvNVFuVF/GAXr2SjBdDhMHc6p+uu+GkwSHskI/Q=
X-Received: by 2002:a05:6512:15a4:b0:53b:1508:468d with SMTP id
 2adb3069b0e04-53d862f82a5mr5909824e87.54.1731274223384; Sun, 10 Nov 2024
 13:30:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031211411.58726-1-yesanishhere@gmail.com> <ZyQ5OJM8k1rGog2R@archie.me>
In-Reply-To: <ZyQ5OJM8k1rGog2R@archie.me>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 13:30:12 -0800
Message-ID: <CABCoZhCapQBCj=UJ78XWtzier5m34zX+bwSo4bPxEVkOdZSxRA@mail.gmail.com>
Subject: Re: [PATCH V4] Docs/sound: Update codec-to-codec documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 7:13=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Thu, Oct 31, 2024 at 02:14:11PM -0700, anish kumar wrote:
> > Updated documentation to provide more details
> > for codec-to-codec connection especially around
> > the scenarios and DAPM core details for C2C
> > creation.
> "Describe in more detail codec-to-codec connection, especially on
> use cases and DAPM core details for C2C creation."

Sorry, I like the way it is written.
> > +An ALSA-based audio system typically involves playback and capture
> > +functionality, where users may require audio file playback through
> > +speakers or recording from microphones. However, certain systems
> > +necessitate audio data routing directly between components, such as FM
> > +radio to speakers, without CPU involvement. For such scenarios, ASoC(
> > +ALSA system on chip) provides a mechanism known as codec-to-codec (C2C=
)
> "For such scenarios, ASoC (ALSA system on chip) ..."
> > +connections, leveraging the Dynamic Audio Power Management (DAPM)
> > +framework to facilitate direct data transfers between codecs.
> > <snipped>...
> > +To better understand the configuration inspired by the setup found in
> > +``sound/soc/samsung/speyside.c``, here are several key points:
> > +
> > +1. The presence of ``c2c_params`` informs the DAPM core that the DAI l=
ink
> > +   represents a C2C connection.
> > +
> > +2. ``c2c_params`` can be an array, and ``num_c2c_params`` defines the =
size
> > +   of this array.
> > +
> > +3. If ``num_c2c_params`` is 1:
> > +
> > +   - The C2C DAI is configured with the provided ``snd_soc_pcm_stream`=
`
> > +     parameters.
> > +
> > +4. If ``num_c2c_params`` is greater than 1:
> > +
> > +   - A kcontrol is created, allowing the user to select the index of t=
he
> > +     ``c2c_params`` array to be used.
>
> I guess #3 and #4 can be combined, i.e. "If ``num_c2c_params`` is 1, ...;
> otherwise if ``num_c2c_params`` is greater than 1, ...".

I like it this way.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

