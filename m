Return-Path: <linux-kernel+bounces-236091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A72CF91DD4D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331511F2329D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE5213F439;
	Mon,  1 Jul 2024 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmWHyzLx"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6A13E41A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831516; cv=none; b=S1oKeNP+9eVlYNWPDJRIgoygQTEI/M0wA/8vd/zhjUt1NlaeGpXTp2X0rDIH5zID+eNhF14Eotb5UvpulLIP0J5ikdZXFZYddQtJEJXJq+WvXLfoqjSr0B0TiHRx9JQ6k7jmmE/XsNz/QovXV6l1T0GuAQsMQZCHcTbLwsXV2PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831516; c=relaxed/simple;
	bh=vi1zKS5QWXf24NqCQMK2rqOOm5imdNwU8IGLd8N9Z0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bWOLdIVodM1onlt0V4iytgEkl410kUMuT0Us+JV9sg9/Pia7BLmLdOy/zARomqtwEAJUv0bHoOqGmPPWYiVdi1xXXVgallXWRY0PHJdTb+s7Jc/vt3UlDtpgwfwFYjo/uUCsWouDDk7riSFsNedOTvbC57iJBwH385UNq1P1oEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmWHyzLx; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e7693c369so3683489e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831513; x=1720436313; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HIWPigT+lU9Tq1QonutX2ZbsITp2ocpK5f0GcEPPTOU=;
        b=KmWHyzLxbuFny9zds9S+gmkoQKBPPNAySJKYDQ25UIk1t2mM2YQtlLHCpmL774qTcR
         R6ziNiRuBbpNZrStCN0qaOZwAf2byXkspT6hCu2QrfbA+vhEyt1hvwJ4b/5lSzdftbM+
         j49TA0awrM+20+n1x3LeDUYpKzROMqluqnTvG1ZwCzQgb+vlIqKE/GM01k1TT29eKclX
         A5aPL7e2qICw/rF2pT8rWNuPv25/nBNrsJff1H7lhU/+0m51uNc2cGP2bhjbmuIiruOD
         9L8CP0Z+vMqLIbAIWT7ACs0v9690A7zm3g2C3Hk0O664l5EkSH9BR6CqFENVx/lEdhyu
         yB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831513; x=1720436313;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIWPigT+lU9Tq1QonutX2ZbsITp2ocpK5f0GcEPPTOU=;
        b=iDA4bADaqXvHVFu0g0y3I2gbzSNYFP5uarl6ygl+NVzuphWOGGiks49W+Rmo8dhd5B
         E8UxttTee3n08l+R41jxNIN2DekeVnQaTCAd2NBk6P0UVd3gHb7kZ4AwBOyhyql8rDNR
         DxqGn7yOX2ZlLRkRnqfpkEJ9ZgGSCTsw7P4edyUIawJSbXmBwZWjA6hwFI3lVZV8MGHV
         awgJVMYfSeSDkTUxWcy/jvO416gbXARIZFJ9eTRMf2n384ZjRK9/lK1EyxqvhYv7e8Jm
         xUoYKkEWrdaP4cLMFsg5sQ4ZFjf+pTwsIeiK0O5IAkQNXrJEqrtYVSlQ7BJzIz9Ll+t0
         RWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWczCKHxxFQ5ZGF4AimmA+2f3C4MiYBb6ETPXl78U2QajYxLz1pGk+DvAmaetao9mJLJH+Fdr3SQRcdwqIvfW88dtkY4xgunHOMATfM
X-Gm-Message-State: AOJu0YwYUDQ0ZB/rx3Wr1vbRlAKKJrghXc/KJMDpPHlYVXY9SdfNbfCE
	n0mLT+qoiwGKn0jQtJwYna3lJ3K5IbyS+yI8wAaOZkBvaefEFq3s
X-Google-Smtp-Source: AGHT+IEgTwJyqYE1S/mVI2l4G54YXLgApVQSlnw3Ms5luFx+SU2eYpVt6qv10OFEpsGIwlloNvBXsw==
X-Received: by 2002:a05:6512:1253:b0:52e:7ef1:7c6e with SMTP id 2adb3069b0e04-52e826f12f2mr3307850e87.51.1719831512484;
        Mon, 01 Jul 2024 03:58:32 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3f7basm1366337e87.305.2024.07.01.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:58:31 -0700 (PDT)
Date: Mon, 1 Jul 2024 13:58:18 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] regmap IRQ support for devices with multiple IRQs
Message-ID: <cover.1719830185.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mZGSyFuIIxYwpRpe"
Content-Disposition: inline


--mZGSyFuIIxYwpRpe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Devices can provide multiple interrupt lines. One reason for this is that
a device has multiple subfunctions, each providing its own interrupt line.
Another reason is that a device can be designed to be used (also) on a
system where some of the interrupts can be routed to another processor.

A line often further acts as a demultiplex for specific interrupts
and has it's respective set of interrupt (status, mask, ack, ...)
registers.

Regmap supports the handling of these registers and demultiplexing
interrupts, but interrupt domain code ends up assigning the same name for
the per interrupt line domains

This series adds possibility for giving a name suffix for an interrupt
domain when regmap is used for devices with multiple interrupt lines.

Series is created on top of the:
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

which contains the changes by Herve Codina adding both the
struct irq_domain_info and the irq_domain_instantiate().

Previous discussion can be found from:
https://lore.kernel.org/all/87plst28yk.ffs@tglx/
https://lore.kernel.org/all/15685ef6-92a5-41df-9148-1a67ceaec47b@gmail.com/

The domain suffix support added in this series will be used by the
ROHM BD96801 ERRB IRQ support code. The BD96801 ERRB support will need
the initial BD96801 driver code, which is not yet in irq/core or regmap
trees. Thus the user for this new support is not included in the series,
but will be sent once the name suffix support gets merged.

---

Matti Vaittinen (2):
  irqdomain: Allow giving name suffix for domain
  regmap: Allow setting IRQ domain name suffix

 drivers/base/regmap/regmap-irq.c | 39 +++++++++++++++++++++++---------
 include/linux/irqdomain.h        |  3 +++
 include/linux/regmap.h           |  4 ++++
 kernel/irq/irqdomain.c           | 36 +++++++++++++++++++++--------
 4 files changed, 62 insertions(+), 20 deletions(-)


base-commit: be5e5f3a1120bada0cff1bc84c2a1805da308f6e
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

--mZGSyFuIIxYwpRpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaCi8YACgkQeFA3/03a
ocUi+Af/e/gbNHEJRUXrSE3vIOINVgiIPLfZB+2d7oGucbf2G9p4Um7rb39AtGAa
4oaV8n4r+64gD2H0r4vT/bJREsnHzKbqGddfKx8aHEaGMXbs08MJWpTRcPNwmD4j
dwbAAKq+NCHLzI5+u1HLRQhE4haoKDKFLTDXd5LyyhYhJ2vZvv2wLYD+UYz/zZRD
vBA/Fun9Y5DeVDq4RfTzMVBTDT2phA5rbPyZfRFva4ZlkYXvzcweuTlXNzGWIBCB
srdyBJPbK+S782gKDHxO7m4XKZwxGpYAXtH89EaOsniVCdPa2etLCccBykNS1KXr
QHZusItUZ8wdaviE7uBtfUr132UG0A==
=PaHg
-----END PGP SIGNATURE-----

--mZGSyFuIIxYwpRpe--

