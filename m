Return-Path: <linux-kernel+bounces-188568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 174F08CE3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B600B20BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537A885631;
	Fri, 24 May 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q36joe6S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF7C85266;
	Fri, 24 May 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543771; cv=none; b=DYRX6FWsJvTkLPDKCnF2tBOTMYFCbZnh4JgrxEzdLXyvqdjJnC6j61cwBpiCfaKdtzFMxI9cvPVBVasS3rfNsYCJd++nEa4W+zK5ajN69EkkvKQ+3i1BQURlfdl7vdGeovNiHv5cXGTdR0tcwbQArB0Tonjk7Yg7LK86O6uUgNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543771; c=relaxed/simple;
	bh=EE0Mfcd6ewSc6+WFz6f+/FGp9UJiVN+BC87M0MwSeQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHvrCmQQpe2tgPozGwUiTCqgyxxQUAfqaB7ZNylJtH+VYy/gl+wz83W5fYoMoQdX+LJnegK/WXJ43Ej/31zd9z86cCXXMfAdliUr0PfB9b6Pzal31a9c0g03WzEjSwHaVcims2JTBNvjVqyaP6zk3I99G2RfZmc0xdqX4SBpWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q36joe6S; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716543769; x=1748079769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EE0Mfcd6ewSc6+WFz6f+/FGp9UJiVN+BC87M0MwSeQw=;
  b=Q36joe6S/530dlmrJaIFGeWJ6t30xsYqAodgeHnbNbov97GvsU1ztZRg
   sPsWvc7IPqTrv1lOxowGAErTUcXOnMvl+nEdgziIotZ3Z1ztTbDjyI1Kw
   jz5LQXkxCz0RsOn0+eSJ1O3ds2CYUWiYr1mXRbz4z+aOJ2CxFEQyaz7yh
   qS+dzWdYdlC3lixrZ/AEym6pRI8RibA5uwbaepyKXJIPGIgfZU8JthsJW
   O0qkvPsLmSaKqZANoIpVKp30l9X36TBQ3NCAO44mK7dKnVtQun010eJux
   J37EoKifHuU8KdupeVyPvFzaFxvgbwSRuW7NiYehMIYQUgx3B62xhMnDt
   g==;
X-CSE-ConnectionGUID: b4+wVHXGT3mv4nLKwFF8SQ==
X-CSE-MsgGUID: tAJhnAYzTY66e+My7u8Ylg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12763456"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="12763456"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 02:42:49 -0700
X-CSE-ConnectionGUID: znjdwd8bQf2TBiM/HicIRA==
X-CSE-MsgGUID: RL2Xng9gQBqLZzgS6kTPcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="33887417"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 24 May 2024 02:42:45 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sARRP-0004SB-12;
	Fri, 24 May 2024 09:42:30 +0000
Date: Fri, 24 May 2024 17:38:13 +0800
From: kernel test robot <lkp@intel.com>
To: Hector Martin <marcan@marcan.st>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] xhci: Remove dead code in xhci_move_dequeue_past_td()
Message-ID: <202405241753.Idenkg7C-lkp@intel.com>
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
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240524/202405241753.Idenkg7C-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7aa382fd7257d9bd4f7fc50bb7078a3c26a1628c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405241753.Idenkg7C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405241753.Idenkg7C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/usb/host/xhci-ring.c:55:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/usb/host/xhci-ring.c:695:1: warning: unused label 'deq_found' [-Wunused-label]
     695 | deq_found:
         | ^~~~~~~~~~
   2 warnings generated.


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

