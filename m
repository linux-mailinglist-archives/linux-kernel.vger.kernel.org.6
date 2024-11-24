Return-Path: <linux-kernel+bounces-420127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEA69D7551
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3786F168BF9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 15:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B258A954;
	Sun, 24 Nov 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLYm6J5c"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42B015DBB3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732460449; cv=none; b=GPfX63L2mzgGlhFnm8FjDNKOAswcFqAtOMmatekmLd2lmL8mXRh/9mkEjWphr+J1mk8BXdhhiHZ0rCHYpYnhAiptyhEjNsvRX60faKowBktejAcISaEDS6XiwWq2h/E34rqDoxr+0UzHylMIn6JbA+3dyzP2h511MN/0a4gpARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732460449; c=relaxed/simple;
	bh=PBAxbrnOf3mUDylcJ3Av/xPCET+3fgbDMZT7D8E9FlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEDnuZYfXw8xOld0X6U6GuZ1J843xNmKwp/242wajaSR5bWu1Dj6oKydUzaaAjXprw2zJRDlfGMAa9cBg1vvxuuchGyb9W6fRPw+tNtBEOoaL0M4NJTik+qP9ooqCVTp2pDO1+a5B0posCO3N/BgQXYfzfwkbrjgdKWMyqbKd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tLYm6J5c; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbc1ca1046so2818677a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732460447; x=1733065247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uGc1S2wYIhfLQogroy29pKHU2o6lK/gHyYeLMurEVxY=;
        b=tLYm6J5cAkL77InAgoqw04QEe50B2ygCIuwQEJGMI1bFgA1RxB1P5NJsIbinaCJ9IA
         bC4iVXsv4GwWVLsURtVMnYEQeJWImDod908IxkdnesFBZuuaCf+AQxjZv7TnbfUZ+M68
         wdVwF/wFAQmcmuP/528GXb7wX6UBJ6lPrUrPCjOO9j6++UgXaEgS64o7BzzxQi+GbO+i
         w4f+md2KHkmZpMrGvRmL7OjzqR8F4BNM074Ln6bBOiLlNPk1FkDm3iqoI8LH1jaNoSKQ
         0s+4mizfjl3WrmG3thoIZQ5yfnjnIrdI9trIN+Eo/HLxsS1ihAcRkV8A/KgPVjzrkRAJ
         Y91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732460447; x=1733065247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGc1S2wYIhfLQogroy29pKHU2o6lK/gHyYeLMurEVxY=;
        b=XwrxyRb5iTPR6BuJo9Dd3ckdgCFCQTr/sk7G+oEB95oW+C2Fvjk8IMJRjxpVk72eBH
         YLnU8SBLrR5qJVlMUt3UKjHYFK8uCOrskXxqGruD3XgTUFRuaCXfV3jP7BhqvaM+JhdW
         RVqR7kD6B80ibGWVEgbhrMAYxMD+UT+I6Os7aSYRzyhIH1t9d98NwNUj1LCeA11YhzOG
         ttRjxXci+V9xzcipCyX0+EVfRUNxFEqf7R/dRZIdY3So6/Tf4JAbaY4sEY8ioHqTxDfr
         PbjbSrWgi/HsCWWOWwlUtreZvFzOxE5dXc/zTOqO01xO8/NwDTk2SVDGvg/7Oiv8P4KP
         sx3g==
X-Forwarded-Encrypted: i=1; AJvYcCVeVK/Gh5Nq5zfTjQdUYMxvY/JCnw24m+aEmObQ48iALVn03mN329O8LR+KooqlBBsqlmMiIpZN3pLskEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0HJJmYe5htYRjrC8INUcspa3qdGaFuiAt6xZMyAm9siHto1Ku
	MEdP3ZEN1mAQvlYQ0+0pK9RxZiOxReX6pmMxlCs8ylsenV28WTMmsIaSwyS+Sw==
X-Gm-Gg: ASbGnctQHclY+cCbPXlXYqgZuk0YDouGN//mn+KbaVPY2mqJ8cGzIVgNX4yyvx/38gT
	JFZTl/+N6gGP674RpzB4TtgSmBuon6K/m6znMSaPvaNQPFNDSgoq+yaLjOMx3z4kKX2RgE/y66k
	MgZ+L9nKlQDfnmJORUnRoiafdlK1nVVGr0Zq2Z630ty1Zzu7QJg5atMRmLT0JeQYQwjKOBWLZGJ
	or5MezMgjVKJHcFsHhWKJhZ9UHIhiCjm/KFu3n/JF82KIjvWWzGzl3IbWV4
X-Google-Smtp-Source: AGHT+IGSIxvkw6uzHJU66ROMlaDDTKSfeX3BN4E33A4cnjvrKqZLF5VEOAWjCg4WJIQuCYjdbk/27w==
X-Received: by 2002:a17:90b:3a88:b0:2ea:47f1:7a03 with SMTP id 98e67ed59e1d1-2eb0e87c077mr12722997a91.30.1732460447156;
        Sun, 24 Nov 2024 07:00:47 -0800 (PST)
Received: from thinkpad ([36.255.17.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cfe448esm4893619a91.8.2024.11.24.07.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 07:00:46 -0800 (PST)
Date: Sun, 24 Nov 2024 20:30:39 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
	bhelgaas@google.com, kw@linux.com, lpieralisi@kernel.org,
	quic_qianyu@quicinc.com, conor+dt@kernel.org,
	neil.armstrong@linaro.org, andersson@kernel.org,
	konradybcio@kernel.org, quic_tsoni@quicinc.com,
	quic_shashim@quicinc.com, quic_kaushalk@quicinc.com,
	quic_tdas@quicinc.com, quic_tingweiz@quicinc.com,
	quic_aiquny@quicinc.com, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 4/6] PCI: qcom: Add QCS615 PCIe support
Message-ID: <20241124150039.cjp5g6pnulf5xnp5@thinkpad>
References: <20241122023314.1616353-1-quic_ziyuzhan@quicinc.com>
 <20241122023314.1616353-5-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122023314.1616353-5-quic_ziyuzhan@quicinc.com>

On Fri, Nov 22, 2024 at 10:33:12AM +0800, Ziyue Zhang wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Add the compatible and the driver data for QCS615 PCIe controller.
> 
> There is only one controller instance found on this platform, out of which

'out of which'? you said there is only one instance.

> is Gen3 with speeds of up to 8.0GT/s.
> 
> The version of the controller is 1.38.0 for all instances, but they are

Again, only one instance.

> compatible with 1.9.0 config.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>

With above fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..da7200b56b1e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1830,6 +1830,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-qcs615", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>  	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

