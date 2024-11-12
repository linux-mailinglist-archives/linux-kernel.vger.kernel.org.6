Return-Path: <linux-kernel+bounces-405001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A40919C4B98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D94B1F238F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF4B204936;
	Tue, 12 Nov 2024 01:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGjE8eYm"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684332010E3;
	Tue, 12 Nov 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374294; cv=none; b=F1nIZb2374LtZyFMWGrLM0oZoXHfLtWsy0d2MQ2uhFU46GS78kNX6CScUXA6IZrilE6cHA1D4q/o1eJFskiKHM6Q/yDyCnqC9/xSBs+oHaEsXwj1mepIowSHCRGCalUGXeSci1D6z+DN9YRAEINHTGA5UI+YvaNXccFsz/i1HwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374294; c=relaxed/simple;
	bh=t13VTO4fFyiMFGbz+q+sUUKDddqPat8+PPWtPUpS8M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwiW+3+OuVgDNTK/0Nmopf2ZO3fbBQ94wo8gkRgZbM1i7oVQURLmQKTFJp8hafsOJbYSmJRCwj0u7mZjPQu0Cvl4X7aHaWbBwUo/fH9aeEww6SuIocd/Dbveu+zJolFCXZaKhjKwhnaXysns00CAxzjusOg2tFUC+WDbsH1vd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGjE8eYm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso37288261fa.3;
        Mon, 11 Nov 2024 17:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731374290; x=1731979090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3x1XD5BHJdM36ghcfeo4S6goN5EOgmQYPBVkMxbxS4=;
        b=KGjE8eYmlE/R0ReGAiYZX3vZmZdur+ZXhGiZITMz8A1VyM3Z2/esQen/KMRHKLAby5
         FnRqrRZqY1MY8gbp6JxVeoSkJi576O4vHXW9A8l7HflqlNPbujkEbTjhTmtCG3yDRXHn
         18VL+PteHKzBpyUnHcMmaBEf3mn9jNf6XWXmI6NjFwI0SXpUG6B5eSlNEhBo4Iy1cwAY
         X+3V6v75eScNbfgjaOZrKtuDWHBoq4Is1SumtHdhdqqNKTjWgwAZ0tHVTcPG57QKONXk
         6r8WlCRhTs8Km9jCQ2PCMwAdy/FTRIMNm2qfrKA67aG9nNTyQH/Ka10q+Z+H5fncSPu7
         fZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731374290; x=1731979090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3x1XD5BHJdM36ghcfeo4S6goN5EOgmQYPBVkMxbxS4=;
        b=e+6QEFQmN54mcCzaQozujfRdHfTQ5Ym/HmOEKGi1HlK0TC4ALNDQK/UalSnHJ8iUDO
         jEaofRCLlmVSGaUhqBGDEZx8cwjJ2wcFd65VCtmOvamWkndCLSYPDw/P3IgAMiVSe6xv
         ZyFi8+LIZF3qqXB0UkhlH4WFYrUChePUglc9Q1mP/wXBp4KPSxTPIDpN7nK17l3H2Rjb
         8LhuEJsOi8r7lFCYXx+hekdBWBreFwFrNAw/AhXwQ8mm3GiAnIOOaDExKXkuGOn/Fc20
         HzzW5mSRXP5ZUhdJFYXVgx4cuaN/KOQioA1Ri9InciXIA8/ANI0nIdak9c6yp1Zx9lxX
         0IMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD0P31gb1f0jZubB/5+qF/RqSd96w7pAN7DcIzdFzJG0g+TVAlpaRGfKdJocI30wUR22B9xOTRwgjMtLXg@vger.kernel.org, AJvYcCUaz9L9dEJKp3iDyitOg57aPAfoFPy8b5x3Yip2l2G34MV2BNuhrL03guGMw/jHDL63Oj6bwJsIHPY=@vger.kernel.org, AJvYcCUykP+u9Gb/tYYce/2VTDz3oAeypCDo1xVPCL+4MJgMd/4c8NUqHrnLU49rsNe7ASgn7/lyXlU2aesvcdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHSY29EqUJQclqz8R5u8lbqgeuUVpWUkm8Eo4VgAmf7w1iCf6
	HrG0v98cx0AR1h7aPFPJ/D4mAOWyYWWjgvlo8/6mrpEyqO/HKZgmj/uwnx2hHDqrEgfCi/41KPA
	HplebkE9UcfmtvmA63Q8V6yxpEWsVAaIeZZ0=
X-Google-Smtp-Source: AGHT+IEwmboXLYvo02CMnnfmlr/DRNkR3zFp3GjNXL5pQnbWlS6gXAv2UwZYAn/D0Ru9vsEvZRK1Oo4bidFSWEiW98I=
X-Received: by 2002:a05:651c:88a:b0:2fb:5014:c939 with SMTP id
 38308e7fff4ca-2ff42750f6bmr3074981fa.41.1731374290279; Mon, 11 Nov 2024
 17:18:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031211411.58726-1-yesanishhere@gmail.com>
 <ZyQ5OJM8k1rGog2R@archie.me> <CABCoZhCapQBCj=UJ78XWtzier5m34zX+bwSo4bPxEVkOdZSxRA@mail.gmail.com>
 <ZzKnMLe-L7bOe9Tw@archie.me>
In-Reply-To: <ZzKnMLe-L7bOe9Tw@archie.me>
From: anish kumar <yesanishhere@gmail.com>
Date: Mon, 11 Nov 2024 17:17:58 -0800
Message-ID: <CABCoZhC5w-uUgmsqb_m2t98NF5oftuoDTThvthoRK8m97bM+MA@mail.gmail.com>
Subject: Re: [PATCH V4] Docs/sound: Update codec-to-codec documentation
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	corbet@lwn.net, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:54=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Sun, Nov 10, 2024 at 01:30:12PM -0800, anish kumar wrote:
> > On Thu, Oct 31, 2024 at 7:13=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail=
.com> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 02:14:11PM -0700, anish kumar wrote:
> > > > Updated documentation to provide more details
> > > > for codec-to-codec connection especially around
> > > > the scenarios and DAPM core details for C2C
> > > > creation.
> > > "Describe in more detail codec-to-codec connection, especially on
> > > use cases and DAPM core details for C2C creation."
> >
> > Sorry, I like the way it is written.
>
> What do you mean?
>
> > > > +An ALSA-based audio system typically involves playback and capture
> > > > +functionality, where users may require audio file playback through
> > > > +speakers or recording from microphones. However, certain systems
> > > > +necessitate audio data routing directly between components, such a=
s FM
> > > > +radio to speakers, without CPU involvement. For such scenarios, AS=
oC(
> > > > +ALSA system on chip) provides a mechanism known as codec-to-codec =
(C2C)
> > > "For such scenarios, ASoC (ALSA system on chip) ..."
> > > > +connections, leveraging the Dynamic Audio Power Management (DAPM)
> > > > +framework to facilitate direct data transfers between codecs.
> > > > <snipped>...
> > > > +To better understand the configuration inspired by the setup found=
 in
> > > > +``sound/soc/samsung/speyside.c``, here are several key points:
> > > > +
> > > > +1. The presence of ``c2c_params`` informs the DAPM core that the D=
AI link
> > > > +   represents a C2C connection.
> > > > +
> > > > +2. ``c2c_params`` can be an array, and ``num_c2c_params`` defines =
the size
> > > > +   of this array.
> > > > +
> > > > +3. If ``num_c2c_params`` is 1:
> > > > +
> > > > +   - The C2C DAI is configured with the provided ``snd_soc_pcm_str=
eam``
> > > > +     parameters.
> > > > +
> > > > +4. If ``num_c2c_params`` is greater than 1:
> > > > +
> > > > +   - A kcontrol is created, allowing the user to select the index =
of the
> > > > +     ``c2c_params`` array to be used.
> > >
> > > I guess #3 and #4 can be combined, i.e. "If ``num_c2c_params`` is 1, =
...;
> > > otherwise if ``num_c2c_params`` is greater than 1, ...".
> >
> > I like it this way.
>
> Sorry again but what do you mean? Keep it as-is?

Yes it is more developer friendly.
>
> Confused...
>
> --
> An old man doll... just what I always wanted! - Clara

