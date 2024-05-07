Return-Path: <linux-kernel+bounces-171172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F08D8BE0B0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF91C20959
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A64152162;
	Tue,  7 May 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbt4wUu9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F731514C9;
	Tue,  7 May 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080173; cv=none; b=Gvz5PfeqM4VAhH/OWuR/E3eRgKLdE4PYkxfiPbfxv2Aaonzp66oa/OUaOe/J/WFCLhpyULHQj8LRD3INhrZa9lhVr6bfn+KjzIl1OeBtcssjVJttqgFqafd90bag/dasDtUnDindeZLrfOTHpVEELLqPqpLVPe/B0S34eQEYXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080173; c=relaxed/simple;
	bh=ZDHAJEmGPC34idg5wIvN/SlxRNOVp/+v3SFR/mFtXG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPzTRSO2JnRgy5GDT3H4geUZxj/j8bJ6ZZZnWYBWuFkYjWb6gDewebvWYsNjcy7hMmwickSM/UQaHIDyJ0QFcAOuqILzbMz35QfQoGEEDS76xZD49UmySvHwbB2imyVNofi1iExswD2Peai7i4XGKNMPFqTAzoA2RT8BsLB07G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbt4wUu9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080171; x=1746616171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZDHAJEmGPC34idg5wIvN/SlxRNOVp/+v3SFR/mFtXG4=;
  b=gbt4wUu9LzLAIIEOtmSd0OewPeAARlHeqy1dc6K1QdU9rt8zushDLUXU
   Yz2CPCN9xkP8POk9J46cKcM6p/hKew5f3j+fP7IQ0slYx1aSIHyG9fEqL
   +hqeQlgPc2rIzYzzUl0iPkwzylItQ1uSvsT2AuGlqphUWp5SGwRtO0jmd
   q+vo11ut7RiUBU1AXG2ew94Pr5dcd9mycWnXS39M3qiz4R+CQM+A+430l
   heMmKd+gyHjRhcAV3owV6Vbd84BustJSEuul6++DXWBlzXbfQ+dkIxAuy
   MxWqoeB69SbVHS629dgFUq1xbys7UlglBRFE1OApDzu7sLGsrLgjY+nw0
   w==;
X-CSE-ConnectionGUID: YZK1mkJjT+iQigi+sDNIww==
X-CSE-MsgGUID: TJxgrBpDQSKSemIi8SwFKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10720744"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10720744"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:09:31 -0700
X-CSE-ConnectionGUID: ZrOBaoG9Sdiqh7Rw7qH+sw==
X-CSE-MsgGUID: 36gEx8TfSX+QnqxwlLRF2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="51682325"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 May 2024 04:09:28 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4IhJ-0001qH-35;
	Tue, 07 May 2024 11:09:25 +0000
Date: Tue, 7 May 2024 19:08:33 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	michael.riesch@wolfvision.net, kernel@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Message-ID: <202405071800.omy5Ou1D-lkp@intel.com>
References: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dd5a440a31fae6e459c0d6271dddd62825505361]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-dwc3-gadget-create-per-ep-interrupts/20240507-070804
base:   dd5a440a31fae6e459c0d6271dddd62825505361
patch link:    https://lore.kernel.org/r/20240507-dwc3_per_ep_irqthread-v1-1-f14dec6de19f%40pengutronix.de
patch subject: [PATCH] usb: dwc3: gadget: create per ep interrupts
config: x86_64-buildonly-randconfig-001-20240507 (https://download.01.org/0day-ci/archive/20240507/202405071800.omy5Ou1D-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405071800.omy5Ou1D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405071800.omy5Ou1D-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/dwc3/gadget.c:1068:6: warning: variable 'count_processed' set but not used [-Wunused-but-set-variable]
    1068 |         int count_processed = 0;
         |             ^
   1 warning generated.


vim +/count_processed +1068 drivers/usb/dwc3/gadget.c

  1059	
  1060	static void dwc3_process_event_entry(struct dwc3 *dwc,
  1061					     const union dwc3_event *event);
  1062	
  1063	static irqreturn_t dwc3_endpoint_thread_irq(int irq, void *_dep)
  1064	{
  1065		struct dwc3_ep *dep = _dep;
  1066		struct dwc3 *dwc = dep->dwc;
  1067		const union dwc3_event *event;
> 1068		int count_processed = 0;
  1069		u32 event_raw;
  1070		unsigned long flags;
  1071	
  1072		dep->givebacks_current_turn = 0;
  1073	
  1074		spin_lock_irqsave(&dep->event_lock, flags);
  1075	
  1076		if (dep->ep_event_flags & DWC3_EP_EVENT_OVERFLOW) {
  1077			dev_err(dwc->dev, "ep%d: event buffer overflow\n", dep->number);
  1078			dep->ep_event_flags &= ~DWC3_EP_EVENT_OVERFLOW;
  1079		}
  1080	
  1081		while (dep->ep_event_r_index != dep->ep_event_w_index) {
  1082	
  1083			event_raw = dep->ep_event_buffer[dep->ep_event_r_index];
  1084	
  1085			/*
  1086			 * we have a copy of the event, so we can release the lock
  1087			 */
  1088			spin_unlock_irqrestore(&dep->event_lock, flags);
  1089	
  1090			event = (const union dwc3_event *) &event_raw;
  1091	
  1092			spin_lock(&dwc->lock);
  1093			dwc3_process_event_entry(dwc, event);
  1094			spin_unlock(&dwc->lock);
  1095	
  1096			/*
  1097			 * we need to re-acquire the lock to update the read index
  1098			 */
  1099			spin_lock_irqsave(&dep->event_lock, flags);
  1100	
  1101			dep->ep_event_r_index = (dep->ep_event_r_index + 1) %
  1102						 ARRAY_SIZE(dep->ep_event_buffer);
  1103	
  1104			count_processed += 1;
  1105		}
  1106	
  1107		spin_unlock_irqrestore(&dep->event_lock, flags);
  1108	
  1109		return IRQ_HANDLED;
  1110	}
  1111	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

