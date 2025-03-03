Return-Path: <linux-kernel+bounces-541990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BBA4C43D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5055188EA5B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBE214201;
	Mon,  3 Mar 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd6bWjEW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A8084D13;
	Mon,  3 Mar 2025 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014462; cv=none; b=pqS0Z7GuCInGq8toMlR5z1s7IiJ4Za7ssbYs1bJEaPPxZAiCwiqzLSV3qqnZR6NYsPlGedloc7u33avN0+5bc1TEHHwZDFKYIyxv4cfyg662Ae7gFC87azSHVw3OZSiso3CsUiiM3qNp2ci5gNpzbRSwNm2JkKgWKnqwwPBFwnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014462; c=relaxed/simple;
	bh=hiybgUw9KPpv22AWcOejdFM7b/sDSPS48X0e2YDcPyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=url3G8MnRKOKuCWSWZRK4Uw5zzDGkCDSh2zQhIU+BAI37CqDFd9t0EqH6G/cQh6c+4Xya5F3MK5Hvfd1/VUWl+Airp/X4tguH6eOqCbtevvx92/aHAq48+hPg1o7dolgX7yjEB5DbSe/tOiRxfcQb76Dg1OjOqbK+HP7/isnXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd6bWjEW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741014460; x=1772550460;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hiybgUw9KPpv22AWcOejdFM7b/sDSPS48X0e2YDcPyc=;
  b=Sd6bWjEWZ5EfoiCR8gdMExMmjI275tARdd0GknYKPruPzdGzKMQVI3MV
   TbMBtDs/kj+QWhq1dyjONeA5+KA3+8aZr6oigX+lB6svtK+htAMln/q0Q
   yVdlgEcj/ZN/ZXDnqVqq6y6uzGqARDD7LY+jJ6xCHVkqvsqltpdEb6U9w
   qTMmnN02tadlKRZhGLd4GAPlP5DNkMNQYH7L47CiHj3diFZuFYt9QmJ00
   05HVvM43GiFUor7p4CQ5mlaV097RBW1H4Nveux6shsicMMwrzQqFrOexa
   qf9+lrDlcXqWNBVTwrhjyFg75QS5GSCKAQYnNRRtAPOr5J2r/7IInjXSX
   Q==;
X-CSE-ConnectionGUID: EsLrz8WeTGutOnRopRA2Ig==
X-CSE-MsgGUID: iVBOJIJET6SXD0XRO3A/hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53287147"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="53287147"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 07:07:39 -0800
X-CSE-ConnectionGUID: nPip6LAQRc6hvgyjY4I86g==
X-CSE-MsgGUID: qN4SGlI4RUK5ASjhqIWpfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="148858310"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2025 07:07:38 -0800
Message-ID: <2a44ee96-25e4-4693-8f43-913942091c51@linux.intel.com>
Date: Mon, 3 Mar 2025 17:08:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc
 enpoints
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: ki.chiang65@gmail.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <41847336-9111-4aaa-b3dc-f3c18bb03508@linux.intel.com>
 <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
 <20250303113401.280cb911@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250303113401.280cb911@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3.3.2025 12.34, Michał Pecio wrote:
> 
> Works here too, modulo the obvious build problem.

Thanks for testing on both Etron and Renesas hosts.

> 
> Etron with errors:
> [ 1064.865311] xhci_hcd 0000:06:00.0: Transfer error for slot 1 ep 2 on endpoint
> [ 1064.865322] xhci_hcd 0000:06:00.0: Successful completion on short TX for slot 1 ep 2 with last td comp code 4
> [ 1064.865326] xhci_hcd 0000:06:00.0: Spurious event dma 0x00000000ffef88c0, comp_code 13 after 4
> 
> Renesas with short packets:
> [ 1365.299218] xhci_hcd 0000:08:00.0: Successful completion on short TX for slot 1 ep 2 with last td comp code 13
> [ 1365.299223] xhci_hcd 0000:08:00.0: Spurious event dma 0x00000000ffbbf870, comp_code 13 after 13
> 
> BTW, it says "comp_code 13 after something" because of this crazy
> TRUST_TX_LENGTH hack, which changes trb_comp_code if it's success
> but the residual is nonzero. If I remove the hack,
> 
> Etron:
> [ 2713.630443] xhci_hcd 0000:06:00.0: Spurious event dma 0x00000000ff3b6130, comp_code 1 after 4
> 
> Renesas:
> [ 4033.652300] xhci_hcd 0000:08:00.0: Spurious event dma 0x00000000ffcd1b80, comp_code 1 after 13
> 
> 
> The hack could almost be removed now, but if there really are HCs
> which report Success on the first event, this won't work for them:

This looks better, and I agree that the hack/quirk is annoying, but in fear of regression I
don't want to touch that in this patch yet.

> 
>> +static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
>> +					   struct xhci_ring *ring)
>> +{
>> +	switch (ring->old_trb_comp_code) {
>> +	case COMP_SHORT_PACKET:
>> +		return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
> 
> Could it work without relying on fictional COMP_SHORT_PACKET events?
> 
>> +			if (xhci_spurious_success_tx_event(xhci, ep_ring)) {
>> +				xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
>> +					 &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
>> +				ep_ring->old_trb_comp_code = trb_comp_code;
> 
> This part will (quite arbitrarily IMO) not execute if td_list is empty.

Yes, if td_list is empty we don't take this path, and we don't print any
"ERROR Transfer event TRB DMA ptr not part of current TD..." message either,
just like before.

> 
> I had this idea that "empty td_list" and "no matching TD on td_list"
> are practically identical cases, and their code could be merged.'

Possibly, but not in this patch.

Thanks
Mathias

