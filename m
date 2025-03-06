Return-Path: <linux-kernel+bounces-549961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484BAA55914
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 22:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E697A8FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0D9277020;
	Thu,  6 Mar 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAPBjBJj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3B26FD9A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297901; cv=none; b=mHMTN+khx1IQuHIreNCKg3J47Pr2qfmpufy3N+UNFEgXMR9UJLH7nJxsh0sSuO0VlKxr5y+oa/xkUZiEH9V9hLrINigh8jG16lv/k7snxXR0yJlQSfGqNvLRKT/k5jzUmLNboQg9nkJ6fTqs3qahzvEmCzob1ABkB+Vbdl3LXYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297901; c=relaxed/simple;
	bh=JfRLPknr6t/lzKAO4sHgBXmNudQiAB6yND2W6g9u0FE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=joFNrlPgFeRfKUXb6ULJVmV+PAPOQKAuSPcYqyEjDphcYVNNMOAuc5r+TFLemJlXP4o0JxEobfwLgIJGUYIrGfkwtzLph0ndr1NotJGZijVe55mcxmgl6HpHI3orv3SuWOLB1fRvwQF3VGs0I1CUOlc+/2e48V69rne1Gr1EVRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAPBjBJj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741297900; x=1772833900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JfRLPknr6t/lzKAO4sHgBXmNudQiAB6yND2W6g9u0FE=;
  b=UAPBjBJjQFD3/8YwO1q+gc2QvpybNfkhph/mfGVNFVOTrAT5TVSZe4MG
   TCUAWQI6WeLaHFJZrTRF7GQh+tqIZzHAp70sgHkNgZOx8OO3R2iyE3v64
   3nyHFaZeDPG6nqZi4dFXlF3INF1Yleps065/xO3OJRV5bo3l+VOrx9BbA
   Tdczo/HzztxaCF+0hjEekTUm/2Um39JDTL7WdrsyVsqdt00boVJ/7jZke
   Mx1FzXMRoVtvHlDeJwNa0jsf8x8Kj5VdZ0h9GFGFK4ar5F1qI9HcUTEXd
   vKL5tnuRN41dOQi8Lb3VQacjnfyK0DJzthUbYqgDBz+Tpv5P/bmCkAsIT
   Q==;
X-CSE-ConnectionGUID: bbN/NBGvTIeiuQl3aWLIIw==
X-CSE-MsgGUID: GOJNnd8DStGEq1AYeYiR0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="41585483"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="41585483"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:51:39 -0800
X-CSE-ConnectionGUID: YDUMy8//RS2tUmWuBQjw2g==
X-CSE-MsgGUID: UPtH+EtTTQqvEScGDUejUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150077493"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Mar 2025 13:51:37 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqJ7v-000NfS-1t;
	Thu, 06 Mar 2025 21:51:35 +0000
Date: Fri, 7 Mar 2025 05:50:51 +0800
From: kernel test robot <lkp@intel.com>
To: Greg Ungerer <gerg@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but
 not used
Message-ID: <202503070539.bKnm5hEv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1238f0af13495e14e1f40d011b9b7b414bf387fe
commit: 9549fb354ef1a451ceddfa404ae3e943c5c803d0 riscv: support the elf-fdpic binfmt loader
date:   1 year, 6 months ago
config: riscv-randconfig-002-20240701 (https://download.01.org/0day-ci/archive/20250307/202503070539.bKnm5hEv-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503070539.bKnm5hEv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070539.bKnm5hEv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/binfmt_elf_fdpic.c: In function 'elf_fdpic_map_file_by_direct_mmap':
>> fs/binfmt_elf_fdpic.c:1024:52: warning: variable 'excess1' set but not used [-Wunused-but-set-variable]
    1024 |                 unsigned long maddr, disp, excess, excess1;
         |                                                    ^~~~~~~


vim +/excess1 +1024 fs/binfmt_elf_fdpic.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  1001  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1002  /*****************************************************************************/
^1da177e4c3f41 Linus Torvalds    2005-04-16  1003  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  1004   * map a binary by direct mmap() of the individual PT_LOAD segments
^1da177e4c3f41 Linus Torvalds    2005-04-16  1005   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1006  static int elf_fdpic_map_file_by_direct_mmap(struct elf_fdpic_params *params,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1007  					     struct file *file,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1008  					     struct mm_struct *mm)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1009  {
b922bf04d2c135 Greg Ungerer      2023-07-11  1010  	struct elf_fdpic_loadseg *seg;
b922bf04d2c135 Greg Ungerer      2023-07-11  1011  	struct elf_phdr *phdr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1012  	unsigned long load_addr, delta_vaddr;
e30c7c3b306312 Takuya Yoshikawa  2010-06-01  1013  	int loop, dvset;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1014  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1015  	load_addr = params->load_addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1016  	delta_vaddr = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1017  	dvset = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1018  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1019  	seg = params->loadmap->segs;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1020  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1021  	/* deal with each load segment separately */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1022  	phdr = params->phdrs;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1023  	for (loop = 0; loop < params->hdr.e_phnum; loop++, phdr++) {
^1da177e4c3f41 Linus Torvalds    2005-04-16 @1024  		unsigned long maddr, disp, excess, excess1;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1025  		int prot = 0, flags;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1026  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1027  		if (phdr->p_type != PT_LOAD)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1028  			continue;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1029  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1030  		kdebug("[LOAD] va=%lx of=%lx fs=%lx ms=%lx",
^1da177e4c3f41 Linus Torvalds    2005-04-16  1031  		       (unsigned long) phdr->p_vaddr,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1032  		       (unsigned long) phdr->p_offset,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1033  		       (unsigned long) phdr->p_filesz,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1034  		       (unsigned long) phdr->p_memsz);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1035  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1036  		/* determine the mapping parameters */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1037  		if (phdr->p_flags & PF_R) prot |= PROT_READ;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1038  		if (phdr->p_flags & PF_W) prot |= PROT_WRITE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1039  		if (phdr->p_flags & PF_X) prot |= PROT_EXEC;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1040  
4589ff7ca81516 David Hildenbrand 2021-04-23  1041  		flags = MAP_PRIVATE;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1042  		maddr = 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1043  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1044  		switch (params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1045  		case ELF_FDPIC_FLAG_INDEPENDENT:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1046  			/* PT_LOADs are independently locatable */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1047  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1048  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1049  		case ELF_FDPIC_FLAG_HONOURVADDR:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1050  			/* the specified virtual address must be honoured */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1051  			maddr = phdr->p_vaddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1052  			flags |= MAP_FIXED;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1053  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1054  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1055  		case ELF_FDPIC_FLAG_CONSTDISP:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1056  			/* constant displacement
8a2ab7f5df76b9 David Howells     2006-07-10  1057  			 * - can be mapped anywhere, but must be mapped as a
8a2ab7f5df76b9 David Howells     2006-07-10  1058  			 *   unit
^1da177e4c3f41 Linus Torvalds    2005-04-16  1059  			 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1060  			if (!dvset) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1061  				maddr = load_addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1062  				delta_vaddr = phdr->p_vaddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1063  				dvset = 1;
8a2ab7f5df76b9 David Howells     2006-07-10  1064  			} else {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1065  				maddr = load_addr + phdr->p_vaddr - delta_vaddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1066  				flags |= MAP_FIXED;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1067  			}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1068  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1069  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1070  		case ELF_FDPIC_FLAG_CONTIGUOUS:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1071  			/* contiguity handled later */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1072  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1073  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1074  		default:
^1da177e4c3f41 Linus Torvalds    2005-04-16  1075  			BUG();
^1da177e4c3f41 Linus Torvalds    2005-04-16  1076  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1077  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1078  		maddr &= PAGE_MASK;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1079  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1080  		/* create the mapping */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1081  		disp = phdr->p_vaddr & ~PAGE_MASK;
6be5ceb02e98ea Linus Torvalds    2012-04-20  1082  		maddr = vm_mmap(file, maddr, phdr->p_memsz + disp, prot, flags,
^1da177e4c3f41 Linus Torvalds    2005-04-16  1083  				phdr->p_offset - disp);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1084  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1085  		kdebug("mmap[%d] <file> sz=%lx pr=%x fl=%x of=%lx --> %08lx",
8a2ab7f5df76b9 David Howells     2006-07-10  1086  		       loop, phdr->p_memsz + disp, prot, flags,
8a2ab7f5df76b9 David Howells     2006-07-10  1087  		       phdr->p_offset - disp, maddr);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1088  
8a2ab7f5df76b9 David Howells     2006-07-10  1089  		if (IS_ERR_VALUE(maddr))
^1da177e4c3f41 Linus Torvalds    2005-04-16  1090  			return (int) maddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1091  
8a2ab7f5df76b9 David Howells     2006-07-10  1092  		if ((params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) ==
8a2ab7f5df76b9 David Howells     2006-07-10  1093  		    ELF_FDPIC_FLAG_CONTIGUOUS)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1094  			load_addr += PAGE_ALIGN(phdr->p_memsz + disp);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1095  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1096  		seg->addr = maddr + disp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1097  		seg->p_vaddr = phdr->p_vaddr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1098  		seg->p_memsz = phdr->p_memsz;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1099  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1100  		/* map the ELF header address if in this segment */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1101  		if (phdr->p_offset == 0)
^1da177e4c3f41 Linus Torvalds    2005-04-16  1102  			params->elfhdr_addr = seg->addr;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1103  
8a2ab7f5df76b9 David Howells     2006-07-10  1104  		/* clear the bit between beginning of mapping and beginning of
8a2ab7f5df76b9 David Howells     2006-07-10  1105  		 * PT_LOAD */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1106  		if (prot & PROT_WRITE && disp > 0) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  1107  			kdebug("clear[%d] ad=%lx sz=%lx", loop, maddr, disp);
e30c7c3b306312 Takuya Yoshikawa  2010-06-01  1108  			if (clear_user((void __user *) maddr, disp))
e30c7c3b306312 Takuya Yoshikawa  2010-06-01  1109  				return -EFAULT;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1110  			maddr += disp;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1111  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  1112  
^1da177e4c3f41 Linus Torvalds    2005-04-16  1113  		/* clear any space allocated but not loaded
^1da177e4c3f41 Linus Torvalds    2005-04-16  1114  		 * - on uClinux we can just clear the lot
^1da177e4c3f41 Linus Torvalds    2005-04-16  1115  		 * - on MMU linux we'll get a SIGBUS beyond the last page
^1da177e4c3f41 Linus Torvalds    2005-04-16  1116  		 *   extant in the file
^1da177e4c3f41 Linus Torvalds    2005-04-16  1117  		 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  1118  		excess = phdr->p_memsz - phdr->p_filesz;
^1da177e4c3f41 Linus Torvalds    2005-04-16  1119  		excess1 = PAGE_SIZE - ((maddr + phdr->p_filesz) & ~PAGE_MASK);
^1da177e4c3f41 Linus Torvalds    2005-04-16  1120  

:::::: The code at line 1024 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

