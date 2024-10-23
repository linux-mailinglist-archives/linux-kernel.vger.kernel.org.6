Return-Path: <linux-kernel+bounces-377542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CD9AC03F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5D61C214A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2C2433B3;
	Wed, 23 Oct 2024 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BwE5wB7C"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780073451
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729668636; cv=none; b=PtUJ+UPYUpD9uTxdpjBVkx45Pim7bg2UAn2MJpOOU41KiVPnicH56Payt/Q3iIhHF0UK1zQbUW/Sz72Tl55WthuNF+flx9hf39ulnOOemORzY9NQZK/kOXqNzqBoto3HO8dU9lHw02S5jOR9782tUhzI++nx2IJszjKoUIe+v2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729668636; c=relaxed/simple;
	bh=n739nx2UN/NZUZKONL+XuhvZ1JZzuzJ0nufrWP0ptmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll/LT8r86qoIWKXBSM7m/YFXXa5FRhWHsAG70TSlQEj1u3ajokPckn19mKzi18vqwRX3+xYdoEl2qwuK5lzBPXj3vLfPsc5O3LD4PSTV69nxvwtu+9S/Wwp1um7ktwDt77u+picIeSjSXkKzWTR/YXhf5BIXBxqBCeJ0eBeIEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BwE5wB7C; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso6241241fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729668633; x=1730273433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n739nx2UN/NZUZKONL+XuhvZ1JZzuzJ0nufrWP0ptmw=;
        b=BwE5wB7Cri/jVgzmZDwe4ZNkcxuhE9GnIGsUEO82h/sbNcfuit0+qiYkzGGapY5a8k
         A1zL89884XHlhvq8Kam6KSHmy7py6o91k8CfkgqdPFwYqAIAxdpay1GKXH4fe9xBh1WD
         GWXUTPKrQ075uDVi7J6mqhD3RF+9uFG/DzzuIUUoYf8tZ1COAC9qlWpgr3Uc92MOk436
         4LuIVPZIlB5HqFANG5UoUXm6HyWXqLPyEPIOueeMt2DFTHWiPON8ujLHje9z3zBgTgtp
         sHnVK1HyJmTPc11RBV+dONRW1hrXi88EvTeHOUdo+L8u+YzlRWlJb18gHuDnIk36fIkw
         f6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729668633; x=1730273433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n739nx2UN/NZUZKONL+XuhvZ1JZzuzJ0nufrWP0ptmw=;
        b=SbE7bnnFoiU+7SaeZq20eYhq7Xn2Yy/RdHDy9TaG6PYkLcCV/43fdwko98raUGh95k
         nkNAybszOZf7M6eXBUhgqcAL4RJ24J8IFO7qFdu7JY/rfQUEQ4NAQUeBq92sqIPlZhDl
         z7VJWldc3cOu1w+471Yru0+GWT9Rrd9hSJzF4Jr75+QfS1XylSf/0cydm8m5u0MHmtY9
         tT04U9ic4VfEvbKgcSqjIquIMFOFIxfiB7TcZr3aJnM8hgAI2OMj0MvMNSigI/9TGLY6
         +w2VNsVKaIHeKYEM374UZiDe1vSpWXpjONDvdbWu2c98C5tjcG3JWBAzUpDTnwZcSu84
         X/wA==
X-Forwarded-Encrypted: i=1; AJvYcCWcu2JTqJ4P6tp6QQ6GiGHMDz8rKRimSrxXxj9CiDsp/amINwJi/mX1wRMchrtkgOQ2hM+FEejuiiArbxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrj4TXOEZXogcuZp8wgsnFETI0aiSbzspuNEuxSMRyDCOWOhX
	hxExeZ3BbC+EiAz7ccVImflBsv/u7TVZQYe27oywWgCIFAeYV7gspR4MaJX/FnSTRiWvDUQhTix
	fxncsFRh0554AwxfCiAU760zO6OMCOytVG2LdiP7Ybvl7OZAE
X-Google-Smtp-Source: AGHT+IEva4wXnakfKjcvafWbhgQwJmgwA5fWu6O1TBp2BSbKq+o1/SacVwJJ50gzLu8hzdCHr7hbC09FfJcgamvwsSA=
X-Received: by 2002:a05:651c:b0a:b0:2fb:49d7:8009 with SMTP id
 38308e7fff4ca-2fc91af1dd4mr19424311fa.3.1729668633091; Wed, 23 Oct 2024
 00:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022194624.34223-1-surajsonawane0215@gmail.com> <20241022195432.35700-1-surajsonawane0215@gmail.com>
In-Reply-To: <20241022195432.35700-1-surajsonawane0215@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Oct 2024 09:30:21 +0200
Message-ID: <CAMRc=MdL2rnCG1ix_iTKAZ5+Oa9bC7P5BmKzYCZtQuyrP2DZGA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: fix uninit-value in swnode_find_gpio
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:54=E2=80=AFPM Suraj Sonawane
<surajsonawane0215@gmail.com> wrote:
>
> Fix an issue detected by the Smatch tool:
>
> drivers/gpio/gpiolib-swnode.c:78 swnode_find_gpio() error:
> uninitialized symbol 'ret'.
>
> The issue occurs because the 'ret' variable may be used without
> initialization if the for_each_gpio_property_name loop does not run.
> This could lead to returning an undefined value, causing unpredictable
> behavior.
>
> Initialize 'ret' to 0 before the loop to ensure the function
> returns an error code if no properties are parsed, maintaining proper
> error handling.
>
> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>

Please add a Fixes tag too.

Bart

