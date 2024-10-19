Return-Path: <linux-kernel+bounces-372836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E89A4E07
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A2C1F22B6B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DABB20DF4;
	Sat, 19 Oct 2024 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1e4SB+O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F9DF44
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342838; cv=none; b=i/RzLKQmrZjRLadxyW42GHwZysXxf73Lqcz1q8ch4yvNEh+P2aMIIQi0Xw88Rg2eilV0V3FKjSa+fVb/W5iAAaxJfedQJvlUIpjHpLrxo1X3PgcJJ1nW1dKV2yhDeIpnS4uoF29zAEBFV82AYf9uqIc95huAOZU/BDsu2U0A8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342838; c=relaxed/simple;
	bh=m7W4fJEtIeyu8tniSEMGnCUSt9Skkxkp3RQMvF94rpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5JXxautW0y3YAdhSzP26Dv3W4AzDqojmSBCPKCcnjsdIF8/ZxxAnQ84ZSaG6HinVKpHQVGS7ekonznXrihRSlcTBuOP+H4acdBrVPVNNE8LNCvTg8psiD7uBYgbmkcsB3n3KCsaZ5xLoEbDWIVihHUyZGPfW2yF0Rexbn1kgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1e4SB+O; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729342836; x=1760878836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m7W4fJEtIeyu8tniSEMGnCUSt9Skkxkp3RQMvF94rpA=;
  b=C1e4SB+O0CE5b9vGdxz2LeqKnpK5klT7cZro+mxd9YCOu1F4sFv8f/y3
   n6+mBa/6Zzj5ggkCy729rcTGVDlJny2EyLJFvFFmjgZ2tTny7ujI6dCyq
   A44NscK5Y+SI+he5fdk9Qr9h5aby0N37xBB0FST3DHBF5O8Hzp1H505kT
   HLGxXNkPBn5aCIhR3m8pm0Gtn/BNGnAt/w0Nz/VE4OFz4a9LlvKInfAdw
   fgVuw52I+OpKyJ0+JypCXb7Iyd+/QpWpz4YKpsIuu23GI/sSyLlGIge4c
   eNIAFrwS6qVZE5dA6qBzDgynXJnEIBG2hOmNSeKzQSLT7gBCGlsYY7nNf
   Q==;
X-CSE-ConnectionGUID: cRxGiVDUScOZGLmo5VC8cg==
X-CSE-MsgGUID: IeAqyRHSSE+xgvJrrmwciA==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="40232725"
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="40232725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 06:00:35 -0700
X-CSE-ConnectionGUID: nRm6KXBBRZK57aaXZ94/mg==
X-CSE-MsgGUID: uZ4+rfKdTee/kSSABrapEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,216,1725346800"; 
   d="scan'208";a="116580650"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Oct 2024 06:00:33 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t294I-000P1B-2R;
	Sat, 19 Oct 2024 13:00:30 +0000
Date: Sat, 19 Oct 2024 20:59:56 +0800
From: kernel test robot <lkp@intel.com>
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>,
	jaegeuk@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: fix to convert log type to segment data type
 correctly
Message-ID: <202410192028.vIwx2fbN-lkp@intel.com>
References: <20241018092200.2792472-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018092200.2792472-1-chao@kernel.org>

Hi Chao,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev linus/master v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chao-Yu/f2fs-fix-to-convert-log-type-to-segment-data-type-correctly/20241018-172401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20241018092200.2792472-1-chao%40kernel.org
patch subject: [PATCH] f2fs: fix to convert log type to segment data type correctly
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241019/202410192028.vIwx2fbN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241019/202410192028.vIwx2fbN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410192028.vIwx2fbN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> fs/f2fs/segment.c:3818:38: warning: 'enum log_type' declared inside parameter list will not be visible outside of this definition or declaration
    3818 | static int log_type_to_seg_type(enum log_type type)
         |                                      ^~~~~~~~
>> fs/f2fs/segment.c:3818:47: error: parameter 1 ('type') has incomplete type
    3818 | static int log_type_to_seg_type(enum log_type type)
         |                                 ~~~~~~~~~~~~~~^~~~
>> fs/f2fs/segment.c:3818:12: error: function declaration isn't a prototype [-Werror=strict-prototypes]
    3818 | static int log_type_to_seg_type(enum log_type type)
         |            ^~~~~~~~~~~~~~~~~~~~
   fs/f2fs/segment.c: In function 'do_write_page':
>> fs/f2fs/segment.c:3843:14: error: variable 'type' has initializer but incomplete type
    3843 |         enum log_type type = __get_segment_type(fio);
         |              ^~~~~~~~
>> fs/f2fs/segment.c:3843:23: error: storage size of 'type' isn't known
    3843 |         enum log_type type = __get_segment_type(fio);
         |                       ^~~~
>> fs/f2fs/segment.c:3843:23: warning: unused variable 'type' [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +3818 fs/f2fs/segment.c

  3817	
> 3818	static int log_type_to_seg_type(enum log_type type)
  3819	{
  3820		int seg_type = CURSEG_COLD_DATA;
  3821	
  3822		switch (type) {
  3823		case CURSEG_HOT_DATA:
  3824		case CURSEG_WARM_DATA:
  3825		case CURSEG_COLD_DATA:
  3826		case CURSEG_HOT_NODE:
  3827		case CURSEG_WARM_NODE:
  3828		case CURSEG_COLD_NODE:
  3829			seg_type = (int)type;
  3830			break;
  3831		case CURSEG_COLD_DATA_PINNED:
  3832		case CURSEG_ALL_DATA_ATGC:
  3833			seg_type = CURSEG_COLD_DATA;
  3834			break;
  3835		default:
  3836			break;
  3837		}
  3838		return seg_type;
  3839	}
  3840	
  3841	static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
  3842	{
> 3843		enum log_type type = __get_segment_type(fio);
  3844		int seg_type = log_type_to_seg_type(type);
  3845		bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
  3846					seg_type == CURSEG_COLD_DATA);
  3847	
  3848		if (keep_order)
  3849			f2fs_down_read(&fio->sbi->io_order_lock);
  3850	
  3851		if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
  3852				&fio->new_blkaddr, sum, type, fio)) {
  3853			if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
  3854				fscrypt_finalize_bounce_page(&fio->encrypted_page);
  3855			end_page_writeback(fio->page);
  3856			if (f2fs_in_warm_node_list(fio->sbi, fio->page))
  3857				f2fs_del_fsync_node_entry(fio->sbi, fio->page);
  3858			goto out;
  3859		}
  3860		if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
  3861			f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
  3862	
  3863		/* writeout dirty page into bdev */
  3864		f2fs_submit_page_write(fio);
  3865	
  3866		f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
  3867	out:
  3868		if (keep_order)
  3869			f2fs_up_read(&fio->sbi->io_order_lock);
  3870	}
  3871	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

