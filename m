Return-Path: <linux-kernel+bounces-214003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D9907DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231C61C21B60
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E413B787;
	Thu, 13 Jun 2024 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BxZtckS7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69613B588
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718311596; cv=none; b=poP5tTHRlDoXs+V3HAsTaqP9hS4w/IqLL75rSUt558IumW210gqBVjYxLuBBUSXehUAEeZbA9Vrj7k08xYMkvlSbKVUubDkLFrorikpc7IgkleoCRGdi3TdpGqFwLOALexgCK38xJTBG64e0jqM5TLdpu04hrXjKYMV/N6wzc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718311596; c=relaxed/simple;
	bh=CnHZb9z25XNpR7nxuaGQfAj2reg5e5IRMmuc2RvoCGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5XZ19BAc6fXl4IbjHSKk46jfvl+6hBF/bemTs7/q1UB1cWZ0G+tlJICsTf70GRNMfbc311g/QKW3rlR1X0zM+0TZsP9WNAhe/d6WdhrUIhZsajgdy+0BzvbUdonD82GGNgG9OL9xAXyxU9TyyAK6yl+KhGwQIOxb4IgAUoPeb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BxZtckS7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a44c2ce80so1648945a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718311592; x=1718916392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5+He79jybhHTCYOhSX8BgQBoEHtDE3sqg7uCiPqItM=;
        b=BxZtckS75VxW0r54FGyng3f1WF/gyGjXrvLUAwjbE/yWooVn+6jjGY0OEPEhpJSNhZ
         aO58ICN1SUi/U/TJiVT4L6Gv6ur9FAbQ9tYTRmRIn8fwcTyNPeQ5MXDUI3S6kOFqpJx7
         FmE/DNso4IYf5lA9gzgaf6PB8sLD+tTUhNLRo2/uQbFAT7s1kLE0Z27nJ2ctCp67uOkU
         TXugI4mjzg3Mm+dvc241j2J8xDStZ1hZ1L93rn1Yt0NSm+NbjKsxa4ZXHxhpA5kU7hP3
         Brj07GUwzvk2VRWp/R6/kTq+Ksu200pDAZ50+wonggcdRa/PwC0+TBcITT3uorg/oh6a
         CKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718311592; x=1718916392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5+He79jybhHTCYOhSX8BgQBoEHtDE3sqg7uCiPqItM=;
        b=lu+QMfpkX7Oa3DOSthSFe7VoXiCTdzDndUdgXRc9/cmfNxdIrx+zvK0W9aCFw2rfC6
         znkBd/BJJ6lw9Js0JPgGM+9QxHSfF08PwbbVvwnUFIct0/SrrXIkPuCEhYcKMy7lRg9p
         LxjwzPNrIxuuk9+KW/IVVci1PifI6B7TBY8loZKq04Xt1HnYgS0PMRpMQKuC+bDVZi37
         v872aQUNZ4TvAaZbZrlZMmuOfxcG7OHSSJPFPVjmXep5oTCypy3V3Z/iBQfc1BsCeZsS
         U0wzMITIiCJUC20LFHXuLHaikaOc4V6/tSjXAK33R45xkq03RiVbouEmJGvkUXPfp39M
         Z1ow==
X-Forwarded-Encrypted: i=1; AJvYcCUCKujJvq4O+Bf4IMxA5yTgsZEldxGajOoomWt1qr6q6cqbBQQ3TCNEyEwAQ9WyBW3R8/d/LEQX/EDFFNkk+Yw+WVYL0Fy71bgCC3tB
X-Gm-Message-State: AOJu0Yx02Syd9yJn/rBh5294qCD//pB2bo9aIvTfH3qTnM2pihFQW+xk
	kAZmUUdC7JvuiXwJKS/4/hGF1z91kNP7tHlJyvrt4HassHgBt9SKiYp97xKfO8o=
X-Google-Smtp-Source: AGHT+IFtpOzE8kKqoKpYLmM4FbNCxftMEW9YZ0CGmabwa7MvW6sl7qRnrlLjm9/uGQPw+uKoNnSNBg==
X-Received: by 2002:a50:a45c:0:b0:57c:b83a:fef5 with SMTP id 4fb4d7f45d1cf-57cbd8b9be3mr598711a12.34.1718311592344;
        Thu, 13 Jun 2024 13:46:32 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:78cd:4cb6:e3af:4473])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e702sm1342351a12.70.2024.06.13.13.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:46:31 -0700 (PDT)
Date: Thu, 13 Jun 2024 22:46:30 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: 
	Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, kelvin.zhang@amlogic.com, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Message-ID: <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
 <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atnwtc63iuembv37"
Content-Disposition: inline
In-Reply-To: <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>


--atnwtc63iuembv37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 13, 2024 at 05:54:31PM +0200, Jerome Brunet wrote:
> > +	for (i =3D 0; i < MESON_NUM_PWMS; i++) {
> > +		meson->channels[i].clk =3D of_clk_get(np, i);
> > +		if (IS_ERR(meson->channels[i].clk))
> > +			return dev_err_probe(dev,
> > +					     PTR_ERR(meson->channels[i].clk),
> > +					     "Failed to get clk\n");
>=20
> here it is ok but ..
>=20
> > +
> > +		ret =3D devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
> > +					       meson->channels[i].clk);
> > +		if (ret)
> > +			return dev_err_probe(dev, ret,
> > +					     "Failed to add clk_put action\n");
>=20
> ... here, devm_add_action_or_reset cannot defer, so dev_err_probe is not =
useful.
> dev_err() if you must print something. Just "return ret;" would be fine
> by me

I don't agree. dev_err_probe() has several purposes. Only one of them is
handling -EPROBE_DEFER. See also commit
532888a59505da2a3fbb4abac6adad381cedb374.

So yes, please use dev_err_probe() also to handle
devm_add_action_or_reset().

Best regards
Uwe

--atnwtc63iuembv37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZrWqIACgkQj4D7WH0S
/k7GIggAqVAdsuyCU4qUCiRosJKIKXIHaUcrhQLdIciPH7mkNTw3UOw9RTgdygIt
RRtsP2rXk6hKJtbI/SA234syDPp/2zlmkDOk475vviRgmnxGpQiw1/C9/emfGYX4
bOHhBHkSQvxKjGIWhuFSHo3dy2h0iAYYZFZSiNfvrydjAOA3ERRtgJf/hZUS8zpt
ogHtoO6hD545xuoG8gLPIMest9lvd/W0PdyyQnqyx5+X4V6QyBBAmjuKnSMMpr0W
5NtJr0vvFaiH+NAvi38WFBUzF5KkQyUF/Qi2PQf7r1wzIULlWdC7CiDFcLDA5+l5
aEYn8Zg3ghfFXda0jlvgTNItV0D8sA==
=7F+E
-----END PGP SIGNATURE-----

--atnwtc63iuembv37--

