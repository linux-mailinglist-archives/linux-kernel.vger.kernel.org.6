Return-Path: <linux-kernel+bounces-230022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE6C91776D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620BD1C21BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F01411E4;
	Wed, 26 Jun 2024 04:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/8eqZX5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061B139CF7;
	Wed, 26 Jun 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719376365; cv=none; b=q8I9fcO5F6k5auZbklX66i88qL3PcKXRWtkMLakD+g9pzFedzvixLCHWdCCvQcWZXQoBAgqFRciyF4uAmNiKA3xBjC0e+M62fEhiK+1Q4oJ2VIFAJbdNiCEZfxU8DnWG28+HZqV3PKpOakVblwyC2mEPFfH/lmVGzo6+RKFJDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719376365; c=relaxed/simple;
	bh=2yyolTPyZlhtn4v6ot25IwyUWxJHPjJWN4pvowp4MPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfrGWJMpXd/pH2uXZ3VhknQLznUG13crIsHPRrRDqX2Vu28D4V3I5+UmWzvlQ+77t0tNzXEp6DPLRr5ZRQMPA3c7ZnbAlddiCzjFhBlYNmVZimE4yuIfhVyForbXsZtMVxQxJFbAKtapOe07LuwT73IHAFGcuZ94EUPHsgoLYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/8eqZX5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719376364; x=1750912364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2yyolTPyZlhtn4v6ot25IwyUWxJHPjJWN4pvowp4MPo=;
  b=n/8eqZX54jLXZcaTfPaYFSrDXIaLJxM4bw2W10JXw+f/njpNHGMKkAi4
   Gbuu7gJauqZkWkqJ+1BJcZ+LTP8BM6KN0+c/serewtmLrFiqw33nG5ZK9
   dfWo7nwHZjIuogqs1YOXvZdo0uCnBiuWNR0MAuNJ4H84SnINCp65GWmHb
   ufSxv+vJRnL4QGHGz50IGLd1PXgEBpZbIzN9s5M2G6mOg4q3hXFSJdq0k
   ExGlcm8BjF5jCJ8ymGUylfjtkNpCP7ljlUqMl+CCk8E2bv7/pYW7VsWRV
   zeHvfKec/6f0FhfnGsiLNTb+xV0euAwF9/v3eD9Gp+nNSFJ3PMQ3/prdA
   g==;
X-CSE-ConnectionGUID: tSt25j1tTVqiljSWmbU2ZQ==
X-CSE-MsgGUID: lMgxDg/dTNiglxqC4ZiCbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27047207"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="27047207"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 21:32:44 -0700
X-CSE-ConnectionGUID: Bo7EaqkpRx+pgFOcryWCew==
X-CSE-MsgGUID: axVy6dV6RsS8CvwXm24tHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="44308318"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 25 Jun 2024 21:32:42 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMKKl-000Ez3-0Y;
	Wed, 26 Jun 2024 04:32:39 +0000
Date: Wed, 26 Jun 2024 12:32:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: r8a66597-udc: validate endpoint index for
 r8a66597 udc
Message-ID: <202406261220.OagNp3Mb-lkp@intel.com>
References: <20240622142308.1929531-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240622142308.1929531-1-make24@iscas.ac.cn>

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/usb-gadget-r8a66597-udc-validate-endpoint-index-for-r8a66597-udc/20240626-003228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20240622142308.1929531-1-make24%40iscas.ac.cn
patch subject: [PATCH] usb: gadget: r8a66597-udc: validate endpoint index for r8a66597 udc
config: i386-buildonly-randconfig-004-20240626 (https://download.01.org/0day-ci/archive/20240626/202406261220.OagNp3Mb-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261220.OagNp3Mb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261220.OagNp3Mb-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/gadget/udc/r8a66597-udc.c: In function 'get_status':
>> drivers/usb/gadget/udc/r8a66597-udc.c:1178:29: error: 'USB_MAX_ENDPOINTS' undeclared (first use in this function); did you mean 'USB_DT_ENDPOINT'?
    1178 |                 if (pipe >= USB_MAX_ENDPOINTS)
         |                             ^~~~~~~~~~~~~~~~~
         |                             USB_DT_ENDPOINT
   drivers/usb/gadget/udc/r8a66597-udc.c:1178:29: note: each undeclared identifier is reported only once for each function it appears in
   drivers/usb/gadget/udc/r8a66597-udc.c: In function 'clear_feature':
   drivers/usb/gadget/udc/r8a66597-udc.c:1217:29: error: 'USB_MAX_ENDPOINTS' undeclared (first use in this function); did you mean 'USB_DT_ENDPOINT'?
    1217 |                 if (pipe >= USB_MAX_ENDPOINTS)
         |                             ^~~~~~~~~~~~~~~~~
         |                             USB_DT_ENDPOINT
   drivers/usb/gadget/udc/r8a66597-udc.c: In function 'set_feature':
   drivers/usb/gadget/udc/r8a66597-udc.c:1280:29: error: 'USB_MAX_ENDPOINTS' undeclared (first use in this function); did you mean 'USB_DT_ENDPOINT'?
    1280 |                 if (pipe >= USB_MAX_ENDPOINTS)
         |                             ^~~~~~~~~~~~~~~~~
         |                             USB_DT_ENDPOINT


vim +1178 drivers/usb/gadget/udc/r8a66597-udc.c

  1158	
  1159	static void get_status(struct r8a66597 *r8a66597, struct usb_ctrlrequest *ctrl)
  1160	__releases(r8a66597->lock)
  1161	__acquires(r8a66597->lock)
  1162	{
  1163		struct r8a66597_ep *ep;
  1164		u16 pid;
  1165		u16 status = 0;
  1166		u16 w_index = le16_to_cpu(ctrl->wIndex);
  1167	
  1168		switch (ctrl->bRequestType & USB_RECIP_MASK) {
  1169		case USB_RECIP_DEVICE:
  1170			status = r8a66597->device_status;
  1171			break;
  1172		case USB_RECIP_INTERFACE:
  1173			status = 0;
  1174			break;
  1175		case USB_RECIP_ENDPOINT:
  1176			int pipe = w_index & USB_ENDPOINT_NUMBER_MASK;
  1177	
> 1178			if (pipe >= USB_MAX_ENDPOINTS)
  1179				break;
  1180			ep = r8a66597->epaddr2ep[pipe];
  1181			pid = control_reg_get_pid(r8a66597, ep->pipenum);
  1182			if (pid == PID_STALL)
  1183				status = 1 << USB_ENDPOINT_HALT;
  1184			else
  1185				status = 0;
  1186			break;
  1187		default:
  1188			pipe_stall(r8a66597, 0);
  1189			return;		/* exit */
  1190		}
  1191	
  1192		r8a66597->ep0_data = cpu_to_le16(status);
  1193		r8a66597->ep0_req->buf = &r8a66597->ep0_data;
  1194		r8a66597->ep0_req->length = 2;
  1195		/* AV: what happens if we get called again before that gets through? */
  1196		spin_unlock(&r8a66597->lock);
  1197		r8a66597_queue(r8a66597->gadget.ep0, r8a66597->ep0_req, GFP_ATOMIC);
  1198		spin_lock(&r8a66597->lock);
  1199	}
  1200	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

