Return-Path: <linux-kernel+bounces-274438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08137947815
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D6828261D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE71509B6;
	Mon,  5 Aug 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oK6iHbk0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054F3BB48;
	Mon,  5 Aug 2024 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849323; cv=none; b=NH+21JsACKxQjLdzO26TCneEVH38ZvSNDjOVHuVtXQ5N/eG4wMmrWn4CcDfLYukZqznABqQK3bJUTAPAEB89aFUnhhMVkyk8y6nmxqBk685c3b7QxglhMWqWUAUFsVEsLMwCvdhd7QQIosxiP1uXXQixgtQkPVda/iSuQPNXsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849323; c=relaxed/simple;
	bh=cvqshu4NOMhBgS0hfBljAsaLU2Pe+X3I8HEC/W2V6e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjZ250cb4XXzCyvmepwANFd8q4SF8P9w9h6nC8WMt1+NPfPdixsupqakjeMXG4qX5Dh2ZidBM1BujZ9sQEJMb5Wd34W1GauEMEbb9PpWmjNBgQI05xLBwSOqW9Rqggrxas9Y9VVdVe2ebyRs+pr9yv3GCyD3LTZbi2to1vVdnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oK6iHbk0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722849322; x=1754385322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cvqshu4NOMhBgS0hfBljAsaLU2Pe+X3I8HEC/W2V6e8=;
  b=oK6iHbk0ZX5lx6BtVFRnLVowtmn9b8jXdchCfn7nJo4JZpK9QWgf43ts
   GyYoa8oGPkkQfl0vJQThliXuNFpsr7l2Sy1S6N6QwPsXQ0YrD7N7X0ew+
   Lq+x54nhQKx2gNM1YkNt5JLz60EZBGI1FeUwiT5F48WUxo0ryV0Y+kHHm
   rVAimD+E9vLuvwWljvC1nCcj43OGCr6nCiV9V3QYRPplxv7qvZHi0KUVV
   CWXpPlg9JT4EorIqQ1iiCh1mfWx2zJ7Gq2J2xpR6tabqFgtY0/fwc7+tp
   +yEiMZltReqfex7zPXinStmTvOiwuYzRF0IyHWYxSfoZrlNacTPTzymY4
   A==;
X-CSE-ConnectionGUID: N+TexjG9RtmoenTOFFrPWQ==
X-CSE-MsgGUID: 3MOrgRQ1Sc2MAJB12LTLDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20468548"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20468548"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 02:15:21 -0700
X-CSE-ConnectionGUID: ncTAOCExTUewIwy5Q6CJSA==
X-CSE-MsgGUID: 6OhP0XGkTPWr3qkBUzbYTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61069121"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 02:15:19 -0700
Message-ID: <ac78b076-b0e5-4d09-a304-8bd68c5ecf38@linux.intel.com>
Date: Mon, 5 Aug 2024 12:17:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: hub_port_reset: Remove extra 40 ms reset
 recovery time
To: Alan Stern <stern@rowland.harvard.edu>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240724111524.25441-1-pmenzel@molgen.mpg.de>
 <c7c299e7-605c-4bd6-afad-dfbfe266aa7e@rowland.harvard.edu>
 <f1e2e2b1-b83c-4105-b62c-a053d18c2985@molgen.mpg.de>
 <3d3416cd-167f-4c50-972b-0eb376a13fdf@rowland.harvard.edu>
 <cee9630e-781e-49b1-82c5-9066552f71b1@molgen.mpg.de>
 <8e300b0b-91f8-4003-a1b9-0f22869ae6e1@rowland.harvard.edu>
 <712dee24-e939-4b1b-b2ea-0c0c12891a62@molgen.mpg.de>
 <3ec64ec7-5e10-4d24-bc6b-f205154f2cf8@rowland.harvard.edu>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <3ec64ec7-5e10-4d24-bc6b-f205154f2cf8@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.8.2024 16.19, Alan Stern wrote:
> On Sun, Aug 04, 2024 at 09:15:34AM +0200, Paul Menzel wrote:
>> [To: +Heikki]
>>
>>
>> Dear Alan, dear Heikki,
>>
>>
>> Am 26.07.24 um 19:48 schrieb Alan Stern:
> 
> ...
> 
>>> It's probably an xHCI thing -- the hardware may stop providing power to
>>> the ports during S3 suspend, or something like that.  The xHCI people
>>> may have a better idea of what's going on.
>>
>> Heikki, can you confirm this. I am attaching the logs with
> 
> You should be asking Mathias, the xHCI maintainer.
> 
>>      echo 'file drivers/usb/* +p' | sudo tee
>> /sys/kernel/debug/dynamic_debug/control
> 
> ...
> 
>> [  149.185600] usb 1-3: usb suspend, wakeup 0
>> [  149.185642] xhci_hcd 0000:00:14.0: Cancel URB 000000003e45896a, dev 4, ep 0x81, starting at offset 0x102ef1010
>> [  149.185661] usb usb2: usb auto-resume
>> [  149.185664] xhci_hcd 0000:00:14.0: // Ding dong!
>> [  149.185736] xhci_hcd 0000:00:14.0: Stopped on Transfer TRB for slot 2 ep 2
>> [  149.185745] xhci_hcd 0000:00:14.0: Removing canceled TD starting at 0x102ef1010 (dma) in stream 0 URB 000000003e45896a
>> [  149.185753] xhci_hcd 0000:00:14.0: Set TR Deq ptr 0x102ef1020, cycle 1
>>
>> [  149.185757] xhci_hcd 0000:00:14.0: // Ding dong!
>> [  149.185763] xhci_hcd 0000:00:14.0: xhci_giveback_invalidated_tds: Keep cancelled URB 000000003e45896a TD as cancel_status is 2
>> [  149.185770] xhci_hcd 0000:00:14.0: Successful Set TR Deq Ptr cmd, deq = @102ef1020
>> [  149.185775] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: Giveback cancelled URB 000000003e45896a TD
>> [  149.185780] xhci_hcd 0000:00:14.0: Giveback URB 000000003e45896a, len = 0, expected = 116, status = -115
>> [  149.185788] xhci_hcd 0000:00:14.0: xhci_handle_cmd_set_deq: All TDs cleared, ring doorbell
>> [  149.185810] hub 2-0:1.0: hub_resume
>> [  149.185816] usb 1-4: usb suspend, wakeup 0
>> [  149.185840] hub 1-0:1.0: hub_suspend
>> [  149.185865] usb usb1: bus suspend, wakeup 0
>> [  149.185894] xhci_hcd 0000:00:14.0: port 1-4 not suspended
>> [  149.185899] xhci_hcd 0000:00:14.0: port 1-3 not suspended
> 
> I have to wonder why xhci-hcd says ports 1-3 and 1-4 are not suspended,
> when only a few lines earlier the log says that devices 1-3 and 1-4
> have gone into USB suspend.

In bus suspend xhci notices that those ports are not properly suspended.
They are both in link state U0 state when they should be in U3 at this point
where devices and hubs should have successfully suspended.
Bus suspend will now try to set those ports to u3

Looks like at least 1-4 and 1-5 report connect status change at resume.
They need to be reset to get to the enabled state

[  149.879684] xhci_hcd 0000:00:14.0: xhci_resume: starting usb1 port polling.
[  149.879687] xhci_hcd 0000:00:14.0: Port change event, 1-4, id 4, portsc: 0x206e1
[  149.879736] xhci_hcd 0000:00:14.0: Port change event, 1-5, id 5, portsc: 0x206e1
...
[  149.937564] xhci_hcd 0000:00:14.0: clear port4 connect change, portsc: 0x6e1
[  149.937591] xhci_hcd 0000:00:14.0: clear port5 connect change, portsc: 0x6e1

Port Status: 0x206e1
	Connected
	Disabled
	Link: Polling
	Powered
	Full Speed
	Connect Status Change

port 1-3 seems like it resumes fine from u3 -> u0, but ends up being reset anyway
during resume, didn't look into why (maybe reset_resume flag is set?)

-Mathias


