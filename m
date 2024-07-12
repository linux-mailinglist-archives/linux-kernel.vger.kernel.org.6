Return-Path: <linux-kernel+bounces-250545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AB592F8EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20326285F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904916F8F3;
	Fri, 12 Jul 2024 10:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F+opiLwp"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC49F16F844
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779791; cv=none; b=dg32HWi7XH/Fqmt5j9mEWpP+JP+IF+IusQnaYPMb+3+KZ3b67Z8/Uos6h2i8AJRGY9mjFAqP96McLeyAk+Xc5Yo6+JBk1E91QCavqmb+xymsi/MLyD+34FjimuyWPLP8DNsCPKenTV/qBjYlK1ji6IQiy0X0VMw2uq6pzGfCew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779791; c=relaxed/simple;
	bh=qrk0LVcmuVjiEcv7KyZeL00+thrBnOd8/EoHt4sBkOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2aiyHwkQpT+Uk1n6hZyBio4ctO472eZs5QXVO+u+Vre555ei/NQMlo6ORG80hy2Ttn8M3ohEoUPgP+SUdFx7ERxVsaB33YkZJPyQxFLHx8zdns+Tx8wnvJgpL79/cx+JYRu4bulk+mDkiO33npTo0ZxI66fU8P4VIFyaAilWcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F+opiLwp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77b60cafecso232506566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720779787; x=1721384587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrk0LVcmuVjiEcv7KyZeL00+thrBnOd8/EoHt4sBkOg=;
        b=F+opiLwp3R97klDdaMLuiKOsIdTDMJTeRCFZ5YQH1XHqf0VqRrBUvLDPSYW+ugTo3f
         oeKGVPtJIOzIDZV+8aHHABTsg1O0dIsXIr1qTmx0FQ8jACm0sh3ecIo9/Awbp2wWqnrf
         2Hvk0WniTApHhyqrVexgK69jr6stBhW5vzKuvUKff+hlJxKLqJaF7rsuN/lwZwHChauR
         IUPj3tOYRtz0XYTipCiRQcjbsIYPaDszVgb26NclK0w5anNAuFS9Y+jNAxRR+BNjOMl8
         FPpLk6Sl7/UwXBjuC9XDUCQ+bSja4kvQa5/9olguJgp2/FBZQ718fz5YFioyheCI1+eO
         W4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720779787; x=1721384587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrk0LVcmuVjiEcv7KyZeL00+thrBnOd8/EoHt4sBkOg=;
        b=Y8KWLtnpwjjF8JiZXbnndTkhFmOcsaafkektIpzg8GvPu761zHRXrS+I1+morbrdTp
         HVEQveVY+MsccN59/165agOLYvGPyy6ot0srhR5zTHjkgcZuIblqQxYcozZRSZTfS2au
         xwnY8bM197G3HC7JD3zt3TBddx2TX8euoK2InwD2eMYiUBgTeUt4FolFg/rrWtSKbcHf
         ESA71C5/URwZhxq2R7+PuiAcWSNQpvgqa1uFTRDXyKlH2jyLKyBrpKdrSdP6imJf1Vzx
         QjIYQvRHaHjZscSGzGnCS27LvIC0UM4htkWjMV+DSTxblq/UQKduL1wRP/UKtEKstMR8
         dGfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr5S8GL8CV8a9XVwu7z7KZsY6sojjteJ09fwNpbzbIzp/xTBzl4DMZETxwqdNAfYAGJgMlfc+1jweN9h+UnkAqurdUODV+Q0CbfQ4b
X-Gm-Message-State: AOJu0YzSwEb6Uu98hB5Af3gM7HYWdK46dFOFItqzSvmHKLWnS1oUrx9k
	tb1s/mW5SHdxbXmLW63E8arr4rtnrjZFrsj15wvFJCQ4+2PnU2QiH5cntS0LftTnNPYhgDV5THv
	2
X-Google-Smtp-Source: AGHT+IFG0J6IkxmWgik1JhA9krrIT763djjpb2/xyRINL7DV5Gi3UhRk38CA3x9QcfjUIWGM5OvikQ==
X-Received: by 2002:a17:906:1583:b0:a72:4a4f:23d6 with SMTP id a640c23a62f3a-a780b6882d5mr698656466b.8.1720779787038;
        Fri, 12 Jul 2024 03:23:07 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a797e3b160dsm216698866b.204.2024.07.12.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 03:23:06 -0700 (PDT)
Date: Fri, 12 Jul 2024 12:23:05 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UAPI/ioctl: Improve parameter name of ioctl request
 definition helpers
Message-ID: <payyjsywrmqt6wirl3eiq2bndfbfgk2epp2cgojm3oetj5fx7l@apfkwfprjwe4>
References: <20240712093524.905556-2-u.kleine-koenig@baylibre.com>
 <7351db74-fb04-4d0f-93ae-d3a3a3a310ff@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r7vzfxn6wa55mgjx"
Content-Disposition: inline
In-Reply-To: <7351db74-fb04-4d0f-93ae-d3a3a3a310ff@app.fastmail.com>


--r7vzfxn6wa55mgjx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Arnd,

On Fri, Jul 12, 2024 at 11:51:38AM +0200, Arnd Bergmann wrote:
> On Fri, Jul 12, 2024, at 11:35, Uwe Kleine-K=F6nig wrote:
> > if there are doubts about using "argtype": Would "_argtype" be better?
>=20
> The patch looks good to me, and I think using 'argtype'
> is fine. I would apply it directly, but not with the current
> timing just ahead of the merge window.

Yes, having it in next for some time is a good idea for sure.

> If there are no other comments, how about I take this after -rc1?
> You may have to remind me about it.

I'll ping you.

Best regards
Uwe

--r7vzfxn6wa55mgjx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaRBAcACgkQj4D7WH0S
/k6KtggApbi7Ik4HZeeYZvYBZz+oozbuGzdDpSgxs3GFjXkpHZupaca0Rxc2eqlD
Sa1SlUev0zSeZnbzCq099fqqwDxyKGFGVQ7esLwrVbliA+Dum0ZWK7RslLKFCDLy
SRnLeeONYE5eJt4fPz7qRUE3ba8R+zgaGS36l9nSZ7ey0aWPRMuSzoY0pOJSxCPH
Vkn7R1ao6WbvbUn+qrso5Lqwe5vl92+ntaVWcHC62IR2JGcwCHj2YF6nUtxidNwT
zE/GG0X7+pa1ywVxhQ5BBk75gu7F/pSAX+Fj7pagfTsUQzV9lw//EBqpoYlNEvwS
hHZD+Erp7OmdMfm88TVrHdjnJ4Q/Hw==
=YQPz
-----END PGP SIGNATURE-----

--r7vzfxn6wa55mgjx--

