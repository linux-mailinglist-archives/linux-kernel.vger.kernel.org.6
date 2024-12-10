Return-Path: <linux-kernel+bounces-439412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F829EAEE3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007B4165AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD52153D6;
	Tue, 10 Dec 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlSpZiIm"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D44210F6E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828292; cv=none; b=tUjzAhglVxWAYmv7UArlyNc9XU+1pF1O8/EtnVInAxCxxj8FWJRtLqJp6LO/U1eVWRY1dMrNU59CokHxfApWAxpnCrTX8/U6G/7CU6xzSMzD8VvA+/2j4Ke616stjtx178umYhH80wSgD/KjRS50TA7Fkm0cfJvIkDnGdP39R6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828292; c=relaxed/simple;
	bh=fIg3YEalL2M2g2gfhkuZNb95cmhl/Se4u4uhkVU9dPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxx5t6yNHZN8ym0TSBns+31NJ0fcGbHOM8cNonOe80wXvlRjdKGVxZOr47Dk+vCozpg2f6VvMIXsehXADv79AapUyWbXZFDlXxhz4+mocJYUWFgC/uG8HQrRLUiEWoWF+6NZM/7bh38KigczFw6DnXycJUVBTi6nfnLCip1IUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlSpZiIm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30229d5b21cso13317201fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733828288; x=1734433088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5ZSfy2xDxDQ8s69afPzdWrhJXHaV4xhzcq4XiywxXg=;
        b=RlSpZiImkI7a1VsougUJ3dWooDzkka8kwhEl6RylBw0/GNV5hug03My0P0m1zRPIig
         KDeOExvNa5nwu09WW+SUqzxkDKD1a0qOnFamr5eKmYir5nHaYHxT/FXMMtX1E1jjzpae
         wb0rRDCg8PaWKvc+uD0MgfIAMR8YZr1VbHBotIr6hUF6+pXSOx51BQPrU8udSMtdY5mi
         iY9WFImtzNKOzhgAP2EzUBBKP9wP1SHn3Iph9674jf25WmqovFBi1qA8+sxIG5OdyZhJ
         vq+Z7UljA4nqUZA7Kseq8pacP+jdyovR2oNJvKd5cQCAgYhp/VZKTl9eWsCdjGukoj6j
         31sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828288; x=1734433088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5ZSfy2xDxDQ8s69afPzdWrhJXHaV4xhzcq4XiywxXg=;
        b=BYiyG70E8hvPPDfJMFtOZ9Zy/E9310cgAgPly3v0K9+Cu9AgQodS2iVBXREI7BWJYS
         EnzCBRWeA4uZ++WGSs46jsRyog5+7gxzInSI6UyrTR+dKRf5g8u4kJwvK/H4VsdBQnO8
         dokDRu7PC7LdLe7oudOGfNGjDn7epGk+WLgmcL1hmzn/Lv0C0mmo87dG7u6tpxVy0vij
         2SNB7cpZpkZoUIbXjJ7bEZDuHfhGsEDwIgDl+bNswT8tqjcX22zT45b1R/iuBSHyoFyo
         XeWJnDj5jAhHN+Yv+yIIbbdvwk/DUgt0PyVeT4o1gquwjGVp1ATNZVOElcYAgyxfQCgs
         QDAA==
X-Forwarded-Encrypted: i=1; AJvYcCUghWRJ+Hr+uSRJSnBTmmzuxoNzrTU+xfLiqex/5hthBy6r5RKK8QyV1oaIUTWduKIlzl33KDH0tQoi6Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIfsTORhEIbOcv9qyUp/UlD68BJMuqFai4DBmAVvCoIQIroiiQ
	dWHAm6doLPq61hjmDXoxE5HpHhbsypiXORL9poN/YskuhsSmGsbL1zQ3ZhDJF2A=
X-Gm-Gg: ASbGncuK0cl+m1q54mfKAb1bgMQ1E9xRJ8kawtAFKSBt6WBJU48Cc3YKB1mXW8zdxWo
	O/mQtlYf5sdI9PHr+SLGosR4YxGGOk74AAyjTDcEpJFeJU22IIe7J2VsivYP5H7KACvyfjaNelU
	yXOoyfT7wc4Yn4/9W4+RtBDTRzHlQXkrNXxn28lp2vbkbozoQ6tb8s5X5480F5AhqLn3NMC++4s
	T8y2tL20imIIKCxwop9jG+MfM+9wVS7IHzrq83s39VzRt5znMS+JRk5w34qYQZIVfwmnyuY970J
	S8PLZ+RqRTEJ6JKaSufLkJq2M7FGu4+K6w==
X-Google-Smtp-Source: AGHT+IE7+ryAMqJtCxAuJvc/qOGq5Ck0ZMSjTv00rqBtwofn1LyRnlQNhWyrc/EQiBZpPjSjCdJE+Q==
X-Received: by 2002:a05:6512:238f:b0:540:21d6:d681 with SMTP id 2adb3069b0e04-540240c0f47mr1559055e87.19.1733828287631;
        Tue, 10 Dec 2024 02:58:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3855a6b8sm1232351e87.69.2024.12.10.02.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:58:06 -0800 (PST)
Date: Tue, 10 Dec 2024 12:58:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Liu Li <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] drm/msm/dsi: Add support for SM6150
Message-ID: <3cr32yulhhnruhi5cf4agxxottt4ofnwbnwjqv6ib36ebipswd@qhbuhoejhjld>
References: <20241210-add-display-support-for-qcs615-platform-v4-0-2d875a67602d@quicinc.com>
 <20241210-add-display-support-for-qcs615-platform-v4-7-2d875a67602d@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-add-display-support-for-qcs615-platform-v4-7-2d875a67602d@quicinc.com>

On Tue, Dec 10, 2024 at 02:53:58PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add support for DSI 2.3.1 (block used on SM6150).
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 ++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

