Return-Path: <linux-kernel+bounces-202201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1358FC924
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0A9284972
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB03191472;
	Wed,  5 Jun 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDLxVNGW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33691946C5;
	Wed,  5 Jun 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583514; cv=none; b=o2IPTCAvHDWQsRXApXyndUtB2D1yeUqt3Sxy4dEIzHIyE1DxNePAouBq9PK2DckWCjXSbk4su36sJ/vczRXFx4PlNEzDlGbpXc4mSVb7xFO/dvQDxwLvZXRip9s6k8IzaMZZQDSyZpxOm6ii3rh5wcAjhBdwr6FSegQ23WwJ9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583514; c=relaxed/simple;
	bh=a9XRqk5YRelt0Lj1N0v4hRcvo12rQA+gq5jQgC9NgiA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=dDUiepSybRQdtpqr25KrenG42UMsHWuGXMFXdVU3WDTykpd1aly4YZLDrMzUtIlJAEB6lBxZ2IB486tK8Qoq06Ll9ZDI8PDnVlgIJsiQS1x+bBOWkUol+74SraHpfKJOMmTRiiHCsP88CMbh2CgBaewuTC7f14FqXWIl8xs0bnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDLxVNGW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717583512; x=1749119512;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=a9XRqk5YRelt0Lj1N0v4hRcvo12rQA+gq5jQgC9NgiA=;
  b=bDLxVNGWfc4BbZvcp5ZpAO9Q270iCvDjKW7kEYdbjkHQrXJfdXMW2dK3
   MAJn6S/Rq/NfUga9THHdOcDOWDvKyyvDBrq3gwL8RSxDSevqNy91MaeD4
   Ivmyp3w+6kaY4OZF37NBA7djLZkdbxzfYEzi1q9PblNtqfjH+hDs08TjS
   UKYYPAqaaAydJ2N64hP7UtMKvFPN7EsA4Q/uk70zYSjaYPapc3E3GCYFu
   OPZLw55HtXwjhEZjv4qf6csYdgvr6Lrzf7G6dsArS6G6gmEflQCMd8saZ
   hB77ipi1KF1hAVslQTdH4BfEmywZPAnBf1un1qe6hNr/ijfHD6135L795
   Q==;
X-CSE-ConnectionGUID: p8hVLTvMSmezvHh95h6miw==
X-CSE-MsgGUID: 9Ns0mmL7QsiiHDmTV9x3jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="18024525"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="18024525"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:31:51 -0700
X-CSE-ConnectionGUID: 6wEWdMNDQN2jP0csSlBTxg==
X-CSE-MsgGUID: GeIuYKWNSRKiUD9w1DP81w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37486558"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 05 Jun 2024 03:31:49 -0700
Message-ID: <c9430561-ecfe-5b36-9574-73a946410eea@linux.intel.com>
Date: Wed, 5 Jun 2024 13:33:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: joswang <joswang1221@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 joswang <joswang@lenovo.com>
References: <20240601120640.73556-1-joswang1221@gmail.com>
 <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
 <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
In-Reply-To: <CAMtoTm1u+8ynBRaWgCMVgaR+dBoZfNGhzGqmvooBSDxZm5Qx+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5.6.2024 8.37, joswang wrote:
> On Mon, Jun 3, 2024 at 8:21 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> On 1.6.2024 15.06, joswang wrote:
>>> From: joswang <joswang@lenovo.com>
>>>
>>> For Synopsys DWC31 2.00a and earlier versions, every isochronous
>>> interval the BEI(Block Event Interrupt) flag is set for all except
>>> the last Isoch TRB in a URB, host controller consumes the event
>>> TRBs in the event ring, once the event ring is full, it will not
>>> generate an interrupt and will stop all data transmission and command
>>> execution.
>>>
>>> To avoid the problem of event ring full, the XHCI-AVOID-BEI quirk is
>>> introduced. Currently, the XHCI-AVOID-BEI quirk has been applied to all
>>> Intel xHCI controllers, see commit '227a4fd801c8 ("USB: xhci: apply
>>> XHCI-AVOID-BEI quirk to all Intel xHCI controllers")'.
>>>
>>> For Linux system, each event ring consists of one or more event ring
>>> segments and each segment is 4 KB that contains 256 TRBs. It seems that
>>> the TRBs on the event ring are sufficient and the event ring will not be
>>> full. In real application, if it does happen, event ring is full, host
>>> controller no interrupt causes the driver to timeout.
>>>
>>> However, applying XHCI-AVOID-BEI quirk will also bring power consumption
>>> issues. We can consider the application scenarios of the product to decide
>>> whether to enable it. Therefore, we add the enable XHCI-AVOID-BEI quirk
>>> through dts configuration to make it more flexible.
>>
>> Took a look at XHCI_AVOID_BEI quirk and it seems that it evolved from
>> solving a hardware issue into a interrupt trigger optimization.
> Thanks for reviewing the code.
> Yes, you optimized the interrupt triggering frequency.
>>
>> How about making current XHCI_AVOID_BEI the default behavior, i.e. force
>> an interrupt every 32nd isoc trb, and reduce it in case event ring
>> has more than half a segments of events per interrupt.
> Yes，enabling XHCI_AVOID_BEI quirk is to solve the problem of event ring fullness
>>
>> The actual XHCI_AVOID_BEI quirk would only be used for hardware that that
>> can't handle BEI flag properly
>>
>> something like:
>>
>> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
>> index 266fcbc4bb93..dd161ebf15a3 100644
>> --- a/drivers/usb/host/xhci-ring.c
>> +++ b/drivers/usb/host/xhci-ring.c
>> @@ -3991,16 +3991,17 @@ static int xhci_get_isoc_frame_id(struct xhci_hcd *xhci,
>>    static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, int i,
>>                                    struct xhci_interrupter *ir)
>>    {
>> -       if (xhci->hci_version < 0x100)
>> +       if (xhci->hci_version < 0x100 || xhci->quirks & XHCI_AVOID_BEI)
>>                   return false;
>> +
>>           /* always generate an event interrupt for the last TD */
>>           if (i == num_tds - 1)
>>                   return false;
>>           /*
>> -        * If AVOID_BEI is set the host handles full event rings poorly,
>> -        * generate an event at least every 8th TD to clear the event ring
>> +        * host handles full event rings poorly, force an interrupt at least
>> +        * every 32 isoc TRB to clear the event ring.
>>            */
>> -       if (i && ir->isoc_bei_interval && xhci->quirks & XHCI_AVOID_BEI)
>> +       if (i && ir->isoc_bei_interval)
>>
> For Synopsys DWC31 2.00a IP and earlier versions, the corresponding
> driver is in drivers/usb/dwc3/core.c.
> If XHCI_AVOID_BEI quirk is not enabled, in other words, an interrupt
> is triggered every 32nd isoc trb, then
> the event ring may be full. After the event ring is full, the
> controller cannot trigger an interrupt, causing the driver
> to timeout.

I was thinking of turning XHCI_AVOID_BEI behavior into the new default, so no
quirk flag would be needed:

Currently without the quirk flag:

- ISOC TRBs trigger interrupt if TRB is the last in the TD

Currently with XHCI_AVOID_BEI quirk flag:

- ISOC TRBs trigger interrupt if TRB is the last in the TD
- Interrupt is additionally triggered every 32 isoc TRB (initially).
- if more than 128 events are processed in one interrupt then the
   32 is halved, and we trigger an interrupts every 16th isoc TRB, and so
   on, 16 -> 8...

I would remove the quirk flag, and make all controllers interrupt
behave as if it was set. i.e. interrupt at least every 32 isoc TRB

> My initial solution:
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index a171b27a7845..1e33e58c7281 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -126,7 +126,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
> 
>   int dwc3_host_init(struct dwc3 *dwc)
>   {
> -       struct property_entry   props[5];
> +       struct property_entry   props[6];
>          struct platform_device  *xhci;
>          int                     ret, irq;
>          int                     prop_idx = 0;
> @@ -180,6 +180,9 @@ int dwc3_host_init(struct dwc3 *dwc)
>          if (DWC3_VER_IS_WITHIN(DWC3, ANY, 300A))
>                  props[prop_idx++] =
> PROPERTY_ENTRY_BOOL("quirk-broken-port-ped");
> 
> +       if (DWC3_VER_IS_WITHIN(DWC31, ANY, 200A))
> +               props[prop_idx++] = PROPERTY_ENTRY_BOOL("quirk-avoid-bei");
> +
>          if (prop_idx) {
>                  ret = device_create_managed_software_node(&xhci->dev,
> props, NULL);
>                  if (ret) {
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 3d071b875308..e1071827d4b3 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -253,6 +253,9 @@ int xhci_plat_probe(struct platform_device *pdev,
> struct device *sysdev, const s
>                  if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
>                          xhci->quirks |= XHCI_BROKEN_PORT_PED;
> 
> +               if (device_property_read_bool(tmpdev, "quirk-avoid-bei"))
> +                       xhci->quirks |= XHCI_AVOID_BEI;
> +
>                  if (device_property_read_bool(tmpdev,
> "xhci-sg-trb-cache-size-quirk"))
>                          xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
> 
> I consider that enabling XHCI_AVOID_BEI quirk will increase the number
> of isoc transmission
> interrupts, and some specific applications of products may not have
> full event rings.
> For Synopsys DWC31 2.00a IP and earlier versions, XHCI_AVOID_BEI quirk
> is forced to be enabled,
> which is not the best solution. Therefore, the second solution is
> generated, which is to remove the
> modification of drivers/usb/dwc3/host.c file, only keep
> drivers/usb/host/xhci-plat.c, enable XHCI_AVOID_BEI
> quirk by adding dts configuration. Let users decide whether to enable
> XHCI_AVOID_BEI quirk based on
> the specific application of the product.

Is there an actual real world case where interrupting every 32nd ISOC TRB is
too often?

UVC driver for example has defined UVC_MAX_PACKETS 32, meaning a common isoc
usb camera has max 32 TRBs per TD, and naturally interrupt at least every 32
isoc TRB

To me the problem seems to be the other way around, we see cases like this where
we are not interrupting often enough, and event ring fills up.

Thanks
Mathias


