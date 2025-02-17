Return-Path: <linux-kernel+bounces-518247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A562AA38C38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1FB16FBE4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395DA235BF5;
	Mon, 17 Feb 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BDOYIYOB"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39A2187858
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819927; cv=none; b=G708R2RH2Z3zKwgu2y3KFSIOxzfHOVrynR91zmCVOsU6Of6z7e+cY92hI957eVWeju1YfvXyCyEYZRTPMU9Nghg6JRx0HxPVM7eII8Kn4cjIL7DBCsdQj7BOW49WbcP6onbtpQm31fo6p4EzunOfsyzrsGmZvfQy2gAgr/kBMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819927; c=relaxed/simple;
	bh=mhMQAL+ZuCppMLZz3hGC1V1w1m+yQ2xV52Svf7YNBBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7ugdc+eF5zvk+Lhml+K9KRaLLrfIm6Vukd+hCobckORecK64Bq5vJ4t4UPXCSUIDqWJA++3+piVcB59WdB6aaS2rO9pm1AdYDyUIVPv2a+o4IqSCI+4pasDB6P0Ktec0SdkQpZQfNVpOx/iEr590Tu/VF8LOGdOEdvENXKZoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BDOYIYOB; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54527a7270eso3365400e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739819923; x=1740424723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DK+fqhLw+0oSKSvkhmUshysfw/dArV7Gb0FGu6H8pRM=;
        b=BDOYIYOBgxrYEXkVTg9BNQkdzk2Hk/0TDeHpNhz8Rr0L2ZSG9mRKe/f1U2e3isBkKE
         PHdjNJZ3n4CT1WlAAfTEChtcsFEYTxpA6YS1K4nmGkDq8btB6S1CQ3lMndViSv3eZz7T
         qWoqQ50kqY7wdbOCEc2UN4bhuNT9wiCMy6Kb2I9UePtYAcacHyOrqAQ35w61DOA0Sqwo
         HoDxN3QjiaX02qY5qi62tCUKwKjLbuJ/uzdolThFyQcrgg4cBjxaFADyNA3gEydedpv1
         Z9hduDbGsBk0+5vsNuRWySc+f4BfP5ZAuaqf7U6bgNf7LcH7VynAMsvv1ZZgwgAF60zO
         3CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819923; x=1740424723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK+fqhLw+0oSKSvkhmUshysfw/dArV7Gb0FGu6H8pRM=;
        b=ObCJb1Z+y1kA9J6iiL06cCUpimTJ2+wWFlGjtdtAI8bA1pLwh9CJE5WCLcdX6ZYY6A
         k8oSjRitSEDichIHjajKFcgPdqiBaOB7GZ1QY9RDEkyI20gRlybTdmFij1za9WwIk7s8
         /lHmU3ga4HrxQO9Dm7keW+Ra8HQHhOPXpy6ACV2k+5iht/VB0BTCF3xTZ2qOJ9njN8h7
         QIN22LdG3ffYy0UYuQGaH+Hz3oBXOa1uAMDl9iUwYMN2yFO+TRYkSA7hfnhDBuF9CdoD
         vypUjKDssaQoU0Ax+0fUpIFDkDVCiBDwKccYX+HK/NRfiSlvyFiasqHb/qHh4eMYZR8M
         eBpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp0HxhUMR9sAotwnIz1vXJBAU64QVkdVLAkIrUjmGU7TNYZK8hSvvk8wy/ea00FUz4L4phFKpXK53NdCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYdrs/WYUBmnx+w5kcCL533l7tYiZYfObO7U0efxe3J9IdFOJ
	XOlJFm46jn7CcDNTDVvy2uEtX20f4BZYsTvTIe8mxA1ppoRhHbLUCdXFODOyNuo=
X-Gm-Gg: ASbGncsg7qKd++TQO3Od29PJLfWcXbZkjUy9gDeKAeWy2Ft0dVz18Y+cZIBqk+pMOtr
	VJsrZWdNlrWusvvaGppV2QxC6RDUoI7oJDuBgL3aH/+UMlr3oNKh0EcvW6JpVGjOIH1R82vIS1b
	DDX+QCpmgOzfWdKcYKqgmU3n7mVLNYZFpZTuV6cgKbcv8enz6wilDS+UiUbz5tra8+xuvKHN4sv
	vyRoxxSJAgt6jRXWvUgD4oYYnnHrPfb1uFSDmC1aRgHi8IWDGQZNlPIrenYduYmnKCzTFxFXPaQ
	l9zeVQyZlNOgmn6ScJFSEKkrM3Alzm/WGxYlV9BjB3Pw5GTXxfNEjWxXzARMg4DcmIEOZmI=
X-Google-Smtp-Source: AGHT+IH7pPe9WdA9acnmeu4tM6FBkJrCmOJkB/cGc23MUQGTJZAedW80zQq+KjfFc7YHQvnbMFONmg==
X-Received: by 2002:a19:2d11:0:b0:546:27f0:21a7 with SMTP id 2adb3069b0e04-54627f02773mr695030e87.49.1739819922816;
        Mon, 17 Feb 2025 11:18:42 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461d4f2aa5sm694294e87.0.2025.02.17.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:18:41 -0800 (PST)
Date: Mon, 17 Feb 2025 21:18:39 +0200
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
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 15/16] drm/msm/dpu: Implement new v12.0 DPU differences
Message-ID: <qlotuliwnm5spneolztca7avmh2a46pz2xqlxzqbw5kwa53m6q@oyhnzz7fhay3>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-15-d201dcdda6a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-b4-sm8750-display-v2-15-d201dcdda6a4@linaro.org>

On Mon, Feb 17, 2025 at 05:41:36PM +0100, Krzysztof Kozlowski wrote:
> Implement new features and differences coming in v12.0 of DPU present on
> Qualcomm SM8750 SoC:
> 1. 10-bit color alpha.
> 2. New CTL_PIPE_ACTIVE and CTL_LAYER_ACTIVE registers for pipes and
>    layer mixers.
> 2. Several differences in LM registers (also changed offsets) for LM
>    crossbar hardware changes.

I'd really prefer for this patch to be split into a logical chunks
rather than "everything for 12.x"

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  49 +++++--
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  12 ++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c  |  59 +++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h  |  17 +++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c   | 210 +++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h   |  18 +++
>  6 files changed, 350 insertions(+), 15 deletions(-)
> 

-- 
With best wishes
Dmitry

