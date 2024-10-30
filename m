Return-Path: <linux-kernel+bounces-388604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3049B61FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04031C213B7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D62B1E570D;
	Wed, 30 Oct 2024 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oc2Sa1xI"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77151D0E30
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 11:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288266; cv=none; b=HR/isapQ82e1jUOI3bxThEI9QjK1p3Gxx44BmVdN/7+i6ewOY8Qm2Ojjcaxbzy1zVFoDVdW7MIel/kH1c8kk1gmOBDI9GHtVFRqfqQldgv+l5GbfpBAvUO462VpcvmG4Tr0+gW58mxLchYah29NB8gJjmR9dhx681AMBxFQtEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288266; c=relaxed/simple;
	bh=FpqEcqz5ysQty4cAtR4jPHdLSbIpX1aKXXfjG/Vd8MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUTbRtRYAWMPiCrt5vcL6j5d9OL8r2HWRbxPuu13TM5VI1Mg0iH8vpJLXmfpUdJ18EX6rgaRoJbPQ9/ucZaxyhpBV4IeAg3weNunApDweF4sct4xnpPpVxTcTYOsl0AQ3LVKM1loFWswStwKRwi7W0POVjiXwT1ZCLJILxx1JZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oc2Sa1xI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53c779ef19cso238092e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 04:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730288261; x=1730893061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k6P6CHR2G+Z74CeVbWC/M2HCFnqe+PKSGrzretJt9j4=;
        b=oc2Sa1xI1y5+9zYywu0qF5PQZFT60fAT1lUYQOd9GBzjhxC2rB5AQ7BYh67EZKRPO/
         eGlIZBmgcYkMOipk4GHYyxagUX5S5rbRBz+atnUaWXljFM7yLi0Iou42p9cSjrEwTgBH
         F/cWvK4+zOYShK0UxgPoRg2X+gnvKVdl2cnL7nbhkzhWSX4Fj2uIonER8kr4sezIotVK
         XgkHNerptC53bwVR44wuQ+urD11UjZ3kRuo1GaZi3toKUnyylksxAIKMXabv8CDL5YHR
         5aufBFqnZklSrotM1SIhmp+s09IWXvLkXCQh9+tcBhCfePEokiTh0pUrXHgYgcGPhO73
         sq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288261; x=1730893061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6P6CHR2G+Z74CeVbWC/M2HCFnqe+PKSGrzretJt9j4=;
        b=or/SWbK9RZicnkhalsU1hgy7DG2qTsWSRFyHUqIa03ksF0cfljzIYqiqhhsrrPLmI3
         gNtTNSyIfeWV5bf+JE2/Le8bO0YnnblPIEaeo1XfFNJAzaSt50iVBfUIRCZmjdPslvrf
         jVPGXl/O7Qq0dduXFyfitb3pDU2wQTGvYYPnH5TfhqdLVNIOvWFNcGxFEtCKlks4cC7J
         GSMxSefOJ3MRMWaNVHXoKcFf/naaAWxOK6Xwo4jkjDEhXyZScWxjuRdHZkzfOxS56lrx
         AzAm2xYRQVlIKvhpZ0SOzzUtq9/ba5ecy1GkEMBUsqfEpqceLBuZdAX2LaVbuRpbMx6b
         Y4+A==
X-Forwarded-Encrypted: i=1; AJvYcCXWslxJC6nZfLwAQJ5MNWGvyX3jmeh0RgfYSJQQaqAPBcE28z7/ISda2kWG72MsvY10HK3Xf4Hqeezz+nI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzLvEQHxEJYu7j2uyjX4/de6txkXTSlHWjwjpjWofQnIWygxJG
	klyw28xNRWiOty5Mi2K7lf2TqQcfNQsFg+4oB4Nk4PklSHPP38WB0Vqkk2DxhVU=
X-Google-Smtp-Source: AGHT+IHyikXAyWWvRz+LDig1htJzJ4Wi027eELtxUwK8sBFMRombUryR+qpp/TW7fESgN0nBLz3WyA==
X-Received: by 2002:a05:6512:3d14:b0:539:fc86:ce0e with SMTP id 2adb3069b0e04-53b348e58c7mr7586492e87.35.1730288260923;
        Wed, 30 Oct 2024 04:37:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c763d8775sm85995e87.129.2024.10.30.04.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:37:40 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:37:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, Stephan Gerhold <stephan@gerhold.net>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] cpuidle: qcom-spm: fix platform device release in
 spm_cpuidle_register
Message-ID: <ltsbd7dyvfpk6dhcl5cpwcy3gctzdt3rmiivue4uluujgxcfxb@duuo5ygohqwr>
References: <20241030-cpuidle-qcom-spm-cleanup-v1-0-04416fcca7de@gmail.com>
 <20241030-cpuidle-qcom-spm-cleanup-v1-2-04416fcca7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-cpuidle-qcom-spm-cleanup-v1-2-04416fcca7de@gmail.com>

On Wed, Oct 30, 2024 at 07:38:33AM +0100, Javier Carrasco wrote:
> A reference to a device obtained via of_find_device_by_node() requires
> explicit calls to put_device() when it is no longer required to avoid
> leaking the resource.
> 
> Add the missing calls to put_device(&pdev->dev) in the success path as
> well as in the only error path before the device is no longer required.
> 
> Note that the acquired device is neither assigned nor used to manage
> additional resources, and it can be released right after using it.

Well... This raises one question: if the device is put, then its drvdata
can go away. But at the same time the drvdata can also go away if the
SPM device is just unbound from the driver. Granted the age of those
platforms it's probably not worth refactoring the drivers too much.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> 
> Cc: stable@vger.kernel.org
> Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-qcom-spm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
> index c9ab49b310fd..601aa81ffff3 100644
> --- a/drivers/cpuidle/cpuidle-qcom-spm.c
> +++ b/drivers/cpuidle/cpuidle-qcom-spm.c
> @@ -106,10 +106,13 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
>  		return -ENODEV;
>  
>  	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
> -	if (!data)
> +	if (!data) {
> +		put_device(&pdev->dev);
>  		return -ENOMEM;
> +	}
>  
>  	data->spm = dev_get_drvdata(&pdev->dev);
> +	put_device(&pdev->dev);
>  	if (!data->spm)
>  		return -EINVAL;
>  
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

