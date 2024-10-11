Return-Path: <linux-kernel+bounces-360625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954B999D69
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CA51F23C13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A9C209F33;
	Fri, 11 Oct 2024 07:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8oq+aCE"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554019C579
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630336; cv=none; b=ENeRz1bMasCwiZ0ykrazXeYsm70oRHjdiPmEKo0Gh8E0m4bCDTAbIN/OiRhk9wPZ/kWJ7x8+MJUFpTltzryP/bWTT1yjsohLcSBKqHV0nEQpjxTEZUjz/Pono9gK+l9AdH+wKGev6/o9RN58JuMj1MqHzm+BJZt7Ra6BBvuva9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630336; c=relaxed/simple;
	bh=o3wVqjKbdTul8AVVnaYDCXqFq3fTiSJjcEftrFI3akE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=looEzSVfWgr6nH7PwTjquoMlNLUnuxHgDqCSBt3SESulUPUh2Ciw0qPbUgGZUZxlxU/yHJdt68VQiqzRj5MQmDrC1z0aC/Bwtl2e+MjFHMhns5xZFUD6j3NoPRL4jb/ltBmqCRVByMSHpiSsYAkm4UEm+KpONIB6TI3+jZSVp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W8oq+aCE; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb18f14242so15815621fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630332; x=1729235132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3wVqjKbdTul8AVVnaYDCXqFq3fTiSJjcEftrFI3akE=;
        b=W8oq+aCEvJfWopXCBzTtfmRXHPk5IGeUMpCIcv8HKaKTutz7VVhca/LEeeskh6LMSO
         6sH1dlj/NuuYHcsRpRShYZ21Ok6Ubn53Tv7d1y+8Kqa+oZ+sxGGlaRbF0m3afMlhneSS
         uoF28dhOGQoiT1c7hfijNb+8gDsCWpXjoK0ZQLfLm1kBXk4oIDes09jlu39Q2CnEmp5X
         AsJ7b2QOf4ztv1ZfJt2c3uWv8fOk47UxnyqVzgMsrmHrVDVJ0jYsl8GvYrXtyD41JB6C
         +1iX4UUaZKg3kbHkwJAbzcjnVpwXabQDNqupp3FDHUP3V5ZF6519R7bmKmvUOGc8Gn7P
         WVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630332; x=1729235132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3wVqjKbdTul8AVVnaYDCXqFq3fTiSJjcEftrFI3akE=;
        b=YdJD3r9VXCo7U7ciAhfdfMADOamJhS2xmo41tyaipYqFTWHHKJlcPh1Tl9N6YgSNh9
         DptHsh2z8KCUgnhXNpYs+NxKmvbl6SEEVMB9tDwP0iXv4dN9bT5MXnNA4TPFM8asOVvo
         W0i49C+uALLrN7AOzKKM0konEtgE6eNZEyoTgs6+zbUPJPHg61godNDaZO8mfw3hsG6U
         piFsVHwcw/e9R2QU8F5UXO6cRHhb+zF62Z23tv7ZbJwB9fRFhCC1qOEx40eR6JZvFXhK
         8l6GNvshnfE87gJBWIoZ1fPNYA9Oto5Woum3ueyV8lb5pCoikA8iJO+plgFQl1wAQniJ
         XBsw==
X-Forwarded-Encrypted: i=1; AJvYcCVWZeeYFqR9Qu4Z3YduAV8Nhu4WALSCpv1pe+7uHK3Vv3hzwv5AW3ps+pvUoocZDP+h6DNg9uc51LA8t9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZcunqKYzB/25Mc5LMeSubvT+XzlnBZXkVZf6B9X3FSdOul88
	eZyY/Yh90q4BAfDsSyEylBzFQXiCyNrojo8ePbWEuz6lKW2G1ltQNooCL+15fGoUB2L5WYS6VE5
	5cPf7U0AwXjHJ+7gtTWhBms6PHByxLcdBZh7Xgw==
X-Google-Smtp-Source: AGHT+IFsLWHKVSQuf8PCZlf0puIwtvwF5LoRI0DzSO4qYGUTPWTB1RZI3Auv5C+8LCpbKVsRtRLFZE1Zfoqov1FGZNw=
X-Received: by 2002:a2e:b8cb:0:b0:2fa:fc3f:d604 with SMTP id
 38308e7fff4ca-2fb329e3091mr5523641fa.43.1728630331925; Fri, 11 Oct 2024
 00:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009162910.33477-1-brgl@bgdev.pl>
In-Reply-To: <20241009162910.33477-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 09:05:21 +0200
Message-ID: <CACRpkdbUystN3iqN1rQqLP=2UxmNRPR+DwGQKJwC64z4dnV26Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mpc8xxx: use a helper variable to store the
 address of pdev->dev
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:29=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Instead of repeatedly dereferencing pdev, just store the address of the
> embedded struct device in a local variable and use it instead for
> improved readability.
>
> While at it: rearrange variable declarations.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

