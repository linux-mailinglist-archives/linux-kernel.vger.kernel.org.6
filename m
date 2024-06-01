Return-Path: <linux-kernel+bounces-197668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCC78D6DA3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEDA1F23269
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13202BE78;
	Sat,  1 Jun 2024 03:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cg93CBS7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A026FC7;
	Sat,  1 Jun 2024 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211683; cv=none; b=Evq2+La3zxFWozBEuc7jp4OmfBk6ET1MBbJ6KFviAHJuBLVN/DLU1qvBSQvoecLwzwGJLHkx143Ae6sXA/RJUtCbkwKXNMOHzs0wCe5u4dT9hRUfBvFhWPVbaKgoPSR46l9JYP4iiA8gkU4MxZCZ9HYLitc9EraracTSQFKxhzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211683; c=relaxed/simple;
	bh=c7E6ywWcouETEOz7X+m9V6ffY9O9cI6IapgRWonAuyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0sfjYD79LcdOwRGiFFVDFH6azIL7K9xsAQXj8XIT6/sUJNZghoXSOQNcDshJUhiaiw1qvMNVMMVLGZ9hQT5JM0F8bZ5x3IHhja+c+D6yK9TohLCHDZCG/rQaOR7b/qPyGdkMTsNvfgU5WBhxssiNa+mDHcMHsFu2Az+Z+FM3LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cg93CBS7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717211683; x=1748747683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c7E6ywWcouETEOz7X+m9V6ffY9O9cI6IapgRWonAuyw=;
  b=Cg93CBS7Knh5ciDwIwAOyGsoT/qg0/IW7TBy39bd8o4PAXypToyQXQwM
   hWx2gdFW5Vu5pj4hAHFQ9VFE6ifGjK368SJw16GrfDE7/qeACivht8zQY
   2/NDIPJrxKC0bUK645lhiez0ZGVf1yTEPvCwSEzxLj5wf1xE9rCH8t+zF
   ZPNhxyS7ZfeEOG9WW8jDstisoAXYOBEj2flgm87azHDaCFKETFCRnw1UN
   +WYoZrzD/9SgVFIaf3fGsaPAyO2oy86KeO0tj4j7MivzZIMYeZD3zS8TU
   iIybq4GVVHoLpPQ2WdacCyuSeIkpyP2PqCAOCidWqTyQ3h+X/2PPtgsYT
   w==;
X-CSE-ConnectionGUID: y5VKK6VYTuGN6acFqQJARw==
X-CSE-MsgGUID: IddRGVkvTv6c7AV/zB6X6w==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="24431270"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="24431270"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 20:14:42 -0700
X-CSE-ConnectionGUID: l2xz+gaVQ1Sp7xFZjbApEA==
X-CSE-MsgGUID: n7Eg6RluRgSRmWmZVdk4kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="73824285"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 31 May 2024 20:14:38 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDFCV-000IGn-2o;
	Sat, 01 Jun 2024 03:14:35 +0000
Date: Sat, 1 Jun 2024 11:02:50 +0800
From: kernel test robot <lkp@intel.com>
To: Simon Trimmer <simont@opensource.cirrus.com>, tiwai@suse.com
Cc: oe-kbuild-all@lists.linux.dev, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com, soyer@irl.hu, shenghao-ding@ti.com,
	kevin-lu@ti.com, baojun.xu@ti.com, kailang@realtek.com,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 4/7] ALSA: hda: hda_component: Introduce component parent
 structure
Message-ID: <202406011025.mzDXJJjz-lkp@intel.com>
References: <20240531151409.80284-5-simont@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531151409.80284-5-simont@opensource.cirrus.com>

Hi Simon,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tiwai-sound/for-next]
[also build test WARNING on tiwai-sound/for-linus linus/master v6.10-rc1 next-20240531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Simon-Trimmer/ALSA-hda-cs35l56-Component-should-be-unbound-before-deconstruction/20240531-231828
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
patch link:    https://lore.kernel.org/r/20240531151409.80284-5-simont%40opensource.cirrus.com
patch subject: [PATCH 4/7] ALSA: hda: hda_component: Introduce component parent structure
config: arm64-randconfig-001-20240601 (https://download.01.org/0day-ci/archive/20240601/202406011025.mzDXJJjz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011025.mzDXJJjz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011025.mzDXJJjz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   sound/pci/hda/hda_component.c: In function 'hda_component_manager_bind':
>> sound/pci/hda/hda_component.c:140:33: warning: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to dereference it? [-Wsizeof-pointer-memaccess]
     140 |         memset(parent, 0, sizeof(parent));
         |                                 ^


vim +140 sound/pci/hda/hda_component.c

   133	
   134	int hda_component_manager_bind(struct hda_codec *cdc,
   135				       struct hda_component_parent *parent)
   136	{
   137		int i;
   138	
   139		/* Init shared and component specific data */
 > 140		memset(parent, 0, sizeof(parent));
   141		for (i = 0; i < ARRAY_SIZE(parent->comps); i++)
   142			parent->comps[i].codec = cdc;
   143	
   144		return component_bind_all(hda_codec_dev(cdc), &parent->comps);
   145	}
   146	EXPORT_SYMBOL_NS_GPL(hda_component_manager_bind, SND_HDA_SCODEC_COMPONENT);
   147	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

