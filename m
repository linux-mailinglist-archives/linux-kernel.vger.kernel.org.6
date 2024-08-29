Return-Path: <linux-kernel+bounces-306746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EC39642E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6A1F23881
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E519048F;
	Thu, 29 Aug 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skch1S/2"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAC49474
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930549; cv=none; b=e7LcTZQKv7B6oICf98nwyZCd76pqRvsjvHdB9667Nso9c39PUEiQhd6lnmt/8uX3gzTou5x8XNWIMaOmMszDRYW0ZmoZ5aqwWLitn/MMa3oteZU/kQzOYMWoE4FOxJOHPj5s2XStvKQzRoRT131GTufCUgCBk9cMu04PcfJb2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930549; c=relaxed/simple;
	bh=O0Y/AFpa5aX5cFCa3K5odeAxS0xeOnjrnas4BD7VE10=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=irZ4nyMojQq5GgtKiuctjAtnZFbXX6jbPb01PFT/4Zq1uV7/NHfCYMA5PiUUYBNjnA7TizfZjV1jz695TO5z+VzrDJ/aMcbpgYsQ6mO8Ys6UJnG5nwRsqpkY3wIP6nbxVK2pniWB1wlBvnVwmS5GryJtmydGagIpotxRZaNC+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skch1S/2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb72a5e0bso4043895e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724930545; x=1725535345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwq6oUC3DLFb6LHJMA7x3N/oOgzyp0ek1NiN8KPUNVo=;
        b=skch1S/2QXg6n333kppDuvHEsPH0pY3X2Pd+Sgz+BGgf/yM7IuguSJLaVpnhTf2DXH
         3qpOgJ5KF2J+1a0I75SU5/U5ea8+QEHyY7G335AmXE8ARh710iR79KtupPpmCkKdIRuV
         CiMM5FRzZYgFUY3rin3ibWn1lIv73esJIQLfyQgMY03DEPd88sPagOH3BLR0Kmvt6n8d
         R5SgS/NcHrYdVpDBdt17QeQc24wRpjy/CtSPvjj7OiKonDKG+XdEvEis4uVYbRW2jKGU
         dmewF6oblToo5vRf761IjI4xacSrrxU6IhLCmhz9yfIq5CluyCBUlFxqc25V2KxCotXY
         Hcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930545; x=1725535345;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwq6oUC3DLFb6LHJMA7x3N/oOgzyp0ek1NiN8KPUNVo=;
        b=unwiRyN4Max5yiA+xmxvta+1sC1RFHbjWzh/1cvinRVGbGieHZXUZIbaQsz8aVNhJF
         w2T7n9r4tn4anaLhVt4pJR4bRhSo4vpezdxyB+aYOmWSEG+Pigu2SZ9MWemK+YeN0Qrd
         3ZaJdeRM6acZsDxhulMGclKg76BTrwZvi6reRvskzR42Zx81a1uW7UOEYz1eLvYbyLmH
         Aw+wlEOTookolRtXtwcuT+TL14lR46wKsTzetS21eXbYVba2SixoKyG+/x0Y82Nwrinl
         iNftCtUKpL+j1F31IrxstLSDZwBu4DYc76jlGx9qVfrJLNAPu2nD57YAFKQb3vQPz6Xa
         4lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0htMvD9UJF51JzvW8RFHxk6M+Q4pm9PLT//WqqZ7I8WMFp+ko++Gl0N4lvwFvBObLJGVjw2uoGy01ix4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72O3HzTbToThaJwCejgLZXGGB/hDGkFL0WurvE2WRFlNmYZH3
	sfRmXJZARvkfNUJ06Kl52eaVhSUe8u1tG1WAP2TATh7YsLRVFNEu+ziIpBKrQNk=
X-Google-Smtp-Source: AGHT+IGX8FgKJ9OLClmHZ9MmqJf1OLjmkFuFn7waOynWRsD8HlkQEk2ZA1PtyRRNz/LCammUU4hm7Q==
X-Received: by 2002:a05:600c:1548:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42bb01bfbfemr21200945e9.17.1724930545034;
        Thu, 29 Aug 2024 04:22:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d60sm14122015e9.43.2024.08.29.04.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:22:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
References: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
Subject: Re: [PATCH 0/2] drm/panel: annual cleanup of visionox vtdr6130
 driver
Message-Id: <172493054424.1145269.17157130520267583947.b4-ty@linaro.org>
Date: Thu, 29 Aug 2024 13:22:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Wed, 28 Aug 2024 18:03:38 +0200, Neil Armstrong wrote:
> Switch to _multi() dsi functions and devm_regulator_bulk_get_const()
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel: visionox-vtdr6130: switch to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/175d648be98bae22eb22444377dd9a0c497c9d46
[2/2] drm/panel: visionox-vtdr6130: switch to devm_regulator_bulk_get_const
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e0cb0c785250d0565c19ba17fc95bd7ab97670ba

-- 
Neil


