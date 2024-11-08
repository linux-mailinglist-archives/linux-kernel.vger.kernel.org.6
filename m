Return-Path: <linux-kernel+bounces-402247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 249259C256A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1546286054
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B561F26EE;
	Fri,  8 Nov 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bnhapw5f"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885D51F26CB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731093085; cv=none; b=l9g5GuDtJNUDL+GuKvK9OkTlMRcwbwrzWHJKYKeAQ9wzG0xx+9pk6LIh1cJ9uXd2NV/0dQGL10xc1TkyUv17mUPUBTHsGB0dWRbri4xZr5tFGtJKSTLwjKOI9q5MpmFeXcDCHR291/mcdTQjAa3VQeiS5y8l6hcBBPTFvQ7UW5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731093085; c=relaxed/simple;
	bh=VIRkx+efX/6GJFRSs+ScK+sQvOdc8uMwqc3bnd22j8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl0rdC8tf0dzmg5aZdimpRHp8T1qC3wIZxTtXMzf/2jlYML3u98EJGpr/rlOCcKBzTGy+MJ7RPeHQ2WTSWL65dV4C2/fHqgwcXGc2LTt3tf0KZi87vKta6Gz+3aaLsHpYRaIdn89dWS3WZmGF5Y1FzVevNjt/Hv9gn+oJCxFL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bnhapw5f; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb50e84ec7so16587531fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731093081; x=1731697881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIRkx+efX/6GJFRSs+ScK+sQvOdc8uMwqc3bnd22j8Q=;
        b=Bnhapw5foka1Ig1WeR6wObMuvHk+Lkrn7kqmlqF+/eF0YfntamtnA6RoJgRnXGf8Jv
         YY8KT/AFztF1GTtnF2u0ZfaFB4SENE1oc2ohWEwM+3YJ6l3x/q8xm+gMvfb4Tpurs9x+
         G3YrI9rB0ERKoVnfLENfxxzYRGlFQAnWdT8O1Tm9EvhVk7W1RieTNDgGPABuE0KxIdMZ
         WUGfSyzxXFKUEHiUVSJ+REFhwODHSMZGwOa8jDg+WbsWtfVlAboZivA5VPaEXC3Crva0
         S6sPm1NUgCBrLKt8FTfWYA/NddiT8ORoS+FPzyqc8A7RQlBcWwCmySP12MrPwhC6gq9m
         qUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731093081; x=1731697881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIRkx+efX/6GJFRSs+ScK+sQvOdc8uMwqc3bnd22j8Q=;
        b=IWWRXijJFIkpHcFkYIEOit/RKyZQGXx4ksCkw8voi8g6OPZWh1+yncjhNkf3YfclzI
         3qSTFRsdwwOKJb274Z48PCojTniJ42L8qM4FvKBo4yDWe6YMkgA0PSlXglcpv6M9D25P
         DTNPLODxvtdhzgTZrXvWSqCkqoP0WttIVV3iYPsj4E3293MVtupQY6aAkxsA+L4eI0k6
         bd7a6IlhtBZulhbJDFZAna1W627B9ernOejtP2qIh6VCJ1+tHcw64s9C0XgAXhPQCS1U
         vjgpIq9jItBDQc9YWRiuK/2CW6kxzsHPya7AmS/UaL4YZ7uqFOC3BOkLYj+jjRPPFwLk
         JCWg==
X-Forwarded-Encrypted: i=1; AJvYcCVxZhK5zaVkZJyNkWYYRHAYlTR0Hq/v4kJpz1DjyQlmgKmYhl33Gc+a00iq92x5RIs84PzW04wzqIXwmNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1hht632BLSWwoQ1WssZtbxRQkn9yWLhmHeDTAh0UdTcCcraqv
	eaxiPEZs9gTwLCA/TEfhyNaXUYp8luXRPHv6Zx+1zPc/MED9sD2ZeC8C5nMFPr98grhHsSFqIf+
	2B5aDLJ+hAKQKUD/9HY/iozME+KMACzoVktMefKRbn+yZTgtP
X-Google-Smtp-Source: AGHT+IEyu3ErGRSaoQFi38Acb6XQ4BU2dWUjhmoCrPXW6aChPPUQ0fFsyrxlijdB2I2MeCnQFX6bAQ4S/Z/CIgMGk7U=
X-Received: by 2002:a2e:be24:0:b0:2fb:591d:3db8 with SMTP id
 38308e7fff4ca-2ff2028a90bmr22074941fa.35.1731093081457; Fri, 08 Nov 2024
 11:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220616013747.126051-1-frank@zago.net> <cf32d676-831c-4c3f-8965-c9be3abd5300@gmail.com>
In-Reply-To: <cf32d676-831c-4c3f-8965-c9be3abd5300@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 20:11:10 +0100
Message-ID: <CACRpkdb-VWnOcHBcHOfMMxKicDGvGt3vB-dSo2nhz_M7oxq35A@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] add driver for the WCH CH341 in I2C/GPIO mode
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Howard Harte <hharte@magicandroidapps.com>
Cc: frank zago <frank@zago.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, 
	Wolfram Sang <wsa@kernel.org>, Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org, 
	Lee Jones <lee.jones@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 4:58=E2=80=AFPM Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:


> Hi Frank,
>
> Are you going to further proceed with this patch set? As far as I can
> see, there were no updates since 2022.

I suggest you take it over if there is no reply in a week or so.

IIRC Howard Harte also has this very device inside the USR8200 router,
but I don't know if it uses the I2C/GPIO portions in that device.

Yours,
Linus Walleij

