Return-Path: <linux-kernel+bounces-340599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 451179875B3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B071C2095F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13F6136347;
	Thu, 26 Sep 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7ZsCnRd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A64F21D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361209; cv=none; b=MJC8W/s9DZgf0n/BFyO7avs13YJ2WOClYGRfzi4pbgPwPfkKE4m3jzqtfx1MTEah0MciuNuBU9PIuzzpzISH9TJlzrszeaPUXZEZUi0P4Eq8OYrcsqM2SRPtsfPNQm7gDTgJnTlgP4G1znDCPpIx4/d7TesXBQkFnkwnKfavsSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361209; c=relaxed/simple;
	bh=I7RjqxILvX5nM6Bur27oArvs62ir65ZtC4vP5appnfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sns+At30KW/FMku31SKtoAFZPfmEaLYPVMpdCepx8KWmOF0nqTfh+Ofa1hBWRoyLbo7QR4RBgMzjuBm/7znXsndSyQdfev/XOYM388AoZCvHsrCohkEtZT3FEUuaW2OvXuIMdVcmJW6G8f+M5ZRhEb6tmmqocj8hkYfSee80P3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7ZsCnRd; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727361206; x=1758897206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I7RjqxILvX5nM6Bur27oArvs62ir65ZtC4vP5appnfA=;
  b=O7ZsCnRdiqmjTbrHYZXJNRsEwH8/T34PE0fhH6JFilRLKNps882XR4oj
   O3lrD3AMvAKJ9a9PflPl3K9EV1APm1PKQQjbe5AJtBNHYssMNF0JKoJpL
   eY1dzK0T9v6GAcbwh72LI/+1ca/XKfFsmBU4RxT8Dm+kGB9JjFYze8Eos
   b7empCUe02cMTAZrNCo90jj0vS4VNh66SnEl3RshfsX7lM/Nt6Q2Q4SXu
   ByLpHS75fHFJpem2urXaODTVboM4vFGW2v65cVawQIGsMiLRbf8M3JcAP
   et1iM2asilCauYTySjZ3F7QeU9cQghf5xno0cisCjIoBz5cxVr0+bPU4p
   g==;
X-CSE-ConnectionGUID: r1IpK7WARQ2a40Xu5QZlZA==
X-CSE-MsgGUID: zt6ndos/SuCU9X6ZDe85HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="48991883"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="48991883"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 07:33:21 -0700
X-CSE-ConnectionGUID: 81tDcjiQTmqFyWNLBrYufw==
X-CSE-MsgGUID: 3yPc9vsDStSpxOa8G94BDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76259283"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Sep 2024 07:33:18 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stpYS-000KoJ-0U;
	Thu, 26 Sep 2024 14:33:16 +0000
Date: Thu, 26 Sep 2024 22:32:57 +0800
From: kernel test robot <lkp@intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	heikki.krogerus@linux.intel.com, tzungbi@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jthies@google.com, pmalani@chromium.org,
	akuchynski@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
Message-ID: <202409262259.lXP7G1FE-lkp@intel.com>
References: <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>

Hi Abhishek,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.11 next-20240926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Add-driver-for-Thunderbolt-3-Alternate-Mode/20240926-002931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829%40changeid
patch subject: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240926/202409262259.lXP7G1FE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240926/202409262259.lXP7G1FE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409262259.lXP7G1FE-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/platform/chrome/cros_typec_thunderbolt.o: in function `cros_typec_register_displayport':
>> (.text+0x34c): multiple definition of `cros_typec_register_displayport'; drivers/platform/chrome/cros_ec_typec.o:(.text+0x2118): first defined here
   sh4-linux-ld: drivers/platform/chrome/cros_typec_thunderbolt.o: in function `cros_typec_displayport_status_update':
>> (.text+0x37c): multiple definition of `cros_typec_displayport_status_update'; drivers/platform/chrome/cros_ec_typec.o:(.text+0x2148): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

