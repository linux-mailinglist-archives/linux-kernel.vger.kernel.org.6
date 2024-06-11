Return-Path: <linux-kernel+bounces-209311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE9903259
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67249285A36
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7517164B;
	Tue, 11 Jun 2024 06:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvGPnqg1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E3171099
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086799; cv=none; b=BVxrOzX3tMNe7SIfsoiPmbIW4/BSE6hn5ehFTAW2zqcrEFc5rPjegpX/jP0dIn5EG4VmxHXVy2tkCegILTA1pIDNwU3/OcToQ+EbgZZfQDBv01Ey3JIAgIJIE9qMGZvncuLTKarxojHsPzitBB2h6E2By4rbAbtwLEzgPM+M0Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086799; c=relaxed/simple;
	bh=GTlbHv79HCUkR4bCyJN/xCE2y1H0lGUfX/kWCA8XoYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcWaYLW0EMhQs1iEeN66ZyWGsCSvLvgKQQUsWIHa6MUFHFUc+Ysb0XUOeEgyDV0ppqZ+fQy7wiNVpXw78nsHmIa8U8JX6GTLIq1i5ruItSGZ6xp5cpl4qMwYiLfwJCAksDfiKoZgIowIzWpqfLyalKph4wYR1dnEkgxkZoKOyco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvGPnqg1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718086797; x=1749622797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GTlbHv79HCUkR4bCyJN/xCE2y1H0lGUfX/kWCA8XoYE=;
  b=EvGPnqg1aSu1/+Vp48RlEYzP07qjnwRhJ5u5kryakugPhyBm+pDLrQ8j
   fthdZOzKM/lXWBAznkoorOd7N5IuWsGkeNiIcGA/JiaDe6hCx7+1TDTw8
   ePrtOdoIEs42qGyMVnQkQghOl2B0ooJA+RHQ42+cQavWB1631HmK69BRJ
   e0JFcnJpioafuzgSq9conzMnFWnaNXGbEXwkWK5vbgP/iTpyra7GwGRPb
   MdFqmY2znSknQB5H0usYVCOxauXG1bZMsMeX9BSSbu5qC7yXUGzijL7U+
   yj2u8+5rbs+URgbcD8xqGzs7tdeZzr94gfZL8INWTEdD7FMXx93flhKmk
   A==;
X-CSE-ConnectionGUID: oFzhjUhCRnCLJNtUniYx9A==
X-CSE-MsgGUID: kUkX6dBkRKKhouXEM+lMfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="12012062"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="12012062"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 23:19:55 -0700
X-CSE-ConnectionGUID: aVccBOZbSdmLjP9VexFR6Q==
X-CSE-MsgGUID: nA+GciTgTKSR0/bc/6c12Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="39769427"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 10 Jun 2024 23:19:53 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGurH-000079-0u;
	Tue, 11 Jun 2024 06:19:51 +0000
Date: Tue, 11 Jun 2024 14:19:08 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	=?iso-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>
Subject: Re: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
Message-ID: <202406111410.gmDjiFQR-lkp@intel.com>
References: <20240610161133.156566-1-jose.souza@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610161133.156566-1-jose.souza@intel.com>

Hi José,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-xe/drm-xe-next]
[also build test ERROR on wireless/main linus/master v6.10-rc3 next-20240607]
[cannot apply to driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus wireless-next/main]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jos-Roberto-de-Souza/drm-xe-Increase-devcoredump-timeout/20240611-001400
base:   https://gitlab.freedesktop.org/drm/xe/kernel.git drm-xe-next
patch link:    https://lore.kernel.org/r/20240610161133.156566-1-jose.souza%40intel.com
patch subject: [PATCH v5 1/2] devcoredump: Add dev_coredumpm_timeout()
config: i386-buildonly-randconfig-004-20240611 (https://download.01.org/0day-ci/archive/20240611/202406111410.gmDjiFQR-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240611/202406111410.gmDjiFQR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406111410.gmDjiFQR-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: sound/soc/intel/avs/apl.o: in function `dev_coredumpm_timeout':
>> apl.c:(.text+0x64c): multiple definition of `dev_coredumpm_timeout'; sound/soc/intel/avs/skl.o:skl.c:(.text+0x2d0): first defined here
--
   In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c:26:0:
>> include/linux/devcoredump.h:79:6: error: no previous prototype for 'dev_coredumpm_timeout' [-Werror=missing-prototypes]
    void dev_coredumpm_timeout(struct device *dev, struct module *owner,
         ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

