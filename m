Return-Path: <linux-kernel+bounces-171173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2762B8BE0B1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933EE1F21A54
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B93E152515;
	Tue,  7 May 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NapILRbG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB114D422
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080173; cv=none; b=lYfJ4OFFt/Qnf6RFlx4+3klw3aN5WUgiVT3OGmGnaZ17toLrnOA/mgGU4bjAxegebMauRNpQSdE8xJYq4gOczZzLifEdXiaehCW3erQPG1VQNpgpnld70yk6KV3fT1D8xCmjWHhhW6LMJDRmfkEJiRAZb6+X9hlBz05WGd/mMuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080173; c=relaxed/simple;
	bh=X+nsIqa8R9gZFQD73EKo76zTf2aTyJtE3+rq70of7Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qopgs1GOuI8JFVTW0+gzHdHyQIJg5kL8elLCvsLnZhEgFGRYZlquSOxuJxZIBgv5aluyjBxI9fgaY1jFOwJHNqfWCjPOlv4qIbm4eUJxFx5xIsz5wLGMR2YsXgGg0u1R/yNo+GcdcENBA9JU7ZYZW8MwTLuz/RpMnKQDMF6hLPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NapILRbG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080171; x=1746616171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X+nsIqa8R9gZFQD73EKo76zTf2aTyJtE3+rq70of7Sk=;
  b=NapILRbGmSNCAzs80LHOYPKrkWYIMJ+5qxRnCNpTCZaWVKfQieyTDYF2
   Us3+N/EcPfuCjr61dyUrBfnlAE8EzsmcCf8wsOPuCf2Tf6/g/kxZ9RDj6
   cnGJV2eFQEx9QM0mqA0x7+U/QjnJWnvqudR7hcJy8fAG9OyEGH6IQoBgX
   5d6MdZuKJQnSZKjhRIclLo9ISa/8doSzQi5zOq+uabjuhTfrxjW/WghYi
   aFF7giCW3WMwI7nH4YiBNKwnTar4fchcurJyFzRX67TRlKPnauwo+jx7/
   HzPlSAtN4aPMXtp/o/FKAn8OQnX8/QacrC5O88dGtbsLVEG4WF5/nO6Ip
   Q==;
X-CSE-ConnectionGUID: Am9L5jGHQXqXMH3ABbpjbw==
X-CSE-MsgGUID: UunlyErNSEeKZ7XRWK0ihw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22259102"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="22259102"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:09:30 -0700
X-CSE-ConnectionGUID: IxOTJ9HfQZqBi6mCULFP0w==
X-CSE-MsgGUID: u74QgCEcTmugrWgnKipWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28572389"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 04:09:28 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4IhJ-0001qD-2u;
	Tue, 07 May 2024 11:09:25 +0000
Date: Tue, 7 May 2024 19:08:36 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: do_write_oneword+0x119:
 cfi_send_gen_cmd() is missing a __noreturn annotation
Message-ID: <202405071947.b7nSK2m3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dccb07f2914cdab2ac3a5b6c98406f765acab803
commit: 719a937b7003933de1298ffa4b881dd6a234e244 iov_iter: Mark copy_iovec_from_user() noclone
date:   10 months ago
config: x86_64-randconfig-r052-20240124 (https://download.01.org/0day-ci/archive/20240507/202405071947.b7nSK2m3-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405071947.b7nSK2m3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405071947.b7nSK2m3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: cfi_staa_resume+0x94: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_buffer+0xc2: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_read_onechip+0x82: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_unlock_oneblock+0x7b: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_lock_oneblock+0x7b: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_oneblock+0x74: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: fixup_sst39vf_rev_b+0x3e: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_resume+0xb0: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_check_err_status+0x8a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: chip_ready+0xd4: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_panic_wait+0x58: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_panic_write_oneword+0xef: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_oneword_once+0x4b: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: fixup_sst38vf640x_sectorsize+0x3f: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: put_chip.isra.0+0x145: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: get_chip+0x24f: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_write_oneword+0x119: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_atmel_unlock+0x7a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_atmel_lock+0x80: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0xa6: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_read+0x23a: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_chip+0x102: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_buffer+0xb0: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_oneblock+0x10e: cfi_send_gen_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_ppb_xxlock+0x7d: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_otp_lock+0xa0: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_otp_walk+0x12c: cfi_qry_mode_on() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_reset.isra.0+0xbd: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_secsi_read+0x197: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_otp_write+0xa6: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_read_secsi_onechip+0xed: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: jedec_reset+0x3c: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_jedec_setup+0x146: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: jedec_probe_chip+0x142: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_oneblock.cold+0x0: unreachable instruction
   vmlinux.o: warning: objtool: jedec_probe_chip.cold+0x0: unreachable instruction


objdump-func vmlinux.o do_write_oneword:
0000 0000000000f99e80 <do_write_oneword_once>:
0000   f99e80:	41 57                	push   %r15
0002   f99e82:	45 89 c7             	mov    %r8d,%r15d
0005   f99e85:	41 56                	push   %r14
0007   f99e87:	49 89 d6             	mov    %rdx,%r14
000a   f99e8a:	41 55                	push   %r13
000c   f99e8c:	41 54                	push   %r12
000e   f99e8e:	49 89 fc             	mov    %rdi,%r12
0011   f99e91:	55                   	push   %rbp
0012   f99e92:	4c 89 cd             	mov    %r9,%rbp
0015   f99e95:	53                   	push   %rbx
0016   f99e96:	48 89 f3             	mov    %rsi,%rbx
0019   f99e99:	4c 8d 6b 28          	lea    0x28(%rbx),%r13
001d   f99e9d:	48 83 ec 50          	sub    $0x50,%rsp
0021   f99ea1:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
0026   f99ea6:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
002b   f99eab:	e8 00 00 00 00       	call   f99eb0 <do_write_oneword_once+0x30>	f99eac: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0030   f99eb0:	8b 75 1c             	mov    0x1c(%rbp),%esi
0033   f99eb3:	49 89 e8             	mov    %rbp,%r8
0036   f99eb6:	4c 89 e1             	mov    %r12,%rcx
0039   f99eb9:	6a 00                	push   $0x0
003b   f99ebb:	44 8b 4d 14          	mov    0x14(%rbp),%r9d
003f   f99ebf:	bf aa 00 00 00       	mov    $0xaa,%edi
0044   f99ec4:	8b 13                	mov    (%rbx),%edx
0046   f99ec6:	e8 00 00 00 00       	call   f99ecb <do_write_oneword_once+0x4b>	f99ec7: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
004b   f99ecb:	8b 75 20             	mov    0x20(%rbp),%esi
004e   f99ece:	49 89 e8             	mov    %rbp,%r8
0051   f99ed1:	4c 89 e1             	mov    %r12,%rcx
0054   f99ed4:	6a 00                	push   $0x0
0056   f99ed6:	44 8b 4d 14          	mov    0x14(%rbp),%r9d
005a   f99eda:	bf 55 00 00 00       	mov    $0x55,%edi
005f   f99edf:	8b 13                	mov    (%rbx),%edx
0061   f99ee1:	e8 00 00 00 00       	call   f99ee6 <do_write_oneword_once+0x66>	f99ee2: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0066   f99ee6:	8b 75 1c             	mov    0x1c(%rbp),%esi
0069   f99ee9:	49 89 e8             	mov    %rbp,%r8
006c   f99eec:	4c 89 e1             	mov    %r12,%rcx
006f   f99eef:	6a 00                	push   $0x0
0071   f99ef1:	44 8b 4d 14          	mov    0x14(%rbp),%r9d
0075   f99ef5:	bf a0 00 00 00       	mov    $0xa0,%edi
007a   f99efa:	8b 13                	mov    (%rbx),%edx
007c   f99efc:	e8 00 00 00 00       	call   f99f01 <do_write_oneword_once+0x81>	f99efd: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0081   f99f01:	49 8b 44 24 40       	mov    0x40(%r12),%rax
0086   f99f06:	4c 89 f2             	mov    %r14,%rdx
0089   f99f09:	4c 89 e7             	mov    %r12,%rdi
008c   f99f0c:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
0091   f99f11:	e8 00 00 00 00       	call   f99f16 <do_write_oneword_once+0x96>	f99f12: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0096   f99f16:	44 89 7b 0c          	mov    %r15d,0xc(%rbx)
009a   f99f1a:	4c 89 ef             	mov    %r13,%rdi
009d   f99f1d:	e8 00 00 00 00       	call   f99f22 <do_write_oneword_once+0xa2>	f99f1e: R_X86_64_PLT32	mutex_unlock-0x4
00a2   f99f22:	49 8b 6c 24 50       	mov    0x50(%r12),%rbp
00a7   f99f27:	48 83 c4 18          	add    $0x18,%rsp
00ab   f99f2b:	48 85 ed             	test   %rbp,%rbp
00ae   f99f2e:	74 15                	je     f99f45 <do_write_oneword_once+0xc5>
00b0   f99f30:	e8 00 00 00 00       	call   f99f35 <do_write_oneword_once+0xb5>	f99f31: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00b5   f99f35:	ba 02 00 00 00       	mov    $0x2,%edx
00ba   f99f3a:	4c 89 f6             	mov    %r14,%rsi
00bd   f99f3d:	4c 89 e7             	mov    %r12,%rdi
00c0   f99f40:	e8 00 00 00 00       	call   f99f45 <do_write_oneword_once+0xc5>	f99f41: R_X86_64_PLT32	__x86_indirect_thunk_rbp-0x4
00c5   f99f45:	e8 00 00 00 00       	call   f99f4a <do_write_oneword_once+0xca>	f99f46: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00ca   f99f4a:	8b bb 18 01 00 00    	mov    0x118(%rbx),%edi
00d0   f99f50:	31 ed                	xor    %ebp,%ebp
00d2   f99f52:	4c 8b 34 25 00 00 00 00 	mov    0x0,%r14	f99f56: R_X86_64_32S	pcpu_hot
00da   f99f5a:	e8 00 00 00 00       	call   f99f5f <do_write_oneword_once+0xdf>	f99f5b: R_X86_64_PLT32	cfi_udelay-0x4
00df   f99f5f:	31 f6                	xor    %esi,%esi
00e1   f99f61:	4c 89 ef             	mov    %r13,%rdi
00e4   f99f64:	e8 00 00 00 00       	call   f99f69 <do_write_oneword_once+0xe9>	f99f65: R_X86_64_PLT32	mutex_lock_nested-0x4
00e9   f99f69:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # f99f70 <do_write_oneword_once+0xf0>	f99f6c: R_X86_64_PC32	jiffies-0x4
00f0   f99f70:	48 83 c0 01          	add    $0x1,%rax
00f4   f99f74:	48 89 04 24          	mov    %rax,(%rsp)
00f8   f99f78:	e8 00 00 00 00       	call   f99f7d <do_write_oneword_once+0xfd>	f99f79: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00fd   f99f7d:	44 3b 7b 0c          	cmp    0xc(%rbx),%r15d
0101   f99f81:	0f 84 95 00 00 00    	je     f9a01c <do_write_oneword_once+0x19c>
0107   f99f87:	e8 00 00 00 00       	call   f99f8c <do_write_oneword_once+0x10c>	f99f88: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
010c   f99f8c:	48 89 6c 24 28       	mov    %rbp,0x28(%rsp)
0111   f99f91:	48 89 6c 24 40       	mov    %rbp,0x40(%rsp)
0116   f99f96:	48 89 6c 24 48       	mov    %rbp,0x48(%rsp)
011b   f99f9b:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
0120   f99fa0:	48 c7 44 24 38 00 00 00 00 	movq   $0x0,0x38(%rsp)	f99fa5: R_X86_64_32S	default_wake_function
0129   f99fa9:	e8 00 00 00 00       	call   f99fae <do_write_oneword_once+0x12e>	f99faa: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
012e   f99fae:	41 c7 46 18 02 00 00 00 	movl   $0x2,0x18(%r14)
0136   f99fb6:	49 c7 86 30 25 00 00 00 00 00 00 	movq   $0x0,0x2530(%r14)	f99fbd: R_X86_64_32S	.text+0xf99f87
0141   f99fc1:	48 8d 83 c0 00 00 00 	lea    0xc0(%rbx),%rax
0148   f99fc8:	48 8d 74 24 28       	lea    0x28(%rsp),%rsi
014d   f99fcd:	48 89 c7             	mov    %rax,%rdi
0150   f99fd0:	48 89 04 24          	mov    %rax,(%rsp)
0154   f99fd4:	e8 00 00 00 00       	call   f99fd9 <do_write_oneword_once+0x159>	f99fd5: R_X86_64_PLT32	add_wait_queue-0x4
0159   f99fd9:	4c 89 ef             	mov    %r13,%rdi
015c   f99fdc:	e8 00 00 00 00       	call   f99fe1 <do_write_oneword_once+0x161>	f99fdd: R_X86_64_PLT32	mutex_unlock-0x4
0161   f99fe1:	e8 00 00 00 00       	call   f99fe6 <do_write_oneword_once+0x166>	f99fe2: R_X86_64_PLT32	schedule-0x4
0166   f99fe6:	48 8b 3c 24          	mov    (%rsp),%rdi
016a   f99fea:	48 8d 74 24 28       	lea    0x28(%rsp),%rsi
016f   f99fef:	e8 00 00 00 00       	call   f99ff4 <do_write_oneword_once+0x174>	f99ff0: R_X86_64_PLT32	remove_wait_queue-0x4
0174   f99ff4:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # f99ffb <do_write_oneword_once+0x17b>	f99ff7: R_X86_64_PC32	jiffies-0x4
017b   f99ffb:	31 f6                	xor    %esi,%esi
017d   f99ffd:	4c 89 ef             	mov    %r13,%rdi
0180   f9a000:	48 83 c0 7d          	add    $0x7d,%rax
0184   f9a004:	48 89 04 24          	mov    %rax,(%rsp)
0188   f9a008:	e8 00 00 00 00       	call   f9a00d <do_write_oneword_once+0x18d>	f9a009: R_X86_64_PLT32	mutex_lock_nested-0x4
018d   f9a00d:	e8 00 00 00 00       	call   f9a012 <do_write_oneword_once+0x192>	f9a00e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0192   f9a012:	44 3b 7b 0c          	cmp    0xc(%rbx),%r15d
0196   f9a016:	0f 85 6b ff ff ff    	jne    f99f87 <do_write_oneword_once+0x107>
019c   f9a01c:	e8 00 00 00 00       	call   f9a021 <do_write_oneword_once+0x1a1>	f9a01d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01a1   f9a021:	49 8b 94 24 80 00 00 00 	mov    0x80(%r12),%rdx
01a9   f9a029:	48 b8 fe fe fe fe fe fe fe fe 	movabs $0xfefefefefefefefe,%rax
01b3   f9a033:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
01b8   f9a038:	48 8b 05 00 00 00 00 	mov    0x0(%rip),%rax        # f9a03f <do_write_oneword_once+0x1bf>	f9a03b: R_X86_64_PC32	jiffies-0x4
01bf   f9a03f:	48 8b 52 60          	mov    0x60(%rdx),%rdx
01c3   f9a043:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
01c8   f9a048:	48 39 04 24          	cmp    %rax,(%rsp)
01cc   f9a04c:	78 6a                	js     f9a0b8 <do_write_oneword_once+0x238>
01ce   f9a04e:	e8 00 00 00 00       	call   f9a053 <do_write_oneword_once+0x1d3>	f9a04f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01d3   f9a053:	49 8b 84 24 80 00 00 00 	mov    0x80(%r12),%rax
01db   f9a05b:	48 89 e9             	mov    %rbp,%rcx
01de   f9a05e:	f6 40 60 01          	testb  $0x1,0x60(%rax)
01e2   f9a062:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
01e7   f9a067:	48 0f 44 c8          	cmove  %rax,%rcx
01eb   f9a06b:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
01f0   f9a070:	e8 00 00 00 00       	call   f9a075 <do_write_oneword_once+0x1f5>	f9a071: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01f5   f9a075:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
01fa   f9a07a:	48 89 de             	mov    %rbx,%rsi
01fd   f9a07d:	4c 89 e7             	mov    %r12,%rdi
0200   f9a080:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
0205   f9a085:	e8 b6 f8 ff ff       	call   f99940 <chip_ready>
020a   f9a08a:	85 c0                	test   %eax,%eax
020c   f9a08c:	0f 85 85 00 00 00    	jne    f9a117 <do_write_oneword_once+0x297>
0212   f9a092:	e8 00 00 00 00       	call   f9a097 <do_write_oneword_once+0x217>	f9a093: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0217   f9a097:	4c 89 ef             	mov    %r13,%rdi
021a   f9a09a:	e8 00 00 00 00       	call   f9a09f <do_write_oneword_once+0x21f>	f9a09b: R_X86_64_PLT32	mutex_unlock-0x4
021f   f9a09f:	bf 01 00 00 00       	mov    $0x1,%edi
0224   f9a0a4:	e8 00 00 00 00       	call   f9a0a9 <do_write_oneword_once+0x229>	f9a0a5: R_X86_64_PLT32	cfi_udelay-0x4
0229   f9a0a9:	31 f6                	xor    %esi,%esi
022b   f9a0ab:	4c 89 ef             	mov    %r13,%rdi
022e   f9a0ae:	e8 00 00 00 00       	call   f9a0b3 <do_write_oneword_once+0x233>	f9a0af: R_X86_64_PLT32	mutex_lock_nested-0x4
0233   f9a0b3:	e9 c0 fe ff ff       	jmp    f99f78 <do_write_oneword_once+0xf8>
0238   f9a0b8:	e8 00 00 00 00       	call   f9a0bd <do_write_oneword_once+0x23d>	f9a0b9: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
023d   f9a0bd:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
0242   f9a0c2:	48 89 e9             	mov    %rbp,%rcx
0245   f9a0c5:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
024a   f9a0ca:	83 e2 01             	and    $0x1,%edx
024d   f9a0cd:	48 0f 44 c8          	cmove  %rax,%rcx
0251   f9a0d1:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
0256   f9a0d6:	e8 00 00 00 00       	call   f9a0db <do_write_oneword_once+0x25b>	f9a0d7: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
025b   f9a0db:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
0260   f9a0e0:	48 89 de             	mov    %rbx,%rsi
0263   f9a0e3:	4c 89 e7             	mov    %r12,%rdi
0266   f9a0e6:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
026b   f9a0eb:	e8 50 f8 ff ff       	call   f99940 <chip_ready>
0270   f9a0f0:	85 c0                	test   %eax,%eax
0272   f9a0f2:	0f 85 56 ff ff ff    	jne    f9a04e <do_write_oneword_once+0x1ce>
0278   f9a0f8:	e8 00 00 00 00       	call   f9a0fd <do_write_oneword_once+0x27d>	f9a0f9: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
027d   f9a0fd:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	f9a100: R_X86_64_32S	.rodata+0x13fe40
0284   f9a104:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	f9a107: R_X86_64_32S	.rodata.str1.1+0x5a2e8
028b   f9a10b:	e8 00 00 00 00       	call   f9a110 <do_write_oneword_once+0x290>	f9a10c: R_X86_64_PLT32	_printk-0x4
0290   f9a110:	bb fb ff ff ff       	mov    $0xfffffffb,%ebx
0295   f9a115:	eb 1b                	jmp    f9a132 <do_write_oneword_once+0x2b2>
0297   f9a117:	e8 00 00 00 00       	call   f9a11c <do_write_oneword_once+0x29c>	f9a118: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
029c   f9a11c:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
02a1   f9a121:	48 89 de             	mov    %rbx,%rsi
02a4   f9a124:	4c 89 e7             	mov    %r12,%rdi
02a7   f9a127:	e8 d4 f4 ff ff       	call   f99600 <cfi_check_err_status>
02ac   f9a12c:	89 c3                	mov    %eax,%ebx
02ae   f9a12e:	85 c0                	test   %eax,%eax
02b0   f9a130:	75 de                	jne    f9a110 <do_write_oneword_once+0x290>
02b2   f9a132:	e8 00 00 00 00       	call   f9a137 <do_write_oneword_once+0x2b7>	f9a133: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02b7   f9a137:	89 d8                	mov    %ebx,%eax
02b9   f9a139:	48 83 c4 50          	add    $0x50,%rsp
02bd   f9a13d:	5b                   	pop    %rbx
02be   f9a13e:	5d                   	pop    %rbp
02bf   f9a13f:	41 5c                	pop    %r12
02c1   f9a141:	41 5d                	pop    %r13
02c3   f9a143:	41 5e                	pop    %r14
02c5   f9a145:	41 5f                	pop    %r15
02c7   f9a147:	31 d2                	xor    %edx,%edx
02c9   f9a149:	31 c9                	xor    %ecx,%ecx
02cb   f9a14b:	31 f6                	xor    %esi,%esi
02cd   f9a14d:	31 ff                	xor    %edi,%edi
02cf   f9a14f:	45 31 c0             	xor    %r8d,%r8d
02d2   f9a152:	45 31 c9             	xor    %r9d,%r9d
02d5   f9a155:	e9 00 00 00 00       	jmp    f9a15a <do_write_oneword_once+0x2da>	f9a156: R_X86_64_PLT32	__x86_return_thunk-0x4
02da   f9a15a:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02e5   f9a165:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02f0   f9a170:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
02fb   f9a17b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
0000 0000000000f9b4c0 <do_write_oneword>:
0000   f9b4c0:	41 57                	push   %r15
0002   f9b4c2:	41 56                	push   %r14
0004   f9b4c4:	45 89 c6             	mov    %r8d,%r14d
0007   f9b4c7:	41 55                	push   %r13
0009   f9b4c9:	49 89 d5             	mov    %rdx,%r13
000c   f9b4cc:	41 54                	push   %r12
000e   f9b4ce:	55                   	push   %rbp
000f   f9b4cf:	48 89 f5             	mov    %rsi,%rbp
0012   f9b4d2:	53                   	push   %rbx
0013   f9b4d3:	48 89 fb             	mov    %rdi,%rbx
0016   f9b4d6:	48 83 ec 28          	sub    $0x28,%rsp
001a   f9b4da:	48 89 0c 24          	mov    %rcx,(%rsp)
001e   f9b4de:	e8 00 00 00 00       	call   f9b4e3 <do_write_oneword+0x23>	f9b4df: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0023   f9b4e3:	48 8d 45 28          	lea    0x28(%rbp),%rax
0027   f9b4e7:	4c 03 6d 00          	add    0x0(%rbp),%r13
002b   f9b4eb:	31 f6                	xor    %esi,%esi
002d   f9b4ed:	48 89 c7             	mov    %rax,%rdi
0030   f9b4f0:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
0035   f9b4f5:	e8 00 00 00 00       	call   f9b4fa <do_write_oneword+0x3a>	f9b4f6: R_X86_64_PLT32	mutex_lock_nested-0x4
003a   f9b4fa:	44 89 f1             	mov    %r14d,%ecx
003d   f9b4fd:	4c 89 ea             	mov    %r13,%rdx
0040   f9b500:	48 89 ee             	mov    %rbp,%rsi
0043   f9b503:	48 89 df             	mov    %rbx,%rdi
0046   f9b506:	e8 f5 fb ff ff       	call   f9b100 <get_chip>
004b   f9b50b:	41 89 c4             	mov    %eax,%r12d
004e   f9b50e:	85 c0                	test   %eax,%eax
0050   f9b510:	0f 85 98 02 00 00    	jne    f9b7ae <do_write_oneword+0x2ee>
0056   f9b516:	e8 00 00 00 00       	call   f9b51b <do_write_oneword+0x5b>	f9b517: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
005b   f9b51b:	4c 8b bb 80 00 00 00 	mov    0x80(%rbx),%r15
0062   f9b522:	41 83 fe 09          	cmp    $0x9,%r14d
0066   f9b526:	0f 84 8b 00 00 00    	je     f9b5b7 <do_write_oneword+0xf7>
006c   f9b52c:	e8 00 00 00 00       	call   f9b531 <do_write_oneword+0x71>	f9b52d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0071   f9b531:	48 8b 43 30          	mov    0x30(%rbx),%rax
0075   f9b535:	4c 89 ee             	mov    %r13,%rsi
0078   f9b538:	48 89 df             	mov    %rbx,%rdi
007b   f9b53b:	e8 00 00 00 00       	call   f9b540 <do_write_oneword+0x80>	f9b53c: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0080   f9b540:	48 39 04 24          	cmp    %rax,(%rsp)
0084   f9b544:	0f 85 18 01 00 00    	jne    f9b662 <do_write_oneword+0x1a2>
008a   f9b54a:	e8 00 00 00 00       	call   f9b54f <do_write_oneword+0x8f>	f9b54b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
008f   f9b54f:	e8 00 00 00 00       	call   f9b554 <do_write_oneword+0x94>	f9b550: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0094   f9b554:	c7 45 0c 00 00 00 00 	movl   $0x0,0xc(%rbp)
009b   f9b55b:	4c 8b 6b 58          	mov    0x58(%rbx),%r13
009f   f9b55f:	4d 85 ed             	test   %r13,%r13
00a2   f9b562:	74 10                	je     f9b574 <do_write_oneword+0xb4>
00a4   f9b564:	e8 00 00 00 00       	call   f9b569 <do_write_oneword+0xa9>	f9b565: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00a9   f9b569:	31 f6                	xor    %esi,%esi
00ab   f9b56b:	48 89 df             	mov    %rbx,%rdi
00ae   f9b56e:	2e e8 00 00 00 00    	cs call f9b574 <do_write_oneword+0xb4>	f9b570: R_X86_64_PLT32	__x86_indirect_thunk_r13-0x4
00b4   f9b574:	e8 00 00 00 00       	call   f9b579 <do_write_oneword+0xb9>	f9b575: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00b9   f9b579:	48 89 df             	mov    %rbx,%rdi
00bc   f9b57c:	48 89 ee             	mov    %rbp,%rsi
00bf   f9b57f:	e8 7c f9 ff ff       	call   f9af00 <put_chip.isra.0>
00c4   f9b584:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
00c9   f9b589:	e8 00 00 00 00       	call   f9b58e <do_write_oneword+0xce>	f9b58a: R_X86_64_PLT32	mutex_unlock-0x4
00ce   f9b58e:	e8 00 00 00 00       	call   f9b593 <do_write_oneword+0xd3>	f9b58f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00d3   f9b593:	44 89 e0             	mov    %r12d,%eax
00d6   f9b596:	48 83 c4 28          	add    $0x28,%rsp
00da   f9b59a:	5b                   	pop    %rbx
00db   f9b59b:	5d                   	pop    %rbp
00dc   f9b59c:	41 5c                	pop    %r12
00de   f9b59e:	41 5d                	pop    %r13
00e0   f9b5a0:	41 5e                	pop    %r14
00e2   f9b5a2:	41 5f                	pop    %r15
00e4   f9b5a4:	31 d2                	xor    %edx,%edx
00e6   f9b5a6:	31 c9                	xor    %ecx,%ecx
00e8   f9b5a8:	31 f6                	xor    %esi,%esi
00ea   f9b5aa:	31 ff                	xor    %edi,%edi
00ec   f9b5ac:	45 31 c0             	xor    %r8d,%r8d
00ef   f9b5af:	45 31 c9             	xor    %r9d,%r9d
00f2   f9b5b2:	e9 00 00 00 00       	jmp    f9b5b7 <do_write_oneword+0xf7>	f9b5b3: R_X86_64_PLT32	__x86_return_thunk-0x4
00f7   f9b5b7:	e8 00 00 00 00       	call   f9b5bc <do_write_oneword+0xfc>	f9b5b8: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00fc   f9b5bc:	45 8b 4f 14          	mov    0x14(%r15),%r9d
0100   f9b5c0:	41 8b 77 1c          	mov    0x1c(%r15),%esi
0104   f9b5c4:	4d 89 f8             	mov    %r15,%r8
0107   f9b5c7:	6a 00                	push   $0x0
0109   f9b5c9:	8b 55 00             	mov    0x0(%rbp),%edx
010c   f9b5cc:	48 89 d9             	mov    %rbx,%rcx
010f   f9b5cf:	bf aa 00 00 00       	mov    $0xaa,%edi
0114   f9b5d4:	e8 00 00 00 00       	call   f9b5d9 <do_write_oneword+0x119>	f9b5d5: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0119   f9b5d9:	45 8b 4f 14          	mov    0x14(%r15),%r9d
011d   f9b5dd:	41 8b 77 20          	mov    0x20(%r15),%esi
0121   f9b5e1:	4d 89 f8             	mov    %r15,%r8
0124   f9b5e4:	6a 00                	push   $0x0
0126   f9b5e6:	8b 55 00             	mov    0x0(%rbp),%edx
0129   f9b5e9:	48 89 d9             	mov    %rbx,%rcx
012c   f9b5ec:	bf 55 00 00 00       	mov    $0x55,%edi
0131   f9b5f1:	e8 00 00 00 00       	call   f9b5f6 <do_write_oneword+0x136>	f9b5f2: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0136   f9b5f6:	45 8b 4f 14          	mov    0x14(%r15),%r9d
013a   f9b5fa:	41 8b 77 1c          	mov    0x1c(%r15),%esi
013e   f9b5fe:	4d 89 f8             	mov    %r15,%r8
0141   f9b601:	6a 00                	push   $0x0
0143   f9b603:	8b 55 00             	mov    0x0(%rbp),%edx
0146   f9b606:	48 89 d9             	mov    %rbx,%rcx
0149   f9b609:	bf 88 00 00 00       	mov    $0x88,%edi
014e   f9b60e:	e8 00 00 00 00       	call   f9b613 <do_write_oneword+0x153>	f9b60f: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0153   f9b613:	4c 8b 7b 50          	mov    0x50(%rbx),%r15
0157   f9b617:	48 83 c4 18          	add    $0x18,%rsp
015b   f9b61b:	4d 85 ff             	test   %r15,%r15
015e   f9b61e:	74 1a                	je     f9b63a <do_write_oneword+0x17a>
0160   f9b620:	e8 00 00 00 00       	call   f9b625 <do_write_oneword+0x165>	f9b621: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0165   f9b625:	48 8b 75 00          	mov    0x0(%rbp),%rsi
0169   f9b629:	ba 02 00 00 00       	mov    $0x2,%edx
016e   f9b62e:	48 89 df             	mov    %rbx,%rdi
0171   f9b631:	4c 01 ee             	add    %r13,%rsi
0174   f9b634:	2e e8 00 00 00 00    	cs call f9b63a <do_write_oneword+0x17a>	f9b636: R_X86_64_PLT32	__x86_indirect_thunk_r15-0x4
017a   f9b63a:	e8 00 00 00 00       	call   f9b63f <do_write_oneword+0x17f>	f9b63b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
017f   f9b63f:	48 8b 43 30          	mov    0x30(%rbx),%rax
0183   f9b643:	4c 89 ee             	mov    %r13,%rsi
0186   f9b646:	48 89 df             	mov    %rbx,%rdi
0189   f9b649:	4c 8b bb 80 00 00 00 	mov    0x80(%rbx),%r15
0190   f9b650:	e8 00 00 00 00       	call   f9b655 <do_write_oneword+0x195>	f9b651: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0195   f9b655:	48 8b 0c 24          	mov    (%rsp),%rcx
0199   f9b659:	48 39 c8             	cmp    %rcx,%rax
019c   f9b65c:	0f 84 60 01 00 00    	je     f9b7c2 <do_write_oneword+0x302>
01a2   f9b662:	e8 00 00 00 00       	call   f9b667 <do_write_oneword+0x1a7>	f9b663: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01a7   f9b667:	4c 8b 63 58          	mov    0x58(%rbx),%r12
01ab   f9b66b:	4d 85 e4             	test   %r12,%r12
01ae   f9b66e:	74 13                	je     f9b683 <do_write_oneword+0x1c3>
01b0   f9b670:	e8 00 00 00 00       	call   f9b675 <do_write_oneword+0x1b5>	f9b671: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01b5   f9b675:	be 01 00 00 00       	mov    $0x1,%esi
01ba   f9b67a:	48 89 df             	mov    %rbx,%rdi
01bd   f9b67d:	2e e8 00 00 00 00    	cs call f9b683 <do_write_oneword+0x1c3>	f9b67f: R_X86_64_PLT32	__x86_indirect_thunk_r12-0x4
01c3   f9b683:	c7 44 24 24 04 00 00 00 	movl   $0x4,0x24(%rsp)
01cb   f9b68b:	e8 00 00 00 00       	call   f9b690 <do_write_oneword+0x1d0>	f9b68c: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01d0   f9b690:	48 8b 0c 24          	mov    (%rsp),%rcx
01d4   f9b694:	4d 89 f9             	mov    %r15,%r9
01d7   f9b697:	45 89 f0             	mov    %r14d,%r8d
01da   f9b69a:	4c 89 ea             	mov    %r13,%rdx
01dd   f9b69d:	48 89 ee             	mov    %rbp,%rsi
01e0   f9b6a0:	48 89 df             	mov    %rbx,%rdi
01e3   f9b6a3:	e8 d8 e7 ff ff       	call   f99e80 <do_write_oneword_once>
01e8   f9b6a8:	41 89 c4             	mov    %eax,%r12d
01eb   f9b6ab:	85 c0                	test   %eax,%eax
01ed   f9b6ad:	74 43                	je     f9b6f2 <do_write_oneword+0x232>
01ef   f9b6af:	e8 00 00 00 00       	call   f9b6b4 <do_write_oneword+0x1f4>	f9b6b0: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
01f4   f9b6b4:	48 8b 4b 40          	mov    0x40(%rbx),%rcx
01f8   f9b6b8:	48 8b 45 00          	mov    0x0(%rbp),%rax
01fc   f9b6bc:	4c 89 fa             	mov    %r15,%rdx
01ff   f9b6bf:	48 89 de             	mov    %rbx,%rsi
0202   f9b6c2:	bf f0 00 00 00       	mov    $0xf0,%edi
0207   f9b6c7:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
020c   f9b6cc:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0211   f9b6d1:	e8 00 00 00 00       	call   f9b6d6 <do_write_oneword+0x216>	f9b6d2: R_X86_64_PLT32	cfi_build_cmd-0x4
0216   f9b6d6:	48 89 df             	mov    %rbx,%rdi
0219   f9b6d9:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
021e   f9b6de:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
0223   f9b6e3:	48 89 c6             	mov    %rax,%rsi
0226   f9b6e6:	e8 00 00 00 00       	call   f9b6eb <do_write_oneword+0x22b>	f9b6e7: R_X86_64_PLT32	__x86_indirect_thunk_rcx-0x4
022b   f9b6eb:	83 6c 24 24 01       	subl   $0x1,0x24(%rsp)
0230   f9b6f0:	75 99                	jne    f9b68b <do_write_oneword+0x1cb>
0232   f9b6f2:	e8 00 00 00 00       	call   f9b6f7 <do_write_oneword+0x237>	f9b6f3: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0237   f9b6f7:	41 83 fe 09          	cmp    $0x9,%r14d
023b   f9b6fb:	0f 85 4e fe ff ff    	jne    f9b54f <do_write_oneword+0x8f>
0241   f9b701:	e8 00 00 00 00       	call   f9b706 <do_write_oneword+0x246>	f9b702: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0246   f9b706:	4c 8b b3 80 00 00 00 	mov    0x80(%rbx),%r14
024d   f9b70d:	48 89 d9             	mov    %rbx,%rcx
0250   f9b710:	bf aa 00 00 00       	mov    $0xaa,%edi
0255   f9b715:	45 8b 4e 14          	mov    0x14(%r14),%r9d
0259   f9b719:	41 8b 76 1c          	mov    0x1c(%r14),%esi
025d   f9b71d:	6a 00                	push   $0x0
025f   f9b71f:	4d 89 f0             	mov    %r14,%r8
0262   f9b722:	8b 55 00             	mov    0x0(%rbp),%edx
0265   f9b725:	e8 00 00 00 00       	call   f9b72a <do_write_oneword+0x26a>	f9b726: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
026a   f9b72a:	45 8b 4e 14          	mov    0x14(%r14),%r9d
026e   f9b72e:	41 8b 76 20          	mov    0x20(%r14),%esi
0272   f9b732:	4d 89 f0             	mov    %r14,%r8
0275   f9b735:	6a 00                	push   $0x0
0277   f9b737:	8b 55 00             	mov    0x0(%rbp),%edx
027a   f9b73a:	48 89 d9             	mov    %rbx,%rcx
027d   f9b73d:	bf 55 00 00 00       	mov    $0x55,%edi
0282   f9b742:	e8 00 00 00 00       	call   f9b747 <do_write_oneword+0x287>	f9b743: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0287   f9b747:	45 8b 4e 14          	mov    0x14(%r14),%r9d
028b   f9b74b:	41 8b 76 1c          	mov    0x1c(%r14),%esi
028f   f9b74f:	4d 89 f0             	mov    %r14,%r8
0292   f9b752:	6a 00                	push   $0x0
0294   f9b754:	8b 55 00             	mov    0x0(%rbp),%edx
0297   f9b757:	48 89 d9             	mov    %rbx,%rcx
029a   f9b75a:	bf 90 00 00 00       	mov    $0x90,%edi
029f   f9b75f:	e8 00 00 00 00       	call   f9b764 <do_write_oneword+0x2a4>	f9b760: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
02a4   f9b764:	45 8b 4e 14          	mov    0x14(%r14),%r9d
02a8   f9b768:	41 8b 76 1c          	mov    0x1c(%r14),%esi
02ac   f9b76c:	4d 89 f0             	mov    %r14,%r8
02af   f9b76f:	6a 00                	push   $0x0
02b1   f9b771:	8b 55 00             	mov    0x0(%rbp),%edx
02b4   f9b774:	48 89 d9             	mov    %rbx,%rcx
02b7   f9b777:	31 ff                	xor    %edi,%edi
02b9   f9b779:	e8 00 00 00 00       	call   f9b77e <do_write_oneword+0x2be>	f9b77a: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
02be   f9b77e:	4c 8b 73 50          	mov    0x50(%rbx),%r14
02c2   f9b782:	48 83 c4 20          	add    $0x20,%rsp
02c6   f9b786:	4d 85 f6             	test   %r14,%r14
02c9   f9b789:	0f 84 c0 fd ff ff    	je     f9b54f <do_write_oneword+0x8f>
02cf   f9b78f:	e8 00 00 00 00       	call   f9b794 <do_write_oneword+0x2d4>	f9b790: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02d4   f9b794:	48 8b 75 00          	mov    0x0(%rbp),%rsi
02d8   f9b798:	ba 02 00 00 00       	mov    $0x2,%edx
02dd   f9b79d:	48 89 df             	mov    %rbx,%rdi
02e0   f9b7a0:	4c 01 ee             	add    %r13,%rsi
02e3   f9b7a3:	2e e8 00 00 00 00    	cs call f9b7a9 <do_write_oneword+0x2e9>	f9b7a5: R_X86_64_PLT32	__x86_indirect_thunk_r14-0x4
02e9   f9b7a9:	e9 a1 fd ff ff       	jmp    f9b54f <do_write_oneword+0x8f>
02ee   f9b7ae:	e8 00 00 00 00       	call   f9b7b3 <do_write_oneword+0x2f3>	f9b7af: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02f3   f9b7b3:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
02f8   f9b7b8:	e8 00 00 00 00       	call   f9b7bd <do_write_oneword+0x2fd>	f9b7b9: R_X86_64_PLT32	mutex_unlock-0x4
02fd   f9b7bd:	e9 cc fd ff ff       	jmp    f9b58e <do_write_oneword+0xce>
0302   f9b7c2:	e8 00 00 00 00       	call   f9b7c7 <do_write_oneword+0x307>	f9b7c3: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0307   f9b7c7:	e9 35 ff ff ff       	jmp    f9b701 <do_write_oneword+0x241>
030c   f9b7cc:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
0317   f9b7d7:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
0322   f9b7e2:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
032d   f9b7ed:	66 66 2e 0f 1f 84 00 00 00 00 00 	data16 cs nopw 0x0(%rax,%rax,1)
0338   f9b7f8:	0f 1f 84 00 00 00 00 00 	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

