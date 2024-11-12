Return-Path: <linux-kernel+bounces-404981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B31C9C4B5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3819AB29D85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 00:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CFD20262A;
	Tue, 12 Nov 2024 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m70/qMAx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5D200121;
	Tue, 12 Nov 2024 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731372856; cv=none; b=sqJhuZDLmzLE6HnLsqOByCVkoFBTUjcX+7s9mpMfBMR7QzXVemwtxtOVJAI8bIqtmCseRZtITPw6bUU/jNSjjXU1Xc24seEdBQBwRFy31JuXESxeaonhKBvOPM5XUyst8+7qLCDqqESEMRNFT7LHmnA3warSzFbjIBRejPh/IAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731372856; c=relaxed/simple;
	bh=Hu4dBsJ5xP62QvmuRPaX4UIwMs8WvQh2ETQ5nwFhdYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8kgmDzk6B2jGKYJaLfwUa1c81Ip9lrEeZPv+/H/2yYe156YA60WN18wLR3u8FoZvdLnM75KjFpKxxbaewnACcqijeSsyznqRU/uYPTuyCf/Cv671l9bhm3j3bvSw+nK/Wm1HhRu5isIjb6XdVKyipPldxCh/ASaEWh/foZFvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m70/qMAx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c77459558so46204515ad.0;
        Mon, 11 Nov 2024 16:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731372854; x=1731977654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMJJU2vS4YE3uBb6HCAG4zKl0VOV5PsAT/leQ4TNxnY=;
        b=m70/qMAxN0pqAqEZpsR6aywgqvwGAQPRLLdjUS2Msv26EsHRCv5g7EjgqxCXmLArWI
         5X1ZEJTSI5js5ceJCv+fNTvupAjcsHMWEjNwx4v6U7QyojsWwGNI/ErzJMLH04GWuLbp
         XHUokfuFB594b1Fb0JaEFUqw/tZVEm/GV9QTspb8hvmRxsLDz62ZkHTt9elbiJlqGCiz
         WKaX9w8a6uhy6K46bA0sJevwMQMlW2Z5oWxtvVo3YSvqwuy2P/qbSA+IhpZympint2hU
         QPIHOQ0QlVXtwtB5OfPf8DbehNcmRGFRFZrYwu1pchJVfwVdVdHl02hfDycpaRsNhY/f
         6c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731372854; x=1731977654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMJJU2vS4YE3uBb6HCAG4zKl0VOV5PsAT/leQ4TNxnY=;
        b=nndm32mdoc2+FoXRwHKkmua42GKktI+11QC3uwrRqukcfjGSETsmz36FWi1WK1ZnGi
         TR/lXYHnr/vLI67J1AuzP3UaROhovGNmmTbLiFNAQIrzAtJmgxvS6WAJSzgyad51jDEi
         0X0xeFFdK7GpDRHj1YaH+/UiIOH4/8+kNBpPa64/Dz0VrAKJEXbWlBsycJt6TW7EgrHq
         hb523S/aYALGlhWIVRbsCP0+G9vhrX18W7ZmWFzO0tCH9QrPic73Ns1It/wZoUMKZfmg
         A/Hmx+F+urm91Fx02xoCQZA21iEVTRn76t9L/Be7omfgndkh12XI00aVey/j83uF0Yyv
         IQdg==
X-Forwarded-Encrypted: i=1; AJvYcCUSHxE0YHzKxgc3bdpN/5e8tZye/uquOKuFxY8fezhqc8W5WGCzBWv3xVjn0rkU/0el7wH4Z2k2qB6ZFmVC@vger.kernel.org, AJvYcCUvdgMmPuXQy9kngrl7YbeahZXnQu/fi0vYbJ2N7hHcmk0B3lOctPCZiK8I3tP3KpKTKffTtOMpjtI=@vger.kernel.org, AJvYcCWeDQJFA3a+abZ6CxQZbtIUcpG/4Nd4Vt6iubuIjKwBhtfF0QHR8CU/vOkkMOVtEyMOj3JT08Hl0epveqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxTPiAGkSTC5Mz/Qh4c6fN6KXcsef9EWhTAyK9c2AcuYRulUm7
	xZUpx/0+5fzDrzL5lwjMYSFQP9lm+YqG025djF+E9F1PLyt/eJ8eWgmMDg==
X-Google-Smtp-Source: AGHT+IHwtTvUJoENTDvZnyT0YawUxXABmQ2LbUhLkDiDiIxOPrZJWzce2wnxYA2YuPw/FDUuB20eJQ==
X-Received: by 2002:a17:903:1d1:b0:211:18bf:e91d with SMTP id d9443c01a7336-211ab967356mr9016955ad.27.1731372853243;
        Mon, 11 Nov 2024 16:54:13 -0800 (PST)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e85419sm81493685ad.273.2024.11.11.16.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 16:54:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 889B24209E61; Tue, 12 Nov 2024 07:54:08 +0700 (WIB)
Date: Tue, 12 Nov 2024 07:54:08 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: anish kumar <yesanishhere@gmail.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH V4] Docs/sound: Update codec-to-codec documentation
Message-ID: <ZzKnMLe-L7bOe9Tw@archie.me>
References: <20241031211411.58726-1-yesanishhere@gmail.com>
 <ZyQ5OJM8k1rGog2R@archie.me>
 <CABCoZhCapQBCj=UJ78XWtzier5m34zX+bwSo4bPxEVkOdZSxRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YERgxwYtdic5yVS3"
Content-Disposition: inline
In-Reply-To: <CABCoZhCapQBCj=UJ78XWtzier5m34zX+bwSo4bPxEVkOdZSxRA@mail.gmail.com>


--YERgxwYtdic5yVS3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 01:30:12PM -0800, anish kumar wrote:
> On Thu, Oct 31, 2024 at 7:13=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.c=
om> wrote:
> >
> > On Thu, Oct 31, 2024 at 02:14:11PM -0700, anish kumar wrote:
> > > Updated documentation to provide more details
> > > for codec-to-codec connection especially around
> > > the scenarios and DAPM core details for C2C
> > > creation.
> > "Describe in more detail codec-to-codec connection, especially on
> > use cases and DAPM core details for C2C creation."
>=20
> Sorry, I like the way it is written.

What do you mean?

> > > +An ALSA-based audio system typically involves playback and capture
> > > +functionality, where users may require audio file playback through
> > > +speakers or recording from microphones. However, certain systems
> > > +necessitate audio data routing directly between components, such as =
FM
> > > +radio to speakers, without CPU involvement. For such scenarios, ASoC(
> > > +ALSA system on chip) provides a mechanism known as codec-to-codec (C=
2C)
> > "For such scenarios, ASoC (ALSA system on chip) ..."
> > > +connections, leveraging the Dynamic Audio Power Management (DAPM)
> > > +framework to facilitate direct data transfers between codecs.
> > > <snipped>...
> > > +To better understand the configuration inspired by the setup found in
> > > +``sound/soc/samsung/speyside.c``, here are several key points:
> > > +
> > > +1. The presence of ``c2c_params`` informs the DAPM core that the DAI=
 link
> > > +   represents a C2C connection.
> > > +
> > > +2. ``c2c_params`` can be an array, and ``num_c2c_params`` defines th=
e size
> > > +   of this array.
> > > +
> > > +3. If ``num_c2c_params`` is 1:
> > > +
> > > +   - The C2C DAI is configured with the provided ``snd_soc_pcm_strea=
m``
> > > +     parameters.
> > > +
> > > +4. If ``num_c2c_params`` is greater than 1:
> > > +
> > > +   - A kcontrol is created, allowing the user to select the index of=
 the
> > > +     ``c2c_params`` array to be used.
> >
> > I guess #3 and #4 can be combined, i.e. "If ``num_c2c_params`` is 1, ..=
=2E;
> > otherwise if ``num_c2c_params`` is greater than 1, ...".
>=20
> I like it this way.

Sorry again but what do you mean? Keep it as-is?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--YERgxwYtdic5yVS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZzKnMAAKCRD2uYlJVVFO
ox3aAP42LvxWgRueGN8dNrW4CyiGCTgJNqK0jlQeeYTNMWepiAEAg5Ft2kRDOEdo
D1PFBi3pkEiC/uYoFYMnH34xevlqDA0=
=YQyH
-----END PGP SIGNATURE-----

--YERgxwYtdic5yVS3--

