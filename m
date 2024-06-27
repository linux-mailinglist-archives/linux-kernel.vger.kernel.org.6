Return-Path: <linux-kernel+bounces-232655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4763B91AC6B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE33A1F26F72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E0199391;
	Thu, 27 Jun 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiD2w6AE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579CD299;
	Thu, 27 Jun 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505055; cv=none; b=ZxB1IiSPnR52sQ9QjQTs0MNj4GK8IT/k6ir1WgaPLY2GS6W7hAeWxHmbgaazlr6AucoSdouuek+rZN825DVB4Fbs+0DyI9L8frrJIfQz8Otgik6E/dsBTERdOs5p5M029fB5aQhaFmhR+h0vcvq+ZZYHorEttkhuY3gzbRzm1D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505055; c=relaxed/simple;
	bh=JCHawlPhQVtEB/62gpaSxlS8FpdBXAdzyhtV6Q2BFkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElxHd/rStfmbCTb3v19/83jSKp2wxQqfKIU6fIDH2H2cSqiCSpExtyOuN5BjVaFqEqoro28nG12+eFU+FZIyOBSizHCtSi3L6ixApe0XobJIgM3ErAJHSq/A4IfbNuXfLc8Pd0yfYRaGe2MKdoVa1njI2ACMpNW0L8KQF8kt+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiD2w6AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F54C2BBFC;
	Thu, 27 Jun 2024 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719505055;
	bh=JCHawlPhQVtEB/62gpaSxlS8FpdBXAdzyhtV6Q2BFkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oiD2w6AE7gFDNRrMxB6X9GL0NJ/yeRh8e1hQQBQA0Oj09Iome67YbcP/FpbwnNBzd
	 Yry9mxpHo65f448GHeqv1DZOwoe+MklKyXTKmL4rayIADVJ+JeV+bXDQMM6zhk9LO+
	 DKTIl3Sx/w/RiuKFpwb8yZ9xmGQ/DdOFbGYxdWKUJDam6w8daHarEKd8VLdOAhOcCe
	 7uZqa5HElNgOUZHMElt3fTlznB3ZnY/kXPiU/M31+oKsTVPcgctXQ5q/qI+esZoawQ
	 k7svT9Kt7qnK0Jj7jMdXTk3J1ItoV5zLe+LdMMCJt044u6DiRxNy0tZAK5fwx2xzPQ
	 ZWl0oKtIsFmew==
Date: Thu, 27 Jun 2024 17:17:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
	kasan-dev@googlegroups.com, Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: riscv: Add pointer masking ISA
 extensions
Message-ID: <20240627-deprive-unclog-2fba7562a8e6@spud>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
 <20240625210933.1620802-2-samuel.holland@sifive.com>
 <20240626-refined-cadmium-d850b9e15230@spud>
 <acd4c562-1f4f-4cd0-8ff8-e24e3e70d25e@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="68QJ4uKjJCUY75Cn"
Content-Disposition: inline
In-Reply-To: <acd4c562-1f4f-4cd0-8ff8-e24e3e70d25e@sifive.com>


--68QJ4uKjJCUY75Cn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:14:27AM -0500, Samuel Holland wrote:
> Hi Conor,
>=20
> On 2024-06-26 11:01 AM, Conor Dooley wrote:
> > On Tue, Jun 25, 2024 at 02:09:12PM -0700, Samuel Holland wrote:
> >> The RISC-V Pointer Masking specification defines three extensions:
> >> Smmpm, Smnpm, and Ssnpm. Document the behavior of these extensions as
> >> following the current draft of the specification, which is 1.0.0-rc2.
> >=20
> > You say draft, but the actual extension has already completed public
> > review, right?
>=20
> Correct. The spec is frozen, and public review is complete. Here's the tr=
acking
> ticket for details: https://jira.riscv.org/browse/RVS-1111
>=20
> I use the word draft because it is still an -rc version, but I can reword=
 this
> if you prefer.

No, it's fine. I just was double checking the state of the extension
before acking the patch. It'd be good, in the future to note what the
status is, given the policy is to not accept things that are at least
frozen.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--68QJ4uKjJCUY75Cn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZn2QmgAKCRB4tDGHoIJi
0ugrAPwMAkqBdLVsNJYPUHmC+kiwO+gD/VqRmHsUype6Dvv2iQD/aPrrIh/9f5bL
PgBTuvqfvaF2Rp8IVP+TtTDUn9MREw8=
=3K8O
-----END PGP SIGNATURE-----

--68QJ4uKjJCUY75Cn--

