Return-Path: <linux-kernel+bounces-513438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3068AA34A49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAF01897088
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1075124A073;
	Thu, 13 Feb 2025 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eclslWL+"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE702241699
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463924; cv=none; b=euOm0J6NudPEz8mpjxNAuj7eIavxSQovYhkU0WvDJmyYi9/7z3FOlRZfSd08jBaGRaYvNAiGfZO7ltJInziL0Mt9YP1geVONkYAjjId6y8bkG/nivSXxYoFlEPxMQ87ZeumWkbBZVCEIUBsVA28Qx1uy5UthsmBPYa29+NTgzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463924; c=relaxed/simple;
	bh=hMCwLB7+OBaZ5P4MNokRsNDc+YfKyQ578hYF//of3Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBEYTYsJfRC8nVUbmidbKqoC1cRt9rWtQXdvF32954fi+63GJDbt6psCeIMjvyKYZClk6GM0kK7dBFcYKh1NTueNGMdwa86fF7ghDOepCxrSJYwtkJzV6UNly6JRxj+tfNiUeCn0THH73HAHxspLM5oFfOJoN6nII38s79aseKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eclslWL+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-545097ff67cso1078114e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739463921; x=1740068721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cSOs50TsU4X4YYQxYbnAMJ4ehCd3Gz/LqOB9FsJlXcU=;
        b=eclslWL+K3mR32rTsTqIuxKgj1NAIx3feKv5jGhQVbaHBMBcJ8T9oPsCNksipBVnXm
         uiJhSTHVoUFzrEYeyqYHNMs5w5JR+kyzq4uKPPe00g88JevPnn7k3J5KMf1JyVSZD5iH
         sRd+sLCDvuEwI0oWQZ9mYybSc9MWWPrLB61IivsydvKdT4LNlYAvPZMw+8OC1zI/jxJf
         ijb1F4sql01Og4F+ig1SHxenswtLS56JhhyrliE4lxa4h9MRlIB9vVt36a+yXv7gohxF
         6HNcLOyKYCS26bsTUIU+oTjkT6zeMTgMBenpL81rFN/B+YDI/uQUOpkaijt0K5oAuoL5
         zOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463921; x=1740068721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSOs50TsU4X4YYQxYbnAMJ4ehCd3Gz/LqOB9FsJlXcU=;
        b=V7Gfn7GJ4HJ8puff7rmDZhdoA/zt0OWWQ9Tt1bgelJybpVqqu+ijNyXKSc7Q+yWRG2
         iKfOpFiBNyU96j8m05RMzYSmsJketTBUuQX76PJvAYit3XRFUiFH7CG6g/B/1E5KPVDY
         HpYxQFulEsK/WeQHbMQtXzfHtUlcVCBd6yjTmAjxyNFC1LL4E0OUASKHWKjsq97cx6sP
         mWavY1HB0b8K7B2pFYMZ6uzcdmn7R+5hC5V/nv++fJ8F8Bi0WVfPpW/tfqll0/zL0v+s
         60KK6jbKH/KuEiyNWQvdSnCZi4kqKUNCz0hg5fRQsbDnMduyhsI3J2QjQJfXho7ympcJ
         sQMA==
X-Forwarded-Encrypted: i=1; AJvYcCX4HIREYJDp+TPYgRXNpynDIPFBjXqPM84keLIVfgw+0k1xOtDm4kvEDpTOojFF/oQ9BjETGECh30igABI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVqWbBKg+z1zUgovQkWL5meG543K7BpxqKBdcWfHeddXJB6Wf
	YSWwSMBHUEHMptJ/XHxPcSYU4VH7Gjo8KMFDZLtmGLKcL279JkJatfw6BZPqkBI=
X-Gm-Gg: ASbGnctP99gO0cZ20gzP8IGQ4+VgPr738bvR7CnpmIjRlLW6q7OVElmr0fHaVKg+A+a
	DkMBLMDRmxZJrD+JwMCaPWsR7QU+cRzqzO9Hl7AUUNnbhSK8+Wvo9jybl32D54Ae0tnQqLHOTtE
	nBFkb0XUh4yVSAsTylpKTvjBQBzpw/7Puf8Gn1jV1AxP78Darrg4bkTnNpjmOUStTmAIV3vQbtH
	YuNbAFQ1TZ6DoYo+n9hkqCuNsMRFt8LcJZAZBj7r6YZZYABtosDBNxFYwP9dmMcMJ1XJabnbshp
	LpolL1IeKX6DDFsKwihxE2Ef36mtgdnK/nsZmtPh/MvcKRt2aWrxAb7n6YND6E2PGMHVPoo=
X-Google-Smtp-Source: AGHT+IFChiazqWx/+2a2ZIZUghuFgsnsSdaCX/3eX3urzt33SaYJfC4xuJX7c2QAEv7EGv4JsO+x3A==
X-Received: by 2002:a05:6512:3f25:b0:545:6ee:8396 with SMTP id 2adb3069b0e04-54518282967mr2782235e87.13.1739463920795;
        Thu, 13 Feb 2025 08:25:20 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f11ea5asm211876e87.215.2025.02.13.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:25:19 -0800 (PST)
Date: Thu, 13 Feb 2025 18:25:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 29/37] drm/bridge: Introduce drm_bridge_is_atomic()
 helper
Message-ID: <5afaezaqggshwmcclrsfgnkd3kgxfhrspimqt2hvan35lsoz74@w4ytuxjgtqrc>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-29-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-29-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:48PM +0100, Maxime Ripard wrote:
> We test for whether the bridge is atomic in several places in the source
> code, so let's consolidate them.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_bridge.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

