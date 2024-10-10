Return-Path: <linux-kernel+bounces-359915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD58999273
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447D9B246F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3796D1CF2B9;
	Thu, 10 Oct 2024 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tg5Djhk8"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E470A19DFA2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728588988; cv=none; b=qnMrY/JEB42VqVI9ztrolrDnJeA+qtKZRDiabGjJM89Nb4GwNU0eIHzsSwm7AIMmfQG84atS2/2+QCXKpm6Kvt1RKJOFEO/U3OPlOxYVeQ1ChGi+e3qOd+h4ItjTpIGW5ZfIqHxNmy5iHMtFdIoSiZXG2+7OpPcqpEEfovRPJ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728588988; c=relaxed/simple;
	bh=Ip3chL8Bss1a08NOwaypbXfYRjqRoK2PDdFzgYiK+7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScrEmZjNkS4AwzhuI3gYY24dk1rYmUYZcjqPquA1MmygaGd6t8w8mnE3CnIVtbhjUbLI7BgQ8wUnX/fdECPs6HZ/yyIyAyTEWLUeL7TTc1uKNf9oZ2k0C78+RFip6dshge5EcyGcGlF+JRzdAMylA0P2KSvdq5/6HMcuk2RXWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tg5Djhk8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fac49b17ebso11707881fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728588985; x=1729193785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip3chL8Bss1a08NOwaypbXfYRjqRoK2PDdFzgYiK+7g=;
        b=tg5Djhk8jjKJop1DduXwjpAXJRzcjZJHK3NVQjmmrtE5riIR5OhvNo1AOd4O0YSJ8h
         4XRLKPsCa04z/rkXXyFHpSBiUE/O5gedqreLYiTG9HQQj0dkJLm2menTgLSScYQ/ZbLc
         WdPgGx83SESREOf61WdOfoxJAbMQk0HI/VP0RcX7i+iYvqpbYft6zdZZiJaJKg0r5ho4
         1G5rw2r/UXz9JXENExzJr8WHazf2WIlVX42g7g6kt8lz/w1kWFicK+4rW7vkvfZEoGiJ
         4JZlDVtMmXyf5UdKUD/tobVP76UQLOHf+hsFL/Hlnw9KihokuTiTWkcAslY0QEpdv17z
         fgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728588985; x=1729193785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ip3chL8Bss1a08NOwaypbXfYRjqRoK2PDdFzgYiK+7g=;
        b=cKQRtvHDaPd1NOL1KlTJVVmEwdXTWT2d8ZeyvhENmCDsjrU0PMBfDXC4QQMyRfHKVm
         1gIauZZUyJ+/kL3ea2XyI1RgBE+MHSsz/u4YAuGbnTL1Z7PqP3fUmZV8+T11ZC/NhxFc
         lsqL9XiqXIDKYaGT5i/mX2VwV0PYqw3MgIc6UXGJgVFhO2kssCfu6ZkL0PHRxrZAfAFx
         RyuZkP70qxgF74im+8F1Vf5HiLKVLhKrI+KkFTGkA8wphoPlBOgRHYCaL+lDYstpA/Sb
         7XrzU8YcK/qp5Ou+Nmv3ObaDvhYYADrasOpCN6KiqGojX9GvKEz6YzzmrNV1a6GZkndv
         RuJg==
X-Forwarded-Encrypted: i=1; AJvYcCWk8zUuGmq0c5YIK4QXwS7zQ2MrTulCGcKYCxR4i3SPX9yk8Nd7MwYIlnVBwUzFedUdVnxWpMFiwVoH7IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEmhlgNkmB8YY6jrNLx/PinGfqALzfYX8qeNRHH6EQAphA35I
	V30C/xRtqXf82+WbH0ax1Kj4sUf8pSQbPs5ZiWTWmXwB73V/umlSZO+nxM263c5F+n9lSXh1Khs
	LlBAd0F0kvrQjAba1WL7h9LstfMlmiLHRuE276A==
X-Google-Smtp-Source: AGHT+IF1JPtswPqXRowOIiK4P5X8Uj/d9e4V75wvy5zFvANGLSPcvYHJKLPcx2qzkyv2Qy3Z4IEyqYV3wScisgfF/fY=
X-Received: by 2002:a05:651c:1987:b0:2fa:d296:6fc6 with SMTP id
 38308e7fff4ca-2fb1f7a2a69mr29389541fa.13.1728588984996; Thu, 10 Oct 2024
 12:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010080347.7759-1-brgl@bgdev.pl>
In-Reply-To: <20241010080347.7759-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Oct 2024 21:36:14 +0200
Message-ID: <CACRpkdaTfzzdXhBrXd8SxWNupay_Q9ZW=MJi1Po3x7BOUhcgDg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: aw9523: fix kerneldoc for _aw9523_gpio_get_multiple()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:03=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The parameters' descriptions are wrong, drop the invalid ones and
> document the ones that are missing the description.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patch applied, thanks!

Yours,
Linus Walleij

