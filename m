Return-Path: <linux-kernel+bounces-573297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5CA6D562
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3092188A77D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0671662E9;
	Mon, 24 Mar 2025 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFubLlqx"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3C19E98A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802460; cv=none; b=K8erFU/mAF5QRj1qenMgF5KAbwXsC3J5ttCvC9X3ElXHdr8l2lQRoIPriY+eQlNtiEQ5nIGrwIKOBP6RuoP9anCmrAvTF5eEMMSEXMBNmFCXI7koap9QL6LPoXdJFxUjzhoT6WGMNy6nrBRbZwjdIa2XT0weREnncWj8l0/YGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802460; c=relaxed/simple;
	bh=LADn1kANv9yfbuyperCIqqOS/gvroECf2fXmlFm+UsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4V78GMfJrf8arcBSan8mlU4q8pbP+9x/njBgSDdHq0nWjP6b4tLT649x89iDPBSjplYwaqPNiyWsWiG1t6KN5Vz5go4kPIyLZoqR9NWjGFgjb35rit9aodgA5drnr+Skzeu4sqFmLN59shfIrNUCGZj587o4Aj97vPNxptUxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kFubLlqx; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4460700e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742802457; x=1743407257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LADn1kANv9yfbuyperCIqqOS/gvroECf2fXmlFm+UsU=;
        b=kFubLlqxdANp2SaBSJ2+aCPynJ9e/fXGr5+x5KsTu0KEQ5Z1rx+KrlGUENa/0QMuaH
         /5/t5mcT6gkVfaR4n3y/X4KhLEw2JF5yP0zVYJ5yn6ld+Be3LJKfWXuQ4TI1URgLrNyu
         9pt0pjs7qtqpLpGcU23v782REk8MgkyBhtq3q261lfdA+Ru0hNFCI/VLzVSmB3pPHhOZ
         GXl1S/WBnLQe7fRWeCtipLe48yeN+K+4eJtMm6SHFHLG5+EXn8A6BOwxzv8T1oQujO9E
         u6crXoeupzIXprAianNGWSNTAU5ckrOsndm5I9CHxAlJWJ+6IFWixJtyZvchiCj8ozXq
         58JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742802457; x=1743407257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LADn1kANv9yfbuyperCIqqOS/gvroECf2fXmlFm+UsU=;
        b=H+q9rbEABhQKRWNzu6tBgNg7UfStf94Qg3N7/K4MJ4c8rYwevoblaA970Nmesl64Dy
         sc2Rt2spPDyAG/LxI1Yz3GtyYeLdyIluFFPi/pWK7GW/fSaoWjRqvrrB7fJguadpJTu5
         +TfpJqP2TppYfez9euy3tgxj2cS02vgYIv0nWkiOy2zaPyAV5kylftKBuIcvZPx/v1JM
         7W7QPiko2uk+Rc3F5y2lWgJTzqmP/77b4fj/ROVmlmqANLca90AArOTwN+rhZcsVXbca
         TuXlPYcmRYcMZMSiJnGdNoxBzYE4cFMIjs9SLfoAnnhs3bHvXwe2lK6SN/KYvls+SuyT
         lLZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWQ8SKoPLswftrUeIhOGjxUteOoGBwabdYJF1SGYCJyAlR38mNQdoXZmN7Tm9lzE4JzmVEjyf0LoFigt0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bRF+kclC1YGzoOeJroZyEMmR25qkcAAdpByxPGyEpx+sOmTX
	mjEx0ddCHNePL+qlZ6TtrnxCyQtCUolLpDe9+NilebF9Aud7FB1ppHcPFH7CRzQ/DJ6ewnPAbpk
	V2Xn3gAOFFBpGo4EggY427IYOWnILTOuri8UdZQ==
X-Gm-Gg: ASbGncuN5brZDDAltwfiLaHLOwhI9G/CqTNaOeMhSr82ZcsmmOmYzvZ90snSiFqOEt6
	HXh0Istm+LdCRSc3bBQxWOh+weAs6cBQF5MnV/TeiUXrE82etut8AYFfj/Kt+uPOSLIh46GumIE
	BtfhTVaQ6xFOQKKBudrqw6H8U=
X-Google-Smtp-Source: AGHT+IFoKZEu+cWJ6kUjBS4RpIBDAR0l8rGtHeVCikA1xU6nS5VUl5q1Ld16dkGWapP7A6sIfZYBs2kqSSLj1B5qKIw=
X-Received: by 2002:a05:6512:3f05:b0:549:4e79:dd5f with SMTP id
 2adb3069b0e04-54ad64f7da2mr4777907e87.37.1742802457021; Mon, 24 Mar 2025
 00:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-wcd-gpiod-v1-0-27afa472e331@nxp.com> <20250324-wcd-gpiod-v1-3-27afa472e331@nxp.com>
In-Reply-To: <20250324-wcd-gpiod-v1-3-27afa472e331@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 24 Mar 2025 08:47:25 +0100
X-Gm-Features: AQ5f1JoLqXpK62k6ENcNGiw40yjAMqH6KjKoeHo5l6jpodi-SVCf3FhtdJEoj-w
Message-ID: <CACRpkdYLMJaC7XREXL4m62B6x8fc6XvmR3FfXYUfh=QKM3whmA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: codec: wcd9335: Convert to GPIO descriptors
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:28=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> of_gpio.h is deprecated, update the driver to use GPIO descriptors.
> - Use dev_gpiod_get to get GPIO descriptor.
> - Use gpiod_set_value to configure output value.
>
> With legacy of_gpio API, the driver set gpio value 0 to assert reset,
> and 1 to deassert reset. And the reset-gpios use GPIO_ACTIVE_LOW flag in
> DTS, so set GPIOD_ASIS when get GPIO descriptors, and set value 1 means
> output low, set value 0 means output high with gpiod API.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

