Return-Path: <linux-kernel+bounces-395163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B149BB9AC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A21FB212EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B661C07E2;
	Mon,  4 Nov 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="se6gMMNQ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ABA208A7
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736071; cv=none; b=WIkF+RVhHCWZtUsfeiDjGgv9sRAGbtYgjEvnAirL3uxcJARraS4jfJrqxhCTZ1arOytieeEsi3Zs66avM1uv1G6IMzTKksiXSAIPUhhBFDc/jyX/DogOQji6mA6yATNY0TfHl9ERzrtVPuw7jpXtbeBApgLAOb+0d8LsTvmJqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736071; c=relaxed/simple;
	bh=uGJ0bYEml/HrRXHxK5WrIBHnMo9oiduhoM1OOTxFknw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEZa7AzVodrR7nJQnTzqQv6Vozfn5wOEy1rQ1b+NtK98q6DHVAFh9WVTEYPYX0ZnzgzXeDv6psnGARaV5ipEaFvli7wmduwJBGBZhcgWJiODtChFJpj0XtvhIOuKgUUpS0YhBF+f1txtzTodjhAIlGYguSx+XKyYwaC5askYjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=se6gMMNQ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e333af0f528so891211276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1730736068; x=1731340868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r32SkwEDEGyM8KRubZcTgZf56txRY/08O0Oc/h8gpfM=;
        b=se6gMMNQf3UBYkZrZsqnjiQtS5Bt4nycaON/Tf8A1WoyxDqknLmRtMWLVFvpsbfsnF
         21mH2BauDz0IGG9VZbJx5caC1qX43nf8XY67XA4ijipeBqK5lXOKp/6+Y8g8w/ssFQtQ
         Ct26BMxgnd6/JAl5EhiB9s8tss+o+hHxz9O0Ml242NVSHv9xKkr9jv/hHLvZa3qiXkv1
         b2k78sU3jqRDUHN6Ktb9PrVv+h+jq4cZaWqVtSlCGr0XgwQ5s6XFAGgZh3hBDkHxMH3/
         SJ6WtbJDlIhRpUlwW4E08tti0FppJWB6JDe74LUrvummwWosGJYELtygpy85qG/Abqzm
         EEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730736068; x=1731340868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r32SkwEDEGyM8KRubZcTgZf56txRY/08O0Oc/h8gpfM=;
        b=MFoBH1l98pA2ACzv/cIaf7kgADNdOZI0pXjpQjBpSS4CyXJunhqqUJFECPqC5jIJwr
         CfsxCc3WWJXxsdOAQjJu9SXT+DTMl+pXPkCo79bIi6iFD3LHXGzI0NN2Fpr2L8y50agc
         uwhAfAICE39MtbByB12TQqRyCoMZDjAcfAKfrH9aV+OWz9ryDihsarUD9rVUQ5RBRKoo
         K2O4nBLbEZXcBAGb2mNIdiFUkxg7/yv/R2Y8PwfQwpSz2aHL+t+OsFNUMU6CtCX0mCGa
         B4yXyjWiUX0SYMNHtdA2mtgEX0oY3gmtAUgdR0Ue8lln8cldTlPDI+wzLMh9pw6vKk3S
         9POg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Ps5ncQMj4Qilk5XIYVE86A2oh6wtZsJO6bJGGEd32pB4g0q1bA2GhvVWa6yqlZwkwPiDHif5xIz68OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFILVk3wAPbqDW9kQBlME43UnTFtLeufNPS/NFumla7aa5klFg
	ojJJRWeSFpQHZRYRyY+omxiePbGluX7BPJjQtN26JYmYdGLTNUFF4MZWXqj8Y+psSEwF/0yBwdr
	rKUaqyKadt1AtKgDROCQd1rfzuQZ6QVhjWmulMQ==
X-Google-Smtp-Source: AGHT+IFujurUNdBIc2jhl5l4ausb7S50k/V0Wx+SJ0D+7ItaEAYASme79PTW2iU/NqOUarwZskVPOJUg2kPhSceaIIM=
X-Received: by 2002:a05:690c:9c10:b0:6ea:4e1f:2b40 with SMTP id
 00721157ae682-6ea4e1f3d77mr171184117b3.9.1730736067813; Mon, 04 Nov 2024
 08:01:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101-hdmi-mode-valid-v2-0-a6478fd20fa6@linaro.org> <20241101-hdmi-mode-valid-v2-3-a6478fd20fa6@linaro.org>
In-Reply-To: <20241101-hdmi-mode-valid-v2-3-a6478fd20fa6@linaro.org>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 4 Nov 2024 16:00:51 +0000
Message-ID: <CAPY8ntCyg7P2gZ9QpLFUQxZY52e4-MSA=6PM1ZfVBKWwgoxXjw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/vc4: use drm_hdmi_connector_mode_valid()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 00:25, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Use new drm_hdmi_connector_mode_valid() helper instead of a
> module-specific copy.
>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index 62b82b1eeb3694d1685969c49b2760cbbddc840e..486e513b898d7f761e8615f2afc193ca44b23200 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1752,7 +1752,6 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
>                             const struct drm_display_mode *mode)
>  {
>         struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
> -       unsigned long long rate;
>
>         if (vc4_hdmi->variant->unsupported_odd_h_timings &&
>             !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
> @@ -1760,8 +1759,7 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
>              (mode->hsync_end % 2) || (mode->htotal % 2)))
>                 return MODE_H_ILLEGAL;
>
> -       rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
> -       return vc4_hdmi_connector_clock_valid(&vc4_hdmi->connector, mode, rate);
> +       return drm_hdmi_connector_mode_valid(&vc4_hdmi->connector, mode);
>  }
>
>  static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {
>
> --
> 2.39.5
>

