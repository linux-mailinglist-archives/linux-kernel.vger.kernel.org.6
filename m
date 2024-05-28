Return-Path: <linux-kernel+bounces-191583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF18D111E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE95282775
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923C8827;
	Tue, 28 May 2024 00:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sT+dIfpk"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B089450
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857295; cv=none; b=WALfQ2G7v1P/V9CPhLTAo8ZVqepfmwVCco+ptqtKgNvIDDtSz/Oj8eZGJnJhuPvLxDX6vZ7gHF7MYkWXDlq2pN7g0pm2fERN2Vf1LvMB24OE6Xn4tHcOnZVLso6SDxyGgB5jVwvjZI0Fqn2XZyiff8BQzuDakzP9GZye1ztIFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857295; c=relaxed/simple;
	bh=E+TWwbyaezMS8lLMs4qhN+D2M29eXck/QfaU7vDKmb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPLM5OEkqdYLhz05lhjNxpIGYsp6rhPsC78v1sY60ANfnc7KFX8mfqv19bE9p+2qy66BAj5EA8eM7tRJUS+qpznVFueN/weRcXqLc/QvqyCIq2X16VMV90IwKG2/WslcaBk/m8McwRwtbGI3o8CvyhWiUoCpmx91Ge3h0xDPyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sT+dIfpk; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52962423ed8so316593e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716857292; x=1717462092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypB2D9Bb+O5VK4pY/eZpWiPU4q5dgpNVinp1IWPeDkY=;
        b=sT+dIfpkP3DPun8TiJbTomdHgNuIg9YzPO7+m9PdVxrLO+zlxbmbr3uvStN98qL2lQ
         5IxnR4HL/Tqei4V9+4vDKWNLDoUjB13NAs95v/pRG9iidz2rZjfSWBM2An8VNKjm8WKX
         3K0DmLq6dzCHahVJoTlDc7ZmRwusljbYKMcj5uZYE5hikvZ+PZft5ipdyC66LBRx7HFD
         TSvfHnqJPyr5Fof2+YSpRX9gTCTPKHE/5u1zm1qywOihp//xtBr6ebiznDshHWZx7fKs
         E88TP+LxqVTDuEdQUkGxvEePyEewTXTSB/2n7U4yBzANX5Y+OJD7D+q3o43qTnuwGceE
         GByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857292; x=1717462092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypB2D9Bb+O5VK4pY/eZpWiPU4q5dgpNVinp1IWPeDkY=;
        b=MnHf2X3CArM82ZGQStTY2MiwVUxmUeGr5MwjHlBV4YO9P2dYabvc9sTguW3VpjC4BR
         mc+h4lMB00IRRZEyyJ/o2u2BXwXcJXO3xmhv1jdWHcKrpsMsiYRdoqxxZqQ2/kQFiMks
         7focfeNHxPaXEMWD4eK1ojzhJWlZcX9An0RSir6AG0PLLIkq8H+32LPsx3JtUzkesruS
         TDlash/ZmeSn01JdzFRrzZmM2NUKYyJcio7wI5fmBBJVehjvoNqkp+9A4iXkwo9ougwa
         uq7X5ZGNHKh7RZJcXMFoTq4gblyDko5/jXK+EqxvFO1bWECY5MHWxyC0/Usky0OzZ+UN
         JzyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrrPS1bpan8qlciWRwIwAH9P9TsGHtnVHr0OoRkm87pb0zIqO6GkVycM3e3hjnPxqqCEEXJ+3chG2BYJiDIwqdDLEViekrCnnE2wO2
X-Gm-Message-State: AOJu0YxFmsHkdzaOgyblKxmrTWC+u/bD+m0fqaDq2vCeZdUitdMpMdlr
	M5+nuc+Y8rV4US5kv0/GO8sxQw6RNCjb1oihWrOAaR/F0JOpor3iuAzkB/96Wlg=
X-Google-Smtp-Source: AGHT+IEVie+TQv3jITNYhblOTW1JouMd65as19e2NeHTBjHaj+9QaGA8P0Iw3XMZQXdTAy8/gfB5ig==
X-Received: by 2002:a05:6512:45c:b0:51b:fc6c:cbf6 with SMTP id 2adb3069b0e04-52964baf307mr6988063e87.16.1716857291477;
        Mon, 27 May 2024 17:48:11 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296e887a77sm811073e87.58.2024.05.27.17.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:48:11 -0700 (PDT)
Date: Tue, 28 May 2024 03:48:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] drm/msm/dpu: adjust data width for widen bus case
Message-ID: <57sr3ssi6nwermdqtnb2ackmu4tlxs4gcslvp4v6ndafnvbqhb@4npuqfpkzzan>
References: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
 <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-2-f797ffba4682@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-2-f797ffba4682@linaro.org>

On Mon, May 27, 2024 at 10:21:48PM +0800, Jun Nie wrote:
> data is valid for only half the active window if widebus
> is enabled
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> index 225c1c7768ff..f97221423249 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c
> @@ -168,6 +168,15 @@ static void dpu_hw_intf_setup_timing_engine(struct dpu_hw_intf *intf,
>  
>  	data_width = p->width;
>  
> +	/*
> +	 * If widebus is enabled, data is valid for only half the active window
> +	 * since the data rate is doubled in this mode. But for the compression
> +	 * mode in DP case, the p->width is already adjusted in
> +	 * drm_mode_to_intf_timing_params()

Is there any reason for divergence here?

> +	 */
> +	if (p->wide_bus_en && !dp_intf)
> +		data_width = p->width >> 1;
> +
>  	hsync_data_start_x = hsync_start_x;
>  	hsync_data_end_x =  hsync_start_x + data_width - 1;
>  
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

