Return-Path: <linux-kernel+bounces-415624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE809D3914
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05A2B29B76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D481A7265;
	Wed, 20 Nov 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TZZy37Gr"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111EE1A76B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100558; cv=none; b=KjGerITtd+r/wujZSM5zPJVpOJrVvNOCWKb13+5QKEKcB7qdu+GEP1aGI53rzyhc5XTr99+46B5AKMdkqHpTEypa5KIrdy6YL21CGE4w+DRgaRMgn34XRauwTXNu9crSZolrgL2B3SbDTrbmVMrcHdRsEmkeFUAGLTi/BPVJhOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100558; c=relaxed/simple;
	bh=zeRJrbbWDExW4KbfV8yDdwcoYd/3egm/qiRgnU8jK4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBIuiGEhJQF4LG6P7EFIVBPAHzS81zbICc5hT/Uw5TgUDa1Go4Y6dSjx1ntfh3Rk7aksIW6qdRlgBYJDoF9utDLWJeoSYo/exxJz342vkq8w/HBLZ/42+owR/5754FP9jhar3rlAmHVvUkQRRm1WYBvhhhqqumxRisRHW1tfeZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TZZy37Gr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so5022837e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732100555; x=1732705355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5zgbWAlYfYCr8Nk6Jg9k5X2+R3v6k9oDP6EluhSmbg=;
        b=TZZy37Grx98ttt4l66+SPVJOoobCGxeM/M4tvkRscLlenkccuB1dj/fnpq081NEvya
         bzKqISROu3oD2VuD953fKb0WlKnFMl8LjOMHJYZzZuqexvo6D5FPThYi7ZuOODWFcnk6
         5W7/YBwO7rFXyOlRQ8EL/I8PR0NCYZLXxf8lVU+w95gXuotgDMQDbOeUGKHi8kOR2X0K
         bbCZNqVgrW1T5bYtecbTkzEmCt3vwJY58ZixdKJ3xEMBKsjwwbHfFvW2UOO/+V0CbBo/
         Ll4wURzbd1GZDytaPhjh5LUBHNQssLV48SV+yli6xxNd3Phi0VMd4Vmf1bVlv2NAwJLP
         wtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732100555; x=1732705355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5zgbWAlYfYCr8Nk6Jg9k5X2+R3v6k9oDP6EluhSmbg=;
        b=c2IGZqBkabD2DKeWSaOANC2Y/g6gxyGP0O5L9iEmffdo6WhsybJR9o6g/U11wRMgub
         enpHmRSlXxzLZ8+2xg7/r5yQkbbmx9eQNQxxveDzNe4egilg/uIWBcllp918Hzf0GL1M
         OuQQVnn0Ss6f9gGjUIolPjGveD1fFzV3xs6EKSkL7AAOACikcdpJZ+prkkkwQPpND1aM
         qTLguMCxILE/dzWPGF0LYm3Nqkbkha7UPzR86Fx1L7wIZDT39UEjVKlHI9m1Satlvj6b
         k0Q7Z3Fgwm/J482IsNpTa00tipYCMDIK/DCF692OzbFbuOr9PWgMiMHgTJCdn4+JeBTP
         TnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX20KxTD1tqXazJY2Eyofj1v21n1rhcGVTpxDCWxZzqzSSvizb6V5chOUSXLSIUWUn6Iw17H9QaonxRbaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhY7HXkYgk/shBtIvZ53sR+635/qXC+bZHL2o5O95ZkdynxtfG
	rdgzhxv47CstVCwBQL2BpTZLjY9i4XuEYle8XSCGQFv9OShLXc+3a9bZtwhg5zs=
X-Google-Smtp-Source: AGHT+IHKWiTrRrCzYnYM6d7Ym7wDAknR4wn2POzDwbTPgBhBhzfbphYglKnHr9g6u4D92E9megUh/Q==
X-Received: by 2002:a05:6512:3d19:b0:53d:a86a:6b2b with SMTP id 2adb3069b0e04-53dc136a95emr1101614e87.35.1732100555170;
        Wed, 20 Nov 2024 03:02:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbf09664esm394046e87.162.2024.11.20.03.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:02:34 -0800 (PST)
Date: Wed, 20 Nov 2024 13:02:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, 
	linux-arm-msm@vger.kernel.org, sean@poorly.run, marijn.suijten@somainline.org, 
	airlied@gmail.com, simona@ffwll.ch, quic_bjorande@quicinc.com, 
	quic_parellan@quicinc.com, quic_khsieh@quicinc.com, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH drm-next] drm/msm/dp: Fix potential division by zero issue
Message-ID: <piembwzz7x6plsps3umjg3b3pi2ii44svmeii3wwtydtriceny@uqq7ck2ge5zz>
References: <20241120050451.100957-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120050451.100957-1-dheeraj.linuxdev@gmail.com>

On Wed, Nov 20, 2024 at 10:34:51AM +0530, Dheeraj Reddy Jonnalagadda wrote:
> The variable pixel_div can remain zero due to an invalid rate input,

No, it can not. Rate is set by the driver, which knowns which rates are
supported. 

> leading to a potential division by zero issue. This patch fixes it and
> the function now logs an error and returns early.

See Documentation/process/submitting-patches.rst, look for "This patch"
string.

> 
> Additionally, this patch resolves trailing whitespace issues detected
> by checkpatch.pl in the same file.

Additionally perform ... => separate commits.

> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index b4c8856fb25d..e170f70f1d42 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -225,7 +225,7 @@ int msm_dp_catalog_aux_clear_hw_interrupts(struct msm_dp_catalog *msm_dp_catalog
>   * This function reset AUX controller
>   *
>   * NOTE: reset AUX controller will also clear any pending HPD related interrupts
> - * 
> + *
>   */
>  void msm_dp_catalog_aux_reset(struct msm_dp_catalog *msm_dp_catalog)
>  {
> @@ -487,8 +487,10 @@ void msm_dp_catalog_ctrl_config_msa(struct msm_dp_catalog *msm_dp_catalog,
>  		pixel_div = 2;
>  	else if (rate == link_rate_hbr2)
>  		pixel_div = 4;
> -	else
> +	else {
>  		DRM_ERROR("Invalid pixel mux divider\n");
> +		return;
> +	}
>  
>  	dispcc_input_rate = (rate * 10) / pixel_div;
>  
> @@ -579,7 +581,7 @@ u32 msm_dp_catalog_hw_revision(const struct msm_dp_catalog *msm_dp_catalog)
>   * This function reset the DP controller
>   *
>   * NOTE: reset DP controller will also clear any pending HPD related interrupts
> - * 
> + *
>   */
>  void msm_dp_catalog_ctrl_reset(struct msm_dp_catalog *msm_dp_catalog)
>  {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

