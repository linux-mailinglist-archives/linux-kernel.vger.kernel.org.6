Return-Path: <linux-kernel+bounces-259293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E099393A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FFBC1C21557
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B9717084F;
	Mon, 22 Jul 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/wE/RZQ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7216EB7A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721673602; cv=none; b=FkZDNe2VmhaX/jx+GotPtMAqwEdg+QECqTdYHmYRfbGJVVczdrugHwg0x4x4nZKC99ZLMwYJEeufRhL6uSZUGfgny5LKGP9/bUnDSowuG5fAzQ27BVGBEXUIYn1XFwrOWvsAQKINnqQEDbsKG9o3d5owz7dzKje+LLMKR/dqJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721673602; c=relaxed/simple;
	bh=jiivNKC7lQbRfNg1Kjpt39Y+ifXLk9Fuixvd9EbV8+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWIbC47ZXmlu8v1VFzDsu04BSRPcj8XScNSEt5MZnGnYZdN/y9+1F0ZpiHtwJYprH806E9/8DMJzvNm8yQwXTXpUSn1KUMYB7j/dMv6dHWuIVWgzRYOn01XKhWM4Pw4BnbnIUBfP0Wn303q/AVC7DRP6sGGJfTLIv46F9j3y5Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/wE/RZQ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-651da7c1531so43437867b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721673598; x=1722278398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1c97fZFJ3UOJw/ZZR/BLt9bIZt0krqS+WJPVRsmyTw=;
        b=e/wE/RZQWHKigEckl6HNT959oxaZ7ZC4jQi2uz1f11XBtrOdCSL2IOvOfawiqHTWY4
         tqpzp4yG3rGi4ZGCajXWslVG50XnJXqXKtX+dIta6m1COUOZeOsXLqdsuRKGm+lcFfAd
         JR7M7CRlc7TXZ0rXSmKvHAsASWPu6j+7RUNhKb4V4Lyj19ngD64lp2Z++aHEu5b7U6Pf
         Ng3r19lk1eFB3CC7zBBxHg5eVdm4OpHmDC6YJnPRWt4cWfKlH0JM28FzAIhjLRct+CSC
         3JWKtX4DABpBOXkQCTldq7Go43GrHCZZMcGdG730JvLrdyojYM/YDhr5Sqqzs1tknvAc
         q5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721673598; x=1722278398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1c97fZFJ3UOJw/ZZR/BLt9bIZt0krqS+WJPVRsmyTw=;
        b=DXb3cyuFTYcJyda6ql85MwzU4eD5HZ/KNOQobb0Tzocqfeby2iJOpJaUQvHrs5mhGN
         zL6CpQmYeVisjKwaR7iqvVtfmH5fiT4IIp8sONFNzJlg0cK+T39TnTKh4os0fezStkXD
         AK5ki58idPdE1t6Z+fHTKTNZ5Z3FryLZkC3goTqyNmwbk66suuYHVtdsOXoOZcyWs9F3
         zybjL4xwytSCoOOs+SCp5M+/xnvUT9pVTpPOEq31+OYhOyKV0KgkR+jI2KNlUNF2qAit
         MJ1DFym7MKxXUtwKmMgvEA5hqALmfILhAsIQsfh+xufvI8e+WuHaKn/Ep4v4xtfgNiud
         uI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXU7S60FuJ5osM7AIng8BoTB9brh4w32QXXsxRWaRXSJ715acxpu0EPhuLRQ5ErA28xEMgn4m8XvSwkt8TH8ZBztHMzDwM/iEogP9/F
X-Gm-Message-State: AOJu0Ywq3zDC09XnWP9A74O4gZdWLR1xAb3SydZ4MfofiBZ3tOqSem80
	bPomqk1nqw/rW1ChiYKcXa6bN21EdNhOHIOnO2WyCtKE8jkGq+1Zd5rU8f0Ka136pzEpgSVwkrt
	knF1sp8YVrNgCfOyt2c4B0sElaZizs/sI4D8PxA==
X-Google-Smtp-Source: AGHT+IEReHOHNiIFa0oMgVRxlCG9RA8ftspFBW9UmBDqwYk4Nh57Mi8IAfbccJjJtUaTYgJaPpM1V++zASopTbzE/EM=
X-Received: by 2002:a05:690c:2e0d:b0:64a:7e85:9a94 with SMTP id
 00721157ae682-66ad91c36aamr79649327b3.21.1721673598539; Mon, 22 Jul 2024
 11:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240719120944eucas1p29318fb588150b15f60f637fbea48271f@eucas1p2.samsung.com>
 <20240719120853.1924771-1-m.majewski2@samsung.com>
In-Reply-To: <20240719120853.1924771-1-m.majewski2@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 22 Jul 2024 13:39:47 -0500
Message-ID: <CAPLW+4m0xG5yHOT_ucGdrOhLZvjhga8caqHQZmVH6HHKUnBgkw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add initial Exynos 850 support to the thermal driver
To: Mateusz Majewski <m.majewski2@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mateusz,


On Fri, Jul 19, 2024 at 7:09=E2=80=AFAM Mateusz Majewski
<m.majewski2@samsung.com> wrote:
>
> This series adds initial Exynos 850 support to the thermal driver
> together with its requirements (tmu_temp_mask fix, making data->clk
> optional, adding the new string to dt-bindings), while also cleaning up
> a bit (using DEFINE_SIMPLE_DEV_PM_OPS and removing some outdated
> information from dt-bindings).
>
> Mateusz Majewski (6):
>   drivers/thermal/exynos: use DEFINE_SIMPLE_DEV_PM_OPS
>   drivers/thermal/exynos: use tmu_temp_mask consistently
>   drivers/thermal/exynos: check IS_ERR(data->clk) consistently
>   dt-bindings: thermal: samsung,exynos: add exynos850-tmu string
>   drivers/thermal/exynos: add initial Exynos 850 support
>   dt-bindings: thermal: samsung,exynos: remove outdated information on
>     trip point count
>
>  .../thermal/samsung,exynos-thermal.yaml       |  33 ++-
>  drivers/thermal/samsung/exynos_tmu.c          | 279 +++++++++++++++---
>  2 files changed, 270 insertions(+), 42 deletions(-)
>
> --

Thank you for the contribution! Did you by chance test it on any
hardware, perhaps on E850-96 board? Just noticed there are no dts
changes in this series (or as separate patches). If no -- I'll be glad
to assist you on that, if you can share dts definitions for E850-96
and the testing instructions with me.

Thanks!

> 2.45.1
>
>

