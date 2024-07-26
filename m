Return-Path: <linux-kernel+bounces-262747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943493CC22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0613F2828C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 00:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B76A3D;
	Fri, 26 Jul 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kuGGccCZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16263CB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 00:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954312; cv=none; b=msh6w54MbAI8MtYdanmUKGidNjQAirJPVIme+qjH2ykDzTcgGecrliL6gcMSwjDzKyOC2e8si3WkvN/zcvuxjqs2k8Abmfkzi6US5YKQCNzpG1pJQARnUZSn6Gi3paQ93UfG6BiRHPsNDnS9cQFFPYpvcs66AZXvwsye+t+gQIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954312; c=relaxed/simple;
	bh=13fVH2RsERPqjmIpy1ZU+vBArgrtv42VMumf4nLIMig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dpfl72OYAws0eJddLATyctw4XVcElKEmnPMFJ+5EYfOkymNmBBhaOO2I3KY6ZqwPaeHPRtTlaEGgzIFEfpZc2AmOPOqkJclUSZCoqkB7kjoMUtFS2F+GEhZ6kSzwwHSfuwn9u5nwj5kTkf8J6u/I2Xm75RGnlc1/91n7gLsyqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kuGGccCZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721954311; x=1753490311;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=13fVH2RsERPqjmIpy1ZU+vBArgrtv42VMumf4nLIMig=;
  b=kuGGccCZHpPtiyVVkTbsXY8n/IzsPcMUoRXB/HPzpDhAIobLQoFNRQLF
   CqTvpommL6n23wj/imAL9t2i6XgzF5SnSu41GAo8fRlPxpBMZI1EmVQTR
   Qdwq0feQEnDVx03DPSluAZcev9p7yNe0bHh9iKp64tray+guxMRNgngrk
   RsPXMe46HiYX7jkCW/pzPa6CBcbvbe7xT+RcOgClG+soikwIuqDD8UVki
   92tRZWauBo7M/FOjUY6SsXxw2tpTdksFOluygnpUpGN3pcyHeGFvuPF/q
   Dw/jCQdW0VO69ychOEabTwdHt0wkiICC2i9SquCroN2vN62s6hIb/DseE
   A==;
X-CSE-ConnectionGUID: zFO05+8DQ/uca1PKwyhmTQ==
X-CSE-MsgGUID: lOqK2/32Tg2D5bEPh8X13g==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="22645542"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="22645542"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 17:38:30 -0700
X-CSE-ConnectionGUID: TvxuR1WQQ7WsT8UFm0ivsQ==
X-CSE-MsgGUID: CT3uebsGQP+WfIWgfjCYPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="52774161"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Jul 2024 17:38:29 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sX8yZ-000odI-06;
	Fri, 26 Jul 2024 00:38:27 +0000
Date: Fri, 26 Jul 2024 08:38:21 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko]
 undefined!
Message-ID: <202407260828.NQM5BhqE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1722389b0d863056d78287a120a1d6cadb8d4f7b
commit: f73edc8951b2de515b5ecc8a357ccd47dd41077e kbuild: unify two modpost invocations
date:   1 year, 10 months ago
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240726/202407260828.NQM5BhqE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240726/202407260828.NQM5BhqE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407260828.NQM5BhqE-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

