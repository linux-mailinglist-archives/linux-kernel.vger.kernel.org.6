Return-Path: <linux-kernel+bounces-250320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C892F66D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0330B1F23ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33653140E58;
	Fri, 12 Jul 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UH1VUXf2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143FBE68
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770377; cv=none; b=Qg/AqJYRY8dbZFeoFjtoGZhLWbz/tRgLSQLR6b5hij83kHtsaDpS3U0/p36d/+6z2Xbtsml9ysQJUxt+v+X7r4lZiCpHfUTBneRDFVotlKTfEBZWIwHL/zeuP3ELGuHnxqCtAJFncByUpPlf4bwX/vuBkNSMfYCC2u89Sko7lWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770377; c=relaxed/simple;
	bh=YX7j78VLNzPW2wYMCt+KHgvkC89kIfvd3P2qlzl3kOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BZRRR5uNqeVxaBZfZ0ez14edAsTsbsMLs93906oq04SEHfIHl+GsV4/MY4p9WWhKLLxc3geGxMHkZkLxzO+ctSOSFVky2IOPrmVeIly4oea7EwGNZ77jOyP3IZ9MXTMcxYvnVAPUt21lLNW42W2vFDIs3OgWre6wKfw2bUHGDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UH1VUXf2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720770375; x=1752306375;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YX7j78VLNzPW2wYMCt+KHgvkC89kIfvd3P2qlzl3kOc=;
  b=UH1VUXf2yGsJsfDReP3AU+yEaxKcdHIUe05FT1sT7Hy2wz5flErMSOGf
   JqLCWs43SFf8J6MdWHSVt33EQGw0Hgj7Az9pI9aXaZmOlO9FzigJNKpIu
   YkMa8X7UOZwEuVUqem6BeR9GD6UlnxtKQH4yuQDLunBe1yp8OjnVquVk3
   MvVfkmXwctWSuUax4YaFLbRtKh4NL75XjgX8VJmP+GPbaaqNxd8SAHiSC
   lsv16Aa3z5ahhLKIKlcJlfiBj86guh9OsGfueUpLkb8HPY0b9l3SmgOTa
   qFtMk2QeXG4FqqeuYDVp8FNsPHMWMkauTgJHCg3AvvtXJtFaoDMiyjyiO
   Q==;
X-CSE-ConnectionGUID: fJV3POIMQ82SO2tMU84u4A==
X-CSE-MsgGUID: rd6vKsIBRpuy5SKRpkg9tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="28802279"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="28802279"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 00:46:15 -0700
X-CSE-ConnectionGUID: lusxwEWdQxSGr2pDSlUzQQ==
X-CSE-MsgGUID: SFg6/hAiQjSD5O+4Vdg8RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49599474"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Jul 2024 00:46:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sSAyp-000aVP-2M;
	Fri, 12 Jul 2024 07:46:11 +0000
Date: Fri, 12 Jul 2024 15:45:31 +0800
From: kernel test robot <lkp@intel.com>
To: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: ERROR: modpost: "xmb_manager_register"
 [drivers/misc/xilinx_tmr_manager.ko] undefined!
Message-ID: <202407121554.m95t606T-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   43db1e03c086ed20cc75808d3f45e780ec4ca26e
commit: f5ec7f54fdba7fef051c65e975612edf46d4934d drivers: misc: Add Support for TMR Manager
date:   1 year, 6 months ago
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240712/202407121554.m95t606T-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407121554.m95t606T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407121554.m95t606T-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xmb_manager_register" [drivers/misc/xilinx_tmr_manager.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

