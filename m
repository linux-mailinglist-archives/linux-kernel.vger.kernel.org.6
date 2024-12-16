Return-Path: <linux-kernel+bounces-447962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5D9F3945
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57108188FF88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4F20766C;
	Mon, 16 Dec 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1ZPNrm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F828204F8B;
	Mon, 16 Dec 2024 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374963; cv=none; b=IoOVWt5Ub/BBu3YheP+lGX4RI15SRWSY+PihnHyTENjZzKjRab7UyQHqFq2V/DzNHxNVj72L0KZD6wn+XClJVaFqQVcBZbGPj3nzTkXv1YP+aiNGj/5qQvLClV5GYSqR1a38lg1WC9Wkwmr9Nt0Z6TbTynC5HhCB4/VQ4BO5X50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374963; c=relaxed/simple;
	bh=ZeQQScruNqW/bJ/x/lj6Dul84Yp6/f/jX5d+nsFQXP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m97OQSLiCYArpUd/hEgpaWKNAIQ1hFk16ivlt25LvKhlZx4bzA7Z6lBf4DLeoDEnP+pmyRi+T9ncda5YdsUwiznQjKYFC8gcCOQg3Q6jftjlfnKVy9xx3Lxi1BHuEA6oQp5n8vvofoFrt8NpSMhYIeOSv6uj15xuiG6KyNopOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1ZPNrm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25A3C4CED0;
	Mon, 16 Dec 2024 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734374963;
	bh=ZeQQScruNqW/bJ/x/lj6Dul84Yp6/f/jX5d+nsFQXP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1ZPNrm77Hzb3Yr+VIztPlS4AaSqQZsY4L4YZA9QyjHnf9y9BKoeORsmL5zqgKM5z
	 zLaNqRq6UgjB77sZjplhEZvkYOwLVcGoCG3dowN1eWsh6i5FORV033E1421uFMGfFD
	 ikzKblefGpcRe5va/r0VTspaftVOegoMzFiPLys3IV/zW/amTD8r56rT9kmc+udtBt
	 4QRQxrK5zAnkPf+4VqrMovYSuSx4UGoHBY6wxRrubhkokRlvQdN8/aFhXyhQv60rcM
	 a4ZHBnq1aW8/33AXSZy4Tfg96sbT4oMedVo3YzFjVgm0J++jU5Ff5gptjzJi3iK5wo
	 UEUM1dM3cddig==
Date: Mon, 16 Dec 2024 18:49:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] dt-bindings: mailbox: Add bindings for RPMI
 shared memory transport
Message-ID: <20241216-untrained-scarce-211d99984416@spud>
References: <20241216084817.373131-1-apatel@ventanamicro.com>
 <20241216084817.373131-3-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DW1/Ea3gbyAW1RUZ"
Content-Disposition: inline
In-Reply-To: <20241216084817.373131-3-apatel@ventanamicro.com>


--DW1/Ea3gbyAW1RUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 02:18:11PM +0530, Anup Patel wrote:
> Add device tree bindings for the common RISC-V Platform Management
> Interface (RPMI) shared memory transport as a mailbox controller.
>=20
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../mailbox/riscv,rpmi-shmem-mbox.yaml        | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-=
shmem-mbox.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-m=
box.yaml b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.=
yaml
> new file mode 100644
> index 000000000000..8d713ba7ffc7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/riscv,sbi-mpxy-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V Platform Management Interface (RPMI) shared memory mailbox
> +
> +maintainers:
> +  - Anup Patel <anup@brainfault.org>
> +
> +description: |
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a common s=
hared
> +  memory based RPMI transport. This RPMI shared memory transport integra=
tes as
> +  mailbox controller in the SBI implementation or supervisor software wh=
ereas
> +  each RPMI service group is mailbox client in the SBI implementation and
> +  supervisor software.
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  References
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  [1] RISC-V Platform Management Interface (RPMI)
> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> +
> +properties:
> +  compatible:
> +    const: riscv,rpmi-shmem-mbox
> +
> +  reg:
> +    oneOf:
> +      - items:
> +        - description: A2P request queue base address
> +        - description: P2A acknowledgment queue base address
> +        - description: P2A request queue base address
> +        - description: A2P acknowledgment queue base address
> +        - description: A2P doorbell address
> +      - items:
> +        - description: A2P request queue base address
> +        - description: P2A acknowledgment queue base address
> +        - description: A2P doorbell address
> +
> +  reg-names:
> +    oneOf:
> +      - items:
> +        - const: a2p-req
> +        - const: p2a-ack
> +        - const: p2a-req
> +        - const: a2p-ack
> +        - const: db-reg
> +      - items:
> +        - const: a2p-req
> +        - const: p2a-ack
> +        - const: db-reg
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 1
> +    description:
> +      The RPMI shared memory transport supports wired interrupt specifie=
d by
> +      this property as the P2A doorbell.
> +
> +  msi-parent:
> +    description:
> +      The RPMI shared memory transport supports MSI as P2A doorbell and =
this
> +      property specifies the target MSI controller.
> +
> +  riscv,slot-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 64
> +    description:
> +      Power-of-2 RPMI slot size of the RPMI shared memory transport.
> +
> +  riscv,db-mask:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Update only the register bits of doorbell defined by the mask (32 =
bit).

For an untested RFC, the bindings here look mostly fine. I'd suggest
renaming "db" to "doorbell" in properties etc, since we can easily
afford the extra characters. Please make sure to actually test the
bindings next time around, looks like all 3 bindings produced warnings.

General comments like not needing to provide minItems: 1 when maxItems
is also 1, and not needing a | unless you have formatting to preserve.

> +      If this property is not present then mask is assumed to be 0xfffff=
fff.

Also, things like this should be handled with a `default: 0xffffffff`,
rather than describing it in text.

I'll give the !rfc bindings a proper review when they appear, but before
that I'll give the code here a go too - thanks for sending the patches.

Cheers,
Conor.

--DW1/Ea3gbyAW1RUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2B2LQAKCRB4tDGHoIJi
0oJNAP9JzetQCsrZEN1o9LOtrG9uzZmopAxjlXBU4Ev0ivS0wgD9GrrhOQX2dGfa
MzxcsO3uL5ROuSy48vQfWsf+RA9CnAA=
=lG3u
-----END PGP SIGNATURE-----

--DW1/Ea3gbyAW1RUZ--

