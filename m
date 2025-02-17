Return-Path: <linux-kernel+bounces-518241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37689A38C15
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9C83B399B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E675236A74;
	Mon, 17 Feb 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NOaO5h1+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B8228CBA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819313; cv=none; b=LT33fcYJCAAmA5XLWcqdPDIVyzGadsHE3iXxRDtqVHfdfqyER6PJ/WWrQNd62SjmXvur1IbpG+lJTy5J5Fby8rN6a1HaGfU6L5NDIXl4CVXcA1nuNCLdUp68plxxHqjn1nOh/UXiwRTzu9xAyIk+8v/q7Qzqzw7UNYlmlR3Pkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819313; c=relaxed/simple;
	bh=Oo7Lrcl2ZPC6VhucruHTwVeLY63vJvWzZsAVRWNt6Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9KVGMt4mEvGpJ81vNC/nMvXC7r7WxWaToSDMAH9hvXdy8r/qb84OAEujbGOmDQMhST5DlwyI9UWyG3CaPZb71NFt/PEDwsBAEpDdAWKQO5NId+9hppQXGVbXiEvicqoJ92977RxuuX4jjGYOTmbnyXdu2imzeDDwsgEghT9QVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NOaO5h1+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-546237cd3cbso1236335e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739819310; x=1740424110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wdRXWfwJ/W21WH+kqrSD6iNAMN48NhyL/UJXo71GHvM=;
        b=NOaO5h1+ZbcRANW28dsryouRppVIC4WVVrnetnm1lpGqzlRpdjn8eZUhdXmudHEYEJ
         liLuanI9DAORgGUAabEsXzA7S9Cc+Qhy+rFHwTRx9C2EWZ7spOQ+GJ6TxMHxTiKbHnUt
         WCGKe2rpJtRcYRuCwou2Pr00v8JFcFg/o/au9KZ4+nqmgDvae35JW3v/8UtguKgByeqJ
         Yw0sFZeU5BV5itUXc/2k98xbH1OT1lpDd5sp6StXVPGqVoBf//aLzBV9DCV9JVuFmRRt
         imRolMyIys59TGj9dAFcgNY4Iws2lOD/eWg/+i0vQAXG2JELH09yQCdPN82gmOutPgfM
         pV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819310; x=1740424110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdRXWfwJ/W21WH+kqrSD6iNAMN48NhyL/UJXo71GHvM=;
        b=LPinicy2FNddGRsof2HpM9BrSZcSNhQSm2d2nexmR5101zb+zlTYppeHke1uNLNymL
         fhn4p/4K1Pwyr+KwGw2W9tckHTjEde5gGlIIbT04IZ39/Ox0TB1JZVBJtbj0MmJ+SKgg
         3kQ/i9RJMJDTYO9+7sBazOwT2N2N7NobLxH/JSbf0BwONHX2qFhwxcW3ftG5P1BJcIFm
         Hsj60MP1W/rTCOEFhPWnMFIwVXczBeVrVDwkKa84aPq761gresZjsxeutL0c7QMCp+gN
         9cRG31x/RzwMivz8pncaXzixlQWr2aQyh0TYFIoAX+1zLiY1DbOzGoinFVHSJ27zJvBh
         yC7w==
X-Forwarded-Encrypted: i=1; AJvYcCXhfRyy3shxzFl7FqgXoplbovNnwY+uZ64cTJlYba0b7kMhNSUajpGujDKKyCzFemmIWhqBIeRrvGx8pOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmqJIokoYiaS4t0RPyf0lwGBCRpH429xjceOwAXnM79p8F5zbh
	3FhHLN+V1IZoID3ZBeoD+Ql57S0+kLzb+vkxcBL4d3usTw+vRP7+hdCPY1FYwI4=
X-Gm-Gg: ASbGncvEUjTFgkIEOk0YYoDKOPGBlhL+Zc/393q3axeEIBlveyA8xwyFdtiQtKsMAv6
	U+NRwwutWnZsJr1aXUU7MNSmwlqd7Mso2IA9ypEEhsFJsFKC7h9WjnBr679v5wAm+RQHXW8MlpD
	XtWFIJdsYQ6GBrB6zWugkFrStM6Ozc23aB7o35C2uTZVU2ol64hxM1rqy3Av1ouj/NwrXnAFDd0
	0EzyfBpXhGpm3v28wkvWmntXlF4BM9/gSyKEiO+8Oz8HerSwH6/ALCI+UMlAmLLfOgb9DguUZxV
	EkSNDx6xhqOLeX3FDjIf2Jh5W5NAWqvbYzYK+nv8DiU0LCh5napJncZT5Y/AVTGfyqEghXU=
X-Google-Smtp-Source: AGHT+IHamycJDA8JS60gP7tbbymnAwBhYuHbKpt67zrHM+Y3j+U5GzOFbCQPJZF1gEw20AZA/az6qQ==
X-Received: by 2002:a05:6512:2823:b0:545:4cb:b25d with SMTP id 2adb3069b0e04-5452fe37326mr3178556e87.13.1739819310163;
        Mon, 17 Feb 2025 11:08:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526dc0461sm1398133e87.246.2025.02.17.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:08:28 -0800 (PST)
Date: Mon, 17 Feb 2025 21:08:26 +0200
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
Subject: Re: [PATCH v2 14/16] drm/msm/dpu: Add missing "fetch" name to
 set_active_pipes()
Message-ID: <hnarfrrealmd6uma6ahbnw6v63yqtjw5a4idkp44mu73t6gyfm@4zcb6xkbpwry>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-14-d201dcdda6a4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-b4-sm8750-display-v2-14-d201dcdda6a4@linaro.org>

On Mon, Feb 17, 2025 at 05:41:35PM +0100, Krzysztof Kozlowski wrote:
> The set_active_pipes() callback configures CTL_FETCH_PIPE_ACTIVE and
> newer DPU v12.0 comes with CTL_PIPE_ACTIVE, thus rename it to
> set_active_fetch_pipes() to better match the purpose.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. New patch
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c   | 12 ++++++------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c |  6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

