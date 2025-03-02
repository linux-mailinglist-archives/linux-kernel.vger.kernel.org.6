Return-Path: <linux-kernel+bounces-540407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EBAA4B03F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9A318949E7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28961D5143;
	Sun,  2 Mar 2025 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcgO3KAy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485A61C3F02
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740899253; cv=none; b=iH2gqo6m6b96fYbok6cH9ZHrA5QrUQM1S4nLUTcvWupVrWx/IYfatpvIF5pXsnGCDbi9bB5XVb80aPxhQ8zanbpCj3DgDqMaI//Fx8ftirlBE0w0MM/H7yg3S0xW3t+9bSk5QNRUpijg+QO5zx4/gy/EwXrY6n3xaIS0CgeUQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740899253; c=relaxed/simple;
	bh=pCTyOMsoLM1diGY0FwhWjKVCKVR5YkUhbs4Z1PoxRDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=D+Vq3girVUW5Px5UQ4s3dGYo0fKobn6nqNFaoS7Ckt4LEcsliKse1I/sXnJMa0yqpoy4/M/54WDUWUbNsI82/XbYxqFv2RVUnxZFau660Y+nkMbmIvtygZNqDvXHmQCWYUCG+d78s1SCk4mFlJEkVIvenm9RgScQ82qR++4KAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcgO3KAy; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740899250; x=1772435250;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pCTyOMsoLM1diGY0FwhWjKVCKVR5YkUhbs4Z1PoxRDI=;
  b=EcgO3KAyUAvcxj2yuPRBWXKcdc+vylCFtgtSf+Cuvo0L77+yh74mr4ma
   l4NQlqjyXVJ+LEDHe7BJFEzwSqDxuGJDZMgyB/MUl9/xDh5WCN83yzQfk
   xSTES9QvSt0Fbmf/dOKzjlkf5m0rx0KjH9VYNi1BeYcsmGH6unRP3CKU7
   xyKXunJa1/nh+qQBQrrODHTXPBPmCeAsTzHNsbj+g/4fRuPScn3EhXoE7
   8FJhAVJ2SQ5zp+d5KCAaH0dGAJ69oTLGNGPclhmATSWXn0rOP6KWW7G8u
   B8TlwsCZW/sEmiqo3B3h0yFzHV0ifHrCbXtX4H6wChaW64tVtjIVdyOky
   g==;
X-CSE-ConnectionGUID: mrGDSyvRTj+xXiDwPPvb5w==
X-CSE-MsgGUID: lO2QByqhRLyYBwf+9KamFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="29373202"
X-IronPort-AV: E=Sophos;i="6.13,327,1732608000"; 
   d="scan'208";a="29373202"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 23:07:30 -0800
X-CSE-ConnectionGUID: eUgCW2+0Sx6w24nsHwf49Q==
X-CSE-MsgGUID: 74x5j4XhRLqqhgF+bz8IRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118612695"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 01 Mar 2025 23:07:28 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1todQ5-000H9c-2b;
	Sun, 02 Mar 2025 07:07:25 +0000
Date: Sun, 2 Mar 2025 15:06:41 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Sakai <msakai@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: drivers/md/dm-vdo/recovery-journal.c:1369: warning: Function
 parameter or struct member 'context' not described in 'write_block'
Message-ID: <202503021428.HHj7BiAW-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ece144f151ac7bf8bb5b98f7d4aeeda7a2eed02a
commit: 19ac19e02ffa318e77f6b086b8fb3917da0aa893 dm vdo: fix function doc comment formatting
date:   3 months ago
config: x86_64-randconfig-161-20241019 (https://download.01.org/0day-ci/archive/20250302/202503021428.HHj7BiAW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503021428.HHj7BiAW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503021428.HHj7BiAW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/md/dm-vdo/recovery-journal.c:268: warning: Function parameter or struct member 'waiter' not described in 'continue_waiter'
   drivers/md/dm-vdo/recovery-journal.c:268: warning: Function parameter or struct member 'context' not described in 'continue_waiter'
   drivers/md/dm-vdo/recovery-journal.c:1085: warning: Function parameter or struct member 'waiter' not described in 'assign_entry'
   drivers/md/dm-vdo/recovery-journal.c:1085: warning: Function parameter or struct member 'context' not described in 'assign_entry'
   drivers/md/dm-vdo/recovery-journal.c:1172: warning: Function parameter or struct member 'waiter' not described in 'continue_committed_waiter'
   drivers/md/dm-vdo/recovery-journal.c:1172: warning: Function parameter or struct member 'context' not described in 'continue_committed_waiter'
   drivers/md/dm-vdo/recovery-journal.c:1369: warning: Function parameter or struct member 'waiter' not described in 'write_block'
>> drivers/md/dm-vdo/recovery-journal.c:1369: warning: Function parameter or struct member 'context' not described in 'write_block'
   drivers/md/dm-vdo/recovery-journal.c:1620: warning: Function parameter or struct member 'state' not described in 'initiate_drain'


vim +1369 drivers/md/dm-vdo/recovery-journal.c

95a72357688803 Matthew Sakai 2023-11-16  1362  
95a72357688803 Matthew Sakai 2023-11-16  1363  /**
95a72357688803 Matthew Sakai 2023-11-16  1364   * write_block() - Issue a block for writing.
95a72357688803 Matthew Sakai 2023-11-16  1365   *
95a72357688803 Matthew Sakai 2023-11-16  1366   * Implements waiter_callback_fn.
95a72357688803 Matthew Sakai 2023-11-16  1367   */
19ac19e02ffa31 Matthew Sakai 2024-10-02  1368  static void write_block(struct vdo_waiter *waiter, void __always_unused *context)
95a72357688803 Matthew Sakai 2023-11-16 @1369  {
95a72357688803 Matthew Sakai 2023-11-16  1370  	struct recovery_journal_block *block =
95a72357688803 Matthew Sakai 2023-11-16  1371  		container_of(waiter, struct recovery_journal_block, write_waiter);
95a72357688803 Matthew Sakai 2023-11-16  1372  	struct recovery_journal *journal = block->journal;
95a72357688803 Matthew Sakai 2023-11-16  1373  	struct packed_journal_header *header = get_block_header(block);
95a72357688803 Matthew Sakai 2023-11-16  1374  
d6e260cc426164 Mike Snitzer  2023-11-20  1375  	if (block->committing || !vdo_waitq_has_waiters(&block->entry_waiters) ||
d6e260cc426164 Mike Snitzer  2023-11-20  1376  	    is_read_only(journal))
95a72357688803 Matthew Sakai 2023-11-16  1377  		return;
95a72357688803 Matthew Sakai 2023-11-16  1378  
d6e260cc426164 Mike Snitzer  2023-11-20  1379  	block->entries_in_commit = vdo_waitq_num_waiters(&block->entry_waiters);
95a72357688803 Matthew Sakai 2023-11-16  1380  	add_queued_recovery_entries(block);
95a72357688803 Matthew Sakai 2023-11-16  1381  
95a72357688803 Matthew Sakai 2023-11-16  1382  	journal->pending_write_count += 1;
95a72357688803 Matthew Sakai 2023-11-16  1383  	journal->events.blocks.written += 1;
95a72357688803 Matthew Sakai 2023-11-16  1384  	journal->events.entries.written += block->entries_in_commit;
95a72357688803 Matthew Sakai 2023-11-16  1385  
95a72357688803 Matthew Sakai 2023-11-16  1386  	header->block_map_head = __cpu_to_le64(journal->block_map_head);
95a72357688803 Matthew Sakai 2023-11-16  1387  	header->slab_journal_head = __cpu_to_le64(journal->slab_journal_head);
95a72357688803 Matthew Sakai 2023-11-16  1388  	header->entry_count = __cpu_to_le16(block->entry_count);
95a72357688803 Matthew Sakai 2023-11-16  1389  
95a72357688803 Matthew Sakai 2023-11-16  1390  	block->committing = true;
95a72357688803 Matthew Sakai 2023-11-16  1391  
95a72357688803 Matthew Sakai 2023-11-16  1392  	/*
95a72357688803 Matthew Sakai 2023-11-16  1393  	 * We must issue a flush and a FUA for every commit. The flush is necessary to ensure that
95a72357688803 Matthew Sakai 2023-11-16  1394  	 * the data being referenced is stable. The FUA is necessary to ensure that the journal
95a72357688803 Matthew Sakai 2023-11-16  1395  	 * block itself is stable before allowing overwrites of the lbn's previous data.
95a72357688803 Matthew Sakai 2023-11-16  1396  	 */
f7f46761ccd9b4 Mike Snitzer  2023-08-25  1397  	vdo_submit_metadata_vio(&block->vio, journal->origin + block->block_number,
b863d7f7503c42 Mike Snitzer  2024-02-05  1398  				complete_write_endio, handle_write_error,
b863d7f7503c42 Mike Snitzer  2024-02-05  1399  				REQ_OP_WRITE | REQ_PRIO | REQ_PREFLUSH | REQ_SYNC | REQ_FUA);
95a72357688803 Matthew Sakai 2023-11-16  1400  }
95a72357688803 Matthew Sakai 2023-11-16  1401  

:::::: The code at line 1369 was first introduced by commit
:::::: 95a72357688803736bf60db973cbf94c0ff3a6da dm vdo: add the recovery journal

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

