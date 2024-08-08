Return-Path: <linux-kernel+bounces-279461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A83394BD91
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E5B1F22458
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3C918C357;
	Thu,  8 Aug 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS4JDENK"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17831487C0
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120387; cv=none; b=X+4lMhpWrqs0qeaBtQmSfYxXqLwTeNvVhE9mnqW2E3EZtcwDN58T4gT1Pq/QBLm3UwViGaaaXvu9/ciqFQa0UU/elRMFPXdRLtqF7fNH3i/xJYtfJb6Fq7cd3p5G/HSXPJf2S9l1wkB0M3O0UMi6oQ1Y5DgjbZtohhmwCAYD+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120387; c=relaxed/simple;
	bh=yffRsRzgKXFKgytHvkJglFC/WSteC7XEYWNMVMuA+yA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MwfhvtTSQk5aVLMFeLAVKKA9lR/pwsMNC+EeXyxT24G+LXLVyMIxUJCPLOI0OHzhwy7VbuLYtRn3wtPvRxTE1+8vuIHgNwuhIyIQatIgTHcmou6YSNPTOz9YCAmjvWxFePcWaQkZaSpzL/E+x8KFrCl3M2TRMazmXcX9WBekJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS4JDENK; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f032cb782dso9408331fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120384; x=1723725184; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsycpafsX59Hr3mnoii3gDASRVWj3s3g2MTaIisNO0g=;
        b=SS4JDENKB++Wlk5DribXJor+VmYNCTxBEYXh3OLVFs3TwVvYvblZZ9r2F+oCkMEhAg
         u4pg2euM6eQNY0odmWwssMF9TSYEDKi8mM/38nRavKN6prEVR6SXGNN8TXp7ut9sxCUT
         TzgbBw+jOBvDg3Baud0tICfEK8ZTBBGfWPRzeQZKcN2xvt836ieg79J9BCz1qHYJygAs
         kgAmEhjZa2NGN2KHBTHV+oPn9O5lEhc4lDyOjddkQqbOIuRGORxZwg9FVtZQ35n55ASc
         /I7pxORyXtkxPh+dvQy2kA7eOeuotVGtcoY/xYviXUuUtq//K82ClygywI/uKHbMJrWd
         0zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120384; x=1723725184;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsycpafsX59Hr3mnoii3gDASRVWj3s3g2MTaIisNO0g=;
        b=r5+CkkL/XXfygPjSmfgxpZ5wsyPQGvRrjiMwknhLe04C9Zd1DYog6+NpqBGqESNuzA
         bYMQm0OMrG/jGMTbtUjxnlIu8OKUsvQ9ri1GiVq2yXiyQV+HW+3Ep7DghUFp+gnwIjSw
         veutTdJ5isULz8d1nFvpZ9AXgH0+OyVKmpBU4tIzPRiDMSEMOyCe2CkNq3cf+6VAE9m5
         JXpSgtA2ZKWNqdG8D2Z7PcAE2I0X63IoZ0EepX5pJmqIckWSh2R0ZHngcfOMr6+7ZrkS
         EHbeJCfiJ+TxQlYpjZeh55l70oRygEsJkckChQKJiyooCVlcrVR9KVyL6PRblnNfzUGU
         u7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5IbuaGkg/pj2KwD/sncRfFoYyH7VM1SRTT+Jt2bl2Sf6RdaTx7dV9fAhc4TY3gDEAY1z2Cjz4SyhqgvFf7DL8S4k4bfcIhpCZBMiH
X-Gm-Message-State: AOJu0YyCrfsauxPog9WrsLSRLwcftatDWr3RVkKSm5Kx2yuKyB6tAx5U
	F1QtW90vt8yenQewRVsjySoLRyj1SqYNYwb8aF52g3KtuQXmak8G
X-Google-Smtp-Source: AGHT+IGplckda8Qos3D90YOd5KXBmivm+cCjrGJBUn8tXb8cbQHxqxJjPaubd0XR/1uJ67allkDO0w==
X-Received: by 2002:a2e:7a15:0:b0:2ef:23a2:7efa with SMTP id 38308e7fff4ca-2f19de3dbd9mr11569641fa.27.1723120382890;
        Thu, 08 Aug 2024 05:33:02 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1aea5bsm20819251fa.44.2024.08.08.05.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:33:01 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:32:51 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] regmap IRQ support for devices with multiple IRQs
Message-ID: <cover.1723120028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2yDqkgU+drjbb1i"
Content-Disposition: inline


--s2yDqkgU+drjbb1i
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

Revision history:
	v1 =3D> v2:
	  - Fixes as suggested by Thomas Gleixner. Mainly fixes to
	    legacy and simple domain.
	  - Added new patch, patch 1.

---

Matti Vaittinen (3):
  irqdomain: simplify simple and legacy domain creation
  irqdomain: Allow giving name suffix for domain
  regmap: Allow setting IRQ domain name suffix

 drivers/base/regmap/regmap-irq.c |  37 +++++++----
 include/linux/irqdomain.h        |   8 +++
 include/linux/regmap.h           |   4 ++
 kernel/irq/irqdomain.c           | 109 +++++++++++++++++++------------
 4 files changed, 105 insertions(+), 53 deletions(-)


base-commit: bb4531976523c6e394188c4f4a7eeaf5e9efdd48
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

--s2yDqkgU+drjbb1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAma0uu4ACgkQeFA3/03a
ocW+dAf/So3HXHyZnkgjbk9yW6jghUSGhqvQntjDG8Y8rxyUpd/0F9Jn0gygkLDH
sF9M9jAZtMaL2zu5wfwmGcEcgfc+v3o4NNeo5k5q2T8hdcHj1dpLfK6blJm0nwI4
t1oyE00VAiu0xM0EbzjcUh3hzsnWN+Ba/BVgz9Nt2iDO33B98tbbkB9O5UDwcTSd
9y2UQdqqnWOAV3tgnaArGHwoeBGRlWOEdhDRX/BX1qeeJV8xnSMPHdZIQ6QPv/Ec
zro24RaY9/0HQxj4GEMhUSU7AVIMMAFsu/4Rzzd0mhaYrZfj7+aQoOflxgNf22t6
qc+sEbcybWmEnMgzSGeQb5ORFuzWwQ==
=ntvM
-----END PGP SIGNATURE-----

--s2yDqkgU+drjbb1i--

