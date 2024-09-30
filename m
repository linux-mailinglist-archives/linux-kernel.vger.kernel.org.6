Return-Path: <linux-kernel+bounces-343386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE303989A60
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698291F21A41
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1813F43A;
	Mon, 30 Sep 2024 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EvjOq9lE"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77453804
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727676116; cv=none; b=NpZxo+7uOVD1CJEyLkaOkjVEYPzaI6SpbLVaVTFIhgoMe/aPrJJ4+H3sc7HToDdE29fQHppqcdFVwD2frL6fFojKEo+QmTxo1qSIZk8YsU3baswtEJNz0xK0PItO+PjfiO+nICuu7XQZnXUNeHTwGyDPeNYLTaT7lZKqreM1sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727676116; c=relaxed/simple;
	bh=WpXj85SfRpCsy9vsp5kdBGnGeFLBYWiuAlgpdvFAE7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV6YRm1I8REL63ozJbfMrVzvQEn2EzkglQeK4V8SCG/Cf4+UwrnJfNIMmdOwDsDFwiU7W29ozYtz9WOIHs/60JPLcQW5bhxZV22sbcQI1la8Jg9wXhFokYYsGn6dVb/jlLVmlAtFd5vukR5xfAPF93AsGmTiZldYYgms6JTSzHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EvjOq9lE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7903cb7dso363731166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727676110; x=1728280910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQ/GtUgwKqf/gZ9/mwIokDWgaKNxfHwfz5uH9ZIUzX8=;
        b=EvjOq9lEICqauHuCkNsIlEfGWleKg61Ds8uT1f6KqO5yQQA9WZFqOb7ZN2Rfum+7cj
         mqycGyOhj1nrKN/aWNMoz8/rpGwloaZULB17GuXR1auI6/79bFjs09heff1v984TkmH3
         XQdEY5I7bVkH3R9QFMQpYPAiSUW3tNhcXdawzycdi+4HZXyPqhRN1qz2IZPYPG5zuCRl
         ndv/N/VWkr3jbbkfcNEz9Em8w8ozzJlpfE8z5HP2MX6nn1lPl8M6bsift6TlyyN2/ffk
         xfTO8iWiWAmIMznnS03zABV2XqE0Uy8qVWoOSVVEy7oBf+2mWx5Uu1k69EdYJJD4Phaq
         ldaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727676110; x=1728280910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQ/GtUgwKqf/gZ9/mwIokDWgaKNxfHwfz5uH9ZIUzX8=;
        b=rFLY8RQLUOztoAvaDyUT2mQtL1VZ81o1O64p33honjObAKJp6yy406HVkz3XoLKAPb
         CAqFYx1Io0joNROy7AMTtxcXjwFvSnsJf9lMehoJPxA4YR/uQeARRf7pO5xJzuJqT4Kt
         0jbSsd5wTKZaXGzwAL+VGUFAz/Ox+kI8ws8t+KgF6eMQcksagwPVGhEe4ers4NQATRFg
         glTd2uRCELAbxOKTZrbLoE+OiDNwYhtzcbKxPjOnYIx4OYeQaEYEUY4rwWPWGYPAvt1L
         WLhNarQdhatSnTAWd4+JRYt82dOlDJfTwj4seDgtHs8WAmGQ14EY7g/NhMpyqIq1hXPZ
         TcNg==
X-Gm-Message-State: AOJu0YxSE6vUql/HB+X62kFlQYKhTR4hzZenS6yIRCbQI6AlqBGqR4ba
	wqanJZ7kpHX4dxWr9MBQ4DoY/TwF0gDBNzaPBsepwx00BwqeJIAQR0n4GY2ZZ3M=
X-Google-Smtp-Source: AGHT+IEINgXB3TGy9MJ3AQiHCEbwcpIsZdd+N0fcUfg5k9Vhz1ymIVedFzhuEVaAryD7/KEUVc0j0g==
X-Received: by 2002:a05:6402:5254:b0:5c8:9f3c:e9c7 with SMTP id 4fb4d7f45d1cf-5c89f3cea0fmr558489a12.25.1727676110006;
        Sun, 29 Sep 2024 23:01:50 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:402b:d3b5:8533:7ba2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405d39sm4008263a12.18.2024.09.29.23.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 23:01:48 -0700 (PDT)
Date: Mon, 30 Sep 2024 08:01:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: Re: [PATCH v5 8/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <hgoario7a2x6zoyjy5frbjmxla5vzkbucos55gsjycvxudue65@xqdta7kezomc>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
 <657876d1321467a2b23060ac15924aed8c423390.1726819463.git.u.kleine-koenig@baylibre.com>
 <20240929044828.GA21440@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="afaxet6gf3busi6q"
Content-Disposition: inline
In-Reply-To: <20240929044828.GA21440@rigel>


--afaxet6gf3busi6q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Kent,

On Sun, Sep 29, 2024 at 12:48:28PM +0800, Kent Gibson wrote:
> On Fri, Sep 20, 2024 at 10:58:04AM +0200, Uwe Kleine-K=F6nig wrote:
> > +static int pwm_cdev_request(struct pwm_cdev_data *cdata, unsigned int =
hwpwm)
> > +{
> > +	struct pwm_chip *chip =3D cdata->chip;
> > +
> > +	if (hwpwm >=3D chip->npwm)
> > +		return -EINVAL;
> > +
> > +	if (!cdata->pwm[hwpwm]) {
> > +		struct pwm_device *pwm =3D &chip->pwms[hwpwm];
> > +		int ret;
> > +
> > +		ret =3D pwm_device_request(pwm, "pwm-cdev");
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		cdata->pwm[hwpwm] =3D pwm;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
>=20
> Allow the user to specify the consumer label as part of the request rather
> than hard coding it to "pwm-cdev"?

I considered using the process name, or pwm-cdev:$(pidof
userspace-program). And I'd like to have a possibility to specify names
in dt (that then could be used to lookup a PWM, too). I think these two
are better than having userspace provide a name. What do you think?

> > +static int pwm_cdev_free(struct pwm_cdev_data *cdata, unsigned int hwp=
wm)
> > +{
> > +	struct pwm_chip *chip =3D cdata->chip;
> > +
> > +	if (hwpwm >=3D chip->npwm)
> > +		return -EINVAL;
> > +
> > +	if (cdata->pwm[hwpwm]) {
> > +		struct pwm_device *pwm =3D cdata->pwm[hwpwm];
> > +
> > +		__pwm_put(pwm);
> > +
> > +		cdata->pwm[hwpwm] =3D NULL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct pwm_device *pwm_cdev_get_requested_pwm(struct pwm_cdev_d=
ata *cdata,
> > +						     u32 hwpwm)
> > +{
> > +	struct pwm_chip *chip =3D cdata->chip;
> > +
> > +	if (hwpwm >=3D chip->npwm)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (cdata->pwm[hwpwm])
> > +		return cdata->pwm[hwpwm];
> > +
> > +	return ERR_PTR(-EINVAL);
> > +}
> > +
> > +static long pwm_cdev_ioctl(struct file *file, unsigned int cmd, unsign=
ed long arg)
> > +{
> > +	int ret =3D 0;
> > +	struct pwm_cdev_data *cdata =3D file->private_data;
> > +	struct pwm_chip *chip =3D cdata->chip;
> > +
> > +	guard(mutex)(&pwm_lock);
> > +
>=20
> Coarse grain locking of the whole of pwm for the duration, where some
> calls my sleep, feels excessive. Is it really necessary for all of the
> ioctls?

This might be improvable a bit indeed. I think we won't come around
holding the pwmchip lock, but that would already be nice. I'll invest
some brain cycles here.
=20
> > +/**
> > + * struct pwmchip_waveform - Describe a PWM waveform for a pwm_chip's =
PWM channel
> > + * @hwpwm: per-chip relative index of the PWM device
> > + * @__pad: padding, must be zero
> > + * @period_length_ns: duration of the repeating period
> > + * @duty_length_ns: duration of the active part in each period
> > + * @duty_offset_ns: offset of the rising edge from a period's start
> > + */
>=20
> While you have added some documentation, this is still lacking compared
> to the corresponding in include/linux/pwm.h.  e.g. zeroing
> period_length_ns to disable a PWM...

Ack.

> > +struct pwmchip_waveform {
> > +	__u32 hwpwm;
> > +	__u32 __pad;
> > +	__u64 period_length_ns;
> > +	__u64 duty_length_ns;
> > +	__u64 duty_offset_ns;
> > +};
> > +
> > +#define PWM_IOCTL_REQUEST	_IO(0x75, 1)
> > +#define PWM_IOCTL_FREE		_IO(0x75, 2)
> > +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
> > +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> > +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> > +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> > +
>=20
> A brief description of the ioctls and their semantics would be handy,
> either here or as full blown documentation in
> linux/Documentation/userspace-api/pwm/...

Ack.
=20
> PWMs are automatically released when the pwmchip file is closed?
> And the state of the PWM line after release (or _FREE) is indeterminate?
>=20
> Is it possible that the underlying PWM chip be removed while the user has
> the pwmchip open and/or has pwm devices requested?

I guess these questions are hints about what to describe in the docs to
be written and not actual questions. I fully agree that the
documentation front isn't optimal yet.

> Provide some ioctls to aid discoverability, e.g. for pwm chips exposing t=
he
> npwms, module name.  For pwm devices the label, if the PWM is requested a=
nd
> the consumer's label (similar to the GPIO chipinfo and lineinfo)?
> Unless that information otherwise exposed to userspace?

Most of that is already in /sys/class/pwm. Duplicating that feels wrong.

Thanks a lot for your feedback
Uwe

--afaxet6gf3busi6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb6PsYACgkQj4D7WH0S
/k7xoggAlY47stfCSQEqXlytn3JCP8tS9P5Mjar5hZSPQ5IteRP+2UP2EByLj+PK
nWBbgjn5oUxpBS2r+qOz/PSKoVweNEXjn9FmAaL+dRJkfmwAHcPzwu1+jNarQj6N
xCLe0lc+H+WPWpyixhlBcgvrfh4Yv9ECstJY8oYXviveDiiUjhUWnkdbioR0vUmL
NK7ruFNT70j2TryjDZNGVEuAxi61ZjXP+5Q5middvukTrrzm5/GANPhLywlok+fj
Mkwz/sKfSLyP04Eqf8WpGFF8YoW6o3F4uPeuymhJRpbCOIOstTOJwUNPaPUc+fmk
2p0RaO7Oia7Vr+UTgEDC0ri51CYk+A==
=bTAH
-----END PGP SIGNATURE-----

--afaxet6gf3busi6q--

