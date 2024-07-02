Return-Path: <linux-kernel+bounces-237991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D939241D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345B71C22314
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C681BB695;
	Tue,  2 Jul 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6+rSvzr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2745C1DFFC;
	Tue,  2 Jul 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932555; cv=none; b=S5FmUZVf9xBQNiIGrJdGdTyhRBXeGmENkT6lwbZYaipW4dE8UwV7TQmSpl/WWmnNQFARasSsDfV7f9+WK6rOCm92MHBatXHtFDQE2+JUU81oHIfrtb+3o6HVJj03diQPYi15wEqoloIsxDi5OSVvxABqtvxCJo7V2Kwgnhj8XUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932555; c=relaxed/simple;
	bh=ztMq901XmUFB1BuzPipFR04mykoZrcUnpHnDqCoR3FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eee2RnWZJOYHT275sYii7uib1TU2DdcJj995PmtB26nO4PIF034ZtvAsYSWTUnDHFqopqlZpbHoOp64+txJIqMT+u8X2dINTrSvfRGid545NPBo+OrdiTiXFLMWOOTWZONzbbFSovDjwHgcoDbkCHm0TkHXEQPzS6THi4Z/QGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6+rSvzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D79EC116B1;
	Tue,  2 Jul 2024 15:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719932554;
	bh=ztMq901XmUFB1BuzPipFR04mykoZrcUnpHnDqCoR3FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t6+rSvzrscxfKsOyntILw2yEyYa2bECDdGf8HrqfOaLd2CfPjD6pNgXxf1Sz06+/y
	 bUfdSoCvAj+/vSE+h6WNZNTQcuiWjCMkaWECQiUEsgRUah77RLElTzuF2vE3fV9TnF
	 hVaEE6xO1kF3aFfjX2OlS7SvitwVjgTRaxf+pMFtn2cChaSnEACOlovUfIhxu3JPyI
	 tz6DtPoo1KRfqCKVo199acbNJlcac8p7PWeTYIYd1SkfpdYF6u2FFNNoYGhy44+QQR
	 0b9PARwt0+91sxNI2XQnfHpW6aby7rUjQhAL0TdwdijM9bxzbgjUzEMbEraek696ev
	 8Ns5Tt3zJE4Dg==
Date: Tue, 2 Jul 2024 16:02:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/4] riscv: Add ISA extension parsing for Svvptc
Message-ID: <20240702-reset-skirmish-74c6a30b41ad@spud>
References: <20240702085034.48395-1-alexghiti@rivosinc.com>
 <20240702085034.48395-2-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgGaz+REe5RWb2vu"
Content-Disposition: inline
In-Reply-To: <20240702085034.48395-2-alexghiti@rivosinc.com>


--xgGaz+REe5RWb2vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 10:50:31AM +0200, Alexandre Ghiti wrote:
> Add support to parse the Svvptc string in the riscv,isa string.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>


Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--xgGaz+REe5RWb2vu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZoQWhgAKCRB4tDGHoIJi
0ifAAP9plyA2m/vt7qY20XZcvjGlyy0qgUy50Xu5Kixsyo4MeAEAuTY4Ovy1WMj+
EW0wPL8aWFktQf2DmAJj/JhJcA9QwwE=
=F09G
-----END PGP SIGNATURE-----

--xgGaz+REe5RWb2vu--

