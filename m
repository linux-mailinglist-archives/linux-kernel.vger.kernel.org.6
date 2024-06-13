Return-Path: <linux-kernel+bounces-212592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C859063BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BED3F1C21829
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F63132104;
	Thu, 13 Jun 2024 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SRTXsA47"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89913698E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258841; cv=none; b=c8GsbVuJr7/l7/xMGpLGxdGWalWIKxTj/j6ptS1xfI/l7rJ2uF5gBjJzjqcGzTVLxlV5k4P+fL5O1OyuaD0CCPehrbUUNLiAKo8skra8LrqOu/av9SSB2J4BhMzbacnET38hrDdPeGGnYrBY2hoh2GTMP/JLXXVsXVxlTG6aqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258841; c=relaxed/simple;
	bh=DuF3s2NTbx9eNAhEvcHOmtYwWf1R8c8+PhArMhqMNRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHs8cmFSe5mlVb+icwdDgeLe6IO7EanSV2dpvZPeiQJNnbk4z6h2S8MCyM0IsHKXHRIXz9Aav4FaM96Zf4yzBo3q+UFYxyDT7bONbVjqaJsmbtIapwmFRqbuKQH3Wvpq9CMMN/EZZgFJW4X8spmMp+eKp+nvbwqOYyhjjzY7sjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SRTXsA47; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f11a2d18aso74617066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718258837; x=1718863637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGw9LjxRLnO3E/KOoJkpWZFT1iYKIeZOgESfwWkEGak=;
        b=SRTXsA47PWmKt8l+JRMpKC+DPIN+JUmsQ+h/kzhvU+T1uTPESFp9kA/zAipOLIDmY7
         eIobqA3L/OanJ4cwiseWfdkrSDTvVzRMQtKn53FK5bR+dd6Y9uISbaHTIYUKbnScIb2f
         XsAe6eDkTest/KOLOhL1TGjlVXoHfwtwA5keiN4RwZOdTaY3mFwcLLVEk+QlmLddTNIU
         yzGWxRohO8364KuU9YJxZYSFD15LGWjnfHG7WMby8Fltp9aEXKOgcujYGOFgTN4J8ZNF
         wtpR4heR18uJwfZ0BGYYgEP2yxEpLresMCM631f9Xvh8tZJv3lwdMqjeRy39CTjQtrDY
         WcVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718258837; x=1718863637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGw9LjxRLnO3E/KOoJkpWZFT1iYKIeZOgESfwWkEGak=;
        b=nezandQZeX0Nu/hDxqGT9wyjcKfd5on2GQl/rpXO53emjioxmxAxNtteuKKYwZEkqS
         53Q7+Rgu/1XcrEeq5CwOYq+pDvaj4QnIU1nuqS3Z8pvFdyrYOYE0hf3O9Ar5rzRrbZOB
         pYmcc4dRifGTW82+Ci38v1pC4xZNQJzBH/nahKA9ywLagURQRc1B4l3aCsD52EyLDl5B
         uxif7fwuud5zrBT0y5zeG/HpvWiy9YwUaiqRrHxRW25vZKnoyCeEvGstftl6t3gS5C5x
         +WzHQvRDcpf0h03HvwFcq7LtL0gkq3zUEkMBFdORyHNWt7YyJtWR5xDu0Ae65VOPjMVC
         BjGg==
X-Forwarded-Encrypted: i=1; AJvYcCXFVrXnzShKWI1+yFFX1MShpaXyl3NdlsteDdYaP1sWhispYK/scOObtypnzn3ebpSPNiX3EO+Ay+ej7tT14nPz/T0HY4Be2auP4z2H
X-Gm-Message-State: AOJu0YwygmKau8nSsGhrTtR1vxW9oAjtrP2fuCNlWeFo1jjc4Sm6krWk
	3dCGC2fh7AppjxOIHfF0c5CoR8FuP7yGrxLoGCW6J8Et2HqYKdtcFLqY/ZIsMYw=
X-Google-Smtp-Source: AGHT+IFyG97kapcpRtgBxfI28itXzYDTqJwCuhD9+V/5izctPGOD1KVGzSQPvm/H+fT80lQmOs9NDA==
X-Received: by 2002:a17:906:517:b0:a6e:2a67:7899 with SMTP id a640c23a62f3a-a6f47f7fc60mr202929666b.35.1718258836898;
        Wed, 12 Jun 2024 23:07:16 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:6dd9:ebe6:fd11:a860])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3f86sm35701566b.3.2024.06.12.23.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:07:16 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:07:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in
 .get_state()
Message-ID: <p322xo44wkcrmaewbz6pf2jn4zxw2wzzwikc3xkdl6mh4yc7od@rnxc4qdj6vxx>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
 <ZmgP5NTPEGM0M2Li@google.com>
 <dbygoq4rzxnzforpdsvuy5jze2rxqszi6qxtx6q37yxwjo36o6@qfoc6iz2nbay>
 <Zmk_wolV5vK4JPCV@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dux3ffohujxukeib"
Content-Disposition: inline
In-Reply-To: <Zmk_wolV5vK4JPCV@google.com>


--dux3ffohujxukeib
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jun 12, 2024 at 06:27:14AM +0000, Tzung-Bi Shih wrote:
> On Tue, Jun 11, 2024 at 12:39:44PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jun 11, 2024 at 08:50:44AM +0000, Tzung-Bi Shih wrote:
> > > On Fri, Jun 07, 2024 at 10:44:15AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > The get_state() callback is never called (in a visible way) after t=
here
> > > > is a consumer for a pwm device. The core handles loosing the inform=
ation
> > > > about duty_cycle just fine.
> > >=20
> > > ChromeOS EC has no separated "enabled" state, it sees `duty =3D=3D 0`=
 as
> > > "disabled"[1].  1db37f9561b2 ("pwm: cros-ec: Cache duty cycle value")
> > > caches the value in kernel side so that it can retrieve the original =
duty
> > > value even if (struct pwm_state *)->enabled is false.
> >=20
> > There is no need to cache, so the following would work:
>=20
> Ack.
>=20
> > > To make sure I understand, did you mean the original duty value could=
 be less
> > > important because:
> > > - We are less caring as it is in a debug context at [2]?
> > > - At [3], the PWM device is still initializing.
> >=20
> > It doesn't really matter that this is about debug or initialisation. The
> > key here is that the core can handle the PWM using duty_cycle 0 (or
> > anything else) when it was requested to be disabled.
> >=20
> >=20
> > > [1]: https://crrev.com/0e16954460a08133b2557150e0897014ea2b9672/commo=
n/pwm.c#66
> > > [2]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/co=
re.c#L52
> > > [3]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/co=
re.c#L371
>=20
> I was trying to understand the description in the commit message:
> : The get_state() callback is never called (in a visible way) after there
> : is a consumer for a pwm device.
>=20
> I guess I understood; the core reads the duty value via get_state() when:
> - Initializing the device for the intial value.

Yes, that a consumer cannot do any assumptions about a PWM just aquired,
so there is no danger for confusion.

> - Debugging for checking if apply() really takes effect.

Right, and the read pwm_state is only used in the core. The core won't
be confused about disabled vs. duty=3D0. Consumers never see the result of
the .get_state callback.

> What 1db37f9561b2 worried about is already addressed by the core[4].
> [4]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c=
#L495

What 1db37f9561b2 worried about is bogus, because pwm_get_state()
doesn't call the .get_state() callback:

	$ git show 1db37f9561b2:include/linux/pwm.h | awk '/void pwm_get_state/,/^=
$/'
	static inline void pwm_get_state(const struct pwm_device *pwm,
					 struct pwm_state *state)
	{
		*state =3D pwm->state;
	}

> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

I'll apply the patch under discussion and create a proper patch for the
ad-hoc change from my previous mail.

Thanks
Uwe

--dux3ffohujxukeib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZqjI8ACgkQj4D7WH0S
/k5jCAgAsA5+r0pbCBGPDyie+4QAe8InHSyHZ7STwVbBOGPL5OUvhqgMzs0yBS+m
PUSC5vbmRyXAmEvq5/iuD65ty1ggYj8bNTjjUtzooSUXzssJWUorWxOqhotFtOpn
0M9Pd1XbMMPOuFfpvYJGoko4hA8SmSiHBmZAMiRfBws7ca7gUELwUreumcX5yJk0
UlmfrdmHdSkPcl0GcOslvvYjS5+m8KSwrjnuVOOnBth+23L6IxpWUiqb2Hp3nem7
TL1vumpfZV8Lqiv833fzmTjugihshRWA7H27hJS7C7ZZDGDB2Aka+WbEuuMypqFA
05zw0QzJ0h16YYyk7D+IPAi+r/WHtg==
=M2it
-----END PGP SIGNATURE-----

--dux3ffohujxukeib--

