Return-Path: <linux-kernel+bounces-514677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603CA35A19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE56E1890F49
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0C22F388;
	Fri, 14 Feb 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1FEnFa0"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4522D799
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524875; cv=none; b=pULp2pidsqMvLZ78lSCMLcOn1BGQvCwGWLtKxB6Zrva9sBu5oAl7OQSVqvJscaVGDR95oO1/o6zPV0gP4oF8gDoO5/YHR4nIOMcAWMtcA1GQ85CTt5FeAF4G5ld9DQa07R+JIcYfW3whXtlXGsypk8g0v43X3ZckOhpGvbScw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524875; c=relaxed/simple;
	bh=nAgI/y8eJ1E8nc79XXLDgqcje8Y04QIWciPNIuCcLr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Um9sBw0ii3GXMGSOW6TKwnSuq4f85bk3vyHTyxSfVN9Ib7mvZEitW+94aEdXmDoaHO72UwbSejtW2TOQEmBV5ZvnvwYbm1HuuKCZ8X9CmDdhECJ8ego4pl0XPtsrK7f0npYm0b4KakK/AAfx69mW7RuyOV8KG/QYJKGk8qVGr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1FEnFa0; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5452e6f2999so10256e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739524871; x=1740129671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nAgI/y8eJ1E8nc79XXLDgqcje8Y04QIWciPNIuCcLr8=;
        b=p1FEnFa09lSugOKK9Nd0m6W6AHH3ieDTsFDkP1QwHrAY+sW6fc3okIq4krLCLAsWE1
         jsth5OoOunMQ3K1Wl47X8fA4dXSQPHT0zFWbf4wYRkVXXAKknN2fsqid6JF0AYdYEenX
         5ft8Oi+9u/MD0xi8zbIhkKQdUl/J3WoE7W4O4ZRCsBokAYgsXt6TSVJb0Q3/4lpuxe8a
         hY+LuL9xrQqdF0zu1faslNIAG+Px9D7Ym/EdjEV2T8P/ht1WMtVoG6YA4rgHDU3oP/lP
         fRhfK3POOUF2rkn0TRiTozy6rfv6GSidaFq4KP5Y7ieGDN37xkr3HWGnZCBaH+09S3wK
         47kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739524871; x=1740129671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAgI/y8eJ1E8nc79XXLDgqcje8Y04QIWciPNIuCcLr8=;
        b=UQLSqRJ2uo0+fOI2+xxHH6l19zWtyB5L5elnq8aQj8E1fcioRx5y1atvGELfTKOchu
         2v1VJROXgVRNxksPHjlj7P6SNaFgg6RGYACI3bxB8E+o7hOaKuPK1O5Mos8kwHh3m9yB
         8bYd2zZRuhBxmqt1AmTjSJt4bzGflcdJLcRcy00WZEep8hFBe/a16AikbnObz++8tL9r
         1bCGPFEk3lh7QquK5+qXPEbtzDDJkYrGVnkfcQMAQU4OMgP2BgW20AoIOy6dvlyJWfqg
         CjwotD5lNey0dbv7ghHQrwM+NoatY0pd2ZRtOq9V01WLRU6QZUxHE+Kg8zBxTZjlLEqz
         3o8w==
X-Forwarded-Encrypted: i=1; AJvYcCUHBRTt6zh//FNsgm4JW2/S0Yis4vQaet/JxC8STTDB3nDjZa/1T4Ik+/ppG5EZP2V8HawhDxcmQj5b/BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYILMP1tXvsZ4N1VCL77PbpAJ2g/tFn4CmOFDPYQ947weyRl5v
	CzgJnZK/pbGnyoVUn66YrcCBVTB5DTpc1XMvzArf0BFZXbe7k1mEy/fHkPSrg1M481aQk6T5Bee
	OC61MJshMg9vntJaRV+0Wg7UY7RnlRr5HklDddA==
X-Gm-Gg: ASbGncvl/309q6h+x8m7tUDYHj1iJ7dpIuhOdFll//l/8xt0jqq6oZGHH+Qg9H3y/WD
	tbIuKdkofgSbGrBrz+2crgrEjJKz3WOwrmUC7qyGqWfaWjR8JNye7G7Wbbd5lfcCHMGHq8sW8
X-Google-Smtp-Source: AGHT+IE90b6o1JJv5clQNldUi4eegVlq4Ca3JgGfeUcZ+3CP/urShfREcnZbwFVUloZzXxIeSNiZtb/EuXTKGiYXpXY=
X-Received: by 2002:a05:6512:110d:b0:545:191:81db with SMTP id
 2adb3069b0e04-5451ddda5d7mr2106191e87.50.1739524871552; Fri, 14 Feb 2025
 01:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
In-Reply-To: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Feb 2025 10:21:00 +0100
X-Gm-Features: AWEUYZkpajzFykICl53b_t6wma0KSzpRBNdWfZ389OoEnBSGFtcIchXCSCVghNU
Message-ID: <CACRpkdYYj6MO-xAQAJ7dnD22YRbfBZFm18Zg1T9P0sd=5kd8-w@mail.gmail.com>
Subject: Re: [PATCH 0/8] gpiolib: sanitize return values of callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 11:52=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> We've had instances of drivers returning invalid values from gpio_chip
> calbacks. In several cases these return values would be propagated to
> user-space and confuse programs that only expect 0 or negative errnos
> from ioctl()s. Let's sanitize the return values of callbacks and make
> sure we don't allow anyone see invalid ones.
>
> The first patch checks the return values of get_direction() in kernel
> where needed and is a backportable fix.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This seems reasonable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

