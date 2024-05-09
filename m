Return-Path: <linux-kernel+bounces-174018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465288C0936
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB98A281F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B2A3D548;
	Thu,  9 May 2024 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OirVWCfO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526BE10979
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218737; cv=none; b=l7BjVAE0yTwJpZAEWoo41T45oyVe8A2eQ3ukIABZUxwp1bkTsWJvYVsjlnQMTwVRmaQiyES646IPlt88vzqqHdLgEvSTT42sUsbzj1LjBFGJ7HZrojeJSLKGzCHPO2I9q533jGNXj7V4z5hbnxzEiGQJoUtGfxLVQu+YRUKuK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218737; c=relaxed/simple;
	bh=i506avOxHe02oo3krEuR1rkqC3CIfva8GpPJrBKOl2c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C1nWYb0V75mng0mdaTQiMXED/cYXph33XEoeQJZkLtJdSrwJxcRdxECDViJHac16ZUbiPKD1R576cnj18rviJxYQKRwfCwbcrmHcTFi6ad/iSRYBlSU1MP2mFD+mXDhttz11Cdi7rvAqOtW9rnaIdb2qjPMciPrhy8LDTDFCDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OirVWCfO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715218735; x=1746754735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i506avOxHe02oo3krEuR1rkqC3CIfva8GpPJrBKOl2c=;
  b=OirVWCfOtbsfTTKoD3S9cvdd7vTd2tKuXSvwZI0aBeCJc1NthJ0Z51GW
   bkgbMKvj1YdMujc/6zWWyS2Jllux2XEm5MaZx1FUJSYndOsgrysusJswp
   W73GcpVRUV7l3lUDMRhkiiiuxxNlXdpF3dYDvZ0I9i2hoZqSD1MYT//su
   LPb3OlJuRXfcrFTGF02C15SauT9QzNAS84eBtRWfjE+OeLGOa92iDXSOP
   h7Ucq+gomALYHi6RCH33G1Nc4L/kx7nMRm+LO8TuwQa9oriK00aOh33HS
   ObCQm/CaOcQgRKPU2b0dllbqI7mYt3aTIXMnJ6uaXz8iud+WOAc8f3aab
   g==;
X-CSE-ConnectionGUID: 4LSQZ2X2TuyDX9ZXiKI3Jg==
X-CSE-MsgGUID: WXQ0FhXFQvOYTVh/fFkB5A==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11239321"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11239321"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 18:38:54 -0700
X-CSE-ConnectionGUID: V+WEnVq9SwS7hXoyVvRHVw==
X-CSE-MsgGUID: KBSK4t3bTR2AkbsA8F4C1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="33612397"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 08 May 2024 18:38:51 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4skD-0004Kd-2C;
	Thu, 09 May 2024 01:38:49 +0000
Date: Thu, 9 May 2024 09:38:24 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: vmlinux.o: warning: objtool: do_panic_write_oneword+0x129:
 cfi_build_cmd() is missing a __noreturn annotation
Message-ID: <202405090918.Tc20z6kq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   45db3ab70092637967967bfd8e6144017638563c
commit: 719a937b7003933de1298ffa4b881dd6a234e244 iov_iter: Mark copy_iovec_from_user() noclone
date:   10 months ago
config: x86_64-randconfig-003-20240509 (https://download.01.org/0day-ci/archive/20240509/202405090918.Tc20z6kq-lkp@intel.com/config)
compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240509/202405090918.Tc20z6kq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405090918.Tc20z6kq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: fixup_sst39vf_rev_b+0x131: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_resume+0x19d: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_check_err_status+0x170: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: chip_ready+0x155: cfi_build_cmd() is missing a __noreturn annotation
>> vmlinux.o: warning: objtool: do_panic_write_oneword+0x129: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_oneword_once+0x115: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: fixup_sst38vf640x_sectorsize+0x142: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: put_chip.constprop.0+0x34b: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: get_chip+0x41d: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_oneword+0x2b6: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_atmel_unlock+0x173: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_atmel_lock+0x17a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x172: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_otp_lock+0x16a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_chip+0x34b: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_write_buffer+0x19a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_erase_oneblock+0x351: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_ppb_xxlock+0x12e: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_read+0x279: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_otp_walk+0x26c: cfi_qry_mode_on() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_reset.isra.0+0x1a4: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_amdstd_secsi_read+0x3a7: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_otp_write+0xe5: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: do_read_secsi_onechip+0x28f: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: jedec_reset+0x9a: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: cfi_jedec_setup+0x3b7: cfi_build_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: jedec_probe_chip+0x2f2: cfi_send_gen_cmd() is missing a __noreturn annotation
   vmlinux.o: warning: objtool: jedec_probe_chip.cold+0x0: unreachable instruction


objdump-func vmlinux.o do_panic_write_oneword:
0000 0000000001a53a00 <do_panic_write_oneword>:
0000  1a53a00:	e8 00 00 00 00       	call   1a53a05 <do_panic_write_oneword+0x5>	1a53a01: R_X86_64_PLT32	__fentry__-0x4
0005  1a53a05:	41 57                	push   %r15
0007  1a53a07:	41 56                	push   %r14
0009  1a53a09:	41 55                	push   %r13
000b  1a53a0b:	41 54                	push   %r12
000d  1a53a0d:	55                   	push   %rbp
000e  1a53a0e:	48 89 fd             	mov    %rdi,%rbp
0011  1a53a11:	53                   	push   %rbx
0012  1a53a12:	48 89 f3             	mov    %rsi,%rbx
0015  1a53a15:	48 81 ec b0 00 00 00 	sub    $0xb0,%rsp
001c  1a53a1c:	48 c7 44 24 70 b3 8a b5 41 	movq   $0x41b58ab3,0x70(%rsp)
0025  1a53a25:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
002a  1a53a2a:	48 c7 44 24 78 00 00 00 00 	movq   $0x0,0x78(%rsp)	1a53a2f: R_X86_64_32S	.rodata.str1.1+0xd9a6a
0033  1a53a33:	48 c1 e8 03          	shr    $0x3,%rax
0037  1a53a37:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
003c  1a53a3c:	48 89 c6             	mov    %rax,%rsi
003f  1a53a3f:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0049  1a53a49:	48 c7 84 24 80 00 00 00 00 00 00 00 	movq   $0x0,0x80(%rsp)	1a53a51: R_X86_64_32S	.text+0x1a53a00
0055  1a53a55:	48 01 c6             	add    %rax,%rsi
0058  1a53a58:	c7 06 f1 f1 f1 f1    	movl   $0xf1f1f1f1,(%rsi)
005e  1a53a5e:	c7 46 04 00 f3 f3 f3 	movl   $0xf3f3f300,0x4(%rsi)
0065  1a53a65:	e8 00 00 00 00       	call   1a53a6a <do_panic_write_oneword+0x6a>	1a53a66: R_X86_64_PLT32	stackleak_track_stack-0x4
006a  1a53a6a:	48 83 c7 60          	add    $0x60,%rdi
006e  1a53a6e:	48 89 8c 24 90 00 00 00 	mov    %rcx,0x90(%rsp)
0076  1a53a76:	48 89 f9             	mov    %rdi,%rcx
0079  1a53a79:	48 c1 e9 03          	shr    $0x3,%rcx
007d  1a53a7d:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
0081  1a53a81:	0f 85 0b 06 00 00    	jne    1a54092 <do_panic_write_oneword+0x692>
0087  1a53a87:	48 89 d9             	mov    %rbx,%rcx
008a  1a53a8a:	4c 8b 7d 60          	mov    0x60(%rbp),%r15
008e  1a53a8e:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0098  1a53a98:	48 c1 e9 03          	shr    $0x3,%rcx
009c  1a53a9c:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
00a0  1a53aa0:	0f 85 d7 05 00 00    	jne    1a5407d <do_panic_write_oneword+0x67d>
00a6  1a53aa6:	4c 8b 23             	mov    (%rbx),%r12
00a9  1a53aa9:	48 8d 7b 0c          	lea    0xc(%rbx),%rdi
00ad  1a53aad:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
00b7  1a53ab7:	4d 8d 34 14          	lea    (%r12,%rdx,1),%r14
00bb  1a53abb:	48 89 fa             	mov    %rdi,%rdx
00be  1a53abe:	48 c1 ea 03          	shr    $0x3,%rdx
00c2  1a53ac2:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
00c6  1a53ac6:	48 89 f8             	mov    %rdi,%rax
00c9  1a53ac9:	83 e0 07             	and    $0x7,%eax
00cc  1a53acc:	83 c0 03             	add    $0x3,%eax
00cf  1a53acf:	38 d0                	cmp    %dl,%al
00d1  1a53ad1:	7c 08                	jl     1a53adb <do_panic_write_oneword+0xdb>
00d3  1a53ad3:	84 d2                	test   %dl,%dl
00d5  1a53ad5:	0f 85 98 05 00 00    	jne    1a54073 <do_panic_write_oneword+0x673>
00db  1a53adb:	8b 7b 0c             	mov    0xc(%rbx),%edi
00de  1a53ade:	85 ff                	test   %edi,%edi
00e0  1a53ae0:	0f 84 12 04 00 00    	je     1a53ef8 <do_panic_write_oneword+0x4f8>
00e6  1a53ae6:	48 8d 45 18          	lea    0x18(%rbp),%rax
00ea  1a53aea:	48 89 da             	mov    %rbx,%rdx
00ed  1a53aed:	c7 04 24 0a 00 00 00 	movl   $0xa,(%rsp)
00f4  1a53af4:	49 89 c5             	mov    %rax,%r13
00f7  1a53af7:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
00fc  1a53afc:	48 c1 ea 03          	shr    $0x3,%rdx
0100  1a53b00:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
010a  1a53b0a:	49 c1 ed 03          	shr    $0x3,%r13
010e  1a53b0e:	49 01 c5             	add    %rax,%r13
0111  1a53b11:	48 01 d0             	add    %rdx,%rax
0114  1a53b14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
0119  1a53b19:	4c 89 fa             	mov    %r15,%rdx
011c  1a53b1c:	48 89 ee             	mov    %rbp,%rsi
011f  1a53b1f:	bf f0 00 00 00       	mov    $0xf0,%edi
0124  1a53b24:	e8 00 00 00 00       	call   1a53b29 <do_panic_write_oneword+0x129>	1a53b25: R_X86_64_PLT32	cfi_build_cmd-0x4
0129  1a53b29:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
012e  1a53b2e:	0f 85 20 04 00 00    	jne    1a53f54 <do_panic_write_oneword+0x554>
0134  1a53b34:	4c 03 65 18          	add    0x18(%rbp),%r12
0138  1a53b38:	41 88 04 24          	mov    %al,(%r12)
013c  1a53b3c:	0f ae f0             	mfence
013f  1a53b3f:	45 31 e4             	xor    %r12d,%r12d
0142  1a53b42:	eb 22                	jmp    1a53b66 <do_panic_write_oneword+0x166>
0144  1a53b44:	31 c9                	xor    %ecx,%ecx
0146  1a53b46:	4c 89 f2             	mov    %r14,%rdx
0149  1a53b49:	48 89 de             	mov    %rbx,%rsi
014c  1a53b4c:	48 89 ef             	mov    %rbp,%rdi
014f  1a53b4f:	e8 bc fb ff ff       	call   1a53710 <chip_ready>
0154  1a53b54:	85 c0                	test   %eax,%eax
0156  1a53b56:	75 43                	jne    1a53b9b <do_panic_write_oneword+0x19b>
0158  1a53b58:	bf c7 10 00 00       	mov    $0x10c7,%edi
015d  1a53b5d:	41 83 c4 01          	add    $0x1,%r12d
0161  1a53b61:	e8 00 00 00 00       	call   1a53b66 <do_panic_write_oneword+0x166>	1a53b62: R_X86_64_PLT32	__const_udelay-0x4
0166  1a53b66:	bf 01 00 00 00       	mov    $0x1,%edi
016b  1a53b6b:	e8 00 00 00 00       	call   1a53b70 <do_panic_write_oneword+0x170>	1a53b6c: R_X86_64_PLT32	jiffies_to_usecs-0x4
0170  1a53b70:	41 39 c4             	cmp    %eax,%r12d
0173  1a53b73:	72 cf                	jb     1a53b44 <do_panic_write_oneword+0x144>
0175  1a53b75:	83 2c 24 01          	subl   $0x1,(%rsp)
0179  1a53b79:	0f 84 b4 03 00 00    	je     1a53f33 <do_panic_write_oneword+0x533>
017f  1a53b7f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
0184  1a53b84:	80 38 00             	cmpb   $0x0,(%rax)
0187  1a53b87:	0f 85 26 05 00 00    	jne    1a540b3 <do_panic_write_oneword+0x6b3>
018d  1a53b8d:	4c 8b 23             	mov    (%rbx),%r12
0190  1a53b90:	eb 87                	jmp    1a53b19 <do_panic_write_oneword+0x119>
0192  1a53b92:	48 8d 45 18          	lea    0x18(%rbp),%rax
0196  1a53b96:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
019b  1a53b9b:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
01a5  1a53ba5:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
01aa  1a53baa:	48 c1 ea 03          	shr    $0x3,%rdx
01ae  1a53bae:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
01b2  1a53bb2:	0f 85 ec 04 00 00    	jne    1a540a4 <do_panic_write_oneword+0x6a4>
01b8  1a53bb8:	48 8b 45 18          	mov    0x18(%rbp),%rax
01bc  1a53bbc:	4c 01 f0             	add    %r14,%rax
01bf  1a53bbf:	44 8a 20             	mov    (%rax),%r12b
01c2  1a53bc2:	48 8d 84 24 90 00 00 00 	lea    0x90(%rsp),%rax
01ca  1a53bca:	45 0f b6 e4          	movzbl %r12b,%r12d
01ce  1a53bce:	48 89 c2             	mov    %rax,%rdx
01d1  1a53bd1:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
01d6  1a53bd6:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
01e0  1a53be0:	48 c1 ea 03          	shr    $0x3,%rdx
01e4  1a53be4:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
01e8  1a53be8:	0f 85 e1 04 00 00    	jne    1a540cf <do_panic_write_oneword+0x6cf>
01ee  1a53bee:	48 8d 45 38          	lea    0x38(%rbp),%rax
01f2  1a53bf2:	4c 39 a4 24 90 00 00 00 	cmp    %r12,0x90(%rsp)
01fa  1a53bfa:	48 89 44 24 48       	mov    %rax,0x48(%rsp)
01ff  1a53bff:	75 5c                	jne    1a53c5d <do_panic_write_oneword+0x25d>
0201  1a53c01:	45 31 e4             	xor    %r12d,%r12d
0204  1a53c04:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
020e  1a53c0e:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
0213  1a53c13:	48 c1 ea 03          	shr    $0x3,%rdx
0217  1a53c17:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
021b  1a53c1b:	0f 85 9f 04 00 00    	jne    1a540c0 <do_panic_write_oneword+0x6c0>
0221  1a53c21:	48 8b 45 38          	mov    0x38(%rbp),%rax
0225  1a53c25:	48 85 c0             	test   %rax,%rax
0228  1a53c28:	74 07                	je     1a53c31 <do_panic_write_oneword+0x231>
022a  1a53c2a:	31 f6                	xor    %esi,%esi
022c  1a53c2c:	48 89 ef             	mov    %rbp,%rdi
022f  1a53c2f:	ff d0                	call   *%rax
0231  1a53c31:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
023b  1a53c3b:	48 8b 5c 24 40       	mov    0x40(%rsp),%rbx
0240  1a53c40:	48 c7 04 03 00 00 00 00 	movq   $0x0,(%rbx,%rax,1)
0248  1a53c48:	48 81 c4 b0 00 00 00 	add    $0xb0,%rsp
024f  1a53c4f:	44 89 e0             	mov    %r12d,%eax
0252  1a53c52:	5b                   	pop    %rbx
0253  1a53c53:	5d                   	pop    %rbp
0254  1a53c54:	41 5c                	pop    %r12
0256  1a53c56:	41 5d                	pop    %r13
0258  1a53c58:	41 5e                	pop    %r14
025a  1a53c5a:	41 5f                	pop    %r15
025c  1a53c5c:	c3                   	ret
025d  1a53c5d:	48 89 c2             	mov    %rax,%rdx
0260  1a53c60:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
026a  1a53c6a:	48 c1 ea 03          	shr    $0x3,%rdx
026e  1a53c6e:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0272  1a53c72:	0f 85 66 04 00 00    	jne    1a540de <do_panic_write_oneword+0x6de>
0278  1a53c78:	48 8b 45 38          	mov    0x38(%rbp),%rax
027c  1a53c7c:	48 85 c0             	test   %rax,%rax
027f  1a53c7f:	74 0a                	je     1a53c8b <do_panic_write_oneword+0x28b>
0281  1a53c81:	be 01 00 00 00       	mov    $0x1,%esi
0286  1a53c86:	48 89 ef             	mov    %rbp,%rdi
0289  1a53c89:	ff d0                	call   *%rax
028b  1a53c8b:	49 8d 77 14          	lea    0x14(%r15),%rsi
028f  1a53c8f:	49 8d 47 20          	lea    0x20(%r15),%rax
0293  1a53c93:	49 bd 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r13
029d  1a53c9d:	c7 44 24 3c 04 00 00 00 	movl   $0x4,0x3c(%rsp)
02a5  1a53ca5:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
02aa  1a53caa:	48 89 f0             	mov    %rsi,%rax
02ad  1a53cad:	49 8d 4f 1c          	lea    0x1c(%r15),%rcx
02b1  1a53cb1:	48 c1 e8 03          	shr    $0x3,%rax
02b5  1a53cb5:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
02ba  1a53cba:	4c 01 e8             	add    %r13,%rax
02bd  1a53cbd:	48 89 74 24 50       	mov    %rsi,0x50(%rsp)
02c2  1a53cc2:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
02c7  1a53cc7:	48 89 f0             	mov    %rsi,%rax
02ca  1a53cca:	83 e0 07             	and    $0x7,%eax
02cd  1a53ccd:	83 c0 03             	add    $0x3,%eax
02d0  1a53cd0:	88 44 24 10          	mov    %al,0x10(%rsp)
02d4  1a53cd4:	48 89 d8             	mov    %rbx,%rax
02d7  1a53cd7:	48 c1 e8 03          	shr    $0x3,%rax
02db  1a53cdb:	4c 01 e8             	add    %r13,%rax
02de  1a53cde:	48 89 04 24          	mov    %rax,(%rsp)
02e2  1a53ce2:	48 89 c8             	mov    %rcx,%rax
02e5  1a53ce5:	83 e1 07             	and    $0x7,%ecx
02e8  1a53ce8:	48 c1 e8 03          	shr    $0x3,%rax
02ec  1a53cec:	4c 01 e8             	add    %r13,%rax
02ef  1a53cef:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
02f4  1a53cf4:	48 89 c8             	mov    %rcx,%rax
02f7  1a53cf7:	83 c0 03             	add    $0x3,%eax
02fa  1a53cfa:	88 44 24 3b          	mov    %al,0x3b(%rsp)
02fe  1a53cfe:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
0303  1a53d03:	0f b6 00             	movzbl (%rax),%eax
0306  1a53d06:	38 44 24 10          	cmp    %al,0x10(%rsp)
030a  1a53d0a:	7c 08                	jl     1a53d14 <do_panic_write_oneword+0x314>
030c  1a53d0c:	84 c0                	test   %al,%al
030e  1a53d0e:	0f 85 59 02 00 00    	jne    1a53f6d <do_panic_write_oneword+0x56d>
0314  1a53d14:	48 8b 04 24          	mov    (%rsp),%rax
0318  1a53d18:	45 8b 4f 14          	mov    0x14(%r15),%r9d
031c  1a53d1c:	80 38 00             	cmpb   $0x0,(%rax)
031f  1a53d1f:	0f 85 57 02 00 00    	jne    1a53f7c <do_panic_write_oneword+0x57c>
0325  1a53d25:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
032a  1a53d2a:	48 8b 13             	mov    (%rbx),%rdx
032d  1a53d2d:	0f b6 00             	movzbl (%rax),%eax
0330  1a53d30:	38 44 24 3b          	cmp    %al,0x3b(%rsp)
0334  1a53d34:	7c 08                	jl     1a53d3e <do_panic_write_oneword+0x33e>
0336  1a53d36:	84 c0                	test   %al,%al
0338  1a53d38:	0f 85 55 02 00 00    	jne    1a53f93 <do_panic_write_oneword+0x593>
033e  1a53d3e:	41 8b 77 1c          	mov    0x1c(%r15),%esi
0342  1a53d42:	6a 00                	push   $0x0
0344  1a53d44:	4d 89 f8             	mov    %r15,%r8
0347  1a53d47:	48 89 e9             	mov    %rbp,%rcx
034a  1a53d4a:	bf aa 00 00 00       	mov    $0xaa,%edi
034f  1a53d4f:	e8 00 00 00 00       	call   1a53d54 <do_panic_write_oneword+0x354>	1a53d50: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0354  1a53d54:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
0359  1a53d59:	5e                   	pop    %rsi
035a  1a53d5a:	0f b6 00             	movzbl (%rax),%eax
035d  1a53d5d:	38 44 24 10          	cmp    %al,0x10(%rsp)
0361  1a53d61:	7c 08                	jl     1a53d6b <do_panic_write_oneword+0x36b>
0363  1a53d63:	84 c0                	test   %al,%al
0365  1a53d65:	0f 85 4b 02 00 00    	jne    1a53fb6 <do_panic_write_oneword+0x5b6>
036b  1a53d6b:	48 8b 04 24          	mov    (%rsp),%rax
036f  1a53d6f:	45 8b 4f 14          	mov    0x14(%r15),%r9d
0373  1a53d73:	80 38 00             	cmpb   $0x0,(%rax)
0376  1a53d76:	0f 85 49 02 00 00    	jne    1a53fc5 <do_panic_write_oneword+0x5c5>
037c  1a53d7c:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
0381  1a53d81:	48 8b 13             	mov    (%rbx),%rdx
0384  1a53d84:	48 c1 e8 03          	shr    $0x3,%rax
0388  1a53d88:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
038d  1a53d8d:	84 c0                	test   %al,%al
038f  1a53d8f:	74 08                	je     1a53d99 <do_panic_write_oneword+0x399>
0391  1a53d91:	3c 03                	cmp    $0x3,%al
0393  1a53d93:	0f 8e 43 02 00 00    	jle    1a53fdc <do_panic_write_oneword+0x5dc>
0399  1a53d99:	41 8b 77 20          	mov    0x20(%r15),%esi
039d  1a53d9d:	6a 00                	push   $0x0
039f  1a53d9f:	48 89 e9             	mov    %rbp,%rcx
03a2  1a53da2:	4d 89 f8             	mov    %r15,%r8
03a5  1a53da5:	bf 55 00 00 00       	mov    $0x55,%edi
03aa  1a53daa:	e8 00 00 00 00       	call   1a53daf <do_panic_write_oneword+0x3af>	1a53dab: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
03af  1a53daf:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
03b4  1a53db4:	59                   	pop    %rcx
03b5  1a53db5:	0f b6 00             	movzbl (%rax),%eax
03b8  1a53db8:	38 44 24 10          	cmp    %al,0x10(%rsp)
03bc  1a53dbc:	7c 08                	jl     1a53dc6 <do_panic_write_oneword+0x3c6>
03be  1a53dbe:	84 c0                	test   %al,%al
03c0  1a53dc0:	0f 85 39 02 00 00    	jne    1a53fff <do_panic_write_oneword+0x5ff>
03c6  1a53dc6:	48 8b 04 24          	mov    (%rsp),%rax
03ca  1a53dca:	45 8b 4f 14          	mov    0x14(%r15),%r9d
03ce  1a53dce:	80 38 00             	cmpb   $0x0,(%rax)
03d1  1a53dd1:	0f 85 37 02 00 00    	jne    1a5400e <do_panic_write_oneword+0x60e>
03d7  1a53dd7:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
03dc  1a53ddc:	48 8b 13             	mov    (%rbx),%rdx
03df  1a53ddf:	0f b6 00             	movzbl (%rax),%eax
03e2  1a53de2:	38 44 24 3b          	cmp    %al,0x3b(%rsp)
03e6  1a53de6:	7c 08                	jl     1a53df0 <do_panic_write_oneword+0x3f0>
03e8  1a53de8:	84 c0                	test   %al,%al
03ea  1a53dea:	0f 85 35 02 00 00    	jne    1a54025 <do_panic_write_oneword+0x625>
03f0  1a53df0:	41 8b 77 1c          	mov    0x1c(%r15),%esi
03f4  1a53df4:	6a 00                	push   $0x0
03f6  1a53df6:	4d 89 f8             	mov    %r15,%r8
03f9  1a53df9:	48 89 e9             	mov    %rbp,%rcx
03fc  1a53dfc:	bf a0 00 00 00       	mov    $0xa0,%edi
0401  1a53e01:	e8 00 00 00 00       	call   1a53e06 <do_panic_write_oneword+0x406>	1a53e02: R_X86_64_PLT32	cfi_send_gen_cmd-0x4
0406  1a53e06:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
040b  1a53e0b:	5a                   	pop    %rdx
040c  1a53e0c:	48 c1 e8 03          	shr    $0x3,%rax
0410  1a53e10:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
0415  1a53e15:	0f 85 2d 02 00 00    	jne    1a54048 <do_panic_write_oneword+0x648>
041b  1a53e1b:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
0420  1a53e20:	4c 8b a4 24 90 00 00 00 	mov    0x90(%rsp),%r12
0428  1a53e28:	48 c1 e8 03          	shr    $0x3,%rax
042c  1a53e2c:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
0431  1a53e31:	0f 85 20 02 00 00    	jne    1a54057 <do_panic_write_oneword+0x657>
0437  1a53e37:	48 8b 45 18          	mov    0x18(%rbp),%rax
043b  1a53e3b:	4c 01 f0             	add    %r14,%rax
043e  1a53e3e:	44 88 20             	mov    %r12b,(%rax)
0441  1a53e41:	0f ae f0             	mfence
0444  1a53e44:	45 31 e4             	xor    %r12d,%r12d
0447  1a53e47:	eb 22                	jmp    1a53e6b <do_panic_write_oneword+0x46b>
0449  1a53e49:	31 c9                	xor    %ecx,%ecx
044b  1a53e4b:	4c 89 f2             	mov    %r14,%rdx
044e  1a53e4e:	48 89 de             	mov    %rbx,%rsi
0451  1a53e51:	48 89 ef             	mov    %rbp,%rdi
0454  1a53e54:	e8 b7 f8 ff ff       	call   1a53710 <chip_ready>
0459  1a53e59:	85 c0                	test   %eax,%eax
045b  1a53e5b:	75 1d                	jne    1a53e7a <do_panic_write_oneword+0x47a>
045d  1a53e5d:	bf c7 10 00 00       	mov    $0x10c7,%edi
0462  1a53e62:	41 83 c4 01          	add    $0x1,%r12d
0466  1a53e66:	e8 00 00 00 00       	call   1a53e6b <do_panic_write_oneword+0x46b>	1a53e67: R_X86_64_PLT32	__const_udelay-0x4
046b  1a53e6b:	bf 01 00 00 00       	mov    $0x1,%edi
0470  1a53e70:	e8 00 00 00 00       	call   1a53e75 <do_panic_write_oneword+0x475>	1a53e71: R_X86_64_PLT32	jiffies_to_usecs-0x4
0475  1a53e75:	44 39 e0             	cmp    %r12d,%eax
0478  1a53e78:	77 cf                	ja     1a53e49 <do_panic_write_oneword+0x449>
047a  1a53e7a:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
047f  1a53e7f:	4c 89 f2             	mov    %r14,%rdx
0482  1a53e82:	48 89 de             	mov    %rbx,%rsi
0485  1a53e85:	48 89 ef             	mov    %rbp,%rdi
0488  1a53e88:	e8 83 f8 ff ff       	call   1a53710 <chip_ready>
048d  1a53e8d:	85 c0                	test   %eax,%eax
048f  1a53e8f:	74 16                	je     1a53ea7 <do_panic_write_oneword+0x4a7>
0491  1a53e91:	4c 89 f2             	mov    %r14,%rdx
0494  1a53e94:	48 89 de             	mov    %rbx,%rsi
0497  1a53e97:	48 89 ef             	mov    %rbp,%rdi
049a  1a53e9a:	e8 31 f1 ff ff       	call   1a52fd0 <cfi_check_err_status>
049f  1a53e9f:	85 c0                	test   %eax,%eax
04a1  1a53ea1:	0f 84 5a fd ff ff    	je     1a53c01 <do_panic_write_oneword+0x201>
04a7  1a53ea7:	48 8b 04 24          	mov    (%rsp),%rax
04ab  1a53eab:	80 38 00             	cmpb   $0x0,(%rax)
04ae  1a53eae:	0f 85 b2 01 00 00    	jne    1a54066 <do_panic_write_oneword+0x666>
04b4  1a53eb4:	4c 89 fa             	mov    %r15,%rdx
04b7  1a53eb7:	48 89 ee             	mov    %rbp,%rsi
04ba  1a53eba:	bf f0 00 00 00       	mov    $0xf0,%edi
04bf  1a53ebf:	4c 8b 23             	mov    (%rbx),%r12
04c2  1a53ec2:	e8 00 00 00 00       	call   1a53ec7 <do_panic_write_oneword+0x4c7>	1a53ec3: R_X86_64_PLT32	cfi_build_cmd-0x4
04c7  1a53ec7:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
04cc  1a53ecc:	48 c1 ea 03          	shr    $0x3,%rdx
04d0  1a53ed0:	42 80 3c 2a 00       	cmpb   $0x0,(%rdx,%r13,1)
04d5  1a53ed5:	75 67                	jne    1a53f3e <do_panic_write_oneword+0x53e>
04d7  1a53ed7:	4c 03 65 18          	add    0x18(%rbp),%r12
04db  1a53edb:	41 88 04 24          	mov    %al,(%r12)
04df  1a53edf:	0f ae f0             	mfence
04e2  1a53ee2:	83 6c 24 3c 01       	subl   $0x1,0x3c(%rsp)
04e7  1a53ee7:	0f 85 11 fe ff ff    	jne    1a53cfe <do_panic_write_oneword+0x2fe>
04ed  1a53eed:	41 bc fb ff ff ff    	mov    $0xfffffffb,%r12d
04f3  1a53ef3:	e9 0c fd ff ff       	jmp    1a53c04 <do_panic_write_oneword+0x204>
04f8  1a53ef8:	31 c9                	xor    %ecx,%ecx
04fa  1a53efa:	4c 89 f2             	mov    %r14,%rdx
04fd  1a53efd:	48 89 de             	mov    %rbx,%rsi
0500  1a53f00:	48 89 ef             	mov    %rbp,%rdi
0503  1a53f03:	e8 08 f8 ff ff       	call   1a53710 <chip_ready>
0508  1a53f08:	85 c0                	test   %eax,%eax
050a  1a53f0a:	0f 85 82 fc ff ff    	jne    1a53b92 <do_panic_write_oneword+0x192>
0510  1a53f10:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
051a  1a53f1a:	48 89 da             	mov    %rbx,%rdx
051d  1a53f1d:	48 c1 ea 03          	shr    $0x3,%rdx
0521  1a53f21:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
0525  1a53f25:	0f 85 c2 01 00 00    	jne    1a540ed <do_panic_write_oneword+0x6ed>
052b  1a53f2b:	4c 8b 23             	mov    (%rbx),%r12
052e  1a53f2e:	e9 b3 fb ff ff       	jmp    1a53ae6 <do_panic_write_oneword+0xe6>
0533  1a53f33:	41 bc f0 ff ff ff    	mov    $0xfffffff0,%r12d
0539  1a53f39:	e9 f3 fc ff ff       	jmp    1a53c31 <do_panic_write_oneword+0x231>
053e  1a53f3e:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
0543  1a53f43:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
0548  1a53f48:	e8 00 00 00 00       	call   1a53f4d <do_panic_write_oneword+0x54d>	1a53f49: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
054d  1a53f4d:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
0552  1a53f52:	eb 83                	jmp    1a53ed7 <do_panic_write_oneword+0x4d7>
0554  1a53f54:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
0559  1a53f59:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
055e  1a53f5e:	e8 00 00 00 00       	call   1a53f63 <do_panic_write_oneword+0x563>	1a53f5f: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0563  1a53f63:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
0568  1a53f68:	e9 c7 fb ff ff       	jmp    1a53b34 <do_panic_write_oneword+0x134>
056d  1a53f6d:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
0572  1a53f72:	e8 00 00 00 00       	call   1a53f77 <do_panic_write_oneword+0x577>	1a53f73: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0577  1a53f77:	e9 98 fd ff ff       	jmp    1a53d14 <do_panic_write_oneword+0x314>
057c  1a53f7c:	48 89 df             	mov    %rbx,%rdi
057f  1a53f7f:	44 89 4c 24 60       	mov    %r9d,0x60(%rsp)
0584  1a53f84:	e8 00 00 00 00       	call   1a53f89 <do_panic_write_oneword+0x589>	1a53f85: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0589  1a53f89:	44 8b 4c 24 60       	mov    0x60(%rsp),%r9d
058e  1a53f8e:	e9 92 fd ff ff       	jmp    1a53d25 <do_panic_write_oneword+0x325>
0593  1a53f93:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
0598  1a53f98:	48 89 54 24 68       	mov    %rdx,0x68(%rsp)
059d  1a53f9d:	44 89 4c 24 60       	mov    %r9d,0x60(%rsp)
05a2  1a53fa2:	e8 00 00 00 00       	call   1a53fa7 <do_panic_write_oneword+0x5a7>	1a53fa3: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
05a7  1a53fa7:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
05ac  1a53fac:	44 8b 4c 24 60       	mov    0x60(%rsp),%r9d
05b1  1a53fb1:	e9 88 fd ff ff       	jmp    1a53d3e <do_panic_write_oneword+0x33e>
05b6  1a53fb6:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
05bb  1a53fbb:	e8 00 00 00 00       	call   1a53fc0 <do_panic_write_oneword+0x5c0>	1a53fbc: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
05c0  1a53fc0:	e9 a6 fd ff ff       	jmp    1a53d6b <do_panic_write_oneword+0x36b>
05c5  1a53fc5:	48 89 df             	mov    %rbx,%rdi
05c8  1a53fc8:	44 89 4c 24 60       	mov    %r9d,0x60(%rsp)
05cd  1a53fcd:	e8 00 00 00 00       	call   1a53fd2 <do_panic_write_oneword+0x5d2>	1a53fce: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
05d2  1a53fd2:	44 8b 4c 24 60       	mov    0x60(%rsp),%r9d
05d7  1a53fd7:	e9 a0 fd ff ff       	jmp    1a53d7c <do_panic_write_oneword+0x37c>
05dc  1a53fdc:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
05e1  1a53fe1:	48 89 54 24 68       	mov    %rdx,0x68(%rsp)
05e6  1a53fe6:	44 89 4c 24 60       	mov    %r9d,0x60(%rsp)
05eb  1a53feb:	e8 00 00 00 00       	call   1a53ff0 <do_panic_write_oneword+0x5f0>	1a53fec: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
05f0  1a53ff0:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
05f5  1a53ff5:	44 8b 4c 24 60       	mov    0x60(%rsp),%r9d
05fa  1a53ffa:	e9 9a fd ff ff       	jmp    1a53d99 <do_panic_write_oneword+0x399>
05ff  1a53fff:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
0604  1a54004:	e8 00 00 00 00       	call   1a54009 <do_panic_write_oneword+0x609>	1a54005: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0609  1a54009:	e9 b8 fd ff ff       	jmp    1a53dc6 <do_panic_write_oneword+0x3c6>
060e  1a5400e:	48 89 df             	mov    %rbx,%rdi
0611  1a54011:	44 89 4c 24 60       	mov    %r9d,0x60(%rsp)
0616  1a54016:	e8 00 00 00 00       	call   1a5401b <do_panic_write_oneword+0x61b>	1a54017: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
061b  1a5401b:	44 8b 4c 24 60       	mov    0x60(%rsp),%r9d
0620  1a54020:	e9 b2 fd ff ff       	jmp    1a53dd7 <do_panic_write_oneword+0x3d7>
0625  1a54025:	48 8b 7c 24 58       	mov    0x58(%rsp),%rdi
062a  1a5402a:	48 89 54 24 68       	mov    %rdx,0x68(%rsp)
062f  1a5402f:	44 89 4c 24 60       	mov    %r9d,0x60(%rsp)
0634  1a54034:	e8 00 00 00 00       	call   1a54039 <do_panic_write_oneword+0x639>	1a54035: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0639  1a54039:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
063e  1a5403e:	44 8b 4c 24 60       	mov    0x60(%rsp),%r9d
0643  1a54043:	e9 a8 fd ff ff       	jmp    1a53df0 <do_panic_write_oneword+0x3f0>
0648  1a54048:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
064d  1a5404d:	e8 00 00 00 00       	call   1a54052 <do_panic_write_oneword+0x652>	1a5404e: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0652  1a54052:	e9 c4 fd ff ff       	jmp    1a53e1b <do_panic_write_oneword+0x41b>
0657  1a54057:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
065c  1a5405c:	e8 00 00 00 00       	call   1a54061 <do_panic_write_oneword+0x661>	1a5405d: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0661  1a54061:	e9 d1 fd ff ff       	jmp    1a53e37 <do_panic_write_oneword+0x437>
0666  1a54066:	48 89 df             	mov    %rbx,%rdi
0669  1a54069:	e8 00 00 00 00       	call   1a5406e <do_panic_write_oneword+0x66e>	1a5406a: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
066e  1a5406e:	e9 41 fe ff ff       	jmp    1a53eb4 <do_panic_write_oneword+0x4b4>
0673  1a54073:	e8 00 00 00 00       	call   1a54078 <do_panic_write_oneword+0x678>	1a54074: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
0678  1a54078:	e9 5e fa ff ff       	jmp    1a53adb <do_panic_write_oneword+0xdb>
067d  1a5407d:	48 89 df             	mov    %rbx,%rdi
0680  1a54080:	48 89 14 24          	mov    %rdx,(%rsp)
0684  1a54084:	e8 00 00 00 00       	call   1a54089 <do_panic_write_oneword+0x689>	1a54085: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0689  1a54089:	48 8b 14 24          	mov    (%rsp),%rdx
068d  1a5408d:	e9 14 fa ff ff       	jmp    1a53aa6 <do_panic_write_oneword+0xa6>
0692  1a54092:	48 89 14 24          	mov    %rdx,(%rsp)
0696  1a54096:	e8 00 00 00 00       	call   1a5409b <do_panic_write_oneword+0x69b>	1a54097: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
069b  1a5409b:	48 8b 14 24          	mov    (%rsp),%rdx
069f  1a5409f:	e9 e3 f9 ff ff       	jmp    1a53a87 <do_panic_write_oneword+0x87>
06a4  1a540a4:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
06a9  1a540a9:	e8 00 00 00 00       	call   1a540ae <do_panic_write_oneword+0x6ae>	1a540aa: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
06ae  1a540ae:	e9 05 fb ff ff       	jmp    1a53bb8 <do_panic_write_oneword+0x1b8>
06b3  1a540b3:	48 89 df             	mov    %rbx,%rdi
06b6  1a540b6:	e8 00 00 00 00       	call   1a540bb <do_panic_write_oneword+0x6bb>	1a540b7: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
06bb  1a540bb:	e9 cd fa ff ff       	jmp    1a53b8d <do_panic_write_oneword+0x18d>
06c0  1a540c0:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
06c5  1a540c5:	e8 00 00 00 00       	call   1a540ca <do_panic_write_oneword+0x6ca>	1a540c6: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
06ca  1a540ca:	e9 52 fb ff ff       	jmp    1a53c21 <do_panic_write_oneword+0x221>
06cf  1a540cf:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
06d4  1a540d4:	e8 00 00 00 00       	call   1a540d9 <do_panic_write_oneword+0x6d9>	1a540d5: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
06d9  1a540d9:	e9 10 fb ff ff       	jmp    1a53bee <do_panic_write_oneword+0x1ee>
06de  1a540de:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
06e3  1a540e3:	e8 00 00 00 00       	call   1a540e8 <do_panic_write_oneword+0x6e8>	1a540e4: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
06e8  1a540e8:	e9 8b fb ff ff       	jmp    1a53c78 <do_panic_write_oneword+0x278>
06ed  1a540ed:	48 89 df             	mov    %rbx,%rdi
06f0  1a540f0:	e8 00 00 00 00       	call   1a540f5 <do_panic_write_oneword+0x6f5>	1a540f1: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
06f5  1a540f5:	e9 31 fe ff ff       	jmp    1a53f2b <do_panic_write_oneword+0x52b>
06fa  1a540fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

