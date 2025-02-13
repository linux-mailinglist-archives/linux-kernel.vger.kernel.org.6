Return-Path: <linux-kernel+bounces-513473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B57A34A68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400AF7A619A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226B28A2AB;
	Thu, 13 Feb 2025 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJKljE9y"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC090211468
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464812; cv=none; b=H/ZkKfMfsUmxfSHJvgFW+C45hbYAyp7vNeN/vtsAzp2LS6bg1FQIfj2+O19vzqgGamfx1jAifiA3iUxhOKpNI9jqwugNF0hmiYjKlxSt97v9ed7j3LU/x6DdGriw/C3jkNApNFM5AnqZ0eYtRPqGSpY30KonRem9MSVytHjEvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464812; c=relaxed/simple;
	bh=JdREVv43W+KfWpIFww6y859yPw4j4/2xklu50TDtis8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ealAPX7t89ISxWCpR4SMxnIjsT16xgASflyh9MIyq7yTfp+1aTv5lEHxPbjbx/9PIpWgtt0Nd5cwxumYfbKN1c4lHms3sBJpo5ETHHSx/EviRlL+21d9He8MNUfR1ywbbMIok1jWcNrPvHg/kfAjRVmawSgX1oz+ON/jR1VzRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJKljE9y; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54524740032so112537e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464809; x=1740069609; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jEIQ3K/3iDZAyHTodK3+6OTlBYGjys5mtHQuCkfEBss=;
        b=iJKljE9ylPTeohI9iIkctmCj5o7f/y0duKOC5CK9MucvvVG+WishGiXFSbDy6dkIWi
         psbEhMXn0A7ZJDuVLpNlwXqcUYSqPipW2BA6L77l37zHmGyBy5/rb9isjo7vzXKXIimb
         6opO+CumyBNU3ml29DOSwTJS5Mr9u8OLqCBbm6S5gOLaOr3HSKlmXoyO9Gne61iPaMiW
         G2Rhf1ChF06b2ET1l2ZHhKtHDlIqAbglwacVVSMzlwOh9bPNWlShxR2Zq49bYZt+sjSx
         wJQW+VlOEEc52jSYTKl8FuNx8gpDzecDAgXncSv/NML4IHH6NsFfxRJvT85sGXHh6RAK
         AYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464809; x=1740069609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEIQ3K/3iDZAyHTodK3+6OTlBYGjys5mtHQuCkfEBss=;
        b=A564rLtO+e01drcJgMgHcul+gc1Ycj7pUq53vPhJocG4OMmuQ02YA+BDMvnV1n2giG
         L5EcRFBxA9TeKjJjLthAig6kazoh48tTv9zEs4SbQCjmosD3iNwYhHDuLQ62j8ha8li0
         I6SGRw9x3nTkz6ap2Ca+6GalYWMhBJByi8whWyfN/p9nJft+ObSr+q/lK5Ksn3mKQNdw
         mAnsGZDFwpOOm3AXiF0bpXQgpQZjb6eBa8VGOfMJUolYhGF/EvUy7n+Du/Gz4ehDT0Va
         t/dCx8AtiZL6bD4cgmoc1e71dOVerQXoxZNO9IeZA34JhxnuUKFV5KK7gG3+7aSFHzHV
         VAkA==
X-Forwarded-Encrypted: i=1; AJvYcCVHvxJYqb426HuEczOI8gyUSt5Bs4JBYtRbMGUxiiL7gJ8s7dFb25f+CVtFRhNHU8yy9A8BuqKNdz2m7S0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3aRz/pQSgdrMlPXCzG+GdC7a/bXUB7R5jNMhD5dtdNGesyv+
	xm2xg788bisYKLm/U4+j1JgnojIsuW1ehwCBVSSGP8Xe8onkNB4rGTc7u7E362M=
X-Gm-Gg: ASbGncsh24tGna6LgRkLyuRZlfmz5FgmOI6GdlIXak/ooR07NoHFQWXIsT5NXRSwjd/
	pNCjNnyYFY7pAcjxipSUZoS03j5arOa2Mn/Y4Tf4sq+2SbirbSLIDRvw+Q78aGp6BG9lPTR8p00
	xfO3Jeqzuc1q3GfB6Nq4S+9wNvGCkgkFyjujwyRexdIzCZvuj0OdgIFHSD671BHnudunId0jxfX
	9aw96GAUZfpI/UmUzBNld9C0OqLtaXQry7wsfOMZ6QeH6r6xrREtergvOmtgCn2TvZ8B2iR7ybI
	TqpjHBLoAWvtvMQCmeUnZqpj16Dgewm25fv9PH7VnAOxJ0TcKr+Q3w77ScUfZTEn3pCjVQw=
X-Google-Smtp-Source: AGHT+IHF6JYg8o9iPAbhowG9brKPw9OQ7bxonNwRfn7MOY4iIar8pyOkUt+TuUgL4bBtZ7bJl/qq3Q==
X-Received: by 2002:a05:6512:ea6:b0:545:58d:9dda with SMTP id 2adb3069b0e04-5451ddeb4d6mr1608127e87.48.1739464808737;
        Thu, 13 Feb 2025 08:40:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09d0d4sm217697e87.100.2025.02.13.08.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:40:08 -0800 (PST)
Date: Thu, 13 Feb 2025 18:40:05 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 21/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_fake_vblank()
Message-ID: <j74s4po655dtjcvsweijgdcfktalceenn2mh5ebkx6wuostaus@st2m5gf2o3cl>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-21-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-21-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:40PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_fake_vblank() fake a vblank event if needed when a new
> commit is being applied. It takes the drm_atomic_state being committed
> as a parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

