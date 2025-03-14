Return-Path: <linux-kernel+bounces-560563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59333A6069F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32CD460521
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8A79F5;
	Fri, 14 Mar 2025 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HJDZ29IN"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED7C17D2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912830; cv=none; b=FLvkoKXSnSIURd54BXf7pB1PCyium1gg5xoPavzkeSFS4Kofmwdf6UTdxsgpKvPeP6bd2iu5FVCaCJL3ExBhivf2SGabs6+r9LNaggCXYZkWSR29qbMqTyj4ZxBFle6qTi33fkmaoJ4UpZ9xHCqqlCTpFLcZim4wy9b9lVZxIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912830; c=relaxed/simple;
	bh=CLjoHk/2FywAKu201Za30kVxpQ8oFSYXRt+qLjcB/iE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyaoZ8YxHLHOhrriBPyk5DelRhnA18UhWgrgwJ8bU8wKgOkl5k9s+t7ev1wDvzgdJu60CPHX54Iw/2e7cgvRen5Gu+2GYD8nirEMk8bkzywH7OU/QloGCelUKPeqpOY2RsR6uSzJJBU4b0wWDMzR8NMfex9IMBk48l8BlgP6wcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HJDZ29IN; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741912825; x=1742172025;
	bh=ya/bcmooFTPxVHeVVCfgw55NiPTjhYrR/nnf5aWTFck=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HJDZ29INaDatoDQ7obeuyu1eXEiEQc1+Wy9bNJlLDUZby5U4eDqh6hvaE7IuxuCOW
	 xFsvQQa96NAKqQNa1BGzfA0+FEsEWPrNuQx4MaUBMNOCyQf40P2vV+eU8Y1e+0oXhd
	 FerfzBhOyGuPh9xPiD4QXe9x68+8GH5S01YfEZVXUf4myctITweZbSVL+WLz9EYMJl
	 CSTe7/Uf/p8Wb1Q99GqV+qY1vMrCorhWG589fHF9gBhDhCjQ+LuM1zSXH369RlFvqe
	 YIOyVCihENZ5VVeqUHrBBB71Mv3C81JDea9/lxTzsRkOwglOvNYH2kG0f/nO7zb5Zy
	 fjrx7s7B1DBRw==
Date: Fri, 14 Mar 2025 00:40:19 +0000
To: Randy Dunlap <rdunlap@infradead.org>
From: Denis Mukhin <dmkhn@proton.me>
Cc: dmukhin@ford.com, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/early_printk: add MMIO-based UARTs
Message-ID: <7_SFqopQLJqdOZk_EAmrbfmAvP9O8_zhcriVwUnSH01zgm9x3XV_G_PBgyno7fTB3Nq5DtfKDumaJZHnXT0Ju1cPflzZPX3ME5k2MtBUb0A=@proton.me>
In-Reply-To: <60067986-ce08-45da-85ba-a9ea8fedfe06@infradead.org>
References: <20250313-earlyprintk-v1-1-8f818d77a8dd@ford.com> <60067986-ce08-45da-85ba-a9ea8fedfe06@infradead.org>
Feedback-ID: 123220910:user:proton
X-Pm-Message-ID: 6471ce0ba7d43692ab059397d523171614a69a95
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, March 13th, 2025 at 5:04 PM, Randy Dunlap <rdunlap@infradead.o=
rg> wrote:

>=20
>=20
> Hi,
>=20
> On 3/13/25 4:45 PM, Denis Mukhin via B4 Relay wrote:
>=20
> > From: Denis Mukhin dmukhin@ford.com
> >=20
> > During the bring-up of an x86 board, the kernel was crashing before
> > reaching the platform's console driver because of a bug in the firmware=
,
> > leaving no trace of the boot progress.
> >=20
> > It was discovered that the only available method to debug the kernel
> > boot process was via the platform's MMIO-based UART, as the board lacke=
d
> > an I/O port-based UART, PCI UART, or functional video output.
> >=20
> > Then it turned out that earlyprintk=3D does not have a knob to configur=
e
> > the MMIO-mapped UART.
> >=20
> > Extend the early printk facility to support platform MMIO-based UARTs
> > on x86 systems, enabling debugging during the system bring-up phase.
> >=20
> > The command line syntax to enable platform MMIO-based UART is:
> > earlyprintk=3Dmmio,membase[,{nocfg|baudrate}][,keep]
> >=20
> > Note, the change does not integrate MMIO-based UART support to:
> > arch/x86/boot/early_serial_console.c
> >=20
> > Signed-off-by: Denis Mukhin dmukhin@ford.com
> > ---
> > Documentation/admin-guide/kernel-parameters.txt | 4 +++
> > arch/x86/kernel/early_printk.c | 45 ++++++++++++++++++++++++-
> > 2 files changed, 48 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index fb8752b42ec8582b8750d7e014c4d76166fa2fc1..bee9ee18a506d019dc3d330=
268e3e1c83434ebba 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1414,11 +1414,15 @@
> > earlyprintk=3Dpciserial[,force],bus:device.function[,baudrate]
> > earlyprintk=3Dxdbc[xhciController#]
> > earlyprintk=3Dbios
> > + earlyprintk=3Dmmio,membase[,{nocfg|baudrate}][,keep]
> >=20
> > earlyprintk is useful when the kernel crashes before
> > the normal console is initialized. It is not enabled by
> > default because it has some cosmetic problems.
> >=20
> > + Use "nocfg" to skip UART configuration, assume
> > + BIOS/firmware has configured UART correctly.
> > +
> > Append ",keep" to not disable it when the real console
> > takes over.
> >=20
> > diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_pri=
ntk.c
> > index 44f937015e1e25bf41532eb7e1031a6be32a6523..19248c73b5b0950e9edf1a6=
0ba67829f1cd3279e 100644
> > --- a/arch/x86/kernel/early_printk.c
> > +++ b/arch/x86/kernel/early_printk.c
> > @@ -191,7 +191,6 @@ static __init void early_serial_init(char *s)
> > early_serial_hw_init(divisor);
> > }
> >=20
> > -#ifdef CONFIG_PCI
> > static void mem32_serial_out(unsigned long addr, int offset, int value)
> > {
> > u32 __iomem *vaddr =3D (u32 __iomem *)addr;
> > @@ -206,6 +205,45 @@ static unsigned int mem32_serial_in(unsigned long =
addr, int offset)
> > return readl(vaddr + offset);
> > }
> >=20
> > +/*
> > + * early_mmio_serial_init() - Initialize MMIO-based early serial conso=
le.
> > + * @membase: UART base address.
> > + * @nocfg: Skip configuration, assume BIOS has configured UART correct=
ly.
> > + * @baudrate (int): Baud rate.
>=20
>=20
> Looks like unsigned long to me.
>=20
> > + * @keep: Keep after the real driver is available.
>=20
>=20
> These 4 "parameters" are not the function arguments.
> @s is the function argument.
>=20
> You could say in a comment that @s is scanned to obtain
> these 4 parameters or something like that.

Sorry, I messed the description.

These 4 parameters meant to describe the arguments of the string to parse:
   membase[,{nocfg|baudrate}][,keep]

I will update.

Thanks!

>=20
> > + */
> > +static __init void early_mmio_serial_init(char *s)
> > +{
> > + unsigned long baudrate;
> > + unsigned long membase;
> > + char *e;
> > +
> > + if (*s =3D=3D ',')
> > + s++;
> > +
> > + if (!strncmp(s, "0x", 2)) {
> > + membase =3D simple_strtoul(s, &e, 16);
> > + early_serial_base =3D (unsigned long)early_ioremap(membase, PAGE_SIZE=
);
> > + serial_in =3D mem32_serial_in;
> > + serial_out =3D mem32_serial_out;
> > +
> > + s +=3D strcspn(s, ",");
> > + if (s =3D=3D ',')
> > + s++;
> > + }
> > +
> > + if (!strncmp(s, "nocfg", 5))
> > + baudrate =3D 0;
> > + else {
> > + baudrate =3D simple_strtoul(s, &e, 0);
> > + if (baudrate =3D=3D 0 || s =3D=3D e)
> > + baudrate =3D DEFAULT_BAUD;
> > + }
> > + if (baudrate)
> > + early_serial_hw_init(115200 / baudrate);
> > +}
> > +
> > +#ifdef CONFIG_PCI
> > /
> > * early_pci_serial_init()
> > *
> > @@ -352,6 +390,11 @@ static int __init setup_early_printk(char *buf)
> > keep =3D (strstr(buf, "keep") !=3D NULL);
> >=20
> > while (*buf !=3D '\0') {
> > + if (!strncmp(buf, "mmio", 4)) {
> > + early_mmio_serial_init(buf + 4);
> > + early_console_register(&early_serial_console, keep);
> > + buf +=3D 4;
> > + }
> > if (!strncmp(buf, "serial", 6)) {
> > buf +=3D 6;
> > early_serial_init(buf);
> >=20
> > ---
>=20
>=20
>=20
> --
> ~Randy

