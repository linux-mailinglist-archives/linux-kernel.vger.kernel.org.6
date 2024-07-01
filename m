Return-Path: <linux-kernel+bounces-236093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D45C91DD50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF34B2566D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A943142E97;
	Mon,  1 Jul 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwgth53k"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E013C679
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831534; cv=none; b=tLPd7+Qto2uAR2PJKjKWcOoFz+TCwj3BGfphTYGV7Irbt0PjPi/4TRiq9aelM/Q/savk5Ui/I3fVqUocyAwrtu6cEkOM248mFyzr9jSnzBZ2v2GTjVui3oweIs08pEB+nTQEGA8hatStdIC3dMd3MI8rKdYQgvtca1okZncR7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831534; c=relaxed/simple;
	bh=dnRR8Ke9gbskhhTVdHZ/lOzHqbz+7GKyKUBXw5dpyUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVoda+nnRLdZ5rQDuKR6XjCQ0difRiK0NfFPM0WUByDnL5nKtRkGUJF3VwnEiNvqDqy0FmSBL3dxmLMq/WhSZCCUAaBZ682QcycOr/obNmpQzy3GadytYSaaeziSTVQpomKzJbqYiZLhp+tna1fWu5dc7qnEgIup4V/mHVje0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwgth53k; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52cdea1387eso2929478e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 03:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719831531; x=1720436331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptyreQLSX0yPf7BXkeYPAjY9DgJ+90etUBU9efm0tMY=;
        b=Zwgth53klQ5Iec/SAgnx9Shm7JVbOoIWMTx13RnG7QKd/XVITtPFYmRRuO0B23tT6g
         IaWT+M3Fwi8/1cV/U3WeMTl1ojT+45V0kR1eeH8S3BDnDj5GelQWVPjFK0CpvN5aQwRT
         56I5Qf7sMjPxPtNwOUtEVybY299gz12sM3tmLao8E5F1ixK4Zy9XxjWyVC5CiqJ03qRR
         HNzy424JDCZrbfW7wxC6z7TvD/a2+L83mhcXyT4o+von9ttzZMSnqFrVJtbcYzUUhWXB
         MBJ4CkfNgeVMaskWySb1VpYBaa6sLo0ef1F1lr8qInvLqe5YDLgdTjhOL0u5aGjxIDYr
         xD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719831531; x=1720436331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptyreQLSX0yPf7BXkeYPAjY9DgJ+90etUBU9efm0tMY=;
        b=VC8GMVFDNKmHz5GUsMqrdCUggdQ09Oc2bY3kiW0fnOutMMoUI12IFnXSlOu7QWlQqm
         Clycd2oykUbJki1qFV9Xw6j20u++GT9yQwnPZs37aBzJJKnG9pTQFxZiL+IUz4zsdlkn
         yGCpBe8QYssiiCD4WuC2OnmxIXs8NHX51gwfjhLde4zvaj+fs5K2mwxKD16j3Pi3hk2Q
         R2xlUf8HV1ni0poXFcmFhd/g5dJeU0GRgN9R4l6Bb4cCu/PH7422kodjtAjOeUUsPxII
         WQK2mxaWpw1or8FKFVpAmtTcykaqwt3mJLUmxeSP5s72t89/T/b8OsqIpydfLH7neQTW
         Jp9w==
X-Forwarded-Encrypted: i=1; AJvYcCWfOCrRbaeAEyF38h0oB/+2hmp1/h2wV1KrFdyomBugL1DEgx1en/kx969KXAf8RZNfTPfBmbo27uek0DrTXcH90TnMDz8c8G2xfU7B
X-Gm-Message-State: AOJu0YxYFS5rT7YOhGi95IAtV84O0mdU/NCQpsMuqu09DUozyysHStpX
	GNj7xO1vrXj+QXlVF+bqa7Fv3mUL2tJ4ARkxXhRr6Uhx87g1m3Nd
X-Google-Smtp-Source: AGHT+IEWC7DEvddMe6UeLnm48/2XjXvPTK6S6SpidMqoDxSvSpq18/iqujsy3wM12Fr/f6qtBVdEng==
X-Received: by 2002:a05:6512:1384:b0:52c:86d6:e8d7 with SMTP id 2adb3069b0e04-52e8264733dmr4074657e87.13.1719831528324;
        Mon, 01 Jul 2024 03:58:48 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0ba73sm1347132e87.47.2024.07.01.03.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:58:47 -0700 (PDT)
Date: Mon, 1 Jul 2024 13:58:43 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] irqdomain: Allow giving name suffix for domain
Message-ID: <4f037bdc2804116d674bdbeba09169ca9ea7ce4b.1719830185.git.mazziesaccount@gmail.com>
References: <cover.1719830185.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ReDjjF9hu6x6o9ha"
Content-Disposition: inline
In-Reply-To: <cover.1719830185.git.mazziesaccount@gmail.com>


--ReDjjF9hu6x6o9ha
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
 include/linux/irqdomain.h |  3 +++
 kernel/irq/irqdomain.c    | 36 +++++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 02cd486ac354..77ead0d41ccd 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -274,6 +274,8 @@ struct irq_domain_chip_generic_info;
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
  * @bus_token:		Domain bus token
+ * @name_suffix:	Optional name suffix to avoid collisions when multiple
+ *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  * @dgc_info:		Geneneric chip information structure pointer used to
@@ -290,6 +292,7 @@ struct irq_domain_info {
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
 	enum irq_domain_bus_token		bus_token;
+	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 91eaf6bfcbf0..41348a325a94 100644
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
+		 * collison, when multiple domains are created for a single
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

--ReDjjF9hu6x6o9ha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmaCi+MACgkQeFA3/03a
ocWpZQf9E2nH9PjsSycD9W2dC74FvSwhYli1wmyD5mPowH3c2Ddq9zUdV3E8Bd9W
SvH1NpUmMyTiUQvgI2SnBWjfgtcifP/AHqhpJYGmAmjAGNoOSAshb5ll90ifRJbc
mIWf+FrCq5kcemmYME5oSbqrLEpTHkm/iEySuThwLetrpHq/xAAofc6pcHB2Suml
NARh6qz2RrOqq/wpHRRSIuVGlYkRuqimgXVKGjIMiZNZb6u06bHl+P8n+6tl++f0
o6PiPmHaGvt/qNicamkv3YUIWuU9ivyNpiy0XG8ALrK1YsG1hJd0MXLfKQpGn7tN
wiqaFvIunmX5rwH1iS/j54l0o/wt+g==
=c36j
-----END PGP SIGNATURE-----

--ReDjjF9hu6x6o9ha--

