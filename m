Return-Path: <linux-kernel+bounces-428453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C89E0EAD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849781656A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32E1E0DE1;
	Mon,  2 Dec 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERP9yDVO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8341E0DDA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177262; cv=none; b=PUx/AzOVIYsHLNwaLEc3SsblsxaBs4M9rj7TBH7ov0gk15n3wcJpk57dAXYa9j9VgmvifOCyRk0Pqf7HBEO1S0yepdkVbuFknHt+JwFAZpII0SzFASyQj0VyqBWwQbVcxGcz+5DbuKD8HT1c5Lt2bgQ8UxHopbIAhzP+VsZIygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177262; c=relaxed/simple;
	bh=/7uOvTHO15DE4mt5obi8ozfgCwJ7keTUXgu3dpCOCGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUuKDD9N5L2vYM3bx/H44BeQIGr3iAztCi3AtDnKK69W0K3wQCGEI5ShMGjL11G8i9Fi9msPvZ1A0OsNJRtaO3/FvDA7yH6qFcMclvGr4qQfmZsHnzPjRl/eaxgA/OAUucVcZmmZmCc6jefH6vAaD3LnQAG/ndwk2RH5QnXX26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERP9yDVO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733177260; x=1764713260;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/7uOvTHO15DE4mt5obi8ozfgCwJ7keTUXgu3dpCOCGw=;
  b=ERP9yDVOVQ3+ABs8sfGG0Aa3Hd8iyifMp9pvwUdBP9/rjrMT5USh4N67
   FS1aqOKFdZDwbN+92t5DRoA+V+OQQj7Q3oVPQD7Ky5hkkI3xlQybYQL8i
   aF99QIKA9IkOFhY6IuprVeTCKudUD9LJ97x9j5WSsaP6LbpuIkOOypieL
   2i0uzOqigU124bJhTTgI+Dg0rW5SfvzkHugMBJ2wUwMsWde7JN/TIu+7N
   1fLCzddvkU7eynPZv3RFJidoXQ4j0ibwQC3yEqYGVs3AfOq9YIvsUg0kB
   1zCzN3OyAYK2EUfAjVeT6MhpRiwEAaN84ll7mfjLNDNmYS3KOreWPOMB/
   Q==;
X-CSE-ConnectionGUID: n3QVjsMGRd6wdO1whRwAmQ==
X-CSE-MsgGUID: VtqCEpiXS5mmFk4Kwm1nyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33295916"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33295916"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 14:07:40 -0800
X-CSE-ConnectionGUID: +hVLYfDWS2a+a036nLZKFA==
X-CSE-MsgGUID: DAbXJg+5QAKTVpTmxF/TxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="98009834"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 02 Dec 2024 14:07:37 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIEZr-0002wv-0X;
	Mon, 02 Dec 2024 22:07:35 +0000
Date: Tue, 3 Dec 2024 06:07:03 +0800
From: kernel test robot <lkp@intel.com>
To: Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, Muchun Song <muchun.song@linux.dev>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	linux-kernel@vger.kernel.org,
	Frank van der Linden <fvdl@google.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
Message-ID: <202412030519.W14yll4e-lkp@intel.com>
References: <20241202202058.3249628-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202202058.3249628-1-fvdl@google.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.12]
[cannot apply to akpm-mm/mm-everything brauner-vfs/vfs.all linus/master v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-van-der-Linden/mm-hugetlb-optionally-pre-zero-hugetlb-pages/20241203-042817
base:   v6.12
patch link:    https://lore.kernel.org/r/20241202202058.3249628-1-fvdl%40google.com
patch subject: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
config: powerpc-ps3_defconfig (https://download.01.org/0day-ci/archive/20241203/202412030519.W14yll4e-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030519.W14yll4e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030519.W14yll4e-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/hugetlb.c: In function 'prezero_enabled_store':
>> mm/hugetlb.c:4290:13: warning: variable 'err' set but not used [-Wunused-but-set-variable]
    4290 |         int err;
         |             ^~~


vim +/err +4290 mm/hugetlb.c

  4284	
  4285	static ssize_t prezero_enabled_store(struct kobject *kobj,
  4286						  struct kobj_attribute *attr,
  4287						  const char *buf, size_t count)
  4288	{
  4289		struct hstate *h;
> 4290		int err;
  4291		long val;
  4292		bool prezero_enabled;
  4293	
  4294		err = kstrtol(buf, 10, &val);
  4295		if (val != 0 && val != 1)
  4296			return -EINVAL;
  4297	
  4298		prezero_enabled = !!val;
  4299	
  4300		h = kobj_to_hstate(kobj, NULL);
  4301		if (prezero_enabled == h->prezero_enabled)
  4302			return count;
  4303	
  4304		h->prezero_enabled = prezero_enabled;
  4305	
  4306		mem_hotplug_begin();
  4307		khzerod_run_hstate(h);
  4308		mem_hotplug_done();
  4309	
  4310		return count;
  4311	}
  4312	HSTATE_ATTR(prezero_enabled);
  4313	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

