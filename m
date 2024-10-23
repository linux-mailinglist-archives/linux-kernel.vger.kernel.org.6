Return-Path: <linux-kernel+bounces-377272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586C9ABC58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF82C1F227B0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D91136347;
	Wed, 23 Oct 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQbuJsBQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1649A139E;
	Wed, 23 Oct 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729654855; cv=none; b=MRKHTG2+eh+Dfb0qNfIfkdZBJdfQmaso2GwxUPpuzWnsbhgZdvkJzUSZ/lZnAF0FjoteVYP4YL8ixOmqYq4o2EyKnQThgMqjKFJGIZlAj9F6M40wkWZcfRF5TUmCB/1T6noIajtwBPD9/W2iR1t3F9YN/t3tgLjj5AoUcTbaQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729654855; c=relaxed/simple;
	bh=y6Fi+NfUfOCbXVBSGJQOadNVKudjHfXcg/ylrecymHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq3Sa1R5PPOH6Jbsh/Nxc9Tfptj7qvBPncZmnZSfXPPOGUiGneiRHYToso45n6LbFj341f8TR5R50yVHDV8KTrwBkxyS7+B7n0qGLV4W0GmWe5SwYVoWStvui966hCJBWW1/4ptFAnbQg+8jH7mS9hvk4Z754kq19n7sVrbTS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQbuJsBQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A88C4CEC3;
	Wed, 23 Oct 2024 03:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729654854;
	bh=y6Fi+NfUfOCbXVBSGJQOadNVKudjHfXcg/ylrecymHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQbuJsBQfrLAaEku7pnQ6Whcj2aN5vELmTtsW482kKCcxWyQTUA+njylLZTi63UlH
	 skERste6Xuh02EoeRVVzzryid3hyWrbzaL4mmlmi9Q5VNBY85/oTNe2n+a6CyGOmil
	 WRlhGYHa/foPcqsqt4YfoKCaHW3seK+h7H2Va+f5fdifBb1RUVreB9YHEv2iNnsuOK
	 JasAVFz4effnIMXlBfxDwWgP0eMP4RS/w1cIyptMArn+0r32ybmSfGW+Id+lT0LezH
	 skRcdGKdL+B3WJUewUQKqMoKuUO9IsPpAUX0ujz5Au5hP5gHf9Ra2epQTymxBsz6mX
	 6Zd5QaCZ6J+uA==
Date: Tue, 22 Oct 2024 22:40:51 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clk: qcom: rpmh: Add support for SM8750 rpmh clocks
Message-ID: <hisxeyns76aibj2wfw65epqwe5cbox5mt7t7c67zrzzaildelm@6pu4ao2qvtgf>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-3-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-3-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:54PM GMT, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add the RPMH clocks present in SM8750 SoC.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 4acde937114a..245bdfe4827d 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -344,6 +344,7 @@ static const struct clk_ops clk_rpmh_bcm_ops = {
>  DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 1);
>  DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 2);
>  DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 4);
> +DEFINE_CLK_RPMH_ARC(xo_pad,  "xo.lvl", 0x3, 2);

Please make a note in the commit message documenting why we need two
different xo.lvl resources defined.

If we indeed should have two copies, this list is sorted alphabetically
on the clock name - rather than on the resource. Please keep that (i.e.
move this down one line).

>  DEFINE_CLK_RPMH_ARC(qlink, "qphy.lvl", 0x1, 4);
>  
>  DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2, "lnbclka1", 2);
> @@ -368,6 +369,10 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
>  DEFINE_CLK_RPMH_VRM(rf_clk3, _d, "rfclkd3", 1);
>  DEFINE_CLK_RPMH_VRM(rf_clk4, _d, "rfclkd4", 1);
>  
> +DEFINE_CLK_RPMH_VRM(rf_clk3, _a2, "rfclka3", 2);
> +DEFINE_CLK_RPMH_VRM(rf_clk4, _a2, "rfclka4", 2);
> +DEFINE_CLK_RPMH_VRM(rf_clk5, _a2, "rfclka5", 2);
> +
>  DEFINE_CLK_RPMH_VRM(clk1, _a1, "clka1", 1);
>  DEFINE_CLK_RPMH_VRM(clk2, _a1, "clka2", 1);
>  DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
> @@ -795,6 +800,26 @@ static const struct clk_rpmh_desc clk_rpmh_x1e80100 = {
>  	.num_clks = ARRAY_SIZE(x1e80100_rpmh_clocks),
>  };
>  
> +static struct clk_hw *sm8750_rpmh_clocks[] = {
> +	[RPMH_CXO_PAD_CLK]      = &clk_rpmh_xo_pad_div2.hw,
> +	[RPMH_CXO_PAD_CLK_A]    = &clk_rpmh_xo_pad_div2_ao.hw,
> +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
> +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
> +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
> +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
> +	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
> +	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
> +	[RPMH_RF_CLK2]		= &clk_rpmh_rf_clk2_a.hw,
> +	[RPMH_RF_CLK2_A]	= &clk_rpmh_rf_clk2_a_ao.hw,
> +	[RPMH_RF_CLK3]		= &clk_rpmh_rf_clk3_a2.hw,
> +	[RPMH_RF_CLK3_A]	= &clk_rpmh_rf_clk3_a2_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sm8750 = {
> +	.clks = sm8750_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sm8750_rpmh_clocks),
> +};

Please add an empty line here, when you're resubmitting the series.

Thanks,
Bjorn

>  static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
>  					 void *data)
>  {
> @@ -896,6 +921,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
>  	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
>  	{ .compatible = "qcom,sm8650-rpmh-clk", .data = &clk_rpmh_sm8650},
> +	{ .compatible = "qcom,sm8750-rpmh-clk", .data = &clk_rpmh_sm8750},
>  	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
>  	{ .compatible = "qcom,x1e80100-rpmh-clk", .data = &clk_rpmh_x1e80100},
>  	{ }
> -- 
> 2.46.1
> 

