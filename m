Return-Path: <linux-kernel+bounces-335160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75897E209
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 16:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEA1F21191
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B56B664;
	Sun, 22 Sep 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiQGZvey"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07AB652
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016313; cv=none; b=Q1+8RMGf9ufOkiHWM/4CxxQV34zNIlcOSkVUrPGBCigt60cBzubsoo++rnb4/IKarQptxOXxHmFlOgc2umS1pJy2/DLCvkdYKMj/2MgkOvZZrXnyjNnbQmhHVdAzkQKbv2lDMbvxX5H0aYaejWLDn5ZzClc+9EncHueEITtwWtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016313; c=relaxed/simple;
	bh=qTJtz4q4tiQEXxOejgVzSH+mCIhF0R/oGPTLzEu30VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcPrpPMQRubvb9YaVHJ7CeisnerXwTPp5UebTAd46T36ZBzADaP7I5H4uUFN7MxvlQUXX1Ws4h5eLBHCglyxUH5BZJLr6/FYthuHqU8vZxSW6M5TEw1VEn/EvCs20uvXkl8SWSZSKIF55oGtC8AXrrrr/yQ8SlR94FhCXWpHaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qiQGZvey; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75f116d11so33366461fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727016310; x=1727621110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cFIWlQEpg4yYKfKEiN8b4f9CB/NTT5qfc3eckbpNis=;
        b=qiQGZveyKGB/x8lgt9dKMfOnBbREdsOcAzR9llBdX87k5yw+GhxxTjUjCmG144SjVS
         khf/BkcCyMQ5AsgJgEbj+KF82NfJ3r2opKlN07L8nCABXFZCULMDwq4rIqGtGIrSiIQM
         TQ0YDekCrjYnjt5CsQVch5ybUPssuOCc649ubPQEPD4DFedkpgoGHFMqDaYhr69e3Bn0
         9dWHDVH6rp6WWqM7MOL/5Wm7Tijh2vAog39IUigyFiRAX4IT0k9Wyx6c46XRag56AyXk
         +JvmkewQqswqxCtSVMje2h+k/gmNgV0gd3mxHG9bR7IePj2Hng2q+VNrZHIgn8+9sMvj
         a2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016310; x=1727621110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cFIWlQEpg4yYKfKEiN8b4f9CB/NTT5qfc3eckbpNis=;
        b=USzHkgDJUApFmjFV2MHuPIJ9cI7R9oUvO3ZkztzVusy9us8W9vcuDWQuIyieMQt8as
         bSpJCgIn1epLNtVUz3YUZrf+8dBFGte5gfAVAYUNUj+YiRIGWOhZ0Citj/MnZ4HXc/Sm
         M3RfjMM2wKTi8yHaeshu7dA5JVxsmXQ0a1BM3ZZ44dkVJux7rASrKJCZK+kegaywV593
         qHDlDoDIwc+zXnggD7sl5mupCmNi6FRRnFLliAn86lWQf61tJMi6xzI35wIAV1dv1U4s
         bMMiYRq095nvusbvS+cBv5u0CknBCxrVv4s3MN7EPphqGJ0zYMNv5GI7rHOUFMegJ+gp
         hUXg==
X-Forwarded-Encrypted: i=1; AJvYcCWuephox3GivEcs4x9fXHZTycwV56LvSbFzn094mT8Ql6otHrWUbrP0Cg1wi0fx5GxiIZ3xrJ3puCxjOUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3SjPEA384jZfFgY7EgmRm1dF+iXM7oyjx2Ttycg5OGw91DPh2
	Pn5FSoKxG+C3ZgQELpJLtNmGQKLy2HFBYcqsE6IKhojBFWhzbwLawJxezV8PF0A=
X-Google-Smtp-Source: AGHT+IEmba5pmwDH7Fqb5k5mkZ6dxxmrmN0NkbYXp4vrViTWJAciliMjfjOzKCRWA+B3H8aCpS0VFQ==
X-Received: by 2002:a05:6512:a91:b0:535:665f:cfc0 with SMTP id 2adb3069b0e04-536ac2f2c26mr4272329e87.32.1727016309699;
        Sun, 22 Sep 2024 07:45:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870b8ccbsm2986578e87.279.2024.09.22.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:45:09 -0700 (PDT)
Date: Sun, 22 Sep 2024 17:45:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dianders@chromium.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: elida-kd35t133: transition to mipi_dsi
 wrapped functions
Message-ID: <pqzvhnrvtb4r3olxkkx2kyhsms3y3cki7cow52au3bug2hqzc6@h7wxgyruzd6n>
References: <20240917071710.1254520-1-tejasvipin76@gmail.com>
 <c3wv3r44cmua2hphyjqzb7pp2a32pvs6svcj6s2zohp77qn3cr@4iica7j5bx5l>
 <d470e0ef-0193-478c-a858-d6498758aa9a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d470e0ef-0193-478c-a858-d6498758aa9a@gmail.com>

On Sun, Sep 22, 2024 at 11:49:49AM GMT, Tejas Vipin wrote:
> 
> 
> On 9/20/24 9:59 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 17, 2024 at 12:47:10PM GMT, Tejas Vipin wrote:
> >> Changes the elida-kd35t133 panel to use multi style functions for
> >> improved error handling.
> >>
> >> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >> ---
> >>  drivers/gpu/drm/panel/panel-elida-kd35t133.c | 107 ++++++++-----------
> >>  1 file changed, 45 insertions(+), 62 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> >> index 00791ea81e90..62abda9559e7 100644
> >> --- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> >> +++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
> >> @@ -135,25 +127,16 @@ static int kd35t133_prepare(struct drm_panel *panel)
> >>  
> >>  	msleep(20);
> >>  
> >> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> >> -	if (ret < 0) {
> >> -		dev_err(ctx->dev, "Failed to exit sleep mode: %d\n", ret);
> >> -		goto disable_iovcc;
> >> -	}
> >> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> >> +	mipi_dsi_msleep(&dsi_ctx, 250);
> >>  
> >> -	msleep(250);
> >> +	kd35t133_init_sequence(&dsi_ctx);
> >> +	if (!dsi_ctx.accum_err)
> >> +		dev_dbg(ctx->dev, "Panel init sequence done\n");
> >>  
> >> -	ret = kd35t133_init_sequence(ctx);
> >> -	if (ret < 0) {
> >> -		dev_err(ctx->dev, "Panel init sequence failed: %d\n", ret);
> >> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> >> +	if (dsi_ctx.accum_err)
> >>  		goto disable_iovcc;
> >> -	}
> > 
> > Move this after the last mipi_dsi_msleep(), merge with the error
> > handling.
> > 
> >> -
> >> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> >> -	if (ret < 0) {
> >> -		dev_err(ctx->dev, "Failed to set display on: %d\n", ret);
> >> -		goto disable_iovcc;
> >> -	}
> >>  
> >>  	msleep(50);
> > 
> > mipi_dsi_msleep()
> 
> Is this necessary though? Converting this msleep to mipi_dsi_msleep and
> moving the previous dsi_ctx.accum_err check to below this seems
> redundant. If the check is placed above msleep, then we need to only
> check for the error once. If its placed below mipi_dsi_msleep, we end up
> checking for the error twice (once as written in the code, once in the
> code generated by the macro) which is unnecessary.

Yes, uniformity. And the compiler will most likely optimize things away.

> 
> -- 
> Tejas Vipin

-- 
With best wishes
Dmitry

