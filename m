Return-Path: <linux-kernel+bounces-402729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1987A9C2B14
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47E21F2194F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984713B2B6;
	Sat,  9 Nov 2024 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOMmmyqv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0E8836
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731139243; cv=none; b=GW/Q09ExnL/LAMuScumh/V9Mhp7HY1hLyLWsrY65WoT0wCFw4MKbQEQUEbuBZfh0WOCz5j5gAxSG6ums/8lHA8P9f5QoLqKyK0MpvhwMhvQse09YBIRo4J93a/RyN8ioaBvyHPM8AFZGS6s7uVuLlliH7RNLgkixWJ6P/CZlH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731139243; c=relaxed/simple;
	bh=Hg18jHenln1AxJEu/4fRwyzk7EQid7Ptx0+xOvDyjrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pTxly+YOaGCrMClTmq/OjPPuRVHuxvSkAcw+0T8MnEmMEjqAx4fCCxjPF3lvxpXIGsuap/yVqGoUCtQ7l9BfoYvU8wsdZa5E8M7RBbhyS+KrhJFEuY1aAbcIXp2hIf9ZvomP7HL9Spc3QaaCZXpxDC3YzVWci4ONsfByRgnsIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOMmmyqv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731139241; x=1762675241;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hg18jHenln1AxJEu/4fRwyzk7EQid7Ptx0+xOvDyjrM=;
  b=KOMmmyqv76VPn5PXkDfiw7tugCbr4OkkTalb1SesI60G8HZ8BW591nt5
   uYPSvmSel6qHcZmKtemt1BxMQsnHYZL++c4cZVkjH38pI3Mx5zl1x1yRO
   mibI7zxNeq3YHm+8wynT2bPpYMg/JaiCLgi/NYjbIHGnhp+TsWkCqETdY
   y6wHdqVqzOQGVeAN2fmpztjHBT9VuwjUMUBsNppe0EL755H07vYzrrEpO
   9rrzQKKhgotcMHBrF0ZTG9ObJ0V6GrB5lUTTv6Cs7+qxfSr/hbdKlc4qO
   RXiuTHrBhzEGVNXTkIktZzrrI8Qjp9/0ygnfT2O/L8+LGjdhck9xU3dHh
   w==;
X-CSE-ConnectionGUID: tFNH4LaGRz2eYwJbNOVWEQ==
X-CSE-MsgGUID: jKriN1zTQuGAtVgPDjTxMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="56421395"
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="56421395"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2024 00:00:40 -0800
X-CSE-ConnectionGUID: WZmeLo8VQmKHnEym4E9xcw==
X-CSE-MsgGUID: AmJeUSpcQwayyHeZia5reA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,140,1728975600"; 
   d="scan'208";a="109231056"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 09 Nov 2024 00:00:39 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9gOa-000sDO-24;
	Sat, 09 Nov 2024 08:00:36 +0000
Date: Sat, 9 Nov 2024 16:00:08 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Guillaume Nault <gnault@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>
Subject: net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202411091538.PGSTqUBi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   da4373fbcf006deda90e5e6a87c499e0ff747572
commit: 223f55196bbdb182a9b8de6108a0834b5e5e832e inet_diag: allow concurrent operations
date:   10 months ago
config: hexagon-randconfig-r112-20241109 (https://download.01.org/0day-ci/archive/20241109/202411091538.PGSTqUBi-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce: (https://download.01.org/0day-ci/archive/20241109/202411091538.PGSTqUBi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411091538.PGSTqUBi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> net/ipv4/inet_diag.c:1511:17: sparse: sparse: Using plain integer as NULL pointer

vim +1511 net/ipv4/inet_diag.c

  1503	
  1504	int inet_diag_register(const struct inet_diag_handler *h)
  1505	{
  1506		const __u16 type = h->idiag_type;
  1507	
  1508		if (type >= IPPROTO_MAX)
  1509			return -EINVAL;
  1510	
> 1511		return !cmpxchg((const struct inet_diag_handler **)&inet_diag_table[type],
  1512				NULL, h) ? 0 : -EEXIST;
  1513	}
  1514	EXPORT_SYMBOL_GPL(inet_diag_register);
  1515	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

