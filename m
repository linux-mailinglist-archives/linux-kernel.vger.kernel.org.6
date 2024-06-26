Return-Path: <linux-kernel+bounces-230087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B501917832
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC3028403C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F0147C76;
	Wed, 26 Jun 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2ioERG5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024222F5E;
	Wed, 26 Jun 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719380115; cv=none; b=XPR/t9+7382mJ5gyyPGEkLVbRf039/X8f6f5jX/H/DtVM5jBePqUqVFP6c22RCskmExVZcZwsN9fBKpcenAR7Btnh568pHk/0PEpa1oohrlNXknayJ5W8yIZXWnhyjOt4Q1NCcvMoGuIck6ZFJs7JKgBMABek12qPuBmxWiQVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719380115; c=relaxed/simple;
	bh=/G7fO/Q3JvUeVnBbit8Ih4BufFWcmDw2Sl71qmKYszs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaUzmNJlHTb5upKqP4O1cTPfMNh+/Pn0ukxSp+gdCigqLStHt92K9wpbYRt/K0MS1GXvpqWrYK3kr675RGmhCLBd0V4GpjGkjJAn4ZF4L0xqM8uJj+KYioAsBrQk5HiKT/i0zQl9trXeHRsq9tjUQ3C8tYVOz0V1MYChu9kPZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2ioERG5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719380114; x=1750916114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/G7fO/Q3JvUeVnBbit8Ih4BufFWcmDw2Sl71qmKYszs=;
  b=Y2ioERG58og+he4QKGPM7YBykQlqfDB48ncK5v1qzJsvWqvjMW2FgbTk
   tSysG1N8MMzFzwtRMwiMCeTUwyOmLzGtmGGU09EVmT4vowN8a/wRWFSEt
   gVkAJA9HxRClDtFnp7qEGxSXgRh07rvXhIkknZ8uFPsjWForYuaU/gaaN
   BZMhzbkW0FwoJCXIVLeJuPPKg6Doozv6NsVhVxkP/EQkMghgmHSfMLbf+
   uGZOlWjimEcyS6OHZ3MfqxDC34UF9dwmP8+UlRyJZltSOZxlu9x5WCxyB
   ygKdzWHLNtRvwiGLzHheUbOMPoBNLqUnc+NYqTm9nD35tgOmE8NNgvAGv
   g==;
X-CSE-ConnectionGUID: NFdrQlvsTweGUScoHrf8HA==
X-CSE-MsgGUID: iXV3WmjoQAejxoJNtyjKHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="27119961"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="27119961"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 22:35:14 -0700
X-CSE-ConnectionGUID: x0USdE5aRPGrRsUis8ENQg==
X-CSE-MsgGUID: dM8BzhOPRhu2MrQumls2Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="75091561"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Jun 2024 22:35:11 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMLJF-000F1S-1b;
	Wed, 26 Jun 2024 05:35:09 +0000
Date: Wed, 26 Jun 2024 13:34:25 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, gregkh@linuxfoundation.org,
	u.kleine-koenig@pengutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: r8a66597-udc: validate endpoint index for
 r8a66597 udc
Message-ID: <202406261324.4izkBtpK-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20240626 (https://download.01.org/0day-ci/archive/20240626/202406261324.4izkBtpK-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261324.4izkBtpK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261324.4izkBtpK-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/usb/gadget/udc/r8a66597-udc.c:1176:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
    1176 |                 int pipe = w_index & USB_ENDPOINT_NUMBER_MASK;
         |                 ^
>> drivers/usb/gadget/udc/r8a66597-udc.c:1178:15: error: use of undeclared identifier 'USB_MAX_ENDPOINTS'
    1178 |                 if (pipe >= USB_MAX_ENDPOINTS)
         |                             ^
   drivers/usb/gadget/udc/r8a66597-udc.c:1217:15: error: use of undeclared identifier 'USB_MAX_ENDPOINTS'
    1217 |                 if (pipe >= USB_MAX_ENDPOINTS)
         |                             ^
   drivers/usb/gadget/udc/r8a66597-udc.c:1280:15: error: use of undeclared identifier 'USB_MAX_ENDPOINTS'
    1280 |                 if (pipe >= USB_MAX_ENDPOINTS)
         |                             ^
   1 warning and 3 errors generated.


vim +/USB_MAX_ENDPOINTS +1178 drivers/usb/gadget/udc/r8a66597-udc.c

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
> 1176			int pipe = w_index & USB_ENDPOINT_NUMBER_MASK;
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

