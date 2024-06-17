Return-Path: <linux-kernel+bounces-216837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FD90A732
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA34283A37
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252E418C34E;
	Mon, 17 Jun 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZE5lpYd5"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA715FA7A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609537; cv=none; b=sPgxhxESQplbBX3DTIpWgmjBWeGqZr6nLNdPnTDwKR5nEvSBc+HBn651BR68N/L+eXzAoBuq9wzrJcbtZYwVpEfYwhyIPUzRGO32ssQI4PQzH9ahWAJyeUKZETmfZ6U6mWG4loG49qXCbN8Au66j1gyXvJsn3kgPrZXHA5uRakg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609537; c=relaxed/simple;
	bh=izB/PkYn9CmRGEl0RKH83ESrDRe7DjkYfAYL8ocZl2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMQ1XpbQuKrGu37MaoHtqjY0vG4Vz+b3LjKvkARGXVhkBmUU5C2MxXyWPHk8ZXuU1FB1TtaNq4EdorOJkJMZFwaS60k6ZyLeqUHMK/BXnSYWvJF72b/yITJhl46K9LnfYOqK3EfwAvSrqsct02lRez52CXMW39mkxCxsa7RAqzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZE5lpYd5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso5574446e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718609534; x=1719214334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izB/PkYn9CmRGEl0RKH83ESrDRe7DjkYfAYL8ocZl2o=;
        b=ZE5lpYd5niqwg8scmkDJAopwtsTUPcxVTu+dOG4xCxHYjUWr+fAUPhaiVcWLoWU/rs
         qdtcvZ1yddeA6MPiOztVpjknDsr+5eZp8dwbocswJArRdADJNrpkB+mR1i62ai56nYQy
         WeNy1b3lbGduo+cLLFz1vpudYF9JXNGKb4aI0gJaBx9oceYs/p8fSkJ09KRL65/yJJ6V
         R19jq+suiVSQ7+DZRujNFs3+Ydz1YNI+cFfBzZW1zfNJdXP1E3senyG8zTURShd7Vqz9
         6jH7nVzrs5KS85X5oUovNQDPb4Pu3Z2CPSfXT4L7z+Xb31yh6xl5fd7YK0u5T2ODNOkE
         bv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718609534; x=1719214334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izB/PkYn9CmRGEl0RKH83ESrDRe7DjkYfAYL8ocZl2o=;
        b=iOM71SWmiDWCaSP3xW3HUDfYpOn1pOpf85z7k26PvdvRoBpR22zkltWO3A0A6ylwPZ
         GZ/W8RrRAJg43mU6ZBdQKrO6KWJepcbm63z4Yhnd2NE8KJ2QD87qDp2gOVBz1ovOpT3a
         eVOBhW3zy6ZiCxKvmGnex92NlgBJtmvopqHHdBVH4rXsL2VLCtz9Osq4yooFIVvMs6Dw
         F4KkKUbf39GTyQLv2h+znXc6g9WXWW3VAKZ9VMfSo12wFp2J4E2Vv104JPz9zLwfCQey
         yBj4QSaeHs8RVuzpJT07GGCpoCvpSzEIxP/xGqBQ9VPjUNCTt50An9uw3BBZZFcMCxnl
         FYGA==
X-Forwarded-Encrypted: i=1; AJvYcCVkLCKQO6MK5WsJBymbhCjS3ZN/WlVr8GoEUrO607sQnNHbvq6rAeP+cMbWgJUU4ee1os+EUc1dsTNMv1qRGUfdmqoXRxvqzqs7yPY8
X-Gm-Message-State: AOJu0YypslzLmpwBGHaPI+a2+Zi1j6H9XcDT0YXvpny8cSbg41gGrEFf
	QkOzf7FVczLir62Np0i1VWmg0VNKIsgV2oPPvTtBH/W0v1VfuSehZm/8+bsWE0Kzho0xmV2wzjC
	79iNvdxo7/lxi42HmkFLgbAI/30qEE53/4gu2ToEOfcVL0a2p
X-Google-Smtp-Source: AGHT+IH+aOgaMdTi/LHDhO7GCjbGTHZ3DYDJKPcBfnNVqrjisruFyc66w/1I9dZr+KOs/UdgKKpsqeDeHqe9txRh0x0=
X-Received: by 2002:ac2:44a2:0:b0:52c:a5cc:27e7 with SMTP id
 2adb3069b0e04-52ca6e9dafcmr6487689e87.66.1718609533740; Mon, 17 Jun 2024
 00:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530191418.1138003-1-andriy.shevchenko@linux.intel.com> <20240530191418.1138003-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240530191418.1138003-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Jun 2024 09:32:02 +0200
Message-ID: <CACRpkdY2fxg6uUkbezaR8wAFEUnyOrOW7WqbTEjEF9SzAoQR3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Return label, if set, for IRQ only line
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> If line has been locked as IRQ without requesting,
> still check its label and return it, if not NULL.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I'm OK with it personally, the perfect solution would be to catenate
"interrupt" to the line name so we don't miss the information that the
line is used for interrupts in case of proper labels, but it's not a big
problem.

Yours,
Linus Walleij

