Return-Path: <linux-kernel+bounces-188453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA048CE23C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7EE1C2164A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C0127E32;
	Fri, 24 May 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoZzVBJJ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CE5B1F8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538743; cv=none; b=SR8Yjpq7lomtHQMCQhkJ5nfHisee7WqITzTV6ubAQk0dAsdUabtOv7kT+jJE942avEGyFpwO4GfDEf+u40fadmkUvYS+tmimaW7cftDEpTr+eb+AZOchCqx3sFWNtBlTgFPgX33UbujnvWVuy6YG2gDlrLMbSjD8gyHLy3jvHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538743; c=relaxed/simple;
	bh=Zj8mJ9mmgh0ZPEdmz1Qbgx5N+asAB4JKUrXf72BY1bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX2TzlR3sf+iT8QaGf+WSHP0FWuIF272W2rfYRQoZMGigTuZFhtpxaC0fRRazrLQy37NPv8JS4ZHOAOTz/W88KQW9luGaOqOdg1J8TXHb5EEL9axi4ERKABIedUhmP2YZH5ZFQKIXQ63196MB4vz8JlP/mNe7yhbyb8kozZeVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GoZzVBJJ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52962423ed8so615573e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716538740; x=1717143540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6u83Z55b4o1IcGNI4+8K+UlRSGSwxTnsZ3LQL61BB+g=;
        b=GoZzVBJJrBl9pq1aSS5P2tBOuLOM5crz1Mw2ynXFddWtH9n3aVL0vUyEu6UBfJyP8D
         +XgYJP9WpaddvlocDECbfcpEqI3twWvy6D29c7bwt5ibdobtuh1kD2bA6vNGEpOTTu/4
         b8jkfvwe5qlIfmpeusGz7QMluQadt1ddEbrZIGy0ryrruwWrys3VbNlQuVVA/2ihxrFY
         LO02Q6W5Js29uSD1nJucMpifdA4mxeJiYCg6yidaneLIRKjjcbw9hkTLsGHdrM+F5mPs
         lAr/UUdhi2WD/vBpfNodPQTlfanHfM30TKsY9flqgW6FRHgS7c9kDLJDmSe1445SDuT1
         Pi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538740; x=1717143540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u83Z55b4o1IcGNI4+8K+UlRSGSwxTnsZ3LQL61BB+g=;
        b=uOuW8lrH+/P1HIp2FaBpBpTdcafn/7/MedAb4kE5DG31cT6v033dPZ8RhlqVEdRTtH
         cu02IXzig25m9PIaPu2PQy2EpnuBKcKGHh0nXgd8jvm6RYeUKLAefDr+sVZISro7N98f
         7kCg9FzMkW6FNFARLecsHzDyHMkn5H0jQSk0W5GyK04MMhUuxWNWtTni7ujlaWNLtgh0
         6xtECuRnSXQ5QYu33bAMkMrTkaNq3n8VMVyc6kMmmbrXPxzRorYqLn3lMH+kmO4MiWlr
         iCbWh13hfBnujGAAECPaf90eOYNxxK7nfvNo6UUnuSf91klQ0bM/5FQloB7nSXaMgMSx
         9y5w==
X-Forwarded-Encrypted: i=1; AJvYcCWwlxybyuO3yumHRx3NUDS+uAkO5ZpgJWYtmZDq1hzoTXpZBAGSOyGn0F2wN/UW0UCz+TrzE+TDPJ5zKGm4N6jvc3SKNiSPQ7xvGP8f
X-Gm-Message-State: AOJu0YyQGGeR8yjkPjXZuRz4KDIpk9J3yhWL+IrXWMzZkrTBhpG20kdv
	oR/h9ETJ96B84BeO9hFgCQy7/unWn36zkFjXy5OFKbB6iKGIHOB7
X-Google-Smtp-Source: AGHT+IH8OznAFBhjSehWOU21eRrTOyE9vFzlKybJL45gKrasA6Tt9+zDlrJIxltsvN5YqHjI6SXUYg==
X-Received: by 2002:a05:6512:1143:b0:524:3177:8e46 with SMTP id 2adb3069b0e04-52964bb2c92mr802213e87.28.1716538739898;
        Fri, 24 May 2024 01:18:59 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066b2c9sm126875e87.143.2024.05.24.01.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:18:58 -0700 (PDT)
Date: Fri, 24 May 2024 11:18:54 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
Message-ID: <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IXbRwJC6b/vapmDD"
Content-Disposition: inline
In-Reply-To: <cover.1716533790.git.mazziesaccount@gmail.com>


--IXbRwJC6b/vapmDD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When multiple IRQ domains are created from same device-tree node they
will get same name based on the device-tree path. This will cause a
naming collision in debugFS when IRQ domain specific entries are
created.

One use-case for being able to create multiple IRQ domains / single
device node is using regmap-IRQ controller code for devices which
provide more than one physical IRQ. It seems much cleaner to instantiate
own regmap-IRQ controller for each parent IRQ because most of the regmap
IRQ properties are really specific to parent IRQ.

Allow giving a suffix to IRQ domain name to avoid naming collisions.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Some devices which could use this are ROHM's BD96801, BD96802 and BD96811
PMICs. BD96801 is being upstreamed, others are on my TODO list - but I
believe this may be beneficial to any other devices as well. Especially
for those which provide IRQs that are clearly different form each
other.

Some discussion about this can be found from:
https://lore.kernel.org/all/Zjzt8mOW6dO_7XNV@finisterre.sirena.org.uk/
---
 include/linux/irqdomain.h | 28 ++++++++++++++++-----
 kernel/irq/irqdomain.c    | 53 +++++++++++++++++++++++++++++++--------
 2 files changed, 65 insertions(+), 16 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 21ecf582a0fe..7b1123fbd453 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -260,7 +260,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnod=
e);
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned=
 int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
-				    void *host_data);
+				    void *host_data, const char *name_suffix);
 struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
@@ -272,6 +272,12 @@ struct irq_domain *irq_domain_add_legacy(struct device=
_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
+struct irq_domain *irq_domain_create_legacy_named(struct fwnode_handle *fw=
node,
+					    unsigned int size,
+					    unsigned int first_irq,
+					    irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops,
+					    void *host_data, const char *name_suffix);
 struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
@@ -350,7 +356,8 @@ static inline struct irq_domain *irq_domain_add_linear(=
struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, h=
ost_data);
+	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops,
+				host_data, NULL);
 }
=20
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
@@ -359,7 +366,8 @@ static inline struct irq_domain *irq_domain_add_nomap(s=
truct device_node *of_nod
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, =
ops, host_data);
+	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq,
+						  ops, host_data, NULL);
 }
=20
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
@@ -369,7 +377,7 @@ static inline struct irq_domain *irq_domain_add_tree(st=
ruct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_d=
ata);
+	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_d=
ata, NULL);
 }
=20
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_ha=
ndle *fwnode,
@@ -377,14 +385,22 @@ static inline struct irq_domain *irq_domain_create_li=
near(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+	return __irq_domain_add(fwnode, size, size, 0, ops, host_data, NULL);
+}
+
+static inline struct irq_domain *irq_domain_create_linear_named(struct fwn=
ode_handle *fwnode,
+					 unsigned int size,
+					 const struct irq_domain_ops *ops,
+					 void *host_data, const char *name_suffix)
+{
+	return __irq_domain_add(fwnode, size, size, 0, ops, host_data, name_suffi=
x);
 }
=20
 static inline struct irq_domain *irq_domain_create_tree(struct fwnode_hand=
le *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data);
+	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data, NULL);
 }
=20
 extern void irq_domain_remove(struct irq_domain *host);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3dd1c871e091..07802c48bade 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -132,7 +132,8 @@ static struct irq_domain *__irq_domain_create(struct fw=
node_handle *fwnode,
 					      irq_hw_number_t hwirq_max,
 					      int direct_max,
 					      const struct irq_domain_ops *ops,
-					      void *host_data)
+					      void *host_data,
+					      const char *name_suffix)
 {
 	struct irqchip_fwid *fwid;
 	struct irq_domain *domain;
@@ -150,6 +151,17 @@ static struct irq_domain *__irq_domain_create(struct f=
wnode_handle *fwnode,
 		return NULL;
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
+		if (name_suffix)
+			return NULL;
+
 		fwid =3D container_of(fwnode, struct irqchip_fwid, fwnode);
=20
 		switch (fwid->type) {
@@ -177,7 +189,11 @@ static struct irq_domain *__irq_domain_create(struct f=
wnode_handle *fwnode,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name =3D kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		if (!name_suffix)
+			name =3D kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		else
+			name =3D kasprintf(GFP_KERNEL, "%pfw-%s", fwnode,
+					 name_suffix);
 		if (!name) {
 			kfree(domain);
 			return NULL;
@@ -249,6 +265,8 @@ static void __irq_domain_publish(struct irq_domain *dom=
ain)
  *              direct mapping
  * @ops: domain callbacks
  * @host_data: Controller private data pointer
+ * @name_suffix: Optional name suffix to avoid collisions when multiple do=
mains
+ *		 are added using same fwnode
  *
  * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
@@ -256,12 +274,12 @@ static void __irq_domain_publish(struct irq_domain *d=
omain)
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned=
 int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
-				    void *host_data)
+				    void *host_data, const char *name_suffix)
 {
 	struct irq_domain *domain;
=20
 	domain =3D __irq_domain_create(fwnode, size, hwirq_max, direct_max,
-				     ops, host_data);
+				     ops, host_data, name_suffix);
 	if (domain)
 		__irq_domain_publish(domain);
=20
@@ -362,7 +380,7 @@ struct irq_domain *irq_domain_create_simple(struct fwno=
de_handle *fwnode,
 {
 	struct irq_domain *domain;
=20
-	domain =3D __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+	domain =3D __irq_domain_add(fwnode, size, size, 0, ops, host_data, NULL);
 	if (!domain)
 		return NULL;
=20
@@ -409,21 +427,34 @@ struct irq_domain *irq_domain_add_legacy(struct devic=
e_node *of_node,
 }
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
=20
-struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+struct irq_domain *irq_domain_create_legacy_named(struct fwnode_handle *fw=
node,
 					 unsigned int size,
 					 unsigned int first_irq,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
-					 void *host_data)
+					 void *host_data, const char *name_suffix)
 {
 	struct irq_domain *domain;
=20
-	domain =3D __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + siz=
e, 0, ops, host_data);
+	domain =3D __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + siz=
e,
+				  0, ops, host_data, name_suffix);
 	if (domain)
 		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
=20
 	return domain;
 }
+EXPORT_SYMBOL_GPL(irq_domain_create_legacy_named);
+
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					 unsigned int size,
+					 unsigned int first_irq,
+					 irq_hw_number_t first_hwirq,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
+{
+	return irq_domain_create_legacy_named(fwnode, size, first_irq,
+					      first_hwirq, ops, host_data, NULL);
+}
 EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
=20
 /**
@@ -1146,9 +1177,11 @@ struct irq_domain *irq_domain_create_hierarchy(struc=
t irq_domain *parent,
 	struct irq_domain *domain;
=20
 	if (size)
-		domain =3D __irq_domain_create(fwnode, size, size, 0, ops, host_data);
+		domain =3D __irq_domain_create(fwnode, size, size, 0, ops,
+					     host_data, NULL);
 	else
-		domain =3D __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
+		domain =3D __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data,
+					     NULL);
=20
 	if (domain) {
 		if (parent)
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

--IXbRwJC6b/vapmDD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZQTW4ACgkQeFA3/03a
ocWN8QgAoV2jqqJfOiTw6xoIETHiyAAJRhD7c1IBHwuvcplEcGSbmvq9fxRLy3sp
FUdOKf6vMFuilLQfbkOn/lyupMSroyehbD5U8jmAYH11tj8WGlUepf5lGzQ/6FyB
sixYWsYkYsjtKbjh39PnX5QS8ysJz9O+fIWtsD5yrMKWBwDlgi18tIFPsHTh7YVI
6V5mV22K9CpCJLQuA2+vWSxe9jfkqYpHN3B8FZDVf+9ob7mn456ztw3vLbEOkUIp
eDX3qEwoUkVNCR3YO9NXSOJWNjc6yd6u0ppCXmlKB1UDWuriEx91ZWmES2lVqxWl
k/iebLBnrhf3EftoBn4IbcBeKra0Rg==
=6iDu
-----END PGP SIGNATURE-----

--IXbRwJC6b/vapmDD--

