Return-Path: <linux-kernel+bounces-436993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FFA9E8DBE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1942281299
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BED2156E5;
	Mon,  9 Dec 2024 08:46:55 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A372156EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734014; cv=none; b=aBw41Toqp5hvSNuo+gl4GtDuUCZVqnmS6sPACSV2U4YWnJsOjpO2zsf9UELo7QoRiRDBBuHu0DRz09fVhpejZa7Bsn4L+YlgzWpJFrD9bP+EoQHbdMvGsWsjg2F/dbzUkctgtaDdhivzageinGo2froJ3Q4TIQfx51aGakIrx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734014; c=relaxed/simple;
	bh=WOzESMhvwFcFOdQAuEiGC9hEv3P+/m8JLqWfGEiW5Ok=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=o7WlTrdCIb2OQzX/Hx7a0/oEF3bOF2hyC4vRzIkCtK79y0GIDFLz7SvsXsMBFc9dM7KXyWL1SJggxWg0ew/4q80Fv3gXBuIjmdRk/htBDJM2L6gAw9KAAU+MdYckK+4hUkN9u7ZVRMabibR3yXUF5lEV76wzF/ePkrYewwHfL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id 2EA392345;
	Mon,  9 Dec 2024 09:46:38 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Dec 2024 09:46:38 +0100
From: Nikolaus Voss <nv@vosn.de>
To: Marek Vasut <marex@denx.de>
Cc: Liu Ying <victor.liu@oss.nxp.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Liu Ying <victor.liu@nxp.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Fabio Estevam <festevam@denx.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nikolaus.voss@haag-streit.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <897b3787-8246-4509-94a1-129488297150@denx.de>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <000b34cdd1591c82265ce1f9848828d1@vosn.de>
 <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
 <12a1b86e-8f25-4875-8503-1de98f125a62@denx.de>
 <808d4092a9e97b95480d47c1bd84d930@vosn.de>
 <b86666cc-da63-405d-9036-96cb4e69dafb@denx.de>
 <21ea39dba5e35e99ea499b4408cb1bdf@vosn.de>
 <897b3787-8246-4509-94a1-129488297150@denx.de>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <2d1b404288a6f0b99f26b697df1ff975@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Marek,

On 07.12.2024 12:30, Marek Vasut wrote:
> On 12/4/24 11:55 AM, Nikolaus Voss wrote:
>>>>>>>> I doubt that pixel clock tree cannot find appropriate division 
>>>>>>>> ratios
>>>>>>>> for some pixel clock rates, especially for dual-link LVDS on 
>>>>>>>> i.MX8MP
>>>>>>>> and i.MX93 platforms, because PLL clock rate should be 7x faster 
>>>>>>>> than
>>>>>>>> pixel clock rate and 2x faster than "ldb" clock rate so that the 
>>>>>>>> 3.5
>>>>>>>> folder between "ldb" clock and pixel clock can be met. That 
>>>>>>>> means the
>>>>>>>> PLL clock rate needs to be explicitly set first for this case.
>>>>>>>> 
>>>>>>>> Can you assign the PLL clock rate in DT to satisfy the "ldb" and 
>>>>>>>> pixel
>>>>>>>> clock rates like the below commit does, if you use a LVDS panel?
>>>>>>>> 
>>>>>>>> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video 
>>>>>>>> PLL1
>>>>>>>> frequency to 506.8 MHz")
>>>>>>> 
>>>>>>> I probably could. The point of my patch is you don't have to know 
>>>>>>> in
>>>>>>> advance which LVDS panel is connected, and you don't have to 
>>>>>>> calculate
>>>>>>> the base PLL clock by hand and store it in the device tree.
>>>>>>> 
>>>>>>> In my test system, I have three different LVDS panels with EDID 
>>>>>>> EEPROM,
>>>>>>> none of which worked with the stock driver, but all work with 
>>>>>>> this
>>>>>>> patch.
>>>>>>> With slightly adapted pixel clocks though.
>>>>>> 
>>>>>> If each of the three LVDS panels has only one display mode, you 
>>>>>> may
>>>>>> assign the PLL clock rates in DT overlays for the panels.
>>>>> I temporarily agree.
>>>>> 
>>>>> I also currently use DTOs for various panels including their PLL
>>>>> setting, but in the end, I think/hope the work of Miquel and co. is
>>>>> going to make that PLL setting part unnecessary.
>>>> 
>>>> That is exactly what my patch is about. I want to use one DT for all
>>>> panels
>>> 
>>> Right
>>> 
>>>> and store the panel's timing in EDID EEPROM.
>>> Oh, that is a new one. Does the EDID EEPROM store the entirety of
>>> 'struct display_timing {}' somehow , or is that a custom format ?
>> 
>> Well, sort of ;-). VESA has taken care of this 30 years ago
>> (https://en.wikipedia.org/wiki/Extended_Display_Identification_Data).
>> 
>> DRM handles this with drm_get_edid() and siblings, e.g. :
> 
> EDID can not encode all the information in struct display_timing {} ,
> or can it ?
> 
> I think what you would be missing are bus_flags , bus_format and
> possibly the single/dual link and channel (odd/even) mapping, won't
> you ?

Yes, that's right. I use the vendor block for bus_flags and bus_format
now, but that's not standard and not portable of course.

My first idea was to store the DT overlay in the display EEPROM but
a standard 1k EEPROM is too small for that.

-- 
Nikolaus Voss

