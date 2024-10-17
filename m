Return-Path: <linux-kernel+bounces-369199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB679A1A3A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4691F2520C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B7F161326;
	Thu, 17 Oct 2024 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWTB3lOd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1231388
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729144083; cv=none; b=CKJjOKY9Glr7e2MxumJd4RqPEExmPPrCGszUgEsMa9ocdIl+io7AAQh1cEiuyBgAQRMIokVE3I4KpgMqGcMsyjkDg/z1MBLkyB3PR7ZiRvVHNDqV+BNg3EToOYNCVPdi+6mfMO9z7V/NDyhiOg2L/mnO2wFkvJijyrJbGUH+36U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729144083; c=relaxed/simple;
	bh=JdI560mGE1ydYY2U1ISr4jnftj9tZxdERmiaclpN7zE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UP4IPK9bpHaZ1KtaCQHdB0jeZEanIqtAUHtWDBTFYIJ9QnCDGw+SmAwczkdmbj/UIyN/2aTjUhdG3gLAX3AEBlpvtYZR1sGSuJHgatiFf3yhA5t0ef8+lAdg8EgzDmRLxCdxIpC+uXbjQz4vx0VTomgDdr6HdWiImhpXbNrvFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWTB3lOd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729144080; x=1760680080;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JdI560mGE1ydYY2U1ISr4jnftj9tZxdERmiaclpN7zE=;
  b=LWTB3lOdKlpP0kjVuVqjmwC++KxwP43GIaFesTqjLe5m1YQbZ11K+TDl
   Io3KX3UfoA+XFiMq5kdcnzNhJ4AnueLCEMSvQvGX74boJqx79uCMRzBQq
   3HdfXoZVYv67Fdt2mH0Xonxq7eyVNddIW7iV5Wmbt0qn7DmBOuucnFMX/
   zCZ5D46Q0aocTtg52CUJtrhnQOVQPi73J4SgzrxxY4+YokSdIcwep/CkC
   /OQN7tKuo73WI8uXbh2Zd91yhe7xw5sKSlIEPAW0zcRXaZ+h3S7v3Nzdd
   MgFaq+qiF5fk8UwOMsjgF6dipjaZV0xk9lkypGL/VlYKYClSL7Dfs14Uo
   Q==;
X-CSE-ConnectionGUID: Z8RnWsXUTraM2U08GEuXOA==
X-CSE-MsgGUID: M9sfYFxgRgePHOnbaVaG9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="40011752"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="40011752"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 22:47:59 -0700
X-CSE-ConnectionGUID: uob64dLaRbmp4JlgNILSsw==
X-CSE-MsgGUID: 1OwBMn/SRnumtokRcbnzTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78473232"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 16 Oct 2024 22:47:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1JMa-000LmF-0L;
	Thu, 17 Oct 2024 05:47:56 +0000
Date: Thu, 17 Oct 2024 13:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015 16/18]
 ./usr/include/linux/wireless.h:860:33: error: field 'src_addr' has
 incomplete type
Message-ID: <202410171340.SzEKww7B-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Gustavo,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20241015
head:   d64af418459145b7d8eb94cd300fb4b7d2659a3c
commit: d9e9d9c1ade33701172b069e7dea728b063b00ee [16/18] uapi: wireless: Avoid -Wflex-array-member-not-at-end warnings
config: x86_64-buildonly-randconfig-002-20241017 (https://download.01.org/0day-ci/archive/20241017/202410171340.SzEKww7B-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410171340.SzEKww7B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410171340.SzEKww7B-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/wireless.h:747:33: error: field 'addr' has incomplete type
     747 |         struct sockaddr_legacy  addr;           /* Source address (hw/mac) */
         |                                 ^~~~
>> ./usr/include/linux/wireless.h:772:33: error: field 'bssid' has incomplete type
     772 |         struct sockaddr_legacy  bssid; /* ff:ff:ff:ff:ff:ff for broadcast BSSID or
         |                                 ^~~~~
   ./usr/include/linux/wireless.h:829:33: error: field 'addr' has incomplete type
     829 |         struct sockaddr_legacy  addr; /* ff:ff:ff:ff:ff:ff for broadcast/multicast
         |                                 ^~~~
   ./usr/include/linux/wireless.h:853:33: error: field 'bssid' has incomplete type
     853 |         struct sockaddr_legacy  bssid;
         |                                 ^~~~~
>> ./usr/include/linux/wireless.h:860:33: error: field 'src_addr' has incomplete type
     860 |         struct sockaddr_legacy  src_addr;
         |                                 ^~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

