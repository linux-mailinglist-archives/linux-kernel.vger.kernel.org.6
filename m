Return-Path: <linux-kernel+bounces-180365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D948C6D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AE61C21FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99615B121;
	Wed, 15 May 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GD8pW60b"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663E15B0E7
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807275; cv=none; b=f529LCWcaaDAH7fhGwONOTrhEh6uhXzTnXvj7q+n1l362+Eh4D+bIA7XXigXtJcbc32HxocyapNbGvo2CZJvNLqQ0E+HWEFACsTgSGlEI4HykChozKpQ/xWnuChr87BVMMwtxTUoSs2lbyGX40q622cofPqrlwQYu+H6HyBtOes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807275; c=relaxed/simple;
	bh=+1v3Hy4YUvL0n6+oTd/SgGRt1q9gw29RzhoV85mMgqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X8ivNrUvhPUwfuqDLlCp+JYyjcM+z3U8KP/6mecBQeyJ2cOaUIti+UH78JSJdrTfW9EtWCUKg5zP2ysZ7v+lazQwjHC98LcieoHHw/Z+B/2v/hXBlizF2/+vkTA2GaXPxBsslanM6SuMUjeOh8CtK2iWT+ad9FaFrOv1GFiJ9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GD8pW60b; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4200ee47de7so33867815e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715807271; x=1716412071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWHLY+0xu3zArTUYXPHmiujebW7avno1a1q9nZr/Hdo=;
        b=GD8pW60byJAPZBoFLchJq9y13hAhaZr4EM+NiXpr0WGDb3dWbZi/ZhMNfsLSsjQhYV
         1vDTOinrF7ZdwYIY2yVr80Wz/6Hz6Y59o3fFvWg6fUXbkCk10MUHGg6i8fSyknScnXzX
         34W2O6uNzDdsFF3WrWYa23HDUhdNPieSHnPuGI/HoxdnL4XiEWDb0JG6ejanl06cN7PG
         xmnoWkysS2mlL3C56kDbae+PuBBCtsUO38T725lPfYQoRisgMEa4adxrH2GFJhAMzS0g
         KjmBjvq7fCiWHVStOvz8D5OrXJoPoHvRjaKOE0bs8Ig28h4QiuoRtUIpC17dwxefy89f
         YsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715807271; x=1716412071;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWHLY+0xu3zArTUYXPHmiujebW7avno1a1q9nZr/Hdo=;
        b=a6P5JuN3b90qkPc4i5rbv2gkcTAlN2fVaPwkarcSF4ZLLiQduZMmdUhwvvJrSOyRer
         PBGdHJdHUnmWCE5fRJ5cP4OgCsnEbCsgv+tFUyx0l84AEAmX9dMWtF0ktIhznsja0ApF
         RBpj8X2lsFi5LnW4pcCtsgEp34F+uZTFbU1p7DxU8ySbR4i/Ozr8uVJXeO6xC/vamb+e
         6PGoZjLM/y4+LJ8Ypg2+IO3ca48Hf2xGxiPKscs95MgK1nB444PS+lmxkdC9qArvYD7I
         HtaTaLVE+ivuaLlk3zxbIEF5gr7495S7Pya4Qt6Q1LNAWUQt0x+iKXgcb5QH8JeLZ6BE
         hcHw==
X-Forwarded-Encrypted: i=1; AJvYcCXkYYm5kPkF6m6BWVP+AJH0q3zSf58HwKJvuJlfQQzif1txvs37v6dTPp3/vGvr4MQEQibbB6Xj2ltr9Mf580AMQrjo2FPgX7M0MWY9
X-Gm-Message-State: AOJu0Yw3SiWljV1I5+atGBbFt5md/zJrXYOGry6Jz9Mxr07yLVsQ5A3+
	u/WJ0Tw9rD9sg8e2xOlsHBMb+OIbrqQwmwOWZ93QioGlkFS0poMdMrzdLl5Huxw=
X-Google-Smtp-Source: AGHT+IGGQuEli06xc4lxHRwmkEHLH+J+jWaeAZEBTyYly20sTNZPUnHHWZFcp4FcGy4iuEd2zzsfJA==
X-Received: by 2002:a05:600c:5685:b0:418:f991:713f with SMTP id 5b1f17b1804b1-41feab42b13mr125950055e9.23.1715807271323;
        Wed, 15 May 2024 14:07:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm17424110f8f.85.2024.05.15.14.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:07:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, 
 Douglas Anderson <dianders@chromium.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 lvzhaoxiong@huaqin.corp-partner.google.com, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Brian Norris <briannorris@chromium.org>, Sam Ravnborg <sam@ravnborg.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, Joel Selvaraj <jo@jsfamily.in>, 
 Hsin-Yi Wang <hsinyi@google.com>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Daniel Vetter <daniel@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240514172136.1578498-1-dianders@chromium.org>
References: <20240514172136.1578498-1-dianders@chromium.org>
Subject: Re: [PATCH v5 0/9] drm/mipi-dsi: Reduce bloat and add funcs for
 cleaner init seqs
Message-Id: <171580727020.3184993.17823317356671253009.b4-ty@linaro.org>
Date: Wed, 15 May 2024 23:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Tue, 14 May 2024 10:20:50 -0700, Douglas Anderson wrote:
> The consensus of many DRM folks is that we want to move away from DSI
> drivers defining tables of init commands. Instead, we want to move to
> init functions that can use common DRM functions. The issue thus far
> has been that using the macros mipi_dsi_generic_write_seq() and
> mipi_dsi_dcs_write_seq() bloats the driver using them.
> 
> While trying to solve bloat, we realized that the majority of the it
> was easy to solve. This series solves the bloat for existing drivers
> by moving the printout outside of the macro.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_dcs_write_seq()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0b03829fdece47beba9ecb7dbcbde4585ee3663e
[2/9] drm/mipi-dsi: Fix theoretical int overflow in mipi_dsi_generic_write_seq()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/24acbcce5cc673886c2f4f9b3f6f89a9c6a53b7e
[3/9] drm/mipi-dsi: mipi_dsi_*_write functions don't need to ratelimit prints
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/7d3f6acaf87c7db6dcd868694a2f65e7040478dc
[4/9] drm/mipi-dsi: Reduce driver bloat of mipi_dsi_*_write_seq()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/3b724909a380fddb44dfa0072fc459c698a52658
[5/9] drm/mipi-dsi: Introduce mipi_dsi_*_write_seq_multi()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/966e397e4f6032b73438f8d775756541513e7daf
[6/9] drm/panel: novatek-nt36672e: Switch to mipi_dsi_dcs_write_seq_multi()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d6fcbec281a2ed16794fabea49d4ac93db2d2944
[7/9] drm/panel: boe-tv101wum-nl6: Don't use a table for initting panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d6ddb6624a7fc4fc3d7750bccaf43c66b55beab9
[8/9] drm/panel: ili9882t: Don't use a table for initting panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/95951654ca57786c658942a7c6f4471ef3f0d47e
[9/9] drm/panel: innolux-p079zca: Don't use a table for initting panels
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6f6fd690de1aef476e631ac03779e7d1de3fe451

-- 
Neil


