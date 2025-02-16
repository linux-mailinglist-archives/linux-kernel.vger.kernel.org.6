Return-Path: <linux-kernel+bounces-516557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18400A373FD
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 12:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AA0168A7C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078818DB3B;
	Sun, 16 Feb 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="uB8DTAFs";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="H/8tFOw4"
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D213D897;
	Sun, 16 Feb 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739705680; cv=none; b=HFzL5uRf2pUG5E7t3eheTrOkGIenwNCqufon0XWLBT8IoeZ1pl0bi10pLMLnLYbBljO7fY4tQ6AvzgmyHMCJPMjtdsxNOozDD7rI5ObkH5bJZyE6szQd01is86oZgDj6+jD/mBn/syx/jyyp6RB1ViwWfIPrIdBOAXQYip/V5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739705680; c=relaxed/simple;
	bh=EazINzQbX2CZ3H/iPWJJj9tTMbi2UPooj82nJP8Z4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFBuyV9pQUmIjFNBPWvPXF0+qeNaYtfcxa+ueYJHUI/H6bwHco+cfHe5ffNdtzhddoVvgNsjsAv+w1mvkcN+HZgoYE5r0Bf8sRpH2kl9Vu40djn60FUPvRo//5mDopPS/5mMG/VoHpj+PeSlCsIGdh169owEvwj8Df96bIMS3Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=uB8DTAFs; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=H/8tFOw4; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id A6A04122FE5F;
	Sun, 16 Feb 2025 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1739705666; bh=EazINzQbX2CZ3H/iPWJJj9tTMbi2UPooj82nJP8Z4gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uB8DTAFsIpEI4YygldC8IGVga1ks3xu/vLiU8Hkjd1XJjRwuO2fgv2TOk5rQHYQ8z
	 +0Q0RAchmL3vq5dXFn7r7IoDTC1t64C27QS6926Y7KkPLD+Yqn5kQIP7/E6xtRXDz4
	 eeaNClrInfeAbCLz/i2AEJcwTCoaH0oWZZ8Hsnc/UtgrqgMbnsV6UGwkhEn3aQRgHQ
	 mAC8JoPKDuAgxqbYA1smwRobVkGzrsfdC5B/blFV2o+fe37is7lS0ndUZ+LqmPZ1F6
	 ziacgRhu7YjNBMrVkPPoQFJsY2HRDtaUyQLvaZreqPtsHl+9STyeoIT7clzumpVFNp
	 OhTykFeycyTrg==
X-Virus-Scanned: amavisd-new at 4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id okFk24t49Wqc; Sun, 16 Feb 2025 03:34:20 -0800 (PST)
Received: from ketchup (unknown [183.217.80.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 4C035122FE21;
	Sun, 16 Feb 2025 03:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1739705660; bh=EazINzQbX2CZ3H/iPWJJj9tTMbi2UPooj82nJP8Z4gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/8tFOw4/Hb6xxfDqTAj1u0pucjGQM+PFhfIpSI8iNlsB0DKDPy01e+CiIcfgYGsF
	 D+MuqyDVc7xOSsIR9YqK9GN9Q28OaW/XtvV2k6F1SWzKtqyJyz5vLnHWRtvgwfohVF
	 rzA0Qt9U0ahZG8usVBWsDK+ifzPo3l0UJXy1ZLZlTxHwjwV4KCUI7TRFYtIX6Pvc5Z
	 dT4KPAosgkDiSht8ma4RlMjq3oTM0mI3MgcOyPVxYYpsHSRPUjhfuHXHulw6a1NtEJ
	 zgzciQJyapNCWZ+5HNLDJciHqgebjp3G9dT53rRFNMu0vi72vNu9kigHMFQMbPm8w2
	 iWP5MHEHdouhQ==
Date: Sun, 16 Feb 2025 11:34:06 +0000
From: Haylen Chu <heylenay@4d2.org>
To: Alex Elder <elder@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH v4 3/4] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <Z7HNLq3DgJj7WKGI@ketchup>
References: <20250103215636.19967-2-heylenay@4d2.org>
 <20250103215636.19967-5-heylenay@4d2.org>
 <f8b30551-25e7-4626-8c03-6d8807041d8a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b30551-25e7-4626-8c03-6d8807041d8a@riscstar.com>

On Thu, Feb 13, 2025 at 10:04:10PM -0600, Alex Elder wrote:
> On 1/3/25 3:56 PM, Haylen Chu wrote:
> > The clock tree of K1 SoC contains three main types of clock hardware
> > (PLL/DDN/MIX) and is managed by several independent controllers in
> > different SoC parts (APBC, APBS and etc.), thus different compatible
> > strings are added to distinguish them.
> > 
> > Some controllers may share IO region with reset controller and other low
> > speed peripherals like watchdog, so all register operations are done
> > through regmap to avoid competition.
> > 
> > Signed-off-by: Haylen Chu <heylenay@4d2.org>
> 
> This is a really big patch (over 3000 lines), and a fairly large
> amount of code to review.  But I've given it a really thorough
> read and I have a *lot* of review comments for you to consider.

Thanks for the detailed review!

> First, a few top-level comments.
> - This driver is very comprehensive.  It represents essentially
>   *all* of the clocks in the tree diagram shown here:
> https://developer.spacemit.com/resource/file/images?fileName=DkWGb4ed7oAziVxE6PIcbjTLnpd.png
>   (I can tell you what's missing but I don't think it matters.)
> - In almost all cases, the names of the clocks match the names
>   shown in that diagram, which is very helpful.
> - All of the clocks are implemented using "custom" clock
>   implementations.  I'm fairly certain that almost all of
>   them can use standard clock framework types instead
>   (fixed-rate, fixed-factor, fractional-divider, mux, and
>   composite).  But for now I think there are other things
>   more important to improve.

These three types of clocks are originally adapted from the vendor
driver, although the mix type has been largely rewritten during the
revisions.

If the custom types don't cause big problems, I'd like to see the driver
merged first and we can gradually convert them to the more general ones,
which avoids blocking other SoC drivers.

> - A great deal of my commentary below is simply saying that the
>   code is more complex than necessary.  Some simple (though
>   widespread) refactoring would improve things a lot.  And
>   some of the definitions can be done without having to
>   specify nearly so many values.
> - Much of what might be considered generality in the
>   implementation actually isn't needed, because it isn't used.
>   This is especially true given that there are essentially no
>   clocks left unspecified for the K1 SoC.
> - Once the refactoring I suggest has been done, I expect
>   that more opportunities for simplification and cleanup will
>   become obvious; we'll see.
> - I suggest these changes because the resulting simplicity
>   will make the code much more understandable and maintainable
>   in the long term.  And if it's simpler to understand, it
>   should be easier for a maintainer to accept.
> 
> I'm not going to comment on the things related to Device Tree
> that have already been mentioned, nor on the Makefile or Kconfig,
> etc.  I'm focusing just on the code.
> 
> > ---
> >   drivers/clk/Kconfig               |    1 +
> >   drivers/clk/Makefile              |    1 +
> >   drivers/clk/spacemit/Kconfig      |   20 +
> >   drivers/clk/spacemit/Makefile     |    5 +
> >   drivers/clk/spacemit/ccu-k1.c     | 1747 +++++++++++++++++++++++++++++
> >   drivers/clk/spacemit/ccu_common.h |   51 +
> >   drivers/clk/spacemit/ccu_ddn.c    |  140 +++
> >   drivers/clk/spacemit/ccu_ddn.h    |   84 ++
> >   drivers/clk/spacemit/ccu_mix.c    |  304 +++++
> >   drivers/clk/spacemit/ccu_mix.h    |  309 +++++
> >   drivers/clk/spacemit/ccu_pll.c    |  189 ++++
> >   drivers/clk/spacemit/ccu_pll.h    |   80 ++
> >   12 files changed, 2931 insertions(+)
> >   create mode 100644 drivers/clk/spacemit/Kconfig
> >   create mode 100644 drivers/clk/spacemit/Makefile
> >   create mode 100644 drivers/clk/spacemit/ccu-k1.c
> >   create mode 100644 drivers/clk/spacemit/ccu_common.h
> >   create mode 100644 drivers/clk/spacemit/ccu_ddn.c
> >   create mode 100644 drivers/clk/spacemit/ccu_ddn.h
> >   create mode 100644 drivers/clk/spacemit/ccu_mix.c
> >   create mode 100644 drivers/clk/spacemit/ccu_mix.h
> >   create mode 100644 drivers/clk/spacemit/ccu_pll.c
> >   create mode 100644 drivers/clk/spacemit/ccu_pll.h
> > 
> > diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> > new file mode 100644
> > index 000000000000..6fb0a12ec261
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu-k1.c
> > @@ -0,0 +1,1747 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/delay.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include "ccu_common.h"
> > +#include "ccu_pll.h"
> > +#include "ccu_mix.h"
> > +#include "ccu_ddn.h"
> > +
> > +#include <dt-bindings/clock/spacemit,k1-ccu.h>
> > +
> > +/*	APBS register offset	*/
> 
> 
> What do APBS, MPMU, APBC, and APMU stand for and represent?

APMU and MPMU are abbreviated from Application/Main Power Management
Unit, as mentioned earlier in my reply to the dt-binding things. APBC
means APB Bus Clock Unit. APBS stands for APB SPARE and I'm not sure
about the precise meaning.

These information seems important but I'm not sure about where they
should be documented. I could mention it in the cover letter or commit
message in next version.

> It seems each has its own clock controller, but can you
> offer any explanation about why they're divided that way?

Sadly no, I have no idea why the clock bits are divided into several
MMIO regions, which really complicates binding.

> > +/*	pll1	*/
> 
> These first few registers are found in the "APB_SPARE" space.
> But what they represent are PLL control registers.  I'd rather
> have these take on their more meaningful names, like:
>   PLL1_SW1_CTRL
>   PLL1_SW3_CTRL
>   PLL2_SW1_CTRL, etc.

Thanks, it makes sense.

> > +#define APB_SPARE1_REG			0x100
> > +#define APB_SPARE2_REG			0x104
> 
> The above register, as well as APB_SPARE8_REG and APB_SPARE11_REG
> below, are not actually used.  More on this later.
> 
> > +#define APB_SPARE3_REG			0x108
> > +/*	pll2	*/
> > +#define APB_SPARE7_REG			0x118
> > +#define APB_SPARE8_REG			0x11c
> > +#define APB_SPARE9_REG			0x120
> > +/*	pll3	*/
> > +#define APB_SPARE10_REG			0x124
> > +#define APB_SPARE11_REG			0x128
> > +#define APB_SPARE12_REG			0x12c
> > +
> > +/* MPMU register offset */
> > +#define MPMU_POSR			0x10
> 
> This register is used to signal when enabling a PLL has completed,
> with the 3 bits defined next corresponding to the three PLLs.
> This is OK, but it seems weird that this register is in the MPMU
> space, while the registers controlling the clocks themselves are
> in APBC space.  It makes the probe a little more complicated,
> because it requires the MPMU controller probe to complete before
> the APBC probe can.
> 
> I guess that's not really a question or suggestion, it's an
> oddity I wanted to point out.  If you have any more information
> about this, please share it.

Sadly no, either. While searching through the clock bindings, I
occasionally found there're similar split PLL status in Rockchip SoCs.
Thus I think it's just some (probably wrong) decisions during hardware
designing.

> > +#define POSR_PLL1_LOCK			BIT(27)
> > +#define POSR_PLL2_LOCK			BIT(28)
> > +#define POSR_PLL3_LOCK			BIT(29)
> > +
> > +#define MPMU_WDTPCR			0x200
> > +#define MPMU_RIPCCR			0x210
> > +#define MPMU_ACGR			0x1024
> > +#define MPMU_SUCCR			0x14
> > +#define MPMU_ISCCR			0x44
> > +#define MPMU_SUCCR_1			0x10b0
> > +#define MPMU_APBCSCR			0x1050
> > +
> > +/* APBC register offset */
> > +#define APBC_UART1_CLK_RST		0x0
> > +#define APBC_UART2_CLK_RST		0x4
> > +#define APBC_GPIO_CLK_RST		0x8
> > +#define APBC_PWM0_CLK_RST		0xc
> > +#define APBC_PWM1_CLK_RST		0x10
> > +#define APBC_PWM2_CLK_RST		0x14
> > +#define APBC_PWM3_CLK_RST		0x18
> > +#define APBC_TWSI8_CLK_RST		0x20
> > +#define APBC_UART3_CLK_RST		0x24
> > +#define APBC_RTC_CLK_RST		0x28
> > +#define APBC_TWSI0_CLK_RST		0x2c
> > +#define APBC_TWSI1_CLK_RST		0x30
> > +#define APBC_TIMERS1_CLK_RST		0x34
> > +#define APBC_TWSI2_CLK_RST		0x38
> > +#define APBC_AIB_CLK_RST		0x3c
> > +#define APBC_TWSI4_CLK_RST		0x40
> > +#define APBC_TIMERS2_CLK_RST		0x44
> > +#define APBC_ONEWIRE_CLK_RST		0x48
> > +#define APBC_TWSI5_CLK_RST		0x4c
> > +#define APBC_DRO_CLK_RST		0x58
> > +#define APBC_IR_CLK_RST			0x5c
> > +#define APBC_TWSI6_CLK_RST		0x60
> 
> The APBC_COUNTER_CLK_SEL register offset is never used.
> 
> > +#define APBC_COUNTER_CLK_SEL		0x64
> > +#define APBC_TWSI7_CLK_RST		0x68
> > +#define APBC_TSEN_CLK_RST		0x6c
> > +#define APBC_UART4_CLK_RST		0x70
> > +#define APBC_UART5_CLK_RST		0x74
> > +#define APBC_UART6_CLK_RST		0x78
> > +#define APBC_SSP3_CLK_RST		0x7c
> > +#define APBC_SSPA0_CLK_RST		0x80
> > +#define APBC_SSPA1_CLK_RST		0x84
> > +#define APBC_IPC_AP2AUD_CLK_RST		0x90
> > +#define APBC_UART7_CLK_RST		0x94
> > +#define APBC_UART8_CLK_RST		0x98
> > +#define APBC_UART9_CLK_RST		0x9c
> > +#define APBC_CAN0_CLK_RST		0xa0
> > +#define APBC_PWM4_CLK_RST		0xa8
> > +#define APBC_PWM5_CLK_RST		0xac
> > +#define APBC_PWM6_CLK_RST		0xb0
> > +#define APBC_PWM7_CLK_RST		0xb4
> > +#define APBC_PWM8_CLK_RST		0xb8
> > +#define APBC_PWM9_CLK_RST		0xbc
> > +#define APBC_PWM10_CLK_RST		0xc0
> > +#define APBC_PWM11_CLK_RST		0xc4
> > +#define APBC_PWM12_CLK_RST		0xc8
> > +#define APBC_PWM13_CLK_RST		0xcc
> > +#define APBC_PWM14_CLK_RST		0xd0
> > +#define APBC_PWM15_CLK_RST		0xd4
> > +#define APBC_PWM16_CLK_RST		0xd8
> > +#define APBC_PWM17_CLK_RST		0xdc
> > +#define APBC_PWM18_CLK_RST		0xe0
> > +#define APBC_PWM19_CLK_RST		0xe4
> > +
> > +/* APMU register offset */
> > +#define APMU_CCI550_CLK_CTRL		0x300
> > +#define APMU_CPU_C0_CLK_CTRL		0x38C
> > +#define APMU_CPU_C1_CLK_CTRL		0x390
> > +#define APMU_JPG_CLK_RES_CTRL		0x20
> > +#define APMU_CSI_CCIC2_CLK_RES_CTRL	0x24
> > +#define APMU_ISP_CLK_RES_CTRL		0x38
> > +#define APMU_LCD_CLK_RES_CTRL1		0x44
> > +#define APMU_LCD_SPI_CLK_RES_CTRL	0x48
> > +#define APMU_LCD_CLK_RES_CTRL2		0x4c
> > +#define APMU_CCIC_CLK_RES_CTRL		0x50
> > +#define APMU_SDH0_CLK_RES_CTRL		0x54
> > +#define APMU_SDH1_CLK_RES_CTRL		0x58
> > +#define APMU_USB_CLK_RES_CTRL		0x5c
> > +#define APMU_QSPI_CLK_RES_CTRL		0x60
> 
> APMU_USB_CLK_RES_CTRL is duplicated below.

Thanks, will remove one along with other duplication.

For the unused offsets, I prefer to keep the documented ones for future
completion of the driver. I don't think it's a large burden.

> > +#define APMU_USB_CLK_RES_CTRL		0x5c
> > +#define APMU_DMA_CLK_RES_CTRL		0x64
> > +#define APMU_AES_CLK_RES_CTRL		0x68
> > +#define APMU_VPU_CLK_RES_CTRL		0xa4
> > +#define APMU_GPU_CLK_RES_CTRL		0xcc
> > +#define APMU_SDH2_CLK_RES_CTRL		0xe0
> 
> APMU_PMUA_MC_CTRL is never used, nor is APMU_PMU_CC2_AP.
> 
> > +#define APMU_PMUA_MC_CTRL		0xe8
> > +#define APMU_PMU_CC2_AP			0x100
> > +#define APMU_PMUA_EM_CLK_RES_CTRL	0x104
> > +#define APMU_AUDIO_CLK_RES_CTRL		0x14c
> > +#define APMU_HDMI_CLK_RES_CTRL		0x1B8
> 
> APMU_CCI550_CLK_CTRL is duplicated below, as are APMU_ACLK_CLK_CTRL,
> APMU_CPU_C0_CLK_CTRL, and APMU_CPU_C1_CLK_CTRL.
> 
> > +#define APMU_CCI550_CLK_CTRL		0x300
> > +#define APMU_ACLK_CLK_CTRL		0x388
> > +#define APMU_CPU_C0_CLK_CTRL		0x38C
> > +#define APMU_CPU_C1_CLK_CTRL		0x390
> > +#define APMU_PCIE_CLK_RES_CTRL_0	0x3cc
> > +#define APMU_PCIE_CLK_RES_CTRL_1	0x3d4
> > +#define APMU_PCIE_CLK_RES_CTRL_2	0x3dc
> > +#define APMU_EMAC0_CLK_RES_CTRL		0x3e4
> > +#define APMU_EMAC1_CLK_RES_CTRL		0x3ec
> > +
> > +/*	APBS clocks start	*/
> > +
> > +/* Frequency of pll{1,2} should not be updated at runtime */
> 
> I'm going to say more about this below, but these definitions can
> be simplified a lot.  For example, the first one could be:
> 	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
> 
> > +static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
> > +	CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd),
> > +};
> > +
> > +static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
> > +	CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000),
> > +};
> > +
> > +static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
> > +	CCU_PLL_RATE(3000000000UL, 0x66, 0xdd, 0x50, 0x00, 0x3f, 0xe00000),
> > +	CCU_PLL_RATE(3200000000UL, 0x67, 0xdd, 0x50, 0x00, 0x43, 0xeaaaab),
> > +	CCU_PLL_RATE(2457600000UL, 0x64, 0xdd, 0x50, 0x00, 0x33, 0x0ccccd),
> > +};
> > +
> 
> Therre are only three PLL clocks, defined next.  All share the same
> lock register offset (MPMU_POSR), so that could be factored out.

I'm not sure how to factor the offset out, could you please explain more
about it? By coding the offset in the macro or something else?

I'd like to keep it as is, since PLL status in future SpacemiT SoCs are
likely to locate in different registers. Factoring the offset out won't
save a lot of characters, either.

> > +static CCU_PLL_DEFINE(pll1, "pll1", pll1_rate_tbl,
> > +		      APB_SPARE1_REG, APB_SPARE2_REG, APB_SPARE3_REG,
> > +		      MPMU_POSR, POSR_PLL1_LOCK, CLK_SET_RATE_GATE);
> > +static CCU_PLL_DEFINE(pll2, "pll2", pll2_rate_tbl,
> > +		      APB_SPARE7_REG, APB_SPARE8_REG, APB_SPARE9_REG,
> > +		      MPMU_POSR, POSR_PLL2_LOCK, CLK_SET_RATE_GATE);
> > +static CCU_PLL_DEFINE(pll3, "pll3", pll3_rate_tbl,
> > +		      APB_SPARE10_REG, APB_SPARE11_REG, APB_SPARE12_REG,
> > +		      MPMU_POSR, POSR_PLL3_LOCK, 0);
> > +
> 
> The next set of clocks differ from essentially all others, in that
> they don't encode their frequency in the name.  I.e., I would expect
> the first one to be named pll1_d2_1228p8.

Thanks, will adapt it in the next revision.

> > +static CCU_GATE_FACTOR_DEFINE(pll1_d2, "pll1_d2", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(1), BIT(1), 0, 2, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d3, "pll1_d3", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(2), BIT(2), 0, 3, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d4, "pll1_d4", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(3), BIT(3), 0, 4, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d5, "pll1_d5", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(4), BIT(4), 0, 5, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d6, "pll1_d6", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(5), BIT(5), 0, 6, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d7, "pll1_d7", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(6), BIT(6), 0, 7, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d8, "pll1_d8", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(7), BIT(7), 0, 8, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d11_223p4, "pll1_d11_223p4", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(15), BIT(15), 0, 11, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d13_189, "pll1_d13_189", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(16), BIT(16), 0, 13, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d23_106p8, "pll1_d23_106p8", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(20), BIT(20), 0, 23, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d64_38p4, "pll1_d64_38p4", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(0), BIT(0), 0, 64, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_aud_245p7, "pll1_aud_245p7", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(10), BIT(10), 0, 10, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_aud_24p5, "pll1_aud_24p5", CCU_PARENT_HW(pll1),
> > +			      APB_SPARE2_REG,
> > +			      BIT(11), BIT(11), 0, 100, 1, 0);
> > +
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d1, "pll2_d1", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(0), BIT(0), 0, 1, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d2, "pll2_d2", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(1), BIT(1), 0, 2, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d3, "pll2_d3", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(2), BIT(2), 0, 3, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d4, "pll2_d4", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(3), BIT(3), 0, 4, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d5, "pll2_d5", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(4), BIT(4), 0, 5, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d6, "pll2_d6", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(5), BIT(5), 0, 6, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d7, "pll2_d7", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(6), BIT(6), 0, 7, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll2_d8, "pll2_d8", CCU_PARENT_HW(pll2),
> > +			      APB_SPARE8_REG,
> > +			      BIT(7), BIT(7), 0, 8, 1, 0);
> > +
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d1, "pll3_d1", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(0), BIT(0), 0, 1, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d2, "pll3_d2", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(1), BIT(1), 0, 2, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d3, "pll3_d3", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(2), BIT(2), 0, 3, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d4, "pll3_d4", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(3), BIT(3), 0, 4, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d5, "pll3_d5", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(4), BIT(4), 0, 5, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d6, "pll3_d6", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(5), BIT(5), 0, 6, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d7, "pll3_d7", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(6), BIT(6), 0, 7, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll3_d8, "pll3_d8", CCU_PARENT_HW(pll3),
> > +			      APB_SPARE11_REG,
> > +			      BIT(7), BIT(7), 0, 8, 1, 0);
> > +
> > +static CCU_FACTOR_DEFINE(pll3_20, "pll3_20", CCU_PARENT_HW(pll3_d8), 20, 1);
> > +static CCU_FACTOR_DEFINE(pll3_40, "pll3_40", CCU_PARENT_HW(pll3_d8), 10, 1);
> > +static CCU_FACTOR_DEFINE(pll3_80, "pll3_80", CCU_PARENT_HW(pll3_d8), 5, 1);
> > +
> > +/*	APBS clocks end		*/
> > +
> > +/*	MPMU clocks start	*/
> > +static CCU_GATE_DEFINE(pll1_d8_307p2, "pll1_d8_307p2", CCU_PARENT_HW(pll1_d8),
> > +		       MPMU_ACGR,
> > +		       BIT(13), BIT(13), 0, 0);
> > +static CCU_FACTOR_DEFINE(pll1_d32_76p8, "pll1_d32_76p8", CCU_PARENT_HW(pll1_d8_307p2),
> > +			 4, 1);
> > +static CCU_FACTOR_DEFINE(pll1_d40_61p44, "pll1_d40_61p44", CCU_PARENT_HW(pll1_d8_307p2),
> > +			 5, 1);
> > +static CCU_FACTOR_DEFINE(pll1_d16_153p6, "pll1_d16_153p6", CCU_PARENT_HW(pll1_d8),
> > +			 2, 1);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d24_102p4, "pll1_d24_102p4", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(12), BIT(12), 0, 3, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2, "pll1_d48_51p2", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(7), BIT(7), 0, 6, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d48_51p2_ap, "pll1_d48_51p2_ap", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(11), BIT(11), 0, 6, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_m3d128_57p6, "pll1_m3d128_57p6", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(8), BIT(8), 0, 16, 3, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d96_25p6, "pll1_d96_25p6", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(4), BIT(4), 0, 12, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8, "pll1_d192_12p8", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(3), BIT(3), 0, 24, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d192_12p8_wdt, "pll1_d192_12p8_wdt", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(19), BIT(19), 0x0, 24, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d384_6p4, "pll1_d384_6p4", CCU_PARENT_HW(pll1_d8),
> > +			      MPMU_ACGR,
> > +			      BIT(2), BIT(2), 0, 48, 1, 0);
> > +static CCU_FACTOR_DEFINE(pll1_d768_3p2, "pll1_d768_3p2", CCU_PARENT_HW(pll1_d384_6p4),
> > +			 2, 1);
> > +static CCU_FACTOR_DEFINE(pll1_d1536_1p6, "pll1_d1536_1p6", CCU_PARENT_HW(pll1_d384_6p4),
> > +			 4, 1);
> > +static CCU_FACTOR_DEFINE(pll1_d3072_0p8, "pll1_d3072_0p8", CCU_PARENT_HW(pll1_d384_6p4),
> > +			 8, 1);
> > +
> 
> The next clock is weird, and it's the only one of its kind.  It is not
> represented in the clock tree diagram. It is a "factor 1" clock (so it
> just passes the parent's rate through), and has no gate.  Do you know
> why it's defined?  It is used only as one of the MPMU parent clocks.
> Why isn't just the pll1_d7 clock used in its place?

It is represented in the diagram. The photo version of the diagram seems
hard to search so I will ask the vendor to publish a PDF version if
possible.

As the definition involves no hardware bits, I guess it's actually an
alias listed to keep the tree structure in similar form. Will confirm
this with the vendor.

> > +static CCU_FACTOR_DEFINE(pll1_d7_351p08, "pll1_d7_351p08", CCU_PARENT_HW(pll1_d7),
> > +			 1, 1);
> > +
> > +static CCU_GATE_DEFINE(pll1_d6_409p6, "pll1_d6_409p6", CCU_PARENT_HW(pll1_d6),
> > +		       MPMU_ACGR,
> > +		       BIT(0), BIT(0), 0, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d12_204p8, "pll1_d12_204p8", CCU_PARENT_HW(pll1_d6),
> > +			      MPMU_ACGR,
> > +			      BIT(5), BIT(5), 0, 2, 1, 0);
> > +
> > +static CCU_GATE_DEFINE(pll1_d5_491p52, "pll1_d5_491p52", CCU_PARENT_HW(pll1_d5),
> > +		       MPMU_ACGR,
> > +		       BIT(21), BIT(21), 0, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d10_245p76, "pll1_d10_245p76", CCU_PARENT_HW(pll1_d5),
> > +			      MPMU_ACGR,
> > +			      BIT(18), BIT(18), 0, 2, 1, 0);
> > +
> > +static CCU_GATE_DEFINE(pll1_d4_614p4, "pll1_d4_614p4", CCU_PARENT_HW(pll1_d4),
> > +		       MPMU_ACGR,
> > +		       BIT(15), BIT(15), 0, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d52_47p26, "pll1_d52_47p26", CCU_PARENT_HW(pll1_d4),
> > +			      MPMU_ACGR,
> > +			      BIT(10), BIT(10), 0, 13, 1, 0);
> > +static CCU_GATE_FACTOR_DEFINE(pll1_d78_31p5, "pll1_d78_31p5", CCU_PARENT_HW(pll1_d4),
> > +			      MPMU_ACGR,
> > +			      BIT(6), BIT(6), 0, 39, 2, 0);
> > +
> > +static CCU_GATE_DEFINE(pll1_d3_819p2, "pll1_d3_819p2", CCU_PARENT_HW(pll1_d3),
> > +		       MPMU_ACGR,
> > +		       BIT(14), BIT(14), 0, 0);
> > +
> > +static CCU_GATE_DEFINE(pll1_d2_1228p8, "pll1_d2_1228p8", CCU_PARENT_HW(pll1_d2),
> > +		       MPMU_ACGR,
> > +		       BIT(16), BIT(16), 0, 0);
> > +static struct ccu_ddn_info uart_ddn_mask_info = {
> > +	.factor		= 2,
> > +	.num_mask	= 0x1fff,
> > +	.den_mask	= 0x1fff,
> > +	.num_shift	= 16,
> > +	.den_shift	= 0,
> > +};
> 
> I think ccu_ddn_tbl structure can go away. More below.
> 
> > +static struct ccu_ddn_tbl slow_uart1_tbl[] = {
> > +	{ .num = 125, .den = 24 },
> > +};
> > +static struct ccu_ddn_tbl slow_uart2_tbl[] = {
> > +	{ .num = 6144, .den = 960 },
> > +};
> 
> I'll note here that this "slow_uart" gate is defined separately
> from the two slow UART DDN clocks below.  That's different from
> some other gated clocks.

"slow_uart" is a gate that controlls both slow_uart1_14p7 and
slow_uart2_48. Enabling any one of these two clocks requires slow_uart
to ungate.

I didn't find a good method to describe the structure under CCF (I'm
really new to it), thus listed it out and applied the CLK_IGNORE_UNUSED
trick. Any suggesions on this will be appreciated, thanks.

> > +static CCU_GATE_DEFINE(slow_uart, "slow_uart", CCU_PARENT_NAME(osc),
> > +		       MPMU_ACGR,
> > +		       BIT(1), BIT(1), 0, CLK_IGNORE_UNUSED);
> 
> What follows are the only two DDN clocks defined.  Both define
> a "table" of numerator/denominator pairs, but in both cases,
> the table has only one entry.
> 
> Given that, why not simply encode the numerator and denominator
> in the ccu_info structure for each of these DDN clock instances?

DDN types are M/N clocks, just like clk-fractional-divider. Hardcoded
tables (even with only one entry) work because their only consumers are
UARTs, which require a relatively fixed frequency. This will prevent us
from generating precise clock if we want the UART to operate under a
different baudrate.

I'll cover more about this later.

> > +static CCU_DDN_DEFINE(slow_uart1_14p74, "slow_uart1_14p74", pll1_d16_153p6,
> > +		      &uart_ddn_mask_info, slow_uart1_tbl,
> > +		      MPMU_SUCCR, 0);
> > +static CCU_DDN_DEFINE(slow_uart2_48, "slow_uart2_48", pll1_d4_614p4,
> > +		      &uart_ddn_mask_info, slow_uart2_tbl,
> > +		      MPMU_SUCCR_1, 0);
> > +
> > +static CCU_GATE_DEFINE(wdt_clk, "wdt_clk", CCU_PARENT_HW(pll1_d96_25p6),
> > +		       MPMU_WDTPCR,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +
> 
> I couldn't find the "ripc_clk" on the clock tree diagram.  It is
> never used elsewhere, so I think this definition can go away.

I'm not sure whether the ripc_clk doesn't exist or it's just missing in
both datasheet and clock tree diagram. Will confirm with the vendor.

> > +static CCU_GATE_DEFINE(ripc_clk, "ripc_clk", CCU_PARENT_NAME(vctcxo_24m),
> > +		       MPMU_RIPCCR,
> > +		       0x3, 0x3, 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_FACTOR_DEFINE(i2s_sysclk, "i2s_sysclk", CCU_PARENT_HW(pll1_d16_153p6),
> > +			      MPMU_ISCCR,
> > +			      BIT(31), BIT(31), 0x0, 50, 1,
> > +			      0);
> > +static CCU_GATE_FACTOR_DEFINE(i2s_bclk, "i2s_bclk", CCU_PARENT_HW(i2s_sysclk),
> > +			      MPMU_ISCCR,
> > +			      BIT(29), BIT(29), 0x0, 1, 1,
> > +			      0);
> > +
> > +static const struct clk_parent_data apb_parents[] = {
> > +	CCU_PARENT_HW(pll1_d96_25p6),
> > +	CCU_PARENT_HW(pll1_d48_51p2),
> > +	CCU_PARENT_HW(pll1_d96_25p6),
> > +	CCU_PARENT_HW(pll1_d24_102p4),
> > +};
> > +static CCU_MUX_DEFINE(apb_clk, "apb_clk", apb_parents,
> > +		      MPMU_APBCSCR,
> > +		      0, 2,
> > +		      0);
> > +
> 
> The following clock is just called "wdt_clk" on the clock tree diagram.

They're different things. The wdt_clk is defined a few lines earlier and
acts as the function clock of watchdog. Instead, wdt_bus_clk is its bus
clock.

Most bus clocks in the clock tree diagram aren't listed explicitly, but
represented as a gate besides the function clock.

> > +static CCU_GATE_DEFINE(wdt_bus_clk, "wdt_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       MPMU_WDTPCR,
> > +		       BIT(2), BIT(2), 0x0,
> > +		       0);

I do find a typo here. BIT(0) should be used here instead of BIT(2),
which is the reset bit for watchdog.

> > +/*	MPMU clocks end		*/
> > +
> > +/*	APBC clocks start	*/
> > +static const struct clk_parent_data uart_clk_parents[] = {
> > +	CCU_PARENT_HW(pll1_m3d128_57p6),
> > +	CCU_PARENT_HW(slow_uart1_14p74),
> > +	CCU_PARENT_HW(slow_uart2_48),
> > +};
> 
> I might be misunderstanding this, but all of the 9 UART clocks below
> share a common gate.

AFAIK they don't share the common gate. Each uart comes with its own
functional gate, bus gate and multiplexer. The diagram seems a little
confusing: only one gate is drawn to avoid duplication.

This applies for PWM as well. There're 10 different UART clock/reset
registers, each contains a gate bit for functional clock and one for
bus clock,  confirming the idea[1].

> I *think* that gate should be represented as a distinct clock so that
> it can be properly reference-counted. There are numerous cases of this.

> Also note there is no uart1 clock; I think the clock tree diagram
> erroneously calls the first clock "uart1" (not uart0).

The clocks are reordered to match our current devicetree, where the
first uart is uart0 and uart1 is assigned to the one in RCPU (real-time
CPU) region.

> > +static CCU_MUX_GATE_DEFINE(uart0_clk, "uart0_clk", uart_clk_parents,
> > +			   APBC_UART1_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   CLK_IS_CRITICAL);
> > +static CCU_MUX_GATE_DEFINE(uart2_clk, "uart2_clk", uart_clk_parents,
> > +			   APBC_UART2_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart3_clk, "uart3_clk", uart_clk_parents,
> > +			   APBC_UART3_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart4_clk, "uart4_clk", uart_clk_parents,
> > +			   APBC_UART4_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart5_clk, "uart5_clk", uart_clk_parents,
> > +			   APBC_UART5_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart6_clk, "uart6_clk", uart_clk_parents,
> > +			   APBC_UART6_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart7_clk, "uart7_clk", uart_clk_parents,
> > +			   APBC_UART7_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart8_clk, "uart8_clk", uart_clk_parents,
> > +			   APBC_UART8_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(uart9_clk, "uart9_clk", uart_clk_parents,
> > +			   APBC_UART9_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +
> > +static CCU_GATE_DEFINE(gpio_clk, "gpio_clk", CCU_PARENT_NAME(vctcxo_24m),
> > +		       APBC_GPIO_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data pwm_parents[] = {
> > +	CCU_PARENT_HW(pll1_d192_12p8),
> > +	CCU_PARENT_NAME(osc),
> > +};
> 
> The 20 PMIC clocks share a common gate, and this is another example
> where I think that should be represented separate from all of these.
> (I'm not going to point out any more such instances.)
> 
> > +static CCU_MUX_GATE_DEFINE(pwm0_clk, "pwm0_clk", pwm_parents,
> > +			   APBC_PWM0_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm1_clk, "pwm1_clk", pwm_parents,
> > +			   APBC_PWM1_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm2_clk, "pwm2_clk", pwm_parents,
> > +			   APBC_PWM2_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm3_clk, "pwm3_clk", pwm_parents,
> > +			   APBC_PWM3_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm4_clk, "pwm4_clk", pwm_parents,
> > +			   APBC_PWM4_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm5_clk, "pwm5_clk", pwm_parents,
> > +			   APBC_PWM5_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm6_clk, "pwm6_clk", pwm_parents,
> > +			   APBC_PWM6_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm7_clk, "pwm7_clk", pwm_parents,
> > +			   APBC_PWM7_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm8_clk, "pwm8_clk", pwm_parents,
> > +			   APBC_PWM8_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm9_clk, "pwm9_clk", pwm_parents,
> > +			   APBC_PWM9_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm10_clk, "pwm10_clk", pwm_parents,
> > +			   APBC_PWM10_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm11_clk, "pwm11_clk", pwm_parents,
> > +			   APBC_PWM11_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm12_clk, "pwm12_clk", pwm_parents,
> > +			   APBC_PWM12_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm13_clk, "pwm13_clk", pwm_parents,
> > +			   APBC_PWM13_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm14_clk, "pwm14_clk", pwm_parents,
> > +			   APBC_PWM14_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm15_clk, "pwm15_clk", pwm_parents,
> > +			   APBC_PWM15_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm16_clk, "pwm16_clk", pwm_parents,
> > +			   APBC_PWM16_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm17_clk, "pwm17_clk", pwm_parents,
> > +			   APBC_PWM17_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm18_clk, "pwm18_clk", pwm_parents,
> > +			   APBC_PWM18_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(pwm19_clk, "pwm19_clk", pwm_parents,
> > +			   APBC_PWM19_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data ssp_parents[] = {
> > +	CCU_PARENT_HW(pll1_d384_6p4),
> > +	CCU_PARENT_HW(pll1_d192_12p8),
> > +	CCU_PARENT_HW(pll1_d96_25p6),
> > +	CCU_PARENT_HW(pll1_d48_51p2),
> > +	CCU_PARENT_HW(pll1_d768_3p2),
> > +	CCU_PARENT_HW(pll1_d1536_1p6),
> > +	CCU_PARENT_HW(pll1_d3072_0p8),
> > +};
> > +static CCU_MUX_GATE_DEFINE(ssp3_clk, "ssp3_clk", ssp_parents,
> > +			   APBC_SSP3_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +
> > +static CCU_GATE_DEFINE(rtc_clk, "rtc_clk", CCU_PARENT_NAME(osc),
> > +		       APBC_RTC_CLK_RST,
> > +		       0x82, 0x82, 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data twsi_parents[] = {
> > +	CCU_PARENT_HW(pll1_d78_31p5),
> > +	CCU_PARENT_HW(pll1_d48_51p2),
> > +	CCU_PARENT_HW(pll1_d40_61p44),
> > +};
> > +static CCU_MUX_GATE_DEFINE(twsi0_clk, "twsi0_clk", twsi_parents,
> > +			   APBC_TWSI0_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi1_clk, "twsi1_clk", twsi_parents,
> > +			   APBC_TWSI1_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi2_clk, "twsi2_clk", twsi_parents,
> > +			   APBC_TWSI2_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi4_clk, "twsi4_clk", twsi_parents,
> > +			   APBC_TWSI4_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi5_clk, "twsi5_clk", twsi_parents,
> > +			   APBC_TWSI5_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi6_clk, "twsi6_clk", twsi_parents,
> > +			   APBC_TWSI6_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi7_clk, "twsi7_clk", twsi_parents,
> > +			   APBC_TWSI7_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(twsi8_clk, "twsi8_clk", twsi_parents,
> > +			   APBC_TWSI8_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data timer_parents[] = {
> > +	CCU_PARENT_HW(pll1_d192_12p8),
> > +	CCU_PARENT_NAME(osc),
> > +	CCU_PARENT_HW(pll1_d384_6p4),
> > +	CCU_PARENT_NAME(vctcxo_3m),
> > +	CCU_PARENT_NAME(vctcxo_1m),
> > +};
> > +static CCU_MUX_GATE_DEFINE(timers1_clk, "timers1_clk", timer_parents,
> > +			   APBC_TIMERS1_CLK_RST,
> > +			   4, 3, 0x3, 0x3, 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(timers2_clk, "timers2_clk", timer_parents,
> > +			   APBC_TIMERS2_CLK_RST,
> > +			   4, 3, 0x3, 0x3, 0x0,
> > +			   0);
> > +
> > +static CCU_GATE_DEFINE(aib_clk, "aib_clk", CCU_PARENT_NAME(vctcxo_24m),
> > +		       APBC_AIB_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(onewire_clk, "onewire_clk", CCU_PARENT_NAME(vctcxo_24m),
> > +		       APBC_ONEWIRE_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data sspa_parents[] = {
> > +	CCU_PARENT_HW(pll1_d384_6p4),
> > +	CCU_PARENT_HW(pll1_d192_12p8),
> > +	CCU_PARENT_HW(pll1_d96_25p6),
> > +	CCU_PARENT_HW(pll1_d48_51p2),
> > +	CCU_PARENT_HW(pll1_d768_3p2),
> > +	CCU_PARENT_HW(pll1_d1536_1p6),
> > +	CCU_PARENT_HW(pll1_d3072_0p8),
> > +	CCU_PARENT_HW(i2s_bclk),
> > +};
> > +static CCU_MUX_GATE_DEFINE(sspa0_clk, "sspa0_clk", sspa_parents,
> > +			   APBC_SSPA0_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_MUX_GATE_DEFINE(sspa1_clk, "sspa1_clk", sspa_parents,
> > +			   APBC_SSPA1_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_GATE_DEFINE(dro_clk, "dro_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_DRO_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(ir_clk, "ir_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_IR_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(tsen_clk, "tsen_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TSEN_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(ipc_ap2aud_clk, "ipc_ap2aud_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_IPC_AP2AUD_CLK_RST,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data can_parents[] = {
> > +	CCU_PARENT_HW(pll3_20),
> > +	CCU_PARENT_HW(pll3_40),
> > +	CCU_PARENT_HW(pll3_80),
> > +};
> > +static CCU_MUX_GATE_DEFINE(can0_clk, "can0_clk", can_parents,
> > +			   APBC_CAN0_CLK_RST,
> > +			   4, 3, BIT(1), BIT(1), 0x0,
> > +			   0);
> > +static CCU_GATE_DEFINE(can0_bus_clk, "can0_bus_clk", CCU_PARENT_NAME(vctcxo_24m),
> > +		       APBC_CAN0_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> 
> Here we begin a bunch of definitions of "bus clocks".  They are all
> simply gates, and the clock tree diagram shows these paired with
> another gated parent.

Please note in the diagram, the clock beside the bus clock isn't the
parent of the bus clock. Without special notes, all bus clocks in the
APBC region take apb_clk as parent. All bus clocks in the APMU region
take pmua_aclk as parent.

> This says to me that in order to use a "child clock" in this
> situation, both the "regular gate" and the "bus gate" clock must be
> defined, and a reference to it taken (with clk_get() or similar).

No, functional clock and bus clock are completely irrelevant. They
control different parts of a peripheral. Taking UART as example, you do
need to take both function and bus clock for normal operation; but if
the bus clock is disabled, the UART could continue to send data. Only
the bus component won't work and the registers couldn't be accessed.

> Can you confirm this?
> > +
> > +static CCU_GATE_DEFINE(uart0_bus_clk, "uart0_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART1_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       CLK_IS_CRITICAL);
> > +static CCU_GATE_DEFINE(uart2_bus_clk, "uart2_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART2_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart3_bus_clk, "uart3_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART3_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart4_bus_clk, "uart4_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART4_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart5_bus_clk, "uart5_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART5_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart6_bus_clk, "uart6_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART6_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart7_bus_clk, "uart7_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART7_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart8_bus_clk, "uart8_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART8_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(uart9_bus_clk, "uart9_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_UART9_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(gpio_bus_clk, "gpio_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_GPIO_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(pwm0_bus_clk, "pwm0_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM0_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm1_bus_clk, "pwm1_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM1_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm2_bus_clk, "pwm2_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM2_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm3_bus_clk, "pwm3_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM3_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm4_bus_clk, "pwm4_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM4_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm5_bus_clk, "pwm5_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM5_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm6_bus_clk, "pwm6_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM6_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm7_bus_clk, "pwm7_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM7_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm8_bus_clk, "pwm8_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM8_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm9_bus_clk, "pwm9_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM9_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm10_bus_clk, "pwm10_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM10_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm11_bus_clk, "pwm11_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM11_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm12_bus_clk, "pwm12_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM12_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm13_bus_clk, "pwm13_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM13_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm14_bus_clk, "pwm14_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM14_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm15_bus_clk, "pwm15_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM15_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm16_bus_clk, "pwm16_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM16_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm17_bus_clk, "pwm17_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM17_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm18_bus_clk, "pwm18_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM18_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pwm19_bus_clk, "pwm19_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_PWM19_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(ssp3_bus_clk, "ssp3_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_SSP3_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(rtc_bus_clk, "rtc_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_RTC_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(twsi0_bus_clk, "twsi0_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI0_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi1_bus_clk, "twsi1_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI1_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi2_bus_clk, "twsi2_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI2_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi4_bus_clk, "twsi4_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI4_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi5_bus_clk, "twsi5_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI5_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi6_bus_clk, "twsi6_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI6_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi7_bus_clk, "twsi7_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI7_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(twsi8_bus_clk, "twsi8_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TWSI8_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(timers1_bus_clk, "timers1_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TIMERS1_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(timers2_bus_clk, "timers2_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TIMERS2_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(aib_bus_clk, "aib_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_AIB_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(onewire_bus_clk, "onewire_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_ONEWIRE_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(sspa0_bus_clk, "sspa0_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_SSPA0_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(sspa1_bus_clk, "sspa1_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_SSPA1_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(tsen_bus_clk, "tsen_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_TSEN_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(ipc_ap2aud_bus_clk, "ipc_ap2aud_bus_clk", CCU_PARENT_HW(apb_clk),
> > +		       APBC_IPC_AP2AUD_CLK_RST,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +/*	APBC clocks end		*/
> > +
> > +/*	APMU clocks start	*/
> > +static const struct clk_parent_data pmua_aclk_parents[] = {
> > +	CCU_PARENT_HW(pll1_d10_245p76),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +};
> 
> OK I'm just going to point out that this is the first clock that
> defines a "FC" (frequency change) register/bit.  It must be set
> by software when the clock control register is updated, and
> the hardware will clear that bit to signal that the change
> is complete.
> 
> > +static CCU_DIV_FC_MUX_DEFINE(pmua_aclk, "pmua_aclk", pmua_aclk_parents,
> > +			     APMU_ACLK_CLK_CTRL,
> > +			     1, 2, BIT(4),
> > +			     0, 1,
> > +			     0);
> > +
> > +static const struct clk_parent_data cci550_clk_parents[] = {
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll2_d3),
> > +};
> > +static CCU_DIV_FC_MUX_DEFINE(cci550_clk, "cci550_clk", cci550_clk_parents,
> > +			     APMU_CCI550_CLK_CTRL,
> > +			     8, 3, BIT(12), 0, 2, CLK_IS_CRITICAL);
> > +
> > +static const struct clk_parent_data cpu_c0_hi_clk_parents[] = {
> > +	CCU_PARENT_HW(pll3_d2),
> > +	CCU_PARENT_HW(pll3_d1),
> > +};
> > +static CCU_MUX_DEFINE(cpu_c0_hi_clk, "cpu_c0_hi_clk", cpu_c0_hi_clk_parents,
> > +		      APMU_CPU_C0_CLK_CTRL,
> > +		      13, 1, 0);
> > +static const struct clk_parent_data cpu_c0_clk_parents[] = {
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > +	CCU_PARENT_HW(pll3_d3),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(cpu_c0_hi_clk),
> > +};
> > +static CCU_MUX_FC_DEFINE(cpu_c0_core_clk, "cpu_c0_core_clk", cpu_c0_clk_parents,
> > +			 APMU_CPU_C0_CLK_CTRL,
> > +			 BIT(12), 0, 3, CLK_IS_CRITICAL);
> > +static CCU_DIV_DEFINE(cpu_c0_ace_clk, "cpu_c0_ace_clk", CCU_PARENT_HW(cpu_c0_core_clk),
> > +		      APMU_CPU_C0_CLK_CTRL,
> > +		      6, 3, CLK_IS_CRITICAL);
> > +static CCU_DIV_DEFINE(cpu_c0_tcm_clk, "cpu_c0_tcm_clk", CCU_PARENT_HW(cpu_c0_core_clk),
> > +		      APMU_CPU_C0_CLK_CTRL, 9, 3, CLK_IS_CRITICAL);
> > +
> > +static const struct clk_parent_data cpu_c1_hi_clk_parents[] = {
> > +	CCU_PARENT_HW(pll3_d2),
> > +	CCU_PARENT_HW(pll3_d1),
> > +};
> > +static CCU_MUX_DEFINE(cpu_c1_hi_clk, "cpu_c1_hi_clk", cpu_c1_hi_clk_parents,
> > +		      APMU_CPU_C1_CLK_CTRL,
> > +		      13, 1, CLK_IS_CRITICAL);
> > +static const struct clk_parent_data cpu_c1_clk_parents[] = {
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > +	CCU_PARENT_HW(pll3_d3),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(cpu_c1_hi_clk),
> > +};
> 
> The following clock is named "cpu_c1_pclk" on the clock tree diagram.

It's renamed to match the clock for cluster 0.

> > +static CCU_MUX_FC_DEFINE(cpu_c1_core_clk, "cpu_c1_core_clk", cpu_c1_clk_parents,
> > +			 APMU_CPU_C1_CLK_CTRL,
> > +			 BIT(12), 0, 3, CLK_IS_CRITICAL);
> > +static CCU_DIV_DEFINE(cpu_c1_ace_clk, "cpu_c1_ace_clk", CCU_PARENT_HW(cpu_c1_core_clk),
> > +		      APMU_CPU_C1_CLK_CTRL,
> > +		      6, 3, CLK_IS_CRITICAL);
> > +
> > +static const struct clk_parent_data jpg_parents[] = {
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > +	CCU_PARENT_HW(pll2_d4),
> > +	CCU_PARENT_HW(pll2_d3),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(jpg_clk, "jpg_clk", jpg_parents,
> > +				  APMU_JPG_CLK_RES_CTRL,
> > +				  5, 3, BIT(15),
> > +				  2, 3, BIT(1), BIT(1), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data ccic2phy_parents[] = {
> > +	CCU_PARENT_HW(pll1_d24_102p4),
> > +	CCU_PARENT_HW(pll1_d48_51p2_ap),
> > +};
> > +static CCU_MUX_GATE_DEFINE(ccic2phy_clk, "ccic2phy_clk", ccic2phy_parents,
> > +			   APMU_CSI_CCIC2_CLK_RES_CTRL,
> > +			   7, 1, BIT(5), BIT(5), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data ccic3phy_parents[] = {
> > +	CCU_PARENT_HW(pll1_d24_102p4),
> > +	CCU_PARENT_HW(pll1_d48_51p2_ap),
> > +};
> > +static CCU_MUX_GATE_DEFINE(ccic3phy_clk, "ccic3phy_clk", ccic3phy_parents,
> > +			   APMU_CSI_CCIC2_CLK_RES_CTRL,
> > +			   31, 1, BIT(30), BIT(30), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data csi_parents[] = {
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll2_d2),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(pll2_d4),
> > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(csi_clk, "csi_clk", csi_parents,
> > +				  APMU_CSI_CCIC2_CLK_RES_CTRL,
> > +				  20, 3, BIT(15),
> > +				  16, 3, BIT(4), BIT(4), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data camm_parents[] = {
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll2_d5),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_NAME(vctcxo_24m),
> > +};
> > +static CCU_DIV_MUX_GATE_DEFINE(camm0_clk, "camm0_clk", camm_parents,
> > +			       APMU_CSI_CCIC2_CLK_RES_CTRL,
> > +			       23, 4, 8, 2,
> > +			       BIT(28), BIT(28), 0x0,
> > +			       0);
> > +static CCU_DIV_MUX_GATE_DEFINE(camm1_clk, "camm1_clk", camm_parents,
> > +			       APMU_CSI_CCIC2_CLK_RES_CTRL,
> > +			       23, 4, 8, 2, BIT(6), BIT(6), 0x0,
> > +			       0);
> > +static CCU_DIV_MUX_GATE_DEFINE(camm2_clk, "camm2_clk", camm_parents,
> > +			       APMU_CSI_CCIC2_CLK_RES_CTRL,
> > +			       23, 4, 8, 2, BIT(3), BIT(3), 0x0,
> > +			       0);
> > +
> > +static const struct clk_parent_data isp_cpp_parents[] = {
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +};
> > +static CCU_DIV_MUX_GATE_DEFINE(isp_cpp_clk, "isp_cpp_clk", isp_cpp_parents,
> > +			       APMU_ISP_CLK_RES_CTRL,
> > +			       24, 2, 26, 1, BIT(28), BIT(28), 0x0,
> > +			       0);
> > +static const struct clk_parent_data isp_bus_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll1_d10_245p76),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(isp_bus_clk, "isp_bus_clk", isp_bus_parents,
> > +				  APMU_ISP_CLK_RES_CTRL,
> > +				  18, 3, BIT(23),
> > +				  21, 2, BIT(17), BIT(17), 0x0,
> > +				  0);
> > +static const struct clk_parent_data isp_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(isp_clk, "isp_clk", isp_parents,
> > +				  APMU_ISP_CLK_RES_CTRL,
> > +				  4, 3, BIT(7),
> > +				  8, 2, BIT(1), BIT(1), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data dpumclk_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +};
> > +static CCU_DIV2_FC_MUX_GATE_DEFINE(dpu_mclk, "dpu_mclk", dpumclk_parents,
> > +				   APMU_LCD_CLK_RES_CTRL2,
> > +				   APMU_LCD_CLK_RES_CTRL1,
> > +				   1, 4, BIT(29),
> > +				   5, 3, BIT(0), BIT(0), 0x0,
> > +				   0);
> > +
> > +static const struct clk_parent_data dpuesc_parents[] = {
> > +	CCU_PARENT_HW(pll1_d48_51p2_ap),
> > +	CCU_PARENT_HW(pll1_d52_47p26),
> > +	CCU_PARENT_HW(pll1_d96_25p6),
> > +	CCU_PARENT_HW(pll1_d32_76p8),
> > +};
> > +static CCU_MUX_GATE_DEFINE(dpu_esc_clk, "dpu_esc_clk", dpuesc_parents,
> > +			   APMU_LCD_CLK_RES_CTRL1,
> > +			   0, 2, BIT(2), BIT(2), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data dpubit_parents[] = {
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll2_d2),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > +	CCU_PARENT_HW(pll2_d4),
> > +	CCU_PARENT_HW(pll2_d5),
> 
> The next two parent clocks are duplicates.  It looks this way on the
> clock tree diagram as well.  Is this correct? Can you find out from
> SpacemiT whether one of them is actually a different clock (like
> pll2_d6 or something)?  It makes no sense to have two multiplexed
> parent clocks with the same source.

Yes, will confirm it later. The register description[2] suggests it's
wrong (there aren't two configuration for MIPI_BIT_CLK_SEL resulting in
the same frequency).

> > +	CCU_PARENT_HW(pll2_d8),
> > +	CCU_PARENT_HW(pll2_d8),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_bit_clk, "dpu_bit_clk", dpubit_parents,
> > +				  APMU_LCD_CLK_RES_CTRL1,
> > +				  17, 3, BIT(31),
> > +				  20, 3, BIT(16), BIT(16), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data dpupx_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll2_d7),
> > +	CCU_PARENT_HW(pll2_d8),
> > +};
> > +static CCU_DIV2_FC_MUX_GATE_DEFINE(dpu_pxclk, "dpu_pxclk", dpupx_parents,
> > +				  APMU_LCD_CLK_RES_CTRL2,
> > +				  APMU_LCD_CLK_RES_CTRL1,
> > +				  17, 4, BIT(30),
> > +				  21, 3, BIT(16), BIT(16), 0x0,
> > +				  0);
> > +
> > +static CCU_GATE_DEFINE(dpu_hclk, "dpu_hclk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_LCD_CLK_RES_CTRL1,
> > +		       BIT(5), BIT(5), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data dpu_spi_parents[] = {
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d10_245p76),
> > +	CCU_PARENT_HW(pll1_d11_223p4),
> > +	CCU_PARENT_HW(pll1_d13_189),
> > +	CCU_PARENT_HW(pll1_d23_106p8),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(pll2_d5),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(dpu_spi_clk, "dpu_spi_clk", dpu_spi_parents,
> > +				  APMU_LCD_SPI_CLK_RES_CTRL,
> > +				  8, 3, BIT(7),
> > +				  12, 3, BIT(1), BIT(1), 0x0,
> > +				  0);
> > +static CCU_GATE_DEFINE(dpu_spi_hbus_clk, "dpu_spi_hbus_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_LCD_SPI_CLK_RES_CTRL,
> > +		       BIT(3), BIT(3), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(dpu_spi_bus_clk, "dpu_spi_bus_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_LCD_SPI_CLK_RES_CTRL,
> > +		       BIT(5), BIT(5), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(dpu_spi_aclk, "dpu_spi_aclk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_LCD_SPI_CLK_RES_CTRL,
> > +		       BIT(6), BIT(6), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data v2d_parents[] = {
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(v2d_clk, "v2d_clk", v2d_parents,
> > +				  APMU_LCD_CLK_RES_CTRL1,
> > +				  9, 3, BIT(28),
> > +				  12, 2, BIT(8), BIT(8), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data ccic_4x_parents[] = {
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll2_d2),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(pll2_d4),
> > +	CCU_PARENT_HW(pll1_d2_1228p8),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(ccic_4x_clk, "ccic_4x_clk", ccic_4x_parents,
> > +				  APMU_CCIC_CLK_RES_CTRL,
> > +				  18, 3, BIT(15),
> > +				  23, 2, BIT(4), BIT(4), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data ccic1phy_parents[] = {
> > +	CCU_PARENT_HW(pll1_d24_102p4),
> > +	CCU_PARENT_HW(pll1_d48_51p2_ap),
> > +};
> > +static CCU_MUX_GATE_DEFINE(ccic1phy_clk, "ccic1phy_clk", ccic1phy_parents,
> > +			   APMU_CCIC_CLK_RES_CTRL,
> > +			   7, 1, BIT(5), BIT(5), 0x0,
> > +			   0);
> > +
> > +static CCU_GATE_DEFINE(sdh_axi_aclk, "sdh_axi_aclk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_SDH0_CLK_RES_CTRL,
> > +		       BIT(3), BIT(3), 0x0,
> > +		       0);
> > +static const struct clk_parent_data sdh01_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll2_d8),
> > +	CCU_PARENT_HW(pll2_d5),
> > +	CCU_PARENT_HW(pll1_d11_223p4),
> > +	CCU_PARENT_HW(pll1_d13_189),
> > +	CCU_PARENT_HW(pll1_d23_106p8),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(sdh0_clk, "sdh0_clk", sdh01_parents,
> > +				  APMU_SDH0_CLK_RES_CTRL,
> > +				  8, 3, BIT(11),
> > +				  5, 3, BIT(4), BIT(4), 0x0,
> > +				  0);
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(sdh1_clk, "sdh1_clk", sdh01_parents,
> > +				  APMU_SDH1_CLK_RES_CTRL,
> > +				  8, 3, BIT(11),
> > +				  5, 3, BIT(4), BIT(4), 0x0,
> > +				  0);
> 
> This is strange too.  sdh2_parents is identical to sdh01_parents.

No, it isn't. pll2_d5 is a parent for sdh0/1; for sdh2, pll1_d3_819p2
replaces it.

> All of the bits used are identical for the three control registers.
> The clock tree diagram shows all three of these sdhx clocks sharing
> a single parent mux.  Why is sdh2_parents defined separately?

I don't think the mux is shared. It should be the same case for
UART/PWM clocks, as described earlier.

> > +static const struct clk_parent_data sdh2_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll2_d8),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll1_d11_223p4),
> > +	CCU_PARENT_HW(pll1_d13_189),
> > +	CCU_PARENT_HW(pll1_d23_106p8),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(sdh2_clk, "sdh2_clk", sdh2_parents,
> > +				  APMU_SDH2_CLK_RES_CTRL,
> > +				  8, 3, BIT(11),
> > +				  5, 3, BIT(4), BIT(4), 0x0,
> > +				  0);
> > +
> > +static CCU_GATE_DEFINE(usb_axi_clk, "usb_axi_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_USB_CLK_RES_CTRL,
> > +		       BIT(1), BIT(1), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(usb_p1_aclk, "usb_p1_aclk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_USB_CLK_RES_CTRL,
> > +		       BIT(5), BIT(5), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(usb30_clk, "usb30_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_USB_CLK_RES_CTRL,
> > +		       BIT(8), BIT(8), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data qspi_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll2_d8),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll1_d10_245p76),
> > +	CCU_PARENT_HW(pll1_d11_223p4),
> > +	CCU_PARENT_HW(pll1_d23_106p8),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d13_189),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(qspi_clk, "qspi_clk", qspi_parents,
> > +				   APMU_QSPI_CLK_RES_CTRL,
> > +				   9, 3, BIT(12),
> > +				   6, 3, BIT(4), BIT(4), 0x0,
> > +				   0);
> > +static CCU_GATE_DEFINE(qspi_bus_clk, "qspi_bus_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_QSPI_CLK_RES_CTRL,
> > +		       BIT(3), BIT(3), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(dma_clk, "dma_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_DMA_CLK_RES_CTRL,
> > +		       BIT(3), BIT(3), 0x0,
> > +		       0);
> > +
> > +static const struct clk_parent_data aes_parents[] = {
> > +	CCU_PARENT_HW(pll1_d12_204p8),
> > +	CCU_PARENT_HW(pll1_d24_102p4),
> > +};
> > +static CCU_MUX_GATE_DEFINE(aes_clk, "aes_clk", aes_parents,
> > +			   APMU_AES_CLK_RES_CTRL,
> > +			   6, 1, BIT(5), BIT(5), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data vpu_parents[] = {
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll3_d6),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(pll2_d4),
> > +	CCU_PARENT_HW(pll2_d5),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(vpu_clk, "vpu_clk", vpu_parents,
> > +				  APMU_VPU_CLK_RES_CTRL,
> > +				  13, 3, BIT(21),
> > +				  10, 3,
> > +				  BIT(3), BIT(3), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data gpu_parents[] = {
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll3_d6),
> > +	CCU_PARENT_HW(pll2_d3),
> > +	CCU_PARENT_HW(pll2_d4),
> > +	CCU_PARENT_HW(pll2_d5),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(gpu_clk, "gpu_clk", gpu_parents,
> > +				  APMU_GPU_CLK_RES_CTRL,
> > +				  12, 3, BIT(15),
> > +				  18, 3,
> > +				  BIT(4), BIT(4), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data emmc_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d52_47p26),
> > +	CCU_PARENT_HW(pll1_d3_819p2),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(emmc_clk, "emmc_clk", emmc_parents,
> > +				  APMU_PMUA_EM_CLK_RES_CTRL,
> > +				  8, 3, BIT(11),
> > +				  6, 2,
> > +				  BIT(4), BIT(4), 0x0,
> > +				  0);
> > +static CCU_DIV_GATE_DEFINE(emmc_x_clk, "emmc_x_clk", CCU_PARENT_HW(pll1_d2_1228p8),
> > +			   APMU_PMUA_EM_CLK_RES_CTRL,
> > +			   12, 3, BIT(15), BIT(15), 0x0,
> > +			   0);
> > +
> > +static const struct clk_parent_data audio_parents[] = {
> > +	CCU_PARENT_HW(pll1_aud_245p7),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(audio_clk, "audio_clk", audio_parents,
> > +				  APMU_AUDIO_CLK_RES_CTRL,
> > +				  4, 3, BIT(15),
> > +				  7, 3,
> > +				  BIT(12), BIT(12), 0x0,
> > +				  0);
> > +
> > +static const struct clk_parent_data hdmi_parents[] = {
> > +	CCU_PARENT_HW(pll1_d6_409p6),
> > +	CCU_PARENT_HW(pll1_d5_491p52),
> > +	CCU_PARENT_HW(pll1_d4_614p4),
> > +	CCU_PARENT_HW(pll1_d8_307p2),
> > +};
> > +static CCU_DIV_FC_MUX_GATE_DEFINE(hdmi_mclk, "hdmi_mclk", hdmi_parents,
> > +				  APMU_HDMI_CLK_RES_CTRL,
> > +				  1, 4, BIT(29),
> > +				  5, 3,
> > +				  BIT(0), BIT(0), 0x0,
> > +				  0);
> > +
> > +static CCU_GATE_DEFINE(pcie0_clk, "pcie0_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_PCIE_CLK_RES_CTRL_0,
> > +		       0x7, 0x7, 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pcie1_clk, "pcie1_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_PCIE_CLK_RES_CTRL_1,
> > +		       0x7, 0x7, 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(pcie2_clk, "pcie2_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_PCIE_CLK_RES_CTRL_2,
> > +		       0x7, 0x7, 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(emac0_bus_clk, "emac0_bus_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_EMAC0_CLK_RES_CTRL,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(emac0_ptp_clk, "emac0_ptp_clk", CCU_PARENT_HW(pll2_d6),
> > +		       APMU_EMAC0_CLK_RES_CTRL,
> > +		       BIT(15), BIT(15), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(emac1_bus_clk, "emac1_bus_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_EMAC1_CLK_RES_CTRL,
> > +		       BIT(0), BIT(0), 0x0,
> > +		       0);
> > +static CCU_GATE_DEFINE(emac1_ptp_clk, "emac1_ptp_clk", CCU_PARENT_HW(pll2_d6),
> > +		       APMU_EMAC1_CLK_RES_CTRL,
> > +		       BIT(15), BIT(15), 0x0,
> > +		       0);
> > +
> > +static CCU_GATE_DEFINE(emmc_bus_clk, "emmc_bus_clk", CCU_PARENT_HW(pmua_aclk),
> > +		       APMU_PMUA_EM_CLK_RES_CTRL,
> > +		       BIT(3), BIT(3), 0,
> > +		       0);
> > +/*	APMU clocks end		*/
> > +
> 
> You could reduce some duplication here using a simple
> macro for defining the address of the clk_hw structure:
> 
> #define CLK_HW(x)	&x.common.hw
> 
> (Add parentheses if you like.)  It saves 3 characters for
> each clock...

Looks good to me, but

> > +static struct clk_hw_onecell_data k1_ccu_apbs_clks = {
> > +	.hws = {
> > +		[CLK_PLL1]		= &pll1.common.hw,
> > +		[CLK_PLL2]		= &pll2.common.hw,
> > +		[CLK_PLL3]		= &pll3.common.hw,
> > +		[CLK_PLL1_D2]		= &pll1_d2.common.hw,
> > +		[CLK_PLL1_D3]		= &pll1_d3.common.hw,
> > +		[CLK_PLL1_D4]		= &pll1_d4.common.hw,
> > +		[CLK_PLL1_D5]		= &pll1_d5.common.hw,
> > +		[CLK_PLL1_D6]		= &pll1_d6.common.hw,
> > +		[CLK_PLL1_D7]		= &pll1_d7.common.hw,
> > +		[CLK_PLL1_D8]		= &pll1_d8.common.hw,
> > +		[CLK_PLL1_D11]		= &pll1_d11_223p4.common.hw,
> > +		[CLK_PLL1_D13]		= &pll1_d13_189.common.hw,
> > +		[CLK_PLL1_D23]		= &pll1_d23_106p8.common.hw,
> > +		[CLK_PLL1_D64]		= &pll1_d64_38p4.common.hw,
> > +		[CLK_PLL1_D10_AUD]	= &pll1_aud_245p7.common.hw,
> > +		[CLK_PLL1_D100_AUD]	= &pll1_aud_24p5.common.hw,
> > +		[CLK_PLL2_D1]		= &pll2_d1.common.hw,
> > +		[CLK_PLL2_D2]		= &pll2_d2.common.hw,
> > +		[CLK_PLL2_D3]		= &pll2_d3.common.hw,
> > +		[CLK_PLL2_D4]		= &pll2_d4.common.hw,
> > +		[CLK_PLL2_D5]		= &pll2_d5.common.hw,
> > +		[CLK_PLL2_D6]		= &pll2_d6.common.hw,
> > +		[CLK_PLL2_D7]		= &pll2_d7.common.hw,
> > +		[CLK_PLL2_D8]		= &pll2_d8.common.hw,
> > +		[CLK_PLL3_D1]		= &pll3_d1.common.hw,
> > +		[CLK_PLL3_D2]		= &pll3_d2.common.hw,
> > +		[CLK_PLL3_D3]		= &pll3_d3.common.hw,
> > +		[CLK_PLL3_D4]		= &pll3_d4.common.hw,
> > +		[CLK_PLL3_D5]		= &pll3_d5.common.hw,
> > +		[CLK_PLL3_D6]		= &pll3_d6.common.hw,
> > +		[CLK_PLL3_D7]		= &pll3_d7.common.hw,
> > +		[CLK_PLL3_D8]		= &pll3_d8.common.hw,
> > +		[CLK_PLL3_80]		= &pll3_80.common.hw,
> > +		[CLK_PLL3_40]		= &pll3_40.common.hw,
> > +		[CLK_PLL3_20]		= &pll3_20.common.hw,
> > +
> > +	},
> > +	.num = CLK_APBS_NUM,
> 
> It sure would be nice to be able to use ARRAY_SIZE() here but
> alas I don't think it's possible here.

CLK_*_NUM will be removed in the next revision, as it's actually not a
binding. I'm looking for a better way to represent these clocks.

Maybe represent the clocks with (ID, struct clk_hw *) pairs and
generate struct clk_hw_onecell_data dynamically during probe.

> > +};
> > +
> > +static struct clk_hw_onecell_data k1_ccu_mpmu_clks = {
> > +	.hws = {
> > +		[CLK_PLL1_307P2]	= &pll1_d8_307p2.common.hw,
> > +		[CLK_PLL1_76P8]		= &pll1_d32_76p8.common.hw,
> > +		[CLK_PLL1_61P44]	= &pll1_d40_61p44.common.hw,
> > +		[CLK_PLL1_153P6]	= &pll1_d16_153p6.common.hw,
> > +		[CLK_PLL1_102P4]	= &pll1_d24_102p4.common.hw,
> > +		[CLK_PLL1_51P2]		= &pll1_d48_51p2.common.hw,
> > +		[CLK_PLL1_51P2_AP]	= &pll1_d48_51p2_ap.common.hw,
> > +		[CLK_PLL1_57P6]		= &pll1_m3d128_57p6.common.hw,
> > +		[CLK_PLL1_25P6]		= &pll1_d96_25p6.common.hw,
> > +		[CLK_PLL1_12P8]		= &pll1_d192_12p8.common.hw,
> > +		[CLK_PLL1_12P8_WDT]	= &pll1_d192_12p8_wdt.common.hw,
> > +		[CLK_PLL1_6P4]		= &pll1_d384_6p4.common.hw,
> > +		[CLK_PLL1_3P2]		= &pll1_d768_3p2.common.hw,
> > +		[CLK_PLL1_1P6]		= &pll1_d1536_1p6.common.hw,
> > +		[CLK_PLL1_0P8]		= &pll1_d3072_0p8.common.hw,
> > +		[CLK_PLL1_351]		= &pll1_d7_351p08.common.hw,
> > +		[CLK_PLL1_409P6]	= &pll1_d6_409p6.common.hw,
> > +		[CLK_PLL1_204P8]	= &pll1_d12_204p8.common.hw,
> > +		[CLK_PLL1_491]		= &pll1_d5_491p52.common.hw,
> > +		[CLK_PLL1_245P76]	= &pll1_d10_245p76.common.hw,
> > +		[CLK_PLL1_614]		= &pll1_d4_614p4.common.hw,
> > +		[CLK_PLL1_47P26]	= &pll1_d52_47p26.common.hw,
> > +		[CLK_PLL1_31P5]		= &pll1_d78_31p5.common.hw,
> > +		[CLK_PLL1_819]		= &pll1_d3_819p2.common.hw,
> > +		[CLK_PLL1_1228]		= &pll1_d2_1228p8.common.hw,
> > +		[CLK_SLOW_UART]		= &slow_uart.common.hw,
> > +		[CLK_SLOW_UART1]	= &slow_uart1_14p74.common.hw,
> > +		[CLK_SLOW_UART2]	= &slow_uart2_48.common.hw,
> > +		[CLK_WDT]		= &wdt_clk.common.hw,
> > +		[CLK_RIPC]		= &ripc_clk.common.hw,
> > +		[CLK_I2S_SYSCLK]	= &i2s_sysclk.common.hw,
> > +		[CLK_I2S_BCLK]		= &i2s_bclk.common.hw,
> > +		[CLK_APB]		= &apb_clk.common.hw,
> > +		[CLK_WDT_BUS]		= &wdt_bus_clk.common.hw,
> > +	},
> > +	.num = CLK_MPMU_NUM,
> > +};
> > +
> > +static struct clk_hw_onecell_data k1_ccu_apbc_clks = {
> > +	.hws = {
> > +		[CLK_UART0]		= &uart0_clk.common.hw,
> > +		[CLK_UART2]		= &uart2_clk.common.hw,
> > +		[CLK_UART3]		= &uart3_clk.common.hw,
> > +		[CLK_UART4]		= &uart4_clk.common.hw,
> > +		[CLK_UART5]		= &uart5_clk.common.hw,
> > +		[CLK_UART6]		= &uart6_clk.common.hw,
> > +		[CLK_UART7]		= &uart7_clk.common.hw,
> > +		[CLK_UART8]		= &uart8_clk.common.hw,
> > +		[CLK_UART9]		= &uart9_clk.common.hw,
> > +		[CLK_GPIO]		= &gpio_clk.common.hw,
> > +		[CLK_PWM0]		= &pwm0_clk.common.hw,
> > +		[CLK_PWM1]		= &pwm1_clk.common.hw,
> > +		[CLK_PWM2]		= &pwm2_clk.common.hw,
> > +		[CLK_PWM3]		= &pwm3_clk.common.hw,
> > +		[CLK_PWM4]		= &pwm4_clk.common.hw,
> > +		[CLK_PWM5]		= &pwm5_clk.common.hw,
> > +		[CLK_PWM6]		= &pwm6_clk.common.hw,
> > +		[CLK_PWM7]		= &pwm7_clk.common.hw,
> > +		[CLK_PWM8]		= &pwm8_clk.common.hw,
> > +		[CLK_PWM9]		= &pwm9_clk.common.hw,
> > +		[CLK_PWM10]		= &pwm10_clk.common.hw,
> > +		[CLK_PWM11]		= &pwm11_clk.common.hw,
> > +		[CLK_PWM12]		= &pwm12_clk.common.hw,
> > +		[CLK_PWM13]		= &pwm13_clk.common.hw,
> > +		[CLK_PWM14]		= &pwm14_clk.common.hw,
> > +		[CLK_PWM15]		= &pwm15_clk.common.hw,
> > +		[CLK_PWM16]		= &pwm16_clk.common.hw,
> > +		[CLK_PWM17]		= &pwm17_clk.common.hw,
> > +		[CLK_PWM18]		= &pwm18_clk.common.hw,
> > +		[CLK_PWM19]		= &pwm19_clk.common.hw,
> > +		[CLK_SSP3]		= &ssp3_clk.common.hw,
> > +		[CLK_RTC]		= &rtc_clk.common.hw,
> > +		[CLK_TWSI0]		= &twsi0_clk.common.hw,
> > +		[CLK_TWSI1]		= &twsi1_clk.common.hw,
> > +		[CLK_TWSI2]		= &twsi2_clk.common.hw,
> > +		[CLK_TWSI4]		= &twsi4_clk.common.hw,
> > +		[CLK_TWSI5]		= &twsi5_clk.common.hw,
> > +		[CLK_TWSI6]		= &twsi6_clk.common.hw,
> > +		[CLK_TWSI7]		= &twsi7_clk.common.hw,
> > +		[CLK_TWSI8]		= &twsi8_clk.common.hw,
> > +		[CLK_TIMERS1]		= &timers1_clk.common.hw,
> > +		[CLK_TIMERS2]		= &timers2_clk.common.hw,
> > +		[CLK_AIB]		= &aib_clk.common.hw,
> > +		[CLK_ONEWIRE]		= &onewire_clk.common.hw,
> > +		[CLK_SSPA0]		= &sspa0_clk.common.hw,
> > +		[CLK_SSPA1]		= &sspa1_clk.common.hw,
> > +		[CLK_DRO]		= &dro_clk.common.hw,
> > +		[CLK_IR]		= &ir_clk.common.hw,
> > +		[CLK_TSEN]		= &tsen_clk.common.hw,
> > +		[CLK_IPC_AP2AUD]	= &ipc_ap2aud_clk.common.hw,
> > +		[CLK_CAN0]		= &can0_clk.common.hw,
> > +		[CLK_CAN0_BUS]		= &can0_bus_clk.common.hw,
> > +		[CLK_UART0_BUS]		= &uart0_bus_clk.common.hw,
> > +		[CLK_UART2_BUS]		= &uart2_bus_clk.common.hw,
> > +		[CLK_UART3_BUS]		= &uart3_bus_clk.common.hw,
> > +		[CLK_UART4_BUS]		= &uart4_bus_clk.common.hw,
> > +		[CLK_UART5_BUS]		= &uart5_bus_clk.common.hw,
> > +		[CLK_UART6_BUS]		= &uart6_bus_clk.common.hw,
> > +		[CLK_UART7_BUS]		= &uart7_bus_clk.common.hw,
> > +		[CLK_UART8_BUS]		= &uart8_bus_clk.common.hw,
> > +		[CLK_UART9_BUS]		= &uart9_bus_clk.common.hw,
> > +		[CLK_GPIO_BUS]		= &gpio_bus_clk.common.hw,
> > +		[CLK_PWM0_BUS]		= &pwm0_bus_clk.common.hw,
> > +		[CLK_PWM1_BUS]		= &pwm1_bus_clk.common.hw,
> > +		[CLK_PWM2_BUS]		= &pwm2_bus_clk.common.hw,
> > +		[CLK_PWM3_BUS]		= &pwm3_bus_clk.common.hw,
> > +		[CLK_PWM4_BUS]		= &pwm4_bus_clk.common.hw,
> > +		[CLK_PWM5_BUS]		= &pwm5_bus_clk.common.hw,
> > +		[CLK_PWM6_BUS]		= &pwm6_bus_clk.common.hw,
> > +		[CLK_PWM7_BUS]		= &pwm7_bus_clk.common.hw,
> > +		[CLK_PWM8_BUS]		= &pwm8_bus_clk.common.hw,
> > +		[CLK_PWM9_BUS]		= &pwm9_bus_clk.common.hw,
> > +		[CLK_PWM10_BUS]		= &pwm10_bus_clk.common.hw,
> > +		[CLK_PWM11_BUS]		= &pwm11_bus_clk.common.hw,
> > +		[CLK_PWM12_BUS]		= &pwm12_bus_clk.common.hw,
> > +		[CLK_PWM13_BUS]		= &pwm13_bus_clk.common.hw,
> > +		[CLK_PWM14_BUS]		= &pwm14_bus_clk.common.hw,
> > +		[CLK_PWM15_BUS]		= &pwm15_bus_clk.common.hw,
> > +		[CLK_PWM16_BUS]		= &pwm16_bus_clk.common.hw,
> > +		[CLK_PWM17_BUS]		= &pwm17_bus_clk.common.hw,
> > +		[CLK_PWM18_BUS]		= &pwm18_bus_clk.common.hw,
> > +		[CLK_PWM19_BUS]		= &pwm19_bus_clk.common.hw,
> > +		[CLK_SSP3_BUS]		= &ssp3_bus_clk.common.hw,
> > +		[CLK_RTC_BUS]		= &rtc_bus_clk.common.hw,
> > +		[CLK_TWSI0_BUS]		= &twsi0_bus_clk.common.hw,
> > +		[CLK_TWSI1_BUS]		= &twsi1_bus_clk.common.hw,
> > +		[CLK_TWSI2_BUS]		= &twsi2_bus_clk.common.hw,
> > +		[CLK_TWSI4_BUS]		= &twsi4_bus_clk.common.hw,
> > +		[CLK_TWSI5_BUS]		= &twsi5_bus_clk.common.hw,
> > +		[CLK_TWSI6_BUS]		= &twsi6_bus_clk.common.hw,
> > +		[CLK_TWSI7_BUS]		= &twsi7_bus_clk.common.hw,
> > +		[CLK_TWSI8_BUS]		= &twsi8_bus_clk.common.hw,
> > +		[CLK_TIMERS1_BUS]	= &timers1_bus_clk.common.hw,
> > +		[CLK_TIMERS2_BUS]	= &timers2_bus_clk.common.hw,
> > +		[CLK_AIB_BUS]		= &aib_bus_clk.common.hw,
> > +		[CLK_ONEWIRE_BUS]	= &onewire_bus_clk.common.hw,
> > +		[CLK_SSPA0_BUS]		= &sspa0_bus_clk.common.hw,
> > +		[CLK_SSPA1_BUS]		= &sspa1_bus_clk.common.hw,
> > +		[CLK_TSEN_BUS]		= &tsen_bus_clk.common.hw,
> > +		[CLK_IPC_AP2AUD_BUS]	= &ipc_ap2aud_bus_clk.common.hw,
> > +	},
> > +	.num = CLK_APBC_NUM,
> > +};
> > +
> > +static struct clk_hw_onecell_data k1_ccu_apmu_clks = {
> > +	.hws = {
> > +		[CLK_CCI550]		= &cci550_clk.common.hw,
> > +		[CLK_CPU_C0_HI]		= &cpu_c0_hi_clk.common.hw,
> > +		[CLK_CPU_C0_CORE]	= &cpu_c0_core_clk.common.hw,
> > +		[CLK_CPU_C0_ACE]	= &cpu_c0_ace_clk.common.hw,
> > +		[CLK_CPU_C0_TCM]	= &cpu_c0_tcm_clk.common.hw,
> > +		[CLK_CPU_C1_HI]		= &cpu_c1_hi_clk.common.hw,
> > +		[CLK_CPU_C1_CORE]	= &cpu_c1_core_clk.common.hw,
> > +		[CLK_CPU_C1_ACE]	= &cpu_c1_ace_clk.common.hw,
> > +		[CLK_CCIC_4X]		= &ccic_4x_clk.common.hw,
> > +		[CLK_CCIC1PHY]		= &ccic1phy_clk.common.hw,
> > +		[CLK_SDH_AXI]		= &sdh_axi_aclk.common.hw,
> > +		[CLK_SDH0]		= &sdh0_clk.common.hw,
> > +		[CLK_SDH1]		= &sdh1_clk.common.hw,
> > +		[CLK_SDH2]		= &sdh2_clk.common.hw,
> > +		[CLK_USB_P1]		= &usb_p1_aclk.common.hw,
> > +		[CLK_USB_AXI]		= &usb_axi_clk.common.hw,
> > +		[CLK_USB30]		= &usb30_clk.common.hw,
> > +		[CLK_QSPI]		= &qspi_clk.common.hw,
> > +		[CLK_QSPI_BUS]		= &qspi_bus_clk.common.hw,
> > +		[CLK_DMA]		= &dma_clk.common.hw,
> > +		[CLK_AES]		= &aes_clk.common.hw,
> > +		[CLK_VPU]		= &vpu_clk.common.hw,
> > +		[CLK_GPU]		= &gpu_clk.common.hw,
> > +		[CLK_EMMC]		= &emmc_clk.common.hw,
> > +		[CLK_EMMC_X]		= &emmc_x_clk.common.hw,
> > +		[CLK_AUDIO]		= &audio_clk.common.hw,
> > +		[CLK_HDMI]		= &hdmi_mclk.common.hw,
> > +		[CLK_PMUA_ACLK]		= &pmua_aclk.common.hw,
> > +		[CLK_PCIE0]		= &pcie0_clk.common.hw,
> > +		[CLK_PCIE1]		= &pcie1_clk.common.hw,
> > +		[CLK_PCIE2]		= &pcie2_clk.common.hw,
> > +		[CLK_EMAC0_BUS]		= &emac0_bus_clk.common.hw,
> > +		[CLK_EMAC0_PTP]		= &emac0_ptp_clk.common.hw,
> > +		[CLK_EMAC1_BUS]		= &emac1_bus_clk.common.hw,
> > +		[CLK_EMAC1_PTP]		= &emac1_ptp_clk.common.hw,
> > +		[CLK_JPG]		= &jpg_clk.common.hw,
> > +		[CLK_CCIC2PHY]		= &ccic2phy_clk.common.hw,
> > +		[CLK_CCIC3PHY]		= &ccic3phy_clk.common.hw,
> > +		[CLK_CSI]		= &csi_clk.common.hw,
> > +		[CLK_CAMM0]		= &camm0_clk.common.hw,
> > +		[CLK_CAMM1]		= &camm1_clk.common.hw,
> > +		[CLK_CAMM2]		= &camm2_clk.common.hw,
> > +		[CLK_ISP_CPP]		= &isp_cpp_clk.common.hw,
> > +		[CLK_ISP_BUS]		= &isp_bus_clk.common.hw,
> > +		[CLK_ISP]		= &isp_clk.common.hw,
> > +		[CLK_DPU_MCLK]		= &dpu_mclk.common.hw,
> > +		[CLK_DPU_ESC]		= &dpu_esc_clk.common.hw,
> > +		[CLK_DPU_BIT]		= &dpu_bit_clk.common.hw,
> > +		[CLK_DPU_PXCLK]		= &dpu_pxclk.common.hw,
> > +		[CLK_DPU_HCLK]		= &dpu_hclk.common.hw,
> > +		[CLK_DPU_SPI]		= &dpu_spi_clk.common.hw,
> > +		[CLK_DPU_SPI_HBUS]	= &dpu_spi_hbus_clk.common.hw,
> > +		[CLK_DPU_SPIBUS]	= &dpu_spi_bus_clk.common.hw,
> > +		[CLK_DPU_SPI_ACLK]	= &dpu_spi_aclk.common.hw,
> > +		[CLK_V2D]		= &v2d_clk.common.hw,
> > +		[CLK_EMMC_BUS]		= &emmc_bus_clk.common.hw,
> > +	},
> > +	.num = CLK_APMU_NUM
> > +};
> > +
> 
> The only time the "PLL lock" is needed is with PLL clocks.  Can you
> encode this flag, or perhaps the address of the lock register,
> into the ccu_pll structure instead somehow?
>
> If so you wouldn't need this spacemit_ccu_data structure, and could
> simply use the clk_hw_onecell_data structure in its place.

We could scan the clk_hw_onecell_data array before the probing, but I
don't think it's worth.

As the raw clk_hw_onecell_data is likely to be removed in the next
revision, I'll try to avoid the flag during refactoring.

> > +struct spacemit_ccu_data {
> > +	struct clk_hw_onecell_data *hw_clks;
> > +	bool need_pll_lock;
> > +};
> > +
> 
> You should get rid of the spacemit_ccu_priv structure.  More below.
> 
> > +struct spacemit_ccu_priv {
> > +	const struct spacemit_ccu_data *data;
> > +	struct regmap *base;
> > +	struct regmap *lock_base;
> > +};
> > +
> 
> You use the fields in the above priv structure temporarily,
> to pass three values into spacemit_ccu_register().  Just pass
> those three values as arguments to this function, and get rid
> of the structure.

Thanks, it makes sense.

> > +static int spacemit_ccu_register(struct device *dev,
> > +				 struct spacemit_ccu_priv *priv)
> > +{
> > +	const struct spacemit_ccu_data *data = priv->data;
> 
> You never use the data pointer, except when you're using
> its hw_clks field.  So it would be better to do:
> 
>     struct clk_hw_onecell_data *hw_clks = &priv->data.hw_clks;
> 
> Then use that.  If you eliminated the spacemit_ccu_data
> type as I suggested above, you could just pass in the
> clk_hw_onecell_data pointer as an argument.
>
> > +	int i, ret;
> > +
> > +	for (i = 0; i < data->hw_clks->num; i++) {
> > +		struct clk_hw *hw = data->hw_clks->hws[i];
> 
> I think the hw pointer should probably be const.  There may
> be other spots that should be const as well.

Yes, I don't think a lot about the constant when writing this, will look
through later and see where it applies.

> > +		struct ccu_common *common;
> > +		const char *name;
> 
> Don't bother with the name variable.
> 
> > +
> > +		if (!hw)
> > +			continue;
> > +
> > +		common = hw_to_ccu_common(hw);
> > +		name = hw->init->name;
> > +
> 
> The next two pointers are regmap pointers.  Could the
> name of the fields suggest that?  (They sound like raw
> memory addresses to me.)

Do "common.regmap" and "common.lock_regmap" sound better for you?

> > +		common->base		= priv->base;
> > +		common->lock_base	= priv->lock_base;
> > +
> > +		ret = devm_clk_hw_register(dev, hw);
> > +		if (ret) {
> > +			dev_err(dev, "Cannot register clock %d - %s\n",
> > +				i, name);
> 
> Just use hw->init->name here instead of name.

Will change in the next version.

> > +			return ret;
> > +		}
> > +	}
> > +
> > +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> > +					   data->hw_clks);
> > +}
> > +
> > +static int k1_ccu_probe(struct platform_device *pdev)
> > +{
> > +	const struct spacemit_ccu_data *data;
> > +	struct regmap *base_map, *lock_map = NULL;
> > +	struct device *dev = &pdev->dev;
> > +	struct spacemit_ccu_priv *priv;
> > +	struct device_node *parent;
> > +	int ret;
> > +
> > +	data = of_device_get_match_data(dev);
> 
> You can tell by inspection that data will never be null.
> So the next two lines can go away.

Will, will fix this in the next version.

> > +	if (WARN_ON(!data))
> > +		return -EINVAL;
> > +
> > +	parent   = of_get_parent(dev->of_node);
> > +	base_map = syscon_node_to_regmap(parent);
> > +	of_node_put(parent);
> > +
> > +	if (IS_ERR(base_map))
> > +		return dev_err_probe(dev, PTR_ERR(base_map),
> > +				     "failed to get regmap\n");
> > +
> > +	if (data->need_pll_lock) {
> 
> This is the weird part that requires the MPMU CCU to get
> fully probed before the APBC CCU can complete its probe.
> It would be nice if all the clocks shared their address
> ranges somehow to avoid this, but I'm not sure that maps
> well to the hardware.
> 
> > +		lock_map = syscon_regmap_lookup_by_phandle(dev->of_node,
> > +							   "spacemit,mpmu");
> > +		if (IS_ERR(lock_map))
> > +			return dev_err_probe(dev, PTR_ERR(lock_map),
> > +					     "failed to get lock regmap\n");
> > +	}
> > +
> 
> You allocate the priv structure, but never free it (a bug).
> It only holds 3 values; just pass them as arguments when
> registering the CCU, as suggested above.

The allocation is done through a devres variant, it should be released
automatically. Please correct me if I'm wrong.

> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->data	= data;
> > +	priv->base	= base_map;
> > +	priv->lock_base	= lock_map;
> > +
> > +	ret = spacemit_ccu_register(dev, priv);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to register clocks\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct spacemit_ccu_data k1_ccu_apbs_data = {
> > +	.need_pll_lock	= true,
> > +	.hw_clks	= &k1_ccu_apbs_clks,
> > +};
> > +
> > +static const struct spacemit_ccu_data k1_ccu_mpmu_data = {
> > +	.need_pll_lock	= false,
> > +	.hw_clks	= &k1_ccu_mpmu_clks,
> > +};
> > +
> > +static const struct spacemit_ccu_data k1_ccu_apbc_data = {
> > +	.need_pll_lock	= false,
> > +	.hw_clks	= &k1_ccu_apbc_clks,
> > +};
> > +
> > +static const struct spacemit_ccu_data k1_ccu_apmu_data = {
> > +	.need_pll_lock	= false,
> > +	.hw_clks	= &k1_ccu_apmu_clks,
> > +};
> > +
> > +static const struct of_device_id of_k1_ccu_match[] = {
> > +	{
> > +		.compatible	= "spacemit,k1-ccu-apbs",
> > +		.data		= &k1_ccu_apbs_data,
> > +	},
> > +	{
> > +		.compatible	= "spacemit,k1-ccu-mpmu",
> > +		.data		= &k1_ccu_mpmu_data,
> > +	},
> > +	{
> > +		.compatible	= "spacemit,k1-ccu-apbc",
> > +		.data		= &k1_ccu_apbc_data,
> > +	},
> > +	{
> > +		.compatible	= "spacemit,k1-ccu-apmu",
> > +		.data		= &k1_ccu_apmu_data,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
> > +
> > +static struct platform_driver k1_ccu_driver = {
> > +	.driver = {
> > +		.name		= "spacemit,k1-ccu",
> > +		.of_match_table = of_k1_ccu_match,
> > +	},
> > +	.probe	= k1_ccu_probe,
> > +};
> > +module_platform_driver(k1_ccu_driver);
> > +
> > +MODULE_DESCRIPTION("Spacemit K1 CCU driver");
> > +MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
> > +MODULE_LICENSE("GPL");
> 
> End of "ccu-k1.c"!!!

It's really a lot of lines lol

> > diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
> > new file mode 100644
> > index 000000000000..242461ee592f
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_common.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#ifndef _CCU_COMMON_H_
> > +#define _CCU_COMMON_H_
> > +
> > +#include <linux/regmap.h>
> > +
> > +struct ccu_common {
> > +	struct regmap *base;
> > +	struct regmap *lock_base;
> > +
> > +	union {
> 
> The following struct is used for all clocks except PLL.
> 
> > +		struct {
> > +			u32 reg_ctrl;
> 
> The reg_sel field is never needed and can go away.
> 
> > +			u32 reg_sel;
> > +			u32 reg_fc;
> > +			u32 fc;
> > +		};
> 
> Add a comment indicating that the following struct is used only
> for PLL type clocks.
> 
> > +		struct {
> > +			u32 reg_swcr1;
> 
> The reg_swcr2 field is never needed and can go away.
>
> > +			u32 reg_swcr2;
> > +			u32 reg_swcr3;
> > +		};
> > +	};
> > +
> > +	unsigned long flags;
> 
> I don't believe the name field here is *ever* used, despite
> being assigned for every clock.  The name is put into the
> hw.init structure, so there's no need for this one.
> 
> > +	const char *name;
> 
> The parent_names field here is also not used.  The names of
> the parent clocks are provided to the hw.init structure
> though.
> 
> > +	const char * const *parent_names;
> 
> The num_parents field isn't necessary.  It seems to be used when
> looping through parents in ccu_mix_calc_best_rate(), but I think
> the number can be looked up with clk_hw_get_num_parents() as is
> done in ccu_mux_get_parent().

Thanks, comments above all make sense to me. Will adapt them in the next
revision.

> > +	int num_parents;
> > +
> > +	struct clk_hw hw;
> > +};
> > +
> > +static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
> > +{
> > +	return container_of(hw, struct ccu_common, hw);
> > +}
> > +
> 
> Although I think the following macros are nice and concise, they
> obscure the fact that they're essentially renaming existing
> regmap operations.  They don't really add much value; the
> regmap functions are pretty clear.

They're just for saving some characters,

	regmap_read(common->base, common->reg_ctrl, &tmp)

is much longer than

	ccu_read(common, ctrl, &tmp)

Of course it could be changed, if you're still strongly against it,

> Although regmap_read() returns a value, you never check for an
> error when calling ccu_read().

I don't expect that access to a MMIO regmap could fail. There shouldn't
be any cases of failure, so I don't check it.

> > +#define ccu_read(reg, c, val)	regmap_read((c)->base, (c)->reg_##reg, val)
> 
> The ccu_write() macro is never used.

Yes, most operations are done through ccu_update, which ensures the
atomicity. As reset controllers that will be introduced in the future
share some registers with the clock controller, it's a must. I agree
on a removal.

> > +#define ccu_write(reg, c, val)	regmap_write((c)->base, (c)->reg_##reg, val)
> 
> Although regmap_update_bits() returns a value, you never check
> for an error when calling ccu_update().
> 
> > +#define ccu_update(reg, c, mask, val) \
> > +	regmap_update_bits((c)->base, (c)->reg_##reg, mask, val)
> 
> 
> You *do* look at the return value for ccu_poll()!!!

Because polling for a condition MAY timeout and we want to report the
failure if the PLL doesn't lock or the frequency changing request does
not complete in a reasonable period. This differs from the simple read
and update cases.

> > +#define ccu_poll(reg, c, tmp, cond, sleep, timeout) \
> > +	regmap_read_poll_timeout_atomic((c)->base, (c)->reg_##reg,	\
> > +					tmp, cond, sleep, timeout)
> > +
> > +#endif /* _CCU_COMMON_H_ */
> > diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
> > new file mode 100644
> > index 000000000000..1df555888ecb
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_ddn.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Spacemit clock type ddn
> > + *
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_ddn.h"
> 
> What does "DDN" stand for?

I'm not sure, the name is kept from the vendor driver. I could change it
to a more descriptive name, like "fraction-factor".

Thanks for pointing out problems in frequency calculation, they all make
sense. I have to admit this clock type is quite ugly and plan to rewrite
it to reuse code in clk-fraction-divider in the next version.

> > +
> > +/*
> > + * It is M/N clock
> > + *
> > + * Fout from synthesizer can be given from two equations:
> > + * numerator/denominator = Fin / (Fout * factor)
> > + */
> 
> The next three functions are never used and can be removed.
> 
> The reason is that the only time they'd be used is when
> CCU_DDN_GATE_DEFINE() (defined in "ccu_ddn.h") is called,
> but it never is.  So you can get rid of CCU_DDN_GATE_DEFINE(),
> and once you do that there's no need for ccu_ddn_disable(),
> ccu_ddn_enable(), and ccu_ddn_is_enabled().  Furthermore,
> these three functions are the only place the "reg_sel"
> field in the ccu_common structure is used, and without
> these functions, that field serves no purpose.  So that
> field can go away, and there's no need to provide a value
> for initializing it in all those clock definition macros.

When cleaning up the driver from the vendor source, I tried to keep most
clock types included since future SpacemiT SoCs made may make use of
them. It seems too farsighted as this patch is already quite large.

I'll remove the unused clock types as well as the reg_sel field, thanks.

> > +static void ccu_ddn_disable(struct clk_hw *hw)
> > +{
> > +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> > +	struct ccu_common *common = &ddn->common;
> > +
> > +	ccu_update(sel, common, ddn->gate, 0);
> > +}
> > +
> > +static int ccu_ddn_enable(struct clk_hw *hw)
> > +{
> > +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> > +	struct ccu_common *common = &ddn->common;
> > +
> > +	ccu_update(sel, common, ddn->gate, ddn->gate);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ccu_ddn_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> > +	struct ccu_common *common = &ddn->common;
> > +	u32 tmp;
> > +
> > +	ccu_read(sel, common, &tmp);
> > +
> > +	return tmp & ddn->gate;
> > +}
> > +
> 
> Defining a ->determine_rate() is better than ->round_rate(),
> given you implement multiplexed parent clocks.
>
> > +static long clk_ddn_round_rate(struct clk_hw *hw, unsigned long drate,
> > +			       unsigned long *prate)
> > +{
> > +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> > +	struct ccu_ddn_config *params = &ddn->ddn;
> > +	unsigned long rate = 0, prev_rate;
> > +	unsigned long result;
> > +	int i;
> > +
> > +	for (i = 0; i < params->tbl_size; i++) {
> > +		prev_rate = rate;
> 
> I'm going to say more about this below, but I think the
> factor can be removed and hard-coded here.

Alright, we could hardcode it for now to make the patch as simple as
possible. If different factors are used in future SoCs, it isn't hard
to add it back later.

> > +		rate = (*prate * params->tbl[i].den) /
> > +			(params->tbl[i].num * params->info->factor);
> 
> I think you want this to use >= in the comparison.  If the
> rate is *exactly* the desired rate, that's what you want
> to use.
> 
> > +		if (rate > drate)
> > +			break;
> > +	}
> > +
> 
> I'm pretty sure the table size is always non-zero.  And if
> so, the above loop can be a do...while, which I think
> would mean there's no need to to treat i == 0 specially.
> You still would want to return 0 if no entry is found.
> 
> > +	if ((i == 0) || (i == params->tbl_size)) {
> > +		result = rate;
> > +	} else {
> > +		if ((drate - prev_rate) > (rate - drate))
> > +			result = rate;
> > +		else
> > +			result = prev_rate;
> > +	}
> > +
> > +	return result;
> > +}
> > +
> > +static unsigned long clk_ddn_recalc_rate(struct clk_hw *hw,
> > +					 unsigned long parent_rate)
> > +{
> > +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> > +	struct ccu_ddn_config *params = &ddn->ddn;
> > +	unsigned int val, num, den;
> > +	unsigned long rate;
> > +
> > +	ccu_read(ctrl, &ddn->common, &val);
> > +
> > +	num = (val >> params->info->num_shift) & params->info->num_mask;
> > +	den = (val >> params->info->den_shift) & params->info->den_mask;
> > +
> > +	if (!den)
> > +		return 0;
> > +
> 
> Here too, I think the factor can be hard-coded.
> 
> > +	rate = (parent_rate * den) / (num * params->info->factor);
> > +
> > +	return rate;
> > +}
> > +
> > +/* Configures new clock rate*/
> > +static int clk_ddn_set_rate(struct clk_hw *hw, unsigned long drate,
> > +			    unsigned long prate)
> > +{
> > +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> > +	struct ccu_ddn_config *params = &ddn->ddn;
> > +	struct ccu_ddn_info *info = params->info;
> > +	unsigned long rate = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < params->tbl_size; i++) {
> 
> The way you calculate the output rate here tells me that your
> "num" and "den" field names are completely backward.
>
> The numerator is the top part of a fraction and the
> denominator is the bottom.

I'm not a native speaker and haven't noted the error, thanks for
pointing it out. Will fix it.

>    output_rate = parent_rate * numerator / (denominator * factor)
> 
> Please fix this naming (carefully).  (And I propose hard-coding
> the factor here as well.)
> 
> > +		rate = (prate * params->tbl[i].den) /
> > +		       (params->tbl[i].num * info->factor);
> > +
> 
> Here too, I think you want >=, not > in the comparison.
> 
> > +		if (rate > drate)
> > +			break;
> > +	}
> > +
> > +	if (i > 0)
> > +		i--;
> > +
> > +	ccu_update(ctrl, &ddn->common,
> > +		   info->num_mask | info->den_mask,
> > +		   (params->tbl[i].num << info->num_shift) |
> > +		   (params->tbl[i].den << info->den_shift));
> > +
> > +	return 0;
> > +}
> > +
> > +const struct clk_ops spacemit_ccu_ddn_ops = {
> > +	.recalc_rate	= clk_ddn_recalc_rate,
> > +	.round_rate	= clk_ddn_round_rate,
> > +	.set_rate	= clk_ddn_set_rate,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_ddn_gate_ops = {
> > +	.disable	= ccu_ddn_disable,
> > +	.enable		= ccu_ddn_enable,
> > +	.is_enabled	= ccu_ddn_is_enabled,
> > +	.recalc_rate	= clk_ddn_recalc_rate,
> > +	.round_rate	= clk_ddn_round_rate,
> > +	.set_rate	= clk_ddn_set_rate,
> > +};
> > diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
> > new file mode 100644
> > index 000000000000..6fa658bcd50a
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_ddn.h
> > @@ -0,0 +1,84 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#ifndef _CCU_DDN_H_
> > +#define _CCU_DDN_H_
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_common.h"
> > +
> 
> This struct definition is fine, but I think the way you used the
> fields is completely wrong (as I said above).
> 
> > +struct ccu_ddn_tbl {
> > +	unsigned int num;
> > +	unsigned int den;
> > +};
> > +
> 
> Maybe the factor is included here to somehow match the way the
> hardware works.  In practice, the factor is an additional divider
> for the parent clock rate.
> 
> The reality is there are only two DDN clocks, and both of them
> supply 2 for the factor.  So rather than using a separate field
> to hold that value, just incorporate the additional factor of 2
> where the rates are calculated in the code.  Add a comment to
> explain if it helps.
> 
> > +struct ccu_ddn_info {
> > +	unsigned int factor;
> 
> Here is a general comment that applies to a bunch of places in
> this code.  You can concisely define a field with a single
> mask value.  That means there is no need to define both a mask
> (or a field width) and a shift.  What you need is defined in
> <linux/bitfield.h>.  There you will find a set of macros
> like FIELD_GET() and FIELD_PREP(), or alternatively a set
> of inline functions like u32_get_bits() and u32_encode_bits().

I think both macros and inline functions in bitfield.h work with only
constant masks. With non-constant masks, some checks cannot be optimized
out, resulting in compilation errors.

> > +	unsigned int num_mask;
> > +	unsigned int den_mask;
> > +	unsigned int num_shift;
> > +	unsigned int den_shift;
> > +};
> 
> So instead of defining this:
> 
>     static struct ccu_ddn_info uart_ddn_mask_info = {
>         .factor         = 2,
>         .num_mask       = 0x1fff,
>         .den_mask       = 0x1fff,
>         .num_shift      = 16,
>         .den_shift      = 0,
>     };
> 
> You can define:
> 
>     static struct ccu_ddn_info uart_ddn_mask_info = {
>         .factor         = 2,
>         .num_mask       = 0x1fff0000,
>         .den_mask       = 0x00001fff,
>     };
> 
> And then you use those masks with the helper functions
> to extract or encode values from or two fields.  I'm not
> going to say more here about how to do that, but I'll
> point out some more places where this suggestion applies.
>
> > +
> > +struct ccu_ddn_config {
> > +	struct ccu_ddn_info *info;
> > +	struct ccu_ddn_tbl *tbl;
> > +	u32 tbl_size;
> 
> I mentioned this earlier.  In the two DDN clocks defined, both
> have a single entry table.  So rather than defining this with
> a poitner to a table and a table size, just define the num
> and den fields directly in this structure.
> 
> > +};
> > +
> > +struct ccu_ddn {
> > +	struct ccu_ddn_config  ddn;
> > +	struct ccu_common	common;
> > +	u32 gate;
> > +};
> > +
> > +#define CCU_DDN_CONFIG(_info, _table)					\
> > +	{								\
> > +		.info		= (struct ccu_ddn_info *)_info,		\
> > +		.tbl		= (struct ccu_ddn_tbl *)&_table,	\
> > +		.tbl_size	= ARRAY_SIZE(_table),			\
> > +	}
> > +
> > +#define CCU_DDN_INIT(_name, _parent, _ops, _flags) \
> > +	CLK_HW_INIT_HW(_name, &_parent.common.hw, &_ops, _flags)
> > +
> > +#define CCU_DDN_DEFINE(_struct, _name, _parent, _info, _table,			\
> > +		       _reg_ctrl, _flags)					\
> > +	struct ccu_ddn _struct = {						\
> > +		.ddn	= CCU_DDN_CONFIG(_info, _table),			\
> > +		.common = {							\
> > +			.reg_ctrl = _reg_ctrl,					\
> > +			.hw.init  = CCU_DDN_INIT(_name, _parent,		\
> > +						 spacemit_ccu_ddn_ops,		\
> > +						 _flags),			\
> > +		}								\
> > +	}
> > +
> 
> As mentioned before, the following macro is never used and can be
> removed.  That means a bunch of other things can be removed as well.
> 
> > +#define CCU_DDN_GATE_DEFINE(_struct, _name, _parent, _info, _table,		\
> > +			    _reg_ddn, _reg_gate, _gate_mask, _flags)		\
> > +	struct ccu_ddn _struct = {						\
> > +		.ddn	= CCU_DDN_CONFIG(_info, _table),			\
> > +		.common = {							\
> > +			.reg_ctrl	= _reg_ddn,				\
> > +			.reg_sel	= _reg_gate,				\
> > +			.hw.init = CCU_DDN_INIT(_name, _parent,			\
> > +						&spacemit_ccu_ddn_gate_ops,	\
> > +						_flags),			\
> > +		}								\
> > +		.gate	= _gate_mask,						\
> > +	}
> > +
> > +static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
> > +{
> > +	struct ccu_common *common = hw_to_ccu_common(hw);
> > +
> > +	return container_of(common, struct ccu_ddn, common);
> > +}
> > +
> > +extern const struct clk_ops spacemit_ccu_ddn_ops, spacemit_ccu_ddn_gate_ops;
> > +
> > +#endif
> > diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> > new file mode 100644
> > index 000000000000..b46eeb59faea
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_mix.c
> > @@ -0,0 +1,304 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Spacemit clock type mix(div/mux/gate/factor)
> > + *
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_mix.h"
> > +
> > +#define MIX_TIMEOUT	10000
> > +
> > +static void ccu_gate_disable(struct clk_hw *hw)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_gate_config *gate = mix->gate;
> > +
> 
> I will explain more below.  But gate->val_disable can go
> away and you should just use 0 here.
> 
> > +	ccu_update(ctrl, common, gate->gate_mask, gate->val_disable);
> > +}
> > +
> > +static int ccu_gate_enable(struct clk_hw *hw)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_gate_config *gate = mix->gate;
> > +	u32 val_enable, mask;
> > +	u32 tmp;
> > +
> > +	val_enable	= gate->val_enable;
> > +	mask		= gate->gate_mask;
> > +
> > +	ccu_update(ctrl, common, mask, val_enable);
> > +
> > +	return ccu_poll(ctrl, common, tmp, (tmp & mask) == val_enable,
> > +			10, MIX_TIMEOUT);
> 
> Here too, val_enable can just go away, and this can be
> simplified:
> 
> 	return ccu_poll(ctrl, common, tmp, tmp & mask, 10, MIX_TIMEOUT);
> 
> > +}
> > +
> > +static int ccu_gate_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_gate_config *gate = mix->gate;
> > +	u32 tmp;
> > +
> > +	ccu_read(ctrl, common, &tmp);
> > +
> 
> With val_enable gone, this would be:
> 
> 	return !!(tmp & gate->gate_mask);
> 
> > +	return (tmp & gate->gate_mask) == gate->val_enable;
> > +}
> > +
> > +static unsigned long ccu_factor_recalc_rate(struct clk_hw *hw,
> > +					    unsigned long parent_rate)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +
> > +	return parent_rate * mix->factor->mul / mix->factor->div;
> > +}
> > +
> > +static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
> > +					 unsigned long parent_rate)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_div_config *div = mix->div;
> > +	unsigned long val;
> > +	u32 reg;
> > +
> > +	ccu_read(ctrl, common, &reg);
> > +
> > +	val = reg >> div->shift;
> > +	val &= (1 << div->width) - 1;
> > +
> > +	val = divider_recalc_rate(hw, parent_rate, val, div->table,
> > +				  div->flags, div->width);
> > +
> > +	return val;
> > +}
> > +
> > +static int ccu_mix_trigger_fc(struct clk_hw *hw)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	unsigned int val = 0;
> > +
> > +	ccu_update(fc, common, common->fc, common->fc);
> > +
> > +	return ccu_poll(fc, common, val, !(val & common->fc),
> > +			5, MIX_TIMEOUT);
> > +}
> > +
> > +static long ccu_factor_round_rate(struct clk_hw *hw, unsigned long rate,
> > +				  unsigned long *prate)
> > +{
> > +	return ccu_factor_recalc_rate(hw, *prate);
> > +}
> > +
> > +static int ccu_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> > +			       unsigned long parent_rate)
> > +{
> > +	return 0;
> > +}
> > +
> > +static unsigned long
> > +ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
> > +		       struct clk_hw **best_parent,
> > +		       unsigned long *best_parent_rate,
> > +		       u32 *div_val)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_div_config *div = mix->div;
> > +	u32 div_max = div ? 1 << div->width : 1;
> > +	unsigned long best_rate = 0;
> > +
> > +	for (int i = 0; i < common->num_parents; i++) {
> > +		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> 
> 		unsigned long parent_rate;
> 
> > +
> > +		if (!parent)
> > +			continue;
> > +
> > +		unsigned long parent_rate = clk_hw_get_rate(parent);
> 
> 		parent_rate = clk_hw_get_rate(parent);

Thanks, will fix the style.

> > +
> > +		for (int j = 1; j <= div_max; j++) {
> > +			unsigned long tmp = DIV_ROUND_UP_ULL(parent_rate, j);
> > +
> > +			if (abs(tmp - rate) < abs(best_rate - rate)) {
> > +				best_rate = tmp;
> > +
> > +				if (div_val)
> > +					*div_val = j - 1;
> > +
> > +				if (best_parent) {
> > +					*best_parent      = parent;
> > +					*best_parent_rate = parent_rate;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	return best_rate;
> > +}
> > +
> > +static int ccu_mix_determine_rate(struct clk_hw *hw,
> > +				  struct clk_rate_request *req)
> > +{
> > +	req->rate = ccu_mix_calc_best_rate(hw, req->rate,
> > +					   &req->best_parent_hw,
> > +					   &req->best_parent_rate,
> > +					   NULL);
> > +	return 0;
> > +}
> > +
> > +static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
> > +			    unsigned long parent_rate)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_div_config *div = mix->div;
> > +	int ret = 0, tmp = 0;
> > +	u32 current_div, target_div;
> > +
> > +	ccu_mix_calc_best_rate(hw, rate, NULL, NULL, &target_div);
> > +
> > +	ccu_read(ctrl, common, &tmp);
> > +
> > +	current_div = tmp >> div->shift;
> > +	current_div &= (1 << div->width) - 1;
> 
> With my suggested change for using bitfields, this would be:
> 
> 	current_div = u32_get_bits(tmp, div->mask);
> 

Sadly, I don't think it compiles :(

> > +
> > +	if (current_div == target_div)
> > +		return 0;
> > +
> > +	tmp = GENMASK(div->width + div->shift - 1, div->shift);
> 
> And the above would not be required; just use div->mask (which
> I'll define a little later).
> 
> > +
> > +	ccu_update(ctrl, common, tmp, target_div << div->shift);
> > +
> > +	if (common->reg_fc)
> > +		ret = ccu_mix_trigger_fc(hw);
> > +
> > +	return ret;
> > +}
> > +
> > +static u8 ccu_mux_get_parent(struct clk_hw *hw)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_mux_config *mux = mix->mux;
> > +	u32 reg;
> > +	u8 parent;
> > +
> > +	ccu_read(ctrl, common, &reg);
> > +
> > +	parent = reg >> mux->shift;
> > +	parent &= (1 << mux->width) - 1;
> > +
> > +	if (mux->table) {
> > +		int num_parents = clk_hw_get_num_parents(&common->hw);
> > +		int i;
> > +
> > +		for (i = 0; i < num_parents; i++)
> > +			if (mux->table[i] == parent)
> > +				return i;
> 
> I think if there is no table entry found there should at
> least be a WARN() call or something.

Yes, it makes sense.

> > +	}
> > +
> > +	return parent;
> > +}
> > +
> > +static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> > +{
> > +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> > +	struct ccu_common *common = &mix->common;
> > +	struct ccu_mux_config *mux = mix->mux;
> > +	int ret = 0;
> > +	u32 mask;
> > +
> > +	if (mux->table)
> 
> You should verify that the index is less than the
> number of entries in the table before you blindly
> dereference it here.

The desired index is found by searching in clk_fetch_parent_index(),
thus is always be valid, isn't it?

However, this is a dead codepath: no clock hardware comes with a valid
table. The whole if could be removed for simplication.

> > +		index = mux->table[index];
> > +
> > +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> > +
> > +	ccu_update(ctrl, common, mask, index << mux->shift);
> > +
> > +	if (common->reg_fc)
> > +		ret = ccu_mix_trigger_fc(hw);
> > +
> > +	return ret;
> > +}
> > +
> > +const struct clk_ops spacemit_ccu_gate_ops = {
> > +	.disable	= ccu_gate_disable,
> > +	.enable		= ccu_gate_enable,
> > +	.is_enabled	= ccu_gate_is_enabled,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_factor_ops = {
> > +	.round_rate	= ccu_factor_round_rate,
> > +	.recalc_rate	= ccu_factor_recalc_rate,
> > +	.set_rate	= ccu_factor_set_rate,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_mux_ops = {
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.get_parent	= ccu_mux_get_parent,
> > +	.set_parent	= ccu_mux_set_parent,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_div_ops = {
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.recalc_rate	= ccu_div_recalc_rate,
> > +	.set_rate	= ccu_mix_set_rate,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_gate_factor_ops = {
> > +	.disable	= ccu_gate_disable,
> > +	.enable		= ccu_gate_enable,
> > +	.is_enabled	= ccu_gate_is_enabled,
> > +
> > +	.round_rate	= ccu_factor_round_rate,
> > +	.recalc_rate	= ccu_factor_recalc_rate,
> > +	.set_rate	= ccu_factor_set_rate,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_mux_gate_ops = {
> > +	.disable	= ccu_gate_disable,
> > +	.enable		= ccu_gate_enable,
> > +	.is_enabled	= ccu_gate_is_enabled,
> > +
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.get_parent	= ccu_mux_get_parent,
> > +	.set_parent	= ccu_mux_set_parent,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_div_gate_ops = {
> > +	.disable	= ccu_gate_disable,
> > +	.enable		= ccu_gate_enable,
> > +	.is_enabled	= ccu_gate_is_enabled,
> > +
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.recalc_rate	= ccu_div_recalc_rate,
> > +	.set_rate	= ccu_mix_set_rate,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_div_mux_gate_ops = {
> > +	.disable	= ccu_gate_disable,
> > +	.enable		= ccu_gate_enable,
> > +	.is_enabled	= ccu_gate_is_enabled,
> > +
> > +	.get_parent	= ccu_mux_get_parent,
> > +	.set_parent	= ccu_mux_set_parent,
> > +
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.recalc_rate	= ccu_div_recalc_rate,
> > +	.set_rate	= ccu_mix_set_rate,
> > +};
> > +
> > +const struct clk_ops spacemit_ccu_div_mux_ops = {
> > +	.get_parent	= ccu_mux_get_parent,
> > +	.set_parent	= ccu_mux_set_parent,
> > +
> > +	.determine_rate = ccu_mix_determine_rate,
> > +	.recalc_rate	= ccu_div_recalc_rate,
> > +	.set_rate	= ccu_mix_set_rate,
> > +};
> > diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> > new file mode 100644
> > index 000000000000..97a3a099b42f
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_mix.h
> > @@ -0,0 +1,309 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#ifndef _CCU_MIX_H_
> > +#define _CCU_MIX_H_
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_common.h"
> > +
> > +struct ccu_gate_config {
> > +	u32 gate_mask;
> 
> Get rid of the val_enable and val_disable definitions.  In all cases,
> val_enable is equal to gate_mask (and in fact, there are a few gate
> masks made of more than a single bit).  And in all cases, val_disable
> is zero.  So just use gate_mask and 0 to represent enable and disable.

Will take it, this will simplify definitions a lot.

> > +	u32 val_enable;
> > +	u32 val_disable;
> > +	u32 flags;
> 
> When you have a flags field like this, it's helpful to add a comment
> that indicates what values it can take on.  I believe in all cases
> like this, the flags values are standard clock framework flags.

Yes.

> So what I mean is do something like this:
> 
>     u32 flags;		/* E.g., CLK_IGNORE_UNUSED */

Do you think

	u32 flags;		/* standard CCF flags */

ls more descriptive?

> > +};
> > +
> > +struct ccu_factor_config {
> > +	u32 div;
> > +	u32 mul;
> > +};
> > +
> > +struct ccu_mux_config {
> > +	const u8 *table;
> > +	u32 flags;
> > +	u8 shift;
> > +	u8 width;
> 
> The shift and width fields can be replaced with:
> 	u32 mask;
> 
> Where:
>     mask = ((1 << width) - 1) << shift;
> 
> > +};
> > +
> > +struct ccu_div_config {
> > +	struct clk_div_table *table;
> > +	u32 max;
> 
> I'm pretty sure the offset field here is unused and should be removed.

Thanks for finding this, I think the flags field in this structure and
ccu_mux_config aren't neccesary, either. Will remove them.

> > +	u32 offset;
> > +	u32 flags;
> > +	u8 shift;
> > +	u8 width;
> 
> The shift and width fields can be replaced with:
> 	u32 mask;
> 
> > +};
> > +
> > +struct ccu_mix {
> > +	struct ccu_factor_config *factor;
> > +	struct ccu_gate_config *gate;
> > +	struct ccu_div_config *div;
> > +	struct ccu_mux_config *mux;
> > +	struct ccu_common common;
> > +};
> > +
> > +#define CCU_GATE_INIT(_gate_mask, _val_enable, _val_disable, _flags)	\
> > +	(&(struct ccu_gate_config) {					\
> > +		.gate_mask   = _gate_mask,				\
> > +		.val_enable  = _val_enable,				\
> > +		.val_disable = _val_disable,				\
> > +		.flags	     = _flags,					\
> > +	})
> > +
> > +#define CCU_FACTOR_INIT(_div, _mul)					\
> > +	(&(struct ccu_factor_config) {					\
> > +		.div = _div,						\
> > +		.mul = _mul,						\
> > +	})
> > +
> > +
> 
> Pass a mask rather than _shift and _width here, and initialize
> the structure accordingly.
> 
> > +#define CCU_MUX_INIT(_shift, _width, _table, _flags)			\
> > +	(&(struct ccu_mux_config) {					\
> > +		.shift	= _shift,					\
> > +		.width	= _width,					\
> > +		.table	= _table,					\
> > +		.flags	= _flags,					\
> > +	})
> > +
> 
> Same here, use a mask rather than _shift and _width.
> 
> > +#define CCU_DIV_INIT(_shift, _width, _table, _flags)			\
> > +	(&(struct ccu_div_config) {					\
> > +		.shift	= _shift,					\
> > +		.width	= _width,					\
> > +		.flags	= _flags,					\
> > +		.table	= _table,					\
> > +	})
> > +
> > +#define CCU_PARENT_HW(_parent)		{ .hw = &_parent.common.hw }
> > +#define CCU_PARENT_NAME(_name)		{ .fw_name = #_name }
> > +
> > +#define CCU_MIX_INITHW(_name, _parent, _ops, _flags)			\
> > +	(&(struct clk_init_data) {					\
> > +		.flags		= _flags,				\
> > +		.name		= _name,				\
> > +		.parent_data	= (const struct clk_parent_data[])	\
> > +					{ _parent },			\
> > +		.num_parents	= 1,					\
> > +		.ops		= &_ops,				\
> > +	})
> > +
> > +#define CCU_MIX_INITHW_PARENTS(_name, _parents, _ops, _flags)		\
> > +	CLK_HW_INIT_PARENTS_DATA(_name, _parents,			\
> > +				 &_ops, _flags)
> > +
> 
> I'm almost certain that *all* calls to these *_DEFINE() macros pass
> the same name for the _struct value as the _name value, except the
> name is quoted.  So use the C preprocessor here, and just pass the
> non-quoted thing, and use #_struct to stringify it.  I'd rather the
> name of the argument be _name in that case.

This makes sense. Will simplify it.

> > +#define CCU_GATE_DEFINE(_struct, _name, _parent, _reg, _gate_mask,		\
> > +			 _val_enable, _val_disable, _flags)			\
> 
> There is one case where the _flags value is CLK_IGNORE_UNUSED, and
> one case where it is CLK_IS_CRITICAL.

The UART0 (booting UART) and all core clocks are marked as
CLK_IS_CRTICAL, not just one case.

> All others pass 0.  Given
> that, you could define two macros and remove the 0 argument from
> most of the callers:

I'd like to always keep the flags field, since keeping the clock
definitions intact and in the same format helps reading. There're a
bunch of clocks.

> #define CCU_GATE_DEFINE_FLAGS(..., _flags)
> 
> #define CCU_GATE_DEFINE(..., _val_disable) \
> 	CCU_GATE_DEFINE_FLAGS(..., _val_disable, 0)
> 
> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.common	= {								\
> > +		.reg_ctrl	= _reg,						\
> > +		.name		= _name,					\
> > +		.num_parents	= 1,						\
> > +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> > +					  spacemit_ccu_gate_ops, _flags),	\
> > +	}									\
> > +}
> > +
> 
> The _mul argument passed to CCU_FACTOR_DEFINE() is always 1.
> Just get rid of it, and use 1 for the value used in the macro.

Thanks for finding this, will take it.

> > +#define CCU_FACTOR_DEFINE(_struct, _name, _parent, _div, _mul)			\
> > +struct ccu_mix _struct = {							\
> > +	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
> > +	.common = {								\
> > +		.name		= _name,					\
> > +		.num_parents	= 1,						\
> > +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> > +					  spacemit_ccu_factor_ops, 0),		\
> > +	}									\
> > +}
> > +
> 
> Same suggestion as above here, given that _flags is almost always 0.
> 
> Also, pass a mask rather than _shift and _width here.  (I'm not going
> to repeat this suggestion any more).
> 
> > +#define CCU_MUX_DEFINE(_struct, _name, _parents, _reg, _shift, _width,		\
> > +		       _flags)							\
> > +struct ccu_mix _struct = {							\
> > +	.mux	= CCU_MUX_INIT(_shift, _width, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg,						\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_mux_ops,	_flags),\
> > +	}									\
> > +}
> > +
> 
> All three callers of this pass CLK_IS_CRITICAL for _flags.
> You could remove the argument and hard-code it, but I think
> you might want to change the name of the macro if so.

For the reason described above, I'd like to keep all the flags field.

> > +#define CCU_DIV_DEFINE(_struct, _name, _parent, _reg, _shift, _width,		\
> > +		       _flags)							\
> > +struct ccu_mix _struct = {							\
> > +	.div	= CCU_DIV_INIT(_shift, _width, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg,						\
> > +		.name		= _name,					\
> > +		.num_parents	= 1,						\
> > +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> > +					  spacemit_ccu_div_ops, _flags)		\
> > +	}									\
> > +}
> > +
> > +#define CCU_GATE_FACTOR_DEFINE(_struct, _name, _parent, _reg,			\
> > +			       _gate_mask, _val_enable, _val_disable,		\
> 
> You can get rid of _val_enable and _val_disable here; just
> use _gate_mask and 0 in their place.
> 
> > +			       _div, _mul, _flags)				\
> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg,						\
> > +		.name		= _name,					\
> > +		.num_parents	= 1,						\
> > +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> > +					  spacemit_ccu_gate_factor_ops, _flags)	\
> > +	}									\
> > +}
> > +
> > +#define CCU_MUX_GATE_DEFINE(_struct, _name, _parents, _reg, _shift,		\
> > +			    _width, _gate_mask, _val_enable,			\
> 
> Get rid of _val_enable and _val_disable here too.  (I'm not going
> to repeat this suggestion any more.)
> 
> > +			    _val_disable, _flags)				\
> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.mux	= CCU_MUX_INIT(_shift, _width, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg,						\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_mux_gate_ops,	\
> > +						  _flags),			\
> > +	}									\
> > +}
> > +
> > +#define CCU_DIV_GATE_DEFINE(_struct, _name, _parent, _reg, _shift,		\
> > +			    _width, _gate_mask, _val_enable,			\
> > +			    _val_disable, _flags)				\
> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.div	= CCU_DIV_INIT(_shift, _width, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg,						\
> > +		.name		= _name,					\
> > +		.num_parents	= 1,						\
> > +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> > +					  spacemit_ccu_div_gate_ops, _flags),	\
> > +	}									\
> > +}
> > +
> > +#define CCU_DIV_MUX_GATE_DEFINE(_struct, _name, _parents,  _reg_ctrl,		\
> > +				_mshift, _mwidth, _muxshift, _muxwidth,		\
> > +				_gate_mask, _val_enable, _val_disable,		\
> > +				_flags)						\
> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),			\
> > +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),			\
> > +	.common	= {								\
> > +		.reg_ctrl	= _reg_ctrl,					\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_div_mux_gate_ops,\
> > +						  _flags),			\
> > +	},									\
> > +}
> > +
> 
> I'd put the "2" somewhere else in the name of this.  It suggests
> "divide by two" but it's really a "second DIV_FC_MUX_GATE" macro.

Is DIV_SPLIT_FC_MUX_GATE a better name? The difference between this and
DIV_FC_MUX_GATE is that the fc bit locates in a different register.

> > +#define CCU_DIV2_FC_MUX_GATE_DEFINE(_struct, _name, _parents,			\
> > +				    _reg_ctrl, _reg_fc, _mshift,		\
> > +				    _mwidth, _fc, _muxshift, _muxwidth,		\
> > +				    _gate_mask, _val_enable,			\
> > +				    _val_disable, _flags)			\
> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),			\
> > +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg_ctrl,					\
> > +		.reg_fc		= _reg_fc,					\
> > +		.fc		= _fc,						\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_div_mux_gate_ops,\
> > +						  _flags),			\
> > +	},									\
> > +}
> > +
> > +#define CCU_DIV_FC_MUX_GATE_DEFINE(_struct, _name, _parents, _reg_ctrl,		\
> > +				   _mshift, _mwidth, _fc, _muxshift,		\
> > +				   _muxwidth, _gate_mask, _val_enable,		\
> > +				   _val_disable, _flags)			\
> 
> The only difference between this and CCU_DIV2_...() above is that
> the other macro takes a _reg_fc argument.  Just pass _reg_ctrl for
> that, and define this macro in terms of the other one.

Thanks for the advice!

> > +struct ccu_mix _struct = {							\
> > +	.gate	= CCU_GATE_INIT(_gate_mask, _val_enable,			\
> > +				_val_disable, 0),				\
> > +	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),			\
> > +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg_ctrl,					\
> > +		.reg_fc		= _reg_ctrl,					\
> > +		.fc		= _fc,						\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_div_mux_gate_ops,\
> > +						  _flags),			\
> > +	},									\
> > +}
> > +
> > +#define CCU_DIV_FC_MUX_DEFINE(_struct, _name, _parents, _reg_ctrl,		\
> > +			      _mshift, _mwidth, _fc, _muxshift,			\
> > +			      _muxwidth, _flags)				\
> > +struct ccu_mix _struct = {							\
> > +	.div	= CCU_DIV_INIT(_mshift, _mwidth, NULL, 0),			\
> > +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg_ctrl,					\
> > +		.reg_fc		= _reg_ctrl,					\
> > +		.fc		= _fc,						\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_div_mux_ops,	\
> > +						  _flags),			\
> > +	},									\
> > +}
> > +
> > +#define CCU_MUX_FC_DEFINE(_struct, _name, _parents, _reg_ctrl, _fc,		\
> > +			  _muxshift, _muxwidth, _flags)				\
> > +struct ccu_mix _struct = {							\
> > +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth, NULL, 0),			\
> > +	.common = {								\
> > +		.reg_ctrl	= _reg_ctrl,					\
> > +		.reg_fc		= _reg_ctrl,					\
> > +		.fc		= _fc,						\
> > +		.name		= _name,					\
> > +		.num_parents	= ARRAY_SIZE(_parents),				\
> > +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> > +						  spacemit_ccu_mux_ops,	_flags)	\
> > +	},									\
> > +}
> > +
> > +static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
> > +{
> > +	struct ccu_common *common = hw_to_ccu_common(hw);
> > +
> > +	return container_of(common, struct ccu_mix, common);
> > +}
> > +
> > +extern const struct clk_ops spacemit_ccu_gate_ops, spacemit_ccu_factor_ops;
> > +extern const struct clk_ops spacemit_ccu_mux_ops, spacemit_ccu_div_ops;
> > +
> > +extern const struct clk_ops spacemit_ccu_gate_factor_ops;
> > +extern const struct clk_ops spacemit_ccu_div_gate_ops;
> > +extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> > +extern const struct clk_ops spacemit_ccu_div_mux_ops;
> > +
> > +extern const struct clk_ops spacemit_ccu_div_mux_gate_ops;
> > +#endif /* _CCU_DIV_H_ */
> > diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
> > new file mode 100644
> > index 000000000000..81b929ca1c5c
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_pll.c
> > @@ -0,0 +1,189 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Spacemit clock type pll
> > + *
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/regmap.h>
> > +
> > +#include "ccu_common.h"
> > +#include "ccu_pll.h"
> > +
> > +#define PLL_MIN_FREQ	600000000
> > +#define PLL_MAX_FREQ	3400000000
> > +#define PLL_DELAY_TIME	3000
> > +
> These four values are 1-byte components of what gets placed in
> the SWCR1 register, to manage the PLL clocks.  They all represent
> various things that configure the clock.  But in fact, this code
> doesn't care at all about the format.  All that matters is that
> certain combinations of them are well-defined, and produce a
> specific clock rate out of the PLL.
> 
> For that reason, I recommend you just do away with this whole notion
> of the four bytes being defined separately.  Just combine them all
> into a single 4-byte value that's sort of an abstract magic number.
> Then all of these definitions here can go away.  I'll explain more
> below.
> 
> > +#define PLL_SWCR1_REG5_OFF	0
> > +#define PLL_SWCR1_REG5_MASK	GENMASK(7, 0)
> > +#define PLL_SWCR1_REG6_OFF	8
> > +#define PLL_SWCR1_REG6_MASK	GENMASK(15, 8)
> > +#define PLL_SWCR1_REG7_OFF	16
> > +#define PLL_SWCR1_REG7_MASK	GENMASK(23, 16)
> > +#define PLL_SWCR1_REG8_OFF	24
> > +#define PLL_SWCR1_REG8_MASK	GENMASK(31, 24)
> > +
> 
> The SWCR2_* macros can all go away; they're never used (or needed).

Indeed, thanks for finding it.

> > +#define PLL_SWCR2_DIVn_EN(n)	BIT(n + 1)
> > +#define PLL_SWCR2_ATEST_EN	BIT(12)
> > +#define PLL_SWCR2_CKTEST_EN	BIT(13)
> > +#define PLL_SWCR2_DTEST_EN	BIT(14)
> > +
> 
> Here too, the "frc" and "int" parts of this register are ignored
> by this code.  The only thing that matters is that both match a
> particular value, and if they do, then they take part in the
> production of a specific PLL output rate.  So here too I
> suggest combining them into a single, 31-bit abstract magic
> value.

Will do the combination.

> The only other thing that matters in the SWCR3 register is
> the enable bit.
>
> > +#define PLL_SWCR3_DIV_FRC_OFF	0
> > +#define PLL_SWCR3_DIV_FRC_MASK	GENMASK(23, 0)
> > +#define PLL_SWCR3_DIV_INT_OFF	24
> > +#define PLL_SWCR3_DIV_INT_MASK	GENMASK(30, 24)
> > +#define PLL_SWCR3_EN		BIT(31)
> > +
> 
> This should be a Boolean function.
> 
> > +static int ccu_pll_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> 
> You could probably do something like hw_to_ccu_comm(hw).
> 
> > +	u32 tmp;
> > +
> > +	ccu_read(swcr3, &p->common, &tmp);
> > +
> > +	return tmp & PLL_SWCR3_EN;
> 
> 	return !!(tmp & PLL_SWCR3_EN);
> 
> > +}
> > +
> > +/* frequency unit Mhz, return pll vco freq */
> > +static unsigned long ccu_pll_get_vco_freq(struct clk_hw *hw)
> > +{
> > +	unsigned int reg5, reg6, reg7, reg8, size, i;
> > +	unsigned int div_int, div_frc;
> > +	struct ccu_pll_rate_tbl *freq_pll_regs_table;
> > +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> > +	struct ccu_common *common = &p->common;
> > +	u32 tmp;
> > +
> > +	ccu_read(swcr1, common, &tmp);
> > +	reg5 = (tmp & PLL_SWCR1_REG5_MASK) >> PLL_SWCR1_REG5_OFF;
> > +	reg6 = (tmp & PLL_SWCR1_REG6_MASK) >> PLL_SWCR1_REG6_OFF;
> > +	reg7 = (tmp & PLL_SWCR1_REG7_MASK) >> PLL_SWCR1_REG7_OFF;
> > +	reg8 = (tmp & PLL_SWCR1_REG8_MASK) >> PLL_SWCR1_REG8_OFF;
> 
> Here you're extracting the four bytes out of the value read from
> the SWCR1 register.
> 
> > +
> > +	ccu_read(swcr3, common, &tmp);
> 
> And here you're extracting the INT and FRC parts of the value
> read from the SWCR3 register.
> 
> > +	div_int = (tmp & PLL_SWCR3_DIV_INT_MASK) >> PLL_SWCR3_DIV_INT_OFF;
> > +	div_frc = (tmp & PLL_SWCR3_DIV_FRC_MASK) >> PLL_SWCR3_DIV_FRC_OFF;
> > +
> > +	freq_pll_regs_table = p->pll.rate_tbl;
> > +	size = p->pll.tbl_size;
> > +
> > +	for (i = 0; i < size; i++)
> 
> Then the only thing that matters is whether all four values in
> the table entry are equal to the four extracted values, *and*
> the div and frc values match as well.
> 
> Just do a single 4-byte comparision of the value read from SWCR1,
> and also a comparison of the value read from SWCR3 (with the enable
> bit masked off).
> 
> > +		if ((freq_pll_regs_table[i].reg5 == reg5) &&
> > +		    (freq_pll_regs_table[i].reg6 == reg6) &&
> > +		    (freq_pll_regs_table[i].reg7 == reg7) &&
> > +		    (freq_pll_regs_table[i].reg8 == reg8) &&
> > +		    (freq_pll_regs_table[i].div_int == div_int) &&
> > +		    (freq_pll_regs_table[i].div_frac == div_frc))
> > +			return freq_pll_regs_table[i].rate;
> > +
> > +	WARN_ON_ONCE(1);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ccu_pll_enable(struct clk_hw *hw)
> > +{
> > +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> > +	struct ccu_common *common = &p->common;
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	if (ccu_pll_is_enabled(hw))
> > +		return 0;
> > +
> > +	ccu_update(swcr3, common, PLL_SWCR3_EN, PLL_SWCR3_EN);
> > +
> > +	/* check lock status */
> > +	ret = regmap_read_poll_timeout_atomic(common->lock_base,
> > +					      p->pll.reg_lock,
> > +					      tmp,
> > +					      tmp & p->pll.lock_enable_bit,
> > +					      5, PLL_DELAY_TIME);
> > +
> > +	return ret;
> > +}
> > +
> > +static void ccu_pll_disable(struct clk_hw *hw)
> > +{
> > +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> > +	struct ccu_common *common = &p->common;
> > +
> > +	ccu_update(swcr3, common, PLL_SWCR3_EN, 0);
> > +}
> > +
> > +/*
> > + * pll rate change requires sequence:
> > + * clock off -> change rate setting -> clock on
> > + * This function doesn't really change rate, but cache the config
> 
> Actually, the function *does* seem to change the rate.
> (Fix this comment.)

Okay.

> > + */
> > +static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> > +			    unsigned long parent_rate)
> > +{
> > +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> > +	struct ccu_common *common = &p->common;
> > +	struct ccu_pll_config *params = &p->pll;
> > +	struct ccu_pll_rate_tbl *entry = NULL;
> > +	u32 mask, val;
> > +	int i;
> > +
> > +	for (i = 0; i < params->tbl_size; i++) {
> > +		if (rate == params->rate_tbl[i].rate) {
> > +			entry = &params->rate_tbl[i];
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (WARN_ON_ONCE(!entry))
> > +		return -EINVAL;
> > +
> > +	mask = PLL_SWCR1_REG5_MASK | PLL_SWCR1_REG6_MASK;
> > +	mask |= PLL_SWCR1_REG7_MASK | PLL_SWCR1_REG8_MASK;
> > +	val = entry->reg5 << PLL_SWCR1_REG5_OFF;
> > +	val |= entry->reg6 << PLL_SWCR1_REG6_OFF;
> > +	val |= entry->reg7 << PLL_SWCR1_REG7_OFF;
> > +	val |= entry->reg8 << PLL_SWCR1_REG8_OFF;
> > +	ccu_update(swcr1, common, mask, val);
> > +
> > +	mask = PLL_SWCR3_DIV_INT_MASK | PLL_SWCR3_DIV_FRC_MASK;
> > +	val = entry->div_int << PLL_SWCR3_DIV_INT_OFF;
> > +	val |= entry->div_frac << PLL_SWCR3_DIV_FRC_OFF;
> > +	ccu_update(swcr3, common, mask, val);
> > +
> > +	return 0;
> > +}
> > +
> > +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> > +					 unsigned long parent_rate)
> > +{
> > +	return ccu_pll_get_vco_freq(hw);
> > +}
> > +
> > +static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> > +			       unsigned long *prate)
> > +{
> > +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> > +	struct ccu_pll_config *params = &p->pll;
> > +	unsigned long max_rate = 0;
> 
> unsigned long long max_rate = 0;
> 
> (At least that's how it's defined in the ccu_pll_rate_tbl structure.)

Will change the member in ccu_pll_rate_tbl to unsigned long.

> > +	unsigned int i;
> > +
> > +	for (i = 0; i < params->tbl_size; i++) {
> > +		if (params->rate_tbl[i].rate <= rate) {
> > +			if (max_rate < params->rate_tbl[i].rate)
> > +				max_rate = params->rate_tbl[i].rate;
> > +		}
> > +	}
> > +
> 
> I don't like that you're passing a compile-time defined
> frequency (which might not match reality).

We could make the rate_tbl sorted, which should improve both set_rate
and round_rate a lot.

> > +	return MAX(max_rate, PLL_MIN_FREQ);
> > +}
> > +
> > +const struct clk_ops spacemit_ccu_pll_ops = {
> > +	.enable		= ccu_pll_enable,
> > +	.disable	= ccu_pll_disable,
> > +	.set_rate	= ccu_pll_set_rate,
> > +	.recalc_rate	= ccu_pll_recalc_rate,
> > +	.round_rate	= ccu_pll_round_rate,
> > +	.is_enabled	= ccu_pll_is_enabled,
> > +};
> > +
> > diff --git a/drivers/clk/spacemit/ccu_pll.h b/drivers/clk/spacemit/ccu_pll.h
> > new file mode 100644
> > index 000000000000..d3397120414e
> > --- /dev/null
> > +++ b/drivers/clk/spacemit/ccu_pll.h
> > @@ -0,0 +1,80 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> > + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> > + */
> > +
> > +#ifndef _CCU_PLL_H_
> > +#define _CCU_PLL_H_
> > +
> > +#include <linux/clk-provider.h>
> > +
> > +#include "ccu_common.h"
> > +
> > +struct ccu_pll_rate_tbl {
> 
> I'd prefer you define this as u64.  But if you meant to match what
> the clock routines use, I think that's unsigned long (not long long).
> 
> > +	unsigned long long rate;
> > +	u32 reg5;
> > +	u32 reg6;
> > +	u32 reg7;
> > +	u32 reg8;
> > +	unsigned int div_int;
> > +	unsigned int div_frac;
> > +};
> > +
> > +struct ccu_pll_config {
> 
> The rate_tbl is probably const, isn't it?
>
> > +	struct ccu_pll_rate_tbl *rate_tbl;
> > +	u32 tbl_size;
> > +	u32 reg_lock;
> > +	u32 lock_enable_bit;
> > +};
> > +
> 
> Here I recommend you define two combined magic values rather than
> all these arguments.
> 
> If reg5-reg8 are  0x67, 0xdd, 0x50, 0x00, then pass 0x0050dd67.
> 
> And if div_int is 0x43 and div_frac is 0xeaaaab, pass 0x43eaaaab.
> 
> > +#define CCU_PLL_RATE(_rate, _reg5, _reg6, _reg7, _reg8, _div_int, _div_frac) \
> > +	{									\
> > +		.rate		= (_rate),					\
> > +		.reg5		= (_reg5),					\
> > +		.reg6		= (_reg6),					\
> > +		.reg7		= (_reg7),					\
> > +		.reg8		= (_reg8),					\
> > +		.div_int	= (_div_int),				\
> > +		.div_frac	= (_div_frac),				\
> > +	}
> > +
> > +struct ccu_pll {
> > +	struct ccu_pll_config	pll;
> > +	struct ccu_common	common;
> > +};
> > +
> > +#define CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit) \
> > +	{									\
> 
> It shouldn't be necessary to type-cast the table here.  I think I
> saw this sort of thing elsewhere and didn't comment on it (and if
> that's true, fix those too).
>
> That's the end!

Really thanks for the detailed review!

> 					-Alex

Best regards,
Haylen Chu

[1]: https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#part603
[2]: https://developer.spacemit.com/documentation?token=LCrKwWDasiJuROkVNusc2pWTnEb#part271

