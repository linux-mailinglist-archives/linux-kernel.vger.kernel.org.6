Return-Path: <linux-kernel+bounces-519910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98437A3A380
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAA9A3AC7E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267CD26FA4B;
	Tue, 18 Feb 2025 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0rViv0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7592EAE6;
	Tue, 18 Feb 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898158; cv=none; b=e7IymiN1IkGWXFtpRryNvxSk3Nc45tU/ZoWWbkYFW+g32KsRzW2GdlkhITsqQh8U+ifwrTLUcfdKTVFz1hmbHy7ARZBeBt4J5Geqyjbowh1P9ywEgf1pCSTauCwb0+QKgeXYfhTqrOfffEJwzjCGgxFZfjbeRsHrFynejPj8UE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898158; c=relaxed/simple;
	bh=hxZMRmhOej47toRK0ik8X/JMRjiOAT/0BXqJA9WLLpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/trUrBISxvmihN5/23WUoorEArDR/LQYPP56sXWXHGEBsaAe2n8y2CVEnF71UdvW8ybdoxaTL7xqBT4x1aWyl58OI/OM3DDvJX+a+v3T4b1palv/GJvtMpT8vAm5cbgyuxEZ77BVvMkGP258xSZ9858r7Cua4wICxHJodesRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0rViv0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0710C4CEE2;
	Tue, 18 Feb 2025 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898158;
	bh=hxZMRmhOej47toRK0ik8X/JMRjiOAT/0BXqJA9WLLpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0rViv0sVQMs1kcS09YPvJGHeRgaoq1Jl9rlYGzR4H9ea6gvTt6GDQSQFfi39D5MW
	 Lx0wkdSCEG6bIPhtC94JRqFKxcR9OBZYlYA+INqx3FWi7nUQh5Y/aBXq+qiEQI8EyK
	 sgbC8X2HWlAbIc9fuXT0ZQxNxgZ72DWakw6ivVnB1ou4fdsrCeyCZ4yfUuuaCeWVwa
	 wWyeva0LHupfTEwL4WJKQ17ZCeLMaJObNQO+uNdz0eByJHKyYmltmKp6BsTPAPUv83
	 i+OgfxTIjVRcgGpIVjTZO2yfanb7r58xBadVfuw1off27um1zAjgVgWHynyitiYJap
	 Hs4iFjifok+cw==
Date: Tue, 18 Feb 2025 17:02:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Xukai Wang <kingxukai@zohomail.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Troy Mitchell <TroyMitchell988@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/3] riscv: canaan: Add support for K230-Canmv clock
Message-ID: <20250218-poplar-iron-c894fe8deca6@spud>
References: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kbLHPbgA0NhUTES7"
Content-Disposition: inline
In-Reply-To: <20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com>


--kbLHPbgA0NhUTES7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen,

Is the driver in this series satisfactory to you? If it is, can I send
you a PR containing it and the binding so that I can apply the final
patch in the series (and merge the basic support for the k230 soc)?

Cheers,
Conor.

On Mon, Feb 17, 2025 at 10:45:15PM +0800, Xukai Wang wrote:
> This patch series adds clock controller support for the Canaan Kendryte
> K230 SoC. The K230 SoC includes an external 24MHz OSC and 4 internal
> PLLs, with the controller managing these sources and their derived clocks.
>=20
> The clock tree and hardware-specific definition can be found in the
> vendor's DTS [1],
> and this series is based on the K230 initial series [2].
>=20
> Link: https://github.com/kendryte/k230_sdk/blob/main/src/little/linux/arc=
h/riscv/boot/dts/kendryte/clock_provider.dtsi [1]
> Link: https://lore.kernel.org/linux-clk/tencent_F76EB8D731C521C18D5D7C4F8=
229DAA58E08@qq.com/ [2]
>=20
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
>=20
> ---
> Changes in v4:
> - Remove redundant onecell_get callback and add_provider function
> for pll_divs.
> - Modify the base-commit in cover letter.
> - Link to v3: https://lore.kernel.org/r/20250203-b4-k230-clk-v3-0-362c791=
24572@zohomail.com
>=20
> Changes in v3:
> - Reorder the defination and declaration in drivers code.
> - Reorder the properties in dts node.
> - Replace global variable `k230_sysclk` with dynamic memory allocation.
> - Rename the macro K230_NUM_CLKS to K230_CLK_NUM.
> - Use dev_err_probe for error handling.
> - Remove unused includes.
> - Link to v2: https://lore.kernel.org/r/20250108-b4-k230-clk-v2-0-27b30a2=
ca52d@zohomail.com
>=20
> Changes in v2:
> - Add items and description.
> - Rename k230-clk.h to canaan,k230-clk.h
> - Link to v1: https://lore.kernel.org/r/20241229-b4-k230-clk-v1-0-221a917=
e80ed@zohomail.com
>=20
> ---
> Xukai Wang (3):
>       dt-bindings: clock: Add bindings for Canaan K230 clock controller
>       clk: canaan: Add clock driver for Canaan K230
>       riscv: dts: canaan: Add clock initial support for K230
>=20
>  .../devicetree/bindings/clock/canaan,k230-clk.yaml |   43 +
>  arch/riscv/boot/dts/canaan/k230.dtsi               |   32 +
>  drivers/clk/Kconfig                                |    6 +
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/clk-k230.c                             | 1347 ++++++++++++++=
++++++
>  include/dt-bindings/clock/canaan,k230-clk.h        |   49 +
>  6 files changed, 1478 insertions(+)
> ---
> base-commit: 7fdb24bbac37ce692346d60b89f5aa29844b8b88
> change-id: 20241206-b4-k230-clk-925f33fed6c2
>=20
> Best regards,
> --=20
> Xukai Wang <kingxukai@zohomail.com>
>=20

--kbLHPbgA0NhUTES7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ7S9KAAKCRB4tDGHoIJi
0rI1AP9y8hypNtdPcY14Ojl+N98Ywv6/Uwj7IvHIC4k2+k80ZAD/RhGE8a8Zix3V
2BB5hrI/mGOw51ydyOw7cdBuw6S8nAk=
=hINT
-----END PGP SIGNATURE-----

--kbLHPbgA0NhUTES7--

