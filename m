Return-Path: <linux-kernel+bounces-538010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E68A49380
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FFCB18876EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107B2512C6;
	Fri, 28 Feb 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJiyz0oU"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C22500DE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731419; cv=none; b=jcJTRFAQwv2zcR6riFIKGedtfSOUVU+O6ZDSzM7Qulmv4Y8Glv46Bjg3InR5kmCoVe0yNun61uQQZzgqN6hd8VzRIZ1IO+GuZNJeeX1N2S7cny9GWnIGWcmoVn/Wr3gL8h5fwI/vKoexeiPMpag7RTnAmNfaE4RAvD3yOpqFSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731419; c=relaxed/simple;
	bh=XLeo5Vi0OixPq2usRBaLnZM1RGFrZ64TkfzAhPZN/00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPNhxHRGmxWFTrrMCGb9RtDCp73K6ud+9S303txJSpyVp2eRu0IDzQo0qj7ULytfGEx/wRCEY1M72JBYf//8amFBZp/BKgzPK6r9E1SJb6Na3J8dBMo2npxMqn2zMsz6WQ34s9Fft92gk+XqtAaMQkNx+m6+uqAoxPT7bOTvP9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJiyz0oU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30b909f0629so7491141fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740731416; x=1741336216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLeo5Vi0OixPq2usRBaLnZM1RGFrZ64TkfzAhPZN/00=;
        b=VJiyz0oUSMjK9zPu15m/CZF0RbCX9jKneAQ0x4jWScV1Pp3HgW+YQ8DJb+hfqtxxJ5
         zDq6yODwaIW9FXXMR2qwMQNxcB01MqH5CwGVqEa1oliEeHrzXYBXiDCxXOqSmZxDliaX
         udWrQTYyVPJRw5BWuWg5vEPbKHLZRngv0oam5aqkV78qe0+GR4137SkZeI8VSw7EXgU2
         fjBrSf0hVBJHGrth6/dSgo7ANL5ap3Oot2WVT23xCdsyQzZlXAeAOXjVYLwb90xEg9d4
         4Y9MOzXJzP4PCNnlEuzN4WwIrRl/OhcD8uWfZWcw+WwsjWBvai7Rma25TD03+MSojkh1
         bzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731416; x=1741336216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLeo5Vi0OixPq2usRBaLnZM1RGFrZ64TkfzAhPZN/00=;
        b=rPnG1S0aEn0VMJcpuO1eGebwwAIZon0DBoxsZNahnabPZZcJ7zW65YQX4m3y5jl/L7
         XzmYSwdlX1siM4fB7xjRHs8jcSTbB5sJRIU4eaujArtPPh5GsRx+uRFdxRRoL6SByY7j
         FruEYOVTsP9UOtbiOe7lpbqYDYkCEHBsBFr843upbH2vOln8mH9l6bHlD/TzGdyQnBKh
         BLkcg9EkMmBMnjyJrJ75/uIOaAztx1765DMIpqqy6zXMr3H4m0lKKvCpGE3RcU0vHcEA
         m/LBDolBSSl/ghI6ZjiYDrCbTrOX3OqJSa5/lKGeVSgoYLuQuypvCSz3Fz6zXqTnebpu
         b/gg==
X-Forwarded-Encrypted: i=1; AJvYcCUln+9g2YycdHFCyyDhEfDyd7vc8xNa/rfjaCE6LhE+MhiK5sEnmM+EVNeDVSUIEGpISVrGkPxaG0EKtto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3TqyuTL/mhx+FvKBAJbuu2LSVBHWycIHx1s4h8KjplsmL8kT
	losXCDGMlHSPnppfbBGK3eeuYWsAEz0TZ6vpGUHU8V7Kqo762DRJqmXOjELJK2mjVvU+vYZ/272
	Zs3306p43cGSa3J0MXJZ8F70b/8HTgyAFTuvvWg==
X-Gm-Gg: ASbGncs2w9E5Y1QLbIKjpgghzlqqZAu+VPo1XHi2hvv4kUyQuOH/JsyRhXCO1O9dpXD
	BKM6IVRJgLqS9leTOmcnaUkGY5sCFnodRSVaJoHJoBSAkpC4Z13fWHkpe7mvUQ8C6HyOHuHTMIH
	4DefznP+A=
X-Google-Smtp-Source: AGHT+IFabYR4anq6ZnLG1cYokflyCZpl7vXNDkVse2kJ8e83DCgpLEdWqJ5k3QMlfybkzSzdA+z9Ryu1m5Kz270QjQ4=
X-Received: by 2002:a05:651c:10a9:b0:30b:94b3:7f87 with SMTP id
 38308e7fff4ca-30b94b38053mr5217851fa.11.1740731414526; Fri, 28 Feb 2025
 00:30:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227152831.59784-1-brgl@bgdev.pl>
In-Reply-To: <20250227152831.59784-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:30:03 +0100
X-Gm-Features: AQ5f1Jpb-gX8sgef_3oXTCJS8DXaXh7_9cKS1g-9bF1Ux-_WbeQKPC42ilJWQFk
Message-ID: <CACRpkdbpNkwQQTLcEk1r7=KcG-d+auozOr9jA160zwE9mq6qAg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: remove unneeded WARN_ON() from gpiochip_set_multiple()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:28=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> GPIO drivers are not required to support set_multiple() - the core will
> fallback to calling set() for each line if it's missing. Remove the
> offending check from gpiochip_set_multiple().
>
> Fixes: 98ce1eb1fd87 ("gpiolib: introduce gpio_chip setters that return va=
lues")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/ab3e42c0-70fa-48e0-ac93-ecbffef63507@=
samsung.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

That's right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

