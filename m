Return-Path: <linux-kernel+bounces-442304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12739EDA62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E897E18855A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA61F0E55;
	Wed, 11 Dec 2024 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9nM8x6O"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6151DC9AB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957443; cv=none; b=M5f2/8RFQLIeUpjnTSdHRxbTix6aK5hpYKUw6yWjEzV3VZK4pILie90sakyPOskxZfzJn4myz83xBegvr5bvz13lyFUSHYhR1zu/cj6H7P+UXY6NncBfTdIdDH2zBcHMu7SQv6Oy9QqMz5F4vEEMpyVSMr922hJqViXt5cfYJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957443; c=relaxed/simple;
	bh=qLPHbexhku9g9Zx0tU2cdtwR915l4cxWmGkn09DrlaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2vG8t6WHEHMPtPSYmoBzdYBGdP7wHJTBl7xg0fk3/g2GRx4LeAVziR2R4fyHM+iZYWN5KBAAmILGk6t9ui6is6HhSKf2nWMgNG7OEDzfWLMiFjHcZJnyD8leN2laFjRV1Ownlk2BKm6IOMlLDxgHtotzmpNTapKV5LNdCr9bSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9nM8x6O; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53f22fd6832so4437505e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733957440; x=1734562240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhObuxr/02KFb2isXPxGgNEnZ1jE84bLOSCb6UyuS5M=;
        b=M9nM8x6OfO03jDEkTq8YZGOvXgDOkRxXSZVnc4K2RUBV//ortf2AXVBy/BiRQjwlh4
         bGTVhmeZHuoW7FgAusHJ1WAOTEV8JFPOQpq0FhMDKwr8ZUKbdltMNq+jM2IFTaUU7d+R
         dEsghChiiFBpU8sl0J/8FXC8AZ+KgYEMQEoe8TWWWT0eah9rNbEcObp61v79Th1rUYJ5
         Go1AD9NaSIe73mKk4BAaCXD14TWoQ/xSVicXDYuEsZs4h3KqbFPCiVcBQt+qCPxzXj32
         LuGLaqXPkeSYs/jEiExQzSrD7+aVpWydQf/pJtT1glfeZtOkct4lRVrtkHLuMj4m5pRC
         h+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733957440; x=1734562240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZhObuxr/02KFb2isXPxGgNEnZ1jE84bLOSCb6UyuS5M=;
        b=WmCfMBbmfn7VQ4BBuSyXrE9V6QK3ZD/qOCEvVACSmZYmo/9Sxq9FFJYYhWiOjhRz9E
         0CEGA8QI05E5hCOpUfSTaObE0azYbYIwmT8ISXqKhmqN6nu2VH6BoY3xd27uBe8SZQUW
         dCJRgYttipsJSLfoGZOG2tHUf+AqBsr7KtQEyfeVPezXW4pRIaMeFEMJk1EDfJA4EEO8
         npjXf31e6KFDkU2KbC5FLC0sBDEnef+9mQk9aVHZVtnc8x5omZB7yBkE5SsDnvwpUEO9
         v7Vuq0cNepcYNGyvimSEm6QYx/PwlImCK/N3V3X8py+Nxu3SxvPmjiVRhdzUGrV5VwsI
         B8oA==
X-Forwarded-Encrypted: i=1; AJvYcCUbsyfNpTylC54/W3rtsdgR5GX2HO9/WzY5iCWxMfPcwOGhVonUJkwD4/8bFxthFUNUYSYzD57EigKHP6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDEZqgGmB02MdhqFIFe7d/VYG/mCM1+SI5EkOhjIwpQkkmtAuL
	waDneY0GpbFKMbEVQQDd5dWQbc/n7mNiNijK61r38N6ufsG079o7yo8WiWLmuKA=
X-Gm-Gg: ASbGncuhfUBpgawD9edx1uuDLm1ue0IBmHJXBcm33YIVNoNhkkgueMqCmjnBjBDo0lo
	IpRmf9zT5FA6gITtCFvFHlHTLa+rHmsGmNOm9/mNxws6+lJp1fLgLrI6ia45/jCq/J7F+nPJe4D
	EM8kiN5VkYryet/F0npSWbJOc50nYRbVvt9JAzxokEeE7MmiZepESczEZKy8MzOChxKfVtvCwuA
	/DUhr9MgfyoKdieDBfU3olqjWRFL069UgIh/D47paGWj1VkefMJ1tpQ7YYPmufZEXsTZI1PZLs2
	5WMGo70pfq8gTdwftBxtwH4Hs1gOdhFRsQ==
X-Google-Smtp-Source: AGHT+IFfopIZRMQLZAH8vRQxGl2sNJnS4PO0XzwFwmFMQsUTluQcT38x+rS7eG9hh809gTG97MV1HA==
X-Received: by 2002:a05:6512:2387:b0:53e:391c:e985 with SMTP id 2adb3069b0e04-5402a5e8309mr1405330e87.32.1733957439569;
        Wed, 11 Dec 2024 14:50:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5401e51bafesm1154464e87.221.2024.12.11.14.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:50:38 -0800 (PST)
Date: Thu, 12 Dec 2024 00:50:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, quic_abhinavk@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, robdclark@gmail.com
Subject: Re: [PATCH v3 2/2] drm/tests: Add test for
 drm_atomic_helper_commit_modeset_disables()
Message-ID: <njx2ogued4bbu3ub5jlnczql3x2dr4i72onhmh35tgxyuf3lek@3liwh4butumk>
References: <20241211-abhinavk-modeset-fix-v3-0-0de4bf3e7c32@quicinc.com>
 <20241211-abhinavk-modeset-fix-v3-2-0de4bf3e7c32@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211-abhinavk-modeset-fix-v3-2-0de4bf3e7c32@quicinc.com>

On Wed, Dec 11, 2024 at 01:18:43PM -0800, Jessica Zhang wrote:
> Add a subtest to check that modeset is called when the connector is
> changed
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v3:
> - Use BUILD_BUG_ON to check connectors and encoders array sizes (Dmitry)
> - Renamed functions to be more test-specific (Dmitry)
> - Added comment description for test (Dmitry)
> - Return get_modes_fixed() directly within the encoder get_modes
>   function (Dmitry)
> - Move drm_connector local variable declaration to top of function
>   (Dmitry)
> - Changed drm_test_modeset() to a more descriptive name
> ---
>  drivers/gpu/drm/tests/Makefile                |   1 +
>  drivers/gpu/drm/tests/drm_atomic_state_test.c | 244 ++++++++++++++++++++++++++
>  2 files changed, 245 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

