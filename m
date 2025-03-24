Return-Path: <linux-kernel+bounces-573387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA68FA6D6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D9188D374
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB025D556;
	Mon, 24 Mar 2025 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuzjbY8i"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92165FC1D;
	Mon, 24 Mar 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806480; cv=none; b=ritxtSvZ5snp9H+9c9gxLQQwHFP2dg52/VOrWKR2e2S3zKL36YG+mn2jkb52Yv82LA5L8ME2NUzARKqModaqGjaqmjWWovHwGTUlJ0zC3vixFLmidIjTpGzjlFhYOKxxrPPodOqOiif37IUJJduXqExclhVzCyLQ5LIEzPJnxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806480; c=relaxed/simple;
	bh=bbXUljvonVvZM8WQx+vMddlPHs5mXRSXF5emQSLw65c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cDsERDKr6dKDYVcUQ7WZwBkIt1W3SdYIdr/yjlk7CoA6iRfK1BxD8fSWuvYKiIDFPh3KWNOPOX/h5W1LeMH+WshRbZgGOI59TzRtP8XfXcx9RVH+UdDCzbjLUmy6k9sHlcJohS2ICv8YXCjfxtEdpFKSyHkDH8y8Ld5qTOeLHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuzjbY8i; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499c8fa0f3so4902433e87.2;
        Mon, 24 Mar 2025 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806476; x=1743411276; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQMyCn24BEhr98hR8P1jkpU1lfIklyXGFnieEZhcyyg=;
        b=JuzjbY8ilwTwrKn/OXfc6S3/7LVowWYqYTCEWB2MKRLV8rswTHpu/x9YA5595VL00L
         EYlLQEsn+7x1IHHPl9bHero1VPjs1mJsFHO+xALuLwzPmkHDqlGHTaLQSmwmDN+FFkC7
         b821mhFYcS/w5VeLFPTi+BaQa+N3EW/RuGWEhtwrmVzJX9MtU/2YWloFdMVFbP8UmSRp
         mIIyXWU4vU6Cy+ckpdq6gwZVw7m2NF8bv0JDMnFJLGudpRa9CzrxNDKDxshThTxVgVFw
         HeTxlKsXAxxSJYf6Y5ekQyxpRTMpk9TqfYdwFVXzJF78bMjEm12IMxETNX2aS6a5SBWd
         GNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806476; x=1743411276;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RQMyCn24BEhr98hR8P1jkpU1lfIklyXGFnieEZhcyyg=;
        b=IBKs1rhH6E5yVS3xnoDZrTbN42l43gQnYRBkPA3k2nwxvqBKxzmhlIaFjIfK8sqke3
         E9AGsqnyZ2sDvtPQiGGz9WC7Q5xTW1z4j8eHt4sq73Z5Ze9inRi7sonxZkLZ3lOiSosm
         U5mIrdopN9Zg5r97+kPolTOr8FUMZ8t6j810GAc8OAlA/jFlwxPlQUTDVsidL+CWr05J
         0QzIYwaRg2oV3F3KR2lU7YW+bfjO5MPqv12qb4zWRJeub61L2BOQuBNYcL/TaMYp9y85
         JEt0afC+RYO6xAvk/PqRHtkjr3dHlqdECrcGG0vTgpModlgALCh5NXmqfpga6tr48/sw
         qdYg==
X-Forwarded-Encrypted: i=1; AJvYcCUXe3HIIzLMnM6+n6GkHgHZ5mgJJjKy9BvABDTbIBgICgUAuOMo7rerB/5XQoTSsRLiLrLFj4LpbS3r@vger.kernel.org, AJvYcCVsIetMRMDahQ9YrDZIF38CVrmVxnWV5eyKeoCtpXDO3l0zgpi+PMmXQht0K2X4OwH6E7nK83+dmaJSlLP/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8QhWdAzx1UQ38aF4hRLIeycsR0glndXgeEa3kUaWPcke2QNt9
	kCfFcb699PHSD78e2YuHWrN5ulJul4BDlSzwGpdB60A5wJF0/IfG
X-Gm-Gg: ASbGnctUVycA6Q3C6vaJDuDUUrM3pm+f3PRp7ycAu+Hw5sTLEqyNXR82Y+sWi5JCpf8
	1kMpSrLwdylyBi9A89XTVCXv31AmPc2oH2DaYcsinej6UGPrAeccbC4IKtKKlBNJJ4+5T/FXedW
	Av0RPOXvqYZmEGbM3jxipfFXtwyMm2Elejf1MyQjGu2lEQve12IGSXNI+aEl3rUWI/AG/TqRfb7
	q1Nve87niQzF+MVO13EsUEHJz2hgc4fXiuJTiyKA8xqAxfwBJPbtkaZJFHMdBrNO+8kL/QYBriV
	NWMZsjXZjhkBr09AHpRHgetaRhtQ0KV0cmA+G+OGtvFB3JROPs4=
X-Google-Smtp-Source: AGHT+IEGF7GkFYKhn6esGBh8n1YN37yfubkNZl1tdOxWgly6Msb4Xq9aF8NHwtEQVLQZ2TakWAw2Ag==
X-Received: by 2002:a05:6512:3ba7:b0:549:8963:eb04 with SMTP id 2adb3069b0e04-54ad6502c93mr2736740e87.40.1742806476110;
        Mon, 24 Mar 2025 01:54:36 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6512143sm1053903e87.228.2025.03.24.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:54:33 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:54:28 +0200
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
Subject: [PATCH v2 00/14] Support ROHM Scalable PMIC family
Message-ID: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2zIDuTP5DyUIDmSZ"
Content-Disposition: inline


--2zIDuTP5DyUIDmSZ
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

Revision history:

v1 =3D> v2: MFD driver changes after review by Lee
 - Use enum for chip type instead of picking the data directly from the
   of_match_data.
 - rename "chip data" variable 'cd' to more widely used 'ddata'.
 link to v1:
  https://lore.kernel.org/all/cover.1741864404.git.mazziesaccount@gmail.com/

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
 drivers/mfd/rohm-bd96801.c                    | 565 ++++++++++++++----
 drivers/regulator/bd96801-regulator.c         | 447 ++++++++++++--
 include/linux/mfd/rohm-bd96801.h              |   2 +
 include/linux/mfd/rohm-bd96802.h              |  74 +++
 include/linux/mfd/rohm-generic.h              |   3 +
 9 files changed, 1065 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd9680=
2-regulator.yaml
 create mode 100644 include/linux/mfd/rohm-bd96802.h


base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
--=20
2.49.0


--2zIDuTP5DyUIDmSZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHcEACgkQeFA3/03a
ocX8JAgAmJbF9JHLwAhyXIzCAMxOUB3DT4o9LiHvj3sAadGnZIAWHJmuhVcfRpd9
nfCHNE3TfV1T/FZ0WoYr9+GbhedoRYZvwtSX28zK/kvzfJ3HXXAPZcuOTjUAf2KO
5WvU1W5TNz9KtEja58XjMxXpecjL04gYqTRZNal7dv/RsPSWEZFJmnaelgZbqYyV
EpfE52EIk+BbZ3F9qKMmI3OYr1pOB6214qq8u2VW8gtkHD2oCmXmWk1oHqZdpsjJ
Fc+uLh1S0r2FGtsp88fyoDxFaeAuwGhsPwSe6YrMJ5lfyL3zOvSsPJx+UqA4NhpC
8coz4L8TaXJbY/Enhysb+IqKAG20BQ==
=va0t
-----END PGP SIGNATURE-----

--2zIDuTP5DyUIDmSZ--

