Return-Path: <linux-kernel+bounces-341401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690FB987F87
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE862820BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE217C9F6;
	Fri, 27 Sep 2024 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drrEX/rw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A7176FDF
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422509; cv=none; b=DqNt80GK0M0EJQ8AvrBk6LOayMciuqzZhBMNTW9We6nBGQgDJyiUXRPOTkhjzWWnX+4OhuosGFaHsilhZfURAUKyNi72BSFpqgj2voBpav3wGKCrSY+2SiJLTYJNamznonZAcXMShhgh27xhzY0APxg4qiOhz0YoOCJFg81wheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422509; c=relaxed/simple;
	bh=dl7KEC3bcA0zG29w0kvbzh2j7JbKLNg0ctUNe/5nXZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgcbsDZNFHmz/waZ5o4ImsQ4zJfLVnyjUr0c/p4ecclL4zymR7BDtJdLTdI2mRTnmRquCS+f6f/OGOZHuyM/jGMRXU3unINE4uIfwm9JKdvpFANOSFpLzL9d5AR3f/ISIQJUWb9WcRbdtIOKAedO5m2aUiOn9SXEmF2Jtw0LAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drrEX/rw; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727422508; x=1758958508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dl7KEC3bcA0zG29w0kvbzh2j7JbKLNg0ctUNe/5nXZ8=;
  b=drrEX/rwneUYonRKN2CJ8cSPQBk7XWnd5JnN1fCj19o5zMeJGESj3Uxg
   lzC6P9HXOg3l/OzWm7DlFGUyOb+5RQSMV/vG2K7BBVvZ5KXV2r25RMpsp
   +zhwxIA3N83QJiUDoKLgp81mHSgsE9QrwbugwKIIs36gD6yr4rWjRGgEM
   8hJYl/e9L9oxGx3s41qFoOEGsIrltcRlOa8PepOk0eGA6yciVWXMO9QO9
   wOhhwfuGXgm9fsWwORc5dvWtNmUr+PNNuN8MofVXWbNUYzWUclm2Yb3mZ
   Ls6VCY0lCsllhzQ7fMJsVBDvu6u7gl2l+CStE9BEf+wmbg/XUDyBkZMGj
   g==;
X-CSE-ConnectionGUID: 8J48D9jaRxSdn79gvb9nAQ==
X-CSE-MsgGUID: d7feLK6nRp+ex1tr4PkUpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="30270224"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="30270224"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 00:35:07 -0700
X-CSE-ConnectionGUID: wXRWhCHvTuKNDOX5qWfodg==
X-CSE-MsgGUID: bH2h9b3jQhi6nOnMmjKtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72444779"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 27 Sep 2024 00:35:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1su5VF-000Lex-1x;
	Fri, 27 Sep 2024 07:35:01 +0000
Date: Fri, 27 Sep 2024 15:34:59 +0800
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
Message-ID: <202409271548.taoANDmm-lkp@intel.com>
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
[also build test ERROR on chrome-platform/for-firmware-next usb/usb-testing usb/usb-next usb/usb-linus linus/master v6.11 next-20240927]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Abhishek-Pandit-Subedi/usb-typec-Add-driver-for-Thunderbolt-3-Alternate-Mode/20240926-002931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20240925092505.7.Ic61ced3cdfb5d6776435356061f12307da719829%40changeid
patch subject: [PATCH 7/8] platform/chrome: cros_ec_typec: Thunderbolt support
config: i386-randconfig-r133-20240927 (https://download.01.org/0day-ci/archive/20240927/202409271548.taoANDmm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240927/202409271548.taoANDmm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409271548.taoANDmm-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/chrome/cros_typec_thunderbolt.o: in function `cros_typec_register_displayport':
>> drivers/platform/chrome/cros_typec_altmode.h:24: multiple definition of `cros_typec_register_displayport'; drivers/platform/chrome/cros_ec_typec.o:drivers/platform/chrome/cros_typec_altmode.h:24: first defined here
   ld: drivers/platform/chrome/cros_typec_thunderbolt.o: in function `cros_typec_displayport_status_update':
>> drivers/platform/chrome/cros_typec_altmode.h:30: multiple definition of `cros_typec_displayport_status_update'; drivers/platform/chrome/cros_ec_typec.o:drivers/platform/chrome/cros_typec_altmode.h:30: first defined here


vim +24 drivers/platform/chrome/cros_typec_altmode.h

a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  10  
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  11  #if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  12  struct typec_altmode *
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  13  cros_typec_register_displayport(struct cros_typec_port *port,
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  14  				struct typec_altmode_desc *desc,
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  15  				bool ap_mode_entry);
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  16  
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  17  int cros_typec_displayport_status_update(struct typec_altmode *altmode,
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  18  					 struct typec_displayport_data *data);
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  19  #else
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  20  struct typec_altmode *
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  21  cros_typec_register_displayport(struct cros_typec_port *port,
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  22  				struct typec_altmode_desc *desc,
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  23  				bool ap_mode_entry)
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25 @24  {
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  25  	return typec_port_register_altmode(port->port, desc);
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  26  }
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  27  
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  28  int cros_typec_displayport_status_update(struct typec_altmode *altmode,
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  29  					 struct typec_displayport_data *data)
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25 @30  {
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  31  	return 0;
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  32  }
a57f16462c7621 Abhishek Pandit-Subedi 2024-09-25  33  #endif
4db96705bb611f Abhishek Pandit-Subedi 2024-09-25  34  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

