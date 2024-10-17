Return-Path: <linux-kernel+bounces-369152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BC69A197E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2961C219F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E214A4E2;
	Thu, 17 Oct 2024 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIQ4A8Vx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A061FD8;
	Thu, 17 Oct 2024 03:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137062; cv=none; b=uzRD7fK89OuQSQciz7luq4WeYHT+nzzN6ZvdNeFFGkvg45yJTS4M5lJsHoQR+YyN0TD7AWehMonX8i7FAk6QMsaE1tB6oeC6W6ifbR15y8D7HlaW+jnJl+3MEl4sZlDhcVqs7tO9bteS78b24joMNspUW7V47CfUNSozNhsMwRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137062; c=relaxed/simple;
	bh=beJn5IycSLX4sg7z/JwH2+KUaHgTimetgZVNFzZQzb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjE7ExhIrl/q3JLFxTsp6c620X1iqJ/U8q100/iOcoKRPBqb5JEg2H9znEwNOTOefL3cEpWL52a2oZhCkZRxRx4qIKOaZX9X5eaC2aU0qZNGttH/EqwF3eolf+Wd+B7B1lRGXC1Any4puOpUqDZtq17sI0sRhJ1dApVF6pIfYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIQ4A8Vx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729137059; x=1760673059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=beJn5IycSLX4sg7z/JwH2+KUaHgTimetgZVNFzZQzb8=;
  b=MIQ4A8VxM9a3k/LiDAA7cY/A326ynZooqgc2F3QV6zNAnDALTSa8G0ck
   A7Ai5PRYyA/0kqkLtE6wkvppOoHNcapYFnvxeGnJf9XLFKK7EnYhY3DZE
   5nxOJAzVa9lHmmBZ9mm6LYWZTw/7mgeHxsmnPP3WFvParpmL0B13CGwBs
   8RWMrkdwWxVbhnjCG5FRpbcuyPLVgBZhlq/bfuGdx6GYCaxu/ge9ivsbR
   ImVdyX6p0ssrSu7qnF996tuPXh4J6O2IacxFQ0US47YQxnsE9OEFFJpnH
   +PuWfCer1TmsFXq20ddoNzn/il69eTp3t++EImxZhGkwXUIThD9yE2aEE
   g==;
X-CSE-ConnectionGUID: JI7cHl1rToyS77nZEfp6SA==
X-CSE-MsgGUID: 5LlmoCCmTg23Ny2kHDSV6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28497596"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28497596"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 20:50:59 -0700
X-CSE-ConnectionGUID: Fe6o3H0HS/qntUAqC0BLkw==
X-CSE-MsgGUID: kye1m7slQT2+lnbDBnIKIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78453959"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2024 20:50:55 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1HXI-000Lhb-36;
	Thu, 17 Oct 2024 03:50:52 +0000
Date: Thu, 17 Oct 2024 11:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: Akash Kumar <quic_akakum@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
	Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Akash Kumar <quic_akakum@quicinc.com>
Subject: Re: [PATCH v6] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
Message-ID: <202410171121.i9xLy4CF-lkp@intel.com>
References: <20241016111904.11375-1-quic_akakum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016111904.11375-1-quic_akakum@quicinc.com>

Hi Akash,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.12-rc3 next-20241016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akash-Kumar/usb-dwc3-gadget-Refine-the-logic-for-resizing-Tx-FIFOs/20241016-192104
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20241016111904.11375-1-quic_akakum%40quicinc.com
patch subject: [PATCH v6] usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
config: i386-buildonly-randconfig-003-20241017 (https://download.01.org/0day-ci/archive/20241017/202410171121.i9xLy4CF-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171121.i9xLy4CF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171121.i9xLy4CF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/dwc3/gadget.c:782:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     782 |                 break;
         |                 ^
   drivers/usb/dwc3/gadget.c:777:2: note: previous statement is here
     777 |         if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
         |         ^
   drivers/usb/dwc3/gadget.c:794:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
     794 |                 break;
         |                 ^
   drivers/usb/dwc3/gadget.c:792:2: note: previous statement is here
     792 |         if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
         |         ^
   2 warnings generated.


vim +/if +782 drivers/usb/dwc3/gadget.c

   726	
   727	/*
   728	 * dwc3_gadget_resize_tx_fifos - reallocate fifo spaces for current use-case
   729	 * @dwc: pointer to our context structure
   730	 *
   731	 * This function will a best effort FIFO allocation in order
   732	 * to improve FIFO usage and throughput, while still allowing
   733	 * us to enable as many endpoints as possible.
   734	 *
   735	 * Keep in mind that this operation will be highly dependent
   736	 * on the configured size for RAM1 - which contains TxFifo -,
   737	 * the amount of endpoints enabled on coreConsultant tool, and
   738	 * the width of the Master Bus.
   739	 *
   740	 * In general, FIFO depths are represented with the following equation:
   741	 *
   742	 * fifo_size = mult * ((max_packet + mdwidth)/mdwidth + 1) + 1
   743	 *
   744	 * In conjunction with dwc3_gadget_check_config(), this resizing logic will
   745	 * ensure that all endpoints will have enough internal memory for one max
   746	 * packet per endpoint.
   747	 */
   748	static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
   749	{
   750		struct dwc3 *dwc = dep->dwc;
   751		int fifo_0_start;
   752		int ram1_depth;
   753		int fifo_size;
   754		int min_depth;
   755		int num_in_ep;
   756		int remaining;
   757		int num_fifos = 1;
   758		int fifo;
   759		int tmp;
   760	
   761		if (!dwc->do_fifo_resize)
   762			return 0;
   763	
   764		/* resize IN endpoints except ep0 */
   765		if (!usb_endpoint_dir_in(dep->endpoint.desc) || dep->number <= 1)
   766			return 0;
   767	
   768		/* bail if already resized */
   769		if (dep->flags & DWC3_EP_TXFIFO_RESIZED)
   770			return 0;
   771	
   772		ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
   773	
   774		switch (dwc->gadget->speed) {
   775		case USB_SPEED_SUPER_PLUS:
   776		case USB_SPEED_SUPER:
   777		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
   778		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
   779			num_fifos = min_t(unsigned int,
   780					  dep->endpoint.maxburst,
   781					  dwc->tx_fifo_resize_max_num);
 > 782			break;
   783		case USB_SPEED_HIGH:
   784		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
   785			num_fifos = min_t(unsigned int,
   786					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
   787					  dwc->tx_fifo_resize_max_num);
   788			break;
   789		}
   790			fallthrough;
   791		case USB_SPEED_FULL:
   792		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
   793			num_fifos = 2;
   794			break;
   795		default:
   796			break;
   797		}
   798	
   799		/* FIFO size for a single buffer */
   800		fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
   801	
   802		/* Calculate the number of remaining EPs w/o any FIFO */
   803		num_in_ep = dwc->max_cfg_eps;
   804		num_in_ep -= dwc->num_ep_resized;
   805	
   806		/* Reserve at least one FIFO for the number of IN EPs */
   807		min_depth = num_in_ep * (fifo + 1);
   808		remaining = ram1_depth - min_depth - dwc->last_fifo_depth;
   809		remaining = max_t(int, 0, remaining);
   810		/*
   811		 * We've already reserved 1 FIFO per EP, so check what we can fit in
   812		 * addition to it.  If there is not enough remaining space, allocate
   813		 * all the remaining space to the EP.
   814		 */
   815		fifo_size = (num_fifos - 1) * fifo;
   816		if (remaining < fifo_size)
   817			fifo_size = remaining;
   818	
   819		fifo_size += fifo;
   820		/* Last increment according to the TX FIFO size equation */
   821		fifo_size++;
   822	
   823		/* Check if TXFIFOs start at non-zero addr */
   824		tmp = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(0));
   825		fifo_0_start = DWC3_GTXFIFOSIZ_TXFSTADDR(tmp);
   826	
   827		fifo_size |= (fifo_0_start + (dwc->last_fifo_depth << 16));
   828		if (DWC3_IP_IS(DWC3))
   829			dwc->last_fifo_depth += DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
   830		else
   831			dwc->last_fifo_depth += DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
   832	
   833		/* Check fifo size allocation doesn't exceed available RAM size. */
   834		if (dwc->last_fifo_depth >= ram1_depth) {
   835			dev_err(dwc->dev, "Fifosize(%d) > RAM size(%d) %s depth:%d\n",
   836				dwc->last_fifo_depth, ram1_depth,
   837				dep->endpoint.name, fifo_size);
   838			if (DWC3_IP_IS(DWC3))
   839				fifo_size = DWC3_GTXFIFOSIZ_TXFDEP(fifo_size);
   840			else
   841				fifo_size = DWC31_GTXFIFOSIZ_TXFDEP(fifo_size);
   842	
   843			dwc->last_fifo_depth -= fifo_size;
   844			return -ENOMEM;
   845		}
   846	
   847		dwc3_writel(dwc->regs, DWC3_GTXFIFOSIZ(dep->number >> 1), fifo_size);
   848		dep->flags |= DWC3_EP_TXFIFO_RESIZED;
   849		dwc->num_ep_resized++;
   850	
   851		return 0;
   852	}
   853	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

