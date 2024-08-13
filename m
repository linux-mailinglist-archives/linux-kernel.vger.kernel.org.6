Return-Path: <linux-kernel+bounces-284926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE49506F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714891C22935
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7019D070;
	Tue, 13 Aug 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT/S8A62"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE219CCFC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557424; cv=none; b=DuooF6EjV7zHw5q1HqHpdRmeT5K93H+8oAPa946Es3pTZndPZZ8eFJPk3qUvCleeQkHOXGUiAGKAgIeX7KsQd27UTiSoUsC19TbHa/TOaKi7TbpLSj9sj05eYP9eVy3iRgasaUJZ9AdAxZNURuNGIiFXcfPT0VX+rzmRv37JUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557424; c=relaxed/simple;
	bh=gA+QStwRj/LVatDuKESJdCv++0LFZ88d5P6I6zHRsOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSx6lbKN0p88ZdgjMgz4iOxc7KwtbgHiasSVq8ZrJADCNWch+ztTdcHZfTAhyPGtpKTbkBODSpB427LHbLjFPmr93XrKW0urbsWHxWw6uEV8VhERO7XaozWkf10nFypPsj7/FODzr5r8OAKF/2YMg5XNmKQhIrS8D1Ikd1a9GyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OT/S8A62; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e0bfd14aff7so4857940276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723557421; x=1724162221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLSLN/JNWAOSXtxRH8miLcEkaLp2UzeNqUb5zeUUf0g=;
        b=OT/S8A62y9zYsr69otgjbk24Ht0LA8z/uk936ABsW5HIJGf11g8HYOsKjDzrhVjlU2
         DbWhIJY54Mxt6D0OlbPHLXz2AEmrGHqRHj0Z30znT7onYTyc2Dq/u1qB4XOq72/a29bf
         Y8gpqNbxILEragu2S0mHpNcu22G2W9jyqDJphO9UQDc5P/puXeWafhhLE0NV7PysPpwS
         8EVFo6k9dnA0Lss+4sJ4OYwFliWT54VxY0lDKhnedXOe/JMt0cxu8rpvK0JQsIx43Ar6
         vhfQYX8skbcaK+LPVmBvJB9ztil0jVeO5yx7Kcusqx2ScOyp7jzxxtZAPuCW/PJMaaXx
         Y/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557421; x=1724162221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLSLN/JNWAOSXtxRH8miLcEkaLp2UzeNqUb5zeUUf0g=;
        b=oSGddw0ScjSQ1NBDe8WF8WpsYjuBT603oEk7gOqlT7FLL+Ftd9Qm/FXiA1I9btA9nd
         bIVMZCB4vF2tijBYT0BRUSW22FUakz1q+ChNPuDkXvyK3MJk++qM+jULa08Kx5kAp4Qv
         uUp1HCRH15kJRHH6WUK1wY4/mYJxvLya0UvWfhWE1g6sqEsXtK0mzis3VuKQpbNH8/v1
         pYk/LkVzfZFGL3iWJTpIOZl7C11UCogYDRDLtBuP4P1fcCmvcJUu3ar9qrSj4tFtyqYr
         yFlraRMytwvtN/vjjg09uoARuBLBSFiMGG0niDhDN1uehIlqD+SE8Tgwv6Xc+NqY10Hs
         whng==
X-Forwarded-Encrypted: i=1; AJvYcCUbWV3s6PA9PuuI4qeqW/ZnepuGvXlcwWld4sK4iIFeqaYfXfojmoNmwjZcQ9KR9TSgxkmeefFK3kDW8yQeplbIlffBJLtnjOW2V8kv
X-Gm-Message-State: AOJu0YzsnzXm9gZXOtMf2LI22P3bHM3ENWzPl3DDYDno/L6YATwl4xak
	7t3CDJWY94tobrp5Ht22qo9xmlwniCZC48OOp/J8zx+QdvODpKlGVR6bXaepPnAPxjMjiWfVjRW
	JqpUNtkgafDdoqLRivLzhYNGxN7GYH0v3yZ+kCA==
X-Google-Smtp-Source: AGHT+IGSRXHkL7PvnTNEwvOCFZfzIGVjr9cYpYKwW+c0HMHoaWdUmQ9IzZF7tEGG+VM8etItOggTy4TAzrcmiyP930o=
X-Received: by 2002:a05:6902:2805:b0:e0b:f45f:65dd with SMTP id
 3f1490d57ef6-e113d2e303emr3310212276.57.1723557421255; Tue, 13 Aug 2024
 06:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com> <20240619120920.2703605-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240619120920.2703605-4-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 15:56:24 +0200
Message-ID: <CAPDyKFq1EX1Spedhkek=50EdwmHY5erNTmvegVGbxfLzTqYjEA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] watchdog: rzg2l_wdt: Power on the PM domain in rzg2l_wdt_restart()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, rafael@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, geert+renesas@glider.be, 
	linux-renesas-soc@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 14:09, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rzg2l_wdt_restart() is called in atomic context. Calling
> pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
> APIs is not an option as it may lead to issues as described in commit
> e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
> that removed the pm_runtime_get_sync() and enabled directly the clocks.
>
> Starting with RZ/G3S the watchdog could be part of its own
> software-controlled power domain. In case the watchdog is not used the
> power domain is off and accessing watchdog registers leads to aborts.
>
> To solve this, the patch powers on the power domain using
> dev_pm_genpd_resume_restart_dev() API after enabling its clock. This is
> not sleeping or taking any other locks as the watchdog power domain is not
> registered with GENPD_FLAG_IRQ_SAFE flags.

Would it be a problem to register the corresponding genpd using the
GENPD_FLAG_IRQ_SAFE?

Assuming it wouldn't, it looks like we should be able to make the
watchdog device irq-safe too, by calling pm_runtime_irq_safe() during
->probe().

In that case it should be okay to call pm_runtime_get_sync() in atomic
context, right?

Kind regards
Uffe

>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
> index 6e3d7512f38c..bbdbbaa7b82b 100644
> --- a/drivers/watchdog/rzg2l_wdt.c
> +++ b/drivers/watchdog/rzg2l_wdt.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  #include <linux/units.h>
> @@ -169,6 +170,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
>         clk_enable(priv->pclk);
>         clk_enable(priv->osc_clk);
>
> +       /*
> +        * The device may be part of a power domain that is currently
> +        * powered off. We need to power it on before accessing registers.
> +        * We don't undo the dev_pm_genpd_resume_restart_dev() as the device
> +        * need to be on for the reboot to happen. Also, as we are in atomic
> +        * context here, there is no need to increment PM runtime usage counter
> +        * (to make sure pm_runtime_active() doesn't return wrong code).
> +        */
> +       if (!pm_runtime_active(wdev->parent))
> +               dev_pm_genpd_resume_restart_dev(wdev->parent);
> +
>         if (priv->devtype == WDT_RZG2L) {
>                 ret = reset_control_deassert(priv->rstc);
>                 if (ret)
> --
> 2.39.2
>

