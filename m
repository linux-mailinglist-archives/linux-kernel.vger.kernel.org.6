Return-Path: <linux-kernel+bounces-188454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918068CE23D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC9FB22290
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96560127E12;
	Fri, 24 May 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQPKLIu1"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD75B1F8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538761; cv=none; b=P3RuIoEDXohEZg1vNbgo/RQxF4fAlSvq72WPLkBbpiySebOho1mXsn8JONYKR1Zi+ugg0Y51p58/AvjcIyd5o/TfbuOQxMScUflveFC+J1FjNW6MO/XdxLci9C6ZkTabbNdpGKt+rX0MldR4yzRK3C5GqRKWap248XtQmU2C8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538761; c=relaxed/simple;
	bh=lIC8PATib4ECHZvoRaJcqvbW2iLxMzcGASLxpvYW2uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5P9oF++4XtfhpOdWJHG9KVuMaLX6JX/EkyCtaNwt7yIlmUByZuS8KNYvc11ZwcXNIEw+WcbDQNG303ZL3yKj4JHYSY0bjNIVylaqOxQz/aTkBfIiCyOE5SkvikSi3x06uRrOTUo9/6WAxLiPjJ2612HzcNw7n35Aqe0cU5+iSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQPKLIu1; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52962423ed8so615824e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716538759; x=1717143559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+oz6UCrdb1975kB7UeAyVPQIZ7iHx46ETbSo/v9u0/s=;
        b=bQPKLIu1q7SirVMXU5v0Q6TCxZmzVaTyUxf+KcUpZO7pTuhVRQeU0R2CNNudUuRUr4
         5PL+VeRFVOKHiMN4OXu6FPf1l/GakjPJsG85TSM2dhPYsXCeIja4bIArUwDhiFmqCljN
         bVMfzycH1wXp2+VvI8VFWk8jLSSlVk0hTZ53sRCt7GYl3po9m5FV/SOM1rSmQM9l5KfA
         6ftko0IDsunqi1r/Koq0uFN8jXT3NK49S4uPWdqFGleItDrj+aZX5TJtkadmngTbgoUX
         NKg5TP6f1mlVnDqPznFCB0Jz5+2hZA0LP2DlceH0/jZn0Czz+UwKgmBMH4exJK/5yuam
         RH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538759; x=1717143559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oz6UCrdb1975kB7UeAyVPQIZ7iHx46ETbSo/v9u0/s=;
        b=ZEFwBgKqoOK1X8DFaSPCoNy1+27pNdFKKYv4/9dfOEgz4LDh+2QGSajunz2b0uOI+q
         /zZQtlrOMb7BCG166H6yUDPyBiJpzGrnMImOf/R364fvGlfWYvOA+9nO3+MzGPxnnLRV
         z+aEIEgOI/9sU2Ew/tobJ6ygUIWRRQiVdxVNpB+Np/6sw4kvVpTId40SIfyuRrOy9pgr
         zEKXFpflw4bMQTSMEzXl18kRXFB7bvHatrcaqbXL7KckIJmIW9qvjFKdB0p1G4SkQoQ4
         5iNg5E+09jtIJaSyi1kz+wbDSn7m4AkPy/GDSQfYzpnfugkXEmlKQruA4U6zcpaDxO2n
         XdBA==
X-Forwarded-Encrypted: i=1; AJvYcCUD9RAaPcHYG6kYrMoexBHsa2YlmIDBJ+MV6v7ZC6pxvAR/AvhAKTxms/4rZTifrM+YS5eywZJhv0CHzaaXULO9lsP1NiunRRTH40pG
X-Gm-Message-State: AOJu0Yyv05lH7HpLXSYqxp2TKJcuYry8PAz5pqgKeqT/+Bl+DLAMwo6a
	QASRS7uCnGfVeYYS8K5QHayE75D2v9IHPyXPOL2mMowP6Il2ycmi
X-Google-Smtp-Source: AGHT+IEJFrVeq18UsKFlMIEcK87TozQc7K6bpPAfxPt+DP3SYXQFqwhPBkrQFe/r4Qqiy6ZM8WtmXQ==
X-Received: by 2002:ac2:47fc:0:b0:51f:5d0a:d716 with SMTP id 2adb3069b0e04-5296717ff6bmr737801e87.63.1716538758387;
        Fri, 24 May 2024 01:19:18 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b21dsm129380e87.173.2024.05.24.01.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:19:17 -0700 (PDT)
Date: Fri, 24 May 2024 11:19:13 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] regmap: Allow setting IRQ domain name suffix
Message-ID: <dc2c1d972a5553ce13f8df5d82e65a5a8c099f0e.1716533790.git.mazziesaccount@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pvvwC7uEUQRemi+8"
Content-Disposition: inline
In-Reply-To: <cover.1716533790.git.mazziesaccount@gmail.com>


--pvvwC7uEUQRemi+8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When multiple IRQ domains are created from same device-tree node they
will get same name based on the device-tree path. This will cause a
naming collision in debugFS when IRQ domain specific entries are
created.

The regmap-IRQ creates per instance IRQ domains. This will lead to the
domain name conflict when a device which provides more than one physical
IRQ uses the regmap-IRQ.

Add support for specifying an IRQ domain name suffix when creating a
regmap-IRQ controller.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/base/regmap/regmap-irq.c | 13 ++++++++-----
 include/linux/regmap.h           |  4 ++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-=
irq.c
index 45fd13ef13fc..e86964a9843b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -857,12 +857,15 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *=
fwnode,
 	}
=20
 	if (irq_base)
-		d->domain =3D irq_domain_create_legacy(fwnode, chip->num_irqs,
-						     irq_base, 0,
-						     &regmap_domain_ops, d);
+		d->domain =3D irq_domain_create_legacy_named(fwnode,
+						chip->num_irqs,	irq_base, 0,
+						&regmap_domain_ops, d,
+						chip->domain_suffix);
 	else
-		d->domain =3D irq_domain_create_linear(fwnode, chip->num_irqs,
-						     &regmap_domain_ops, d);
+		d->domain =3D irq_domain_create_linear_named(fwnode,
+						chip->num_irqs, &regmap_domain_ops,
+						d, chip->domain_suffix);
+
 	if (!d->domain) {
 		dev_err(map->dev, "Failed to create IRQ domain\n");
 		ret =3D -ENOMEM;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index b743241cfb7c..9df971986abb 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1518,6 +1518,9 @@ struct regmap_irq_chip_data;
  * struct regmap_irq_chip - Description of a generic regmap irq_chip.
  *
  * @name:        Descriptive name for IRQ controller.
+ * @domain_suffix: Name suffix to be appended to end of IRQ domain name. N=
eeded
+ *		   when multiple regmap-IRQ controllers are created from same
+ *		   device.
  *
  * @main_status: Base main status register address. For chips which have
  *		 interrupts arranged in separate sub-irq blocks with own IRQ
@@ -1603,6 +1606,7 @@ struct regmap_irq_chip_data;
  */
 struct regmap_irq_chip {
 	const char *name;
+	const char *domain_suffix;
=20
 	unsigned int main_status;
 	unsigned int num_main_status_bits;
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

--pvvwC7uEUQRemi+8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZQTYAACgkQeFA3/03a
ocWAcQgAyjYIua3DPCGfdB6p+8JV35kfPtGJAlFn2Y4JeUQ3S2Fcz9kxiBguPt7R
cPTtUgbTM62Go5CvTu0d6dX3zpyiEqaAlUxurh3oc386IKSi4RrSONRaI6+baIVO
J19Z0EgyyqY66oBgT3EPBcctGtL+7yyyneREeQyZDL9UJaQY+eb2RibCiTQPkEU6
giGr/Lwo5otz/WtDQ4U9USZEn/K8hVipCINmsB0Tcamu8sVriayjnpdAk1c3O639
TBnCrhD8th/vUoWVWDgzys7iWHpUBnn/NlENlDk7Lul22mAQgCqppOScWqU4rcR3
rw+AMkXVexeEesDyl9/+535gDJYjlA==
=LLTT
-----END PGP SIGNATURE-----

--pvvwC7uEUQRemi+8--

