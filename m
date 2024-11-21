Return-Path: <linux-kernel+bounces-416590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C19D4746
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 06:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A583B22C62
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8036419F47A;
	Thu, 21 Nov 2024 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1GQjjD/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7206146A68
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732166941; cv=none; b=OqMZfSrvjHy0FW9yqrwnZZkBqNpTVPefKGsbABTCDehQiXc3X3V1SO2xuXcntowGbCcBwQK51XpTaeFK5P8EaJDH05GqvWup7eNtPg7yZHsWBxEwDuU7kPx2M7ZrxD7y7iQcW+W1XydoKYGH4L4X5pjuooYuw00NVq3FXzQTmPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732166941; c=relaxed/simple;
	bh=8ohpPBomnM+jD+Au65m3SmNRZyP+0EO+SYd8k/FmxeA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U7D9Mj1Dxp3TzYRKCt1FhpsM9ZwhdFI0K7VAR/6h4dosMEsA8YFPxf1ivNcTPMaetg3w2XjOOdxUZd7fpmf/RGdl1P2KSjfXN148MQ+ZWhvFSVOMRBKXN3fOZtLWUWd54J53iKg/Jmc8Nn4tFWSu555+5Ip/YBVC5787pzgxkxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1GQjjD/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732166940; x=1763702940;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8ohpPBomnM+jD+Au65m3SmNRZyP+0EO+SYd8k/FmxeA=;
  b=Z1GQjjD/ZQCj0kRQEwmGOdocCzT1V/LaRp/nVK0AcyMN24PVZCXSHgXy
   WZa2fMEujl1dAI0VSHun7ckt7rHhMjetRQGDz9gxgEOJEBED3tLBnbACQ
   5+ERHxur/43LPND1kRYUDfBYFHLFtWEqbZTw0L06AQ8Bnpw640o/gCmBB
   67qSjAis3LlfEWAt6EJ8sOV6Q+upYIeexrkJHPqPQ8P70R2bTN93hH6kv
   vt4DI2zzhyJrE+UL1x86jrv24zXEJ8cMfSHTBItY6KckfG0/rDsKVqXbU
   CP97lW5tI3xkLHqyXeaeICqs/0VqSK8raYYMZgR8h0SbEvk0XNV1jXY8/
   Q==;
X-CSE-ConnectionGUID: a3BDkfckSWSs+yB57PA+cw==
X-CSE-MsgGUID: aYxG30PjRMiMu1KTVy709A==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="32313431"
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="32313431"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 21:28:59 -0800
X-CSE-ConnectionGUID: U+3IgghjTkSEBqS4uF1LnQ==
X-CSE-MsgGUID: Q9eC276VSemWuDdcl5hSDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,171,1728975600"; 
   d="scan'208";a="121087406"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Nov 2024 21:28:58 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDzkO-0002If-0v;
	Thu, 21 Nov 2024 05:28:56 +0000
Date: Thu, 21 Nov 2024 13:28:50 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/register.c:553:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202411211339.6Gskqqs6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
commit: c43203154d8ac579537aa0c7802b77d463b1f53a io_uring/register: move io_uring_register(2) related code to register.c
date:   11 months ago
config: s390-randconfig-r133-20241121 (https://download.01.org/0day-ci/archive/20241121/202411211339.6Gskqqs6-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241121/202411211339.6Gskqqs6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411211339.6Gskqqs6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   io_uring/register.c: note: in included file:
   include/linux/io_uring_types.h:341:48: sparse: sparse: array of flexible structures
   io_uring/register.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false
>> io_uring/register.c:553:1: sparse: sparse: Using plain integer as NULL pointer
>> io_uring/register.c:553:1: sparse: sparse: Using plain integer as NULL pointer

vim +553 io_uring/register.c

   552	
 > 553	SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

