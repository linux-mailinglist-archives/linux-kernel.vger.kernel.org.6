Return-Path: <linux-kernel+bounces-541633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE2A4BF7A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323823B84EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E7920C02E;
	Mon,  3 Mar 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8hsg1Ui"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23A20C016
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002632; cv=none; b=rJMPmNQr5jxnHBvpiowYGcuv8PkLfmP4CC0vgZuKLP50rBkTYyYpyeBdIYNphR/1pdvGqSCwYXZG8CU9f2AxbiVyny+gYjDK4ANiagZkVFXYt3+ZLxmi9+JDLkDlmZ62iAaHcfmMPAJfUblT8oMwJlG6h4BIQDIFy3iTRryxo8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002632; c=relaxed/simple;
	bh=iYUckyVAVeI7XDNNji2uBn6ccd7npEcaiKeFcolCkl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZobWUkm3uzySMl14US8Mbf+XTHbAfcGGvjbqUrZi8KKlLXnWDTJncSEY5bdgJAFa1ZhDKYkcgxwBsl4sz1eZF4xMJZRMyUoDYXnxISKcZMP5Bbl9nDeYRWW9iFApUTaiNcWXTvMqAcjAvFwet5egUYEB7nDvQl6serTx+KWQjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8hsg1Ui; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd3b6a6a24so28438537b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 03:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741002629; x=1741607429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uk4RC6gYyKlg81cJh6W+VhPYO5gDI/YlGZXXv16k7MQ=;
        b=F8hsg1UiwKECfQsGtOKKbFDKGEqu6ZIXQDa1QTruaoye6q78NWZQHYBzvcQ4B2iuWI
         1o8gez1SEP7H37/UixC4ZDON6HsTim+Aj6WvUFxmrlymX5Xs3+XB35XCtlI/X2Y5kTlc
         wj8bAMqDg9mXtAdq/e0QRkB1szc12HpCUDsHTxrOS1jMWptro81bmUyTJcHV1HFxkJCL
         gM/ouAshpbk3r/zDp6J2WVawtLvsmZGj6VPQBaVCyJsLH9ihO9XY5qGjB4Y5hyF5iCcj
         FVclzS6mR9jXufNj1uasHP+WQI3T/Zqn/THUJgqYDBRo7iuuN2p4bKV0ELXPCc8AzVHR
         iPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002629; x=1741607429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uk4RC6gYyKlg81cJh6W+VhPYO5gDI/YlGZXXv16k7MQ=;
        b=tYl9WLD1NpqHyWJGcEp6DJPpW8JHZRmdFgHnFA02qOojE2Gt7pxKjWRzLH0uE8uys/
         kJLiCsEeNhLO2MlfGJA6turfziNQbv0fO7aBMF5c4p247YpwX/XJk1oZluMWYKWeOrWa
         yv4uzwLY/fVsHoh7n1rx2k5bvW+guiUdJ7pnpAQip25A3jQAheCEeYxrKAs8t52JkVHV
         42dNhN6hoarckTif8cyEFcQiJirgZahI0DAV7snOnWXc0zPCoDxRoKXyYaVCuwiJK0dN
         4FzKNGYLd7HkRPCPXS1TmTTfbbY/D9CZEzdS+R5InMTRF8K2qQRPYKw7xehSLA/e2Hny
         xbng==
X-Forwarded-Encrypted: i=1; AJvYcCVQrHsXtoJlCypNl4clQVV53bR0mfa+jY7yGhP4rU47UgV6lxedQuAr9aCb46NMNKcQOzYuqSYfWUMIhN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2yDMuZ67eF4faFRMhYwyFf/x3WRgYvEJqUjgEjEjzckJF1AGr
	seyX1ZmJKyM9T7ZUkamrNsOBH5qP+t+UfOvgxbWCpY0ErdiKCVA3xSyIVYvi74otot1k56fxy00
	OAt1izITSeHncDURvGB1VJO+TqELy8fDqprRS1w==
X-Gm-Gg: ASbGnctHG8befiAhfHdv+OOo73EZ8weoDA5rg7MajEe6ud8wO7Y0Ym88CYzP4S+Yf3G
	1EEnP9KoJepL5qMeXCiME2sQkhQxhBk+zRfs2YGwol4jbvsJz+uSKNb/SINh8r0lFBmzGhuzubW
	HIVCeLu0aA+trbWKHxJW8YohaZHLE=
X-Google-Smtp-Source: AGHT+IHbEZTHl8hhFga4vQY/ULqM1THSQSqqYAdq51p7CVUXvrld+wWN+muocGAUEDlP0o1E2tcH3vx/K7c1uLHnFyY=
X-Received: by 2002:a05:690c:4b8c:b0:6fd:47b7:9730 with SMTP id
 00721157ae682-6fd49fb60a6mr161831797b3.12.1741002628443; Mon, 03 Mar 2025
 03:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3353728.44csPzL39Z@rjwysocki.net>
In-Reply-To: <3353728.44csPzL39Z@rjwysocki.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Mar 2025 12:49:52 +0100
X-Gm-Features: AQ5f1JrH4q1zOIaTrqYzbdkfjiU66g40RtbSmo7LK-gb4j9oNzq1abNpZhBdAkc
Message-ID: <CAPDyKFoQvKFmwpzPtHGzPKzPv7KLo_7-2oYb2=BXEZAm4xpVbQ@mail.gmail.com>
Subject: Re: [PATCH v2] PM: sleep: Adjust check before setting power.must_resume
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 11:53, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The check before setting power.must_resume in device_suspend_noirq()
> does not take power.child_count into account, but it should do that, so
> use pm_runtime_need_not_resume() in it for this purpose and adjust the
> comment next to it accordingly.
>
> Fixes: 107d47b2b95e ("PM: sleep: core: Simplify the SMART_SUSPEND flag handling")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> The previous version of this patch is here:
>
> https://lore.kernel.org/linux-pm/3548152.QJadu78ljV@rjwysocki.net/
>
> v1 -> v2:
>    * Changelog rewrite.
>    * Added the Fixes: tag.
>    * Refined the comment adjustment.
>
> ---
>  drivers/base/power/main.c    |   13 ++++++-------
>  drivers/base/power/runtime.c |    2 +-
>  include/linux/pm_runtime.h   |    2 ++
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1382,14 +1382,13 @@
>         dev->power.is_noirq_suspended = true;
>
>         /*
> -        * Skipping the resume of devices that were in use right before the
> -        * system suspend (as indicated by their PM-runtime usage counters)
> -        * would be suboptimal.  Also resume them if doing that is not allowed
> -        * to be skipped.
> +        * Devices must be resumed unless they are explicitly allowed to be left
> +        * in suspend, but even in that case skipping the resume of devices that
> +        * were in use right before the system suspend (as indicated by their
> +        * runtime PM usage counters and child counters) would be suboptimal.
>          */
> -       if (atomic_read(&dev->power.usage_count) > 1 ||
> -           !(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
> -             dev->power.may_skip_resume))
> +       if (!(dev_pm_test_driver_flags(dev, DPM_FLAG_MAY_SKIP_RESUME) &&
> +             dev->power.may_skip_resume) || !pm_runtime_need_not_resume(dev))
>                 dev->power.must_resume = true;
>
>         if (dev->power.must_resume)
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1897,7 +1897,7 @@
>         pm_request_idle(link->supplier);
>  }
>
> -static bool pm_runtime_need_not_resume(struct device *dev)
> +bool pm_runtime_need_not_resume(struct device *dev)
>  {
>         return atomic_read(&dev->power.usage_count) <= 1 &&
>                 (atomic_read(&dev->power.child_count) == 0 ||
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -66,6 +66,7 @@
>
>  extern int pm_generic_runtime_suspend(struct device *dev);
>  extern int pm_generic_runtime_resume(struct device *dev);
> +extern bool pm_runtime_need_not_resume(struct device *dev);
>  extern int pm_runtime_force_suspend(struct device *dev);
>  extern int pm_runtime_force_resume(struct device *dev);
>
> @@ -254,6 +255,7 @@
>
>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
>  static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
> +static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
>  static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
>  static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
>
>
>
>

