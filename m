Return-Path: <linux-kernel+bounces-317500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7A096DF2C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDD41C22FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1282119F49E;
	Thu,  5 Sep 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VsAVtQ4l"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B329B1A00CF
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552480; cv=none; b=CkNyeMrCK6q0hUGCqDvR24Y8kMC1061apoQhhsV4ccEaDv3W36xphVKYP5hNCBOIRl8DCKzm3Hz91ljh+oZfPKUIGoQNUdcA1pA8/VKfvfm4n343HeFHwuSBv6RKrpQe6Szm0NYbPQlp0KYb7gNlRQcUlt4XFzA8eJNO0pnx1hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552480; c=relaxed/simple;
	bh=4+V/2/69Oekf/IqJLJkJMCGq+BYCH2b4UrGiPsgeqgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHZ5vWpRGqGg6ezgnOim4g8kbroDu5WjRyWgXpXZzK7XpR7gwfAeZO82dUKoqjpgYIzA5w46aqfosLEWDpDG4tRls8UCdozJCdo1mAUY+tyRd38aY1rIC06u1o7NUWY/xljGBIzUw7loa38+huWjto9HMUkv+LwUSK66TtmCh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VsAVtQ4l; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3cdbe4728so1027091a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725552477; x=1726157277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+V/2/69Oekf/IqJLJkJMCGq+BYCH2b4UrGiPsgeqgg=;
        b=VsAVtQ4lG1heGJ7DNLeQqrhr8BylAXrgUmMH5O/tjvPkSkh6yUYPpLgzCbhDsb8w1J
         iJFR9gr50BS4ZChqo4pud89I4uDz5RlWEMKlYqxDPAbNI8mO9o1Xj8njU/SCjyX8Mw7J
         yWFdEnZuOdt+OoK2NWwWEd8ap4bZlRJi4ZxHoZNLIR1tzszQt7hlp4ZgiLe0bVylcLsW
         YZFRH2KaefnWYSBA4zjmT96mFDzzjU1o4VIe7v5UeLkxsn2g4oNNBCL8EXwL/rtRYE57
         8p0sZUOxoUhS6ZXZUx6pUrrXCv+1sJnpGYVQy1XtvJL8H3eqw4R4s6hP/zzWhV7opwEh
         nv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552477; x=1726157277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+V/2/69Oekf/IqJLJkJMCGq+BYCH2b4UrGiPsgeqgg=;
        b=vWZIEIv/7wqWKNoW8DTtUmRg9kEAvUO8Ws5UjCMxt1ZHAg+77UOzbJQShZs98CKBar
         s32RygmNRFVxDWCi1lEmRxvDNFkeQufiTJadicqjOGRu2upd0xAmwMWShhSVxAPQgTdP
         olqkd9p/JdqYdTisjm53nmqw7cyQstwFghQQry6XGwe3zo6/isKa0OV8d5MpRkiX4m4d
         yjFUF4iGQTL1GKlltyb3DHlUA9NXXVaCrD0+E+RJ2cVdxAlG7ufmzrGLlZ6q00RRmix8
         R//9PcNO4EfscN0/RLqXi2EjOZqrt1uvgPsetkDZnM/VSVRPzp1bp3HcXPDzkGd3xCpU
         /edQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdWpR8VFGv9ju3t5EIgff4SOOHE1w+CDQ/bxaozWDQgye7Hs2XlV14z5EClSceWCi4DNOUYdbpmwInj1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKhphjIxYYlEaVByqTrAsAj3oIINVLfsuXwZeanxcsx4SUlz56
	4tLA4Lhn2mc2eACw2GzKLAUlSTbsNPBr2aABsY3ySv5LA/D+yk+4sRokeRlNJgo=
X-Google-Smtp-Source: AGHT+IH+yeZQhRsD9G65BjoujdjesMoaUAknZULkhtESsyPwnLRQdSEaHjaNYNJRShPfhk7+5tEtsw==
X-Received: by 2002:a50:c943:0:b0:5c0:b793:df4e with SMTP id 4fb4d7f45d1cf-5c21ed52c88mr16699830a12.22.1725552476740;
        Thu, 05 Sep 2024 09:07:56 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc528bcfsm1405056a12.16.2024.09.05.09.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 09:07:56 -0700 (PDT)
Date: Thu, 5 Sep 2024 18:07:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: axi-pwmgen: use shared macro for version reg
Message-ID: <hurwsgglzhipxkehkefopiw7ujfbnowbprkqdc3hyxlwp3qhud@a22jwhzfp6z5>
References: <20240816-pwm-axi-pwmgen-use-shared-macro-v1-1-994153ebc3a7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5kiyyqgcuiwe4rb"
Content-Disposition: inline
In-Reply-To: <20240816-pwm-axi-pwmgen-use-shared-macro-v1-1-994153ebc3a7@baylibre.com>


--r5kiyyqgcuiwe4rb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Aug 16, 2024 at 12:30:58PM -0500, David Lechner wrote:
> The linux/fpga/adi-axi-common.h header already defines a macro for the
> version register offset. Use this macro in the axi-pwmgen driver instead
> of defining it again.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Thanks
Uwe

--r5kiyyqgcuiwe4rb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbZ11cACgkQj4D7WH0S
/k67fwgAkaC5Tr+QQb7cGPfyg4WK05i1LzaFUD73feUn7jpHQluPp89YLYqj6xzl
U9Nfw9F9JLrqPEKdDYJPuUfAYg8EncbRar8FclUAWt1zYtoEe7lw7Fh+dfl7qnFk
u7FjIuUiPtkvhpn4He0zix0AGh2Rahu2CyjhQ0RA3/Z1BQo/vfVzAldPlnwAf9d/
k9xLZZiAQcjwOF1MA0e4lcIKQybQHCsp2CEpvCjWB3CZut7+lAAttjd2yQLeK4Sz
WvUbRjGVNA5lHijjdDVQTGAGo9nU7rgVYEoAbhBxRY9IJ3D9NsfMGk3zwsJlqbKx
0P2ghUCVIGkYQMy6s31PCvQGgm1heA==
=5U8F
-----END PGP SIGNATURE-----

--r5kiyyqgcuiwe4rb--

