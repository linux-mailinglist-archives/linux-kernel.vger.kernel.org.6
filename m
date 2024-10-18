Return-Path: <linux-kernel+bounces-371642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79AA9A3DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F34F1F22DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BAC179BD;
	Fri, 18 Oct 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLLbEkmO"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E817555
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252951; cv=none; b=MP2kvvzVm32ijrRI5B65g/dfL3tyB2BEulGyvpatv5zJ3x7rVhHF5Q9ZnM8qmOIeWs7A9hvpeIdWcGZN4SRGP7qyOTN1jV0iDJVZ+2aKdpBaBinYey9XDwX286JPtu677ML5wYZprbzHhCakSfWkFoMLqer4SZ/jU8/9E+8J6fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252951; c=relaxed/simple;
	bh=TB1dGvfKO/U3vZiiQabzt22yY3ju7VJ8RJY1p7st6Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk+ZAkPSKEyjEAyZO0Os+KOCFqFd9iCqQf/kvIhvhXcvHKkBP/mwNHikV2eXS7LxNMz9wCL5EGQg4m8xqPGXNpcWo1/ZqFhhSuUS09EHvH1YE3IjyGg/CoxbVtgmbKtosGnzD5+sI+gwC7E0nSarq9rgiVfKk+wAIfenXWn1uII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLLbEkmO; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2075172e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729252947; x=1729857747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAbv6XsDmwAo2jyC998ue0W9E4DrCSE3SereVqz2R1I=;
        b=YLLbEkmOoUE0oFoCAXRlUDTsm/mNzE4NjhkTXzr+01PKYr4FqiTV32JTA8/7LkZQoQ
         lYpMRb/JKnv0pgvU4SXsKMbSQej/eib2JVFX+UEhQREQoKYZdta5wGlpiRCKhxPkZ4NU
         RB6lX2+Weitj8y8Qjjx7/1rwU5i66VIXy+PF1ZadyNrID+sZXgLYf3+zHcER68n0kduB
         CQAPjNZrLS3QGBudLVe4F8HJwsp4esR/19KOsOOOw1KsBeQJR218ldDzi5xOvzcNyiH5
         /Gpxl+8jrIBp/ekengcGRmNj8RikDHyROplJSuYIvJYPUCDZ3qtVUcEyol+LnT4Wmz5z
         q0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729252947; x=1729857747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAbv6XsDmwAo2jyC998ue0W9E4DrCSE3SereVqz2R1I=;
        b=jAp02NgXMLQI7MeHrT7jAAYGsKHnfcp5skKdr5uxw5C3kqEW8RM7d0nAZDHmQWohrx
         SSdRSgsW6G8yk1ZEjhKw7swwj+BHQTgaAD+SWqBUm5ZXc4SF0r7vxoYz+NVvVeh3aJX0
         DGfdMQWrYPlR84Jut7gpeO0OTBXMs8AC66TcQ6FVs15G7bi6LylcmGQmZkL/0h12xAJi
         vXOD0cjW4jFxmeGNJTEZEm3FLQbyO30x5hiXbawOXLh0Df/aY6a0pvdwK+OR2uiWmeq5
         50Qir4cyf6nlEXwnP3R9e+wclc4QJnVl/WEAAz74Xw2HVuoVhxCMpaN9AswqHBk+Q5zO
         bLEg==
X-Gm-Message-State: AOJu0Yx5ODEemeOl7W0cBVUlH1w4ELrTiMhHTd/s2o0dzYyIx3Re8KM7
	7dCYKqQyzPIL2kpouiE5pvMR+vRhudYHTwxe5gDqwQo8ib0adac07MU4ep89CmA=
X-Google-Smtp-Source: AGHT+IHCFo+NNLfp0lSvn5YXtWignyK0C2gw+49g51E6ZF+fUhL3qAV0HflJP7w5Uvo/44V70tVY0Q==
X-Received: by 2002:a05:6512:124e:b0:539:a2e0:4e94 with SMTP id 2adb3069b0e04-53a15b9f2f2mr578807e87.30.1729252946842;
        Fri, 18 Oct 2024 05:02:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a152044a2sm202120e87.227.2024.10.18.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:02:26 -0700 (PDT)
Date: Fri, 18 Oct 2024 15:02:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, robdclark@gmail.com, 
	sean@poorly.run, konradybcio@kernel.org, quic_abhinavk@quicinc.com, 
	marijn.suijten@somainline.org, airlied@gmail.com
Subject: Re: [PATCH] drm/msm/gpu: Check the status of registration to PM QoS
Message-ID: <dpwmookr5owd43efowmnoxbtbzstvezgczpbzwxb5rwu3h3zaf@luim5srcbo6f>
References: <20241018111811.3534385-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018111811.3534385-1-lukasz.luba@arm.com>

On Fri, Oct 18, 2024 at 12:18:11PM +0100, Lukasz Luba wrote:
> There is a need to check the returned value of the registration function.

Why?

> In case of returned error, print that and stop the init process.
> 
> Fixes: 7c0ffcd40b16 ("drm/msm/gpu: Respect PM QoS constraints")
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/gpu/drm/msm/msm_gpu_devfreq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry

