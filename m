Return-Path: <linux-kernel+bounces-191582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D068D1119
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78BF282B26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED518828;
	Tue, 28 May 2024 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqiLjdX1"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A671C2E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716857157; cv=none; b=IOBIIL6Ue8CtVLWvwnd6/hBD0kp7e5Y8fDqfsaTCW+zu2bcxv9EtFtlF3VUsR1uTtT2ZRbrGW7aGPx/S9czz1qTULJueslOCYzGkPHd3CczWvbfBwJT2MYg1D92QAuZElfi9zoH1kNl/OA3Sbwt88+2Ydun1CYetiXbAEADetRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716857157; c=relaxed/simple;
	bh=jVzkGsZ65uCHxBCV02bXGkUww6DDsHNwUbBPAaY0jS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEb6Vgura/hq7qlaHZYWnoAQfhg68oK6tSaCb6IBOZGYOJkl5jvqKpvX0JcEFC0gCNwZHJI9bgWBZOjUI9FxGmW56Kj63vo6EnUh2uBT4jvIxQ7XXbOTFLFX/f+LaDv8eyJhs+u2pR1un8mXrEhyZJL0Ctml9R3q77rL6wUB5v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FqiLjdX1; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-529661f2552so335582e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 17:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716857153; x=1717461953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOWy7EeQHptnyQiZmhO+uVmW6cGOWfsT+AnLGJBX70I=;
        b=FqiLjdX1ksbl9Kz3S+P27hgGF46xSe9zXvNWusB8ccvSdtwl84wqlYQAXOOwnVlaYv
         OPcP1rir8/hqOwnCmXwG6/dfd4cQv1GVNRGh7NRWya9vH2waX60xhD+zVCfws+S1o2a4
         RwYuauFP/nd7uA4LT1mbwots7iItQ18gg7LVFoGmFEINyJQswL4LVoM8fDzEpm6mUg9p
         TDtquDPm+t5/daka2Nv2TZxJIHYyi4JXqzMgu4Q6tBNTHcd9aYie0q7rlEOAO21qznmo
         SzLONuTah1+002injP59Y1S+NCmfTVaPjxbXpwcCh6TIRk/ctN0bxWj9txsfGqBcXCK4
         WWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716857153; x=1717461953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOWy7EeQHptnyQiZmhO+uVmW6cGOWfsT+AnLGJBX70I=;
        b=OQl/K7Vd1p8xnnII4+1D/6evXksgrAxObduSQHD2kZDawL1yGnDlEYRtSh2PGYp5QI
         MaYJsYXrKuOpn8O+Mk/rF7QIlu4wEM7ZLQzxZDp0rnObnk/bLhoLvy5G5pMst5wy1dEs
         G7z2nEE/xdfZAPfY/1LXXWlI6H5DVj2pTxTgfcQsJIq1Q9TDEQoBEFlEniRFuhw/FQaJ
         ZKZrbiI532BnZWM60vV5vGIigAHHUmd/LXa/W+ByByebPdUVyfvmfFn6ZLFE2eAMheRN
         fObAqbaW/h4h+LIxHotwlZiPjqEvUDHX4OOgvNfcJ/UuQKX1Y/DH37K+Fs71iNzC0Aym
         WNlw==
X-Forwarded-Encrypted: i=1; AJvYcCVPoJwkPDkfZz7rPPCOipwPxGNIsZDJtHNGzO9LxJRLKkSxHJE1eqZi3fG2sU8OPTC51a67vF/u/znqhCw9YCBgy8JmhBdIvQ4C570F
X-Gm-Message-State: AOJu0YzlVAjzuuxkJtFkr8ezwHMwOhDVh+49SdWzAghZG68dn7zezIat
	2jX4EUmwf2Owdk/tAfx/O1fcGZe5KtHIHJ7WNtF3GjRRDsO38zpNDu1rqCEhH1w=
X-Google-Smtp-Source: AGHT+IEeVOq5H+mPCLvlXwPGTkXAziCy2DXE3RRA3lEao7/kITRzHNGqTbqSesNqPvwwhBkkwxU/JA==
X-Received: by 2002:a05:6512:2387:b0:51e:41a1:4d5 with SMTP id 2adb3069b0e04-529646e363bmr8255722e87.9.1716857153315;
        Mon, 27 May 2024 17:45:53 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5297066bb04sm812775e87.142.2024.05.27.17.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 17:45:52 -0700 (PDT)
Date: Tue, 28 May 2024 03:45:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jun Nie <jun.nie@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH v5 1/6] drm/msm/dpu: fix video mode DSC for DSI
Message-ID: <w5qtzevizjq3626uzhdnspefnojcludcdrbcbxnre2fxjfdei7@s7yqvofew3tu>
References: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-0-f797ffba4682@linaro.org>
 <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-1-f797ffba4682@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-msm-drm-dsc-dsi-video-upstream-4-v5-1-f797ffba4682@linaro.org>

On Mon, May 27, 2024 at 10:21:47PM +0800, Jun Nie wrote:
> From: Jonathan Marek <jonathan@marek.ca>
> 
> Add width change in DPU timing for DSC compression case to work with
> DSI video mode.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c          |  2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h     |  8 ++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 18 ++++++++++++++++++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

