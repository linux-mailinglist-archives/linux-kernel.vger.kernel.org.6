Return-Path: <linux-kernel+bounces-206894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96043900F67
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 05:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77DAB21C65
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 03:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD66DF4D;
	Sat,  8 Jun 2024 03:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCPpo9AN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D128F3
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717818731; cv=none; b=O9RS/3E0NZb38Rk/6FRGhqcn6v+G94oDAHWpY478jqOSLiP7l+s3j29EM9SSSyLHCudYNqZEISOPEG+I0uiVzpZS5bE4DlJhYK+c3XVA5SbvyDs3oQHmCPJG77Ns9jdkwizaA1w/N5AYl9ZwfO1bMYRFcqswTNoNSA8/J2NyMd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717818731; c=relaxed/simple;
	bh=6Cm+CgN11GfmM/yX8tcb2ymAxLaz7HWIhehqxPB568k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naP8hGnZIujLNfo984pUZ3Lx7fXVsMateYayIVxCvqRst8PswqAoO8gV0uS4/M3i04LJSedIqf4EA3yMTKAAsVQksSHTy0iWczimgZeNNUyRpGdJqiXgtvtEkPAfARtfjE/b0qy6a9/iWtnOkA/ZpLYuqD+uM21x7cGCkcHTADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCPpo9AN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717818728; x=1749354728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Cm+CgN11GfmM/yX8tcb2ymAxLaz7HWIhehqxPB568k=;
  b=kCPpo9ANMyxh012+WhBN8lqQQWSvMwpnyfSNuE2CMSocFRkK7jY9wyJB
   k1AUgYgcLs/1D5HTrLsZ5i5zGbqMRgHB9buaZrd7gHTia/iVxpubLWYBs
   f9Gf8/UBSwHBGRUc/EHi0f6aCN5EF6t5szUwWDXcXlsKPIrHAyoTPJ0Ch
   jM+1GW8Fg7dmAvQpLPCiqlCSIuBgx8ADDwsmM5dhlZBVXPHg0C5ugU1Ep
   qeCszLolJzfTERcq8skiL55Q51VH2pHfkn6TVT7yoZMmZ3f4CmrXfWMPM
   Ce43w8HHBTGjbvJCN8z85cyrCkJCotq2o5lfWjYOQqA+mAqNJ1GAP+Glu
   w==;
X-CSE-ConnectionGUID: DqMd1KbATLuLgpeQ8MYOnw==
X-CSE-MsgGUID: 3fZxICypQymKKtB7DjGabw==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="14396991"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="14396991"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 20:52:07 -0700
X-CSE-ConnectionGUID: PocEqOsSSZuzfGsnkzRjTw==
X-CSE-MsgGUID: Zf86QYu4R4+E8mvVViogMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="38462322"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Jun 2024 20:52:03 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFn7Z-0000wM-1I;
	Sat, 08 Jun 2024 03:52:01 +0000
Date: Sat, 8 Jun 2024 11:51:46 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>, Greg KH <greg@kroah.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
Message-ID: <202406081124.hYZYvBL0-lkp@intel.com>
References: <20240607122622.167228-2-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607122622.167228-2-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8a92980606e3585d72d510a03b59906e96755b8a]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240607-203154
base:   8a92980606e3585d72d510a03b59906e96755b8a
patch link:    https://lore.kernel.org/r/20240607122622.167228-2-coxu%40redhat.com
patch subject: [PATCH v5 1/7] kexec_file: allow to place kexec_buf randomly
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20240608/202406081124.hYZYvBL0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081124.hYZYvBL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081124.hYZYvBL0-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/kexec_file.c: In function 'locate_mem_hole_bottom_up':
>> kernel/kexec_file.c:504:17: error: 'struct kexec_buf' has no member named 'random'
     504 |         if (kbuf->random)
         |                 ^~
>> kernel/kexec_file.c:505:30: error: implicit declaration of function 'kexec_random_start' [-Werror=implicit-function-declaration]
     505 |                 temp_start = kexec_random_start(temp_start, end);
         |                              ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +504 kernel/kexec_file.c

   496	
   497	static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
   498					     struct kexec_buf *kbuf)
   499	{
   500		struct kimage *image = kbuf->image;
   501		unsigned long temp_start, temp_end;
   502	
   503		temp_start = max(start, kbuf->buf_min);
 > 504		if (kbuf->random)
 > 505			temp_start = kexec_random_start(temp_start, end);
   506	
   507		do {
   508			temp_start = ALIGN(temp_start, kbuf->buf_align);
   509			temp_end = temp_start + kbuf->memsz - 1;
   510	
   511			if (temp_end > end || temp_end > kbuf->buf_max)
   512				return 0;
   513			/*
   514			 * Make sure this does not conflict with any of existing
   515			 * segments
   516			 */
   517			if (kimage_is_destination_range(image, temp_start, temp_end)) {
   518				temp_start = temp_start + PAGE_SIZE;
   519				continue;
   520			}
   521	
   522			/* We found a suitable memory range */
   523			break;
   524		} while (1);
   525	
   526		/* If we are here, we found a suitable memory range */
   527		kbuf->mem = temp_start;
   528	
   529		/* Success, stop navigating through remaining System RAM ranges */
   530		return 1;
   531	}
   532	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

