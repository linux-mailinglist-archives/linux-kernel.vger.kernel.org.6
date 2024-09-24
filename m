Return-Path: <linux-kernel+bounces-337214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967F984711
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC8C1C208CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851E1A76BD;
	Tue, 24 Sep 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEmz6zlF"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D981A7067
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727185826; cv=none; b=PlbjQ6HO+/tvJTmUC8dPZ7YBhT1r7AMWTggMbhr9hNzp0xq08upC+4CiEXrmjYWv+rUpug7eyGVKDuzGeLSCG5R0CEBlgeTW07N03jwxhAa3LNQJ0qT9V5Nw3KKrd/ggG3ZXJWayDy2wZ5/l83GpcZ+PZcjZy002iAJc9AN5ZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727185826; c=relaxed/simple;
	bh=FfFjf3VJdlGssW2awH79Wj4ykRkSoAFUaeAibisjnZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2y3zCxrS3VWz/AaeQkrpiu6E9AUiBEcUOTjhzKhHWKqNbdprlUgYD4C5g0508WLIoLp4w2/b5KrHhZNBwVsOVW9Jic7rdzrvQhTv0f6Kkxr+QML+1Fbb1/agMPQB7TbidiIChY8VLkTJx6StZ0fEojLqSSwj+k5+FJxj/BNZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEmz6zlF; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3d2f9f896so7731526a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727185823; x=1727790623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U0y2FhLvJlmHV0mTv41RTPjAXO9B+KhA3TIpyOQoJGM=;
        b=tEmz6zlFK/gEE423R043YjO+P/ikl6mtuHc7Ia9SuwZqwawfglwcM/JQ8Cuknp3gCq
         fUp+z93PcLrY2vCwqE6yLE+t5tNm43YE4oCE9pEvQTQWvNalWQ1PA0p7TxOALEdQ2CjT
         kBLpB2e48oyQhiXMN1u4IwK7nuYsboGl6eYaooMzTN+XGEv/l/bQpePpQwrSOwOv10IN
         v5UrpWb2A4jKtExQT+hmCqCKjfwDoq4l0jTWM1EWSgDAvNqODt65udx75X3SMYQ9F+Az
         uGd7aVWkWdFMgIORxZFDhCeetqqTnW2ASAtAX0pAJgMXaI9ziTEHsUPco2hwmH2G2BSD
         pCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727185823; x=1727790623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0y2FhLvJlmHV0mTv41RTPjAXO9B+KhA3TIpyOQoJGM=;
        b=Ze0scqdQ2yjLhEvmB5gvXZSc1xYGUSgJlSGPkm/TTGtY8PUTHwlsWI6wllilVBmcrb
         NNf45/IFd4qYtfCadSGW1lxC2/mItqojMpvlpCIXxymLwd5XGQi0EisbQ528KyL0clx5
         8eb10SZxWlbdeXwQkbzh8W5C2MVQS+iAGvQdL4lkicg/uo763VLFqjYyKw+tO2NDfmW5
         WsqWvIhhfC4UK14HoIlJ1pFcXdw9XAMEjV9Y2utKzGCmWAdUHocSpNdxk24wKNMb6HQv
         zf3J74LBwBJjQSkweFxY0JnHv5gVNfk/ug2pBGp6yH0dQeK9E4fuxcZUEEy3Uz41KmTa
         tLrw==
X-Forwarded-Encrypted: i=1; AJvYcCVaMozCjclLwhp+uWe7PjRlY0IQpq1dqtrzGW24graGMYt7jctO2p+nHrbQ2l5/DmoPTw3BYo0RBLg5ZgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV08qVdXMP2XRO4bRQloaxGwRSwjL6t3/soM9sLCijKwcQKZWW
	8ZC+WhhbE4rCrZQhTWLRGwTlkSIglUuAig1KA8cUn+swJhS2NM+kMWAe3A3ypw==
X-Google-Smtp-Source: AGHT+IEyXFVN8yWlZBr2c0QmUeS9Pixk5O8tibvuF7nDhnrYoQ0QURy2zis3HJYVbJUApjUTxl05fQ==
X-Received: by 2002:a17:907:e615:b0:a8d:7046:a1bd with SMTP id a640c23a62f3a-a90d501ad10mr1301633766b.28.1727185822706;
        Tue, 24 Sep 2024 06:50:22 -0700 (PDT)
Received: from thinkpad ([80.66.138.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93931340b5sm85768766b.190.2024.09.24.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:50:22 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:50:21 +0200
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
	abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 5/6] PCI: qcom: Add support for X1E80100 SoC
Message-ID: <20240924135021.ybpyoahlpuvedma5@thinkpad>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924101444.3933828-6-quic_qianyu@quicinc.com>

On Tue, Sep 24, 2024 at 03:14:43AM -0700, Qiang Yu wrote:
> X1E80100 has PCIe ports that support up to Gen4 x8 based on hardware IP
> version 1.38.0.
> 
> Currently the ops_1_9_0 which is being used for X1E80100 has config_sid
> callback to config BDF to SID table. However, this callback is not
> required for X1E80100 because it has smmuv3 support and BDF to SID table
> will be not present.
> 
> Hence add support for X1E80100 by introducing a new ops and cfg structures
> that don't require the config_sid callback. This could be reused by the
> future platforms based on SMMUv3.
> 

Oops... I completely overlooked that you are not adding the SoC support but
fixing the existing one :( Sorry for suggesting a commit message that changed
the context.

For this, you can have something like:

"PCI: qcom: Fix the ops for X1E80100 SoC

X1E80100 SoC is based on SMMUv3, hence it doesn't need the BDF2SID mapping
present in the existing cfg_1_9_0 ops. This is fixed by introducing new ops
'ops_1_38_0' and cfg 'cfg_1_38_0' structures. These are exactly same as the
1_9_0 ones, but they don't have the 'config_sid()' callback that handles the
BDF2SID mapping in the hardware. These new structures could also be used by the
future SoCs making use of SMMUv3."

- Mani

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 88a98be930e3..56ba8bc72f78 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1367,6 +1367,16 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 1.38.0 */
> +static const struct qcom_pcie_ops ops_1_38_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
> @@ -1409,6 +1419,10 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
>  	.no_l0s = true,
>  };
>  
> +static const struct qcom_pcie_cfg cfg_1_38_0 = {
> +	.ops = &ops_1_38_0,
> +};
> +
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> @@ -1837,7 +1851,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_38_0 },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

