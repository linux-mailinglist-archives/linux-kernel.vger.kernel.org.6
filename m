Return-Path: <linux-kernel+bounces-206707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8BA900CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F5428A416
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B61552ED;
	Fri,  7 Jun 2024 20:29:22 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0114E2FF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792161; cv=none; b=X5XOyAbu+d9VTX8OOJkbkPO60Rf4uonyYx/81RzaaZGWAr/wehhMNezrovEgl7T/sKeqoaVfpHqEA0bhhCNStnTM1JRQX6KhCn1KZAFyCbALMutpBjJY2ysHTk8sGiAKcZzjB+JRo/oqRI8MmJW/2JoPUxigDNz2nps6mtY7D9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792161; c=relaxed/simple;
	bh=LWkQbRGo51GW+7l4ahN+J4VoJhN2gJmJSiGsH0bZP28=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSaETWvg+JYfG3nd/ncSg8+XcQ6ki0ume90HdyfsgI3x30rwgJpnaSKscJWLOjpX1mjP0wQ85UxahPpGJ8tw0iyXogwvDWn9g1L0tiSC2Rael9dzHjLjbp3Bkcza6HketS6/fBhcHDNmsnFJyhz88Q7MPKxtOwgvYGVlrQv2AKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id 99337689-250c-11ef-ab0a-005056bdd08f;
	Fri, 07 Jun 2024 23:29:11 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Jun 2024 23:29:10 +0300
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	naresh.solanki@9elements.com, broonie@kernel.org,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pinctrl: cy8c95x0: Use regmap ranges
Message-ID: <ZmNtllmSoOGiikel@surfacebook.localdomain>
References: <20240521152602.1097764-1-patrick.rudolph@9elements.com>
 <20240521152602.1097764-2-patrick.rudolph@9elements.com>
 <CAHp75VcYZCr=N_3YNe4kO1Vm95mJcxV4dKkBEz-NqXzumzXa1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcYZCr=N_3YNe4kO1Vm95mJcxV4dKkBEz-NqXzumzXa1w@mail.gmail.com>

Tue, May 21, 2024 at 08:34:18PM +0300, Andy Shevchenko kirjoitti:
> On Tue, May 21, 2024 at 6:26 PM Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Instead of implementing a custom register paging mechanism in
> > the driver use the existing regmap ranges feature.
> 
> driver, use

...

> > +static const struct regmap_range_cfg cy8c95x0_ranges[] = {
> > +       {
> > +               .range_min = CY8C95X0_VIRTUAL,
> > +               .range_max = 0,         /* Updated at runtime */
> 
> This and similar comments are misleading since the data is defined as
> const. Updated --> Filled or alike here and elsewhere.
> 
> > +               .selector_reg = CY8C95X0_PORTSEL,
> > +               .selector_mask = 0x07,
> > +               .selector_shift = 0x0,
> > +               .window_start = CY8C95X0_INTMASK,
> > +               .window_len = MUXED_STRIDE,
> > +       }
> >  };

...

> > +                       regcache_cache_only(chip->regmap, true);
> > +                       regmap_update_bits(chip->regmap, off, mask & val, 0);
> > +                       regcache_cache_only(chip->regmap, false);
> 
> A side note: It's strange to see mask & val, 0 in the parameters of
> regmap calls. Perhaps refactor this (in a separate patch) to use
> standard approach?

...

> > +       memcpy(&regmap_range_conf, &cy8c95x0_ranges[0], sizeof(regmap_range_conf));
> 
>        memcpy(&regmap_range_conf, cy8c95x0_ranges, sizeof(regmap_range_conf));

I hope the all above can be tweaked by Linus when applying.

...

> Note, if you are not using --histogram diff algo, please start using
> it from the next version of this series.
> 
> P.S. I will test the next version on Intel Galileo Gen1 as currently I
> have some issues with the HW I need to fix first.

Unfortunately I wasn't able to ressurect the HW and now I'm going to be off for
a while. Let's go with this and if any problem appears, I probably can try to
fix myself.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



