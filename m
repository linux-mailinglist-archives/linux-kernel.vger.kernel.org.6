Return-Path: <linux-kernel+bounces-539593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7DFA4A633
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE0416AA76
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4D1DED79;
	Fri, 28 Feb 2025 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fVR7/x2f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329011DED71
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783124; cv=none; b=YcOukw+MXUCi/lcmzfyr6FivYUVDUuXJ6/J75QQSZ4jWmgVccfBfM7PHNNoSAr51YKVoIXBSQSqQqMZCwoqKiPvDcBnOx4Iw53vN13t+66OFwkLEAdMjMOt8k+tUwNAgIZsujmVvjK+MUdevuzHJMCcUswk1ZvKzWmzfANGXbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783124; c=relaxed/simple;
	bh=dRpj+l9v3cUD/5QdVug3/CCYYHU7qC+XEOOSgCDQTtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R77YiymDPbUsqgomUknpRIKKphILAT6acUSOvut9D1Za0kL/5RGVVGj+qfwKM0rOVgHj0b1GgWjrdCr0PEP9An44aG6PNYTv60jw/U/KAQkzJqV/1Rvac98HtY+9Oj6n2zjGXHnJFgc346i3f1GZNDOfLpQZpaepHNOsdtdIxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fVR7/x2f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740783122; x=1772319122;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dRpj+l9v3cUD/5QdVug3/CCYYHU7qC+XEOOSgCDQTtI=;
  b=fVR7/x2fWQha2kWGbQxuihD6Ab3HHDwwy+Xr34MDnBr1d39TQ9d5YMwG
   JeXMb2MbWFy21ZHhOKhoRLSQ1skOcPF4b0NdC2iHNkFfDgqzWNnsl4d5A
   0BHkMtkBr7F9TATcffM39Y3Wk/YaGybpn7ML5nvjskrgwrXra5E+z8B3Q
   81WZuu++zP53/h554ZUxyObSM3rpEw5/YyPkExuKMa6eZjAHrfBEp/0wh
   3iO4mJxYkAGM+oEJwZQHyTusTW+8Tvy+jmrhncwakG5TnEBcAS9fPhjbL
   mJxUgxfjv5fQ4JGxRUEt9/9M97C9e4b9+g3wcaby7aetRQX3YnnjPWnqO
   A==;
X-CSE-ConnectionGUID: P/wJbyBMTGqbnR+hR/E3Fg==
X-CSE-MsgGUID: sr6uLyJsRRiSvmmZD96juw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="67097768"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="67097768"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 14:52:01 -0800
X-CSE-ConnectionGUID: WgV0pbUxQYKkYpzNjeYUtg==
X-CSE-MsgGUID: A99RggSOQcu66A6nj6WIyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117248039"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 28 Feb 2025 14:52:00 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to9D3-000FbO-1t;
	Fri, 28 Feb 2025 22:51:57 +0000
Date: Sat, 1 Mar 2025 06:51:43 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolas Pitre <npitre@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: security/keys/proc.c:211:40: warning: '%llu' directive writing
 between 1 and 18 bytes into a region of size 16
Message-ID: <202503010638.lMdz5xwN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicolas,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   276f98efb64a2c31c099465ace78d3054c662a0f
commit: 00a31dd3acea0f88f947fc71e268ebb34b59f218 asm-generic/div64: optimize/simplify __div64_const32()
date:   4 months ago
config: arm-randconfig-r002-20220811 (https://download.01.org/0day-ci/archive/20250301/202503010638.lMdz5xwN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010638.lMdz5xwN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010638.lMdz5xwN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   security/keys/proc.c: In function 'proc_keys_show':
   security/keys/proc.c:217:45: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     217 |                         sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
         |                                             ^
   security/keys/proc.c:217:25: note: 'sprintf' output between 3 and 17 bytes into a destination of size 16
     217 |                         sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/keys/proc.c:215:45: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     215 |                         sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
         |                                             ^
   security/keys/proc.c:215:25: note: 'sprintf' output between 3 and 17 bytes into a destination of size 16
     215 |                         sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   security/keys/proc.c:213:44: warning: 'h' directive writing 1 byte into a region of size between 0 and 15 [-Wformat-overflow=]
     213 |                         sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
         |                                            ^
   security/keys/proc.c:213:25: note: 'sprintf' output between 3 and 18 bytes into a destination of size 16
     213 |                         sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> security/keys/proc.c:211:40: warning: '%llu' directive writing between 1 and 18 bytes into a region of size 16 [-Wformat-overflow=]
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                                        ^~~~
   security/keys/proc.c:211:39: note: directive argument in the range [0, 576460752303423487]
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                                       ^~~~~~~
   security/keys/proc.c:211:25: note: 'sprintf' output between 3 and 20 bytes into a destination of size 16
     211 |                         sprintf(xbuf, "%llum", div_u64(timo, 60));
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +211 security/keys/proc.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  152  
^1da177e4c3f41 Linus Torvalds 2005-04-16  153  static int proc_keys_show(struct seq_file *m, void *v)
^1da177e4c3f41 Linus Torvalds 2005-04-16  154  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  155  	struct rb_node *_p = v;
^1da177e4c3f41 Linus Torvalds 2005-04-16  156  	struct key *key = rb_entry(_p, struct key, serial_node);
ab5c69f01313c8 Eric Biggers   2017-09-27  157  	unsigned long flags;
927942aabbbe50 David Howells  2010-06-11  158  	key_ref_t key_ref, skey_ref;
074d58989569b3 Baolin Wang    2017-11-15  159  	time64_t now, expiry;
03dab869b7b239 David Howells  2016-10-26  160  	char xbuf[16];
363b02dab09b32 David Howells  2017-10-04  161  	short state;
074d58989569b3 Baolin Wang    2017-11-15  162  	u64 timo;
06ec7be557a125 Michael LeMay  2006-06-26  163  	int rc;
06ec7be557a125 Michael LeMay  2006-06-26  164  
4bdf0bc3003141 David Howells  2013-09-24  165  	struct keyring_search_context ctx = {
ede0fa98a900e6 Eric Biggers   2019-02-22  166  		.index_key		= key->index_key,
4aa68e07d84556 Eric Biggers   2017-09-18  167  		.cred			= m->file->f_cred,
462919591a1791 David Howells  2014-09-16  168  		.match_data.cmp		= lookup_user_key_possessed,
462919591a1791 David Howells  2014-09-16  169  		.match_data.raw_data	= key,
462919591a1791 David Howells  2014-09-16  170  		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
dcf49dbc8077e2 David Howells  2019-06-26  171  		.flags			= (KEYRING_SEARCH_NO_STATE_CHECK |
dcf49dbc8077e2 David Howells  2019-06-26  172  					   KEYRING_SEARCH_RECURSE),
4bdf0bc3003141 David Howells  2013-09-24  173  	};
4bdf0bc3003141 David Howells  2013-09-24  174  
028db3e290f15a Linus Torvalds 2019-07-10  175  	key_ref = make_key_ref(key, 0);
927942aabbbe50 David Howells  2010-06-11  176  
927942aabbbe50 David Howells  2010-06-11  177  	/* determine if the key is possessed by this process (a test we can
927942aabbbe50 David Howells  2010-06-11  178  	 * skip if the key does not indicate the possessor can view it
927942aabbbe50 David Howells  2010-06-11  179  	 */
028db3e290f15a Linus Torvalds 2019-07-10  180  	if (key->perm & KEY_POS_VIEW) {
028db3e290f15a Linus Torvalds 2019-07-10  181  		rcu_read_lock();
e59428f721ee09 David Howells  2019-06-19  182  		skey_ref = search_cred_keyrings_rcu(&ctx);
028db3e290f15a Linus Torvalds 2019-07-10  183  		rcu_read_unlock();
927942aabbbe50 David Howells  2010-06-11  184  		if (!IS_ERR(skey_ref)) {
927942aabbbe50 David Howells  2010-06-11  185  			key_ref_put(skey_ref);
927942aabbbe50 David Howells  2010-06-11  186  			key_ref = make_key_ref(key, 1);
927942aabbbe50 David Howells  2010-06-11  187  		}
927942aabbbe50 David Howells  2010-06-11  188  	}
927942aabbbe50 David Howells  2010-06-11  189  
4aa68e07d84556 Eric Biggers   2017-09-18  190  	/* check whether the current task is allowed to view the key */
f5895943d91b41 David Howells  2014-03-14  191  	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
06ec7be557a125 Michael LeMay  2006-06-26  192  	if (rc < 0)
028db3e290f15a Linus Torvalds 2019-07-10  193  		return 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  194  
074d58989569b3 Baolin Wang    2017-11-15  195  	now = ktime_get_real_seconds();
^1da177e4c3f41 Linus Torvalds 2005-04-16  196  
028db3e290f15a Linus Torvalds 2019-07-10  197  	rcu_read_lock();
028db3e290f15a Linus Torvalds 2019-07-10  198  
^1da177e4c3f41 Linus Torvalds 2005-04-16  199  	/* come up with a suitable timeout value */
ab5c69f01313c8 Eric Biggers   2017-09-27  200  	expiry = READ_ONCE(key->expiry);
39299bdd254668 David Howells  2023-12-09  201  	if (expiry == TIME64_MAX) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  202  		memcpy(xbuf, "perm", 5);
074d58989569b3 Baolin Wang    2017-11-15  203  	} else if (now >= expiry) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  204  		memcpy(xbuf, "expd", 5);
7b1b9164598286 David Howells  2009-09-02  205  	} else {
074d58989569b3 Baolin Wang    2017-11-15  206  		timo = expiry - now;
^1da177e4c3f41 Linus Torvalds 2005-04-16  207  
^1da177e4c3f41 Linus Torvalds 2005-04-16  208  		if (timo < 60)
074d58989569b3 Baolin Wang    2017-11-15  209  			sprintf(xbuf, "%llus", timo);
^1da177e4c3f41 Linus Torvalds 2005-04-16  210  		else if (timo < 60*60)
074d58989569b3 Baolin Wang    2017-11-15 @211  			sprintf(xbuf, "%llum", div_u64(timo, 60));
^1da177e4c3f41 Linus Torvalds 2005-04-16  212  		else if (timo < 60*60*24)
074d58989569b3 Baolin Wang    2017-11-15  213  			sprintf(xbuf, "%lluh", div_u64(timo, 60 * 60));
^1da177e4c3f41 Linus Torvalds 2005-04-16  214  		else if (timo < 60*60*24*7)
074d58989569b3 Baolin Wang    2017-11-15 @215  			sprintf(xbuf, "%llud", div_u64(timo, 60 * 60 * 24));
^1da177e4c3f41 Linus Torvalds 2005-04-16  216  		else
074d58989569b3 Baolin Wang    2017-11-15  217  			sprintf(xbuf, "%lluw", div_u64(timo, 60 * 60 * 24 * 7));
^1da177e4c3f41 Linus Torvalds 2005-04-16  218  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  219  
363b02dab09b32 David Howells  2017-10-04  220  	state = key_read_state(key);
363b02dab09b32 David Howells  2017-10-04  221  

:::::: The code at line 211 was first introduced by commit
:::::: 074d58989569b39f04294c90ef36dd82b8c2cc1a security: keys: Replace time_t/timespec with time64_t

:::::: TO: Baolin Wang <baolin.wang@linaro.org>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

