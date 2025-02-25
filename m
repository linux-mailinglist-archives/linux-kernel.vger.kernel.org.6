Return-Path: <linux-kernel+bounces-532268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23FAA44ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD19B7A66AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F11A2C04;
	Tue, 25 Feb 2025 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4gcDtfO"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7A2197A67;
	Tue, 25 Feb 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740509306; cv=none; b=FJSd1SS/PLnSpWK17Nz1GE9KhGMxAoZi6HqtU04NHocRcJQXwHbxstbs195XbbPONpxAtrF2mwr76UFjZ4xD49I0IkTlOQ4sxIm2KChGxrTwXF0K6mPJgQQzUJaCCKwHrFAEhaloqKH9lVzW1S/uavveLPXvG455WFIACm6R7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740509306; c=relaxed/simple;
	bh=k8IVphafgPFQdg6tJ0lBrhgoq44ce4Pd2tJlvx6fDD0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Iy35gVaKcffhswlYjyvOB1cOyhePQiSCZzFZICXZW8H/n+O57h8cmXcUkPsH3KZBpmoltx7w9wr2MmKg4yQfj5Z8gpxvhMPlEGUarISYTLpMAfFoUfnf5BWN0fQ/AseDzcMgccm347cdQiyrSAhI6ZbLSecugdzDurWS6wOM1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4gcDtfO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb90f68f8cso1134178266b.3;
        Tue, 25 Feb 2025 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740509302; x=1741114102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XKPdeJEIm5j9QWNBqcrVgnkGdH/Cc0RtDIhKeCC9ldQ=;
        b=S4gcDtfO9i1fXLGqn9fePF08VfsUmUmNJEnMxkIUtiBJSEVgfd3ZtxF2kKsfyzHUBS
         7C/O0BrMRdjhsDbPNRV9fGu89s97jKsGRGPoCO+H3zqsKEFgDSOnWBmkc7tL19SfZvld
         d8C8YEFfxTiS1/y/C7FjW8xA12AjDTg8uMkSPNSwqAkU3kVgu6qDOLs+MJkhLHEf+hvX
         YVcT4T8VY3s+3sHXnYloXxt1UiAicfc9ZftzjOfB0bSnrOk/ZbTOPNm2r6OdAodzWcr5
         h3cPCjBnrjs2r+POCMs2/iXmn9/vypZ3SPpH1IF/rELm8+mjTDL4vzo4hDTJcDvQLYbE
         6M4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740509302; x=1741114102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKPdeJEIm5j9QWNBqcrVgnkGdH/Cc0RtDIhKeCC9ldQ=;
        b=V7Jaqnm35NsfrGsGuIOC9vUIpNTPC9/zQG9oz7hq7mrYdVnM0xQhnyq77TWI8WjI14
         DzrG8k8f1QcWV6k4G6HxmCRi4T9fdfy+9pXoeb4oK6liRmTaBESyfnocP7vtr9THXcKV
         NWxJ+qHWNoq1Z1U6sVSyH5/9RyppzR3KIpfI8AouhIJ4qUYNxLg3Gkp4EzARalsMU99r
         YiV0TZoL8wBo2VRptggJXcHj6Mr9INSM+EZD861HgObZbss4g6tY1QnT4+iwwsuxCg/7
         QCIxA3BUvrHlVXuaiGpaVX5IjEJU2UX5HacxYJYRtXL6HkPvHKB31v8Tz2O8tu8sQXQ2
         sFcA==
X-Forwarded-Encrypted: i=1; AJvYcCUz13LWrq3moAEDp2CPjVTnizeHxHi42mg1HWXs74XzSrMkB/yvVBi9v+hGDyT/K+wMggbS2oxFB8L03Oby@vger.kernel.org, AJvYcCXQvvEVk34zltnorf1t1EESBN+14v2NMyCEXCsnL9cdQFF5sVoADbHzpXDiZctqeXNK/n7ZwDB2qcXi@vger.kernel.org, AJvYcCXTwY0Eizhq+twNCWEJjYhAHZIdcpmcN/tLzFY+RIz3HUKjvyFiu3CMfa/LDUSXrqpD6FcRljHkWU05@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9fgPG5soZAZff85Iypt+EHR9jEiBv7uzKl0chwa05PzbBx3D
	akVJxFNPinfCMqAFPHd/+XK/8nJB3sycEsnI4nL9FkY0fAowaGfL
X-Gm-Gg: ASbGncsvaYGg3xeOF/POFAX0HvqJj1Vl7e6hEtBz/iQ0O7yinugYzGWLTdwgZLNLdAq
	7b2xfY5FTYrvPwe4UolKyu6t2bI+vUUc0bCjBADsJZkH/MFF49MvvFOaKx8EFkaB/HnBrHJiUPW
	zGzefdtTXqDBfHLFG7u/hH3GyUyyLQwDQ9uHL0RXvt9NKHrHYfoN9inJrb/OWFZVBlB72BcreYE
	d7fjNPoSo50sul9tqiDSNG/FgJJVH2jPb0xLG0QdZzm6eBhGzUshPSn1CrZ6EUHxtnvPG/B+9yD
	Zrb0+ZopbdJtq8jhpFt+sWWhkMywuDihSzp/VrI8YtcVVDQEgy9Cpwf6SLY2iAwB6e6px5z0PZs
	y
X-Google-Smtp-Source: AGHT+IHSjccqHYhEVYhXqYCUvC+f2bEC9jFMNeFPtwxhRaojPOSAbGXHZn71Dib+UeNS7hTmmNDCqw==
X-Received: by 2002:a17:907:7fa1:b0:abb:9c8a:fbcd with SMTP id a640c23a62f3a-abed107b0e2mr500552266b.53.1740509302080;
        Tue, 25 Feb 2025 10:48:22 -0800 (PST)
Received: from [192.168.50.244] (83.8.202.192.ipv4.supernova.orange.pl. [83.8.202.192])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1da56b2sm183428866b.79.2025.02.25.10.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:48:21 -0800 (PST)
Message-ID: <238b8798-1c6f-4f60-b30e-766142a09306@gmail.com>
Date: Tue, 25 Feb 2025 19:48:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artur Weber <aweber.kernel@gmail.com>
Subject: Re: [PATCH RFC 3/5] clk: bcm281xx: implement prerequisite clocks
To: Alex Elder <elder@riscstar.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, Stanislav Jakubek
 <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
 <20250216-kona-bus-clock-v1-3-e8779d77a6f2@gmail.com>
 <d4aa25fb-2cc0-4b1a-a376-936e7e83233a@riscstar.com>
Content-Language: en-US
In-Reply-To: <d4aa25fb-2cc0-4b1a-a376-936e7e83233a@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.02.2025 17:20, Alex Elder wrote:
> On 2/16/25 10:12 AM, Artur Weber wrote:
>> From: Alex Elder <elder@kernel.org>
>>
>> Allow a clock to specify a "prerequisite" clock, identified by its
>> name.  The prerequisite clock must be prepared and enabled before a
>> clock that depends on it is used.  In order to simplify locking, we
>> require a clock and its prerequisite to be associated with the same
>> CCU.  (We'll just trust--but not verify--that nobody defines a cycle
>> of prerequisite clocks.)
>>
>> Rework the KONA_CLK() macro, and define a new KONA_CLK_PREREQ()
>> variant that allows a prerequisite clock to be specified.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> --- Artur: rebase on v6.13, move prereq prepare/unprepare to main
>>      prepare/unprepare functions, use locking versions of clk_prepare
>>      and clk_enable since the non-locking versions are no longer
>>      public ---
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> 
> I'm surprised there is no prepare function for the peripheral
> clocks.

Not sure I follow - there is a prepare function for peri clocks, the
same one as for all Kona clocks - kona_clk_prepare. Though it only
enables the prereq clock... I assume you mean "prepare function specific
to peripheral clocks", in which case - what should a prepare function
specifically for peripheral clocks do?

As I mentioned in the cover letter, clock initialization has to be done
explicitly at clock init time, since it's required for later operations
like setting the clock rate/parent that are done *before* the first call
to the prepare function happens; otherwise we get errors like this:

[    4.740000] [   T39] kona_peri_clk_set_parent: trigger failed for sdio1
[    4.760000] [   T39] kona_peri_clk_set_rate: gating failure for sdio1
[    5.650000] [   T36] kona_peri_clk_set_parent: trigger failed for sdio3
[    5.670000] [   T36] kona_peri_clk_set_rate: gating failure for sdio3

(I did consider moving the relevant clock initialization to a
"clk_ops.init" function, but left it out of this patchset for brevity.
Might consider actually doing that...)

> The prequisite clock should separate the prepare and the
> enable functionality.  Right now you have kona_clk_prepare()
> doing both.  Instead, a clock's prepare function should
> prepare its prerequisite (if any).  Then its enable function
> should enable its parent.

I copied this behavior from the original patch; there the
prereq_prepare function both prepared and enabled the relevant
prerequisite clock. Indeed doing each step (prepare/enable/disable/
unprepare) in the relevant functions would probably make more sense.

> Should all the users of peripheral clocks just also be required
> to specify the bus clocks as well?  I suppose that doesn't
> encode the prerequisite property (bus comes before peripheral);
> is that truly a requirement?

I see a few problems with that:

- Most drivers only take one clock - that clock is pretty much always
   the peripheral clock (with the only exception being usb_otg_ahb which
   is used for the USB OTG controller).
- Even if they supported both clocks, they would likely just switch them
   on/off at the same time as the equivalent peri clock.

I mostly figured a clock dependency mechanism would work here since it's
what the vendor kernel does - it allows for specifying a dependent clock
and enables/disables it whenever the clock with the dependency is
enabled/disabled.

An alternative option would be to handle the dependency in the device
tree, using "simple-pm-bus" nodes, either:

- Wrapping around each node for a subdevice that uses a peripheral
   clock. This is rather unwieldy since it means a lot of subnodes for
   the most basic of peripherals (sdio1-4, uartb(2,3), etc.). (Also,
   managing the "ranges" properties for all of these sub-busses would
   get annoying unless we specify empty ranges, which according to the
   bindings "is only appropriate if the child node is another 'simple-
   bus' or similar."[1].)

- Using the simple-bus nodes that the BCM2166x DTSI already uses, and
   connecting the relevant bus clock for all the components to them,
   and switching the compatible to "simple-pm-bus". It's less granular,
   but is probably the most sensible option if we go the DT route.

As for whether enabling a bus clock before a peripheral clock is
required... I went ahead and tested it, and the results seem to hint
that it's not.

- I seem to remember that not having the bus clock initialized caused
   some failures on peri clocks, but I can't reproduce this anymore.
   Most likely I'm mistaking it for policy bit setup, which is required
   for gating to work (I have another commit ready to add policy bits
   to all BCM21664 clocks, which I'm planning to send after this
   patchset). And besides, just initializing bus clocks after peri
   clocks seems to work given that's how it's set up right now.

- Also, it seems that all clocks defined with HW_SW_GATE are gated
   on by default, and this state is never cleared afterwards, so all the
   bus clocks I added in the BCM21664 bus clock commit are already
   enabled at startup... after the peri clocks. And given that everything
   works fine, it's probably OK.

Now that I think about it - maybe it would be easier to just keep things
the way they are; drop the prerequisite clock mechanism, let the
driver enable bus clocks by default, then if we wanted to explicitly
control the bus clocks, use the second DT approach I mentioned. If we
ever want to squeeze every last bit of power savings or for any other
potential benefit of keeping bus clocks off, we can revisit this
mechanism later.

Best regards
Artur

[1] https://github.com/devicetree-org/dt-schema/blob/ed9190d20f146d13e262cc9138506326f7d4da91/dtschema/schemas/simple-bus.yaml#L60-L69

