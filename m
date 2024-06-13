Return-Path: <linux-kernel+bounces-213453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80076907588
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361401F22E68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4DC84A41;
	Thu, 13 Jun 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTLGRq+m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF1B664
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289938; cv=none; b=sWWlFV3S8nkwq+kAzQ025zRiJD0sRKCJPehOa6eF8LZE4qmQNpSQGNZeVRue0fwRB4nYwz4ovgccAWSgHHsM81qbteJHnmpPOCeNv3jY37q0c2BlMDno2wwzAu8RINCydN2GyNWIAoRzyvY4W8tZUm0md1uk8+sUnXDfLCjB7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289938; c=relaxed/simple;
	bh=InMkkQqrp6LohnfMJCBwnWlQ6oAWATxmLwHmBrNPrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tye4m9r/EXEZQJiXP7mjTTXP+6cuR5UD6VhQ/49zAU7v7hY+H5oC6cYy4Mp3NhRGu0Ndi8JRp/U2REwoIsVsXgqOBHgt2orJOmhh+jemNa2TL0fcziysHlT6rQIC+RaGWU4Vknbln6X/Ks/QX+RR1N3M9EhJ8O0fm470Dgw/jdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTLGRq+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA901C2BBFC;
	Thu, 13 Jun 2024 14:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289937;
	bh=InMkkQqrp6LohnfMJCBwnWlQ6oAWATxmLwHmBrNPrGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTLGRq+msZPdiljWIIbChj7j0CTeKCfawgg6iDL6MqP+rFNN2aVjWpy0CmJVOAgKy
	 g6Kxc2TC8WMraFODKBYKhl8xXxsYE0OPT4Tv3T6MMsHj4u1AsnXyrCTTIKsnJx/OCA
	 EO/2gCT546u3YMbHbMIl8k4emxuNzqPS9oaOX8V47ftb7y4jMt3hmwV/9mupn94ozr
	 23giyNwjsiASb5BhFIpfiyLCKc9dvUqATFYa7z1vKRiyIw2Bkee0Q8VKnOjUNQ5Dy/
	 xRgPWZrxRYHts2EkCOyjvn+Zr827udCCaeOTbY9NLNEDlKAyJv2VkbfgJ8SVerevQO
	 tSZKfByHAP+sQ==
Date: Thu, 13 Jun 2024 15:45:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] riscv: Separate vendor extensions from standard
 extensions
Message-ID: <20240613-deepness-refried-c6dea811f6f6@spud>
References: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ICFdcertGdMCTx5g"
Content-Disposition: inline
In-Reply-To: <20240609-support_vendor_extensions-v2-0-9a43f1fdcbb9@rivosinc.com>


--ICFdcertGdMCTx5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 09, 2024 at 09:34:13PM -0700, Charlie Jenkins wrote:
> All extensions, both standard and vendor, live in one struct
> "riscv_isa_ext". There is currently one vendor extension, xandespmu, but
> it is likely that more vendor extensions will be added to the kernel in
> the future. As more vendor extensions (and standard extensions) are
> added, riscv_isa_ext will become more bloated with a mix of vendor and
> standard extensions.
>=20
> This also allows each vendor to be conditionally enabled through
> Kconfig.
>=20
> ---
> This has been split out from the previous series that contained the
> addition of xtheadvector due to lack of reviews. The xtheadvector
> support will be posted again separately from this.

I think that's a good call.

> The reviewed-bys on "riscv: Extend cpufeature.c to detect vendor extensio=
ns"
> and "riscv: Introduce vendor variants of extension helpers" have been
> dropped in this series. The majority of the code is the same in these
> patches, but thead-specific code is swapped out with andes-specific
> code. The changes are minimal, but I decided to drop the reviews in case
> I inadvertently introduced issues.

Actually, you only completely did that on the first of the two patches
you mention, but I don't mind.

--ICFdcertGdMCTx5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmsGDQAKCRB4tDGHoIJi
0pYSAP9rvZJvNB06EdO0fsFWf+ZcA3sSaIFnn6FuW9XS1h/5IgEAzSlVcU4SmJ4X
iE60uHO4zub2um02J5KOxOg+yrHU8Q0=
=sR76
-----END PGP SIGNATURE-----

--ICFdcertGdMCTx5g--

