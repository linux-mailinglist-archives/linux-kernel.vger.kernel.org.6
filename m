Return-Path: <linux-kernel+bounces-439318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5459A9EAD99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95FF51881FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE08023DE92;
	Tue, 10 Dec 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="mlLJlGZ8"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039E23DE8B;
	Tue, 10 Dec 2024 10:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825233; cv=none; b=SDt3jFlOZ9DXmMYRpr/rKqSqT6laD5zzClxXqXSEnwLHymQ6snETdycsc5IP1aefTrxvs+vLwx0qJxO1w9cxNLJFCbMMsZdRLNMX3Vwiok/bZmKUI5cQVondTajsk1fj1ep9FXDKMVOT3GVjOjw5jW6S7lBDsUaUgHOLZlx9Ky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825233; c=relaxed/simple;
	bh=Msp8EBwbSaDVGDutN7E7ic9HQFOi4liVHYOLAu6bbcc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ymh402dkNUwXSLXr87bqpnw3GPatKuzYew3qqEUhpc5+H1qXObKcHGk4VS2Hh8Dv/dNLXpoTAEaFBsvlYsPcJih4UT6qQSZVj5hQhfVS5fLUrO0nGjTo8xOu5LNSQ9szgl3+tEc2BBAqZIBBr2frgw6Xi7p5TNAg3wjQ0nKKGyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=mlLJlGZ8; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1733825224;
	bh=abpofRq31ORHYJ4N/NA7SJPQZ+/vA7JXL4gI2ORl16U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mlLJlGZ84oi24RkI4/WWM0pQA4+OYFCGEVS5SSS3+ox/gBVd/bTx2dLTNNFd2aEVV
	 Ru9FzBwoOP53KyDhcfWUlGE0yM4n9NnJkiAkSmM0He1rNGCIqMXMoDRXyLAbPlbhzi
	 lIxJ/1AcOVHm6NPewpPtkXrLbSrz04qczLfWEMNk=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BF3C71A3F9A;
	Tue, 10 Dec 2024 05:07:01 -0500 (EST)
Message-ID: <fb9f77696318823b405d30f7224a8bd95d922a36.camel@xry111.site>
Subject: Re: [PATCH v2] clk: thead: Fix TH1520 emmc and shdci clock rate
From: Xi Ruoyao <xry111@xry111.site>
To: bigunclemax@gmail.com
Cc: Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, Fu Wei	
 <wefu@redhat.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd	 <sboyd@kernel.org>, Yangtao Li <frank.li@vivo.com>, Jisheng Zhang	
 <jszhang@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Dec 2024 18:07:00 +0800
In-Reply-To: <20241210083029.92620-1-bigunclemax@gmail.com>
References: <20241210083029.92620-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-12-10 at 11:30 +0300, bigunclemax@gmail.com wrote:
> From: Maksim Kiselev <bigunclemax@gmail.com>
>=20
> In accordance with LicheePi 4A BSP the clock that comes to emmc/sdhci
> is 198Mhz which is got through frequency division of source clock
> VIDEO PLL by 4 [1].
>=20
> But now the AP_SUBSYS driver sets the CLK EMMC SDIO to the same
> frequency as the VIDEO PLL, equal to 792 MHz. This causes emmc/sdhci
> to work 4 times slower.
>=20
> Let's fix this issue by adding fixed factor clock that divides
> VIDEO PLL by 4 for emmc/sdhci.
>=20
> Link: https://github.com/revyos/thead-kernel/blob/7563179071a314f41cdcdbf=
d8cf6e101e73707f3/drivers/clk/thead/clk-light-fm.c#L454
>=20
> Fixes: ae81b69fd2b1 ("clk: thead: Add support for T-Head TH1520 AP_SUBSYS=
 clocks")
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>

It has raised the "dd if=3Dgcc-14.2.0.tar.xz of=3D/dev/null" speed report
from 22MB/s to 61MB/s (the file is on a SD card).

Tested-by: Xi Ruoyao <xry111@xry111.site>

> ---
> =C2=A0drivers/clk/thead/clk-th1520-ap.c | 13 ++++++++++++-
> =C2=A01 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th=
1520-ap.c
> index 17e32ae08720..1015fab95251 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -779,6 +779,13 @@ static struct ccu_div dpu1_clk =3D {
> =C2=A0	},
> =C2=A0};
> =C2=A0
> +static CLK_FIXED_FACTOR_HW(emmc_sdio_ref_clk, "emmc-sdio-ref",
> +			=C2=A0=C2=A0 &video_pll_clk.common.hw, 4, 1, 0);
> +
> +static const struct clk_parent_data emmc_sdio_ref_clk_pd[] =3D {
> +	{ .hw =3D &emmc_sdio_ref_clk.hw },
> +};
> +
> =C2=A0static CCU_GATE(CLK_BROM, brom_clk, "brom", ahb2_cpusys_hclk_pd, 0x=
100, BIT(4), 0);
> =C2=A0static CCU_GATE(CLK_BMU, bmu_clk, "bmu", axi4_cpusys2_aclk_pd, 0x10=
0, BIT(5), 0);
> =C2=A0static CCU_GATE(CLK_AON2CPU_A2X, aon2cpu_a2x_clk, "aon2cpu-a2x", ax=
i4_cpusys2_aclk_pd,
> @@ -798,7 +805,7 @@ static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_h=
clk, "perisys-apb4-hclk", p
> =C2=A0		0x150, BIT(12), 0);
> =C2=A0static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0=
x1c8, BIT(5), 0);
> =C2=A0static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e=
0, BIT(13), 0);
> -static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", video_pll_clk=
_pd, 0x204, BIT(30), 0);
> +static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref=
_clk_pd, 0x204, BIT(30), 0);
> =C2=A0static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x2=
04, BIT(26), 0);
> =C2=A0static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb=
_pclk_pd, 0x204, BIT(24), 0);
> =C2=A0static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_=
pd, 0x204, BIT(23), 0);
> @@ -1059,6 +1066,10 @@ static int th1520_clk_probe(struct platform_device=
 *pdev)
> =C2=A0		return ret;
> =C2=A0	priv->hws[CLK_PLL_GMAC_100M] =3D &gmac_pll_clk_100m.hw;
> =C2=A0
> +	ret =3D devm_clk_hw_register(dev, &emmc_sdio_ref_clk.hw);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, pr=
iv);
> =C2=A0	if (ret)
> =C2=A0		return ret;

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

