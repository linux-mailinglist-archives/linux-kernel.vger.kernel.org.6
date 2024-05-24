Return-Path: <linux-kernel+bounces-188567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E768CE3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C8C1C21045
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85A8562C;
	Fri, 24 May 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFV56/EB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B600D7E59A;
	Fri, 24 May 2024 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543696; cv=none; b=r7UsBrL0IcL0TsGKJdhgvGkrzov0itGG0lIXiNW811/sIMIw/tTLPtJy0oeglWUNsTD8mInwbXEnnDIpOV9QhaEgKbD3cF7tjBMFyunBzNUn+M3RZbQP/zEKeJBSsO34H0Uy1/AafhnF5euN5G2GG2RTboGKWx2C9DMbUFYZESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543696; c=relaxed/simple;
	bh=39w3Dm4QhyNhUgbhI9dPrvSHAukw4/tLKmL24sL5jAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWz1H8Ua2JjVFyM7dNXdvoYDzPo/COaRqYaL4WadHpAKt0Rmp0V31/otzYH2bQ5tumwS1a4vHBi9zI1JubJvBTFVrUvxJaq/AHXRxWW7Ih+a6vFOBuSSA7cFmmrMYryugzR7QPelRzE7fwl1UF999pN9+OCTUpbc6TbXxDk/hqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFV56/EB; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716543694; x=1748079694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=39w3Dm4QhyNhUgbhI9dPrvSHAukw4/tLKmL24sL5jAE=;
  b=lFV56/EBBAo3p7zwBKBVDtfAZgEOutzRbQ9w8UkVjmyl9ygGJnDCfwcm
   AlURKc3XNIQSHCHTi8ZDe+50YKCjp4xQVkgHFkZbU4Tb4DUL63DTf4w51
   kSf8zvllggMh/TaQKo2PkGv+qAEZ1J8K8xQHXIMMVUMbdvtNSYHH7YrF7
   j9WtWf1d8H041CX+rhPJva4FEF599/2zU5yyvX3Tw3zigHd/RpqVS0+Md
   iz6snwk0F/g25oWsn8uuCwWn1WvgNThLhQH/gzKbF4UfvEYD+6K5+lyeW
   nvshcdK4kaZflk8Imzu8xYFsCjH2F2oR3bIQfb2i1usINp1Gybw75Rf1k
   w==;
X-CSE-ConnectionGUID: Skxt3N5NRseS3dUkfvrapg==
X-CSE-MsgGUID: TZ5rk/NKQpOMocd3NnPQzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="16704577"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="16704577"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 02:41:34 -0700
X-CSE-ConnectionGUID: gfXoh0qORkiEKxlQAaslTQ==
X-CSE-MsgGUID: MzTrzmzlQXy8A4KSwHlilQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="38409841"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 May 2024 02:41:31 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sARQQ-0004Rw-2X;
	Fri, 24 May 2024 09:41:24 +0000
Date: Fri, 24 May 2024 17:39:33 +0800
From: kernel test robot <lkp@intel.com>
To: Hector Martin <marcan@marcan.st>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] xhci: Remove dead code in xhci_move_dequeue_past_td()
Message-ID: <202405241706.h0PyUQfL-lkp@intel.com>
References: <20240524-xhci-deadcode-v1-1-a4453a756e0f@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524-xhci-deadcode-v1-1-a4453a756e0f@marcan.st>

Hi Hector,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6]

url:    https://github.com/intel-lab-lkp/linux/commits/Hector-Martin/xhci-Remove-dead-code-in-xhci_move_dequeue_past_td/20240524-151544
base:   a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
patch link:    https://lore.kernel.org/r/20240524-xhci-deadcode-v1-1-a4453a756e0f%40marcan.st
patch subject: [PATCH] xhci: Remove dead code in xhci_move_dequeue_past_td()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240524/202405241706.h0PyUQfL-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241706.h0PyUQfL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241706.h0PyUQfL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-ring.c: In function 'xhci_move_dequeue_past_td':
>> drivers/usb/host/xhci-ring.c:695:1: warning: label 'deq_found' defined but not used [-Wunused-label]
     695 | deq_found:
         | ^~~~~~~~~


vim +/deq_found +695 drivers/usb/host/xhci-ring.c

e6b20121c6d5d1 Mathias Nyman 2017-06-02  633  
d1dbfb942c33bf Mathias Nyman 2021-01-29  634  static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
d1dbfb942c33bf Mathias Nyman 2021-01-29  635  				unsigned int slot_id, unsigned int ep_index,
d1dbfb942c33bf Mathias Nyman 2021-01-29  636  				unsigned int stream_id, struct xhci_td *td)
d1dbfb942c33bf Mathias Nyman 2021-01-29  637  {
d1dbfb942c33bf Mathias Nyman 2021-01-29  638  	struct xhci_virt_device *dev = xhci->devs[slot_id];
d1dbfb942c33bf Mathias Nyman 2021-01-29  639  	struct xhci_virt_ep *ep = &dev->eps[ep_index];
d1dbfb942c33bf Mathias Nyman 2021-01-29  640  	struct xhci_ring *ep_ring;
d1dbfb942c33bf Mathias Nyman 2021-01-29  641  	struct xhci_command *cmd;
d1dbfb942c33bf Mathias Nyman 2021-01-29  642  	struct xhci_segment *new_seg;
d1dbfb942c33bf Mathias Nyman 2021-01-29  643  	union xhci_trb *new_deq;
d1dbfb942c33bf Mathias Nyman 2021-01-29  644  	int new_cycle;
d1dbfb942c33bf Mathias Nyman 2021-01-29  645  	dma_addr_t addr;
d1dbfb942c33bf Mathias Nyman 2021-01-29  646  	u64 hw_dequeue;
d1dbfb942c33bf Mathias Nyman 2021-01-29  647  	bool cycle_found = false;
d1dbfb942c33bf Mathias Nyman 2021-01-29  648  	bool td_last_trb_found = false;
d1dbfb942c33bf Mathias Nyman 2021-01-29  649  	u32 trb_sct = 0;
d1dbfb942c33bf Mathias Nyman 2021-01-29  650  	int ret;
d1dbfb942c33bf Mathias Nyman 2021-01-29  651  
d1dbfb942c33bf Mathias Nyman 2021-01-29  652  	ep_ring = xhci_triad_to_transfer_ring(xhci, slot_id,
d1dbfb942c33bf Mathias Nyman 2021-01-29  653  			ep_index, stream_id);
d1dbfb942c33bf Mathias Nyman 2021-01-29  654  	if (!ep_ring) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  655  		xhci_warn(xhci, "WARN can't find new dequeue, invalid stream ID %u\n",
d1dbfb942c33bf Mathias Nyman 2021-01-29  656  			  stream_id);
d1dbfb942c33bf Mathias Nyman 2021-01-29  657  		return -ENODEV;
d1dbfb942c33bf Mathias Nyman 2021-01-29  658  	}
d1dbfb942c33bf Mathias Nyman 2021-01-29  659  
d1dbfb942c33bf Mathias Nyman 2021-01-29  660  	hw_dequeue = xhci_get_hw_deq(xhci, dev, ep_index, stream_id);
d1dbfb942c33bf Mathias Nyman 2021-01-29  661  	new_seg = ep_ring->deq_seg;
d1dbfb942c33bf Mathias Nyman 2021-01-29  662  	new_deq = ep_ring->dequeue;
d1dbfb942c33bf Mathias Nyman 2021-01-29  663  	new_cycle = hw_dequeue & 0x1;
d1dbfb942c33bf Mathias Nyman 2021-01-29  664  
d1dbfb942c33bf Mathias Nyman 2021-01-29  665  	/*
d1dbfb942c33bf Mathias Nyman 2021-01-29  666  	 * We want to find the pointer, segment and cycle state of the new trb
d1dbfb942c33bf Mathias Nyman 2021-01-29  667  	 * (the one after current TD's last_trb). We know the cycle state at
d1dbfb942c33bf Mathias Nyman 2021-01-29  668  	 * hw_dequeue, so walk the ring until both hw_dequeue and last_trb are
d1dbfb942c33bf Mathias Nyman 2021-01-29  669  	 * found.
d1dbfb942c33bf Mathias Nyman 2021-01-29  670  	 */
d1dbfb942c33bf Mathias Nyman 2021-01-29  671  	do {
d1dbfb942c33bf Mathias Nyman 2021-01-29  672  		if (!cycle_found && xhci_trb_virt_to_dma(new_seg, new_deq)
d1dbfb942c33bf Mathias Nyman 2021-01-29  673  		    == (dma_addr_t)(hw_dequeue & ~0xf)) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  674  			cycle_found = true;
d1dbfb942c33bf Mathias Nyman 2021-01-29  675  			if (td_last_trb_found)
d1dbfb942c33bf Mathias Nyman 2021-01-29  676  				break;
d1dbfb942c33bf Mathias Nyman 2021-01-29  677  		}
d1dbfb942c33bf Mathias Nyman 2021-01-29  678  		if (new_deq == td->last_trb)
d1dbfb942c33bf Mathias Nyman 2021-01-29  679  			td_last_trb_found = true;
d1dbfb942c33bf Mathias Nyman 2021-01-29  680  
d1dbfb942c33bf Mathias Nyman 2021-01-29  681  		if (cycle_found && trb_is_link(new_deq) &&
d1dbfb942c33bf Mathias Nyman 2021-01-29  682  		    link_trb_toggles_cycle(new_deq))
d1dbfb942c33bf Mathias Nyman 2021-01-29  683  			new_cycle ^= 0x1;
d1dbfb942c33bf Mathias Nyman 2021-01-29  684  
d1dbfb942c33bf Mathias Nyman 2021-01-29  685  		next_trb(xhci, ep_ring, &new_seg, &new_deq);
d1dbfb942c33bf Mathias Nyman 2021-01-29  686  
d1dbfb942c33bf Mathias Nyman 2021-01-29  687  		/* Search wrapped around, bail out */
d1dbfb942c33bf Mathias Nyman 2021-01-29  688  		if (new_deq == ep->ring->dequeue) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  689  			xhci_err(xhci, "Error: Failed finding new dequeue state\n");
d1dbfb942c33bf Mathias Nyman 2021-01-29  690  			return -EINVAL;
d1dbfb942c33bf Mathias Nyman 2021-01-29  691  		}
d1dbfb942c33bf Mathias Nyman 2021-01-29  692  
d1dbfb942c33bf Mathias Nyman 2021-01-29  693  	} while (!cycle_found || !td_last_trb_found);
d1dbfb942c33bf Mathias Nyman 2021-01-29  694  
d1dbfb942c33bf Mathias Nyman 2021-01-29 @695  deq_found:
d1dbfb942c33bf Mathias Nyman 2021-01-29  696  
d1dbfb942c33bf Mathias Nyman 2021-01-29  697  	/* Don't update the ring cycle state for the producer (us). */
d1dbfb942c33bf Mathias Nyman 2021-01-29  698  	addr = xhci_trb_virt_to_dma(new_seg, new_deq);
d1dbfb942c33bf Mathias Nyman 2021-01-29  699  	if (addr == 0) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  700  		xhci_warn(xhci, "Can't find dma of new dequeue ptr\n");
d1dbfb942c33bf Mathias Nyman 2021-01-29  701  		xhci_warn(xhci, "deq seg = %p, deq ptr = %p\n", new_seg, new_deq);
d1dbfb942c33bf Mathias Nyman 2021-01-29  702  		return -EINVAL;
d1dbfb942c33bf Mathias Nyman 2021-01-29  703  	}
d1dbfb942c33bf Mathias Nyman 2021-01-29  704  
d1dbfb942c33bf Mathias Nyman 2021-01-29  705  	if ((ep->ep_state & SET_DEQ_PENDING)) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  706  		xhci_warn(xhci, "Set TR Deq already pending, don't submit for 0x%pad\n",
d1dbfb942c33bf Mathias Nyman 2021-01-29  707  			  &addr);
d1dbfb942c33bf Mathias Nyman 2021-01-29  708  		return -EBUSY;
d1dbfb942c33bf Mathias Nyman 2021-01-29  709  	}
d1dbfb942c33bf Mathias Nyman 2021-01-29  710  
d1dbfb942c33bf Mathias Nyman 2021-01-29  711  	/* This function gets called from contexts where it cannot sleep */
d1dbfb942c33bf Mathias Nyman 2021-01-29  712  	cmd = xhci_alloc_command(xhci, false, GFP_ATOMIC);
d1dbfb942c33bf Mathias Nyman 2021-01-29  713  	if (!cmd) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  714  		xhci_warn(xhci, "Can't alloc Set TR Deq cmd 0x%pad\n", &addr);
d1dbfb942c33bf Mathias Nyman 2021-01-29  715  		return -ENOMEM;
d1dbfb942c33bf Mathias Nyman 2021-01-29  716  	}
d1dbfb942c33bf Mathias Nyman 2021-01-29  717  
d1dbfb942c33bf Mathias Nyman 2021-01-29  718  	if (stream_id)
d1dbfb942c33bf Mathias Nyman 2021-01-29  719  		trb_sct = SCT_FOR_TRB(SCT_PRI_TR);
d1dbfb942c33bf Mathias Nyman 2021-01-29  720  	ret = queue_command(xhci, cmd,
d1dbfb942c33bf Mathias Nyman 2021-01-29  721  		lower_32_bits(addr) | trb_sct | new_cycle,
d1dbfb942c33bf Mathias Nyman 2021-01-29  722  		upper_32_bits(addr),
d1dbfb942c33bf Mathias Nyman 2021-01-29  723  		STREAM_ID_FOR_TRB(stream_id), SLOT_ID_FOR_TRB(slot_id) |
d1dbfb942c33bf Mathias Nyman 2021-01-29  724  		EP_ID_FOR_TRB(ep_index) | TRB_TYPE(TRB_SET_DEQ), false);
d1dbfb942c33bf Mathias Nyman 2021-01-29  725  	if (ret < 0) {
d1dbfb942c33bf Mathias Nyman 2021-01-29  726  		xhci_free_command(xhci, cmd);
d1dbfb942c33bf Mathias Nyman 2021-01-29  727  		return ret;
d1dbfb942c33bf Mathias Nyman 2021-01-29  728  	}
d1dbfb942c33bf Mathias Nyman 2021-01-29  729  	ep->queued_deq_seg = new_seg;
d1dbfb942c33bf Mathias Nyman 2021-01-29  730  	ep->queued_deq_ptr = new_deq;
d1dbfb942c33bf Mathias Nyman 2021-01-29  731  
d1dbfb942c33bf Mathias Nyman 2021-01-29  732  	xhci_dbg_trace(xhci, trace_xhci_dbg_cancel_urb,
d1dbfb942c33bf Mathias Nyman 2021-01-29  733  		       "Set TR Deq ptr 0x%llx, cycle %u\n", addr, new_cycle);
d1dbfb942c33bf Mathias Nyman 2021-01-29  734  
d1dbfb942c33bf Mathias Nyman 2021-01-29  735  	/* Stop the TD queueing code from ringing the doorbell until
d1dbfb942c33bf Mathias Nyman 2021-01-29  736  	 * this command completes.  The HC won't set the dequeue pointer
d1dbfb942c33bf Mathias Nyman 2021-01-29  737  	 * if the ring is running, and ringing the doorbell starts the
d1dbfb942c33bf Mathias Nyman 2021-01-29  738  	 * ring running.
d1dbfb942c33bf Mathias Nyman 2021-01-29  739  	 */
d1dbfb942c33bf Mathias Nyman 2021-01-29  740  	ep->ep_state |= SET_DEQ_PENDING;
d1dbfb942c33bf Mathias Nyman 2021-01-29  741  	xhci_ring_cmd_db(xhci);
d1dbfb942c33bf Mathias Nyman 2021-01-29  742  	return 0;
d1dbfb942c33bf Mathias Nyman 2021-01-29  743  }
d1dbfb942c33bf Mathias Nyman 2021-01-29  744  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

