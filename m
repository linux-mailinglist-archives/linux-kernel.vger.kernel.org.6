Return-Path: <linux-kernel+bounces-549355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AFCA551A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D787164CB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2876724060E;
	Thu,  6 Mar 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CGlZPhjh"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785C23F41F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741279450; cv=none; b=cGWTxpzisXlx0WzGPTWWPXoQl/b4/lg0yBhSVQAGuzV5vhpB/TELegwgstOR6ycbHxUKHMTFTJlTEcnwCXd/nPUTAK+IGrOaxnzQST/YRrIpQvdAqRJf+y67NCmqnMydLd9XaKNoVepfsra4ZkITZm3Ypd1FI/0iTvdm+TYnab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741279450; c=relaxed/simple;
	bh=xumzZjkU4tkrqKuAOy3KUxEAfxdkBzVDRxTBqOU3XDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=h67hj5KewPgGRp00zG8wtXEQ8on6aTEShv5+BV6TsEsVvKesJKzuBuZcBqXi4FxEMjeltg8xnnvcNhx6DfCJ7llJ2JPSwEBfKjfUz5wQ21//jgRw4S2+0B+VcTH4/r9eYw72y/hDveAMrnczUOfFghuOwcNkQN2bqjrB5M2PvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CGlZPhjh; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250306164359euoutp01d1e8196a92b7ce901f16f69e7d754c6a~qRGzGjwvI3229132291euoutp01W
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:43:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250306164359euoutp01d1e8196a92b7ce901f16f69e7d754c6a~qRGzGjwvI3229132291euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741279439;
	bh=JFJsXeDxec202sV3ZmU2bsv+R8LOKU6JYqm2DG2llLo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CGlZPhjhlqCQvE3EYGT2QQRJLc/xV8kuMtvT12OUvZVE77uZ7i57qzlkBOFxZff3z
	 NGeWx4+AItCZTz9IAtP2RYb/g9de3RSo8TG+HnltlWS5ImQoe1CveTyoEHdPm/j+qU
	 c9XlstXPu6RpQKEFKB6joNHT3zJSUv++9jnZbhyg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250306164358eucas1p258a20554cf2829d4d1472fbac593f1d0~qRGyIYGWp1219312193eucas1p2x;
	Thu,  6 Mar 2025 16:43:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id E2.62.20397.EC0D9C76; Thu,  6
	Mar 2025 16:43:58 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250306164358eucas1p24d9c9277f81a7dcf73845ad3051daaf8~qRGxob3dL1124011240eucas1p26;
	Thu,  6 Mar 2025 16:43:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306164358eusmtrp171cc179be224b361c54a3eee20903db2~qRGxm4p7j1632616326eusmtrp1-;
	Thu,  6 Mar 2025 16:43:58 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-a3-67c9d0ceab27
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 42.A4.19654.EC0D9C76; Thu,  6
	Mar 2025 16:43:58 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250306164357eusmtip182d61006b9cf9811c392f556a1b83f18~qRGwoOK812181221812eusmtip1n;
	Thu,  6 Mar 2025 16:43:57 +0000 (GMT)
Message-ID: <4c035603-4c11-4e71-8ef3-b857a81bf5ef@samsung.com>
Date: Thu, 6 Mar 2025 17:43:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with
 CLKGEN reset support
To: Stephen Boyd <sboyd@kernel.org>, alex@ghiti.fr, aou@eecs.berkeley.edu,
	conor+dt@kernel.org, drew@pdp7.com, guoren@kernel.org, jszhang@kernel.org,
	krzk+dt@kernel.org, m.szyprowski@samsung.com, mturquette@baylibre.com,
	p.zabel@pengutronix.de, palmer@dabbelt.com, paul.walmsley@sifive.com,
	robh@kernel.org, wefu@redhat.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <de50dd55e1285726e8d5ebae73877486.sboyd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7djPc7rnLpxMN/jwRtvi2Z2vrBZbf89i
	t1iz9xyTxfwj51gt7l3awmTxYm8ji0XzsfVsFi9n3WOz+Nhzj9Xi8q45bBbbPrewWaw9cpfd
	4uIpV4u7906wWLy83MNs0TaL3+L/nh3sFv+ubWSxaNk/hcVB2OP9jVZ2jzcvX7J4HO74wu5x
	78Q0Vo9NqzrZPDYvqfdoWXuMyaP/r4HH+31X2Tz6tqxi9LjUfJ3d4/MmuQCeKC6blNSczLLU
	In27BK6Mt9+/sBbMc67o+LyArYFxoVkXIyeHhICJxIS98xi7GLk4hARWMEq0PvvOCuF8YZRY
	veAGVOYzo8Tl1ouMMC2X/n6BSixnlLgyZR4ThPOWUeLo6ZVgVbwCdhKbfx1lBbFZBFQkOrr/
	sUPEBSVOznzCAmKLCshL3L81AywuLBAncWPbSbBBIgKnmSSW750FlmAWqJLYcf8GlC0ucevJ
	fCYQm03ASOLB8vlgCzgFHCTerL3IAlEjL7H97RxmkEESAo84Ja6//soCcbeLxNtjbawQtrDE
	q+Nb2CFsGYnTk3ugavIlHmz9xAxh10js7DkOZVtL3Dn3i62LkQNogabE+l36EGFHicev9zOC
	hCUE+CRuvBWEOIFPYtK26cwQYV6JjjYhiGo1iak9vXBLz63YxjSBUWkWUqjMQvLkLCTPzELY
	u4CRZRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZg6jz97/jXHYwrXn3UO8TIxMF4iFGC
	g1lJhFdw88l0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryL9remCwmkJ5akZqemFqQWwWSZODil
	Gpi4VLJP7H/udKvyBufrQKnfu8793M5fYTrj45eQeXlnG/Mf2yYIvdqyncdv7hKxaa07nXM3
	sb6r6v9xr9nw6cuJa9V5iqZUtrVPl9GdWiwzwYX1py572Ly3tsw7TmsuWfPeqOjJwgs/nk61
	Zjq59XPFxGlzONac6Fh5L7PH8rIXc8DZrZMXT/mquyFCjzGm3U+1c5d5S+Lh1U6hDHISKy+Z
	PLsWaLTpuWbgyuwfuq2RGsEr785wKfmc0rHO2ipM0NpMeU2jxVWbo/kOBgo/yo/J9VuxLnXM
	OuQzyep62ea5igqbanIsmJo+rbSXW7iz4kO8WHfluoKKmxf5N/2w7/frTj/RUzdZ2+TdJcFd
	1nVKLMUZiYZazEXFiQDEPPNSDAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42I5/e/4Xd1zF06mGxz5z2Hx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	cfGUq8XdeydYLF5e7mG2aJvFb/F/zw52i3/XNrJYtOyfwuIg7PH+Riu7x5uXL1k8Dnd8Yfe4
	d2Iaq8emVZ1sHpuX1Hu0rD3G5NH/18Dj/b6rbB59W1Yxelxqvs7u8XmTXABPlJ5NUX5pSapC
	Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G2+9fWAvmOVd0fF7A
	1sC40KyLkZNDQsBE4tLfL4xdjFwcQgJLGSXWPHrHCpGQkbjW/ZIFwhaW+HOtiw2i6DWjRMuR
	VmaQBK+AncTmX0fBGlgEVCQ6uv+xQ8QFJU7OfALWLCogL3H/1gywuLBAnMT5XatYQQaJCJxm
	kth49woTSIJZoEri/N4rrBAb/gKdsfIuK0RCXOLWk/lgRWwCRhIPls8Hi3MKOEi8WXsRaAMH
	UI26xPp5QhDl8hLb385hnsAoNAvJHbOQTJqF0DELSccCRpZVjCKppcW56bnFRnrFibnFpXnp
	esn5uZsYgali27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFewc0n04V4UxIrq1KL8uOLSnNSiw8x
	mgLDYiKzlGhyPjBZ5ZXEG5oZmBqamFkamFqaGSuJ87JdOZ8mJJCeWJKanZpakFoE08fEwSnV
	wOR29Jhljivbxaj55drKj6ICpG8+n3/hYK/AXLttYoZFWwNtLoqnFcXvvOh/d2Ph30chew98
	q59Z+5zhguaz+HsJ101vsyvZVco7zHl1VsqdcfnUmInv47d+z6rzVU9cVZGqGvlHKKZfO4tz
	glflK8nOnVHJMgoyMwq2vNhpr9lo6OZ6+crh01b97Gf4t3DVbzh+Qe96yeT1mZURS/9JH+lQ
	2uTduLViZ7nAcQn3KREsxpbrVibZlh2y2H5um96NtSxXFxautgn6t8JWXLkn8bTd4dctvopv
	Cl5kCQpmh1x4v9EvLEvJjM8idtt9yUvfYqNcuZ2t1xxijj2zdk7YDF+rUF/l4vWvrnzb2KJn
	o8RSnJFoqMVcVJwIAC66yyeeAwAA
X-CMS-MailID: 20250306164358eucas1p24d9c9277f81a7dcf73845ad3051daaf8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0
References: <20250303143629.400583-1-m.wilczynski@samsung.com>
	<CGME20250303143637eucas1p1a3abdea520ab88688de1263a5f07bba0@eucas1p1.samsung.com>
	<20250303143629.400583-5-m.wilczynski@samsung.com>
	<de50dd55e1285726e8d5ebae73877486.sboyd@kernel.org>



On 3/6/25 00:47, Stephen Boyd wrote:
> Quoting Michal Wilczynski (2025-03-03 06:36:29)
>> The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
>> clock gate is marked as "Reserved" in hardware, while core and cfg are
>> configurable. In order for these clock gates to work properly, the
>> CLKGEN reset must be managed in a specific sequence.
>>
>> Move the CLKGEN reset handling to the clock driver since it's
>> fundamentally a clock-related workaround [1]. This ensures that clk_enabled
>> GPU clocks stay physically enabled without external interference from
>> the reset driver.  The reset is now deasserted only when both core and
>> cfg clocks are enabled, and asserted when either of them is disabled.
>>
>> The mem clock is configured to use nop operations since it cannot be
>> controlled.
>>
>> Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de [1]
>>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> [...]
>> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
>> index ea96d007aecd..1dfcde867233 100644
>> --- a/drivers/clk/thead/clk-th1520-ap.c
>> +++ b/drivers/clk/thead/clk-th1520-ap.c
>> @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
> [...]
>>  
>>  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
>>                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
>> +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
>> +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_ops);
>> +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
>> +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_ops);
>> +
>> +static void ccu_gpu_clk_disable(struct clk_hw *hw)
>> +{
>> +       struct ccu_gate *cg = hw_to_ccu_gate(hw);
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&gpu_reset_lock, flags);
>> +
>> +       ccu_disable_helper(&cg->common, cg->enable);
>> +
>> +       if ((cg == &gpu_core_clk &&
>> +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
>> +           (cg == &gpu_cfg_aclk &&
>> +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
>> +               reset_control_assert(gpu_reset);
> 
> Why can't the clk consumer control the reset itself? Doing this here is
> not ideal because we hold the clk lock when we try to grab the reset
> lock. These are all spinlocks that should be small in lines of code
> where the lock is held, but we're calling into an entire other framework
> under a spinlock. If an (unrelated) reset driver tries to grab the clk
> lock it will deadlock.

So in our case the clk consumer is the drm/imagination driver. Here is
the comment from the maintainer for my previous attempt to use a reset
driver to abstract the GPU init sequence [1]:

"Do you know what this resets? From our side, the GPU only has a single
reset line (which I assume to be GPU_RESET)."

"I don't love that this procedure appears in the platform reset driver.
I appreciate it may not be clear from the SoC TRM, but this is the
standard reset procedure for all IMG Rogue GPUs. The currently
supported TI SoC handles this in silicon, when power up/down requests
are sent so we never needed to encode it in the driver before.

Strictly speaking, the 32 cycle delay is required between power and
clocks being enabled and the reset line being deasserted. If nothing
here touches power or clocks (which I don't think it should), the delay
could potentially be lifted to the GPU driver." 

From the drm/imagination maintainers point of view their hardware has
only one reset, the extra CLKGEN reset is SoC specific. 

Also the reset driver maintainer didn't like my way of abstracting two
resets ("GPU" and and SoC specific"CLKGEN") into one reset to make it
seem to the consumer driver drm/imagination like there is only one
reset and suggested and attempt to code the re-setting in the clock
driver [2]. Even though he suggested a different way of achieving that: 

"In my mind it shouldn't be much: the GPU clocks could all share the
same refcounted implementation. The first clock to get enabled would
ungate both GPU_CORE and GPU_CFG_ACLK gates and deassert
GPU_SW_CLKGEN_RST, all in one place. The remaining enable(s) would be
no-ops. Would that work?"

The above would have similar effect, but I felt like enabling both
clocks in single .enable callback could be confusing so I ended up with
the current approach. This could be easily re-done if you feel this
would be better.

I agree that using spinlocks here is dangerous, but looking at the code
of the reset_control_deassert and reset_control_assert, it doesn't seem
like any spinlocks are acquired/relased in that code flow, unless the
driver ops would introduce that. So in this specific case deadlock
shouldn't happen ?

[1] - https://lore.kernel.org/all/816db99d-7088-4c1a-af03-b9a825ac09dc@imgtec.com/
[2] - https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de/

> 
> I see the commit text talks about this being a workaround. I'm not sure
> what the workaround is though. I've seen designs where the reset doesn't
> work unless the clk is enabled because the flops have to be clocking for
> the reset to propagate a few cycles, or the clk has to be disabled so
> that the reset controller can do the clocking, or vice versa for the clk
> not working unless the reset is deasserted. Long story short, it's
> different between SoCs.

OK, so this is how GPU initialization needs to happen for this specific
SoC:

drm/imagination consumer driver:

pvr_power_device_resume():

clk_prepare_enable(pvr_dev->core_clk);
clk_prepare_enable(pvr_dev->sys_clk);
clk_prepare_enable(pvr_dev->mem_clk);

// Then deassert reset introduced in [3]
// [3] - https://lore.kernel.org/all/20250128194816.2185326-11-m.wilczynski@samsung.com/

// Eventually this would get called in the SoC specific reset driver
static void th1520_rst_gpu_enable(struct regmap *reg,
				  struct mutex *gpu_seq_lock)
{
	int val;

	mutex_lock(gpu_seq_lock);

	/* if the GPU is not in a reset state it, put it into one */
	regmap_read(reg, TH1520_GPU_RST_CFG, &val);
	if (val)
		regmap_update_bits(reg, TH1520_GPU_RST_CFG,
				   TH1520_GPU_RST_CFG_MASK, 0x0);

	/* rst gpu clkgen */
	regmap_set_bits(reg, TH1520_GPU_RST_CFG, TH1520_GPU_SW_CLKGEN_RST);

	/*
	 * According to the hardware manual, a delay of at least 32 clock
	 * cycles is required between de-asserting the clkgen reset and
	 * de-asserting the GPU reset. Assuming a worst-case scenario with
	 * a very high GPU clock frequency, a delay of 1 microsecond is
	 * sufficient to ensure this requirement is met across all
	 * feasible GPU clock speeds.
	 */
	udelay(1);

	/* rst gpu */
	regmap_set_bits(reg, TH1520_GPU_RST_CFG, TH1520_GPU_SW_GPU_RST);

	mutex_unlock(gpu_seq_lock);
}


Based on my testing this is exactly how the resets should happen, else
the GPU fails to initialize, and the drm/imagination driver hangs. To
reiterate: first power ON the GPU using power-domain driver. Then
drm/imagination enable all three clocks, then deassert reset of the GPU
CLKGEN (SoC specific), delay for 32 cycles, and then deassert the GPU reset.

> 
> Likely the reset and clk control should be coordinated in a PM domain
> for the device so that when the device is active, the clks are enabled
> and the reset is deasserted in the correct order for the SoC. Can you do
> that?

Obviously this would work, but I'm worried, the drm/imagination driver
maintainers would reject it, as for them this is a special case, from
their perspective there is only one reset line to their hardware, and
there are three clocks which they manage in driver already. And the PM
maintainers probably wouldn't be happy to take this as well.

At the very end maybe we could go back to abstracting the resets in the
reset driver, as the reset maintainer seemed to be open to it, if the
alternatives proves to be too problematic [4].

"I won't object to carry this in the reset driver if the clock
implementation turns out to be unreasonably complex, but I currently
don't expect that to be the case. Please give it a shot."

[4] - https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de/

> 
>> +
>> +       spin_unlock_irqrestore(&gpu_reset_lock, flags);
>> +}
> 

