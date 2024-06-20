Return-Path: <linux-kernel+bounces-223514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE7D911448
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4B91C21725
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558B78C70;
	Thu, 20 Jun 2024 21:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjzIpfsN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D7770F2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918430; cv=none; b=DPxeMCOyJeKz1ZdyReFJ35WKvO27gaP8ImmqosdvPlOWg+HFriqbuSxlrOGbcYYOZd6JHiML8EMmMeUMQOE2oG7csWmDinkLIUYRbkj5t+neCjFe4iTrNvLT27MlIdBlJVM70SJC8d2YsJuXo6XI9xMsXu/DQZQJJQOCCml/LeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918430; c=relaxed/simple;
	bh=87Dp8Q4lrEL7ITxkh/neWEv+aJpT4mSXkTVg9joWs80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tv/ryrgLAhMslivBpXNgihdkZRHvhcvypKqzNfNVap2R9ul5wuEIUSZwbr+Acndq+vLZhZE7rF03Lzyw1J5ATI8zBKn32ZwbgBiP+Mst1pGQ6IMUUKNkq1agmtkRopsHw68Uipf0ttussXVmiuqQ/ohXoj8xKyiKScVdfz4wfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjzIpfsN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718918429; x=1750454429;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=87Dp8Q4lrEL7ITxkh/neWEv+aJpT4mSXkTVg9joWs80=;
  b=OjzIpfsNsSiZCaRmmTSQcmlYHk6a+/ZFMzTFeZwvSATePzriiIv1O//Q
   VQQbY0lUrBk1efqs2KPpzNL9ghZOgM1m6vd3uxfzXCACIY1ILwW5VNdh2
   +WCj8i5SMbfNbHtZZCALgf9ISQ0udXhTfQkf2VOyRmmMS+3jOC+pd9Fys
   5Y5olZTZ/rZ6mcIpw1OQwnlo0bAXA/wfQaeBZfJDzxKnekkFMF7+7lO1r
   oceld4fUi8etthmlHvxvBd9hcuxZAH+aY9GgWysAQlTBGpW4CGm7H5J4g
   4ZBy2yrGa+UD/YxC14h5B2UzfTTm7nIZ1UGDaPoZuddQqIe/cEHKlVJJW
   w==;
X-CSE-ConnectionGUID: Eo+IXQy8RVW0MVH8YGW/hw==
X-CSE-MsgGUID: XWdOagkrSL68Cp/0HUZn7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="27338445"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="27338445"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 14:20:28 -0700
X-CSE-ConnectionGUID: sn3wgCqSRweElp+sWryq+g==
X-CSE-MsgGUID: Jv2iKtIIRYaG3QQzyJBR6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="47334471"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Jun 2024 14:20:27 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKPCi-0007xs-2Q;
	Thu, 20 Jun 2024 21:20:24 +0000
Date: Fri, 21 Jun 2024 05:20:19 +0800
From: kernel test robot <lkp@intel.com>
To: Jianguo Wu <wujianguo@chinatelecom.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: csky-linux-ld: core.c:undefined reference to
 `netfilter_lwtunnel_fini'
Message-ID: <202406210511.8vbByYj3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50736169ecc8387247fe6a00932852ce7b057083
commit: a2225e0250c5fa397dcebf6ce65a9f05a114e0cf netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
date:   29 hours ago
config: csky-buildonly-randconfig-r003-20220117 (https://download.01.org/0day-ci/archive/20240621/202406210511.8vbByYj3-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406210511.8vbByYj3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406210511.8vbByYj3-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: net/netfilter/core.o: in function `netfilter_init':
   core.c:(.init.text+0x42): undefined reference to `netfilter_lwtunnel_init'
>> csky-linux-ld: core.c:(.init.text+0x56): undefined reference to `netfilter_lwtunnel_fini'
>> csky-linux-ld: core.c:(.init.text+0x70): undefined reference to `netfilter_lwtunnel_init'
   csky-linux-ld: core.c:(.init.text+0x78): undefined reference to `netfilter_lwtunnel_fini'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

