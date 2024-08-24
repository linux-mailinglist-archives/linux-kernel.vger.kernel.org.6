Return-Path: <linux-kernel+bounces-300073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB895DE73
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA75B1F22402
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C153017A599;
	Sat, 24 Aug 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3LSEa7a"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70892176AC7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510205; cv=none; b=D5hI0egEjo7eMMngeLGWbdMXwUUVdTdlTLDQMF76S7HpMAYDVZ+RKbA61H3O1P0kqJ2TS/e3QlAWVy/glkVo3Z32WUupYvqsEN5J6AzTN7tsF6Dp1+EiE+ORaWSwUGLyR6Ia9ZjS0uVDeeK2hD/1XqKbbqkmHvBEla5Anvw4N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510205; c=relaxed/simple;
	bh=wB3Syap6zk3TZ71TqZm0GBbGr/QS8s2QORv+2dfLgZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7lRgeD00iqXVyBhQ24kCIBTUrZvtzQYcXApMTfcdVFK17LWOriLsB1QXz9/S+OcWbm9xm8HfiXPJhBXV9cdkXUJtdksgfWOVsEtoKBUQanJ/PObQQTs9k6fIA7xem34yKZg9rUkQT7X95VXo9qCG+76gptHGD8IDhqXTTvJEWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3LSEa7a; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533496017f8so3914746e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724510201; x=1725115001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wB3Syap6zk3TZ71TqZm0GBbGr/QS8s2QORv+2dfLgZg=;
        b=o3LSEa7aJn8Xn9lnJdteYtpsRufoxkVXXx6A+cUtLx37RnZezHBMnLoPiB/6SCGpld
         VhohM7BT//CDj8+dKXPN9bb8R7PEmcacwvX5MX1hlAqxzpL5LmdTcFQWJDGNknqLBHkT
         elhH+0ZTFjDbVbQ3E24KtE7oH5d7x9ILHFGIQRGhFg6s/BIBeoX9djPQRQ/RLQFvjXiN
         Fq1d4YGVHiF6zJeuZfBLNnJTG1ETBwL+wYf8c/GQOWHLA9FaBo7gTo7/y8KLTLPiQN05
         zn6d+7mJQUJzBCS4nSsjMEmymYEFUK4MP/e+S6vjbvj5S9m8xhIculLSTD6dJNcVV07H
         Xq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510201; x=1725115001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wB3Syap6zk3TZ71TqZm0GBbGr/QS8s2QORv+2dfLgZg=;
        b=d4Kyisr1Dz2MSetx/KqcP/uKsULvtVpAmgSLdVhuHRpqM8fYD/I93hZQBtr7k28C4U
         V5N1t2dgIRWN+H3+ARn2kgc88a6CtChOj0cefIluSZ1l1KZ/3BHz/9RbPgkcyRZ4I4cR
         E/QrzQntk9CtOZdurrewAd23mUsS0YvbqkL/uainsqt232XeyxlNn4DtgSEIKysrVkir
         WD+tOx0gLikIN9Uo+q4yv2RPYv4jI74BXHx5MBlhiY60OjepWFbWAgUbraE77RtcAvqU
         /o1b3/aFduBo6fIG7RbWX8KXL91WuPNGEJRbs0Et8g5CVeY46NzxQEYD1gbIpRP8vt+/
         zHJw==
X-Forwarded-Encrypted: i=1; AJvYcCVMApE+HwQke17Joh/oI9SPye5TBUfhtwWKfHkk31tWhI14XTJqpZbekNRsM4Lk3WH7jGXsfK4+ttO2tgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhcu5X2TrKfCYVqsaT/lddhI9CNA+Is9lX1gXYYik8hi1409mA
	jHtVZvUPS/Vp6X7vIN+poEDg+z+r31tskmcbwbym0XPSAkGUojtMTiA6oFnPfuTMbzcf0mgX6F4
	SZhXY3DD9XWau9nX7+kw7SUa40nwRreX7rcU7RA==
X-Google-Smtp-Source: AGHT+IHKC5osdxzdTomyph+tELe/N/OZcQXCHUfYqc4VqddsiDL04Fdnz7veo/0EKo4mmoML52vAp7ejuIlBX9uRP+k=
X-Received: by 2002:a05:6512:3052:b0:52e:9b2f:c313 with SMTP id
 2adb3069b0e04-53438831efbmr3616798e87.22.1724510200912; Sat, 24 Aug 2024
 07:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819151705.37258-1-brgl@bgdev.pl>
In-Reply-To: <20240819151705.37258-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 24 Aug 2024 16:36:30 +0200
Message-ID: <CACRpkdZXoVavrAUHuny-kzJJ23djqiKQwR2qXb=A7-NcLzfrZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: davinci: drop platform data support
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 5:17=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> There are no more any board files that use the platform data for
> gpio-davinci. We can remove the header defining it and port the code to
> no longer store any context in pdata.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

