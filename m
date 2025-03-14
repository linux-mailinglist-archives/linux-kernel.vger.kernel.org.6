Return-Path: <linux-kernel+bounces-561617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9457BA61413
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA41F17C457
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96619201035;
	Fri, 14 Mar 2025 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mksSY5yo"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C1200B85
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963843; cv=none; b=YJ/vesRZvjEUXceAYjDqlhe59HuTj7cPXHjK/FpxOblHKEqCM2P+fRK4ADJLPjk/bIeU6qp8yGfrAzhlXFXoSEQQCfi3A9C17XvI/seMXnV7k7Y1IlMt7adK4mchom1lDlSZN+HU9oDMOHPQ3nfsYpCEKWmV7sIXDnQshMNsrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963843; c=relaxed/simple;
	bh=maO4VrlOA5Crgv/3qBCu9Kk+oUeartKpyLArd51qh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJv2R6PrYDorsV8KiqKxHT7bPVyhQS5hsHlZYQk0QO6RkbxTXhKmkQ/mPDb2P8KtE5iswZNgwaGI5uHEMpVmS+Xon0HbVP/XRUKkSYU5tA0RYFBzFnTiZfenSPbG0HkBtTGPcdDa/07yyTT/eXpLnBLWZupITTGGDebP95T352o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mksSY5yo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22401f4d35aso43860775ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741963841; x=1742568641; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7OrItOGYSNYN0heMZXm9O2Sd5YIsOC/lcspBLUrGTOo=;
        b=mksSY5yoJH4Tcp4rWXEzbFSEBM9Uco3ucM3ETh8xpcnQEugnJiob/Wz45hlEhsFZWn
         Hvew+7z4nw75/MOVQmuK3iOQsrNs7Odc3ZeF+BP197vSuU5gZfUWje0L+AHED5x0vyJP
         z2qHOEU5E8iRnhom4XZwPINW2qk6qrm/HPShoEYJpSe6nVgVAwxoXbfoz83tpF78rNCh
         IjLq7Gzvhy/VJHJkDXWNUkpBXCZ/OHIgqYwy5aQqSw/iLVdKFao3pr7gz4D2qLH6m56e
         pzj1wqaVN3jduVNJJ0bwh+omPAQZffjlzAa6o1C+s+pvP2r8IoN+rDfV5ayYA1wloSiU
         z2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741963841; x=1742568641;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OrItOGYSNYN0heMZXm9O2Sd5YIsOC/lcspBLUrGTOo=;
        b=bJa16ArC4jW/eRZwAbUaxeSN+wglWPxAJ4qMcpgAatsMqW2XQIpCzL+YU0Au0Kp3TL
         99Z+FZnxxIVzIbp2lDmS1Mz6SXWtLPuFQhIH1dQ412ZetNbI3mroUdFVjCzym0vLgSjg
         iyIoVaGkkJegKsVitEUPL5CjtqVcjvHK1PMOrau6F5tH5trd72GD6eF8HGe5zG5kS7Tp
         vS93fxsMIpBebrATdXCbVR2Nbtd/doZbhwbygXupM6zyGkD3Qb/eTJxtF43JrSfCgowb
         rUEpZD1wNRes8H3542i+j8vEpRVSHwn8HEzrn4Abj9EmMlsgqXkthbHcyg3aqGVFqU8p
         mpmw==
X-Forwarded-Encrypted: i=1; AJvYcCW8bXp3MbDsf2JN44niV7Gk+zzFQ2YwXY9aMnL+qAseyrFtcgPLIiP3oiu0Cmx0pmPjCGh1DPvgztfNxDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVePsgKqqNGHj/6Fo2FPrDuAgPMsRzCgWeNCqRP5z51vLpPoK4
	T8EbUYKA9xEWGVM2OB7P083cqpm8BogOb4dDFiR6ChvjGTAGYrfcjaAlJQTJRw==
X-Gm-Gg: ASbGncvbYbswTjHVU4fwQHsXdsFlMcn/umWOciBGiCkQEf+qHhI+Jjoes0zTbFJaEu3
	nx8ZtOrQ9jmvVojwHvkzGwq0nJjhqTaiSjafnmR6hnNVLPzui5Y6MNYsPbFn1XaP3cTDAWEUHqJ
	u8Y3r9SpfIns8aRQO6/oEiTl9px1s87BqeTkILL7+aixQpku1zFOO5ZMIleMRod0rnqmpaOkZ0I
	7zqeKRwiXLn18k5JoZrT+JtusLb85qDqdB9AOpHn0WuLS+HKM4Q5pP9/iIDIa1rwygth6qqmsAo
	6dK2fIL2cb3k1dbQ3D5WPxyeaRChaC8+wWRkZO7UDdOlUgghkakFPwGc
X-Google-Smtp-Source: AGHT+IHmY97xSOZQboXnoTB4b5k6xHHuACGBmQ9IazWwAK8CRME94eJLpOCS80qaR25WQuoGvR2UGA==
X-Received: by 2002:a17:903:98b:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-225e0aeeabemr39677735ad.42.1741963840675;
        Fri, 14 Mar 2025 07:50:40 -0700 (PDT)
Received: from thinkpad ([120.56.195.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba734esm29357815ad.141.2025.03.14.07.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:50:40 -0700 (PDT)
Date: Fri, 14 Mar 2025 20:20:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, abel.vesa@linaro.org,
	quic_qianyu@quicinc.com, neil.armstrong@linaro.org,
	quic_devipriy@quicinc.com, konrad.dybcio@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] phy: qcom: qmp-pcie: Add PHY register retention
 support
Message-ID: <20250314145035.h3nybvvko3ew37wl@thinkpad>
References: <20250226103600.1923047-1-quic_wenbyao@quicinc.com>
 <20250226103600.1923047-3-quic_wenbyao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226103600.1923047-3-quic_wenbyao@quicinc.com>

On Wed, Feb 26, 2025 at 06:36:00PM +0800, Wenbin Yao wrote:
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One nit below.

> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 69 ++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index 219266125cf2..c3642d1807e4 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -2805,6 +2805,7 @@ struct qmp_pcie {
>  
>  	const struct qmp_phy_cfg *cfg;
>  	bool tcsr_4ln_config;
> +	bool skip_init;
>  
>  	void __iomem *serdes;
>  	void __iomem *pcs;
> @@ -3976,18 +3977,38 @@ static int qmp_pcie_init(struct phy *phy)
>  {
>  	struct qmp_pcie *qmp = phy_get_drvdata(phy);
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +	void __iomem *pcs = qmp->pcs;
> +	bool phy_initialized = !!(readl(pcs + cfg->regs[QPHY_START_CTRL]));
>  	int ret;
>  
> +	qmp->skip_init = qmp->nocsr_reset && phy_initialized;
> +	/*
> +	 * We need to check the existence of init sequences in two cases:
> +	 * 1. The PHY doesn't support no_csr reset.
> +	 * 2. The PHY supports no_csr reset but isn't initialized by bootloader.
> +	 * As we can't skip init in these two cases.
> +	 */
> +	if (!qmp->skip_init && !cfg->tbls.serdes_num) {
> +		dev_err(qmp->dev, "no init sequences are available\n");

"Init sequence not available\n"

> +		return -EINVAL;

-ENODATA

- Mani

-- 
மணிவண்ணன் சதாசிவம்

