Return-Path: <linux-kernel+bounces-449932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42B79F5847
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 22:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FDB1701F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964531F9AB2;
	Tue, 17 Dec 2024 21:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g50/Vin1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C1208CA;
	Tue, 17 Dec 2024 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469241; cv=none; b=R6Fvy06eOmxMPVN0ABBGOqkN/b3rfpX0HsvgRl5Cy9lNfkgbVqkloOhcv7OGt77SkeeBVjNfp8WGb7g6PG4/sEt13lstpaY9oZV0QcrScWDUC2hfZ60D0uzV3v4odjDvtRrlASqLJaGOLVe1Otreq7JfXTqaXJNQcSULcRccBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469241; c=relaxed/simple;
	bh=gT7SGZ+RgZjr4sjaS4D5vIpdgF1oyCiZb1851h8AvmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kc9D20jExEmWGTbyiCFZss0hhLl38+2Cl6fLei+Wyq0jOPc+hGAJ6nWktAXo0ZJJUQTLLH2SAR7BHTo2GL10jAaET14rUZcGE4s4fBMYRUkmuQdoTxj029Vh5mpJaXRYjhnAG3N8/S5P8aJYEbUcn/gJYuYPyAUl5salPtDPui8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g50/Vin1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748EAC4CED3;
	Tue, 17 Dec 2024 21:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734469240;
	bh=gT7SGZ+RgZjr4sjaS4D5vIpdgF1oyCiZb1851h8AvmI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g50/Vin1NMs21PVMw5jM8YUVvpZ8d1U3+GXgcQKbRuW36vV52pR70iCtjvcVDKDW+
	 DLidMVudZGsMaHwZXQcYRVQw5r6fX+rRDOQw9xG+mgt8HYsn+s5UrNNywyNwQG3yPv
	 Vb6IYog2J7Z7S7MsfLGHYn+kc050dFvj2IvP9TVouN31G9DFRT9hWJi65A9Qk7UFDD
	 LviM9kB/cP704mawxAKgkuT7NDhvMJk7qdlX7hXQ1Cd3+nJ/GnY2a8Pij6TYjGAtdW
	 KTt4i3kEtN56Lahc/Qmti+FKoEnmwcPkuR1faGn7nr0xQ7MDG9TLoGGk7S+WEaYYc8
	 pUy8Z9lA8AVtw==
Message-ID: <ed77988a-ba26-4a71-a8cf-b1e5a6425a2e@kernel.org>
Date: Tue, 17 Dec 2024 23:00:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] xhci: introduce xhci->lost_power flag
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-4-28a17f9715a2@bootlin.com>
 <70aced7f-0311-43b9-96af-c8325c39ff2b@kernel.org>
 <D6AP7JCNSME9.3FS7XCZJ37GM8@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <D6AP7JCNSME9.3FS7XCZJ37GM8@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/12/2024 18:03, Théo Lebrun wrote:
> On Thu Dec 12, 2024 at 1:37 PM CET, Roger Quadros wrote:
>> On 10/12/2024 19:13, Théo Lebrun wrote:
>>> The XHCI_RESET_ON_RESUME quirk allows wrappers to signal that they
>>> expect a reset after resume. It is also used by some to enforce a XHCI
>>> reset on resume (see needs-reset-on-resume DT prop).
>>>
>>> Some wrappers are unsure beforehands if they will reset. Add a mechanism
>>> to signal *at resume* if power has been lost. Parent devices can set
>>> this flag, that defaults to false.
>>>
>>> The XHCI_RESET_ON_RESUME quirk still triggers a runtime_pm_get() on the
>>> controller. This is required as we do not know if a suspend will
>>> trigger a reset, so the best guess is to avoid runtime PM.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  drivers/usb/host/xhci.c | 3 ++-
>>>  drivers/usb/host/xhci.h | 6 ++++++
>>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>> index 5ebde8cae4fc44cdb997b0f61314e309bda56c0d..ae2c8daa206a87da24d58a62b0a0485ebf68cdd6 100644
>>> --- a/drivers/usb/host/xhci.c
>>> +++ b/drivers/usb/host/xhci.c
>>> @@ -1017,7 +1017,8 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
>>>  
>>>  	spin_lock_irq(&xhci->lock);
>>>  
>>> -	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
>>> +	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME ||
>>> +	    xhci->broken_suspend || xhci->lost_power)
>>>  		reinit_xhc = true;
>>>  
>>>  	if (!reinit_xhc) {
>>> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
>>> index 4914f0a10cff42dbc1448dcf7908534d582c848e..32526df75925989d40cbe7d59a187c945f498a30 100644
>>> --- a/drivers/usb/host/xhci.h
>>> +++ b/drivers/usb/host/xhci.h
>>> @@ -1645,6 +1645,12 @@ struct xhci_hcd {
>>>  	unsigned		broken_suspend:1;
>>>  	/* Indicates that omitting hcd is supported if root hub has no ports */
>>>  	unsigned		allow_single_roothub:1;
>>> +	/*
>>> +	 * Signal from upper stacks that we lost power during system-wide
>>> +	 * suspend. Its default value is based on XHCI_RESET_ON_RESUME, meaning
>>> +	 * it is safe for wrappers to not modify lost_power at resume.
>>> +	 */
>>> +	unsigned                lost_power:1;
>>
>> I suppose this is private to XHCI driver and not legitimate to be accessed
>> by another driver after HCD is instantiated?
> 
> Yes it is private.
> 
>> Doesn't access to xhci_hcd need to be serialized via xhci->lock?
> 
> Good question. In theory maybe. In practice I don't see how
> cdns_host_resume(), called by cdns_resume(), could clash with anything
> else. I'll add that to be safe.
> 
>> Just curious, what happens if you don't include patch 4 and 5?
>> Is USB functionality still broken for you?
> 
> No it works fine. Patches 4+5 are only there to avoid the below warning.
> Logging "xHC error in resume" is a lie, so I want to avoid it.

How is it a lie?
The XHCI controller did loose its save/restore state during a PM operation.
As far as XHCI is concerned this is an error. no?

> 
>> Doesn't XHCI driver detect that power was lost and issue a reset in any case
>> via the below code
>>
>>         /* re-initialize the HC on Restore Error, or Host Controller Error */
>>         if ((temp & (STS_SRE | STS_HCE)) &&
>>             !(xhci->xhc_state & XHCI_STATE_REMOVING)) {
>>                 reinit_xhc = true;
>>                 if (!xhci->broken_suspend)
>>                         xhci_warn(xhci, "xHC error in resume, USBSTS 0x%x, Reinit\n", temp);
>>         }
>>
>>>  	/* cached extended protocol port capabilities */
>>>  	struct xhci_port_cap	*port_caps;
>>>  	unsigned int		num_port_caps;
>>>
> 
> I'll wait for your opinion on the [PATCH v6 2/5] email thread before
> sending a new revision.

Sorry for the delay. I'm not an expert in PM but will give my opinion there anyways.

> 
> Thanks,
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
> 

-- 
cheers,
-roger


