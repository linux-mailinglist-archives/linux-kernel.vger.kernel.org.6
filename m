Return-Path: <linux-kernel+bounces-560561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9171DA6069A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55B546055F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B11B13D246;
	Fri, 14 Mar 2025 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IV0LVRvT"
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC61386B4
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912561; cv=none; b=mpqQg1vVp5f/EqmaZLxWGECIKhYJ+f1PsQlFAl+Nx04M0kSX48p2/0nkG3ruKY5HL11OddlVwzdprRbuYzcnQskPTNYxZqOgzkagBmv1ebaOhLWuWBluwmxdYHzREPhEQKApA4Bipk3b1o0k4A/0MwidSxZWy9Dda933PYezUig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912561; c=relaxed/simple;
	bh=UBQCkinyVXtoYGUuEtjWctCIDp6wpWpyJrrlXuHXHrw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUojfLpd4qHHetn/pU7EUpOZWDXr3RMEEEph/gO0KBHCCLiZrCoytQmSG9T1/KNoVy9Qs7rpmm+CSssYvV4O8upcB7frUhZcvqgSVq9UQtyvxJUkU4TannXf3BCm5LN6lstrL0uXM/OjuU21MuThiQx20+yGSlb7qxmrc+yWukM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IV0LVRvT; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741912556; x=1742171756;
	bh=UBQCkinyVXtoYGUuEtjWctCIDp6wpWpyJrrlXuHXHrw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=IV0LVRvTpLturMerlgpQ229BAnypstXfgepPxUmuyE5OiyLgX4ON40CsFnA/sLrlB
	 tJVPws9e8f/uDMgpRj3uguH9oXWhVG4JfP3pH8WJkDdBCi1A/NwpgGnHUN9p4VqGDf
	 C+OvaLVXqtViPXZcSydswkJBSyJeuN0ryIIDBzKW4PukMQZZ/kQDn2wdpmea1VdoG/
	 ZaFUzcvekBC3cJw/B2ds9s0YsPR415I9bLvUMrHr2CyQOKJq8kyKWF0xr+o4Hgorwv
	 GOB20eUIMfoNnLCN5bQZtsdHYWmys6dau7ckRaOQTR4AtXau+AWZIDvkBR6Md0JYYP
	 M0zygLONimdVg==
Date: Fri, 14 Mar 2025 00:35:51 +0000
To: Dave Hansen <dave.hansen@intel.com>
From: Denis Mukhin <dmkhn@proton.me>
Cc: dmukhin@ford.com, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/early_printk: add MMIO-based UARTs
Message-ID: <QKiXvDxnTzqiTDN61eP_MtKY53BNMuH5wG_PHWrr_VbdjypCjsDmioJ7SYg4a8sfp1In8OV0aihcLffmjkNCklhe5cTZ3km22cS604TpIYE=@proton.me>
In-Reply-To: <cfc6916e-802f-4727-aa74-b052f94d0101@intel.com>
References: <20250313-earlyprintk-v1-1-8f818d77a8dd@ford.com> <cfc6916e-802f-4727-aa74-b052f94d0101@intel.com>
Feedback-ID: 123220910:user:proton
X-Pm-Message-ID: 321b00b4827518539abbe38e6b337b1d8c0a534a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thursday, March 13th, 2025 at 5:04 PM, Dave Hansen <dave.hansen@intel.co=
m> wrote:

>=20
>=20
> On 3/13/25 16:45, Denis Mukhin via B4 Relay wrote:
>=20
> > During the bring-up of an x86 board, the kernel was crashing before
> > reaching the platform's console driver because of a bug in the firmware=
,
> > leaving no trace of the boot progress.
> >=20
> > It was discovered that the only available method to debug the kernel
> > boot process was via the platform's MMIO-based UART, as the board lacke=
d
> > an I/O port-based UART, PCI UART, or functional video output.
>=20
>=20
> This is a pretty exotic piece of hardware, right? It's not some off the
> shelf laptop?

Correct, this is not off the shelf laptop.

>=20
> Is there a driver for it during normal runtime?

Yes, that is a variant of NS16550 UART.

>=20
> > Then it turned out that earlyprintk=3D does not have a knob to configur=
e
> > the MMIO-mapped UART.
> >=20
> > Extend the early printk facility to support platform MMIO-based UARTs
> > on x86 systems, enabling debugging during the system bring-up phase.
> >=20
> > The command line syntax to enable platform MMIO-based UART is:
> > earlyprintk=3Dmmio,membase[,{nocfg|baudrate}][,keep]
>=20
>=20
>=20
> I'll stick this in the queue to take a closer look after the next merge
> window closes. It's a bit on the late side in the 6.14 cycle for new stuf=
f.
>=20
> I do appreciate the importance of having this tool in your toolbox.
> earlyprintk has saved my bacon more times than I can count.

Thanks!

--
Denis

