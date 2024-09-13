Return-Path: <linux-kernel+bounces-328228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4629780CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2D5B1C21DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B1B1DA608;
	Fri, 13 Sep 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VMCMGf41"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A61BA292;
	Fri, 13 Sep 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233327; cv=none; b=Zng5vdmABoMZCSjmjI8AcHNu4kY0cCyekaRNmXKBotCikXFACjpKIAwMELeMY3q4p/xR9Duuw/DF6s7jSLY6kO5G0fRzoR6SIWY/jNcIoSa5bSiHRxwvz/NuzcRwAfa1Cgs4OrWwal/Mq9QJoWErwgTOB44Mmh0PSgEOV7lNC60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233327; c=relaxed/simple;
	bh=INE0EAx43UceBca77LIqBXQ2nySY+St4jDvMZbo6keI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d55LE+GwCS/ZfG9KRkw6ACV2URAJLHGPYW0ldlCFYDQOswoQEneQk/nJxPOiYwBagipBri/4kyHDK9HdAWoPeowmTvEQUBrSPJDrWNopOLMZIWeU5vtXebSL9gbCFflZoyq9EUe2ObaB7pe8nQTEmBrCYQBM/XD1I1G4BDRa638=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=VMCMGf41; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726233322;
	bh=nt0wBmAol6tMoem7ESVcPxXpXMmwnfJWNcB17dRflFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VMCMGf41drt8ib6eRyj4uH8cl/ZAhfszPYZyDAS80NNABs68YSgq60CPzWBpXCba4
	 pGhU3rm4oEIwEiLdnuUd43wCR5eFEtTjfpK8jsdJoDIPv+/39w7LvJ2yQYbcaDrYVi
	 LJogoDLPZdXy0dBXH+wXaneam8oozMzR3Qt0fGS69b3wFvHv1ZOOVr0kL9qDNUhTK3
	 EBt336Qp4naTEoHuXKa8EsvHiruDagdr8fctEsCLYgQEOrilMbP8ov/RDO7Cjy6Clx
	 Q7p6I0bNEJbGdgv4axsga6uFoxh3ob/8iZTdWiI9oRX00cIdo+uouwHll/iclnRAi+
	 +g0aiwiHv1cag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X4vtf1ylTz4xQV;
	Fri, 13 Sep 2024 23:15:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Rob
 Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 <linuxppc-dev@lists.ozlabs.org> 
Subject: Re: [PATCH] of: address: Unify resource bounds overflow checking
In-Reply-To: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de>
References: <20240906-of-address-overflow-v1-1-19567aaa61da@linutronix.de>
Date: Fri, 13 Sep 2024 23:15:21 +1000
Message-ID: <87plp7r8ye.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> The members "start" and "end" of struct resource are of type
> "resource_size_t" which can be 32bit wide.
> Values read from OF however are always 64bit wide.
>
> Refactor the diff overflow checks into a helper function.
> Also extend the checks to validate each calculation step.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  drivers/of/address.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 7e59283a4472..df854bb427ce 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -198,6 +198,25 @@ static u64 of_bus_pci_map(__be32 *addr, const __be32=
 *range, int na, int ns,
>=20=20
>  #endif /* CONFIG_PCI */
>=20=20
> +static int __of_address_resource_bounds(struct resource *r, u64 start, u=
64 size)
> +{
> +	u64 end =3D start;
> +
> +	if (overflows_type(start, r->start))
> +		return -EOVERFLOW;
> +	if (size =3D=3D 0)
> +		return -EOVERFLOW;
> +	if (check_add_overflow(end, size - 1, &end))
> +		return -EOVERFLOW;
> +	if (overflows_type(end, r->end))
> +		return -EOVERFLOW;
=20
This breaks PCI on powerpc qemu. Part of the PCI probe reads a resource
that's zero sized, which used to succeed but now fails due to the size
check above.

The diff below fixes it for me.

It leaves r.end =3D=3D r.start, which is fine in my case, because the code
only uses r.start.

And it seems more sane than the old code which would return
end =3D start - 1, for zero sized resources.

cheers


diff --git a/drivers/of/address.c b/drivers/of/address.c
index df854bb427ce..a001e789a6c4 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -204,9 +204,7 @@ static int __of_address_resource_bounds(struct resource=
 *r, u64 start, u64 size)
=20
 	if (overflows_type(start, r->start))
 		return -EOVERFLOW;
-	if (size =3D=3D 0)
-		return -EOVERFLOW;
-	if (check_add_overflow(end, size - 1, &end))
+	if (size > 0 && check_add_overflow(end, size - 1, &end))
 		return -EOVERFLOW;
 	if (overflows_type(end, r->end))
 		return -EOVERFLOW;

