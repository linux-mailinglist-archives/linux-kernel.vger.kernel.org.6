Return-Path: <linux-kernel+bounces-530017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58959A42DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354E97A7A19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36296221F13;
	Mon, 24 Feb 2025 20:26:53 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F36B206F3E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428812; cv=none; b=UwNGEaSIiB88yidOx3JZzReAgNeoQeLTRO/v9r2P+uA09cRdJo4qjCpEs7OwhjPblt74EPmpA9nFaxakgYL0k425s/cLtpCDS512MQs2hYYIcXfbclRoqAqPRJHqOIP7Ga2I+itAutRwJNPzBff9TtdCe3k/hru2jDUd+Q6pBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428812; c=relaxed/simple;
	bh=lSOhfgM9aqjP7uFmcecoJ5HzRf8wsz0vaLN16X+Vsy8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxiTHYeaA2SzhsTsOiCQh06vi9AYPDQQFOftbNEfg/rP1bdaM/BIoh0DM8hS9E3PyevfrA+xXLNJncEonmGiit0Lr1F0M1aO6cik7vaM5C0UCCsxf6wxdb3xRmSb0O6ueu5wfWzIu9YLcC1QoQYcbkqvAsbGb4hh9eC6JcUjn6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 80914f8f-f2ed-11ef-9d7a-005056bd6ce9;
	Mon, 24 Feb 2025 22:25:35 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 24 Feb 2025 22:25:34 +0200
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 8/8] gpiolib: sanitize the return value of
 gpio_chip::get_direction()
Message-ID: <Z7zVvgcEeWnYr9vZ@surfacebook.localdomain>
References: <20250210-gpio-sanitize-retvals-v1-0-12ea88506cb2@linaro.org>
 <20250210-gpio-sanitize-retvals-v1-8-12ea88506cb2@linaro.org>
 <Z7yfTggRrk3K6srs@black.fi.intel.com>
 <CAMRc=Md-bMUEKgF7srLFqwdetDcTDB-0YzrisccQmReDs-Ndvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md-bMUEKgF7srLFqwdetDcTDB-0YzrisccQmReDs-Ndvg@mail.gmail.com>

Mon, Feb 24, 2025 at 08:55:26PM +0100, Bartosz Golaszewski kirjoitti:
> On Mon, Feb 24, 2025 at 5:33 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Mon, Feb 10, 2025 at 11:52:02AM +0100, Bartosz Golaszewski wrote:

...

> > > +static int gpiochip_get_direction(struct gpio_chip *gc, unsigned int offset)
> > > +{
> > > +     int ret;
> > > +
> > > +     lockdep_assert_held(&gc->gpiodev->srcu);
> > > +
> > > +     if (WARN_ON(!gc->get_direction))
> > > +             return -EOPNOTSUPP;
> > > +
> > > +     ret = gc->get_direction(gc, offset);
> > > +     if (ret > 1)
> >
> > Would it be better to use the respective GPIO*... macro instead of 1?
> >
> 
> I did consider it but I don't like comparing against enums, it doesn't
> feel right as the value behind the name can change. I think I prefer
> it like this even if it's not the best solution either. Maybe we could
> be more explicit and say:
> 
>     if (!(ret == IN || ret == OUT || ret < 0)
> 
> ?

Yep, I like this.

-- 
With Best Regards,
Andy Shevchenko



