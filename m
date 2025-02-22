Return-Path: <linux-kernel+bounces-527201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08FA4085C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2955700E10
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97320ADFE;
	Sat, 22 Feb 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bt66CAPt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EA2066CC;
	Sat, 22 Feb 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740227904; cv=none; b=bH3RdQt8PrSnLbN5qk/kaoGxb9+abHlANcJ0NDwg2PhmvMLnCYS5AxDH9TkJFxoTcaEXD3/7xfYamECf0h7YodkDBYCTHWG2JUM8wPa3SIjsr9DIuoaWHv7NDqyf1sxHA55aV/RN2gLs1MLVKamkToNDMw8VQKkmE5tIlweCCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740227904; c=relaxed/simple;
	bh=el5ZJUzGnyfrSd3FRUaCFdSD+6NXdRj2/O4Cb5hz+S0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jqB8Zp6e/jaz/CvdUQgTzkkoD+2tySVmM7OM+9pglXQ9cAyh3QaaeLvgfQzBlmQVqKOtTQ6DNa6gpnzogk6++cjfUN7URBfq0jqR8+69CkjsWGrb/LWd09vzZ5/Ku58+BamQMZlf3FMXsPIYSrMqpI5OLR7/SEXv3/9ypjzRt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bt66CAPt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740227903; x=1771763903;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=el5ZJUzGnyfrSd3FRUaCFdSD+6NXdRj2/O4Cb5hz+S0=;
  b=bt66CAPtn9d6qSMX2GQD6lpuJK6hhn343anAaHqufu27ziMCzdvy/LR8
   1CaIALNvypgFjljfxOEeWOUwEBTTumjTL+2sj3O74ypi+5lv/xJqg1ds9
   mT6CKOKAcwTJyF/NXJ7P3UfPEltKF0c/bg92bM8QNl/0XSBJqVkZFRt0a
   Hh+U4IcOT1YrWhw88pdjdenONJ0AIncDbWD3zGvjEs7iRdqrUuAGYUJH+
   8HyT4a5BKvCOW2jqjfhNSfP/tvMvIIhxIQ7mgICtvl1/OpxRWZR+xCc9G
   azhAFSowY/BvGal0rpkzIHU2WmRE6A0PyW2OUIFxRxug6REG9dOJRKdUJ
   Q==;
X-CSE-ConnectionGUID: WSaIptZuR8WgBCHpstn/FQ==
X-CSE-MsgGUID: EVHAEXetQEGJAHR9FjBUbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11353"; a="52026537"
X-IronPort-AV: E=Sophos;i="6.13,307,1732608000"; 
   d="scan'208";a="52026537"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 04:38:22 -0800
X-CSE-ConnectionGUID: YLbd9cYBSyqRLfbzEXM05Q==
X-CSE-MsgGUID: Po69SaA0TYa+2Goio7WFwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116105331"
Received: from nneronin-mobl1.ger.corp.intel.com (HELO [10.245.102.28]) ([10.245.102.28])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 04:38:20 -0800
Message-ID: <be026374-91d2-4b1d-9eb7-568b376f6e72@linux.intel.com>
Date: Sat, 22 Feb 2025 14:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
Subject: Re: [PATCH 2/5] usb: xhci: Clean up the TD skipping loop
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250210083718.2dd337c3@foxbook>
 <20250210083940.626c02d9@foxbook>
Content-Language: en-US
In-Reply-To: <20250210083940.626c02d9@foxbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/02/2025 9.39, Michal Pecio wrote:
> Half of this loop is code which only executes once to deal with cases
> where no TD matches the event and then immediately returns. This code
> has no need to be in any kind of loop, so get it out.
> 
> Shuffle the remaining conditionals a little to improve readability.
> 
> No functional change.
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>  
> -		if (!ep_seg) {
> +		if (ep->skip) {
>  
> -			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
> +			if (!ep_seg && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
>  				skip_isoc_td(xhci, td, ep, status);
>  				if (!list_empty(&ep_ring->td_list))
>  					continue;
> @@ -2880,38 +2880,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
>  				goto check_endpoint_halted;
>  			}
>  
> -			/*
> -			 * Skip the Force Stopped Event. The 'ep_trb' of FSE is not in the current
> -			 * TD pointed by 'ep_ring->dequeue' because that the hardware dequeue
> -			 * pointer still at the previous TRB of the current TD. The previous TRB
> -			 * maybe a Link TD or the last TRB of the previous TD. The command
> -			 * completion handle will take care the rest.
> -			 */
> -			if (trb_comp_code == COMP_STOPPED ||
> -			    trb_comp_code == COMP_STOPPED_LENGTH_INVALID) {
> -				return 0;
> -			}
> -
> -			/*
> -			 * Some hosts give a spurious success event after a short
> -			 * transfer. Ignore it.
> -			 */
> -			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
> -			    ep_ring->last_td_was_short) {
> -				ep_ring->last_td_was_short = false;
> -				return 0;
> -			}
> -
> -			/* HC is busted, give up! */
> -			xhci_err(xhci,
> -				 "ERROR Transfer event TRB DMA ptr not part of current TD ep_index %d comp_code %u\n",
> -				 ep_index, trb_comp_code);
> -			trb_in_td(xhci, td, ep_trb_dma, true);
> -
> -			return -ESHUTDOWN;
> -		}
> -
> -		if (ep->skip) {
>  			xhci_dbg(xhci,
>  				 "Found td. Clear skip flag for slot %u ep %u.\n",
>  				 slot_id, ep_index);

This debug message is now misleading, the TD way or may not be found on non-isochronous.

Before:
	if (ep_seg && ep->skip)
		xhci_dbg(xhci, "Found td. ...
After:
	if (ep->skip && (ep_seg || !isoc))
		xhci_dbg(xhci, "Found td. ...


With Best Regards,
Niklas


