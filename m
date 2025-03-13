Return-Path: <linux-kernel+bounces-559355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E45A5F29C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7922E7ABB77
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE7266B68;
	Thu, 13 Mar 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsq/XEy9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDD11EF09A;
	Thu, 13 Mar 2025 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866049; cv=none; b=UfecI9WnyjJ3UTNU1G01Tuut4JXVOJMhXSpAtI0REc73UkZEi+pww+gRhYUD3CquxWTFUdJ1puydYElpp/G8byjnSDv3URCWaDE/v8vMdHKl0NUkfGtTy9lTQmAO6X5oQzFFl7U0mMZJRAfR+P+g/INvedEDIr3qlB1nOtt8loA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866049; c=relaxed/simple;
	bh=q7TtbufYe4DY8Qdh09Vs3wNFHZmInyzpvykuaGqfM7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ie5k3vWIEKe4toA5rXD7bvBTItVZmqeGwtZoRtGDf6LQOZE6KVwuSmB8yxoBdfGdh55QLYlq6pbMGKPrN6Fy1+nC5c9/qzoKeMMatWepfcd4waz0Jyguz0JfqOD+LxC5Ao+ZyFhDImdWgPgo9c+ZaTVUe02/lvqrvPnaBicgFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsq/XEy9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5499d2134e8so1056384e87.0;
        Thu, 13 Mar 2025 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866045; x=1742470845; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYzITn99FYNV7TM20mtLBPXFKmeuxgoI/hlAaZHsv3k=;
        b=Jsq/XEy9qTCW6HPLcxYAfb9csqKiD4XPpFX5zNmYTBRrHLtN+0EgeToCl5KlavnPlY
         DEyueS8xbicRT3HqFbhQNg/RUFgBqZ9PMuRfNkNa82Q5l0/4JsFFdr3EvpdCRfiCOF/E
         2RWNjMC484ZgIKypntNw/0MWC1sFcOXcTd5W62epBE4O9YuSB87C39/6wwgfci4lLThd
         ZOvE/bd0Sv8AsDLB++vertMdKs1KIiMiNflzO9MWXaTToAhyKsD5yNtwiPMwud1/glHO
         ba+gcpZGUtJ7rDQ9o9YgKh/41g9MGx+RmMAITnwtTP/FjgRP6uXmn5lesxgqIIKjcEhs
         Fv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866045; x=1742470845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UYzITn99FYNV7TM20mtLBPXFKmeuxgoI/hlAaZHsv3k=;
        b=IW4wc49GIka+iGjnop7Ao8T1KmBHHnVbGdLj42oVLQJ7tPDvXB2FQPmsmjHTCh30uT
         kz7gWyujjDidDUoZrWqsKLiwVsNpuHY2vFAko/wWyVW6YddqnK6IZI4uQt/vKm4CSjFY
         PlPEDKPOsiOc7KHjJl96/P8RAwMz1VOl8EOshsbCqjHwL6HexbpX1IbDEcmDMMzQFWAl
         Lb5LqIhMjjuhBbli4oVca8VREL7ds/yB1zv+2HZevJSWoWSUE3Sb62NPuTdnzQ91qb/6
         jeHuT5HemX1dhdwJTsr+bSAMmqSIdlTJ/mu1SHbcxx3eYsODUiCPUmqt6PxfhHIlhCcU
         1MLA==
X-Forwarded-Encrypted: i=1; AJvYcCUeoN1UAuEsx7DVGz1BBoc1bucsLf+3t7rDGCs0TZ7ChnAQxhNGiHqFgi3IHOyRQ+fQeOfHoDsMdJnX@vger.kernel.org, AJvYcCWYXd0ZDk+oHzaDxDXuwaOv1DdGwKS9hx1UEVDotUyKCWrZxrOFfZtws9KK8feUJM9I47D/OGAS5SrBi5zB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/MTMxSgCPMlcgE3Uyqju5EXuUdMToR8dK/OpYrsmdOcOjjnYv
	/d0QZgGPAfFqvnbCbQwUSHpBKQ8a+uptUGSdXSk/JizS53SCsqs2
X-Gm-Gg: ASbGncvSXiXJtPaThsUGJbKBOcx9FJ+2G2yvnN9eTkoTS/tqCsZbX/q9yK3FTvq7Qi0
	BXR/r7ZnHdqRxNqfLy103yIOJWI/4iuBCUqucqdXu7fo8utYuC6VZp1kjDmrBlTOnCXyYBIeh6Y
	txH/kvKtiERQc5pNCSg7sYXBvWevKdHa3/e4IcJot3lh8MddYM8tAbSoAjBdKF5xbhhLmjYkvt+
	I0UYAs4oLWyG6uHp2ZpjJ4SUPPWf3cU/5szf/WflM9/ZT8u1VOLop9QNw0dspeKuusd7JNJzUuZ
	mxjdAxnIhIqREPmC/ozGiay+oqKpYFzQBqC+qATDPoX8COKr2L0=
X-Google-Smtp-Source: AGHT+IHskF1RABXC1t3A3GJ0pYP3k9gCjDQL0O3SzmXfqcJulGUDCvuu9Lx5zuiYx6QH/HSR7x+b/A==
X-Received: by 2002:a05:6512:2396:b0:549:5769:6adb with SMTP id 2adb3069b0e04-54990e2bfafmr8423957e87.5.1741866045150;
        Thu, 13 Mar 2025 04:40:45 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a73ffsm181324e87.216.2025.03.13.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:40:44 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:40:32 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] Support ROHM Scalable PMIC family
Message-ID: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xu+pkgG4tCokwqcd"
Content-Disposition: inline


--Xu+pkgG4tCokwqcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD96802, BD96805 and BD96806 PMICs

The ROHM BD96801 [1] and BD96805 [2] are almost identical PMICs what comes
to the digital interface. Main difference is voltage tuning range.
Supporting BD96805 with BD96801 drivers is mostly just a matter of being
able to differentiate the PMICs (done based on the devicetree
compatible) and then providing separate voltage tables.

The ROHM BD96802 [3] is a companion PMIC which is intended to be used to
provide more capacity on systems where the BD96801 alone is not
sufficient. Startup sequence of these PMICs can be synchronized in
hardware level, and there seems to be some mechanisms which allow
delivering the companion PMIC (BD96802) status to the main PMIC
(BD96801/BD96805). This patch series does treat the companion PMIC(s) as
individual PMICs and allows using them from software point of view as a
stand alone ICs. From the digital point of view, the BD96802 is a subset
of BD96801, providing only buck1 and buck2 regulators. Please see the
data sheet

The ROHM BD96806 [4] is similar to the BD96802, except that it does also
provide different voltage tuning ranges.

This series adds basic voltage monitoring and control as well as a
watchdog support for these PMICs using the BD96801 drivers.

Similarly to the BD96801, these PMICs too have a few configurations
which can only be done when the PMIC is in STBY state. Similarly to the
BD96801, doing these configurations isn't supported by the driver. The
original BD96801 RFC [5] driver should be able to cover those
configurations, if modified to support these models.

[1]: ROHM BD96801 data sheet:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/switching_re=
gulator_system/product_brief_bd96801qxx-c-e.pdf
[2]: ROHM BD96805 data sheet:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/switching_re=
gulator_system/product_brief_bd96805qxx-c-e.pdf
[3]: ROHM BD96802 data sheet:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/switching_re=
gulator_system/product_brief_bd96802qxx-c-e.pdf
[4]: ROHM BD96806 data sheet:
https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/switching_re=
gulator_system/product_brief_bd96806qxx-c-e.pdf
[5]: Original BD96801 RFC:
https://lore.kernel.org/all/cover.1712058690.git.mazziesaccount@gmail.com/

---

Matti Vaittinen (14):
  dt-bindings: regulator: Add ROHM BD96802 PMIC
  dt-bindings: mfd: Add ROHM BD96802 PMIC
  dt-bindings: mfd: bd96801: Add ROHM BD96805
  dt-bindings: mfd: bd96802: Add ROHM BD96806
  mfd: rohm-bd96801: Add chip info
  mfd: bd96801: Drop IC name from the regulator IRQ resources
  regulator: bd96801: Drop IC name from the IRQ resources
  mfd: rohm-bd96801: Support ROHM BD96802
  regulator: bd96801: Support ROHM BD96802
  mfd: bd96801: Support ROHM BD96805
  regulator: bd96801: Support ROHM BD96805 PMIC
  mfd: bd96801: Support ROHM BD96806
  regulator: bd96801: Support ROHM BD96806 PMIC
  MAINTAINERS: Add BD96802 specific header

 .../bindings/mfd/rohm,bd96801-pmic.yaml       |  10 +-
 .../bindings/mfd/rohm,bd96802-pmic.yaml       | 101 ++++
 .../regulator/rohm,bd96802-regulator.yaml     |  44 ++
 MAINTAINERS                                   |   1 +
 drivers/mfd/rohm-bd96801.c                    | 549 ++++++++++++++----
 drivers/regulator/bd96801-regulator.c         | 447 ++++++++++++--
 include/linux/mfd/rohm-bd96801.h              |   2 +
 include/linux/mfd/rohm-bd96802.h              |  74 +++
 8 files changed, 1047 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
2-regulator.yaml
 create mode 100644 include/linux/mfd/rohm-bd96802.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.48.1


--Xu+pkgG4tCokwqcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxC0ACgkQeFA3/03a
ocWaLggAkBdvhGSQ9McZHGZP8IzxA2sVUFBJcBXqPuYi/7WXlf/Uj2xR6qvN168f
2naHNEmM3LmCHtUXJxvdfJPsMt/Aa2/mF+6VEYKRwTolQBhKp9aNK7POuDA+pNNp
qsJC1etHjBB5850Vbv6hTu97vVItMF3GwF9Qdc42ocUNj/mldVDhm3kam6esAgy/
PphspALZxY5yNJN6FuvdFTTfQNZm4EbTnnvwjMhusOC5Usdkuyv9CsetcCO/FPGq
uk8QirRAV7YBhB39EZgD+5g6eE1NjffdcGdpT7EULR9eLgGCkbvMY7WBBIAx00OU
zj/xXKHR3atBE42bDCmBj0WkGQQLwQ==
=AZgR
-----END PGP SIGNATURE-----

--Xu+pkgG4tCokwqcd--

