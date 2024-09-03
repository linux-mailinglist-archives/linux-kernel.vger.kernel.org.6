Return-Path: <linux-kernel+bounces-313526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3A196A6AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B479A1F2474A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17934191F62;
	Tue,  3 Sep 2024 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTevbHlO"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AC515574F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725388621; cv=none; b=R6OLxK30MtbotD5SWMdpqzEOnGBq5GEPCaGYssfOaXE/E1RS2Mq2odiA7b2eIifJfwzZsDDEFLBGY9M0pn6PamhX/SEy3BW1V+A7d9iNL+WrQ/fHrVYLn46CABtDKYpAjyl7+HyhthFdzit410t51V6gqPNCrS2/59cs49Jj34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725388621; c=relaxed/simple;
	bh=iF1ve7zUvFd6IQgMpiZkAA8RIOFoGavKDQT5WLJeZgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=raMRk50U2SBPlBC2KjGFhJ9uBqwpRB0oUpFFfX6g+yBr9cXRQVn5t5MYRn+oT7RUkHazOJ5KO1r5qBFZnbuamiV/mCnz9EUyVv6BuH1bcpKiq9yJVBtBRUqIXWbM+BBqARVk5nFRw4tqvXJLYLgHzA/jhVDU4nb2rs9MJFe60Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eTevbHlO; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6d47d860fc4so31856627b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725388619; x=1725993419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4PquCzpBQxckopb5g2wFn+ZyjJzmKndGiHDxxGCGscU=;
        b=eTevbHlOPA9eOr2FTY9Jk9rZOGWDA8tHrWCED05K+gQS+x3M0Wt/63RAcOvABuGOgk
         +My/TbAuxHtLe3hOMwPw3iFWwLvK7lQwR+dbuefMCf6z1QZH4JXEDzF24+UBB74Apr+h
         bosgExVsgWWZE+9PCqTgc7v0KHILSJLogvJQrCOv/xcLitGTwJp8XDxSsZ7csV/MvGiq
         vMBaqOjVc2jG8QYtKMP4L4A11Zmp1QB5AvB1ujLQHnrQL1OlcnV2wT0hjSrx4Y908Ew2
         EICTaa6/YiuF1ANqiy68YPsdn4T95ePf0fmHzfLeGpbVNxsyL4eFZh3Kyq1zelHA3XAY
         lbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725388619; x=1725993419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PquCzpBQxckopb5g2wFn+ZyjJzmKndGiHDxxGCGscU=;
        b=KEGUwr4iQP/exnbsddAv/KHAkk3JJgOm070eo9M1TkdEV+qw6OivmG1LMXIjZCzeYT
         pT28CPu7wEg8PYgu1bUZb+nLAij3hNwEBsXd1Un8Ykwl1aDk+CnsifqjAzlb8YMhAFLy
         DfNwERCK0CrqSfumW2M9mAxsmFrmJnYbQ3Ru+7sxj5LOm1WGrKpz9C/hgHKEYF75/bYi
         cw1QqGLAg6QrOu3eRgINNC+YErvIRI2Lsr3J3AA4SzzIDT8AkPwhuPmaAA4aob2YpFPv
         vek/Zkc6WLaTOcrQrtkFj0TAsTzq0t2dYY2Dicrn/QVxAKZvoj9XmkSFUVIjX07X7r/2
         280A==
X-Forwarded-Encrypted: i=1; AJvYcCU6hTA/xmjYBOhAzxWs3kEH0lNDSLbg/E2ck1KPpp2E/A/mX26k6Y6h0+gB+KAhyY/QaJBVnbZUJzXwzi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6fiIXvGzeCf1PkVbqS2OD1hQDvNhGP4YX6oraRgC9WgC42wmJ
	ixQIlSFuClbSFxHWhldjocUtcqRyGShb8LrG0X92j5VwSN35baQHq5bJDXNKlgUPbYawAbs041K
	eQvxSS/tQxnkQqIAvoBXQwffOJCKgen2wEoK79Q==
X-Google-Smtp-Source: AGHT+IGbjJtekEa3t2dYJC8Xj6XtuDHK1yJ2uZ2mG3+kcU+1x1vZT7qFDeeeDqgkzze6gPZN9sUdsue1YPAlOjLXO2o=
X-Received: by 2002:a05:690c:112:b0:63b:d055:6a7f with SMTP id
 00721157ae682-6d40fc15df7mr151478767b3.38.1725388619041; Tue, 03 Sep 2024
 11:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903154533.101258-1-brgl@bgdev.pl> <20240903154533.101258-2-brgl@bgdev.pl>
 <Ztc4A0rZE3G1oHo7@smile.fi.intel.com> <Ztc4f3AOpppiL4Dt@smile.fi.intel.com>
In-Reply-To: <Ztc4f3AOpppiL4Dt@smile.fi.intel.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 3 Sep 2024 20:36:48 +0200
Message-ID: <CACMJSeu+OsDc7ZiQxxN5gbKaq4DSYsMPC7S_A=9eesiWrQPaGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mpc8xxx: switch to using DEFINE_RUNTIME_DEV_PM_OPS()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linus.walleij@linaro.org>, 
	Martyn Welch <martyn.welch@collabora.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Sept 2024 at 18:25, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, Sep 03, 2024 at 07:23:31PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 03, 2024 at 05:45:33PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/pm_runtime.h>
> >
> > You need pm.h as macros defined there.
>
> ...or both...
>

pm_runtime.h implies pm.h.

> > >  #include <linux/property.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spinlock.h>
>
> ...
>
> > > +static DEFINE_RUNTIME_DEV_PM_OPS(mpc8xx_pm_ops, mpc8xxx_suspend,
> > > +                            mpc8xxx_resume, NULL);
>
> This one comes from pm_runtime.h, but pm*_ptr() ones from pm.h.
>
> And it seems you wanted pm_ptr().
>

Yeah, I'm not sure really. The suspend and resume callbacks for
platform devices are not documented but it looks like they're only
used for system sleep. Martyn: which one do we actually need?

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>

