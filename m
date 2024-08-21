Return-Path: <linux-kernel+bounces-295211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C139598AC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931B11C21593
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798B31E57A0;
	Wed, 21 Aug 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5RcHhmP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42004199949;
	Wed, 21 Aug 2024 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724232215; cv=none; b=j3/cl3PH/hVT0HUbee0HyPVklIPe1KCeKMxpDPuN9AzQg+TqH5bxBO1sHsDZIIxbmRhNl6f1iejbXIgXPgPZ+fXKt26rq9+tcIN4NaSVuaL2TXgClgGc3Bat9KJTwn9fqv02whJSiKxw6IImHCrOicGRBnSxIXUqm4cHMjLRNXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724232215; c=relaxed/simple;
	bh=GQmvh93n0sjvEBciCjg3yPXh4xUoRnlnPYM+eNVB4q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4ATn72VE3qgGUhmOJGKjp/nDSdCV6mCchQ4YN6+BzTQnM7mZRJEU7KrCdhVceeZS2bGKbiA7lJAbnjvqwpPSNetL61bD76yqfmWs9ghVZWzj73ycabFHSHFauJS62adgWlbwRFXOAmVxULGH3PGxk+tdth+I1NSXcUL8zWtOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5RcHhmP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724232214; x=1755768214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GQmvh93n0sjvEBciCjg3yPXh4xUoRnlnPYM+eNVB4q0=;
  b=P5RcHhmPCbjeMgRMpVAJnD/ljfeVdA3d32gIz/4KePVt9vk23Up5aqFC
   hHLxUj4Zs1NWKO3wJkl18RPBJiFUIAYjSmbR/aWA0/bkvgGTQo3nJc6tL
   NPHR8mwuu7LGqubViE+1Kjuup5gJ4CJT2Pop/jto87VJdSdfPZ9IM8i0z
   pQ7+LCwLT8m+ONSMxpOj7Vc04vXhRRRu8BIZ3Tlbdsu/UbVMfahs0+zB5
   FGUYFg4blH+9JoD8PpiwETA9H2EzUWagbXL5o2DUbkt3eJBfX9f5TzjnQ
   ++KI5s62C8YuGv1F9F/qoGfjCvqLlFycGgOBFeHd/DnQwzd6EaAixIjiM
   w==;
X-CSE-ConnectionGUID: VxncY4VgQg+HAB+1g460pQ==
X-CSE-MsgGUID: Oj37dhOlSiGMZ7bDqQvj2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33734713"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33734713"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 02:23:33 -0700
X-CSE-ConnectionGUID: JVwZAN6OSOCIycE2JSTbuw==
X-CSE-MsgGUID: U9HsYzoBT4mU2Ci7vwClgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61795229"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa008.jf.intel.com with ESMTP; 21 Aug 2024 02:23:31 -0700
Message-ID: <76daeba0-ac1a-4e05-8d25-3966526b464e@linux.intel.com>
Date: Wed, 21 Aug 2024 12:25:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xhci: pci: If no ports have wakeup enabled then
 disable PCI device at S4
To: superm1@kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 mika.westerberg@linux.intel.com,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240712185418.937087-1-superm1@kernel.org>
 <20240712185418.937087-2-superm1@kernel.org>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240712185418.937087-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.7.2024 21.54, superm1@kernel.org wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If a port on an XHCI controller hasn't been marked for wakeup at S4, then
> leaving it at D0 will needlessly consume power than necessary.
> 
> Explicitly check ports configured for wakeup and if none are found then
> put the controller into D3hot before hibernate.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/usb/host/xhci-pci.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 05881153883ec..4408d4caf66d2 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -823,6 +823,7 @@ static int xhci_pci_poweroff_late(struct usb_hcd *hcd, bool do_wakeup)
>   	struct usb_device	*udev;
>   	u32			portsc;
>   	int			i;
> +	bool			wakeup = false;
>   
>   	/*
>   	 * Systems with XHCI_RESET_TO_DEFAULT quirk have boot firmware that
> @@ -860,6 +861,14 @@ static int xhci_pci_poweroff_late(struct usb_hcd *hcd, bool do_wakeup)
>   			 port->rhub->hcd->self.busnum, port->hcd_portnum + 1);
>   		portsc = xhci_port_state_to_neutral(portsc);
>   		writel(portsc | PORT_PE, port->addr);
> +		wakeup = true;
> +	}
> +
> +	if (!wakeup) {
> +		struct pci_dev *pdev = to_pci_dev(hcd->self.controller);
> +
> +		xhci_shutdown(hcd);
> +		pci_set_power_state(pdev, PCI_D3hot);

Not sure we should force D3 here.
I think usb core will set the PCI D state in the next .poweroff_noirq stage,

for s4:
.poweroff	= hcd_pci_suspend,
.poweroff_late	= hcd_pci_poweroff_late,
.poweroff_noirq	= hcd_pci_suspend_noirq,

hcd_pci_suspend_noirq()
   pci_prepare_to_sleep();
     target_state = pci_target_state(dev, wakeup)
     pci_set_power_state(dev, target_state)

Maybe the target_state isn't D3 for some reason? (missing ACPI entries?)

Thanks
Mathias

