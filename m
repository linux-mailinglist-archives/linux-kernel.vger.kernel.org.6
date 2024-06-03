Return-Path: <linux-kernel+bounces-199727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF38DAA91
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 23:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89ECB251E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867AE13BAE5;
	Mon,  3 Jun 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+QdSnXV"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D312DD9B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717449608; cv=none; b=ssN8zCPVsmNaFzwTAlqtjW4RZOfAXkAncWaGZJcNLCIlfkrunXGSK7zY2F0WpZMBZeBb7DSFJOWYo5i2s//GvePGy6nPlChzEHUMndppPur2jnp8I1VT1v4EM2fP7inUifo/6ji/N6nvthvEOx3gI7ZDZ/tbrTikBWRGr+Mywsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717449608; c=relaxed/simple;
	bh=lNmb3/BgjUm+a1AFRGSeiPAbX9j5whtrrLFo7461qw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyLaj5ucFwrQkJs0780x+zmr6GxWHo4kW/4St9tBKjEAbjgMIYIi8w0TgvI/2hE5TZM3sHnZm3psqenZheKGvrGsLY+BE8xvP/CWBBAnfTNQbSOKaMvsP//M1hjRn9DyJMXC7si3G0TLD3kI4qNaeE0grB7QPHSujVVrlJByGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+QdSnXV; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso535002e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 14:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717449605; x=1718054405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1nvboUWrwT+izheqIMKJAA8UWhsuG1LQYHh6Ih/rJg=;
        b=O+QdSnXVl5IO3Ybfr7dRABuHiNEsHyrIniJZDWSGhKSZfA1nVq4Cv1WO9w4t4oI1my
         +2KtCK8UBdzBRqEaKCigPD9mr0Ik9jVquXQR/Vw3Jw2M71tKhi3Oy4lMBdsPIyR0VVVP
         YgGHwEaIpDcCMZmI9B185l1ygmsfTVcb4cMiu0f3Dh8mCwLaZx6Ik6zWRTLj0th5JWln
         qMXIpY9OEzYNgLQg2qwmwlWx8RTJQPeJX+fjxs+wk5RyzKV+qSn1COR700ZpX87NLf+P
         /gWOU7+mVdZQ0qYoPQkfcgFdqLK+pOeC+GuXJ3A+jxX6YpX46jcj7MSJGNlPm48GEfsQ
         9X+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717449605; x=1718054405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1nvboUWrwT+izheqIMKJAA8UWhsuG1LQYHh6Ih/rJg=;
        b=RyI2iiNzlldfBPAyUqODOVgSSfPjSe9SXCTy71ksMGeqBub6k8PP43fbSvu14GlZss
         HeWDsljF/xZL3MYRU+GuQxY4HNsYJ/6MxCYrkU5aau0VnzvrYn0ELSCsEbUJSiFT+qS1
         PcABv3/884BNOqLObiQecUujyBKv2Doe41UIoxTG37t9PqUVNG7+DY2FOCmIKSHJDE/C
         eDYUkKOC0qBqO/NDspxineXJQt13zzUgmNFWzdBrLKEsV/RSIcDERodxRAt/SSXFGvah
         JUv6XUToR3d5X5E/akDc5uWpLlr5E53xswyp8FyyfoEIsKCW8dHWdBHmzFOwCgRnnkeh
         Z6ow==
X-Forwarded-Encrypted: i=1; AJvYcCWoamnh4+a/nnizud4UppQ/BR9Wni8tylnT0hq8Sipp3OAqQYyQu75eYG3iiEBXECwgWqqqWjDao1SGa2kNq8m3AIZFPd457T5S23jG
X-Gm-Message-State: AOJu0YyUAh217mWba3MvYnzAvrd5u+p+OPXcOH7V19Kntaw8TlOahzkb
	fhHMtY+zyN3rlZKTb4b/pN3yTmGoP1MyU/IwQrr561tTof/dhPKNfw/hRtsEQAc=
X-Google-Smtp-Source: AGHT+IFhhrjTB+1TjVZWFCGgzUXx7UwmaTcD4sWkJy1XVm35ERd7tph+1HliSXbdZWovKYKrgPAkXA==
X-Received: by 2002:ac2:4c86:0:b0:51f:696b:949a with SMTP id 2adb3069b0e04-52b896c7ae7mr6800530e87.48.1717449605203;
        Mon, 03 Jun 2024 14:20:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b9f555afasm128873e87.289.2024.06.03.14.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 14:20:04 -0700 (PDT)
Date: Tue, 4 Jun 2024 00:20:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Ryan McCann <quic_rmccann@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: drop duplicate drm formats from wb2_formats
 arrays
Message-ID: <aid2ezgphqbshep4vulpct3yfsnhmt7prwhyj2tghvb4fma7kv@ztoe6v4xbnui>
References: <20240524150128.1878297-2-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524150128.1878297-2-bigfoot@classfun.cn>

On Fri, May 24, 2024 at 11:01:12PM +0800, Junhao Xie wrote:
> There are duplicate items in wb2_formats_rgb and wb2_formats_rgb_yuv,
> which cause weston assertions failed.
> 
> weston: libweston/drm-formats.c:131: weston_drm_format_array_add_format:
> Assertion `!weston_drm_format_array_find_format(formats, format)' failed.
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 6 ------
>  1 file changed, 6 deletions(-)
> 

To make patchwork happy:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Fixes: 8c16b988ba2d ("drm/msm/dpu: introduce separate wb2_format arrays for rgb and yuv")
Fixes: 53324b99bd7b ("drm/msm/dpu: add writeback blocks to the sm8250 DPU catalog")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

