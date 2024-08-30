Return-Path: <linux-kernel+bounces-308736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D608896610F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91926281658
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A1197512;
	Fri, 30 Aug 2024 11:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClwvBHk/"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF0190068
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018928; cv=none; b=gz6iZE4SQ+70tDQI7T6qbRZPejpw6mGzFfYFSOUWNYcEpFyld5H/ur7ih6whuKpqWI2x7cFXPHeHHtVsJTAmXiOkXxVo6evYVaxu9kaYsQFPyCNPUzUsGbqdmUVtP1Kzvc439qRTbSXFawmMDuoeGMUKsmysAzgYY4j6EpJdnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018928; c=relaxed/simple;
	bh=rGJabSH1WjGrwPyUZvO8SIhkBqF284ClrE8qaXkEwU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiIkp457XeS0Y/Q2apThP3t/aoJE+a9Io3JdovRrjdIhUVlnb1ponyFfNe5PYcymCzrOVfTnmDAwh9nIvkO5qntMzfRmud7+kgrWiAfpQ8WFYa6KaEJBxiwS+QmeuBU+f+uR+kF/ViqxL5jZMVhp7VcNRxmsxS8J+yaM/Bm2z1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ClwvBHk/; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5dca9cc71b2so961465eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725018926; x=1725623726; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2kXXjyoQkOSIGIfDRWOMPNe7ntaakkXVTK3kq6Qxk2A=;
        b=ClwvBHk/WBUYgmBFNCANRNc9u98r85EiYTRleP0gl7m5yUCdhZYOCmptRPPVyyo+FG
         cmC9iTEto7mZQi839hnUE3mo+R/L5MAenQautgTaAwinoAiRwlHTm/mma7HMRL3bg8iF
         vRtDiOzSLAtBJZaWAJd3l6g4fe+pJ1v1EppUG10j9JLzpu+ayQHoeu4FqNW6UXR6rL0A
         qUzyxQaCIe0HnBlyRfn0C/h4UqfR5ceFNiZAAxWIWNnKei4eL0gh6xttZRWbTPt+j/g7
         h2IXkauYYoGKfrXBX7/uTWRTvxga4J1z+xUWzsJw+hBdjQ/xPm1o7PLgwvusPZH5BtzJ
         wmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725018926; x=1725623726;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kXXjyoQkOSIGIfDRWOMPNe7ntaakkXVTK3kq6Qxk2A=;
        b=qrx/WyJh2VbToyhGXzY/JyfwMIY+/LQuhul7akawagz4j7VuIgXXFJjR3BIkVstwlj
         pD/q1uNGrl5QIfwO3vDOlP4lPkJnTF6wEgi4gjfeOGUJovOZBuQthghUFWnxW0/8lLZq
         rwudFWTnrs5U226CGtM2EuMEhL7gFQa2dD1admS8X6KD+vmpGkF+gGj4f7hn8hZnyBaE
         zueBgSBCsLAZYeNOoCl/qDvwvF6pLFvCh2sVPAwFRNm1G0ldTKnHw4Pv+ANwGVG3OI06
         4jLzCshRiQKYeOwx3QmCeDlDVtot/DrCPVbpdN+T81hMD76z0vQnnkskaClMVOqUe2U9
         COMw==
X-Forwarded-Encrypted: i=1; AJvYcCWpkMwWtmejN1U8YpUzL59FPbTERZIz7A2ieZegW18/TQCszCO+h2CXBsECbJ67moyY6vkdAwhYnrFlDIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3pS8pqA4ffCrAhREXm9wFHVXAQIhb/9urUcNY3yVLK2QkMPv
	s4AYQMYVQKh717FP/LqTitHN8fKrn6JJ0Dr9XxA7X8c2fwamuaYN41mLtqtOgw==
X-Google-Smtp-Source: AGHT+IH/BxJwIxRjq4Ftk2utGPO5gE372yrfaYPPrKkvTKKraSTvq03DzON9Ri0ykoGoYqRcozC2MA==
X-Received: by 2002:a05:6871:e25d:b0:25e:129c:2223 with SMTP id 586e51a60fabf-277900f62cfmr5786865fac.19.1725018926065;
        Fri, 30 Aug 2024 04:55:26 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5773733sm2584959b3a.217.2024.08.30.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 04:55:25 -0700 (PDT)
Date: Fri, 30 Aug 2024 17:25:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bus: mhi: host: pci_generic: Update the file path
 for Foxconn SDX55/SDX72
Message-ID: <20240830115519.nun52bselrkc77qy@thinkpad>
References: <20240725022941.65948-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725022941.65948-1-slark_xiao@163.com>

On Thu, Jul 25, 2024 at 10:29:40AM +0800, Slark Xiao wrote:
> To separate the images of Foxconn from other vendors, adding a
> new foxconn subfolder under qcom/<platform> for edl image path.
> And delete the fw patch since it's useless for Foxconn devices.
> 
> Fixes: bf30a75e6e00 ("bus: mhi: host: Add support for Foxconn SDX72 modems")
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v2: change the folder path architecture
> ---
>  drivers/bus/mhi/host/pci_generic.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 14a11880bcea..f159a9dd53e7 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -433,8 +433,7 @@ static const struct mhi_controller_config modem_foxconn_sdx72_config = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.name = "foxconn-sdx55",
> -	.fw = "qcom/sdx55m/sbl1.mbn",
> -	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl = "qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn",
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -444,8 +443,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
>  	.name = "foxconn-t99w175",
> -	.fw = "qcom/sdx55m/sbl1.mbn",
> -	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl = "qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn",
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -455,8 +453,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
>  	.name = "foxconn-dw5930e",
> -	.fw = "qcom/sdx55m/sbl1.mbn",
> -	.edl = "qcom/sdx55m/edl.mbn",
> +	.edl = "qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn",
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -502,7 +499,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_t99w515_info = {
>  	.name = "foxconn-t99w515",
> -	.edl = "fox/sdx72m/edl.mbn",
> +	.edl = "qcom/sdx72m/foxconn/edl.mbn",
>  	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx72_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> @@ -513,7 +510,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w515_info = {
>  
>  static const struct mhi_pci_dev_info mhi_foxconn_dw5934e_info = {
>  	.name = "foxconn-dw5934e",
> -	.edl = "fox/sdx72m/edl.mbn",
> +	.edl = "qcom/sdx72m/foxconn/edl.mbn",
>  	.edl_trigger = true,
>  	.config = &modem_foxconn_sdx72_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

