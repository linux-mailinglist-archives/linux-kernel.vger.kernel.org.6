Return-Path: <linux-kernel+bounces-510248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B25BA31A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6F63A29C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCB92111;
	Wed, 12 Feb 2025 00:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCbCr2RZ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EB8F6E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319207; cv=none; b=enptyYhuPk69tCk1n5gyEhR3iw1SPzRYs9ydLMBe5Pwaf42kXMflLApCONPbYWppl1khM+ZVrPlVJGmZZZoO2XXw7mJHhb+B7rMKLail7bJbyw+3rcNU9896nS8sBm3CTPEDDs3CiKisk4J5F8fo4qRg9lucD1CsnaFzC8DDRhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319207; c=relaxed/simple;
	bh=AfGoqhjTzUpQGuvtQWiZjgEkOZEMTfW3aERwEHJQ9hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgbdKiqbp0mfEg7REICBR/bUiMxBYEA9ruG9u+cIABZfv/Tt/jYm5XpSkWxta8gv7jAzxei4w8vkpS6uIF+9c+pzS+iNIhI29YXeuzEeHhrbMmH6IoeMilWpuO+i0ys7hErNOs8hO4pMZjGuRfLosbmA3fLfLqu+3TpBLaVdMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bCbCr2RZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54509f46614so3304156e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739319204; x=1739924004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=09rdko5VnFpqLqbQWkI5gnzT1kNBqMtoAA5n9hDbxAo=;
        b=bCbCr2RZM6a3FVs9ty53IMkSSw06auQCp+M9ZRURt+9+U8/H7ei/+fRXUtrd7Qa4UR
         +bsaL6pZn4Bra5wNeIh8j97Ax2ZKE5UyX8WoPP/v3wXIIcCKeeHwlBJWVD6ZYFdfDBJt
         MWBZa7S3NZlnzP99H59FJ3u/0e5lFGca4+eMUp4uqIdve/kM9gQ34BRkBzZbK48EpS/L
         o/cNfb+gjFhQatkT2cdqqIC7O1Kf2ecH9Z08qQGSiC39oZBPZngvMJSfEGdFXfGMXCsL
         p3A+7Ya7+uvZhggn+/rfyBZSNsjvoqr/wvxNKVHn8TOit30iZs0xCCFtqc2U/EUTgtH2
         riFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319204; x=1739924004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09rdko5VnFpqLqbQWkI5gnzT1kNBqMtoAA5n9hDbxAo=;
        b=XqaFrNvm0ZeRR/vFzLZJD6pLLYEx1REVBV05anVIrPOtZ3YljFzvf3HoduGBmfoeRH
         vhiNED8bDmxqE4SA+qvv+LMew39x1Ucas+yzlt5GJabSRN2jRE/LOmOsgVdjb9qCKFj/
         fZJUWJrNI0TUGRtcdD8mPUbzwBAAuYNy7FXpXNplzQ209SY6GXPZWoidXqh3wQUG1NMc
         3S/Xca28KlBzh8h4IQZYiHkcLWXzAAAlTkRm+CTr92f0GKPN3vdgkCgER2whqvjupg3A
         zPXePDAyC9Z4glZukwIVk9+m+vfY6tBTCTi/Y5VhVJOh6p/n4vEz633tQF9Zl4PTLSAp
         kyWA==
X-Forwarded-Encrypted: i=1; AJvYcCXyQJ7Du+8Zf0ui0hh1sEUZYqtEWezH+Dfq0foufF9sL7DBd/c/BJcFeVRPqXvc3UHUZxDg4Xe6jWRkzLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FGNO9p2NWUnNXaOtcsaiH2EIQhhVE7UkxDNysB3ho/ezc8YU
	IYCbj+CRMJIhp6DnWBfPhQcSsT6PXQEy97GE+9jZz8TJSG2tYGVguWRqCuOQsUA=
X-Gm-Gg: ASbGncsWuqtPtTqqtceFDBDHN25wzDJrj66pkygFdI3mVrvo+6s0eOjDYbFpZSwnnFp
	wgTM8yA/7OVMpOtGqqZ1qmb2K89k55t1m1QwJniZqKvTWMsMxMO0LWOw49AxsyA50RgPEkct2HA
	Y/a/xvT3Q0pZQqzcrNaeroMvvrrIRPWZyA9ge5Iby1sKPzlChb3WmUa3lPSecnvtAVOwDTb1hQA
	iP7S/tz398FG3AP5oUDZ1PvdwL2mRZfGzm5VkkeCn9TepQCyXwKUaHSenAhhBkISXFDCzYby75Y
	eADFVazv9CDYU4c1SIHgo3o84kRVst3yd7j8IxHhIxmBcOvnq17erzKCYMP919bdNznPzDY=
X-Google-Smtp-Source: AGHT+IHgVatrLZ/ZeYnRWB0ZM6rywyAVkWjefzKWqV7sKscFBHR+wM/ltf3GM+1GfPZl8mnRuMYC9Q==
X-Received: by 2002:a05:6512:2031:b0:545:54b:6a0e with SMTP id 2adb3069b0e04-54518182960mr253317e87.48.1739319203556;
        Tue, 11 Feb 2025 16:13:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053eb53sm1684741e87.36.2025.02.11.16.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:13:22 -0800 (PST)
Date: Wed, 12 Feb 2025 02:13:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, p.zabel@pengutronix.de, 
	abel.vesa@linaro.org, quic_qianyu@quicinc.com, neil.armstrong@linaro.org, 
	manivannan.sadhasivam@linaro.org, quic_devipriy@quicinc.com, konrad.dybcio@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <7deghiadmomrz7w7vq3v7nkzq2kabq4xbhkouswjrexif7pip3@tvjlpvuulxvp>
References: <20250211094231.1813558-1-quic_wenbyao@quicinc.com>
 <20250211094231.1813558-3-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211094231.1813558-3-quic_wenbyao@quicinc.com>

On Tue, Feb 11, 2025 at 05:42:31PM +0800, Wenbin Yao wrote:
> From: Qiang Yu <quic_qianyu@quicinc.com>
> 
> Some QCOM PCIe PHYs support no_csr reset. Unlike BCR reset which resets the
> whole PHY (hardware and register), no_csr reset only resets PHY hardware
> but retains register values, which means PHY setting can be skipped during
> PHY init if PCIe link is enabled in booltloader and only no_csr is toggled
> after that.
> 
> Hence, determine whether the PHY has been enabled in bootloader by
> verifying QPHY_START_CTRL register. If it's programmed and no_csr reset is
> available, skip BCR reset and PHY register setting to establish the PCIe
> link with bootloader - programmed PHY settings.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Signed-off-by: Wenbin Yao <quic_wenbyao@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 91 +++++++++++++++---------
>  1 file changed, 58 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index ac42e4b01065..7f0802d09812 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2805,6 +2805,7 @@ struct qmp_pcie {
>  
>  	const struct qmp_phy_cfg *cfg;
>  	bool tcsr_4ln_config;
> +	bool phy_initialized;
>  
>  	void __iomem *serdes;
>  	void __iomem *pcs;
> @@ -3976,6 +3977,7 @@ static int qmp_pcie_init(struct phy *phy)
>  {
>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs = qmp->pcs;
>  	int ret;
>  
>  	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
> @@ -3984,10 +3986,17 @@ static int qmp_pcie_init(struct phy *phy)
>  		return ret;
>  	}
>  
> -	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> -	if (ret) {
> -		dev_err(qmp->dev, "reset assert failed\n");
> -		goto err_disable_regulators;
> +	qmp->phy_initialized = !!(readl(pcs + cfg->regs[QPHY_START_CTRL]));
> +	/*
> +	 * Toggle BCR reset for phy that doesn't support no_csr
> +	 * reset or has not been initialized
> +	 */
> +	if (!qmp->nocsr_reset || !qmp->phy_initialized) {

Instead of having phy_initialized please add another boolean field,
qmp->skip_init = !!qmp->nocsr_reset && !!phy_initialized;
Use qmp->skip_init through the code.

> +		ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "reset assert failed\n");
> +			goto err_disable_regulators;
> +		}
>  	}
>  
>  	ret = reset_control_assert(qmp->nocsr_reset);
> @@ -3998,10 +4007,12 @@ static int qmp_pcie_init(struct phy *phy)
>  
>  	usleep_range(200, 300);
>  
> -	ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
> -	if (ret) {
> -		dev_err(qmp->dev, "reset deassert failed\n");
> -		goto err_assert_reset;
> +	if (!qmp->nocsr_reset || !qmp->phy_initialized) {
> +		ret = reset_control_bulk_deassert(cfg->num_resets, qmp->resets);
> +		if (ret) {
> +			dev_err(qmp->dev, "reset deassert failed\n");
> +			goto err_assert_reset;
> +		}
>  	}
>  
>  	ret = clk_bulk_prepare_enable(ARRAY_SIZE(qmp_pciephy_clk_l), qmp->clks);
> @@ -4011,7 +4022,8 @@ static int qmp_pcie_init(struct phy *phy)
>  	return 0;
>  
>  err_assert_reset:
> -	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> +	if (!qmp->nocsr_reset || !qmp->phy_initialized)
> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  err_disable_regulators:
>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
>  
> @@ -4023,7 +4035,10 @@ static int qmp_pcie_exit(struct phy *phy)
>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  
> -	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> +	if (!qmp->nocsr_reset)
> +		reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> +	else
> +		reset_control_assert(qmp->nocsr_reset);
>  
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(qmp_pciephy_clk_l), qmp->clks);
>  
> @@ -4042,16 +4057,22 @@ static int qmp_pcie_power_on(struct phy *phy)
>  	unsigned int mask, val;
>  	int ret;
>  
> -	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> -			cfg->pwrdn_ctrl);
> +	/*
> +	 * Write CSR register for phy that doesn't support no_csr

what is CSR register?

> +	 * reset or has not been initialized
> +	 */
> +	if (!qmp->nocsr_reset || !qmp->phy_initialized) {
> +		qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +				cfg->pwrdn_ctrl);
>  
> -	if (qmp->mode == PHY_MODE_PCIE_RC)
> -		mode_tbls = cfg->tbls_rc;
> -	else
> -		mode_tbls = cfg->tbls_ep;
> +		if (qmp->mode == PHY_MODE_PCIE_RC)
> +			mode_tbls = cfg->tbls_rc;
> +		else
> +			mode_tbls = cfg->tbls_ep;
>  
> -	qmp_pcie_init_registers(qmp, &cfg->tbls);
> -	qmp_pcie_init_registers(qmp, mode_tbls);
> +		qmp_pcie_init_registers(qmp, &cfg->tbls);
> +		qmp_pcie_init_registers(qmp, mode_tbls);
> +	}
>  
>  	ret = clk_bulk_prepare_enable(qmp->num_pipe_clks, qmp->pipe_clks);
>  	if (ret)
> @@ -4063,15 +4084,16 @@ static int qmp_pcie_power_on(struct phy *phy)
>  		goto err_disable_pipe_clk;
>  	}
>  
> -	/* Pull PHY out of reset state */
> -	qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
> +	if (!qmp->nocsr_reset || !qmp->phy_initialized) {
> +		/* Pull PHY out of reset state */
> +		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>  
> -	/* start SerDes and Phy-Coding-Sublayer */
> -	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
> -
> -	if (!cfg->skip_start_delay)
> -		usleep_range(1000, 1200);
> +		/* start SerDes and Phy-Coding-Sublayer */
> +		qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START | PCS_START);
>  
> +		if (!cfg->skip_start_delay)
> +			usleep_range(1000, 1200);
> +	}
>  	status = pcs + cfg->regs[QPHY_PCS_STATUS];
>  	mask = cfg->phy_status;
>  	ret = readl_poll_timeout(status, val, !(val & mask), 200,
> @@ -4096,16 +4118,19 @@ static int qmp_pcie_power_off(struct phy *phy)
>  
>  	clk_bulk_disable_unprepare(qmp->num_pipe_clks, qmp->pipe_clks);
>  
> -	/* PHY reset */
> -	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>  
> -	/* stop SerDes and Phy-Coding-Sublayer */
> -	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL],
> -			SERDES_START | PCS_START);
> +	if (!qmp->nocsr_reset) {

Why this one doesn't check for the qmp->phy_initialized?

> +		/* PHY reset */
> +		qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
>  
> -	/* Put PHY into POWER DOWN state: active low */
> -	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> -			cfg->pwrdn_ctrl);
> +		/* stop SerDes and Phy-Coding-Sublayer */
> +		qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL],
> +				SERDES_START | PCS_START);
> +
> +		/* Put PHY into POWER DOWN state: active low */
> +		qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
> +				cfg->pwrdn_ctrl);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

