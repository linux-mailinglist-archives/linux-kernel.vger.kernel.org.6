Return-Path: <linux-kernel+bounces-526162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B793A3FB6B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA34D8808A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DF4211A29;
	Fri, 21 Feb 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tCQCdmlZ"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1504204F8E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154334; cv=none; b=ePA0reWb7pe89f1acxpc1s75JA6Orli/XtsAYvZk4UMadAANwPaG+3jcVkw4yuUQQT6tb98IxRVLx7Z4GVJpBVt3p7T94u6/AV+9V+li7wzuGNVmdEXtUAHQJKRfB4DU73c5rCBLdj6A4s3zlx7sOH3HOsJfN7VYruxieEMHu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154334; c=relaxed/simple;
	bh=5H4PEf9E9yk8XT2swQY06hLeXngmDP4x4LJ+LIwvvO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo5oK593LATnypgJzWcJLgV3C6RwPOKFB/FVWPCKLWOAtL3M2q8w/a5xD/rjMWi4PWz8IAowP5OiZ1obj4e9pQmwMRQwCUomkTomYtH+B03vQO3BbzNXT7IrQyIDb3NiuXC8ULAvLEGPUjMuVooF5vioVUsBL1tjBz2Zg71OAxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tCQCdmlZ; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-309311e7b39so20809951fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740154331; x=1740759131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbnhtJEa4SquPfm19GzdxAOTsJ3ZtzFT/hW1Tsd7YMA=;
        b=tCQCdmlZrK5safywGUkkygQaJbsKc+gaZcMtb/4y4lvzf1VJ08M8p32AL72hYKTjkw
         8rMvO23OXJTmrrMeaaoNmxMuhhPG1iMt6nMY2DZU9k4Ar2tmCwc2F2d9NTWzwD8hHtnL
         fMDvcRFqpobj05moA5HNa0yVPLaaxeeasy4SZMagewU0sswpK4zYYMVxjvwTFMmnpG6x
         gC5qjo1SZSIpW1A0w4Pn2Sl+/xx0A0iCYalSyKMaUlJKTXNDZeKsUNf7o+Z3rqK25/bD
         6x8U/IyC4hqDFGpkzKL46bGspjsmNjFV1i2JrMJFJK0MJRkIr0y8tPwF5LTxpcdN0S+G
         RvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740154331; x=1740759131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbnhtJEa4SquPfm19GzdxAOTsJ3ZtzFT/hW1Tsd7YMA=;
        b=sBGUMcZctZdiF5tQKiIgX5zbUyPWBGT4N1FegUOo3k8qTb2uoOyRM47drgrMHL0i3B
         kxNOjQ+GQxIZZOS6lMs/T1oKFGZ25omPzEPNCm5QguIvHdKSzxddyIBbS9dUMek/y874
         zq9R4hVKOupJiJXpbVOTi4lzOzE7/xpxrji33IBmbAlqK9IAolGmHkTgcbqtU5LpDaiz
         VRsNsnjMJ9bqzgm3H4KEQk0ZtYWJy+px2gC1tSmZO+WnDDcZYlwdQr+/EFKEaSUjYbKP
         kWgFmc9Ms7xpQx5eDRknpqMts4hbOpKQy6R4mF4q+CvQvWKVyClFTAdjBbFlV44oD3cb
         hDWg==
X-Forwarded-Encrypted: i=1; AJvYcCXPn6uEfpuiuKgCF/oTij6UzCIZW1C7uFPZlr+yHH5binsXDHNAaNvFYdHw8H6ctSCV/67TN2GV2H/dhbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+3BH7rJaf1WqhHta5Jy9goaftL6gWtG9kQXJLHUts8XSblTJY
	wMq26a+iGnwtpCYw0FUg1v7yT3HKaNOWZJFifpyqDdsOvZ37bK8JzK3Yl8P3Its=
X-Gm-Gg: ASbGnctZ97o1Au9OPVE8u2e1QQg/mJAz2FYsYObKmgnDmBN8z/cFkxUYDMOGrlrJ+Ds
	E5gnVZV9FC4S+5EMDc1db+iMl9KJBV2sSgHVUpuR2JlPFxm4wrfd0tXaBOrrs04e7RhD0buj7qY
	iio5FiWToDy6bbSCadze/B6PAJZsytmotSw3B0WL1K9BdPiRMMTh/dnFJ5PcP4P8Tb3ZryqBt2+
	rQLhFhCPj5M7GbUyfDjc9oUwJBwR8DWnu1P/AnCe2F29F5rLU77oA/XRb06Bbu5n9rREqBzDFQL
	Ax2o/OU+uF23bWBicgOMHwnzbYnXvhMTjZBjS1UI0UKKnnXwX6xLClvufybqhWtes4noxGjS6FH
	2gMmmPg==
X-Google-Smtp-Source: AGHT+IEKm09ffSc5M3frvvgU3E9J1EUpouTHSwPL5rhTUfv0oqJAypzPAMmviTh4qLAjGZjUYSJxPQ==
X-Received: by 2002:a2e:7d07:0:b0:308:ec6f:7022 with SMTP id 38308e7fff4ca-30a598e29c8mr15100431fa.17.1740154330646;
        Fri, 21 Feb 2025 08:12:10 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a25195701sm20109501fa.4.2025.02.21.08.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 08:12:10 -0800 (PST)
Date: Fri, 21 Feb 2025 18:12:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH v3 11/21] drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE before
 blend setup
Message-ID: <7nd7j7wslq5fclik6trs2egwj7kx5wy246ljaqmwbkvnutu547@qgxcx66kjsw2>
References: <20250221-b4-sm8750-display-v3-0-3ea95b1630ea@linaro.org>
 <20250221-b4-sm8750-display-v3-11-3ea95b1630ea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-b4-sm8750-display-v3-11-3ea95b1630ea@linaro.org>

On Fri, Feb 21, 2025 at 04:24:21PM +0100, Krzysztof Kozlowski wrote:
> Before blend setup, all existing blend stages are cleared, so shall be
> active fetch pipes.
> 
> Fixes: b3652e87c03c ("drm/msm/disp/dpu1: add support to program fetch active in ctl path")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

