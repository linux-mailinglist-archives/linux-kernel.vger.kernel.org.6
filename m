Return-Path: <linux-kernel+bounces-284826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958EF95058A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC7E281C90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C946D199EAB;
	Tue, 13 Aug 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPTYmt0g"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569D199392
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553426; cv=none; b=A9P6rAv+Y1XmLJnblbLJjqmlJPDYC6l/OSmO5Nep9RayXMRTS9sAFHkFBlH3kqzlTdU2Q6bFyJ3y9pjMOOqHOB824Iqobb4604jgkKaeVqmQ8yspEaepQRuacvtS0xzOg3oH6qtbpTMLLtymRaIEuUUL05VQaQL8HyAAq/k7i78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553426; c=relaxed/simple;
	bh=yQuyweB5q7DdoH2VSQhl4pxz164hxKVPEa2rPFWqBR4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nw6NoejEpCPyAItrYhs75t+OuB4PVAZb8qnyVcVqn8+8SuhGuKt+6jlPUPBueaLx0nY0faWokOiOWi6QGU3LxgGpZzzK6XNZJYXQ07cAMvfJkp4o5e7dLaWjX/W7cw6oRmpjiwwkxmnNV2ZNtOyFvtsC5WImyWI7QrRY37zmic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPTYmt0g; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f01613acbso7003426e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723553422; x=1724158222; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2k/GTyYRiJ4oM36iNUmCHo0ldUjfhdMSEf930zi126w=;
        b=QPTYmt0gGOniNgD6XbrVrZybyt0UURkz3PDc4532W2LYUtrY5dXW4Ev4oiV/nZzwZ2
         O3w6w0BnmH6DJCQYX+QdNLiwpkJv3K2AmPlDnvV/IelQFGAFNgSFWJGSQc01LTv96OVd
         kR7TaIuG2ndKpkyp91upx+bIU+SOXPzrgMoSemJdOMB21QCV7/A7OuxSEUS2ZpQG6ofG
         vaiqyLVoioaTE+5zzCc3O7BPwhM0nn8AktKtbqzx1Q8rrw2SRwBhqH/XljxaiYhic0om
         07NODldAWZiq4dqm9j9FozcNilrSC8PgFni4SrSj9cw8QWFBTpwDP51qK0LRBl4+wFmG
         Ahhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553422; x=1724158222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2k/GTyYRiJ4oM36iNUmCHo0ldUjfhdMSEf930zi126w=;
        b=wmv58N0EjZGdUsCGWcDBE9Oxr0V6nbpuNK2WgnbY2YDfChQGF9HwlHK40iWf7p4R+q
         /u9wyl4XAOxSoUOzG6yq7y3tFPxE5N1FyMinqNM5ielXkl78CgWWDvqcFnIRr+gQ+G5R
         XSg3SNOp4lTuPvSgAwrsaT2tpffZ1Nnh3ISvOeopuEMeJb/XuaUZYoePMZE3oaCh4GPS
         Y7dGgkb0BYI+i0vEU+YpjzXGsdVeh0LyVqJyhFTjNiRQLkzsvT2PM3/9ewsIRcQEZ0WE
         u8NPFkHpM5044g/POdmEz6L4EW9Gwre0OehxtsloEKJ+R4tzHgkntXv2B1PRb+qAF97g
         OteQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhsg9pSv+f8KAb4vMyAzoqAJOi2+CdqR/3D6IxEanFL8zaJI//AYDmr8EVs0QN7wNb04tQqq9QM7mQE+xqFFitpINmxVE6cBFyMbNU
X-Gm-Message-State: AOJu0YyRnnE3JtmwULSACaLE57G4jqZea3DsW4BXvAjxYmizBpkN5xkO
	uPBoZgnrvs1x8peYMVGSrLbVQ6DqXzleejVjBFob4nGKBV3CojYXaEdNyA==
X-Google-Smtp-Source: AGHT+IFDUUHO3l3tUHyNXpichZRYpMMrdsHeQzeAyKQ1YjLEFpPmMBvxXopa2Y2BggpZNI0St27TFA==
X-Received: by 2002:a05:6512:b14:b0:52e:a644:98e8 with SMTP id 2adb3069b0e04-53213dae154mr748087e87.27.1723553421528;
        Tue, 13 Aug 2024 05:50:21 -0700 (PDT)
Received: from fedora ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f428b3sm1012978e87.288.2024.08.13.05.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:50:20 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:50:08 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] irqdomain: Fix irq_domain_create_legacy() when first_irq is 0
Message-ID: <ZrtWgF1iNP81az8f@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="47CrDD4eLmkSeVIV"
Content-Disposition: inline


--47CrDD4eLmkSeVIV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

commit 70114e7f7585 ("irqdomain: Simplify simple and legacy domain creation=
")
changed logic of calling the irq_domain_associate_many() from the
irq_domain_create_legacy() when first_irq is set to 0. Before the change,
the irq_domain_associate_many() is unconditionally called inside the
irq_domain_create_legacy(). After the change, the call is omitted when
first_irq is set to 0. This breaks MIPS systemns where
drivers/irqchip/irq-mips-cpu.c has irq_domain_add_legacy() called with
first_irq set to 0.

Fixes: 70114e7f7585 ("irqdomain: Simplify simple and legacy domain creation=
")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---

This was tested on MIPS by Jiaxun. Please feel free to add the tested-by
line if you like :)

 kernel/irq/irqdomain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 01001eb615ec..5be165399a96 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -300,7 +300,8 @@ static void irq_domain_instantiate_descs(const struct i=
rq_domain_info *info)
 }
=20
 static struct irq_domain *__irq_domain_instantiate(const struct irq_domain=
_info *info,
-						   bool cond_alloc_descs)
+						   bool cond_alloc_descs,
+						   bool cond_force_associate)
 {
 	struct irq_domain *domain;
 	int err;
@@ -337,10 +338,9 @@ static struct irq_domain *__irq_domain_instantiate(con=
st struct irq_domain_info
 		irq_domain_instantiate_descs(info);
=20
 	/* Legacy interrupt domains have a fixed Linux interrupt number */
-	if (info->virq_base > 0) {
+	if (cond_force_associate || info->virq_base > 0)
 		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
 					  info->size - info->hwirq_base);
-	}
=20
 	return domain;
=20
@@ -360,7 +360,7 @@ static struct irq_domain *__irq_domain_instantiate(cons=
t struct irq_domain_info
  */
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *in=
fo)
 {
-	return __irq_domain_instantiate(info, false);
+	return __irq_domain_instantiate(info, false, false);
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
=20
@@ -464,7 +464,7 @@ struct irq_domain *irq_domain_create_simple(struct fwno=
de_handle *fwnode,
 		.ops		=3D ops,
 		.host_data	=3D host_data,
 	};
-	struct irq_domain *domain =3D __irq_domain_instantiate(&info, true);
+	struct irq_domain *domain =3D __irq_domain_instantiate(&info, true, false=
);
=20
 	return IS_ERR(domain) ? NULL : domain;
 }
@@ -513,7 +513,7 @@ struct irq_domain *irq_domain_create_legacy(struct fwno=
de_handle *fwnode,
 		.ops		=3D ops,
 		.host_data	=3D host_data,
 	};
-	struct irq_domain *domain =3D irq_domain_instantiate(&info);
+	struct irq_domain *domain =3D __irq_domain_instantiate(&info, false, true=
);
=20
 	return IS_ERR(domain) ? NULL : domain;
 }

base-commit: 1e7c05292531e5b6bebe409cd531ed4ec0b2ff56
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

--47CrDD4eLmkSeVIV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAma7VnwACgkQeFA3/03a
ocWyTQgAsmU1Yf47UkCCVC/5hCJ5Q9ZvsCQK0HObb9fCg8uX2jdJpygTaX5eZN99
8j5mwxO0naQvYvnxSd1NyNvUJ/DushszaTfa/0tjhxzsV+vYzZAmyXHFujeTjTdu
OdmuBgrFoK4/Lw0rB4E9W2VigTk0t2rsB4RkBwfECuiGYVDXqSf37nxiNATafAs1
2ZFmCtURi3YSyzW/RC2kVdZeL763cLE0t2INZPuhNbAQYMTViblLtTxHtTqsn7GC
KotqdtqIMDNlbalH4xC05mryQ9BU+0+vX5f1ALf7eh+H+Hh4k4A9Jf6ubihmTi0p
hXFme6KKLcADoDkFHx04dTLwhxZ/0A==
=cKGm
-----END PGP SIGNATURE-----

--47CrDD4eLmkSeVIV--

