Return-Path: <linux-kernel+bounces-426139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A19A49DEF69
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C12162C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5705714AD17;
	Sat, 30 Nov 2024 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuBlIzkx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA1E14A60F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732956143; cv=none; b=f9Ws782IgkcrgZNR33PRKwyd23s6cqxljz7d6xXfZ/LcKFAOYfUM49Bqfr3gSvI5W8e/GO8mjTYPaSc/Rq5vJ8lqEG/tsvn0eEcU9IkyIswPp9GbxxFg8guLx5mRhynUnvsa4w3WLgWH/emqPSch193HaqFJHTaWOK74F5T5Vms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732956143; c=relaxed/simple;
	bh=uIcKjgFPuD/X72hn3FsJuBBF3lT/Nv/Obp8oWWykiBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT5qOFpYrSnJXroI1tFSH819mZf8DdxJqbU8aahqWMAl/LsmdRXSww5NgJOmCxwXxao0g7iQ2wYtdbRSJVkOH0V67Uyb0TVLNyAyaF3xpNd2OL2vjKRCEqZ3FswD0TG5yvuQgcsTJMkYZUTiJC2HqL5263shajdIANc/s34ooyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MuBlIzkx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de579f775so3806369e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732956140; x=1733560940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YiTdOQTmKQnnT3u/vRpmnx3kA75mK1aPDkrsIIBxJq8=;
        b=MuBlIzkxCSTFfIE/h/A61WZiLiHCS864vN2tPHGYvewb771oBRhO4GNDGHswARtD6M
         pLfu3l8Va1lSHRrMs4dfXMBoMyI17aVZgt4iDPF9v3nXrAcr+wvZq0nuiXnE5NlU5Qsn
         xcXsZvcmbPP5R7usFhy4RXBWYiR8Lz2DZmQV9hDagy39i4BlcwlVETDN8gWLK+LC8J8/
         jCkikmkaa7LjAI8F7hbi4eSYdhB4P8nuWfToNlq9DW+ONVJQnqQVw+bu8Y3f95SfX/hR
         It/3lLxc4MvEocd6M8WDzy5PicuLmED4Wf5GVJmCHvWuq/LQF7pdM5cQXo41Y4BeSCzK
         Jwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732956140; x=1733560940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiTdOQTmKQnnT3u/vRpmnx3kA75mK1aPDkrsIIBxJq8=;
        b=OOHhMTG6RqIdigudYrivaSK9Rjwyn7kr5vwb3qpJssD+QXGMgM5fh8mq9oInPZiyOZ
         eSguJZtliW4lMnJFVQbjOlQhvdp6YlTcqeVRIr5ULos3hhFs7oX8oW+VWUiSDv4IS/mJ
         KK1pzWCv7nEmnLrzGJZEsb32ldOIyLxrW7B6ikXewbxWhixEbui3+f9s0Oj4AvFZwjYV
         LNHLdfbJohfRUQHYHj+SSOK8GI2Nzlqd4L4wGB8y7lGRVez4Y2jPEUESpviz5RziUK/s
         hM2VyeWKh4USK36sVPRuJxvtJZs0MMajTYLu/i09X7IMAMYGRpRBQRX3t9hrzTDShsNg
         yirw==
X-Forwarded-Encrypted: i=1; AJvYcCWuhfcK+GQr2EcZRt80NsQFCGbXDmli6fMLx9CxipezjQpi9jbcb/94B/Z608XJzM8sSuxCZ3Z0HWj/dWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9OIvs0whG1STPPjZb27Rxq1eZ8mhuuQ/XpOrZKVxQkMhpCze
	YICOfuf+pP6HaXtVjL2t8HPeMG14Yv5BjU8A+S2H1mU623XS5keHcKfML0XXfMA=
X-Gm-Gg: ASbGnct9LStkF3W1jRxUYEHvo+ci3YJGfeIb6aP9iJIDgaUN+jNdfMaV09SVTn5fOk5
	f+zG8fxLDfgXDwcqEwlzsuE0vRxhyxNnHiX8qk7pQCkIBy9WVaojBXe9OYyVBtOxBT+QfSG+kBF
	szRHHFXeD+yxZ4s+Bof2bQJgvPHcghAc3ReOJQTTWH81Op+iHxBsY9Fg9JQ7OmjYwWqlRoZsunW
	ukLK4eFzXKmsC9eHYHzSpx6AIST53SSWaeaOnxzscc2wLSwmQvw4d/hqiB/B9+03yVKhVZ3mJvu
	krsot5MalCfSmWjYHsmkhoWOWW+JMg==
X-Google-Smtp-Source: AGHT+IEEK8CkCTOvlO09efgwBx3bMcY5gfcm8u1qQfaMXFvzGemWDXqn9wPa62U3AOMv1mmqMOAitQ==
X-Received: by 2002:a05:6512:3e23:b0:53d:e5fd:a453 with SMTP id 2adb3069b0e04-53df010b140mr13875507e87.39.1732956139957;
        Sat, 30 Nov 2024 00:42:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64433b2sm700166e87.86.2024.11.30.00.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:42:18 -0800 (PST)
Date: Sat, 30 Nov 2024 10:42:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/connector: hdmi: Evaluate limited range after
 computing format
Message-ID: <y266o2w6xu4wlqdlyckfaxjze7d45qi4f7qlv2ivkbzoi4jh3o@nj5t53pusxjj>
References: <20241130-hdmi-conn-yuv-v1-0-254279a08671@collabora.com>
 <20241130-hdmi-conn-yuv-v1-1-254279a08671@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-hdmi-conn-yuv-v1-1-254279a08671@collabora.com>

On Sat, Nov 30, 2024 at 01:56:32AM +0200, Cristian Ciocaltea wrote:
> Evaluating the requirement to use a limited RGB quantization range
> involves a verification of the output format, among others, but this is
> currently performed before actually computing the format, hence relying
> on the old connector state.
> 
> Move the call to hdmi_is_limited_range() after hdmi_compute_config() to
> ensure the verification is done on the updated output format.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Fixes: 027d43590649 ("drm/connector: hdmi: Add RGB Quantization Range to the connector state")

> 
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> index feb7a3a759811aed70c679be8704072093e2a79b..0cbcee7e77cd8dff387044487ce28ee5748f5587 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -494,12 +494,12 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>  		connector_state_get_mode(new_conn_state);
>  	int ret;
>  
> -	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
> -
>  	ret = hdmi_compute_config(connector, new_conn_state, mode);
>  	if (ret)
>  		return ret;
>  
> +	new_conn_state->hdmi.is_limited_range = hdmi_is_limited_range(connector, new_conn_state);
> +
>  	ret = hdmi_generate_infoframes(connector, new_conn_state);
>  	if (ret)
>  		return ret;
> 
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

