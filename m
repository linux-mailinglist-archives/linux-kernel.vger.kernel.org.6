Return-Path: <linux-kernel+bounces-301012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086A895EB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A981F210A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055351369BC;
	Mon, 26 Aug 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhVj1oAT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E638745F4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660075; cv=none; b=Q/3/tvQe0i8GLlb/zcPPwEpmWKseue4wx/17CBKYkik4s2S9CW+9Ev+bxuNMkkNWRfdN2DcMcIxmqiCZ5IUXLe4fr3Cr5IFyqwWh27L3MIpxieUKQumhRuHej4lsA6PN1rUFVuLRLNOj0WgjCAYnpZwghB/auS1rjY3IN5L5ED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660075; c=relaxed/simple;
	bh=FZm9UfUUi2TEdOXkUaCNDzvEb5QHu0her1IGKBTDy80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QqkldjSrZIJQEEgs7ri8uUDeiZU3EooSJMPkS4Zkosqy3fuqxw+M3AIRO88piKOSd9ATqMARZksx/KmHxdHdWEZXso8471nZ7HgvIsPl119+536deYcDgxhh9eHlzwZ3xb+RSVRwhyhT1FIyhk2tOQiJA+0YfNYypP9b2cEOB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhVj1oAT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso35973911fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724660072; x=1725264872; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLdxwI418mS4I1m/YKHKxJHCUGx3go/gy+3oXp9zknw=;
        b=bhVj1oAT17gjeW0xbuOsSi/OXWCBBK4+wtpf8nVqY7mz3rCWdrbcCfLzqSba9xe9t6
         RFfa0eNuEv51MYlbpk0iDcUcl+hlblUKwMFCg6O1u+MD+ptgXnFzuuvTTcmRHKbbuGOS
         RnA+PeGo5rXrpIrRNHMvmFKEmYuysKzvcIV7YgoTbhlfpijbkj9tkzDIRomRP5tgtXN3
         lG4ZgV7ARwi6OO6qD9iRVceqeEmTJ9FK7EpRwnofBw1jy2W0F3aJaZ5pO4B/FMhMWFCw
         WC3YvIVIypCEMslz9gq6sN4XZ1dNgIJzQtCcr0tVkVzZBzTfKY43NUCv88Nb5R7SSXum
         O3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660072; x=1725264872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLdxwI418mS4I1m/YKHKxJHCUGx3go/gy+3oXp9zknw=;
        b=a/qVRTfvqdlmD1QflYajgMyhmRoQT3KIJIfv3mJHxjyq2MCB7g51hr5iEsmxBGIsNf
         vOtgs+UMHga6MeQ2c0IH02cOAN8cl1Q/DS5jpgBTGwxnmNConmuZp6m/ZMluemXG2y6M
         YKg/o99d8icSHSwVzwBSquJiosQ3UYMK2W1x1bxULnsXB3RYLQwPFjslxUKPDrjqunwQ
         mvT8vaIdUobt1l3itvDd2jgB2yAileODTLth36g0kBCW3uDGuctFGFMo2dYMCEWHM8PT
         eg4PH8k76BPqU7//HH+eQcy2GAnLAFHteb+yvyPzLjy+6Yh4KVk5uAcS++x1UQZJPj6J
         f2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpNe2IXTxIE7ein/VOL/cNl8pPsspx1IYV50KKLsfNGg+POyHhoMY0syGPzU7xc3nZKHoDVbPZ07pfwE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MpdDUxAfdLyvsSVGhwAyEUz7ct+XkSXeuVsXPUYkdYTpC6HK
	kAIRGFbaGrNvHzks3z/Y9X6acGO1JzKxaNP/zv5XCR9nPpsQDYstLo0FeA==
X-Google-Smtp-Source: AGHT+IGtguPvYVu1heSt9cfVCj5uNxWUzHVqQEYuEJOV2HoRliG+/L0P3wfuYqbv5lPRKKHXucgllQ==
X-Received: by 2002:a05:6512:1394:b0:52c:dbc6:8eb0 with SMTP id 2adb3069b0e04-534387799a1mr6565404e87.21.1724660070804;
        Mon, 26 Aug 2024 01:14:30 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea594e9sm1371610e87.181.2024.08.26.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:14:29 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:14:21 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ROHM BD96801 Support ERRB IRQ
Message-ID: <cover.1724655894.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8jf5ulyB4bXPvdos"
Content-Disposition: inline


--8jf5ulyB4bXPvdos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add ERRB IRQ support to ROHM BD96801 PMIC driver.

The BD96801 has two IRQ pins, ERRB and INTB. ERRB is used to notify
'fatal' events so handling it has not been mandatory. However, there
are use-cases where handling the ERRB interrupts may be beneficial.

---

Supporting more than one IRQ pin in one device, using the regmap-IRQ,
caused an IRQ domain naming collision in the debugFS when device-tree
was used.

In order to avoid the collision, support for adding a name suffix to
IRQ domain was merged in regmap tree at
commit c69bb91c47e8 ("regmap IRQ support for devices with multiple IRQs")
This is required for the MFD driver to compile. Hence this series is
based on the regmap/for-6.12.

Furthermore, there has been a few (trivial) fixes to the BD96801 driver
in the regulator tree, and thus merge conflicts are possible. I can
re-spin the regulator driver based on the regulator tree when there is
a branch with the required IRQ domain and regmap commits as well as the
MFD driver. The MFD driver with ERRB support is needed so that the
regulator probe won't break for the users with the "errb" in
device-tree.

The ERRB patches were originally part of this series:
https://lore.kernel.org/all/cover.1717486682.git.mazziesaccount@gmail.com/

Revision history in the patches refers to the old versions in that
series.

Matti Vaittinen (2):
  mfd: bd96801: Add ERRB IRQ
  regulator: bd96801: Add ERRB IRQ

 drivers/mfd/rohm-bd96801.c            | 276 ++++++++++++++++++++++----
 drivers/regulator/bd96801-regulator.c | 130 ++++++++++--
 2 files changed, 356 insertions(+), 50 deletions(-)

--=20
2.45.2


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

--8jf5ulyB4bXPvdos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmbMOVgACgkQeFA3/03a
ocUjGQgArSbKLvStp10MxHlBvSaNSy/uMRzpOSdSNO+7wzcfbQJ4oY+lDETamYfQ
rynk/XvC3q3oOPDPVXrGNUYTqP0FouylzFs6bUNxm6SwdGzXSRL2YDj9fEnzjvfe
xUm2yXmGtBCyGzJyhNqLalVDwsNR+XXZCBz0vSO72OW1LQuZfcyC6pzlYky+VC0F
4IbIkDAlDr9XC5CTQUEl8GXEykgQZOlK3xsEXqNrydmJThjtO73FIW2sPYL7e+gA
waiPH99DwvL77ZBZmy+Cjfa+R0iqRH68N+N1cPxsVOGoEBbvNmncC404Ya1tWGQ7
jwuy9B/yMpdmreINmc7V83WQ9D3oLg==
=zCKK
-----END PGP SIGNATURE-----

--8jf5ulyB4bXPvdos--

