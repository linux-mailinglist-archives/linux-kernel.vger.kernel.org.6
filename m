Return-Path: <linux-kernel+bounces-567567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4164FA687D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C0B164CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816325332F;
	Wed, 19 Mar 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IyIyCsOM"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E724EF9E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376143; cv=none; b=P+ENdM9sJBQdIBmkih7GOXlspVdXp20VSKeR7gGm0Xe/GiIizoPmUsrberaWJJu+pGtJxpCE8R8XiESz1zeRdnu36NkppxGtw7672s8RpaU6ivK3XYs7vcdKMOfmOxSHeITcr3AfKP++Hr4aovadwBeX4HO3in+B5df6i7cCchw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376143; c=relaxed/simple;
	bh=MJurp/n35hBvHIMiQuoAEo93QaKfh1JOkc1u3IvRhkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bCdPvDouN+KXqQX0xUtsDSZOzPi2BRTR0wsg/eABlyACx0HDoKwfcxjsBNN1xf1QrAb3z5xG67dXJy+mUdtIJrjwXYfER39xeIDH6ZtlFUJUvM2ucA25OlPNfQ9tLfiaLto5sK/l1BzZ1FSL0JnK8cT3bAyaRT9cO1E0MdDqhGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IyIyCsOM; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250319092214euoutp0224ddb6f86b4d984a45456a76cabe1bac~uKdzfZiBf1649216492euoutp026
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 09:22:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250319092214euoutp0224ddb6f86b4d984a45456a76cabe1bac~uKdzfZiBf1649216492euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742376134;
	bh=xziCeePU8VJH3HPvHWkmHqvN/zw2drIJZnyVPgks6DM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IyIyCsOM4YrF0U4Ki51TGDxHSXSSvgjqYO4MD68nMNP8sAiMxl/41PSGx9Ok2eLpO
	 gogrb4tEp4G/hE8SyR5nTS2+mXSwtiJBcXhZTdJbJ9vu4rvA2sN7Qkyf65Q5to2Ugf
	 rWrHEIL1c2yRz7SAw7hD3yBg9fzb4JH7ieCSRT5w=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250319092213eucas1p1afea36ec858edac801d86b9fe4df0d19~uKdyzAxs_2948529485eucas1p1v;
	Wed, 19 Mar 2025 09:22:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 4E.60.20397.5CC8AD76; Wed, 19
	Mar 2025 09:22:13 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250319092213eucas1p159ec41756a40a4139a0c222e65a7a05b~uKdyP6lOr2951729517eucas1p1L;
	Wed, 19 Mar 2025 09:22:13 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250319092213eusmtrp1cbe8c083bbe4d0478d70d8413b02d2a5~uKdyPLt9D1884918849eusmtrp1F;
	Wed, 19 Mar 2025 09:22:13 +0000 (GMT)
X-AuditID: cbfec7f5-ed1d670000004fad-40-67da8cc592da
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 3B.DA.19654.4CC8AD76; Wed, 19
	Mar 2025 09:22:12 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250319092212eusmtip13c59f2b45dc28429110a264bc2191f47~uKdxOUuC12074820748eusmtip1I;
	Wed, 19 Mar 2025 09:22:11 +0000 (GMT)
Message-ID: <e90a0c77-61a0-49db-86ba-bac253f8ec53@samsung.com>
Date: Wed, 19 Mar 2025 10:22:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] clk: thead: Add GPU clock gate control with
 CLKGEN reset support
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
	alex@ghiti.fr, aou@eecs.berkeley.edu, conor+dt@kernel.org, drew@pdp7.com,
	guoren@kernel.org, jszhang@kernel.org, krzk+dt@kernel.org,
	m.szyprowski@samsung.com, mturquette@baylibre.com, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, wefu@redhat.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <aacd03a071dce7b340d7170eae59d662d58f23b1.camel@pengutronix.de>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djPc7pHe26lGyz8q2bx7M5XVoutv2ex
	W6zZe47JYv6Rc6wW9y5tYbJ4sbeRxaL52Ho2i5ez7rFZfOy5x2pxedccNottn1vYLNYeuctu
	cfGUq8XdeydYLF5e7mG2aJvFb/F/zw52i3/XNrJYtOyfwuIg7PH+Riu7x5uXL1k8Dnd8Yfe4
	d2Iaq8emVZ1sHpuX1Hu0rD3G5NH/18Dj/b6rbB59W1Yxelxqvs7u8XmTXABPFJdNSmpOZllq
	kb5dAlfGj9OHWQruG1dcufaIrYHxuGYXIyeHhICJxLope1m6GLk4hARWMEr073zABuF8YZTY
	ceUWM4TzmVFixq8DTDAt515vYgSxhQSWM0rMO5sOUfSWUeLN1tPMIAleATuJQ5+OsHcxcnCw
	CKhKvD1dCREWlDg58wkLiC0qIC9x/9YMdhBbWCBO4sa2k0wgc0QEbjNJ/OrdyAaSYBaokthx
	/wY7hC0ucevJfLAj2ASMJB4sn88KYnMK+Eh8WfiXBaJGXqJ562ywqyUEnnFK7NzwhRHiaheJ
	pysXs0DYwhKvjm9hh7BlJE5P7oGK50s82PqJGcKukdjZcxzKtpa4c+4XG8gzzAKaEut36UOE
	HSUev97PCBKWEOCTuPFWEOIEPolJ26YzQ4R5JTrahCCq1SSm9vTCLT23YhvTBEalWUihMgvJ
	k7OQPDMLYe8CRpZVjOKppcW56anFxnmp5XrFibnFpXnpesn5uZsYgWnz9L/jX3cwrnj1Ue8Q
	IxMH4yFGCQ5mJRFe9yfX04V4UxIrq1KL8uOLSnNSiw8xSnOwKInzLtrfmi4kkJ5YkpqdmlqQ
	WgSTZeLglGpgkvreY2Rr81iJjeFIsqD6ZNk2v9hFL2W/ZLbveNGTxZ/FLBP3OUzup+FSz4n6
	oZGKJn1f/4Y3nD9TWhY+IZAjt+Nn+9T9jcqH76naObwU1noQJnNzj4G+5pF+u7KNIbMdDU+G
	mCbdPZWwfp3eLrH5ncq36y1XlVjm1HsHsORzbbIOmxkrYKwR6DyTjeeRVeHrvfLnNzNKrY9f
	0rck9unTCJvcwvmXxGU+29aWns25vUdIRf34r6mJE3ac/109ecXKdN0VfK3tiuePBEV6y+rF
	LRE2y6zwv6BtYj/77iZdcTejlphFlbvNjsWlrxFfLR2/m081aaW61Xf283vOPO/OabFRlW6P
	27HsZJrXEiWW4oxEQy3mouJEANRis3AKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42I5/e/4Xd0jPbfSDWY3WVk8u/OV1WLr71ns
	Fmv2nmOymH/kHKvFvUtbmCxe7G1ksWg+tp7N4uWse2wWH3vusVpc3jWHzWLb5xY2i7VH7rJb
	XDzlanH33gkWi5eXe5gt2mbxW/zfs4Pd4t+1jSwWLfunsDgIe7y/0cru8eblSxaPwx1f2D3u
	nZjG6rFpVSebx+Yl9R4ta48xefT/NfB4v+8qm0ffllWMHpear7N7fN4kF8ATpWdTlF9akqqQ
	kV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfx4/RhloL7xhVXrj1i
	a2A8rtnFyMkhIWAice71JsYuRi4OIYGljBKfzzWwQCRkJK51v4SyhSX+XOtigyh6zSjxeF4P
	WIJXwE7i0Kcj7F2MHBwsAqoSb09XQoQFJU7OfAJWIiogL3H/1gx2EFtYIE7i/K5VrCBzRARu
	M0lse74ArIhZoEri/N4rrBALvjBJzP+2gxkiIS5x68l8JhCbTcBI4sHy+awgNqeAj8SXhX9Z
	QBYzC6hLrJ8nBFEuL9G8dTbzBEahWUjumIVk0iyEjllIOhYwsqxiFEktLc5Nzy020itOzC0u
	zUvXS87P3cQITBTbjv3csoNx5auPeocYmTgYDzFKcDArifC6P7meLsSbklhZlVqUH19UmpNa
	fIjRFBgUE5mlRJPzgakqryTe0MzA1NDEzNLA1NLMWEmcl+3K+TQhgfTEktTs1NSC1CKYPiYO
	TqkGpvV/ZEOrz+9TTKiUSPesXC0VMMnsyNf6lUuDfB6crWeLLNs3z03o2S3eLQ0m7y05/Die
	LCuU3umSd3KBatY36RSn64eMV52IttvjO5FPL1vmyZ17k61Y59059nbKSaXesMgfDxK+7MkU
	qf5aJfsu32L71QPruGqW/2U48+uKldrqhvNHlCSazS++vcO76lz7Xa7uqK2BDB1sO55u0A5u
	lpytcqslpzhWx/j70hlu/+9HbnHLNEzlj3efVRZRUG7EwzR57aray5EZMdlm5gmXEnYopTGt
	is9fc80mcnuR7XL+l596/1ivljjrc51r1sGC0HhlsQtnP9p7mdW95DhY6HOjZIPPambxgwoi
	ifpySizFGYmGWsxFxYkA2lC6eJ0DAAA=
X-CMS-MailID: 20250319092213eucas1p159ec41756a40a4139a0c222e65a7a05b
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
	<4c035603-4c11-4e71-8ef3-b857a81bf5ef@samsung.com>
	<aacd03a071dce7b340d7170eae59d662d58f23b1.camel@pengutronix.de>



On 3/13/25 10:25, Philipp Zabel wrote:
> On Do, 2025-03-06 at 17:43 +0100, Michal Wilczynski wrote:
>>
>> On 3/6/25 00:47, Stephen Boyd wrote:
>>> Quoting Michal Wilczynski (2025-03-03 06:36:29)
>>>> The T-HEAD TH1520 has three GPU clocks: core, cfg, and mem. The mem
>>>> clock gate is marked as "Reserved" in hardware, while core and cfg are
>>>> configurable. In order for these clock gates to work properly, the
>>>> CLKGEN reset must be managed in a specific sequence.
>>>>
>>>> Move the CLKGEN reset handling to the clock driver since it's
>>>> fundamentally a clock-related workaround [1]. This ensures that clk_enabled
>>>> GPU clocks stay physically enabled without external interference from
>>>> the reset driver.  The reset is now deasserted only when both core and
>>>> cfg clocks are enabled, and asserted when either of them is disabled.
>>>>
>>>> The mem clock is configured to use nop operations since it cannot be
>>>> controlled.
>>>>
>>>> Link: https://lore.kernel.org/all/945fb7e913a9c3dcb40697328b7e9842b75fea5c.camel@pengutronix.de [1]
>>>>
>>>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>>> [...]
>>>> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th1520-ap.c
>>>> index ea96d007aecd..1dfcde867233 100644
>>>> --- a/drivers/clk/thead/clk-th1520-ap.c
>>>> +++ b/drivers/clk/thead/clk-th1520-ap.c
>>>> @@ -862,17 +863,70 @@ static CCU_GATE(CLK_SRAM1, sram1_clk, "sram1", axi_aclk_pd, 0x20c, BIT(3), 0);
>>> [...]
>>>>  
>>>>  static CCU_GATE_CLK_OPS(CLK_GPU_MEM, gpu_mem_clk, "gpu-mem-clk",
>>>>                         video_pll_clk_pd, 0x0, BIT(2), 0, clk_nop_ops);
>>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CORE, gpu_core_clk, "gpu-core-clk",
>>>> +                       video_pll_clk_pd, 0x0, BIT(3), 0, ccu_gate_gpu_ops);
>>>> +static CCU_GATE_CLK_OPS(CLK_GPU_CFG_ACLK, gpu_cfg_aclk, "gpu-cfg-aclk",
>>>> +                       video_pll_clk_pd, 0x0, BIT(4), 0, ccu_gate_gpu_ops);
>>>> +
>>>> +static void ccu_gpu_clk_disable(struct clk_hw *hw)
>>>> +{
>>>> +       struct ccu_gate *cg = hw_to_ccu_gate(hw);
>>>> +       unsigned long flags;
>>>> +
>>>> +       spin_lock_irqsave(&gpu_reset_lock, flags);
>>>> +
>>>> +       ccu_disable_helper(&cg->common, cg->enable);
>>>> +
>>>> +       if ((cg == &gpu_core_clk &&
>>>> +            !clk_hw_is_enabled(&gpu_cfg_aclk.common.hw)) ||
>>>> +           (cg == &gpu_cfg_aclk &&
>>>> +            !clk_hw_is_enabled(&gpu_core_clk.common.hw)))
>>>> +               reset_control_assert(gpu_reset);
>>>
>>> Why can't the clk consumer control the reset itself? Doing this here is
>>> not ideal because we hold the clk lock when we try to grab the reset
>>> lock. These are all spinlocks that should be small in lines of code
>>> where the lock is held, but we're calling into an entire other framework
>>> under a spinlock. If an (unrelated) reset driver tries to grab the clk
>>> lock it will deadlock.
>>
>> So in our case the clk consumer is the drm/imagination driver. Here is
>> the comment from the maintainer for my previous attempt to use a reset
>> driver to abstract the GPU init sequence [1]:
>>
>> "Do you know what this resets? From our side, the GPU only has a single
>> reset line (which I assume to be GPU_RESET)."
>>
>> "I don't love that this procedure appears in the platform reset driver.
>> I appreciate it may not be clear from the SoC TRM, but this is the
>> standard reset procedure for all IMG Rogue GPUs. The currently
>> supported TI SoC handles this in silicon, when power up/down requests
>> are sent so we never needed to encode it in the driver before.
>>
>> Strictly speaking, the 32 cycle delay is required between power and
>> clocks being enabled and the reset line being deasserted. If nothing
>> here touches power or clocks (which I don't think it should), the delay
>> could potentially be lifted to the GPU driver." 
>>
>> From the drm/imagination maintainers point of view their hardware has
>> only one reset, the extra CLKGEN reset is SoC specific.
> 
> If I am understanding correctly, the CLKGEN reset doesn't reset
> anything in the GPU itself, but holds the GPU clock generator block in
> reset, effectively disabling the three GPU clocks as a workaround for
> the always-ungated GPU_MEM clock.
> 
>> Also the reset driver maintainer didn't like my way of abstracting two
>> resets ("GPU" and and SoC specific"CLKGEN") into one reset
> 
> That is one part of it. The other is that (according to my
> understanding as laid out above), the combined GPU+CLKGEN reset would
> effectively disable all three GPU clocks for a while, after the GPU
> driver has already requested them to be enabled.

Thank you for your comments Philipp, it seems like we're on the same
page here. I was wondering whether there is anything I can do to move the
patches forward.

Stephen, if the current patch is a no go from your perspective could you
please advise whether there is a way to solve this in a clock that would
be acceptable to you.

Thanks,
Michał

> 
>> to make it
>> seem to the consumer driver drm/imagination like there is only one
>> reset and suggested and attempt to code the re-setting in the clock
>> driver [2]. Even though he suggested a different way of achieving that: 
>>
>> "In my mind it shouldn't be much: the GPU clocks could all share the
>> same refcounted implementation. The first clock to get enabled would
>> ungate both GPU_CORE and GPU_CFG_ACLK gates and deassert
>> GPU_SW_CLKGEN_RST, all in one place. The remaining enable(s) would be
>> no-ops. Would that work?"
>>
>> The above would have similar effect, but I felt like enabling both
>> clocks in single .enable callback could be confusing so I ended up with
>> the current approach. This could be easily re-done if you feel this
>> would be better.
>>
>> I agree that using spinlocks here is dangerous, but looking at the code
>> of the reset_control_deassert and reset_control_assert, it doesn't seem
>> like any spinlocks are acquired/relased in that code flow, unless the
>> driver ops would introduce that. So in this specific case deadlock
>> shouldn't happen ?
> 
> There are no spinlocks in the reset_control_(de)assert paths in the
> reset framework, but in general there could be in the driver. The thead
> driver [1], uses regmap_update_bits() on a regmap with .fast_io = true,
> which uses the internal struct regmap::spinlock.
> 
> [1] https://lore.kernel.org/all/20250303152511.494405-3-m.wilczynski@samsung.com/
> 
> 
> regards
> Philipp
> 

