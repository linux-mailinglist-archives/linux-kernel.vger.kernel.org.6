Return-Path: <linux-kernel+bounces-389982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DFB9B7407
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE2C1F24C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 05:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AD813C9B8;
	Thu, 31 Oct 2024 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B63QYUox"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4612C52E;
	Thu, 31 Oct 2024 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730351401; cv=none; b=P2/jvNaL6VYBO45Iq3F+fiUR2DjMa6G2DuaoCZrnneSGdxIJraGcNYbOUR0tWLmodSZgVENtX4DBr3pshogRDCzA1GZifn/WF+arRPDWL1BkyVzwjDUl9Je6dbyshqP+oXoI8M6ZRPyK/AOy3/wkIapQxMr4QgDvEgblSygXlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730351401; c=relaxed/simple;
	bh=iAXyY8h3wSBHZqgx4EtdRqu7TyDAlhH22WfxpajjMZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3fzarWoxzvgMx01CRnSTA5shJTBDJeQR/pJX3d0sq2lyRliy+Z89/ARIiVWgAu4Dbe9qanU5r1YwoR+wSl8nLq/Dvn+Dz7r7/bJokycYpQ4p/NtgAAljjlH5Gd/+Msi+o8xJrT+OlNgpyNooM4gTumabl3wlwMNJTwlz2M370o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B63QYUox; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730351399; x=1761887399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAXyY8h3wSBHZqgx4EtdRqu7TyDAlhH22WfxpajjMZY=;
  b=B63QYUoxjMo4DocC4qDe3RZIoSTNOchBOvQROh9Rfyitz3UyGfhvUF8J
   bfq940SO40uSRlEHDsm/W2q/oGrfqeKfT/N433fIrA4DcmMywQI/OYi+b
   VaEgy2oRpRISuCeeOaFe/1L/Q5/ivz7PavhwMity0tt6HYwA1s6DLd/dt
   T9xBKAGuZedXRENz3hObwnG7V4tXpgWUIpjdOskIPxa3d8Wquds9gRwQz
   5Pgi+CKQgSDNZ829ZVw8ML/76azUiL+zt0X91ivJAeWwRMajlXPxHSP92
   0vYix7gTBYuQNcAu7cQ0MNo268rF5QJDmSnk3V5ChufyEJue0F/JfDQ2a
   A==;
X-CSE-ConnectionGUID: Faoxzl/DTOWzpztPMk75SQ==
X-CSE-MsgGUID: 127rCUJVQ9+ZesZ2xrW61g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30235286"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30235286"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 22:09:59 -0700
X-CSE-ConnectionGUID: LioMlFWLRwy/tZL5lLltNQ==
X-CSE-MsgGUID: Fvn15uk0RsGaCSxdhO1tug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87311616"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 30 Oct 2024 22:09:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6NRQ-000fgU-2J;
	Thu, 31 Oct 2024 05:09:52 +0000
Date: Thu, 31 Oct 2024 13:09:37 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, dmitry.baryshkov@linaro.org,
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] usb: typec: Add driver for Thunderbolt 3
 Alternate Mode
Message-ID: <202410311250.ALKPLCqo-lkp@intel.com>
References: <20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>

Hi Abhishek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus westeri-thunderbolt/next linus/master v6.12-rc5 next-20241030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Add-driver-for-Thunderbolt-3-Alternate-Mode/20241031-053304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549%40changeid
patch subject: [PATCH v2 1/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241031/202410311250.ALKPLCqo-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410311250.ALKPLCqo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410311250.ALKPLCqo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/altmodes/thunderbolt.c:16: warning: cannot understand function prototype: 'enum tbt_state '

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


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

