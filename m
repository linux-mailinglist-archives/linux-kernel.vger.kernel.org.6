Return-Path: <linux-kernel+bounces-230319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF541917B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B9282C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1794D168483;
	Wed, 26 Jun 2024 08:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaBCE6ue"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BE16630F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391513; cv=none; b=LLEVbWNgysrYdHO/mBo7xWOVKwn8/JfQ8ioOhwD/irbCkbCYCA+J6jrTYpdUHq7VdwRYap1X7CI/H8uOzB10b8OkN04nyqhdccC7L5rDPRDHI0+K/wmi3I/pnKCbDyxNPBPVAT63cWJtYLKml/nkYftsezxp6/nRoB74L/WA1qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391513; c=relaxed/simple;
	bh=4TqMgPchaSgkEnGussyG2ZGIP6a6Rnch6g+F0GYql/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReyTHctu4ENyo6GOtb4Jo1IbQIsP9IhhKN3kXwIQbymaV4u/VN1yW4Tozfn+9C3tRD8aWUOAGNhuWBDgd+rL3uIr54x6ppsJ6y/Dc18C2oOXZsqrg+ZopyaVlhtNHwT1Ws61DeBKjQGewq4UMVCdRe3OGsJd89Sv8Aujx8DVny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jaBCE6ue; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdf579dd2so3929348e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719391510; x=1719996310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hzxdCXT91751HJvUEbEVilPPM8qkMSIeAMEqqDe5ss4=;
        b=jaBCE6uet1C3xlqnIbvRXwb73kgI7MffLkWNyc0wQ/G/5U4DI6VSZIbQGizoq4bCdu
         7sIOScL4eGZB58CZvF4y9t76CabNdNey9gyVVhakQSkw62V1pAoGThI+lkTUgbWIy0IS
         E4lQzBCwJHENDzxTMvZkRfsVfuztbBqhT3QSNEpy/yDEZMNHK+3/Ztu7F5OusDSYurZN
         fYy0Lj7Bozm+bBcDzqo2eWXkYOSNwHoiJuXDNmorIghnH989rObweyNaDAAw2zXNu0dC
         12VinN3Ai5l4LzQ+qbbK26wkdvpaRSxZSeejewY7U+4lih9Baw4VyfpSSDT4ExKmf/So
         Micg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719391510; x=1719996310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzxdCXT91751HJvUEbEVilPPM8qkMSIeAMEqqDe5ss4=;
        b=tx7wfua5ahVucHCwpOdRN8NThJ0TbOo9+LzPLPp+xx93r5HYdQLRyq3pHQDAjOF5Ll
         hFL4cKz/7zZ+w0Z5di1xxWyy/z3ZjmKwzE+Ckeu5KcqGz6RJPJdKBB5wdjBl1gPWkKfs
         Ypk4BmbG39/6fYi21Kv2MoDbU9GaOdXTW3LeEK4OSihkHscW6rmYrHDHOCuhX1WXa7jj
         yRXl0FHXUSpjfoOt4vlP5tNIML/dKxqtlGDp90KqRD1scxBPaJ8NzI27R3BQyVH06Maa
         Yv2ofhP6VPYyT38RsbInnXM5OK1YPvclR6x/iaZlKAi1VFcXn/KsHB9RR7jL+0lmDDPk
         5a8A==
X-Forwarded-Encrypted: i=1; AJvYcCU8+2kxKzNGyhQDbZdgf3RZAIzGTFnCqZ2hIarozealwZuuu3wyoV3C3A8pKHpPFnqEGbgtoWGuTKiOU0CRx6RiabVcvulR4rRv2bqX
X-Gm-Message-State: AOJu0YwpPG3EGm7oSbe0vvgaI2BgWgLUqlvDctSbO8L3utixbCnDnwSa
	u9zfOJZAgttmQFjE2CvCjwT47ZHdU4Vieqo0dc6mfpcDApBLXnAC0Kfltlg+t+k=
X-Google-Smtp-Source: AGHT+IEfNnaYv5wFcwXGDonyXMCAQRs6U5hhIUgaupgn52qc7BZELI6S6uPQT6f7cTlAU8Kn7qOOxA==
X-Received: by 2002:ac2:5f63:0:b0:52c:a002:1afc with SMTP id 2adb3069b0e04-52cdf7f66f2mr6580219e87.34.1719391509740;
        Wed, 26 Jun 2024 01:45:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52db1a5b45esm180539e87.46.2024.06.26.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 01:45:09 -0700 (PDT)
Date: Wed, 26 Jun 2024 11:45:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/adreno: fix a7xx gpu init
Message-ID: <yrhlsznrz3zt72kjizwfoit7st3qtdpug2lgruzpjditik5kh2@a7yu6in37kvo>
References: <20240626-topic-sm8x50-upstream-fix-a7xx-gpu-init-v1-1-ff0a0b7c778d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-topic-sm8x50-upstream-fix-a7xx-gpu-init-v1-1-ff0a0b7c778d@linaro.org>

On Wed, Jun 26, 2024 at 09:53:16AM GMT, Neil Armstrong wrote:
> The gpulist has twice the a6xx gpulist, replace the second one
> with the a7xx gpulist.
> 
> Solves:
> msm_dpu ae01000.display-controller: Unknown GPU revision: 7.3.0.1
> msm_dpu ae01000.display-controller: Unknown GPU revision: 67.5.10.1
> msm_dpu ae01000.display-controller: Unknown GPU revision: 67.5.20.1
> 
> on SM8450, SM8550 & SM8560.
> 
> Fixes: 8ed322f632a9 ("drm/msm/adreno: Split up giant device table")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

