Return-Path: <linux-kernel+bounces-514768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA144A35B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4977D189323B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB825743C;
	Fri, 14 Feb 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="B+TmeMG7"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFD62566C9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739528100; cv=none; b=IfCbS/P7E7GpwwFRwkiEETPoe6MwT5UXopLxLgMKc7KO51PzbeRPEiF2HiaRi05Q632Imm027wREesXlsuEbuOVbfj3cv7ZEek1xNnmiX8btvpLLMQwYjLsvN0WsldWmka3WhbjNaTPISiFWRqsGB1V+6Au62Ej/9rSbW2wK1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739528100; c=relaxed/simple;
	bh=96IUlvA4Kab/E8aWKKJlXMsjG5KwQVnXCwIZK25zn9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCy37B1ajdbwC/ebdzLzLyOMbQnRIA4JXnetCuUGB4NrVZpJPMhpFVGn4nHoVFNDv4FFfbkGv06QNJrbwAPC5RkvPP5p/yXspzcKCQMXn8wvbAj5CJ1Pm+U1QEksMhBlg2xC/QLsA0D0BZX5NxCUPgd6YiY9blvUTzGAac/QYfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=B+TmeMG7; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5439e331cceso2192869e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739528097; x=1740132897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96IUlvA4Kab/E8aWKKJlXMsjG5KwQVnXCwIZK25zn9I=;
        b=B+TmeMG7fChE+5sf5xiiZZNZjtKynx3/vb2uM6xsOuuI4xcwSKb2M7EhOdwZ0DqBhc
         a/lspK+dm+4XaaOwpAr38tpgV6tRkMGuUzmCMIPibqUfJekZ3Gk+fDmwD6tgsalvkl0m
         cYzslemXfpyKPqezcPV9Ku6y6LNGyH9ZepaYOTAA1J0WHV0lh3TLOQPJwAFE4lkx6DOz
         VkI7Ia+Z99BjX1Bs7P9Ks9xu3esMlb9wQrk9nBeyXKCf0lTNfQhKVo5JKiXzQvBUaHrB
         jTBDd0VQVuLr6qHNgl1essykKGo9K0j2+KLHvk3Eh9qUCXOuvm5hpbFKx4BF2KaT6f9J
         faFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739528097; x=1740132897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96IUlvA4Kab/E8aWKKJlXMsjG5KwQVnXCwIZK25zn9I=;
        b=rUF4VtNqnVkFV/Jngf1BltIswKXC+34bPy3udI3a5Gps6mNDc0G4zBJRbYJgerJghN
         LWOsmiMwPA2Cq48rkU/kYAQ+Ac1fcumYUreBFIu7W79meC6a6UJfUZFglxbD4c8VNGkw
         H6bJJn4nS13yiTHFxuPck/rowSycpUDBKlOvgB8rNml8kVJaAt0N4l/rGxjmeAfZqR+x
         7jfIWyIKA5zYBKElYuwM1047Z3+rXYkmB8YL2u9Ibt7KCwnu8qeO6JnHSN281VwrUIqT
         j0Y3c5J5Df0lG9RokWgatyPRh2xVSGpajYFswAfRiAHkaflnNY2pugALIKhOH74iOJKx
         zbGA==
X-Forwarded-Encrypted: i=1; AJvYcCX4SzpXW0aa0CwJ+rNrOuF0OZ1Nm+88aM3+0M3+ZIvt8Tyrq/kXDyfidN6UmEbptjak+TCmxblPmMZtpgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10t98GB3lx+3/XMF8zMkR7Ma/PiAjcQDj9MM4S1TGtImMHsrt
	bvI+4OiA8NM+cBVoyx4+NO9TttBDOuQ1qgG864+BrneHex+sBitCH/LBCvp5xtI7IugaL7YiqJg
	G3gd6W7fRZ0/Pof2uxJzFqkcmwy0hxdOEKoMTHg==
X-Gm-Gg: ASbGncv17yqMYn1XwZNANp9wVc95yeQJd0cQ4BQrKGeJlWVjCAa+6eWMNSy8ezoNF5s
	Cw8wahTIhwmWPAdmShVCBSnlE4TEjhDHm+kbWgB0761Hs21dnFZPQbiz8qvVJK3yFRYT0jG5CZj
	hbmSDxFoXiEu2lZcMt6g2Gr5Xx1XQ=
X-Google-Smtp-Source: AGHT+IGIHT58DThOkHUQCnE0Th1WDTQk4pOddXfAj+W59mKK6nphQZOjUH2rQySGLrnHMOPeaMVkwqsD4JIkTWJHbzc=
X-Received: by 2002:a05:6512:230d:b0:545:c51:4a0f with SMTP id
 2adb3069b0e04-545180ea93emr3217951e87.4.1739528096595; Fri, 14 Feb 2025
 02:14:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-gpio-set-retval-v1-0-52d3d613d7d3@linaro.org> <CACRpkdYL4odi-00YDi-cFuVgw8uBncA+ZxGYnRRhuYR7eZuBWw@mail.gmail.com>
In-Reply-To: <CACRpkdYL4odi-00YDi-cFuVgw8uBncA+ZxGYnRRhuYR7eZuBWw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 14 Feb 2025 11:14:45 +0100
X-Gm-Features: AWEUYZlEKbgfCg5LM4mAcnDmuKyPgH0ZcuCi6oqVDIjGsTxRu9-K5fCxAVSS7C4
Message-ID: <CAMRc=McEgpm+rafr64N-NeOEqk9OzwaEb=7u5ZXQ6vwnQBgyTQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] gpiolib: indicate errors in value setters
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Walle <mwalle@kernel.org>, Bamvor Jian Zhang <bamv2005@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 10:56=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Tue, Feb 11, 2025 at 1:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > The value setter callbacks (both for single and multiple lines) return
> > void even though we have many types of controllers that can fail to set
> > a line's value: i2c, SPI, USB, etc.
>
> Yeah this is a remnant from the design that was done of gpiolib,
> at the time (by David Brownell) assumed to be simple MMIO register
> writes, so not much could go wrong there.
>
> > This series proposes to start the process of converting the setters to
> > returning int thus making it possible to propagate any errors to the
> > user.
>
> My worry is that this project will be another one that stalls at
> 85% completion (like with the eternal descriptor rewrite project)
> but I guess the upside outweighs the downside, and I also trust
> your proven grittiness so:
>

Unlike the descriptor API, the changes here are quite trivial. There
are about 350 drivers that need changing but can be done relatively
fast.

Bart

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> for the series +/- minor nitpicks I may send that I am sure
> you would address anyway.
>
> Yours,
> Linus Walleij

