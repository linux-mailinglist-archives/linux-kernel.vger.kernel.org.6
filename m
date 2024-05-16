Return-Path: <linux-kernel+bounces-180797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 401EE8C7347
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713CD1C22738
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E2E142E95;
	Thu, 16 May 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdZW3PWR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1722D054
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849578; cv=none; b=AUGM0bws4ON09r4uBbp9/thsnsKDow5q5DTtXSjevAneT2CpSFAfzVuvFqVQ2bryvt2ux7V4pymNDqGTmWpvZbnoGpWMvTMw/eUGMX0O7/GKAYCqGSNIb23L8pxDCxDQ2Oy4sNBNun3TmzPHKlRA9sF43OB9R6/5Ja9lv4iNX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849578; c=relaxed/simple;
	bh=SOFhZnbfrK+W7JMH+7jBr4uwGqHGYwqfkagAeEIjSZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fpaQI1DbmafDEtnRTWmJtk3D1Pn9GmE1xdHRAWzVuIdIO8hWcxDuPxMUVQ0A3+hzFKYuT/v59m8cerxaTQgkr04zSx83UnUCNTr+bqv9fMw321LzGVfyy1svR+057USeFooC9WATt4NFq68xpGk9d3cDMN+AktIgnb7k1ZGy1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdZW3PWR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f72a29f13so608329e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715849574; x=1716454374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBwoMBMjGCQnPXLlZjoQkBMRf+vVLmRtklv2WaJZwac=;
        b=DdZW3PWRDQH2KbUxeR2xGq14lrFJWTiqvt6OlhmF/1e1FRxFryUhmzcuXtbjt10BfW
         OD2etdukVOuO8hGC/GIVEgptdDfAA+hLk5gDRfg0s0M4Xk9LJp5974jzGZqcK+XRX8Z7
         lMmvdsoq3r4cjvFIgD05ufNFpUHD0HRlVLKkxI03QGe5UI3FTlyUqNLW8L5xyyAvurik
         Rcd963Urpm+eGJYuXlL4aJC3pQR4QR2RLLzFZgIrqzyVQFvimiwiaMZXJghvmPpYF9AN
         A3LrZcajemrEmzLcFxbM8FTzU9OIRevxd5qsSxS0Zd2iUzH2Tm0qO7/o4jaiv2WcRYkx
         CnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715849574; x=1716454374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBwoMBMjGCQnPXLlZjoQkBMRf+vVLmRtklv2WaJZwac=;
        b=tzRrgzYQJjZHGmM2CugdI9RRhTLxTDFdLRGqxDsjz6GBzPMGzN9rcZiXfZ2rOPX44U
         RAe6cviWPRJO7FoRB5K4oX4gv+YAt2N/QPQEY8cbNl0IMSDCuCBLpM04i+H3jTA3z6tr
         59Cni50ytfH8+CJyoH3sWJX/Qd4xZvbCbGyBeOv0TUAIUT7Hqbgpk6+tPY2kXSsdAqmn
         LWBabs/7S9DpR8kJDjbDLJjtzAE578yuqXH2Ljg/0tWV2OJrUNdV3sUJlbKCOAsDQIlD
         CemXacFbU8D3x/eGMhjPdwNxktjr3JbJcfnRGT6iLfoYVCtnqOpoeHNnr/F1GdC9isVn
         8bIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrwKSRJUWcvqs2NVJebHE4IWOs3fdirDD4PiQqjJsvmT5KdrQLr+9AMCSaJ7otu0UyLp8LzC616ggxvrOQl+BbtPdwiqLyR3VVvqs4
X-Gm-Message-State: AOJu0YwhetZRAJDjBrVcd+aGy+ISmcaNlNcgD5F5suJeQlNyBT/xbRhB
	ITzx+vsc43pratsrVLC7l+L9uuVQkCOj/KoiMEFaPrM/RdmrQvD/
X-Google-Smtp-Source: AGHT+IH8VouB3CIfDnBkNK3EUXkmukrlv5aRxQqWostKxuKkCIpXNP5gADPPJIWM+DVZeX1YV1cQsw==
X-Received: by 2002:ac2:490b:0:b0:522:3817:6d4c with SMTP id 2adb3069b0e04-52238176e26mr9277531e87.68.1715849571976;
        Thu, 16 May 2024 01:52:51 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d33f5sm2907563e87.133.2024.05.16.01.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 01:52:51 -0700 (PDT)
Date: Thu, 16 May 2024 11:52:44 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] regulator: misc fixes
Message-ID: <cover.1715848512.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZrHgggBSNMa7JqiA"
Content-Disposition: inline


--ZrHgggBSNMa7JqiA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This series adds couple of a bit unrelated fixes/improvements which I
implemented while working to support yet another ROHM PMIC.

Patch1 addresses a potential problem where the voltage selector for
pickable-ranges is used in same fashion as a 'apply-bit'. Eg, when a
regulator voltage is changed so that also the range changes, the effect
of the range and voltage selector change is not taken into account until
the voltage selector is written to hardware. In such case caching the
voltage-selector value will cause the voltage range change to not change
the actual output voltage.

Patch2 is a fix to ROHM bd71818 and bd71879 low-power state specific
voltage settings where some of the voltages were common to many states.
The old behaviour was that changing voltage for one state caused it to
change for all states. This had a potential impact of accidentally
changing the runtime voltage when trying to configure voltage for a
low-power state, potentially hurting the boot-up process.

Patch3 is just a minor print improvement to help pinpointing unsupported
voltage in device-tree.

Series is based on v6.9

---

Matti Vaittinen (3):
  regulator: don't cache vsel to ensure voltage setting
  regulator: bd71828: Don't overwrite runtime voltages
  regulator: rohm-regulator: warn if unsupported voltage is set

 drivers/regulator/bd71828-regulator.c | 58 +--------------------------
 drivers/regulator/helpers.c           | 10 ++++-
 drivers/regulator/rohm-regulator.c    |  4 ++
 3 files changed, 14 insertions(+), 58 deletions(-)


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
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

--ZrHgggBSNMa7JqiA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZFyVkACgkQeFA3/03a
ocWj0ggAqjmxyioG5eZWDWnRZhhWTOz5qk97OpSSyrQvopNcnpHR6mKdeMFB2Qi9
Xk2DpUH+FN6dNbEt5zXnYSMzWL7ohP2mOl65Ny1k/QnT7RuD2krxLENx93I7Ek4s
/wfqBRNu2Hcw+9a2NYK1sumUz/H5o0vRgP3DzCbBhIh5JYO1ID4+bi7tHNm4Ufmj
DOPzeDuocNNM/SuSoKbNDFjafAu1wzItMMSyUeFEem9lHa3iPbPNFEUWRQowaM6u
oXzD+6cuWc+RuyvOn/Jvz/DEf3LfHadsm8jwI43PykE13s/MZHb7H7loyWrCe81e
6lMERZMBvu0J7Wand14vHmOYSPQBXw==
=29Zh
-----END PGP SIGNATURE-----

--ZrHgggBSNMa7JqiA--

