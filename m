Return-Path: <linux-kernel+bounces-187412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 627098CD171
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AFCB21E79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EDF13BC05;
	Thu, 23 May 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9Fw70R6"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75950276
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464797; cv=none; b=sbUIok3BEPmbW/Y3La0LW7aO1RtVhds4Hl3Ctb+uaqrfTXiog0dNyyPf5zlAJ6EWa1ULdXhwmQc1fXx/LngNSmf/j1tAvAGNzmov2Vu5IQ0urdOpgH3x0r/Z4RA+3Nl/68lMQ8wXErNjNUbapX/OWsxZxKpkk+B3V17DZ9MbtEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464797; c=relaxed/simple;
	bh=Tjqag5Ft0/cLNmS/1MjmwM9JVkyiVtyORGiBEQxrD9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2he8kJJTMFIZVfLhGyHEt/kIVCdishygjKK+tY9rAXeBDdfHGqHF11eLXclA/V32Ax6/hE4Cx2fEXOjmfYHVeIWdxa1ECF9bR16DO2lzaU/K3kBTbx+sW30rweuSiET/jKzb7Aa/JHG6ZOMAl6YTSfh3YVTX3QBXYQ5n435aHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g9Fw70R6; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52449b7aa2bso5040417e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716464794; x=1717069594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uprefhCgqHmgRCR+cfAZCBDosMSOOYvyqNmZZJrA1vg=;
        b=g9Fw70R6b43lf5Ip9QrCl+lbjJw2gBUVFOEVCYBSZGCxaqE7J/CjbyC+tu4y3WJIYq
         6j0q4nKhA5lHUuFWYNFszBacdMC/4A4i2b6EaUP3oGr4HLiwjZ0klwAnI/jgadZ2j/q6
         2y27pdlbEt8IGbMpYx3r7CTb6HR+3XO0JuzyFAnb5YcYMCzW3xh29glq7HOgF8iEZQYV
         8Feq/1Vt+wmsFqrJ9IagF99EmpedfaN2RsOXdesZKC6awLi8LeAmbESv8W1cul9O+j0L
         D4SRBRKjL8gT31BjOq9ioXIcWS9VHXPLMwxFz98ISLKN0JBcWyo9bykR3lH7kfJKoMbE
         6nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716464794; x=1717069594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uprefhCgqHmgRCR+cfAZCBDosMSOOYvyqNmZZJrA1vg=;
        b=EtBZ7vISgsT0kFQkY8wbTzMzA518Rfq0zdbY7352dWlCB7Dv/gvsyc1YgMWkRwERI3
         cU8Ktx74BLAF9M+Nmstx7iDprB5yZ1Qtqwvb29UG7YtPKBDmWNg44XFzBsXIbJrXXZrx
         i8eRbx1P1ucCDDE6XKbIV6zHH023QkfZU/TA2XBXwZZRXyzj12kwkAodqlgRhp83Jkm7
         geqzqLlHz6P4QqjfIPa6jb7blo5fdqBCg75TmohJUHKbvJyHFqOXSbnEpa4E7IA5Ll+5
         3doG3U9apgE/wA6wlSA5p5iBVJ297Z0TY/A0n6gWzx/rcRVL4wpU4bAllybUtQampV4q
         NU9A==
X-Forwarded-Encrypted: i=1; AJvYcCUysb8U++FbCvzqC2skapIlp6d2Q1HOgxS2bXkHVdNvfZIiDivA9W1Df28zc7VCJkrUaz0cDnmqdIOiY6sA4i9L/UztfzLY4bNh02Q4
X-Gm-Message-State: AOJu0YzjvjKRT0j25U+U+6hTh+W9AfdndiMArjrqdrMHnn0eTMmrjCNx
	ak7PA4FCsL+J6WtzU1bly5OjDxP7kRp60ennowXsskKplkddhW0YWEFm5u7n678=
X-Google-Smtp-Source: AGHT+IGBiL7Oiztj/+dmQv4BL665Zqfu967E/8LJRhUrFe0HkWUk7uqDb6+uR4EPIq2SDZKgH59zZA==
X-Received: by 2002:ac2:4d1c:0:b0:51b:248b:e768 with SMTP id 2adb3069b0e04-526bef87adcmr3053749e87.25.1716464793664;
        Thu, 23 May 2024 04:46:33 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f39d2c84sm5319149e87.282.2024.05.23.04.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 04:46:33 -0700 (PDT)
Date: Thu, 23 May 2024 14:46:31 +0300
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
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v14 21/28] drm/connector: hdmi: Add Infoframes generation
Message-ID: <e47uh7w6fxqdtio5qwgv7yro5mmywhbjj7v332ts4thzzg3uk5@ilke33oaczgj>
References: <20240521-kms-hdmi-connector-state-v14-0-51950db4fedb@kernel.org>
 <20240521-kms-hdmi-connector-state-v14-21-51950db4fedb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521-kms-hdmi-connector-state-v14-21-51950db4fedb@kernel.org>

On Tue, May 21, 2024 at 12:13:54PM +0200, Maxime Ripard wrote:
> Infoframes in KMS is usually handled by a bunch of low-level helpers
> that require quite some boilerplate for drivers. This leads to
> discrepancies with how drivers generate them, and which are actually
> sent.
> 
> Now that we have everything needed to generate them in the HDMI
> connector state, we can generate them in our common logic so that
> drivers can simply reuse what we precomputed.
> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 336 +++++++++++++++++++++
>  drivers/gpu/drm/drm_connector.c                    |  14 +
>  drivers/gpu/drm/tests/drm_connector_test.c         |  12 +
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   1 +
>  include/drm/display/drm_hdmi_state_helper.h        |   7 +
>  include/drm/drm_connector.h                        | 111 ++++++-
>  6 files changed, 480 insertions(+), 1 deletion(-)
> 


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

