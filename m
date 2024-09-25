Return-Path: <linux-kernel+bounces-339341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8A898638A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88111F252EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496DD1D5AB0;
	Wed, 25 Sep 2024 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="r24O82Ae"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429551F5F6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277886; cv=none; b=fTOegW2jlXkQwErLxDgKqL27PQ0b09TDSjt3nC0v+q5OtjGIOIDq/D6j7v+vSkReNTPGtULhxB6MMXVreo2XaWjjS4Hicrmloeeugnh/prASYeo6LTvWgYn1oRgEnj8GgRiXtw9bwp9SJHH6ZYYycdog35xjCoF2TII8GCIN2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277886; c=relaxed/simple;
	bh=Nei19YCOdWxQB6PSFPBaKgKKbnCCQEOXG737LQ9AkSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/+s3QfAR+r73NK2sKHKyhWa3PAyd4f5ubpR1JQ6zn8uInx5rkjjF4VlMukvN5Z6ie3ezCbSqCjjra2oYjn+CkcrI8gowRD5WR4R+ZRfXHIDBEbPqkHMY1dOw+petR3nXkTz589PJgazsxE1qDl5Zw6ugyGWSf1MWSS1kI3IKJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=r24O82Ae; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so60550035e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727277882; x=1727882682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZaMZwXHaKwH3J28J1QUJ8EoP3VpC4zNWUFe/+K3NKg=;
        b=r24O82Ae4uytcsbEvvMneIUeZNprSWbmibyv58zobG8gTKlOz9h4a42F2xaQMpO9wq
         2KkNhfRhynMmcnv80i4R1L10DTpOsZPfP1bqinUHj+mA3OvdET7F4EJiq2DQDHLZo6TQ
         6fNk5kMQ7dlo1FPqy/LEJ578r2V9HondS/BTEkhIWlJa0QfKams5hedocdRvK7TkgxVD
         bja+6q/fC4Okuf6om7Y8JVGHUQj4LCk11cX7SrIb1mEmRuTkIVEJE7gx/E3py8XVzXhs
         dtX6rFjz3j1h7zCT2/NnmBxVk74cOYhuSs7crRY+Pj9mr4So1uNv4NYfyxpjyla8VOya
         Ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277882; x=1727882682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZaMZwXHaKwH3J28J1QUJ8EoP3VpC4zNWUFe/+K3NKg=;
        b=g2JKkO35rMcxT9LWK/42C/I3qcvp2Fpa8swK52kps0Q71BPoqV6t+GwGvLpGfTGSag
         iNN6s2OUqE2oIMIyG/jyaQoRm15jKebsUsgII/O+VbrvOTChLx37zzZAxsxiSVMlfvmq
         0GRg/RKRbcEziL+1M4iccavtsqR1Ex3gHR82QyebvgBXZuRDf4Ksj8J4xwi7ZFYge1r9
         toMwwtYfXrrfuqkww7cM72qT7E/cOOcWI2fFhiWGwxw2NHgcb1fWc2rJFUc7l7Txq4So
         2bIRVdwA8gxVapxRfbGChKcfzIneOt/OZcBhkejy0uU5/w2J89DCgPrxdXVZvgP+Wrd3
         362w==
X-Forwarded-Encrypted: i=1; AJvYcCUQh/f23GIBKDO/yryiUglrKiq0oFR+wwCLOugK99XiJA/O9Y54/+/FaPejASmJj3cyw9aOZp3NK3FaCcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hLYa4CHaWmhDx61QXLxgtLeRuoizuvBSVdF2P2FEM7UIDk5w
	FF3PltdYgLwaUnmKK8+2Ge3KEVIOu8tt+pltcbJa/RuEUeEBu5TXDVHODZ7iizY=
X-Google-Smtp-Source: AGHT+IGp7IXEcyn9CleK5p1AdnO4qjInVMLqS+PxMVRogEvNdttg+ML/7c2lCBDgnb9yXkneZtqQFA==
X-Received: by 2002:a05:600c:2908:b0:42c:b949:328e with SMTP id 5b1f17b1804b1-42e96ab6bbamr16529155e9.31.1727277882413;
        Wed, 25 Sep 2024 08:24:42 -0700 (PDT)
Received: from localhost (amontpellier-556-1-151-252.w109-210.abo.wanadoo.fr. [109.210.7.252])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a54fdesm22048715e9.41.2024.09.25.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:24:42 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:24:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: axi-pwmgen: Create a dedicated function for getting
 driver data from a chip
Message-ID: <4zgf7ykie6blsatpmc22qy4ipglgwzyze6utvhzbkzr7o24rpj@hdpf6k2pf7mm>
X-Patchwork-State: Accepted
References: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gtjkcuacc3cpyeri"
Content-Disposition: inline
In-Reply-To: <20240923125418.16558-2-u.kleine-koenig@baylibre.com>


--gtjkcuacc3cpyeri
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 23, 2024 at 02:54:17PM +0200, Uwe Kleine-K=F6nig wrote:
> Compared to direct calls to pwmchip_get_drvdata() a dedicated function
> has two upsides: A better name and the right type. So the code becomes
> easier to read and the new function is harder to use wrongly.
>=20
> Another side effect (which is the secret motivation for this patch, but
> shhh) is that the driver becomes a bit easier to backport to kernel
> versions that don't have devm_pwmchip_alloc() yet.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-axi-pwmgen.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
> index b5477659ba18..e5162f3e511e 100644
> --- a/drivers/pwm/pwm-axi-pwmgen.c
> +++ b/drivers/pwm/pwm-axi-pwmgen.c
> @@ -53,10 +53,15 @@ static const struct regmap_config axi_pwmgen_regmap_c=
onfig =3D {
>  	.max_register =3D 0xFC,
>  };
> =20
> +static struct axi_pwmgen_ddata axi_pwmgen_ddata_from_chip(struct pwm_chi=
p *chip)

Applied with an extra * to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt
=2E It will migrate to pwm/for-next once the merge window closes.

Best regards
Uwe

--gtjkcuacc3cpyeri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb0KzQACgkQj4D7WH0S
/k7KPQf+JPIPZqb28EwD4AmBY40e0WcHC3V63BzgaJnZ/BYxZ24ZVlgNVPH5M6BE
MmOnL2wcuvCYoCGFTJtdUNI4FLFzkJ2vqif9CTcXEFomAhqPwBqkxzI7coOEXIEF
N7tG0O9/mQ4gKokmv4clc0DSw5gE811iO7wUwRsLdL7LYLvxbgkZ/apTd/WihuPX
1uMK0FujmoF9/hBivwSgdeySF+wmK/xracX0bSzAzBXGTd2jaQewNFdR9TlDAIse
zoQJR3KzXtq8T56AXAutvfUbA5WWnTFVEa7xLtkrJqzn4BMeely7kEa8IgQikPre
uAu7DbdBvhY6Oj3NPUGpCohLdffsNQ==
=yuIz
-----END PGP SIGNATURE-----

--gtjkcuacc3cpyeri--

