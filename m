Return-Path: <linux-kernel+bounces-423016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D850F9DA14A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0F92844C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984113B293;
	Wed, 27 Nov 2024 04:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypQEskSa"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA8C1805A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680042; cv=none; b=E3jFFHm7jEcVSvhEclmXbKBioOx6g5Oc84IMqFxkJlxJcWkWFXYvRH3NqyAhmo39tf3QvNsimZlXj9Lcim/izlpgwlAPxM60iaDaCGLfaMkc2lo6F2Nhl2tIHsuyAHDodQVttlQkph2pBOOhs9D5MTfKtL89czN5xggS7pkfU9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680042; c=relaxed/simple;
	bh=HmL5KghJhyA1NHfNg2xF4U1baArdo1wSpfGkfHDUK8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F78Durdp65V+6jJtSBBxMxO8SK7/LUPScqLerUmcjHwXtbUZ+nYVIeY+8/745ELvhYIC7imwy5FFecRBP5Y2tG0o2tOytSrO8uRFkTEkAXrfsRemzBx2jmwtAIBJm8rS1Krd3AJtC/0M8w4/jBrLgejIwX+wEQm35TYcD8o3xvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ypQEskSa; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd9e853ccso4351187e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 20:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732680038; x=1733284838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvYaGtKoOy0NaIKR2w9foJlILqskaLFgzQORKPCUl0k=;
        b=ypQEskSanMKrjKGW+ixrojbbc+vVCzBWsMpVL9nTjtGn0gSHwPPaavt4VHF20ZmSwX
         IbTmSLkhVs6yLZjQNzZMLmoIfazgBalrwYORLw3PaBV8G8ycTYpdhcQ+fj420ZQVDtaU
         gtNayyC8GZtMAO9MsSbffhU9WKvNiq4fp8WSCszq3vqHZnN2m7XzeBm0XsANRG/RKtJW
         308N3TCiFYqer2ZLFB2GT7wxnSoNhc8fy+g3h6Aw42zA59SLgY6f1NL96eEi9mf1xD/t
         d5WmTxZ7dC+u+ushXiWlYNc/bIxxr2ernOD42FKPAr4PHpFPPuWBg0+HjyNT2UuL2DkU
         7Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732680038; x=1733284838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvYaGtKoOy0NaIKR2w9foJlILqskaLFgzQORKPCUl0k=;
        b=RwpGpnxawNzvFwHM2EjvNA+fDC643FBRXdDhA4T6B/ipBCFTeDTqID7c7kBdf/Lbnv
         IWQk8QjX4/iBkFgDrLiwAYXPi3n5sK9kxWXwVgJBLf/L61dazuGjO+79lEe3ZxkUAPCr
         w1PaYe39SC0K5Ufytcl1Dfys1sqc2ETNtdXtoTe1esbDd1h2DHDc50LVTx71Y+8Xp2xk
         jqrgSLAf71wpxDAET3NzRwtUfLt7gRGrUMwC9y9kFGTSoE3fidRYSTUiUbjenar8T6yi
         jEu6T61Fcnac5OY1VS4Fk3GoyhfFBofLrm8H4gQNNUNI0yg1+2IRfCNx13iHC3pSAZUe
         uSCg==
X-Forwarded-Encrypted: i=1; AJvYcCUkDhUzjV7270/J92E+zEmF7tvwOCIODipl0Au3eMvEZywQ1VY/5dEmO4WAVLJnAgTasbhf6zPI7BtLLlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCqFqA9rjYw72LF7urTZyOIJhoaFmoxFkhLPJ1ZBtEB4kMkbL
	CtizRnkn+25NN9V+kELFxsG57r2Ymbp5bxBSwArnGF0aOdkQmb+V4tXcV+fP2JI=
X-Gm-Gg: ASbGncvglFGJ3RtFh9WNQnbv4qLLp2r+qucY5dTlqXIgT7AoWlREThiyJXgkcE0E7w8
	rW+J+2Cn01W72QCFMhNBWEKDFMbf9ETPFVm+ar8I2raLO/Cz/L8Se5PnPie2yK7aVZ5tfT1o63p
	cKUwxRvRM0PxY2TcXOjqokmE+C3i0RQ7olGKvgbfiiE1cvnNndzt67uwf3RN1qqGmGgaqB96ug0
	COIf3JFAYgrtBWgzN/pOXk5XMUtP3/VnAo6rgs1Rlnc5ly1ffdkZ5KL2qXCY2x+LLfQ2hfjfx08
	VxMDZLRyLe1s/5C1WEzl7QE4usKqTA==
X-Google-Smtp-Source: AGHT+IFe46Ut3ixzrDaftB+74Cb5uVfPJwBiur6xDbxeHzU02v/b8vYaE19Gaapdwhhc1BJVVfN3HQ==
X-Received: by 2002:a05:6512:b15:b0:53d:ed4e:e5af with SMTP id 2adb3069b0e04-53df00dce8amr636846e87.33.1732680037797;
        Tue, 26 Nov 2024 20:00:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd88b54cbsm1914492e87.214.2024.11.26.20.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:00:36 -0800 (PST)
Date: Wed, 27 Nov 2024 06:00:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
Subject: Re: [PATCH v1] mmc: sdhci-msm: Enable aggressive PM
Message-ID: <zrqcbghhhpmr2dknipkmqxcxcxnlqr4ury4haqq4n6xja5lc7p@6gh56cndcwjl>
References: <20241127031708.2343727-1-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127031708.2343727-1-quic_yuanjiey@quicinc.com>

On Wed, Nov 27, 2024 at 11:17:08AM +0800, Yuanjie Yang wrote:
> The sdhci-msm driver supports the device in both RUNNING
> and IDLE states, when eMMC/SD are not reading or writing,
> eMMC/SD are in IDLE state, the power management module
> will suspend the device(power off and reduce frequency,
> etc.), putting the device into a low-power mode. But the
> current sdhci-msm driver cannot put device enter into
> low-power mode.
> 
> Enable aggressive PM capability to support runtime PM
> functionality, allowing the eMMC/SD card to enter
> lowe-power mode.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>

What is the difference to [1] ?

[1] https://lore.kernel.org/linux-arm-msm/20241104060722.10642-1-quic_sartgarg@quicinc.com

> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..e3444d223513 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2627,6 +2627,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	}
>  
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
> +	msm_host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>  
>  	/* Set the timeout value to max possible */
>  	host->max_timeout_count = 0xF;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

