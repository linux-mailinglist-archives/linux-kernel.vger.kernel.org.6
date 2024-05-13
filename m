Return-Path: <linux-kernel+bounces-177343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702818C3D1C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EEF1C211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B861474B8;
	Mon, 13 May 2024 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AKyBZZcP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770B146D74
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588752; cv=none; b=smRD0DKiY2d5AhhXiurCr77r4yvZnJGupySrtdMWSZUnafeLT3K0dUpp2DsAD9RXjUSVurxieVuaXHsA/zAlTtir4YtHvKRr7TRuGloZKFs3xm2cJq6HMLRFM5tciTy4EUprNokqPpll47fa5iRwBZCOpwPGqvk1rD45qDY7kqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588752; c=relaxed/simple;
	bh=kv58yjtp4L6lyaDcV2lWx438OL1wTutW6wcJG731nuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQWR2EUMaFiVsozjpJm9ORqn0Wjebaw94hLjijcyI3b1TRQ6hy6l5GyCKPex0q+Gr/cNsAB0Kq/xvA5snDDYnVNdQuB/7yoZXek6/NAosWio6ERRwa/oyTDZpLlQEXGGQLsCFyWyTfoPO4BO5aOEqnk6AzWd62f1yxibK8uOwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AKyBZZcP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4201986d60aso1945405e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715588747; x=1716193547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7bfOTbG7L4+V0IOHIQ4n3cG7h0Ezgicil3K//KkhP4=;
        b=AKyBZZcPtIRXzD9QYuZGYGhX12FR2mIjEiKlqgnBr9hJrIPmK2u5Am6vljuDZVewSN
         tVFkCJW1g6tJhp5GMOXQggnYZzpz5aoUFvFqDMO98U7zsnxUYkHF7zIBdUxp0DB69gxj
         DaAeImagE5tZ3/XDUNJd/gOz4gvU8N625aZId1/GtnXtjQ9gLrUCy8EpptfYL6eg8S50
         l57EDfgTYhzi9uRIiAh78SyiltvlIfUHk2wa7W4RbTRJhJHNN1jDGYMpbmkHqNbbR03X
         UEJtj2UMK1N9EEQ3+8/q5j37cuAncfEgyGc29xCeIfBmcHUCiEOduM+rqoHfWVJxRTpT
         0ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588747; x=1716193547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7bfOTbG7L4+V0IOHIQ4n3cG7h0Ezgicil3K//KkhP4=;
        b=p+v4+oDPSHYjR/r9uUMdTncGw0YtbOZXj5bkpssS/O5KPtT0k2p8f9+/dmW5zespp4
         0FpNZPPZPgc09Lvvx+dsbSmxnP6N119gSSBiLZucyXmkVwjK1nutL/OgMiIlu60Aurur
         BmvRtqsMzXTT4tVhfwtADuQfpyzXJ4PBi6+kl0Ol0NgO1u2/lmJeSGRr43I+kXka79sz
         2VGgeZzgDqTXFYzGV42XG27T2aUy3p61MHppRc7c7qQPnnf1xnogHFqk0EFtoXx3D8CY
         GhSQ7NW0K1cUZayNIOqthCgbe/vjxudyIKReTURRL9o5nopduvDqYNrEZR2EMgOoBJRA
         kHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjL0djuaGnM0DUD/tjIP5lL3yPqZKFCetn7ij0W/1CSLS4GNtefUs9XV4DBiB81yGm12EOmdOV1JSwAOfrzuxXWjczlur9LAYWjiE2
X-Gm-Message-State: AOJu0YyTLitLOAuLpfyiZuJJkC8g7RRvhmi+RQGgGhwyJt6PsaMk/Y0v
	Fpyth7KbhJTEM4vLYvl7xR4whW6wmQaahQ/uZ8tnTWKomN416hL2YQ29HhuFAg4=
X-Google-Smtp-Source: AGHT+IFkeqQ2HdkJe+AA1wZ470jwmiPbC0UDSEdQJw80c8DxUD2Cc7e6aTPGGPq+eLulQCkh6dcqnQ==
X-Received: by 2002:a05:600c:4689:b0:420:509:714f with SMTP id 5b1f17b1804b1-4200509728bmr53232585e9.14.1715588747328;
        Mon, 13 May 2024 01:25:47 -0700 (PDT)
Received: from linaro.org ([82.76.168.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f9bc3b12fsm91897845e9.0.2024.05.13.01.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:25:46 -0700 (PDT)
Date: Mon, 13 May 2024 11:25:45 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: devi priya <quic_devipriy@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	quic_msarkar@quicinc.com, quic_qianyu@quicinc.com,
	quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] phy: qcom-qmp-pcie: Add support for IPQ9574 g3x1
 and g3x2 PCIEs
Message-ID: <ZkHOiQj6a980BkI5@linaro.org>
References: <20240512082541.1805335-1-quic_devipriy@quicinc.com>
 <20240512082541.1805335-3-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512082541.1805335-3-quic_devipriy@quicinc.com>

On 24-05-12 13:55:41, devi priya wrote:
> Add support for a single-lane and two-lane PCIe PHYs
> found on Qualcomm IPQ9574 platform.
> Also, add the definitions for missing register offsets.
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
> 	- Dropped ipq9574_pcie_tx_tbl and reused ipq8074_pcie_gen3_tx_tbl
> 	  as the table offsets are the same.
> 	- Used pciephy_v5_regs_layout instead of v4 for gen3x2 PHY.
> 
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 309 ++++++++++++++++++
>  .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  14 +
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-pll.h   |   3 +

Maybe split the patch into 3 separate per-file patches.

Beyond that, LGTM.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

>  3 files changed, 326 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 6c796723c8f5..8cb91b9114d6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -489,6 +489,243 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
>  	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>  };
>  
> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xd4),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7d),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0f),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xff),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3f),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xab),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xd4),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xaa),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xa0),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xb4),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_EN_CENTER, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7d),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER1, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER2, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0a),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_pcie_rx_tbl[] = {
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x03),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_ENABLES, 0x1c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x61),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1e),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x70),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x73),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x80),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x09),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xf0),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x02),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x2f),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0xd3),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x40),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG1, 0x14),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG1, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG2, 0x0b),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_PRE, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_POST, 0x58),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x50),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x1a),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x06),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0d),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xaa),
> +};
> +
> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_misc_tbl[] = {
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1d),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x14),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x10),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0b),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_PRE, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_POST, 0x58),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4, 0x19),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x49),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x2a),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x02),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
> +};
> +
>  static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>  	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
> @@ -2535,6 +2772,16 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>  	.rx2		= 0x1800,
>  };
>  
> +static const struct qmp_pcie_offsets qmp_pcie_offsets_ipq9574 = {
> +	.serdes         = 0,
> +	.pcs            = 0x1000,
> +	.pcs_misc       = 0x1400,
> +	.tx             = 0x0200,
> +	.rx             = 0x0400,
> +	.tx2            = 0x0600,
> +	.rx2            = 0x0800,
> +};
> +
>  static const struct qmp_pcie_offsets qmp_pcie_offsets_v5_20 = {
>  	.serdes		= 0x1000,
>  	.pcs		= 0x1200,
> @@ -2647,6 +2894,62 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>  	.phy_status		= PHYSTATUS,
>  };
>  
> +static const struct qmp_phy_cfg ipq9574_gen3x1_pciephy_cfg = {
> +	.lanes			= 1,
> +
> +	.offsets		= &qmp_pcie_offsets_v4x1,
> +
> +	.tbls = {
> +		.serdes		= ipq9574_gen3x1_pcie_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(ipq9574_gen3x1_pcie_serdes_tbl),
> +		.tx		= ipq8074_pcie_gen3_tx_tbl,
> +		.tx_num		= ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> +		.rx		= ipq9574_pcie_rx_tbl,
> +		.rx_num		= ARRAY_SIZE(ipq9574_pcie_rx_tbl),
> +		.pcs		= ipq9574_gen3x1_pcie_pcs_tbl,
> +		.pcs_num	= ARRAY_SIZE(ipq9574_gen3x1_pcie_pcs_tbl),
> +		.pcs_misc	= ipq9574_gen3x1_pcie_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(ipq9574_gen3x1_pcie_pcs_misc_tbl),
> +	},
> +	.reset_list		= ipq8074_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
> +	.vreg_list		= NULL,
> +	.num_vregs		= 0,
> +	.regs			= pciephy_v4_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +	.pipe_clock_rate	= 250000000,
> +};
> +
> +static const struct qmp_phy_cfg ipq9574_gen3x2_pciephy_cfg = {
> +	.lanes			= 2,
> +
> +	.offsets		= &qmp_pcie_offsets_ipq9574,
> +
> +	.tbls = {
> +		.serdes		= ipq9574_gen3x2_pcie_serdes_tbl,
> +		.serdes_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
> +		.tx		= ipq8074_pcie_gen3_tx_tbl,
> +		.tx_num		= ARRAY_SIZE(ipq8074_pcie_gen3_tx_tbl),
> +		.rx		= ipq9574_pcie_rx_tbl,
> +		.rx_num		= ARRAY_SIZE(ipq9574_pcie_rx_tbl),
> +		.pcs		= ipq9574_gen3x2_pcie_pcs_tbl,
> +		.pcs_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_tbl),
> +		.pcs_misc	= ipq9574_gen3x2_pcie_pcs_misc_tbl,
> +		.pcs_misc_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
> +	},
> +	.reset_list		= ipq8074_pciephy_reset_l,
> +	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
> +	.vreg_list		= NULL,
> +	.num_vregs		= 0,
> +	.regs			= pciephy_v5_regs_layout,
> +
> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
> +	.phy_status		= PHYSTATUS,
> +	.pipe_clock_rate	= 250000000,
> +};
> +
>  static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>  	.lanes			= 1,
>  
> @@ -4030,6 +4333,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>  	}, {
>  		.compatible = "qcom,ipq8074-qmp-pcie-phy",
>  		.data = &ipq8074_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy",
> +		.data = &ipq9574_gen3x1_pciephy_cfg,
> +	}, {
> +		.compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy",
> +		.data = &ipq9574_gen3x2_pciephy_cfg,
>  	}, {
>  		.compatible = "qcom,msm8998-qmp-pcie-phy",
>  		.data = &msm8998_pciephy_cfg,
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> index a469ae2a10a1..fa15a03055de 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
> @@ -11,8 +11,22 @@
>  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
>  #define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4		0x14
>  #define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L	0x44
> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H	0x48
> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L	0x4c
> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H	0x50
>  #define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x54
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1		0x5c
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2		0x60
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4		0x68
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2		0x7c
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4		0x84
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5		0x88
> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6		0x8c
>  #define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
> +#define QPHY_V5_PCS_PCIE_EQ_CONFIG1			0xa4
>  #define QPHY_V5_PCS_PCIE_EQ_CONFIG2			0xa8
> +#define QPHY_V5_PCS_PCIE_PRESET_P10_PRE			0xc0
> +#define QPHY_V5_PCS_PCIE_PRESET_P10_POST		0xe4
>  
>  #endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
> index ad326e301a3a..231e59364e31 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
> @@ -8,6 +8,9 @@
>  
>  /* QMP V2 PHY for PCIE gen3 ports - QSERDES PLL registers */
>  #define QSERDES_PLL_BG_TIMER				0x00c
> +#define QSERDES_PLL_SSC_EN_CENTER			0x010
> +#define QSERDES_PLL_SSC_ADJ_PER1			0x014
> +#define QSERDES_PLL_SSC_ADJ_PER2			0x018
>  #define QSERDES_PLL_SSC_PER1				0x01c
>  #define QSERDES_PLL_SSC_PER2				0x020
>  #define QSERDES_PLL_SSC_STEP_SIZE1_MODE0		0x024
> -- 
> 2.34.1
> 

