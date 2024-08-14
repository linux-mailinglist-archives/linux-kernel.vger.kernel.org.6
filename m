Return-Path: <linux-kernel+bounces-286972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E73A952103
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D311C20B05
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D07B1BC07C;
	Wed, 14 Aug 2024 17:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KELjCl3n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0181BBBCD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656273; cv=none; b=Out8BBU6pNRalmBwsiACls62MO/Y7BZWkFRTj0mfC1Nj2LnAuOSR+MPEx4ZS4mfZ/XgQG1rghDL6/NJqBQeWSyenn5YySa9dHvNfQk4qRFeULKjY25AfCS5n0cwnFlVmoikDfEGXVfzASKNeFZelW/W2MnI2YlKVoJJjX3qDrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656273; c=relaxed/simple;
	bh=/2nqj1zk1eK5KRY1Jy6nsIwDR99wK4nO4cOzT9n6K3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei2lyUxrMCkcvxR5HH00L4bpU2hxVb4Gpnj55fRq+qEwO0v25J/FC0rlM1Q4y0IMTZO1QhrlctPfgmcrZunYG81T25tf0M0td+Jj4k8sci51V4snqYPaX6xebb5QlnS9HkOLHbrS2V562rpiFw8TQpJQxMAGaf0s4wergvxYeMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KELjCl3n; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723656272; x=1755192272;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2nqj1zk1eK5KRY1Jy6nsIwDR99wK4nO4cOzT9n6K3s=;
  b=KELjCl3nDEEk6xx1ffiCrEj7TyI+0sEMd1tfckiWslNFTHr5v2BuWqCN
   KFReHFOdfKcDABgHnij450gV68+mcVQk1kW8TCP5FCDIvnr6n0w0VRGxF
   6WTnb1rq+M3hr58u39u75ZJMmkp74VMBBG9i6y+2T9vnSfM+WyZgd1Ee5
   LQWsS1akAxfkVe12tCsTwS4gwHK4KKOTcP6boasG//nQReFt9qSMwZeFt
   2PuwB1k+uy8m16NVh8rhhoKfjCTLgg4Cnoto9+nezQXOEOMjTJ8+2GNxA
   xnOgeZhCYUaVXmNpUH/jkvVP03hNCgqoCWV7kgVxhf0jxi6SoZOuN4ybc
   g==;
X-CSE-ConnectionGUID: 1juFCKIFQLazjh9l6fNQgw==
X-CSE-MsgGUID: ccYDeLCdTNSoYRvOSvP2pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32564574"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="32564574"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:24:29 -0700
X-CSE-ConnectionGUID: B1w5T3AwRBejyYsR2BN9bw==
X-CSE-MsgGUID: DGOFRB0ZR8Kvs/uEdul9jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="89790981"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 14 Aug 2024 10:24:24 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1seHjS-0002bz-1S;
	Wed, 14 Aug 2024 17:24:22 +0000
Date: Thu, 15 Aug 2024 01:24:21 +0800
From: kernel test robot <lkp@intel.com>
To: Li Li <dualli@chromium.org>, dualli@google.com,
	gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com, arnd@arndb.de,
	masahiroy@kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, hridya@google.com,
	smoreland@google.com
Cc: oe-kbuild-all@lists.linux.dev, kernel-team@android.com
Subject: Re: [PATCH v1] add binder genl for txn report
Message-ID: <202408150004.BAtK29zS-lkp@intel.com>
References: <20240812211844.4107494-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812211844.4107494-1-dualli@chromium.org>

Hi Li,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]
[also build test ERROR on staging/staging-next staging/staging-linus linus/master v6.11-rc3 next-20240814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Li/add-binder-genl-for-txn-report/20240814-150338
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20240812211844.4107494-1-dualli%40chromium.org
patch subject: [PATCH v1] add binder genl for txn report
config: x86_64-buildonly-randconfig-002-20240814 (https://download.01.org/0day-ci/archive/20240815/202408150004.BAtK29zS-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240815/202408150004.BAtK29zS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408150004.BAtK29zS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/android/binder_genl.c:20: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * The registered process that would receive binder reports.
   drivers/android/binder_genl.c:25: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * The policy to verify the type of the binder genl data
>> drivers/android/binder_genl.c:102: warning: cannot understand function prototype: 'struct genl_small_ops binder_genl_ops[] = '
>> drivers/android/binder_genl.c:114: warning: cannot understand function prototype: 'struct genl_family binder_gnl_family = '
--
   ld: drivers/android/binder_genl.o: in function `binder_genl_cmd_doit':
>> binder_genl.c:(.text+0x38): undefined reference to `__alloc_skb'
>> ld: binder_genl.c:(.text+0x61): undefined reference to `genlmsg_put'
>> ld: binder_genl.c:(.text+0x83): undefined reference to `nla_put'
>> ld: binder_genl.c:(.text+0xb7): undefined reference to `init_net'
>> ld: binder_genl.c:(.text+0xbc): undefined reference to `netlink_unicast'
>> ld: binder_genl.c:(.text+0x135): undefined reference to `skb_trim'
>> ld: binder_genl.c:(.text+0x144): undefined reference to `sk_skb_reason_drop'
   ld: binder_genl.c:(.text+0x195): undefined reference to `sk_skb_reason_drop'
   ld: drivers/android/binder_genl.o: in function `binder_genl_send_report':
   binder_genl.c:(.text+0x21c): undefined reference to `__alloc_skb'
   ld: binder_genl.c:(.text+0x248): undefined reference to `genlmsg_put'
   ld: binder_genl.c:(.text+0x267): undefined reference to `nla_put'
   ld: binder_genl.c:(.text+0x298): undefined reference to `init_net'
   ld: binder_genl.c:(.text+0x29d): undefined reference to `netlink_unicast'
   ld: binder_genl.c:(.text+0x304): undefined reference to `skb_trim'
   ld: binder_genl.c:(.text+0x313): undefined reference to `sk_skb_reason_drop'
   ld: binder_genl.c:(.text+0x34c): undefined reference to `sk_skb_reason_drop'
   ld: drivers/android/binder_genl.o: in function `binder_genl_init':
>> binder_genl.c:(.init.text+0x12): undefined reference to `genl_register_family'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

