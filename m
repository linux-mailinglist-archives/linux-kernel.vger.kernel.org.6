Return-Path: <linux-kernel+bounces-572767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB1A6CE7B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 10:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5A331891E63
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4BA202C50;
	Sun, 23 Mar 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="YB0GOurS";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="NCQDlCUc"
Received: from bayard.4d2.org (bayard.4d2.org [155.254.16.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7113AA20;
	Sun, 23 Mar 2025 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.254.16.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742721266; cv=none; b=AeXCZ0akPDnE0zC39bPqALr/r8tNVkRnlwWnklssEadoVfy9GBBxDs04WlyiQSQcVts9aTBQg/xVk6mtn2e/BvRbIOKnFimQ3V6PoIvOb8G1WgXyyRO3CPZE+0yOBxKhOTG5bYHZZS5MViJUEx1amKF3qP5RePlu0kuTi/oqSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742721266; c=relaxed/simple;
	bh=42KjRZG4Ec7xBTXyyzIFb+83EFkreEJzD1byDRrYTvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0hOl+XMybScDYl9F3qb9YsjrnE+0K9Y2XgvIEsQEsFvttr2dfY9+Q6K0fkdeBHizgOF/NvhLMxeJ86N+Yct9fTfStxW/gToYtL3YT9pJA6MhPiqE31kZxssBfFXbPjzj8CJM9gvUqe6qJI3dIIiCCD6JJn24JrSDlgw5kd/5x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=YB0GOurS; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=NCQDlCUc; arc=none smtp.client-ip=155.254.16.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id 67FEEEC59F1;
	Sun, 23 Mar 2025 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1742720143; bh=42KjRZG4Ec7xBTXyyzIFb+83EFkreEJzD1byDRrYTvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YB0GOurS6e7ntM1c3szslhrVmNfTs29qW3DmV+4LusNNm/ZbyPsW22qezs41sbOmi
	 Ny4wYzkogpnaK/lDgdomhH262gh1l0gCMIKIeH9v/0zD3Eq7NTZ9XbIUi9i3vB5wvt
	 UYbntCXgGgr/w2Y4lkeATFRgAD/zQr9PbYURbHuZO66z8MQwrfluHDwgzqis3RLRb9
	 FdsrvWv6O9MSbWvEO8y1YS/kTw4A+T7UDqVWlM+7krZn8dYOPd9R7DCnGN9Ct/rtfo
	 scuWnLfZ1ycbhEbCyyZFHKC7Jb44vmqFqKcpyUlw6HPaEjZGuFzNkOpP2XXX7L5ZS3
	 hnHNxcqmvj/Dw==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cxXVrxWgCf42; Sun, 23 Mar 2025 01:55:40 -0700 (PDT)
Received: from ketchup (unknown [183.217.80.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 58C7DEC59EE;
	Sun, 23 Mar 2025 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1742720140; bh=42KjRZG4Ec7xBTXyyzIFb+83EFkreEJzD1byDRrYTvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCQDlCUcrc4vhN8OBM1cEf/Rw4Catjgu4eGkIeUvAN8bFaEzI8TBhnHzzvDGmYclf
	 PPhmMpX7zIrmDfxICl/VQ0B2nMb+X4LzAEslEZga5vKaLZoHyMXO5ivn3K+UgTpiTN
	 kGiit+2e9HxwtIs4sXD8doRmPzhC9bWR7jfIF/yjCiJLaGHOh+JGH7FYHuwPv9xeBO
	 4st5JpY68yfbJuljaEgSgQYJ4okfB/DfuMO5QpKLrXt5DgkFh+6tfS6RtAcoL30Sz4
	 TN6tvJ1SYgWkY0fOb88bQy/kPUo7mj/nO2rxj0xpcIVKRM+IaOAxEkX9968uLu0Oq8
	 sWkVC4OpSoTEQ==
Date: Sun, 23 Mar 2025 08:55:28 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Inochi Amaoto <inochiama@gmail.com>, Yixun Lan <dlan@gentoo.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <Z9_MgAZE53eQ-FV8@ketchup>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
 <20250318053736-GYA2516@gentoo>
 <xwo2jjqy634z4rimgyrbjmxlgzxzauxmqzl57qr5oasph74qwj@7we45fnhwfzh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xwo2jjqy634z4rimgyrbjmxlgzxzauxmqzl57qr5oasph74qwj@7we45fnhwfzh>

On Tue, Mar 18, 2025 at 01:43:52PM +0800, Inochi Amaoto wrote:
> On Tue, Mar 18, 2025 at 05:37:36AM +0000, Yixun Lan wrote:
> > Hi Haylen Chu:
> > 
> > On 17:57 Thu 06 Mar     , Haylen Chu wrote:
> > > The clock tree of K1 SoC contains three main types of clock hardware
> > > (PLL/DDN/MIX) and has control registers split into several multifunction
> > > devices: APBS (PLLs), MPMU, APBC and APMU.
> > > 
> > > All register operations are done through regmap to ensure atomiciy
> > > between concurrent operations of clock driver and reset,
> > > power-domain driver that will be introduced in the future.
> > > 
> > > Signed-off-by: Haylen Chu <heylenay@4d2.org>
> > > ---
> > >  drivers/clk/Kconfig               |    1 +
> > >  drivers/clk/Makefile              |    1 +
> > >  drivers/clk/spacemit/Kconfig      |   20 +
> > >  drivers/clk/spacemit/Makefile     |    5 +
> > >  drivers/clk/spacemit/ccu-k1.c     | 1714 +++++++++++++++++++++++++++++
> > >  drivers/clk/spacemit/ccu_common.h |   47 +
> > >  drivers/clk/spacemit/ccu_ddn.c    |   80 ++
> > >  drivers/clk/spacemit/ccu_ddn.h    |   48 +
> > >  drivers/clk/spacemit/ccu_mix.c    |  284 +++++
> > >  drivers/clk/spacemit/ccu_mix.h    |  246 +++++
> > >  drivers/clk/spacemit/ccu_pll.c    |  146 +++
> > >  drivers/clk/spacemit/ccu_pll.h    |   76 ++
> > >  12 files changed, 2668 insertions(+)
> > >  create mode 100644 drivers/clk/spacemit/Kconfig
> > >  create mode 100644 drivers/clk/spacemit/Makefile
> > >  create mode 100644 drivers/clk/spacemit/ccu-k1.c
> > >  create mode 100644 drivers/clk/spacemit/ccu_common.h
> > >  create mode 100644 drivers/clk/spacemit/ccu_ddn.c
> > >  create mode 100644 drivers/clk/spacemit/ccu_ddn.h
> > >  create mode 100644 drivers/clk/spacemit/ccu_mix.c
> > >  create mode 100644 drivers/clk/spacemit/ccu_mix.h
> > >  create mode 100644 drivers/clk/spacemit/ccu_pll.c
> > >  create mode 100644 drivers/clk/spacemit/ccu_pll.h
> > > 
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index 713573b6c86c..19c1ed280fd7 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -517,6 +517,7 @@ source "drivers/clk/samsung/Kconfig"
> > >  source "drivers/clk/sifive/Kconfig"
> > >  source "drivers/clk/socfpga/Kconfig"
> > >  source "drivers/clk/sophgo/Kconfig"
> > > +source "drivers/clk/spacemit/Kconfig"
> > >  source "drivers/clk/sprd/Kconfig"
> > >  source "drivers/clk/starfive/Kconfig"
> > >  source "drivers/clk/sunxi/Kconfig"
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > index bf4bd45adc3a..42867cd37c33 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -145,6 +145,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
> > >  obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
> > >  obj-y					+= socfpga/
> > >  obj-y					+= sophgo/
> > > +obj-y					+= spacemit/
> > >  obj-$(CONFIG_PLAT_SPEAR)		+= spear/
> > >  obj-y					+= sprd/
> > >  obj-$(CONFIG_ARCH_STI)			+= st/
> > > diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
> > > new file mode 100644
> > > index 000000000000..76090cd85668
> > > --- /dev/null
> > > +++ b/drivers/clk/spacemit/Kconfig
> > > @@ -0,0 +1,20 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +

Hi Inochi, Yixun,

> > > +config SPACEMIT_CCU
> > > +	tristate "Clock support for Spacemit SoCs"
> > > +	default y
> > similar reason to pinctrl with these patches [1], [2]
> > I'd suggest switch to "bool + default ARCH_SPACEMIT" 
> > 
> > Link: https://lore.kernel.org/all/20250218-k1-pinctrl-option-v3-1-36e031e0da1b@gentoo.org [1]
> > Link: https://lore.kernel.org/all/6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be [2]
> > 
> 
> Clk subsystem prefers no defalt and set it in defconfig,
> so should no default there.

Thanks for these hints, I will drop default and set the configuration in
defconfig, in which case it seems okay to keep it as bool.

> Regards,
> Inochi

Thanks,
Haylen Chu

