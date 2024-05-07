Return-Path: <linux-kernel+bounces-171596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866038BE638
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C931C219E2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E26715F415;
	Tue,  7 May 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwZoA1MW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D3D15ECD5;
	Tue,  7 May 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092731; cv=none; b=LaEV2iP2Xs1dMthmXaPKlE527vJ5He8QPWmZm0UV6pTVLlGRacwTi2pvO6hKMCLpigUSD36wBXPUoeKxevRkmwvgdapAlznSlG20uPoml4g7SZ3TI+IKdSc+5wHIwqbMHPzLf0fNyzeRx7Hqpxa4VtCzjQaTrbAC2dm5iqJxs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092731; c=relaxed/simple;
	bh=yZuzJyyvPy8+ARyrfWyX9X3SwCYwiAjFi1r7M1BzdqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtmGZwZrIYtFBC+g63BkkdMxh5j639omMXAIiiJYV3vK0mz/TXjF7EuvXMgAVOntr2ljqeCo69hnvpaHuuf7p1kUWNyFeIw5dWuaqzNJa0yOPj92X433Me90JXYF4n/LKnZybKbRJ//oIzlSSueFPCcmMCMeC4H64kIE1BurD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwZoA1MW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715092729; x=1746628729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yZuzJyyvPy8+ARyrfWyX9X3SwCYwiAjFi1r7M1BzdqQ=;
  b=GwZoA1MWn/d8t1hersSkRprH1RrQfDCV88bn8o0xs5FoqnITAw4/kIF3
   JY0dTOwlyVfvSnZGz7SM3UThxeopgbTVs8dRsu1MvTlzDrUfALKzOyTqU
   P+WSXOqEmi+XiV66C0UaJo3JHYMPRIfF6pAod01pUqArTIStWDvAcPmRQ
   8/OPOOrlkefJy97mB39PN3390F2CM2adleashKZ3rBErHxdiUeTc3fLOi
   vpOHiRcn1bDE1bVgRTtzp6WHKlcFNxQAkvZos9FXLTQLzJWp9Foi5Hcm+
   Ba3xjk1WSaal9gLOVLHYnNoWdxiN++u5AiJiMFRgXZLy3XfKwfysuVVE3
   g==;
X-CSE-ConnectionGUID: +/nyy6ZZTSqnAiv4Noj4fg==
X-CSE-MsgGUID: peNMLFSTQB2Qo9SJEbf6lg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11048383"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="11048383"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 07:38:49 -0700
X-CSE-ConnectionGUID: 16wnDbnPRNewE1eD8Y75Bg==
X-CSE-MsgGUID: UV8B/KW9SmCG43pTkG+SSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="33018359"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 07 May 2024 07:38:47 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4Lxs-0002Cy-0o;
	Tue, 07 May 2024 14:38:44 +0000
Date: Tue, 7 May 2024 22:38:40 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, michael.riesch@wolfvision.net,
	kernel@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH] usb: dwc3: gadget: create per ep interrupts
Message-ID: <202405072202.VCOpSmIK-lkp@intel.com>
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
config: i386-randconfig-141-20240507 (https://download.01.org/0day-ci/archive/20240507/202405072202.VCOpSmIK-lkp@intel.com/config)
compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405072202.VCOpSmIK-lkp@intel.com/

New smatch warnings:
drivers/usb/dwc3/gadget.c:1126 dwc3_gadget_init_endpoint_irq() warn: unsigned 'dep->irq_endpoint' is never less than zero.
drivers/usb/dwc3/gadget.c:3077 dwc3_gadget_start() warn: 'dwc->irq_gadget' from request_threaded_irq() not released on lines: 3067.

Old smatch warnings:
drivers/usb/dwc3/gadget.c:1733 __dwc3_gadget_kick_transfer() warn: missing error code? 'ret'
drivers/usb/dwc3/gadget.c:2848 dwc3_gadget_pullup() warn: pm_runtime_get_sync() also returns 1 on success

vim +1126 drivers/usb/dwc3/gadget.c

  1111	
  1112	static int dwc3_gadget_init_endpoint_irq(struct dwc3 *dwc, struct dwc3_ep *dep)
  1113	{
  1114		char *irq_name;
  1115		int ret = 0;
  1116	
  1117		/* FIXME: endpoint.claimed would be better here, but somehow
  1118		 * the composite gadget layer is leaving the claimed value to 0
  1119		 * after calling usb_ep_autoconfig_reset after the final bind
  1120		 */
  1121		/* ep0in and ep0out share the same interrupt thread */
  1122		if (!dep->endpoint.address && dep->number)
  1123			return 0;
  1124	
  1125		dep->irq_endpoint = irq_create_mapping(dwc->ep_irq_domain, dep->number);
> 1126		if (dep->irq_endpoint < 0) {
  1127			ret = dep->irq_endpoint;
  1128	
  1129			dev_err(dwc->dev, "failed to map irq for ep%d --> %d\n",
  1130					dep->number, ret);
  1131			return ret;
  1132		}
  1133	
  1134		irq_name = kzalloc(16, GFP_KERNEL);
  1135		if (!dep->number)
  1136			snprintf(irq_name, 16, "ep0");
  1137		else
  1138			snprintf(irq_name, 16, "ep%d%s", dep->number >> 1, dep->direction ?
  1139				"in" : "out");
  1140	
  1141		ret = request_threaded_irq(dep->irq_endpoint, dwc3_endpoint_irq,
  1142					   dwc3_endpoint_thread_irq, IRQF_SHARED,
  1143					   irq_name, dep);
  1144		if (ret) {
  1145			irq_dispose_mapping(irq_find_mapping(dwc->ep_irq_domain, dep->number));
  1146			dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
  1147					dep->irq_endpoint, ret);
  1148		}
  1149	
  1150		return ret;
  1151	}
  1152	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

