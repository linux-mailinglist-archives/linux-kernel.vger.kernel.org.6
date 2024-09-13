Return-Path: <linux-kernel+bounces-327868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B77977C10
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA491C24623
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA021D6DDB;
	Fri, 13 Sep 2024 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgeKm0Eg"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472DC175D45
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219119; cv=none; b=pqEiVwMvN2hrSwh8Yeb40So1BbMyODp+XcOGefpb9VwDp0yr9RrSUImR+b9ZpU/iItXUcFbJMkblCx3euEwNTNVjYiRP9VoFRbVKZeUCtxiK/Mlr3TPg056NQzd0+4G1X0Mu8NX6S8YZOSLmMK2a8osEHZkBNQrzBsFqAZUE0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219119; c=relaxed/simple;
	bh=4gJy8+NFk+tTtEwukRfqZdPyfvFXHMCfJ66Zgi9Vvf8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T6L1Bb0030nEo/+qJssIeJQFMPxdhQoKCJ0yH4Wr7L1c6g3I+yEpsTx6cZrTDWl5071ul1ICLLbZbl0ico5/yj2Vq5ImK/egxOUv+pckIjGnjAuHvXiNp6CfgVylOXU+Oj6h1+TGCkmTman4pnJ7t0RvUm/Qr5k4HkS5NYasqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgeKm0Eg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb0f28bfbso17399875e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726219116; x=1726823916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq1OUH9zOqOD8Y0n9EUsrRMAyvSF4LZSIOe4n6BSVno=;
        b=GgeKm0EgC9ErhkhEguP51SkYnrVu6C4M6+DMkjjn+rnW5Ue6Xax0oRltUGJC+aOAWP
         OZJKc+7As6vFUZQY67xTStppp2X2XbmIDOU5aCR1Cg/gbxma2v4ZhwJPP/hD0+Q8yQ1r
         TFZWRfvAQIId5VMiNQQTzOzK3xk9jmaAkWWcdf2+Ngp0iINywaKhjylJjWcn7qgd10RG
         Sz9BF2nEPHio/RLwKzd9q/i3WDA9hDnEatLw6BaLGlcoLBBfZg0TyiU8Kp96vXm9e8Dg
         C3iT5GxgAW+mitAMwJT4Opm3I1QsyaKdGzBi0jbjWUnyaP0Z7zzJ6G9FLfgETnS8fG88
         YSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726219116; x=1726823916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uq1OUH9zOqOD8Y0n9EUsrRMAyvSF4LZSIOe4n6BSVno=;
        b=NbaysDJia+rlSiKVBZfq5/kZA3H+S0s1+l3S4fS5arz8u9lwEDXM9Y1veGaC+B1ewz
         b1yTISeEUjEAZxOjpT5Kx1D4ACdHMdg1+tUMCZErrD7k1ao1/BvMQdwpG86YqzN0/mvo
         B+u412Do9BSKA03mSxapgDmEBcUATU2+0rMYTF0c7c+5mN0lv81kfD4MuinsjvkReP3E
         OUfWOl4PCRh/KyXQwoDA01eQrqQZJBTT07i7EiPd1FUZpPIywRPaO+2x8PNDKABHcRqI
         pgTTNWwQBAtNNn/8Hfua1Z2OSXXRhxNKtzpeWP4IQBkCU0Uzr3A++Uah+mwEXhU9pZQR
         /kDA==
X-Forwarded-Encrypted: i=1; AJvYcCU3d9TphMmiIFWltUDIFc//LQcalTwXFXwDkNW+eSVQnFAIY1isX24uyYyeAmBSyvxKf8TlzQQMQsJ75jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmP24zu70c9xaxvf7sOZcTtwQSxAHvUaQBjEAAYxXq+7pDsFq
	98Q7D7tDnDZTZnh1g2+D6CGuF8VWE/ow87m0J/3hO6TAD6ujkLf+RrpJObMX2pCwbKzyiMvawO/
	n
X-Google-Smtp-Source: AGHT+IHDJGoQVhZeDx+JOIUQ9Cd8sptY6QohqTjqBy/QDYuAMQ9PBkRfRMdewJWGkhuVGeZYURG05A==
X-Received: by 2002:a05:600c:4f4f:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42cdb53bd22mr47776685e9.17.1726219116378;
        Fri, 13 Sep 2024 02:18:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de0e2sm16258982f8f.105.2024.09.13.02.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:18:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jianhua Lu <lujianhua000@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240904142907.367786-1-lujianhua000@gmail.com>
References: <20240904142907.367786-1-lujianhua000@gmail.com>
Subject: Re: [PATCH] drm: panel: nt36523: use devm_mipi_dsi_* function to
 register and attach dsi
Message-Id: <172621911559.1200554.9536280533966410927.b4-ty@linaro.org>
Date: Fri, 13 Sep 2024 11:18:35 +0200
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

On Wed, 04 Sep 2024 22:29:07 +0800, Jianhua Lu wrote:
> Switch to devm_mipi_dsi_* function, we don't need to detach and
> unregister dsi manually any more.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm: panel: nt36523: use devm_mipi_dsi_* function to register and attach dsi
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/62f6bc14bbd12c13abe08b5a1bd8e55c843b776b

-- 
Neil


