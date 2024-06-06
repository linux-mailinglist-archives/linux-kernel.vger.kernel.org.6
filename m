Return-Path: <linux-kernel+bounces-204596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42A8FF106
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5921C21836
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D81D197A7B;
	Thu,  6 Jun 2024 15:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jXOHFHRb"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26519753B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688683; cv=none; b=uOYJ2x2I4HLHeeCeb/GcrUWYvZsplc1bn4FGqtzCAtVWQ1G+HoKgxcRu/NJfGzU6kKLAFdvXygGDwJjBWHTEJkYvGsgcHC3rIdMtlaBrNUmx3iiczDQjcKSXQU9mrf50J2Ah60nqcxtWJ2ancFcQgufKv4stZDWcjDQcgk7HfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688683; c=relaxed/simple;
	bh=GK2TAzVHi7t+avHmUmGxuI/Ivtu5v5EspjOyIKr0EM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGiGhE7tOJQWzbxWZfD2Dnd3gY+WwtfwqPYWCYutbP7mxcapo07PEguSmxp5L38mPIHtJ8kxiQV2FbWtsqY/2suYLCBPNSOsB7XDTHxY+u1w4/hkczGNtUo/SBlBOBL33RxCm/EQ2MlotPlDibvXfqV+2hOwvw5TGTBBr34ZAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jXOHFHRb; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b938587a4so1295691e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717688680; x=1718293480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CcvLWtoAhuxv7+XmnyzWyh5/jHFSbk/UPbtacznbqAQ=;
        b=jXOHFHRbt09mM9B9tKrV+CFN1aCkt/ox6ddsiYAhEIu7EV2k8UB6NuaMmZhbWMcU6i
         TpQHgmlN+IAiTeikDkAY4pYaFhXJGP6k47YpEvlrNQwEFHUrwlfiRP5OPiQ/it2Jp+ME
         3yvkodRMX+JWFgHuy1/HhG6k2oYYhJ6CYMST3pyLbgMPHiKQpLqf9kSAYK+Fb/hSotKC
         ItvFFHipXubPO7xbLISCqHGS7Q7rMEFvAG49fAPlDzKHZE95NJ8qBfXJZgfoeHcPySn2
         LESo5bEOh1bdPKLomyb9iXEbX4vBzLXHkWyCanNb+K9Eu1//FfY5pwLb3sUEkaWLE+FB
         Ww2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688680; x=1718293480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcvLWtoAhuxv7+XmnyzWyh5/jHFSbk/UPbtacznbqAQ=;
        b=SJX+nk3DIVcFSR/8uqFAdD+uohaRFoVyOTr9W1p5l5izt6MCuByw/ZW/+x2ygBxn1s
         qZ1GBwOi8jBqdsHvOBKEoiXM4LxYrV7hytn3f1W4/bRHsSk3+A6ZlE8urlnaFB2FFqoM
         WQ/1gVdepD/W9FjUf3pGHam90IYZnw/zSpQkAuJDePBCAcHpNZHdlBtnJOpYRxOjtbsM
         lTl4/OYZ5RGPUqKhS+4CQcp9jtbWpt7LdpPyzPYZ6YYVlVqoJwcw8G+JSdyhMPqDnxy6
         6MWbIuzIoia9FKrx3duu4LpEo+XmMH/IU1R1IFXaQzJu6Bx4XKdVoJiXXMAOGJsFxd76
         3FHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqyU4IMHoRP4bvIKl4WfTdD0el7ZDuy0uv6WakyLVGdVC7hXjw2uzKi9l/1mCzS9e1DLPX5RSXGKpmFpN0epIoL8VNY2OOXBG3GUE2
X-Gm-Message-State: AOJu0YyZlXSVkogjxwDwZlM2sYmIH3Uy9JbA3jjJTrDIGIy3EguyW1r+
	ve5oIKGMA+vmHZ+6Unn9B4GFvKqeOEpFwAHgOriK7DsUU/OuPxKkAOOYxqY6yNjwYD42QaCS5+M
	O
X-Google-Smtp-Source: AGHT+IGfkquA6C70zvNtH1bpeU35r9otrSSRpObdg1UiWOp9nLQV2leYilFdaGLb2X7iS4KqqbZ4DA==
X-Received: by 2002:a05:6512:3b8:b0:52b:7a3c:36ca with SMTP id 2adb3069b0e04-52bb9f7cbb5mr3964e87.27.1717688679984;
        Thu, 06 Jun 2024 08:44:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41ee6acsm227187e87.80.2024.06.06.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 08:44:39 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:44:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Connor Abbott <cwabbott0@gmail.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, quic_jesszhan@quicinc.com, 
	nathan@kernel.org, Rob Clark <robdclark@chromium.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drm/msm/a6xx: use __unused__ to fix compiler warnings
 for gen7_* includes
Message-ID: <5b2o5hhq76pa322bum2td4cqqa5333d7rdxxsxulhalt3j24pi@ea7wzku5waf6>
References: <20240605183415.259276-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605183415.259276-1-quic_abhinavk@quicinc.com>

On Wed, Jun 05, 2024 at 11:34:15AM -0700, Abhinav Kumar wrote:
> GCC diagnostic pragma method throws below warnings in some of the versions
> 
> drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:16:9: warning: unknown
> option after '#pragma GCC diagnostic' kind [-Wpragmas]
>   #pragma GCC diagnostic ignored "-Wunused-const-variable"
>           ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:18:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h:924:19: warning:
> 'gen7_0_0_external_core_regs' defined but not used [-Wunused-variable]
>   static const u32 *gen7_0_0_external_core_regs[] = {
>                     ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:19:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h:748:19: warning:
> 'gen7_2_0_external_core_regs' defined but not used [-Wunused-variable]
>   static const u32 *gen7_2_0_external_core_regs[] = {
>                     ^
> In file included from drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c:20:0:
> drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h:1188:43: warning:
> 'gen7_9_0_sptp_clusters' defined but not used [-Wunused-variable]
>   static struct gen7_sptp_cluster_registers gen7_9_0_sptp_clusters[] = {
>                                             ^
> drivers/gpu/drm/msm/adreno/adreno_gen7_9_0_snapshot.h:1438:19: warning:
> 'gen7_9_0_external_core_regs' defined but not used [-Wunused-variable]
>   static const u32 *gen7_9_0_external_core_regs[] = {
> 
> Remove GCC version dependency by using __unused__ for the unused gen7_* includes.
> 
> Changes in v2:
> 	- Fix the warnings in the commit text
> 	- Use __attribute((__unused__)) instead of local assignment
> 
> changes in v3:
> 	- drop the Link from the auto add
> 
> changes in v4:
> 	- replace __attribute((__unused__)) with __always_unused
> 
> Fixes: 64d6255650d4 ("drm/msm: More fully implement devcoredump for a7xx")
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

