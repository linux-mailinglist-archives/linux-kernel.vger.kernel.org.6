Return-Path: <linux-kernel+bounces-236094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87F91DD51
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CC2B25790
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B613D503;
	Mon,  1 Jul 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQFp5aCB"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B012E1EE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831551; cv=none; b=QA5h78OGQ1h9xdqyV3hbRoYNK4CmVMskYHTImcE9+Nh3Y1oZUjxkzdf0CluColRHTBZwJ96zCqk1HqRoBqAbqAwUS0cnqwJoBvOG2xfBzaY11gVtvMhAfqOwHmKvHV2TI3JzrfbB9lkTJ64KKoQ9AXPDR5kA6tBXiLm6YRQXbXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831551; c=relaxed/simple;
	bh=AJWcK4W5ftFClyEqrpF7wXS0A2KWp5gtMzvOoNTIUo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlBSbKc2P1bWGX8M9JMWxStg3Gb6ZjGA8WU7aF2PQphYNj719xmgbCmvjf6Jf92YzhFQlQkOQVnBZO1iE1krkzf4AOJ+xQ9IMjxjMG6MmfPgEMciWbUCZJ40bSwxjip6hSZw36dUDrRzB05Ke3hUnTQyFjgnptCJxhoy9sqMNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQFp5aCB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52caebc6137so2146750e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831548; x=1720436348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfz0TMyxF38ATYWwYTXTKghaOOuHe//IkuNlNyFlQD0=;
        b=WQFp5aCB7F307MTgv5yPyWe5XbADsV1rqfgzuxJgVPwGVhm//1lhocGtXWnen93X5c
         Sh1X6Tkoop7np/BqnTl37rZlAA/6yZWkQdbngyV+uPxiPaN+oPMWePd9nRQ7CL+vuU+v
         EUSI8w/SQjSXWkYeSs54Gv0AsimavI0mk9OCkBRMK2u31EnBRqTjE9VRUOrO57eKUrSo
         8LGHMVr/Kw4ng+Hb9aohQyX9nJdhrRssU05zrhDiQcVlPHzfoeAf4ZT8Uo1SB8cRJUjk
         yO+3RLZL+9BHET1Ufk+nd5hqDHbnXPzo699FIbcLhQVs3X0YvPDjqUHQ/SU7Eo+LOKDl
         mDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831548; x=1720436348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bfz0TMyxF38ATYWwYTXTKghaOOuHe//IkuNlNyFlQD0=;
        b=nhf7hRRH9vmB6rOxSk47clyeL1d25Gxn04VSGfyPAYjTYg2vAp4/Ph3Y/KC2xG5OSV
         pugUpDGOrUKGou3N0GkPaALBFtu28SeeDzKAe3YlHCNkJYKmfU4R2k6JVIDvsnat+90H
         e44gMH/XGfPO1KMaV4rvtDf8qySs6qEYRa6pIhmpNcBRbSvNUU9xUEHuT7s9PSOXv0c+
         IbkpDoDNwqcH2tJeuKQVlNQzR0k/9GWj3+QvrWTCvcFGHlijHHo9+UXwCcOAkUpkyGAb
         8A4nMYY3zsP79gCjEtY0ckuSdA2LAOiZj22HntEBT8alHrweFUgqQknt1r+TgVgLmhZ/
         Sw1A==
X-Forwarded-Encrypted: i=1; AJvYcCVwsnbh2e+QrV0xstL6SgnJnkpv1/7ZenuuvqGYLeYsQwc+XFXcMCYz/cjXd9iMWVaeQbYG18j4ISdCJUjGbU/ZgqR9MLx33YJHszec
X-Gm-Message-State: AOJu0YwWYBI+YdoCAH6Zy0/xsar3D06WH3vYbIxOQfiBbnHk1WBQ+S1N
	QLAZCvRsWiYL94NowTAp+//8pG8I+KC8Om1qcoY1s4VIIpyIxLX0
X-Google-Smtp-Source: AGHT+IF1cwiUcE4xI0T58ne4n3Jz49ASBrKtuddougzSFc9FHgked6Uxz2R/OJM97myZ7+VDWY8DDg==
X-Received: by 2002:a05:6512:15a3:b0:52c:8fd7:2252 with SMTP id 2adb3069b0e04-52e826467aemr3757246e87.11.1719831547868;
        Mon, 01 Jul 2024 03:59:07 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2eaf0sm1376011e87.195.2024.07.01.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:59:07 -0700 (PDT)
Date: Mon, 1 Jul 2024 13:59:03 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
Message-ID: <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/NLf3SfcsRCvWQp9"
Content-Disposition: inline
In-Reply-To: <cover.1719830185.git.mazziesaccount@gmail.com>


--/NLf3SfcsRCvWQp9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When multiple IRQ domains are created from the same device-tree node they
will get the same name based on the device-tree path. This will cause a
naming collision in debugFS when IRQ domain specific entries are created.

The regmap-IRQ creates per instance IRQ domains. This will lead to a
domain name conflict when a device which provides more than one
interrupt line uses the regmap-IRQ.

Add support for specifying an IRQ domain name suffix when creating a
regmap-IRQ controller.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
A change worth mentioning is that this patch changes the error code
returned by IRQ domain generation code to be propagated to the caller.
Earlier all IRQ domain creation failutes were returning the -ENOMEM.
Please let me know if you assume this will cause problems.

This patch was originally part of the series adding support for the
ROHM BD96801 PMIC. Basic support was already merged while this one was
postponed until the name-suffix support was added to IRQ-domain code.
Hence the non linear version history.

Finally, there is a comment:
"Should really dispose of the domain but..." in the regmap-IRQ creation
code. Any insight what the "but..." refers to would be appreciated as
there would be an option to for example use the devm_ variant of the
irq_domain_instantiate().

Revision history:
v1 of the new series:
 - use the new irq_domain_instantiate().
v2 =3D> v3 (old series):
 - Drop name suffix support for the legacy domains
---
 drivers/base/regmap/regmap-irq.c | 39 +++++++++++++++++++++++---------
 include/linux/regmap.h           |  4 ++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-=
irq.c
index 45fd13ef13fc..43bde9744ea6 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -608,6 +608,32 @@ int regmap_irq_set_type_config_simple(unsigned int **b=
uf, unsigned int type,
 }
 EXPORT_SYMBOL_GPL(regmap_irq_set_type_config_simple);
=20
+static int regmap_irq_create_domain(struct fwnode_handle *fwnode, int irq_=
base,
+				    const struct regmap_irq_chip *chip,
+				    struct regmap_irq_chip_data *d)
+{
+	struct irq_domain_info info =3D {
+		.fwnode =3D fwnode,
+		.size =3D irq_base + chip->num_irqs,
+		.hwirq_max =3D irq_base + chip->num_irqs,
+		.ops =3D &regmap_domain_ops,
+		.host_data =3D d,
+		.name_suffix =3D chip->domain_suffix,
+	};
+
+	d->domain =3D irq_domain_instantiate(&info);
+	if (IS_ERR(d->domain)) {
+		dev_err(d->map->dev, "Failed to create IRQ domain\n");
+		return PTR_ERR(d->domain);
+	}
+
+	if (irq_base)
+		irq_domain_associate_many(d->domain, irq_base, 0, chip->num_irqs);
+
+	return 0;
+}
+
+
 /**
  * regmap_add_irq_chip_fwnode() - Use standard regmap IRQ controller handl=
ing
  *
@@ -856,18 +882,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *f=
wnode,
 		}
 	}
=20
-	if (irq_base)
-		d->domain =3D irq_domain_create_legacy(fwnode, chip->num_irqs,
-						     irq_base, 0,
-						     &regmap_domain_ops, d);
-	else
-		d->domain =3D irq_domain_create_linear(fwnode, chip->num_irqs,
-						     &regmap_domain_ops, d);
-	if (!d->domain) {
-		dev_err(map->dev, "Failed to create IRQ domain\n");
-		ret =3D -ENOMEM;
+	ret =3D regmap_irq_create_domain(fwnode, irq_base, chip, d);
+	if (ret)
 		goto err_alloc;
-	}
=20
 	ret =3D request_threaded_irq(irq, NULL, regmap_irq_thread,
 				   irq_flags | IRQF_ONESHOT,
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index a6bc2980a98b..b0b6cd3afefa 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1519,6 +1519,9 @@ struct regmap_irq_chip_data;
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
@@ -1604,6 +1607,7 @@ struct regmap_irq_chip_data;
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

--/NLf3SfcsRCvWQp9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaCi/cACgkQeFA3/03a
ocVnuwf/feJKv0mVSdQxsPqGS568JdeGPoSYf3GehkmXMUucSbanziUA2gGvPwku
B9Aa+srjqR5xMYyobuk8W5iLr6ieK7j6VyYb9TpVqIjy5LPruXO2Qdh1tCB+QGSC
4N3QWMtrfBlyapALoNh5uLC3AZcOokXXYSmcwvoUnh8n4jHU8hJ+2K88JHeGJULX
4pJ+UnJ6vUdmfG4t0XO6rq3qvzZsoelTuj4rzWXM+dmL6YfviVWXLBacqX5nKA8r
UmFp9I97t9gGyyiP6FosznEnLUV5y4i8bNMGBWZAE7mDoR+OPP60tLhlk516hVpM
cWIWFRDz1xN1mgRwU6oPasSEycymAg==
=KZdn
-----END PGP SIGNATURE-----

--/NLf3SfcsRCvWQp9--

