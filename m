Return-Path: <linux-kernel+bounces-186980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B98CCB70
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27CEB21E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86C47F58;
	Thu, 23 May 2024 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnQjvLcQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC0512B15A;
	Thu, 23 May 2024 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716439141; cv=none; b=JQqfLgigdlbggHkCo3+ig/66+Cs0ippGAtUmYY+tssFLtRYyH21kBPKKx8hbfBf8ZQhcD+h3xAXqjyddIOm8b+W1Uq0B6ROMmedLH6mMpZQYM0hcdObEI0LCOZp+gOJCMSlcuy6E56vx9OY1eX2EW8S70LYGz3KLuX1qqQOtEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716439141; c=relaxed/simple;
	bh=pasGcSWoeKJOH4rGpXF4luseHwee+VNIn+nYF88RALs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTRdsOAyCkZ1918roR9zrtMnm9LGBv3dumh0mWuOIp3bK+7D3sSNZ+KCyOu+RoC4ZIvo8b9OXXb/FwAUSFhOJnNFNEZWGGCdk4+UGl6j98+04Hz0SMlhoAvxuZV/tUnQXre2Dl2Na0nlf2NnW0SiRqPzG18X6KOjC5AqehlmVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnQjvLcQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716439139; x=1747975139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pasGcSWoeKJOH4rGpXF4luseHwee+VNIn+nYF88RALs=;
  b=YnQjvLcQeqR2M97coLec2/Koo5ph7iFzyZDCZLMzvniC72bd2V09M2Yn
   t8mqruQuVdoHupV8sr3fzPLzHrpb3yaUTkq2dMnG9w5ea5cufkLTCua1x
   D7YJ7qS3rFnTP6TvnM/P7qU/fv+jIMW1atPRtUIWl5WhKIu0kl4KAEgTH
   qdSSeIgGAZY4GyyVX9QbkmzbPFetEA8Ov9jvyzEXUWItJ4z4O0bMsVIMC
   rVUxvyDFH5Y1bGShMdVnulCHSz8H0HRDqhFdW1/bt69t0qv+Xsuha2rwc
   Nn56KvWrrLkRmoACDH12zOg7foIDrtbBFVisgGaZ+wNyvvWFcSXQS9fVS
   w==;
X-CSE-ConnectionGUID: bX3S/NWyTK+7n8zsNt1c3A==
X-CSE-MsgGUID: xwZ1L5ZdReu2JuK4Z1MPHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12564134"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12564134"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 21:38:58 -0700
X-CSE-ConnectionGUID: qPGFOeH2RWSTGIHPcy5JvA==
X-CSE-MsgGUID: da48y4KIRZyLlv1VKqSBbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33366860"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 22 May 2024 21:38:56 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA0E9-0002SP-1d;
	Thu, 23 May 2024 04:38:53 +0000
Date: Thu, 23 May 2024 12:37:59 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH 1/2] drivers: hwmon: max31827: Add PEC support
Message-ID: <202405231257.IOuSANzt-lkp@intel.com>
References: <20240522123923.22320-2-radu.sabau@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522123923.22320-2-radu.sabau@analog.com>

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v6.9 next-20240523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau/drivers-hwmon-max31827-Add-PEC-support/20240523-004248
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20240522123923.22320-2-radu.sabau%40analog.com
patch subject: [PATCH 1/2] drivers: hwmon: max31827: Add PEC support
config: i386-buildonly-randconfig-003-20240523 (https://download.01.org/0day-ci/archive/20240523/202405231257.IOuSANzt-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240523/202405231257.IOuSANzt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405231257.IOuSANzt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hwmon/max31827.c:727:3: error: field designator 'probe_new' does not refer to any field in type 'struct i2c_driver'
     727 |         .probe_new = max31827_probe,
         |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +727 drivers/hwmon/max31827.c

   720	
   721	static struct i2c_driver max31827_driver = {
   722		.class = I2C_CLASS_HWMON,
   723		.driver = {
   724			.name = "max31827",
   725			.of_match_table = max31827_of_match,
   726		},
 > 727		.probe_new = max31827_probe,
   728		.id_table = max31827_i2c_ids,
   729	};
   730	module_i2c_driver(max31827_driver);
   731	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

