Return-Path: <linux-kernel+bounces-304431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60689961FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D8A286F01
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FB157E88;
	Wed, 28 Aug 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aXdis2mi"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8209157469
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827599; cv=none; b=B8S30/Zhw/Jul8exx4ZFGMnuu5LWO3edFkYu2PVcSt4GvObIz4lFA4pNFMFKnJCd6s7TkaJl+Kybu1nM5ErLTrP+beQwVl1IcXANR52zT+kbmeyV66h0nkmhBsNc+gk3mEWQQM63d1E6xCCP/rPrAOSLzUtZmQuQoVYeO2Pn5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827599; c=relaxed/simple;
	bh=k7OQG7UGq+5+V4/ckvBPFF0UXfEHVjzOblv15sDs95A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlBysJmzLHTFB4kT0qnNJxBupUtEU8w8Ywc0XTn4HxxPRRwb5kCCMSJ+hvoA0nlK+qe1VPHNpjVblLmmQa7J4DHCZhQUQDSOzjKuGndsrGCqwzlNRuwqwTXj6ZnTNKnQ6hO7xuAofIfLA0w91Ygb0NplP7P489quoFidYJ2+8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aXdis2mi; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724827596; x=1756363596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k7OQG7UGq+5+V4/ckvBPFF0UXfEHVjzOblv15sDs95A=;
  b=aXdis2mihd2Ja65oOhmNkoxLH3K+W/SfP/RfaE7AUto036y/ar82a3Od
   zwv2v7UoszNK7wAKvUJHElTsW+XIg+GC05lIaRIRv8bzMxYDi9l6r+bdc
   IcheA7+FmhHZc2cfWKEAlIYF7CGyTeog/av0WHPB0UO6116noE8ISb9Vz
   87qJp8Knl+N1/yt+QR5bbpDGOWjKA+O0MLoplqZ9Qr+27Lx/pyuJyau4b
   wXdxFPVOIRuYhVM1FXqpqG2neiPxOAy6n470mJNTZEWzO8Ays4JOj9eBt
   gwtFu9XIBBdlJBPaEPqUySnn5CRZrwmuL98e41rrZK0+iYjqNxSLsG4VU
   A==;
X-CSE-ConnectionGUID: x3WSnwMeTXCQAFkJ2kaqjQ==
X-CSE-MsgGUID: uEo4ucA1TdiN1WsF5bHHrQ==
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="asc'?scan'208";a="30984765"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2024 23:46:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Aug 2024 23:46:04 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Aug 2024 23:46:02 -0700
Date: Wed, 28 Aug 2024 07:45:30 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alex@ghiti.fr>
CC: Conor Dooley <conor@kernel.org>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
	<guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Philipp Tomsich
	<philipp.tomsich@vrull.eu>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
Message-ID: <20240828-wolf-expletive-f96cfc4e9c7a@wendy>
References: <20240826105737.106879-1-alexghiti@rivosinc.com>
 <20240827-striving-dispute-19b6cf97139b@spud>
 <14d633c5-804b-4be9-8329-751a2ac08c7a@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6jLkahvux+y0lESW"
Content-Disposition: inline
In-Reply-To: <14d633c5-804b-4be9-8329-751a2ac08c7a@ghiti.fr>

--6jLkahvux+y0lESW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:13:16AM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 27/08/2024 10:38, Conor Dooley wrote:
> > On Mon, Aug 26, 2024 at 12:57:37PM +0200, Alexandre Ghiti wrote:
> > > RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
> > > process, before the first memory mapping is setup so we can't have any
> > > instrumentation happening here.
> > >=20
> > > In addition, when the kernel is relocatable, we must also not issue a=
ny
> > > relocation this early since they would have been patched virtually on=
ly.
> > >=20
> > > So, instead of disabling instrumentation for the whole kernel/sbi.c f=
ile
> > > and compiling it with -fno-pie, simply move __sbi_ecall() and
> > > __sbi_base_ecall() into their own file where this is fixed.
> > IOW, this should fix the issue that we discussed here
> > https://lore.kernel.org/linux-riscv/abec162e-f3f2-488c-83d9-be17257a5df=
8@ghiti.fr/
> > also?
>=20
>=20
> Yes, as a side effect it also fixes TRACEPOINTS + [KASAN|RELOCATABLE] as I
> reported in this thread since I moved the tracepoints in a file where
> instrumentation is disabled and compiled with no-pie.

And it does, so
Closes: https://lore.kernel.org/linux-riscv/20240813-pony-truck-3e7a83e9759=
e@spud/
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--6jLkahvux+y0lESW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs7HhQAKCRB4tDGHoIJi
0mRNAQDN1X4zm0B2mqva54OgfujQV8jdFEp/nNY3Mt1f+Fmy+wEA/uHkjAC3VXyc
9lCVnuuUC/VbM/U/cV+Nqa/q5hRD2wU=
=qxcC
-----END PGP SIGNATURE-----

--6jLkahvux+y0lESW--

