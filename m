Return-Path: <linux-kernel+bounces-209665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D80C903913
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B66282C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A773178CCF;
	Tue, 11 Jun 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fw919fy6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B27174EF4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102392; cv=none; b=AQYD5bfJ9KA1l+g9m70zE39UxgWvNwm3V7UOuA2LzBizF1HnHqmI2hCAR/aDz5V7Sww8jgQzAvE5QzQ5BIy9hGy9+2/WE4s6aZwrLNLQUHnicivhukYATgR2FQrpfRnhV13Ul3U8TNk5M1tMam4O7ifQRPiifWi02yKJ6NKC67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102392; c=relaxed/simple;
	bh=lirAN5Btmeq0UbEDe8gzm1pnhLl1R7Bg3Vdt/RO8g0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU67XnSaXG4NvI/ku4UIB1TwcCmyjCpmGSBJSQ3IfHJPeFym7Q9bh1wp6rPLRALrULzF1LqAgDNK5pzS5b0n8fxLChA2WtqdaqroXwfpnxOh6dRmwtDygmLd1RVSBf8YkKU9U1YNGv00it1ARd9xTK4kECx8KCjW8vgD2TZnkCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fw919fy6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c681dd692so4071164a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718102388; x=1718707188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+P5WPE+ImAbQV43ou/lMEcNBass1HwSNX4d8MwKtlIM=;
        b=fw919fy63F0PMfcYEcVUcK5r94hbXIPHlc1Iyhpu4bvCeQt0yrWkAkJfzYaQ/FGbKv
         i5AszFKw5w7QBO59mZ7vdNk/sqD6jsovuhG5YiCqWDiuHluX9GZiIUcysEgEjl33YjXr
         XRgmIMxHUuG1ESSNM4dpfS8moHYadxPdvN7/x+qg1HG1hkNvnbGGkdDG8CpBct/G6ghU
         MYAeYBLnE5i3vkfJrUuPBK5RtKy2teF79+x8EcpXs0vSXJJEUp1mH4JuccHsDJaeJNJx
         mPLsdZ6Ui0sANhBYezVkKfMErcOAPVmrMBzKna8ej0q9KY0ccQSG89Cis1CPZ7+jmu8r
         tjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718102388; x=1718707188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P5WPE+ImAbQV43ou/lMEcNBass1HwSNX4d8MwKtlIM=;
        b=IuJMPFiGY2hy1g9wt7eDKIsnQy52e0mhfWooLS3ixqs/E9OHVyo8DgdpsbGSD/R0gV
         /dI+gCm3rOB9IvbMmMQA2eg+ouOLirBqJo55X3w+s3/Q4h+YtwaIij/nrq8BOBYubWvt
         q90bMzZJMRrc8Tpr0qGs02dsbBPkDK81/VPe4f+BtqUCioddVbD0VyU0cn0ZeLbwqyCC
         CNROGPN2jX2VXE5bXt1DsXZ7hNypIWPdXlcfyTa66Nz+fwnaj+PwP6fWCzBb0/CXJyv7
         yGWjPlBJmgw6NKBSlbkG+8Ch5iVsbGHzKI4XGGWO8Mnbbg1TxjoONZ9DYdbjLodlr+7P
         Ai+g==
X-Forwarded-Encrypted: i=1; AJvYcCU3TCdVNGXa/oNNseZQLS9ytQ2ruvmpSR5n+b5RLY5w7qcWb03WT58PLV0Zr2pc7ljaApS9udljddY9s5uIZnkOLTGyCP/Fy6TFF1h9
X-Gm-Message-State: AOJu0Yz9dPM0YRDQYLsjRGB9b6ho8tWjM0DVC0/QWkhi4W4tETBBeo6A
	+4avM2zVLP5w6USy4xRkUXvPoYsKKlGZPc/SGfSNmoY5/KV9VyYd2XH1MHrb/TY=
X-Google-Smtp-Source: AGHT+IEbxriNoGDmtH7cENlXkSkINKU7KHdfmhUC2bUJYj1VkGK+4gPHQyF71NMYXPVJT8rOjRNHcQ==
X-Received: by 2002:a17:906:f20b:b0:a6f:268a:1fc4 with SMTP id a640c23a62f3a-a6f268a2031mr280799666b.61.1718102387895;
        Tue, 11 Jun 2024 03:39:47 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f34591542sm94539266b.55.2024.06.11.03.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:39:46 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:39:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in
 .get_state()
Message-ID: <dbygoq4rzxnzforpdsvuy5jze2rxqszi6qxtx6q37yxwjo36o6@qfoc6iz2nbay>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
 <ZmgP5NTPEGM0M2Li@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="konmklnuzw5wmdnt"
Content-Disposition: inline
In-Reply-To: <ZmgP5NTPEGM0M2Li@google.com>


--konmklnuzw5wmdnt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Tzung,

On Tue, Jun 11, 2024 at 08:50:44AM +0000, Tzung-Bi Shih wrote:
> On Fri, Jun 07, 2024 at 10:44:15AM +0200, Uwe Kleine-K=F6nig wrote:
> > The get_state() callback is never called (in a visible way) after there
> > is a consumer for a pwm device. The core handles loosing the information
> > about duty_cycle just fine.
>=20
> ChromeOS EC has no separated "enabled" state, it sees `duty =3D=3D 0` as
> "disabled"[1].  1db37f9561b2 ("pwm: cros-ec: Cache duty cycle value")
> caches the value in kernel side so that it can retrieve the original duty
> value even if (struct pwm_state *)->enabled is false.

There is no need to cache, so the following would work:

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 606ccfdaf4cc..2b72468767f4 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,15 +25,6 @@
 struct cros_ec_pwm_device {
 	struct cros_ec_device *ec;
 	bool use_pwm_type;
-	struct cros_ec_pwm *channel;
-};
-
-/**
- * struct cros_ec_pwm - per-PWM driver data
- * @duty_cycle: cached duty cycle
- */
-struct cros_ec_pwm {
-	u16 duty_cycle;
 };
=20
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chi=
p *chip)
@@ -135,37 +126,33 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel =3D &ec_pwm->channel[pwm->hwpwm];
 	u16 duty_cycle;
-	int ret;
=20
-	/* The EC won't let us change the period */
-	if (state->period !=3D EC_PWM_MAX_DUTY)
-		return -EINVAL;
+	if (state->enabled) {
=20
-	if (state->polarity !=3D PWM_POLARITY_NORMAL)
-		return -EINVAL;
+		/* The EC only supports period =3D EC_PWM_MAX_DUTY */
+		if (state->period < EC_PWM_MAX_DUTY ||
+		    state->polarity !=3D PWM_POLARITY_NORMAL)
+			return -EINVAL;
=20
-	/*
-	 * EC doesn't separate the concept of duty cycle and enabled, but
-	 * kernel does. Translate.
-	 */
-	duty_cycle =3D state->enabled ? state->duty_cycle : 0;
+		duty_cycle =3D min(state->duty_cycle, (u64)EC_PWM_MAX_DUTY);
=20
-	ret =3D cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
-	if (ret < 0)
-		return ret;
+	} else {
+		/*
+		 * The hardware has no possibility to disable and so save power.
+		 * Many consumers expect the PWM to at least stop to oscilate, so just
+		 * configure for duty_cycle =3D 0.
+		 */
+		duty_cycle =3D 0;
+	}
=20
-	channel->duty_cycle =3D state->duty_cycle;
-
-	return 0;
+	return cros_ec_pwm_set_duty(ec_pwm, pwm->hwpwm, duty_cycle);
 }
=20
 static int cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,
 				 struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm =3D pwm_to_cros_ec_pwm(chip);
-	struct cros_ec_pwm *channel =3D &ec_pwm->channel[pwm->hwpwm];
 	int ret;
=20
 	ret =3D cros_ec_pwm_get_duty(ec_pwm->ec, ec_pwm->use_pwm_type, pwm->hwpwm=
);
@@ -175,23 +162,10 @@ static int cros_ec_pwm_get_state(struct pwm_chip *chi=
p, struct pwm_device *pwm,
 	}
=20
 	state->enabled =3D (ret > 0);
+	state->duty_cycle =3D ret;
 	state->period =3D EC_PWM_MAX_DUTY;
 	state->polarity =3D PWM_POLARITY_NORMAL;
=20
-	/*
-	 * Note that "disabled" and "duty cycle =3D=3D 0" are treated the same. If
-	 * the cached duty cycle is not zero, used the cached duty cycle. This
-	 * ensures that the configured duty cycle is kept across a disable and
-	 * enable operation and avoids potentially confusing consumers.
-	 *
-	 * For the case of the initial hardware readout, channel->duty_cycle
-	 * will be 0 and the actual duty cycle read from the EC is used.
-	 */
-	if (ret =3D=3D 0 && channel->duty_cycle > 0)
-		state->duty_cycle =3D channel->duty_cycle;
-	else
-		state->duty_cycle =3D ret;
-
 	return 0;
 }
=20
@@ -291,11 +265,6 @@ static int cros_ec_pwm_probe(struct platform_device *p=
dev)
 	chip->ops =3D &cros_ec_pwm_ops;
 	chip->of_xlate =3D cros_ec_pwm_xlate;
=20
-	ec_pwm->channel =3D devm_kcalloc(dev, chip->npwm, sizeof(*ec_pwm->channel=
),
-					GFP_KERNEL);
-	if (!ec_pwm->channel)
-		return -ENOMEM;
-
 	dev_dbg(dev, "Probed %u PWMs\n", chip->npwm);
=20
 	ret =3D devm_pwmchip_add(dev, chip);

> To make sure I understand, did you mean the original duty value could be =
less
> important because:
> - We are less caring as it is in a debug context at [2]?
> - At [3], the PWM device is still initializing.

It doesn't really matter that this is about debug or initialisation. The
key here is that the core can handle the PWM using duty_cycle 0 (or
anything else) when it was requested to be disabled.

Best regards
Uwe

> [1]: https://crrev.com/0e16954460a08133b2557150e0897014ea2b9672/common/pw=
m.c#66
> [2]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c=
#L52
> [3]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c=
#L371

--konmklnuzw5wmdnt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZoKW0ACgkQj4D7WH0S
/k76DQgAoM0Jovkalc4hFgZCLg19A/V4oH1mD06Dnr0VwAPv9grqkpL4twyYuwXo
YTF7WPRC67Jvp+z3eK8cq6bhOyh7BmHwlq5z1nXZrASbVx1qkNyKOorCWbeJwkc+
9ozeO0OuXaGkWpkpOteacgLVCQ1RVKMGWV/ko1b2DMfQLm0kCMO7vKO26EmDvfVO
EF5rOURIjLsTSXH8DkZxoqauYQ5MholEJ+Hik+X/n3gD3Ke01MC0Rra1VO1c2Hns
150mZPTxUhOO5imOm69P5eHuu+nXdnCBhqNB42gsRvP3wtJay7YUdsc9ys6dxUJX
6izeIbyZYqsPyERA4d7Wmh9oOfC4Ew==
=Jzn+
-----END PGP SIGNATURE-----

--konmklnuzw5wmdnt--

