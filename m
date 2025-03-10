Return-Path: <linux-kernel+bounces-553890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1EA59042
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B1A3ABC05
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2922578E;
	Mon, 10 Mar 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/8Kl8jR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4259225774;
	Mon, 10 Mar 2025 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600230; cv=none; b=erNNgQ2mE8ChDspdn3tM7sBiZ2OuPpcKAsw9QY4HwtSdgbnitq3u70nB4HI/0tcOVJ5k114adRDImOR/kzXj1JknVzeAgE2MVUpV+jig0Su/Z7cjN4eclRT/+NrqERwQLEoP88nHt1aI9uEMnhnvzM/gbUVfRtu0Zfzv6D7vF5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600230; c=relaxed/simple;
	bh=Ic5/BUg0zh3v22Lvr4sbgdYXGDaROThhXoV+hio8QiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuGbni7Se6k1q09YiG/OO7WSHElWsrLJxFlUkiEnufw51VOAxEHN0+x7gA74KOGq3xPiMHRiiJI/8tHzRNuadEJv53mihHpamAh0WBA7h3Aao80m2ODGX45HHBilRmgrmtEmpMqd0ERhinKKdygeCVUpvEeh4qm7SAnvff50IFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U/8Kl8jR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741600229; x=1773136229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ic5/BUg0zh3v22Lvr4sbgdYXGDaROThhXoV+hio8QiE=;
  b=U/8Kl8jRlKIicVm5y9GHfN6UMWHp0aq5jcnbJ6qs5I36xj7vP5fLbcHN
   IRQdsXPkvo3pC9waBal1ObC8d9tyCBybqj+C4rNbtl4OXzszG/tEvaSPw
   aUW+ywPf4WTbRWQyNjL7Y5CFJCDUzZaYlaUsqOpW4q/bjDkVguVxE+Xna
   hiGEsC774JNSx6hj5Y2arqJOpCEZiOZquPJz/4M8OfzJmWisOYN9LguYA
   LLuH3rmvZYxtIBUJsLcF4+BaCvlQoJQYrF8DXARzZQBqan/JUDXkgbXcy
   OI0C1AUhxIQOxInm7BJvMrKOJ+TejlsBzA2nT5sFRVCLHOMtifO+OstqH
   w==;
X-CSE-ConnectionGUID: /UJFzOQjQdWz5fatHTNm2A==
X-CSE-MsgGUID: vineWTDWSHyw8jfB8ZJXeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46498783"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="46498783"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 02:50:28 -0700
X-CSE-ConnectionGUID: lQSeG3ktS+mf3OQx7EXdKA==
X-CSE-MsgGUID: SAmL73QMQuq761dMl7aLZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="120150306"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by fmviesa008.fm.intel.com with ESMTP; 10 Mar 2025 02:50:26 -0700
Message-ID: <dabb1140-b26e-4f90-8e65-85e16d99aa49@linux.intel.com>
Date: Mon, 10 Mar 2025 11:51:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] usb: xhci: Deduplicate some endpoint state flag lists
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310093605.2b3d0425@foxbook>
 <20250310093748.201e87cd@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250310093748.201e87cd@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.3.2025 10.37, Michal Pecio wrote:
> xhci_ring_endpoint_doorbell() needs a list of flags which prohibit
> running the endpoint.
> 
> xhci_urb_dequeue() needs the same list, split in two parts, to know
> whether the endpoint is running and how to cancel TDs.
> 
> Define the two partial lists in xhci.h and use them in both functions.
> 
> Add a comment about the AMD Stop Endpoint bug, see commit 28a2369f7d72
> ("usb: xhci: Issue stop EP command only when the EP state is running")
> 
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> --->   drivers/usb/host/xhci-ring.c | 10 ++--------
>   drivers/usb/host/xhci.c      | 16 +++++++++++-----
>   drivers/usb/host/xhci.h      | 16 +++++++++++++++-
>   3 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 0f8acbb9cd21..8aab077d6183 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -555,14 +555,8 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
>   	struct xhci_virt_ep *ep = &xhci->devs[slot_id]->eps[ep_index];
>   	unsigned int ep_state = ep->ep_state;
>   
> -	/* Don't ring the doorbell for this endpoint if there are pending
> -	 * cancellations because we don't want to interrupt processing.
> -	 * We don't want to restart any stream rings if there's a set dequeue
> -	 * pointer command pending because the device can choose to start any
> -	 * stream once the endpoint is on the HW schedule.
> -	 */
> -	if (ep_state & (EP_STOP_CMD_PENDING | SET_DEQ_PENDING | EP_HALTED |
> -			EP_CLEARING_TT | EP_STALLED))
> +	/* Don't start yet if certain endpoint operations are ongoing */
> +	if (ep_state & (EP_CANCEL_PENDING | EP_MISC_OPS_PENDING))
>   		return;
>   >   	trace_xhci_ring_ep_doorbell(slot_id, DB_VALUE(ep_index, stream_id));
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 7492090fad5f..c33134a3003a 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -1762,16 +1762,22 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>   		}
>   	}
>   
> -	/* These completion handlers will sort out cancelled TDs for us */
> -	if (ep->ep_state & (EP_STOP_CMD_PENDING | EP_HALTED | SET_DEQ_PENDING)) {
> +	/*
> +	 * We have a few strategies to give back the cancelled TDs. If the endpoint is running,
> +	 * no other choice - it must be stopped. But if it's not, we avoid queuing Stop Endpoint
> +	 * because this triggers a bug in "AMD SNPS 3.1 xHC" and because our completion handler
> +	 * is complex enough already without having to worry about such things.
> +	 */
> +
> +	/* If cancellation is already running, giveback of all cancelled TDs is guaranteed */
> +	if (ep->ep_state & EP_CANCEL_PENDING) {
>   		xhci_dbg(xhci, "Not queuing Stop Endpoint on slot %d ep %d in state 0x%x\n",
>   				urb->dev->slot_id, ep_index, ep->ep_state);
>   		goto done;
>   	}
>   
> -	/* In this case no commands are pending but the endpoint is stopped */
> -	if (ep->ep_state & (EP_CLEARING_TT | EP_STALLED)) {
> -		/* and cancelled TDs can be given back right away */
> +	/* Cancel immediately if no commands are pending but the endpoint is held stopped */
> +	if (ep->ep_state & EP_MISC_OPS_PENDING) {
>   		xhci_dbg(xhci, "Invalidating TDs instantly on slot %d ep %d in state 0x%x\n",
>   				urb->dev->slot_id, ep_index, ep->ep_state);
>   		xhci_process_cancelled_tds(ep);
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 46bbdc97cc4b..87d87ed08b8b 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -718,9 +718,23 @@ struct xhci_virt_ep {
>    * xhci_ring_ep_doorbell() inspects the flags to decide if the endpoint can be restarted. Another
>    * user is xhci_urb_dequeue(), which must not attempt to stop a Stopped endpoint, due to HW bugs.
>    * An endpoint with pending URBs and no flags preventing restart must be Running for this to work.
> - * Call xhci_ring_doorbell_for_active_rings() or similar after clearing any such flag.
> + * Call xhci_ring_doorbell_for_active_rings() or similar after clearing flags on the lists below.
>    */
>   
> +/*
> + * TD cancellation is in progress. New TDs can be marked as cancelled without further action and
> + * indeed no such action is possible until these commands complete. Their handlers must check for
> + * more cancelled TDs and continue until all are given back. The endpoint must not be restarted.
> + */
> +#define EP_CANCEL_PENDING (SET_DEQ_PENDING | EP_HALTED | EP_STOP_CMD_PENDING)
> +
> +/*
> + * Some other operations are pending which preclude restarting the endpoint. If the endpoint isn't
> + * transitioning to the Stopped state, it has already reached this state and stays in it.
> + */
> +#define EP_MISC_OPS_PENDING (EP_CLEARING_TT | EP_STALLED)
> +

Not sure this helps readability

It defines even more macros to abstract away something that is not complex enough.

It also gives false impression that EP_HALTED would somehow be more part of cancelling a
TD than EP_STALLED, when both of those are about returning a TD with an error due to
transfer issues detected by host, not class driver cancelling URBs

Thanks
Mathias


