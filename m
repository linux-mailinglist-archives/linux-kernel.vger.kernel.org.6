Return-Path: <linux-kernel+bounces-536230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19596A47D09
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32973173BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86122D7B3;
	Thu, 27 Feb 2025 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1z+dFJk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14B22D4E4;
	Thu, 27 Feb 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658148; cv=none; b=iS0fdqkQQ0jIx5/lVkMeDSFQKUcFM2cclrJR10zbl0d2mPSvWXY9cifGsCkYr6W0LSxQEj/mrV4x22HexBn+p4Eb5kKgaXR/NMIWcfTT3EYbxQYTsELW/b278rldPpYNpw7Qc2xykEL6lmmwymacXJqNNKsnUViNqLysYOOirWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658148; c=relaxed/simple;
	bh=iw6gpxgNgCBOUaRo1oW1+W4WQuHahR7DBounBYF4vHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qz/RDyAeFe24VZuD9cFfTHHcau6Z72w9M0KRRxPJIF3j8lfv3FWP4hU8BTDKrMu68FW2MsJZgIY7cE0aE5a63/ws0yoP43QZvpzqHznyiMZKVygvlgv9eKsUEp+OtBpfNn3pZo1kHNxzwP0GD3TGA9BY+ZramOwJEYlxL/vhnfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1z+dFJk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740658147; x=1772194147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iw6gpxgNgCBOUaRo1oW1+W4WQuHahR7DBounBYF4vHc=;
  b=i1z+dFJkNMbp2dMKrC/8cQ8AxBwOid9YxSQo9TbLyZzmpkQg1LL4tInV
   C807tczT4OIodgvBeNwYYdekW5MVKGRIVjnHWo39p8a17T/XHu7MEd24d
   ZyEr44Xzabc/YlKIuvONUgOTYqhR19BXiiz38MHFg0hCH2FhM3ExgyOJg
   r6sru+/QMmt63PE5C5YHLfB/e1mtSu1uvDttmTY7mA1lo0ykfdswu81f0
   CNaqcqiUKswdinP3Ifk6qaHOXVbqJ3PFm34K/MGUNrgY8LHA+Pfb+5YbX
   GccBZ88wMaUpNUT/gNf4cWhWUEKoDZxxwWGlNB30NrTcPKAtQIq8gE+3I
   g==;
X-CSE-ConnectionGUID: 2u07U76hTp6CoUNCIdCQog==
X-CSE-MsgGUID: xNt9RaO0QyOODRYBV4EmKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41670733"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41670733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:09:05 -0800
X-CSE-ConnectionGUID: gWMO6CD3SEmDG5AGc8J93w==
X-CSE-MsgGUID: 8P5oN2CVRLGHqI8lceCkXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121611696"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 27 Feb 2025 04:09:03 -0800
Message-ID: <0bce0b2f-1b74-4ffb-b34d-601ff5bd5490@linux.intel.com>
Date: Thu, 27 Feb 2025 14:10:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] xHCI: Isochronous error handling fixes and
 improvements
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Neronin <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250226080202.7eb5e142@foxbook>
 <8bf4212a-72af-4c5d-a9b2-f3363d3ee3cd@linux.intel.com>
 <20250226230501.48e8b23a@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250226230501.48e8b23a@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.2.2025 0.05, Michał Pecio wrote:
> On Wed, 26 Feb 2025 14:41:44 +0200, Mathias Nyman wrote:
>> Updated my for-usb-next branch to this v3 version
> 
> 
> A few remarks regarding "Add helper to find trb from its dma address":
> 
> xhci_dma_to_trb():
> This function could use xhci_for_each_ring_seg.

Good point

> The use of in_range() perhaps deserves a comment, because its
> correctness is not as obvious as it might seem.
> 
> Long story short, my own version:
> 
> /*
>   * Look up a TRB on the ring by its DMA address, return NULL if not found.
>   * Start from deq_seg to optimize for event handling use.
>   *
>   * Note: false positive is possible if dma < TRB_SEGMENT_SIZE *and*
>   * seg->dma > (dma_addr_t) 0 - TRB_SEGMENT_SIZE, but that shouldn't
>   * happen if seg->dma is an allocation of size TRB_SEGMENT_SIZE.
>   */

True, but as you said this shouldn't happen as we allocate TRB_SEGMENT_SIZE bytes
starting at seg->dma, so seg->dma should be at least TRB_SEGMENT_SIZE bytes from
max u64 (or u32)

We can also use "if (dma >= seg->dma && (dma - seg->dma) < TRB_SEGMENT_SIZE)"
instead of in_range(). It's a bit uglier, but we can skip additional notes.
    
> static union xhci_trb *xhci_dma_to_trb(struct xhci_ring *ring, dma_addr_t dma)
> {
>         struct xhci_segment *seg;
> 
>         xhci_for_each_ring_seg(ring->deq_seg, seg)
>                 if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE))
>                         return seg->trbs + (dma - seg->dma) / sizeof(seg->trbs[0]);
> 
>         return NULL;
> }
> 
>> +       struct xhci_td *matched_td;
> 
> This variable is only used as bool so it could be declared as such.
> Other places still use 'td' and assume that it equals 'matched_td'.
> And that's OK because there is no need for iterating further after
> the matching TD is found.

True, it could be just a bool

> 
>> +       /* find the transfer trb this events points to */
>> +       if (ep_trb_dma)
>> +               ep_trb = xhci_dma_to_trb(ep_ring, ep_trb_dma);
> 
> This may deserve a dedicated warning. It's a pathology. Either the
> event is bogus due to internal corruption in the HC, or it's executing
> TRBs from a wrong ring due to damaged/ignored Link TRB or bad Set Deq.
> Or we completely screwed up and are looking at a wrong ep_ring here.
> 
>> -       if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb_dma)
>> +       if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb)
>>                 return 0;
> 
> Good idea. I think I would go further and refuse to handle anything
> when (ep_trb_dma && !ep_trb). Nothing is going to match, nothing good
> will come from trying as far as I see.
> 
> But that's a behavior change, so maybe material for a separate patch.

Idea of this patch is to slowly migrate handle_tx_event() towards the
vision in my feature_transfer_event_rework branch

https://web.git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_transfer_event_rework

Niklas is working towards a similar goal, and he just informed me that this
patch conflicts a bit with his plan to get there, so I might drop this.

Thanks for looking at it.

-Mathias


