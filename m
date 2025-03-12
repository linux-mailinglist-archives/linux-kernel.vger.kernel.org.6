Return-Path: <linux-kernel+bounces-557504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EECA5DA15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310B2189D4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2E623CF1F;
	Wed, 12 Mar 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LM+WMKTE"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD223BF93
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773675; cv=none; b=YwpINSxP2vklOJ3fOgC+mSv3ZWaAGQrmECejv1EeAlwGapjaOvy9+RGHvfZLWNNuurwjdhCHehzHhcu/uskfA1/zF3srT5pNe+uDc5ttSBiEr6Hm2KxTJPVbcqMFqAcjSR3uNudDR8lYl8ihjoRNrkO7yIzH1JOxyWcBaIL6b7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773675; c=relaxed/simple;
	bh=H70cromMzBc7G1Dxdn7Ujl+1TcPLdylbz6SBFKEdUOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7wk1HL5khNmDTHgZLkihTKVf2jM7/1QNoQU/MpPCJ3/RjOKIFZ59HOgGOaOm91BV29objxP8WWaMQg+vuq8J+KjU97ypjILQczl/zUxzKoJvi2aFj4joLC4zEtQrld8BKufEFg0HqkeVveA72fYeKtbYAVOsbPit17YHxX0268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LM+WMKTE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30615661f98so68652961fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741773672; x=1742378472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H70cromMzBc7G1Dxdn7Ujl+1TcPLdylbz6SBFKEdUOo=;
        b=LM+WMKTEtBro67ucRHGFG82QurBUVVTKueWjq6fDb4ct1i3KejryugfkoRLxmXodsT
         gEpX5bmbXgc0Pia5+kYM/u22mb5eE2PU965J+nKcNzU+gnD5g0qPMC+AGwDIvQNU6OvV
         4gMhJu81ak6Plrm7PcR85qREnu0ChRdO7Emv1PqiXCRAnO4HUygSvj4GME7wukOG4JqE
         nNvagmkxB0k4nQPKYBG9kk4nnP3qFHWfkRXv4BzJq1kZiCUbpYTyee0J/hz4Ljbj0zUU
         mRyJzAftdRRvSOocXvmTHIPX+TQQJF6mMMuI2P28z22iLTQX56T6IOJLTq83PNJ5WsYz
         J8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741773672; x=1742378472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H70cromMzBc7G1Dxdn7Ujl+1TcPLdylbz6SBFKEdUOo=;
        b=DqWpoqcrOQQ9usyTV/K32ddtSmIh61CnN8uNz1J9Z8nVS1t4g8jCTfTvJChveGs0J3
         piizcUtOtzTC8Gyx2Gwg62JkbvtCwhtIFxw+z2UE5TS4gG3vhHATIlIrVHMFuIkAfnRR
         Y0vf+M7TK3uH59/otUNeSKUMJaDECZJfnuuwe+vNFok+/bPwsf5ACk0pFBlU5lvdkNUD
         bHuuFqcWdn1KE7VZ2SYptyoDqBZXP0CkHlK+kRqDkiHxlt25bMXd3sEShT6Vk4XpRifa
         M1U2tGusTfZ6eK9+E11AVFYDkUCkuMHiYHbtkzgGaqDwmJaV1p/YwlQTI4QPcIYPCDPN
         /OgQ==
X-Forwarded-Encrypted: i=1; AJvYcCW//FX6tnpddHsd+DTngP2YEgqOCi52dV7gNNBC6hTbrbpo3h+qUGlxYZJeSpDa9KFcJD4d9BndqpggMRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrflb1gTDLzQ/m8RitUL+/SsR/BNqFCXYMFWseFzwN464ey+D+
	txC4iU1vjgrJo7TanLEj8Mh5fbKMw0GASOFN/VnMndTpKLtnDvy6cO5tduLmjNUpZ6LnSXw3O14
	eXdZl1NpLoYekyrzbATVlU+gJAnr4Ei0hem/bBQ==
X-Gm-Gg: ASbGnctloF6Io8CCfTeiMRWxaxQr+bunPi8Hag+z+HZbjl6ZcVfQLmAdz0d2zhSrRk1
	C8eIxYeCKBzh1VsC4w4cu3MZpi5M8Ffzbsm9rNd8H+QZv7Q+djRwELKX6PEtG+UucSeiYfqPd00
	N4BNKW3Krrsq46NZk91AiJFeT0L1BFv61kcJTapZ/0A7wmc8XQ2w3jIWZh0A==
X-Google-Smtp-Source: AGHT+IF3JsnGDmtC8cFGGo9UJ3LwBpBWNU0LU9dhkqF7FdQC0xv6vW0juUcQgoshe4Cj7uKAJnjHv9k5v01339Iy9Rw=
X-Received: by 2002:a05:6512:220a:b0:545:49d:547a with SMTP id
 2adb3069b0e04-54990e5dac1mr7224533e87.18.1741773671774; Wed, 12 Mar 2025
 03:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org> <20250312-max77759-mfd-v4-1-b908d606c8cb@linaro.org>
In-Reply-To: <20250312-max77759-mfd-v4-1-b908d606c8cb@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Mar 2025 11:01:00 +0100
X-Gm-Features: AQ5f1Jp2A-9h5YN6Ed4bZKIBT4UotjU0jd3UNyhUp6pXeEy9BD3imBjHO6ZUslo
Message-ID: <CAMRc=Mddcku1vokKQzxyJOtvpdJSjM2TFvG9r0tnZ_qY7HBGJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: gpio: add max77759 binding
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:26=E2=80=AFAM Andr=C3=A9 Draszik <andre.draszik@=
linaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This describes its GPIO module.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

