Return-Path: <linux-kernel+bounces-239489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679449260D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A2C2898A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0079176FD3;
	Wed,  3 Jul 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXljRZKb"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88003179954
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010925; cv=none; b=gPl8fSwqd6BpAOnndKDhWAh3hWEN0BPILECglKqlgkd6vsgjC/L5/BtusacziiVeaWwkkwVijrFrbgpYD6XqI6QnCQYel4u18tHH0WzuJwTwkAKkACztQF6Sj8WunwqzKfQs0dBS8dvOjp20Sh6JTViSK7AyaGHOI/j6sIIUYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010925; c=relaxed/simple;
	bh=3M92oo7D0GCuxKuFGIgzFo85A2FKnAzzgy4TTDdt9mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJCEsSuW4CvQU6/iFhU7PMKxIrtAsyHQ98Qk98qeT+CEzUFDn5uyoHQNt1P7IHkxsybRrhTG+L1gn9vyOm8+6LB5xZ0Fu6PjLLHBRH4e021llSnAWFGnkRGxsWX9QqUhdD32gUcDrIHhr7vCqhnjd7TXT3ssZOZ6kIXGgxryrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXljRZKb; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e02748b2402so5903270276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720010922; x=1720615722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M92oo7D0GCuxKuFGIgzFo85A2FKnAzzgy4TTDdt9mA=;
        b=qXljRZKbNQHiwKrg2WVTeyJZpUOz8tXoJA75hdV6K2x6CcXKZeZ53JiIz+TEOvsENz
         kMs63238uhuY9/bY/DwAjtc24QZs7Bysgy4IRsWzYW8YXpR3G2IWTIfTwnUev6Qgznro
         aLj5+u/sasZwyHHrwtEiBeBy9qb6ju/4WUKQOC+sk3OYGV2Z9owggCQAFC6kKRpZWvun
         cWOUfLjvESspaQBKipBlvxdeEHn/1Fao9lgkVi6FaCa34fY3So6Srtn+lF96wsnAJAiY
         +qL7DiiHqeg+whlJpAbDQyLfF44qyLK5/fhMMnPHOy9af2FgWRBAkcFPoOX7oGwTAehG
         46sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010922; x=1720615722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M92oo7D0GCuxKuFGIgzFo85A2FKnAzzgy4TTDdt9mA=;
        b=kVOl5gTHUDR5H5iaLbSUtht0T0+XLunPYL6iriPVrepMfLBF4pwMqUWLpY7GxPz0cH
         51V4zkOHCDdy/XyG2owLBiv+N0I3sqAOOX0c9kKWUSkVI68R5Y51OusIqN8XE346m7Ng
         /7f2Xo2j+/Wivf5rqvYrI1jgHYY2YnHcGnrBD8XwYxUZEDvagjoimNKFmZvPrbPBf6vP
         2Kpte2YKJHpFUzIG1kpfVxFnD3/pa1s46QYrksFx5ihGg0S0A72ZR4/stXN91waiYxxn
         LMCqtuQbqcrq1ME+HNoOkcg7FSkAXGYOfzVha6CBJC0CNaN1qHge2qN4JfLQn+/mBZbJ
         6MiA==
X-Forwarded-Encrypted: i=1; AJvYcCXAoyarNAXxX4vD2r8sgwJ5ExHh2OwhvKkANLEz2AwV98DA+aQ+p5p0+kIbI9oh3dmmJUkMNgZmEloOxp/UREpOB7yJ2e+umlO4nX0Y
X-Gm-Message-State: AOJu0YzQw/U+jpae3o5mQ8CXFTZqR05uR3pHPtd1cAkZALkA9LJzwaHI
	iyZC5M+EboY8wKL32kxxI6fwrcQgHDrqWQ9kND/EFQDpYrPR07gH4eBGH9tCG/f0aUCS47Nrl7Y
	GmpNwzR8m1UJWvd7MxJqMKWjWsDFakW7Ia108DovdFbG4sos5
X-Google-Smtp-Source: AGHT+IFjUoGWH3PFBnIYNiYrEoEkHea61nrLqNK8E7mLauuHE0kJwuMinNs3K6k/4bxMVi3XuQWPjA5JmPxbv0mcXkg=
X-Received: by 2002:a25:b96:0:b0:e03:4d43:658f with SMTP id
 3f1490d57ef6-e036ec6ceb5mr11316730276.53.1720010922580; Wed, 03 Jul 2024
 05:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624093934.17089-1-brgl@bgdev.pl>
In-Reply-To: <20240624093934.17089-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Jul 2024 14:48:30 +0200
Message-ID: <CACRpkdZh1RU43Y2PHwdUPx-K12z5xd5pZ9+dFVMOUc+Ze7mJVg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio: sim: lock simulated GPIOs as interrupts
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
> I realized that the gpio-sim module doesn't lock the GPIOs as interrupts
> when they are requested from the irq_sim. This leads to users being able
> to change the direction of GPIOs that should remain as inputs to output.
> This series extends the irq_sim interface and allows users to supply
> callbacks that will be executed to inform users about interrupts being
> requested and released so that they can act accordingly. The gpio-sim is
> made to use this new API and lock GPIOs as interrupts when needed.
>
> Thomas: if this is fine with you, can you Ack it so that I can take it
> through the GPIO tree for the next merge window?
>
> Changes since v1:
> - drop the notifier in favor of specific callbacks

Acked-by: Linus Walleij <linus.walleij@linaro.org>

It sure seems consistent to me and in line with how I once
thought about locking lines for IRQ.

Yours,
Linus Walleij

