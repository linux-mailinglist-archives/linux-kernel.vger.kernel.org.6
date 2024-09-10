Return-Path: <linux-kernel+bounces-322257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324EE972660
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 02:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B19285E11
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331617640D;
	Tue, 10 Sep 2024 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLKbcy/s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D86A332
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725929480; cv=none; b=BpFGbbN/ITcDMkvVqIRZSaEhrtdWbOI/K2PWuoi4XaOzODzqBHv8AZxq/43NzQUaFjigNDBdKLvAAXtDWRRqyQjLr9ghhT7Q9TunQnJo37/234hVbb7PvYBvLzjM4XqNgnOcO3wdclyCHP9/HvZ0qA7pWBHfRHeVAIlHv7/1U4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725929480; c=relaxed/simple;
	bh=x5FMIUov/6DOEU1HnQcCBMZArJqHczQ+VMg/GPovUD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HGQ/X7XtQT57eiGbqR05IMM8gqt42J0rPruFcHuHH31jPU8U9gmuA0v/3fKi3eeM9Ksab0k4wjvqx7V/nNDZB36QaKcbN6GIrUxtwWZpiCR360hs7Pkgwp1qnG4fbB72txUUTsZ04aGInTbS3wsdsZ+WtEf16qWouDXxBEv61QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLKbcy/s; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725929479; x=1757465479;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x5FMIUov/6DOEU1HnQcCBMZArJqHczQ+VMg/GPovUD8=;
  b=FLKbcy/sAear4/S+qKiogPVtOI6N+wcUG6uK9rnd9atRIz4OIdU48Is3
   EaIrF5Q9Yn1s3dGxiF2gwBPl5F0lpjzGEsnsR4sPa4zpf+avXsOJ6ZAwU
   FBshjoBiaPDOTdKz39BnpNBvrnZLICu46mpOh5ypoOnJD0jLVZnoAz3G2
   /cgYzsgajjkiqsU7OhMwF2iSOgIP4gMn7cHtmkSBUkmCJNMZMtOGXjvxu
   C5dCUqY67rhSt+aRzkh/Nr3pGERaV40qHURhkUcHCYay8QKKOd2yZg4FN
   fEpMbnEDgJO/EAOJeVk7ibwYRKEGo0Ag5+k01qb6lD9ys2kr7ptK6mYX8
   A==;
X-CSE-ConnectionGUID: S8nDd1OuSNawBZGJw3no9w==
X-CSE-MsgGUID: Daxff+9UQjelKuFytTkikQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="28542728"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="28542728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 17:51:19 -0700
X-CSE-ConnectionGUID: bD2GGUYHT4++n2orLGJ44g==
X-CSE-MsgGUID: ibKMv0hNTF+iWkszYtUlmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="66798498"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 09 Sep 2024 17:51:17 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snp6B-000FPw-1B;
	Tue, 10 Sep 2024 00:51:15 +0000
Date: Tue, 10 Sep 2024 08:50:14 +0800
From: kernel test robot <lkp@intel.com>
To: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "xmb_manager_register"
 [drivers/misc/xilinx_tmr_manager.ko] undefined!
Message-ID: <202409100844.5dIzksa3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Appana,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bc83b4d1f08695e85e85d36f7b803da58010161d
commit: f5ec7f54fdba7fef051c65e975612edf46d4934d drivers: misc: Add Support for TMR Manager
date:   1 year, 8 months ago
config: microblaze-randconfig-r052-20240909 (https://download.01.org/0day-ci/archive/20240910/202409100844.5dIzksa3-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100844.5dIzksa3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409100844.5dIzksa3-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xmb_manager_register" [drivers/misc/xilinx_tmr_manager.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

