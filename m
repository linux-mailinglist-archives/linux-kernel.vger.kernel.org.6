Return-Path: <linux-kernel+bounces-406102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E119C5F64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47C9B8218A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968BA1FF050;
	Tue, 12 Nov 2024 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gw7suwbH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0252003A2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423143; cv=none; b=u190ziFFKMT9kt9eJMKEb2GKy0FtO8vVZ9NmpNEl0ZazxnPHl4abggypUY4VkDId8sHckHjKxftFdCBrBGSWAPSPhB4mGyZIcXD1nkODIupo6RvSUdLRaaQzIUFoRmMHKqarShcdCnzHig7gxb83bKlkLnbdpfuX0FW3wGiMj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423143; c=relaxed/simple;
	bh=XxmjXbd3NELFVsWVdW6o2Zxqx8IqBr4HxPuGWI6cATE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+DTR3Q0PrtxTUbLSXh9Z0+FkF36Vs+zmru1LfJDqVAvxuRK5a98cUWAec+5qx3tJHt52UZc8CzoNjqAFhb0uUKKfI5sV8cyVyOdDLzzfNS1AVhUonhWMnH0Q46OePDTduIob8+RSt2JhwtmmCVPbcwLzzzsAm7uO1zYOBkX6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gw7suwbH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731423141; x=1762959141;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XxmjXbd3NELFVsWVdW6o2Zxqx8IqBr4HxPuGWI6cATE=;
  b=gw7suwbHdWNPwD4yYfqvC7+3pp+IKU96UM6duCl6DHgHQNfcowfCz3NI
   3kSVS3AV7YxTQpOsdO89tdU7pljQQQdB4LeXu5oy09qFwzqDph3ok9ju4
   Hhg2pMhO6UXA0tWcsStvvkPiUU6FOSX5V6TC8xJZiyDBObwbohCFKiHJg
   3eZUeDMQzhk10FO/FtUn2cW5/ITEzxExf9mJAE3XqEzAg+oppu6qJVEE9
   xTZfQIy9IqwINe0dYSd1i4UzAKJHQ59plDFIDz1VP1sh0cIe6gPN4G8K/
   UB+/n4XLTRu1DsbzuVC7qz6TlA73iEmDjWa+zeKerw4OTafgtu1iRuj3r
   A==;
X-CSE-ConnectionGUID: 4R+CzlhOTZGK+2Vkv6FlUg==
X-CSE-MsgGUID: K7heGbiJQQG95rbbaVnb/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41885678"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41885678"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 06:52:20 -0800
X-CSE-ConnectionGUID: ckdD5CfLSzipX2yz0R4Ubw==
X-CSE-MsgGUID: f3iIhOODQomMGy2XCI5DuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87259015"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2024 06:52:17 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAsFb-0001RK-2e;
	Tue, 12 Nov 2024 14:52:15 +0000
Date: Tue, 12 Nov 2024 22:51:40 +0800
From: kernel test robot <lkp@intel.com>
To: Chunhai Guo <guochunhai@vivo.com>, xiang@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, chao@kernel.org, huyue2@coolpad.com,
	jefflexu@linux.alibaba.com, dhavale@google.com,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: Re: [PATCH] erofs: add sysfs node to drop all compression-related
 caches
Message-ID: <202411122209.OQ3CcFg1-lkp@intel.com>
References: <20241112091403.586545-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112091403.586545-1-guochunhai@vivo.com>

Hi Chunhai,

kernel test robot noticed the following build errors:

[auto build test ERROR on xiang-erofs/dev-test]
[also build test ERROR on xiang-erofs/dev xiang-erofs/fixes linus/master v6.12-rc7 next-20241112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chunhai-Guo/erofs-add-sysfs-node-to-drop-all-compression-related-caches/20241112-170412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
patch link:    https://lore.kernel.org/r/20241112091403.586545-1-guochunhai%40vivo.com
patch subject: [PATCH] erofs: add sysfs node to drop all compression-related caches
config: x86_64-randconfig-161-20241112 (https://download.01.org/0day-ci/archive/20241112/202411122209.OQ3CcFg1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411122209.OQ3CcFg1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411122209.OQ3CcFg1-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/erofs/sysfs.c: In function 'erofs_attr_store':
>> fs/erofs/sysfs.c:175:17: error: implicit declaration of function 'z_erofs_shrink_scan' [-Werror=implicit-function-declaration]
     175 |                 z_erofs_shrink_scan(sbi, ~0UL);
         |                 ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/z_erofs_shrink_scan +175 fs/erofs/sysfs.c

   132	
   133	static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
   134							const char *buf, size_t len)
   135	{
   136		struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
   137							s_kobj);
   138		struct erofs_attr *a = container_of(attr, struct erofs_attr, attr);
   139		unsigned char *ptr = __struct_ptr(sbi, a->struct_type, a->offset);
   140		unsigned long t;
   141		int ret;
   142	
   143		switch (a->attr_id) {
   144		case attr_pointer_ui:
   145			if (!ptr)
   146				return 0;
   147			ret = kstrtoul(skip_spaces(buf), 0, &t);
   148			if (ret)
   149				return ret;
   150			if (t != (unsigned int)t)
   151				return -ERANGE;
   152	#ifdef CONFIG_EROFS_FS_ZIP
   153			if (!strcmp(a->attr.name, "sync_decompress") &&
   154			    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
   155				return -EINVAL;
   156	#endif
   157			*(unsigned int *)ptr = t;
   158			return len;
   159		case attr_pointer_bool:
   160			if (!ptr)
   161				return 0;
   162			ret = kstrtoul(skip_spaces(buf), 0, &t);
   163			if (ret)
   164				return ret;
   165			if (t != 0 && t != 1)
   166				return -EINVAL;
   167			*(bool *)ptr = !!t;
   168			return len;
   169		case attr_drop_caches:
   170			ret = kstrtoul(skip_spaces(buf), 0, &t);
   171			if (ret)
   172				return ret;
   173			if (t != 1)
   174				return -EINVAL;
 > 175			z_erofs_shrink_scan(sbi, ~0UL);
   176			return len;
   177		}
   178		return 0;
   179	}
   180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

