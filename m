Return-Path: <linux-kernel+bounces-418874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9B9D6690
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977431611BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544751D6AA;
	Sat, 23 Nov 2024 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCibfN9F"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0D11862A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732320024; cv=none; b=iahUqxitaN+daAZU82HjxwC+FLdvKQ1JpcyEoDvsimH0uFpIeDXbS0Inww+henY9AlFw1ryjPkwlTqRYPlzAz5n7W1R+qhbkIPy+TmYEaGxJdNvmx76bLN1/GifVlODDfC1443BlmB3XKJwYpJr0hgdjTpkwEIpXKCGmoNGVkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732320024; c=relaxed/simple;
	bh=u3GVNbfepnp7N5qDFxe94e68p+Ai5fxqeOp9tDEO4gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gusjhQUFMmYwz42cNSGVHwbZXHFSu8SQqU9S9W2i9N0cwJhZTgQLyfZXua+xaMPSDz/9WV7zHEbUW9NKqIuA59VcfUvXir09WfYpY9KpcvD53YGqEJQ+8Ef6V8o/k5PkWMwAmFYMaHDCRrfyGP1p1fzJLW+TYsPochKsjj2nJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gCibfN9F; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539ee1acb86so3118732e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732320020; x=1732924820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jsBEPts/nIbbNaoUTj1vxVlfNzP9ab+ytNZuDFKdOsk=;
        b=gCibfN9FzwbZtSCG5X66rDLBjseMPx7NLp5v0BO0eoEQZySfEW9gzqC+vKePeeU8LM
         m4dMbByVeQICwi+LndXPOz0Zx161PtPgw6k46cqadMEoSYzVnaFVOS/NjWNDZ0DPFwFF
         CWPxjStDs8YCxxAJmjpPNuB1fhBgS1+ENqveUgwf+gFt3DKrr/ie6/sbfI8jAVHP0vq1
         Ikl95BYz/zTLDJFFovZz54W5Om+84a9vRK+I/lrtRXfI3GVZvAbbpgVLxF6BeDsbSd1K
         yr9ndSbOtMrVgp4pMzC4osCiQeamUobWlcWgambKOI054zrfxVrJc8qtI8H7h/lSLgFC
         xXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732320020; x=1732924820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsBEPts/nIbbNaoUTj1vxVlfNzP9ab+ytNZuDFKdOsk=;
        b=OgCrNwbYoRYjuKjeOfSo/BApgOJ5JFYs+LP3zNgHBph0qXUKTSPPPadBJBDeuJcSr2
         nWeh/kYMgbiECI60BmEpD/mR2v/7LrClKSacSPCZNlNwmjfr1hmzkUUeGbIKBtRYeUQd
         YC3yGm3oD2oQLx2N0NQ9JsbVQfWqojP2qQM0XpUqoxGiJwzsXWAijTpWHIPdz9SqN43D
         sTzCzHw/i4E5/cCegHRAuF5/61YHSz9tL6c2hRe3IqHuY/GTgvUvf4hyb2CJ4Q/hqR75
         amoE8mBONmU/DkTh0lp9UpUCbd/OCfyZuS9xiSOc7q5EcED+fmaQCOJZ5LlgsyjeYtr6
         FKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtdvAWB8EmuUSv9lEf4yXBTSEcYIc4w4ygVdRbHfSnALcDxikcSPSE/1bidHOAXI3YmU0+pDty1s1b2GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzX23ukzGnLkE0UpyzNlmpaPvigiHnXbafHJ8mGOueS+hUSEf
	41eRvxR5sL6oWXLj/NRq/jGJXVgbnZFGZR0kZQ60ZBQL99c9OR8MC2DJHWI5l3c=
X-Gm-Gg: ASbGnctaocxGBXljao3f5+oDaJfbqN9P74mic93rXLkZ7J4inRa9M4NCLOLxaYXCpue
	uKEl+7PO9AcOpbKthSZllY+i9Lq2S9kpIjcdYwKakGaj9W2Nf1jcnjSRbgsBqYMU2MH/rGxfuIA
	GM8vH/cl8KlY0NNMAqlvZ7S6IhsrbYvz1pH5z1NSk9jhoN1QnxEpP7iUV1QePdSkdnD9O4OmmYC
	SzqeO1XqCgjpYhmM7ugjaoQyjod5unD/vTVR85InW0SRutMBrIkscAvLHGDVF/ct8+bpX6nqm85
	4Rr8PH8CZ2q+SrPxYhTw2g8V63lpjw==
X-Google-Smtp-Source: AGHT+IFzdu68PpAVcH2MaPOLobnSuhzBLFuGpwZtzC/B7jvw+8UWRjpP5qmwwColoKW5tz3fO1q7LQ==
X-Received: by 2002:a05:6512:118d:b0:53d:dc12:7cb4 with SMTP id 2adb3069b0e04-53ddc127db7mr103246e87.29.1732320019290;
        Fri, 22 Nov 2024 16:00:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497cfdsm610900e87.248.2024.11.22.16.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 16:00:18 -0800 (PST)
Date: Sat, 23 Nov 2024 02:00:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: Add VBIF to DPU snapshot
Message-ID: <mue2tzzik4hiu3i4jjl457inbrveq7oifsy35fzwclfbqwn5xz@awtruuphsjzb>
References: <20241122-vbif-snapshot-v1-1-6e8fedd16fdf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-vbif-snapshot-v1-1-6e8fedd16fdf@quicinc.com>

On Fri, Nov 22, 2024 at 03:09:10PM -0800, Jessica Zhang wrote:
> Add VBIF registers to the DPU snapshot to help with debugging.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

