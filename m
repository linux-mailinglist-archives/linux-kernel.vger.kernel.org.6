Return-Path: <linux-kernel+bounces-304572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B8B9621F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0556FB24A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AA14B959;
	Wed, 28 Aug 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jgZgbRJT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62F415AAC1;
	Wed, 28 Aug 2024 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724832013; cv=none; b=UGdMeYPqgaq9YV6We4ery3zFLCmRV+OHlNutpk1IdhHnbbVtZxj5G58YKLC8Kt4xANaQNOsWgSJaymcssul1s+XGPJLNs67B1LTZkui0u3+fYwhYk91pnW4DUPzdrGkb+oI3pr2khPXBNBHLGBxXoYCGaqDmWxstyGjvJOPWvrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724832013; c=relaxed/simple;
	bh=UlG6nchsqBKmiYp8pAVvbHG5hJwd3EJQs1Sv91Wc4dM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwLHDrdB7cCv27yL93nxi1s+nvHKg7oQjbyRPuoq32W1XG9fdBZCijmKgJaFgwfzBr+ckjoslB41UnY50oZrn3GZMdlQK/2gW8kaP2oN3b/VOg4Y2Csu7EcXcPGx/RjOhvLyAg3PkpcpqyUX97nTzU6EirNUiDygMxjGb5RQOSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jgZgbRJT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724832011; x=1756368011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UlG6nchsqBKmiYp8pAVvbHG5hJwd3EJQs1Sv91Wc4dM=;
  b=jgZgbRJTIgKkW6EC0BiR3uwyHppxXZe2pTyt+P8Gxf8+aHJZCqhT5PZd
   blNbcKHjnK9ahNParu4MvFB0LDRquoQVino7aKUlGHs6p74hyw3L4wzFv
   6J3Vub+o2ZuIytjoJfTgLSYkthLRGFEW9I8U6Eyc+CM3P7mXm6PjYeBB2
   PrQT84+/mbus7Gy18ZIHcqAmOdinI0/7eRODYSHzmVOeKh1nDnnCMNzFN
   EJiJpO9TWilWQqFoQrXrHTIj+keriP6uvEdtL78Q+mPRXOEEpv9MUpg7u
   Yy2iHd9rcnMQ2yqfBaAvytA8TUdPldg0rQ4/m3NCRt6ov2rimLwRBt++s
   w==;
X-CSE-ConnectionGUID: vBLI3Y69RSK7UCFTHu+5EA==
X-CSE-MsgGUID: JIhNA13dTE6oYGp9Pk08yA==
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="asc'?scan'208";a="31646340"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 01:00:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 00:59:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 28 Aug 2024 00:59:14 -0700
Date: Wed, 28 Aug 2024 08:58:43 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bo Gan <ganboing@gmail.com>
CC: <zong.li@sifive.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<Pragnesh.patel@sifive.com>, <aou@eecs.berkeley.edu>,
	<erik.danie@sifive.com>, <hes@sifive.com>, <mturquette@baylibre.com>,
	<palmer@dabbelt.com>, <palmerdabbelt@google.com>, <paul.walmsley@sifive.com>,
	<pragnesh.patel@openfive.com>, <sboyd@kernel.org>, <schwab@linux-m68k.org>,
	<yash.shah@sifive.com>
Subject: Re: [PATCH 3/3] clk: sifive: prci: Add release_reset hooks for
 gemgxlpll/cltxpll
Message-ID: <20240828-duplex-skillful-752582090412@wendy>
References: <cover.1724827635.git.ganboing@gmail.com>
 <e47b943c0f685cd028ebd477e97e1706f184a7b6.1724827635.git.ganboing@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J+WpBVuQQDWSZqNh"
Content-Disposition: inline
In-Reply-To: <e47b943c0f685cd028ebd477e97e1706f184a7b6.1724827635.git.ganboing@gmail.com>

--J+WpBVuQQDWSZqNh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 11:55:20PM -0700, Bo Gan wrote:
> This patch adds the release_reset hook interface to __prci_wrpll_data.
> During clock enablement, the function (if present) will be called after P=
LL
> registers are configured. It aligns the logic to the driver in u-boot. Wh=
en
> there's a previous bootloader stage, such as u-boot, it usually enables t=
he
> gemgxlpll clock when trying to PXE/network boot. The kernel boots fine, b=
ut
> we should not depend on it being our previous stage, and the logic within:
>=20
>  a. We (linux) can get directly invoked by firmware (OpenSBI).
>  b. U-boot doesn't necessarily have to initialize ethernet and enable the
>     clock (when not enabled in CONFIG).
>=20
> When the kernel is the first to initialize gemgxlpll, it must also release
> the corresponding reset. Otherwise the chip will just hang during macb
> initialization, and even external JTAG debugger will lose control over the
> risc-v debug module. (Observed with my Sifive Unmatched Rev.B board)
>=20
> The patch took the dt-bindings and logics directly from u-boot with some
> additional modifications:
>  - Use __prci_writel after __prci_readl to have barrier semantic. U-boot
>    has the strong version of readl/writel, but linux has the relaxed ones.
>  - Use pd->reset.rcdev.ops to access the reset regs.
>  - Split reset bindings for FU540/FU740 and use them directly, instead of
>    looking it up through reset-names.

The macb driver already supports using a reset at boot time (see zynq and
mpfs) if hooked up in the devicetree, why doesn't that work for you in
this situation?

Thanks,
Conor.

>=20
> Signed-off-by: Bo Gan <ganboing@gmail.com>
> ---
>  drivers/clk/sifive/fu540-prci.h  | 16 ++++++++++++++++
>  drivers/clk/sifive/fu740-prci.h  | 31 +++++++++++++++++++++++++++++++
>  drivers/clk/sifive/sifive-prci.c | 23 +++++++++++++++++++++++
>  drivers/clk/sifive/sifive-prci.h |  8 ++++++++
>  4 files changed, 78 insertions(+)
>=20
> diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-p=
rci.h
> index e0173324f3c5..9d2ca18f47a4 100644
> --- a/drivers/clk/sifive/fu540-prci.h
> +++ b/drivers/clk/sifive/fu540-prci.h
> @@ -23,9 +23,24 @@
>  #include <linux/module.h>
> =20
>  #include <dt-bindings/clock/sifive-fu540-prci.h>
> +#include <dt-bindings/reset/sifive-fu540-prci.h>
> =20
>  #include "sifive-prci.h"
> =20
> +/**
> + * sifive_fu540_prci_ethernet_release_reset() - Release ethernet reset
> + * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mu=
x reg
> + *
> + */
> +static void sifive_fu540_prci_ethernet_release_reset(struct __prci_data =
*pd)
> +{
> +	/* Release GEMGXL reset */
> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU540_PRCI_RST_GEMGXL_N=
);
> +
> +	/* Procmon =3D> core clock */
> +	sifive_prci_set_procmoncfg(pd, PRCI_PROCMONCFG_CORE_CLOCK_MASK);
> +}
> +
>  /* PRCI integration data for each WRPLL instance */
> =20
>  static struct __prci_wrpll_data sifive_fu540_prci_corepll_data =3D {
> @@ -43,6 +58,7 @@ static struct __prci_wrpll_data sifive_fu540_prci_ddrpl=
l_data =3D {
>  static struct __prci_wrpll_data sifive_fu540_prci_gemgxlpll_data =3D {
>  	.cfg0_offs =3D PRCI_GEMGXLPLLCFG0_OFFSET,
>  	.cfg1_offs =3D PRCI_GEMGXLPLLCFG1_OFFSET,
> +	.release_reset =3D sifive_fu540_prci_ethernet_release_reset,
>  };
> =20
>  /* Linux clock framework integration */
> diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-p=
rci.h
> index f31cd30fc395..dd0f54277a99 100644
> --- a/drivers/clk/sifive/fu740-prci.h
> +++ b/drivers/clk/sifive/fu740-prci.h
> @@ -10,9 +10,38 @@
>  #include <linux/module.h>
> =20
>  #include <dt-bindings/clock/sifive-fu740-prci.h>
> +#include <dt-bindings/reset/sifive-fu740-prci.h>
> =20
>  #include "sifive-prci.h"
> =20
> +/**
> + * sifive_fu740_prci_ethernet_release_reset() - Release ethernet reset
> + * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mu=
x reg
> + *
> + */
> +static void sifive_fu740_prci_ethernet_release_reset(struct __prci_data =
*pd)
> +{
> +	/* Release GEMGXL reset */
> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_GEMGXL_N=
);
> +
> +	/* Procmon =3D> core clock */
> +	sifive_prci_set_procmoncfg(pd, PRCI_PROCMONCFG_CORE_CLOCK_MASK);
> +
> +	/* Release Chiplink reset */
> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_CLTX_N);
> +}
> +
> +/**
> + * sifive_fu740_prci_cltx_release_reset() - Release cltx reset
> + * @pd: struct __prci_data * for the PRCI containing the Ethernet CLK mu=
x reg
> + *
> + */
> +static void sifive_fu740_prci_cltx_release_reset(struct __prci_data *pd)
> +{
> +	/* Release CLTX reset */
> +	pd->reset.rcdev.ops->deassert(&pd->reset.rcdev, FU740_PRCI_RST_CLTX_N);
> +}
> +
>  /* PRCI integration data for each WRPLL instance */
> =20
>  static struct __prci_wrpll_data sifive_fu740_prci_corepll_data =3D {
> @@ -30,6 +59,7 @@ static struct __prci_wrpll_data sifive_fu740_prci_ddrpl=
l_data =3D {
>  static struct __prci_wrpll_data sifive_fu740_prci_gemgxlpll_data =3D {
>  	.cfg0_offs =3D PRCI_GEMGXLPLLCFG0_OFFSET,
>  	.cfg1_offs =3D PRCI_GEMGXLPLLCFG1_OFFSET,
> +	.release_reset =3D sifive_fu740_prci_ethernet_release_reset,
>  };
> =20
>  static struct __prci_wrpll_data sifive_fu740_prci_dvfscorepll_data =3D {
> @@ -49,6 +79,7 @@ static struct __prci_wrpll_data sifive_fu740_prci_hfpcl=
kpll_data =3D {
>  static struct __prci_wrpll_data sifive_fu740_prci_cltxpll_data =3D {
>  	.cfg0_offs =3D PRCI_CLTXPLLCFG0_OFFSET,
>  	.cfg1_offs =3D PRCI_CLTXPLLCFG1_OFFSET,
> +	.release_reset =3D sifive_fu740_prci_cltx_release_reset,
>  };
> =20
>  /* Linux clock framework integration */
> diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive=
-prci.c
> index caba0400f8a2..ae8055a84466 100644
> --- a/drivers/clk/sifive/sifive-prci.c
> +++ b/drivers/clk/sifive/sifive-prci.c
> @@ -249,6 +249,9 @@ int sifive_prci_clock_enable(struct clk_hw *hw)
>  	if (pwd->disable_bypass)
>  		pwd->disable_bypass(pd);
> =20
> +	if (pwd->release_reset)
> +		pwd->release_reset(pd);
> +
>  	return 0;
>  }
> =20
> @@ -448,6 +451,26 @@ void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct _=
_prci_data *pd)
>  	r =3D __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
>  }
> =20
> +/*
> + * PROCMONCFG
> + */
> +
> +/**
> + * sifive_prci_set_procmoncfg() - set PROCMONCFG
> + * @pd: struct __prci_data * PRCI context
> + * @val: u32 value to write to PROCMONCFG register
> + *
> + * Set the PROCMONCFG register to @val
> + *
> + * Context: Any context.  Caller must prevent concurrent changes to the
> + *          PROCMONCFG_OFFSET register.
> + */
> +void sifive_prci_set_procmoncfg(struct __prci_data *pd, u32 val)
> +{
> +	__prci_writel(val, PRCI_PROCMONCFG_OFFSET, pd);
> +	__prci_readl(pd, PRCI_PROCMONCFG_OFFSET);	/* barrier */
> +}
> +
>  /* PCIE AUX clock APIs for enable, disable. */
>  int sifive_prci_pcie_aux_clock_is_enabled(struct clk_hw *hw)
>  {
> diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive=
-prci.h
> index 91658a88af4e..825a0aef9fd5 100644
> --- a/drivers/clk/sifive/sifive-prci.h
> +++ b/drivers/clk/sifive/sifive-prci.h
> @@ -210,6 +210,9 @@
> =20
>  /* PROCMONCFG */
>  #define PRCI_PROCMONCFG_OFFSET			0xf0
> +#define PRCI_PROCMONCFG_CORE_CLOCK_SHIFT	24
> +#define PRCI_PROCMONCFG_CORE_CLOCK_MASK					\
> +		(0x1 << PRCI_PROCMONCFG_CORE_CLOCK_SHIFT)
> =20
>  /*
>   * Private structures
> @@ -235,6 +238,7 @@ struct __prci_data {
>   * @disable_bypass: fn ptr to code to not bypass the WRPLL (or NULL)
>   * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base =
address
>   * @cfg1_offs: WRPLL CFG1 register offset (in bytes) from the PRCI base =
address
> + * @release_reset: fn ptr to code to release clock reset
>   *
>   * @enable_bypass and @disable_bypass are used for WRPLL instances
>   * that contain a separate external glitchless clock mux downstream
> @@ -246,6 +250,7 @@ struct __prci_wrpll_data {
>  	void (*disable_bypass)(struct __prci_data *pd);
>  	u8 cfg0_offs;
>  	u8 cfg1_offs;
> +	void (*release_reset)(struct __prci_data *pd);
>  };
> =20
>  /**
> @@ -290,6 +295,9 @@ void sifive_prci_corepllsel_use_corepll(struct __prci=
_data *pd);
>  void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd);
>  void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd);
> =20
> +/* PROCMONCFG */
> +void sifive_prci_set_procmoncfg(struct __prci_data *pd, u32 val);
> +
>  /* Linux clock framework integration */
>  long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
>  				  unsigned long *parent_rate);
> --=20
> 2.34.1
>=20

--J+WpBVuQQDWSZqNh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZs7YsAAKCRB4tDGHoIJi
0luTAQCIgvGMDu52ic/bzKzN5OE+pVDqeHGa26Ys8vhKE2rAQQEA99NdX7lzDF1W
zK5BU6vMP12OdOmCBJ3GhrEQieARWg0=
=hBF/
-----END PGP SIGNATURE-----

--J+WpBVuQQDWSZqNh--

