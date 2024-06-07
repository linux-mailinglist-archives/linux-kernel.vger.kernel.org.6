Return-Path: <linux-kernel+bounces-206221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59429005EE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6584E1F22AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224E19645E;
	Fri,  7 Jun 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNuikrl0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67009195978;
	Fri,  7 Jun 2024 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717769477; cv=none; b=DU2L6ueW3FiO/LjfUE/lc3uvCO3NAeRilMp0Pfr9MYrurIlMl5i/xsMpgsSv7LL/wrOayAa/xp2eV17TySEHFWH/6JGSqNeRSdeW0kCOd/ieDUwPxft38HC1kUjAZdW3l0IQIzkOAGiVqJN5Myh+DpouYXf7uPVBUqvm900mN8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717769477; c=relaxed/simple;
	bh=suuNusIzkzRsJ1dnHfTnPwZzMdarY3ER9yTq8osWV3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpZ3qlBswuMsz8bFSRPRIuhxvODxL9JB95FKu94L3AKYGFCtj4bcRXh65Np1VNb8L7X9fq/pypTxeGp7RdwAkM9pyMBZgHEd9R5B014unKHlijQ+6QhcSSMX8HiY/5IErhTYh8JykMwyx02GK1C9o3hqiyzfhz63Aggnob+CZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNuikrl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACD7C2BBFC;
	Fri,  7 Jun 2024 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717769477;
	bh=suuNusIzkzRsJ1dnHfTnPwZzMdarY3ER9yTq8osWV3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNuikrl0L49lh26A7q6bYFusU2zK/gBbXIAAxc9e3jAgrGu8PBouoIfK58Lv8EzE+
	 8zgwQNEezTP+5QI/lSU0FsxOnHN88MRFR7swLuJhSWZKXBQ02/+kRfPN4vZ82qf7pG
	 qvg6sYyd3XpH3VxmSvkKLtQMq0RGPMuPZ9AIc79rXZ9ROgnxKH4RRXADGQmHIscBid
	 5j8aQ6AajfIxKwFoRv9jQgoAZG/ax5Z9ZgQTlo9K6iJkPVuhy5MP6KeZ8NjYzytYHz
	 toPLdgMJymseoMp+SYasQsAYoK05Us9s1f7XzqqLF9FW5zn00azXXoUv9fuH6+Vwme
	 g3Enrgf+EoaZg==
Date: Fri, 7 Jun 2024 15:11:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RESEND v3 2/2] dt-bindings: riscv: cpus: add ref to
 interrupt-controller
Message-ID: <20240607-essay-rink-a74d82d3c56a@spud>
References: <20240523154748.22670-1-kanakshilledar111@protonmail.com>
 <20240523154748.22670-3-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WO/yTYhFE1ojeZ+A"
Content-Disposition: inline
In-Reply-To: <20240523154748.22670-3-kanakshilledar111@protonmail.com>


--WO/yTYhFE1ojeZ+A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:17:50PM +0530, Kanak Shilledar wrote:
> removed the redundant properties for interrupt-controller
> and provide reference to the riscv,cpu-intc.yaml which defines
> the interrupt-controller. making the properties for riscv
> interrupt-controller at a central place.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
> ---
> Changes in v3:
> - No change.
> - Rolling out as RESEND.
> Changes in v2:
> - Fix warning of `type` is a required property during `make
> dt_bindings_check`.
> ---
>  .../interrupt-controller/riscv,cpu-intc.yaml  |  2 +-
>  .../devicetree/bindings/riscv/cpus.yaml       | 21 +------------------
>  2 files changed, 2 insertions(+), 21 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv=
,cpu-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ris=
cv,cpu-intc.yaml
> index c9c79e0870ff..6c229f3c6735 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-in=
tc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-in=
tc.yaml
> @@ -61,7 +61,7 @@ required:
>    - compatible
>    - '#interrupt-cells'
>    - interrupt-controller
> - =20
> +

I tried to get Palmer to apply this the other day, but the series
somehow conflicts with itself, due to this hunk. When I apply patch 1/2
locally, this whitespace never appears in the file and so patch 2/2 has
a conflict:
	b4 shazam 20240523154748.22670-2-kanakshilledar111@protonmail.com
	Grabbing thread from lore.kernel.org/all/20240523154748.22670-2-kanakshill=
edar111@protonmail.com/t.mbox.gz
	Checking for newer revisions
	Grabbing search results from lore.kernel.org
	Analyzing 3 messages in the thread
	Looking for additional code-review trailers on lore.kernel.org
	Checking attestation on all messages, may take a moment...
	---
	  =E2=9C=97 [PATCH v3 1/2] dt-bindings: interrupt-controller: riscv,cpu-in=
tc: convert to dtschema
	    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
	  =E2=9C=97 [PATCH v3 2/2] dt-bindings: riscv: cpus: add ref to interrupt-=
controller
	    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
	  ---
	  =E2=9C=97 BADSIG: DKIM/gmail.com
	---
	Total patches: 2
	---
	 Base: using specified base-commit 20cb38a7af88dc40095da7c2c9094da3873fea23
	Applying: dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dt=
schema
	Applying: dt-bindings: riscv: cpus: add ref to interrupt-controller
	Patch failed at 0002 dt-bindings: riscv: cpus: add ref to interrupt-contro=
ller
	When you have resolved this problem, run "git am --continue".
	If you prefer to skip this patch, run "git am --skip" instead.
	To restore the original branch and stop patching, run "git am --abort".
	error: patch failed: Documentation/devicetree/bindings/interrupt-controlle=
r/riscv,cpu-intc.yaml:61
	error: Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-in=
tc.yaml: patch does not apply
	hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch

He also pointed out that there's a from address mismatch in this patch,
given it was sent from gmail but the signoff is proton. Usually git
send-email will sort this out, provided you've set the protonmail
address as the author for the patch. I think usually this sort of issue
comes about when your signoff email isn't the same as user.email in your
gitconfig, but 100% on that.

Thanks,
Conor.

--WO/yTYhFE1ojeZ+A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmMVAAAKCRB4tDGHoIJi
0ugyAP4gQBplTF+cj/i8WB1UnZhdAF9LfvVfGT0azEcfiURn/QEA+TUOI0QHbcCD
tZ7GD/a/3/pBOdWW3msepg1B8iHeagQ=
=wl4+
-----END PGP SIGNATURE-----

--WO/yTYhFE1ojeZ+A--

