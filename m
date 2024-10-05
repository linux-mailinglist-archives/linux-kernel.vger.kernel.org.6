Return-Path: <linux-kernel+bounces-352180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E9991B53
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AA4282050
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE82165EEF;
	Sat,  5 Oct 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfNp612r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C24B153BF6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728170380; cv=none; b=dk4AvdI+T6Z6J2Rz2GczhOgxz4xY8fOH2MZ4pgqAwB9pI3KlU0TiHddVXa7HjR5vdFJ7poB9Z56esG2ShJY/LIqJG4lJ/iMrCeyORrE0dNsB/4c8BQ6oc37dfwecFtN7TWU7cyKYHDQVG0GBLQhRNbUOzL5A6NGgs2QA0KwFVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728170380; c=relaxed/simple;
	bh=FIUhbnWIXijMCgZ8mMas7D6jP2DCPVF4LufX70b9CvU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HkvLRf7crHPZHs4eitotQyn8jpvwmjwQu6gIcB5aGadlK8VHYsGhY3UP8pyQzNdmeeCNJsFdkK9Hcu58b2X7ph+I5RXNaR3A1cgI5juBMBA2EV2IdcZ3lS0KIb5hhHtpDwtBk2WjkfC+NYpzDabGXV2ds+aIopMQVjsF+Jlm/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfNp612r; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728170373; x=1759706373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FIUhbnWIXijMCgZ8mMas7D6jP2DCPVF4LufX70b9CvU=;
  b=LfNp612r73DuI7kOPwyQghOjF7+PR+rfuy/1x+SOq3RxVnFtBVQR9Ufx
   +l+vgzuFqtDR11nJkynaMeWUA2DUXPKKNIViomlKtzm/GL71+UBwmqDnz
   aQH7ej7+MAI+oZIQJo8r4J9uq473stMwR32X3glAfyh2ge3nNQttqagRf
   Ehmph0Lp57P4Lso/M1IloUPDTaufZ9gx3UxLW8F56ZUByun21FaMiKkKX
   QAqtKotbNX0sfq0+N/qRp+sKWGqXz4HwQUr95kUapTUCecR7pUqveTm9D
   SLKQi8XdbEZkxe75qM2pfhNs2C5Gpdx0lAFFlX5MNbHMhFSaIRK8jsoeR
   w==;
X-CSE-ConnectionGUID: llH0jDgwTviEB72+8KOHxA==
X-CSE-MsgGUID: ewW5ySMjQ+GwwKEhGU7Hfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27235384"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="27235384"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 16:19:32 -0700
X-CSE-ConnectionGUID: yU2rxGhORnmy0oJxZghZ9g==
X-CSE-MsgGUID: RqccSH35TkWuyhT/Z4OVvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="80032547"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Oct 2024 16:19:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxE3c-0003RU-0D;
	Sat, 05 Oct 2024 23:19:28 +0000
Date: Sun, 6 Oct 2024 07:18:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0xd37:
 __stack_chk_fail() is missing a __noreturn annotation
Message-ID: <202410060726.22g9mHS8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc20a3e57247e21e1bd582f604b20bf898f7d111
commit: bc7996c864bf58102f640474e04ec5ab04911ac1 x86: mm: accelerate pagefault when badaccess
date:   5 months ago
config: x86_64-randconfig-101-20241006 (https://download.01.org/0day-ci/archive/20241006/202410060726.22g9mHS8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060726.22g9mHS8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060726.22g9mHS8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0xd37: __stack_chk_fail() is missing a __noreturn annotation


objdump-func vmlinux.o do_user_addr_fault:
0000 00000000000ada20 <do_user_addr_fault>:
0000    ada20:	55                   	push   %rbp
0001    ada21:	48 89 e5             	mov    %rsp,%rbp
0004    ada24:	41 57                	push   %r15
0006    ada26:	41 56                	push   %r14
0008    ada28:	41 55                	push   %r13
000a    ada2a:	41 54                	push   %r12
000c    ada2c:	53                   	push   %rbx
000d    ada2d:	48 83 ec 70          	sub    $0x70,%rsp
0011    ada31:	49 89 d5             	mov    %rdx,%r13
0014    ada34:	49 89 f6             	mov    %rsi,%r14
0017    ada37:	49 89 fc             	mov    %rdi,%r12
001a    ada3a:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
0023    ada43:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
0027    ada47:	e8 00 00 00 00       	call   ada4c <do_user_addr_fault+0x2c>	ada48: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
002c    ada4c:	65 48 8b 04 25 00 00 00 00 	mov    %gs:0x0,%rax	ada51: R_X86_64_32S	pcpu_hot
0035    ada55:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
0039    ada59:	48 8b 80 28 09 00 00 	mov    0x928(%rax),%rax
0040    ada60:	48 89 45 a0          	mov    %rax,-0x60(%rbp)
0044    ada64:	44 89 f3             	mov    %r14d,%ebx
0047    ada67:	83 e3 14             	and    $0x14,%ebx
004a    ada6a:	bf 10 00 00 00       	mov    $0x10,%edi
004f    ada6f:	48 89 de             	mov    %rbx,%rsi
0052    ada72:	e8 00 00 00 00       	call   ada77 <do_user_addr_fault+0x57>	ada73: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0057    ada77:	48 83 fb 10          	cmp    $0x10,%rbx
005b    ada7b:	0f 84 bf 0a 00 00    	je     ae540 <do_user_addr_fault+0xb20>
0061    ada81:	41 0f b7 9c 24 88 00 00 00 	movzwl 0x88(%r12),%ebx
006a    ada8a:	89 de                	mov    %ebx,%esi
006c    ada8c:	83 e6 03             	and    $0x3,%esi
006f    ada8f:	31 ff                	xor    %edi,%edi
0071    ada91:	e8 00 00 00 00       	call   ada96 <do_user_addr_fault+0x76>	ada92: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
0076    ada96:	83 e3 03             	and    $0x3,%ebx
0079    ada99:	74 0a                	je     adaa5 <do_user_addr_fault+0x85>
007b    ada9b:	e8 00 00 00 00       	call   adaa0 <do_user_addr_fault+0x80>	ada9c: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0080    adaa0:	e9 9e 00 00 00       	jmp    adb43 <do_user_addr_fault+0x123>
0085    adaa5:	65 8b 1d 00 00 00 00 	mov    %gs:0x0(%rip),%ebx        # adaac <do_user_addr_fault+0x8c>	adaa8: R_X86_64_PC32	pcpu_hot+0x4
008c    adaac:	89 de                	mov    %ebx,%esi
008e    adaae:	81 e6 ff ff ff 7f    	and    $0x7fffffff,%esi
0094    adab4:	31 ff                	xor    %edi,%edi
0096    adab6:	e8 00 00 00 00       	call   adabb <do_user_addr_fault+0x9b>	adab7: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
009b    adabb:	81 e3 ff ff ff 7f    	and    $0x7fffffff,%ebx
00a1    adac1:	74 07                	je     adaca <do_user_addr_fault+0xaa>
00a3    adac3:	e8 00 00 00 00       	call   adac8 <do_user_addr_fault+0xa8>	adac4: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00a8    adac8:	eb 2f                	jmp    adaf9 <do_user_addr_fault+0xd9>
00aa    adaca:	48 c7 45 c8 00 00 00 00 	movq   $0x0,-0x38(%rbp)
00b2    adad2:	9c                   	pushf
00b3    adad3:	8f 45 c8             	pop    -0x38(%rbp)
00b6    adad6:	48 8b 5d c8          	mov    -0x38(%rbp),%rbx
00ba    adada:	41 bf 00 02 00 00    	mov    $0x200,%r15d
00c0    adae0:	be 00 02 00 00       	mov    $0x200,%esi
00c5    adae5:	48 21 de             	and    %rbx,%rsi
00c8    adae8:	31 ff                	xor    %edi,%edi
00ca    adaea:	e8 00 00 00 00       	call   adaef <do_user_addr_fault+0xcf>	adaeb: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
00cf    adaef:	49 21 df             	and    %rbx,%r15
00d2    adaf2:	75 4a                	jne    adb3e <do_user_addr_fault+0x11e>
00d4    adaf4:	e8 00 00 00 00       	call   adaf9 <do_user_addr_fault+0xd9>	adaf5: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
00d9    adaf9:	65 48 8b 1d 00 00 00 00 	mov    %gs:0x0(%rip),%rbx        # adb01 <do_user_addr_fault+0xe1>	adafd: R_X86_64_PC32	current_kprobe-0x4
00e1    adb01:	31 ff                	xor    %edi,%edi
00e3    adb03:	48 89 de             	mov    %rbx,%rsi
00e6    adb06:	e8 00 00 00 00       	call   adb0b <do_user_addr_fault+0xeb>	adb07: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
00eb    adb0b:	48 85 db             	test   %rbx,%rbx
00ee    adb0e:	74 27                	je     adb37 <do_user_addr_fault+0x117>
00f0    adb10:	4c 89 e7             	mov    %r12,%rdi
00f3    adb13:	be 0e 00 00 00       	mov    $0xe,%esi
00f8    adb18:	e8 00 00 00 00       	call   adb1d <do_user_addr_fault+0xfd>	adb19: R_X86_64_PLT32	kprobe_fault_handler-0x4
00fd    adb1d:	89 c3                	mov    %eax,%ebx
00ff    adb1f:	31 ff                	xor    %edi,%edi
0101    adb21:	89 c6                	mov    %eax,%esi
0103    adb23:	e8 00 00 00 00       	call   adb28 <do_user_addr_fault+0x108>	adb24: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0108    adb28:	85 db                	test   %ebx,%ebx
010a    adb2a:	0f 85 63 0a 00 00    	jne    ae593 <do_user_addr_fault+0xb73>
0110    adb30:	e8 00 00 00 00       	call   adb35 <do_user_addr_fault+0x115>	adb31: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0115    adb35:	eb 0c                	jmp    adb43 <do_user_addr_fault+0x123>
0117    adb37:	e8 00 00 00 00       	call   adb3c <do_user_addr_fault+0x11c>	adb38: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
011c    adb3c:	eb 05                	jmp    adb43 <do_user_addr_fault+0x123>
011e    adb3e:	e8 00 00 00 00       	call   adb43 <do_user_addr_fault+0x123>	adb3f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0123    adb43:	4c 89 f6             	mov    %r14,%rsi
0126    adb46:	48 83 e6 08          	and    $0x8,%rsi
012a    adb4a:	31 ff                	xor    %edi,%edi
012c    adb4c:	e8 00 00 00 00       	call   adb51 <do_user_addr_fault+0x131>	adb4d: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0131    adb51:	4c 89 f0             	mov    %r14,%rax
0134    adb54:	48 83 e0 08          	and    $0x8,%rax
0138    adb58:	0f 85 e9 09 00 00    	jne    ae547 <do_user_addr_fault+0xb27>
013e    adb5e:	e8 00 00 00 00       	call   adb63 <do_user_addr_fault+0x143>	adb5f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0143    adb63:	e9 00 00 00 00       	jmp    adb68 <do_user_addr_fault+0x148>	adb64: R_X86_64_PLT32	.altinstr_aux+0x1538
0148    adb68:	e8 00 00 00 00       	call   adb6d <do_user_addr_fault+0x14d>	adb69: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
014d    adb6d:	4c 89 f6             	mov    %r14,%rsi
0150    adb70:	48 83 e6 04          	and    $0x4,%rsi
0154    adb74:	31 ff                	xor    %edi,%edi
0156    adb76:	e8 00 00 00 00       	call   adb7b <do_user_addr_fault+0x15b>	adb77: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
015b    adb7b:	4c 89 f0             	mov    %r14,%rax
015e    adb7e:	48 83 e0 04          	and    $0x4,%rax
0162    adb82:	75 2d                	jne    adbb1 <do_user_addr_fault+0x191>
0164    adb84:	49 8b 9c 24 90 00 00 00 	mov    0x90(%r12),%rbx
016c    adb8c:	41 bf 00 00 04 00    	mov    $0x40000,%r15d
0172    adb92:	be 00 00 04 00       	mov    $0x40000,%esi
0177    adb97:	48 21 de             	and    %rbx,%rsi
017a    adb9a:	31 ff                	xor    %edi,%edi
017c    adb9c:	e8 00 00 00 00       	call   adba1 <do_user_addr_fault+0x181>	adb9d: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0181    adba1:	49 21 df             	and    %rbx,%r15
0184    adba4:	0f 84 f7 09 00 00    	je     ae5a1 <do_user_addr_fault+0xb81>
018a    adbaa:	e8 00 00 00 00       	call   adbaf <do_user_addr_fault+0x18f>	adbab: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
018f    adbaf:	eb 05                	jmp    adbb6 <do_user_addr_fault+0x196>
0191    adbb1:	e8 00 00 00 00       	call   adbb6 <do_user_addr_fault+0x196>	adbb2: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0196    adbb6:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
019a    adbba:	8b 98 bc 2a 00 00    	mov    0x2abc(%rax),%ebx
01a0    adbc0:	31 ff                	xor    %edi,%edi
01a2    adbc2:	89 de                	mov    %ebx,%esi
01a4    adbc4:	e8 00 00 00 00       	call   adbc9 <do_user_addr_fault+0x1a9>	adbc5: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
01a9    adbc9:	85 db                	test   %ebx,%ebx
01ab    adbcb:	0f 85 8e 09 00 00    	jne    ae55f <do_user_addr_fault+0xb3f>
01b1    adbd1:	65 8b 1d 00 00 00 00 	mov    %gs:0x0(%rip),%ebx        # adbd8 <do_user_addr_fault+0x1b8>	adbd4: R_X86_64_PC32	pcpu_hot+0x4
01b8    adbd8:	89 de                	mov    %ebx,%esi
01ba    adbda:	81 e6 ff ff ff 7f    	and    $0x7fffffff,%esi
01c0    adbe0:	31 ff                	xor    %edi,%edi
01c2    adbe2:	e8 00 00 00 00       	call   adbe7 <do_user_addr_fault+0x1c7>	adbe3: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
01c7    adbe7:	81 e3 ff ff ff 7f    	and    $0x7fffffff,%ebx
01cd    adbed:	0f 85 73 09 00 00    	jne    ae566 <do_user_addr_fault+0xb46>
01d3    adbf3:	48 83 7d a0 00       	cmpq   $0x0,-0x60(%rbp)
01d8    adbf8:	0f 84 68 09 00 00    	je     ae566 <do_user_addr_fault+0xb46>
01de    adbfe:	49 8b 9c 24 90 00 00 00 	mov    0x90(%r12),%rbx
01e6    adc06:	41 bf 00 02 00 00    	mov    $0x200,%r15d
01ec    adc0c:	be 00 02 00 00       	mov    $0x200,%esi
01f1    adc11:	48 21 de             	and    %rbx,%rsi
01f4    adc14:	31 ff                	xor    %edi,%edi
01f6    adc16:	e8 00 00 00 00       	call   adc1b <do_user_addr_fault+0x1fb>	adc17: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
01fb    adc1b:	49 21 df             	and    %rbx,%r15
01fe    adc1e:	0f 84 49 09 00 00    	je     ae56d <do_user_addr_fault+0xb4d>
0204    adc24:	e8 00 00 00 00       	call   adc29 <do_user_addr_fault+0x209>	adc25: R_X86_64_PLT32	trace_hardirqs_on-0x4
0209    adc29:	fb                   	sti
020a    adc2a:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
020f    adc2f:	e8 00 00 00 00       	call   adc34 <do_user_addr_fault+0x214>	adc30: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0214    adc34:	44 89 f6             	mov    %r14d,%esi
0217    adc37:	83 e6 40             	and    $0x40,%esi
021a    adc3a:	31 ff                	xor    %edi,%edi
021c    adc3c:	48 89 75 98          	mov    %rsi,-0x68(%rbp)
0220    adc40:	e8 00 00 00 00       	call   adc45 <do_user_addr_fault+0x225>	adc41: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0225    adc45:	44 89 f6             	mov    %r14d,%esi
0228    adc48:	83 e6 02             	and    $0x2,%esi
022b    adc4b:	31 ff                	xor    %edi,%edi
022d    adc4d:	48 89 75 90          	mov    %rsi,-0x70(%rbp)
0231    adc51:	e8 00 00 00 00       	call   adc56 <do_user_addr_fault+0x236>	adc52: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0236    adc56:	31 db                	xor    %ebx,%ebx
0238    adc58:	4c 89 f6             	mov    %r14,%rsi
023b    adc5b:	48 83 e6 42          	and    $0x42,%rsi
023f    adc5f:	0f 94 c3             	sete   %bl
0242    adc62:	31 ff                	xor    %edi,%edi
0244    adc64:	e8 00 00 00 00       	call   adc69 <do_user_addr_fault+0x249>	adc65: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0249    adc69:	81 f3 15 02 00 00    	xor    $0x215,%ebx
024f    adc6f:	44 8d bb 00 01 00 00 	lea    0x100(%rbx),%r15d
0256    adc76:	4c 89 f6             	mov    %r14,%rsi
0259    adc79:	48 83 e6 10          	and    $0x10,%rsi
025d    adc7d:	44 0f 44 fb          	cmove  %ebx,%r15d
0261    adc81:	31 ff                	xor    %edi,%edi
0263    adc83:	48 89 b5 78 ff ff ff 	mov    %rsi,-0x88(%rbp)
026a    adc8a:	e8 00 00 00 00       	call   adc8f <do_user_addr_fault+0x26f>	adc8b: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
026f    adc8f:	41 0f b7 b4 24 88 00 00 00 	movzwl 0x88(%r12),%esi
0278    adc98:	41 8d 47 40          	lea    0x40(%r15),%eax
027c    adc9c:	83 e6 03             	and    $0x3,%esi
027f    adc9f:	41 0f 44 c7          	cmove  %r15d,%eax
0283    adca3:	49 89 c7             	mov    %rax,%r15
0286    adca6:	31 ff                	xor    %edi,%edi
0288    adca8:	e8 00 00 00 00       	call   adcad <do_user_addr_fault+0x28d>	adca9: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
028d    adcad:	4c 89 eb             	mov    %r13,%rbx
0290    adcb0:	48 81 e3 00 f0 ff ff 	and    $0xfffffffffffff000,%rbx
0297    adcb7:	48 c7 c7 00 00 60 ff 	mov    $0xffffffffff600000,%rdi
029e    adcbe:	48 89 de             	mov    %rbx,%rsi
02a1    adcc1:	e8 00 00 00 00       	call   adcc6 <do_user_addr_fault+0x2a6>	adcc2: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
02a6    adcc6:	48 81 fb 00 00 60 ff 	cmp    $0xffffffffff600000,%rbx
02ad    adccd:	4c 89 65 c0          	mov    %r12,-0x40(%rbp)
02b1    adcd1:	4c 89 75 b8          	mov    %r14,-0x48(%rbp)
02b5    adcd5:	75 1c                	jne    adcf3 <do_user_addr_fault+0x2d3>
02b7    adcd7:	4c 89 f7             	mov    %r14,%rdi
02ba    adcda:	4c 89 e6             	mov    %r12,%rsi
02bd    adcdd:	4c 89 ea             	mov    %r13,%rdx
02c0    adce0:	e8 00 00 00 00       	call   adce5 <do_user_addr_fault+0x2c5>	adce1: R_X86_64_PLT32	emulate_vsyscall-0x4
02c5    adce5:	84 c0                	test   %al,%al
02c7    adce7:	74 11                	je     adcfa <do_user_addr_fault+0x2da>
02c9    adce9:	e8 00 00 00 00       	call   adcee <do_user_addr_fault+0x2ce>	adcea: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02ce    adcee:	e9 06 04 00 00       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
02d3    adcf3:	e8 00 00 00 00       	call   adcf8 <do_user_addr_fault+0x2d8>	adcf4: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02d8    adcf8:	eb 05                	jmp    adcff <do_user_addr_fault+0x2df>
02da    adcfa:	e8 00 00 00 00       	call   adcff <do_user_addr_fault+0x2df>	adcfb: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
02df    adcff:	4d 89 fe             	mov    %r15,%r14
02e2    add02:	44 89 f6             	mov    %r14d,%esi
02e5    add05:	83 e6 40             	and    $0x40,%esi
02e8    add08:	31 ff                	xor    %edi,%edi
02ea    add0a:	e8 00 00 00 00       	call   add0f <do_user_addr_fault+0x2ef>	add0b: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
02ef    add0f:	44 89 f0             	mov    %r14d,%eax
02f2    add12:	83 e0 40             	and    $0x40,%eax
02f5    add15:	4c 8b 65 a8          	mov    -0x58(%rbp),%r12
02f9    add19:	75 07                	jne    add22 <do_user_addr_fault+0x302>
02fb    add1b:	e8 00 00 00 00       	call   add20 <do_user_addr_fault+0x300>	add1c: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0300    add20:	eb 54                	jmp    add76 <do_user_addr_fault+0x356>
0302    add22:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
0306    add26:	4c 89 ee             	mov    %r13,%rsi
0309    add29:	e8 00 00 00 00       	call   add2e <do_user_addr_fault+0x30e>	add2a: R_X86_64_PLT32	lock_vma_under_rcu-0x4
030e    add2e:	48 85 c0             	test   %rax,%rax
0311    add31:	74 3e                	je     add71 <do_user_addr_fault+0x351>
0313    add33:	49 89 c7             	mov    %rax,%r15
0316    add36:	48 8b 5d b8          	mov    -0x48(%rbp),%rbx
031a    add3a:	48 89 de             	mov    %rbx,%rsi
031d    add3d:	48 81 e6 20 80 00 00 	and    $0x8020,%rsi
0324    add44:	31 ff                	xor    %edi,%edi
0326    add46:	e8 00 00 00 00       	call   add4b <do_user_addr_fault+0x32b>	add47: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
032b    add4b:	48 89 d8             	mov    %rbx,%rax
032e    add4e:	48 25 20 80 00 00    	and    $0x8020,%rax
0334    add54:	0f 84 c6 03 00 00    	je     ae120 <do_user_addr_fault+0x700>
033a    add5a:	e8 00 00 00 00       	call   add5f <do_user_addr_fault+0x33f>	add5b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
033f    add5f:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
0343    add63:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0347    add67:	4c 89 ea             	mov    %r13,%rdx
034a    add6a:	31 c9                	xor    %ecx,%ecx
034c    add6c:	e9 80 03 00 00       	jmp    ae0f1 <do_user_addr_fault+0x6d1>
0351    add71:	e8 00 00 00 00       	call   add76 <do_user_addr_fault+0x356>	add72: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0356    add76:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
035a    add7a:	4c 89 ee             	mov    %r13,%rsi
035d    add7d:	48 8b 55 c0          	mov    -0x40(%rbp),%rdx
0361    add81:	e8 00 00 00 00       	call   add86 <do_user_addr_fault+0x366>	add82: R_X86_64_PLT32	lock_mm_and_find_vma-0x4
0366    add86:	48 85 c0             	test   %rax,%rax
0369    add89:	0f 84 45 07 00 00    	je     ae4d4 <do_user_addr_fault+0xab4>
036f    add8f:	49 89 c7             	mov    %rax,%r15
0372    add92:	4c 8b 65 b8          	mov    -0x48(%rbp),%r12
0376    add96:	44 89 e3             	mov    %r12d,%ebx
0379    add99:	81 e3 20 80 00 00    	and    $0x8020,%ebx
037f    add9f:	31 ff                	xor    %edi,%edi
0381    adda1:	48 89 de             	mov    %rbx,%rsi
0384    adda4:	e8 00 00 00 00       	call   adda9 <do_user_addr_fault+0x389>	adda5: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0389    adda9:	44 89 e6             	mov    %r12d,%esi
038c    addac:	83 e6 01             	and    $0x1,%esi
038f    addaf:	31 ff                	xor    %edi,%edi
0391    addb1:	48 89 b5 70 ff ff ff 	mov    %rsi,-0x90(%rbp)
0398    addb8:	e8 00 00 00 00       	call   addbd <do_user_addr_fault+0x39d>	addb9: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
039d    addbd:	44 89 f1             	mov    %r14d,%ecx
03a0    addc0:	83 c9 20             	or     $0x20,%ecx
03a3    addc3:	4d 89 fc             	mov    %r15,%r12
03a6    addc6:	48 85 db             	test   %rbx,%rbx
03a9    addc9:	0f 85 0e 03 00 00    	jne    ae0dd <do_user_addr_fault+0x6bd>
03af    addcf:	48 83 bd 78 ff ff ff 00 	cmpq   $0x0,-0x88(%rbp)
03b7    addd7:	4c 89 7d 88          	mov    %r15,-0x78(%rbp)
03bb    adddb:	48 89 9d 68 ff ff ff 	mov    %rbx,-0x98(%rbp)
03c2    adde2:	89 4d 84             	mov    %ecx,-0x7c(%rbp)
03c5    adde5:	75 22                	jne    ade09 <do_user_addr_fault+0x3e9>
03c7    adde7:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
03cb    addeb:	48 8b 80 28 09 00 00 	mov    0x928(%rax),%rax
03d2    addf2:	48 85 c0             	test   %rax,%rax
03d5    addf5:	74 19                	je     ade10 <do_user_addr_fault+0x3f0>
03d7    addf7:	49 3b 44 24 10       	cmp    0x10(%r12),%rax
03dc    addfc:	0f 84 18 02 00 00    	je     ae01a <do_user_addr_fault+0x5fa>
03e2    ade02:	e8 00 00 00 00       	call   ade07 <do_user_addr_fault+0x3e7>	ade03: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
03e7    ade07:	eb 0c                	jmp    ade15 <do_user_addr_fault+0x3f5>
03e9    ade09:	e8 00 00 00 00       	call   ade0e <do_user_addr_fault+0x3ee>	ade0a: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
03ee    ade0e:	eb 05                	jmp    ade15 <do_user_addr_fault+0x3f5>
03f0    ade10:	e8 00 00 00 00       	call   ade15 <do_user_addr_fault+0x3f5>	ade11: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
03f5    ade15:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
03fa    ade1a:	75 2a                	jne    ade46 <do_user_addr_fault+0x426>
03fc    ade1c:	48 83 7d 90 00       	cmpq   $0x0,-0x70(%rbp)
0401    ade21:	75 57                	jne    ade7a <do_user_addr_fault+0x45a>
0403    ade23:	e8 00 00 00 00       	call   ade28 <do_user_addr_fault+0x408>	ade24: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0408    ade28:	48 83 bd 70 ff ff ff 00 	cmpq   $0x0,-0x90(%rbp)
0410    ade30:	0f 85 9e 07 00 00    	jne    ae5d4 <do_user_addr_fault+0xbb4>
0416    ade36:	e8 00 00 00 00       	call   ade3b <do_user_addr_fault+0x41b>	ade37: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
041b    ade3b:	4d 8b 7c 24 20       	mov    0x20(%r12),%r15
0420    ade40:	41 83 e7 07          	and    $0x7,%r15d
0424    ade44:	eb 6a                	jmp    adeb0 <do_user_addr_fault+0x490>
0426    ade46:	e8 00 00 00 00       	call   ade4b <do_user_addr_fault+0x42b>	ade47: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
042b    ade4b:	4d 8b 7c 24 20       	mov    0x20(%r12),%r15
0430    ade50:	4c 89 fe             	mov    %r15,%rsi
0433    ade53:	48 bb 00 00 00 00 20 00 00 00 	movabs $0x2000000000,%rbx
043d    ade5d:	48 21 de             	and    %rbx,%rsi
0440    ade60:	31 ff                	xor    %edi,%edi
0442    ade62:	e8 00 00 00 00       	call   ade67 <do_user_addr_fault+0x447>	ade63: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0447    ade67:	4c 89 f8             	mov    %r15,%rax
044a    ade6a:	48 21 d8             	and    %rbx,%rax
044d    ade6d:	0f 84 5a 07 00 00    	je     ae5cd <do_user_addr_fault+0xbad>
0453    ade73:	e8 00 00 00 00       	call   ade78 <do_user_addr_fault+0x458>	ade74: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0458    ade78:	eb 32                	jmp    adeac <do_user_addr_fault+0x48c>
045a    ade7a:	e8 00 00 00 00       	call   ade7f <do_user_addr_fault+0x45f>	ade7b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
045f    ade7f:	4d 8b 7c 24 20       	mov    0x20(%r12),%r15
0464    ade84:	4c 89 fe             	mov    %r15,%rsi
0467    ade87:	48 bb 00 00 00 00 20 00 00 00 	movabs $0x2000000000,%rbx
0471    ade91:	48 21 de             	and    %rbx,%rsi
0474    ade94:	31 ff                	xor    %edi,%edi
0476    ade96:	e8 00 00 00 00       	call   ade9b <do_user_addr_fault+0x47b>	ade97: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
047b    ade9b:	4c 89 f8             	mov    %r15,%rax
047e    ade9e:	48 21 d8             	and    %rbx,%rax
0481    adea1:	0f 85 34 07 00 00    	jne    ae5db <do_user_addr_fault+0xbbb>
0487    adea7:	e8 00 00 00 00       	call   adeac <do_user_addr_fault+0x48c>	adea8: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
048c    adeac:	41 83 e7 02          	and    $0x2,%r15d
0490    adeb0:	31 ff                	xor    %edi,%edi
0492    adeb2:	4c 89 fe             	mov    %r15,%rsi
0495    adeb5:	e8 00 00 00 00       	call   adeba <do_user_addr_fault+0x49a>	adeb6: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
049a    adeba:	4d 85 ff             	test   %r15,%r15
049d    adebd:	0f 84 c7 08 00 00    	je     ae78a <do_user_addr_fault+0xd6a>
04a3    adec3:	4c 89 e7             	mov    %r12,%rdi
04a6    adec6:	4c 89 ee             	mov    %r13,%rsi
04a9    adec9:	44 89 f2             	mov    %r14d,%edx
04ac    adecc:	4c 8b 65 c0          	mov    -0x40(%rbp),%r12
04b0    aded0:	4c 89 e1             	mov    %r12,%rcx
04b3    aded3:	e8 00 00 00 00       	call   aded8 <do_user_addr_fault+0x4b8>	aded4: R_X86_64_PLT32	handle_mm_fault-0x4
04b8    aded8:	89 c3                	mov    %eax,%ebx
04ba    adeda:	89 c6                	mov    %eax,%esi
04bc    adedc:	81 e6 00 04 00 00    	and    $0x400,%esi
04c2    adee2:	31 ff                	xor    %edi,%edi
04c4    adee4:	e8 00 00 00 00       	call   adee9 <do_user_addr_fault+0x4c9>	adee5: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
04c9    adee9:	89 d8                	mov    %ebx,%eax
04cb    adeeb:	25 00 04 00 00       	and    $0x400,%eax
04d0    adef0:	0f 84 60 04 00 00    	je     ae356 <do_user_addr_fault+0x936>
04d6    adef6:	4c 8b 75 a8          	mov    -0x58(%rbp),%r14
04da    adefa:	4d 8b 3e             	mov    (%r14),%r15
04dd    adefd:	4c 89 fe             	mov    %r15,%rsi
04e0    adf00:	48 83 e6 04          	and    $0x4,%rsi
04e4    adf04:	31 ff                	xor    %edi,%edi
04e6    adf06:	e8 00 00 00 00       	call   adf0b <do_user_addr_fault+0x4eb>	adf07: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
04eb    adf0b:	49 83 e7 04          	and    $0x4,%r15
04ef    adf0f:	75 07                	jne    adf18 <do_user_addr_fault+0x4f8>
04f1    adf11:	e8 00 00 00 00       	call   adf16 <do_user_addr_fault+0x4f6>	adf12: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
04f6    adf16:	eb 29                	jmp    adf41 <do_user_addr_fault+0x521>
04f8    adf18:	4d 8b be c0 0b 00 00 	mov    0xbc0(%r14),%r15
04ff    adf1f:	be 00 01 00 00       	mov    $0x100,%esi
0504    adf24:	4c 21 fe             	and    %r15,%rsi
0507    adf27:	31 ff                	xor    %edi,%edi
0509    adf29:	e8 00 00 00 00       	call   adf2e <do_user_addr_fault+0x50e>	adf2a: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
050e    adf2e:	b8 00 01 00 00       	mov    $0x100,%eax
0513    adf33:	49 21 c7             	and    %rax,%r15
0516    adf36:	0f 85 1b 05 00 00    	jne    ae457 <do_user_addr_fault+0xa37>
051c    adf3c:	e8 00 00 00 00       	call   adf41 <do_user_addr_fault+0x521>	adf3d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0521    adf41:	45 0f b7 a4 24 88 00 00 00 	movzwl 0x88(%r12),%r12d
052a    adf4a:	44 89 e6             	mov    %r12d,%esi
052d    adf4d:	83 e6 03             	and    $0x3,%esi
0530    adf50:	31 ff                	xor    %edi,%edi
0532    adf52:	e8 00 00 00 00       	call   adf57 <do_user_addr_fault+0x537>	adf53: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
0537    adf57:	44 89 e0             	mov    %r12d,%eax
053a    adf5a:	83 e0 03             	and    $0x3,%eax
053d    adf5d:	74 61                	je     adfc0 <do_user_addr_fault+0x5a0>
053f    adf5f:	4c 8b 75 a8          	mov    -0x58(%rbp),%r14
0543    adf63:	4d 8b 3e             	mov    (%r14),%r15
0546    adf66:	be 00 00 02 00       	mov    $0x20000,%esi
054b    adf6b:	4c 21 fe             	and    %r15,%rsi
054e    adf6e:	31 ff                	xor    %edi,%edi
0550    adf70:	e8 00 00 00 00       	call   adf75 <do_user_addr_fault+0x555>	adf71: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0555    adf75:	b8 00 00 02 00       	mov    $0x20000,%eax
055a    adf7a:	49 21 c7             	and    %rax,%r15
055d    adf7d:	0f 85 40 06 00 00    	jne    ae5c3 <do_user_addr_fault+0xba3>
0563    adf83:	4d 8b 3e             	mov    (%r14),%r15
0566    adf86:	4c 89 fe             	mov    %r15,%rsi
0569    adf89:	48 83 e6 04          	and    $0x4,%rsi
056d    adf8d:	31 ff                	xor    %edi,%edi
056f    adf8f:	e8 00 00 00 00       	call   adf94 <do_user_addr_fault+0x574>	adf90: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0574    adf94:	49 83 e7 04          	and    $0x4,%r15
0578    adf98:	0f 85 9e 04 00 00    	jne    ae43c <do_user_addr_fault+0xa1c>
057e    adf9e:	89 de                	mov    %ebx,%esi
0580    adfa0:	81 e6 00 40 00 00    	and    $0x4000,%esi
0586    adfa6:	31 ff                	xor    %edi,%edi
0588    adfa8:	e8 00 00 00 00       	call   adfad <do_user_addr_fault+0x58d>	adfa9: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
058d    adfad:	81 e3 00 40 00 00    	and    $0x4000,%ebx
0593    adfb3:	0f 85 8a 04 00 00    	jne    ae443 <do_user_addr_fault+0xa23>
0599    adfb9:	e8 00 00 00 00       	call   adfbe <do_user_addr_fault+0x59e>	adfba: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
059e    adfbe:	eb 20                	jmp    adfe0 <do_user_addr_fault+0x5c0>
05a0    adfc0:	89 de                	mov    %ebx,%esi
05a2    adfc2:	81 e6 00 40 00 00    	and    $0x4000,%esi
05a8    adfc8:	31 ff                	xor    %edi,%edi
05aa    adfca:	e8 00 00 00 00       	call   adfcf <do_user_addr_fault+0x5af>	adfcb: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
05af    adfcf:	81 e3 00 40 00 00    	and    $0x4000,%ebx
05b5    adfd5:	0f 85 cf 04 00 00    	jne    ae4aa <do_user_addr_fault+0xa8a>
05bb    adfdb:	e8 00 00 00 00       	call   adfe0 <do_user_addr_fault+0x5c0>	adfdc: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
05c0    adfe0:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
05c4    adfe4:	4c 89 ee             	mov    %r13,%rsi
05c7    adfe7:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
05cb    adfeb:	4c 89 f2             	mov    %r14,%rdx
05ce    adfee:	e8 00 00 00 00       	call   adff3 <do_user_addr_fault+0x5d3>	adfef: R_X86_64_PLT32	lock_mm_and_find_vma-0x4
05d3    adff3:	48 85 c0             	test   %rax,%rax
05d6    adff6:	4c 8b 7d 88          	mov    -0x78(%rbp),%r15
05da    adffa:	0f 84 b9 05 00 00    	je     ae5b9 <do_user_addr_fault+0xb99>
05e0    ae000:	49 89 c4             	mov    %rax,%r12
05e3    ae003:	e8 00 00 00 00       	call   ae008 <do_user_addr_fault+0x5e8>	ae004: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
05e8    ae008:	8b 4d 84             	mov    -0x7c(%rbp),%ecx
05eb    ae00b:	41 89 ce             	mov    %ecx,%r14d
05ee    ae00e:	48 8b 9d 68 ff ff ff 	mov    -0x98(%rbp),%rbx
05f5    ae015:	e9 ac fd ff ff       	jmp    addc6 <do_user_addr_fault+0x3a6>
05fa    ae01a:	4d 8b 7c 24 20       	mov    0x20(%r12),%r15
05ff    ae01f:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
0603    ae023:	e9 00 00 00 00       	jmp    ae028 <do_user_addr_fault+0x608>	ae024: R_X86_64_PLT32	.altinstr_aux+0x154a
0608    ae028:	e8 00 00 00 00       	call   ae02d <do_user_addr_fault+0x60d>	ae029: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
060d    ae02d:	31 c9                	xor    %ecx,%ecx
060f    ae02f:	0f 01 ee             	rdpkru
0612    ae032:	89 c3                	mov    %eax,%ebx
0614    ae034:	49 c1 ef 1f          	shr    $0x1f,%r15
0618    ae038:	41 83 e7 1e          	and    $0x1e,%r15d
061c    ae03c:	41 bd 01 00 00 00    	mov    $0x1,%r13d
0622    ae042:	44 89 f9             	mov    %r15d,%ecx
0625    ae045:	41 d3 e5             	shl    %cl,%r13d
0628    ae048:	89 de                	mov    %ebx,%esi
062a    ae04a:	44 21 ee             	and    %r13d,%esi
062d    ae04d:	31 ff                	xor    %edi,%edi
062f    ae04f:	e8 00 00 00 00       	call   ae054 <do_user_addr_fault+0x634>	ae050: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0634    ae054:	41 21 dd             	and    %ebx,%r13d
0637    ae057:	0f 85 b0 04 00 00    	jne    ae50d <do_user_addr_fault+0xaed>
063d    ae05d:	48 83 7d 90 00       	cmpq   $0x0,-0x70(%rbp)
0642    ae062:	75 15                	jne    ae079 <do_user_addr_fault+0x659>
0644    ae064:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
0649    ae069:	75 44                	jne    ae0af <do_user_addr_fault+0x68f>
064b    ae06b:	e8 00 00 00 00       	call   ae070 <do_user_addr_fault+0x650>	ae06c: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0650    ae070:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0654    ae074:	e9 af fd ff ff       	jmp    ade28 <do_user_addr_fault+0x408>
0659    ae079:	41 bd 03 00 00 00    	mov    $0x3,%r13d
065f    ae07f:	44 89 f9             	mov    %r15d,%ecx
0662    ae082:	41 d3 e5             	shl    %cl,%r13d
0665    ae085:	89 de                	mov    %ebx,%esi
0667    ae087:	44 21 ee             	and    %r13d,%esi
066a    ae08a:	31 ff                	xor    %edi,%edi
066c    ae08c:	e8 00 00 00 00       	call   ae091 <do_user_addr_fault+0x671>	ae08d: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0671    ae091:	41 21 dd             	and    %ebx,%r13d
0674    ae094:	0f 85 95 04 00 00    	jne    ae52f <do_user_addr_fault+0xb0f>
067a    ae09a:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
067f    ae09f:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0683    ae0a3:	75 18                	jne    ae0bd <do_user_addr_fault+0x69d>
0685    ae0a5:	e8 00 00 00 00       	call   ae0aa <do_user_addr_fault+0x68a>	ae0a6: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
068a    ae0aa:	e9 d0 fd ff ff       	jmp    ade7f <do_user_addr_fault+0x45f>
068f    ae0af:	e8 00 00 00 00       	call   ae0b4 <do_user_addr_fault+0x694>	ae0b0: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0694    ae0b4:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0698    ae0b8:	e9 8e fd ff ff       	jmp    ade4b <do_user_addr_fault+0x42b>
069d    ae0bd:	e8 00 00 00 00       	call   ae0c2 <do_user_addr_fault+0x6a2>	ae0be: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
06a2    ae0c2:	e9 84 fd ff ff       	jmp    ade4b <do_user_addr_fault+0x42b>
06a7    ae0c7:	e8 00 00 00 00       	call   ae0cc <do_user_addr_fault+0x6ac>	ae0c8: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
06ac    ae0cc:	e9 5c ff ff ff       	jmp    ae02d <do_user_addr_fault+0x60d>
06b1    ae0d1:	e8 00 00 00 00       	call   ae0d6 <do_user_addr_fault+0x6b6>	ae0d2: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
06b6    ae0d6:	31 db                	xor    %ebx,%ebx
06b8    ae0d8:	e9 57 ff ff ff       	jmp    ae034 <do_user_addr_fault+0x614>
06bd    ae0dd:	e8 00 00 00 00       	call   ae0e2 <do_user_addr_fault+0x6c2>	ae0de: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
06c2    ae0e2:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
06c6    ae0e6:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
06ca    ae0ea:	4c 89 ea             	mov    %r13,%rdx
06cd    ae0ed:	48 8b 4d a0          	mov    -0x60(%rbp),%rcx
06d1    ae0f1:	4d 89 f8             	mov    %r15,%r8
06d4    ae0f4:	e8 b7 1a 00 00       	call   afbb0 <bad_area_access_error>
06d9    ae0f9:	65 48 8b 04 25 28 00 00 00 	mov    %gs:0x28,%rax
06e2    ae102:	48 3b 45 d0          	cmp    -0x30(%rbp),%rax
06e6    ae106:	0f 85 46 06 00 00    	jne    ae752 <do_user_addr_fault+0xd32>
06ec    ae10c:	48 83 c4 70          	add    $0x70,%rsp
06f0    ae110:	5b                   	pop    %rbx
06f1    ae111:	41 5c                	pop    %r12
06f3    ae113:	41 5d                	pop    %r13
06f5    ae115:	41 5e                	pop    %r14
06f7    ae117:	41 5f                	pop    %r15
06f9    ae119:	5d                   	pop    %rbp
06fa    ae11a:	2e e9 00 00 00 00    	cs jmp ae120 <do_user_addr_fault+0x700>	ae11c: R_X86_64_PLT32	__x86_return_thunk-0x4
0700    ae120:	48 83 bd 78 ff ff ff 00 	cmpq   $0x0,-0x88(%rbp)
0708    ae128:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
070c    ae12c:	75 1e                	jne    ae14c <do_user_addr_fault+0x72c>
070e    ae12e:	49 8b 84 24 28 09 00 00 	mov    0x928(%r12),%rax
0716    ae136:	48 85 c0             	test   %rax,%rax
0719    ae139:	74 18                	je     ae153 <do_user_addr_fault+0x733>
071b    ae13b:	49 3b 47 10          	cmp    0x10(%r15),%rax
071f    ae13f:	0f 84 5e 02 00 00    	je     ae3a3 <do_user_addr_fault+0x983>
0725    ae145:	e8 00 00 00 00       	call   ae14a <do_user_addr_fault+0x72a>	ae146: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
072a    ae14a:	eb 0c                	jmp    ae158 <do_user_addr_fault+0x738>
072c    ae14c:	e8 00 00 00 00       	call   ae151 <do_user_addr_fault+0x731>	ae14d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0731    ae151:	eb 05                	jmp    ae158 <do_user_addr_fault+0x738>
0733    ae153:	e8 00 00 00 00       	call   ae158 <do_user_addr_fault+0x738>	ae154: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0738    ae158:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
073d    ae15d:	75 39                	jne    ae198 <do_user_addr_fault+0x778>
073f    ae15f:	48 83 7d 90 00       	cmpq   $0x0,-0x70(%rbp)
0744    ae164:	75 62                	jne    ae1c8 <do_user_addr_fault+0x7a8>
0746    ae166:	e8 00 00 00 00       	call   ae16b <do_user_addr_fault+0x74b>	ae167: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
074b    ae16b:	48 8b 5d b8          	mov    -0x48(%rbp),%rbx
074f    ae16f:	48 89 de             	mov    %rbx,%rsi
0752    ae172:	48 83 e6 01          	and    $0x1,%rsi
0756    ae176:	31 ff                	xor    %edi,%edi
0758    ae178:	e8 00 00 00 00       	call   ae17d <do_user_addr_fault+0x75d>	ae179: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
075d    ae17d:	48 89 d8             	mov    %rbx,%rax
0760    ae180:	48 83 e0 01          	and    $0x1,%rax
0764    ae184:	0f 85 b6 04 00 00    	jne    ae640 <do_user_addr_fault+0xc20>
076a    ae18a:	e8 00 00 00 00       	call   ae18f <do_user_addr_fault+0x76f>	ae18b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
076f    ae18f:	49 8b 5f 20          	mov    0x20(%r15),%rbx
0773    ae193:	83 e3 07             	and    $0x7,%ebx
0776    ae196:	eb 65                	jmp    ae1fd <do_user_addr_fault+0x7dd>
0778    ae198:	e8 00 00 00 00       	call   ae19d <do_user_addr_fault+0x77d>	ae199: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
077d    ae19d:	49 8b 5f 20          	mov    0x20(%r15),%rbx
0781    ae1a1:	49 bd 00 00 00 00 20 00 00 00 	movabs $0x2000000000,%r13
078b    ae1ab:	48 89 de             	mov    %rbx,%rsi
078e    ae1ae:	4c 21 ee             	and    %r13,%rsi
0791    ae1b1:	31 ff                	xor    %edi,%edi
0793    ae1b3:	e8 00 00 00 00       	call   ae1b8 <do_user_addr_fault+0x798>	ae1b4: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0798    ae1b8:	49 21 dd             	and    %rbx,%r13
079b    ae1bb:	0f 84 49 04 00 00    	je     ae60a <do_user_addr_fault+0xbea>
07a1    ae1c1:	e8 00 00 00 00       	call   ae1c6 <do_user_addr_fault+0x7a6>	ae1c2: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
07a6    ae1c6:	eb 2e                	jmp    ae1f6 <do_user_addr_fault+0x7d6>
07a8    ae1c8:	e8 00 00 00 00       	call   ae1cd <do_user_addr_fault+0x7ad>	ae1c9: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
07ad    ae1cd:	49 8b 5f 20          	mov    0x20(%r15),%rbx
07b1    ae1d1:	49 bd 00 00 00 00 20 00 00 00 	movabs $0x2000000000,%r13
07bb    ae1db:	48 89 de             	mov    %rbx,%rsi
07be    ae1de:	4c 21 ee             	and    %r13,%rsi
07c1    ae1e1:	31 ff                	xor    %edi,%edi
07c3    ae1e3:	e8 00 00 00 00       	call   ae1e8 <do_user_addr_fault+0x7c8>	ae1e4: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
07c8    ae1e8:	49 21 dd             	and    %rbx,%r13
07cb    ae1eb:	0f 85 59 04 00 00    	jne    ae64a <do_user_addr_fault+0xc2a>
07d1    ae1f1:	e8 00 00 00 00       	call   ae1f6 <do_user_addr_fault+0x7d6>	ae1f2: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
07d6    ae1f6:	83 e3 02             	and    $0x2,%ebx
07d9    ae1f9:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
07dd    ae1fd:	31 ff                	xor    %edi,%edi
07df    ae1ff:	48 89 de             	mov    %rbx,%rsi
07e2    ae202:	e8 00 00 00 00       	call   ae207 <do_user_addr_fault+0x7e7>	ae203: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
07e7    ae207:	48 85 db             	test   %rbx,%rbx
07ea    ae20a:	0f 84 84 05 00 00    	je     ae794 <do_user_addr_fault+0xd74>
07f0    ae210:	41 8d 96 00 10 00 00 	lea    0x1000(%r14),%edx
07f7    ae217:	4c 89 ff             	mov    %r15,%rdi
07fa    ae21a:	4c 89 ee             	mov    %r13,%rsi
07fd    ae21d:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
0801    ae221:	e8 00 00 00 00       	call   ae226 <do_user_addr_fault+0x806>	ae222: R_X86_64_PLT32	handle_mm_fault-0x4
0806    ae226:	89 c3                	mov    %eax,%ebx
0808    ae228:	89 c6                	mov    %eax,%esi
080a    ae22a:	81 e6 00 44 00 00    	and    $0x4400,%esi
0810    ae230:	31 ff                	xor    %edi,%edi
0812    ae232:	e8 00 00 00 00       	call   ae237 <do_user_addr_fault+0x817>	ae233: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0817    ae237:	89 d8                	mov    %ebx,%eax
0819    ae239:	25 00 44 00 00       	and    $0x4400,%eax
081e    ae23e:	74 07                	je     ae247 <do_user_addr_fault+0x827>
0820    ae240:	e8 00 00 00 00       	call   ae245 <do_user_addr_fault+0x825>	ae241: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0825    ae245:	eb 0d                	jmp    ae254 <do_user_addr_fault+0x834>
0827    ae247:	e8 00 00 00 00       	call   ae24c <do_user_addr_fault+0x82c>	ae248: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
082c    ae24c:	4c 89 ff             	mov    %r15,%rdi
082f    ae24f:	e8 3c 1b 00 00       	call   afd90 <vma_end_read>
0834    ae254:	89 de                	mov    %ebx,%esi
0836    ae256:	81 e6 00 04 00 00    	and    $0x400,%esi
083c    ae25c:	31 ff                	xor    %edi,%edi
083e    ae25e:	e8 00 00 00 00       	call   ae263 <do_user_addr_fault+0x843>	ae25f: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0843    ae263:	89 d8                	mov    %ebx,%eax
0845    ae265:	25 00 04 00 00       	and    $0x400,%eax
084a    ae26a:	75 2b                	jne    ae297 <do_user_addr_fault+0x877>
084c    ae26c:	e8 00 00 00 00       	call   ae271 <do_user_addr_fault+0x851>	ae26d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0851    ae271:	89 de                	mov    %ebx,%esi
0853    ae273:	81 e6 73 08 00 00    	and    $0x873,%esi
0859    ae279:	31 ff                	xor    %edi,%edi
085b    ae27b:	e8 00 00 00 00       	call   ae280 <do_user_addr_fault+0x860>	ae27c: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0860    ae280:	89 d8                	mov    %ebx,%eax
0862    ae282:	25 73 08 00 00       	and    $0x873,%eax
0867    ae287:	0f 85 5b 03 00 00    	jne    ae5e8 <do_user_addr_fault+0xbc8>
086d    ae28d:	e8 00 00 00 00       	call   ae292 <do_user_addr_fault+0x872>	ae28e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0872    ae292:	e9 62 fe ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0877    ae297:	4d 8b 3c 24          	mov    (%r12),%r15
087b    ae29b:	4c 89 fe             	mov    %r15,%rsi
087e    ae29e:	48 83 e6 04          	and    $0x4,%rsi
0882    ae2a2:	31 ff                	xor    %edi,%edi
0884    ae2a4:	e8 00 00 00 00       	call   ae2a9 <do_user_addr_fault+0x889>	ae2a5: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0889    ae2a9:	49 83 e7 04          	and    $0x4,%r15
088d    ae2ad:	75 07                	jne    ae2b6 <do_user_addr_fault+0x896>
088f    ae2af:	e8 00 00 00 00       	call   ae2b4 <do_user_addr_fault+0x894>	ae2b0: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0894    ae2b4:	eb 2b                	jmp    ae2e1 <do_user_addr_fault+0x8c1>
0896    ae2b6:	4d 8b bc 24 c0 0b 00 00 	mov    0xbc0(%r12),%r15
089e    ae2be:	41 bd 00 01 00 00    	mov    $0x100,%r13d
08a4    ae2c4:	be 00 01 00 00       	mov    $0x100,%esi
08a9    ae2c9:	4c 21 fe             	and    %r15,%rsi
08ac    ae2cc:	31 ff                	xor    %edi,%edi
08ae    ae2ce:	e8 00 00 00 00       	call   ae2d3 <do_user_addr_fault+0x8b3>	ae2cf: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
08b3    ae2d3:	4d 21 fd             	and    %r15,%r13
08b6    ae2d6:	0f 85 15 01 00 00    	jne    ae3f1 <do_user_addr_fault+0x9d1>
08bc    ae2dc:	e8 00 00 00 00       	call   ae2e1 <do_user_addr_fault+0x8c1>	ae2dd: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
08c1    ae2e1:	83 e3 04             	and    $0x4,%ebx
08c4    ae2e4:	45 8d 34 de          	lea    (%r14,%rbx,8),%r14d
08c8    ae2e8:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
08cc    ae2ec:	0f b7 98 88 00 00 00 	movzwl 0x88(%rax),%ebx
08d3    ae2f3:	89 de                	mov    %ebx,%esi
08d5    ae2f5:	83 e6 03             	and    $0x3,%esi
08d8    ae2f8:	31 ff                	xor    %edi,%edi
08da    ae2fa:	e8 00 00 00 00       	call   ae2ff <do_user_addr_fault+0x8df>	ae2fb: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
08df    ae2ff:	89 d8                	mov    %ebx,%eax
08e1    ae301:	83 e0 03             	and    $0x3,%eax
08e4    ae304:	0f 84 8b 00 00 00    	je     ae395 <do_user_addr_fault+0x975>
08ea    ae30a:	4d 8b 3c 24          	mov    (%r12),%r15
08ee    ae30e:	41 bd 00 00 02 00    	mov    $0x20000,%r13d
08f4    ae314:	be 00 00 02 00       	mov    $0x20000,%esi
08f9    ae319:	4c 21 fe             	and    %r15,%rsi
08fc    ae31c:	31 ff                	xor    %edi,%edi
08fe    ae31e:	e8 00 00 00 00       	call   ae323 <do_user_addr_fault+0x903>	ae31f: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0903    ae323:	4d 21 fd             	and    %r15,%r13
0906    ae326:	0f 85 28 03 00 00    	jne    ae654 <do_user_addr_fault+0xc34>
090c    ae32c:	4d 8b 3c 24          	mov    (%r12),%r15
0910    ae330:	4c 89 fe             	mov    %r15,%rsi
0913    ae333:	48 83 e6 04          	and    $0x4,%rsi
0917    ae337:	31 ff                	xor    %edi,%edi
0919    ae339:	e8 00 00 00 00       	call   ae33e <do_user_addr_fault+0x91e>	ae33a: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
091e    ae33e:	49 83 e7 04          	and    $0x4,%r15
0922    ae342:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0926    ae346:	0f 85 bc 00 00 00    	jne    ae408 <do_user_addr_fault+0x9e8>
092c    ae34c:	e8 00 00 00 00       	call   ae351 <do_user_addr_fault+0x931>	ae34d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0931    ae351:	e9 20 fa ff ff       	jmp    add76 <do_user_addr_fault+0x356>
0936    ae356:	89 de                	mov    %ebx,%esi
0938    ae358:	81 e6 00 40 00 00    	and    $0x4000,%esi
093e    ae35e:	31 ff                	xor    %edi,%edi
0940    ae360:	e8 00 00 00 00       	call   ae365 <do_user_addr_fault+0x945>	ae361: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0945    ae365:	89 d8                	mov    %ebx,%eax
0947    ae367:	25 00 40 00 00       	and    $0x4000,%eax
094c    ae36c:	0f 85 db 00 00 00    	jne    ae44d <do_user_addr_fault+0xa2d>
0952    ae372:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
0957    ae377:	e8 00 00 00 00       	call   ae37c <do_user_addr_fault+0x95c>	ae378: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
095c    ae37c:	4c 8b 65 a8          	mov    -0x58(%rbp),%r12
0960    ae380:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
0964    ae384:	48 81 c7 18 01 00 00 	add    $0x118,%rdi
096b    ae38b:	e8 00 00 00 00       	call   ae390 <do_user_addr_fault+0x970>	ae38c: R_X86_64_PLT32	up_read-0x4
0970    ae390:	e9 dc fe ff ff       	jmp    ae271 <do_user_addr_fault+0x851>
0975    ae395:	e8 00 00 00 00       	call   ae39a <do_user_addr_fault+0x97a>	ae396: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
097a    ae39a:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
097e    ae39e:	e9 d3 f9 ff ff       	jmp    add76 <do_user_addr_fault+0x356>
0983    ae3a3:	49 8b 5f 20          	mov    0x20(%r15),%rbx
0987    ae3a7:	e9 00 00 00 00       	jmp    ae3ac <do_user_addr_fault+0x98c>	ae3a8: R_X86_64_PLT32	.altinstr_aux+0x155c
098c    ae3ac:	e8 00 00 00 00       	call   ae3b1 <do_user_addr_fault+0x991>	ae3ad: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0991    ae3b1:	31 c9                	xor    %ecx,%ecx
0993    ae3b3:	0f 01 ee             	rdpkru
0996    ae3b6:	48 c1 eb 1f          	shr    $0x1f,%rbx
099a    ae3ba:	83 e3 1e             	and    $0x1e,%ebx
099d    ae3bd:	48 89 5d 88          	mov    %rbx,-0x78(%rbp)
09a1    ae3c1:	41 bd 01 00 00 00    	mov    $0x1,%r13d
09a7    ae3c7:	89 d9                	mov    %ebx,%ecx
09a9    ae3c9:	41 d3 e5             	shl    %cl,%r13d
09ac    ae3cc:	89 c6                	mov    %eax,%esi
09ae    ae3ce:	44 21 ee             	and    %r13d,%esi
09b1    ae3d1:	31 ff                	xor    %edi,%edi
09b3    ae3d3:	89 c3                	mov    %eax,%ebx
09b5    ae3d5:	e8 00 00 00 00       	call   ae3da <do_user_addr_fault+0x9ba>	ae3d6: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
09ba    ae3da:	41 21 dd             	and    %ebx,%r13d
09bd    ae3dd:	0f 84 d1 00 00 00    	je     ae4b4 <do_user_addr_fault+0xa94>
09c3    ae3e3:	e8 00 00 00 00       	call   ae3e8 <do_user_addr_fault+0x9c8>	ae3e4: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
09c8    ae3e8:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
09cc    ae3ec:	e9 6e f9 ff ff       	jmp    add5f <do_user_addr_fault+0x33f>
09d1    ae3f1:	e8 00 00 00 00       	call   ae3f6 <do_user_addr_fault+0x9d6>	ae3f2: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
09d6    ae3f6:	4c 8b 7d c0          	mov    -0x40(%rbp),%r15
09da    ae3fa:	41 0f b7 9f 88 00 00 00 	movzwl 0x88(%r15),%ebx
09e2    ae402:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
09e6    ae406:	eb 09                	jmp    ae411 <do_user_addr_fault+0x9f1>
09e8    ae408:	e8 00 00 00 00       	call   ae40d <do_user_addr_fault+0x9ed>	ae409: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
09ed    ae40d:	4c 8b 7d c0          	mov    -0x40(%rbp),%r15
09f1    ae411:	83 e3 03             	and    $0x3,%ebx
09f4    ae414:	31 ff                	xor    %edi,%edi
09f6    ae416:	89 de                	mov    %ebx,%esi
09f8    ae418:	e8 00 00 00 00       	call   ae41d <do_user_addr_fault+0x9fd>	ae419: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
09fd    ae41d:	85 db                	test   %ebx,%ebx
09ff    ae41f:	48 8b 5d b8          	mov    -0x48(%rbp),%rbx
0a03    ae423:	74 0a                	je     ae42f <do_user_addr_fault+0xa0f>
0a05    ae425:	e8 00 00 00 00       	call   ae42a <do_user_addr_fault+0xa0a>	ae426: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a0a    ae42a:	e9 ca fc ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0a0f    ae42f:	e8 00 00 00 00       	call   ae434 <do_user_addr_fault+0xa14>	ae430: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a14    ae434:	4c 89 ff             	mov    %r15,%rdi
0a17    ae437:	48 89 de             	mov    %rbx,%rsi
0a1a    ae43a:	eb 53                	jmp    ae48f <do_user_addr_fault+0xa6f>
0a1c    ae43c:	e8 00 00 00 00       	call   ae441 <do_user_addr_fault+0xa21>	ae43d: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a21    ae441:	eb 22                	jmp    ae465 <do_user_addr_fault+0xa45>
0a23    ae443:	e8 00 00 00 00       	call   ae448 <do_user_addr_fault+0xa28>	ae444: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a28    ae448:	e9 ac fc ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0a2d    ae44d:	e8 00 00 00 00       	call   ae452 <do_user_addr_fault+0xa32>	ae44e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a32    ae452:	e9 a2 fc ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0a37    ae457:	e8 00 00 00 00       	call   ae45c <do_user_addr_fault+0xa3c>	ae458: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a3c    ae45c:	45 0f b7 a4 24 88 00 00 00 	movzwl 0x88(%r12),%r12d
0a45    ae465:	41 83 e4 03          	and    $0x3,%r12d
0a49    ae469:	31 ff                	xor    %edi,%edi
0a4b    ae46b:	44 89 e6             	mov    %r12d,%esi
0a4e    ae46e:	e8 00 00 00 00       	call   ae473 <do_user_addr_fault+0xa53>	ae46f: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
0a53    ae473:	45 85 e4             	test   %r12d,%r12d
0a56    ae476:	74 0a                	je     ae482 <do_user_addr_fault+0xa62>
0a58    ae478:	e8 00 00 00 00       	call   ae47d <do_user_addr_fault+0xa5d>	ae479: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a5d    ae47d:	e9 77 fc ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0a62    ae482:	e8 00 00 00 00       	call   ae487 <do_user_addr_fault+0xa67>	ae483: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a67    ae487:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
0a6b    ae48b:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0a6f    ae48f:	4c 89 ea             	mov    %r13,%rdx
0a72    ae492:	b9 07 00 00 00       	mov    $0x7,%ecx
0a77    ae497:	41 b8 02 00 00 00    	mov    $0x2,%r8d
0a7d    ae49d:	45 31 c9             	xor    %r9d,%r9d
0a80    ae4a0:	e8 3b 09 00 00       	call   aede0 <kernelmode_fixup_or_oops>
0a85    ae4a5:	e9 4f fc ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0a8a    ae4aa:	e8 00 00 00 00       	call   ae4af <do_user_addr_fault+0xa8f>	ae4ab: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0a8f    ae4af:	e9 45 fc ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0a94    ae4b4:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
0a98    ae4b8:	48 83 7d 90 00       	cmpq   $0x0,-0x70(%rbp)
0a9d    ae4bd:	75 2a                	jne    ae4e9 <do_user_addr_fault+0xac9>
0a9f    ae4bf:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
0aa4    ae4c4:	75 4e                	jne    ae514 <do_user_addr_fault+0xaf4>
0aa6    ae4c6:	e8 00 00 00 00       	call   ae4cb <do_user_addr_fault+0xaab>	ae4c7: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0aab    ae4cb:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0aaf    ae4cf:	e9 97 fc ff ff       	jmp    ae16b <do_user_addr_fault+0x74b>
0ab4    ae4d4:	e8 00 00 00 00       	call   ae4d9 <do_user_addr_fault+0xab9>	ae4d5: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0ab9    ae4d9:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
0abd    ae4dd:	4c 89 f7             	mov    %r14,%rdi
0ac0    ae4e0:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0ac4    ae4e4:	e9 93 00 00 00       	jmp    ae57c <do_user_addr_fault+0xb5c>
0ac9    ae4e9:	41 bd 03 00 00 00    	mov    $0x3,%r13d
0acf    ae4ef:	41 d3 e5             	shl    %cl,%r13d
0ad2    ae4f2:	89 de                	mov    %ebx,%esi
0ad4    ae4f4:	44 21 ee             	and    %r13d,%esi
0ad7    ae4f7:	31 ff                	xor    %edi,%edi
0ad9    ae4f9:	e8 00 00 00 00       	call   ae4fe <do_user_addr_fault+0xade>	ae4fa: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0ade    ae4fe:	41 21 dd             	and    %ebx,%r13d
0ae1    ae501:	74 1b                	je     ae51e <do_user_addr_fault+0xafe>
0ae3    ae503:	e8 00 00 00 00       	call   ae508 <do_user_addr_fault+0xae8>	ae504: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0ae8    ae508:	e9 db fe ff ff       	jmp    ae3e8 <do_user_addr_fault+0x9c8>
0aed    ae50d:	e8 00 00 00 00       	call   ae512 <do_user_addr_fault+0xaf2>	ae50e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0af2    ae512:	eb 20                	jmp    ae534 <do_user_addr_fault+0xb14>
0af4    ae514:	e8 00 00 00 00       	call   ae519 <do_user_addr_fault+0xaf9>	ae515: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0af9    ae519:	e9 7f fc ff ff       	jmp    ae19d <do_user_addr_fault+0x77d>
0afe    ae51e:	48 83 7d 98 00       	cmpq   $0x0,-0x68(%rbp)
0b03    ae523:	75 64                	jne    ae589 <do_user_addr_fault+0xb69>
0b05    ae525:	e8 00 00 00 00       	call   ae52a <do_user_addr_fault+0xb0a>	ae526: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b0a    ae52a:	e9 9e fc ff ff       	jmp    ae1cd <do_user_addr_fault+0x7ad>
0b0f    ae52f:	e8 00 00 00 00       	call   ae534 <do_user_addr_fault+0xb14>	ae530: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b14    ae534:	4d 89 e7             	mov    %r12,%r15
0b17    ae537:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0b1b    ae53b:	e9 a2 fb ff ff       	jmp    ae0e2 <do_user_addr_fault+0x6c2>
0b20    ae540:	e8 00 00 00 00       	call   ae545 <do_user_addr_fault+0xb25>	ae541: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b25    ae545:	eb 5f                	jmp    ae5a6 <do_user_addr_fault+0xb86>
0b27    ae547:	e8 00 00 00 00       	call   ae54c <do_user_addr_fault+0xb2c>	ae548: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b2c    ae54c:	4c 89 e7             	mov    %r12,%rdi
0b2f    ae54f:	4c 89 f6             	mov    %r14,%rsi
0b32    ae552:	4c 89 ea             	mov    %r13,%rdx
0b35    ae555:	e8 b6 15 00 00       	call   afb10 <pgtable_bad>
0b3a    ae55a:	e9 04 f6 ff ff       	jmp    adb63 <do_user_addr_fault+0x143>
0b3f    ae55f:	e8 00 00 00 00       	call   ae564 <do_user_addr_fault+0xb44>	ae560: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b44    ae564:	eb 10                	jmp    ae576 <do_user_addr_fault+0xb56>
0b46    ae566:	e8 00 00 00 00       	call   ae56b <do_user_addr_fault+0xb4b>	ae567: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b4b    ae56b:	eb 09                	jmp    ae576 <do_user_addr_fault+0xb56>
0b4d    ae56d:	e8 00 00 00 00       	call   ae572 <do_user_addr_fault+0xb52>	ae56e: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b52    ae572:	90                   	nop
0b53    ae573:	0f 0b                	ud2
0b55    ae575:	90                   	nop
0b56    ae576:	4c 89 e7             	mov    %r12,%rdi
0b59    ae579:	4c 89 f6             	mov    %r14,%rsi
0b5c    ae57c:	4c 89 ea             	mov    %r13,%rdx
0b5f    ae57f:	e8 0c 04 00 00       	call   ae990 <bad_area_nosemaphore>
0b64    ae584:	e9 70 fb ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0b69    ae589:	e8 00 00 00 00       	call   ae58e <do_user_addr_fault+0xb6e>	ae58a: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b6e    ae58e:	e9 0a fc ff ff       	jmp    ae19d <do_user_addr_fault+0x77d>
0b73    ae593:	e8 00 00 00 00       	call   ae598 <do_user_addr_fault+0xb78>	ae594: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b78    ae598:	90                   	nop
0b79    ae599:	0f 0b                	ud2
0b7b    ae59b:	90                   	nop
0b7c    ae59c:	e9 58 fb ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0b81    ae5a1:	e8 00 00 00 00       	call   ae5a6 <do_user_addr_fault+0xb86>	ae5a2: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b86    ae5a6:	4c 89 e7             	mov    %r12,%rdi
0b89    ae5a9:	4c 89 f6             	mov    %r14,%rsi
0b8c    ae5ac:	4c 89 ea             	mov    %r13,%rdx
0b8f    ae5af:	e8 cc 09 00 00       	call   aef80 <page_fault_oops>
0b94    ae5b4:	e9 40 fb ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0b99    ae5b9:	e8 00 00 00 00       	call   ae5be <do_user_addr_fault+0xb9e>	ae5ba: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0b9e    ae5be:	e9 1a ff ff ff       	jmp    ae4dd <do_user_addr_fault+0xabd>
0ba3    ae5c3:	e8 00 00 00 00       	call   ae5c8 <do_user_addr_fault+0xba8>	ae5c4: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0ba8    ae5c8:	e9 98 fe ff ff       	jmp    ae465 <do_user_addr_fault+0xa45>
0bad    ae5cd:	e8 00 00 00 00       	call   ae5d2 <do_user_addr_fault+0xbb2>	ae5ce: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0bb2    ae5d2:	eb 0c                	jmp    ae5e0 <do_user_addr_fault+0xbc0>
0bb4    ae5d4:	e8 00 00 00 00       	call   ae5d9 <do_user_addr_fault+0xbb9>	ae5d5: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0bb9    ae5d9:	eb 05                	jmp    ae5e0 <do_user_addr_fault+0xbc0>
0bbb    ae5db:	e8 00 00 00 00       	call   ae5e0 <do_user_addr_fault+0xbc0>	ae5dc: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0bc0    ae5e0:	4d 89 e7             	mov    %r12,%r15
0bc3    ae5e3:	e9 fa fa ff ff       	jmp    ae0e2 <do_user_addr_fault+0x6c2>
0bc8    ae5e8:	4d 8b 3c 24          	mov    (%r12),%r15
0bcc    ae5ec:	4c 89 fe             	mov    %r15,%rsi
0bcf    ae5ef:	48 83 e6 04          	and    $0x4,%rsi
0bd3    ae5f3:	31 ff                	xor    %edi,%edi
0bd5    ae5f5:	e8 00 00 00 00       	call   ae5fa <do_user_addr_fault+0xbda>	ae5f6: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0bda    ae5fa:	49 83 e7 04          	and    $0x4,%r15
0bde    ae5fe:	75 14                	jne    ae614 <do_user_addr_fault+0xbf4>
0be0    ae600:	e8 00 00 00 00       	call   ae605 <do_user_addr_fault+0xbe5>	ae601: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0be5    ae605:	e9 80 00 00 00       	jmp    ae68a <do_user_addr_fault+0xc6a>
0bea    ae60a:	e8 00 00 00 00       	call   ae60f <do_user_addr_fault+0xbef>	ae60b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0bef    ae60f:	e9 d4 fd ff ff       	jmp    ae3e8 <do_user_addr_fault+0x9c8>
0bf4    ae614:	48 8b 45 a8          	mov    -0x58(%rbp),%rax
0bf8    ae618:	4c 8b b8 c0 0b 00 00 	mov    0xbc0(%rax),%r15
0bff    ae61f:	41 bc 00 01 00 00    	mov    $0x100,%r12d
0c05    ae625:	be 00 01 00 00       	mov    $0x100,%esi
0c0a    ae62a:	4c 21 fe             	and    %r15,%rsi
0c0d    ae62d:	31 ff                	xor    %edi,%edi
0c0f    ae62f:	e8 00 00 00 00       	call   ae634 <do_user_addr_fault+0xc14>	ae630: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp8-0x4
0c14    ae634:	4d 21 fc             	and    %r15,%r12
0c17    ae637:	75 29                	jne    ae662 <do_user_addr_fault+0xc42>
0c19    ae639:	e8 00 00 00 00       	call   ae63e <do_user_addr_fault+0xc1e>	ae63a: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0c1e    ae63e:	eb 4a                	jmp    ae68a <do_user_addr_fault+0xc6a>
0c20    ae640:	e8 00 00 00 00       	call   ae645 <do_user_addr_fault+0xc25>	ae641: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0c25    ae645:	e9 15 f7 ff ff       	jmp    add5f <do_user_addr_fault+0x33f>
0c2a    ae64a:	e8 00 00 00 00       	call   ae64f <do_user_addr_fault+0xc2f>	ae64b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0c2f    ae64f:	e9 94 fd ff ff       	jmp    ae3e8 <do_user_addr_fault+0x9c8>
0c34    ae654:	e8 00 00 00 00       	call   ae659 <do_user_addr_fault+0xc39>	ae655: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0c39    ae659:	4c 8b 6d b0          	mov    -0x50(%rbp),%r13
0c3d    ae65d:	e9 ab fd ff ff       	jmp    ae40d <do_user_addr_fault+0x9ed>
0c42    ae662:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0c46    ae666:	44 0f b7 b8 88 00 00 00 	movzwl 0x88(%rax),%r15d
0c4e    ae66e:	44 89 fe             	mov    %r15d,%esi
0c51    ae671:	83 e6 03             	and    $0x3,%esi
0c54    ae674:	31 ff                	xor    %edi,%edi
0c56    ae676:	e8 00 00 00 00       	call   ae67b <do_user_addr_fault+0xc5b>	ae677: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
0c5b    ae67b:	41 83 e7 03          	and    $0x3,%r15d
0c5f    ae67f:	0f 84 b3 00 00 00    	je     ae738 <do_user_addr_fault+0xd18>
0c65    ae685:	e8 00 00 00 00       	call   ae68a <do_user_addr_fault+0xc6a>	ae686: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0c6a    ae68a:	89 de                	mov    %ebx,%esi
0c6c    ae68c:	83 e6 01             	and    $0x1,%esi
0c6f    ae68f:	31 ff                	xor    %edi,%edi
0c71    ae691:	e8 00 00 00 00       	call   ae696 <do_user_addr_fault+0xc76>	ae692: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0c76    ae696:	89 d8                	mov    %ebx,%eax
0c78    ae698:	83 e0 01             	and    $0x1,%eax
0c7b    ae69b:	75 2d                	jne    ae6ca <do_user_addr_fault+0xcaa>
0c7d    ae69d:	89 de                	mov    %ebx,%esi
0c7f    ae69f:	83 e6 32             	and    $0x32,%esi
0c82    ae6a2:	31 ff                	xor    %edi,%edi
0c84    ae6a4:	e8 00 00 00 00       	call   ae6a9 <do_user_addr_fault+0xc89>	ae6a5: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0c89    ae6a9:	89 d8                	mov    %ebx,%eax
0c8b    ae6ab:	83 e0 32             	and    $0x32,%eax
0c8e    ae6ae:	74 45                	je     ae6f5 <do_user_addr_fault+0xcd5>
0c90    ae6b0:	e8 00 00 00 00       	call   ae6b5 <do_user_addr_fault+0xc95>	ae6b1: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0c95    ae6b5:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
0c99    ae6b9:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0c9d    ae6bd:	4c 89 ea             	mov    %r13,%rdx
0ca0    ae6c0:	e8 4b 18 00 00       	call   aff10 <do_sigbus>
0ca5    ae6c5:	e9 2f fa ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0caa    ae6ca:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
0cae    ae6ce:	0f b7 98 88 00 00 00 	movzwl 0x88(%rax),%ebx
0cb5    ae6d5:	89 de                	mov    %ebx,%esi
0cb7    ae6d7:	83 e6 03             	and    $0x3,%esi
0cba    ae6da:	31 ff                	xor    %edi,%edi
0cbc    ae6dc:	e8 00 00 00 00       	call   ae6e1 <do_user_addr_fault+0xcc1>	ae6dd: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp2-0x4
0cc1    ae6e1:	83 e3 03             	and    $0x3,%ebx
0cc4    ae6e4:	74 32                	je     ae718 <do_user_addr_fault+0xcf8>
0cc6    ae6e6:	e8 00 00 00 00       	call   ae6eb <do_user_addr_fault+0xccb>	ae6e7: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0ccb    ae6eb:	e8 00 00 00 00       	call   ae6f0 <do_user_addr_fault+0xcd0>	ae6ec: R_X86_64_PLT32	pagefault_out_of_memory-0x4
0cd0    ae6f0:	e9 04 fa ff ff       	jmp    ae0f9 <do_user_addr_fault+0x6d9>
0cd5    ae6f5:	89 de                	mov    %ebx,%esi
0cd7    ae6f7:	83 e6 40             	and    $0x40,%esi
0cda    ae6fa:	31 ff                	xor    %edi,%edi
0cdc    ae6fc:	e8 00 00 00 00       	call   ae701 <do_user_addr_fault+0xce1>	ae6fd: R_X86_64_PLT32	__sanitizer_cov_trace_const_cmp4-0x4
0ce1    ae701:	83 e3 40             	and    $0x40,%ebx
0ce4    ae704:	0f 84 bf 00 00 00    	je     ae7c9 <do_user_addr_fault+0xda9>
0cea    ae70a:	e8 00 00 00 00       	call   ae70f <do_user_addr_fault+0xcef>	ae70b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0cef    ae70f:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
0cf3    ae713:	e9 c8 fd ff ff       	jmp    ae4e0 <do_user_addr_fault+0xac0>
0cf8    ae718:	e8 00 00 00 00       	call   ae71d <do_user_addr_fault+0xcfd>	ae719: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0cfd    ae71d:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
0d01    ae721:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0d05    ae725:	4c 89 ea             	mov    %r13,%rdx
0d08    ae728:	b9 0b 00 00 00       	mov    $0xb,%ecx
0d0d    ae72d:	41 b8 01 00 00 00    	mov    $0x1,%r8d
0d13    ae733:	e9 65 fd ff ff       	jmp    ae49d <do_user_addr_fault+0xa7d>
0d18    ae738:	e8 00 00 00 00       	call   ae73d <do_user_addr_fault+0xd1d>	ae739: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d1d    ae73d:	48 8b 7d c0          	mov    -0x40(%rbp),%rdi
0d21    ae741:	48 8b 75 b8          	mov    -0x48(%rbp),%rsi
0d25    ae745:	4c 89 ea             	mov    %r13,%rdx
0d28    ae748:	31 c9                	xor    %ecx,%ecx
0d2a    ae74a:	45 31 c0             	xor    %r8d,%r8d
0d2d    ae74d:	e9 4b fd ff ff       	jmp    ae49d <do_user_addr_fault+0xa7d>
0d32    ae752:	e8 00 00 00 00       	call   ae757 <do_user_addr_fault+0xd37>	ae753: R_X86_64_PLT32	__stack_chk_fail-0x4
0d37    ae757:	e8 00 00 00 00       	call   ae75c <do_user_addr_fault+0xd3c>	ae758: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d3c    ae75c:	e9 0c f4 ff ff       	jmp    adb6d <do_user_addr_fault+0x14d>
0d41    ae761:	e8 00 00 00 00       	call   ae766 <do_user_addr_fault+0xd46>	ae762: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d46    ae766:	e9 4b f4 ff ff       	jmp    adbb6 <do_user_addr_fault+0x196>
0d4b    ae76b:	e8 00 00 00 00       	call   ae770 <do_user_addr_fault+0xd50>	ae76c: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d50    ae770:	be 01 00 00 00       	mov    $0x1,%esi
0d55    ae775:	bf 02 00 00 00       	mov    $0x2,%edi
0d5a    ae77a:	4c 89 e2             	mov    %r12,%rdx
0d5d    ae77d:	4c 89 e9             	mov    %r13,%rcx
0d60    ae780:	e8 00 00 00 00       	call   ae785 <do_user_addr_fault+0xd65>	ae781: R_X86_64_PLT32	__perf_sw_event-0x4
0d65    ae785:	e9 aa f4 ff ff       	jmp    adc34 <do_user_addr_fault+0x214>
0d6a    ae78a:	e8 00 00 00 00       	call   ae78f <do_user_addr_fault+0xd6f>	ae78b: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d6f    ae78f:	e9 4c fe ff ff       	jmp    ae5e0 <do_user_addr_fault+0xbc0>
0d74    ae794:	e8 00 00 00 00       	call   ae799 <do_user_addr_fault+0xd79>	ae795: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d79    ae799:	e9 c1 f5 ff ff       	jmp    add5f <do_user_addr_fault+0x33f>
0d7e    ae79e:	e8 00 00 00 00       	call   ae7a3 <do_user_addr_fault+0xd83>	ae79f: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d83    ae7a3:	e9 09 fc ff ff       	jmp    ae3b1 <do_user_addr_fault+0x991>
0d88    ae7a8:	e8 00 00 00 00       	call   ae7ad <do_user_addr_fault+0xd8d>	ae7a9: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d8d    ae7ad:	31 c0                	xor    %eax,%eax
0d8f    ae7af:	e9 02 fc ff ff       	jmp    ae3b6 <do_user_addr_fault+0x996>
0d94    ae7b4:	e8 00 00 00 00       	call   ae7b9 <do_user_addr_fault+0xd99>	ae7b5: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0d99    ae7b9:	48 8b 7d a0          	mov    -0x60(%rbp),%rdi
0d9d    ae7bd:	31 f6                	xor    %esi,%esi
0d9f    ae7bf:	e8 00 00 00 00       	call   ae7c4 <do_user_addr_fault+0xda4>	ae7c0: R_X86_64_PLT32	__mmap_lock_do_trace_released-0x4
0da4    ae7c4:	e9 b3 fb ff ff       	jmp    ae37c <do_user_addr_fault+0x95c>
0da9    ae7c9:	e8 00 00 00 00       	call   ae7ce <do_user_addr_fault+0xdae>	ae7ca: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
0dae    ae7ce:	90                   	nop
0daf    ae7cf:	0f 0b                	ud2
0db1    ae7d1:	66 2e 0f 1f 84 00 00 00 00 00 	cs nopw 0x0(%rax,%rax,1)
0dbb    ae7db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

