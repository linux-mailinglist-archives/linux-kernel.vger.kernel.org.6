Return-Path: <linux-kernel+bounces-427894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D24C19E0A92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C143B2D1C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C957208997;
	Mon,  2 Dec 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cX1xGeIo"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69BA1D545
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153632; cv=none; b=WfH/b+UZlScNPtCDESEfLsyIEYH38ohk0pjHdXAVZRUwc+c5M11iYS/727TvXfrDXHRPDFs39WJjC6T4tVLvP933eKysIZO/K+MAG97tOUpaWun8/+8eNsGBtFvgk5RDtY1R+Tld9maKw3l4jYfjjzEEuDHuiuSZkEYjfo6hSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153632; c=relaxed/simple;
	bh=AUELSO41N+yQ4AnhFqVhNzQrgNV0pbVHE10ygamCcz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMB10staxzhPmS4M274fk64XlDbE7BCTPoERWezq4Ad/RcRN4/Wu88c/YIQyvR2b9qbGT9/OeFupcQhAXXiUfeQGB7qSjdiHog1yrVpcrdaR3vMYM7eSmgytCY+mest1TMzIdqATjqBB5lGJPxTDtO5CSn4+ySezl/vAnIs3CbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cX1xGeIo; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-385eed29d7fso931901f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733153629; x=1733758429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQZDAJ4BE5Uf6rA0GwOspP+B6xrsXzGOwGjbIONdX9E=;
        b=cX1xGeIoF58aEzOtTXH2lf+8js9IX17HYBLwc37L27fg7K8Ploreb7tBPcJdgj1uvP
         vfJk1KmYgjUN5zNOHYsDP24B8ARLP9XZrIzepWta0cLKHOK00zi/2QZuvQeUS9SUogZ3
         hhy11C5uyydZIktbgGH7t0PdAXHm0xWCP1SNrXcUlFHm5WES9sXNy6XodfAlLTGo3Qo9
         vVBPkqr4lSX/MqUP20M8tdPAtniw/2gFroguTDrPXH95NOjw7yS4PSQWeEypRkVlrr1t
         gKy0Fsm3g665l2z7+j56aPuAJpQdbSdBlRzTdJ2VaDZH4UZAq/bIyg3UVBYTtCFxnzgz
         RePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153629; x=1733758429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQZDAJ4BE5Uf6rA0GwOspP+B6xrsXzGOwGjbIONdX9E=;
        b=n07Lfk6TEHb0AHpDZt6AwCLIMHICio0ba8TptyoCiQa2bDFlkRcJjWu5pzeqzjjR9c
         Oa23F5/Z5kvV1utungxSYQhI3u7EHOVgJgBngSgyykQCwxxDOyeayvbk/hLGM1aRyLx5
         4uiNzV+XIWZcS7N6dCrrl/Zekx5Fo/4OQDKKmFLb/kATXEAvmhcEiXHu7Wcb7OvtolIE
         X9HIgoDAGiHNeOfg/R1EEnkr7kIm3q65hHVjbIlJR90qyNGdJwqWEF7izibypgrMajH1
         ImrLj5n7PUxzcxvGsLP8sHuXWpHOOEs+Gzq5kV7cuTjb3pt3gVNf95ThkwZ8mC5Zw9eD
         FaZA==
X-Forwarded-Encrypted: i=1; AJvYcCUFlPmzT+JVyBk4mFHAaNYnImfHthQOHb6KI+PT+tYiUA3GoNI27k3qELUXPJDzDs/tcHAzyGgnPR3ZncM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8NLGQniOr7uPZjGmRVBFpwhx0mN/wV8xT7K09F7DnL9F0Yzx7
	ulSZM0RembyG45Lpy516djEGCRk8lj/fJYegE09l29QQval3BuUfIFZNh3ErG4c=
X-Gm-Gg: ASbGncsHBVeV3kcnwf8jHJbutf/pYcVqbph9h/zUo57zj9osLcMxNQjBw79ujzsnOSE
	Ljy6cGHuKrs/g2Zy9xEIrHfPdmAGuuHXXI9XMqJAv+oofnJkUxAKpLp7RIdKSaXCXJMiuCw1Ury
	q7MVxOlpq00Nbq53hfjTeF+Yzqf+DaJynTULvrIy2H40tAPoKx8nX/d+o8vIdK9T+6c+/cEXvph
	q/E4T2OfG+O3vRtmoSEM1whQaxNN+tA3+Cglf8Ib6OSYnqTf2Q3GYU=
X-Google-Smtp-Source: AGHT+IHX6IqEaENqWZu640hS31kz63qA3oxvVMl/y0xG/7tbaY8KqMinpnE0TNS9hGb/JlAkKHb8bQ==
X-Received: by 2002:a5d:648f:0:b0:385:f07a:f4cb with SMTP id ffacd0b85a97d-385f07af738mr4797876f8f.8.1733153628915;
        Mon, 02 Dec 2024 07:33:48 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:ebc7:b34e:f4a6:7947])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e0d4778dsm9196361f8f.45.2024.12.02.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:33:48 -0800 (PST)
Date: Mon, 2 Dec 2024 16:33:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, 
	Erick Archer <erick.archer@outlook.com>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] auxdisplay: Switch back to struct
 platform_driver::remove()
Message-ID: <abek2strn75feiakoteul2hcw5vkgci3sxcbckexd5legbdjn3@u6hegsqm5cwb>
References: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
 <CANiq72kqMmD1P_2wjL3xL2ot9+3MzcrrZH1Jsw6Tz+m9A3z6uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uvavrhbodfmnqqy7"
Content-Disposition: inline
In-Reply-To: <CANiq72kqMmD1P_2wjL3xL2ot9+3MzcrrZH1Jsw6Tz+m9A3z6uw@mail.gmail.com>


--uvavrhbodfmnqqy7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] auxdisplay: Switch back to struct
 platform_driver::remove()
MIME-Version: 1.0

Hello,

On Sat, Nov 30, 2024 at 06:36:07PM +0100, Miguel Ojeda wrote:
> On Sat, Nov 30, 2024 at 3:57=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@baylibre.com> wrote:
> >
> >  drivers/auxdisplay/cfag12864bfb.c  | 6 +++---
>=20
> Acked-by: Miguel Ojeda <ojeda@kernel.org> # cfag12864bfb
>=20
> Glad to see that journey finishing :)

It is completed now, faster and in a different way than I expected:
https://git.kernel.org/linus/e70140ba0d2b1a30467d4af6bcfe761327b9ec95

So this patch doesn't need to be applied any more.

Best regards
Uwe

--uvavrhbodfmnqqy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdN01gACgkQj4D7WH0S
/k4+hAf9GVhNVDU82uVaTD00p8KaLHkaZscexO8SSfEfxqT43fAkD2d3iq2mX7gK
aAHL+F4CYB9FMQja01z1E2goTv12RLz5929VURXcIcEAdKBx/UxPeMnsa9dkMvQk
jd4LfznyZLhm/qSLJWu81jr6HzYS70tL1nltGoHUk3+ScJy0pgGLjxS/A5afj439
HvOgwow34jNQ6DRgI46cUIhktMsyqxSEbU6WmBdKqYNcRBHDl+pJqlkyC58kPhKC
CWebCVunDc2tBA4q8HcSwEmf/51DruI1NWlaVFYUYLX6Q5ukhksQq5rSVectpnu4
dwGyAwSTR6jt/evQoMu5Ss3jMqjdkg==
=k/87
-----END PGP SIGNATURE-----

--uvavrhbodfmnqqy7--

