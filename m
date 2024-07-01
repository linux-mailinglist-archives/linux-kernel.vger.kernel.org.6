Return-Path: <linux-kernel+bounces-236943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AC391E8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7719C1C21857
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E898416FF3B;
	Mon,  1 Jul 2024 19:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+FR/i5n"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9C16F8F3
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863383; cv=none; b=Vzf9ZTJQFHT2q8Q/ePfkw59HKUZbsAp606CPw0G3GNFLXA56HlvDS+yKam6VgrFrbz9sorgRiri21Ghy+R7bXPdcuW1e3kK8lFsdVb3FQr07Pfy5Q33sHpBUB31y/YQ07bG/ZRKeSf5pC0o6xFr7Y78vdyZJQ7ZqeJAbVAnUJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863383; c=relaxed/simple;
	bh=pqI7V8vQsOtiU7I9Y39/jsazWXej4pS00F6++ibavZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAjsVIxuu8uJa/k2G7V3m/nmopILivCdn3xnjKGxA/CLgq2M4j/oD1yaFX7p9Envb4PEuG+ouWsnen4bbk0WXyeossPdbSYSKqzokm+cBHfIs4+L4o51CCyDo9WvK/sNeK8XJlytp+geO1ikxZCzZDUiauWAkvEHmm1J9C+edqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x+FR/i5n; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5295e488248so4367442e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719863380; x=1720468180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/klhqOqQpfIffOoQHl0HUCf3/QjQJt9wAB8xWlns1fY=;
        b=x+FR/i5nOfFduDxnDDca3tYWn2A04Dzn1gaJl3b3nquNY8Cu+HgPm0PwiFlaHj4JKV
         qXDtFHLrvB2IObAOD2ZOw49u2XXKueSO/Cf7+HLAzZvVLmtdnNjPVFQ3tWBk4Gf21uFy
         sSP4rPBk4kUfBS4dwWXIL20kFcgSskasMYS9/VMZitBW1i5DxUwWzttCcJIVHybrvK7O
         did2w1UlhWHQoK8OBG9FXy0IucGWG1Ws0QrE57TfKTv9EJEZNFwEUsQYEaghb1LGRuBk
         0X2SplAhkv+ju/dULwcNUwd/3wjfOHGy0Aq7KXAi6AJhkV9G7GJwiLw26wh+D3DWpET6
         Qh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863380; x=1720468180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/klhqOqQpfIffOoQHl0HUCf3/QjQJt9wAB8xWlns1fY=;
        b=LpYEUZtABbU2MS17D4n8Bd9a2kxYS+fp0Vyc5Ku2ukJEay+cWQkMV04E5jk3Bb9Hxq
         uZV7slBDgDcoY6gngUyxGoNU6+ZErJxtxFNH+rupdQ7ujYFoWl7vzf48e4gtZ2GpFKyd
         190KfIvF05S+GI+611jHgLoYb5GZjg1+wJEaQjAkLw0WYGgB0Fw2ZsisJR9f8Ub9UjPm
         J8QbUdUI92AEDix9+Ozafjpq0BM6apfNFVrCTfm1fRESFih4dbM+msMwQH/ZPcfkFl6h
         p1KenmFnjXPfCcM4V28OEZehG9wQIKczVAWNM2d5lNwOBHrgw1Ud5W3eo/pl5XVlGPiK
         8uIg==
X-Forwarded-Encrypted: i=1; AJvYcCV2T4DE0tq9O6Je4NOL3TWMIpFRov3saBiWutq0g8FBCVzKMC1yzdZGzYSEbNRxIGVJvO/AXDSXmGE2rtxMRW02VyWs1fqQBwF7015D
X-Gm-Message-State: AOJu0Yx3qylgh4e50IGm1S03OQPhfy2xK4s3oshlQcy+nw8ZlBa7AiID
	5r+eqIT192sFU6Iqzk5wP9gl5X4Ig8rP/xx/NlZSdEMLkJ7y9HVHyAhrs8WY5Wo=
X-Google-Smtp-Source: AGHT+IHJBGPp9DoIDMpnlZhDen1TE3XHx0LDJutjYa34E6KdbzqTWgJM1qLlNf0PNE3DaT98F8B0kA==
X-Received: by 2002:a05:6512:3d91:b0:52c:c1aa:dd52 with SMTP id 2adb3069b0e04-52e8268aa24mr4398960e87.30.1719863379680;
        Mon, 01 Jul 2024 12:49:39 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab3b3c8sm1536851e87.292.2024.07.01.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 12:49:39 -0700 (PDT)
Date: Mon, 1 Jul 2024 22:49:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dpu: check ubwc support before adding compressed
 formats
Message-ID: <yyoh3jpsc5cy3h4nu3nhnqdv52ajljjn63dzewyujam7d2scgt@j2mmtajldazc>
References: <20240628233927.4170966-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628233927.4170966-1-quic_abhinavk@quicinc.com>

On Fri, Jun 28, 2024 at 04:39:27PM GMT, Abhinav Kumar wrote:
> On QCM2290 chipset DPU does not support UBWC.
> 
> Add a dpu cap to indicate this and do not expose compressed formats
> in this case.
> 
> changes since RFC:
> 	- use ubwc enc and dec version of mdss_data instead of catalog
> 	  to decide if ubwc is supported
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

