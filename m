Return-Path: <linux-kernel+bounces-279462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB95594BD92
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E61F2137D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08E118B481;
	Thu,  8 Aug 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzZJZsoq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDE51E511
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120453; cv=none; b=gS3DRbJWi4t8oeaacXAjJuSptuP61ws7B2e+IEJgNGTEaZ757TYvDDkFOPaku4dlisITmqglBz7aZCxdRCyFhf695XC76psjI8mTbGp+x08rDsnS+T8dfp0Mble4WD4l1eB+1fQAWCrqwwWYYTVk/RZkBE/8yfu+ctjX6bsLD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120453; c=relaxed/simple;
	bh=tz036277a8bDgHHfC2OQToU+PhUGD6SliTzSnU1sy3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW+PEImCU4Bbt72PniCo7wP65QNvHmwR867hSD1QHJ8QFqEQkCinFwzgO9anyMlcr7yIuygPCsNnkLC+0DAA/36UYlwY5wwFexhqCp5KbAVAD2iSZwz2PMoH/Yb2tugQzfKaXQijGA4zG1cwtmX5QJw9Tettcl6zaEmsxaJf590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzZJZsoq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f040733086so9207151fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120448; x=1723725248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZHpAiTIt/O6A6h71tyCVcy7V+/AGzg65920gUuJPt8=;
        b=lzZJZsoq2n4VZqDIaVWh8fg7C32GmbyOrjPyMBLboT0wSX+m7ZWh56zJDg5MrdaKyP
         IcGWc/LFpBeG+k21vfuyfEnlVV1aN1lYEsUjv1PIfDTURm+nB82Wo2+sPpbuJKq0134V
         WOtafpy/oPPFl7/RUc42CWYW83cfKCskVz4oMxTK0OCnciSHH2O/E2IIbSjV9UnZrpm2
         bh+dU9P7zATShWNEEoEoxlikHQ23u3jNbZwCkrAAy7S7hqbbDA9UIDdIMvcybF3o0+7Z
         o8VHhDYPiE7afTPsJXucxxXRPhcUh8lhOVOdnjWUdptROEHB/QdO9vnd8yFys+SQS1bQ
         dx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120448; x=1723725248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZHpAiTIt/O6A6h71tyCVcy7V+/AGzg65920gUuJPt8=;
        b=LiT8VMvQgQnZZkm3FR97S7LRpTsQYlEUcINRN2kE2FnVuL32NMJJw3R7iIMiGsoLwR
         LUMKTqrcnLC5WfsX7dlVnnVv3+jI3lC07bspOjJGV8JtV43McxzW8o5pChEDLiQjZD1E
         96cO2DqL9tI59bK69Qifvc3ZwHaxppIVWQC4FaXwyduPTZ5flCU1Zx/W2r762DmQfhRQ
         La+Ky9mdlosWknx9WfD1OgRxWHLtI7wcTfGI4rZb5+KsTzvoZB+b3AQSLNgJzhbhmDou
         lWp/vAd7C91Zyn1gHv/IqnHwy0dEKHjx7laNlBJoTcxSE5zJ2gbol1RQPhN0sJWtjGjz
         +XHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4W7XZziTlulJwtvYQSZI2Rjz9lDNhCAL9SpDPsyTQWDas0fuSRxuB28Dt/serDZLxnB38J5PQrunySkAb8HBKQTVAHkEmJR4o2Lgs
X-Gm-Message-State: AOJu0YxQAD93q7oyXtiyZmsJbAJLjysPihi6Rw7ksTeJpBWNld26eOrJ
	PWS534corntXDKSduvOLio6edgEtc1svZwzA/zjzGyMEqX1v05ht
X-Google-Smtp-Source: AGHT+IFkK9jWZi5v/SIXXRg2uAZefOiiOn0ABaCFkDJ23LcwIstpIIeF9NOudvlzsUppbihD39iG4Q==
X-Received: by 2002:a2e:bc25:0:b0:2ef:2e3f:35d2 with SMTP id 38308e7fff4ca-2f19de1f942mr14767341fa.5.1723120447508;
        Thu, 08 Aug 2024 05:34:07 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e1aea5bsm20824591fa.44.2024.08.08.05.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:34:06 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:34:02 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] irqdomain: simplify simple and legacy domain creation
Message-ID: <32d07bd79eb2b5416e24da9e9e8fe5955423dcf9.1723120028.git.mazziesaccount@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5Fv/FwShYrc/riQJ"
Content-Disposition: inline
In-Reply-To: <cover.1723120028.git.mazziesaccount@gmail.com>


--5Fv/FwShYrc/riQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move a bit more logic in the generic __irq_domain_instantiate() from the
irq_domain_create_simple() and the irq_domain_create_legacy(). This does
simplify the irq_domain_create_simple() and irq_domain_create_legacy().
It will also ease the use of irq_domain_instantiate() instead of the
irq_domain_create_simple() or irq_domain_create_legacy() by allowing the
callers of irq_domain_instantiate() to omit the IRQ association and
irq_desc allocation code.

Reduce code duplication by introducing the hwirq_base and virq_base
members in the irq_domain_info structure, creating helper function
for allocating irq_descs, and moving logic from the .._legacy() and
the .._simple() to the more generic irq_domain_instantiate().

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>

---
Revision history:
v1 =3D> v2:
 - New patch

Please note that this patch has received only limited testing. Any and
all testing with devices using the legacy domains is greatly appreciated
:)
---
 include/linux/irqdomain.h |  5 +++
 kernel/irq/irqdomain.c    | 73 +++++++++++++++++++++------------------
 2 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index de6105f68fec..bfcffa2c7047 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -291,6 +291,9 @@ struct irq_domain_chip_generic_info;
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @hwirq_base:		The first hardware interrupt number (legacy domains only)
+ * @virq_base:		The first Linux interrupt number for legacy domains to
+ *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
@@ -307,6 +310,8 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	unsigned int				hwirq_base;
+	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cea8f6874b1f..5af5e4028de2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -267,13 +267,20 @@ static void irq_domain_free(struct irq_domain *domain)
 	kfree(domain);
 }
=20
-/**
- * irq_domain_instantiate() - Instantiate a new irq domain data structure
- * @info: Domain information pointer pointing to the information for this =
domain
- *
- * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
- */
-struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *in=
fo)
+static void irq_domain_instantiate_descs(const struct irq_domain_info *inf=
o)
+{
+	if (!IS_ENABLED(CONFIG_SPARSE_IRQ))
+		return;
+
+	if (irq_alloc_descs(info->virq_base, info->virq_base, info->size,
+			    of_node_to_nid(to_of_node(info->fwnode))) < 0) {
+		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+			info->virq_base);
+	}
+}
+
+static struct irq_domain *__irq_domain_instantiate(const struct irq_domain=
_info *info,
+						   bool cond_alloc_descs)
 {
 	struct irq_domain *domain;
 	int err;
@@ -306,6 +313,14 @@ struct irq_domain *irq_domain_instantiate(const struct=
 irq_domain_info *info)
=20
 	__irq_domain_publish(domain);
=20
+	if (cond_alloc_descs && info->virq_base > 0)
+		irq_domain_instantiate_descs(info);
+
+	/* Legacy interrupt domains have a fixed Linux interrupt number */
+	if (info->virq_base > 0)
+		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
+					  info->size - info->hwirq_base);
+
 	return domain;
=20
 err_domain_gc_remove:
@@ -315,6 +330,17 @@ struct irq_domain *irq_domain_instantiate(const struct=
 irq_domain_info *info)
 	irq_domain_free(domain);
 	return ERR_PTR(err);
 }
+
+/**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this =
domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *in=
fo)
+{
+	return __irq_domain_instantiate(info, false);
+}
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
=20
 /**
@@ -413,28 +439,13 @@ struct irq_domain *irq_domain_create_simple(struct fw=
node_handle *fwnode,
 		.fwnode		=3D fwnode,
 		.size		=3D size,
 		.hwirq_max	=3D size,
+		.virq_base	=3D first_irq,
 		.ops		=3D ops,
 		.host_data	=3D host_data,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *domain =3D __irq_domain_instantiate(&info, true);
=20
-	domain =3D irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
-
-	if (first_irq > 0) {
-		if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
-			/* attempt to allocated irq_descs */
-			int rc =3D irq_alloc_descs(first_irq, first_irq, size,
-						 of_node_to_nid(to_of_node(fwnode)));
-			if (rc < 0)
-				pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-					first_irq);
-		}
-		irq_domain_associate_many(domain, first_irq, 0, size);
-	}
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_simple);
=20
@@ -476,18 +487,14 @@ struct irq_domain *irq_domain_create_legacy(struct fw=
node_handle *fwnode,
 		.fwnode		=3D fwnode,
 		.size		=3D first_hwirq + size,
 		.hwirq_max	=3D first_hwirq + size,
+		.hwirq_base	=3D first_hwirq,
+		.virq_base	=3D first_irq,
 		.ops		=3D ops,
 		.host_data	=3D host_data,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *domain =3D irq_domain_instantiate(&info);
=20
-	domain =3D irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
-
-	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
=20
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

--5Fv/FwShYrc/riQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAma0uzoACgkQeFA3/03a
ocU7xwf/Ry2+yDlU8WksjmhM776lg0t0qfi5ccanvmy6JGdoRuVzbB0PF7Zc/KcM
esRQ9M8i98poZyyECawaHVVVupetNmaD1aiwS6VCI3/4Aj38zakZrGXq5YuawYIo
Utzdg9kIzShOmlbJnltJ8Gv+I81iscXIBQZ7DOEATJ/a4YhfbZgenzOpvE7q7AB5
0HbDFowzkN9YNcxwo7WEU1t0/+di+jwMCDWeM+bHnxaGn+DPF6/FWy92/ntqM0fO
SWnCV3Le+U/vIUI3aB4g06bwsI8X3fD0sKcHMjkppZWiJ8ztIoGBuR6Q133H7leN
dSZCf85ZLMG+gsWFvo8IXM+kbuMzxw==
=hMYv
-----END PGP SIGNATURE-----

--5Fv/FwShYrc/riQJ--

