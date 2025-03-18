Return-Path: <linux-kernel+bounces-565505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A99A669BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD4A3BB44A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FB1DE4E6;
	Tue, 18 Mar 2025 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldEo9dEg"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB591DE3BE;
	Tue, 18 Mar 2025 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276651; cv=none; b=nCrgRT45bBWIYhEiAXf9uI4eYp/q3c1R7WCcJZhmvGpNyOIUt6PwautateW84yF3cifJsIxpkW6WZk1zSyT/IMEC6qBjeitr1zba95FyzgcznZNXc+cg2pO2I5op0lf+AJAqsH7xPXBTySacRd/tO9OeEBwgvqDHaNYTnfouKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276651; c=relaxed/simple;
	bh=T8pUQSZ6nXVl1MPwVY3xpS3rfghdPQEDEwopbbkvAfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2gXGyGyKxs+DlTWigfHbJLyRlhqq0k9P93V26V5hFN/9UCMCyp6Fm2jn7BlNua/ucMcNkKbYrfdLNR7bjfGv79AlGsOeJ+bcRLMbRCQnAEgylHTkrJa45KkBvPD/Swyu1TvjgjeI4jlo+0i/uCEDGtr9UDxqheRSI1+SbaaJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldEo9dEg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e41e17645dso47029666d6.2;
        Mon, 17 Mar 2025 22:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742276648; x=1742881448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwFdLf1c7kbfx/fdwSi1PJ2VuLIMc4Zv90ArV+gVLqE=;
        b=ldEo9dEgE5DjX2Hxt2GIy3ge9WWvTmNEWylfyCRMxPLNsCyyyQT/rCu4Q6Xn6HRAkG
         /Y2DW5W/W/1n+x9TkAJ2vvrU6vZOE/FnOfxTWTO7JoIDHOuMVlRMG7BbpNvR5mBI9R5W
         JSnxvUu+Bj71owEJugdYXT3WtDWTHX5SntwKWC1xFzMnzeDrrd0gxduOlIXCdS+vqhsP
         yqwlDXBr1zBviGveoiuh1GBZ/V4IhJGrWGiSPgcD77zhSep5N5XqqTBL7sOtZvibekXJ
         MbvcED5PXtM/otW58RGSHAZ+AW4ve07Z7MHpC2hioT4DVSoAOg8DVyyA5RekNtTlVzMC
         OKEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742276648; x=1742881448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwFdLf1c7kbfx/fdwSi1PJ2VuLIMc4Zv90ArV+gVLqE=;
        b=CLPphoHxgeePBWugH7mOtGr6dq1iGrLHu4EHO7HqdSw6O337ShgXQLHdzgTEHzHUhm
         NnVgUU5MW89k+aN/vy16kUVHmTTr8pGTwAMZNnUj7GFRmRxHWidEt1RyrukhPBsq2JIz
         OVtQ33lYkSSHIpiZ62xzT09TcylKNjlvyHozU68pyOEoD9UyAjalKZHCgs9Y29wcDtBu
         MNDZdJSz/V/hSbzqC20HTyyq68VGHV9FIQNS91eRaYg+n164eRSJBDCPQeCWEjvKjkAD
         AoiWIlqw3HAmFayrJHR3LitHwGhMcvWZkreq9h/YC8C4bfdRtaCnL52pGR3rE1XnrU77
         4tVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+LuvpU/ITIQzzM1DeRn2oKCaaRACmBdzhVyCwQw7XCMGEwu9F/4ywdWwo+I3qlljSh8Gbsn9L9HV7Ag8W@vger.kernel.org, AJvYcCUOADQIM1HmStN7rhfd91EcKWYLuZ9oCO0vdY6RczKn94Z8clHSqgbmBsQ/1AUMFEIwhbNzFW+03Gqa@vger.kernel.org, AJvYcCXAqcDrHuV4NMp+k9HDOh9J1zNoaF5yPaoWStWP3gg43KtHT5IDxwfwAeCkQe3AYWP5FYQasCD7F9HZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyIN5MKHzC/lfIEbdI6yLniPgX1qN0nyTLLMix1tITUiEqjJxQR
	c7WIVk6yIxoc/97McEXyjxoqcxQEbUHCvtf3wlTD3jEFYfB1rqHR
X-Gm-Gg: ASbGncvUb/eFwrO2YjlW/T5EG5dsKzvxhqCZ78hDNpnMrJi9bjK2xiJe8UAoSmZJhzN
	8MDo7ByTg98ZiQRR8qZFbsys9bwtPcOAYtfq+BdYoeM4dwb0MwEjjHvkmlpsk+MDnOWrG/FmcbH
	6uEgUep7kLm7smK79Van7Y06Ikvo58vlIQe7hMhrYjhfwwTLE+NroTzx25kkwTLrIZ9tZfinmyl
	lf6nRDYxYznrenXMXb9QrD4zXAmPw3ZnwA0t/CidV0t5jOS705+mFq6X2VQ2eNqdi+fm1fOJp4Q
	nUgzyCMXZ+vmDu+rrMo45UXbJQGNRUo=
X-Google-Smtp-Source: AGHT+IGuMQhkzUcBs7MzT4DYgtuD7a9Q+hOatvcVV/vkg2Yr9NtbNUqUpAe6FnTc1MisRqrMXkfHwA==
X-Received: by 2002:ad4:5d65:0:b0:6e8:e8dd:30d1 with SMTP id 6a1803df08f44-6eaeaa5fa9amr264171126d6.22.1742276648364;
        Mon, 17 Mar 2025 22:44:08 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eade231bcbsm63413776d6.36.2025.03.17.22.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 22:44:07 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:43:52 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Yixun Lan <dlan@gentoo.org>, Haylen Chu <heylenay@4d2.org>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <xwo2jjqy634z4rimgyrbjmxlgzxzauxmqzl57qr5oasph74qwj@7we45fnhwfzh>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
 <20250318053736-GYA2516@gentoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318053736-GYA2516@gentoo>

On Tue, Mar 18, 2025 at 05:37:36AM +0000, Yixun Lan wrote:
> Hi Haylen Chu:
> 
> On 17:57 Thu 06 Mar     , Haylen Chu wrote:
> > The clock tree of K1 SoC contains three main types of clock hardware
> > (PLL/DDN/MIX) and has control registers split into several multifunction
> > devices: APBS (PLLs), MPMU, APBC and APMU.
> > 
> > All register operations are done through regmap to ensure atomiciy
> > between concurrent operations of clock driver and reset,
> > power-domain driver that will be introduced in the future.
> > 
> > Signed-off-by: Haylen Chu <heylenay@4d2.org>
> > ---
> >  drivers/clk/Kconfig               |    1 +
> >  drivers/clk/Makefile              |    1 +
> >  drivers/clk/spacemit/Kconfig      |   20 +
> >  drivers/clk/spacemit/Makefile     |    5 +
> >  drivers/clk/spacemit/ccu-k1.c     | 1714 +++++++++++++++++++++++++++++
> >  drivers/clk/spacemit/ccu_common.h |   47 +
> >  drivers/clk/spacemit/ccu_ddn.c    |   80 ++
> >  drivers/clk/spacemit/ccu_ddn.h    |   48 +
> >  drivers/clk/spacemit/ccu_mix.c    |  284 +++++
> >  drivers/clk/spacemit/ccu_mix.h    |  246 +++++
> >  drivers/clk/spacemit/ccu_pll.c    |  146 +++
> >  drivers/clk/spacemit/ccu_pll.h    |   76 ++
> >  12 files changed, 2668 insertions(+)
> >  create mode 100644 drivers/clk/spacemit/Kconfig
> >  create mode 100644 drivers/clk/spacemit/Makefile
> >  create mode 100644 drivers/clk/spacemit/ccu-k1.c
> >  create mode 100644 drivers/clk/spacemit/ccu_common.h
> >  create mode 100644 drivers/clk/spacemit/ccu_ddn.c
> >  create mode 100644 drivers/clk/spacemit/ccu_ddn.h
> >  create mode 100644 drivers/clk/spacemit/ccu_mix.c
> >  create mode 100644 drivers/clk/spacemit/ccu_mix.h
> >  create mode 100644 drivers/clk/spacemit/ccu_pll.c
> >  create mode 100644 drivers/clk/spacemit/ccu_pll.h
> > 
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 713573b6c86c..19c1ed280fd7 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -517,6 +517,7 @@ source "drivers/clk/samsung/Kconfig"
> >  source "drivers/clk/sifive/Kconfig"
> >  source "drivers/clk/socfpga/Kconfig"
> >  source "drivers/clk/sophgo/Kconfig"
> > +source "drivers/clk/spacemit/Kconfig"
> >  source "drivers/clk/sprd/Kconfig"
> >  source "drivers/clk/starfive/Kconfig"
> >  source "drivers/clk/sunxi/Kconfig"
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index bf4bd45adc3a..42867cd37c33 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -145,6 +145,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
> >  obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
> >  obj-y					+= socfpga/
> >  obj-y					+= sophgo/
> > +obj-y					+= spacemit/
> >  obj-$(CONFIG_PLAT_SPEAR)		+= spear/
> >  obj-y					+= sprd/
> >  obj-$(CONFIG_ARCH_STI)			+= st/
> > diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
> > new file mode 100644
> > index 000000000000..76090cd85668
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/Kconfig
> > @@ -0,0 +1,20 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config SPACEMIT_CCU
> > +	tristate "Clock support for Spacemit SoCs"
> > +	default y
> similar reason to pinctrl with these patches [1], [2]
> I'd suggest switch to "bool + default ARCH_SPACEMIT" 
> 
> Link: https://lore.kernel.org/all/20250218-k1-pinctrl-option-v3-1-36e031e0da1b@gentoo.org [1]
> Link: https://lore.kernel.org/all/6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be [2]
> 

Clk subsystem prefers no defalt and set it in defconfig,
so should no default there.

Regards,
Inochi

