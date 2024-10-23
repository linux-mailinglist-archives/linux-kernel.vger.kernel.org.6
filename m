Return-Path: <linux-kernel+bounces-377280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CC19ABC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 05:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D65B22BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202F13213E;
	Wed, 23 Oct 2024 03:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb/xvRBm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432B2AD20;
	Wed, 23 Oct 2024 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655300; cv=none; b=hXLF7Lj8cOhfp6r+Lbhs33tGuWJJhARUYHaYA6+z0tekFJLymd9zjd5ASMLy3HQzrI3G8oUcomGBp7pTRUGe7ZY75RJoshkekT9+P5ZQ/DMnKTMHQbhtjjzGMnPXKUtuk0b8oHzUm05rfrWCm3XnAqDk2L9J0vojRfMyyjJCR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655300; c=relaxed/simple;
	bh=ixnwO569q9VVlyzA0jfqNYOTnBca/gWJnB9y2dVTiyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddUcCXJsu3DTgbJoGeKo23rdM+zp86TwyR971bkHfKiXHlg7K/gOgXHzkyZZcdV+SyKH/dsYllHnwwrZFWIrDn3zldaPvLG5eyBuQvQIqIr9QSgnHFGZsxFFkdV+zMTqhIgl421VwK9fOYaPhGO+IQLUipu1Cd7rTZbXcHv3ZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb/xvRBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE19C4CEC6;
	Wed, 23 Oct 2024 03:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729655300;
	bh=ixnwO569q9VVlyzA0jfqNYOTnBca/gWJnB9y2dVTiyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb/xvRBmW8qyaSg11zq6yrOy2kWUeBQ2mtYJOtSAUwUgZeAEak+/DLGhIvzmDjrQ0
	 iDVV+TlqNL9CVBZ1RVDun6r1idWe5+xrLB/qz63o4H5j1nVxSOHzHQBVvAK6zcAc4A
	 0L4Gwl0tcCz3mWhf+BwUNKinM+7Dx7svhz6d4FHCtIobTYH52FFCGKqN+Mt0ZGDfm+
	 +tygG5fDWXzHVKar2Cfzy6mfhdcxGrQCaVwgqfaG1PO05w+t19ViPN/bytn4akRpnb
	 1eEsHuQt8mrw+BRaPIuA0MT8H7o4bnU0fVsVAf2jQmUk6x2bXwCrWePHkMxOzdoj/c
	 TE5apk2zbOSew==
Date: Tue, 22 Oct 2024 22:48:17 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	"Satya Durga Srinivasu Prabhala --cc=linux-arm-msm @ vger . kernel . org" <quic_satyap@quicinc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] clk: qcom: clk-alpha-pll: Add support for
 controlling Taycan PLLs
Message-ID: <isk2sazlimemlljrhslorazplvxkfisak2sncarqenai4ru5yf@k23mofd5dixd>
References: <20241021230359.2632414-1-quic_molvera@quicinc.com>
 <20241021230359.2632414-4-quic_molvera@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021230359.2632414-4-quic_molvera@quicinc.com>

On Mon, Oct 21, 2024 at 04:03:55PM GMT, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Update the clock ops for Taycan PLL, add the register offsets for
> supporting the PLL.

Subject and patch says "Add" so why does it say "Update" here?

> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 14 ++++++++++++++
>  drivers/clk/qcom/clk-alpha-pll.h |  7 +++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index be9bee6ab65f..57a15ac7b052 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -267,6 +267,20 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
>  		[PLL_OFF_OPMODE] = 0x30,
>  		[PLL_OFF_STATUS] = 0x3c,
>  	},
> +	[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU] = {

The other entries in this array are following the order of the enum, how
come this is different?

Regards,
Bjorn

> +		[PLL_OFF_OPMODE] = 0x04,
> +		[PLL_OFF_STATE] = 0x08,
> +		[PLL_OFF_STATUS] = 0x0c,
> +		[PLL_OFF_L_VAL] = 0x10,
> +		[PLL_OFF_ALPHA_VAL] = 0x14,
> +		[PLL_OFF_USER_CTL] = 0x18,
> +		[PLL_OFF_USER_CTL_U] = 0x1c,
> +		[PLL_OFF_CONFIG_CTL] = 0x20,
> +		[PLL_OFF_CONFIG_CTL_U] = 0x24,
> +		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
> +		[PLL_OFF_TEST_CTL] = 0x2c,
> +		[PLL_OFF_TEST_CTL_U] = 0x30,
> +	},
>  };
>  EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
>  
> diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> index 55eca04b23a1..5ba06d9ba77e 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.h
> +++ b/drivers/clk/qcom/clk-alpha-pll.h
> @@ -27,6 +27,7 @@ enum {
>  	CLK_ALPHA_PLL_TYPE_ZONDA_OLE,
>  	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
>  	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
> +	CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
>  	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
>  	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
>  	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
> @@ -184,12 +185,15 @@ extern const struct clk_ops clk_alpha_pll_zonda_ops;
>  #define clk_alpha_pll_zonda_ole_ops clk_alpha_pll_zonda_ops
>  
>  extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
> +#define clk_alpha_pll_taycan_elu_ops clk_alpha_pll_lucid_evo_ops
>  extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
>  #define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
>  extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
>  #define clk_alpha_pll_fixed_lucid_ole_ops clk_alpha_pll_fixed_lucid_evo_ops
> +#define clk_alpha_pll_fixed_taycan_elu_ops clk_alpha_pll_fixed_lucid_evo_ops
>  extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
>  #define clk_alpha_pll_postdiv_lucid_ole_ops clk_alpha_pll_postdiv_lucid_evo_ops
> +#define clk_alpha_pll_postdiv_taycan_elu_ops clk_alpha_pll_postdiv_lucid_evo_ops
>  
>  extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
>  #define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
> @@ -217,6 +221,9 @@ void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regma
>  				 const struct alpha_pll_config *config);
>  void clk_lucid_ole_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  				 const struct alpha_pll_config *config);
> +#define clk_taycan_elu_pll_configure(pll, regmap, config) \
> +	clk_lucid_evo_pll_configure(pll, regmap, config)
> +
>  void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>  				  const struct alpha_pll_config *config);
>  void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
> -- 
> 2.46.1
> 

