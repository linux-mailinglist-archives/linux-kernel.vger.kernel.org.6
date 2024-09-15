Return-Path: <linux-kernel+bounces-329947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6A9797DA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2973E281F43
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C6D1C9DEF;
	Sun, 15 Sep 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUteucF5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC731C9875
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726418637; cv=none; b=BwbJLwyyiOEYCXCBzgf+LqJX94X83GOWmLaZzfqde2pwrGNbulrNJd4HejwYCt4N9UhXnrqx630vaNhoqG6JvCalVjXhdBAY9tgq425PtzN3iW2HiUCH+xANBepPK7H/lVAHqL9IUjUU0ivVsAbe/ft+AvBsa7WXdlORbFMKPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726418637; c=relaxed/simple;
	bh=X+946g+pnrYm6n0oQwKXqGyu4C2TG/BJk84qgLd+hNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqxFMVDNOhunkQ8MlzxOSJ6BCn0S2oq9iex1SHIOBReS8HP0UrSXIIBayFHmMkphFlcjT0fkZFy9tPr+Y9dsj9c/0Vf5k4u61HbBOEeVVng2it38MK7Roy0P8yzBa7y3YJyD4LBmPdqt1C1S3U1lfipenRKyZfnnGoUb+EkOKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUteucF5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726418636; x=1757954636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+946g+pnrYm6n0oQwKXqGyu4C2TG/BJk84qgLd+hNU=;
  b=UUteucF5wxqCNfjnP4u9Yt7pqDsWaXBwfmRukocHwR35nqmjiIj9BrKv
   stUAT24H+cXZv9Pdq7+E22pm7KO3MY55/+eQcDZHr2qdzTipDHUSWcK9f
   CfUB7AXPqmZ5cjDU20HZkZgKDVHNAF0RpOrpnLEVieK3cO6DKSTynjJpR
   uv8XyxlNC8Gub4Z+g0mAoC6XaYOe/5DmtwUADfOYok/KJdZF6G1MULEYF
   gq0HUiq7AfAdS15oJdT++jsSBEBBifeg/NAJw9AYAu5eCghpnpxGHZNex
   946DmtadXcnBKMtLueRHlUEWCUXJnBEPPQG7/Pk69echaKBqhl+yte0Ux
   w==;
X-CSE-ConnectionGUID: IAdiTB1hRQSQBLBTDUymig==
X-CSE-MsgGUID: fT6R62TGQzGxVSrZGgoFCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="36641447"
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="36641447"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2024 09:43:55 -0700
X-CSE-ConnectionGUID: hAwCZOZdQfW7hAIWzPjx4g==
X-CSE-MsgGUID: wAoRu1pdROaiTGe7QtkSFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,231,1719903600"; 
   d="scan'208";a="68897856"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 15 Sep 2024 09:43:52 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1spsLl-0008qi-1x;
	Sun, 15 Sep 2024 16:43:49 +0000
Date: Mon, 16 Sep 2024 00:43:19 +0800
From: kernel test robot <lkp@intel.com>
To: yongli-oc <yongli-oc@zhaoxin.com>, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, boqun.feng@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, yongli@zhaoxin.com,
	louisqi@zhaoxin.com, cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
Subject: Re: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory
 prepare, assign and cleanup.
Message-ID: <202409160059.VIbC9G04-lkp@intel.com>
References: <20240914085327.32912-5-yongli-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914085327.32912-5-yongli-oc@zhaoxin.com>

Hi yongli-oc,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on akpm-mm/mm-nonmm-unstable linus/master v6.11-rc7 next-20240913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/yongli-oc/locking-osq_lock-The-Kconfig-for-dynamic-numa-aware-osq-lock/20240914-172336
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240914085327.32912-5-yongli-oc%40zhaoxin.com
patch subject: [PATCH 4/4] locking/osq_lock: The numa-aware lock memory prepare, assign and cleanup.
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240916/202409160059.VIbC9G04-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240916/202409160059.VIbC9G04-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409160059.VIbC9G04-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/locking/zx_numa.c:250:10: warning: variable 'left' set but not used [-Wunused-but-set-variable]
     250 |                                         u32 left = 0;
         |                                             ^
>> kernel/locking/zx_numa.c:375:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]
     375 |         int err = 0;
         |             ^
   2 warnings generated.


vim +/left +250 kernel/locking/zx_numa.c

   203	
   204	static void zx_numa_cleanup(struct work_struct *work)
   205	{
   206		int i = 0;
   207		int checktimes = 2;
   208	
   209		//reboot or power off state
   210		if (READ_ONCE(enable_zx_numa_osq_lock) == 0xf)
   211			return;
   212	
   213		if (atomic_read(&numa_count) == 0) {
   214			if (READ_ONCE(dynamic_enable) != 0)
   215				schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
   216			return;
   217		}
   218	
   219		for (i = 0; i < zx_numa_lock_total; i++) {
   220			int s = 0;
   221			u32 lockaddr = READ_ONCE(zx_numa_entry[i].lockaddr);
   222			u32 type = zx_numa_entry[i].type;
   223			struct _numa_lock *buf =  zx_numa_entry[i].numa_ptr;
   224			int nodes = 0;
   225	
   226			if (lockaddr == 0 || type == 3 || zx_numa_entry[i].idle == 0)
   227				continue;
   228			nodes = buf->numa_nodes;
   229			if (zx_numa_entry[i].idle < checktimes) {
   230	
   231				s = zx_check_numa_dynamic_locked(lockaddr, buf, 1);
   232				if (s != 0) {
   233					zx_numa_entry[i].idle = 1;
   234					continue;
   235				}
   236				zx_numa_entry[i].idle++;
   237			}
   238	
   239			if (zx_numa_entry[i].idle == checktimes) {
   240				zx_numa_lock_stopping(buf);
   241				zx_numa_entry[i].idle++;
   242	
   243			}
   244	
   245			if (zx_numa_entry[i].idle == checktimes+1) {
   246				while (1) {
   247					if (zx_numa_lock64_try_to_freeze(lockaddr, buf,
   248							i) == nodes + 1) {
   249						//all node has been locked
 > 250						u32 left = 0;
   251	
   252						left = atomic_dec_return(&numa_count);
   253						break;
   254					}
   255					cpu_relax(); cpu_relax();
   256					cpu_relax(); cpu_relax();
   257				}
   258			}
   259		}
   260		schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
   261	}
   262	
   263	static int create_numa_buffer_list(int clusters, int len)
   264	{
   265		int i = 0;
   266	
   267		for (i = 0; i < zx_numa_lock_total; i++) {
   268			struct _numa_lock *s = (struct _numa_lock *)kmem_cache_alloc(
   269					zx_numa_lock_cachep, GFP_KERNEL);
   270			if (!s) {
   271				while (i > 0) {
   272					kmem_cache_free(zx_numa_lock_cachep,
   273							zx_numa_entry[i-1].numa_ptr);
   274					i--;
   275				}
   276				return 0;
   277			}
   278			memset((char *)s, 0,
   279				len * L1_CACHE_BYTES * (clusters + NUMAEXPAND));
   280			numa_lock_init_data(s, clusters, NUMA_LOCKED_VAL, 0);
   281			zx_numa_entry[i].numa_ptr = s;
   282			zx_numa_entry[i].lockaddr = 0;
   283			zx_numa_entry[i].highaddr = 0;
   284			zx_numa_entry[i].idle = 0;
   285			zx_numa_entry[i].type = 0;
   286		}
   287	
   288		for (i = 0; i < zx_numa_lock_total; i++) {
   289			zx_numa_entry[i].index = i;
   290			list_add_tail(&(zx_numa_entry[i].list), &_zx_numa_lock_head);
   291		}
   292		return 1;
   293	}
   294	
   295	static int zx_numa_lock_init(int numa)
   296	{
   297		int align = max_t(int, L1_CACHE_BYTES, ARCH_MIN_TASKALIGN);
   298		int d = 0;
   299		int status = 0;
   300	
   301		atomic_set(&lockindex, 0);
   302		atomic_set(&numa_count, 0);
   303	
   304		if (sizeof(struct _numa_lock) & 0x3f)
   305			d = (int)((sizeof(struct _numa_lock) + L1_CACHE_BYTES) /
   306				  L1_CACHE_BYTES);
   307		else
   308			d = (int)(sizeof(struct _numa_lock) / L1_CACHE_BYTES);
   309	
   310		zx_numa_entry_cachep = kmem_cache_create(
   311			"zx_numa_entry",
   312			sizeof(struct _numa_buf) * zx_numa_lock_total, align,
   313			SLAB_PANIC | SLAB_ACCOUNT, NULL);
   314	
   315		zx_numa_lock_cachep = kmem_cache_create(
   316			"zx_numa_lock",
   317			d * L1_CACHE_BYTES * (numa + NUMAEXPAND), align,
   318			SLAB_PANIC | SLAB_ACCOUNT, NULL);
   319	
   320	
   321		if (zx_numa_entry_cachep && zx_numa_lock_cachep) {
   322			zx_numa_entry = (struct _numa_buf *)kmem_cache_alloc(
   323					zx_numa_entry_cachep, GFP_KERNEL);
   324			if (zx_numa_entry) {
   325				memset((char *)zx_numa_entry, 0,
   326					sizeof(struct _numa_buf) * zx_numa_lock_total);
   327				create_numa_buffer_list(numa, d);
   328				status = 1;
   329			}
   330		}
   331	
   332		pr_info("enable dynamic numa-aware osq_lock, clusters %d\n",
   333			numa);
   334		return status;
   335	}
   336	
   337	
   338	#define numa_lock_proc_dir "zx_numa_lock"
   339	#define zx_numa_enable_dir "dynamic_enable"
   340	#define numa_entry_total 8
   341	struct proc_dir_entry *numa_lock_proc;
   342	struct proc_dir_entry *numa_lock_enable;
   343	struct proc_dir_entry *numa_proc_entry[numa_entry_total];
   344	
   345	static ssize_t numa_lock_proc_read(struct file *file,
   346			char __user *usrbuf, size_t len, loff_t *off)
   347	{
   348		int id = (long) pde_data(file_inode(file));
   349		char kbuffer[128];
   350		ssize_t retval = 0;
   351		size_t n = 0;
   352	
   353		memset(kbuffer, 0, sizeof(kbuffer));
   354		if (id == 0)
   355			n = sprintf(kbuffer, "%d\n", READ_ONCE(dynamic_enable));
   356		else if (id == 1)
   357			n = sprintf(kbuffer, "%d\n", READ_ONCE(osq_lock_depth));
   358		else if (id == 2)
   359			n = sprintf(kbuffer, "%d\n", READ_ONCE(osq_keep_times));
   360		else if (id == 3)
   361			n = sprintf(kbuffer, "%d\n", READ_ONCE(osq_node_max));
   362		else if (id == 4)
   363			n = sprintf(kbuffer, "%d\n", atomic_read(&numa_count));
   364		retval = simple_read_from_buffer(usrbuf, len, off, kbuffer, n);
   365	
   366		return retval;
   367	}
   368	
   369	static ssize_t numa_lock_proc_write(struct file *file,
   370			const char __user *buffer, size_t count, loff_t *f_pos)
   371	{
   372		int id = (long) pde_data(file_inode(file));
   373		char kbuffer[128];
   374		unsigned long new = 0;
 > 375		int err = 0;
   376	
   377		memset(kbuffer, 0, sizeof(kbuffer));
   378		if (copy_from_user(kbuffer, buffer, count))
   379			return count;
   380		kbuffer[count] = '\0';
   381		err = kstrtoul(kbuffer, 10, &new);
   382	
   383		if (id == 0) {
   384			int last = READ_ONCE(dynamic_enable);
   385	
   386			if (new < 0 || new >= 2 || last == new)
   387				return count;
   388	
   389			if (last == 0) {
   390				prefetchw(&enable_zx_numa_osq_lock);
   391				//enable to the 2-bytes-tail osq-lock
   392				prefetchw(&enable_zx_numa_osq_lock);
   393				WRITE_ONCE(enable_zx_numa_osq_lock, 2);
   394				schedule_delayed_work(&zx_numa_cleanup_work, 60*HZ);
   395			}
   396			prefetchw(&dynamic_enable);
   397			WRITE_ONCE(dynamic_enable, new);
   398			return count;
   399		}
   400	
   401		if (READ_ONCE(dynamic_enable) != 0) {
   402			pr_info("dynamic %d: change setting should disable dynamic\n",
   403				dynamic_enable);
   404			return count;
   405		}
   406		if (id == 1 && new > 4 && new <= 32)
   407			WRITE_ONCE(osq_lock_depth, new);
   408		else if (id == 2 && new >= 16 && new <= 2048)
   409			WRITE_ONCE(osq_keep_times, new);
   410		else if (id == 3 && new > 4 && new <= 2048)
   411			WRITE_ONCE(osq_node_max, new);
   412		return count;
   413	}
   414	static int numa_lock_proc_show(struct seq_file *m, void *v)
   415	{
   416		return 0;
   417	}
   418	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

