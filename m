Return-Path: <linux-kernel+bounces-279463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D7994BD96
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 14:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00461F2134C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A36518C357;
	Thu,  8 Aug 2024 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+UyBtf8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D371E511
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120509; cv=none; b=tjhTVacfUo25RhDCRMswg7NXQfDRoVcdkQSPSeUsCvW3/ti1atj7qMx0CaM23COIOT+FzUETGAbjSykSy7QrQaKehaaZYX3D7LhLvbA/8zl+kS5tFWIMxyVKmIFVFmOcb0VAVckLYUwnUIGlxoRUUNnptRGTfmspMiF7Ap8+q3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120509; c=relaxed/simple;
	bh=T09VfP/9+XczLP9nOtI6WsyNARFndysB7hs+8/KBoDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeQ46W9gb1N9InveWSzsEmdJBjYWSZWSYXOxSMALwBGXy9auRzXf8qy4vA+zcOEcHhBlBnUOCupfKWoq5PVr05yqZrzsm5gSMCbvJHYxKH3AEEnRJ+c7LLdIHuRT93FSkjdOpErJibF160eBxgP3qHoRI58o1su/Tg2IW/gxCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+UyBtf8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efbb55d24so1588593e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723120506; x=1723725306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNhAwsrhIdal4pwoMXUZpj+EEHqYsqeqWIBG0u/1A6w=;
        b=S+UyBtf8Ym2or0L5EOOtL9whky+mmyyeLXOl1GQUihV1JKlLHK/E0Z00yZtl0tJ17G
         M92lqMMiZLxZKl2e6RnIrdThIMeJUrm5DHuKUmJQOeEtH0kdWJVQJHC90RohMIy3etqv
         j9DCLTmTfGt5AXzA1WeUtB7VouNVU/CXXEldnptLdM02Bciivpme7CkIZcPtLPhQnL1s
         Ull1p4OWeXVua8GWzcoQOoEaxJqGJkNlCHQgKRRJVsffJHJxz6PK6Odv6VhPnImPnYdX
         VrOJ63jXBWIPhHDuNSwOAGGmL7rCEJy35ONsV3htNE3jf4+ZQi3c6C+Lu1pvqB2EgKpL
         7T4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723120506; x=1723725306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNhAwsrhIdal4pwoMXUZpj+EEHqYsqeqWIBG0u/1A6w=;
        b=YGc6+cNty8bliP9UErMhqrPlBXfOA+yAe3uvsnh6rfg6CpPNo2uXwxfl92LedS58b/
         wRv6LHvkoKgcA7EOAiARP6NU5L7keirFUB1WpzJifVI8SKN8qZ53LSkRkL3FPZb/xBPv
         85Jd26bkBer2Shrw1FO/exqPKioZcdTvszd/j6NlqszTg1keOBfyJOVUPf7unEwoE5o9
         Ih+7iJSdnlx0aE1tJ0dotYwKPLPlqxQn1kE0CItjzhJOrD8XfkJHRr+hlEA8HsgNKkZD
         DeuKjATGniz9csApPlIQsfiIQHU9nX4ItPHqU5PcoYA2XkYdUIn3H3Uelei8ptmo/UuH
         b5fA==
X-Forwarded-Encrypted: i=1; AJvYcCWWXzmtEvKQPRgbD98+f2w7nhvQfByqUYQAHyr/0jmsQAAdgoVq0cAmGsEBkAhlj/UIsy5EDNxXKoQ+c1lsMVfyZwHu4ShjKQiulwUU
X-Gm-Message-State: AOJu0YwUPeBplpUkoH41zPIQFHIy3I7NQhmjfsio4eLybUHv8Oxx8ewM
	HECGTPv8387hONzi3qg9J3oLF0pvMVI9lKGBNStPDrCIgRiPWS4R
X-Google-Smtp-Source: AGHT+IFfMaExb9vVqzZw910hOxowlTD8DLm91DGq3oOd/1yT7ytbJKNfZVXKN8Em1P2PAGCb3408iw==
X-Received: by 2002:a05:6512:220a:b0:52e:73f5:b7c4 with SMTP id 2adb3069b0e04-530e5876b25mr1758069e87.37.1723120505273;
        Thu, 08 Aug 2024 05:35:05 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de47c422sm622767e87.264.2024.08.08.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:35:04 -0700 (PDT)
Date: Thu, 8 Aug 2024 15:35:00 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] irqdomain: Allow giving name suffix for domain
Message-ID: <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
References: <cover.1723120028.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="852xrl80h3Srxl19"
Content-Disposition: inline
In-Reply-To: <cover.1723120028.git.mazziesaccount@gmail.com>


--852xrl80h3Srxl19
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
the per interrupt line domains. This will cause a naming collision in the
debugFS code and can also lead to confusion, as /proc/interrupts would
show two separate interrupts with the same domain name and hardware
interrupt number.

Instead of adding a workaround in regmap or driver code, allow giving a
name suffix for the domain name when the domain is created.

Add a name_suffix field in the irq_domain_info structure and make the
irq_domain_instantiate() to use this suffix if it is given when a domain
is created.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - typofix in comment. 'collison' to 'collision'.
---
 include/linux/irqdomain.h |  3 +++
 kernel/irq/irqdomain.c    | 36 +++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bfcffa2c7047..e432b6a12a32 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -295,6 +295,8 @@ struct irq_domain_chip_generic_info;
  * @virq_base:		The first Linux interrupt number for legacy domains to
  *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
+ * @name_suffix:	Optional name suffix to avoid collisions when multiple
+ *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  * @dgc_info:		Geneneric chip information structure pointer used to
@@ -313,6 +315,7 @@ struct irq_domain_info {
 	unsigned int				hwirq_base;
 	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
+	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5af5e4028de2..376bcfb45aff 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -129,13 +129,25 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwn=
ode)
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
=20
 static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode,
-			       enum irq_domain_bus_token bus_token)
+			       const struct irq_domain_info *info)
 {
+	const struct fwnode_handle *fwnode =3D info->fwnode;
+	enum irq_domain_bus_token bus_token =3D info->bus_token;
 	static atomic_t unknown_domains;
 	struct irqchip_fwid *fwid;
=20
 	if (is_fwnode_irqchip(fwnode)) {
+		/*
+		 * The name_suffix is only intended to be used to avoid a name
+		 * collision, when multiple domains are created for a single
+		 * device and the name is picked using a real device node.
+		 * (Typical use-case is regmap-IRQ controllers for devices
+		 * providing more than one physical IRQ.) There should be no
+		 * need to use name_suffix with irqchip-fwnode.
+		 */
+		if (info->name_suffix)
+			return NULL;
+
 		fwid =3D container_of(fwnode, struct irqchip_fwid, fwnode);
=20
 		switch (fwid->type) {
@@ -164,17 +176,23 @@ static int irq_domain_set_name(struct irq_domain *dom=
ain,
 		   is_software_node(fwnode)) {
 		char *name;
=20
+		if (info->name_suffix)
+			name =3D bus_token ?
+				kasprintf(GFP_KERNEL, "%pfw-%s-%d", fwnode,
+					  info->name_suffix, bus_token) :
+				kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, info->name_suffix);
+		else
+			name =3D bus_token ?
+				kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+				kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		if (!name)
+			return -ENOMEM;
+
 		/*
 		 * fwnode paths contain '/', which debugfs is legitimately
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name =3D bus_token ?
-			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
-			kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name)
-			return -ENOMEM;
-
 		domain->name =3D strreplace(name, '/', ':');
 		domain->flags |=3D IRQ_DOMAIN_NAME_ALLOCATED;
 	}
@@ -211,7 +229,7 @@ static struct irq_domain *__irq_domain_create(const str=
uct irq_domain_info *info
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
=20
-	err =3D irq_domain_set_name(domain, info->fwnode, info->bus_token);
+	err =3D irq_domain_set_name(domain, info);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);
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

--852xrl80h3Srxl19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAma0u3QACgkQeFA3/03a
ocWAwwgAzppK0On7q4laV4iAk+32+A2lEkVlQgr3GcmzSpWu8xxKp4D7YBcnhBoD
JNrI8cjoXNsKpKtTmkypUPB7jSt4umbZpDL7cP1eCIFyW/NVaa6ZZOKaBPJuX2i0
Dm+EwHj0RZxlI+dCJ1rGYwaeu9akQI0qrTpvCdIh+WUTlyi5bQbChGt5e10XmSnV
zE4yZvkEAjavluDst0eKSJ86Eui894ZvaJFuwJKMvkdGu3D2HVLGZKsfFKQSkWkq
fGO1pTchuDF9uJe/F1TwGpsgz3KhanY/yJOSeInWb3z5wct+S2+FsxEe2SR6XOcy
Bl+OBlh9Vne0ULOC1VmO1zwJk3wrkQ==
=XLyQ
-----END PGP SIGNATURE-----

--852xrl80h3Srxl19--

