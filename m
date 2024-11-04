Return-Path: <linux-kernel+bounces-394587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12159BB180
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1171C21439
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC51B21A4;
	Mon,  4 Nov 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AU5V7fnL"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61418C009
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717401; cv=none; b=dKkVegPhXe635UzTGOfoX0jfvw6UNrDEGXWWoJ8YFeG85NZefRfb6K7tXF/nqegZk3X8PCXY1LETu88efqLvXaHbGRDk6QB0zxDwhg2UeeFHPUM+DLeTW0I/Rh1imsi9K8kwXIBaTQwm65GMNTqUGpmdEatbqSPWcWYckwPkBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717401; c=relaxed/simple;
	bh=HjiluiYYU8ct9uzPa/9+3mrpL1aTF+xLCA8ImAoVnW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctmqbHOwkGMpyFxYAYel+QzvskVAY+E6Nemp5xwGzxelFFFeOojseE7hmmyYdKn5BCSgpwD6V/f6fJxqcJ+3OAQgbWG+0N4LJh/gXldsU9JYNV30QjRnAXQ1kAe2VcMdyzRS8jspoziDsmKpSOKuzDdxzXFh5+3wondYpRR8/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AU5V7fnL; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso37060521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730717398; x=1731322198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeXQFy9Pj3a/4ODUXYJdySuoRgQr+QO7RlBYiaBrsZk=;
        b=AU5V7fnLPInUAccZmsYThZC/FIOOhHmW3PGKooWGVc9ogmaLvR0mCiFk64r6C9nLPh
         Fj0qV/ce132viVbNlqCheppIVYzRvsUTbLXzqoRxF4ISNpudn9vMefX9sNWoN8zSHakA
         gHzkfG5N8dR6JweS6kUqa+Y6Pksb/YkY4BPiQytYtUFEvtNNvCANe5pqoWoLw47H6YXJ
         /MJkWyRBxgaFp291ARQ62hRJxspi8XT2IAfIAmfmNMzr5JW+cdKltHBGK07vkB4uOKqm
         jlobwEJiLmCifTwuyXvRzDFgZ7kluOZWRefQIYkIBEB5NJt1uqljnKZQDaCXAmgrmLMo
         pS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730717398; x=1731322198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeXQFy9Pj3a/4ODUXYJdySuoRgQr+QO7RlBYiaBrsZk=;
        b=tb7+Ay9srfNKms8shb4WvbGtPwmy49yWZt9T2zCWuMBASmkRxiHEX83DCrZToTzNh2
         vxR3M+JiEsTq+P3wlEZDqM3T7gm61R9Do0a7D1osdst9i6V8VxkIPqDNVNev/ZpEpukc
         ZNVqNW4zbGOKHt3R462mvRMhW/DNW1ZVXurDo7HoOQbCA7nQAnqpcTUY5LnziUc50PgC
         swYaarP7zZRto0igdxnYDAuzPqbUv1nzehmEelueLIAU7N4Qi7qhkb0RHojQJwiQmSF0
         CCb40kjON3XFylJ2jmeDnUXdvIzV89HQkqjF9PW2HpX1hNrF/Cn7HP/kRnUGzsAjn5v8
         BVTw==
X-Forwarded-Encrypted: i=1; AJvYcCX9Qjl5AKfNz7TPU39iD9G825hmFBWSqIiEuQHFbdObYkxILrNMGZVIy/+s0sC68F1If7VfQnzPWlqKrak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqv7qEWuF6l+0FK9n26duIZP15bFNVV0ibU3qr4ElSCFN1vK0H
	B0akZcMoX2cuNSQoi7AH/LS6D8p/3HevxP1ooceUtzDvxEXySFvc7eBJVp7oVu0=
X-Google-Smtp-Source: AGHT+IFkB+YOxqygY78jfvdT7ykV+NKLizBcQos+MO01VyMRIJ9LTRYILzClrQ7HWeqYmtT14mH4Sw==
X-Received: by 2002:a2e:1302:0:b0:2fb:5723:c9ea with SMTP id 38308e7fff4ca-2fd059d336amr70161111fa.30.1730717397626;
        Mon, 04 Nov 2024 02:49:57 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef3b732bsm16206121fa.4.2024.11.04.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:49:56 -0800 (PST)
Date: Mon, 4 Nov 2024 12:49:54 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_nguyenb@quicinc.com, 
	quic_rampraka@quicinc.com, quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_narepall@quicinc.com, kernel@quicinc.com
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
Message-ID: <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq>
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104060722.10642-1-quic_sartgarg@quicinc.com>

On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> This enables runtime PM for eMMC/SD card.

Could you please mention, which platforms were tested with this patch?
Note, upstream kernel supports a lot of platforms, including MSM8974, I
think the oldest one, which uses SDHCI.

> 
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..6657f7db1b8e 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2626,6 +2626,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  		goto clk_disable;
>  	}
>  
> +	msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>  
>  	/* Set the timeout value to max possible */
> -- 
> 2.17.1
> 

-- 
With best wishes
Dmitry

