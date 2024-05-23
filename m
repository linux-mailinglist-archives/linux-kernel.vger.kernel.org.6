Return-Path: <linux-kernel+bounces-187585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76988CD4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F74B21A37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4FA14A62A;
	Thu, 23 May 2024 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNKRsfqs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D013C80E;
	Thu, 23 May 2024 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716471416; cv=none; b=FUEX4tVM63V3nqq8NAWgSSnSM3iKLtjWh8c4L+APQb8T7qOaVHhLfRu8SnM8D9wHxlUTXv7XESPlRY6noeiLrj0+JL5kREGAUdjxWSX3P7gfJZKc1tfpY7s+p7GLEjnbMi+3FW0jLBdBA4UH5X1rI/JKp+EMSJ+Jy5NGQAUZ7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716471416; c=relaxed/simple;
	bh=kRSxtYfvGaEYm+Suf72IVaC4RooK0ePrcIkOVCA7lR4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=C9EK4E1AJ7wXvf1Ru874ZlcsOlRXT2IjjCrrb/qAv5aTlMc+B9MrvJHQwnA/rYSfs8/sy9YclSY1tWeY1J+A4tpQO/5beBM4+z7MMylYqTng8Yk1JH09ct93VNyY2p+4+jNCw6Yipk4AKyzKNwBCLGSkeFCCtP1KXQKnngkEXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNKRsfqs; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716471415; x=1748007415;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=kRSxtYfvGaEYm+Suf72IVaC4RooK0ePrcIkOVCA7lR4=;
  b=hNKRsfqsypAyw1ZtwRK40RY0CzwxJMuhX6ebmAkghDtdMnFyBv3eBHvN
   7cfQ5H1K8dJOjO9u3Cczzi/6xMXlPdDgETwcOvYn75nKSW1tTX4JRyRFC
   /FVz1oNaTUdgBrJizRenhXVd7bSm2DlbCdBHuNZU5NeqewQI42BzeGvh/
   AJe5EKNG63B8u/CgzwPyZULHx8IHTnRB+SwfJr6Iv6YkwxDQQDGNQ+5Ba
   mDOCUUpmbix1D6wuV24Ztm7VMVGG7YaNMckp0DQSwQXgo124jo1ipYeex
   2aEtlUqSrtgjDgyC+Vz0pdo+tyYPEeibhxDOtT4j0DYlUnEiM4utCq7Tl
   g==;
X-CSE-ConnectionGUID: HegFF0DFQGGqhNni9Nh9yw==
X-CSE-MsgGUID: i6UiiKdzQFa4VwvC/LUfXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="30289874"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="30289874"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 06:36:54 -0700
X-CSE-ConnectionGUID: v5Ok4vCWR9WOxxSbY9f7ow==
X-CSE-MsgGUID: KFwLKT1YSkC01sfJMEv1Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="33515993"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 23 May 2024 06:36:53 -0700
Message-ID: <b936df07-47cc-9921-0550-469fbbb6b49f@linux.intel.com>
Date: Thu, 23 May 2024 16:38:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Jung Daehwan <dh10.jung@samsung.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <CGME20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199@epcas2p4.samsung.com>
 <1716339839-44022-1-git-send-email-dh10.jung@samsung.com>
 <6a4767b5-1e2f-dbec-58ca-c44eb0fca6f1@linux.intel.com>
 <20240523044314.GA58326@ubuntu>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC] usb: host: xhci-mem: Write high first on erst base of
 secondary interrupter
In-Reply-To: <20240523044314.GA58326@ubuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.5.2024 7.43, Jung Daehwan wrote:
> On Wed, May 22, 2024 at 04:40:56PM +0300, Mathias Nyman wrote:
>> On 22.5.2024 4.03, Daehwan Jung wrote:
>>> ERSTBA_HI should be written first on secondary interrupter.
>>> That's why secondary interrupter could be set while Host Controller
>>> is already running.
>>>
>>> [Synopsys]- The host controller was design to support ERST setting
>>> during the RUN state. But since there is a limitation in controller
>>> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
>>> It is supported when the ERSTBA is programmed in 64bit,
>>> or in 32 bit mode ERSTBA_HI before ERSTBA_LO
>>
>> xHCI specification 5.1 "Register Conventions "states that 64 bit
>> registers should be written in low-high order
>>
>>>
>>> [Synopsys]- The internal initialization of event ring fetches
>>> the "Event Ring Segment Table Entry" based on the indication of
>>> ERSTBA_LO written.
>>>
>>
>> Any idea if this is a common issue with this host?
>> Should other 64 bit registers also be written in reverse order.
>>
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>> ---
>>>   drivers/usb/host/xhci-mem.c | 5 ++++-
>>>   drivers/usb/host/xhci.h     | 6 ++++++
>>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
>>> index 3100219..36ee704 100644
>>> --- a/drivers/usb/host/xhci-mem.c
>>> +++ b/drivers/usb/host/xhci-mem.c
>>> @@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
>>>   	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
>>>   	erst_base &= ERST_BASE_RSVDP;
>>>   	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
>>> -	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
>>> +	if (intr_num == 0)
>>> +		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
>>> +	else
>>> +		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
>>
>> This may cause issues with other hosts expecting low-high order as stated
>> in the specification.
>>
>> If all 64 bit registers should be written in high-low order for this host then
>> maybe set a quirk flag and change xhci_write_64()instead.
>>
>> xhci_write_64(...)
>> {
>> 	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
>> 		hi_lo_writeq(val, regs);
>> 	else
>> 		lo_hi_writeq(val, regs);
>> }
>>
> 
> Mathias, Thanks for the comment.
> 
> I've seen this issue only writing the base address of ERST.
> It's better to use a quirk flag as you said.
> How about using the quirk only in xhci_add_interrupter?
> 
> @@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
>    	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
>    	erst_base &= ERST_BASE_RSVDP;
>    	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> 	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
>   	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
> 		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);
> 	else
> 		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> 

This works.
Maybe even skip the xhci_write_64_r() helper and just use hi_lo_writeq() directly.

Thanks
Mathias



