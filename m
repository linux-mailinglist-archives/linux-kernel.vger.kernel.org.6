Return-Path: <linux-kernel+bounces-569973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD7DA6AA53
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E3C188CF24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E921E9B0F;
	Thu, 20 Mar 2025 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nAGWYm++"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01174BED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485881; cv=none; b=VMHXqrl6wGPsehnjMMNaLLzdP3NMxIrtyxC/G+l04sOk2eGt6OHSVPpI54Fsn9k9BF/4flnUdfA4RDYmDksJGPDGBGy5lGggul/wJFRnu+exaREdvJhE7Bl3ba8xoQsgppV1Xx35uw1eYby1jMbZ7ou1Cmrl+h8MJvNt+1/dTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485881; c=relaxed/simple;
	bh=iQJXcm4pjfesK6vrqwTdoAIF9nij943yk9ESVUbG0DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUvtByu+vFAz5FECC5RepUhQ8wZL71LLvKJHuko+9F/J3q4o3tSHsPIIudjzkvtn48/wXRuVKEhfKw9ftMGBFUGQHImMVRN3YiWWTBsRAvjO3ZXHr8tUDf6n0Jk+YSlRU25X7g5pglVrqwNZ+QrTYo0hXUNBnb9XwsfHUr9vQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nAGWYm++; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5497e7bf2e0so1111248e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742485876; x=1743090676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5z/VEzBbLLXlRP9QOXiRcjSgPGJWosjzyohY4aZ/MV8=;
        b=nAGWYm++7fUlmLontq3YglVo23W4XzM7qUBMjZrpftWy26CSwcWfFFIbStBMDkOjKz
         WEn4kXmZBotxOeoPWGxTv0PbW7AnZlLBEp9lYOw4GGwjGctsqR6HMmfMoM6JhTEfPvOZ
         y/DBNy9uRV2D7Gq2A8Emo9gisXQ+GYcPWjqa+kXHN/8egnGQXcqICZ2fNliYBiWCY41k
         qWX+I0IoLjg5hd0Khy03sJ3UQ25fxdhSMr/KKFxsnGf/yJq7XaeFRW+4/iaVt5CAKyji
         3rYnz2Eh/wz1LyQE/GUK6TElCxn9oDJc+FHjcLCrGm5AcqI8coyR50MAeCnXNtHtBO7j
         A6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742485876; x=1743090676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5z/VEzBbLLXlRP9QOXiRcjSgPGJWosjzyohY4aZ/MV8=;
        b=Z/TO+4+R7DvxOUbsXcgxXfpKQVo4hinmWROdzfthwzaitLVRuCkPPWC4cp0X7K6gWH
         z8RuhtMjVIwX4+ZFPNpbpKTgcP/pnHhb8Id1m6TjTLUfyWYE3UTjAoYFPYqSP81WBDFi
         go3LCO4qAVyvJI6FWi70WXXzurWW8DOFadLxqjkOwcs7O7qiayazSP6Xx+Wc22K9CZo5
         Jujr12nqgos20YtMh5gK6zsxdOs2nICCigSm4WQCuFo44yieQMb+eLIMqMpC21vD3gWb
         ztEqKMJQorPsd1gq7zHXAb/F1gukZgZZg2bb5BqBp45dTv6f6GGDfCGpnfyQlhlsCEnm
         zfbA==
X-Forwarded-Encrypted: i=1; AJvYcCXoRqgiDFvbOR/tfnREWG+6t4HPj9mn0raLmrb0fNclPyw4xRzrX/9tRf97sKGhjNSxvLjhRfVVdHHt+wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwpMjGC7+13x+LsF0De25PuR9cNuwEfl+cz6VOMn30FczH/QB
	J5XdYR9659d2SWqxZ8+jjBhmo/Ebo5dxgTdzbi4nsgjbVkIE57euYldLctgBd1Nyi1sgEX6Amky
	MKuE3itF3bYBl1B7jplFW7lJobFtbsTaHyKX7Lg==
X-Gm-Gg: ASbGncvuY+semGJUR+mkXHBDTn+vjLonmt92r9JVooMwSANw3CopzJW/hHEKcI/qCRs
	tt/TAandVsFQGy7HN5Fo7ms6vfvWZTo0Ba7Ax6H2GmQxcbGNt/h2xKpIX8Q5WYqHeieXXS8lZDs
	+Y60HGa8PfpG0m70Etr6IBKerND8LRtm8lwut8abg6WaLc5FxnDqV2sVyYJA==
X-Google-Smtp-Source: AGHT+IFKAv3g3rjK8xZ8Vd95dHFfjGK3xNxuuXvvoxIeGhxQYGrB5VnELTx+bDG/70lnFVD9ia30L+sXpL6HUiMvrKU=
X-Received: by 2002:a05:6512:3d06:b0:549:8ed4:fb4c with SMTP id
 2adb3069b0e04-54acb1ce817mr2905569e87.24.1742485875426; Thu, 20 Mar 2025
 08:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315164123.1855142-1-koichiro.den@canonical.com> <20250315164123.1855142-4-koichiro.den@canonical.com>
In-Reply-To: <20250315164123.1855142-4-koichiro.den@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Mar 2025 16:51:04 +0100
X-Gm-Features: AQ5f1JoZ3Z8Kn1fbCGuu8An41HgVNKTTOw2RDi3CwG5rZGN0-HtUwHYyX3yt9Ns
Message-ID: <CAMRc=Md8nB1U--qcZxpcKVzxTcON2hi-pmsUKFn+aBEqHuBzcQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/9] gpio: aggregator: add aggr_alloc()/aggr_free()
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 5:41=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> Prepare for the upcoming configfs interface. These functions will be
> used by both the existing sysfs interface and the new configfs
> interface, reducing code duplication.
>
> No functional change.
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>  drivers/gpio/gpio-aggregator.c | 58 +++++++++++++++++++++-------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregato=
r.c
> index e026deb4ac64..2692a31e01ac 100644
> --- a/drivers/gpio/gpio-aggregator.c
> +++ b/drivers/gpio/gpio-aggregator.c
> @@ -36,12 +36,41 @@
>  struct gpio_aggregator {
>         struct gpiod_lookup_table *lookups;
>         struct platform_device *pdev;
> +       int id;
>         char args[];
>  };
>
>  static DEFINE_MUTEX(gpio_aggregator_lock);     /* protects idr */
>  static DEFINE_IDR(gpio_aggregator_idr);
>
> +static int aggr_alloc(struct gpio_aggregator **aggr, size_t arg_size)
> +{
> +       struct gpio_aggregator *new __free(kfree) =3D NULL;
> +       int ret;
> +
> +       new =3D kzalloc(sizeof(*new) + arg_size, GFP_KERNEL);

Please prefer declaring the auto variable and initializing it at the
same time. Should be:

struct gpio_aggregator *new __free(kfree) =3D kzalloc(...);

> +       if (!new)
> +               return -ENOMEM;
> +
> +       mutex_lock(&gpio_aggregator_lock);

If adding new code, please use lock guards.

Bart

