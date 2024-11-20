Return-Path: <linux-kernel+bounces-415940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B059D3F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0444EB320CC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C941DE3B9;
	Wed, 20 Nov 2024 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj+kVtgK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4891BBBDA;
	Wed, 20 Nov 2024 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114179; cv=none; b=Qc+nE+JEEanAILVxBMYQWOIlLQLRlSa1dksdT8XZ7sLn/2RQiPInq6C2Roi8d/7JLOaAhIS2O3gZ6zvu6JgPk9AwcCnHZa7m3Qnttx22tyc4v44Yk3iS2545791RstlIPMZN7t5KfS0yqHPO0dpPCsqBe02TRTVrST6ghb8smRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114179; c=relaxed/simple;
	bh=jMjgTssF8JTk16sOo+gXL1KKvtQZooI008o2ZjDi9Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV+PwvoYNVKNYBn9+FhKRYTcRwJPZa4L/Yo3s7rstnSZ0+cCKL+K9xlK/3ZXUJyZj25SJgu7WDVgb2pecdL0qbzeN4lKo5CTGeBoY89xdHGU0RdFbOcD4L706b8pHJTefSTAUk5MrP5tErO3fd9HIu4Did2j86uLp3cZADumUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj+kVtgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F9C4CED1;
	Wed, 20 Nov 2024 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732114177;
	bh=jMjgTssF8JTk16sOo+gXL1KKvtQZooI008o2ZjDi9Zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Gj+kVtgKs2fEbZoaLU/WK4qRB6Y5lmlFlXJ1B6a/qhogii+CuftNsMve1n963nsNg
	 ubUXC+PT+yFzorSeTCOIT5NKbk4UsnFDVsl/LIRJhhDReLa6NAhnXg5tDGNS4VUE62
	 n75s710NFzJCfQqvV/bU2D1TiYJUJgETZJdV1WigkNUxP8DclWfw6g57arCdUQip5T
	 f7YE1BTYH6JRvoRvwqG2INosdOYalseGBR2VjT3KLcoAqS8AP/XFJdlZTS95v9VaOB
	 xVlayAtsMW16jBXlOyDAGzbQwmK2SkJ7umMPAatdDyJ/6L3QEPtnyu4ai2HpeDjtkj
	 iFXLMwLDeiopg==
Message-ID: <ea3b4e40-8798-4352-8f45-242962532500@kernel.org>
Date: Wed, 20 Nov 2024 16:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] xhci: introduce xhci->lost_power flag
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-9-8664bfb032ac@bootlin.com>
 <1cd45625-84e4-43aa-ae2b-a59f10add898@kernel.org>
 <D42NIH63EHZG.KKWZR2WZB68L@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <D42NIH63EHZG.KKWZR2WZB68L@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Théo,

On 10/09/2024 16:50, Théo Lebrun wrote:
> On Mon Aug 5, 2024 at 3:41 PM CEST, Roger Quadros wrote:
>> On 26/07/2024 21:17, Théo Lebrun wrote:
>>> The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
>>> expect a reset after resume. It is also used by some to enforce a XHCI
>>> reset on resume (see needs-reset-on-resume DT prop).
>>>
>>> Some wrappers are unsure beforehands if they will reset. Add a mechanism
>>> to signal *at resume* if power has been lost. Parent devices can set
>>> this flag, that defaults to the XHCI_RESET_ON_RESUME value.
>>>
>>> The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
>>> controller. This is required as we do not know if a suspend will
>>> trigger a reset, so the best guess is to avoid runtime PM.
>>>
>>> Reset the xhci->lost_power value each time in xhci_resume(), making it
>>> safe for devices to only set lost_power on some resumes.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  drivers/usb/host/xhci.c | 8 +++++++-
>>>  drivers/usb/host/xhci.h | 6 ++++++
>>>  2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 0a8cf6c17f82..2c9b32d339f9 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -1029,9 +1029,12 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>>>  
>>>  	spin_lock_irq(&xhci->lock);
>>>  
>>> -	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
>>> +	if (hibernated || xhci->lost_power || xhci->broken_suspend)
>>
>> Why not treat xhci->lost_power and xhci->quriks & XHCI_RESET_ON_RESUME independently?
>>
>> XHCI_RESET_ON_RESUME is sued by devices that know they always need to be reset on resume.
>>
>> xhci->lost_power is used by devices that don't have consistent behavior.
> 
> The goal is to avoid almost-duplicate functionality. I feel like:
> 
>     XHCI_RESET_ON_RESUME is the default value of xhci->lost_power,
>     which might be modified at resume.
> 
> Is a more straight forward solution than:
> 
>     Both XHCI_RESET_ON_RESUME and xhci->lost_power define if power was
>     lost at resume. First must be statically known, second can be
>     updated during runtime. If second is used, first one must NOT be
>     set.
> 
> Indeed, the first solution brings two additional lines of code as you
> commented below. I'd argue the easier-to-wrap-your-head-around logic is
> more important.
> 
> Tell me if you are convinced the second approach is better.
> 

I would still vote to keep logic tied to separate flags.

so XHCI_RESET_ON_RESUME to always resume on RESET
xhci->lost_power, reset based on runtime checks.

Which implies that platforms using xhci->lost_power should not
set XHCI_RESET_ON_RESUME.

But XHCI maintainers should give their opinion on this.

>>
>>
>>>  		reinit_xhc = true;
>>>  
>>> +	/* Reset to default value, parent devices might correct it at next resume. */
>>> +	xhci->lost_power = !!(xhci->quirks & XHCI_RESET_ON_RESUME);
>>> +
>>
>> then you don't need to do this.
> 
> To be honest, I added this line out of rigor. We could remove it and say
> that any device that modifies xhci->lost_power once at resume must set
> it at each later resume.
> 
> The above line felt like a small safety net to avoid logic mistakes.
> 
>>
>>>  	if (!reinit_xhc) {
>>>  		/*
>>>  		 * Some controllers might lose power during suspend, so wait
>>> @@ -5228,6 +5231,9 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
>>>  	if (get_quirks)
>>>  		get_quirks(dev, xhci);
>>>  
>>> +	/* Default value, that can be corrected at resume. */
>>> +	xhci->lost_power = !!(xhci->quirks & XHCI_RESET_ON_RESUME);
>>> + 
>>
>> nor this.
> 
> Regards,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

-- 
cheers,
-roger


