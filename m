Return-Path: <linux-kernel+bounces-186768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE1D8CC8DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B5C282047
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8BD146D4D;
	Wed, 22 May 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFI4haYA"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518680617
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415957; cv=none; b=uU0uCFKDk+bAaD4KdMzsVhpGuZcfENiTySqfhZoLTWXfrNIfZHMH8hIoJL89XAX3ssk/+lGEjI2zfQ0EDy/6aJTFlZJrh+7qJbzwF1NQ8jm2lQuJI35koorqx7Gk0KI4mr3A5qgcgJ+kUwU4Vzo5CHnUjZ2E1ad3ZybWD9zTDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415957; c=relaxed/simple;
	bh=fDOnQ8n/6U8eCK1Py4zZQ5yun47iYE10SbmdRNCSXao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GP2SA1F77MxDl36hZ/Zi/AVx+DL60kPv1ovkBfXcfdJU/GkQueXILO7rerXnluKBQDp6eaicXI6bHfTGbFOoXk4frcH3rNpIhiobXK0Rxjl7YbDAJD1zNCKek07lbf0PIY2OUlg5T1V1QhZIyokEKhKr45GN9clU4JdPtBDoq4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DFI4haYA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52192578b95so8255126e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716415954; x=1717020754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQOeeyMaEqMnu39Y+NwRU81Ky5s55spLGysaOpoEjNs=;
        b=DFI4haYAvbaWEo+J2L5ybV4lscNHKa8u0XUy8n/vJd2bpnZn8V5/PXSuTaVHbLuVUK
         d5JxMYkXdRDRn+Eux9YtOwm8s3YL3wt0ycaS7QbGhjJjyiq8+hujvWZekB7DuFFtKZhE
         SFdslKM+PSMhOogaZIqh35+Q75liGBDNoEQYgJEcm1YYS7bvNznrVfyXvAnij6YpUhLE
         XlGevv2/NY9huJunIO2bltECtbqeCZzYai3xkrGIDyTk4Cyj06vSDPXnA3FP1+cJeer8
         LhHQUUK5Bkp3idaV3HbTgGWAakjliAaVeoRfev1+mp/ADaIE5XrCcWnkyicCBDPpTQgb
         mMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716415954; x=1717020754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQOeeyMaEqMnu39Y+NwRU81Ky5s55spLGysaOpoEjNs=;
        b=OpYRnTEAnuAAndRIhgxc4JtSGNLtXvoKcyalm1ppwdbQaeQnEZY2VagVAalFny7n5y
         hJN56yA/tBfQUGO5Uk1S+/lyJbTSn3sWkYo/jvPbWHTnHCvDgUr+0HfWQexYQy+OjuXC
         ccLtn2OIveFrSpllV8SeJKgshPwvCU6GGXBT1W015Tf1oyrH9o409Qc4bzeIUF34kw1A
         hfZTC15Me3+e+vRpfel5CfKcD1+0sce76iREtDK2tne8Izx1KDMmozEWUslxZuqtJdPW
         HL+0AFFNueB7+lJNUcKAcL23tAFRvHnULd69pRPh4eW/PUlM+VqCCOwNyi7QCTmdPuKX
         zfoA==
X-Forwarded-Encrypted: i=1; AJvYcCWf8Ryi4V1dUJXTb6YlfBONvi4+yIEZIbByyzeu0Bw6fSfGDloFn23t50u9IAZbW8VvbbCS76NHPmLpEjET9KRYX1pIQH5rMO6Ff/LV
X-Gm-Message-State: AOJu0Yx2tSVxUMcGhorefsTA7hLkEuwfswl37EHlaO7g1VVrctcDvfkZ
	FL4lS1veeBqghxWls+pTnxQvk2//BT2THwfDKsjgk4jFw6rOgGdHITUboBIqAb0=
X-Google-Smtp-Source: AGHT+IFmy9iqYhx6F/MxVLTLyGH1Ov9kV4rl1NcWdUJFcx0idK0FYhwE3IrOr5DzJF6JcDSGkx+xHA==
X-Received: by 2002:a19:431a:0:b0:523:9493:4e63 with SMTP id 2adb3069b0e04-526c0d49771mr1801806e87.60.1716415954442;
        Wed, 22 May 2024 15:12:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba50csm5062862e87.69.2024.05.22.15.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 15:12:33 -0700 (PDT)
Date: Thu, 23 May 2024 01:12:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Andy Yan <andy.yan@rock-chips.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v14 01/28] drm/connector: Introduce an HDMI connector
 initialization function
Message-ID: <g4eqwhtbdtqyhjhigtvsplu3hxdyrggkowssgh4b6lj57t6kqh@mptafawe26m7>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-1-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-1-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:34PM +0200, Maxime Ripard wrote:
> A lot of the various HDMI drivers duplicate some logic that depends on
> the HDMI spec itself and not really a particular hardware
> implementation.
> 
> Output BPC or format selection, infoframe generation are good examples
> of such areas.
> 
> This creates a lot of boilerplate, with a lot of variations, which makes
> it hard for userspace to rely on, and makes it difficult to get it right
> for drivers.
> 
> In the next patches, we'll add a lot of infrastructure around the
> drm_connector and drm_connector_state structures, which will allow to
> abstract away the duplicated logic. This infrastructure comes with a few
> requirements though, and thus we need a new initialization function.
> 
> Hopefully, this will make drivers simpler to handle, and their behaviour
> more consistent.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_connector.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h     |  5 +++++
>  2 files changed, 44 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

