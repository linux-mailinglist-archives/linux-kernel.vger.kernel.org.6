Return-Path: <linux-kernel+bounces-313931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA64E96AC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726CA282CBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E7A1D58B9;
	Tue,  3 Sep 2024 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qcar98zr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F91EC01F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403664; cv=none; b=iewoEBj2/5vSLWkqlj9pCqp9Z6DGFBHKavAMAQvkeGGzp11dQqezPLYH97Xzlo1HzG7T6eBMToNVXXp6QA1Uwf1+Mi6SbSgbiXSka7SUaVnz9GQ6QhuL7aITPNmgpwEWBu6fDSric4MWPlfTJuTO3FdEuYKKAGsNXZu5OB8fHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403664; c=relaxed/simple;
	bh=iO/fNMW/wiTNAaqtQ6ViRfRRPRXDsdCIOiMd8CyEKww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6d0f4Y3/qiGlRD45ioN1A4sAk5dsIkeHHIrvs2VYfiyYi2Um9H39+x2tYOjcIZVuV7sUDTDK/Ttcn8nI0tpP7GoJYK5ZlJ440C795gRdKjGqgNtv4FdMJT0TlEe/pG4iRwHAThs2RvEDW/bV1O+25vJOMv0TvEKTZa0krgzAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qcar98zr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725403661; x=1756939661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iO/fNMW/wiTNAaqtQ6ViRfRRPRXDsdCIOiMd8CyEKww=;
  b=Qcar98zrLlG7CmPhXQI/+xwPhr4U8oAJg7LkvUl7grgTD2GPQGcLcnAT
   TBxG893yNBLQg1WZLpgZ30w10td0rIEmioXd6EuUMrtycRsnXhWX3gISp
   RabTaJyp3HtMqiT07Nl59e3Xr6r5G5cszR8WXq765Uke2eJxLuzFdjvu5
   1iDy3QgcJ6LkUBQJyo1uQeI2XaAas+9nkzvCeh5NvoqjLxzZvhdqrUuqC
   4GiwKO5OCXpcQz3SOzyep6HjrKxpfMCGMjLfw7gyr4+ppUxLsvdBzG4wU
   tejjrpLmfmTzbU+k7mlsnu+jxilIVqgkoULMNRIdxVcg0oQ1LA5iK1JYV
   g==;
X-CSE-ConnectionGUID: zWiqcIWDTyijamZhWyM+CQ==
X-CSE-MsgGUID: O1VNVLLvSUyF0PIgRcsV6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34637219"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="34637219"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 15:47:40 -0700
X-CSE-ConnectionGUID: qDXGN2SpRcmbs2Z1fHbSoA==
X-CSE-MsgGUID: 7jsQSHVFTSO3IMmq2uCzug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="69223688"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2024 15:47:38 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slcJD-0007JK-3D;
	Tue, 03 Sep 2024 22:47:35 +0000
Date: Wed, 4 Sep 2024 06:47:13 +0800
From: kernel test robot <lkp@intel.com>
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Wu Bo <wubo.oduw@gmail.com>
Subject: Re: [PATCH 13/13] f2fs: implement inline tail forward recovery
Message-ID: <202409040652.Gn2vQXRR-lkp@intel.com>
References: <b6e9e02244cf2460df1256e257103e2c77fae2a9.1725334811.git.bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e9e02244cf2460df1256e257103e2c77fae2a9.1725334811.git.bo.wu@vivo.com>

Hi Wu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.11-rc6]
[also build test WARNING on linus/master]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wu-Bo/f2fs-add-inline-tail-mount-option/20240903-164436
base:   v6.11-rc6
patch link:    https://lore.kernel.org/r/b6e9e02244cf2460df1256e257103e2c77fae2a9.1725334811.git.bo.wu%40vivo.com
patch subject: [PATCH 13/13] f2fs: implement inline tail forward recovery
config: arc-randconfig-r112-20240903 (https://download.01.org/0day-ci/archive/20240904/202409040652.Gn2vQXRR-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240904/202409040652.Gn2vQXRR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040652.Gn2vQXRR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/f2fs/inline.c:428:34: sparse: sparse: restricted __le32 degrades to integer

vim +428 fs/f2fs/inline.c

   416	
   417	int f2fs_recover_inline_tail(struct inode *inode, struct page *npage)
   418	{
   419		struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
   420		struct f2fs_inode *ri = NULL;
   421		void *src_addr, *dst_addr;
   422		struct page *ipage;
   423	
   424		if (IS_INODE(npage))
   425			ri = F2FS_INODE(npage);
   426	
   427		if (f2fs_has_inline_tail(inode) &&
 > 428				ri && (ri->i_flags & F2FS_INLINE_TAIL)) {
   429	process_inline:
   430			if (!(ri->i_inline & F2FS_DATA_EXIST))
   431				return 0;
   432	
   433			ipage = f2fs_get_node_page(sbi, inode->i_ino);
   434			if (IS_ERR(ipage))
   435				return PTR_ERR(ipage);
   436	
   437			f2fs_wait_on_page_writeback(ipage, NODE, true, true);
   438	
   439			src_addr = inline_data_addr(inode, npage);
   440			dst_addr = inline_data_addr(inode, ipage);
   441			memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
   442	
   443			set_inode_flag(inode, FI_DATA_EXIST);
   444	
   445			set_page_dirty(ipage);
   446			f2fs_put_page(ipage, 1);
   447			return 0;
   448		}
   449	
   450		if (f2fs_has_inline_tail(inode)) {
   451			ipage = f2fs_get_node_page(sbi, inode->i_ino);
   452			if (IS_ERR(ipage))
   453				return PTR_ERR(ipage);
   454			f2fs_truncate_inline_inode(inode, ipage, 0);
   455			clear_inode_flag(inode, FI_INLINE_TAIL);
   456			f2fs_put_page(ipage, 1);
   457		} else if (ri && (ri->i_inline & F2FS_INLINE_TAIL)) {
   458			int ret;
   459	
   460			ret = f2fs_truncate_blocks(inode,
   461					COMPACT_ADDRS_PER_INODE >> PAGE_SHIFT, false);
   462			if (ret)
   463				return ret;
   464			goto process_inline;
   465		}
   466		return 0;
   467	}
   468	struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
   469						const struct f2fs_filename *fname,
   470						struct page **res_page)
   471	{
   472		struct f2fs_sb_info *sbi = F2FS_SB(dir->i_sb);
   473		struct f2fs_dir_entry *de;
   474		struct f2fs_dentry_ptr d;
   475		struct page *ipage;
   476		void *inline_dentry;
   477	
   478		ipage = f2fs_get_node_page(sbi, dir->i_ino);
   479		if (IS_ERR(ipage)) {
   480			*res_page = ipage;
   481			return NULL;
   482		}
   483	
   484		inline_dentry = inline_data_addr(dir, ipage);
   485	
   486		make_dentry_ptr_inline(dir, &d, inline_dentry);
   487		de = f2fs_find_target_dentry(&d, fname, NULL);
   488		unlock_page(ipage);
   489		if (IS_ERR(de)) {
   490			*res_page = ERR_CAST(de);
   491			de = NULL;
   492		}
   493		if (de)
   494			*res_page = ipage;
   495		else
   496			f2fs_put_page(ipage, 0);
   497	
   498		return de;
   499	}
   500	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

