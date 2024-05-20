Return-Path: <linux-kernel+bounces-183733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D218C9D51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A5F1F231C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0960BBE;
	Mon, 20 May 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB+27dHY"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F267612EB
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208275; cv=none; b=O1wbsnOcJNiPVlWWQZXFw7nAzwnDiHrJPo3CgfX1zqXiKwY3oeG8NFwcJ2fS8+uCtLARJODc6Xq+iFyQeS1NpgYDyS3ljoz43+GviHacrbKl9psPGOC2ZI7FbgSjYCXbJQj6jZ9+bCkJL36S2bqSEBHY5Hlg2TwF+NNz5SkEIvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208275; c=relaxed/simple;
	bh=EShonQY2zDsALv6YQhO9ib6qoCyG9n3IUJVvv5yoQjo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a5TYn4xz93h0CrX25xm7V8NVZGDBslU8UxERR8pS7IeSs5SJJ8bt+NoIGb3eBK4pQtDB/gXT/5enpL8I1CFiIOExXp1ZOsXoqleNwa/tbDtRfw+X0HsufRPjwg80i/ifMySgxD1sQ6wmcc7ehgziGS2Jsxqk89NUn6T4kn3OOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB+27dHY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f174e316eso3198590e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716208272; x=1716813072; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTV37OvPNxm097mdCjRk9kivbaQmKYdeu/uwsv44aes=;
        b=fB+27dHYixS2VsxVZmTA1ck9m/jLuvtQcsbKVX+arbcR9adJApp+7e7pWhTjvi0Y8j
         WGCcFv/WpugicSlvrhPXj3pmCOnvFXcVXuYh1qme2lilNcCk1jUirARNC5S2fm3gZKya
         /ACIk9ErlDaZkjicYZine80ot5oYyft/dunoUwhr44OghX+EJvbaTDmTDi26dxd9prQU
         XBlaoor7COK5d3Ebd3XcI3CAdpQ6ipy6RgA+QsPCuHIuApdDJscE389rAJYz5xOPCfnF
         OXvbCU0wmdXkNRpVDL4xkoyuPAIs2CAjSmdQqXtW0Pmew9QAPLHERi/sVMDBiocgDC7Y
         zc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716208272; x=1716813072;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTV37OvPNxm097mdCjRk9kivbaQmKYdeu/uwsv44aes=;
        b=APZmAhHbIDGAmq6tsQEEK/CqtvA7CaRWZv10nMBzckuaGqXYHfeX54df1YyyTGYH1b
         39OraIDyA0g/PyS3ySLgKPncSrfbmtVSGS+MeQ0T0oGFqQk84MtQ1IhjSl+wT8cGLVRL
         i15sZNt5yy4u1H9TJo1EAovY+r1LPnTyD3RKxSztib5K3IOOMS83PQhBIdkGz+Yvc4VZ
         BfYAe14Ksg66SzdcECfsqlDWOudh99snTC6wllj80b8V/BQ9EF8OOJ/yl4eEnZinW1J4
         Y6aYeRdO53R7EEZC5SdWAXT45LwTHN0ATQX7ysm39NvfnvV80JL2nqtfbXSKVCraIK2P
         rhFA==
X-Forwarded-Encrypted: i=1; AJvYcCXMLKbDp89M9pD9sbRGfbnNCdWXZJr69lkG78fMPtjYXLWXUi5U+EYiUFUh74tbXO/A82+U0STTy6G1Rpw8Cm4vef50dcFJb4GAMFAQ
X-Gm-Message-State: AOJu0Yx2ck3wuXaB68mdwM7Ctzfr2IyLtYYe/dDJ1n/1ogyOV1YuoqXd
	QQn1yP1py3JXqzlbXZ3B5o7Wj0DyF2A8IjlCswKN/6/HCjDOSUs9
X-Google-Smtp-Source: AGHT+IHNpzsuX0rBjZvmG4Lw90zHePB/y3cd4iL5UI6lZQYVtEZylz8Y+q1a08ijN9zRU4KSKmSsww==
X-Received: by 2002:a05:6512:3c9f:b0:51d:ab55:f2db with SMTP id 2adb3069b0e04-5220fa717f5mr23174649e87.10.1716208271434;
        Mon, 20 May 2024 05:31:11 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238a14d64bsm2074664e87.258.2024.05.20.05.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:31:10 -0700 (PDT)
Date: Mon, 20 May 2024 15:31:02 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] regulator: fix pickable ranges vsel caching
Message-ID: <ZktChruNV_Jc4j4u@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MQgaS3VPhLaQvzhS"
Content-Disposition: inline


--MQgaS3VPhLaQvzhS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This series addresses a potential problem where the voltage selector for
pickable-ranges is used in same fashion as a 'apply-bit'. Eg, when a
regulator voltage is changed so that also the range changes, the effect
of the range and voltage selector change is not taken into account until
the voltage selector is written to hardware. In such case caching the
voltage-selector value will cause the voltage range change to not change
the actual output voltage.

Patch 1 addresses this issue by adding a flag to regulator desc to
advertise this behaviour and by always writing the VSEL register value to
hardware if range was changed.

Patch 2 sets that flag to Texsas instrument's tps6287x driver because,
according to the data-sheet, the TI's PMICs VSEL register must be always
written after the range has been changed. Please note that this has not
been tested in TI's hardware but the concept is only quickly verified on
ROHM's BD71851. All testing is appreciated.

Revision history:
- v2:
	- Change series name to reflect content that is still not
	  merged.
	- Drop already applied patches.
	- Add patch fixing TI's tps2687x.
	- Don't bypass cache for pickable-ranges users who don't have.
	  the 'VSEL as apply' behaviour.
	- Bypass cache only if range was changed.
- v1:
	https://lore.kernel.org/all/cover.1715848512.git.mazziesaccount@gmail.com/

series is base on regulator/for-next

---

Matti Vaittinen (2):
  regulator: pickable ranges: don't always cache vsel
  regulator: tps6287x: Force writing VSEL bit

 drivers/regulator/helpers.c            | 43 ++++++++++++++++++--------
 drivers/regulator/tps6287x-regulator.c |  1 +
 include/linux/regulator/driver.h       |  3 ++
 3 files changed, 34 insertions(+), 13 deletions(-)

--=20
2.45.1


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

--MQgaS3VPhLaQvzhS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZLQn0ACgkQeFA3/03a
ocVXxAf/eNpKlT3d/ANnNoL1BEmddIi/7e8g3WJrS5H1/1Z5BC+cqZVXPfugKgXy
YZeJo7Pb8+hBafaQSVsZdzHWBgEu//SGabvPUbfhYP6JzlcX9UNSkrNG/EKYX3CZ
GGoUnsxwh0n3lGOf6lc5cwk4ZybqwYHji4BBNVmmGmsgzcjVrX58712XbXdVthNy
w1K9MTJ4elPrgaBrf1cJAbJg+7u7FA9zBxWm8f0SH90Jx65fix63zAvi3chfcqvE
F6QVAGJ2LDWljB4ggXkHsUgt/c2sV7yh5zFdGKlW+6WJu5UC6rf/kV46wL6ORFuS
LWbVDp2LlyVEVeBAG6QswHuaTsPxEA==
=3tAL
-----END PGP SIGNATURE-----

--MQgaS3VPhLaQvzhS--

