Return-Path: <linux-kernel+bounces-362201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D895599B208
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 10:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DCEFB223A3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 08:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C98145B07;
	Sat, 12 Oct 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w86uTF17"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475113211C
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728720956; cv=none; b=WZH8FzPtJrkQBB6POiAE3AB76jrZgtxlAou9bNMNwbWZPMdGPb6ZJUC5To+K6NYgU/JBnQJXeSyOaav/gEdTclCt/Vo9v2asf9naGTFC073d1l+MqN40SovHKChSLqwjmRyAiE+czngER18VE4cUs1VkinswFHqO+U9kh9/I6k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728720956; c=relaxed/simple;
	bh=PWHU5fzEo5gAnHKkrItOxCsgYv5K3qCVxg4l4+hAF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AMG5BeAT91/L0taPD09l9IgWqyrPqn2Goa4FS8Yzk7JZZ7smTynThWtux9rFO9l+Ml2O17dhHyIBHc0cRLVh1YNNE2QPXCqTulzoKBPArM9Uemb1W6mkD+yXVXuQtnXZqq/ylYZER+E2kKZPIPHuC7q020cNpUM6gRPsKz2FCSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w86uTF17; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e7e73740so167929e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728720953; x=1729325753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98Avhm8RF4Q1UREJOF0ug2jybyp+VJAFuutUoDh5cao=;
        b=w86uTF17QPhECQQYzJzoQfR3eewnbj3OjvXp8fHYJ8Vhblxq6OfBbT4ldMISq2ywFI
         bSk7VX8dbLfwk9TpOPK8qxOlwTS57AF66zJcPG36keCDO+s5JDKAS7FlWjhHf/O4aCFN
         7TJvis9Lw7sJQlppkyvSwMa4qfcxtiVLy8e3BipJq4Vce1kPb9OWBeSk8zSDAom2xoYS
         X0r1XWtC+qbkdkznVQT2dJSxvB7uCX5cxoAdYBgz9lVZYLyRgSxc5Qr68I+MgOguFenk
         ngSArGSuRBpkPIPK7PM+3tzPGlmL3GjR5r8GRi38pd/JJdEdjNNKQPGK+ac9EZahW6Cm
         zxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728720953; x=1729325753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98Avhm8RF4Q1UREJOF0ug2jybyp+VJAFuutUoDh5cao=;
        b=dw3Z+k5ILkSf1NR7OZ4oePwhx27UHyF+ewcwtgvIOsoHwylNO2U/nfbNnbezYMtsuK
         +YNEy9whjSVSE3xFzFmdXCO2m7dUrBxYE9xyrERzOOI8IpODEmMQDydQgFAAU/OYac1f
         63EP2JZ2z2dzjth6WNUkMgL+/OvHKzq5zPfeA53XZfldgR4maXf40E4gHEsVwiYQ7rZW
         Kg3vBANvKktovQ4G2uBOrJsGCB+WGVkbrVucLCOOzRJf39G2w+9+qjjuaRU+n3mtwadw
         iIs+BfkVDqnlAvW0hYo2hrdIbfZw4vtdjx4IMQd72E8c6aNhn4z91WaqkyIOzDb/gkc7
         E8AA==
X-Forwarded-Encrypted: i=1; AJvYcCVI65eO1b7oh8ZSYh2FIXy/n44x0jrFbNxe5LBinrL7Ip1mThWr3DIBEBXfMxfgRVrXIwPMrD9++kAOTDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qZD5gWN38Sw9Y/RJXtJTJf79lj6az9oRgeudyuPOLf6o4YkA
	1+5+RfFBV/UgUnpzDt0+kK1nj/Fwwc+yg6/TJRaNPaZkYqwKt0KbMW3pQ/K+xB0=
X-Google-Smtp-Source: AGHT+IGgU2DIDo2BCzgiYQv6VUZx5oN0m+5FPxjeT4o7Oi65BfD6CL0NSjctE1q+BkuYP1KMk5kOfg==
X-Received: by 2002:a05:6512:3e05:b0:539:95f0:a05d with SMTP id 2adb3069b0e04-539da5b344cmr2428747e87.58.1728720952823;
        Sat, 12 Oct 2024 01:15:52 -0700 (PDT)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb8f0ea9sm862700e87.186.2024.10.12.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 01:15:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: (subset) [PATCH RFC 0/5] drm: add DRM HDMI Codec framework
Date: Sat, 12 Oct 2024 11:15:50 +0300
Message-ID: <172872070672.2226967.8196347515267088542.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 15 Jun 2024 20:53:29 +0300, Dmitry Baryshkov wrote:
> While porting lt9611 DSI-to-HDMI bridge driver to use HDMI Connector
> framework, I stumbled upon an issue while handling the Audio InfoFrames.
> The HDMI codec callbacks weren't receiving the drm_atomic_state, so
> there was no simple way to get the drm_connector that stayed at the end
> of the bridge chain. At the same point the drm_hdmi_connector functions
> expected to get drm_connector instance.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/5] drm/bridge: lt9611: use HDMI Connector helper to set InfoFrames
      commit: ac4627c304e7a09068d0e2dba34d21e492649f8d

I'm pushing this patch separately from the rest of the series, it provides an
example of converting DRM bridge driver to the HDMI Connector framework.

Best regards,
-- 
With best wishes
Dmitry


