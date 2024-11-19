Return-Path: <linux-kernel+bounces-414528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3A9D2975
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECB928120D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BB41CCB5F;
	Tue, 19 Nov 2024 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1Sv3Z/zL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888D13AD05
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029567; cv=none; b=NESDLY4NjoWiFEzKIN8hpURjj0tAJfHuZ0V6zPddOtnpWj8/STWjXQ6Lv9qo5snMKCHoz+AYbTajbmC3ly95oxURIlvcOXKl54qR6cNsSneEN7Qkbs8vAnHtA4rc4dV+vhDEJ+nSpOBC2ePYaQQmOdiULFDu9tuqGBhaQ3rU7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029567; c=relaxed/simple;
	bh=+4pXB+hjWBnI1XEtHlO0bqKYtUJ+g9qEvBq4N4jutHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNNltvZffw9BgtlD7NnK1QclCmJE6Y7+QZg1uwE5MLVeRdiAKqNrDITwhCxczkdy+h/YoWIUGlex6twskvXqdmhBCsj2ihP8PNnTsY1eLq6VX0Bve435yOUbSNMLIYviN8NTqW/3fhKgpz6NACVUhMMnE9ROZWCTwJHGKYHC4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1Sv3Z/zL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4319399a411so9775385e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732029562; x=1732634362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MYjRt6aAXmLduNc3M0AhX6eJNrQcUOwMqW4r+1xGqhM=;
        b=1Sv3Z/zLiEJ5+iojb8Dg+zsgl18jN1N2UpaiMyL61yUIaj5z/2j1Vm6aLdFwabgCfH
         jf6uZchmi0RN9Nn2xuD68fTG00o6iOmci8gPZY0d/lDPYMRZfbb8gGsoWGd/7IVxF9p+
         0dKGg8C7OiBj7jTkC5FtUYFy90j9FoTGJT8DPDxcbwswYQTckvg82z8FR3PxgiX7L0+4
         Sk1z/LAHi/twHM0B+q+eehOhfKG0ldurAaSUcbmqBWoF7lOqZcbdHMjQGgndNhLZ7KjS
         NqA3pkXnWD6fDWNGf2WzY5ejqUsxWo7PWD8qHjEGU4n/4Y+QlM4mFuMxfOFJnxENMkXm
         YLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029562; x=1732634362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYjRt6aAXmLduNc3M0AhX6eJNrQcUOwMqW4r+1xGqhM=;
        b=qiTrU/1QS2XUuRu1BXqnAKibUDH73GjGb5i0lM9vDUykfoazE68QPGSuQ9Gf5WI3+o
         HP2AMYhKTQLyYStrRSOsHSiDvLohbvwwvqIa+YGhjz1BQQjWfuSKTVkwEtqiZi3F8S1/
         6aSnnwe8Makwz+hsFDom2v5d/lJfPHA5N9mIdzJruS63KC3q8rbuhTiOzDPa+Q/VJb2j
         su+cXvAonlfWU6U9p3Ekr9WakfbMOcOWXhXK7AW+IoybG/Qt4IdmhazdpsB9EhdQ2wy4
         8rjZCgxaa0gWV1JH0Nn5HL0G0IfIlYCVL8mf5FSkXJuIqfGjlWhHapaYiZEfx7b8QFmj
         7Pfg==
X-Forwarded-Encrypted: i=1; AJvYcCVp1LC+53zx/GcTCeytA9FREjHEUe2TzBqLo8HCy+9qH4ilNjI674bsWV7Zdqvbi+xkaY5E7nrT9kzGohs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OiTQBcRoDapoWZfkfBXOpJQhwwuhQKUswn/CNSM0XIzQ/Ypp
	DA+MD4A/YB2sZ+dpqFjGd1drvY2zArpLXMV/jK9P797FHje87ZxAaNt5NVpn3WQ=
X-Google-Smtp-Source: AGHT+IE06JOv6iPIXo45XJ7NZ7v2VX2jdRE9SZJkOfZPKGcIoNUYJ/Eqqb17OBd17sK6rS+MKmE8PQ==
X-Received: by 2002:a05:600c:1f0b:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-432df72a4f1mr147121875e9.13.1732029562335;
        Tue, 19 Nov 2024 07:19:22 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab789fasm201173905e9.18.2024.11.19.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:19:21 -0800 (PST)
Date: Tue, 19 Nov 2024 16:19:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
Message-ID: <fbafp4qvf7xq7ob7pdtrps2bgk7n5azcysq4jpqhwxtxxhyt5g@kq763dnqkk7m>
References: <20241016152553.2321992-1-gnstark@salutedevices.com>
 <20241016152553.2321992-3-gnstark@salutedevices.com>
 <w3igi2jmva6mfa7anlieyp3iiwfzhsvi3t37wwcqqtzdy42fqn@btmdsfsmpw7r>
 <f08513c8-56d6-4551-8ac6-84641c134552@salutedevices.com>
 <l5xvdndysdvtil472it6ylthcfam5jp7lh3son45mezq7dh2yk@3yj557k2o5k5>
 <ed5cdef1-aaa7-4ff3-a427-87eae4c90f18@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ujldv2oqf45x6kez"
Content-Disposition: inline
In-Reply-To: <ed5cdef1-aaa7-4ff3-a427-87eae4c90f18@salutedevices.com>


--ujldv2oqf45x6kez
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/4] pwm: meson: Support constant and polarity bits
MIME-Version: 1.0

Hello George,

On Tue, Nov 19, 2024 at 03:51:34PM +0300, George Stark wrote:
> On 11/7/24 11:41, Uwe Kleine-K=F6nig wrote:
> > On Wed, Nov 06, 2024 at 04:54:41PM +0300, George Stark wrote:
> > > On 11/4/24 12:32, Uwe Kleine-K=F6nig wrote:
> > > > > @@ -68,6 +72,8 @@ static struct meson_pwm_channel_data {
> > > > >    	u8		clk_div_shift;
> > > > >    	u8		clk_en_shift;
> > > > >    	u32		pwm_en_mask;
> > > > > +	u32		const_en_mask;
> > > > > +	u32		inv_en_mask;
> > > > >    } meson_pwm_per_channel_data[MESON_NUM_PWMS] =3D {
> > > > >    	{
> > > > >    		.reg_offset	=3D REG_PWM_A,
> > > > > @@ -75,6 +81,8 @@ static struct meson_pwm_channel_data {
> > > > >    		.clk_div_shift	=3D MISC_A_CLK_DIV_SHIFT,
> > > > >    		.clk_en_shift	=3D MISC_A_CLK_EN_SHIFT,
> > > > >    		.pwm_en_mask	=3D MISC_A_EN,
> > > > > +		.const_en_mask	=3D MISC_A_CONSTANT_EN,
> > > > > +		.inv_en_mask	=3D MISC_A_INVERT_EN,
> > > > >    	},
> > > > >    	{
> > > > >    		.reg_offset	=3D REG_PWM_B,
> > > > > @@ -82,6 +90,8 @@ static struct meson_pwm_channel_data {
> > > > >    		.clk_div_shift	=3D MISC_B_CLK_DIV_SHIFT,
> > > > >    		.clk_en_shift	=3D MISC_B_CLK_EN_SHIFT,
> > > > >    		.pwm_en_mask	=3D MISC_B_EN,
> > > > > +		.const_en_mask	=3D MISC_B_CONSTANT_EN,
> > > > > +		.inv_en_mask	=3D MISC_B_INVERT_EN,
> > > > >    	}
> > > > >    };
>=20
> ...
>=20
> > > > Personally I'd prefer:
> > > >=20
> > > > 	value &=3D ~MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
> > > > 	if (meson->data->has_constant && channel->constant)
> > > > 		value |=3D MESON_PWM_REG_MISC_CONST_EN(pwm->hwpwm);
> > > >=20
> > > > even though your variant only mentions the mask once. While it has =
this
> > > > repetition, it's clear what happens without having to know what
> > > > meson_pwm_assign_bit() does. Maybe that's subjective?
> > >=20
> > > Actually I also don't like meson_pwm_assign_bit() too match and I'm
> > > surprised there's no something like this in the kernel already.
> > > I again objdumped versions meson_pwm_assign_bit() vs double mask repe=
tition.
> > > Unconditional bit clearing takes only a single instruction:
> > >=20
> > > // value &=3D ~channel_data->const_en_mask;
> > > 9ac:	0a250040 	bic	w0, w2, w5
> > >=20
> > > So in the current series I could drop meson_pwm_assign_bit() and use:
> > >=20
> > > value &=3D ~channel_data->const_en_mask;
> > > if (meson->data->has_constant && channel->constant)
> > > 	value |=3D channel_data->const_en_mask;
> > >=20
> > > If it's decided now or later to drop meson_pwm_channel_data then
> > > w\o meson_pwm_assign_bit() future patch will be line-to-line change.
> > >=20
> > > What you think?
> >=20
> > Sounds sensible.
>=20
> While changing the patch to drop meson_pwm_assign_bit() one thing
> concerned me on the approach:
>=20
> value &=3D ~channel_data->const_en_mask;
> if (meson->data->has_constant && channel->constant)
> 	value |=3D channel_data->const_en_mask;
>=20
> that we reset bit in the value var even if that bit is not supported on
> the current SoC. I checked several datasheets for old SoCs and those bits
> are marked as unused (not even reserved) and I've never seen those
> bits set. Still I'd offer to use precise condition for changing those bit.
> I'll send v3 let's discuss it again if you think I bother too much.

Usually writing zeros to unused bits is a safe procedure. If the
hardware we're talking to is a newer variant of the supported stuff, the
hardware engineer did something wrong if keeping the read bits or
writing them as zero is incompatible. So either way is fine for me.

Best regards
Uwe

--ujldv2oqf45x6kez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmc8rGsACgkQj4D7WH0S
/k5YUQgAunaABIHOeGpv6VDiLMddmRGSo4/uW0SrIyOgXPRNNIk5scQlObQuTijW
wAVLCBr/SS9SIuZvbqo8S7ok6kT9RtcO5SWWGRbSH5CUohyzVQeeDTRPk6DbleDv
Gb56WH4WFWiHzBpQnI49ianH/8ypmo05vHQpP5lUsO2Rnxc4uvkqrLpA3+Lf0brv
ogVDUbMmSSxGMIwm2Kj0oH7FvDLt9aoTcDAaa7DYsgDBt86jyabBVGcnsGX/AOhM
y5/3Z0eZd41DltgEZGO16RJ8IcEb57DaYcU1sxCewdmsW/4qTLZPVqrZd+jzx2A3
84D2FEaM6yRQ5pNFZo8uAY30Db9L4Q==
=lMnI
-----END PGP SIGNATURE-----

--ujldv2oqf45x6kez--

