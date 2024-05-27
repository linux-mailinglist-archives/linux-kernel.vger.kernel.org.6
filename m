Return-Path: <linux-kernel+bounces-190259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCBF8CFC1D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CAD283ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7943B13A404;
	Mon, 27 May 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRTSsGab"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9113A3E7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799594; cv=none; b=NN1ZwIEMKoLPi4H1JfM49SRvQJP20iQYXOEhzognYyMsk1RCYdAsLmQ42l6AxUxMGdjsFw08yK53X7siUFUMW8RMrA0aOHznaOQTALs0Pjrm6adK5aP2yS+xdzOZJHhFQ1MLOtbONdrUPkZxaOFg7ym3GWdL/TkeZyFVv+UCkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799594; c=relaxed/simple;
	bh=70rY50aseYI64Qm8+oXFaZPxdIOsmiHvyjmjaE2BkRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhViwlFLDZP86kOBloCAiQwHVSBkIMNlndw1vfzoy2Ls5/K4kuOI9svMeWY76MldblRq1z5xzcw/zRVHU+UPDd4IxKMkM0Jc5tGLVM1xqvNoyXqsPqmYWiXYU8STDn1fKeDvIVG6psgYiCK/iRzan7skbSl+Pe041OO9Pq3BrY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FRTSsGab; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e95afec7e6so23404721fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 01:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716799591; x=1717404391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCW+HFtoeaierrg0K+2TVOUHq8VHzqfUi+kUPqpq30g=;
        b=FRTSsGabWb+ngqdHMp3yhgqdJ+Tl21ir+gQNAsEqVuVyFsGJijN33MIIbgmCIbDXiT
         bTeMQP4z7G7ZL5HY8hQl2dZfEgbb//4j4RsLFfrQ/qldFkC+B68X7O4ZTeCgabCs5FMs
         8N/Pz0XISOfops40CHRO8kw4pJxmTrMMeKR9bRtBIm/bZAtVnAe3AJHP2WupjpmKev5B
         QsX9H48FOzteC4BvvZnboWZ/OZvWAv0VE0wOyMIg7T3r8FNK1CYL+rwe+5+MDesZVgQZ
         Tgl1NpfeUPMjZ+dZCwcsWb6IT2ib+9gdSQCyrFhT05Qn1Bh+nK9U1tfsAkv6KKBckf18
         nlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799591; x=1717404391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCW+HFtoeaierrg0K+2TVOUHq8VHzqfUi+kUPqpq30g=;
        b=LL8phIfpheLX71OZm9sxUdOJDj97IMG+kcqPptrIz3O0KZXyguHuFR4Jcbabe7jFfU
         HIxjA8uS/LMxOPMzq22MM9J7Tb6OS3e8ZYAQ3cubGSceEPCA1lbqlb4Zhkht9c/WKZAL
         PP9Z7Ha6/w3hUszK0eCztEc/tQ/OSwTxKpjbrHDs+6/r5S16VpGKcMm12GL7hWnUq86B
         TX+H4Jjl+5nhFde7qYoUF2OM40JAUVmFa4BkYKR8Xzmai+oy/eDdVCfSahQjNz1X0aof
         Mn63/jrt8enmuDCoELagzS+qdqOiUgatzSMy13rIjHeI3nYjYA2asxmOqSnHPYxcWPDh
         BV4A==
X-Forwarded-Encrypted: i=1; AJvYcCUKgofvGsz5rjQdy8i4xKJ6h8M+A7pBTvViIovAatcQ3Jo2o0CsKE3jhr8TJYdTe7gna+zg8H7JSZB/Bmbl8RwqC1wB/PZqr+TZpY0h
X-Gm-Message-State: AOJu0Yz5OwlTo7ZL7xY6lqfmPq5yUXwscsOykeKMA90RtkzUYIynb50y
	MkL97ZfGbzRX9xNB2mX9MN2C3GJAyyRoU864HZ+NShns9kC9lAkvVkHqzHTOBac=
X-Google-Smtp-Source: AGHT+IGoIHMv7LzRXg/j0eiiJ3Hf7gEQa4vkwrOCUAOl8CxlUeLhgksZ+dNSoUDerxoQwluUxl8chQ==
X-Received: by 2002:a2e:2c19:0:b0:2e2:3761:2ef5 with SMTP id 38308e7fff4ca-2e951b82fdbmr37512241fa.14.1716799591109;
        Mon, 27 May 2024 01:46:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95be2126esm18474141fa.119.2024.05.27.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 01:46:30 -0700 (PDT)
Date: Mon, 27 May 2024 11:46:29 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] phy: qcom: qmp-combo: introduce QPHY_MODE
Message-ID: <v36mrliwd7rarqofbitv5mtb6kd3n3hmuwp6bgg67krnvzejd6@luityjlkb7nn>
References: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-0-a03e68d7b8fc@linaro.org>
 <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-3-a03e68d7b8fc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-topic-sm8x50-upstream-phy-combo-typec-mux-v2-3-a03e68d7b8fc@linaro.org>

On Mon, May 27, 2024 at 10:42:35AM +0200, Neil Armstrong wrote:
> Introduce an enum for the QMP Combo PHY modes, use it in the
> QMP commmon phy init function and default to COMBO mode.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 41 +++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 183cd9cd1884..788e4c05eaf2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -61,6 +61,12 @@
>  
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
> +enum qphy_mode {
> +	QPHY_MODE_COMBO = 0,
> +	QPHY_MODE_DP_ONLY,
> +	QPHY_MODE_USB_ONLY,
> +};
> +
>  /* set of registers with offsets different per-PHY */
>  enum qphy_reg_layout {
>  	/* PCS registers */
> @@ -1503,6 +1509,7 @@ struct qmp_combo {
>  
>  	struct mutex phy_mutex;
>  	int init_count;
> +	enum qphy_mode init_mode;
>  
>  	struct phy *usb_phy;
>  	enum phy_mode mode;
> @@ -2589,12 +2596,33 @@ static int qmp_combo_com_init(struct qmp_combo *qmp, bool force)
>  	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
>  		val |= SW_PORTSELECT_VAL;
>  	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
> -	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
>  
> -	/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
> -	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> -			SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> -			SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +	switch (qmp->init_mode) {
> +	case QPHY_MODE_COMBO:
> +		writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +		/* bring both QMP USB and QMP DP PHYs PCS block out of reset */
> +		qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +				SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
> +				SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +		break;
> +
> +	case QPHY_MODE_DP_ONLY:
> +		writel(DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +		/* bring QMP DP PHY PCS block out of reset */
> +		qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +				SW_DPPHY_RESET_MUX | SW_DPPHY_RESET);
> +		break;
> +
> +	case QPHY_MODE_USB_ONLY:
> +		writel(USB3_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
> +
> +		/* bring QMP USB PHY PCS block out of reset */
> +		qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
> +				SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
> +		break;
> +	}
>  
>  	qphy_clrbits(com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
>  	qphy_clrbits(com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
> @@ -3603,6 +3631,9 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_node_put;
>  
> +	/* Set PHY_MODE as combo by default */
> +	qmp->init_mode = QPHY_MODE_COMBO;
> +

I see that COMBO mode is backwards compatible with existing code. But
shouldn't the USB-only be a default mode?

>  	qmp->usb_phy = devm_phy_create(dev, usb_np, &qmp_combo_usb_phy_ops);
>  	if (IS_ERR(qmp->usb_phy)) {
>  		ret = PTR_ERR(qmp->usb_phy);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

