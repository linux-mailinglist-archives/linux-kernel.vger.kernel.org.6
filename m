Return-Path: <linux-kernel+bounces-533703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B095AA45DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56371161E52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BF9216E01;
	Wed, 26 Feb 2025 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdeWKcoV"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CCA215F65
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570911; cv=none; b=XU9LU0Cfhyvm0xMHRYk20AY7Sz3q9CGdT7iPS2kKtj/TahO4S6wDofMXXUuwot6EddPcryAQ2wpLkLXpdVf+FyZcv3OeWD2FE6ed5KkPTThXN1yOxD6rRoFPcbli9hou1cQolQVgN8yo3XWbSNgt3T5JEKLx5xo8Tij9N2vK57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570911; c=relaxed/simple;
	bh=Mxt5XTZcaHXg7wgPdmlHQIjEjTfBYMpf/vp+rlCr7SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgvAGhLiYGkF+dw/oJL9363Sz6obbBA91DjYmnRAlaxacuhbrAs8vK1+9geQXe1ofrrC47Yft02ZG/h++J0NR3CjHSQ2MkAiD//lLvlafcAfrnB2UrJV/DLWNCcnQ5Yk71FjAus2W99wCzUrp0fX0wWOsAZFTHbbnw73dvmV6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IdeWKcoV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5484fa1401cso2436708e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740570908; x=1741175708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MV1eFL0jIvGTLmDaJhQUuUnheAKwvr3wFZVERN6PrWg=;
        b=IdeWKcoVV54bK4hZovEQa8hNxOYEOpfrxpA8lF1hHCyxb8ss1KPSLr1tYj9qMIplPF
         ysbdyS+Lge2TYVXigQNLsQDHFPZOvK383Nq4TJWJL9ZmFeU6fXyqMeG4qU6EHTEF51Sr
         fTbrnEHyiuGsHcnvvtcXicH4QcmvvV+0d+es6suyfgvZ28DvK0X4rOWTKyRhvVuISzM1
         Ley6OsbbTvFzu0SbDEYpGgbVA3Fb1/fKFX4wcY9eZfDZGkCeCqXyZKN261C1WQ/D06Sh
         oRZCQfslyD0gD8qY43ty5bqNHZ6QtDdaNlsN2WqdnW9YWrrZIgZyFKwydjqCEsHKUF7h
         09VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570908; x=1741175708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV1eFL0jIvGTLmDaJhQUuUnheAKwvr3wFZVERN6PrWg=;
        b=AdxBaggPKai1VeoaQ3GNnRCd5ByV3Hk/5gYCShVXxg3BLrqGhQjebNfldtdyWxLC0k
         BGUcOQwakO+Sq1GGsUl7E4dhzn4zVje8zbmoA2bn9pKG1BOPZjyw7k9Hin9aJ9daGVaU
         9nIDzkk9F6E0gwy8NivavDGVuLG975TpVXTLnG6RiBWTgBWHAyfDQMUMU5W8EInmsOqf
         73l1/ffPz7F8cZdK310sQ3Rap94DFOXAL62wJwcPujakIjNjsFYlRn1RJdA18P35/eOo
         LPQ3kGvonilt3r116srq3lfvTrvkh5oPqaLcjECvRqaLuM8Vw91L42QCBTBpo+sqgmkh
         M/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiNEdvauDwgVB6a2jfogZYsm5oUQO30j+Wbq8H2v2T0SkVV7jCu+YbkAhQryBo9xRvkF88YGTWD5IONBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvP/TGwxAsdcudTS0ET3gknE2MB0ifh7BQHeyEmH0O7GQq2dWV
	FW/mjznBSbyVJ7LKVSskTx5dSmCE2KxUJCd1SGP+Ms7Sj7STnXS80xhxFwpMelk=
X-Gm-Gg: ASbGnctR1UL/plGd9pq+71r7mh8hD2l3Lk68C/yU8BKDnhuukWWMOPwgYpRMVR+Jqo2
	l3yK8VC8GegM0kpQU+dWBu0pLjzGH7gdgKPModaIkkJ3eapj7bHEODFw2NHgbW4bpW3eHWho1MX
	oUKpSuO+AoaeKPCr1hGQuX/wRt3kDpd5sylCBqHhFhNLyifcVCR4+2CkmkYVYzjNjaAh9gyGMfy
	kvNNteCZoaPUhaKDckpyz38VXZqI4SWP1/kXNFMchkZrIuvWoqXH3iuq7ectYHNRRuWjiVRMfDn
	rjORHR0S2s2q9zb5x/eYbiYKO2XauIaa9ZPoXJ7HjA43Ny6xzrI/I3bT2Sa22Z2LJsCYXIHdTf1
	jZW7g1A==
X-Google-Smtp-Source: AGHT+IFdiaumSjl7stITiQ2wEKd5TEV1JT0pl/xh0E9GddvITQblHFNg5YZZAQPAKKG1ai2p/TA91A==
X-Received: by 2002:a05:6512:3f2a:b0:549:39ca:13fe with SMTP id 2adb3069b0e04-5493c5b85bamr2298709e87.41.1740570907382;
        Wed, 26 Feb 2025 03:55:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b2574sm434994e87.21.2025.02.26.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 03:55:05 -0800 (PST)
Date: Wed, 26 Feb 2025 13:55:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Chandan Uddaraju <chandanu@codeaurora.org>, 
	Jeykumar Sankaran <jsanka@codeaurora.org>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	Sravanthi Kollukuduru <skolluku@codeaurora.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Archit Taneja <architt@codeaurora.org>, Rajesh Yadav <ryadav@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 4/4] drm/msm/dpu: don't set crtc_state->mode_changed
 from atomic_check()
Message-ID: <vn3f6jzx27twq7maamdmeqahvn4zzoxmdttkm7epg2qgn4ueov@hqzjzzzw3mog>
References: <20250123-drm-dirty-modeset-v2-0-bbfd3a6cd1a4@linaro.org>
 <20250123-drm-dirty-modeset-v2-4-bbfd3a6cd1a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123-drm-dirty-modeset-v2-4-bbfd3a6cd1a4@linaro.org>

On Thu, Jan 23, 2025 at 02:43:36PM +0200, Dmitry Baryshkov wrote:
> The MSM driver uses drm_atomic_helper_check() which mandates that none
> of the atomic_check() callbacks toggles crtc_state->mode_changed.
> Perform corresponding check before calling the drm_atomic_helper_check()
> function.
> 
> Fixes: 8b45a26f2ba9 ("drm/msm/dpu: reserve cdm blocks for writeback in case of YUV output")
> Reported-by: Simona Vetter <simona.vetter@ffwll.ch>
> Closes: https://lore.kernel.org/dri-devel/ZtW_S0j5AEr4g0QW@phenom.ffwll.local/
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 32 +++++++++++++++++++++++++----
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  4 ++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 26 +++++++++++++++++++++++
>  drivers/gpu/drm/msm/msm_atomic.c            | 13 +++++++++++-
>  drivers/gpu/drm/msm/msm_kms.h               |  7 +++++++
>  5 files changed, 77 insertions(+), 5 deletions(-)
> 

JFI, this patch generates following warnings, deferred now:

10:49:07.279: [  235.096198] WARNING: CPU: 1 PID: 515 at drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:459 dpu_kms_check_mode_changed+0xb0/0xbc
10:49:07.279: [  235.107375] Modules linked in:
10:49:07.279: [  235.110532] CPU: 1 UID: 0 PID: 515 Comm: kms_atomic_tran Tainted: G        W          6.14.0-rc4-gd229bc98da6b #1
10:49:07.279: [  235.121069] Tainted: [W]=WARN
10:49:07.279: [  235.124130] Hardware name: Google Lazor Limozeen without Touchscreen (rev5 - rev8) (DT)
10:49:07.279: [  235.132356] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
10:49:07.279: [  235.139513] pc : dpu_kms_check_mode_changed+0xb0/0xbc
10:49:07.279: [  235.144712] lr : msm_atomic_check+0xc0/0xe0
10:49:07.279: [  235.149023] sp : ffff8000843f3960
10:49:07.279: [  235.150686] usb 1-1.1: new high-speed USB device number 100 using xhci-hcd
10:49:07.279: [  235.152439] x29: ffff8000843f3960 x28: ffff65a18386d080 x27: ffff65a184826a80
10:49:07.279: [  235.166848] x26: 0000000000000038 x25: 0000000000000008 x24: ffff65a1866fd580
10:49:07.279: [  235.174188] x23: 0000000000000028 x22: 0000000000000028 x21: 0000000000000038
10:49:07.279: [  235.181527] x20: ffff65a184826a80 x19: 0000000000000000 x18: 0000000000000000
10:49:07.279: [  235.188866] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab013dfeb8
10:49:07.279: [  235.196215] x14: 00000000000c0000 x13: 0040a00000400800 x12: 0000000000000000
10:49:07.279: [  235.203553] x11: 0000000000000050 x10: 0000000000000000 x9 : ffffbdf7fc448530
10:49:07.279: [  235.210892] x8 : 00000000ffffffff x7 : ffff65a182610400 x6 : 0000000000000038
10:49:07.279: [  235.218231] x5 : ffff65a18314b000 x4 : 0000000000000000 x3 : 0000000000000001
10:49:07.279: [  235.225570] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff65a18ca7a600
10:49:07.279: [  235.232910] Call trace:
10:49:07.279: [  235.235440]  dpu_kms_check_mode_changed+0xb0/0xbc (P)
10:49:07.279: [  235.240641]  msm_atomic_check+0xc0/0xe0
10:49:07.279: [  235.244594]  drm_atomic_check_only+0x498/0x934
10:49:07.279: [  235.249169]  drm_atomic_commit+0x48/0xc4
10:49:07.279: [  235.253209]  drm_mode_atomic_ioctl+0xa98/0xd00
10:49:07.279: [  235.257791]  drm_ioctl_kernel+0xbc/0x12c
10:49:07.280: [  235.261832]  drm_ioctl+0x228/0x4e4
10:49:07.280: [  235.265339]  __arm64_sys_ioctl+0xb4/0xec
10:49:07.280: [  235.269381]  invoke_syscall+0x48/0x110
10:49:07.280: [  235.273248]  el0_svc_common.constprop.0+0x40/0xe0
10:49:07.280: [  235.278090]  do_el0_svc+0x1c/0x28
10:49:07.280: [  235.281512]  el0_svc+0x48/0x110
10:49:07.280: [  235.284753]  el0t_64_sync_handler+0x10c/0x138
10:49:07.280: [  235.289234]  el0t_64_sync+0x198/0x19c


-- 
With best wishes
Dmitry

