Return-Path: <linux-kernel+bounces-187333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 360028CD052
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C885A1F23B94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6814431B;
	Thu, 23 May 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/A2nphT"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0CE13FD95
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716459885; cv=none; b=Ooy0PsXYOz56vhQ/RkNT50Zz8MabhX8v2HTtFToZehNZUGudLwvMNizalKnL7CG6ZQ1XCAlE43WJTDazcY7hGqO2GxfZmkJbWflVKagfNZGuHKP3EKBHpCQiovuPj5IcpE3RF9xhULX/wBcaaSCFSa8Mm4/4/k8kY8hEIVRNA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716459885; c=relaxed/simple;
	bh=GesYYDL0RueRfZ/lYstvElMRwIUq1iDUssl+48qnt7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egUa7ChyrpkH5gUfRju2Da5UsgN0dgOjl4TwHPrIedUBAkFWwGpnoESwq/FP2d6CRmc0o9UIIlJgu82PEPyisFl8of0FNda2SV6EG6jaY+QBaN+Op8h/yNBsVYhneakhgtIe2vcOGhLoNrQX+reD76z26llBUhJrwtKqTiu+iQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/A2nphT; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e564cad1f6so106613801fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716459881; x=1717064681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTs4KhPH145/AJRmP8+6lMsBop1Ixgucc2xC1shylpk=;
        b=M/A2nphTN23OyaAeWYrIVzB+X4D1yAzAtE3o6ReRfZMqpBKpl/Vx059axdTTv0xtXL
         izwm8xbNIslKXCy7Ci2pu6fd90hHxRx9UNDxMMZXTU9O53OKe3Ev7qTdJQ0jGu3MFRJ7
         +wxKlSEeZyaZYIdYqyQGM9Hg7RW/P6xG+9dc482Df3bP/XChFL8jtBe1jC53vUfYP03K
         OqrUe1G73bt89Cc/IosJCwJX4qfB1TGMKGmKfdlMEayJeup8uiWgqhmYgpbadiX2WKEk
         eQlMwOafMO8mRzJJ1oyMVXqzn+mNPqOYNRUoQmH8aP3zFh2eX4SPYv+xjRJHXP1MJqYV
         lq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716459881; x=1717064681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTs4KhPH145/AJRmP8+6lMsBop1Ixgucc2xC1shylpk=;
        b=KZ/qcchDKrSDRB1TgBo9+Jte5rTQN7U0Ldc5yLSe4jpcEQsEUXez4ZfpxdmjnzKOKO
         LRtywsE+6zHcJjDkS/oo0yN/Ygm2JmjJB7pgvoQkCbJgeuaH+ke1f3Jvf0kuPMeC2PAL
         WOfbV6a1MvG15eioXhIGuuEBj8h8cja7dgVeYv8tbsdQWbYTjgPX7pAC/2VuOUdD9Kc7
         buYqDpTbacGfN0qrRTRFo3rEF5tOLXBT94AegleT3wGZN+uq2wq3SG4gKaEGeG/pxWUy
         +u5D3gNZJ/+xFh8Z3h6pE+5UNSUL9kvP698XIGHdIsR9b9y9zCVbYUhh62iRcb6x9E5p
         Wzjg==
X-Forwarded-Encrypted: i=1; AJvYcCUrEMVrgTQDEm4lPXyUDa5Ru/+IJevtHDHlEAlxYyGVhJlXQhiSDd4tAxOfDW6WIAY3sLhGKABGMJjC1PiHkGxLWPShj+hClxITTLtF
X-Gm-Message-State: AOJu0YxLAbc+XkPR+Oa5D+px7qrlyD5f5TsKh4gOhL1f7SKuoxlqhaQc
	9qOqX+ROyBwlzqK3KxCBdmbk5oBUMxTYRDrcaVwiiC0EDkAU9wq2cJcTNOEckek=
X-Google-Smtp-Source: AGHT+IFh8tvpeC+TwvjC1fPxZfM+UwuyED0DKgyl3oWL27XorJPrG1npFHJwvig7HdSlbfPLtqhR9Q==
X-Received: by 2002:a05:6512:3141:b0:521:9207:189d with SMTP id 2adb3069b0e04-526c121522amr2191728e87.65.1716459880614;
        Thu, 23 May 2024 03:24:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad526sm5387014e87.54.2024.05.23.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:24:39 -0700 (PDT)
Date: Thu, 23 May 2024 13:24:38 +0300
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
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v14 19/28] drm/connector: hdmi: Add RGB Quantization
 Range to the connector state
Message-ID: <evhxta7gk6mogntoafibz7kxcgziikrhitrjg45t3p3lhify2k@uwwdo6i4bqbx>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-19-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-19-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:52PM +0200, Maxime Ripard wrote:
> HDMI controller drivers will need to figure out the RGB range they need
> to configure based on a mode and property values. Let's expose that in
> the HDMI connector state so drivers can just use that value.
> 
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 29 +++++++++++++++++++++++++
>  drivers/gpu/drm/drm_atomic.c                    |  1 +
>  include/drm/drm_connector.h                     |  6 +++++
>  3 files changed, 36 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

