Return-Path: <linux-kernel+bounces-255158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9916933CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2D91C22823
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC617FAB6;
	Wed, 17 Jul 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Fi9XPKfP"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202E14F6C;
	Wed, 17 Jul 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218447; cv=pass; b=ODJIO9LakkKehX7mN8zZuoi6WLV+aiC+YWSKuBHILDswQ7W5U1w5I3+6XwbvsmfN2kTXpIIXLJ2bNqobJV2eaGfSawEH2LE/waBTAfQBTWB4nLHmOhZLacfa9blSb96vu/gI92Xanznr5i9QCJkHOZ0hgt28mtyAWuznih7afhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218447; c=relaxed/simple;
	bh=1ro306oJtwPJGD4bRJH9Oz7hjTng8FSazB4p561g1Ro=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=fdZtl4MzzvYCv8ukfvR55Dg7vIzxVDoZlaVSCigwfYB6jN+IIV0JHwJAa9wI8SYYMtiO5mC1iwiA1qJxk2WbHctgfi9gfYok9wgWDg4kT/wdeDbGBE+ON02oV6jr6r4fu3NzXIpX9XdiGnGao2Yobj2hRfgfnQX2lgFtmUQPOQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Fi9XPKfP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WPFGb5m0fzyVP;
	Wed, 17 Jul 2024 15:13:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1721218442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zV30Oaz/+3O+8LGsjPpfGA2IrdtTFpds3os2OOfj6vc=;
	b=Fi9XPKfPL4p4WU/grjUK4XuEzVEFnflut40GCyP6GwxplF7ct785Gj6oisTwuOVkXnk2N3
	KH3nXJg77jqkxXFXkhncF7hg1UxYbpkYMNo0Su8cLKUPdoyZoJ2L9qDv+c+BKe1mxmlpYt
	en3DS2sy0B0faLjsQAR/DDWDjJB6qKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1721218442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zV30Oaz/+3O+8LGsjPpfGA2IrdtTFpds3os2OOfj6vc=;
	b=b5YcQ/CuO5wMPdoAOpjYz/Im8nmOOdz8X9E6x5YILmcSQ6Q+l84xhjgY0IBzvuSHbBcs+i
	P0+vjKkZkxNzHY6AOecNUH/mFRO6DI5KxPbGG2ng6FhfU8VkrO6B7ReqWTyAHJ18gh0FHC
	Ay00yk9vhgRkuxUqZe12wjR9YgxSNok=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1721218442; a=rsa-sha256; cv=none;
	b=ZfQAfm67UUBzVrmCJEFiaDqCc+UXVnwHsfWBoSxOrB6EF2ApgusHDtuM7258qKdp8RmgW0
	STAWcQ39EJQnHrOYXVTFvSBj3zMYQJJnVyccMOopk8PgD5iWr2EZv6oXKAokin5w3lYqjn
	poXqBnxC4XY3NxKSRLs/6dNftapZp0U=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 15:13:59 +0300
Message-Id: <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi>
Cc: <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>, "Rob Herring (Arm)"
 <robh@kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe
 Leroy" <christophe.leroy@csgroup.eu>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240702161052.3563599-1-robh@kernel.org>
 <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi>
In-Reply-To: <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi>

On Wed Jul 17, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> On Tue Jul 2, 2024 at 7:10 PM EEST, Rob Herring (Arm) wrote:
> > The PPC64 specific MMIO setup open codes DT address functions rather
> > than using standard address parsing functions. The open-coded version
> > fails to handle any address translation and is not endian safe.
> >
> > I haven't found any evidence of what platform used this. The only thing
> > that turned up was a PPC405 platform, but that is 32-bit and PPC405
> > support is being removed as well. CONFIG_TCG_ATMEL is not enabled for
> > any powerpc config and never was. The support was added in 2005 and
> > hasn't been touched since.
> >
> > Rather than try to modernize and fix this code, just remove it.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/char/tpm/Kconfig     |   2 +-
> >  drivers/char/tpm/tpm_atmel.c |  64 +++++++++++++++-
> >  drivers/char/tpm/tpm_atmel.h | 140 -----------------------------------
> >  3 files changed, 62 insertions(+), 144 deletions(-)
> >  delete mode 100644 drivers/char/tpm/tpm_atmel.h
> >
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index e63a6a17793c..9b655e9fc7ab 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -162,7 +162,7 @@ config TCG_NSC
> > =20
> >  config TCG_ATMEL
> >  	tristate "Atmel TPM Interface"
> > -	depends on PPC64 || HAS_IOPORT_MAP
> > +	depends on HAS_IOPORT_MAP
> >  	depends on HAS_IOPORT
> >  	help
> >  	  If you have a TPM security chip from Atmel say Yes and it=20
> > diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.=
c
> > index 9fb2defa9dc4..622c4abe8cb3 100644
> > --- a/drivers/char/tpm/tpm_atmel.c
> > +++ b/drivers/char/tpm/tpm_atmel.c
> > @@ -15,7 +15,67 @@
> >   */
> > =20
> >  #include "tpm.h"
> > -#include "tpm_atmel.h"
> > +
> > +struct tpm_atmel_priv {
> > +	int region_size;
> > +	int have_region;
> > +	unsigned long base;
> > +	void __iomem *iobase;
> > +};
> > +
> > +#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offs=
et)
> > +#define atmel_putb(val, chip, offset) \
> > +	outb(val, atmel_get_priv(chip)->base + offset)
> > +#define atmel_request_region request_region
> > +#define atmel_release_region release_region
> > +/* Atmel definitions */
> > +enum tpm_atmel_addr {
> > +	TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> > +	TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> > +};
> > +
> > +static inline int tpm_read_index(int base, int index)
> > +{
> > +	outb(index, base);
> > +	return inb(base+1) & 0xFF;
> > +}
> > +
> > +/* Verify this is a 1.1 Atmel TPM */
> > +static int atmel_verify_tpm11(void)
> > +{
> > +
> > +	/* verify that it is an Atmel part */
> > +	if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> > +	    tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> > +	    tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> > +	    tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> > +		return 1;
> > +
> > +	/* query chip for its version number */
> > +	if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> > +	    tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> > +		return 1;
> > +
> > +	/* This is an atmel supported part */
> > +	return 0;
> > +}
> > +
> > +/* Determine where to talk to device */
> > +static void __iomem * atmel_get_base_addr(unsigned long *base, int *re=
gion_size)
> > +{
> > +	int lo, hi;
> > +
> > +	if (atmel_verify_tpm11() !=3D 0)
> > +		return NULL;
> > +
> > +	lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> > +	hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> > +
> > +	*base =3D (hi << 8) | lo;
> > +	*region_size =3D 2;
> > +
> > +	return ioport_map(*base, *region_size);
> > +}
> > =20
> >  /* write status bits */
> >  enum tpm_atmel_write_status {
> > @@ -142,7 +202,6 @@ static void atml_plat_remove(void)
> >  	tpm_chip_unregister(chip);
> >  	if (priv->have_region)
> >  		atmel_release_region(priv->base, priv->region_size);
> > -	atmel_put_base_addr(priv->iobase);
> >  	platform_device_unregister(pdev);
> >  }
> > =20
> > @@ -211,7 +270,6 @@ static int __init init_atmel(void)
> >  err_unreg_dev:
> >  	platform_device_unregister(pdev);
> >  err_rel_reg:
> > -	atmel_put_base_addr(iobase);
> >  	if (have_region)
> >  		atmel_release_region(base,
> >  				     region_size);
> > diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.=
h
> > deleted file mode 100644
> > index 7ac3f69dcf0f..000000000000
> > --- a/drivers/char/tpm/tpm_atmel.h
> > +++ /dev/null
> > @@ -1,140 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0-only */
> > -/*
> > - * Copyright (C) 2005 IBM Corporation
> > - *
> > - * Authors:
> > - * Kylene Hall <kjhall@us.ibm.com>
> > - *
> > - * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > - *
> > - * Device driver for TCG/TCPA TPM (trusted platform module).
> > - * Specifications at www.trustedcomputinggroup.org
> > - *
> > - * These difference are required on power because the device must be
> > - * discovered through the device tree and iomap must be used to get
> > - * around the need for holes in the io_page_mask.  This does not happe=
n
> > - * automatically because the tpm is not a normal pci device and lives
> > - * under the root node.
> > - */
> > -
> > -struct tpm_atmel_priv {
> > -	int region_size;
> > -	int have_region;
> > -	unsigned long base;
> > -	void __iomem *iobase;
> > -};
> > -
> > -#ifdef CONFIG_PPC64
> > -
> > -#include <linux/of.h>
> > -
> > -#define atmel_getb(priv, offset) readb(priv->iobase + offset)
> > -#define atmel_putb(val, priv, offset) writeb(val, priv->iobase + offse=
t)
> > -#define atmel_request_region request_mem_region
> > -#define atmel_release_region release_mem_region
> > -
> > -static inline void atmel_put_base_addr(void __iomem *iobase)
> > -{
> > -	iounmap(iobase);
> > -}
> > -
> > -static void __iomem * atmel_get_base_addr(unsigned long *base, int *re=
gion_size)
> > -{
> > -	struct device_node *dn;
> > -	unsigned long address, size;
> > -	const unsigned int *reg;
> > -	int reglen;
> > -	int naddrc;
> > -	int nsizec;
> > -
> > -	dn =3D of_find_node_by_name(NULL, "tpm");
> > -
> > -	if (!dn)
> > -		return NULL;
> > -
> > -	if (!of_device_is_compatible(dn, "AT97SC3201")) {
> > -		of_node_put(dn);
> > -		return NULL;
> > -	}
> > -
> > -	reg =3D of_get_property(dn, "reg", &reglen);
> > -	naddrc =3D of_n_addr_cells(dn);
> > -	nsizec =3D of_n_size_cells(dn);
> > -
> > -	of_node_put(dn);
> > -
> > -
> > -	if (naddrc =3D=3D 2)
> > -		address =3D ((unsigned long) reg[0] << 32) | reg[1];
> > -	else
> > -		address =3D reg[0];
> > -
> > -	if (nsizec =3D=3D 2)
> > -		size =3D
> > -		    ((unsigned long) reg[naddrc] << 32) | reg[naddrc + 1];
> > -	else
> > -		size =3D reg[naddrc];
> > -
> > -	*base =3D address;
> > -	*region_size =3D size;
> > -	return ioremap(*base, *region_size);
> > -}
> > -#else
> > -#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offs=
et)
> > -#define atmel_putb(val, chip, offset) \
> > -	outb(val, atmel_get_priv(chip)->base + offset)
> > -#define atmel_request_region request_region
> > -#define atmel_release_region release_region
> > -/* Atmel definitions */
> > -enum tpm_atmel_addr {
> > -	TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> > -	TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> > -};
> > -
> > -static inline int tpm_read_index(int base, int index)
> > -{
> > -	outb(index, base);
> > -	return inb(base+1) & 0xFF;
> > -}
> > -
> > -/* Verify this is a 1.1 Atmel TPM */
> > -static int atmel_verify_tpm11(void)
> > -{
> > -
> > -	/* verify that it is an Atmel part */
> > -	if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> > -	    tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> > -	    tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> > -	    tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> > -		return 1;
> > -
> > -	/* query chip for its version number */
> > -	if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> > -	    tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> > -		return 1;
> > -
> > -	/* This is an atmel supported part */
> > -	return 0;
> > -}
> > -
> > -static inline void atmel_put_base_addr(void __iomem *iobase)
> > -{
> > -}
> > -
> > -/* Determine where to talk to device */
> > -static void __iomem * atmel_get_base_addr(unsigned long *base, int *re=
gion_size)
> > -{
> > -	int lo, hi;
> > -
> > -	if (atmel_verify_tpm11() !=3D 0)
> > -		return NULL;
> > -
> > -	lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> > -	hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> > -
> > -	*base =3D (hi << 8) | lo;
> > -	*region_size =3D 2;
> > -
> > -	return ioport_map(*base, *region_size);
> > -}
> > -#endif
>
> Responding from holidays but:
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> [still away for couple of weeks]

I got these in with checkpatch.pl --strict:

CHECK: Macro argument 'offset' may be better as '(offset)' to avoid precede=
nce issues
#59: FILE: drivers/char/tpm/tpm_atmel.c:26:
+#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offset)

CHECK: Macro argument 'offset' may be better as '(offset)' to avoid precede=
nce issues
#60: FILE: drivers/char/tpm/tpm_atmel.c:27:
+#define atmel_putb(val, chip, offset) \
+	outb(val, atmel_get_priv(chip)->base + offset)

CHECK: spaces preferred around that '+' (ctx:VxV)
#73: FILE: drivers/char/tpm/tpm_atmel.c:40:
+	return inb(base+1) & 0xFF;
 	              ^

CHECK: Blank lines aren't necessary after an open brace '{'
#79: FILE: drivers/char/tpm/tpm_atmel.c:46:
+{
+

Can you address them and I'll tag the next version, once I've
revisited checkpatch. Otherwise, nothing against the code change.

BR, Jarkko

