Return-Path: <linux-kernel+bounces-211678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66F5905545
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AD7EB20EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20717E915;
	Wed, 12 Jun 2024 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjHbeAle"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8817E8E9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203013; cv=none; b=mMaykurmFHpn8OECWIyz74pFr3dvLvhhFRucBzcsbS/kGZZYLzYtFUV2Xh2D/z5rYkJ+jhyNiWg3S8BWL2c003/c5a+XNoQS+FAsocwJgLeSIxnp7lztU03T/AYolBSiDftY+72OmrwKnAa+eLue9qLqFi61mC7yrWr8sADJLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203013; c=relaxed/simple;
	bh=nrCgGRwUUQ4P3s4cjco1QGlJ2g+lVcvVXrrJBdh9VT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oIWuESKxcgh2E7VrQVtOh9bjUJdMWh/UFQWx+Tx+wYxZdwrAwnJaJgS3/QFl/+dFJpAvCCWKCuENDtYYK8DS9zqeWGMdapJXfakTierXeDY5vI9v5eUhRP90QGpPkSL0lRhtjnaAp4fRHfuT/IMhKDEuXslMxakg3exj3CwAe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjHbeAle; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42172ed3597so6998775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718203010; x=1718807810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10RrM/p3EK+MrQ2L7mQTBTup46vdiah1TdTSnhIWRqY=;
        b=DjHbeAleqQWSQ9fYeY/4d1xYM7miKpwHoP4jY0XhHfXTC3czA+x8SKJf9E0Q75+ZBm
         98l4bf/l/RxaW9u66JFJYYXSdX3JTaowOvmHgpX6rBN63NRSqlyzNNYZ3v9xBDaMq32D
         G8Kns0JXd9JVD6lJt8/UnhkWSqP4Ayv5yNoVeJwYYG0YzV28jvoe/C4EOoVkWfd1Dl5L
         d0sC5u7TlkREs3RXjUN4tDWkTWQasWNXUCZlLsWwiCzPwAsxwDMhFt0b4GSysK6foUrX
         0wv+NHHoH/JRblC6GqyFM1tITINFCbWZk1jLwwHl5f8luMuHlrXGvy5HgaIZjF8TSVV7
         Z1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203010; x=1718807810;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10RrM/p3EK+MrQ2L7mQTBTup46vdiah1TdTSnhIWRqY=;
        b=HJDW4XraihgQOPsf1QTGCdI8t2EB333YRvAx8IgtyQ7orU9OUPnPzoKuKm0fGIIEq6
         kYX6ClDrzt1rgrcmyLBREjMxVMw7ij0AXuIw8jNLM5q85vBuJcM4vCYtApsYH68v99ge
         wn3zrSYIflyi7tcbG/qRCJhA7szbTVyKBeVrNkGjSrTUat8wRp3bHW/nAiZh2i+pGk+R
         DsSsJZnimE04qZyRDRJ8GRDSAUxzCRtUoPpwm9knGo1Rg7KIGRSAmkTVVoLLPwWEw4fc
         dZKfsr5N5ZuHylbCnQfaaTDteZus5C5d1NYGMUCQD+cLpbwpVHFB8iv2sSqC5zb/93y8
         OgPg==
X-Forwarded-Encrypted: i=1; AJvYcCXQRfVAaVcwJEpBPLzjoXVxIh4fhoYbv4NtEmNnqJGiTBOetmVPbvpuxZqwp8WwNSPz3Yfh379qGkpHzbl6HZ1dH02YLwAQ/jsko0x/
X-Gm-Message-State: AOJu0YxQoP+TrGvOat63lXA7XZiIj0LGzwqJtlM8BRTiF6O/+MgzFLeh
	GvgqY1RvoZOJzqJ2DoJbwZDkdDQ9NgiXnYCUc/CBpb2/VhsUPv1wc4Q+dgcoiXA=
X-Google-Smtp-Source: AGHT+IGvtLPVOtiFWrgMFyq9DtbW8o4WCqj67/qU+pmqjeeXy6OzoyX7cuk/Ir5K/S3ibokmn4Z8CA==
X-Received: by 2002:a05:600c:3d91:b0:421:7ab8:59c with SMTP id 5b1f17b1804b1-422863b43ffmr22542885e9.10.1718203009895;
        Wed, 12 Jun 2024 07:36:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f25dc3f07sm7881118f8f.79.2024.06.12.07.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 07:36:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 linus.walleij@linaro.org, dmitry.baryshkov@linaro.org, 
 dianders@chromium.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240612133550.473279-1-tejasvipin76@gmail.com>
References: <20240612133550.473279-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH 0/2] fix handling of incorrect arguments by
 mipi_dsi_msleep
Message-Id: <171820300907.2526372.2735368790944027690.b4-ty@linaro.org>
Date: Wed, 12 Jun 2024 16:36:49 +0200
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

On Wed, 12 Jun 2024 19:05:41 +0530, Tejas Vipin wrote:
> mipi_dsi_msleep is currently defined such that it treats ctx as an
> argument passed by value. In the case of ctx being passed by
> reference, it doesn't raise an error, but instead evaluates the
> resulting expression in an undesired manner. Since the majority of the
> usage of this function passes ctx by reference (similar to
> other functions), mipi_dsi_msleep can be modified to treat ctx as a
> pointer and do it correctly, and the other calls to this macro can be
> adjusted accordingly.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel : himax-hx83102: fix incorrect argument to mipi_dsi_msleep
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a13aaf157467e694a3824d81304106b58d4c20d6
[2/2] drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/66055636a146c435cd226fb5a334176304652f3c

-- 
Neil


