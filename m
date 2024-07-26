Return-Path: <linux-kernel+bounces-263620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D7993D856
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FFC1C22662
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E08A38DEE;
	Fri, 26 Jul 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrSKK7uk"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA7411C83
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722018506; cv=none; b=JjPjLqyr/rLuvzfcE7eTP023nh+s5jWmW0Ti9YnROq+DJXXionw6Hllk1pz0HcwbUpT3/GVEZgynLbsg7sUc90ryL15fw2fZswIQPewZYZLDfpj8wITMnE2xMVDRJHYr9TXxOvKUzhuPjY16Y5yrqVbpHxGPP7hsStTGn+qkdNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722018506; c=relaxed/simple;
	bh=/hCmtFduoZjXr8wWkO90G+e2CChiWzFqbkWEwH9Pngw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAmrOXrMeLZzGiu/waDBo821kgLl8IsXnHcau9kzKYcfZ41kbHK9RwgVHjdUN1g+oSQhceuBYPFhRt5uRcAiH4dwib4/YanHoGV40NQz4Gpg5IcrOoTkhbG3aqorclovUXPBMpn9fnxxa2PmT/DYrkMrFyVG4hcfRM77DmRoEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xrSKK7uk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6512866fa87so23393557b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722018503; x=1722623303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ar5LSSW/uWQjcFvb9wqwW1qn7+87e4drkqRv4fjdD+M=;
        b=xrSKK7uk+sf2Y8AqvxVCdkRpQ7f+kQT8uq3IcR2w261Q6GUJHm/TsPHyiNqEP4wgwK
         eIQGo7jMaXvzsHDZktMyFAaZfLjujZ7E79EmoWo9sH7GHziUry9bwWNa6zbGsj8XsqO7
         2TN+b1nyN4g+ZNNidcGKhiQNOXste9PbZNy8QjXp9Tm6NWNS2qPi3SRu75Iw7Prc4S9y
         Qbvj0MbqSuL0lnN4UT3v6RuK9BG7sjK3v4nLenAo7IwsOkJx1+6xZ5FZrfXXbMNEYUaE
         Wa5DKg0coI5dWAu5dpUu/pni0/C/od+XwZSDGsoMGI+a69YqTIHcj/vkGq2eOkqgT50q
         +EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722018503; x=1722623303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ar5LSSW/uWQjcFvb9wqwW1qn7+87e4drkqRv4fjdD+M=;
        b=Mt7RB9ixanwKak3KWYw0pjvjXrgr/itGcw5aDWn4S01Iopo7Ogv8FBD08HOwkam9Te
         42mRb1MEUYypLJj41SjvONCjuvI664pv5WXoz8k0E8Iz1ap1bnjmH7o1O4OD30XSTh5F
         XYhg6pwlB5jaBLTTA92zH7jXRphuDLywi2fc03JMwdM/USCzmkTtMLfIv352RSClb4rG
         L0PAdHd5dHV71mlpV7ZNOfPvlCOxGD6kp6KGum4NSHOS0ibrqVAVMMVU4tzJgxPZ/abl
         kFuOGTw29yQ6J8ZpXdxEFw5eaPfthT4omhH2WY191D44vmp0W7OVO+S83ksxTz+k88fX
         PyPg==
X-Forwarded-Encrypted: i=1; AJvYcCXQabdGlg0xjd+eHQ0+hirlAJwXZXkuVEtgZz6pNO45enfNCCHuuiYRpH964Gy5M+mOzsaoRTvbeh/CrxvM9Q0g7Wxnykofi86PZ0cO
X-Gm-Message-State: AOJu0YyzCLp3287vMXaM1j62XSE4ryAGv0hc1RYDHTV9bllQExFqnwGp
	HazQbZyMqU4GSUIovz7fABWPPhxgkWnZ8GATJbbgC6N6bJvL2Rh5w3RM9/hvYDODI8pCwOvvXbJ
	I//uW1VlC8BAama6Rvga+yONXg/cNZRHDLAOJqw==
X-Google-Smtp-Source: AGHT+IHato9JiGqKZuTQ6+mFoYDwEL2j8h3hjQq7YdUcOaEIWebF9rgyOekGPj+j55VxlIaNZlt7JqiObKs/Wop42TU=
X-Received: by 2002:a05:690c:dd1:b0:644:b209:4de1 with SMTP id
 00721157ae682-67a050f3e25mr8147617b3.2.1722018503391; Fri, 26 Jul 2024
 11:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240726110139eucas1p24eb41978fdad0d37a95c2c829180a203@eucas1p2.samsung.com>
 <20240726110114.1509733-1-m.majewski2@samsung.com> <20240726110114.1509733-5-m.majewski2@samsung.com>
In-Reply-To: <20240726110114.1509733-5-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jul 2024 13:28:12 -0500
Message-ID: <CAPLW+4mL=sh+n_Wq30yTPuTb9UNKNX2YcgdyObdnoqwhHie8eg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: thermal: samsung,exynos: add
 exynos850-tmu string
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 6:01=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> Like most of the SoCs, it requires 1 clock and 1 register.
>
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> v1 -> v2: make the clock required in Exynos850.
>
>  .../devicetree/bindings/thermal/samsung,exynos-thermal.yaml     | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/samsung,exynos-the=
rmal.yaml b/Documentation/devicetree/bindings/thermal/samsung,exynos-therma=
l.yaml
> index 29a08b0729ee..b8c0bb7f4263 100644
> --- a/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> +++ b/Documentation/devicetree/bindings/thermal/samsung,exynos-thermal.ya=
ml
> @@ -27,6 +27,7 @@ properties:
>        - samsung,exynos5420-tmu-ext-triminfo
>        - samsung,exynos5433-tmu
>        - samsung,exynos7-tmu
> +      - samsung,exynos850-tmu
>
>    clocks:
>      minItems: 1
> @@ -131,6 +132,7 @@ allOf:
>                - samsung,exynos5250-tmu
>                - samsung,exynos5260-tmu
>                - samsung,exynos5420-tmu
> +              - samsung,exynos850-tmu
>      then:
>        properties:
>          clocks:
> --
> 2.45.1
>

