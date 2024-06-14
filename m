Return-Path: <linux-kernel+bounces-214502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921E9085A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6841C21FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F511183071;
	Fri, 14 Jun 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pU4lSOlz"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F21474CB;
	Fri, 14 Jun 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352436; cv=none; b=INla4od6iLQ6HG4uzFRT2b8I6em/y+ZDp3/5TCsW2d4IzjvUSY7zBX/mK2Scfjr7MVDurhLAileqR9BD/5zr7Vkw5K1RGpUU5tkaRQOHtBd2uY4OKgXOV7pEKfx0fvRzSEiViF4IuAz17VR9DJhPBcyLqJDxBS+ss0pPJCi74T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352436; c=relaxed/simple;
	bh=DMK+CWELdQnDrMQO/JKXFNX+z8myFs0IXh6Wo0q7b5Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOrE56/QzktxFhIG10BlHRiKsHnoo/QV/sHOjSxR0sy8kdyQK9XzDUPl5mF42YhbZreZgUDyp3nXCO/nQdqbuapg9jgMNh3mibsxtX88Sm/5J3Y43U9tBcCke9Hl/RPG5DhvMllQS5VInaMDe4vBH3TGqAJqqMYV4ibpLI+3itQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pU4lSOlz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718352433; x=1749888433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DMK+CWELdQnDrMQO/JKXFNX+z8myFs0IXh6Wo0q7b5Q=;
  b=pU4lSOlzut6VVA7JXsuFGTlpFTE1wSSNimx9oKzC2IO/x9EAfBrmUwrA
   dUBz0NVYEvSkXwhrNXrJnOZr+mp2aRV+CdMenPtXowvODmx+jBqj1XrBu
   wS9sWzPhSmAliBuTosLuX8XAiQ5bDDSIgoHbja/9Hv0RQtG7/a4JRU6Zl
   cI5OeaXunW1FhXKiowGkmrjfmfySCrRSsbQFr/+BwsPJVTScHzQLTepcw
   YdBsT517D3XbNHFzvLHkWKbdSDUsjRxh4EjlTj/ad1nu2EeEo0xVj2TGY
   net5hz4gCoKTMLRf0YSczWNcSucJJ+G3kWK8WOafQeTy9Nhvg8SUEsHG+
   w==;
X-CSE-ConnectionGUID: E0Y3hlcORKiEqud2JIoT4A==
X-CSE-MsgGUID: hXS/9NvCRrK8U4zhnOg3vw==
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="asc'?scan'208";a="28157199"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jun 2024 01:07:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 14 Jun 2024 01:06:43 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 14 Jun 2024 01:06:38 -0700
Date: Fri, 14 Jun 2024 09:06:20 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Jesse Taube <jesse@rivosinc.com>
CC: <linux-riscv@lists.infradead.org>, Jonathan Corbet <corbet@lwn.net>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>, Evan Green
	<evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, Charlie Jenkins
	<charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>, Andy Chiu
	<andy.chiu@sifive.com>, Eric Biggers <ebiggers@google.com>, Greentime Hu
	<greentime.hu@sifive.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin
	<costa.shul@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan
 He <bhe@redhat.com>, Anup Patel <apatel@ventanamicro.com>, Zong Li
	<zong.li@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, Ben Dooks
	<ben.dooks@codethink.co.uk>, Alexandre Ghiti <alexghiti@rivosinc.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Erick Archer
	<erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: riscv: Add Zicclsm ISA extension
 description.
Message-ID: <20240614-broaden-bluish-8b2fe892db55@wendy>
References: <20240613191616.2101821-1-jesse@rivosinc.com>
 <20240613191616.2101821-3-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6rVBoByRG8F88jlI"
Content-Disposition: inline
In-Reply-To: <20240613191616.2101821-3-jesse@rivosinc.com>

--6rVBoByRG8F88jlI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 03:16:11PM -0400, Jesse Taube wrote:
> Add description for Zicclsm ISA extension.
>=20
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> V1 -> V2:
>  - New patch
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index cfed80ad5540..9f6aae1f5b65 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -317,6 +317,13 @@ properties:
>              The standard Zicboz extension for cache-block zeroing as rat=
ified
>              in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> =20
> +        - const: zicclsm
> +          description:
> +            The standard Zicclsm extension for misaligned support for al=
l regular
> +            load and store instructions (including scalar and vector) bu=
t not AMOs
> +            or other specialized forms of memory access. Defined in the
> +            RISC-V RVA Profiles Specification.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> +
>          - const: zicntr
>            description:
>              The standard Zicntr extension for base counters and timers, =
as
> --=20
> 2.43.0
>=20

--6rVBoByRG8F88jlI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmv57wAKCRB4tDGHoIJi
0v0FAP9mwX36VWSnRozk96nyVM3RIf8dHyi71Dw0gJMNUha3GgEA3nQVPysOqYVF
bZxE5DpI/lku06/oD+G/uESgN8mlDQw=
=89e4
-----END PGP SIGNATURE-----

--6rVBoByRG8F88jlI--

