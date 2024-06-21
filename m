Return-Path: <linux-kernel+bounces-224812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB36912721
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 184701C2427A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0569107A6;
	Fri, 21 Jun 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyWV5xW2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A422B4C94
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978470; cv=none; b=YAldGgRetgiwLdwk5du+N3ywwDX0PXUtjB0Ax953vPesVpwnZM19ZCZGxSFENDMcIvIlkiC35e9aGFTxYy6N4iKeIFNTj4b6PTuMjTtEWZQavk0mOGE9YzURMASmxWDyoYye/HGQ5fYxuYinkXxEQXC0Hc6FwvgKxYWO4wv2GfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978470; c=relaxed/simple;
	bh=BvaTbXBdt8mAHcbZS7Pq3bujenMEXJYP46Cukn4T8HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sz9axJZt4hC4QcLzH4TzOgFl/77Nr20eznR9yRGlxlEMhKVaZ6hXv54V04CBjrJGSfeD6xFzWFLwdjqT9jbo20kPQ5CeiBk3QlQp59DfpaKRdcVzWIyK7do+BrtmGPjq3vFgf7dIlzFZj8i7WNh1pi94mKS9OH59ibEyU24gbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyWV5xW2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718978468; x=1750514468;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BvaTbXBdt8mAHcbZS7Pq3bujenMEXJYP46Cukn4T8HQ=;
  b=nyWV5xW26rsMfUWI7lftyZsasJe+hwjFfXCAQZFmFZ1WqNfVtO5Ac561
   2vaYKG43a91W00ZNCmsfEPvCkgr/b+6ASyhiM60gRX6HN4QIABBjzV/hp
   HndI+394g9OP7agtjyiQVbPJ3Z2nitFivrF2Lw5nxy0aGqQE2PFA5flwF
   rxWWlJUFBdvG3lc/nJ4DsQlZ6c93CbIODOjAG4zA8nCLqHhWHP6Ff4cmA
   zYrBpbHqNSCi9FljAAkHwE+4EwQWJDRZmOADDc75WXxRGoVRA6DkGu84E
   Km1Ar6PhlUfsOdT5OSn2mOb3fcM7OAVbwzdUgGvsIBeWax5Y7rpinhOYs
   g==;
X-CSE-ConnectionGUID: njy+tY+QSn2d+X8uH5stkA==
X-CSE-MsgGUID: pobAabcBTbeNdalcN+bQ8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16128494"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="16128494"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 07:01:07 -0700
X-CSE-ConnectionGUID: AEVJG/+FScO24iHz6d5K0g==
X-CSE-MsgGUID: uM/pIAFTRDKAb24jQmdnyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="47787292"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Jun 2024 07:01:06 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sKep5-0008dR-2U;
	Fri, 21 Jun 2024 14:01:03 +0000
Date: Fri, 21 Jun 2024 22:01:03 +0800
From: kernel test robot <lkp@intel.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: io_uring/notif.o: warning: objtool: unexpected relocation symbol
 type in .rela.discard.reachable
Message-ID: <202406212142.3Yo2Msds-lkp@intel.com>
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
commit: 6fe4220912d19152a26ce19713ab232f4263018d io_uring/notif: implement notification stacking
date:   9 weeks ago
config: loongarch-randconfig-r071-20240620 (https://download.01.org/0day-ci/archive/20240621/202406212142.3Yo2Msds-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240621/202406212142.3Yo2Msds-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406212142.3Yo2Msds-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> io_uring/notif.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

