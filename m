Return-Path: <linux-kernel+bounces-434630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A863C9E692C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA262820C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1D1DDA3A;
	Fri,  6 Dec 2024 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbpsUQqM"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE431DACA8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474483; cv=none; b=gP1lfUIoIdkT2g8UdLeqlmCXiTuXyBjyPTtHvIE6Dtrd4xyeQO+rUe/e4ZB66S0Kv8p8aHcwQK2/pR3jwuLFIIfonYx/SqYuLUgPpvJHYLx7dhX2ZOta9TrGe76J/w1B7UYdltfIBFXnlU65VfvOVY6hk69p9EObx0uKvzEHoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474483; c=relaxed/simple;
	bh=bcX/8gOs6XW0Ygt0hDstjuJt5JxZsVwkevrtwRWGGhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9BkVEUsa2Gr0xmmFuWM/j7F/Zu/SpIPJO8eksTLfJl58rnXSpxAw3fmR+u/oE0iOieBhdx20yxr/Pl9DSvUOhi0IBRrUF4DAX/MZ4d7j9OeDR+cpx9EapqneSYKnLj01MkiWtZpvRNQDIe7tsHAchNC9mkjLgqPR4RNZUwkYhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kbpsUQqM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53dde5262fdso2321870e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733474478; x=1734079278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=li5k7w3RncPwKsG06G6cusXPPrs5ee6rU92nmMBGwZA=;
        b=kbpsUQqMbo1umoI1M85Ld5epUYGoFWjMKKtpu070h+kxpeauKfrChvnUV38EwpiJ1O
         AtLZHeMfInS25/Vd8woICYkV1T8eU3ssnP/lG+f3vLm911JqwxjimIpwoyDKkQUz/n7y
         mCIVKsSUNS1ObsSAcVkVYEXdROuoo5n8GcSNbZl/7tkhrHiP0yNgwYqVbeSrwD+zGOoi
         dKZERMB3+gHRqlIfifRXOUTHDtY6CuReDCuGfms8B2lgo+iKjs4YC4bctPBI2JpEUnmV
         fs0L8rhCqD61sQCKsizoegNERQSIoVR7bernEmcB8aFhtoBU6I4yBGY/Wzjp6Wi45y/D
         ZIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474478; x=1734079278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li5k7w3RncPwKsG06G6cusXPPrs5ee6rU92nmMBGwZA=;
        b=HbD8u6ofBXUAiuPdw6mIoZwbwMHT12S3NfqncRFH+DqTEqTMdsGDl+LTiPSgl7fvCo
         3eplpV8vNvaoJgS+k7xiaet2kwUdF7ag1ROSeGCG39Qay926sMvXthPnQwq+wDsY/Z+9
         kEjhoaCqpQ4aRWKtiNz1X4U3QqdC9R0qcueY48FCo1E1hs+kUi9dLvCzK3csSjFPq1NK
         0ogVVMwbMX3YK4OKqFlXTjF3aBGXJKiDyFvzqfMmlG4CUVoID41uQoeGjACoOIxHBhlJ
         h0L7/jgE/bGU41A+jDz7jBfdzPpfbdhTTFuxifRDUZ6mB1wvxsLGPGvrt1tQHUY+5Brg
         O0cg==
X-Forwarded-Encrypted: i=1; AJvYcCVrYW1RWFxzI9hElu90FevIurb0sFxx2SeQHZkmY9M66xcM3gUzBds9h399DAi2Fp2KkTwnNGKv4gv2CEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCwePc1w/aibZGWRI6Ldpccx43L7gOa4QjFcZTI4u2BckzANG8
	F5K7noeqvqUjsZRzb/OIzP6fx8y5hw99ge+X/XXzleXKvgqci7zTO3gkh6MBudY=
X-Gm-Gg: ASbGncsrGk8ZMBy+5lxXb/aUsfl2mVv9CoG0yXqYnTOb51Tjhil6b3Y4A8HpAkeyJoG
	GfBJ1jzX+/4P9vR0Lnie73bA9o6QzdwFaQxwoFp8up1PbwJSFbP/v4R5DrfeXu2tgkxHWc+VOkq
	9FYcrjV2rkLTeEiGbRrYbVzTTTfryDmxvWSZlHQkkzu2lhZaOEPhtUQD04nyHsKpiA+eibZIqGp
	oLgSO0Nm2q3qD3XS2Oris/USBI5nWbwKgvI9KoBxJp+lI5jQbeBBvRCuKYPv9KG1/Hv6AB8wIfd
	thK4Vul5degoAYk8VuBp+lUQQ7Mifg==
X-Google-Smtp-Source: AGHT+IFPNVHu/d8sk7Z9glpuRmqa30hf9B+0XHZ+yeGqInSbHjdmC0Dj+A9i/LiHl6Y+WoYcHtnQtA==
X-Received: by 2002:ac2:5e84:0:b0:53e:350a:72a5 with SMTP id 2adb3069b0e04-53e350a7482mr349029e87.36.1733474478446;
        Fri, 06 Dec 2024 00:41:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e372c9228sm26344e87.2.2024.12.06.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 00:41:17 -0800 (PST)
Date: Fri, 6 Dec 2024 10:41:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 03/45] drm/msm/dp: fix the intf_type of MST interfaces
Message-ID: <4ttrd5nrl3flexsmlmlp2jdbht23lxsrkfuuma72nf5uknkehz@xpl3d3w4kjr3>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-3-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-3-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:34PM -0800, Abhinav Kumar wrote:
> Interface type of MST interfaces is currently INTF_NONE.
> Fix this to INTF_DP.

Neither subject nor commit message tell that this is limited to sa8775p
only. Please consider toggling all catalog files which are supposed to
handle MST.

> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> index 907b4d7ceb470b0391d2bbbab3ce520efa2b3263..2509e28e3d6b582cd837c6aea167b3f4ad877383 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> @@ -375,7 +375,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
>  		.name = "intf_3", .id = INTF_3,
>  		.base = 0x37000, .len = 0x280,
>  		.features = INTF_SC7280_MASK,
> -		.type = INTF_NONE,
> +		.type = INTF_DP,
>  		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
> @@ -393,7 +393,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
>  		.name = "intf_6", .id = INTF_6,
>  		.base = 0x3A000, .len = 0x280,
>  		.features = INTF_SC7280_MASK,
> -		.type = INTF_NONE,
> +		.type = INTF_DP,
>  		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
> @@ -402,7 +402,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
>  		.name = "intf_7", .id = INTF_7,
>  		.base = 0x3b000, .len = 0x280,
>  		.features = INTF_SC7280_MASK,
> -		.type = INTF_NONE,
> +		.type = INTF_DP,
>  		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
> @@ -411,7 +411,7 @@ static const struct dpu_intf_cfg sa8775p_intf[] = {
>  		.name = "intf_8", .id = INTF_8,
>  		.base = 0x3c000, .len = 0x280,
>  		.features = INTF_SC7280_MASK,
> -		.type = INTF_NONE,
> +		.type = INTF_DP,
>  		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

