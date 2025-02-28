Return-Path: <linux-kernel+bounces-539396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B69A4A3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66B8882445
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD9227FE8A;
	Fri, 28 Feb 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1VChtom"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459AB27CCF3;
	Fri, 28 Feb 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773274; cv=none; b=Me6/xM9La7XyFkjLAAu+lImY93Y4wVPVVsH6efCWoncqMi0doG6UimwQ0A/XTFfX5qPLk8vl+m3Jaef6vJjcIIklecEfBCLDNF4vUjJkCK9gEn2rhjr6s0O6umsR5ATI0Bh4LWXny/GMp8ya2u9kkqDNKYP7YBrt1VvSmbwF+Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773274; c=relaxed/simple;
	bh=nwoAkcsv+Y8K+laCxOvKNu6hrFxpir2PA0Jamd0b3Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9UvHAdapADUmAwlxQ5VkVUCH3iZGm/TomAsoy2PCPdd4kKMIoKUW2HVG9FugHDkO3v0JWeY7+53ns184NGvFYk0P6mxs/hwPydliaKpHoOV5DqaKh1ONA0VSnoBDLXQl3UYZjepSO5cJ+86DJvwQ3cLn/IwQN89B5mnq5G20wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1VChtom; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740773272; x=1772309272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwoAkcsv+Y8K+laCxOvKNu6hrFxpir2PA0Jamd0b3Oc=;
  b=N1VChtomQqWfe9jKW9ooyx3HNFI/yZdlFZWSVLLBMXGch+BApkWok+93
   QACuFFxz7t+DGQZl3RufOsyce4hwmGrjNq46PsgGTZBk5RdDdO0RCWpPQ
   62WFQTLp4/EeERFhVGikagvxS18Uow9gSTb8KuxUcgGse8A9FRfsHDoAo
   clVJEEu4VwINWD7v9aFcFv9bMeQxJBi8U5teQ7O98jWnu1pHBJ76Add3n
   aUfvCddbMHSF15C0yDdZDk2lQ/bQjM1T0LsYJwU79uOBzZj/nRc7UYYUX
   BjZVIp9iIfP8JzuU1gN+iyqGDuHbGDZ09q265CLt8A5BDsqzHicHTOdVB
   g==;
X-CSE-ConnectionGUID: ZV5GXKcNT6e2q1/13flIZg==
X-CSE-MsgGUID: kruyEzO1TSu31hyxed0zag==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="52347844"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="52347844"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:07:51 -0800
X-CSE-ConnectionGUID: MIVhhdutTiaHbzv7wHGUzQ==
X-CSE-MsgGUID: rmiTuAGdTR6nXNFqXChZOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="122565730"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 28 Feb 2025 12:07:50 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to6eB-000FSI-2e;
	Fri, 28 Feb 2025 20:07:47 +0000
Date: Sat, 1 Mar 2025 04:07:42 +0800
From: kernel test robot <lkp@intel.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>, michal.pecio@gmail.com,
	ki.chiang65@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc
 enpoints
Message-ID: <202503010302.yhUVRgse-lkp@intel.com>
References: <20250228161824.3164826-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228161824.3164826-1-mathias.nyman@linux.intel.com>

Hi Mathias,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathias-Nyman/xhci-Handle-spurious-events-on-Etron-host-isoc-enpoints/20250301-001842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20250228161824.3164826-1-mathias.nyman%40linux.intel.com
patch subject: [RFT PATCH] xhci: Handle spurious events on Etron host isoc enpoints
config: hexagon-randconfig-002-20250301 (https://download.01.org/0day-ci/archive/20250301/202503010302.yhUVRgse-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010302.yhUVRgse-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010302.yhUVRgse-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/host/xhci-ring.c:2650:16: error: no member named 'old_trb_comp_code' in 'struct xhci_ring'
    2650 |         switch (ring->old_trb_comp_code) {
         |                 ~~~~  ^
   drivers/usb/host/xhci-ring.c:2717:34: error: no member named 'old_trb_comp_code' in 'struct xhci_ring'
    2717 |                                  slot_id, ep_index, ep_ring->old_trb_comp_code);
         |                                                     ~~~~~~~  ^
   drivers/usb/host/xhci.h:1733:56: note: expanded from macro 'xhci_dbg'
    1733 |         dev_dbg(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
         |                                                               ^~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                              ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/usb/host/xhci-ring.c:2913:44: error: no member named 'old_trb_comp_code' in 'struct xhci_ring'
    2913 |                                          &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
         |                                                                      ~~~~~~~  ^
   drivers/usb/host/xhci.h:1733:56: note: expanded from macro 'xhci_dbg'
    1733 |         dev_dbg(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
         |                                                               ^~~~
   include/linux/dev_printk.h:165:39: note: expanded from macro 'dev_dbg'
     165 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                              ^~~~~~~~~~~
   include/linux/dynamic_debug.h:274:19: note: expanded from macro 'dynamic_dev_dbg'
     274 |                            dev, fmt, ##__VA_ARGS__)
         |                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
         |                                                                  ^~~~~~~~~~~
   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
     224 |                 func(&id, ##__VA_ARGS__);                       \
         |                             ^~~~~~~~~~~
   drivers/usb/host/xhci-ring.c:2914:14: error: no member named 'old_trb_comp_code' in 'struct xhci_ring'
    2914 |                                 ep_ring->old_trb_comp_code = trb_comp_code;
         |                                 ~~~~~~~  ^
   drivers/usb/host/xhci-ring.c:2942:11: error: no member named 'old_trb_comp_code' in 'struct xhci_ring'
    2942 |         ep_ring->old_trb_comp_code = trb_comp_code;
         |         ~~~~~~~  ^
   5 errors generated.


vim +2650 drivers/usb/host/xhci-ring.c

  2646	
  2647	static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
  2648						   struct xhci_ring *ring)
  2649	{
> 2650		switch (ring->old_trb_comp_code) {
  2651		case COMP_SHORT_PACKET:
  2652			return xhci->quirks & XHCI_SPURIOUS_SUCCESS;
  2653		case COMP_USB_TRANSACTION_ERROR:
  2654		case COMP_BABBLE_DETECTED_ERROR:
  2655		case COMP_ISOCH_BUFFER_OVERRUN:
  2656			return xhci->quirks & XHCI_ETRON_HOST &&
  2657				ring->type == TYPE_ISOC;
  2658		default:
  2659			return false;
  2660		}
  2661	}
  2662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

