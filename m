Return-Path: <linux-kernel+bounces-248664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2945392E05C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5D61F221C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2592812EBC7;
	Thu, 11 Jul 2024 06:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Yv0ln3Ci"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9612D752
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720680945; cv=none; b=O8EmxcqpbZmdv4yQ70X17KjkMhVdOI0n+sGaerBR3ppOhQ3mHUhFo24ieOipNLjpdgA/cwVqjNt84nECD6AODdBP1zbMEADLwHMeAz67H0Bbx5f8y+/bA7BlWPdERQt/iaWlobkiP+Cx6NbAKQoe0tdYaVxdr6sQy8hWedh2hxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720680945; c=relaxed/simple;
	bh=iEJSZWwibei49W28C7OkAYWo9n7vnO08kdlEvcJpxGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0WZPHAmyUZHrXJApC0t3AMrykCR2J0PNtpvV1tdu8vihPTNGlY6KcoL2Z3B50XlkQitMqo8jDcwfW+rcbE4/b5Km3Fedghe/W8RuByNA2iT+S9ggKCA/4zzDgfO1kFOo0HWupMBaG3CIwjTLbyvQSazz/pvZdD0u1HVJCO6wpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Yv0ln3Ci; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb8781ef1bso4159385ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1720680941; x=1721285741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qj5fKPvxGvM7Ufw7p7EXOjC4sCCpwaohueruAgBqnWk=;
        b=Yv0ln3Ci4lEz8nKwr+OyTAlWn28+KXzI8JSsx4OuGvK5iJ/T5ZzI7OSFux4IacNoyi
         PEmvmGHac29c8q9QSD2AFtW2O8IBdwkPKQnNKqDM99/Bazat/E6RmKEfwz8CNLy+jq22
         tmskqk0LNQVjAsPC1iyd1haMA8xvrdzQnbAWaeZ/3rq7oTQ36TdcvfefTdLqlv9sBcYB
         LECQxRAGMHekhZtNObI2n7SYNhF11+CG8P9ipCoLnGSEzR6AD+waTur4D6D0Xu7sYRXG
         FaDNcUDyluhOAfi2xXhieURzUMkt9cimVdEyjUuU2fjQlpytiQ7TAxhyK0/z/taaLOnd
         wYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720680941; x=1721285741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qj5fKPvxGvM7Ufw7p7EXOjC4sCCpwaohueruAgBqnWk=;
        b=IhfieXGsS2139b6DqAPbrRsKxnA34q2zGTewtdoK41/BptvpAg+0iecRehChDGEduE
         TekD5vGjlYS3rsy2d8xNjrIimdhSniLqjZcsaG3kVliBC66Q1wxxYOGhXatpDBnGEr4W
         3nIPR9DaGnCMzAZHOOIagNVJRnWKh+Jwh3DzWSb/ZqU0YNby6SQlx/RMsNGUnlsRHnZu
         WCWpxR/VFr38YjQAC9bUsSRQA7q2LI39Vf3xamCS4DO+zztqjQDLrj8ZDGqEk1PqWLkO
         kGjHw9rYMntqexjeatUTtzzyaQM1/hj/amKJCv0/K70MF5x3iTDCwRbgXJ3xD9+NY19X
         0Szg==
X-Forwarded-Encrypted: i=1; AJvYcCWGbksI3ER5bLWjTGkNRYqKQp61DCDvqLfIkAz9VyFjDRzPXWlLzRaiwLuknZuQyVTXTIYF6H8NVodlclZQa+J/aWGe4qvgtD8BTMqH
X-Gm-Message-State: AOJu0YwuALOMP+zxjNziQb34nQoVs5wKuroT11qIj1zFIGO9lAo1tUZl
	dtc04BEmcHKwVZWqToPT6W6jbNn+hePO6lQwg125ZE3D+VFGy6Zr/kjBpBf3dYo=
X-Google-Smtp-Source: AGHT+IGb4ybc/OK3k0d6iCqvD55Ro9+I1kKUFnh6M3hL2RGrJ7WIIrCEMAeRoySTG0NPFBmMi9Af/g==
X-Received: by 2002:a17:902:e2c5:b0:1fb:64da:b13a with SMTP id d9443c01a7336-1fbb6ec5f62mr49719405ad.59.1720680941493;
        Wed, 10 Jul 2024 23:55:41 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:5ee9:fea0:d9de:cee8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11a4csm43497305ad.15.2024.07.10.23.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 23:55:41 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:55:39 -0700
From: Drew Fustini <dfustini@tenstorrent.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Fu Wei <wefu@redhat.com>, Guo Ren <guoren@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] clk: thead: Add support for T-Head TH1520
 AP_SUBSYS clocks
Message-ID: <Zo+B6yzFwRwSkPpH@x1>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
 <20240623-th1520-clk-v2-2-ad8d6432d9fb@tenstorrent.com>
 <d36ff27b56b3e9c8ef490bfd9d24761d.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d36ff27b56b3e9c8ef490bfd9d24761d.sboyd@kernel.org>

On Wed, Jul 10, 2024 at 04:17:12PM -0700, Stephen Boyd wrote:
> Quoting Drew Fustini (2024-06-23 19:12:32)
> > diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
> > new file mode 100644
> > index 000000000000..982d4d40f783
> > --- /dev/null
> > +++ b/drivers/clk/thead/clk-th1520-ap.c
> > @@ -0,0 +1,1086 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
> > + * Copyright (C) 2023 Vivo Communication Technology Co. Ltd.
> > + *  Authors: Yangtao Li <frank.li@vivo.com>
> > + */
> > +
> > +#include <dt-bindings/clock/thead,th1520-clk-ap.h>
> 
> Preferably include dt-bindings after linux includes.

Okay, I will move it.

> 
> > +#include <linux/bitfield.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +
> > +#define TH1520_PLL_POSTDIV2    GENMASK(26, 24)
> > +#define TH1520_PLL_POSTDIV1    GENMASK(22, 20)
> > +#define TH1520_PLL_FBDIV       GENMASK(19, 8)
> > +#define TH1520_PLL_REFDIV      GENMASK(5, 0)
> > +#define TH1520_PLL_BYPASS      BIT(30)
> > +#define TH1520_PLL_DSMPD       BIT(24)
> > +#define TH1520_PLL_FRAC                GENMASK(23, 0)
> > +#define TH1520_PLL_FRAC_BITS    24
> [...]
> > +
> > +static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
> > +                                               unsigned long parent_rate)
> > +{
> > +       struct ccu_pll *pll = hw_to_ccu_pll(hw);
> > +       unsigned long div, mul, frac, rate = parent_rate;
> > +       unsigned int cfg0, cfg1;
> > +
> > +       regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
> > +       regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
> > +
> > +       mul = FIELD_GET(TH1520_PLL_FBDIV, cfg0);
> > +       div = FIELD_GET(TH1520_PLL_REFDIV, cfg0);
> > +       if (!(cfg1 & TH1520_PLL_DSMPD)) {
> > +               mul <<= TH1520_PLL_FRAC_BITS;
> > +               frac = FIELD_GET(TH1520_PLL_FRAC, cfg1);
> > +               mul += frac;
> > +               div <<= TH1520_PLL_FRAC_BITS;
> > +       }
> > +       rate = parent_rate * mul;
> > +       do_div(rate, div);
> 
> 'rate' is only unsigned long, so do_div() isn't needed here. Perhaps if
> 'parent_rate * mul' can overflow 32-bits then 'rate' should be
> u64.

Thanks for pointing that out. I will make 'rate' u64 as I believe
'parent_rate * mul' could overflow:

The ref clock for all the PLLs on this SoC is intended to be 24 MHz
(section 4.3.2 PLL Resources [1]). Thus it is expected that parent_rate
will use 24 bits.

'mul' is set to TH1520_PLL_FBDIV which is 12 bits. In DSMPD mode, 'mul'
gets shifted left by TH1520_PLL_FRAC_BITS which is 24 bits.

> > +       return rate;
> > +}
> > +
> > +static unsigned long th1520_pll_postdiv_recalc_rate(struct clk_hw *hw,
> > +                                                   unsigned long parent_rate)
> > +{
> > +       struct ccu_pll *pll = hw_to_ccu_pll(hw);
> > +       unsigned long rate = parent_rate;
> > +       unsigned int cfg0, cfg1;
> > +
> > +       regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
> > +       regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
> > +
> > +       if (cfg1 & TH1520_PLL_BYPASS)
> > +               return rate;
> > +
> > +       do_div(rate, FIELD_GET(TH1520_PLL_POSTDIV1, cfg0) *
> 
> Same, 'rate' is unsigned long. Did you get some compilation error
> without this? How big is the divisor going to be? The fields are only
> 3-bits wide, so the multiplication would fit into a u32 just fine. Given
> that 'rate' is unsigned long though I think you can just put the
> multiplication result into a local variable that's also unsigned long
> and then just write the divide with unsigned longs
> 
> 	div = FIELD_GET(...) * FIELD_GET(...);
> 
> 	return rate / div;

I didn't get any compiler errors. I had copied do_div() from another
driver that I was looking at.

You are right that TH1520_PLL_POSTDIV1 and TH1520_PLL_POSTDIV2 are both
just 3 bits each. Thus I think the maximum divisor is 64. I'll change
to the simpler "rate / div" that you suggest.

> > +                    FIELD_GET(TH1520_PLL_POSTDIV2, cfg0));
> > +
> > +       return rate;
> > +}
> > +
> > +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> > +                                        unsigned long parent_rate)
> > +{
> > +       unsigned long rate = parent_rate;
> > +
> > +       rate = th1520_pll_vco_recalc_rate(hw, rate);
> > +       rate = th1520_pll_postdiv_recalc_rate(hw, rate);
> > +
> > +       return rate;
> > +}
> 
> Please fold this in

Will do.

Thanks for the review,
Drew

[1] https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

