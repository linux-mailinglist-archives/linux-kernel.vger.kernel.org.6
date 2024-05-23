Return-Path: <linux-kernel+bounces-187102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FF8CCD1E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC0B2821A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D3E13CA92;
	Thu, 23 May 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS2Cfdns"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03ED51016
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716449883; cv=none; b=BY4ZcwqpIC74zdGFiJwkMveUIqnQStLLZ/3YecLCXHoixK/zyv8pmOB6CYnh1KyNiDrv1TVxM84zlazaFEpI0+crahLl8BGXC0nwSeHySViBTUvJh7GIjs7mT5pSKp2+141f+pXvOKsLHRci+tD+ivnKvNz/x1iQY14RlGhpGhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716449883; c=relaxed/simple;
	bh=QbvoPlfBNdrd/WhUSt/Vgv5PG9/ChYN017RnW9RjwyU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VBCgZ3vUgyXFR+rnylUcuNiMh2WqTMmN5CBU3E0YIzcWVFzm/Kam4nbIiYro5cKGQefss33ad/YpMdIfrSMLl9kv1/W64EFoIbbVXzzqBid7mQdpgmNOhahNU1Zu7mo80dqpiVigOxVPNWjfoFLRrgICHtuGejjo5860eCTTRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VS2Cfdns; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-354dfe54738so1181845f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716449880; x=1717054680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl+iAI5K26DEll0VRgVu8PUUNjDInH4W5RuekMCF5nI=;
        b=VS2CfdnsICB/My76KYkxAF/vLkRNsMKbA+8QrUGBrgGVagFkzZ1/ADH+7uQoqwwWYz
         RyPMxOQkldrqchK9XCPD1Zqus5cutKldtBg6Vv+ys602nxB6y08zRAM6m+eI5mUUHuj5
         KRTNl1QMzCBfItI5R3wozzjKSH9CvLcLjgmZVGJphq/9rHPUEgZnjvS1CC11vPG2w0Ew
         L9WLK79bsZ0ETU6mQfg4KJuUvqj3xOUyJaSdHSy2T8UersU5dA96iriTS3HA8XC0QOBw
         YnMUtEtETZay5bGU9Wa1q+CcB+78tv1fy2ltSzB5UZt7AyOMJJ9kUY8Tz3kn1oetGOmQ
         fq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716449880; x=1717054680;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl+iAI5K26DEll0VRgVu8PUUNjDInH4W5RuekMCF5nI=;
        b=xC+yvYdGnSE+GxN0SUZuU+1S7VTPSDT1uQ88osodfgZRmSEy5jzm1hv1GFAv59gqoW
         jeFCX6czgJHH+baOZZvQ8n04fVsToqPMNv11ZwkWdRj+O1DTT79G1ARsYSWm2cCDeOwq
         nZooQyWpptuSgUJX9Fu9y4b8MInaG+I8BNyulwmdmmWutx8/67vkNMpVhj/KAU3uR0uF
         Cku11Uw1WCbB3J81XLUWIhbLZYXf2atr9FcDfJ2CEA0ZU4HaGTi+ey8sPk9iwgaF2tmI
         STTNpkxUija28BW3VBXl1YJlNEmv3Ai807dkOFDuTDUD0Uh7yPPBiOoDJ+20EyksB7xs
         JgMA==
X-Forwarded-Encrypted: i=1; AJvYcCWC4yEp/MIJvblhlqI+c7clZiT8eLcGdPuoQCkhRvkvNIRy4VIcBdpw4p8q/UAFxizrj7ACmqL0cQXdIcbGGfvsmYcGqEcw5INixIAR
X-Gm-Message-State: AOJu0Yy1amuNefMqujBNOPSzQnW5gMvSiYf6Pg5tVXabiVE4tJDJKeyE
	L+yzGAuJodY35XQ7wrcLbhXXgb23EAXAHLBs6T/Kf7MF6xzBsffISkOouD6Jfuw=
X-Google-Smtp-Source: AGHT+IGxCy+R6DXa1uioyKqLkzy8eBBddT/Xs+TEdS0tI/tLzh/voAk/5vtXzmVG0ekMZdWy6l+dbQ==
X-Received: by 2002:adf:9d87:0:b0:354:ddb1:1c37 with SMTP id ffacd0b85a97d-354ddb11c81mr3578880f8f.30.1716449879987;
        Thu, 23 May 2024 00:37:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354fcf20f4csm282500f8f.47.2024.05.23.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:37:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Douglas Anderson <dianders@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, 
 =?utf-8?q?Kamil_Trzci=C5=84ski?= <ayufan@ayufan.eu>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <megi@xff.cz>, 
 Shuijing Li <shuijing.li@mediatek.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Xinlei Lee <xinlei.lee@mediatek.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Subject: Re: [PATCH 0/8] drm/panel: Some very minor err handling fixes +
 more _multi
Message-Id: <171644987900.2016197.4033111392889834294.b4-ty@linaro.org>
Date: Thu, 23 May 2024 09:37:59 +0200
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

On Fri, 17 May 2024 14:36:35 -0700, Douglas Anderson wrote:
> This series is pretty much just addressing a few minor error handling
> bugs that I noticed recently while reviewing some panel patches. For
> the most part these are all old issues.
> 
> This also adjusts the new himax-hx83102 in a similar way that Dmitry
> did in his recent series that included commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling"). His
> series handled the panel driver that himax-hx83102 forked from but not
> himax-hx83102.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/8] drm/panel: himax-hx8394: Handle errors from mipi_dsi_dcs_set_display_on() better
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/cc2db2ef8d9eebc0df03808ac0dadbdb96733499
[2/8] drm/panel: boe-tv101wum-nl6: If prepare fails, disable GPIO before regulators
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/587c48f622374e5d47b1d515c6006a4df4dee882
[3/8] drm/panel: boe-tv101wum-nl6: Check for errors on the NOP in prepare()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6320b9199dd99622668649c234d4e8a99e44a9c8
[4/8] drm/panel: ilitek-ili9882t: If prepare fails, disable GPIO before regulators
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/554c00181968d43426bfe68c86541b89265075de
[5/8] drm/panel: ilitek-ili9882t: Check for errors on the NOP in prepare()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6a7bd6cde73f0fb7e5faa964dbdeb45b55c64698
[6/8] drm/panel: himax-hx83102: If prepare fails, disable GPIO before regulators
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/509eaa8aeee64bd7a41ca53d8728e497a9991074
[7/8] drm/panel: himax-hx83102: Check for errors on the NOP in prepare()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/676a079fb3be66aed12cf40f236c77b8e7c189c3
[8/8] drm/panel: himax-hx83102: use wrapped MIPI DCS functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a2ab7cb169da38757323929f7b3b4cf396ec53b5

-- 
Neil


