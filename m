Return-Path: <linux-kernel+bounces-569743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A2A6A6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB91189AFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0C1DFE00;
	Thu, 20 Mar 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+w94z9M"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A061CA84
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476686; cv=none; b=nDycwf4vq9DN5mrQJutQRxRuAlphzgfTvfbOz1beS6Z8M8gPA3eQOKDHxdq90kGJSo+9dkBrq3A1iohgCYfTm0lfyGikdN1oIMqBKK6cS1HlClesJSkC5S556SpLt+xPE4sVSqUXrOTP7w96FmpvbVCVs+GUmCmYvCkhtN+eK8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476686; c=relaxed/simple;
	bh=21DqpUGodccfEY/ZfoWYzc7r5EAcAprM67s5qKGMtuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0x5O0XS62i88xyTWNo8QNLGWElN35pDkVkpVVWHbqEaoJ7EtPIZ/4rQcbohGLOU/ZB1qPbH1HKD/wPbmFcbjzZWGUExqrBRgW+ZltfQcQvI0Oytm5PwsHmvskC0eCB/xS4ZB8X6MeJhm+r9y4z6QOfzQTc3M+wZAXQFlvsmO3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P+w94z9M; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5fe86c16f5dso339266eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742476684; x=1743081484; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O12nadUsyPqdQjwO9PDc6yNGkFbb7eWIfLGfjGH84dE=;
        b=P+w94z9MX246o72PiKE+6ES6ISinsCbyniE0GZznGZE+ph5oqsbeBHmwehsquowj3L
         oMt3Fp1qwSUYea/w2wOI7F80gMoZ26MGM5n+M2yidKXbtH//Vv2FJeLSkCQ1quHbBVmF
         SbWOyi1dfakZuE3pFthNYysL2R52iRCY4a+HPhWY9Q5e8MthfRw4mFGLY/KGp8bf5MdP
         xMFE0Dj3BWXlV4lqN+1QIs+u87trw0R4V7xDZU/fq1CS3nz6FNOMqZ6So0F1HCOgIePD
         3/at7KkIvMN5ouNrFeyP5zN8vfROrp8m2kgs5UTDE8yl2tx/jTaPzCZlSp+7uyeuRcf9
         yeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742476684; x=1743081484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O12nadUsyPqdQjwO9PDc6yNGkFbb7eWIfLGfjGH84dE=;
        b=UJyhqqVuPkmgzgY4sxiSLkJXAo84Bh5V0dH3ScGdHSG66lGZq9KfEdtnCzhfN8qQgV
         y17LQ5rJ5mLzxY2kQbLsRSKT5xv81MAFn1ObALUF3ToQg6JZ2iHA6YQrJ+x5rZLO96bw
         BVJ/plS4XghhdV78ADShq2PRTZGKxFKJnaaPXry76gtUq/qmIOurur5qwIGv2t9rJ9aL
         OPZfudPJGJmXwvVbKTD68zSw7dsSEVttFUUCfdGWKL6kkBUtld6MfQbng+YzW4pvsbn5
         Wo7A0EwgQQO6ZoNQHOnWv8XzFVy+FPHLBZAXTLSSNhq5B2F+DYoMjxOrBs+80xmT7wl2
         hJLw==
X-Forwarded-Encrypted: i=1; AJvYcCUOg+Y7a/t+pCvEOhpiNgPk7XMNMLpsoYiIqJcyvk8TWUDpwV/VU8k/gaX6yTdDcwkbt3ZMwSheY8R2B/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpiaf3FRZ008CEL5YkmRo1cJkXSPzsKoWbGLpkOXxpvCbMLsDf
	bZ5W91c3tQmCTS87SLssV7Fs76k16FgoMduv5f80NjNMPwd874JkWh4iNDDEvi1Epe5egBF9tEC
	Pk29c1+HHG2kLql+b/J2d5qDpSra9DqP+8wiu9w==
X-Gm-Gg: ASbGncvlWQjaB32mmlmM9egJH+SYxDziGYb9lJgbzfjrIfqz5rewRwVDq3/zjClFbGy
	aJDO+thCT+vSEevR83T6IpKU/7FlMQIHJZv5V19aXAOp2xCsOMZ9StKOy7jy4f9XXxmU3zZYnKr
	5reFiKvYHI4TBKhbi9J+TO/zIwDW3HfMyi+PVQu/M=
X-Google-Smtp-Source: AGHT+IG6aW5Q3y/RnifIpaEjK5ULxNior0oiMNhU0YpdBqJfjRMwWIEcYmRkJPDhVpVmvt+kqwBSuw6+FqH3T0ivSDo=
X-Received: by 2002:a05:6820:610b:b0:602:2bd5:121c with SMTP id
 006d021491bc7-6022bd5268bmr902498eaf.3.1742476684008; Thu, 20 Mar 2025
 06:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-pinctrl-fltcon-suspend-v5-0-d98d5b271242@linaro.org>
 <20250312-pinctrl-fltcon-suspend-v5-2-d98d5b271242@linaro.org> <5ff8d26d-65bd-4b99-90b1-ae01f0ee9eb7@kernel.org>
In-Reply-To: <5ff8d26d-65bd-4b99-90b1-ae01f0ee9eb7@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 20 Mar 2025 13:17:53 +0000
X-Gm-Features: AQ5f1JrZuFp1AMZqE3M2XuIbs3bdr_wxjPoi_Wqa3MiIrQKNXKZzHtSEuRK2C30
Message-ID: <CADrjBPqPRR+yH=B_pSFNMTqqvQaHZPckw=OaeGZa34icb0WbFw@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] pinctrl: samsung: refactor drvdata suspend &
 resume callbacks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, jaewon02.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for the review feedback.

On Tue, 18 Mar 2025 at 19:47, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/03/2025 22:58, Peter Griffin wrote:
> > Move the call of drvdata->suspend()/resume into the loop which is
> > iterating drvdata for each bank.
>
>
> Side effect is that now each drvdata->suspend will be called before
> saving registers. Please mention it here and this lead me to one more
> comment.

Yes drvdata->suspend() gets called slightly earlier after this patch.
I can mention that in the commit message

>
> > This allows the clk_enable() and clk_disable() logic to be removed
>
>
> For suspend path - yes. For resume path - nothing changed, because
> drvdata->resume(drvdata) was called with clock enabled.

The clk_enable() / clk_disable() has been removed from both the
drvdata->suspend() and drvdata->resume() callbacks

>
> > from each callback, and also avoids iterating the same loop again
> > in the next function.
>
> ...
>
> > diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > index 963060920301ec90affb2ee6d758d3d602ffb4a9..375634d8cc79d6533603e3eed562452181e2ee25 100644
> > --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> > +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> > @@ -1349,6 +1349,9 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
> >               const u8 *widths = bank->type->fld_width;
> >               enum pincfg_type type;
> >
> > +             if (drvdata->suspend)
> > +                     drvdata->suspend(bank);
>
> Here suspend() is called before saving common register state (was
> *after*)...
>
> > +
> >               /* Registers without a powerdown config aren't lost */
> >               if (!widths[PINCFG_TYPE_CON_PDN])
> >                       continue;
> > @@ -1373,8 +1376,6 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
> >
> >       clk_disable(drvdata->pclk);
> >
> > -     if (drvdata->suspend)
> > -             drvdata->suspend(drvdata);
> >       if (drvdata->retention_ctrl && drvdata->retention_ctrl->enable)
> >               drvdata->retention_ctrl->enable(drvdata);
> >
> > @@ -1406,9 +1407,6 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
> >               return ret;
> >       }
> >
> > -     if (drvdata->resume)
> > -             drvdata->resume(drvdata);
> > -
> >       for (i = 0; i < drvdata->nr_banks; i++) {
> >               struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
> >               void __iomem *reg = bank->pctl_base + bank->pctl_offset;
> > @@ -1416,6 +1414,9 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
> >               const u8 *widths = bank->type->fld_width;
> >               enum pincfg_type type;
> >
> > +             if (drvdata->resume)
> > +                     drvdata->resume(bank);
>
> But this is not symmetrically reversed now - resume() is before
> restoring from saved state.
>
> Maybe this change is intentional, but then it should be expressed in
> commit msg and in commit why this was chosen.
>
> I guess you decided to do that way only because of code:
>         if (!widths[PINCFG_TYPE_CON_PDN])

Yes exactly it was the above line, and trying to avoid iterating the
loop a second time.

> This code should be symmetrically reversed, otherwise it just raises
> questions. For saving register state, it does not really matter, but in
> general if we assume driver-specific suspend callback is run the last,
> then driver-specific resume callback should be first, no?

As you say it's just saving/restoring some registers so I don't
believe the ordering matters. But if you would like it to be kept
symmetrically reversed I could switch back to calling it in almost the
same place as before this patch (just moving it a couple lines up
before the clk_disable() and iterate the loop again.

for (i = 0; i < drvdata->nr_banks; i++)
    drvdata->suspend(bank);

and similar for drvdata->resume(). Then the ordering should be exactly
the same as prior to this patch.

Thanks,

Peter

