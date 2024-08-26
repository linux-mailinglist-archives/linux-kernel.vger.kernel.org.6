Return-Path: <linux-kernel+bounces-301070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720395EC02
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB281F211E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84941474A4;
	Mon, 26 Aug 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PL7/PMfE"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECBD13C9CF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660966; cv=none; b=nYHyBpsgbsxif9vE8KGXYPKP+30oAuVGxjGkyL7IliONzIqEv680Fw7iQm8T8OdD/YS5p/v4F+/KrC1Wo3HLgvYg33hPpJQMcuZKmzLhyEVJV6BwyWMOwPSO6FUzi45XVB/kHCBoFVtfimbG0M3s710psnQ3WcBIrezjPgdSS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660966; c=relaxed/simple;
	bh=bDIgEfAUyhm/xLM9fRUYtKIzhj29vuxnUt+xTY13rhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SI6yVmgB9dD/vy32uR6rTkxluA7nO8YtwsUVF2Jmdir+GFNr6FaoYnGY4woXLT8Bwk+XmQFqnYFzwrO0g1BuFyIsUVlGN/i8AwC9ybdE5dfKeUQuM1NcnBLs8DxRYxgbaq4XOyzDdy0Jzjk5M4ncSPT1CLJoBukhtDIfctsO3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PL7/PMfE; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d608060241so3345172eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724660963; x=1725265763; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FpK+LqnMiQxXocEL/iu9e4s+c/+RcNGhhFEbJWYlCI8=;
        b=PL7/PMfEiea3bK0ye4SfMVvHkYXGih0Gg7SD/SJ0wGTe4CsGdAZVyM77KHJZ85BeAk
         TRMNIeCSvjPt7yll1kYuXX7IcY9QIVYhrKJKxjak86+0lukdvUZHlDpd90RycIFMfTPM
         A1lDADqwlvn1Wpo/5ZjjOBNYhZ2BKBUpAgxKJpiZlkdsnpJ48xlX5T00QDRjyDRgsQks
         PkKEw6QFYrYYxuHIaOnCL3ArYqe5EyF+N/xrUr0bOhiEdu3xxcCoPC++lkHVMd13Xtx6
         urWqI9P76Ul9F3KxKV7WNby1//NY2vN23owH3tAFG9+CI9uYzJp2oeNP4Eio+K2aLueg
         UlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660963; x=1725265763;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpK+LqnMiQxXocEL/iu9e4s+c/+RcNGhhFEbJWYlCI8=;
        b=G5KZRPMbR0XwZaRC7X7GUtbSMK/DSphiyYRcugNMwnFbLGMurD8QMcGUrPOck0pT2T
         o7KFSjjcd7Fv9EwqWlTniaR1Wxd8vr+wxVmBvWrRkSulYrG5I/ltRiewXICogZRoniP3
         fG70MiNtkguUdvhHp29/RKLM7XM1rEk6c/aShN2Ti2idlVdi3bCQQCB2rbqvII6ypO31
         pAKcNKFFCmgR15xT9XjS2uYVdPGPe6p/H760JpAb0DV3SEkZzbDcZ6W2nZ6zDaa1Twca
         wPp3W67UtGjF3ytJtRRk9aZ6iN3Nhs/NECc7ZIBGycfTgOn4HcX851oq7fdDr7SdHJV9
         0X1A==
X-Forwarded-Encrypted: i=1; AJvYcCXl62T2p+BRhlj5+sWmckuhLCNJL8B/hqCauw11Z2UUf3741AUSy5E2fMwlDCO9By2p1Jyc8LNnIMBqlp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCSbqJGgN2kslVOs6CrBJTb5B5A8JOG3zmx4ixx51UPogSZQI7
	3UNZsHGUc47zIOnn6LfE5awa1p3V4h5+g/IXi503jMgioEU1dOwNGGJvH3aChQ==
X-Google-Smtp-Source: AGHT+IHa05pyR1/biT4DWNfV5Ah2XihLBGIqbFSdAq19mKgtaB+tYgagS2IxBtdEtRGiuKRf7P4I5Q==
X-Received: by 2002:a05:6820:81f:b0:5dc:9f42:d5ea with SMTP id 006d021491bc7-5dcc6221da7mr11016787eaf.3.1724660963541;
        Mon, 26 Aug 2024 01:29:23 -0700 (PDT)
Received: from thinkpad ([220.158.156.53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad7d5ddsm7175457a12.89.2024.08.26.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:29:23 -0700 (PDT)
Date: Mon, 26 Aug 2024 13:59:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: gregkh@linuxfoundation.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] bus: mhi: host: make mhi_bus_type const
Message-ID: <20240826082918.al7mt3v7rpfgazsv@thinkpad>
References: <20240823031129.49010-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823031129.49010-1-kunwu.chan@linux.dev>

On Fri, Aug 23, 2024 at 11:11:28AM +0800, Kunwu Chan wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Now that the driver core can properly handle constant struct bus_type,
> move the mhi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/init.c     | 2 +-
>  drivers/bus/mhi/host/internal.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index ce7d2e62c2f1..a9b1f8beee7b 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1464,7 +1464,7 @@ static int mhi_match(struct device *dev, const struct device_driver *drv)
>  	return 0;
>  };
>  
> -struct bus_type mhi_bus_type = {
> +const struct bus_type mhi_bus_type = {
>  	.name = "mhi",
>  	.dev_name = "mhi",
>  	.match = mhi_match,
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index aaad40a07f69..d057e877932e 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -9,7 +9,7 @@
>  
>  #include "../common.h"
>  
> -extern struct bus_type mhi_bus_type;
> +extern const struct bus_type mhi_bus_type;
>  
>  /* Host request register */
>  #define MHI_SOC_RESET_REQ_OFFSET			0xb0
> -- 
> 2.41.0
> 

-- 
மணிவண்ணன் சதாசிவம்

