Return-Path: <linux-kernel+bounces-569975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B6A6AA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9961746124A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358051E9B0F;
	Thu, 20 Mar 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Fe3JAR48"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028D14B08A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486081; cv=none; b=qEjuKOby7JE5bz/V1aD9vtfKp9CIUaXpZOL5SllnU8llYMkqL4x8omwlrSuSTvH1ot/IsKr8ReRgDnsO+iAslbxdSHgenC2fDLKMxvbbBUPXss6mb88oDq1K32aovfidedhKpK57MwwXCQLvO0HQzzJBTcKfQIXds6ymzTJ5g4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486081; c=relaxed/simple;
	bh=+G8xeVswd64dlgvV6el9zAepddTC6p9H9vdVZhXc1Wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thvLdVJtufuXDUK7dgBSeCa0Q4NLfEkszER/e84dnPnPS3cW39FGyroCP7Asshr6KxYVFG0ZeM+nbr40teOkfojJUOzVD562jUcMa0YD+/KkSpiJnaQOrHbBNQYp2VXmFujNaA+AJJRduc79Jx27SqUGNsOpQ3MPGggx733YQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Fe3JAR48; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54957f0c657so1051333e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742486078; x=1743090878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMDvJ9Jznrc1kD33TmeQ8/ARj3JPxSTd2xs66KZP2qE=;
        b=Fe3JAR48Qd2aoKWMa5SJJZgS6LVHstFP8hhJSZ23uI/urZYq/eCoWt7y2WL79Tu053
         xnO9S+J+7gKzbKT1Zo+MaeOAlqOE+pxHP/3/hhIu70M2fpRWPDUN5UqFN4TOsJXhF7iG
         MsrrGHKgMI++Zx3eJ7cxo2oMICQADAQZ3DJzovpPTcjcSfrUsrXuLjTKmOAYwn7PPOJZ
         s3bS6BYejGh7pdWjVK4A+Rb/S8NtB7wlUz+IYe6A4alm96e3qO1wder4Xe43904L/Q/G
         txO7HbufL7Sc0jxmGKjYSrb25Oha/4ibAbLh7fcQhrt/6yx9jfbq9Sec/UmnfQd+BogC
         Hivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742486078; x=1743090878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMDvJ9Jznrc1kD33TmeQ8/ARj3JPxSTd2xs66KZP2qE=;
        b=TiIolUIVYDr7ErrmMrmFq9pchnnbHYnlf7lbxC6vYgoyG7LMNIumb2KdgtkmtNqgZn
         +rWNlsa7SP3V8rXM5xQF2+PTxxoMwhAdyfNBe7Wr+HqIR8JXMcOM0al8Vz5i3MjNAAS4
         k0ZR8TdXSk6+UqXE6RYi7OcuUS09HsUaD9KtvSvddZGNyhEI/ZVA4gX4FkVzXw3572kL
         CbbBfopwf+c3+FVr3EbCCmnqWBWHi4nVrgmc9ZOhiZCPTG3+8Z/ih8P13J2Wnu4gJWWb
         mjASvz9Xmo7zUjaQHVAOaVzRWN1SHV0LF8wj8pdxdQvkaL4Y2nUYNqy+yp6X0swGp72/
         mavg==
X-Forwarded-Encrypted: i=1; AJvYcCUl3MBG2s8rNcCVT6Ov0RPtxVuE15S4Ik2/dmKLTYKtIDpf+tMUhmnYQSoSaFJeGoPy4vnKdyz6DEH9HfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCo0bFFfQGV4VeIp3WOXSsCsjnpvWFnsNIFW03+D6C5AvyD42
	17tFKvbr5LWAEZWzS2h4IHlC33K1pUoDP2ZyFEgaIswGf7AEemUolwm5Al2mY4EAt2TYwmGz23E
	3I5Fcz4V9raFDGd1JHf7CcODO6QIApKQfFwpTvA==
X-Gm-Gg: ASbGncsIhcaKWdMBhGi7DNGgQxVgW6FRsy4buJxN2Kwhr/wI30BOV5wR89mFxTVjX8C
	8XHkB3A6HB+1/A1SEIRiG357cnSrjWAUwVHoFeBGSa9E9SVB1qdGIGbUxAvvM93+708bQwj0c06
	owYLlhYBpbKMyrGAxG5c1cNXk4oa6GKw7wI4zeNPIsNvxFmBYnjVits06OwaLIwmTmf8mv
X-Google-Smtp-Source: AGHT+IF+Dw4jJDHhYac2m4xlt6eGAUVFlhWY8ywgAYBxOQs5ZxYS31GdgGmCoHjcswuXQiFt2O3iic8dVwm3QijXkU0=
X-Received: by 2002:a05:6512:3d11:b0:549:965f:5960 with SMTP id
 2adb3069b0e04-54acfadd027mr1698919e87.16.1742486077679; Thu, 20 Mar 2025
 08:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315164123.1855142-1-koichiro.den@canonical.com> <20250315164123.1855142-5-koichiro.den@canonical.com>
In-Reply-To: <20250315164123.1855142-5-koichiro.den@canonical.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Mar 2025 16:54:26 +0100
X-Gm-Features: AQ5f1Jp--exJBMeZ38IUr8lUaIruSRiPIjhRXCBMKUmIrhqWOczKBQE9iCeCJ3k
Message-ID: <CAMRc=MdOSsakJm4H5=cqVzdKDrrMFO2t-wKVWRCU83saozepxQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] gpio: aggregator: introduce basic configfs interface
To: Koichiro Den <koichiro.den@canonical.com>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 5:41=E2=80=AFPM Koichiro Den <koichiro.den@canonica=
l.com> wrote:
>
> The existing sysfs 'new_device' interface has several limitations:
> * No way to determine when GPIO aggregator creation is complete.
> * No way to retrieve errors when creating a GPIO aggregator.
> * No way to trace a GPIO line of an aggregator back to its
>   corresponding physical device.
> * The 'new_device' echo does not indicate which virtual gpiochip<N>
>   was created.
> * No way to assign names to GPIO lines exported through an aggregator.
>
> Introduce the new configfs interface for gpio-aggregator to address
> these limitations. It provides a more streamlined, modern, and
> extensible configuration method. For backward compatibility, the
> 'new_device' interface and its behavior is retained for now.
>
> This commit implements basic functionalities:
>
>   /config/gpio-aggregator/<name-of-your-choice>/
>   /config/gpio-aggregator/<name-of-your-choice>/live
>   /config/gpio-aggregator/<name-of-your-choice>/dev_name
>   /config/gpio-aggregator/<name-of-your-choice>/<lineY>/
>   /config/gpio-aggregator/<name-of-your-choice>/<lineY>/key
>   /config/gpio-aggregator/<name-of-your-choice>/<lineY>/offset
>   /config/gpio-aggregator/<name-of-your-choice>/<lineY>/name
>
> Basic setup flow is:
> 1. Create a directory for a GPIO aggregator.
> 2. Create subdirectories for each line you want to instantiate.
> 3. In each line directory, configure the key and offset.
>    The key/offset semantics are as follows:
>    * If offset is >=3D 0:
>      - key specifies the name of the chip this GPIO belongs to
>      - offset specifies the line offset within that chip.
>    * If offset is <0:
>      - key needs to specify the GPIO line name.
> 4. Return to the aggregator's root directory and write '1' to the live
>    attribute.
>
> For example, the command in the existing kernel doc:
>
>   echo 'e6052000.gpio 19 e6050000.gpio 20-21' > new_device
>
> is equivalent to:
>
>   mkdir /sys/kernel/config/gpio-aggregator/<custom-name>
>   # Change <custom-name> to name of your choice (e.g. "aggr0")
>   cd /sys/kernel/config/gpio-aggregator/<custom-name>
>   mkdir line0 line1 line2  # Only "line<Y>" naming allowed.
>   echo e6052000.gpio > line0/key
>   echo 19            > line0/offset
>   echo e6050000.gpio > line1/key
>   echo 20            > line1/offset
>   echo e6050000.gpio > line2/key
>   echo 21            > line2/offset
>   echo 1             > live
>
> The corresponding gpio_device id can be identified as follows:
>
>   cd /sys/kernel/config/gpio-aggregator/<custom-name>
>   ls -d /sys/devices/platform/`cat dev_name`/gpiochip*
>
> Also, via configfs, custom GPIO line name can be set like this:
>
>   cd /sys/kernel/config/gpio-aggregator/<custom-name>
>   echo "abc"         > line1/name
>
> Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> ---
>
> @@ -90,6 +124,70 @@ static int aggr_add_gpio(struct gpio_aggregator *aggr=
, const char *key,
>         return 0;
>  }
>
> +static bool aggr_is_active(struct gpio_aggregator *aggr)

Series-wide: I would prefer a different prefix: why not
gpio_aggregator or at least gpio_aggr?

Other than that, looks good to me!

Bartosz

