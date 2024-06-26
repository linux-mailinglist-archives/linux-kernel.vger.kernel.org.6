Return-Path: <linux-kernel+bounces-230659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D42918021
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DE1288DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 11:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C49C17FAB4;
	Wed, 26 Jun 2024 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRIstWO1"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DC139D04
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719402513; cv=none; b=mhM60onT375axgMWrLn1frQKi+6b+eSZyV7lXZXPUtdMFrEkisYCfBV5SaYJ5WotdIwcm3cy6haL5vZgwvfiV6jXJxnxx+zKfjk/8lAL/V1vY3V49sYOz77y7McDY43ICoaaMJUrqnM+WOk+P1YIZHSXwdclVtB9QlHm9qKyKQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719402513; c=relaxed/simple;
	bh=i3nbTNHwdC9EOpqpQuTwFL0W87Dqr8OSEvKQ/kZ8xtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1uJlm2v+NGIi84esc9SwaEyM/Ivv+a53pqt8jhQXGtZEJI4rLocnWbT5VcP4JPN2pURgA5Ux0+wBe++fEM0Zdoco9qEr+k+FDDyRNjPH0+xAa7twc7GwOpMefq0UNZ1V4e2xgtbDR+EU1kzn8/B8uBFbpIei+lIUfpoYzPyE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HRIstWO1; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso4311705e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719402510; x=1720007310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3nbTNHwdC9EOpqpQuTwFL0W87Dqr8OSEvKQ/kZ8xtM=;
        b=HRIstWO1oQcmfqtzxa2D6IpmREB+pyxuvdE6nrdHdX18pARNRNS7qt1t/6f+tTR5lq
         IjT1wc/HBLaTiVNa8ROBr/oHfaQHUZoD2B3LOJNvTfuF6/uI/H72UIVqmK6mrBoGbHL3
         CcQ5U3igTCGvt3dHJWQjbyHITHbiG80StbPNQH4VwVFA5miM9UlXOkZT6MmXpbvd7BEr
         Q9JTkxdJTC1dts/WVwrrBadOS+h7OqSsgovE/CoqDpdNxxP6S8Ol/8TJrA1m8iLMaebK
         vktvqg6t15keVrTwvYadUR1JC3Dp+2LkDxJeYV2qMDPp47wP0FyJE/hpk1iCiW2OJrQV
         4btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719402510; x=1720007310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3nbTNHwdC9EOpqpQuTwFL0W87Dqr8OSEvKQ/kZ8xtM=;
        b=KbPwELEURScODtolWJrG/bIA5vT2ADmpaW1B+wxDaMWg9Eh3FAMEBKei5PMExkKlHl
         fOZOdHU4EoB++Ojr3JtpvX+GOtRcvJE4q88CYkz5IvjU+ZGcsjtcI9M6GTI6fDqeQwkP
         stUpfnTn0f6AViZcm1y+Bjhdec9mj2BMaZVeGvT1ogPzuLmY3O8RX1ZKuaQAHrOdhNm+
         nkU30iF3+0qM7SADpAM2YjIzckOdNYAVCfTLj8slUQqUvrXZwLRvZmqUZtwvmkb2gH5t
         BcDPkiR9l8n18AUJQlT2taGttzXkw/Bmr5yMTkQB90fdCa/MbV68tEPVMdUWmLyPC7dQ
         oLZw==
X-Forwarded-Encrypted: i=1; AJvYcCW4tV/Ugl1Ar2aXWxiAELiWUb9xIa3x9C0P5tc0wMxI8tDbavzOstUEKymPBv1QMWGgHIvzmLs6oJ5ZR1itzG1KpjuD+p994sg4xk6u
X-Gm-Message-State: AOJu0YzCV5lGxqil60yhSP+iJwloxTtCzFq6DwKX20grce+t3GLoU0mt
	IqER2nYKTU+xm/CfcMBejHKc1ceoNoBSY6VfLOfOAStsO2A9MnpsVRSOt+0wxd0OIU83sx8Tikt
	OqauJbaRMhCIkvzRVFqXxuhaEfSREgIxjmwH10ZoTQVHh25K5
X-Google-Smtp-Source: AGHT+IExP/MbVX+1uVVGfEGLoTHrzzZOCBoj15PTERfpj4XXHHjjsheL6Cmyn2N7vPLeZqdBjb9Lvj7tEPEg26c8Rqw=
X-Received: by 2002:a05:6512:247:b0:52c:d84b:eee6 with SMTP id
 2adb3069b0e04-52ce183b2b3mr5740882e87.38.1719402509959; Wed, 26 Jun 2024
 04:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624093934.17089-1-brgl@bgdev.pl> <20240624093934.17089-3-brgl@bgdev.pl>
In-Reply-To: <20240624093934.17089-3-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 26 Jun 2024 13:48:19 +0200
Message-ID: <CACRpkdaMCHjdOEmBgVqGz=3KxYbZPMgL17jRJeav5fzmjQaOoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: sim: lock GPIOs as interrupts when they are requested
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:39=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Use the extended irq_sim interface to supply the simulated interrupt
> domain with callbacks allowing the GPIO sim to lock/unlock GPIOs
> requested as interrupts.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Looks good.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

