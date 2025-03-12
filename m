Return-Path: <linux-kernel+bounces-557603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1053A5DB70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95233B8D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED2244E8C;
	Wed, 12 Mar 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H/69/ZqT"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032F2441B4
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778724; cv=none; b=skRlA1Zse9srejdkupk/bWjE4ttc1AZU5UzCRurbmWNcygtaSAhofLBUpe5wRGfu5gYIEZ1h2RrBIbDL+CqLCABKzop7tDyH/SDlCPoI3BYGs34rJxHib14rKfS+xocdMIP45NgdcgoQRtP+KRYGQG+UDrXfTtO8w/fh58eROdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778724; c=relaxed/simple;
	bh=/RhKTxmR7DPjGeSaHLhrD5HO/cS4tcbus8dYscpFo90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC+K9Jj0sCUIfNsQrQfgscjktDr59ZHt85KwvP8QbqRoohSiT2usOzsixH6Vrh+WWjW/zi3oSk1XbVZrjR5yG7kF58PpvlPkq78qm1m/SDXJcqfbySzlciTknLxYVZNDaphswSev+zwGU19LFf2skgXKEzSVpHe5WtJSDY7Wbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H/69/ZqT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6fee50bfea5so33358337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778722; x=1742383522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/EF0zDFUflzONesty7VuCi7dpM8v0C1RgMUVQ/Huc38=;
        b=H/69/ZqTpuFErBCCv93u0JDMhKxcLlcBzo/5RXJr3b+ozudnvvBXNo4PDdbWvBoBd3
         0dSqzGfkCOqdByizKIbXgrV5r+UEkH7htwLMMtMNUDF965MwRf78Lpz4QxcLIWjqtMx2
         /HPNoH4fRTyIbjpkbRs6InH699xDY7VfrMVUL9PueBLKxXKY9gK6YOvXdla6wSO5j+08
         dtj5oKZMeXo+GGuDwuwl0bAFLDJLtDWCPaQEHxhJ9CHjXxOlqjirfPQZL3Qsb6DB616K
         Z6wnMEDSo2YI6j6SN/38nXjt27MDGateU9Z2kGh3QGciOZrvpkRIMrePCO/Xx1S4Bjd0
         Bjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778722; x=1742383522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EF0zDFUflzONesty7VuCi7dpM8v0C1RgMUVQ/Huc38=;
        b=TCpUFoxzcthuI/rEkWqYemVhel2LoZsPBbqOlAxMSvzM0H0wutYdrKaorH4lXeD2rY
         eA6SQs9AfyZtO+N838koADT65pMKV++UhgPqFXzirHBQBb0WqgL5ZtqBjMxOwy1bAK5g
         icgLdHw8X11TYSSVV9S8VvahXhEf1ROLBMxmPvP8MoYptZL7cWAmSr1PeVRlYqkWOKZE
         O0RA2YT6EZxziW43Z3FDT6fwL2u0uKDJTWI+sVlO7R3YkXiBY7qB98MbSdoNCW/ueYzJ
         ZzMEg1HoLv6xHNJOx2Z1qzp7X19I6WMk1SJ/Px5V1k2ac4DAGAr793577/08EqcAlTEE
         SFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMVXYtDF9UAiwvzgq/aJ7PS0ktVVf+ZWvDzTtoqTLg/kKr7PdsCOJntstWpxppQnp9VybSkT+Ywm0srE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9u2K5pqLv2Lmqw9tMuzEStErw1uff7KeCuTdH1xssXVQDfHZ
	RLeoWOcnuehifA0Z+zbk83q2KsTwOeYKpnLEP2k1UmmHVUr0zSuhHIjOl46j5QZwau2nsg/Ot2W
	mNZSpZi3gUQ+MhbboZD/+UTWk7MT2508RgJC4gk4XkubzA5qi
X-Gm-Gg: ASbGnctDA6wk3C67QO/PnhB88IBJ4aWHW+PDkZ4bc2G4i10rgmt8PVZsJCWyjsms2zW
	H6YHeb49yeOJH7/afMQ3hz5BsnWIfIinTeL+6fZ+wWPYSjN7mXF16D//8ls8EIYYneb4uZpKfEF
	h+0sTA3qXA/CbCc/UfkA06nti+1rM=
X-Google-Smtp-Source: AGHT+IFqygKUb22qwAr7SdPFa0reMvPuoDMxSiqht7LJBAA6dNVB//vX5+hUcQlzt9SsFOYTACa28ZoSjTZLQK0COho=
X-Received: by 2002:a05:690c:7441:b0:6fd:385d:5f10 with SMTP id
 00721157ae682-6febf3b354bmr296734367b3.35.1741778722003; Wed, 12 Mar 2025
 04:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227111913.2344207-1-kever.yang@rock-chips.com> <20250227111913.2344207-4-kever.yang@rock-chips.com>
In-Reply-To: <20250227111913.2344207-4-kever.yang@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:45 +0100
X-Gm-Features: AQ5f1Jo1-FHRoh7DeYJjPWlq5FRe7dVaoDojoDTMYnsv82KnWlepC9mm2gadUoA
Message-ID: <CAPDyKFqZeup0hKqeHFV6qOMpFYZLQOdj3xT_6PdSNWJiW48fsw@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] dt-bindings: mmc: rockchip-dw-mshc: Add support
 for rk3562
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 12:19, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> The dw-mshc core on Rockchip's RK3562 is the same as the one already
> included in RK3288. Extend the binding accordingly to allow
>
>         compatible = "rockchip,rk3562-dw-mshc", "rockchip,rk3288-dw-mshc";
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Changes in v3:
> - update commit msg
>
> Changes in v2: None
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 06df1269f247..772f592291bf 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -38,6 +38,7 @@ properties:
>                - rockchip,rk3328-dw-mshc
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
> +              - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
> --
> 2.25.1
>

