Return-Path: <linux-kernel+bounces-292460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF85956FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67503B28560
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9523C176246;
	Mon, 19 Aug 2024 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYjYcf8E"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32206175570
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083383; cv=none; b=W7/KL+jgik94GAaWTexfIkxZ9v1XrheirLKp7LB/J+jxkh9QzooaeeuSA/B9sbEafxLj+1VdXiSTa8DwCfw0P/SEeUxTHPokAiGyZ9cX8gYel/J7KuVwU5j4EgxgViJ6VI4oYKWvY4gXIOvCmvR081JzW0U3/8jDFazXE58tRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083383; c=relaxed/simple;
	bh=wwxX7v30OV3KMo8BZ2UfQAO0pbWwIXFrGSRi4Jktq2E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gUNfgWXyz/FkCyA5HODq8azDg1/D9FSyHJ1lIgaTxpQ+gPa32tolMABqXtAes2a5sI4M/WDdBKIgOrrZIeNAoIo3BpPailxAiN0iOXZaIbDSuQw2FpId6Z8rrWPBcvAWskaXP3KEpdq6WFST3cLRooTot6YpR3+669+d8OQjxtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OYjYcf8E; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4281faefea9so35276145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724083380; x=1724688180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIm5AIc1rs1wFkF7rx3Vybk+LgYQZZfGKlSD6OqWXYw=;
        b=OYjYcf8EZC7e7KHpUKXiZqaVod7tavWpPcS+Y0ka6CNT16GVM+UAmbByDZxwKFFJ4q
         QFuAczrKoM1t8/S65yk635wmqPYPjNJEm/UfwenGI60dhjj7YqiG0+l/qQ8Z1KQr4BMd
         4Mk1qWvZ7wl7fjKPojCKPdeyW8wAJJ5+EBIHZyniS43pEpk3hqLNmEYopAqaum9/fVL6
         YpRbqZnSrqVu23FbsaHAzNyhrd7Xz3ItOL1t9sXnKMtWNnZD2oUKY77/D0fx56f4Bmr/
         qxZzlaiE8evRZn3qZidXh3YC62QEovfdMUtnKHmkCZzMX+/xTeEhhrvOO/tqO9fpDW2t
         Qkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083380; x=1724688180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIm5AIc1rs1wFkF7rx3Vybk+LgYQZZfGKlSD6OqWXYw=;
        b=guVv6IKvo/cvKb+wj438UnqaMpvzh2/v9DvZhB28+8TJXlfnuIJb90cU8PeX6Cl7VC
         UI0ypcQGijsSjRyBasdVGUQgh61Ac0+vMs/bjxaybwmSwsZrrA1kEJXx2ncGDLD8R4f3
         zib5aFXVKCHnPmoQsf18kkYSS+xGHpEhchpOjKttOrru395wvvTqFv4mjfd/YeZwDn57
         ZPEtuz40H9N4LPwQiguwc4V1eFuS53U1ePfGFEdwX7YBAIhp9P2LuWIDytYFl0EzOu0i
         kP7b6mX+d6Et31CzKVYNXSZIqHsPWIA3GZPcORzZyWCkv/c5S+SbusvcHk6NZiG+AF45
         e10w==
X-Gm-Message-State: AOJu0YxBD+Dd3ktzpyA/wajSIxvgAi+JbjkCesKjWDXV6xMxHHtAplUP
	WEOTC8WUc10Kcgzi3xibCIHqVWVPFoZwudSFYIHNvKWfCHfLZo78IrugJY+vgkA=
X-Google-Smtp-Source: AGHT+IGuwzR+Pe76TvMgOJvWX/WfjTd/rE7pWKgN8HYr94IuvHOY+JDJP/vG+x0fCT1HB2/isZ0/RA==
X-Received: by 2002:a05:600c:4e8c:b0:428:f1b4:3473 with SMTP id 5b1f17b1804b1-429ed7cc4c9mr72422445e9.26.1724083380149;
        Mon, 19 Aug 2024 09:03:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabe9sm10907638f8f.92.2024.08.19.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:02:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org, Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20240804061503.881283-1-kikuchan98@gmail.com>
References: <20240804061503.881283-1-kikuchan98@gmail.com>
Subject: Re: [PATCH v4 0/5] drm/panel: st7701: Add Anbernic RG28XX panel
 support
Message-Id: <172408337897.1748689.3164061549359158890.b4-ty@linaro.org>
Date: Mon, 19 Aug 2024 18:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Hi,

On Sun, 04 Aug 2024 15:14:44 +0900, Hironori KIKUCHI wrote:
> Add support for the display panel of the Anbernic RG28XX, a handheld
> gaming device from Anbernic. "RG28XX" is the actual name of the device.
> 
> This panel is driven by a variant of the ST7701 driver IC internally,
> and is connected via an RGB parallel interface for image transmission and
> an SPI interface for configuration.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/5] drm/panel: st7701: Rename macros
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/00b8a47d8ebe0419e649dc81b96033f6db6a4746
[2/5] drm/panel: st7701: Decouple DSI and DRM parts
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a055c91ac6ea493c2508401537e8732dd2a7bbf8
[3/5] dt-bindings: display: st7701: Add Anbernic RG28XX panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9a01fb40fda3de773eabd87d0d10f9c1f49ad581
[4/5] drm/panel: st7701: Add support for SPI for configuration
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6a60273a0e8274820210abcfe7ec0d5f1f38f458
[5/5] drm/panel: st7701: Add Anbernic RG28XX panel support
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f7c4a15225faeffe1e9f9a752097e7d85603ffef

-- 
Neil


