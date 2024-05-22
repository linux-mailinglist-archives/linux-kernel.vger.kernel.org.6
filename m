Return-Path: <linux-kernel+bounces-186290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E5C8CC244
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534FB1F22F36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5714038F;
	Wed, 22 May 2024 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFv7Gb93"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364F13D639;
	Wed, 22 May 2024 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385145; cv=none; b=sWGrySG6mc1YMeP1U+kW5vWxrBHlQIo3mpc2KMpLwQbLS+UbleYqXfGcXo5IF+q0rT+CKe4MjxN2QWIP7FrIHohFlWbkQfqd7cDplk81BFgDSwEcpQrbvcLv4yZZOYM7obOPvkrPal4qdb8tygFKLrpcf+3neG8wTAyjMVaf0zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385145; c=relaxed/simple;
	bh=C8wYKhP4GRxxZY3i0yCo7CFRPS3l6ZJ3JinPO2lbw20=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=nvGXbibSr/8BiEZCRZiMwx462XE0UHQoc4MC+h4h2fgeuAxXQF+uCRpKWcLMjQFUOgOXJ6xnkc3lhbtuVpZ116vuvpGl4ezCmK+oZgQwpeycjGqNwFIM7wViKNus8ywE7ryXAk662VcZeVKovM2V6bD4OG9iBv96fvlwIG0Lfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFv7Gb93; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716385143; x=1747921143;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=C8wYKhP4GRxxZY3i0yCo7CFRPS3l6ZJ3JinPO2lbw20=;
  b=FFv7Gb93EYT0mol22xB8e3SpFqjuxcCHpgnKicp9+2uc9FSk2txrMaWQ
   rJ9ezFsgDocRdrL3wxKQotV0365ufDfGtJHEdaBBQE3dnh98M3moCCbMC
   eWA/DUfwh4/9I4Goa/z5Ly3s2QBQdYqPBCg6d1Uc7XsM26LO5960r/dQV
   UxtkulQRgKmqXB1QvFHvHcxkomAE+eZujWFpERwM3it//+T8qJJUFknMO
   nhUObk0HRKNJzcCBWIT9peXdzSw1dnkgLTWK0chrY76vSqrBhQnCkxdML
   jmaNpSJSVjnj6OJMejJd0PqtTQ2glNnLjQhYhgh1s95/3VYCWKWK9dYMG
   w==;
X-CSE-ConnectionGUID: r9x1sCngRBCoedXUinYusg==
X-CSE-MsgGUID: NnH8BbrBReGOFzE8laldVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="24049568"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="24049568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 06:39:02 -0700
X-CSE-ConnectionGUID: 9nh8CNNKSm6IHeUlWBgVFw==
X-CSE-MsgGUID: eCXBNuQGS2yGRpZkl0HwMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37768842"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 22 May 2024 06:39:00 -0700
Message-ID: <6a4767b5-1e2f-dbec-58ca-c44eb0fca6f1@linux.intel.com>
Date: Wed, 22 May 2024 16:40:56 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Daehwan Jung <dh10.jung@samsung.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
References: <CGME20240522010409epcas2p457b2fcb4f423f2500305053f44ae3199@epcas2p4.samsung.com>
 <1716339839-44022-1-git-send-email-dh10.jung@samsung.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC] usb: host: xhci-mem: Write high first on erst base of
 secondary interrupter
In-Reply-To: <1716339839-44022-1-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.5.2024 4.03, Daehwan Jung wrote:
> ERSTBA_HI should be written first on secondary interrupter.
> That's why secondary interrupter could be set while Host Controller
> is already running.
> 
> [Synopsys]- The host controller was design to support ERST setting
> during the RUN state. But since there is a limitation in controller
> in supporting separate ERSTBA_HI and ERSTBA_LO programming,
> It is supported when the ERSTBA is programmed in 64bit,
> or in 32 bit mode ERSTBA_HI before ERSTBA_LO

xHCI specification 5.1 "Register Conventions "states that 64 bit
registers should be written in low-high order

> 
> [Synopsys]- The internal initialization of event ring fetches
> the "Event Ring Segment Table Entry" based on the indication of
> ERSTBA_LO written.
> 

Any idea if this is a common issue with this host?
Should other 64 bit registers also be written in reverse order.

> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>   drivers/usb/host/xhci-mem.c | 5 ++++-
>   drivers/usb/host/xhci.h     | 6 ++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
> index 3100219..36ee704 100644
> --- a/drivers/usb/host/xhci-mem.c
> +++ b/drivers/usb/host/xhci-mem.c
> @@ -2325,7 +2325,10 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
>   	erst_base = xhci_read_64(xhci, &ir->ir_set->erst_base);
>   	erst_base &= ERST_BASE_RSVDP;
>   	erst_base |= ir->erst.erst_dma_addr & ~ERST_BASE_RSVDP;
> -	xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> +	if (intr_num == 0)
> +		xhci_write_64(xhci, erst_base, &ir->ir_set->erst_base);
> +	else
> +		xhci_write_64_r(xhci, erst_base, &ir->ir_set->erst_base);

This may cause issues with other hosts expecting low-high order as stated
in the specification.

If all 64 bit registers should be written in high-low order for this host then
maybe set a quirk flag and change xhci_write_64()instead.

xhci_write_64(...)
{
	if (xhci->quirks & XHCI_WRITE_64_HI_LO)
		hi_lo_writeq(val, regs);
	else
		lo_hi_writeq(val, regs);
}
	

Thanks
Mathias

