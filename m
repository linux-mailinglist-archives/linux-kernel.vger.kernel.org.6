Return-Path: <linux-kernel+bounces-231141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30199186B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D1028310B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F9918F2D7;
	Wed, 26 Jun 2024 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJkoJt9v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF218F2CC;
	Wed, 26 Jun 2024 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417681; cv=none; b=XgCt7GDFu9OEipJgMZ1MnaAyq6/6UMXn22QVTA2LyzJvZxsBr47NTFuud/gi7s1roDNMLZtwm1uRO2GSregYQQKnUD9f8yXfxf+JTTbyZOWMG5D5d4hfOtGUwMI1zyupbOFusnG7PoB1n/Is1ylcRfufWnY2QUDwspxYRiMjztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417681; c=relaxed/simple;
	bh=nyv3bEUAakqLC7rtOzRHOgPOsPXjI0dRN38MP/V4ocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2Oj0AuY/vsu6nxa5tTeIQ07UE26AsoCNAVWvlNp0npnoHcQuVrfrbnUNHP93JjMnFPobpI1LwJ31cGcgv0Cpodn/LNkjgMblMIeIlJ6LqaecZUE0CKIhDgt2ilb8sGJV0AEJT5OHnSwSrQJJSXGUvz6rVV9d4T/KtQIUOpPhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJkoJt9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D334C116B1;
	Wed, 26 Jun 2024 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417681;
	bh=nyv3bEUAakqLC7rtOzRHOgPOsPXjI0dRN38MP/V4ocg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FJkoJt9v6CUbHgJB4OqNjVcNwf7o/wx/KhKF0GYKtBWuaw3WaaN/4d8Gwt0KSeVXa
	 Nk4og+i76ei30mfMjgYjQ1oxVoaA4ZVDGOoGl9aUMEpWCuZ9WBKXGyuSe5RSzNIHxx
	 kVRL3qVCJRECsnwkVYZoe40szEAQnHbx0kbxspTGbjWc95Ou4M7NezIj4mkZVA5lsq
	 NudAOXZ0VZgyjJpyFdosSWbISF1iSQgUnpT0/LIBegeCfucQaJUAzQ3cnzyznO/DbW
	 iXFK5zPihTlY/Ok4th03aEqd6Jn7jv8jqQzVI4dC/mfmV1LtZ4xnynyYEv986EPpZ2
	 1u6wgyXo8jTYg==
Date: Wed, 26 Jun 2024 17:01:16 +0100
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
Message-ID: <20240626-refined-cadmium-d850b9e15230@spud>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
 <20240625210933.1620802-2-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2g5NVOE5lfng/7+O"
Content-Disposition: inline
In-Reply-To: <20240625210933.1620802-2-samuel.holland@sifive.com>


--2g5NVOE5lfng/7+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 02:09:12PM -0700, Samuel Holland wrote:
> The RISC-V Pointer Masking specification defines three extensions:
> Smmpm, Smnpm, and Ssnpm. Document the behavior of these extensions as
> following the current draft of the specification, which is 1.0.0-rc2.

You say draft, but the actual extension has already completed public
review, right?

>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
> Changes in v2:
>  - Update pointer masking specification version reference
>=20
>  .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cfed80ad5540..b6aeedc53676 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -128,6 +128,18 @@ properties:
>              changes to interrupts as frozen at commit ccbddab ("Merge pu=
ll
>              request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
> =20
> +        - const: smmpm
> +          description: |
> +            The standard Smmpm extension for M-mode pointer masking as d=
efined
> +            at commit 654a5c4a7725 ("Update PDF and version number.") of
> +            riscv-j-extension.
> +
> +        - const: smnpm
> +          description: |
> +            The standard Smnpm extension for next-mode pointer masking a=
s defined
> +            at commit 654a5c4a7725 ("Update PDF and version number.") of
> +            riscv-j-extension.
> +
>          - const: smstateen
>            description: |
>              The standard Smstateen extension for controlling access to C=
SRs
> @@ -147,6 +159,12 @@ properties:
>              and mode-based filtering as ratified at commit 01d1df0 ("Add=
 ability
>              to manually trigger workflow. (#2)") of riscv-count-overflow.
> =20
> +        - const: ssnpm
> +          description: |
> +            The standard Ssnpm extension for next-mode pointer masking a=
s defined
> +            at commit 654a5c4a7725 ("Update PDF and version number.") of
> +            riscv-j-extension.
> +
>          - const: sstc
>            description: |
>              The standard Sstc supervisor-level extension for time compar=
e as
> --=20
> 2.44.1
>=20

--2g5NVOE5lfng/7+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnw7TAAKCRB4tDGHoIJi
0lzdAP9FEjY6nhgecyj1qyL7BY1ORdvCG0mlA35ivg61fW7EsgEAwwWyBymmuOic
KbI1oP/Agz7PwvDvQ4h4QigAxWc+jQs=
=tYy9
-----END PGP SIGNATURE-----

--2g5NVOE5lfng/7+O--

