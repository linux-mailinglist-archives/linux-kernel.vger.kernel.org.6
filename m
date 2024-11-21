Return-Path: <linux-kernel+bounces-417531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDDB9D553B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E35B22ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4581DDC14;
	Thu, 21 Nov 2024 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9P1RY7q"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F31BD031
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227043; cv=none; b=rnDM7iKs2oKf63guxp0XG8kzq368qvZMdIRoSuBattJSuCA+yoHZal6XlYGsWCstSdGWcoSj8olUGHQi1b+y1a8eDfS8fw1k4mg6mXlou2CaAJBilig3QYEfHejP/PPCsjUtp39tsHoFOObmoDKhOhMRVba03uyVzC5Gq/jBrpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227043; c=relaxed/simple;
	bh=yeWBaZyskmHQQzGoYf4eQzjnS5JlEV8qt70IgjYzCIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTLN57Rra1uuPz3f4u5GYK+VX3HysGqSRCYnJ5UcjLp4w0NJDPnCYSta6xvKyHEHKXxh4mh1cycTtlE/naAh3EnKHjrtmxIXdwp6blbuAu7CR0QTL1faEv50o9iT/WXH12n/uJRprl+eC/JDPYsyOl4vNjs2Zys5M7LLppOF17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9P1RY7q; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ff976ab0edso15277141fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732227040; x=1732831840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFDuP7IjDwDMv6NR+DnprUqGpxBiP59fQ/sq6qPsJrg=;
        b=H9P1RY7qOTOzBIoE9oqgJcctr5IqJ9f3UvXdpcBOJrQ+nVf0lLCpWjh477uvHWFek6
         GyU8h2ELHq2Z3bMc47zDNEd79WT3cBbSUGXDV2djQlMm65J/kXFUkNlg1wU3Dtz0R5Wd
         5G2b8/aIRkJFmuwAcotlk1VyuJ43aCcl8b1nlQ4Ly3nfcfIOaJfMO3YoP0vw/xNJbElc
         QFw9qUhPOH90ZGVpph3XJiYDtXcUrUsjVEa14Ug9bKk2KoiaYzPUdsaTNxfvMfdH7FoT
         +qwyDMnMDRRcVGZIpqyT8K+DLrUUCIIGpgsYuv1UkA/0jSSNliFxe1LGWb4EtXbxVsFQ
         eT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227040; x=1732831840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFDuP7IjDwDMv6NR+DnprUqGpxBiP59fQ/sq6qPsJrg=;
        b=UQdSol1dwacz3dCO//g7QcWhEBfZDnh1evN1uA+9Y2Ha94NvDJaUuCYKpad1InOXjQ
         Xex4AO92kBTnHNk8juKpOOtbZZBUa+GgcaMduTBfgf66E9PHSnggCj7eQkeHg0Cv030V
         9f4cUn4bwUSEgh0ErbuOx/6NmrELLqqwj+aK8OfD1Zje7nMIiaLi5jbS8XeK8BRuaRHh
         /Y5r5wKgDsIaHIjIsHG1Jr548OPhURMTZ0QWQuKOe9nLY7mk7TvsE7Qquf6REPje9ZjD
         Thit1S9hR4C6V3td3ziIsVZbXck+Avoukjd4/KZzmoh/174Np7FAbM/UZHgSD88J8OnU
         fqog==
X-Forwarded-Encrypted: i=1; AJvYcCVGdU8oG2zXzMCKrtfytETjBU1WOW9oQ10oLkOWQtFvGeN51y0wuvTt5SPafUS41Y1kysm5bkA7FhKwqG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAJNTVrtL73N9RidgjifYGhEh+uKXg+jDJiIMXAfYurwq267w
	J7euIl6gF4PXe0fBp3PDdlrk8Fk6g8rukyzjHZBOVfn/8yut/4pJ8YtJ8U+YspU=
X-Gm-Gg: ASbGncvptejPCMKhvm2mhYEz49hRMLSu01cvYvsE17y6al4ZP8wM+FiRqent8sJwblT
	TMW5l+qu+B+tF7/ZH4KMWraTat6kH4nobaupVve0nL3syiGHszr/w35JHKN9r8ZSasFWNBU24tK
	cLL0GzYTc5xBxhXqQIlXu9Vv8uqluAuKb38xyJP3o9/cPB5UFXLbVY+cQLv7+Mxz9TC7OWmUn65
	HI67samQcuwcm5hCu5SiH0M2VTmSaJxrrQKTLdPhknJ3gO+0s/VEW4qYV9poTks04aN16rwE5xA
	C0RTiADo+jQokZzTRyZBsZeu0ho4cg==
X-Google-Smtp-Source: AGHT+IF5UEvVH8EwlVFvDbA8yqDXP2EnIvz85XTHp+jyVxMS03tfkpla0bwll8dc1ETCUfCWi+KKfg==
X-Received: by 2002:a05:651c:2208:b0:2f4:3de7:ac4c with SMTP id 38308e7fff4ca-2ffa70f0968mr1996351fa.8.1732227039935;
        Thu, 21 Nov 2024 14:10:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538f100sm593151fa.103.2024.11.21.14.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:10:38 -0800 (PST)
Date: Fri, 22 Nov 2024 00:10:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v3 3/3] i2c: i2c-qcom-geni: Update compile dependenices
 for I2C GENI driver
Message-ID: <zfkhbjm6wrmcocqcvluov3nbrpb2ozbo52c6nlwxro44gublcw@5645ksz4cfm2>
References: <20241121130134.29408-1-quic_jseerapu@quicinc.com>
 <20241121130134.29408-4-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121130134.29408-4-quic_jseerapu@quicinc.com>

On Thu, Nov 21, 2024 at 06:31:34PM +0530, Jyothi Kumar Seerapu wrote:
> I2C functionality has dependencies on the GPI driver.
> Ensure that the GPI driver is enabled when using the I2C
> driver functionality.
> Therefore, update the I2C GENI driver to depend on the GPI driver.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> v2 -> v3:
>    - Moved this change to patch3.
>    - Updated commit description.
> 
> v1 -> v2:
>    -  This patch is added in v2 to address the kernel test robot
>       reported compilation error.
>       ERROR: modpost: "gpi_multi_desc_process" [drivers/i2c/busses/i2c-qcom-geni.ko] undefined!
> 
>  drivers/i2c/busses/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 0aa948014008..87634a682855 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1049,6 +1049,7 @@ config I2C_QCOM_GENI
>  	tristate "Qualcomm Technologies Inc.'s GENI based I2C controller"
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on QCOM_GENI_SE
> +	depends on QCOM_GPI_DMA

So... without this change the previous patch is broken, which is a
no-go. And anyway, adding dependency onto a particular DMA driver is a
bad idea. Please make use of the DMA API instead.

>  	help
>  	  This driver supports GENI serial engine based I2C controller in
>  	  master mode on the Qualcomm Technologies Inc.'s SoCs. If you say
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

