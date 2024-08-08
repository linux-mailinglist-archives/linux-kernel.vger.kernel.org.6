Return-Path: <linux-kernel+bounces-279468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D273994BD9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E0E1F21B86
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A3D18C910;
	Thu,  8 Aug 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lElkMJLi"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E9189513
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120598; cv=none; b=tYC+cpolaxtbk/Z4JB1FRCu/BdDRiwEpEoCKK8Fm5RiKhcSprJJCV4EycE2M0CfzPjiIyk7w86RqtvVyD1WmhmFApIVuHZZi2InRAS3bqJIPuL3cQdMeBH9jPPYsDbqIIZhw+Sh95yzj2Vl1JPi6QxiMnry11Fo66WSyPJ/UF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120598; c=relaxed/simple;
	bh=v7lV3u+lEpVaa3+itGth6H6NEphiQOJexLQEacBnr/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT4s24mOdpT+RjmAl+fjuycXCAaOwigpzj7xBPlV6Ua9fLW87HYaIlaRbdCj33Wb8H8xCUE0dfYehGuSZc0lCkq6QRq4loRsIJqy3LvQ5ZidjzsaRCmPdJ1TSMXqWMMHh3MqI9tvbpSu0Yrb7LvuMHJBxHyBZPDQ3WxAulzuiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lElkMJLi; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f025bc147so1012813e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120595; x=1723725395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzp6Micu3tjXmEKWe8ueoR6gtmK+4KywnqQdz8LMUg0=;
        b=lElkMJLiMRlG6aD+zDchsP/tAQQatxbOGMacx1USlTu7PLOJlbP1q8nmkt55JmZLyl
         /h4aLBMe858WZlCeF0lKd6XERd9Se298mVH63PUy2OoqL98y8Ny/naFX8q9HSCaxBnZB
         6IdCSHEaaddPyob5x22dxXjFZOYoDZFfbgIhMRFN4hya0bdyfH/NbS7+dyUHZeR/RPyw
         W8shvpX45muF1dadL21SkSE1Ah+zo5IyrvnsHtp09OODLeenVz7cYIwKwYvrDc2bRXjj
         GgPwIB0hvwzajyCrgQHHWAR7oOZWasLgfGZtZKOqVCdU76dqQepHR+H11vFf7gPcjSU8
         NuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120595; x=1723725395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzp6Micu3tjXmEKWe8ueoR6gtmK+4KywnqQdz8LMUg0=;
        b=pU88L6uVuMfAggsFmqn0NieGSXhVM1teDDEo+KWW6/MCSGmyL+84Dxr8S6BDVHboDp
         VmyubBs62Rfpr6WgrLA34D+ArikrFqDpsQTm6TOLSx58qNhRvBcp6sUDAM/Y0/RyIGO/
         gPrQNVNvFj0oYwzNNq//jFNTslw71UbplHT6L8btFFBhm6/qfRBFjnSmI8kt3HERraN/
         WvnyZfsfNZYJ6S0f7dL0iF5jaJh3iNhEnPTwy5CTpKXHkzBI7NdlQMK2FGy1iwPMSPbI
         wEbbrLFJznnUOa4Ervjzj/01ZO1QTNtbD4tbvOPA70/DoLv+yG+xxVW05+OJ+y2dIGbK
         RJ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXnSyD++BkNIKR7c2K+Y0OWyuwd1o+67LFW7lJizwKR66vmdsKwP8gJxf2xGPWESLdBgefhrt203PMCUNTmp3IL73RqidKwCAr/KVnQ
X-Gm-Message-State: AOJu0YzLmaheopg0OjGnb8n6dGuMyOlKtwcmodWp0S2icQWLKgRom1c/
	91h31wSb0qHowAAHDOlw/8zmlAI5cOVYkGPTQhQycSigQp2NooE3
X-Google-Smtp-Source: AGHT+IEsat8se4x82dZXnFb2EBu0ObaUr3wLeEjTA0CGa11gLFEcU0x+9GA8FmNxC7IJMwqqtpYeng==
X-Received: by 2002:a05:6512:4025:b0:52e:76e8:e18e with SMTP id 2adb3069b0e04-530e581651fmr1326816e87.7.1723120593782;
        Thu, 08 Aug 2024 05:36:33 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de47c5fesm623464e87.269.2024.08.08.05.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:36:32 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:36:28 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] regmap: Allow setting IRQ domain name suffix
Message-ID: <776bc4996969e5081bcf61b9bdb5517e537147a3.1723120028.git.mazziesaccount@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L07GlhcC5fAcYGs/"
Content-Disposition: inline
In-Reply-To: <cover.1723120028.git.mazziesaccount@gmail.com>


--L07GlhcC5fAcYGs/
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
v1 =3D> v2 (new series)
 - fix the legacy domain instantiation as was pointed out by Thomas
   Gleixner.
 - drop irq_domain_associate_many() which was moved to be called during
   the irq_domain_instantiate() as was suggested by Thomas.
v1 of the new series:
 - use the new irq_domain_instantiate().
v2 =3D> v3 (old series):
 - Drop name suffix support for the legacy domains
---
 drivers/base/regmap/regmap-irq.c | 37 ++++++++++++++++++++++----------
 include/linux/regmap.h           |  4 ++++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-=
irq.c
index d3ec1345b5b5..a750e48a26b8 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -608,6 +608,30 @@ int regmap_irq_set_type_config_simple(unsigned int **b=
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
+		.size =3D chip->num_irqs,
+		.hwirq_max =3D chip->num_irqs,
+		.virq_base =3D irq_base,
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
+	return 0;
+}
+
+
 /**
  * regmap_add_irq_chip_fwnode() - Use standard regmap IRQ controller handl=
ing
  *
@@ -856,18 +880,9 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *f=
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
index 122e38161acb..f9ccad32fc5c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1521,6 +1521,9 @@ struct regmap_irq_chip_data;
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
@@ -1606,6 +1609,7 @@ struct regmap_irq_chip_data;
  */
 struct regmap_irq_chip {
 	const char *name;
+	const char *domain_suffix;
=20
 	unsigned int main_status;
 	unsigned int num_main_status_bits;
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

--L07GlhcC5fAcYGs/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAma0u8wACgkQeFA3/03a
ocWCVwgAws5IIkXc2W8Qd4bjOcO8Wc93xF5phcSkuhKo3er7w5PoujIDjOI8WPDf
osyNmZDaGtUBtqlT6zj7V+x7cbrDpfD7OtMDHyDp7fhD/cSl2J/ClJuKijR1r17U
+MJWo4Ge8Z4wZsj16qurgkI7pkgJJP5NN8BxCvPKS2L/DyrG1LZ5UIcTxfpeuMRB
z05gmNFSRC7VKbQUdMMN39nmjCCPgf0RW7pAHeEnlGB1nElFeCszmTx841Y7bARo
B5dIfaYIyxbFgB16s5sKBX7RltmzDvwDZzIxkmOrqY7EosVmpt2fHp+fdpNv7azB
UyiEehNUCqAS0q3kaonqSQrU8o5bAA==
=W7Rg
-----END PGP SIGNATURE-----

--L07GlhcC5fAcYGs/--

