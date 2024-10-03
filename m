Return-Path: <linux-kernel+bounces-348900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362CD98ED60
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8351F22D02
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26F14F9CC;
	Thu,  3 Oct 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WS0CrTVC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC71422C7
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952808; cv=none; b=AiXTlN7tApp9kvTE3/Jg78dStdRXXPnmo7E8qkLfNXCRWuFx5qv1JmsARluJSVJX7/2OrJ60ASbwZnzi3BCTqQHezjfjBHnzJsqkyrGq5Uh+26VGeJ7jVjoPguasnzPE2XWIMMxZzfJpSSDjnuDx2pM5W1yu5z75DPFEkicKS0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952808; c=relaxed/simple;
	bh=3wQNnolcR4ILTTuvJv3OdXCrcUQBTKiC++SvXDaCQnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA20GwkjX+wGbTrIE8X9aHCFOHAqr8thwBOHDZTNzdYW8CZ3+Y2d1b1DNRmapamnk/0TunkaajPjb/44Jeutts233QfF7n2B6L4fsQDBy1gnL5tEoNYNqF1Y8MPzcsVHU++eOmS2vaiNAKTUhS/MsFKf691C67oZpqDYZbqmCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WS0CrTVC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727952807; x=1759488807;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wQNnolcR4ILTTuvJv3OdXCrcUQBTKiC++SvXDaCQnY=;
  b=WS0CrTVCkhNlNw5Rk3526kjrRRAv4YUtc72GFlkYZ9KayRV5uUwxIKLq
   8J45fr3k2DvtU9oe7r+btxyr4YBAsrpWRlV3dWpexhzZQcN3Z3k8KnoKb
   Z4QMJbEGFa/5olb1knaoPFcJ0PzvBvLuxU8stjuGkP3pi8Cymeyv5o6Tz
   Z4CU+IbNFZILFsEgdkTGuPFsyAcT11muvH89ZKKEgrntJQMaNUk+jHTH0
   R4DeTY8AJKVZWuE27StL3J/jw7v9VA/44GlTgEL+wLXfqox6c8QxTVmVV
   MmsQOBr7B+bbAqFeMLraU7CqpCOTtENkLkNbqOiQKBPhBTvX3miMJ5Hr4
   A==;
X-CSE-ConnectionGUID: jQRcEl/0ReypLmtaQ3g3rA==
X-CSE-MsgGUID: /Qo9MBRORbK13wnasVOoEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37804141"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="37804141"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 03:53:26 -0700
X-CSE-ConnectionGUID: WIWNXw/yQHOpBpRFbZaPuA==
X-CSE-MsgGUID: a7j90mBnSU2xuOkhdxhKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74303068"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Oct 2024 03:53:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swJSU-0000JO-2Q;
	Thu, 03 Oct 2024 10:53:22 +0000
Date: Thu, 3 Oct 2024 18:53:05 +0800
From: kernel test robot <lkp@intel.com>
To: Sayyad Abid <sayyad.abid16@gmail.com>, linux-m68k@lists.linux-m68k.org
Cc: oe-kbuild-all@lists.linux.dev, fthain@linux-m68k.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	sayyad.abid16@gmail.com
Subject: Re: [PATCH 2/3] drivers: nubus: Fix use of assignment in if
 condition in nubus_add_board() in nubus.c
Message-ID: <202410031850.v2wyYvLv-lkp@intel.com>
References: <20241002132820.402583-3-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002132820.402583-3-sayyad.abid16@gmail.com>

Hi Sayyad,

kernel test robot noticed the following build errors:

[auto build test ERROR on gerg-m68knommu/for-next]
[also build test ERROR on linus/master v6.12-rc1 next-20241003]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sayyad-Abid/drivers-nubus-Fix-use-of-tabs-in-nubus_get_vendorinfo-and-nubus_add_board-in-nubus-c/20241002-214920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
patch link:    https://lore.kernel.org/r/20241002132820.402583-3-sayyad.abid16%40gmail.com
patch subject: [PATCH 2/3] drivers: nubus: Fix use of assignment in if condition in nubus_add_board() in nubus.c
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241003/202410031850.v2wyYvLv-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410031850.v2wyYvLv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410031850.v2wyYvLv-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nubus/nubus.c: In function 'nubus_add_board':
>> drivers/nubus/nubus.c:739:9: error: expected ';' before 'if'
     739 |         if (board == NULL)
         |         ^~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +739 drivers/nubus/nubus.c

   723	
   724	static void __init nubus_add_board(int slot, int bytelanes)
   725	{
   726		struct nubus_board *board;
   727		unsigned char *rp;
   728		unsigned long dpat;
   729		struct nubus_dir dir;
   730		struct nubus_dirent ent;
   731		int prev_resid = -1;
   732	
   733		/* Move to the start of the format block */
   734		rp = nubus_rom_addr(slot);
   735		nubus_rewind(&rp, FORMAT_BLOCK_SIZE, bytelanes);
   736	
   737		/* Actually we should probably panic if this fails */
   738		board = kzalloc(sizeof(*board), GFP_ATOMIC)
 > 739		if (board == NULL)
   740			return;
   741		board->fblock = rp;
   742	
   743		/* Dump the format block for debugging purposes */
   744		pr_debug("Slot %X, format block at 0x%p:\n", slot, rp);
   745		pr_debug("%08lx\n", nubus_get_rom(&rp, 4, bytelanes));
   746		pr_debug("%08lx\n", nubus_get_rom(&rp, 4, bytelanes));
   747		pr_debug("%08lx\n", nubus_get_rom(&rp, 4, bytelanes));
   748		pr_debug("%02lx\n", nubus_get_rom(&rp, 1, bytelanes));
   749		pr_debug("%02lx\n", nubus_get_rom(&rp, 1, bytelanes));
   750		pr_debug("%08lx\n", nubus_get_rom(&rp, 4, bytelanes));
   751		pr_debug("%02lx\n", nubus_get_rom(&rp, 1, bytelanes));
   752		pr_debug("%02lx\n", nubus_get_rom(&rp, 1, bytelanes));
   753		rp = board->fblock;
   754	
   755		board->slot = slot;
   756		board->slot_addr = (unsigned long)nubus_slot_addr(slot);
   757		board->doffset = nubus_get_rom(&rp, 4, bytelanes);
   758		/* rom_length is *supposed* to be the total length of the
   759		 * ROM.  In practice it is the "amount of ROM used to compute
   760		 * the CRC."  So some jokers decide to set it to zero and
   761		 * set the crc to zero so they don't have to do any math.
   762		 * See the Performa 460 ROM, for example.  Those Apple "engineers".
   763		 */
   764		board->rom_length = nubus_get_rom(&rp, 4, bytelanes);
   765		board->crc = nubus_get_rom(&rp, 4, bytelanes);
   766		board->rev = nubus_get_rom(&rp, 1, bytelanes);
   767		board->format = nubus_get_rom(&rp, 1, bytelanes);
   768		board->lanes = bytelanes;
   769	
   770		/* Directory offset should be small and negative... */
   771		if (!(board->doffset & 0x00FF0000))
   772			pr_warn("Slot %X: Dodgy doffset!\n", slot);
   773		dpat = nubus_get_rom(&rp, 4, bytelanes);
   774		if (dpat != NUBUS_TEST_PATTERN)
   775			pr_warn("Slot %X: Wrong test pattern %08lx!\n", slot, dpat);
   776	
   777		/*
   778		 *	I wonder how the CRC is meant to work -
   779		 *		any takers ?
   780		 * CSA: According to MAC docs, not all cards pass the CRC anyway,
   781		 * since the initial Macintosh ROM releases skipped the check.
   782		 */
   783	
   784		/* Set up the directory pointer */
   785		board->directory = board->fblock;
   786		nubus_move(&board->directory, nubus_expand32(board->doffset),
   787			   board->lanes);
   788	
   789		nubus_get_root_dir(board, &dir);
   790	
   791		/* We're ready to rock */
   792		pr_debug("Slot %X resources:\n", slot);
   793	
   794		/* Each slot should have one board resource and any number of
   795		 * functional resources.  So we'll fill in some fields in the
   796		 * struct nubus_board from the board resource, then walk down
   797		 * the list of functional resources, spinning out a nubus_rsrc
   798		 * for each of them.
   799		 */
   800		if (nubus_readdir(&dir, &ent) == -1) {
   801			/* We can't have this! */
   802			pr_err("Slot %X: Board resource not found!\n", slot);
   803			kfree(board);
   804			return;
   805		}
   806	
   807		if (ent.type < 1 || ent.type > 127)
   808			pr_warn("Slot %X: Board resource ID is invalid!\n", slot);
   809	
   810		board->procdir = nubus_proc_add_board(board);
   811	
   812		nubus_get_board_resource(board, slot, &ent);
   813	
   814		while (nubus_readdir(&dir, &ent) != -1) {
   815			struct nubus_rsrc *fres;
   816	
   817			fres = nubus_get_functional_resource(board, slot, &ent);
   818			if (fres == NULL)
   819				continue;
   820	
   821			/* Resources should appear in ascending ID order. This sanity
   822			 * check prevents duplicate resource IDs.
   823			 */
   824			if (fres->resid <= prev_resid) {
   825				kfree(fres);
   826				continue;
   827			}
   828			prev_resid = fres->resid;
   829	
   830			list_add_tail(&fres->list, &nubus_func_rsrcs);
   831		}
   832	
   833		if (nubus_device_register(board))
   834			put_device(&board->dev);
   835	}
   836	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

