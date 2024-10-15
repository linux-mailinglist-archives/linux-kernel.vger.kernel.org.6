Return-Path: <linux-kernel+bounces-366814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F368F99FAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5561F2227A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DD51B3948;
	Tue, 15 Oct 2024 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yO7PJ2b2"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CC21E3AC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030001; cv=none; b=J4HwcLgY0/u5jFRsZSdyQ9xy3yNvzCEhnuEOV0mtFbZnT/vqisMW7EVEPrNU2BGjqp0m0XJElo8GnDeum1L0345iaIg6WEgvRSFZTGPgp3em869CiiilAIxmh71Hu/F7mo7rPaoWuit8rc0yy7FjpIFXcwSS2+frXYNU2QDCFvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030001; c=relaxed/simple;
	bh=BJE4f1D4lRKL1gR0V2Ux34adfzE9M6v+2sRwffzZB50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSujbOOxPkZEkXCHMcnWwRIIAMoWe0xiaL4rW2qaFyrlBCSB2/5i6L6fzY1SAyoLhrzLO3eJIYGQuoAC3q25yPtv6gDs0Vzhnw9IQcbPhgVvxoJ/xJESIffb44PSbZj7ailhRuwJgEGNvaShfXY9JKeUEnBhkK7/6Q5ka389Q1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yO7PJ2b2; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5f647538so3440571fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729029997; x=1729634797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df2UGXMrSlqnXgDl1o8PQ91Gen6dUgFMpKkG/5j+dDI=;
        b=yO7PJ2b2FsCDhboc2GtB43Vcy4TmBKq+0jR/crXVAydjm83fCqVMY0VAS4mB3EUxNA
         vzniKMM8UKlZcX+YIbQk8dJdIB6WC1QkkKuta3gCI8tpLg/rJkjvV6Zx/jzZI98vHWZO
         g6f6U39xTT+nK+wjoBAWM0solnTo3wqKVd0+JjFR4BDi/rVeyKfrWMkeuJTCtxvJ5erv
         8Ujkll0uiqLWdLYhOqNIVh+kIsJmzpvnnTDVA5y1HDwZJQbGhRQ6ObluLx0eVkZqsmAY
         BofOnWzmOd6D3y2C39WEyfngvm+ucngrDiPr8VDZ2N6cC9ofT/g4HxYHvgO7FhNQDncC
         kGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729029997; x=1729634797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Df2UGXMrSlqnXgDl1o8PQ91Gen6dUgFMpKkG/5j+dDI=;
        b=W1n74A0zaLbHS+nAB8SvBB6VpgaOcqOahZSSdQhSOAsh7LX3yqcQZVkto2rcnPT8b2
         H+Kolc0MdUiA5n1be5+CxbtZcC08a6A/gvTqZ0VKatYybZL1iC35L7YcpJic9apNlTA0
         /ahbmnKE6dv7xgdVuBQEK6W5sMbD1CAmTKtr4Bw4Z6fV5+oJnDRpP4ZbHUFgoyciwUEG
         48FPhzbiwqlpmgqgnYcq1y/RUShI7a41NxJuJeFPGhradHAI6QM3HvL0WGWv4tUtJlw7
         H+5M2/GuQcv96PWjkWP3Oq8F16HQIyi0ZuMtjXsPQySAqdKChBVom4ig2TiXPIg0hwRJ
         AIPw==
X-Forwarded-Encrypted: i=1; AJvYcCW+tPBOaK1mCYyMD83rhNOAhB0hxX0I1HCRo1kz5b9vbGaE8xkNbbD3WsqHZsSzXxQRPxrCwdNCObl0MoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASgO1emCX7mCqKRpzhiySURApivPHNF1RXPqi1gAeNZX3VOww
	Efn3y1tk+US+IwdwHGuLjzD1n0LYd56d0bsjHnQ+IVybzaK4sMrIKlbapxAaGyQwx1rWTlsoj/O
	KWpuyy2BmGcpfcUaB0BI/ClvJ6duDy4vo0VMkHw==
X-Google-Smtp-Source: AGHT+IE02MJ5sLjtZ4n0KaJRs1Aik5DxDdANs4F0KVaTmjkcUN3BW1HGzLone+n39Az1ks2iqiI4fB2KQ8bjyI2qUHY=
X-Received: by 2002:a2e:4e12:0:b0:2f7:6371:6c5a with SMTP id
 38308e7fff4ca-2fb30f53e35mr45632151fa.16.1729029997149; Tue, 15 Oct 2024
 15:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 Oct 2024 00:06:26 +0200
Message-ID: <CACRpkdaJ7Qiar-nV+-HJ=7_thLK-Trrw79eA5M+Wuc3FLDpyTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: samsung: Fix interrupt
 constraint for variants with fallbacks
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
	Jaewon Kim <jaewon02.kim@samsung.com>, Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Commit 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7
> fallbacks for newer wake-up controllers") added
> samsung,exynos7-wakeup-eint fallback to some compatibles, so the
> intention in the if:then: conditions was to handle the cases:
>
> 1. Single Exynos7 compatible or Exynos5433+Exynos7 or
>    Exynos7885+Exynos7: only one interrupt
>
> 2. Exynos850+Exynos7: no interrupts
>
> This was not implemented properly however and if:then: block matches
> only single Exynos5433 or Exynos7885 compatibles, which do not exist in
> DTS anymore, so basically is a no-op and no enforcement on number of
> interrupts is made by the binding.
>
> Fix the if:then: condition so interrupts in the Exynos5433 and
> Exynos7885 wake-up pin controller will be properly constrained.
>
> Fixes: 904140fa4553 ("dt-bindings: pinctrl: samsung: use Exynos7 fallback=
s for newer wake-up controllers")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

