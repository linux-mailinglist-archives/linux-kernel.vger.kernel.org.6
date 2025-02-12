Return-Path: <linux-kernel+bounces-511988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E22A33269
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65586164A51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13267204587;
	Wed, 12 Feb 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kJ5tsehz"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94735203704
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399061; cv=none; b=IP4DE4CfXmVZod9lPU7cfQ6hP5l4kBkdItxhUtbPaFQfofR10HAoYnAbvrOLCJXBUQ8iqjWqvyAYA+XxDqI7O++s/4K4srfBLP/v9BXGpxZzyi06xa6uKd2DV38B3syDIolpOcDa4UKiiPQvmoSqRLla22sc0641dTM7IEOyvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399061; c=relaxed/simple;
	bh=5y/tgsaLquT36eDgvZ3fW9Uidq26vHDDKgSZ/y9JSL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgKHjOgi04wZ/toK4BubSHCqZuoxPEJxcmr3s59FkNUB08jBKR7zXdRQ3vFeGV8vphmR20B3QeRD5iBYDG5wvePyQ6Gc1xPSBmf0c0YHzhj08uRsZsLV9gHLksoVUOC3GJqITBS8/F7hfiU3Jb73NBfGfnolzO1LvUOuQz+1Owo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kJ5tsehz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so2476801fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739399058; x=1740003858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu/vYpK5EdDCessSAfsc81pUNCu3XRPo/EhuZMObYC8=;
        b=kJ5tsehzFYWrNTpI3SApLy71AcU5tQnrtgv7A5a6gAR65Fmr1P3Zy6/MJEQLLNxcVr
         PuYwxtmoxeqGQsWQ01n5jOIb82IAOwATTzZ4raOCenQOUyRWR1KA+1IPuSZnuj/zKwEq
         7+e7nAc00awmy/uSmNZoXNHo06uzXJQkt5SsTRheH6U+UyNKTeyh8cj+SkadOwME2JAr
         HbSSMoLqo75eo8nUEQOY2NpQdlE+QAbQtA0qdnnVPhHQqJQT3Z+iK1pEzoFAOM/EkaD0
         2rJlE+iV12GrMtVmRLPTtZXhKBTtc5KLCGaY+CKsM9DkRio8g+oXzPpOkdszom4PFX9/
         sOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399058; x=1740003858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu/vYpK5EdDCessSAfsc81pUNCu3XRPo/EhuZMObYC8=;
        b=OI1ot4BAzsIfIEaOlLAcq2AqyvsSyQNr+QfpG3vMwvKGkuVQRpCejPdJBJtizSv7c1
         KgMF/m3iaoEW47ETlGZGwdkdwTh8X+/5bp7MFRKhOWTe2CfoTMn8odPvvkXjNR4vXwyM
         wrMt5O518ohY0fxsaGS2K79/eJC0/Wjp/tF+c3swhadA0bD4BFlZiwfHYDTQjb6yOvjU
         13F49X6xPD/Km5SxVRl4Z3IQswucP9LJr2JLgWVoy3Q9GOqiJPIsUd6bKYxHXVVZeq0i
         dMC5zI1ETOZcGX2OVv2ZWovf1B5y2F7KjTcOZHgkKiDZ6rQEEVqPz+EUE9hWfVXX+U5s
         vheA==
X-Gm-Message-State: AOJu0Yy+pkf1s/fkfm9VSTkuQUeRQBpjJ3DwLrulRs8oiqe63dDBdiZw
	PSTRRv7Usp7Sn/q860uclkPLhzU6IbLQs8w1gfGu65sxnY9t0Kj0ZI5P9sM8znc=
X-Gm-Gg: ASbGncuSN1T7k/MiIgpGYIhbqY5Fuv0ff/bwQUptiE8XQBt1iik/Myp7ljf1CPJZf/T
	b3+AeZOuvx0AFlGnO6zDiExO4u2YymFvhmS+czOoyBIxq9TWY9WxGTKVDDvM0V1+gxb+Q+T89pL
	tFPuPsSxzgaFdIMGo6y9qOIs9iUsbOBElszN8sWurnDJWpzPMZiodVLw8kjtoPh6loAodwmo1E4
	8yVZLiVBFtasiuNZXAMrYsvzF6CkyBdJykTNm1Y58RU9s+JFdfFf4VsnpYcFOv5Yx9bclCfaVSy
	QsGoOdsHgJnF7P/Oy/Zy51jLrGAwiP2WDLKhsChCuIqwCHNjRuIEtG7G2iM=
X-Google-Smtp-Source: AGHT+IEllG8xsPecNgr5L5f8FoBGVvz0RiYrsFEd203BKL9JYmw0NxRW3Sco6Y7CdnjBxXidfEeaWA==
X-Received: by 2002:a2e:bc83:0:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-3090dd56bd0mr4718971fa.22.1739399057615;
        Wed, 12 Feb 2025 14:24:17 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309100c6415sm150411fa.6.2025.02.12.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:24:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 0/3] drm/i2c: tda998x: move under drivers/gpu/drm/bridge
Date: Thu, 13 Feb 2025 00:24:13 +0200
Message-ID: <173939904858.578381.4749501592256297365.b4-ty@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250113-drm-move-tda998x-v3-0-214e0682a5e4@linaro.org>
References: <20250113-drm-move-tda998x-v3-0-214e0682a5e4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 13 Jan 2025 11:53:43 +0200, Dmitry Baryshkov wrote:
> TDA998x is the HDMI bridge driver, incorporating drm_connector and
> optional drm_encoder (created via the component bind API by the TICLDC
> and HDLCD drivers). TDA9950 is an I2C-CEC translator, being present
> on-die on the TDA9989 and TDA19989 chips.
> 
> Move TDA9950 driver to drivers/media/cec/i2c and TDA998x driver to
> drivers/gpu/drm/bridge/.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/3] drm/i2c: tda998x: drop support for platform_data
      commit: b7c5169ab9ddc3432161412bc2de28111306fbb3
[2/3] media: cec: move driver for TDA9950 from drm/i2c
      commit: caa6f4a75e9f8eaebd814a9c2d1602e0926f473d
[3/3] drm/i2c: move TDA998x driver under drivers/gpu/drm/bridge
      commit: 325ba852d148434c5bcb06d513af1933a7f77b70

Best regards,
-- 
With best wishes
Dmitry


