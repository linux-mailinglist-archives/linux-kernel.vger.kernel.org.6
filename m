Return-Path: <linux-kernel+bounces-329650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5764F97944D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 04:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4651F21C29
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7E2F4A;
	Sun, 15 Sep 2024 02:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIe422QJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D561C32
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726366052; cv=none; b=brR9TzWu32fq6wSVyeg4uoMg5yy0DmL5epogX7pvqApb+SKpCCymQDXvfvesIqP9+r6HwQLlsb/vdXjxcUVn6tM+Wo+jojcrUWnuuz9nD/0cf2wX90FpBbbdVfxDg97grjTSUeWzp0qW8zXQ/LbgDnulA+2XK5EPzx7xlgaZahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726366052; c=relaxed/simple;
	bh=KpbGciaXOmeOh3W92Etpe7+xu4k9td+wCnPCoZABsd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWplFluXbWmSWegvVESuLll6VDfK3sAIBlaSL/Uwm02zd+wCVSf35qUFHKXjW+MV47BjbCHuJh1zbxltRj/XB2KBcWfH6k/Vnh9I6G5CuJNtMlbJ0kkCqWZ2MQePRAwfKTuQCd2FkhYFE0Ca+fs0hZtEjKEh50L5tfjf2uVuIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIe422QJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726366050; x=1757902050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpbGciaXOmeOh3W92Etpe7+xu4k9td+wCnPCoZABsd0=;
  b=gIe422QJjosIq2QW9sp3bRjTDazoQ6nP30DVxvzo/2lieMdjnRweWkBg
   uLUb/r7gHarLcKPOR1M//YwOT21PYtuzNsa8fMGTHe2DMrEV8Zj2CvI6X
   jKfpt7TBvpLI4bBkM2Ru9X8k2mTha70o0vTnlxsxCw4TqJ92H+OO4ccRr
   IKQkVSZdQ2rWuz3D54pB3uJYiUAvXXvfKtWwPDf4iOyRR/06isPp1WYsY
   sziVEVPG4uJ0iM7QDGaXZhWCY2AKGQMSH9iUFglz5rsG/+mcJcln9NnL/
   xnHJr3pRM3Ajexl3gKBh94xWir2z12lsD3VuL1Wx9bNR0IGIvXuUeeXNf
   g==;
X-CSE-ConnectionGUID: DX5oOyQhSlWe6sWq3XmsvA==
X-CSE-MsgGUID: 320QryZ+QpC2jCy8CBOm6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11195"; a="42748808"
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="42748808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 19:07:30 -0700
X-CSE-ConnectionGUID: EX0/+ZlBRsKH6sW4r3Agow==
X-CSE-MsgGUID: cpHkERcyRuWhtwOrmfJ5+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,230,1719903600"; 
   d="scan'208";a="73274066"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 14 Sep 2024 19:07:27 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spefc-0008KI-1t;
	Sun, 15 Sep 2024 02:07:24 +0000
Date: Sun, 15 Sep 2024 10:06:36 +0800
From: kernel test robot <lkp@intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Julius Werner <jwerner@chromium.org>,
	Hugues Bruant <hugues.bruant@gmail.com>,
	intel-gfx@lists.freedesktop.org,
	Brian Norris <briannorris@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
	chrome-platform@lists.linux.dev,
	Javier Martinez Canillas <javierm@redhat.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v3] firmware: coreboot: Don't register a pdev if
 screen_info data is present
Message-ID: <202409150915.n7egvNYa-lkp@intel.com>
References: <20240913213246.1549213-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913213246.1549213-1-javierm@redhat.com>

Hi Javier,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on chrome-platform/for-firmware-next linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Martinez-Canillas/firmware-coreboot-Don-t-register-a-pdev-if-screen_info-data-is-present/20240914-053323
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20240913213246.1549213-1-javierm%40redhat.com
patch subject: [PATCH v3] firmware: coreboot: Don't register a pdev if screen_info data is present
config: csky-randconfig-002-20240915 (https://download.01.org/0day-ci/archive/20240915/202409150915.n7egvNYa-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240915/202409150915.n7egvNYa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409150915.n7egvNYa-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
>> ERROR: modpost: "screen_info" [drivers/firmware/google/framebuffer-coreboot.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

