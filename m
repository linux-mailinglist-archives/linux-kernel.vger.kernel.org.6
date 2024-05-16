Return-Path: <linux-kernel+bounces-180799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663B58C734A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B951F23948
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05B142E91;
	Thu, 16 May 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRci+I0K"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47F2D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849633; cv=none; b=ZF3Nnv9hRuw1hJpjPNQmvKTsV5gh5G0WsUOcAFV4OgeuraxGMFrdHRvOCwpfG+ut8W7FzyhYl+s64M7qudhPqwciEf2jZcZfnyZdbqlJT7aal9jRQT2siC0Q4XAO6Ih9s0mJeUwM7g5T5EuAZyeQlou5xSwXn4myMUYG0svnTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849633; c=relaxed/simple;
	bh=EvzR/+qP8YpCTYFGhUIxfgeFiMVjA9S9MCVXR2mZlIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CSBogWp9UoXJcVTFg7fSmCAsE2ipv1JbdP8vWPJZeU+jefqdQQKidi8lFeJXAJTUeGDEFxZNKRHmnZk7yhhDpBirMmsvchUyrGy5xattSwCR4Lo/JEtjj30HjuRq/ilzDdYBLcBj/WkFfsxRICdWnCMYWf/+Eg8Oyo8QRIkjzR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRci+I0K; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5238b5c080cso630214e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715849630; x=1716454430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OrpKtu1+8+vAteCx4l2pXb+3WgkEr/bLHS+sWe47SL8=;
        b=TRci+I0KS0mfJPSFuMYr8Bn6u8RKPcSZGrF74uYfYoJFTOD/Oe7jNxpb3dt6UpARJ1
         KcR54fpaOcIue0ZSnT6aHqCVQ5R+V0+fNeggGXq/ENHh5rG8KoEmc4YDnxZY5wK+RIz2
         p5nJJZS0Eoyjriuz+44cSwlIHOPsaYHPvrpr4JFr9oVyv0CioTfUalnLAp6eRvHTO1hE
         OZXf/2u/i0nO9/FVgZXAeU4TudwggZfVSy76eOBaUgeOQjRcT72EQfYsVzwVLKNnLcVn
         l/krRbY6FXgKBLS+WIQAqFH0j69ySo692E5ENnD9+TbsLxMBZTwLyqYbkvRp7hK8n8Iu
         MCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715849630; x=1716454430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrpKtu1+8+vAteCx4l2pXb+3WgkEr/bLHS+sWe47SL8=;
        b=macTPu1I2iGCxbcNWv2Ch4w7JJoYVxva0qzbtPnaBIcDy4rvMdj5Qk+KcQDH/Zd0yM
         uSHW1P+V2E+9fzOZT/bNv78lZIBFs+ofcwPF+lf3fb//lvhYzY+VGbYxDD+fSB6Sxn7u
         +hAH+mJ8Qevr8J011fnoCcAFfgJ7P05fjkkRnNGFaq4Q+85N/6QWa8uFMhXTYSKuSNlB
         G5kZLn6qAHvw+H0a2iSXoyvWBMxkdAMTHk5gqVjPuKOVAdoQFklrZ9erMz8rS6a07ogW
         m+e3/kBf5fcEeu7kc1YH1DnLVNr+8tKj0yPHKnsTuX3t2pDQM84I4thvY2feJ5lswVUq
         2HvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOLzPQqEJE6hh9ddDZOD/SV8d6dVEfROFu6oiwVCM/76o0wi7Wj9yUjuopI1JyCC7Qb998LPCEGcuksqk/XyJJVZWmidYBVLC/FEkA
X-Gm-Message-State: AOJu0YxeSaBT7rQxmak/sMOLOpiyT58ElhGosDQ61hayN1vg6O+uLsQq
	cT94TwSOg2gw1jqQ97ayEErJMe+9g0IIlgDvqRwXjGT/IGGv5aB1
X-Google-Smtp-Source: AGHT+IFIzrwaV5aXvF2n6zb/kTshajEPPEMToNuBlPW4ANyvNfh+q6sPO0ubqfWR5aGq57WngBb/jg==
X-Received: by 2002:a05:6512:3ee:b0:51b:518e:5679 with SMTP id 2adb3069b0e04-5220fb74281mr11414507e87.18.1715849630142;
        Thu, 16 May 2024 01:53:50 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33adsm2923825e87.144.2024.05.16.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:53:49 -0700 (PDT)
Date: Thu, 16 May 2024 11:53:46 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] regulator: don't cache vsel to ensure voltage setting
Message-ID: <a8ee4ae5532b67a5aef0f6e482cb37f5efbd8952.1715848512.git.mazziesaccount@gmail.com>
References: <cover.1715848512.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RE05FgbajyWlp1EM"
Content-Disposition: inline
In-Reply-To: <cover.1715848512.git.mazziesaccount@gmail.com>


--RE05FgbajyWlp1EM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some PMICs treat the vsel_reg same as apply-bit. Eg, when voltage range
is changed, the new voltage setting is not taking effect until the vsel
register is written.

Force the vsel value to be written to hardware even if the old selector
was same as the new (but range changed) by using regmap_write_bits() and
not the regmap_update_bits().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
I have a feeling this same thing should be done with the apply-bit
writes. I just wonder why no-one has reported problems with it. Maybe
all the hardware with the apply bit has 'self clearing' apply register
marked as volatile? Anyways, I'll leave it out of this patch because I
have no hardware to test the apply-bit stuff, and as I haven't seen any
problem reports about it.
---
 drivers/regulator/helpers.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index d49268336553..28c2f40b19cc 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -211,8 +211,14 @@ int regulator_set_voltage_sel_pickable_regmap(struct r=
egulator_dev *rdev,
 		if (ret)
 			return ret;
=20
-		ret =3D regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
-				  rdev->desc->vsel_mask, sel);
+		/*
+		 * Some PMICs treat the vsel_reg same as apply-bit. Force it
+		 * to be written even if the old selector were same as the new
+		 * (but range changed) by using regmap_write_bits() and not the
+		 * regmap_update_bits().
+		 */
+		ret =3D regmap_write_bits(rdev->regmap, rdev->desc->vsel_reg,
+					rdev->desc->vsel_mask, sel);
 	}
=20
 	if (ret)
--=20
2.44.0


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--RE05FgbajyWlp1EM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZFyZoACgkQeFA3/03a
ocUFKgf+KMGACxXe84szs5lVNm3V2WAQdGYED0nvjeIjORdDU1Yo/Q5BT2hugSVk
yVi0Ar/9oYey4opS+06zINLt1bmNgd+5tuGyE80ztD+QyrH24f1Et9vmPwnLRJGU
IHMrdgJI+XwgSzcGl2V02SeYjFHdpZnyUOFi3XbRVHxITrfS9Rt6l8Tsqenj1S4a
lGSPtbcRxJLQVnZVC8shb1fmGf/nJjGUDOXUf4Cq9mQrXK0z9j6SHBkfhAJYvCwg
ERkr6PomPa+8ghr2eY+OR67B+Z3yVSq5qKbiypb1WY99YIptBJrBv+Y7h+N8GdI9
GylmfCGapNnBW/sHDhbBjD+abbeXag==
=2eZW
-----END PGP SIGNATURE-----

--RE05FgbajyWlp1EM--

