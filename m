Return-Path: <linux-kernel+bounces-199104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DD38D8224
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F0D1C21F1C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160D12DD87;
	Mon,  3 Jun 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEb5N0ce"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EE12C46E;
	Mon,  3 Jun 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417262; cv=none; b=agLqBr+K5xRSoxMdoGYhdvx2e6HueAaQzEd+U+ZO+c1XMMmkTovUdFad0jpK9P6Z9875KwhwuP8W2Z8bnf5cZMxXwPuQUo6BqcmN/afhmTJw6S9LVEiWpH2zoo9aYrGyF+BjkgsMRA3pStkgTCNyQXArfj73wmsK/LEIi7xU2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417262; c=relaxed/simple;
	bh=jFAQdB069Gt4QTX8b38JiH2wefG9AwJc5jgi++86ZX4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=J/Pwo/DVr0a+U14r+v5gU4tuNhDq/f2TBL+8Q2/BrM++YEzN7TASU4RzEMuMKgUgr2lTgX7rE7WecHOVmqLxgH2JcPI/X09k6xpE0T0NjZzIM5WqjBwPg89k2XXVCeBqSv7/ax1kszmWTbcyiOEOsUJzZWRsPSPZIsTgcJmUvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEb5N0ce; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717417260; x=1748953260;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=jFAQdB069Gt4QTX8b38JiH2wefG9AwJc5jgi++86ZX4=;
  b=TEb5N0ceqHqi8d07o7DsJ+6Y2geuIuRKhIsrqeZrP90xYsIbqVuds4oF
   xQPCa/va0AOEDibGs0bY4J0tvbfiFebi8iL80jqXmuw5EAXIBjqHPe2bp
   fE1aH+yMYavbuRDx3rJisnNuZIB3qSPSytcQZahSnjcagMUAqjilJs8Cs
   O7rfY7XdSYspdVefzVTcDKfTCPiUhw+aEUxx+RDxh7nP/D1XkSbSNwJbr
   u43RVwxmkhF5Uk8k1WPkHFsmGIk7Y43epglwvzB2z7jOJR+bYm4PP2696
   6wgfgh7SUAqv7P+WFN/Rs0uTlukl25DvX6f+2Ef11v7Ya90ptWffBY6rq
   A==;
X-CSE-ConnectionGUID: 4M66t9EKSyGhq46rZheVOg==
X-CSE-MsgGUID: Gzv8E4bxThKhpcNcxDuZug==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="17731481"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17731481"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 05:20:38 -0700
X-CSE-ConnectionGUID: FYDliy5JSg+41S59NNnXYg==
X-CSE-MsgGUID: x8zXxQGmSE62o9qOT+PupQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="36758547"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa007.fm.intel.com with ESMTP; 03 Jun 2024 05:20:35 -0700
Message-ID: <1662c9c9-7330-4794-843a-940f05802021@linux.intel.com>
Date: Mon, 3 Jun 2024 15:22:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: joswang <joswang1221@gmail.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 joswang <joswang@lenovo.com>
References: <20240601120640.73556-1-joswang1221@gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC 1/1] usb: host: xhci-plat: add enable XHCI-AVOID-BEI quirk
 by dts
In-Reply-To: <20240601120640.73556-1-joswang1221@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1.6.2024 15.06, joswang wrote:
> From: joswang <joswang@lenovo.com>
> 
> For Synopsys DWC31 2.00a and earlier versions, every isochronous
> interval the BEI(Block Event Interrupt) flag is set for all except
> the last Isoch TRB in a URB, host controller consumes the event
> TRBs in the event ring, once the event ring is full, it will not
> generate an interrupt and will stop all data transmission and command
> execution.
> 
> To avoid the problem of event ring full, the XHCI-AVOID-BEI quirk is
> introduced. Currently, the XHCI-AVOID-BEI quirk has been applied to all
> Intel xHCI controllers, see commit '227a4fd801c8 ("USB: xhci: apply
> XHCI-AVOID-BEI quirk to all Intel xHCI controllers")'.
> 
> For Linux system, each event ring consists of one or more event ring
> segments and each segment is 4 KB that contains 256 TRBs. It seems that
> the TRBs on the event ring are sufficient and the event ring will not be
> full. In real application, if it does happen, event ring is full, host
> controller no interrupt causes the driver to timeout.
> 
> However, applying XHCI-AVOID-BEI quirk will also bring power consumption
> issues. We can consider the application scenarios of the product to decide
> whether to enable it. Therefore, we add the enable XHCI-AVOID-BEI quirk
> through dts configuration to make it more flexible.

Took a look at XHCI_AVOID_BEI quirk and it seems that it evolved from
solving a hardware issue into a interrupt trigger optimization.

How about making current XHCI_AVOID_BEI the default behavior, i.e. force
an interrupt every 32nd isoc trb, and reduce it in case event ring
has more than half a segments of events per interrupt.

The actual XHCI_AVOID_BEI quirk would only be used for hardware that that
can't handle BEI flag properly

something like:

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 266fcbc4bb93..dd161ebf15a3 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3991,16 +3991,17 @@ static int xhci_get_isoc_frame_id(struct xhci_hcd *xhci,
  static bool trb_block_event_intr(struct xhci_hcd *xhci, int num_tds, int i,
                                  struct xhci_interrupter *ir)
  {
-       if (xhci->hci_version < 0x100)
+       if (xhci->hci_version < 0x100 || xhci->quirks & XHCI_AVOID_BEI)
                 return false;
+
         /* always generate an event interrupt for the last TD */
         if (i == num_tds - 1)
                 return false;
         /*
-        * If AVOID_BEI is set the host handles full event rings poorly,
-        * generate an event at least every 8th TD to clear the event ring
+        * host handles full event rings poorly, force an interrupt at least
+        * every 32 isoc TRB to clear the event ring.
          */
-       if (i && ir->isoc_bei_interval && xhci->quirks & XHCI_AVOID_BEI)
+       if (i && ir->isoc_bei_interval)


Thanks
Mathias


