Return-Path: <linux-kernel+bounces-426135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5399DEF61
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F662818B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E39E14A62A;
	Sat, 30 Nov 2024 08:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+Ks5heF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9F33F9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955923; cv=none; b=F1WuFg3dHLPP6gDi8vFjDCSS6RxLY5I2YolLY5jCbeTd/u3vl6EzawG5rbRqbZUzE7toR9vN3bc0n6YmGdrRZXiUq7VRiPhKxOOURlxoFByqK8D8QKiyQJRsms5PLLWBqW/tvTb1xBmgAUH0NQ+Ky22y0xIxIeOgDLA8kT5QTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955923; c=relaxed/simple;
	bh=urA4yCemASuyVfSXMxGjKDtEv61zvBoJ3sI3Cx/BflI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2VWB218uavCAHSDx4M3N3j7PLeIw2KO7X/G7TNJptjxE5valaslfLllA5ER6/T6lJWF3ir1nvemJ/cFfyU1/mdwYWwOb4Wdif1X6risQekJu1tfcRWnufxx0MDmApwW+jK06QM4VWQlX4RkhedqcrL90V4xd8hRFtApL2Dc1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+Ks5heF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso2588141e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955920; x=1733560720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NXAcZGkWBHX25QfRBDyi8tlFp6pK1qwOt+Zj/h2BOrI=;
        b=d+Ks5heFQRb+m3CT+SGT80UnCnnkaAipQgK///LDSoDLgHfkVg5rVGCY5WiLxMTh+n
         Fp7Ac1ROhfsHr5vLpJjGaS6Zhus/Lh5e+mxFX1qmoAx2oKnH9zioeVDZLiXqN3drRYGX
         Wue9+StnOfkxU+5jJdIzGw2XN1sRLmoQsk66SRG+Z/1k9jEsb2pGspD0KW8Ju2Adq76P
         At2ofTB6krg49cwt5ZFaOj9bDm0uaz+V0oIEoqS/raAmqAvuBrlQkLfP9IfRgLqd/x2k
         rr4+jiVf7pthx0g4gxtOzaHRi4QrCyi+5qgdri/bh0r0lwvGolHE0I+7lr4nksZd/m5+
         ZeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955920; x=1733560720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXAcZGkWBHX25QfRBDyi8tlFp6pK1qwOt+Zj/h2BOrI=;
        b=NL9LvVVqaIEyKZzzs6PZao9iS3yCLfVIFEL6zzZ20yXZo6E3N3Z6GSCIwDasvjhLnt
         PisHPjOXJ58WMbwcZ0CmCMEY/7Uh7ywL5T3rg+mD25rYhxoJOh9VC4sfpoIRzIEDx1/9
         hq3jj1YXc3yceFEPDEHb412s3FRMiyAKO1vCyedsHk67EBrrwJ4MeYrAEe+3xlMJ7CL7
         i1bBn7edGXnnQZEWyGWYVoYr36FgdZKRwEK1oLxL9zCBQRXT4YzE5rqT2Y4wqGeyF9e7
         TXagmvcynccEm6JCuu2RQ0iem7YxjPUVovMJ3pAlRbEN4eJ6MRhX9WPlcWAs21erf0F2
         JSng==
X-Forwarded-Encrypted: i=1; AJvYcCUFQQGdIeqC/tD84nQOJJXc3apeDxJml21nkB6O3TtkHNx1axh8FsK1dOYr8PkyEyhvmj3+Ko4idFTn+0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMh4sQsyNItqbp2yD7rT9OeMRf3iYPG9zVaxam0FmAp5ugJDZk
	tF86Jp61PxPSTm7TMzWXZM00NuEKG6CmGxsnh6gXELvBuXFDQj7iDuNrbyyDr08=
X-Gm-Gg: ASbGncuF5a/dfhMygjHjzEAE43+Fs123wmk0Mjd69eRBKrCk1KSvh9B7zjhjxNz5Vp7
	9RUUOCpffKHurAfjfiWSXAfLe9KAIlH4Hrwn6M0atIqh90DLYF2RYky5EBfMdHXFIs5MmZrSM8j
	z0KIYNJPu1IPOBSZ2UhDLfxqj8sEz9c7K3LLWBKeTFCse3t3ngZG9Y34l01ytgIw3COzn2vEecW
	qsAhsyiiqWcItyk/73suHVxWvNpCcHYsmIdwJZV85qMu5G1cpPn/qsHTnw5Th+ZChd24hLjCALj
	t0sQ5iUcp3NAbWxSYUXR5M+7/awv6g==
X-Google-Smtp-Source: AGHT+IFp/JR40e+9hDYErdoRaIfhKywKkgp97604Qk0oyKGBNI/opThDDUUCyOtQ8USzlicY6WVnRQ==
X-Received: by 2002:a05:6512:3b23:b0:53d:e88b:ebc with SMTP id 2adb3069b0e04-53df00d7bbbmr9468255e87.24.1732955920272;
        Sat, 30 Nov 2024 00:38:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df643121esm700415e87.56.2024.11.30.00.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:38:38 -0800 (PST)
Date: Sat, 30 Nov 2024 10:38:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/connector: hdmi: Allow using the YUV420 output
 format
Message-ID: <6hcjgagu7hvbnn6rp5znwjxeaa6wqkeecgvvqkzvtma2ni6mfz@lrbmtbogkzgm>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>

On Sat, Nov 30, 2024 at 01:56:31AM +0200, Cristian Ciocaltea wrote:
> Provide the basic support to enable using YUV420 as an RGB fallback when
> computing the best output format and color depth.

The HDMI Connector functionality has pretty good KUnit coverage. Please
expand KUnits to cover your patches too.

> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Cristian Ciocaltea (3):
>       drm/connector: hdmi: Evaluate limited range after computing format
>       drm/connector: hdmi: Add support for YUV420 format verification
>       drm/connector: hdmi: Use YUV420 output format as an RGB fallback
> 
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 55 ++++++++++++++++++++-----
>  1 file changed, 45 insertions(+), 10 deletions(-)
> ---
> base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
> change-id: 20241130-hdmi-conn-yuv-e1fa596df768
> 

-- 
With best wishes
Dmitry

