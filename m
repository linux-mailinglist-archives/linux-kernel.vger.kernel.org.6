Return-Path: <linux-kernel+bounces-525953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47E5A3F7C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAC61671EA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCB2101AE;
	Fri, 21 Feb 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m0J/d1dV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181BA20E31D;
	Fri, 21 Feb 2025 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149595; cv=none; b=ZyTDMgZ8tLNIYY8CPfLG5vvaKjHmb9o7cONOTPS9Ur62KHHC6Dc+z+HvogsO7CiP95IuY8lJujeqtt1hl9OtrRXQBW964iPILSsYvxP/UKeVRhL56k5fW6FZ+KXlWK34G4HHnWTm3D4Px6SId0wD6RkPj2Q7aJ/AwH7mK2TNc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149595; c=relaxed/simple;
	bh=50r3SB5nY0jc7J3bimmbV8BdEzwufMTAjn2U0yjjkMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTuQCNVfLfjdMR7+nr/+HjakrvrsSvE74pptlw7DJPYC7uSe82c5VCqrL18uK2uF4F3EsbOpOeXNy9TZs6LFxGsAfcO0OfL42KrAMsLbcEYMhTrFffMWD6xKjjIdhG8SVfIl+BNCZMEQNijGKX9t7IvZDs+MdbrRoCC6hvWxwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m0J/d1dV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740149595; x=1771685595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=50r3SB5nY0jc7J3bimmbV8BdEzwufMTAjn2U0yjjkMM=;
  b=m0J/d1dVc/78gX0aYWNktpSPGX9PEoWfSkBmPnZEpi2D1rSxp7SHC141
   djVaX1NZJFLE1AH1f2IC9Xd/Bb8Wn7y5FGvRySznmnsW8m0H+uSmVZyFk
   JWWAzD/V+WDS8WQaFjkSL25vv0EMsidiBwxXyIFLmHgtgF3N9c+KReTZ3
   qfsUU0LKC0qit6nb29hbhpJ1Gsb3rZi+8Ks6watzwV0AcZ4EbrWqmnVxU
   I7WsEwuIgdB3U9ieRYN6/S3A8zhT4D0CTQlS9LnNOpnMzLj7PceW8wYY5
   T3r6KGxvuaNnkWLcp7ys2Z0Vs1N0xjMa7fMZVLpMASzo0yq7J7b/la5Y3
   A==;
X-CSE-ConnectionGUID: qcUICjFqSvOXL2wzRRcR4g==
X-CSE-MsgGUID: 5Pjzz4yhTpSTS4S0JOXonQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="44753893"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="44753893"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:53:14 -0800
X-CSE-ConnectionGUID: i9BtSy8ySKaTQb9QOobZhQ==
X-CSE-MsgGUID: ajj6BUeDQIy5ThgLmh8nZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="120486751"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa004.fm.intel.com with ESMTP; 21 Feb 2025 06:53:11 -0800
Message-ID: <d59a6694-e0e7-46b7-874e-0c6acd8c9126@linux.intel.com>
Date: Fri, 21 Feb 2025 16:54:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: xhci: Unify duplicate inc_enq() code
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220234355.2386cb6d@foxbook>
 <20250220234719.5dc47877@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250220234719.5dc47877@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.2.2025 0.47, Michal Pecio wrote:
> Remove a block of code copied from inc_enq(). As often happens, the two
> copies have diverged somewhat - in this case, inc_enq() has a bug where
> it may leave the chain bit of a link TRB unset on a quirky HC. Fix this.
> Remove the pointless 'next' variable which only aliases ring->enqueue.

The linnk TRB chain bit should be set when the ring is created, and never cleared
on those quirky hosts.

> 
> Note: I don't know if any 0.95 xHC ever reached series production, but
> "AMD 0.96 host" appears to be the "Llano" family APU. Example dmesg at
> https://linux-hardware.org/?probe=79d5cfd4fd&log=dmesg
> 
> pci 0000:00:10.0: [1022:7812] type 00 class 0x0c0330
> hcc params 0x014042c3 hci version 0x96 quirks 0x0000000000000608
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>   drivers/usb/host/xhci-ring.c | 135 +++++++++++++++--------------------
>   1 file changed, 58 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 46ca98066856..f400ba85ebc5 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -208,6 +208,52 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
>   	return;
>   }
>   
> +/*
> + * If enqueue points at a link TRB, follow links until an ordinary TRB is reached.
> + * Toggle the cycle bit of passed link TRBs and optionally chain them.
> + */
> +static void inc_enq_past_link(struct xhci_hcd *xhci, struct xhci_ring *ring, u32 chain)
> +{
> +	unsigned int link_trb_count = 0;
> +
> +	while (trb_is_link(ring->enqueue)) {
> +
> +		/*
> +		 * Section 6.4.4.1 of the 0.95 spec says link TRBs cannot have the chain bit
> +		 * set, but other sections talk about dealing with the chain bit set. This was
> +		 * fixed in the 0.96 specification errata, but we have to assume that all 0.95
> +		 * xHCI hardware can't handle the chain bit being cleared on a link TRB.
> +		 *
> +		 * If we're dealing with 0.95 hardware or isoc rings on AMD 0.96 host, override
> +		 * the chain bit to always be set.
> +		 */
> +		if (!xhci_link_chain_quirk(xhci, ring->type)) {
> +			ring->enqueue->link.control &= cpu_to_le32(~TRB_CHAIN);
> +			ring->enqueue->link.control |= cpu_to_le32(chain);
> +		} else {
> +			ring->enqueue->link.control |= cpu_to_le32(TRB_CHAIN);
> +		}
> +
> +		/* Give this link TRB to the hardware */
> +		wmb();
> +		ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
> +
> +		/* Toggle the cycle bit after the last ring segment. */
> +		if (link_trb_toggles_cycle(ring->enqueue))
> +			ring->cycle_state ^= 1;
> +
> +		ring->enq_seg = ring->enq_seg->next;
> +		ring->enqueue = ring->enq_seg->trbs;
> +
> +		trace_xhci_inc_enq(ring);
> +
> +		if (link_trb_count++ > ring->num_segs) {
> +			xhci_warn(xhci, "Link TRB loop at enqueue\n");
> +			break;
> +		}
> +	}
> +}
> +
>   /*
>    * See Cycle bit rules. SW is the consumer for the event ring only.
>    *
> @@ -216,11 +262,6 @@ void inc_deq(struct xhci_hcd *xhci, struct xhci_ring *ring)
>    * If we've enqueued the last TRB in a TD, make sure the following link TRBs
>    * have their chain bit cleared (so that each Link TRB is a separate TD).
>    *
> - * Section 6.4.4.1 of the 0.95 spec says link TRBs cannot have the chain bit
> - * set, but other sections talk about dealing with the chain bit set.  This was
> - * fixed in the 0.96 specification errata, but we have to assume that all 0.95
> - * xHCI hardware can't handle the chain bit being cleared on a link TRB.
> - *
>    * @more_trbs_coming:	Will you enqueue more TRBs before calling
>    *			prepare_transfer()?
>    */
> @@ -228,8 +269,6 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
>   			bool more_trbs_coming)
>   {
>   	u32 chain;
> -	union xhci_trb *next;
> -	unsigned int link_trb_count = 0;
>   
>   	chain = le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
>   
> @@ -238,48 +277,16 @@ static void inc_enq(struct xhci_hcd *xhci, struct xhci_ring *ring,
>   		return;
>   	}
>   
> -	next = ++(ring->enqueue);
> -
> -	/* Update the dequeue pointer further if that was a link TRB */
> -	while (trb_is_link(next)) {
> -
> -		/*
> -		 * If the caller doesn't plan on enqueueing more TDs before
> -		 * ringing the doorbell, then we don't want to give the link TRB
> -		 * to the hardware just yet. We'll give the link TRB back in
> -		 * prepare_ring() just before we enqueue the TD at the top of
> -		 * the ring.
> -		 */
> -		if (!chain && !more_trbs_coming)
> -			break;
> -
> -		/* If we're not dealing with 0.95 hardware or isoc rings on
> -		 * AMD 0.96 host, carry over the chain bit of the previous TRB
> -		 * (which may mean the chain bit is cleared).
> -		 */
> -		if (!xhci_link_chain_quirk(xhci, ring->type)) {
> -			next->link.control &= cpu_to_le32(~TRB_CHAIN);
> -			next->link.control |= cpu_to_le32(chain);
> -		}
> -		/* Give this link TRB to the hardware */
> -		wmb();
> -		next->link.control ^= cpu_to_le32(TRB_CYCLE);
> -
> -		/* Toggle the cycle bit after the last ring segment. */
> -		if (link_trb_toggles_cycle(next))
> -			ring->cycle_state ^= 1;
> -
> -		ring->enq_seg = ring->enq_seg->next;
> -		ring->enqueue = ring->enq_seg->trbs;
> -		next = ring->enqueue;
> -
> -		trace_xhci_inc_enq(ring);
> -
> -		if (link_trb_count++ > ring->num_segs) {
> -			xhci_warn(xhci, "%s: Ring link TRB loop\n", __func__);
> -			break;
> -		}
> -	}
> +	ring->enqueue++;
> +
> +	/*
> +	 * If we are in the middle of a TD or the caller plans to enqueue more
> +	 * TDs as one transfer (eg. control), traverse any link TRBs right now.
> +	 * Otherwise, enqueue can stay on a link until the next prepare_ring().
> +	 * This avoids enqueue entering deq_seg and simplifies ring expansion.
> +	 */
> +	if (chain || more_trbs_coming)> +		inc_enq_past_link(xhci, ring, chain);

maybe

if (trb_is_link(ring->enqueue) && (chain || more_trbs_coming))
	inc_eng_past_link(xhci, ring, chain);

Avoids calling inc_enq_past_link() every time we increase enqueue, and explains why we call it.


>   }
>   
>   /*
> @@ -3177,7 +3184,6 @@ static void queue_trb(struct xhci_hcd *xhci, struct xhci_ring *ring,
>   static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
>   		u32 ep_state, unsigned int num_trbs, gfp_t mem_flags)
>   {
> -	unsigned int link_trb_count = 0;
>   	unsigned int new_segs = 0;
>   
>   	/* Make sure the endpoint has been added to xHC schedule */
> @@ -3225,33 +3231,8 @@ static int prepare_ring(struct xhci_hcd *xhci, struct xhci_ring *ep_ring,
>   		}
>   	}
>   
> -	while (trb_is_link(ep_ring->enqueue)) {
> -		/* If we're not dealing with 0.95 hardware or isoc rings
> -		 * on AMD 0.96 host, clear the chain bit.
> -		 */
> -		if (!xhci_link_chain_quirk(xhci, ep_ring->type))
> -			ep_ring->enqueue->link.control &=
> -				cpu_to_le32(~TRB_CHAIN);
> -		else
> -			ep_ring->enqueue->link.control |=
> -				cpu_to_le32(TRB_CHAIN);
> -
> -		wmb();
> -		ep_ring->enqueue->link.control ^= cpu_to_le32(TRB_CYCLE);
> -
> -		/* Toggle the cycle bit after the last ring segment. */
> -		if (link_trb_toggles_cycle(ep_ring->enqueue))
> -			ep_ring->cycle_state ^= 1;
> -
> -		ep_ring->enq_seg = ep_ring->enq_seg->next;
> -		ep_ring->enqueue = ep_ring->enq_seg->trbs;
> -
> -		/* prevent infinite loop if all first trbs are link trbs */
> -		if (link_trb_count++ > ep_ring->num_segs) {
> -			xhci_warn(xhci, "Ring is an endless link TRB loop\n");
> -			return -EINVAL;
> -		}
> -	}
> +	/* Ensure that new TRBs won't overwrite a link */

Maybe add: if (trb_is_link(ep_ring->enqueue)) check here as well

> +	inc_enq_past_link(xhci, ep_ring, 0);
>   
>   	if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue)) {
>   		xhci_warn(xhci, "Missing link TRB at end of ring segment\n");


Otherwise this is a nice cleanup, and the chain bit seems correct, in short:

if quirky host, set chain bit in link TRB before a TD, otherwise clear it.
if quirky host, set chain bit in link TRB mid TD, otherwise set chain bit to
same value as previous TRB.


