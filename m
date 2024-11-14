Return-Path: <linux-kernel+bounces-408837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 755419C8423
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9B91F2356F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7401DFD8C;
	Thu, 14 Nov 2024 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d6RVNI3e"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583D1CAAC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570372; cv=none; b=pio3EsVlO4UdfEnvsJ3wV5zHbaAq2qc4eUmnZIOLTvZE40mnmg5f6drlwNJk2zPzHzxY3Yq3WnDGxgWO+/EDce45xsiKSUoLIMN45zgUEdBJ2fPfp2cS5zTmuDr7YimVFvuZMHDc9K9RWZCchW3zgyjUbhtoqJzOe2rpYgh4yeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570372; c=relaxed/simple;
	bh=LSVHN6+4B3mrJyoE5/o8RTiqaMgmbaOrWRy9LrctY28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8rd9VrLY9FgFT/yQW44mLre6WPfg6pOAGuIgFv6atpz8wFVnlswoiMSoUOXcFKpk607iuOFzusE+HEatDPmaDMyCs8I4MLyyL6umakeALrcGVBLA0cl/y86K/cQE7lqzghC6w/7/FEvvsb2a/gHbgrzff8LDESfenATuxVhm+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d6RVNI3e; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so2870781fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731570368; x=1732175168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcYuDRBfayb6mBBMDxqM7+ACEUaNjvDbSVP1//2NycY=;
        b=d6RVNI3eBIvIVluFIE1ZH4PKcSoxtglkw0PLDFryxvmbknexi24tmhHkH4Fs8jQIA0
         NZAQsyAOUIv/qJ8gsDC1yXBiw8ALQeVVluvmi2Scok7E7eYQ/jEZz/1oKRzlhiPVygH/
         3jY2d6oTwzlF/OD4YIMG+B5BzKrRtuPyqoDe5vEtZQf35hwRFU12X6xW1poD5+PjZozc
         P5pskuLTfbXmpomL/pwh6apMBmj1AU5ybeYCSMy926baRfQVDSYlH3wP9ZakaRdZ5d2A
         xfLdBHWy1xGAZLM6v34RpXtcl3sjvov8O0tH5cJtYw+JjuZfe38L8/oW69vdZlXdUd5f
         6fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731570368; x=1732175168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcYuDRBfayb6mBBMDxqM7+ACEUaNjvDbSVP1//2NycY=;
        b=jiXocDB8fChrNVXBQWqe6eKtTAqMF9SqfbN3G1A5rZL8AasDmTJakzekOeax0bBqqF
         f16y/I8FVDl6+KgILYUlAoLkCE2hN2jzjNHcNbF4lkpBSgaCbHCjrW29mavsLczrzdqT
         b7zAVaz87ZmykNoxop98TsZDa35rVCs3nK8xsBVAzQh4hYynFyQwkaZJM2WRkfr0okCq
         LKoI5/Ms2OhJPccItq6n0pkxbKNCFCsz/Aa/NnWLHvGweunHbIk/OJ7qwq4gkNmBDVIi
         rQc9TKc/WPmk1sv05+YG0CH0aKJhLYofPolPpwhmb57qT3J0j5h15b68LLstFb+heRUs
         +2NA==
X-Forwarded-Encrypted: i=1; AJvYcCXLssX9AqjWLH+iDQWuC38yyDNoFL4zO62P8yk99L8h9FATtdICr7bWmcHoi9xrExq4TYzTqRx1SY9vFI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbyxP9Ugpuxk7od4B58Hgb+lXqSN5KX9DJy2XdEoC4cLXlir48
	GH6kStBW2J0NlXtfvGA7MqxvoEuBP00Xy07aTiBMV4V0ZpDmzZXV6wVhCBXAOvprtcuPIVJ+vbI
	vW9Hfe1wWeYMPjfL7CGz+BVOoJ8wHysbFP/e6tQ==
X-Google-Smtp-Source: AGHT+IGCEDVqcslf/1H28BU87PXy+jbV6XN+UhRo7uz2l2rNis7Lr6kBiIrOnmhujdEdkkE6Myy7Rurh9bh+a8s+KnU=
X-Received: by 2002:a05:651c:211f:b0:2fb:3a78:190a with SMTP id
 38308e7fff4ca-2ff2025944emr126536061fa.29.1731570368516; Wed, 13 Nov 2024
 23:46:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113171219.2949157-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241113171219.2949157-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 14 Nov 2024 08:45:57 +0100
Message-ID: <CACRpkdaUUCXS7ifmM8fLF3Hgs4YKNLCxPripfSTmMEKvcLOuQQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Move and sort Kconfig entries as suggested
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 6:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The Kconfig under drivers/gpio has a specific comment
>
>   put drivers in the right section, in alphabetical order
>
> but in time some of the entries fell unordered there.
> Put an order again.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

