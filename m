Return-Path: <linux-kernel+bounces-370779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65569A31EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D81F24045
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267238F82;
	Fri, 18 Oct 2024 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SremO6YD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863820E31E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214461; cv=none; b=Z4D0Qc5AzXxPnY0PlJv1XsUNm76vuFkEC1EDAzlFE+2w1BQvGQOAO+z3wEaN8X/c6BrH1g+xZpmwARLQDfDCNww029BDNZa8h04cRp6JaPlrafamFmhA6ov6d9HnAyQ49EL/UZOFtgrKRBZP1Vp7XYDzf+ws/bAmvdyJo/7d77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214461; c=relaxed/simple;
	bh=jCkD1ILQFIsIsbupv765Sn5C0JSNTrw/W2nHbgMwwg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U/hhT527IiWT+ESaLNMy4d2vViY25YLXA821EEvMZ8AgYEHn/5U6mCQcE+W1z+t0a6NT/J2UQJJwDHJesedEk/XM3snD+DIwo30VvBJ0adGSE/RKSZMYNTTzQePQzGAg0ToU1llB4QNJ0kZIUm1MW947mcg1eTX6jSyW6iHgJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SremO6YD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729214460; x=1760750460;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jCkD1ILQFIsIsbupv765Sn5C0JSNTrw/W2nHbgMwwg8=;
  b=SremO6YDMQ0+KJG6U0JeeuLUXHmJ1EPahI6hp/MGdhAaWB1Omtg5YGAX
   KzeiS53QNwcrCczeEEm+aeSixwM3Sjr31fKmyhihbhX4pMRbYJGrmz6Zq
   SalLne3IH1HTi4vOZC+SDFdGYeZk/QPkNs3bScID/PQw5gHrD3k6TToqk
   1EmTaWeMmlMDxdBhMjdkuGSVbJ/lUPQqLQfonQvtL9wuYTr9m9MvAgluW
   52ZwGADDI87u7Dy0MVQ/+epIVJRGU/CSp3LR0xBrEWQZg8J3bqHu8V9QP
   dvYnM+tWoYx0fybFDc3HbbLLbKaggLEQbIZZPpOHVWOqrkGHATDoOVO/J
   Q==;
X-CSE-ConnectionGUID: w4UCo5LeS2+s72kPRGCoSw==
X-CSE-MsgGUID: u64Q/PGbQ+SgGgcN8BwZ2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28170092"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28170092"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:20:58 -0700
X-CSE-ConnectionGUID: C7wboxCTQ9iQvsxMaRNRRg==
X-CSE-MsgGUID: 4KwNKFyPRl+FS4cc0o1Qyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="109538408"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Oct 2024 18:20:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1bfi-000N6Z-1F;
	Fri, 18 Oct 2024 01:20:54 +0000
Date: Fri, 18 Oct 2024 09:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20241015 18/18]
 ./usr/include/linux/route.h:33:33: error: field 'rt_dst' has incomplete type
Message-ID: <202410180900.U30y4vBZ-lkp@intel.com>
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
commit: d64af418459145b7d8eb94cd300fb4b7d2659a3c [18/18] uapi: net: Avoid -Wflex-array-member-not-at-end warnings
config: x86_64-buildonly-randconfig-002-20241017 (https://download.01.org/0day-ci/archive/20241018/202410180900.U30y4vBZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241018/202410180900.U30y4vBZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410180900.U30y4vBZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/route.h:33:33: error: field 'rt_dst' has incomplete type
      33 |         struct sockaddr_legacy  rt_dst;         /* target address               */
         |                                 ^~~~~~
>> ./usr/include/linux/route.h:34:33: error: field 'rt_gateway' has incomplete type
      34 |         struct sockaddr_legacy  rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
         |                                 ^~~~~~~~~~
>> ./usr/include/linux/route.h:35:33: error: field 'rt_genmask' has incomplete type
      35 |         struct sockaddr_legacy  rt_genmask;     /* target network mask (IP)     */
         |                                 ^~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

