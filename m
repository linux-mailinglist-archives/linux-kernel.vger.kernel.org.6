Return-Path: <linux-kernel+bounces-543877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB310A4DB02
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98FB18865CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1127200106;
	Tue,  4 Mar 2025 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0YTgtxRc"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979F1FFC76
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084660; cv=none; b=NO/43e9OW4T0dTr4/6Azum9gP8M3ETYLyevk1oPFpI9/dlq9q6ACezMo0L0todF/nJgIEuJo9TczBk7l2zOQdPbqQ6e5Hs6W3aLh/BZqvSu9YT0QPP1p1xxt40TVz7pTrR+mIafDHLCyFrdBMYKOk27LYtHAzhdJJd0xjR85yWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084660; c=relaxed/simple;
	bh=W7wu7x2CGHp+hodRLerhrOyuQsqw+FEk+o1KUxZ12pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rXtOZrlvxDZt8omHnjsX6fZ8Fa1JqMJKQeiWphWQWhNfGLww8asPRxgsGcKtGa5T4LiR4BMqZe87LA9WQAqy4GlxUPnzOq/3dfDIgQE3z5RkIKyC+lVh0+UoLAt2eCQkhdsPhPmPIvsQ6lpOskEJl37+7NQJYjFDijtehilIwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0YTgtxRc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5497590ffbbso934928e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741084656; x=1741689456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7wu7x2CGHp+hodRLerhrOyuQsqw+FEk+o1KUxZ12pk=;
        b=0YTgtxRc1G9z7rDwnABxcg/ByXXadjxAutXZ1ItVvJh0QPNu1I0EhtOvaOHp6SHWoe
         sKyjlFNH7v0qDv7HvwHME/z2mQA0EEaiL/Mb7me4XwOz+CWtyGjmcyJsk+2oH4eudi0U
         752W1pzlKTyEkRjC22eSIJI2FU5zQUzJDctJ8NjF+3eZR78QVeJT/HmkztbO62FqkENb
         4TvzAcwoWgTZjcOiwonK45m58k2tptJ5122aJfYzY2REZuizWBn0L1XDqHi7I2kGgtJW
         +RiHSigepggpyIqULqYZvochfIF9G5yeZxxf/zGH1ZgjdOF+N9bWxAzMuFle6vhHxDl+
         d4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741084656; x=1741689456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7wu7x2CGHp+hodRLerhrOyuQsqw+FEk+o1KUxZ12pk=;
        b=uukMDFTfpOsbdzuXTrbQ+XX/NAh6tTAK+E3EMHls+Is27ALup6Sgo2GVWEFXr9Un2a
         Jpf1+x8E18aVTRZgoIU98qseJ+MlBctvDGIn8VGC2rkaEhJ3rEMFhP5Fe3OoZ8UIixWI
         M5sC97cAfPjrh8ws5ENmO8ZO9c6GV1rUWb0neB/CNW4duw/VXT/cydEpzKmYcvXdkg+Q
         /o284Mw+a4ljS+fs37NqQzvcTacYRjyTFQ4s6B/o6ljxXMEkwgnXcTaphEyVqC3nDcUY
         Omtjqo2xkgR805orbV5AN5+v4XjDmFZGyqw+PQ4YUZN86CNlx6nQVZCYzQZgzHakeotL
         qPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUub4adgiwoSuiTO2ul70f9HDtWVjaQsb03W/Skq85SdckIhF18zU8vK+zA+sSH44gYcs+8pILyZDlZc6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVsE7J2fo4YrR+JFY2PsObxBnw6PEkakHuz0vByHSlzh7sEta5
	DIzCB1h6HKp6ullkG+2RBRSR3A4ZXrnvciXFkIshuuE3x92hK/Kuoo2HstZfslekgu7r0vi1WcS
	O7V/CJBe8czHHgISUdagB4gSNDPU2HisKPm/EhQ==
X-Gm-Gg: ASbGnctYJ21Sq1vDzDLo1c37UseWCplyOJjTaFuy9CaCU0HRNuqOdrxICkXfybAR3UH
	MdBgdSOmqPFA9GFxSS4+2BIsto9aIOdSZySiOl79roeCEs4f7ZJk/be2+Y8ADjvx4Sq3h7ZseUM
	Kn1lcmPtlcX9DLYshVSg9WIi1YYctJUld7L5lwfW/VyGMIJSI7Pt1SC8yJkw==
X-Google-Smtp-Source: AGHT+IFB+Oj8/Xe4YEFmV/Rb3Rt3KPraZIDAVAusl2gbbTUJaqBBb2xF6ULfEj5cbkgmnDxxA+ahMM664a5woA/zI1I=
X-Received: by 2002:ac2:4a74:0:b0:549:4e80:6dc0 with SMTP id
 2adb3069b0e04-5494e806dc6mr5633715e87.0.1741084656455; Tue, 04 Mar 2025
 02:37:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org> <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
In-Reply-To: <20250228-max77759-mfd-v3-5-0c3627d42526@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Mar 2025 11:37:24 +0100
X-Gm-Features: AQ5f1JpxU_9Y_clBmQu6eNXqzblGFz3KZ1pj5Yu3Z5R1OCnwlBjw0Sc-D8_i8O4
Message-ID: <CAMRc=MeYXFonF8wcU_5RzSYpTUXEhnY+wpsFKJQ6-EJ1h=K3Wg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] gpio: max77759: add Maxim MAX77759 gpio driver
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

On Fri, Feb 28, 2025 at 3:25=E2=80=AFPM Andr=C3=A9 Draszik <andre.draszik@l=
inaro.org> wrote:
>
> The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
> includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
> Port Controller (TCPC), NVMEM, and a GPIO expander.
>
> This driver supports the GPIO functions using the platform device
> registered by the core MFD driver.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

