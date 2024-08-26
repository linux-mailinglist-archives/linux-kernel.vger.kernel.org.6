Return-Path: <linux-kernel+bounces-301517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE295F206
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C326285B74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E36185935;
	Mon, 26 Aug 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbmIE/Me"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6772513D8A2
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676486; cv=none; b=UC9XZM0PniZ2PitgPOBtnLyhZn+9sWpAeMYufIzbUkOsKRXGvQS72sPMJGhS110PVXsUnCTnI0oDurJaPmIKpek505AnBSnaz1HPOOIsv4wdcAAz+MJBYuSKxb/t9hRG5bzE2PEoKFXmwJzriEsbEXdrZzEvdauUt8pYJTZ8tmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676486; c=relaxed/simple;
	bh=3cHiwpJ0IGV2rDH7wRv3NTpGnsui1f0iIgctObp5wKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JCFMeTFEQOlWC/nThJrwAK9+3ahOZP9OgE/oRLxPpzZnhUR92+3LwC/n/SHSlO3ebHIvOe5kEfDS/8VT1Hdf8dfL/bCwZBhXmzQSnQdq3qSbG3HINvtEQj8XU8DT+swBnSZVlR3LK/NuTuqvSa2lZAFHBo0CFcS0u9bzXBf1JLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbmIE/Me; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724676485; x=1756212485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3cHiwpJ0IGV2rDH7wRv3NTpGnsui1f0iIgctObp5wKo=;
  b=UbmIE/MeihVeNFRVUcuCEbMWjaHb8MwW3+135fXnva0OJI8tLeFdoHoP
   1dndeCeRzpRfvikm3nlJDMMavNmW5TxMQive5hfGJxWG/bCDOFTc0f9oR
   ma+rQ7yKZSA+d2aZyLJvHPWbmomqu5x9GoP0EBPWvMIafTkjy7k+eO8r8
   h66e5Ft7WUcWdAOqRC+h51/4PTLSKQPf7shaIrwJe15/KLBUNkXg7fjTS
   J00+5rJ3piBIFxipsy7uwBBcYpJ+Qn50P+J2iiXPk8q7MRG9t6iOzD0W8
   UDu2jnVbW/HSvl3+7pw1yWtKqlE94T5nbbzrlrKSOIPmnzRrQML6+uMzg
   Q==;
X-CSE-ConnectionGUID: 3k6aN82RRACvfpWP5B0NuQ==
X-CSE-MsgGUID: PsFNQ0RnRM2l3JxhgwhlIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="26976416"
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="26976416"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 05:48:04 -0700
X-CSE-ConnectionGUID: R1pCx+aiTpK8UOU1ScsIkQ==
X-CSE-MsgGUID: r3diwDvOTlG5clloy2J6Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,177,1719903600"; 
   d="scan'208";a="66830053"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Aug 2024 05:48:02 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1siZ8a-000H5B-2E;
	Mon, 26 Aug 2024 12:48:00 +0000
Date: Mon, 26 Aug 2024 20:47:43 +0800
From: kernel test robot <lkp@intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/disk_accounting.c:136:5-8: Unneeded variable: "ret".
 Return "0" on line 184
Message-ID: <202408262018.bWsiI6Oz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5be63fc19fcaa4c236b307420483578a56986a37
commit: 077e47372309dcbe3a150754ea9c6f15cc838d6b bcachefs: bch2_accounting_invalid()
date:   2 weeks ago
config: i386-randconfig-053-20240826 (https://download.01.org/0day-ci/archive/20240826/202408262018.bWsiI6Oz-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408262018.bWsiI6Oz-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/disk_accounting.c:136:5-8: Unneeded variable: "ret". Return "0" on line 184

vim +136 fs/bcachefs/disk_accounting.c

   128	
   129	int bch2_accounting_invalid(struct bch_fs *c, struct bkey_s_c k,
   130				    enum bch_validate_flags flags,
   131				    struct printbuf *err)
   132	{
   133		struct disk_accounting_pos acc_k;
   134		bpos_to_disk_accounting_pos(&acc_k, k.k->p);
   135		void *end = &acc_k + 1;
 > 136		int ret = 0;
   137	
   138		switch (acc_k.type) {
   139		case BCH_DISK_ACCOUNTING_nr_inodes:
   140			end = field_end(acc_k, nr_inodes);
   141			break;
   142		case BCH_DISK_ACCOUNTING_persistent_reserved:
   143			end = field_end(acc_k, persistent_reserved);
   144			break;
   145		case BCH_DISK_ACCOUNTING_replicas:
   146			bkey_fsck_err_on(!acc_k.replicas.nr_devs,
   147					 c, err, accounting_key_replicas_nr_devs_0,
   148					 "accounting key replicas entry with nr_devs=0");
   149	
   150			bkey_fsck_err_on(acc_k.replicas.nr_required > acc_k.replicas.nr_devs ||
   151					 (acc_k.replicas.nr_required > 1 &&
   152					  acc_k.replicas.nr_required == acc_k.replicas.nr_devs),
   153					 c, err, accounting_key_replicas_nr_required_bad,
   154					 "accounting key replicas entry with bad nr_required");
   155	
   156			for (unsigned i = 0; i + 1 < acc_k.replicas.nr_devs; i++)
   157				bkey_fsck_err_on(acc_k.replicas.devs[i] > acc_k.replicas.devs[i + 1],
   158						 c, err, accounting_key_replicas_devs_unsorted,
   159						 "accounting key replicas entry with unsorted devs");
   160	
   161			end = (void *) &acc_k.replicas + replicas_entry_bytes(&acc_k.replicas);
   162			break;
   163		case BCH_DISK_ACCOUNTING_dev_data_type:
   164			end = field_end(acc_k, dev_data_type);
   165			break;
   166		case BCH_DISK_ACCOUNTING_compression:
   167			end = field_end(acc_k, compression);
   168			break;
   169		case BCH_DISK_ACCOUNTING_snapshot:
   170			end = field_end(acc_k, snapshot);
   171			break;
   172		case BCH_DISK_ACCOUNTING_btree:
   173			end = field_end(acc_k, btree);
   174			break;
   175		case BCH_DISK_ACCOUNTING_rebalance_work:
   176			end = field_end(acc_k, rebalance_work);
   177			break;
   178		}
   179	
   180		bkey_fsck_err_on(!is_zero(end, (void *) (&acc_k + 1)),
   181				 c, err, accounting_key_junk_at_end,
   182				 "junk at end of accounting key");
   183	fsck_err:
 > 184		return ret;
   185	}
   186	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

