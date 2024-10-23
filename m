Return-Path: <linux-kernel+bounces-377287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F49ABC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD81F229E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C51384BF;
	Wed, 23 Oct 2024 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECtWEs8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D4611E;
	Wed, 23 Oct 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729656039; cv=none; b=OiAYL8S+5Og38RiDDOdpsqzAch/QLLyTzl/lzBVS1GIj6VCyxCvJmcLejqZW+NtVugBdJr89eI4bGcyy+jWyAzW/WNa1UTdihNlqlQAADHbiuhK7PvKNEul0C1qbQh2yV/8wZElcVPhMniXvMvAG+EhSs2PzfBt2/Eg7GMyahH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729656039; c=relaxed/simple;
	bh=9ac7Ropgrarl9obnGtgZWzJzPDF7ciqhTSGa21DcxGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJjF+pPLSTIqxHcNOJTD0s+bVAzgbSOSmSrqMNnuQMUDJ/ceXD+9OHgXnagXw6q9QoWaklL5oOgSbGxsSKg7aYjsid98b/S5/MzEIgrbN0Vb/Qc4nsWjSn6LxKTbYJpkn4ZGdBqk1HL9ILbBZbDofm6hsaLaBaHYszPQhVwLCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECtWEs8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF276C4CEC6;
	Wed, 23 Oct 2024 04:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729656039;
	bh=9ac7Ropgrarl9obnGtgZWzJzPDF7ciqhTSGa21DcxGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECtWEs8QJjxGvJ4rH2KRwXSzyj4c0mBCEEr7T78dp3GP5PT/cKFEbyNZTkfeSJmuc
	 0UxM4t5cANLihdhyu+b32a/wlTqUfjlnKPdBq9H2+I7elHccnKwOLmVSc3beieUdS2
	 e3giTjNLE40Wfd7w0S8ram4XaIbv+VvqHtUGA4W+48FdvlmbO1R/WDAj81ICAs8ozp
	 ivWomWej7D1jz40cXUrQtyY03shNR5nV+jo0IT00X08zW7MEJJVudnptR0pQWcuPRr
	 yEfRmMgxNVlOi8hFFbhkqChybuGA0NuxMYmNTdMdOLWt/Pkly0ihi5DVXkB0QwPoaU
	 ikrb8EAVLtcCg==
Date: Tue, 22 Oct 2024 23:00:36 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] clk: qcom: Add support for GCC clock controller on
 SM8750
Message-ID: <4rp4h2inllsa2zd62yg6giyf45skhe3bzcgkjb5btwn4hhh33b@pdjllzwaqtks>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-6-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-6-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:57PM GMT, Melody Olvera wrote:
[..]
> diff --git a/drivers/clk/qcom/gcc-sm8750.c b/drivers/clk/qcom/gcc-sm8750.c
[..]
> +static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> +	.reg = 0x6b080,
> +	.shift = 0,
> +	.width = 2,
> +	.parent_map = gcc_parent_map_7,
> +	.clkr = {
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_pcie_0_pipe_clk_src",
> +			.parent_data = gcc_parent_data_7,
> +			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> +			.ops = &clk_regmap_mux_closest_ops,

Please confirm that the PCIe pipe clock sources should not be
&clk_regmap_phy_mux_ops, as on other platforms.

> +		},
> +	},
> +};
> +
[..]
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, P_BI_TCXO, 12, 1, 4),
> +	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
> +	.cmd_rcgr = 0x1401c,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_8,
> +	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_sdcc2_apps_clk_src",
> +		.parent_data = gcc_parent_data_8,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,

Please confirm that the sdcc apps_clk_src no longer needs to use
&clk_rcg2_floor_ops.

> +	},
> +};
> +
[..]
> +static struct gdsc gcc_pcie_0_gdsc = {
> +	.gdscr = 0x6b004,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0xf,
> +	.collapse_ctrl = 0x5214c,
> +	.collapse_mask = BIT(0),
> +	.pd = {
> +		.name = "gcc_pcie_0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,

Shouldn't the PCIe GDSCs be PWRSTS_RET_ON?

> +	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
> +};
> +
[..]
> +static int gcc_sm8750_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &gcc_sm8750_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
> +				       ARRAY_SIZE(gcc_dfs_clocks));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Keep clocks always enabled:
> +	 *	gcc_cam_bist_mclk_ahb_clk
> +	 *	gcc_camera_ahb_clk
> +	 *	gcc_camera_xo_clk
> +	 *	gcc_disp_ahb_clk
> +	 *	gcc_eva_ahb_clk
> +	 *	gcc_eva_xo_clk
> +	 *	gcc_gpu_cfg_ahb_clk
> +	 *	gcc_pcie_rscc_cfg_ahb_clk
> +	 *	gcc_pcie_rscc_xo_clk
> +	 *	gcc_video_ahb_clk
> +	 *	gcc_video_xo_clk
> +	 */
> +	regmap_update_bits(regmap, 0xa0004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x26004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x26034, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x27004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x9f004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x9f01c, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x52010, BIT(20), BIT(20));
> +	regmap_update_bits(regmap, 0x52010, BIT(21), BIT(21));
> +	regmap_update_bits(regmap, 0x32004, BIT(0), BIT(0));
> +	regmap_update_bits(regmap, 0x32038, BIT(0), BIT(0));

Any reason why qcom_branch_set_clk_en() can't be used here?

> +
> +	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
> +	regmap_update_bits(regmap, gcc_ufs_phy_ice_core_clk.halt_reg,
> +			   BIT(14), BIT(14));

qcom_branch_set_force_mem_core() ?

Regards,
Bjorn

> +
> +	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8750_desc, regmap);
> +}
> +
> +static struct platform_driver gcc_sm8750_driver = {
> +	.probe = gcc_sm8750_probe,
> +	.driver = {
> +		.name = "gcc-sm8750",
> +		.of_match_table = gcc_sm8750_match_table,
> +	},
> +};
> +
> +static int __init gcc_sm8750_init(void)
> +{
> +	return platform_driver_register(&gcc_sm8750_driver);
> +}
> +subsys_initcall(gcc_sm8750_init);
> +
> +static void __exit gcc_sm8750_exit(void)
> +{
> +	platform_driver_unregister(&gcc_sm8750_driver);
> +}
> +module_exit(gcc_sm8750_exit);
> +
> +MODULE_DESCRIPTION("QTI GCC SM8750 Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.46.1
> 

