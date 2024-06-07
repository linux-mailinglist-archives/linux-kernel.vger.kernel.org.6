Return-Path: <linux-kernel+bounces-206513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFC900ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2BF1F22C68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D9C19AA6A;
	Fri,  7 Jun 2024 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pOSNc8zL"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF486195804
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779155; cv=none; b=EJpYjOEKHq7RVFizc2BXeb5KCGxQeeZ4lwof0zkyIENNelrq8n36wgGQXLX5FDsnOoDIo6/zXVJp2ktFYuHPOzi6IcxVsvNB+gP/sAO5F6WUARDiUNwaDkyWuwp/IG04LNBwF7vCzmos5+UAT3mzH0qi1TTWGz7gJb4sVc1CsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779155; c=relaxed/simple;
	bh=jzan/YNt+iph6kDhBYAQyNeRgRoEW/pl77UxjZOc1qU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5Ex+Be5Iht9bW1q4FYHd9AwsG4x5gMZZytT9umHCo0oLNyosfK7lwdZQynVe+jnx+PWYubdAQa3XbtnambhNWEpZZIfpyO6TA9txpZEuqlf74d97aKhsRRPygs+mtGSv5cNf5qAl4+rZlUDDpv4ve2Fmx9Hp2Bfvc47mhs529Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pOSNc8zL; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35f090093d8so527062f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717779150; x=1718383950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bc5Fab9HJb5cr3eXsyaeU1ehshedHKC3eXMoebONp4U=;
        b=pOSNc8zL4dULZI3NzlyxU8PHudgnLUEJsPhMq60YVn8ChCwap/t38pBJ4lWyNfx7ar
         5roLH/4sYWDrJYbgMU/Ebu69wMlWcPkVw6Zn3oZQgj6MDVV3ByNMQm7GgWnHdl8/NkSI
         yhXubzrABnSWmVlSR9ijdgkwElA2as+ObDQu2ivaPQXJtX4GzhLIhvuP/5cM6lyC0tbT
         y5HGJKSQhQFC8/5X1rgAweISDM3UmD/dTUeJZckJLjm+7kqVDymwnw7OA+yFKdHAKgwS
         /PjXtFy88ZtZnapVJbj+h9/whJpA7gokiSCuYM80372vqIZXPTB8OwP+ykXyxO9Tq5uP
         18AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717779150; x=1718383950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc5Fab9HJb5cr3eXsyaeU1ehshedHKC3eXMoebONp4U=;
        b=FgM91a5ka9SjuR2b9ybgU9EPYSredO9WxVtKO1VjdDlb0gmlGb/Ra4tgljsYMhD45/
         4e1vBxVnsDORwinRFbqEqlb0iqbjp505GvXEZBmMEXt1w1xQfFUlwP2gHReyqaNkpzMj
         2eum8hrrC5SEqu2Mm6Ku28/NMD1KlZdv34P7wO6ZJmfie6L6JjmgvJAfVI59WGdWjO6S
         l+rZQjEmuLWOYXE8/w+VuE0J+zAlbPpCNEe+dcF1PE4OL+3LDtgNvYUrfLaYWr8TRrFe
         154f4ynRzfATh/g1LUYYx3LQSV33svWtsfw9ttOrWN5tp3AXlfyEES/P4fASbbmX8jLV
         zzkA==
X-Forwarded-Encrypted: i=1; AJvYcCVW+yGbci0pnQZ1z0tLn8jiH8yZ4Evd56ZtMmrhrCXSIoIjvEHAxE7QPwq2bV9NqZjQMDHwr3m4k7ssZGJBJ3ImfgnCkjuwutLsF9vB
X-Gm-Message-State: AOJu0Yy7IZwzY2CxLCdzoHRrE9YFEbAtX1F0oI2G6HmeFg3Ydt+Fn5kS
	vKGliz8CGkUv2lEpiijC4x2CDVq3FKOLqSzgngqt3zUZoNYzge3y57uvoaFm3nk=
X-Google-Smtp-Source: AGHT+IFx+YYu803ec7W+G74FTtSx4WrjApVrFi0xZp6/mRweE6i0Z2RLQm7zQoHi354T3EksuDSixg==
X-Received: by 2002:a5d:6892:0:b0:35f:f1d:f4e9 with SMTP id ffacd0b85a97d-35f0f1df7famr378461f8f.28.1717779150418;
        Fri, 07 Jun 2024 09:52:30 -0700 (PDT)
Received: from localhost (p200300f65f283b0017c92b05fa289d44.dip0.t-ipconnect.de. [2003:f6:5f28:3b00:17c9:2b05:fa28:9d44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c364bcdsm57203535e9.19.2024.06.07.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:52:30 -0700 (PDT)
From: "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <ukleinek@baylibre.com>
X-Google-Original-From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Fri, 7 Jun 2024 18:43:23 +0200
To: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in
 .get_state()
Message-ID: <loyvxce22gz6gwcp7vgjbttbtasmoyjwf6bdash4kqzhsf4na7@zf627ythm2ge>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mhwn6reey4op4eyi"
Content-Disposition: inline
In-Reply-To: <20240607084416.897777-6-u.kleine-koenig@baylibre.com>


--mhwn6reey4op4eyi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 10:44:15AM +0200, Uwe Kleine-K=F6nig wrote:
> The get_state() callback is never called (in a visible way) after there
> is a consumer for a pwm device. The core handles loosing the information
> about duty_cycle just fine.
>=20
> Simplify the driver accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  drivers/pwm/pwm-cros-ec.c | 33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 606ccfdaf4cc..ba4ee0b507b7 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -25,15 +25,6 @@
>  struct cros_ec_pwm_device {
>  	struct cros_ec_device *ec;
>  	bool use_pwm_type;
> -	struct cros_ec_pwm *channel;
> -};

I forgot to drop the kernel doc comment. Unless I get some feedback that
makes me send a v2, I'll squash the following into this patch when
applying:

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index fcc33a2cb878..189301dc395e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -20,7 +20,6 @@
  *
  * @ec: Pointer to EC device
  * @use_pwm_type: Use PWM types instead of generic channels
- * @channel: array with per-channel data
  */
 struct cros_ec_pwm_device {
 	struct cros_ec_device *ec;

Best regards
Uwe

--mhwn6reey4op4eyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZjOKYACgkQj4D7WH0S
/k4gHwf+IZdctA9vZgZrUZACvGGOpgs2zu3k4EIKxgfFK1nwlxmXo2yYY+JpGCP8
UMzDV4Xen8UDwVhfjQtvMkZ0ZepmO60NNQqHSkbaws5CbtyeF6vvlktE0+w22Y+Y
71+B8ShFk6pOS4YVEFNPh+kB+LjhRZ0MwdmxJUWBguxqHGIEruOrHVds0jiPlcnW
2JSnIkNiQF5Tpt1lDtY634BVhb8Io/E6ZTYR7MPtD/BqAXwNg+jheyNGFSYUAeu/
jsorkAXn+rwz03Fkrk5x05dNUXY3ikxUywJrZbTliqjKIP+BjQ4F2a623fygl0tt
MzmI9xu7YcT3VDE3vitmLOR7c5c5Aw==
=bXer
-----END PGP SIGNATURE-----

--mhwn6reey4op4eyi--

