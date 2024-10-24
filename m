Return-Path: <linux-kernel+bounces-379818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744489AE42A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3411D28513D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6411CFED9;
	Thu, 24 Oct 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UcOl0W+1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075A170853
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729770535; cv=none; b=Z3cLIDDCZ8CJmkxFYqKvIDfKR2rxiZ6CVUXXnPzEBH7UQJgqPM5BVItjDsheJePHZx7zLFQ98BAw3Acao6thbCzV/03uz6JtEWlks3vf9vcH1i1J6njiHEg3ZLkSJswrIgGwg9zgjnaJTW/DIsBBwXQD0b95kU+GhOnJ3lBzHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729770535; c=relaxed/simple;
	bh=U2nasN99oW5nE8o0v69Lu67J21k9hxMqZ1t8tlbUC9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTPVZ2k0MydJTnf0RmF+B5RLeRBSDHg6AptbPv1isEVYzZbKVKx4DWq4Lu2S8/257lTP12FLeK1zevE4iB4sjUjEtCLo0mMf8Wy5tY8Bzn2m1DS5RlRhj6Ylz9ps8OcX8FMMrFx4Ye04QY3ynBpH6xWUcgSEFIEpO8bhbudsdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UcOl0W+1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729770533; x=1761306533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U2nasN99oW5nE8o0v69Lu67J21k9hxMqZ1t8tlbUC9U=;
  b=UcOl0W+1jIYrki5NeeHwi6t1BtyKPfegw0XiQhMyh1PP+zP6PBr+mV4E
   mEm7V8PEWHeA6Q6RywtEkH2ZmM5wokEpTFqE6Fw4rcHhL4lvSiW4Lpr0b
   zLMjfNQje/osn43y1skMOpiks2Uh6BWASrGri/VckKgKUdZt5c4aJ7CjE
   NRVmVItLS6sasLln4EkFDPitCtmFIsyrdKSCUSpBWUAtYu/Ry0NrVglJI
   0gSLR2EaE2OBGMtYmcGiQhwn04KmfOUezVzqxZUBth2Usi5BRuoEt/x0w
   4dpWjaV5/xvqw+1cD0MI6EaW328YKlqBdFl91SNcE2oIrkRa+HGE50mzj
   A==;
X-CSE-ConnectionGUID: 0goZu/PgS5mBqpkbJLJE0Q==
X-CSE-MsgGUID: E5GiW8CUSAWLL3fWhqnYfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="29508678"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="29508678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 04:48:52 -0700
X-CSE-ConnectionGUID: cwIxLK5bSbmGFRxPN8yQlg==
X-CSE-MsgGUID: kJ2WMSqNTSuVQ45i4T+UCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="80489192"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Oct 2024 04:48:50 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3wKd-000WLw-31;
	Thu, 24 Oct 2024 11:48:47 +0000
Date: Thu, 24 Oct 2024 19:48:02 +0800
From: kernel test robot <lkp@intel.com>
To: Liad Peretz <liad.per@gmail.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
	bhe@redhat.com, hbathini@linux.ibm.com, yang.lee@linux.alibaba.com,
	david@redhat.com, liad.per@gmail.com
Subject: Re: [PATCH] Makefile: Remove unused filechk_cat
Message-ID: <202410241924.AdD9UHio-lkp@intel.com>
References: <20241023070611.67449-1-liad.per@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023070611.67449-1-liad.per@gmail.com>

Hi Liad,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.12-rc4 next-20241024]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liad-Peretz/Makefile-Remove-unused-filechk_cat/20241023-150726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241023070611.67449-1-liad.per%40gmail.com
patch subject: [PATCH] Makefile: Remove unused filechk_cat
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241024/202410241924.AdD9UHio-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241024/202410241924.AdD9UHio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410241924.AdD9UHio-lkp@intel.com/

All errors (new ones prefixed by >>):

>> /bin/bash: -c: line 1: syntax error near unexpected token `;'
>> /bin/bash: -c: line 1: `set -e; mkdir -p kernel/; trap "rm -f kernel/.tmp_config_data" EXIT; { ; } > kernel/.tmp_config_data; if [ ! -r kernel/config_data ] || ! cmp -s kernel/config_data kernel/.tmp_config_data; then echo '  UPD     kernel/config_data'; mv -f kernel/.tmp_config_data kernel/config_data; fi'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

