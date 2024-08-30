Return-Path: <linux-kernel+bounces-309541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55773966C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF208B20936
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0191C1AB2;
	Fri, 30 Aug 2024 22:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIRXkQJK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694A41C173E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057331; cv=none; b=JlBhefvIPSB7LGmVH0Synn+Ww7aaQa7VgTks8tbM3bnp9vU8eFJg4FAYSxTnBdvkESbmk606HGa4CXcXjfIJdnjUmYIgWKPlcgUduBt2JE6eWMd+mx02yWmZeCNXhUmA4PoPhEX2dBxwZmXeqG+jrered24IJSHdMXz1KvQ4HGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057331; c=relaxed/simple;
	bh=v4iBb4s46qTC+OnNjFfAVZeMlvAyxTlCo/S0K1EAh0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqIkfEaVL7vPqDTYYxFmVegzD9uxhPobKHxyNQwUZtMQxonPUe5O9Ca3w8FprvX84TEXPrnoPb+PXiRvscxxMXMNBhFZMINkfFzp6MbKXLKKPWl8GKcaH5qy76U7A9UX3dYRHDEtd2jhRHr/ch0KUXVHnDs7jBQSeeVUsggB3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FIRXkQJK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5353d0b7463so4135903e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725057327; x=1725662127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4iBb4s46qTC+OnNjFfAVZeMlvAyxTlCo/S0K1EAh0E=;
        b=FIRXkQJK60oX0HSKcsAyjeAb9Vrf84275dDoWiZ7DEvvDkGTn2hYJHAoKO4VGcMSWR
         OaTZ7dUy7o0/bmK9FkSGhi2jTn66XEUZkcMsHvqn7IKyV8CORW5TJe5QISGT+M8msVAN
         xbGFU4tqCyl2ljx6Ud/zAsC5jID0/rYMqIkmIjxoHUr5V1AAdoqL4njehBM3tazrHLhA
         pFqUwozDdwQ6JcADJe3VgiNYBXJHONrxDGQUAle+Z2TXimeFS/erAQuUYYUtOugpEysv
         pWdh2G5Wzx9dSeciigU/EPphpCad329evx06S3MzmbQoTy8D7PKF7dCTgf6pslvw849Z
         U7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057327; x=1725662127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4iBb4s46qTC+OnNjFfAVZeMlvAyxTlCo/S0K1EAh0E=;
        b=Be1phnyGCTgQU+pk5L6Bt5OAjGVXoQsuLCi3AMipKRq19H7mLzf7UFeOkZpcEArocV
         cxscP6y/2FSl1w1gYbQLNJNEGAbEMoUAuo3xjBRNBwO7UvBj/B60yOQ03p507r0hoftM
         708KA8USz3ifXS4Lk46otmqC+MlRv6y2m6pqEiU9iOfx5AAHIRghUKds/ZvQRCus0//J
         rDdRtxEEJnlB69Mznj0GvREW2U1dudDGS7JBeO2TJtJvm6VGwpN6/nuhSYc7S4ASjQiL
         kd/TJXRpRBU+tQlQkDddTgaRzsjXahDtchoB+hGe8U+J6qXfGaJbGnfMm/N66i9FqJ3J
         l+lg==
X-Forwarded-Encrypted: i=1; AJvYcCWR/xeoj9NfjzFr6chn6F6e+NQq+rV1UuzoKjXzaqhNe3361Lps3P+Uv2EZ5w78czjvpNabB5YtR5pJ4TY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5UbR7ts4Qp/nKm7hb4rTA+wscDNzuE7H9f31/KICRZnCPPEU
	SHX4PqfavYcUN8xilNweEtDmByl8czKP7UbxKn5ChMrNBnfHwl/9okBix9B+O4nRJb8saOk+x4l
	KiXi+5IGUhJkdHpDGZoAQBmm1qk066CNGVxNj0A==
X-Google-Smtp-Source: AGHT+IEtFXEb5SKkS9Dwum0owW9p7oKua/V4jc1o1ChojvOLPjtG+8DqWfpQtMEozfboOaOre8Jhvg92ZV6kMcJdkjA=
X-Received: by 2002:a05:6512:b9f:b0:533:4591:fc03 with SMTP id
 2adb3069b0e04-53546bde01dmr3131559e87.46.1725057326166; Fri, 30 Aug 2024
 15:35:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828142554.2424189-1-andriy.shevchenko@linux.intel.com> <20240828142554.2424189-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240828142554.2424189-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:35:14 +0200
Message-ID: <CACRpkdZ3L0DGdrFEzRUF54c=yC+aDjO1TNd0dVuSmKninpR6TQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpiolib: legacy: Kill GPIOF_INIT_* definitions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Hartley Sweeten <hsweeten@visionengravers.com>, 
	Alexander Sverdlin <alexander.sverdlin@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 4:26=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Besides the fact that (old) drivers use wrong definitions, e.g.,
> GPIOF_INIT_HIGH instead of GPIOF_OUT_INIT_HIGH, shrink the legacy
> definitions by killing those GPIOF_INIT_* completely.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Excellent, thanks Andy.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

