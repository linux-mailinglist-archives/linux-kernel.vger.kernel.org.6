Return-Path: <linux-kernel+bounces-337781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6B6984ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BEF1C20E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 23:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E84101DE;
	Tue, 24 Sep 2024 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U+TEElGM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C84B13CABC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220013; cv=none; b=TfrkOcSRjQ9DWtb1jY2jxGvFEAeWvcgem0lLSLQqJYaQzwvrm/Gl5UBhMDV0MfFqnzNmPBNahKOKXOf9UKXJfV3aN3Ek1uiskgKRhQehy8MrM3oUHGu43OpSloc+PwC4GACKUA8tdt2opEPYTpYS5MV8X40IlEp+GFEPkhQjJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220013; c=relaxed/simple;
	bh=jDRKd8Gu0pz+g22lBEWP4fpTida+PtY/5wubEmvBJYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayL7Zevp89raDniZel/64xtxiOvNEf/C/RoIV5rpOVTPoEIOcoFhhOv0qCoHKh7ambfcwW0D3fNM8sg+MZYl+IfPVLXb489aoDqmzujOwe5P0/D1714Jd/WW7iG3m5zk3lVscbyT3saOg94Sq8yaJ6Zml3lrVQXXwmHmKNFzt8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U+TEElGM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-537a2a2c74fso353406e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727220010; x=1727824810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+9Q0LCSmj1StAdxRtnVSzUh3z21xwQ3KgCZoUWxL08=;
        b=U+TEElGMKgea8OuCm2wdUUDiHK6OoiFXuRFTi5XeMeqF4PYCqTMDmLI1sTTQrnVsK7
         sld+4ANmTAgqOFs2KIS9fB0ZGaikBgatbnUuPZE+hqPtOvj4xKNpOe5WZ2e6G1H96ajj
         ZJi5lKNE+wV36WIxTGt9YlI3kMFu+lgdks+9BdHYF26LrlmtGuh5NZu7WQ1xwrjMYKA9
         X1+s4yJ8lgvmjm4qud8LFZ87Pp2nNhULuXjzznqY4NWsmVKJ0h0zTwYYEfFGVF3rdB9A
         Za9R1zFENHqKFgMuVX/rDxFUdMzt/X1HUTDc4Lfu+dpitIUjLvJEovak0WAo8DcEujug
         qzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727220010; x=1727824810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+9Q0LCSmj1StAdxRtnVSzUh3z21xwQ3KgCZoUWxL08=;
        b=uAczBjUMjEnVfBoI0GU1DvKVv3joNjJTjHuS8NDxOu9ggA2sBx9zJH4cIM3zIs5zbq
         eJDyTtpRCjfHKOhhwkCrpVrMJksKw1H4UFttrIRUltyczEYLg/IxYeoCSe4pjagxplwk
         RykX31shrID3PysIoOXwB8aOznEPAEIuyvlUI3AC0W0OE/bTtdkDRTbORznnulflAUBE
         7FbVEjse8FO1DbC3MFgZA7YkI6inToBPqFWHNnhcHCO+tarEpqvZBQgfhW0/p42lDT9X
         sPknCP/piZXJTt7r9sHbDTXaXRl1OZLtcn2232tBmAyRFdG/uT84vSssYL5XH3dV3RvV
         jqUA==
X-Forwarded-Encrypted: i=1; AJvYcCU8dYIUafCAOJpah0XQkNfpWO2tVtFtpwZMWpsPcBDLqbABxOSRp/f8c30rHmkAFA9n3yBNNVJLMMvficE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVHkoFn/KdT7oZ+vyfX3rALXF2sBgR/29Z4FUedZd0IYo4JEO
	n9rBiluxnAZ4V55p9KHzodfin8jhJUhmePp8TVi+pKRr8ry6rbjmv2LGsi/WvLE=
X-Google-Smtp-Source: AGHT+IHNEesArxRsedPKolCUJ0834tDf/cKwPSCRQFnIoTfWUbuiW4cAQGCbnGv9EclRDd5JIX7ADg==
X-Received: by 2002:a05:6512:1313:b0:533:4517:5363 with SMTP id 2adb3069b0e04-537a6912cc8mr1914198e87.21.1727220010044;
        Tue, 24 Sep 2024 16:20:10 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e0612sm354765e87.20.2024.09.24.16.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 16:20:08 -0700 (PDT)
Date: Wed, 25 Sep 2024 02:20:06 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v2 11/22] drm/msm/dpu: add CWB support to dpu_hw_wb
Message-ID: <yfpakq6o3zw6e3kf2d2x465d3et2cueaidnfxidb2uwutjromk@q6h6kdz7ooev>
References: <20240924-concurrent-wb-v2-0-7849f900e863@quicinc.com>
 <20240924-concurrent-wb-v2-11-7849f900e863@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924-concurrent-wb-v2-11-7849f900e863@quicinc.com>

On Tue, Sep 24, 2024 at 03:59:27PM GMT, Jessica Zhang wrote:
> From: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> 
> Adjust the WB_MUX configuration to account for using dedicated CWB
> pingpong blocks.
> 
> Signed-off-by: Esha Bharadwaj <quic_ebharadw@quicinc.com>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

