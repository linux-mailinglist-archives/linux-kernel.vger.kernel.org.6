Return-Path: <linux-kernel+bounces-192244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CC48D1A91
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF9E1F23433
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974616D304;
	Tue, 28 May 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xnNFsIZ7"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23713A242
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897847; cv=none; b=CjZkFelwHzcGXJraaAMPV9FMzSzGvCe89IcJUeFHcGnHFt1JWKLg3rk8+0nGty73/qTJXQ2TQJSWHharY+CIpZrEbpNstGJz6lKLIQEriOkVDOuJHGG7pgKFf0gX0dZq5OuI+6l8meQ762M+MXaSfQd9CJDC9fYEigk05EpNnNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897847; c=relaxed/simple;
	bh=q3xcEnSCzTxOpnxHjCPbRxvyz5hqZkV9gtP/m7XxSj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Olatzhdn52aV5yEBdk2f1zFxkHFSq0RUCbRAcey7MqSBwjU7W6SwfOqIoAHKuxfwe7v/OWhwcb0OoZBMHdBeJ9WiEF9cjajy51/J6mM4RL3TNK7fZq/odcTcvWuOVHQKqyAdsbb/kM83T0vPXZR2+kpXfnsA+0AGGaQEJqMHuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xnNFsIZ7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5295ae273c8so932372e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716897842; x=1717502642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHi9w6FG5Fw6jijfWojZg174+p0kdLabsmz91GyjomE=;
        b=xnNFsIZ76xOCuYXpci1DK86L4reBdsd1jsaPtceXtdq5aNSbcHdJqJtlKm82BgqN0R
         w6s6nH6OhfQoUIJL6GeXIW+KHb95TUot/TqAg/1OaH7rH1XLSqMtJoE7yGGz2nCydSup
         CbROBTiDU/Rf49Xv/5u1BICy9Tnva96DXI8d0WO8jFXGGWBRsQnfjFR3HuJPz7pfSulP
         iaWFEPISYagFRhMHj8uUZBFbSGK8xshMsLMZygNLiBvBeiJQvSe1se81TPylIc1ZChzA
         V7UWqtXFDHU/tctaisuibf3yM10Ed3MzZesAtMb0JYLY9dRno+qj84J2eHLsn0ZOMCAL
         16bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897842; x=1717502642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHi9w6FG5Fw6jijfWojZg174+p0kdLabsmz91GyjomE=;
        b=OGszjRcnHZc9E3OTuEvKKelo/0N7QJCoLvs7luMQDpCROxeFtisfTMO7IfQ/LsrK/S
         jyBhL9PDqkqB7lNnbpJzeLqmYok5+frJBualnapoyFojvrjhh4RXr8mEqz4XjCw2wwbz
         T+SzrOYbOevHJPoUDGdIo8SsT6ndyZ62wUyZeiEijTWHOMW/8f1GPTMWIV4cjvyPv4qw
         PQtuhRlnWBvtJHjPmWGZcc/yZ0kEMgkg+l5sqkrczgNcPu9ky1d6XyD+SmfykYESHSh9
         urK8D9wCT4bVVK5GZj695ucY3KxE6ktiZHYz3paHLaqmtYhwd93feB7hpQFFy+GBDo3I
         B0sg==
X-Forwarded-Encrypted: i=1; AJvYcCV3RowlByMZuYHOhTzpztjsmx8M2fZgOlXErxYc5CkVE8oYjvUSsxL5UHQ9naVeLR01yZTXvrVf4lfOVhhtUGQaAMsIuiw3+meBXKhE
X-Gm-Message-State: AOJu0YzVlg3av2DI33YYIZ6jsMf1YS3acGgOJtJ0thZQI1mZKvKe9SNw
	yamMxygifZMJI2DyW5u4gNImDDoBah/rx2yLIW8jv+L08azfH8jAWmYFsSD11hw=
X-Google-Smtp-Source: AGHT+IGqt/f/FvFPYlEe3xZdj1xWsnwojX0FoeCAKJsIlOqiBW/bvKHKecsY++phvOEVEEINHM5bQg==
X-Received: by 2002:a05:6512:3241:b0:51c:df1f:2edc with SMTP id 2adb3069b0e04-529644ebe8cmr6794937e87.2.1716897842586;
        Tue, 28 May 2024 05:04:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529715e57c1sm984579e87.286.2024.05.28.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:04:02 -0700 (PDT)
Date: Tue, 28 May 2024 15:04:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>
Subject: Re: [PATCH v2 2/8] misc: fastrpc: Fix DSP capabilities request
Message-ID: <ufrdx6dw43nhjn3q6vb7bf7qyugr3jpm3f2k4g7vhdk4vzq436@k753wixrhqc5>
References: <20240528112956.5979-1-quic_ekangupt@quicinc.com>
 <20240528112956.5979-3-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528112956.5979-3-quic_ekangupt@quicinc.com>

On Tue, May 28, 2024 at 04:59:48PM +0530, Ekansh Gupta wrote:
> Incorrect remote arguments are getting passed when requesting for
> capabilities from DSP. Also there is no requirement to update the
> PD type as it might cause problems for any PD other than user PD.
> In addition to this, the collected capability information is not
> getting copied properly to user. Add changes to address these
> problems and get correct DSP capabilities.

One commit per fix, please.

> 
> Also, DSP capabilities request is sending bad size to utilities skel
> call which is resulting in memory corruption. Pass proper size to
> avoid the corruption.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 4028cb96bcf2..3e1ab58038ed 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1695,14 +1695,14 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
>  
>  	/* Capability filled in userspace */
>  	dsp_attr_buf[0] = 0;
> +	dsp_attr_buf_len -= 1;
>  
>  	args[0].ptr = (u64)(uintptr_t)&dsp_attr_buf_len;
>  	args[0].length = sizeof(dsp_attr_buf_len);
>  	args[0].fd = -1;
>  	args[1].ptr = (u64)(uintptr_t)&dsp_attr_buf[1];
> -	args[1].length = dsp_attr_buf_len;
> +	args[1].length = dsp_attr_buf_len * sizeof(uint32_t);
>  	args[1].fd = -1;
> -	fl->pd = USER_PD;
>  
>  	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
>  				       FASTRPC_SCALARS(0, 1, 1), args);
> @@ -1730,7 +1730,7 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
>  	if (!dsp_attributes)
>  		return -ENOMEM;
>  
> -	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES_LEN);
> +	err = fastrpc_get_info_from_dsp(fl, dsp_attributes, FASTRPC_MAX_DSP_ATTRIBUTES);
>  	if (err == DSP_UNSUPPORTED_API) {
>  		dev_info(&cctx->rpdev->dev,
>  			 "Warning: DSP capabilities not supported on domain: %d\n", domain);
> @@ -1783,7 +1783,7 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
>  	if (err)
>  		return err;
>  
> -	if (copy_to_user(argp, &cap.capability, sizeof(cap.capability)))
> +	if (copy_to_user(argp, &cap, sizeof(cap)))
>  		return -EFAULT;
>  
>  	return 0;
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry

