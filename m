Return-Path: <linux-kernel+bounces-436751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47509E8A47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 05:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95ED1884B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 04:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3B1607AA;
	Mon,  9 Dec 2024 04:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8ytS9XU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18407158534;
	Mon,  9 Dec 2024 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718560; cv=none; b=AICZR/BviNNQMOQ2irrTjB0ACpOXoYuZXU/b//FUM8JqU7aRZ7cDUrgPDy4BrH7Gf7tm55xm4P9nHwhMqOQFX8CDj3YG3PHWpH7uopMYgg2+tEcpDWg2u4WY2QMriatTgpiSJiwWlGmPXhXyl7Epj2jGe33MDqjLi+bgfwdCgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718560; c=relaxed/simple;
	bh=h4HEKX5WEfX5MF5rDNMl63OuBmbaPdc6Xc34HEpI9d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeYOM6d/LPINs7UTAd8PUprceqNeGIBF+4bhIp5xo9NZLgxMT0+hUYbUUpPH3Om+RYyAsiZfB6Qtaor7N8hzoiseElR2EeZa6K3617nzyR/f5N+zEU/lOtoB/PMOMjHwjdduw3xlgfS8inIdwYwHXeSRlJsXCApqQutYdkhWuCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8ytS9XU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733718559; x=1765254559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h4HEKX5WEfX5MF5rDNMl63OuBmbaPdc6Xc34HEpI9d4=;
  b=M8ytS9XUQp/7kdu/+/v3kWlHLICcMS9aS9zbMl6l+V/ZLVINI7BRnPHr
   zfH2EhKWBIs584ZQFATC8jmeH0dkaQRlkDq6Jpry+Wm3zoDO+BafLPnub
   perd4hC3Eptw5RyYJYQzA6x/0nTsx9UjyIO96NjDIMdrgKSEACNCV3+Ub
   kZEurJiCxxs3t6y/38d/yKsBl8g/+sZffUsYQo1U+FOo/lPCcgxKz06Qk
   lLcXzSh1UfCYF2Upn6rDrJHa92LAfEqxw42Nl2xb2C0dls9kr7/VtsHgN
   ANEaNrsVXj+VxVGFiOyQRApOSj9q6UNHcdVyPD1r/S22QxnDzS8qKUmlq
   A==;
X-CSE-ConnectionGUID: L/1AoaUiQ6ijiFVIgU0v8g==
X-CSE-MsgGUID: UxvOtF1zRCGrmzqmU3/j+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="34122913"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="34122913"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:29:18 -0800
X-CSE-ConnectionGUID: BeSSpaOaRwGjAPOQUvdpKA==
X-CSE-MsgGUID: f+5nCGJ8T42Mi1IFY5kmuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99404806"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 08 Dec 2024 20:29:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKVOS-0003r9-2x;
	Mon, 09 Dec 2024 04:29:12 +0000
Date: Mon, 9 Dec 2024 12:28:12 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, akuchynski@google.com,
	pmalani@chromium.org, jthies@google.com,
	dmitry.baryshkov@linaro.org, badhri@google.com,
	rdbabiera@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] usb: typec: Add driver for Thunderbolt 3
 Alternate Mode
Message-ID: <202412080010.bWqlreGq-lkp@intel.com>
References: <20241206153813.v4.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206153813.v4.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>

Hi Abhishek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12]
[cannot apply to chrome-platform/for-next chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus masahiroy-kbuild/for-next masahiroy-kbuild/fixes linus/master v6.13-rc1 next-20241206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Only-use-SVID-for-matching-altmodes/20241207-074104
base:   v6.12
patch link:    https://lore.kernel.org/r/20241206153813.v4.2.I3080b036e8de0b9957c57c1c3059db7149c5e549%40changeid
patch subject: [PATCH v4 2/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20241208/202412080010.bWqlreGq-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241208/202412080010.bWqlreGq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412080010.bWqlreGq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/altmodes/thunderbolt.c:16: warning: cannot understand function prototype: 'enum tbt_state '


vim +16 drivers/usb/typec/altmodes/thunderbolt.c

    15	
  > 16	enum tbt_state {
    17		TBT_STATE_IDLE,
    18		TBT_STATE_SOP_P_ENTER,
    19		TBT_STATE_SOP_PP_ENTER,
    20		TBT_STATE_ENTER,
    21		TBT_STATE_EXIT,
    22		TBT_STATE_SOP_PP_EXIT,
    23		TBT_STATE_SOP_P_EXIT
    24	};
    25	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

