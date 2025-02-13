Return-Path: <linux-kernel+bounces-513474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75306A34AA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6E189638E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7615122154C;
	Thu, 13 Feb 2025 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRINWV2U"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3342010EB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464832; cv=none; b=N+6BJTNTLAizbR8uotld/85FgprmBZP5c44V8YR8VgR9i0BXzCp+AlNTzL0ILqpQcH6YaBu1ZQOIAGRewOW2+SrlMrCpIYieR2fZs4zMYX0lohsx+AsIh12pDeg9qkYox6mSTyKLmH2C6wpDVebQXH/kAcPnf6PV1HhqNFQRj1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464832; c=relaxed/simple;
	bh=xXGJUKydPnw7s6+HVPYedw4NVYPLzatImh5oWihUqpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JH+J+5UneI5FO9Oo5U/S0ibOrbWKpGpsjmCdmiI13Qrco7C6B+9l4E+95g0h+cMx7DgZ+tJAZy4PyyeQuc0PUg48fZN1MCGSSwpMkYlyIaf4AvHK3odacX2IsiYdgou6nhv5rE/7E+qi/o/jdEPGha1EZtzNZqG1nWrDv8xnKYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRINWV2U; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-308ec50eb3dso11430481fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739464829; x=1740069629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qraGv6mGKYKyl8rZKkkq9STxARUxqekP37EO+4rOhdU=;
        b=GRINWV2U4zlWjpTS8MQWC6suDCZVIxaLNYxCVpcoZNvmOKdRc+AaZ+3k79AH8Vp+wi
         0WQZpd1Ui+578cyufBRYRMxxn0IOgjf6oR+Iqht40p/hAFM1YYh2goe/GZ9SrcvGGlA/
         06wn3UnoA/RIjLZ6nGRBCcRq5fGV6c5rSCJeA51ro5T64bnj+6pC1RN0NpHVAfrT/A/q
         FX6wRQ/0tPJSj5a+6WWAcFK1UOzsuNk8q/XqECSXeoe2NCwH6NZRptatW/ZfQWXtPaC4
         bnt/qktXvhE8XTeQukMnU1yRs+55uhhMfWMWonRGKL2ieva+N/ZLiB1Mkvu/SDm10rLM
         Esug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464829; x=1740069629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qraGv6mGKYKyl8rZKkkq9STxARUxqekP37EO+4rOhdU=;
        b=QNHWZrCa8TdbcnU+XKU9hmIJn3SXxYFFhWm6iWSFt3CIf0+c5efbOi7HfDjz4gGxgA
         2YPXHRXNbnHinOluw51f8Nq/jU62i3H/CGxOzoUbXQaNQ+r29VltIkSWAajPUEGSrAUW
         0j3f7RLJx7N0Omju7glkDDLLIEdx6Pib3WykkprZmB8oGN0uAfQ44mHE1GNTV1JxDmyQ
         Xc14B+EO7RY9a4nPj5W0hpxI2K+ViAsrFJah+LO4NtOj/umQeEMCQ3nz979GrkYcskAH
         dS1wihJEBktDzSWqzgWFHkC7EjbubLJ4VvTJy++JNfEs+yi+dFcg2bfnRQVigL/GeIuy
         zFSA==
X-Forwarded-Encrypted: i=1; AJvYcCXJswK8Pg1kgfEmksU6kcNjYiRL7UHwhxOJHidXqua6Yf9xIaXT2DaA6SlWAfpAUW9mNgX+xyE6JIrLgkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfapPk7YTYa0/vaSOqvjnMDvrRXWq02WlcxaN+dDxuA+f/gSVy
	5A+j2pmUqulr50JRSLy1m6ucy4oTPnmYw8rr+js64TBX81dr0muKHzQzz64Pt3A=
X-Gm-Gg: ASbGncvuMP2CEqmfaDkYflyeUmPhP+fpxOpprWG9mJpdgU8YatEYJjvgu+fLtJ7dvAu
	bjs4zVjy9sy/z1JgiDqzi0r5hMTLNLuOn7Gj9SvMZm8Sdqwq/I/aWvLk9BbNnvGy6pW9lmS0L2J
	kWiJKMD3dpcpc4nlOkSYT8aY7Go/Ognj3ON4xJoegcAqwVeLlmmnPsogocVwpEZtTfrliGX+YY2
	Y9/1g9A5KUMoVbuVUjz/QWWUt00WLMn35wFqyQfPAzkQ2rMqXrq01JFpbAfNb3BqWEVDMZeAtAi
	TiI1D9NzQmez6a4qZBNbrWYwC0cF8rEWKtYG3+YSoPfVCPXADVKlifesJBekEQPBdslKbKw=
X-Google-Smtp-Source: AGHT+IEBbVyTSUbD4VIdVMCULrKUp9Odd8WEDu7/wXj1JaLQYfEgmkmrL2fVeKfSHhXYce9o3e399Q==
X-Received: by 2002:a05:651c:1507:b0:307:5879:e7d8 with SMTP id 38308e7fff4ca-309036d7adcmr31262491fa.30.1739464827902;
        Thu, 13 Feb 2025 08:40:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100effc5sm2332031fa.30.2025.02.13.08.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:40:26 -0800 (PST)
Date: Thu, 13 Feb 2025 18:40:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/37] drm/atomic-helper: Change parameter name of
 drm_atomic_helper_commit_modeset_enables()
Message-ID: <vtmuxb6h6hsjc5xclr2kaxjdyxpzvu2xpouyvmddpye6xtipz2@y7ryrzcjrgrl>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-17-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-17-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:36PM +0100, Maxime Ripard wrote:
> drm_atomic_helper_commit_modeset_enables() enables all outputs affected
> by a new commit. It takes the drm_atomic_state being committed as a
> parameter.
> 
> However, that parameter name is called (and documented) as old_state,
> which is pretty confusing. Let's rename that variable as state.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

