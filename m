Return-Path: <linux-kernel+bounces-327680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A429B977991
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306061F26758
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036EF1BC9E0;
	Fri, 13 Sep 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/zMCV6Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D511BBBF5
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726212285; cv=none; b=H3q9ZC2dyPyaAUwvvxdUxVyy3LmdfPyvWmoHSfQpv0nmQht0RwSBOAaexn/sjSX8tn7XPxdELLHH8WTwTbgjUuUh0EzTbBcWtqzSwcru/PY12FnyqhSMZkwjCfVKRRcwsedunC5W1ihVnQ/Es4nBJZb+HdSi7HKbFPB2FPVZR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726212285; c=relaxed/simple;
	bh=cAJ2hc6styUeyvqM7IkmTg7zicHXIvNVTcF+iiLVlH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/9d6sm961OtWoyzCe9x3vRD2pKvC2XN/iw6psGo389bFK2rKbWGVDEuqU7iP/BpzOPRTDIuMQnVfl8mpA0Bsifas7OYH7iWhbT2lUPbEs/i6hjIvxLo4HXOA8UVsDF3BAf72tJVWeUO2rEp5eFlWsrnIzLPf42V3n5vVs8eEdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/zMCV6Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726212283; x=1757748283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cAJ2hc6styUeyvqM7IkmTg7zicHXIvNVTcF+iiLVlH0=;
  b=g/zMCV6Y3gnx94Flp4rGlYVlONYRPTG5Ae7dlttVVBeoFTpvku+30+ET
   w8ZOx6B9WKSrBPKnPCqWwVN8SbKg0vmNwFMSONJhplKfYs/3wthNUo41Z
   yPAxdOID5AQ00xn0nNk6Xz+XA6ep2sD78Aq30seKeEOSs9P/lwXseFG91
   zS1WqxpV++DpDyHbuaYb1ybzVUYrJ2Oy/yFjI368r5r3vz6SiDyrCdLML
   WxzYytd7nIWQtmqsgFa5PWJu6rRAEEL7pEEpsNubzU7SbgIXxL/AF8Vjb
   4sQH60djr8PEwYJ1Vun81/sjExhw+Yl6SAwiJgiZZONfod4QYD8JClEnw
   w==;
X-CSE-ConnectionGUID: JZpQ1QgcQw+X9NkwFR8Ydg==
X-CSE-MsgGUID: 1yzv85ZtS6OmnPE+7MZzjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="36449455"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="36449455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 00:24:42 -0700
X-CSE-ConnectionGUID: Ap6loFj6TAau8vbuXS7KOQ==
X-CSE-MsgGUID: fLxY4fpNQv2k4at0hR2Z6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72565824"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 13 Sep 2024 00:24:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp0fV-00068O-2s;
	Fri, 13 Sep 2024 07:24:37 +0000
Date: Fri, 13 Sep 2024 15:24:11 +0800
From: kernel test robot <lkp@intel.com>
To: Wu Bo <bo.wu@vivo.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net, Wu Bo <wubo.oduw@gmail.com>
Subject: Re: [PATCH v2 13/13] f2fs: implement inline tail forward recovery
Message-ID: <202409131549.6E5c04Zg-lkp@intel.com>
References: <57e1dbb2f348ab61cbc82be7161d788a08b5fbed.1726024117.git.bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e1dbb2f348ab61cbc82be7161d788a08b5fbed.1726024117.git.bo.wu@vivo.com>

Hi Wu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 67784a74e258a467225f0e68335df77acd67b7ab]

url:    https://github.com/intel-lab-lkp/linux/commits/Wu-Bo/f2fs-add-inline-tail-mount-option/20240911-114705
base:   67784a74e258a467225f0e68335df77acd67b7ab
patch link:    https://lore.kernel.org/r/57e1dbb2f348ab61cbc82be7161d788a08b5fbed.1726024117.git.bo.wu%40vivo.com
patch subject: [PATCH v2 13/13] f2fs: implement inline tail forward recovery
config: x86_64-randconfig-121-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131549.6E5c04Zg-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131549.6E5c04Zg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131549.6E5c04Zg-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/f2fs/inline.c:457:27: sparse: sparse: cast to restricted __le32

vim +457 fs/f2fs/inline.c

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
   428				ri && (le32_to_cpu(ri->i_flags) & F2FS_INLINE_TAIL)) {
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
 > 457		} else if (ri && (le32_to_cpu(ri->i_inline) & F2FS_INLINE_TAIL)) {
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

