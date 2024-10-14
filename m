Return-Path: <linux-kernel+bounces-363522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718399C373
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163951F22B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CAE153BF8;
	Mon, 14 Oct 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foWIHP+e"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E425913D537
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894742; cv=none; b=qnoXqyRdrpIJQOiwh+BRBmV/DP0qrrbYdFdtetj0jQWXwIm63WEIwkHyEu975xVuksVVqeealyB6DTW5zWUmkkSmQNcEF7GiYaKwDwHO6ueVtHzmSz4sJUKXPFkK5ss9nGKe9Bd0WrCi/3CivUbgkT727s06QSuPH9tltTQF7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894742; c=relaxed/simple;
	bh=cxIKPl7GKVQn98O/mrnEhVXAkE0uTRhk4Nnr0kHKm+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTiBHyfhICkcewQwL95/kGse7blqPXy4S3mJfAQOACalLA8GzSrpuWVc0l/JCaaFjg8HFILp+XDSrKVAhP9PFAN1y8Hq4U7o99s4IoelRZiav6GsHDqZKKatSGhj4CPrvWNKi++5o/npV23gLZtPJCGcEhw7GgvrWU4y8ErZTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=foWIHP+e; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e8586b53so1216765e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728894738; x=1729499538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGlKyhbFWxEFs+EN5AdJI/noF1CduIAszsysoTgRVic=;
        b=foWIHP+e/j4WPmc12XR+s0eqpaPeJAIew+yXe0dJrOL6Md0pWILKz1Fz6HqPmrhgHx
         41o0AplCjHehGfpTn0Uru2Nc4JxEvszJHZ223ylk+3VEhl0Y4xMmejQVa8LF0Fw6QYOZ
         rdNyE9LnsJcrN5ihhk8b+qIfJvkaxopFlrCVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894738; x=1729499538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGlKyhbFWxEFs+EN5AdJI/noF1CduIAszsysoTgRVic=;
        b=V4j7+3yj7VCcqp/w7yUF8qY/0d8Go1ROm/lzgHrVNrC/C7lCw9BhhvjnUHR0BWJ9du
         +3/ESbTxHV8lH544e7HCdW0pFCpyq3FzwCFUiVNSsfIp6XAdb7PEOZ2/iW3yTetvhG91
         h5uMUy0ToyeL2HFC+bMAJi16uwDA3byDir5X15lKpKx5zGwumAj7fwgj1X4VTeRswVy4
         tvPeQG9SojrTwmj0xNkIm0iatmfNRoghqmuNyvhZlFwc1lcTy0V8FsnRYnrmOWVAUL6l
         Ea5jOQxmKXRsTf3mikYpd+uj9U3ZpeqJXC7v/D//7S42y+OMNVyx8b8oOIbmquTgOxYF
         xeJA==
X-Forwarded-Encrypted: i=1; AJvYcCU1AX8sMKyGezscqyU7iBmVLuVAjNtu5HtHQejnFVKIcFnmbjxip+QRb6pfzAZGZk1IRLBlR8MJP5e2874=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhX8kk8k0aWK58QgIG4xq3OnDXCcOYHcIkWS+3hEbUWOcu2Tsn
	sasergrFQGgezSq7OPEwR/GM1O17vFZl6/75G+WtKle2fbBEkOup02fZ31VlQLg7wTIk+KBcuRL
	YBENvYWpL/kNhBcQ+lYSsdHhH9t13zw++KcBP
X-Google-Smtp-Source: AGHT+IF8yCwYVSblYBBqvyU6aaOkHAFhmYHymC9/n8uskosKRPRl9o+TsOQe+6xYXWvIN2tZjy8ERc+Cu1NL6JnlR2Y=
X-Received: by 2002:a05:6512:131d:b0:539:a2e0:4e94 with SMTP id
 2adb3069b0e04-539d6ef4d72mr2569999e87.30.1728894738003; Mon, 14 Oct 2024
 01:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
In-Reply-To: <20241010-b4-cleanup-h-of-node-put-thermal-v4-0-bfbe29ad81f4@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 14 Oct 2024 16:32:06 +0800
Message-ID: <CAGXv+5FgLQMG=tA6d_gT71j5ZxWPa56rW1UmfUgKot4uCj56+g@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] thermal: scope/cleanup.h improvements
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:06=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Changes in v4:
> - Patch 2: rewrite, significant change: kzalloc() also with
>   scoped-handling so the entire error handling could be removed.
>   Due to above, drop review-tags (Chen-Yu, Jonathan).
> - Add Rb tags for other patches.
> - Link to v3: https://lore.kernel.org/r/20241008-b4-cleanup-h-of-node-put=
-thermal-v3-0-825122398f71@linaro.org
>
> Changes in v3:
> - Rebase, because there was bigger rework in thermal code.
>   This made two patches obsolete, but brought new one:
>   1/6: thermal: of: Simplify thermal_of_should_bind with scoped for each =
OF child
> - Link to v2: https://lore.kernel.org/r/20240816-b4-cleanup-h-of-node-put=
-thermal-v2-0-cee9fc490478@linaro.org
>
> Changes in v2:
> - Drop left-over of_node_put in regular exit path (Chen-Yu)
> - Link to v1: https://lore.kernel.org/r/20240814-b4-cleanup-h-of-node-put=
-thermal-v1-0-7a1381e1627e@linaro.org
>
> Few code simplifications with scope/cleanup.h.
>
> Best regards,
> Krzysztof
>
> ---
> Krzysztof Kozlowski (6):
>       thermal: of: Simplify thermal_of_should_bind with scoped for each O=
F child

I couldn't find this in my inbox. But since I already reviewed all the othe=
r
patches, and I looked at this one on lore, consider the whole series is now

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

>       thermal: of: Use scoped memory and OF handling to simplify thermal_=
of_trips_init()
>       thermal: of: Use scoped device node handling to simplify of_thermal=
_zone_find()
>       thermal: qcom-spmi-adc-tm5: Simplify with scoped for each OF child =
loop
>       thermal: tegra: Simplify with scoped for each OF child loop
>       thermal: sun8i: Use scoped device node handling to simplify error p=
aths
>
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c |  7 ++---
>  drivers/thermal/sun8i_thermal.c          | 11 +++----
>  drivers/thermal/tegra/soctherm.c         |  5 ++-
>  drivers/thermal/thermal_of.c             | 54 ++++++++++----------------=
------
>  4 files changed, 25 insertions(+), 52 deletions(-)
> ---
> base-commit: 33ce24234fca4c083e6685a18b460a18ebb5d5c1
> change-id: 20240814-b4-cleanup-h-of-node-put-thermal-2268440cc6f7
>
> Best regards,
> --
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

