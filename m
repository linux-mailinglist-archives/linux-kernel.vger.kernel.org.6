Return-Path: <linux-kernel+bounces-368384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6529A0F41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8640286131
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74FA20E013;
	Wed, 16 Oct 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znm5wPG4"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA054F95
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729094638; cv=none; b=geUVv62cmX1YPBDmZVDEBtPrJWFTDmhO4QVD7qNdVh6x/BEMAkRg5CFm//W0C77Hdc/1GvzrwIAs6ZUADeDQydxsH3k4Q51uDC/ZCanJppvI3AOVmvLXDeWtb8i34hl751uQwi88iaUxeYCO+PSiZuZhlA10a1oRDlferIcd1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729094638; c=relaxed/simple;
	bh=BRBodJOMHQSSigJ75vx6VlllvyeNnPVrzypoa5NpDmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APiiVFYXthAnU7v4hrVCD4KFuvT38WE+sgshPasv2BFfIfg2KXNlW0nRUgf11lU7Nfi4l+y3r+SmG1PESDH9ewpt0eUsdXEt5yj4xOo4VUXoCyzeWPpvuHJlH6sJyApkG0N5POqDw0MXVnrOItBJ2tQiN41rSJ7Q57IfRukKbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=znm5wPG4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e74900866so1621953b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729094636; x=1729699436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9A2M3l9xrLracluunXQqaUIfsa0L4iWpemVG+XIr3TY=;
        b=znm5wPG4UwAcrV0D8/rg64a2e95SNfnq6VxRAkoSjqJAA2k/n5rO5HoJdSIQnWei8k
         /JE360Ia1opqBbXcYqp4hnCho2kXa94wuNO36LNx+TeDOr5F5Q5hxoHTqmGTegHLUlQq
         EmBp5muTVoAQj+MmaGvUCPdanZQj0zMXjGjQ/nVXBkmQg2auomYj8DHqNI6AG15HvXne
         J7NZ//2c/st3Nb51tcZPtGgmALG7+b+EkqQZKV6dMrnr8U839MX0kHdKS1iVk0Nslg5D
         nN8rnVUYZLMCWYm8gJSlf8KJ5H9tNyhLqelTOH/gGr5Khxm/cD2mSqM3OekGC+b4YnRe
         r0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729094636; x=1729699436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9A2M3l9xrLracluunXQqaUIfsa0L4iWpemVG+XIr3TY=;
        b=jCNW4zHO3A75fiBJrR+A6d7cPCX1eyoJalc8L/+VKk9otSDL/HLgIU3PGCj5DwHaoF
         S0fQr4BrsJtomYzSudryimMug+/ejNdPNjiwhXBAN5KsusmzuhruRyDox2RSViOPlMMZ
         hhA5FPLTUN8dXrC1l6lJumgd8bwYecprTGek9wDdbn02G9QCgVJYIuu/FLFd3XJt/MW8
         u7nIsprB47jqMi49rpMcWVmramZ68mX9UKaSdairfk6Al3qwdhL1uiZI3izZw6KnZq1i
         SyS06n+ZgTX4QAgCp3gnmRsMr4TDKi422fACSYpA17j47Z/i96TksBVivyKwI938cxZ5
         wS3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNDnUgAJIQ5ImHL0z+WcXjWoi6RmCmzBW68bjkbYg2N95cJpF9H4VKo7Cnb95F0NWGBdJp609afkcl1Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKT6NfAA9qbhK1CwCltNkEpYl8xllQ6UWliRSLVIWRBzi4yXjR
	lrfzMnMXtEYghUPh88v8X33hb6Y3P674woNeslfIMVJXQOotsptV0zrrgFzFdQU=
X-Google-Smtp-Source: AGHT+IFnobAnzJkSiUdU1I3b1rXS40/87QouJg7Eja2z0OpdeH1cg34MQqLrXEfnUMVAVSZABkiRgg==
X-Received: by 2002:a05:6a00:2d9d:b0:71e:7d52:fa6d with SMTP id d2e1a72fcca58-71e7daef151mr6268997b3a.21.1729094635890;
        Wed, 16 Oct 2024 09:03:55 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:2add:7601:8402:667])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a4251sm3204256b3a.128.2024.10.16.09.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 09:03:55 -0700 (PDT)
Date: Wed, 16 Oct 2024 10:03:52 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Zeng Heng <zengheng4@huawei.com>
Cc: nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bobo.shaobowang@huawei.com
Subject: Re: [PATCH] firmware: ti_sci: Fix compilation failure when
 CONFIG_TI_SCI_PROTOCOL=m
Message-ID: <Zw/j6DSmke5pJsJD@p14s>
References: <20241016013922.1392290-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016013922.1392290-1-zengheng4@huawei.com>

On Wed, Oct 16, 2024 at 09:39:22AM +0800, Zeng Heng wrote:
> When build with CONFIG_TI_SCI_PROTOCOL=m && CONFIG_TI_K3_M4_REMOTEPROC=y,
> compilation tool chain would throw the following error message:
> 
>    arm-linux-gnueabi-ld: drivers/remoteproc/ti_k3_m4_remoteproc.o:
>    in function `k3_m4_rproc_probe':
>    ti_k3_m4_remoteproc.c:(.text+0xc24):
>    undefined reference to `devm_ti_sci_get_by_phandle'
> 
> This is because devm_ti_sci_get_by_phandle() is compiled into the driver
> module rather than compiled into kernel, it causes compilation couldn't
> find the reference of devm_ti_sci_get_by_phandle() when tool chain tries
> to link ti_k3_m4_remoteproc.o into kernel image.
> 
> Replace IS_ENABLED with IS_REACHABLE to fix the problem.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202410150837.FOGlkGvW-lkp@intel.com/
> Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  include/linux/soc/ti/ti_sci_protocol.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
> index bd0d11af76c5..cd44ee7f294b 100644
> --- a/include/linux/soc/ti/ti_sci_protocol.h
> +++ b/include/linux/soc/ti/ti_sci_protocol.h
> @@ -572,7 +572,7 @@ struct ti_sci_resource {
>  	struct ti_sci_resource_desc *desc;
>  };
>  
> -#if IS_ENABLED(CONFIG_TI_SCI_PROTOCOL)
> +#if IS_REACHABLE(CONFIG_TI_SCI_PROTOCOL)

I have applied Arnd's patch [1] to fix this problem.

Thanks,
Mathieu

[1]. https://lore.kernel.org/lkml/e6c84b91-20ce-474a-87f8-9faeb64f3724@app.fastmail.com/T/

>  const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
>  int ti_sci_put_handle(const struct ti_sci_handle *handle);
>  const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev);
> -- 
> 2.25.1
> 
> 

