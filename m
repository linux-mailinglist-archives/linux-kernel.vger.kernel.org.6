Return-Path: <linux-kernel+bounces-370920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275049A33C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5171C212F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B60165F1E;
	Fri, 18 Oct 2024 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhVikdMz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261220E32F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225567; cv=none; b=SwNzs27oXknNdkUWXXy4s5J4xd7dwlUcQozhP4jpGcKgSPabe1l+toNUONKSgMMiJGgkMnGnHBy97HI18HH+lYWWS9Z610ZogkCyUh4caCZEagutoUgPyeuPYW3xhsSxRQkUzzmaP4H65TpvPa+qaEKT8FsYNx982m8flf4QbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225567; c=relaxed/simple;
	bh=p0iT7hBYjaaENBP+xtEBga9hy1/7yCsh8edmWJnaTp4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PWDraWRodBezIdck+u5l/6LQ/0USLn1gF26h5IOkabtai67YMDWLtDmhkfzA1PHToCrLT3veJKL3rnBPQF3dP/xtPwLChzBEOBOXAq1xfua4cW1PncYFAhqI1q6LlG0gFbztjKNWs3yIdWh2nvpGDACDSbu8SRzWy34nAC5B808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhVikdMz; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729225565; x=1760761565;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p0iT7hBYjaaENBP+xtEBga9hy1/7yCsh8edmWJnaTp4=;
  b=HhVikdMzbdwJo8jwX8a1nxHY+aKn9dCd4ZjnCf6HFp+/KpDQtZcpffVJ
   woOSvlUYqNBXmtTjjzU1Z6QdzkOKO1GyoRIxrIopkhmTmvy+QLOy5V+sb
   NZT7GgtNqJgFtHHLiM9Lc4HhbVWQ1l7FyPf+S5YBp/x3WLWkZTnsf2mdR
   ztDCJeXbbilFuTgWB0Uzlyr0FU3ZEfs2MResQHEEbRoNv4vs6FSPA3Rph
   QreFRhMCTpdVR1EyNa6L5S61Qn7yJwN+V18oKru96M44CWG45pzleyzM8
   NZ51old3FLeKQsAtYd3It8pVdXlgpAn2Hk7hMvTxGPMQmIX3D2cE2kIbU
   g==;
X-CSE-ConnectionGUID: 3E6t2GpUTl+Q1QItze+FsA==
X-CSE-MsgGUID: BWg4V2F+QmuYxXODiDa3Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28703744"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28703744"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 21:26:05 -0700
X-CSE-ConnectionGUID: tdgb4isJQjyNpQFi0axRlw==
X-CSE-MsgGUID: XNNhvmWrTiKR4ZSI8CeF9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="82716055"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Oct 2024 21:26:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1eYs-000NGC-0S;
	Fri, 18 Oct 2024 04:26:02 +0000
Date: Fri, 18 Oct 2024 12:25:46 +0800
From: kernel test robot <lkp@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: io_uring/register.c:553:1: sparse: sparse: Using plain integer as
 NULL pointer
Message-ID: <202410181226.op9CSaKK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6efbea77b390604a7be7364583e19cd2d6a1291b
commit: c43203154d8ac579537aa0c7802b77d463b1f53a io_uring/register: move io_uring_register(2) related code to register.c
date:   10 months ago
config: s390-randconfig-r123-20241017 (https://download.01.org/0day-ci/archive/20241018/202410181226.op9CSaKK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241018/202410181226.op9CSaKK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181226.op9CSaKK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   io_uring/register.c: note: in included file:
   include/linux/io_uring_types.h:341:48: sparse: sparse: array of flexible structures
>> io_uring/register.c:553:1: sparse: sparse: Using plain integer as NULL pointer
>> io_uring/register.c:553:1: sparse: sparse: Using plain integer as NULL pointer

vim +553 io_uring/register.c

   552	
 > 553	SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

