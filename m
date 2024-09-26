Return-Path: <linux-kernel+bounces-340652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B6198764B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0BE1C21B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C47A154C14;
	Thu, 26 Sep 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqgxCu1N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752C14A4DE;
	Thu, 26 Sep 2024 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363664; cv=none; b=shFwBKRAbWmFi4FwQLE3k/5OCwh8RsiNuezaKplREyg9iNeoplu++k1ya1cb2fOEuwESwprN8YOmuL+6ocNXcYvTpPaanD89UjPzV9xQHgoAo+QKV8pFR7MelmrcqzgRy+2ePrK2b5+16QLxJXZE6e7NH4TaA9wccp55PSzAFMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363664; c=relaxed/simple;
	bh=JuuyEd5ygWXoer3sJn1ctfl6CSW3TtZNYqXUG3o4YMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlFVgELwurGuCW6DE3SOJrWSY0wZDCr2Wur1zspytxjOZSp7IpgimNL1sS8yIed167HW2edyQcNSKVE/Yf+USV0W059V6V4WHF6+9osiNG2ff0LG0JRG3rl1Z6t+xH+42bsxyoJGVPtlsoa6ZaCwVkBPXVK20IB2ygpfI4CGYGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqgxCu1N; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727363663; x=1758899663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JuuyEd5ygWXoer3sJn1ctfl6CSW3TtZNYqXUG3o4YMk=;
  b=UqgxCu1NDqFOSbyeNOtwer2anCANviFrifqs3hg5ySVZeLNe0nqhjKW6
   DdsNnaM/Uo7kGMmtoT/loHoLxoFZD5Cx21GmRb8zFIO2fE5Hs3GrMIBaC
   J2aubsaRopYMHA4LZv5JkmQxUfqqBkSCSuewpELB8hbDHE6bu8iAjFVMX
   buqojgdKAGYDvMuJsOQis1DRisX8/gOftGk56BB3WBOAJyIKFrqh1LjPz
   8crUHF4KaAljLW8CyP+P5FlROFjx2vlTH8ykNbEO6fkKs1SDqLh3+EPRg
   4eH3I8MXILTczrAeE8AJlSKzNqMq1H6K3+B+oulNKUZ9TbI3lMXGLKm2P
   A==;
X-CSE-ConnectionGUID: gpJADGZ7Tyy4JiPM4DvBXQ==
X-CSE-MsgGUID: D77oZn4tQmy955AgA6n0EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26339961"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26339961"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 08:14:23 -0700
X-CSE-ConnectionGUID: 0r+AFkz/QiCxr7Zx/aJ8vA==
X-CSE-MsgGUID: /+5qi4x1Ss2VsX+8SEWUsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="72340291"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 26 Sep 2024 08:14:19 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stqC9-000Kqr-1n;
	Thu, 26 Sep 2024 15:14:17 +0000
Date: Thu, 26 Sep 2024 23:14:09 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	heikki.krogerus@linux.intel.com, tzungbi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jthies@google.com, pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/8] usb: typec: Add driver for Thunderbolt 3 Alternate
 Mode
Message-ID: <202409262224.Bnlmjakc-lkp@intel.com>
References: <20240925092505.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>

Hi Abhishek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chrome-platform/for-next]
[also build test WARNING on chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.11 next-20240926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Add-driver-for-Thunderbolt-3-Alternate-Mode/20240926-002931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20240925092505.1.I3080b036e8de0b9957c57c1c3059db7149c5e549%40changeid
patch subject: [PATCH 1/8] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240926/202409262224.Bnlmjakc-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409262224.Bnlmjakc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409262224.Bnlmjakc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/altmodes/thunderbolt.c:15: warning: expecting prototype for USB Typec(). Prototype was for USB_TYPEC_VENDOR_INTEL() instead


vim +15 drivers/usb/typec/altmodes/thunderbolt.c

    14	
  > 15	#define USB_TYPEC_VENDOR_INTEL		0x8087
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

