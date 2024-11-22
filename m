Return-Path: <linux-kernel+bounces-418089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A469D5D07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4542860E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483381DE3DD;
	Fri, 22 Nov 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOymW9Fj"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFE1DDC3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270137; cv=none; b=XChOQMLTGoELAFsYRFAFxQmya3Rei0YqXDlyhnwyT+9E/d5bwHNX0l167RFGRpsYoNeK5TEG4Z7iBY2SSjQogllElXZsEqOPB5vMSIeepoOzG5iF9yeRZ472W8a6um/tPOdohvYdO5akBNrrrTwsSRleMJU3xyF+wfeMPGts+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270137; c=relaxed/simple;
	bh=MjqTitXAjNnGGAR8OCd71W+zJSsqvxNeq1iDDW5twmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2/uba6Nw5saTgzpdDLlMWlyBfpw91Z8K2sX6+yLSkhxaaZ2z9l4V+KGMjAgNM1JK4DxmRtMY3E3rB8Q3+NGTg+ix1H6B486NxFYwhc/9X3efenRT+RYK8PHjTQ6jcbUTRho1OQr7S59B9mRfJUEggbkbCk8T+iJRocBK0GMZ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BOymW9Fj; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffa12ad18cso17812601fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732270134; x=1732874934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ozG0xW+TN6Pi4dywPncHsCDjL+EQbVR/bZYS04g6N7o=;
        b=BOymW9FjLbO8ie9ZU0Oxvypb5qmmJCThzNAEr9eFfidt8mBiOg5gFDkez8pMjF0uaC
         5Bus958WO35FZtlDrPpiXQvZIXbOocyk35z4xVc45vs4gWJZn9iimmfW14RBHUyQ+fHj
         BU3ShADWbQf0433492sA174BTujzHZ2A3sBkk0S+ulq4mj0qkA1qEcyvEUsni6XIfAo9
         3uUA/vp/OPfjsN7/fVVcD6fxH+RaUdxR5OiFdpsuIAieN6i8dHGj3N1L5SYOoC8YEJEj
         IdUOR3Se+hipzYSStQdzq7CB6IdPOT3ngchceccWKKSDGjBos+1bBRH7uUiGk1rs3vpl
         hFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270134; x=1732874934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozG0xW+TN6Pi4dywPncHsCDjL+EQbVR/bZYS04g6N7o=;
        b=P/9eYL4NOjVidnWWf2S7a7S0fVtamamXJvY8ae5HhiOZSfXWVayhnHCCYkPAdZUdyq
         uQMmtBfyOJy0Xfo7Ld0Lc+1XmTnJT71M05Gc2bxR8c8C45Z362eBrpjBuVzR3/I88XW3
         qEZu/gUU8m/rK/RE+BA6Kz/aEndK17Ho9YWgOzk2Yam7dx9uafrpGJNKzWSHj9Yn1RPc
         qYQ+m760nox6V+4Is4t5WjxPqejwu4aE8yparPOxmucsDXt/x+Jeoxoh3t+F8TDwdXOy
         YOYjHv6o/Om7RBBjPkngXH3cnzc080V1ql91eT5QxtefMUJOtMpPwz1HfQsVnPn324J1
         kUmg==
X-Forwarded-Encrypted: i=1; AJvYcCV2+Zy0cH4osp36f9kcpZxDuYfhWi0ikY0Xi3cGCABgaybAFLcce/65dwSZ6c5qT2J8xGn0cQZUCwNpbsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHb5GPRNGSYqwNn0bUWQIdrZu3/+pCXKG8PoOBhYRppSbCPimq
	P01Ws59jsT3atDgWa4m7RYfFTWqOQDvN1x2RsYHuuR8AFvteAaLSB/LSg3yQC24=
X-Gm-Gg: ASbGncvXGNIkNW50fvn0bDm2YWYUlyIYd+4CUwQu31eUl+2leEf7NJW1ztXO2A61GJ/
	x1vBCXwWpuPwtbGF8oR43eqTw8JRcozvTf3K8Ej5T2i0jCZNVmAR0qfBNMZuQ2vPTyar+4HTa3d
	GO6PmcFGykp18LYciD5chEIWmRMwCjeEZTwQhgvqUXWyN8NlpoJiJUmKhgn3xQi9iC6aHHHCSVA
	gA0DpJWo3ZGMrkfIcvm5fXmDq0vpo8CZJvZnLpQ+CUM21PJ/pw0Ov34DGHqr/c+vKDs2/OH8SAB
	Y6RpdLOwjxJWu8sh7oX0ikxqG15y2A==
X-Google-Smtp-Source: AGHT+IF1XEF/8Gyn2P+dzKuFrYGukbKDM9XOQg3PsZRAmJKFMQcRvEJoruUPypP/45RqggGEEbK2gw==
X-Received: by 2002:a2e:80ce:0:b0:2ff:a8e9:a64a with SMTP id 38308e7fff4ca-2ffa8e9a6e6mr6070311fa.6.1732270134081;
        Fri, 22 Nov 2024 02:08:54 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d58592sm2762491fa.68.2024.11.22.02.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:53 -0800 (PST)
Date: Fri, 22 Nov 2024 12:08:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Fange Zhang <quic_fangez@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Li Liu <quic_lliu6@quicinc.com>, 
	Xiangxu Yin <quic_xiangxuy@quicinc.com>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/9] drm/msm/dsi: Add dsi phy support for SM6150
Message-ID: <nwgfas7oxaumusdeoaheph6rj535szahfkfnbmv55y3nhhmf5p@3gg3ddjgaysr>
References: <20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com>
 <20241122-add-display-support-for-qcs615-platform-v3-6-35252e3a51fe@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-add-display-support-for-qcs615-platform-v3-6-35252e3a51fe@quicinc.com>

On Fri, Nov 22, 2024 at 05:56:49PM +0800, Fange Zhang wrote:
> From: Li Liu <quic_lliu6@quicinc.com>
> 
> Add phy configuration for SM6150
> 
> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
> Signed-off-by: Fange Zhang <quic_fangez@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c      |  2 ++
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 21 +++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

