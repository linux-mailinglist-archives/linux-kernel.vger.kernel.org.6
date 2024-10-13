Return-Path: <linux-kernel+bounces-362741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6515199B8DD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E7E282332
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1413AD22;
	Sun, 13 Oct 2024 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDWN/lL0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBF2907
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728809566; cv=none; b=Ubhie9z5CYQ5J6U5Ht1L32QTTExyfOkjaUc1Kgqz/qay8mN3ez/KvkqsUywhZlW7WYCMbMsJJ0CtLJMucz4qw/mx48hmf381VafNk3qMGb4sGiJF5aIrinVMyPzNm7fSIN8aWtasl0CrpPLjQKYxTYnKocofafi9rQtd/BlDU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728809566; c=relaxed/simple;
	bh=UD1YqoqLreHhFyS6vfSFUekwTj19fHkIF7YoEsutagU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNmR0wktIcydMvXK2Gw1EOWoEgWsW8KBkgD/iOtqmtG9IaNGT2n4XUZyI/YwhNDIYjyRpHmpj7S3bSJDafZnB8nedbIrHLdA+LOkNoonI5i1PMFdHwDLMM6B/OCbW01Beg1WJ55FXh8c7TtTLIFjUrc6RYZU3Zhbbr/fWRWElIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDWN/lL0; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728809562; x=1760345562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UD1YqoqLreHhFyS6vfSFUekwTj19fHkIF7YoEsutagU=;
  b=UDWN/lL0whQS4esajX6gtQqCZ7anHFo2xbn+rKhtuSWGJ1lytBb6cNfX
   upEWtIDLCnKmrmeAO5sQ+FV/NPW76kHWWkRBJ1BFEMiKoTH43JYGAlkLJ
   SqXDh4rakiDUXXtfZvL50R0BTIOjOAbFoKfaS9b7ZPLw9DJ3jiFEzqSvA
   9nlikRao0CVORfqJqq7oLgv6t3N/Z5KhuxR1ARXxAJ5qbrX9r7IkAsDzF
   BzzefsteXVW+q/wwx4gVx8xuK9reRi6Nv6hhLmQwGnyIqlA0Jy2hTf2kc
   kacL4Y6y3v2J0h3rCNuHufE/WJ/9N3b49oqbJ7n2u6shJohls5ls7eLxn
   g==;
X-CSE-ConnectionGUID: alBH3IiSRna5U9+DiyFGhQ==
X-CSE-MsgGUID: A9hlWOW3TAO9zAn9G3cjLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39286045"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39286045"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 01:52:42 -0700
X-CSE-ConnectionGUID: d8Ms5SUTQ3CLDWNJqd11eA==
X-CSE-MsgGUID: XUuHBGDETSqEQiu3Hs9Xxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="77221890"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 Oct 2024 01:52:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szuL8-000EEB-31;
	Sun, 13 Oct 2024 08:52:38 +0000
Date: Sun, 13 Oct 2024 16:52:01 +0800
From: kernel test robot <lkp@intel.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>
Subject: Re: [PATCH 3/6] misc: keba: Support EEPROM sections as separate
 devices
Message-ID: <202410131655.SZLsBJYD-lkp@intel.com>
References: <20241009202949.20164-4-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009202949.20164-4-gerhard@engleder-embedded.com>

Hi Gerhard,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus soc/for-next linus/master v6.12-rc2 next-20241011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gerhard-Engleder/misc-keba-Add-SPI-controller-device/20241010-051016
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20241009202949.20164-4-gerhard%40engleder-embedded.com
patch subject: [PATCH 3/6] misc: keba: Support EEPROM sections as separate devices
config: csky-randconfig-r123-20241012 (https://download.01.org/0day-ci/archive/20241013/202410131655.SZLsBJYD-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241013/202410131655.SZLsBJYD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410131655.SZLsBJYD-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/misc/keba/cp500.o: in function `cp500_nvmem_match':
   drivers/misc/keba/cp500.c:481:(.text+0x19a): undefined reference to `i2c_verify_client'
>> csky-linux-ld: drivers/misc/keba/cp500.c:489:(.text+0x1f4): undefined reference to `i2c_verify_client'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

