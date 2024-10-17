Return-Path: <linux-kernel+bounces-370631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E89A2FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2CB1F22BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA161D63C8;
	Thu, 17 Oct 2024 21:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xhldz94m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE081D12EA
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200899; cv=none; b=HGxTcyLIFzsO3Of2f2hkI4MBKPbkG5svE53GiXZAMvkDbSmyil5RGeOIIgQvfy/1kqSRoIplz4zWFRsUUjP0H/ms515VvDM7PAWV42JdaYZOiKy6nAE7VmqaDfU/NtB9TEJyMBR+B/rNmQamGzmMGfxKctW36cUOy1UIpWp6dnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200899; c=relaxed/simple;
	bh=48YG+JGTHE3S5/27NawYLVVHlS4dCY4Gc+EKzKTt1sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pVaKMqLcOwyytXQgbR496Vu6NFDAAAivAhv+2uy3gL0g9XZCNBqDmDN53k/fc2kKmMM0dcsNjEEsDpBNo3yUZxikt3E+Ovi/ZPy2Odq2q2likfrCdf7vtELfOZ41o1LS2cz3GIXFw3+EH7uQDmFuqIQISs5QdQQEwl9SPJAc1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xhldz94m; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729200893; x=1760736893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=48YG+JGTHE3S5/27NawYLVVHlS4dCY4Gc+EKzKTt1sI=;
  b=Xhldz94m8OADyCn7Yg7NEFlW9a2++gxvDxSgGJJ8IgVYNVVD6a9Y0EDV
   WiZlnSY+/qSsxCm70eGuX6e/5j65HlWhttPFLmk+wThEwfOjnhfqrrfs/
   84+GSHmZ2wwug6j3ag1iKwW/0qYFqoSf6WFbRHAByfDwTeF5TYWXpnwy9
   coyda9mU3uDMRjQMY4iYCc78y7VRy/kJs8lxC9uqQoKcXSQLrG+mRpmY+
   C7rd5sfJCtRqxVSVAOFuK4kTROinjNc5FPSWKP6V1BaPC9yQMPeP7+d2J
   QtlUABfEQ5LHAxPFKLdzWWLu5iRMcRgRka4cdd9XKj6MHh/fLOa7AiAjQ
   g==;
X-CSE-ConnectionGUID: Hq4+JbTdQpWx6/opg1vIGw==
X-CSE-MsgGUID: 4ETL3OXwSqKo/QwyMTbO/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39257441"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39257441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 14:34:53 -0700
X-CSE-ConnectionGUID: QCA6gA4EQYGs05LFkrlJdg==
X-CSE-MsgGUID: rYiiZD8rSwulP5cEu4Xizg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="83755207"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Oct 2024 14:34:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1Y8u-000My5-2f;
	Thu, 17 Oct 2024 21:34:48 +0000
Date: Fri, 18 Oct 2024 05:34:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015 17/18]
 ./usr/include/linux/if_arp.h:118:33: error: field 'arp_pa' has incomplete
 type
Message-ID: <202410180511.pR0VdibP-lkp@intel.com>
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
commit: f04e61e1c69991559f5589080462320bf772499d [17/18] uapi: net: arp: Avoid -Wflex-array-member-not-at-end warnings
config: x86_64-buildonly-randconfig-002-20241017 (https://download.01.org/0day-ci/archive/20241018/202410180511.pR0VdibP-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410180511.pR0VdibP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180511.pR0VdibP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/if_arp.h:118:33: error: field 'arp_pa' has incomplete type
     118 |         struct sockaddr_legacy  arp_pa;         /* protocol address              */
         |                                 ^~~~~~
>> ./usr/include/linux/if_arp.h:119:33: error: field 'arp_ha' has incomplete type
     119 |         struct sockaddr_legacy  arp_ha;         /* hardware address              */
         |                                 ^~~~~~
>> ./usr/include/linux/if_arp.h:121:33: error: field 'arp_netmask' has incomplete type
     121 |         struct sockaddr_legacy  arp_netmask;    /* netmask (only for proxy arps) */
         |                                 ^~~~~~~~~~~
   ./usr/include/linux/if_arp.h:126:33: error: field 'arp_pa' has incomplete type
     126 |         struct sockaddr_legacy  arp_pa;         /* protocol address              */
         |                                 ^~~~~~
   ./usr/include/linux/if_arp.h:127:33: error: field 'arp_ha' has incomplete type
     127 |         struct sockaddr_legacy  arp_ha;         /* hardware address              */
         |                                 ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

