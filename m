Return-Path: <linux-kernel+bounces-183280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B258C96C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 23:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B97280F3D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 21:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389B96EB5F;
	Sun, 19 May 2024 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFF/dnXw"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFA18EB1
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716153966; cv=none; b=a/vXJhnD1hP5LEAoBGvI4mMv56QnQ5twmduyLQsNDIXCUUPHNVBgRwkZgk7L4DWOnQG0dW9E8v2pjcXEOElNpUhoyLACP6dFy+t+D/JTkoLYv4CrxfOZAsYN77lSUqpwBcLlFB6Jre9ZWyLxqpz5pzZDoWs1jrfxpS+nZ8VhoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716153966; c=relaxed/simple;
	bh=xo7z5gBTqh9m8tR1mR90dfldkI721z1Mabjp7Gy3gNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LNRRnRDbsvlY7HVuN0wD6nDo4wcoN97H1TseonwWwz291xtJEfXSS2OiACr1br6ijj57cpyawWUvhYuHOt9wAVCwCI2h5BGyFIdVFa+rkNnlWRhJf4vGApYBrIeHV+dOfmvf+C9cy2u1c6uMGy3tLCfvdmrfuv89dqyer6zdxSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFF/dnXw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e72b8931caso1270551fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716153963; x=1716758763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6nVMrZE712KEz8bUFbSeox35yQ1x4MWsEF3bYFtA1Y=;
        b=XFF/dnXw0SewwVpYdQKzaeenUCAeg+raGqTFhqqqZkjm7QYtKlAcFq8qQwkp6JpBIS
         gzlIq1uhNypfidf1YMrrINSUV377VLTBBCDrevui8TliQIeM1OnTBXPzO4rdoBjWqnaJ
         +dMcQFaHr27A0TcBRrTzQksxxXzcjp6+K40nsGVe7nDUak3UpKy1nSyw+vTRgGL56hLw
         3+GSEFICi2foHJSdMOJK4f/PPfOyaMbiv7njG3+k9txv7Nhf23ACsr83FnIg/OlWCTgj
         TPeJxb7fVBDbNJDZNSwU81BYFhayg9vSwCuqnmGIsKOjXrci7v/RJUwQuQM85aPWIiY6
         A3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716153963; x=1716758763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6nVMrZE712KEz8bUFbSeox35yQ1x4MWsEF3bYFtA1Y=;
        b=t0oYjLdXPOvveSXMZaBbgsYnmrnk2FJe+dDgUzX8pJOfL13itdxGlvfiWoKBL5dgZo
         fYSCgFbeKrRz6ymxZnefMSNg6jzO4r20WH4u9y2sIpNGTs0qAnBGujRdXVkMvelOSx10
         1NUdn7IwCDbiQCR7wrcxbdRBe/WZhbYkXFKGwOHX3yljc2KuhIHSLUZsOAWSAxlqmk3f
         3XtBVgnm9C+A+Qt8c6QTWStk46hRtzOE646C6G+IQEMrClCqB3qtx/2GNchyjJveD0ae
         WEg/01ZtiypGRTC6Mex7ZcT4rLjDXZ22wGQS/HDR8GGvI2sL/7q3xfJDP6nEfQg36L63
         GrcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA2y4gdZqeiM3y/1ELROBcVBZP7YxbdLluPSKZ18d/eOS3iiuJZr6FXAcCvK9qYX2wXgnlU2NYTe7F2xakv5KLza3X+LARSEfSI4ZA
X-Gm-Message-State: AOJu0YwUkExBkD3NK878jnWu2PSoZTo1VCtfRka4G0RzaQP1DmB/BgMX
	5HdfDuxuRfXXekPCEEyhhwtghqEW5X5zGKUOse/R7GlTMHUL5TuUnC0CBqhV6M0=
X-Google-Smtp-Source: AGHT+IEDiTly3l/2arj6xKsFbQnwkCXaJx0c6Qc6YWYld3fj0pvH9iSWWsSZ94Z5R5WBsRW4rLHAKQ==
X-Received: by 2002:a2e:b01a:0:b0:2e6:a0b3:24a3 with SMTP id 38308e7fff4ca-2e6a0b326fdmr141595051fa.4.1716153962611;
        Sun, 19 May 2024 14:26:02 -0700 (PDT)
Received: from eriador.lan (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e4d1622740sm32064781fa.119.2024.05.19.14.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 14:26:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Liu Ying <victor.liu@nxp.com>
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	biju.das.jz@bp.renesas.com,
	aford173@gmail.com,
	bli@bang-olufsen.dk,
	robh@kernel.org,
	jani.nikula@intel.com
Subject: Re: [PATCH] drm/bridge: adv7511: Attach next bridge without creating connector
Date: Mon, 20 May 2024 00:25:59 +0300
Message-ID: <171615394192.98831.12547491683028150051.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240513080243.3952292-1-victor.liu@nxp.com>
References: <20240513080243.3952292-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 13 May 2024 16:02:43 +0800, Liu Ying wrote:
> The connector is created by either this ADV7511 bridge driver or
> any DRM device driver/previous bridge driver, so this ADV7511
> bridge driver should not let the next bridge driver create connector.
> 
> If the next bridge is a HDMI connector, the next bridge driver
> would fail to attach bridge from display_connector_attach() without
> the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.
> 
> [...]

Applied to drm-misc-next-fixes, thanks!

[1/1] drm/bridge: adv7511: Attach next bridge without creating connector
      commit: 20da948e3a807c67f0efe4f665e64728be370f3d

Best regards,
-- 
With best wishes
Dmitry


