Return-Path: <linux-kernel+bounces-273947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783E3947005
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E831F2136C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784FE1311AC;
	Sun,  4 Aug 2024 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6M3jiZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA19B1DFE8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722792057; cv=none; b=MqFbMWbsWURAmKMuR8UcC5ihXCo8FOrkrrrGaMKcyg423myFg4JnePCFM8WXD/6ODIRgAk2XmMRyqgRkaqboi1mwloY5iGxNFfJkZuQu/MbbrxdyNXQgosRfuRP+Wu+a1OPaeLvS2yld24Sz3dQHmIRVC0bTAlCGSac5kOAEUM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722792057; c=relaxed/simple;
	bh=G1R24K2ESK7/Bkj/XCkWrPqcBxwbVuAcBmyP4C2KDGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehMcidruVXJUp6vQb72+lJvlvMAMTru++T/Dz6sHn2TM/Z835qR+iYUg+lOUBWrPNnan3QQJCuhy5dVl29c1tMWhGPt3jsH6DDvjzsTb6tahLUFQsweYi5WuOptJmqCFefikBP6VSiiaCMOqBlhIZD+iSWwO1xWUvU7XsnTKq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6M3jiZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BAFC32786;
	Sun,  4 Aug 2024 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722792057;
	bh=G1R24K2ESK7/Bkj/XCkWrPqcBxwbVuAcBmyP4C2KDGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6M3jiZRKsv/CsiXrOsP8IfQQEs5BDgEURSkcNao8fm6QwAg0WFgdEd1bGub3vhSv
	 1VKov+rOTruPQikzyhlRmu1jSqv0AMjsD/qJWM30QXl76HszHR8Jjj2JOzkxgBFo0O
	 zKfgjLLfydImZ92kdT7iFlIUnOxWV2AkWl/uKcPEYU7u55DnjEHemghxp2/XB5EvJ7
	 kPF5Ob34xV/PAtZD6St5MIHOrXvYAXi7/FIMCu+Jp+vBDZTg3nRQfCbMoZNtRW5LFT
	 khabTWhcxIqRtWRKKZF4jJw6ZLjvvap2jT0cVjq8dTxhk+i0o7Oi4DVNAH2kOdRD9C
	 55Pijhc02rDmQ==
Date: Sun, 4 Aug 2024 22:50:52 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: laurent.pinchart@ideasonboard.com, kishon@kernel.org,
	michal.simek@amd.com, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	git@amd.com
Subject: Re: [PATCH] phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on
 resume
Message-ID: <Zq-4dH2dXzGXebYv@matsya>
References: <1721155263-2913528-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721155263-2913528-1-git-send-email-radhey.shyam.pandey@amd.com>

On 17-07-24, 00:11, Radhey Shyam Pandey wrote:
> From: Piyush Mehta <piyush.mehta@amd.com>
> 
> On a few Kria KR260 Robotics Starter Kit the PS-GEM SGMII linkup is not
> happening after the resume. This is because serdes registers are reset
> when FPD is off (in suspend state) and needs to be reprogrammed in the
> resume path with the same default initialization as done in the first
> stage bootloader psu_init routine.
> 
> To address the failure introduce a set of serdes registers to be saved in
> the suspend path and then restore it on resume.
> 
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> ---
>  drivers/phy/xilinx/phy-zynqmp.c | 56 +++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
> index dc8319bda43d..bdcc8d7c3dfa 100644
> --- a/drivers/phy/xilinx/phy-zynqmp.c
> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -165,6 +165,24 @@
>  /* Timeout values */
>  #define TIMEOUT_US			1000
>  
> +/* Lane 0/1/2/3 offset */
> +#define DIG_8(n)		((0x4000 * (n)) + 0x1074)
> +#define ILL13(n)		((0x4000 * (n)) + 0x1994)
> +#define DIG_10(n)		((0x4000 * (n)) + 0x107C)
> +#define RST_DLY(n)		((0x4000 * (n)) + 0x19A4)
> +#define BYP_15(n)		((0x4000 * (n)) + 0x1038)
> +#define BYP_12(n)		((0x4000 * (n)) + 0x102C)
> +#define MISC3(n)		((0x4000 * (n)) + 0x19AC)
> +#define EQ11(n)			((0x4000 * (n)) + 0x1978)

Lower case hex value please

> +
> +static u32 save_reg_address[] = {
> +	/* Lane 0/1/2/3 Register */
> +	DIG_8(0), ILL13(0), DIG_10(0), RST_DLY(0), BYP_15(0), BYP_12(0), MISC3(0), EQ11(0),
> +	DIG_8(1), ILL13(1), DIG_10(1), RST_DLY(1), BYP_15(1), BYP_12(1), MISC3(1), EQ11(1),
> +	DIG_8(2), ILL13(2), DIG_10(2), RST_DLY(2), BYP_15(2), BYP_12(2), MISC3(2), EQ11(2),
> +	DIG_8(3), ILL13(3), DIG_10(3), RST_DLY(3), BYP_15(3), BYP_12(3), MISC3(3), EQ11(3),
> +};
> +
>  struct xpsgtr_dev;
>  
>  /**
> @@ -213,6 +231,7 @@ struct xpsgtr_phy {
>   * @tx_term_fix: fix for GT issue
>   * @saved_icm_cfg0: stored value of ICM CFG0 register
>   * @saved_icm_cfg1: stored value of ICM CFG1 register
> + * @saved_regs: registers to be saved/restored during suspend/resume
>   */
>  struct xpsgtr_dev {
>  	struct device *dev;
> @@ -225,6 +244,7 @@ struct xpsgtr_dev {
>  	bool tx_term_fix;
>  	unsigned int saved_icm_cfg0;
>  	unsigned int saved_icm_cfg1;
> +	u32 *saved_regs;
>  };
>  
>  /*
> @@ -298,6 +318,32 @@ static inline void xpsgtr_clr_set_phy(struct xpsgtr_phy *gtr_phy,
>  	writel((readl(addr) & ~clr) | set, addr);
>  }
>  
> +/**
> + * xpsgtr_save_lane_regs - Saves registers on suspend
> + * @gtr_dev: pointer to phy controller context structure
> + */
> +static void xpsgtr_save_lane_regs(struct xpsgtr_dev *gtr_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(save_reg_address); i++)
> +		gtr_dev->saved_regs[i] = xpsgtr_read(gtr_dev,
> +						     save_reg_address[i]);
> +}
> +
> +/**
> + * xpsgtr_restore_lane_regs - Restores registers on resume
> + * @gtr_dev: pointer to phy controller context structure
> + */
> +static void xpsgtr_restore_lane_regs(struct xpsgtr_dev *gtr_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(save_reg_address); i++)
> +		xpsgtr_write(gtr_dev, save_reg_address[i],
> +			     gtr_dev->saved_regs[i]);
> +}
> +
>  /*
>   * Hardware Configuration
>   */
> @@ -837,6 +883,8 @@ static int xpsgtr_runtime_suspend(struct device *dev)
>  	gtr_dev->saved_icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	gtr_dev->saved_icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>  
> +	xpsgtr_save_lane_regs(gtr_dev);
> +
>  	return 0;
>  }
>  
> @@ -847,6 +895,8 @@ static int xpsgtr_runtime_resume(struct device *dev)
>  	unsigned int i;
>  	bool skip_phy_init;
>  
> +	xpsgtr_restore_lane_regs(gtr_dev);
> +
>  	icm_cfg0 = xpsgtr_read(gtr_dev, ICM_CFG0);
>  	icm_cfg1 = xpsgtr_read(gtr_dev, ICM_CFG1);
>  
> @@ -992,6 +1042,12 @@ static int xpsgtr_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	gtr_dev->saved_regs = devm_kmalloc(gtr_dev->dev,
> +					   sizeof(save_reg_address),
> +					   GFP_KERNEL);
> +	if (!gtr_dev->saved_regs)
> +		return -ENOMEM;
> +
>  	return 0;
>  }
>  
> 
> base-commit: d67978318827d06f1c0fa4c31343a279e9df6fde
> -- 
> 2.34.1

-- 
~Vinod

