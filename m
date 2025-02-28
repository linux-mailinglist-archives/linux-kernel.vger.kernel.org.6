Return-Path: <linux-kernel+bounces-539333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD96A4A34A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01073BE194
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF589281379;
	Fri, 28 Feb 2025 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="elTX4Fxc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DA280A25;
	Fri, 28 Feb 2025 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772674; cv=none; b=lc3bjLs3a3Qe1Ky1C8e/Ru0T0+sh6xQaDy+7b0WPUjh+eKlMYy/caypik0HLtP+dFEnc05FrNU9eiCqcgaO/YEwRRcO7oIk4vRohE4AEl8lR2jbDepVlZtDU1d6zbjemFSvhkaWws8hkiWgt8xarz456BIAhUIUBhFHcyaIgdy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772674; c=relaxed/simple;
	bh=fW9kkI7u67nrHJc3lzSRVjomgU+mDe9ldQVXaTVjb8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3e4+F58WKqM2vpKep4Ghej8+wPd/QZc28XNiFF33STXtKFebOgx+J6fBIXhFy7V8MZl/4OxjksDqQ1SFzFQz90tyEyzoQ1qVK342ciZbRlCIaqJor7Jo7uCS50CuaerxjkfgUYXM0Pbm96FMZceuEYEkh+C2RD2zWTCVKIDtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=elTX4Fxc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740772672; x=1772308672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fW9kkI7u67nrHJc3lzSRVjomgU+mDe9ldQVXaTVjb8Y=;
  b=elTX4Fxc9gC6cRRg/gp6kAPzFoNAfCn0uIdBC34x9/iUdlG+thTwJzP5
   bVzHST6piwiKH4zf1lPCP8V0mH68hTrnPU4It6MmqcTqNQKF9+d0RLgoS
   xAbyAjegiRZniSEr0BDEby5DwystKuIwnuDbg+ZTUSwF6GGs9lut/f/j7
   NzbmqML2jgaibsqoN9fWppLiyec5QNZVc3Mku/mPBb7nMqKyu15cQRmpi
   ypdrv3RXgWKjb4FfGz5uzMVVgwfkYw5np4soOFU39zLv3rcL8h/kG4qHA
   LuCkWSdBQxYW9kWnXjhd9WzkwHKt23bgvWk6+8E0gJNm9c1dXADnEfGUS
   g==;
X-CSE-ConnectionGUID: FP3s8V1hRjmgvv/74DOk/A==
X-CSE-MsgGUID: /mqnuT7WQNOKKiiG9KAAPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45364528"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="45364528"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 11:57:51 -0800
X-CSE-ConnectionGUID: u2Gd4QlOQZyvTPciEgycwg==
X-CSE-MsgGUID: RzQuk0WZQsWN6bI0CwDa7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117418930"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 28 Feb 2025 11:57:48 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to6UU-000FRe-2i;
	Fri, 28 Feb 2025 19:57:46 +0000
Date: Sat, 1 Mar 2025 03:57:31 +0800
From: kernel test robot <lkp@intel.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>, michal.pecio@gmail.com,
	ki.chiang65@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFT PATCH] xhci: Handle spurious events on Etron host isoc
 enpoints
Message-ID: <202503010346.46nbVSmT-lkp@intel.com>
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
config: sh-randconfig-002-20250301 (https://download.01.org/0day-ci/archive/20250301/202503010346.46nbVSmT-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010346.46nbVSmT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010346.46nbVSmT-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-ring.c: In function 'xhci_spurious_success_tx_event':
>> drivers/usb/host/xhci-ring.c:2650:21: error: 'struct xhci_ring' has no member named 'old_trb_comp_code'
    2650 |         switch (ring->old_trb_comp_code) {
         |                     ^~
   In file included from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:5,
                    from drivers/usb/host/xhci-ring.c:59:
   drivers/usb/host/xhci-ring.c: In function 'handle_tx_event':
   drivers/usb/host/xhci-ring.c:2717:60: error: 'struct xhci_ring' has no member named 'old_trb_comp_code'
    2717 |                                  slot_id, ep_index, ep_ring->old_trb_comp_code);
         |                                                            ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/usb/host/xhci.h:1733:9: note: in expansion of macro 'dev_dbg'
    1733 |         dev_dbg(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
         |         ^~~~~~~
   drivers/usb/host/xhci-ring.c:2716:25: note: in expansion of macro 'xhci_dbg'
    2716 |                         xhci_dbg(xhci, "Successful completion on short TX for slot %u ep %u with last td comp code %d\n",
         |                         ^~~~~~~~
   drivers/usb/host/xhci-ring.c:2913:77: error: 'struct xhci_ring' has no member named 'old_trb_comp_code'
    2913 |                                          &ep_trb_dma, trb_comp_code, ep_ring->old_trb_comp_code);
         |                                                                             ^~
   include/linux/dev_printk.h:139:56: note: in definition of macro 'dev_no_printk'
     139 |                         _dev_printk(level, dev, fmt, ##__VA_ARGS__);    \
         |                                                        ^~~~~~~~~~~
   drivers/usb/host/xhci.h:1733:9: note: in expansion of macro 'dev_dbg'
    1733 |         dev_dbg(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
         |         ^~~~~~~
   drivers/usb/host/xhci-ring.c:2912:33: note: in expansion of macro 'xhci_dbg'
    2912 |                                 xhci_dbg(xhci, "Spurious event dma %pad, comp_code %u after %u\n",
         |                                 ^~~~~~~~
   drivers/usb/host/xhci-ring.c:2914:40: error: 'struct xhci_ring' has no member named 'old_trb_comp_code'
    2914 |                                 ep_ring->old_trb_comp_code = trb_comp_code;
         |                                        ^~
   drivers/usb/host/xhci-ring.c:2942:16: error: 'struct xhci_ring' has no member named 'old_trb_comp_code'
    2942 |         ep_ring->old_trb_comp_code = trb_comp_code;
         |                ^~
   drivers/usb/host/xhci-ring.c: In function 'xhci_spurious_success_tx_event':
>> drivers/usb/host/xhci-ring.c:2661:1: warning: control reaches end of non-void function [-Wreturn-type]
    2661 | }
         | ^


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
> 2661	}
  2662	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

