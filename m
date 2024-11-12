Return-Path: <linux-kernel+bounces-405690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 746D49C558E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0ADFB3D309
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B9922EE76;
	Tue, 12 Nov 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gQzABO/8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E622EE46
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407967; cv=none; b=GIDWPg+IruElbxM8Qiombo2aDQIykp5OQxcnOaGhCyWUXtu76cj56trAVAb9ijiD7smQTjkimlBZ2mAXwygf9FaebEAezr/McUI9WznBzmMmUpD9sYbFFhUef7zshuPhDW0u2+W2/ioz56gpFRDoWUStUhq2aN1EK1Z905J6qOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407967; c=relaxed/simple;
	bh=TnIiOnF1wqFWtB0GnZGUgThTMXjgr7lgvOJgh9Y2oHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUIknM+SzR8EsotI5yL3ucQCAcfnysUupBhBhSJu8kwNeOXnVaJ+bb3/siR+ATX3nNiCZ2m6A/Xv8V6iTkZrPMKG3WTepZ3wy6p8OveQRfHILEE4Xsy68w1ulL8qhke6U/Q1hDaArQZFNwj/VT85AkTGyAPGtbnR6xoiVlXj6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gQzABO/8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731407966; x=1762943966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TnIiOnF1wqFWtB0GnZGUgThTMXjgr7lgvOJgh9Y2oHg=;
  b=gQzABO/8vEj616KfWU2zlPrzIo+hhBSV/Ig6p2KDjjPmTu3tLXxpy/5F
   QXNyj6zZWIUhKAzANShf+0DUkg3Klch4f1Y7MNd9BFmzRQyvbe5T1GiW/
   CmQnE+Fvn5+kDr10F3rqq5iESyetYQA9W7N8h+p1W2SAp4v8zY9W5ty3Q
   yf/vcdNEaRMu/axlAVEUYkvt38Kg0dNu/V19VdD5hAkYoeJyBU6WVRC6c
   mODoqPDl8LSP1aVTPqrQ8k3n3QRDm2q1rFocTw0SGx31UUOhk94h2p5jg
   W7djTdjJH8q2l7vkA/8tpjBG4jDDHoaKgz4J6n9p+9KnqFgscwajWxLzF
   g==;
X-CSE-ConnectionGUID: hEVeL0fkTNStGA748c9R+g==
X-CSE-MsgGUID: C7eln1dVT2uBEylj1Znw/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11253"; a="42638699"
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="42638699"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:39:26 -0800
X-CSE-ConnectionGUID: GOV0UJudRiCoMrOT7nhCSg==
X-CSE-MsgGUID: l9tSmif+Q7StVA/pjNrGTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="91412084"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 12 Nov 2024 02:39:22 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAoIq-0000tx-1t;
	Tue, 12 Nov 2024 10:39:20 +0000
Date: Tue, 12 Nov 2024 18:39:10 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: clean up the cache if cached decompression is
 disabled
Message-ID: <202411121801.vd2yHEHx-lkp@intel.com>
References: <20241112031513.528474-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112031513.528474-1-guochunhai@vivo.com>

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.12-rc7 next-20241112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-clean-up-the-cache-if-cached-decompression-is-disabled/20241112-105927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20241112031513.528474-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: clean up the cache if cached decompression is disabled
config: x86_64-randconfig-161-20241112 (https://download.01.org/0day-ci/archive/20241112/202411121801.vd2yHEHx-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121801.vd2yHEHx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121801.vd2yHEHx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/seq_file.h:9,
                    from fs/erofs/super.c:8:
   fs/erofs/super.c: In function 'erofs_fc_reconfigure':
>> fs/erofs/super.c:749:32: error: 'struct erofs_sb_info' has no member named 'umount_mutex'
     749 |                 mutex_lock(&sbi->umount_mutex);
         |                                ^~
   include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
     166 | #define mutex_lock(lock) mutex_lock_nested(lock, 0)
         |                                            ^~~~
>> fs/erofs/super.c:750:17: error: implicit declaration of function 'z_erofs_shrink_scan' [-Werror=implicit-function-declaration]
     750 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^~~~~~~~~~~~~~~~~~~
   fs/erofs/super.c:751:34: error: 'struct erofs_sb_info' has no member named 'umount_mutex'
     751 |                 mutex_unlock(&sbi->umount_mutex);
         |                                  ^~
   cc1: some warnings being treated as errors


vim +749 fs/erofs/super.c

   731	
   732	static int erofs_fc_reconfigure(struct fs_context *fc)
   733	{
   734		struct super_block *sb = fc->root->d_sb;
   735		struct erofs_sb_info *sbi = EROFS_SB(sb);
   736		struct erofs_sb_info *new_sbi = fc->s_fs_info;
   737	
   738		DBG_BUGON(!sb_rdonly(sb));
   739	
   740		if (new_sbi->fsid || new_sbi->domain_id)
   741			erofs_info(sb, "ignoring reconfiguration for fsid|domain_id.");
   742	
   743		if (test_opt(&new_sbi->opt, POSIX_ACL))
   744			fc->sb_flags |= SB_POSIXACL;
   745		else
   746			fc->sb_flags &= ~SB_POSIXACL;
   747	
   748		if (new_sbi->opt.cache_strategy == EROFS_ZIP_CACHE_DISABLED) {
 > 749			mutex_lock(&sbi->umount_mutex);
 > 750			z_erofs_shrink_scan(sbi, ~0UL);
   751			mutex_unlock(&sbi->umount_mutex);
   752		}
   753		sbi->opt = new_sbi->opt;
   754	
   755		fc->sb_flags |= SB_RDONLY;
   756		return 0;
   757	}
   758	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

