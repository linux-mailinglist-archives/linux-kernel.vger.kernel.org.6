Return-Path: <linux-kernel+bounces-559098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89127A5EF87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3913419C1104
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E02641D4;
	Thu, 13 Mar 2025 09:26:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0652620EA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857968; cv=none; b=kNQZ5T16Hr0tvRQ0G9sAZ6dQJ/ClyPlmfNhOInPr1v+GPdR+hy4kAFrqIEOVH8NeU9In2BV9BGVHtzzIEqRg2HD9jiFE9qDS/bNz8ApMfvpvaoPRhg/6AOY5Z/hNtwFc9wMKHb+C3qV+y259TNZsaHZwf+MTgm+5pHWlNFkcXYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857968; c=relaxed/simple;
	bh=tEX4EaouPo4A9H7gFAjw7VKY1e59Qd+m8eTVByRoHS8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h83S6ko7SPc2xSXZ6qEd3QQt2+7LPo7ojkflWUq2QooNKmiXALcBTs9PsU7F6WxZh/uXz3Y25BPIGYw4v+aw8kuymS3iRbKJ04DfNDZ16VZsgK6hUzBv8M8vGbB7/j8IGXzuOMA6dlfH2cbUlu6WsqPx/d9iBgeGWAgayhODCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseov-0007i3-LS; Thu, 13 Mar 2025 10:25:41 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseou-005VlU-0j;
	Thu, 13 Mar 2025 10:25:40 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseou-00058F-0Q;
	Thu, 13 Mar 2025 10:25:40 +0100
Message-ID: <aacd03a071dce7b340d7170eae59d662d58f23b1.camel@pengutronix.de>
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with
 CLKGEN reset support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michal Wilczynski <m.wilczynski@samsung.com>, Stephen Boyd
 <sboyd@kernel.org>, alex@ghiti.fr, aou@eecs.berkeley.edu,
 conor+dt@kernel.org,  drew@pdp7.com, guoren@kernel.org, jszhang@kernel.org,
 krzk+dt@kernel.org,  m.szyprowski@samsung.com, mturquette@baylibre.com,
 palmer@dabbelt.com,  paul.walmsley@sifive.com, robh@kernel.org,
 wefu@redhat.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date: Thu, 13 Mar 2025 10:25:40 +0100
In-Reply-To: <4c035603-4c11-4e71-8ef3-b857a81bf5ef@samsung.com>
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
	 <CGME20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0@eucas1p1.samsung.com>
	 <20250303143629.400583-5-m.wilczynski@samsung.com>
	 <de50dd55e1285726e8d5ebae73877486.sboyd@kernel.org>
	 <4c035603-4c11-4e71-8ef3-b857a81bf5ef@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-03-06 at 17:43 +0100, Michal Wilczynski wrote:
>=20
> On 3/6/25 00:47, Stephen Boyd wrote:
> > Quoting Michal Wilczynski (2025-03-03 06:36:29)
> > > The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
> > > clock gate is marked as "Reserved" in hardware, while core and cfg ar=
e
> > > configurable. In order for these clock gates to work properly, the
> > > CLKGEN reset must be managed in a specific sequence.
> > >=20
> > > Move the CLKGEN reset handling to the clock driver since it's
> > > fundamentally a clock-related workaround [1]. This ensures that clk_e=
nabled
> > > GPU clocks stay physically enabled without external interference from
> > > the reset driver.  The reset is now deasserted only when both core an=
d
> > > cfg clocks are enabled, and asserted when either of them is disabled.
> > >=20
> > > The mem clock is configured to use nop operations since it cannot be
> > > controlled.
> > >=20
> > > Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75=
fea5c.camel@pengutronix.de [1]
> > >=20
> > > Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> > [...]
> > > diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/cl=
k-th1520-ap.c
> > > index ea96d007aecd..1dfcde867233 100644
> > > --- a/drivers/clk/thead/clk-th1520-ap.c
> > > +++ b/drivers/clk/thead/clk-th1520-ap.c
> > > @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", =
axi_aclk_pd, 0x20c, BIT(3), 0);
> > [...]
> > > =20
> > >  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
> > >                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops=
);
> > > +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
> > > +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gp=
u_ops);
> > > +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-acl=
k",
> > > +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gp=
u_ops);
> > > +
> > > +static void ccu_gpu_clk_disable(struct clk_hw *hw)
> > > +{
> > > +       struct ccu_gate *cg =3D hw_to_ccu_gate(hw);
> > > +       unsigned long flags;
> > > +
> > > +       spin_lock_irqsave(&gpu_reset_lock, flags);
> > > +
> > > +       ccu_disable_helper(&cg->common, cg->enable);
> > > +
> > > +       if ((cg =3D=3D &gpu_core_clk &&
> > > +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
> > > +           (cg =3D=3D &gpu_cfg_aclk &&
> > > +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
> > > +               reset_control_assert(gpu_reset);
> >=20
> > Why can't the clk consumer control the reset itself? Doing this here is
> > not ideal because we hold the clk lock when we try to grab the reset
> > lock. These are all spinlocks that should be small in lines of code
> > where the lock is held, but we're calling into an entire other framewor=
k
> > under a spinlock. If an (unrelated) reset driver tries to grab the clk
> > lock it will deadlock.
>=20
> So in our case the clk consumer is the drm/imagination driver. Here is
> the comment from the maintainer for my previous attempt to use a reset
> driver to abstract the GPU init sequence [1]:
>=20
> "Do you know what this resets? From our side, the GPU only has a single
> reset line (which I assume to be GPU_RESET)."
>=20
> "I don't love that this procedure appears in the platform reset driver.
> I appreciate it may not be clear from the SoC TRM, but this is the
> standard reset procedure for all IMG Rogue GPUs. The currently
> supported TI SoC handles this in silicon, when power up/down requests
> are sent so we never needed to encode it in the driver before.
>=20
> Strictly speaking, the 32 cycle delay is required between power and
> clocks being enabled and the reset line being deasserted. If nothing
> here touches power or clocks (which I don't think it should), the delay
> could potentially be lifted to the GPU driver."=20
>=20
> From the drm/imagination maintainers point of view their hardware has
> only one reset, the extra CLKGEN reset is SoC specific.

If I am understanding correctly, the CLKGEN reset doesn't reset
anything in the GPU itself, but holds the GPU clock generator block in
reset, effectively disabling the three GPU clocks as a workaround for
the always-ungated GPU_MEM clock.

> Also the reset driver maintainer didn't like my way of abstracting two
> resets ("GPU" and and SoC specific"CLKGEN") into one reset

That is one part of it. The other is that (according to my
understanding as laid out above), the combined GPU+CLKGEN reset would
effectively disable all three GPU clocks for a while, after the GPU
driver has already requested them to be enabled.

> to make it
> seem to the consumer driver drm/imagination like there is only one
> reset and suggested and attempt to code the re-setting in the clock
> driver [2]. Even though he suggested a different way of achieving that:=
=20
>=20
> "In my mind it shouldn't be much: the GPU clocks could all share the
> same refcounted implementation. The first clock to get enabled would
> ungate both GPU_CORE and GPU_CFG_ACLK gates and deassert
> GPU_SW_CLKGEN_RST, all in one place. The remaining enable(s) would be
> no-ops. Would that work?"
>=20
> The above would have similar effect, but I felt like enabling both
> clocks in single .enable callback could be confusing so I ended up with
> the current approach. This could be easily re-done if you feel this
> would be better.
>=20
> I agree that using spinlocks here is dangerous, but looking at the code
> of the reset_control_deassert and reset_control_assert, it doesn't seem
> like any spinlocks are acquired/relased in that code flow, unless the
> driver ops would introduce that. So in this specific case deadlock
> shouldn't happen ?

There are no spinlocks in the reset_control_(de)assert paths in the
reset framework, but in general there could be in the driver. The thead
driver [1], uses regmap_update_bits() on a regmap with .fast_io =3D true,
which uses the internal struct regmap::spinlock.

[1] https://lore.kernel.org/all/20250303152511.494405-3-m.wilczynski@samsun=
g.com/


regards
Philipp

