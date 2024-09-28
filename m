Return-Path: <linux-kernel+bounces-342332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA1988DA5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 04:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C31C2190F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C4199EB4;
	Sat, 28 Sep 2024 02:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRhx80tP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984DB19994E;
	Sat, 28 Sep 2024 02:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727492043; cv=none; b=cPCxI3dyVED/R11Y6ZtEO+itgX8yI1zGIV8Cs8U9yjIoXT4q8a2UhSxa7PjDtdfXlcENPRs41TBbveNL/yzkLiUsdYujjBk8dqta9z+vEVhnqu/1owbMQjhlZ/ip51Xj03HZ98hPLBaeoy1wIGqpsj+uIoU64DZhkUDS/ujwwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727492043; c=relaxed/simple;
	bh=L/4ztKUmR2hY9BORg5sinYR4OqxxO8+qKgs09g1Q7iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZXr1u92NrK/IzqCXg8rOXjuWr8lC0/MBLB7S5jabJApi6KjFjJf35u32Ekgkm5AMZRR3q42Wg014Ig0/hd5C8iKJbkWGxM0bb0gzc4YqFyyFnIMxJ0lIdZJSrLEd3P9+aShIiFxv4shXInEk7CQlddRieE9Fu//yqPSGKrGKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRhx80tP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727492041; x=1759028041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L/4ztKUmR2hY9BORg5sinYR4OqxxO8+qKgs09g1Q7iA=;
  b=PRhx80tPUMxtu/JQSHqMQky7mTB009nEJf2MLbrW34G3mEhwDA5KK/T0
   HgceKIaZfj0VTbj2ZOhglXbOruDJRNS3tiLFe0tx4OsC8CsZO9CJJOC7H
   oGqijRpgSf8uzdJz+fJcQTyyVm+CPcjdI+fQZcIaib6GuyK1A7k9GLh0U
   y7dAlUJdkguTdEjXl54jpJMOEIvFqsqQB/AwgP5y811uryG5RGMvDV58J
   AVy6uu+jEDeWF7gCRY3uNcrZh0FKCtkj0YRPlAL+Y60izVMgzC/TwoYlK
   IoOvSS9gqOVIL5aZSZU4fn2EU3XlJ36XdBdddUYkIKG/zJSKIA0pHEbey
   A==;
X-CSE-ConnectionGUID: TrmiaAsQTymT0eshmAVG8A==
X-CSE-MsgGUID: 8onLslsIQaium7bmDT55fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26779795"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26779795"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 19:54:00 -0700
X-CSE-ConnectionGUID: KFmS8c7gQuSlY+Pxl/vwwA==
X-CSE-MsgGUID: dvlsoNVgQO6q7/UFTPhPlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73513459"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 27 Sep 2024 19:53:57 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suNal-000MrY-0m;
	Sat, 28 Sep 2024 02:53:55 +0000
Date: Sat, 28 Sep 2024 10:53:20 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Avichal Rakesh <arakesh@google.com>,
	Jayant Chowdhary <jchowdhary@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH v5 8/9] usb: gadget: uvc: add trace of enqueued and
 completed requests
Message-ID: <202409281004.YHy0SVaY-lkp@intel.com>
References: <20240403-uvc_request_length_by_interval-v5-8-2de78794365c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403-uvc_request_length_by_interval-v5-8-2de78794365c@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on 68d4209158f43a558c5553ea95ab0c8975eab18c]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-uvc-wake-pump-everytime-we-update-the-free-list/20240927-074027
base:   68d4209158f43a558c5553ea95ab0c8975eab18c
patch link:    https://lore.kernel.org/r/20240403-uvc_request_length_by_interval-v5-8-2de78794365c%40pengutronix.de
patch subject: [PATCH v5 8/9] usb: gadget: uvc: add trace of enqueued and completed requests
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240928/202409281004.YHy0SVaY-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240928/202409281004.YHy0SVaY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409281004.YHy0SVaY-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__tracepoint_uvcg_video_complete" [drivers/usb/gadget/function/usb_f_uvc.ko] undefined!
>> ERROR: modpost: "__traceiter_uvcg_video_complete" [drivers/usb/gadget/function/usb_f_uvc.ko] undefined!
>> ERROR: modpost: "__tracepoint_uvcg_video_queue" [drivers/usb/gadget/function/usb_f_uvc.ko] undefined!
>> ERROR: modpost: "__traceiter_uvcg_video_queue" [drivers/usb/gadget/function/usb_f_uvc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

