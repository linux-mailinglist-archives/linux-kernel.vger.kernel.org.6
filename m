Return-Path: <linux-kernel+bounces-423578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0140C9DA9E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D2C163AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6611E1FF7A7;
	Wed, 27 Nov 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtVgWSWr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18F226AD0;
	Wed, 27 Nov 2024 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732718123; cv=none; b=VTPrFOy0BKOWSOZ70bBsGYavnlo7CFPfIR7JilwnicHLSCiD5/tNUmthTpzif8AdXf1om7Nih6G//mj/F0xj1mljRpOzxAZ9D2JAcyrnm+f0Oxk9er3uL/EI+K33L8G5EvpHRb874E+qQieTd+HPlwTrAGLZbg89jM78TrMEc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732718123; c=relaxed/simple;
	bh=cGcZHaMQtle2IcrxcOfO29L9Bv2SJC1rKcXJPH2eSqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwHI8GYCHN0peQK7vLKQtA0tKHR2Fg8Gq3+jrTrlUOR1rMc7oR8ZaWO/CryllkbKnr/HCKepI359ac0GAzouJx+xOrlJS2tR09WHjMbEAqgAMtEQKCGaM6Hcz2BipFeKUZKigCl5s5IspVLrxa9zA4JRjeNlEeZPvPTGHr9nrOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtVgWSWr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB8BC4CECC;
	Wed, 27 Nov 2024 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732718123;
	bh=cGcZHaMQtle2IcrxcOfO29L9Bv2SJC1rKcXJPH2eSqE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RtVgWSWr6L+OMIViUYHjY1nlwUl8WxOfBfWe0Vq/Se2lIBFGur/MjmicE84pjFaks
	 NyeAibnY7AALXe/00TQRW20GsnoqAaDfuuSS3fyPaMKM9M/x4VORjK5+BfKR4eczZF
	 jeb9iRaFSQBhWLxRkbiu/I5IwavU+0y8PtJVOxVesWJ3ClnkKiKAV11HOZ3kcIWRmW
	 1OzR+6y2rzXch4Tr4rbKgYhbXu8aa/+rtwnwfN9AJT37f3fFPbhC1ehk7TGVzjMxMS
	 peSbbndjTvS3UGl9L/YenRqSIBe/gpk/x+hde/IpEfuKkChybLjgRh6LLFk4J4Etdo
	 Z6DagVhn9Krag==
Message-ID: <1abbedd9-f34d-40be-9d3f-f33fcd012cb3@kernel.org>
Date: Wed, 27 Nov 2024 16:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: dwc3-am62: Re-initialize controller if lost
 power in PM suspend
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, "srk@ti.com" <srk@ti.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241122-am62-dwc3-io-ddr-v1-1-cc4956449420@kernel.org>
 <20241125182343.bfnecsub2oxohrns@synopsys.com>
 <523727cd-7950-45b1-a0d3-3f978e789015@kernel.org>
 <20241126221536.n4ecwbndpelx3bmv@synopsys.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241126221536.n4ecwbndpelx3bmv@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thinh,

On 27/11/2024 00:15, Thinh Nguyen wrote:
> On Mon, Nov 25, 2024, Roger Quadros wrote:
>>
>>
>> On 25/11/2024 20:23, Thinh Nguyen wrote:
>>> On Fri, Nov 22, 2024, Roger Quadros wrote:
>>>> If controller looses power during PM suspend then re-initialize
>>>> it. We use the DEBUG_CFG register to track if controller lost power
>>>> or was reset in PM suspend.
>>>>
>>>> Move all initialization code into dwc3_ti_init() so it can be re-used.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  drivers/usb/dwc3/dwc3-am62.c | 82 +++++++++++++++++++++++++++++---------------
>>>>  1 file changed, 55 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
>>>> index fad151e78fd6..2192222faf4f 100644
>>>> --- a/drivers/usb/dwc3/dwc3-am62.c
>>>> +++ b/drivers/usb/dwc3/dwc3-am62.c
>>>> @@ -108,6 +108,9 @@
>>>>  
>>>>  #define DWC3_AM62_AUTOSUSPEND_DELAY	100
>>>>  
>>>> +#define USBSS_DEBUG_CFG_OFF		0x7
>>>> +#define USBSS_DEBUG_CFG_DISABLED	0x7
>>>
>>> Do we need 2 different macros with the same value of the same register
>>> for this?
>>
>> Oops. This is a mistake. The second one should be 0.
>>
> 
> Ok. Please send a fix.

Yes I will send a v2.

I have a query regarding this. Even though we restore the USB wrapper context
the XHCI driver still complains with below message.

[   68.235111] xhci-hcd xhci-hcd.0.auto: xHC error in resume, USBSTS 0x401, Reinit

Clearly the Save/restore failed and so SRE bit is set.
Is this something to be concerned about or needs addressing?

the host controller functions fine as it is re-initialized by the
XHCI driver.

-- 
cheers,
-roger


