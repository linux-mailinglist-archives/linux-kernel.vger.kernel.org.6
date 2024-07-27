Return-Path: <linux-kernel+bounces-264284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4D93E121
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 23:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D17DEB20B36
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 21:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E340861;
	Sat, 27 Jul 2024 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WPhnu8v5"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07931358A7
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722116336; cv=none; b=ePriaC0zCmwyX1xri6yXzuLQpfDjFeeO21mdE0qVhMJ2Hpiywk1rohen6qeQEtb0OIpVP8uzO9F/KBF3ibTrycruoeLhItZOTEF5b6hrwomMfd5y27AT55hLAP+vVkjGRy0Rh/YtiqkQFykQbQvaNo+ex8hkGgXXMB+xt40iSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722116336; c=relaxed/simple;
	bh=DIwWOaaQ00YN/z+RPYknNJSlrG9jljopgyXneIMtbIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ln4nwU9IMuMeldK6xdlKO6PoA/zk+xet4zxh7BsY2ltbyAjKLntXrkBDD1KjY6j2W/x41O/RHe0LtBeUdNNIS9f+3UH/vC/G1p8Arquf7RXxr6Cw5gWbW35Fqo6te4vfdgoX/7XKq7KXSCn/NBA9gG02jqipkcBF4eSOfdi7CoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WPhnu8v5; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8014238b-2668-4602-add1-64a0c6e480ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722116331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JWOVtMmp5rkstgdKWTPceRhx9TWpXK/fgZKWzzIJtdo=;
	b=WPhnu8v5AXV0snlmuvj9zxxVssvrGd6ZHQ13OcJJayuSnm+r1vry9q/9/dET9CWh0KSmCL
	d9fsQSlKRoOLXuPb0k9uWsDkxV4Fany82NCYwYK6HTODdEUceZ6Ozx90cW7BNfTgBaVb1t
	a2uWnA+gPWx9nGAU6sZ4fk65v2VKLMw=
Date: Sun, 28 Jul 2024 05:38:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/19] Add Freescale i.MX8qxp Display Controller
 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, p.zabel@pengutronix.de, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de,
 vkoul@kernel.org, kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org,
 francesco@dolcini.it, frank.li@nxp.com
References: <20240724092950.752536-1-victor.liu@nxp.com>
 <wky3mjl7fn773myatyrdsea6oc2xebkvrgmigmmoj36eswgqry@2kox5ad5dynl>
 <aba35ecb-2357-4c4f-8366-08d14e40d436@linux.dev>
 <zr2t6deyvwacawj7s36gols2vxu24fah25x6ofy7xpqyvc4s2d@luavybrlxpaf>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <zr2t6deyvwacawj7s36gols2vxu24fah25x6ofy7xpqyvc4s2d@luavybrlxpaf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 7/28/24 04:28, Dmitry Baryshkov wrote:
> On Sun, Jul 28, 2024 at 03:10:21AM GMT, Sui Jingfeng wrote:
>> Hi,
>>
>> On 7/28/24 00:39, Dmitry Baryshkov wrote:
>>>> Hi,
>>>>
>>>> This patch series aims to add Freescale i.MX8qxp Display Controller support.
>>>>
>>>> The controller is comprised of three main components that include a blit
>>>> engine for 2D graphics accelerations, display controller for display output
>>>> processing, as well as a command sequencer.
>>>>
>>>> Previous patch series attempts to do that can be found at:
>>>> https://patchwork.freedesktop.org/series/84524/
>>>>
>>>> This series addresses Maxime's comments on the previous one:
>>>> a. Split the display controller into multiple internal devices.
>>>>      1) List display engine, pixel engine, interrupt controller and more as the
>>>>         controller's child devices.
>>>>      2) List display engine and pixel engine's processing units as their child
>>>>         devices.
>>>>
>>>> b. Add minimal feature support.
>>>>      Only support two display pipelines with primary planes with XR24 fb,
>>>>      backed by two fetchunits.  No fetchunit dynamic allocation logic(to be done
>>>>      when necessary).
>>>>
>>>> c. Use drm_dev_{enter, exit}().
>>>>
>>>> Since this series changes a lot comparing to the previous one, I choose to
>>>> send it with a new patch series, not a new version.
>>> I'm sorry, I have started reviewing v2 without noticing that there is a
>>> v3 already.
>>>
>>> Let me summarize my comments:
>>>
>>> - You are using OF aliases. Are they documented and acked by DT
>>>     maintainers?
>>>
>>> - I generally feel that the use of so many small devices to declare
>>>     functional blocks is an abuse of the DT. Please consider creating
>>>     _small_ units from the driver code directly rather than going throught
>>>     the components.
>>
>> Well, I really don't think so. I don't agree.
>>
>> I have checked the DTSpec[1] before type, the spec isn't define how
>> many is considered to be "many", and the spec isn't define to what
>> extent is think to be "small" as well.
> 
> Yeah. However _usually_ we are not defining DT devices for sub-device
> components. 

I guess, this depended on their hardware (i.MX8qxp) layout, reflecting
exactly what their hardware's layout is perfectly valid. It also depend
on if specific part of those sub-device will be re-visioned or not. If
only a small part of the whole is re-versioned in the future, we can 
still re-using this same driver with slightly modify(update) the DTS.

The point is to controll the granularity and forward compatibility.

> So at least such decisions ought to be described and
> explained in the cover letter.

Agree, but I see 08/19 patch has a beautiful schematic. I have learned
a lot when reading it. I can't see any abuse of the DT through this
bulk series anyway.


Comments below are not revelant to Ying's patch series itself.

/*----------------------------------------------------------------*/

By the way, the last time that I have ever seen and feel abuse of the
DT is the aux-bridge.c[1] and aux-hpd-bridge.c[2]. I strongly feel that
those two *small* programs are abuses to the DT and possibily abuse to
the auxiliary bus framework.

1) It's so *small* that it don't even have a hardware entity (physical
    device) to corresponding with. As far as I can see, all hardware
    units in this patch series are bigger than yours. Because your HPD
    bridge is basically a "virtual wire".

    An non-physical-exist wire hold reference to several device node,
    this is the most awful abuse to the DT I have ever seen. In other
    words, despite you want to solve some software problems, but then,
    you could put a device not in the DTS, and let the 'OF' system
    create a device for you. Just like what this series do.

2) I feel your HPD fake bridge driver abuse to the philosophy of
    auxiliary bus [3]. The document of auxiliary bus tell us that

    "These individual devices split from the core cannot live on
     the platform bus as they are not physical devices that are
     controlled by DT/ACPI"

     Which is nearly equivalent to say that devices that are controlled
     by DT/ACPI have better ways to enforce the control. When using
     auxiliary bus, we *generally* should not messed with DT. See
     golden examples[4][5]. At least, their code are able to run on
     X86, while the code you write just can't.

[0] https://patchwork.freedesktop.org/patch/605555/?series=135786&rev=3
[1] 
https://elixir.bootlin.com/linux/v6.10.2/source/drivers/gpu/drm/bridge/aux-bridge.c
[2] 
https://elixir.bootlin.com/linux/v6.10.2/source/drivers/gpu/drm/bridge/aux-hpd-bridge.c
[3] https://www.kernel.org/doc/html/latest/driver-api/auxiliary_bus.html

[4] https://patchwork.freedesktop.org/series/136431/
[5] https://patchwork.freedesktop.org/series/134837/


Best regards
Sui

>>
>> [1]
>> https://github.com/devicetree-org/devicetree-specification/releases/tag/v0.4
> 

-- 
Best regards
Sui


