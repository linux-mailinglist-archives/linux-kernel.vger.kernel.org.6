Return-Path: <linux-kernel+bounces-212978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D174C90693C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18F01C2270E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22F4140367;
	Thu, 13 Jun 2024 09:48:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998117BBB;
	Thu, 13 Jun 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272121; cv=none; b=cU8axJb1yHGaEMenj2l49fM3xcFpc2RwvjkqlfZZRdRkG3JJ5ZdOitfNJIJQdIGiVDerwR+82cMtDZOG9c0PqeYHQapRNeC/dY5PfrutJ0rF5lszYj3uWfX8FSjGW8Ws25RVlr4rKRI1nSgg/nTw358g03wiUA4tPrJPFCdArXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272121; c=relaxed/simple;
	bh=I3QfX5AzcoxITFq10mDDyKgE81ar3tDQVq/zo/Uz9hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqhkuRrnov/+cXWJN85GySzxD2skBUMv3bnvYOQkYkX7WqdKmITjh4Nce7trRkGg7Uo3iVwKNLQskK4k4/M0eTLt342mg9TAUJqOJNMT+cCz7fe73JzyMB/0V62YF0k+0dLwOE4QiV/VUTwfsaF3PFqO7WdAEyqeNbvAPckIOI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC0D1063;
	Thu, 13 Jun 2024 02:49:02 -0700 (PDT)
Received: from [10.1.36.41] (e110479.arm.com [10.1.36.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A4DD3F5A1;
	Thu, 13 Jun 2024 02:48:35 -0700 (PDT)
Message-ID: <8a968327-131d-40f1-b6e2-effe1390ef70@arm.com>
Date: Thu, 13 Jun 2024 10:48:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
To: Lee Jones <lee@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Ryan Walklin <ryan@testtoast.com>,
 Chris Morgan <macroalpha82@gmail.com>,
 Philippe Simons <simons.philippe@gmail.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
 <20240502093907.GM5338@google.com>
 <56aef347-7582-497e-be02-d82eda7b3528@arm.com>
 <20240612152510.GE1504919@google.com>
 <7fdc23ff-fd55-4347-ac61-dd115eff6ff1@arm.com>
 <20240612154817.GH1504919@google.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240612154817.GH1504919@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lee,

On 12/06/2024 16:48, Lee Jones wrote:
> On Wed, 12 Jun 2024, Andre Przywara wrote:
> 
>> Hi,
>>
>> On 12/06/2024 16:25, Lee Jones wrote:
>>> On Wed, 12 Jun 2024, Andre Przywara wrote:
>>>
>>>> Hi Lee,
>>>>
>>>> On 02/05/2024 10:39, Lee Jones wrote:
>>>>> On Thu, 18 Apr 2024, Andre Przywara wrote:
>>>>>
>>>>>> While we list the "IRQ status *and acknowledge*" registers as volatile,
>>>>>> they are missing from the writable range array, so acknowledging any
>>>>>> interrupts was met with an -EIO error.
>>>>>>
>>>>>> Add the five registers that hold those bits to the writable array.
>>>>>>
>>>>>> Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
>>>>>> Reported-by: Chris Morgan <macromorgan@hotmail.com>
>>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>>> ---
>>>>>>     drivers/mfd/axp20x.c | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>
>>>>> Acked-by: Lee Jones <lee@kernel.org>
>>>>
>>>> Can you please take just this patch as a fix for 6.10? This fixes the power
>>>> key operation.
>>>> This applies cleanly on top of v6.10-rc3, so there is no need for any extra
>>>> immutable branch or coordination with regulator.
>>>> (The same is true independently for patch 2/5, on the regulator side).
>>>
>>> What does the Fixes: commit break?
>>>
>>> Or is it the case that it never worked properly?
>>
>> The interrupt part never worked properly, but so far that's only needed for
>> the power key operation. Unfortunately that part wasn't tested properly
>> initially, so the patches were merged into your tree before that.
> 
> This doesn't sounds like a -fixes candidate.  I'll mark the set for v6.11.

Sorry, correction, this patch missing is actually fatal now, since we 
have an interrupt connected in the DT (which wasn't there initially). 
The code tries to clear all IRQs upon driver probe, which fails due to 
regmap error-ing out. This makes the whole driver fail probing, and 
since the AXP supplies basically every peripheral, the system is dead in 
the water:

[    1.173014] sunxi-rsb 7083000.rsb: RSB running at 3000000 Hz
[    1.174996] axp20x-rsb sunxi-rsb-3a3: AXP20x variant AXP717 found
[    1.198931] axp20x-rsb sunxi-rsb-3a3: Failed to ack 0x49: -5
[    1.220878] axp20x-rsb sunxi-rsb-3a3: failed to add irq chip: -5
[    1.235760] axp20x-rsb sunxi-rsb-3a3:

(Thanks to loki666@IRC for providing the log!)

This was discovered early, long before the merge window, and I was 
actually hoping to have this patch squashed into the original series 
still, but there was this immutable branch already.

So can you please take this as a fix for 6.10?

Cheers,
Andre

