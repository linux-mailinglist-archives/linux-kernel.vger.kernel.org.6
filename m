Return-Path: <linux-kernel+bounces-242413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B09287B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DF9282500
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE61494C2;
	Fri,  5 Jul 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="en8u6fjI"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87260147C9B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178396; cv=none; b=Rz/b4/7T//NYu2BvzevRK/ycAle8HU+bpHL69PPFUyZiiQFTES2iRgWiitR8A/hJhNV+zghFm8XdurhwU7l+jfkOYAdm0TXoBakCCJ/plms0LeavHOAWbJmEc6V1efOkl0HKG9KwH+4mmyJ6XtHcMQ4UpXUp3FV2ufFe6kwoxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178396; c=relaxed/simple;
	bh=Z9mXRU/ZC358TSn9Mju3iFWA7QFL/Zj5dSI3IHvRpN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEDsYt68h9Mjn62aIOWuAbKX/1VYRWnI+x7SC6dw9uuIRdtvIXgRNPPkBwPJL2/oOwAC19I/XbnjJOtcYAe37mL1EEyDsxgsQVzjgVUZABynZGxJYZQQnL5SUK+O/blRnSoozmiSQ4EE9JGoTzOMDT03l4kU48G9mnqtYlHKfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=en8u6fjI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4212b102935so1627115e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1720178393; x=1720783193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRlQ8AlnLhBKW/e+W7V++lZYUKpnkva2hJ++8rdmz4E=;
        b=en8u6fjIFJTo4bOmYr3ZaEkwgVpKBemRt941L0eqUwtVGxfQVRpIkVswDOHf/jBH6+
         yIgpzS6TtuzpltgWe1oLAUbAzoo66tGnaM1Xdp6ctE8vhvDRHWIHyoe1JyLtdGMO08EF
         +GAtYpyOgp438Mx3e8jGgSubvjpPX/BTRu8kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178393; x=1720783193;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRlQ8AlnLhBKW/e+W7V++lZYUKpnkva2hJ++8rdmz4E=;
        b=TxaRzOrwNtNW4392eKKI3tb7KkKVXKP1R/KmZ/mh0Mexm4ZUMY/mS98WV+yFj+bN6c
         0jLavsajYRCEr/+sCljt2UDaHyp4Vxx+GBtl8i6hWXo3jcCwjmXa8FXN3tSH19QlC7+W
         jYdALRGFshcv0w23G1HcyD3v4D7GSf8cLefTJ4G3K7nUmk/8JaZP8aNaDiNkx05c2Gao
         Q5ZDLLGpy/vHXmbKrnE4KeOUvoOVjZYGHyTwWyuIi+sdHeZuiunijUZYMbkKNIhf7hCg
         mIOzl9Lpc5xgvWHXEs9vVUn2wuTBeDlG10q85RZuBjt9DVN0u5JcSmEIDTIggngzgiQ0
         F4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrffVWXqNyFLs3FmxMOpvkwV8ngFaFsw0W7SadpY/6YhRQA4T3xJAEhAJU3MNvQ3Bs/Zh2PIRDiZkHFoFWvK1InDMD1pisERlBGiU1
X-Gm-Message-State: AOJu0Yxu9Ku0YWm+d8UX5wZmpqgJMn1CnDtf9LKtQzFNim7HGQuHkI+z
	awbcSYg7EYg/nKKWrTi0EFMV+2dLneokoCQxaJdYLsvcqYzMj76ethvzrgsGjN0=
X-Google-Smtp-Source: AGHT+IECr35g0yFQB00KYk1wD2jMjl5S+5iSXH9l6xSpc5QI9GNI/J64xxachpK9QXdoYxj2ZKUHZQ==
X-Received: by 2002:a5d:6d8f:0:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-3679dd73cfamr3178927f8f.6.1720178392888;
        Fri, 05 Jul 2024 04:19:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367947ddebfsm6221414f8f.34.2024.07.05.04.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 04:19:52 -0700 (PDT)
Date: Fri, 5 Jul 2024 13:19:50 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: drm/sti: mark it as Odd Fixes
Message-ID: <ZofW1v4uEFo9GscF@phenom.ffwll.local>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
References: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
X-Operating-System: Linux phenom 6.8.9-amd64 

On Fri, Jul 05, 2024 at 12:03:56PM +0200, Krzysztof Kozlowski wrote:
> Patches to STI DRM are not being picked up, so even though there is
> maintainer activity, it seems that these drivers are not being actively
> looked at.  Reflect this in maintainer status.

Note that since the driver is in drm-misc, other committers can also pick
up patches and push them. Both Neil and Dimtry have commit rights and
should be able to pick up your patches for you, if they get stuck.
-Sima

> 
> Link: https://lore.kernel.org/all/77b4e4ad-2b1e-4b6d-bc3b-0c7b339bc295@linaro.org/
> Link: https://lore.kernel.org/all/f207b481-f530-4f54-a482-218908869050@linaro.org/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8e16a649a0e..f284cb8db544 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7595,7 +7595,7 @@ F:	drivers/gpu/drm/rockchip/
>  DRM DRIVERS FOR STI
>  M:	Alain Volmat <alain.volmat@foss.st.com>
>  L:	dri-devel@lists.freedesktop.org
> -S:	Maintained
> +S:	Odd Fixes
>  T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
>  F:	Documentation/devicetree/bindings/display/st,stih4xx.txt
>  F:	drivers/gpu/drm/sti
> -- 
> 2.43.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

