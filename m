Return-Path: <linux-kernel+bounces-513539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CEBA34B66
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69442188CFB9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B30207A11;
	Thu, 13 Feb 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWc992NO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B420766B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739466425; cv=none; b=rBHKEyCTYpON6Q2aXfjKOYI0uAf1LPLLy8z+eSPJlY5VVHFZeGVDUBHsdadXW51N3AFUoagUphseFKS44l8lveq7x7OF+P9q0aKrMTWPPJgS2MIptwAU2wYVRyYUfxIuPjx2DbvxUrPIP3SpiQ52QMZF42h3qko0e/DGomAiCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739466425; c=relaxed/simple;
	bh=O6x850tKrIqFZVJ54DB0+azfYOe8EjzHVEw4BZInX80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZjpuULEpSwTSVIDLTa1ZtkWThrwPI6DelUQNicGiwbC9ylAqREt+cID+6Y7L0QGBLLhQWoiX9Gx2CUVxLbsWp1fsVNl2w7cfAeOC2EKb4ARj/j5EJVo/+7Fj9mETNsJu0l5Ep4/pyWjx6WzPEkAfgwGXEclhs71kofecAIGp3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oWc992NO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-439585a067eso12023805e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739466422; x=1740071222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtQn4wgBm9cE7XQgLWrBO7BTmTZKoY45YwSnDy4FO4w=;
        b=oWc992NOQf/YBU8BTJcn+VDz8m709AAiAsSfnTC8G3dK3b2bJRdN1Wb6xoArrkQMXb
         qnqqEqDWTVbbpfgRsuLctd2AmVbA2uN7sOzAygDkA5JvqX1+x4xtzWQVpwj5jJTZHhf/
         OPuQ8YTC5FOaBlIkp4IqafBcxkFfGz/7EZg1Y3R36vGbU+Kx4bXvfC4GmhDgrzaERMjG
         CVBP9rdu4zHzNwWbkr6NU1cMG2YwYl+royXJFWkuOnNs+461oqxFwNelp6Ef76rnRoVc
         vXBzzksXQtQIlDYj1H1l6SVDEoCZ2fjfMB7fZphdUGMbeDPiF7yZmVljRsxVEg6Z7dcJ
         gmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739466422; x=1740071222;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtQn4wgBm9cE7XQgLWrBO7BTmTZKoY45YwSnDy4FO4w=;
        b=G6G8tdowtsXb47uSiLgiFJD/QEc/sMnhvBWBMqMCxejP6AwBqNxQqSWGvrhn2CiS+X
         R4lkfZlJvdRiTYmJGYDl6UcBOr9xBfDyXK6x8Tcr3AirnBjaBX5vGZSsZArcNszmO72U
         qdynNXP7DSlzNkgfSeQw13J9Xe8TxFH0nd/bMV8BhmoNohBgSjnuL5JcuTHcH7mOVHPn
         98HoeZoULgJMNfpCF3Ppl/Aa+ZJuBT01cV7qBFWcBrTegd+yQSo5/v9698NMaIiLnusu
         iQei6S9nkHlMhI/HGFr+GyVZkRh/qyH7uh/HcZ2cieXtdfIk5rmQPYnsH+/7zBtEwwFG
         lWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnGLwqFPjBmo4n01A8vTGlb1CrdxlBIMuhNeqlCrwt8jSVgo5RjwcuN+EFzXki+KsmkIIPunw0YoDNTIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XO0pG5uTK2SfhAYLGA4u2+aIK0oPk2Q1dfSw6t+Bx5c9gyM7
	sVpXMZSNv+vfXxX1EY5UsDfrGFNuklrdUXjf6JJiUiLvpqImxA/sQvHyC48jrew=
X-Gm-Gg: ASbGnctZGB6ftXEfgOgUILYLXTsHfFeBE9XCwC6AXbMVFUkLM4yqwox1Ipe05gTu9zE
	fgrCe39yEZ67eCpRlR0kSqVEUAjaXU/SlY1HKTudB9X2uFHD62p+5VCs7zQLt/5nR4+8ZrjbFfR
	b8o6g82r32xxigN4b/GktbBxlaciuKhOLVYlpj98oljLL71M6OL5SfceUbPrh5KEpNZR9JPaXnT
	YR3QobH1KpYSM9JAy8c0p9SVEQhqQ6edUKjzk1qsUnfpYcZh5sx1kId7iYWGfz6te1kiv9SWQMt
	k+EgQX52r2/VKseB+j1qrzF17OiniShuMy3E
X-Google-Smtp-Source: AGHT+IF8nhcp5YQz9TPZ6YIGpltlu/q9k8/XW67n8eICArykliM83NQmUsrzxgy/G3HVl38kAJ69vw==
X-Received: by 2002:a05:600c:1c91:b0:438:c18c:5ad8 with SMTP id 5b1f17b1804b1-439581cab45mr88901955e9.31.1739466422435;
        Thu, 13 Feb 2025 09:07:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a04f8a2sm53525245e9.2.2025.02.13.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 09:07:02 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jagan Teki <jagan@edgeble.ai>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240927135306.857617-1-hugo@hugovil.com>
References: <20240927135306.857617-1-hugo@hugovil.com>
Subject: Re: [PATCH] drm: panel: jd9365da-h3: fix reset signal polarity
Message-Id: <173946642174.322382.4123111314998976761.b4-ty@linaro.org>
Date: Thu, 13 Feb 2025 18:07:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Fri, 27 Sep 2024 09:53:05 -0400, Hugo Villeneuve wrote:
> In jadard_prepare() a reset pulse is generated with the following
> statements (delays ommited for clarity):
> 
>     gpiod_set_value(jadard->reset, 1); --> Deassert reset
>     gpiod_set_value(jadard->reset, 0); --> Assert reset for 10ms
>     gpiod_set_value(jadard->reset, 1); --> Deassert reset
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm: panel: jd9365da-h3: fix reset signal polarity
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a8972d5a49b408248294b5ecbdd0a085e4726349

-- 
Neil


