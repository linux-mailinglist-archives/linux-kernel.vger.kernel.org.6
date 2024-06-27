Return-Path: <linux-kernel+bounces-232074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834F91A2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4149DB22005
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117213AA20;
	Thu, 27 Jun 2024 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+QszUM4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F513A418
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480922; cv=none; b=l0t2v4G2G0Gu/VqO7LvHNdP8CC2ftpQJ/OvYUI0fpMH3hSyun01boww5fOQh8soSwom6FJORtK3CJrlDjWxVPqnyuRd6qOoC09U7kutLx0+sxeIR9au8u8xjte5KBmqMAXa+rlsZWi9qa/46VsEEGo5CfjSO189qhbjAgwTDIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480922; c=relaxed/simple;
	bh=r6P8kzX+NGW8tcn+P3LI8V28L+TFHY08GCcbsYIhEcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rHv9vtNNQSXi+wyjZB0+MSsrXPn47pJPwTh0/KdhP7MCHCiyM2aC7eiL5lIjqVvMECMdO5c8sCMsvNCWWMn6cIbXVcbe1EHm7+EYuSZD9t7Nv/JScT6Db1qk65b2emgHU8CruWPexJijvPMOtRDMPzitZDo+ZRTGql4XfmUunNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+QszUM4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719480918; x=1751016918;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r6P8kzX+NGW8tcn+P3LI8V28L+TFHY08GCcbsYIhEcQ=;
  b=c+QszUM4BS84qmAK+ExdSFgmpvvVDNFJYIyCT37Ht4nmovetv/B9mcpc
   Myvqr1KaHh1CKyHD+aunzbLJZXxKOwY0jQ5Y8dZVfdkl4okkGYaw7A5l6
   a807lrMB09o4+cZyXg2V97S6q5k6m3plwxY3ZvU/+F7v9yHwWS90cbDgP
   5uei2FKxBFKqauOsapgRZ1auzojyN60c2iwCHoDq5EAvGmWXjUpH7JRRS
   PeT5/BNgasfCUpN3QXqOl97cpr+6RJs/EoYF5C64YMlsNkaivlHeWXJBH
   wmmVVn9w5XqTlng75lIsT9fmE+n5U8r5WDKXiKaxlKUmMuTTayrIRcuqJ
   Q==;
X-CSE-ConnectionGUID: L0MbAm23QmWaY3nBud541g==
X-CSE-MsgGUID: ZPKxEXtGTnSrshInXC88aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16735822"
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="16735822"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 02:35:17 -0700
X-CSE-ConnectionGUID: D+lwUij8Siyrh7+70QtfFg==
X-CSE-MsgGUID: azWzWMAQTIu1BChSCoVdEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,269,1712646000"; 
   d="scan'208";a="44728454"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Jun 2024 02:35:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMlX5-000G62-11;
	Thu, 27 Jun 2024 09:35:11 +0000
Date: Thu, 27 Jun 2024 17:35:03 +0800
From: kernel test robot <lkp@intel.com>
To: Jakob Koschel <jkl820.git@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: vmlinux.o: warning: objtool: leaf_cut_from_buffer+0x2396: stack
 state mismatch: cfa1=4+288 cfa2=4+304
Message-ID: <202406271717.ZT2RKqOf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   afcd48134c58d6af45fb3fdb648f1260b20f2326
commit: 349fde599db65d4827820ef6553e3f9ee75b8c7c arch: enable HAS_LTO_CLANG with KASAN and KCOV
date:   10 months ago
config: x86_64-randconfig-r123-20240626 (https://download.01.org/0day-ci/archive/20240627/202406271717.ZT2RKqOf-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406271717.ZT2RKqOf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406271717.ZT2RKqOf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: balance_leaf+0x11075: stack state mismatch: cfa1=4+624 cfa2=4+640
>> vmlinux.o: warning: objtool: leaf_cut_from_buffer+0x2396: stack state mismatch: cfa1=4+288 cfa2=4+304
   vmlinux.o: warning: objtool: leaf_copy_items_entirely+0xcf6: stack state mismatch: cfa1=4+240 cfa2=4+232
   vmlinux.o: warning: objtool: balance_internal+0x1073: stack state mismatch: cfa1=4+352 cfa2=4+360
   vmlinux.o: warning: objtool: internal_move_pointers_items+0x795: stack state mismatch: cfa1=4+224 cfa2=4+216
   vmlinux.o: warning: objtool: .text.amd_spi_master_transfer: unexpected end of section


objdump-func vmlinux.o leaf_cut_from_buffer:
0000 0000000000000010 <leaf_cut_from_buffer>:
0000       10:	f3 0f 1e fa          	endbr64
0004       14:	55                   	push   %rbp
0005       15:	41 57                	push   %r15
0007       17:	41 56                	push   %r14
0009       19:	41 55                	push   %r13
000b       1b:	41 54                	push   %r12
000d       1d:	53                   	push   %rbx
000e       1e:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
0015       25:	48 89 4c 24 30       	mov    %rcx,0x30(%rsp)
001a       2a:	41 89 d4             	mov    %edx,%r12d
001d       2d:	89 f5                	mov    %esi,%ebp
001f       2f:	48 89 fb             	mov    %rdi,%rbx
0022       32:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
002c       3c:	4c 8d 77 08          	lea    0x8(%rdi),%r14
0030       40:	4c 89 f0             	mov    %r14,%rax
0033       43:	48 c1 e8 03          	shr    $0x3,%rax
0037       47:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
003b       4b:	74 12                	je     5f <leaf_cut_from_buffer+0x4f>
003d       4d:	4c 89 f7             	mov    %r14,%rdi
0040       50:	e8 00 00 00 00       	call   55 <leaf_cut_from_buffer+0x45>	51: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0045       55:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
004f       5f:	49 8b 06             	mov    (%r14),%rax
0052       62:	48 89 84 24 88 00 00 00 	mov    %rax,0x88(%rsp)
005a       6a:	4c 8d 68 28          	lea    0x28(%rax),%r13
005e       6e:	4c 89 e8             	mov    %r13,%rax
0061       71:	48 c1 e8 03          	shr    $0x3,%rax
0065       75:	48 89 84 24 a0 00 00 00 	mov    %rax,0xa0(%rsp)
006d       7d:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
0071       81:	74 12                	je     95 <leaf_cut_from_buffer+0x85>
0073       83:	4c 89 ef             	mov    %r13,%rdi
0076       86:	e8 00 00 00 00       	call   8b <leaf_cut_from_buffer+0x7b>	87: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
007b       8b:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0085       95:	4d 8b 75 00          	mov    0x0(%r13),%r14
0089       99:	49 8d 7e 02          	lea    0x2(%r14),%rdi
008d       9d:	48 89 f8             	mov    %rdi,%rax
0090       a0:	48 c1 e8 03          	shr    $0x3,%rax
0094       a4:	8a 04 30             	mov    (%rax,%rsi,1),%al
0097       a7:	84 c0                	test   %al,%al
0099       a9:	0f 85 a2 11 00 00    	jne    1251 <leaf_cut_from_buffer+0x1241>
009f       af:	45 0f b7 46 02       	movzwl 0x2(%r14),%r8d
00a4       b4:	48 63 c5             	movslq %ebp,%rax
00a7       b7:	48 89 84 24 e0 00 00 00 	mov    %rax,0xe0(%rsp)
00af       bf:	4c 8d 1c 40          	lea    (%rax,%rax,2),%r11
00b3       c3:	4f 8d 3c de          	lea    (%r14,%r11,8),%r15
00b7       c7:	49 83 c7 2e          	add    $0x2e,%r15
00bb       cb:	4b 8d 3c de          	lea    (%r14,%r11,8),%rdi
00bf       cf:	48 83 c7 2f          	add    $0x2f,%rdi
00c3       d3:	4c 89 f8             	mov    %r15,%rax
00c6       d6:	48 c1 e8 03          	shr    $0x3,%rax
00ca       da:	48 89 84 24 c0 00 00 00 	mov    %rax,0xc0(%rsp)
00d2       e2:	8a 04 30             	mov    (%rax,%rsi,1),%al
00d5       e5:	84 c0                	test   %al,%al
00d7       e7:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
00dc       ec:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
00e1       f1:	48 89 7c 24 68       	mov    %rdi,0x68(%rsp)
00e6       f6:	0f 85 78 11 00 00    	jne    1274 <leaf_cut_from_buffer+0x1264>
00ec       fc:	48 89 f8             	mov    %rdi,%rax
00ef       ff:	48 c1 e8 03          	shr    $0x3,%rax
00f3      103:	48 89 84 24 b8 00 00 00 	mov    %rax,0xb8(%rsp)
00fb      10b:	8a 04 30             	mov    (%rax,%rsi,1),%al
00fe      10e:	84 c0                	test   %al,%al
0100      110:	0f 85 97 11 00 00    	jne    12ad <leaf_cut_from_buffer+0x129d>
0106      116:	48 89 9c 24 d0 00 00 00 	mov    %rbx,0xd0(%rsp)
010e      11e:	4d 8d 4e 18          	lea    0x18(%r14),%r9
0112      122:	4c 89 b4 24 90 00 00 00 	mov    %r14,0x90(%rsp)
011a      12a:	4f 8d 14 de          	lea    (%r14,%r11,8),%r10
011e      12e:	49 83 c2 18          	add    $0x18,%r10
0122      132:	4c 89 7c 24 50       	mov    %r15,0x50(%rsp)
0127      137:	66 41 83 3f 00       	cmpw   $0x0,(%r15)
012c      13c:	4c 89 14 24          	mov    %r10,(%rsp)
0130      140:	4c 89 a4 24 98 00 00 00 	mov    %r12,0x98(%rsp)
0138      148:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
013d      14d:	4c 89 ac 24 c8 00 00 00 	mov    %r13,0xc8(%rsp)
0145      155:	0f 84 c4 00 00 00    	je     21f <leaf_cut_from_buffer+0x20f>
014b      15b:	4d 8d 72 08          	lea    0x8(%r10),%r14
014f      15f:	4d 8d 7a 0f          	lea    0xf(%r10),%r15
0153      163:	4c 89 f0             	mov    %r14,%rax
0156      166:	48 c1 e8 03          	shr    $0x3,%rax
015a      16a:	8a 04 30             	mov    (%rax,%rsi,1),%al
015d      16d:	84 c0                	test   %al,%al
015f      16f:	0f 85 d8 12 00 00    	jne    144d <leaf_cut_from_buffer+0x143d>
0165      175:	4c 89 f8             	mov    %r15,%rax
0168      178:	48 c1 e8 03          	shr    $0x3,%rax
016c      17c:	8a 04 30             	mov    (%rax,%rsi,1),%al
016f      17f:	84 c0                	test   %al,%al
0171      181:	0f 85 03 13 00 00    	jne    148a <leaf_cut_from_buffer+0x147a>
0177      187:	49 8b 06             	mov    (%r14),%rax
017a      18a:	48 89 c1             	mov    %rax,%rcx
017d      18d:	48 ba 00 00 00 00 00 00 00 f0 	movabs $0xf000000000000000,%rdx
0187      197:	48 21 d1             	and    %rdx,%rcx
018a      19a:	48 ba 00 00 00 00 00 00 00 30 	movabs $0x3000000000000000,%rdx
0194      1a4:	48 39 d1             	cmp    %rdx,%rcx
0197      1a7:	0f 84 d9 00 00 00    	je     286 <leaf_cut_from_buffer+0x276>
019d      1ad:	48 b9 ff ff ff ff ff ff ff 0f 	movabs $0xfffffffffffffff,%rcx
01a7      1b7:	48 39 c8             	cmp    %rcx,%rax
01aa      1ba:	0f 86 9d 00 00 00    	jbe    25d <leaf_cut_from_buffer+0x24d>
01b0      1c0:	45 85 e4             	test   %r12d,%r12d
01b3      1c3:	0f 84 6c 05 00 00    	je     735 <leaf_cut_from_buffer+0x725>
01b9      1c9:	4f 8d 34 d9          	lea    (%r9,%r11,8),%r14
01bd      1cd:	49 83 c6 12          	add    $0x12,%r14
01c1      1d1:	4f 8d 3c d9          	lea    (%r9,%r11,8),%r15
01c5      1d5:	49 83 c7 13          	add    $0x13,%r15
01c9      1d9:	4c 89 f0             	mov    %r14,%rax
01cc      1dc:	48 c1 e8 03          	shr    $0x3,%rax
01d0      1e0:	8a 04 30             	mov    (%rax,%rsi,1),%al
01d3      1e3:	84 c0                	test   %al,%al
01d5      1e5:	0f 85 11 16 00 00    	jne    17fc <leaf_cut_from_buffer+0x17ec>
01db      1eb:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
01e0      1f0:	42 8d 1c 20          	lea    (%rax,%r12,1),%ebx
01e4      1f4:	4c 89 f8             	mov    %r15,%rax
01e7      1f7:	48 c1 e8 03          	shr    $0x3,%rax
01eb      1fb:	8a 04 30             	mov    (%rax,%rsi,1),%al
01ee      1fe:	84 c0                	test   %al,%al
01f0      200:	0f 85 29 16 00 00    	jne    182f <leaf_cut_from_buffer+0x181f>
01f6      206:	41 0f b7 06          	movzwl (%r14),%eax
01fa      20a:	39 c3                	cmp    %eax,%ebx
01fc      20c:	0f 85 65 21 00 00    	jne    2377 <leaf_cut_from_buffer+0x2367>
0202      212:	49 89 ec             	mov    %rbp,%r12
0205      215:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
020a      21a:	e9 09 07 00 00       	jmp    928 <leaf_cut_from_buffer+0x918>
020f      21f:	4d 8d 72 0c          	lea    0xc(%r10),%r14
0213      223:	4d 8d 7a 0f          	lea    0xf(%r10),%r15
0217      227:	4c 89 f0             	mov    %r14,%rax
021a      22a:	48 c1 e8 03          	shr    $0x3,%rax
021e      22e:	8a 04 30             	mov    (%rax,%rsi,1),%al
0221      231:	84 c0                	test   %al,%al
0223      233:	0f 85 cf 14 00 00    	jne    1708 <leaf_cut_from_buffer+0x16f8>
0229      239:	4c 89 f8             	mov    %r15,%rax
022c      23c:	48 c1 e8 03          	shr    $0x3,%rax
0230      240:	8a 04 30             	mov    (%rax,%rsi,1),%al
0233      243:	84 c0                	test   %al,%al
0235      245:	0f 85 fa 14 00 00    	jne    1745 <leaf_cut_from_buffer+0x1735>
023b      24b:	41 8b 06             	mov    (%r14),%eax
023e      24e:	3d f4 01 00 00       	cmp    $0x1f4,%eax
0243      253:	74 31                	je     286 <leaf_cut_from_buffer+0x276>
0245      255:	85 c0                	test   %eax,%eax
0247      257:	0f 85 63 ff ff ff    	jne    1c0 <leaf_cut_from_buffer+0x1b0>
024d      25d:	31 ff                	xor    %edi,%edi
024f      25f:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	262: R_X86_64_32S	.rodata..str+0x88a0
0256      266:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	269: R_X86_64_32S	.rodata.str1.1+0x767b
025d      26d:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx	270: R_X86_64_32S	.rodata..str.34+0x19a0
0264      274:	41 b8 96 04 00 00    	mov    $0x496,%r8d
026a      27a:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9	27d: R_X86_64_32S	.rodata.str1.1+0x767b
0271      281:	e8 00 00 00 00       	call   286 <leaf_cut_from_buffer+0x276>	282: R_X86_64_PLT32	__reiserfs_panic-0x4
0276      286:	4b 8d 14 d9          	lea    (%r9,%r11,8),%rdx
027a      28a:	48 83 c2 10          	add    $0x10,%rdx
027e      28e:	4f 8d 34 d9          	lea    (%r9,%r11,8),%r14
0282      292:	49 83 c6 11          	add    $0x11,%r14
0286      296:	48 89 d1             	mov    %rdx,%rcx
0289      299:	48 c1 e9 03          	shr    $0x3,%rcx
028d      29d:	8a 04 31             	mov    (%rcx,%rsi,1),%al
0290      2a0:	84 c0                	test   %al,%al
0292      2a2:	0f 85 63 13 00 00    	jne    160b <leaf_cut_from_buffer+0x15fb>
0298      2a8:	4d 89 f5             	mov    %r14,%r13
029b      2ab:	49 c1 ed 03          	shr    $0x3,%r13
029f      2af:	41 8a 44 35 00       	mov    0x0(%r13,%rsi,1),%al
02a4      2b4:	84 c0                	test   %al,%al
02a6      2b6:	0f 85 9a 13 00 00    	jne    1656 <leaf_cut_from_buffer+0x1646>
02ac      2bc:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
02b1      2c1:	0f b7 2a             	movzwl (%rdx),%ebp
02b4      2c4:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
02b9      2c9:	42 8d 3c 20          	lea    (%rax,%r12,1),%edi
02bd      2cd:	39 ef                	cmp    %ebp,%edi
02bf      2cf:	0f 8f b9 1f 00 00    	jg     228e <leaf_cut_from_buffer+0x227e>
02c5      2d5:	85 c0                	test   %eax,%eax
02c7      2d7:	0f 84 29 06 00 00    	je     906 <leaf_cut_from_buffer+0x8f6>
02cd      2dd:	4c 89 ac 24 b0 00 00 00 	mov    %r13,0xb0(%rsp)
02d5      2e5:	4c 89 b4 24 d8 00 00 00 	mov    %r14,0xd8(%rsp)
02dd      2ed:	4f 8d 34 d9          	lea    (%r9,%r11,8),%r14
02e1      2f1:	49 83 c6 14          	add    $0x14,%r14
02e5      2f5:	4f 8d 2c d9          	lea    (%r9,%r11,8),%r13
02e9      2f9:	49 83 c5 15          	add    $0x15,%r13
02ed      2fd:	4c 89 f0             	mov    %r14,%rax
02f0      300:	48 c1 e8 03          	shr    $0x3,%rax
02f4      304:	8a 04 30             	mov    (%rax,%rsi,1),%al
02f7      307:	84 c0                	test   %al,%al
02f9      309:	0f 85 53 15 00 00    	jne    1862 <leaf_cut_from_buffer+0x1852>
02ff      30f:	4c 89 e8             	mov    %r13,%rax
0302      312:	48 c1 e8 03          	shr    $0x3,%rax
0306      316:	8a 04 30             	mov    (%rax,%rsi,1),%al
0309      319:	84 c0                	test   %al,%al
030b      31b:	0f 85 8c 15 00 00    	jne    18ad <leaf_cut_from_buffer+0x189d>
0311      321:	45 0f b7 16          	movzwl (%r14),%r10d
0315      325:	48 8b 84 24 90 00 00 00 	mov    0x90(%rsp),%rax
031d      32d:	4e 8d 04 10          	lea    (%rax,%r10,1),%r8
0321      331:	41 8d 44 24 ff       	lea    -0x1(%r12),%eax
0326      336:	48 98                	cltq
0328      338:	48 c1 e0 04          	shl    $0x4,%rax
032c      33c:	41 83 fc 01          	cmp    $0x1,%r12d
0330      340:	4e 8d 74 00 0c       	lea    0xc(%rax,%r8,1),%r14
0335      345:	4b 8d 44 d9 12       	lea    0x12(%r9,%r11,8),%rax
033a      34a:	48 89 84 24 80 00 00 00 	mov    %rax,0x80(%rsp)
0342      352:	4c 0f 42 f0          	cmovb  %rax,%r14
0346      356:	4d 8d 6e 01          	lea    0x1(%r14),%r13
034a      35a:	4c 89 f0             	mov    %r14,%rax
034d      35d:	48 c1 e8 03          	shr    $0x3,%rax
0351      361:	8a 04 30             	mov    (%rax,%rsi,1),%al
0354      364:	84 c0                	test   %al,%al
0356      366:	0f 85 8c 15 00 00    	jne    18f8 <leaf_cut_from_buffer+0x18e8>
035c      36c:	4c 89 e8             	mov    %r13,%rax
035f      36f:	48 c1 e8 03          	shr    $0x3,%rax
0363      373:	8a 04 30             	mov    (%rax,%rsi,1),%al
0366      376:	84 c0                	test   %al,%al
0368      378:	0f 85 d1 15 00 00    	jne    194f <leaf_cut_from_buffer+0x193f>
036e      37e:	45 0f b7 1e          	movzwl (%r14),%r11d
0372      382:	ff cf                	dec    %edi
0374      384:	48 63 c7             	movslq %edi,%rax
0377      387:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
037c      38c:	48 c1 e0 04          	shl    $0x4,%rax
0380      390:	4d 8d 34 00          	lea    (%r8,%rax,1),%r14
0384      394:	49 83 c6 0c          	add    $0xc,%r14
0388      398:	4d 8d 0c 00          	lea    (%r8,%rax,1),%r9
038c      39c:	49 83 c1 0d          	add    $0xd,%r9
0390      3a0:	4c 89 f0             	mov    %r14,%rax
0393      3a3:	48 c1 e8 03          	shr    $0x3,%rax
0397      3a7:	8a 04 30             	mov    (%rax,%rsi,1),%al
039a      3aa:	84 c0                	test   %al,%al
039c      3ac:	0f 85 ea 15 00 00    	jne    199c <leaf_cut_from_buffer+0x198c>
03a2      3b2:	4c 89 c8             	mov    %r9,%rax
03a5      3b5:	48 c1 e8 03          	shr    $0x3,%rax
03a9      3b9:	8a 04 30             	mov    (%rax,%rsi,1),%al
03ac      3bc:	84 c0                	test   %al,%al
03ae      3be:	0f 85 39 16 00 00    	jne    19fd <leaf_cut_from_buffer+0x19ed>
03b4      3c4:	41 0f b7 06          	movzwl (%r14),%eax
03b8      3c8:	4d 89 d9             	mov    %r11,%r9
03bb      3cb:	49 29 c1             	sub    %rax,%r9
03be      3ce:	8d 45 ff             	lea    -0x1(%rbp),%eax
03c1      3d1:	39 f8                	cmp    %edi,%eax
03c3      3d3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
03c8      3d8:	4c 89 4c 24 28       	mov    %r9,0x28(%rsp)
03cd      3dd:	0f 8e 6e 01 00 00    	jle    551 <leaf_cut_from_buffer+0x541>
03d3      3e3:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
03d8      3e8:	c1 e0 04             	shl    $0x4,%eax
03db      3eb:	89 44 24 48          	mov    %eax,0x48(%rsp)
03df      3ef:	41 89 ec             	mov    %ebp,%r12d
03e2      3f2:	49 ff cc             	dec    %r12
03e5      3f5:	89 e8                	mov    %ebp,%eax
03e7      3f7:	c1 e0 04             	shl    $0x4,%eax
03ea      3fa:	48 8b bc 24 90 00 00 00 	mov    0x90(%rsp),%rdi
03f2      402:	4c 8d 34 07          	lea    (%rdi,%rax,1),%r14
03f6      406:	49 83 c6 fc          	add    $0xfffffffffffffffc,%r14
03fa      40a:	40 c0 e5 04          	shl    $0x4,%bpl
03fe      40e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
0403      413:	8d 0c 2f             	lea    (%rdi,%rbp,1),%ecx
0406      416:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
040b      41b:	8d 51 fc             	lea    -0x4(%rcx),%edx
040e      41e:	0f b6 ea             	movzbl %dl,%ebp
0411      421:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
0416      426:	48 8d 1c 07          	lea    (%rdi,%rax,1),%rbx
041a      42a:	48 83 c3 fd          	add    $0xfffffffffffffffd,%rbx
041e      42e:	80 c1 fd             	add    $0xfd,%cl
0421      431:	44 0f b6 f9          	movzbl %cl,%r15d
0425      435:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
042a      43a:	4d 89 f5             	mov    %r14,%r13
042d      43d:	4b 8d 04 2a          	lea    (%r10,%r13,1),%rax
0431      441:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
0436      446:	4b 8d 04 32          	lea    (%r10,%r14,1),%rax
043a      44a:	48 c1 e8 03          	shr    $0x3,%rax
043e      44e:	8a 04 30             	mov    (%rax,%rsi,1),%al
0441      451:	84 c0                	test   %al,%al
0443      453:	75 45                	jne    49a <leaf_cut_from_buffer+0x48a>
0445      455:	49 8d 3c 1a          	lea    (%r10,%rbx,1),%rdi
0449      459:	48 89 f8             	mov    %rdi,%rax
044c      45c:	48 c1 e8 03          	shr    $0x3,%rax
0450      460:	8a 04 30             	mov    (%rax,%rsi,1),%al
0453      463:	84 c0                	test   %al,%al
0455      465:	0f 85 8b 00 00 00    	jne    4f6 <leaf_cut_from_buffer+0x4e6>
045b      46b:	8b 44 24 48          	mov    0x48(%rsp),%eax
045f      46f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
0464      474:	66 29 07             	sub    %ax,(%rdi)
0467      477:	49 ff cc             	dec    %r12
046a      47a:	49 83 c5 f0          	add    $0xfffffffffffffff0,%r13
046e      47e:	49 83 c6 f0          	add    $0xfffffffffffffff0,%r14
0472      482:	48 83 c5 f0          	add    $0xfffffffffffffff0,%rbp
0476      486:	48 83 c3 f0          	add    $0xfffffffffffffff0,%rbx
047a      48a:	49 83 c7 f0          	add    $0xfffffffffffffff0,%r15
047e      48e:	4c 3b 64 24 78       	cmp    0x78(%rsp),%r12
0483      493:	7f a8                	jg     43d <leaf_cut_from_buffer+0x42d>
0485      495:	e9 b7 00 00 00       	jmp    551 <leaf_cut_from_buffer+0x541>
048a      49a:	41 8d 0c 2a          	lea    (%r10,%rbp,1),%ecx
048e      49e:	80 e1 07             	and    $0x7,%cl
0491      4a1:	38 c1                	cmp    %al,%cl
0493      4a3:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
0498      4a8:	7c ab                	jl     455 <leaf_cut_from_buffer+0x445>
049a      4aa:	be 02 00 00 00       	mov    $0x2,%esi
049f      4af:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
04a4      4b4:	4c 89 94 24 a8 00 00 00 	mov    %r10,0xa8(%rsp)
04ac      4bc:	4c 89 5c 24 58       	mov    %r11,0x58(%rsp)
04b1      4c1:	e8 00 00 00 00       	call   4c6 <leaf_cut_from_buffer+0x4b6>	4c2: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
04b6      4c6:	4c 8b 5c 24 58       	mov    0x58(%rsp),%r11
04bb      4cb:	4c 8b 94 24 a8 00 00 00 	mov    0xa8(%rsp),%r10
04c3      4d3:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
04c8      4d8:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
04cd      4dd:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
04d2      4e2:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
04d7      4e7:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
04e1      4f1:	e9 5f ff ff ff       	jmp    455 <leaf_cut_from_buffer+0x445>
04e6      4f6:	43 8d 0c 3a          	lea    (%r10,%r15,1),%ecx
04ea      4fa:	80 e1 07             	and    $0x7,%cl
04ed      4fd:	38 c1                	cmp    %al,%cl
04ef      4ff:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
04f4      504:	0f 8c 61 ff ff ff    	jl     46b <leaf_cut_from_buffer+0x45b>
04fa      50a:	be 02 00 00 00       	mov    $0x2,%esi
04ff      50f:	4c 89 94 24 a8 00 00 00 	mov    %r10,0xa8(%rsp)
0507      517:	4c 89 5c 24 58       	mov    %r11,0x58(%rsp)
050c      51c:	e8 00 00 00 00       	call   521 <leaf_cut_from_buffer+0x511>	51d: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0511      521:	4c 8b 5c 24 58       	mov    0x58(%rsp),%r11
0516      526:	4c 8b 94 24 a8 00 00 00 	mov    0xa8(%rsp),%r10
051e      52e:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
0523      533:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
0528      538:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
052d      53d:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
0532      542:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
053c      54c:	e9 1a ff ff ff       	jmp    46b <leaf_cut_from_buffer+0x45b>
0541      551:	45 89 dd             	mov    %r11d,%r13d
0544      554:	83 bc 24 98 00 00 00 00 	cmpl   $0x0,0x98(%rsp)
054c      55c:	0f 8e 1b 01 00 00    	jle    67d <leaf_cut_from_buffer+0x66d>
0552      562:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
0557      567:	89 c3                	mov    %eax,%ebx
0559      569:	c1 e3 04             	shl    $0x4,%ebx
055c      56c:	44 01 cb             	add    %r9d,%ebx
055f      56f:	f7 db                	neg    %ebx
0561      571:	44 8b bc 24 98 00 00 00 	mov    0x98(%rsp),%r15d
0569      579:	49 c1 e7 04          	shl    $0x4,%r15
056d      57d:	48 8b 84 24 90 00 00 00 	mov    0x90(%rsp),%rax
0575      585:	4e 8d 24 10          	lea    (%rax,%r10,1),%r12
0579      589:	49 83 c4 0c          	add    $0xc,%r12
057d      58d:	44 01 d0             	add    %r10d,%eax
0580      590:	44 0f b6 d0          	movzbl %al,%r10d
0584      594:	31 ed                	xor    %ebp,%ebp
0586      596:	4d 8d 34 2c          	lea    (%r12,%rbp,1),%r14
058a      59a:	49 8d 04 28          	lea    (%r8,%rbp,1),%rax
058e      59e:	48 83 c0 0c          	add    $0xc,%rax
0592      5a2:	48 c1 e8 03          	shr    $0x3,%rax
0596      5a6:	8a 04 30             	mov    (%rax,%rsi,1),%al
0599      5a9:	84 c0                	test   %al,%al
059b      5ab:	75 28                	jne    5d5 <leaf_cut_from_buffer+0x5c5>
059d      5ad:	49 8d 3c 28          	lea    (%r8,%rbp,1),%rdi
05a1      5b1:	48 83 c7 0d          	add    $0xd,%rdi
05a5      5b5:	48 89 f8             	mov    %rdi,%rax
05a8      5b8:	48 c1 e8 03          	shr    $0x3,%rax
05ac      5bc:	8a 04 30             	mov    (%rax,%rsi,1),%al
05af      5bf:	84 c0                	test   %al,%al
05b1      5c1:	75 66                	jne    629 <leaf_cut_from_buffer+0x619>
05b3      5c3:	66 41 01 1e          	add    %bx,(%r14)
05b7      5c7:	48 83 c5 10          	add    $0x10,%rbp
05bb      5cb:	49 39 ef             	cmp    %rbp,%r15
05be      5ce:	75 c6                	jne    596 <leaf_cut_from_buffer+0x586>
05c0      5d0:	e9 a8 00 00 00       	jmp    67d <leaf_cut_from_buffer+0x66d>
05c5      5d5:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
05ca      5da:	41 8d 0c 2a          	lea    (%r10,%rbp,1),%ecx
05ce      5de:	80 c1 0c             	add    $0xc,%cl
05d1      5e1:	80 e1 07             	and    $0x7,%cl
05d4      5e4:	38 c1                	cmp    %al,%cl
05d6      5e6:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
05db      5eb:	7c c0                	jl     5ad <leaf_cut_from_buffer+0x59d>
05dd      5ed:	be 02 00 00 00       	mov    $0x2,%esi
05e2      5f2:	4c 89 f7             	mov    %r14,%rdi
05e5      5f5:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
05ea      5fa:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
05ef      5ff:	e8 00 00 00 00       	call   604 <leaf_cut_from_buffer+0x5f4>	600: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
05f4      604:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
05f9      609:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
05fe      60e:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
0603      613:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
0608      618:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
060d      61d:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0617      627:	eb 84                	jmp    5ad <leaf_cut_from_buffer+0x59d>
0619      629:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
061e      62e:	41 8d 0c 2a          	lea    (%r10,%rbp,1),%ecx
0622      632:	80 c1 0d             	add    $0xd,%cl
0625      635:	80 e1 07             	and    $0x7,%cl
0628      638:	38 c1                	cmp    %al,%cl
062a      63a:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
062f      63f:	7c 82                	jl     5c3 <leaf_cut_from_buffer+0x5b3>
0631      641:	be 02 00 00 00       	mov    $0x2,%esi
0636      646:	48 89 54 24 60       	mov    %rdx,0x60(%rsp)
063b      64b:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
0640      650:	e8 00 00 00 00       	call   655 <leaf_cut_from_buffer+0x645>	651: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0645      655:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
064a      65a:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
064f      65f:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
0654      664:	4c 8b 44 24 40       	mov    0x40(%rsp),%r8
0659      669:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
065e      66e:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0668      678:	e9 46 ff ff ff       	jmp    5c3 <leaf_cut_from_buffer+0x5b3>
066d      67d:	8a 04 31             	mov    (%rcx,%rsi,1),%al
0670      680:	84 c0                	test   %al,%al
0672      682:	0f 85 cc 13 00 00    	jne    1a54 <leaf_cut_from_buffer+0x1a44>
0678      688:	4d 01 c5             	add    %r8,%r13
067b      68b:	48 8b 84 24 b0 00 00 00 	mov    0xb0(%rsp),%rax
0683      693:	8a 04 30             	mov    (%rax,%rsi,1),%al
0686      696:	84 c0                	test   %al,%al
0688      698:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
068d      69d:	48 89 f3             	mov    %rsi,%rbx
0690      6a0:	4c 8b a4 24 98 00 00 00 	mov    0x98(%rsp),%r12
0698      6a8:	0f 85 e1 13 00 00    	jne    1a8f <leaf_cut_from_buffer+0x1a7f>
069e      6ae:	66 29 2a             	sub    %bp,(%rdx)
06a1      6b1:	4d 89 ef             	mov    %r13,%r15
06a4      6b4:	4d 29 cf             	sub    %r9,%r15
06a7      6b7:	48 63 ed             	movslq %ebp,%rbp
06aa      6ba:	49 63 fc             	movslq %r12d,%rdi
06ad      6bd:	48 c1 e7 04          	shl    $0x4,%rdi
06b1      6c1:	4c 01 c7             	add    %r8,%rdi
06b4      6c4:	48 c1 e5 04          	shl    $0x4,%rbp
06b8      6c8:	48 8d 34 2f          	lea    (%rdi,%rbp,1),%rsi
06bc      6cc:	4c 89 fa             	mov    %r15,%rdx
06bf      6cf:	48 29 f2             	sub    %rsi,%rdx
06c2      6d2:	e8 00 00 00 00       	call   6d7 <leaf_cut_from_buffer+0x6c7>	6d3: R_X86_64_PLT32	__asan_memmove-0x4
06c7      6d7:	48 8b bc 24 80 00 00 00 	mov    0x80(%rsp),%rdi
06cf      6df:	4c 8d 77 01          	lea    0x1(%rdi),%r14
06d3      6e3:	48 89 f8             	mov    %rdi,%rax
06d6      6e6:	48 c1 e8 03          	shr    $0x3,%rax
06da      6ea:	8a 04 18             	mov    (%rax,%rbx,1),%al
06dd      6ed:	84 c0                	test   %al,%al
06df      6ef:	0f 85 d5 13 00 00    	jne    1aca <leaf_cut_from_buffer+0x1aba>
06e5      6f5:	4c 89 f0             	mov    %r14,%rax
06e8      6f8:	48 c1 e8 03          	shr    $0x3,%rax
06ec      6fc:	8a 04 18             	mov    (%rax,%rbx,1),%al
06ef      6ff:	84 c0                	test   %al,%al
06f1      701:	0f 85 f1 13 00 00    	jne    1af8 <leaf_cut_from_buffer+0x1ae8>
06f7      707:	49 29 ef             	sub    %rbp,%r15
06fa      70a:	0f b7 07             	movzwl (%rdi),%eax
06fd      70d:	48 8b 54 24 40       	mov    0x40(%rsp),%rdx
0702      712:	48 01 c2             	add    %rax,%rdx
0705      715:	4c 29 ea             	sub    %r13,%rdx
0708      718:	4c 89 ff             	mov    %r15,%rdi
070b      71b:	4c 89 ee             	mov    %r13,%rsi
070e      71e:	e8 00 00 00 00       	call   723 <leaf_cut_from_buffer+0x713>	71f: R_X86_64_PLT32	__asan_memmove-0x4
0713      723:	03 6c 24 28          	add    0x28(%rsp),%ebp
0717      727:	4c 8b 14 24          	mov    (%rsp),%r10
071b      72b:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
0720      730:	e9 d3 01 00 00       	jmp    908 <leaf_cut_from_buffer+0x8f8>
0725      735:	4b 8d 1c d9          	lea    (%r9,%r11,8),%rbx
0729      739:	48 83 c3 12          	add    $0x12,%rbx
072d      73d:	4f 8d 34 d9          	lea    (%r9,%r11,8),%r14
0731      741:	49 83 c6 13          	add    $0x13,%r14
0735      745:	48 89 d8             	mov    %rbx,%rax
0738      748:	48 c1 e8 03          	shr    $0x3,%rax
073c      74c:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
0741      751:	8a 04 30             	mov    (%rax,%rsi,1),%al
0744      754:	84 c0                	test   %al,%al
0746      756:	0f 85 c4 13 00 00    	jne    1b20 <leaf_cut_from_buffer+0x1b10>
074c      75c:	4c 89 f0             	mov    %r14,%rax
074f      75f:	48 c1 e8 03          	shr    $0x3,%rax
0753      763:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
0758      768:	8a 04 30             	mov    (%rax,%rsi,1),%al
075b      76b:	84 c0                	test   %al,%al
075d      76d:	0f 85 e0 13 00 00    	jne    1b53 <leaf_cut_from_buffer+0x1b43>
0763      773:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
0768      778:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
076d      77d:	0f b7 1b             	movzwl (%rbx),%ebx
0770      780:	4f 8d 34 d9          	lea    (%r9,%r11,8),%r14
0774      784:	49 83 c6 14          	add    $0x14,%r14
0778      788:	4f 8d 24 d9          	lea    (%r9,%r11,8),%r12
077c      78c:	49 83 c4 15          	add    $0x15,%r12
0780      790:	4d 89 f7             	mov    %r14,%r15
0783      793:	49 c1 ef 03          	shr    $0x3,%r15
0787      797:	41 8a 04 37          	mov    (%r15,%rsi,1),%al
078b      79b:	84 c0                	test   %al,%al
078d      79d:	0f 85 e4 13 00 00    	jne    1b87 <leaf_cut_from_buffer+0x1b77>
0793      7a3:	4c 89 e0             	mov    %r12,%rax
0796      7a6:	4c 89 64 24 28       	mov    %r12,0x28(%rsp)
079b      7ab:	49 c1 ec 03          	shr    $0x3,%r12
079f      7af:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
07a3      7b3:	84 c0                	test   %al,%al
07a5      7b5:	0f 85 f6 13 00 00    	jne    1bb1 <leaf_cut_from_buffer+0x1ba1>
07ab      7bb:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
07b0      7c0:	48 8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%rax
07b8      7c8:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
07bc      7cc:	74 12                	je     7e0 <leaf_cut_from_buffer+0x7d0>
07be      7ce:	4c 89 ef             	mov    %r13,%rdi
07c1      7d1:	e8 00 00 00 00       	call   7d6 <leaf_cut_from_buffer+0x7c6>	7d2: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
07c6      7d6:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
07d0      7e0:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
07d5      7e5:	29 cb                	sub    %ecx,%ebx
07d7      7e7:	4d 8b 6d 00          	mov    0x0(%r13),%r13
07db      7eb:	41 8a 04 37          	mov    (%r15,%rsi,1),%al
07df      7ef:	84 c0                	test   %al,%al
07e1      7f1:	49 89 cf             	mov    %rcx,%r15
07e4      7f4:	0f 85 e5 13 00 00    	jne    1bdf <leaf_cut_from_buffer+0x1bcf>
07ea      7fa:	48 63 eb             	movslq %ebx,%rbp
07ed      7fd:	4d 63 ff             	movslq %r15d,%r15
07f0      800:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
07f4      804:	84 c0                	test   %al,%al
07f6      806:	48 89 f3             	mov    %rsi,%rbx
07f9      809:	0f 85 fa 13 00 00    	jne    1c09 <leaf_cut_from_buffer+0x1bf9>
07ff      80f:	41 0f b7 06          	movzwl (%r14),%eax
0803      813:	49 01 c5             	add    %rax,%r13
0806      816:	4b 8d 34 2f          	lea    (%r15,%r13,1),%rsi
080a      81a:	4c 89 ef             	mov    %r13,%rdi
080d      81d:	48 89 ea             	mov    %rbp,%rdx
0810      820:	e8 00 00 00 00       	call   825 <leaf_cut_from_buffer+0x815>	821: R_X86_64_PLT32	__asan_memmove-0x4
0815      825:	48 8b 84 24 c0 00 00 00 	mov    0xc0(%rsp),%rax
081d      82d:	8a 04 18             	mov    (%rax,%rbx,1),%al
0820      830:	84 c0                	test   %al,%al
0822      832:	48 89 de             	mov    %rbx,%rsi
0825      835:	0f 85 f2 13 00 00    	jne    1c2d <leaf_cut_from_buffer+0x1c1d>
082b      83b:	48 8b 84 24 b8 00 00 00 	mov    0xb8(%rsp),%rax
0833      843:	8a 04 30             	mov    (%rax,%rsi,1),%al
0836      846:	84 c0                	test   %al,%al
0838      848:	4c 8b 14 24          	mov    (%rsp),%r10
083c      84c:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
0841      851:	0f 85 04 14 00 00    	jne    1c5b <leaf_cut_from_buffer+0x1c4b>
0847      857:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
084c      85c:	44 0f b7 18          	movzwl (%rax),%r11d
0850      860:	66 45 85 db          	test   %r11w,%r11w
0854      864:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
0859      869:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
085e      86e:	0f 84 78 02 00 00    	je     aec <leaf_cut_from_buffer+0xadc>
0864      874:	48 89 d7             	mov    %rdx,%rdi
0867      877:	4c 89 ca             	mov    %r9,%rdx
086a      87a:	4d 8d 4a 08          	lea    0x8(%r10),%r9
086e      87e:	49 8d 4a 0f          	lea    0xf(%r10),%rcx
0872      882:	4d 89 cc             	mov    %r9,%r12
0875      885:	49 c1 ec 03          	shr    $0x3,%r12
0879      889:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
087d      88d:	84 c0                	test   %al,%al
087f      88f:	0f 85 8b 15 00 00    	jne    1e20 <leaf_cut_from_buffer+0x1e10>
0885      895:	48 89 cb             	mov    %rcx,%rbx
0888      898:	48 c1 eb 03          	shr    $0x3,%rbx
088c      89c:	8a 04 33             	mov    (%rbx,%rsi,1),%al
088f      89f:	84 c0                	test   %al,%al
0891      8a1:	0f 85 cb 15 00 00    	jne    1e72 <leaf_cut_from_buffer+0x1e62>
0897      8a7:	49 bd 00 00 00 00 00 00 00 20 	movabs $0x2000000000000000,%r13
08a1      8b1:	49 8b 29             	mov    (%r9),%rbp
08a4      8b4:	49 89 ee             	mov    %rbp,%r14
08a7      8b7:	48 b8 00 00 00 00 00 00 00 f0 	movabs $0xf000000000000000,%rax
08b1      8c1:	49 21 c6             	and    %rax,%r14
08b4      8c4:	4d 39 ee             	cmp    %r13,%r14
08b7      8c7:	0f 85 08 08 00 00    	jne    10d5 <leaf_cut_from_buffer+0x10c5>
08bd      8cd:	4c 01 fd             	add    %r15,%rbp
08c0      8d0:	48 b8 ff ff ff ff ff ff ff 0f 	movabs $0xfffffffffffffff,%rax
08ca      8da:	48 21 c5             	and    %rax,%rbp
08cd      8dd:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
08d1      8e1:	84 c0                	test   %al,%al
08d3      8e3:	0f 85 9b 17 00 00    	jne    2084 <leaf_cut_from_buffer+0x2074>
08d9      8e9:	4c 09 ed             	or     %r13,%rbp
08dc      8ec:	8a 04 33             	mov    (%rbx,%rsi,1),%al
08df      8ef:	84 c0                	test   %al,%al
08e1      8f1:	0f 85 cf 17 00 00    	jne    20c6 <leaf_cut_from_buffer+0x20b6>
08e7      8f7:	49 89 29             	mov    %rbp,(%r9)
08ea      8fa:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
08ef      8ff:	4c 8b 64 24 70       	mov    0x70(%rsp),%r12
08f4      904:	eb 22                	jmp    928 <leaf_cut_from_buffer+0x918>
08f6      906:	31 ed                	xor    %ebp,%ebp
08f8      908:	45 85 e4             	test   %r12d,%r12d
08fb      90b:	4c 8b 64 24 70       	mov    0x70(%rsp),%r12
0900      910:	48 8b 9c 24 c8 00 00 00 	mov    0xc8(%rsp),%rbx
0908      918:	0f 84 94 00 00 00    	je     9b2 <leaf_cut_from_buffer+0x9a2>
090e      91e:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0918      928:	44 89 e0             	mov    %r12d,%eax
091b      92b:	f7 d0                	not    %eax
091d      92d:	44 01 c0             	add    %r8d,%eax
0920      930:	48 98                	cltq
0922      932:	48 8d 04 40          	lea    (%rax,%rax,2),%rax
0926      936:	4d 8d 34 c2          	lea    (%r10,%rax,8),%r14
092a      93a:	49 83 c6 14          	add    $0x14,%r14
092e      93e:	4d 8d 3c c2          	lea    (%r10,%rax,8),%r15
0932      942:	49 83 c7 15          	add    $0x15,%r15
0936      946:	4c 89 f0             	mov    %r14,%rax
0939      949:	48 c1 e8 03          	shr    $0x3,%rax
093d      94d:	8a 04 30             	mov    (%rax,%rsi,1),%al
0940      950:	84 c0                	test   %al,%al
0942      952:	0f 85 99 0a 00 00    	jne    13f1 <leaf_cut_from_buffer+0x13e1>
0948      958:	49 89 ed             	mov    %rbp,%r13
094b      95b:	4c 89 f8             	mov    %r15,%rax
094e      95e:	48 c1 e8 03          	shr    $0x3,%rax
0952      962:	8a 04 30             	mov    (%rax,%rsi,1),%al
0955      965:	84 c0                	test   %al,%al
0957      967:	0f 85 b2 0a 00 00    	jne    141f <leaf_cut_from_buffer+0x140f>
095d      96d:	41 0f b7 1e          	movzwl (%r14),%ebx
0961      971:	0f b7 eb             	movzwl %bx,%ebp
0964      974:	45 85 e4             	test   %r12d,%r12d
0967      977:	0f 84 30 03 00 00    	je     cad <leaf_cut_from_buffer+0xc9d>
096d      97d:	4d 8d 72 fc          	lea    -0x4(%r10),%r14
0971      981:	4d 8d 7a fd          	lea    -0x3(%r10),%r15
0975      985:	4c 89 f0             	mov    %r14,%rax
0978      988:	48 c1 e8 03          	shr    $0x3,%rax
097c      98c:	8a 04 30             	mov    (%rax,%rsi,1),%al
097f      98f:	84 c0                	test   %al,%al
0981      991:	0f 85 20 0c 00 00    	jne    15b7 <leaf_cut_from_buffer+0x15a7>
0987      997:	4c 89 f8             	mov    %r15,%rax
098a      99a:	48 c1 e8 03          	shr    $0x3,%rax
098e      99e:	8a 04 30             	mov    (%rax,%rsi,1),%al
0991      9a1:	84 c0                	test   %al,%al
0993      9a3:	0f 85 38 0c 00 00    	jne    15e1 <leaf_cut_from_buffer+0x15d1>
0999      9a9:	45 0f b7 36          	movzwl (%r14),%r14d
099d      9ad:	e9 29 03 00 00       	jmp    cdb <leaf_cut_from_buffer+0xccb>
09a2      9b2:	45 85 e4             	test   %r12d,%r12d
09a5      9b5:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
09af      9bf:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
09b4      9c4:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
09b9      9c9:	0f 85 45 1a 00 00    	jne    2414 <leaf_cut_from_buffer+0x2404>
09bf      9cf:	48 8b 94 24 a0 00 00 00 	mov    0xa0(%rsp),%rdx
09c7      9d7:	80 3c 32 00          	cmpb   $0x0,(%rdx,%rsi,1)
09cb      9db:	74 25                	je     a02 <leaf_cut_from_buffer+0x9f2>
09cd      9dd:	48 89 df             	mov    %rbx,%rdi
09d0      9e0:	e8 00 00 00 00       	call   9e5 <leaf_cut_from_buffer+0x9d5>	9e1: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
09d5      9e5:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
09da      9ea:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
09df      9ef:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
09e4      9f4:	4c 8b 14 24          	mov    (%rsp),%r10
09e8      9f8:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
09f2      a02:	48 8b 1b             	mov    (%rbx),%rbx
09f5      a05:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
09f9      a09:	49 83 c6 14          	add    $0x14,%r14
09fd      a0d:	4c 8d 3c c1          	lea    (%rcx,%rax,8),%r15
0a01      a11:	49 83 c7 15          	add    $0x15,%r15
0a05      a15:	4c 89 f0             	mov    %r14,%rax
0a08      a18:	48 c1 e8 03          	shr    $0x3,%rax
0a0c      a1c:	8a 04 30             	mov    (%rax,%rsi,1),%al
0a0f      a1f:	84 c0                	test   %al,%al
0a11      a21:	0f 85 6b 12 00 00    	jne    1c92 <leaf_cut_from_buffer+0x1c82>
0a17      a27:	4c 89 f8             	mov    %r15,%rax
0a1a      a2a:	48 c1 e8 03          	shr    $0x3,%rax
0a1e      a2e:	8a 04 30             	mov    (%rax,%rsi,1),%al
0a21      a31:	84 c0                	test   %al,%al
0a23      a33:	0f 85 8c 12 00 00    	jne    1cc5 <leaf_cut_from_buffer+0x1cb5>
0a29      a39:	41 0f b7 06          	movzwl (%r14),%eax
0a2d      a3d:	4c 8d 34 03          	lea    (%rbx,%rax,1),%r14
0a31      a41:	4c 8d 3c 03          	lea    (%rbx,%rax,1),%r15
0a35      a45:	49 83 c7 03          	add    $0x3,%r15
0a39      a49:	4c 89 f0             	mov    %r14,%rax
0a3c      a4c:	48 c1 e8 03          	shr    $0x3,%rax
0a40      a50:	8a 04 30             	mov    (%rax,%rsi,1),%al
0a43      a53:	84 c0                	test   %al,%al
0a45      a55:	0f 85 9d 12 00 00    	jne    1cf8 <leaf_cut_from_buffer+0x1ce8>
0a4b      a5b:	4c 89 f8             	mov    %r15,%rax
0a4e      a5e:	48 c1 e8 03          	shr    $0x3,%rax
0a52      a62:	8a 04 30             	mov    (%rax,%rsi,1),%al
0a55      a65:	84 c0                	test   %al,%al
0a57      a67:	0f 85 be 12 00 00    	jne    1d2b <leaf_cut_from_buffer+0x1d1b>
0a5d      a6d:	45 8b 2e             	mov    (%r14),%r13d
0a60      a70:	48 8b 84 24 c0 00 00 00 	mov    0xc0(%rsp),%rax
0a68      a78:	8a 04 30             	mov    (%rax,%rsi,1),%al
0a6b      a7b:	84 c0                	test   %al,%al
0a6d      a7d:	0f 85 db 12 00 00    	jne    1d5e <leaf_cut_from_buffer+0x1d4e>
0a73      a83:	48 8b 84 24 b8 00 00 00 	mov    0xb8(%rsp),%rax
0a7b      a8b:	8a 04 30             	mov    (%rax,%rsi,1),%al
0a7e      a8e:	84 c0                	test   %al,%al
0a80      a90:	48 8b 5c 24 50       	mov    0x50(%rsp),%rbx
0a85      a95:	0f 85 fa 12 00 00    	jne    1d95 <leaf_cut_from_buffer+0x1d85>
0a8b      a9b:	66 83 3b 00          	cmpw   $0x0,(%rbx)
0a8f      a9f:	0f 84 92 01 00 00    	je     c37 <leaf_cut_from_buffer+0xc27>
0a95      aa5:	4d 8d 72 08          	lea    0x8(%r10),%r14
0a99      aa9:	4d 8d 7a 0f          	lea    0xf(%r10),%r15
0a9d      aad:	4c 89 f0             	mov    %r14,%rax
0aa0      ab0:	48 c1 e8 03          	shr    $0x3,%rax
0aa4      ab4:	8a 04 30             	mov    (%rax,%rsi,1),%al
0aa7      ab7:	84 c0                	test   %al,%al
0aa9      ab9:	0f 85 02 14 00 00    	jne    1ec1 <leaf_cut_from_buffer+0x1eb1>
0aaf      abf:	4c 89 f8             	mov    %r15,%rax
0ab2      ac2:	48 c1 e8 03          	shr    $0x3,%rax
0ab6      ac6:	8a 04 30             	mov    (%rax,%rsi,1),%al
0ab9      ac9:	84 c0                	test   %al,%al
0abb      acb:	0f 85 23 14 00 00    	jne    1ef4 <leaf_cut_from_buffer+0x1ee4>
0ac1      ad1:	49 8b 06             	mov    (%r14),%rax
0ac4      ad4:	48 b9 00 00 00 00 00 00 00 f0 	movabs $0xf000000000000000,%rcx
0ace      ade:	48 21 c8             	and    %rcx,%rax
0ad1      ae1:	4c 09 e8             	or     %r13,%rax
0ad4      ae4:	49 89 06             	mov    %rax,(%r14)
0ad7      ae7:	e9 7a 01 00 00       	jmp    c66 <leaf_cut_from_buffer+0xc56>
0adc      aec:	49 8d 7a 0c          	lea    0xc(%r10),%rdi
0ae0      af0:	4d 8d 72 0f          	lea    0xf(%r10),%r14
0ae4      af4:	48 89 f8             	mov    %rdi,%rax
0ae7      af7:	48 c1 e8 03          	shr    $0x3,%rax
0aeb      afb:	8a 04 30             	mov    (%rax,%rsi,1),%al
0aee      afe:	84 c0                	test   %al,%al
0af0      b00:	0f 85 21 14 00 00    	jne    1f27 <leaf_cut_from_buffer+0x1f17>
0af6      b06:	4c 89 f0             	mov    %r14,%rax
0af9      b09:	48 c1 e8 03          	shr    $0x3,%rax
0afd      b0d:	8a 04 30             	mov    (%rax,%rsi,1),%al
0b00      b10:	84 c0                	test   %al,%al
0b02      b12:	0f 85 48 14 00 00    	jne    1f60 <leaf_cut_from_buffer+0x1f50>
0b08      b18:	45 8b 6a 0c          	mov    0xc(%r10),%r13d
0b0c      b1c:	49 8d 6a 08          	lea    0x8(%r10),%rbp
0b10      b20:	49 8d 7a 0b          	lea    0xb(%r10),%rdi
0b14      b24:	49 89 ee             	mov    %rbp,%r14
0b17      b27:	49 c1 ee 03          	shr    $0x3,%r14
0b1b      b2b:	41 8a 04 36          	mov    (%r14,%rsi,1),%al
0b1f      b2f:	84 c0                	test   %al,%al
0b21      b31:	0f 85 66 14 00 00    	jne    1f9d <leaf_cut_from_buffer+0x1f8d>
0b27      b37:	49 89 fc             	mov    %rdi,%r12
0b2a      b3a:	49 c1 ec 03          	shr    $0x3,%r12
0b2e      b3e:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
0b32      b42:	84 c0                	test   %al,%al
0b34      b44:	0f 85 95 14 00 00    	jne    1fdf <leaf_cut_from_buffer+0x1fcf>
0b3a      b4a:	8b 5d 00             	mov    0x0(%rbp),%ebx
0b3d      b4d:	41 83 fd ff          	cmp    $0xffffffff,%r13d
0b41      b51:	0f 84 d1 06 00 00    	je     1228 <leaf_cut_from_buffer+0x1218>
0b47      b57:	49 c1 ef 02          	shr    $0x2,%r15
0b4b      b5b:	48 8b 84 24 88 00 00 00 	mov    0x88(%rsp),%rax
0b53      b63:	4c 8d 68 20          	lea    0x20(%rax),%r13
0b57      b67:	4c 89 e8             	mov    %r13,%rax
0b5a      b6a:	48 c1 e8 03          	shr    $0x3,%rax
0b5e      b6e:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
0b62      b72:	74 35                	je     ba9 <leaf_cut_from_buffer+0xb99>
0b64      b74:	48 89 6c 24 28       	mov    %rbp,0x28(%rsp)
0b69      b79:	48 89 fd             	mov    %rdi,%rbp
0b6c      b7c:	4c 89 ef             	mov    %r13,%rdi
0b6f      b7f:	e8 00 00 00 00       	call   b84 <leaf_cut_from_buffer+0xb74>	b80: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0b74      b84:	48 89 ef             	mov    %rbp,%rdi
0b77      b87:	48 8b 6c 24 28       	mov    0x28(%rsp),%rbp
0b7c      b8c:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
0b81      b91:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
0b86      b96:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
0b8b      b9b:	4c 8b 14 24          	mov    (%rsp),%r10
0b8f      b9f:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0b99      ba9:	45 0f af 7d 00       	imul   0x0(%r13),%r15d
0b9e      bae:	41 8a 04 36          	mov    (%r14,%rsi,1),%al
0ba2      bb2:	84 c0                	test   %al,%al
0ba4      bb4:	0f 85 01 17 00 00    	jne    22bb <leaf_cut_from_buffer+0x22ab>
0baa      bba:	44 01 fb             	add    %r15d,%ebx
0bad      bbd:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
0bb1      bc1:	84 c0                	test   %al,%al
0bb3      bc3:	4c 8b 64 24 70       	mov    0x70(%rsp),%r12
0bb8      bc8:	0f 85 2f 17 00 00    	jne    22fd <leaf_cut_from_buffer+0x22ed>
0bbe      bce:	89 5d 00             	mov    %ebx,0x0(%rbp)
0bc1      bd1:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
0bc6      bd6:	8a 04 30             	mov    (%rax,%rsi,1),%al
0bc9      bd9:	84 c0                	test   %al,%al
0bcb      bdb:	0f 85 55 17 00 00    	jne    2336 <leaf_cut_from_buffer+0x2326>
0bd1      be1:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
0bd6      be6:	8a 04 30             	mov    (%rax,%rsi,1),%al
0bd9      be9:	84 c0                	test   %al,%al
0bdb      beb:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
0be0      bf0:	0f 84 ba 05 00 00    	je     11b0 <leaf_cut_from_buffer+0x11a0>
0be6      bf6:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
0beb      bfb:	80 e1 07             	and    $0x7,%cl
0bee      bfe:	38 c1                	cmp    %al,%cl
0bf0      c00:	0f 8c aa 05 00 00    	jl     11b0 <leaf_cut_from_buffer+0x11a0>
0bf6      c06:	be 02 00 00 00       	mov    $0x2,%esi
0bfb      c0b:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
0c00      c10:	e8 00 00 00 00       	call   c15 <leaf_cut_from_buffer+0xc05>	c11: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0c05      c15:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
0c0a      c1a:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
0c0f      c1f:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
0c14      c24:	4c 8b 14 24          	mov    (%rsp),%r10
0c18      c28:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0c22      c32:	e9 79 05 00 00       	jmp    11b0 <leaf_cut_from_buffer+0x11a0>
0c27      c37:	4d 8d 72 08          	lea    0x8(%r10),%r14
0c2b      c3b:	4d 8d 7a 0b          	lea    0xb(%r10),%r15
0c2f      c3f:	4c 89 f0             	mov    %r14,%rax
0c32      c42:	48 c1 e8 03          	shr    $0x3,%rax
0c36      c46:	8a 04 30             	mov    (%rax,%rsi,1),%al
0c39      c49:	84 c0                	test   %al,%al
0c3b      c4b:	0f 85 cd 13 00 00    	jne    201e <leaf_cut_from_buffer+0x200e>
0c41      c51:	4c 89 f8             	mov    %r15,%rax
0c44      c54:	48 c1 e8 03          	shr    $0x3,%rax
0c48      c58:	8a 04 30             	mov    (%rax,%rsi,1),%al
0c4b      c5b:	84 c0                	test   %al,%al
0c4d      c5d:	0f 85 ee 13 00 00    	jne    2051 <leaf_cut_from_buffer+0x2041>
0c53      c63:	45 89 2e             	mov    %r13d,(%r14)
0c56      c66:	4b 8d 04 40          	lea    (%r8,%r8,2),%rax
0c5a      c6a:	4d 8d 34 c2          	lea    (%r10,%rax,8),%r14
0c5e      c6e:	49 83 c6 fc          	add    $0xfffffffffffffffc,%r14
0c62      c72:	4d 8d 3c c2          	lea    (%r10,%rax,8),%r15
0c66      c76:	49 83 c7 fd          	add    $0xfffffffffffffffd,%r15
0c6a      c7a:	4c 89 f0             	mov    %r14,%rax
0c6d      c7d:	48 c1 e8 03          	shr    $0x3,%rax
0c71      c81:	8a 04 30             	mov    (%rax,%rsi,1),%al
0c74      c84:	84 c0                	test   %al,%al
0c76      c86:	4c 8b 64 24 70       	mov    0x70(%rsp),%r12
0c7b      c8b:	0f 85 3b 11 00 00    	jne    1dcc <leaf_cut_from_buffer+0x1dbc>
0c81      c91:	49 89 ed             	mov    %rbp,%r13
0c84      c94:	4c 89 f8             	mov    %r15,%rax
0c87      c97:	48 c1 e8 03          	shr    $0x3,%rax
0c8b      c9b:	8a 04 30             	mov    (%rax,%rsi,1),%al
0c8e      c9e:	84 c0                	test   %al,%al
0c90      ca0:	0f 85 50 11 00 00    	jne    1df6 <leaf_cut_from_buffer+0x1de6>
0c96      ca6:	41 0f b7 1e          	movzwl (%r14),%ebx
0c9a      caa:	0f b7 eb             	movzwl %bx,%ebp
0c9d      cad:	48 8b 84 24 88 00 00 00 	mov    0x88(%rsp),%rax
0ca5      cb5:	4c 8d 70 20          	lea    0x20(%rax),%r14
0ca9      cb9:	4c 89 f0             	mov    %r14,%rax
0cac      cbc:	48 c1 e8 03          	shr    $0x3,%rax
0cb0      cc0:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
0cb4      cc4:	74 12                	je     cd8 <leaf_cut_from_buffer+0xcc8>
0cb6      cc6:	4c 89 f7             	mov    %r14,%rdi
0cb9      cc9:	e8 00 00 00 00       	call   cce <leaf_cut_from_buffer+0xcbe>	cca: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0cbe      cce:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0cc8      cd8:	4d 8b 36             	mov    (%r14),%r14
0ccb      cdb:	44 01 ed             	add    %r13d,%ebp
0cce      cde:	41 29 ee             	sub    %ebp,%r14d
0cd1      ce1:	48 8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%rax
0cd9      ce9:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
0cdd      ced:	74 17                	je     d06 <leaf_cut_from_buffer+0xcf6>
0cdf      cef:	48 8b bc 24 c8 00 00 00 	mov    0xc8(%rsp),%rdi
0ce7      cf7:	e8 00 00 00 00       	call   cfc <leaf_cut_from_buffer+0xcec>	cf8: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0cec      cfc:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
0cf6      d06:	4d 63 f6             	movslq %r14d,%r14
0cf9      d09:	44 0f b7 fb          	movzwl %bx,%r15d
0cfd      d0d:	4c 89 ed             	mov    %r13,%rbp
0d00      d10:	4c 63 ed             	movslq %ebp,%r13
0d03      d13:	48 8b 84 24 a0 00 00 00 	mov    0xa0(%rsp),%rax
0d0b      d1b:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
0d0f      d1f:	48 8b 9c 24 c8 00 00 00 	mov    0xc8(%rsp),%rbx
0d17      d27:	74 08                	je     d31 <leaf_cut_from_buffer+0xd21>
0d19      d29:	48 89 df             	mov    %rbx,%rdi
0d1c      d2c:	e8 00 00 00 00       	call   d31 <leaf_cut_from_buffer+0xd21>	d2d: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0d21      d31:	4c 03 3b             	add    (%rbx),%r15
0d24      d34:	4d 01 fd             	add    %r15,%r13
0d27      d37:	4c 89 ef             	mov    %r13,%rdi
0d2a      d3a:	4c 89 fe             	mov    %r15,%rsi
0d2d      d3d:	4c 89 f2             	mov    %r14,%rdx
0d30      d40:	e8 00 00 00 00       	call   d45 <leaf_cut_from_buffer+0xd35>	d41: R_X86_64_PLT32	__asan_memmove-0x4
0d35      d45:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
0d3a      d4a:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
0d3f      d4f:	4f 8d 34 c1          	lea    (%r9,%r8,8),%r14
0d43      d53:	49 83 c6 12          	add    $0x12,%r14
0d47      d57:	4f 8d 3c c1          	lea    (%r9,%r8,8),%r15
0d4b      d5b:	49 83 c7 13          	add    $0x13,%r15
0d4f      d5f:	4c 89 f0             	mov    %r14,%rax
0d52      d62:	48 c1 e8 03          	shr    $0x3,%rax
0d56      d66:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0d60      d70:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d63      d73:	84 c0                	test   %al,%al
0d65      d75:	0f 85 62 05 00 00    	jne    12dd <leaf_cut_from_buffer+0x12cd>
0d6b      d7b:	4c 89 f8             	mov    %r15,%rax
0d6e      d7e:	48 c1 e8 03          	shr    $0x3,%rax
0d72      d82:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d75      d85:	84 c0                	test   %al,%al
0d77      d87:	4c 89 e3             	mov    %r12,%rbx
0d7a      d8a:	48 8b 34 24          	mov    (%rsp),%rsi
0d7e      d8e:	0f 85 7d 05 00 00    	jne    1311 <leaf_cut_from_buffer+0x1301>
0d84      d94:	66 41 29 2e          	sub    %bp,(%r14)
0d88      d98:	48 8b 84 24 c0 00 00 00 	mov    0xc0(%rsp),%rax
0d90      da0:	8a 04 10             	mov    (%rax,%rdx,1),%al
0d93      da3:	84 c0                	test   %al,%al
0d95      da5:	4c 8b a4 24 98 00 00 00 	mov    0x98(%rsp),%r12
0d9d      dad:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
0da2      db2:	0f 85 91 05 00 00    	jne    1349 <leaf_cut_from_buffer+0x1339>
0da8      db8:	48 8b 84 24 b8 00 00 00 	mov    0xb8(%rsp),%rax
0db0      dc0:	8a 04 10             	mov    (%rax,%rdx,1),%al
0db3      dc3:	84 c0                	test   %al,%al
0db5      dc5:	4c 8b 74 24 50       	mov    0x50(%rsp),%r14
0dba      dca:	0f 85 ba 05 00 00    	jne    138a <leaf_cut_from_buffer+0x137a>
0dc0      dd0:	66 41 83 3e 00       	cmpw   $0x0,(%r14)
0dc5      dd5:	74 4b                	je     e22 <leaf_cut_from_buffer+0xe12>
0dc7      dd7:	4c 8d 76 08          	lea    0x8(%rsi),%r14
0dcb      ddb:	4c 8d 7e 0f          	lea    0xf(%rsi),%r15
0dcf      ddf:	4c 89 f0             	mov    %r14,%rax
0dd2      de2:	48 c1 e8 03          	shr    $0x3,%rax
0dd6      de6:	8a 04 10             	mov    (%rax,%rdx,1),%al
0dd9      de9:	84 c0                	test   %al,%al
0ddb      deb:	0f 85 d6 06 00 00    	jne    14c7 <leaf_cut_from_buffer+0x14b7>
0de1      df1:	4c 89 f8             	mov    %r15,%rax
0de4      df4:	48 c1 e8 03          	shr    $0x3,%rax
0de8      df8:	8a 04 10             	mov    (%rax,%rdx,1),%al
0deb      dfb:	84 c0                	test   %al,%al
0ded      dfd:	0f 85 01 07 00 00    	jne    1504 <leaf_cut_from_buffer+0x14f4>
0df3      e03:	48 b8 00 00 00 00 00 00 00 f0 	movabs $0xf000000000000000,%rax
0dfd      e0d:	49 23 06             	and    (%r14),%rax
0e00      e10:	48 b9 ff ff ff ff ff ff ff 0f 	movabs $0xfffffffffffffff,%rcx
0e0a      e1a:	48 ff c1             	inc    %rcx
0e0d      e1d:	48 39 c8             	cmp    %rcx,%rax
0e10      e20:	eb 30                	jmp    e52 <leaf_cut_from_buffer+0xe42>
0e12      e22:	4c 8d 76 0c          	lea    0xc(%rsi),%r14
0e16      e26:	4c 8d 7e 0f          	lea    0xf(%rsi),%r15
0e1a      e2a:	4c 89 f0             	mov    %r14,%rax
0e1d      e2d:	48 c1 e8 03          	shr    $0x3,%rax
0e21      e31:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e24      e34:	84 c0                	test   %al,%al
0e26      e36:	0f 85 46 09 00 00    	jne    1782 <leaf_cut_from_buffer+0x1772>
0e2c      e3c:	4c 89 f8             	mov    %r15,%rax
0e2f      e3f:	48 c1 e8 03          	shr    $0x3,%rax
0e33      e43:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e36      e46:	84 c0                	test   %al,%al
0e38      e48:	0f 85 71 09 00 00    	jne    17bf <leaf_cut_from_buffer+0x17af>
0e3e      e4e:	41 83 3e fe          	cmpl   $0xfffffffe,(%r14)
0e42      e52:	0f 94 c0             	sete   %al
0e45      e55:	45 85 e4             	test   %r12d,%r12d
0e48      e58:	74 3e                	je     e98 <leaf_cut_from_buffer+0xe88>
0e4a      e5a:	84 c0                	test   %al,%al
0e4c      e5c:	74 3a                	je     e98 <leaf_cut_from_buffer+0xe88>
0e4e      e5e:	4f 8d 34 c1          	lea    (%r9,%r8,8),%r14
0e52      e62:	49 83 c6 10          	add    $0x10,%r14
0e56      e66:	4f 8d 3c c1          	lea    (%r9,%r8,8),%r15
0e5a      e6a:	49 83 c7 11          	add    $0x11,%r15
0e5e      e6e:	4c 89 f0             	mov    %r14,%rax
0e61      e71:	48 c1 e8 03          	shr    $0x3,%rax
0e65      e75:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e68      e78:	84 c0                	test   %al,%al
0e6a      e7a:	0f 85 22 08 00 00    	jne    16a2 <leaf_cut_from_buffer+0x1692>
0e70      e80:	4c 89 f8             	mov    %r15,%rax
0e73      e83:	48 c1 e8 03          	shr    $0x3,%rax
0e77      e87:	8a 04 10             	mov    (%rax,%rdx,1),%al
0e7a      e8a:	84 c0                	test   %al,%al
0e7c      e8c:	0f 85 43 08 00 00    	jne    16d5 <leaf_cut_from_buffer+0x16c5>
0e82      e92:	66 41 c7 06 00 00    	movw   $0x0,(%r14)
0e88      e98:	39 df                	cmp    %ebx,%edi
0e8a      e9a:	0f 8e 98 00 00 00    	jle    f38 <leaf_cut_from_buffer+0xf28>
0e90      ea0:	89 fb                	mov    %edi,%ebx
0e92      ea2:	48 2b 9c 24 e0 00 00 00 	sub    0xe0(%rsp),%rbx
0e9a      eaa:	45 31 ff             	xor    %r15d,%r15d
0e9d      ead:	49 63 c7             	movslq %r15d,%rax
0ea0      eb0:	4c 8d 24 40          	lea    (%rax,%rax,2),%r12
0ea4      eb4:	4e 8d 34 e6          	lea    (%rsi,%r12,8),%r14
0ea8      eb8:	49 83 c6 14          	add    $0x14,%r14
0eac      ebc:	4c 89 f0             	mov    %r14,%rax
0eaf      ebf:	48 c1 e8 03          	shr    $0x3,%rax
0eb3      ec3:	8a 04 10             	mov    (%rax,%rdx,1),%al
0eb6      ec6:	84 c0                	test   %al,%al
0eb8      ec8:	75 24                	jne    eee <leaf_cut_from_buffer+0xede>
0eba      eca:	4a 8d 3c e6          	lea    (%rsi,%r12,8),%rdi
0ebe      ece:	48 83 c7 15          	add    $0x15,%rdi
0ec2      ed2:	48 89 f8             	mov    %rdi,%rax
0ec5      ed5:	48 c1 e8 03          	shr    $0x3,%rax
0ec9      ed9:	8a 04 10             	mov    (%rax,%rdx,1),%al
0ecc      edc:	84 c0                	test   %al,%al
0ece      ede:	75 35                	jne    f15 <leaf_cut_from_buffer+0xf05>
0ed0      ee0:	66 41 01 2e          	add    %bp,(%r14)
0ed4      ee4:	49 ff c7             	inc    %r15
0ed7      ee7:	4c 39 fb             	cmp    %r15,%rbx
0eda      eea:	75 c1                	jne    ead <leaf_cut_from_buffer+0xe9d>
0edc      eec:	eb 4a                	jmp    f38 <leaf_cut_from_buffer+0xf28>
0ede      eee:	44 89 f1             	mov    %r14d,%ecx
0ee1      ef1:	80 e1 07             	and    $0x7,%cl
0ee4      ef4:	38 c1                	cmp    %al,%cl
0ee6      ef6:	7c d2                	jl     eca <leaf_cut_from_buffer+0xeba>
0ee8      ef8:	be 02 00 00 00       	mov    $0x2,%esi
0eed      efd:	4c 89 f7             	mov    %r14,%rdi
0ef0      f00:	e8 00 00 00 00       	call   f05 <leaf_cut_from_buffer+0xef5>	f01: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0ef5      f05:	48 8b 34 24          	mov    (%rsp),%rsi
0ef9      f09:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0f03      f13:	eb b5                	jmp    eca <leaf_cut_from_buffer+0xeba>
0f05      f15:	89 f9                	mov    %edi,%ecx
0f07      f17:	80 e1 07             	and    $0x7,%cl
0f0a      f1a:	38 c1                	cmp    %al,%cl
0f0c      f1c:	7c c2                	jl     ee0 <leaf_cut_from_buffer+0xed0>
0f0e      f1e:	be 02 00 00 00       	mov    $0x2,%esi
0f13      f23:	e8 00 00 00 00       	call   f28 <leaf_cut_from_buffer+0xf18>	f24: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
0f18      f28:	48 8b 34 24          	mov    (%rsp),%rsi
0f1c      f2c:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0f26      f36:	eb a8                	jmp    ee0 <leaf_cut_from_buffer+0xed0>
0f28      f38:	48 8b 9c 24 90 00 00 00 	mov    0x90(%rsp),%rbx
0f30      f40:	48 83 c3 04          	add    $0x4,%rbx
0f34      f44:	48 89 d8             	mov    %rbx,%rax
0f37      f47:	48 c1 e8 03          	shr    $0x3,%rax
0f3b      f4b:	8a 04 10             	mov    (%rax,%rdx,1),%al
0f3e      f4e:	84 c0                	test   %al,%al
0f40      f50:	0f 85 75 04 00 00    	jne    13cb <leaf_cut_from_buffer+0x13bb>
0f46      f56:	66 01 2b             	add    %bp,(%rbx)
0f49      f59:	4c 8b b4 24 d0 00 00 00 	mov    0xd0(%rsp),%r14
0f51      f61:	4c 89 f3             	mov    %r14,%rbx
0f54      f64:	48 c1 eb 03          	shr    $0x3,%rbx
0f58      f68:	80 3c 13 00          	cmpb   $0x0,(%rbx,%rdx,1)
0f5c      f6c:	74 08                	je     f76 <leaf_cut_from_buffer+0xf66>
0f5e      f6e:	4c 89 f7             	mov    %r14,%rdi
0f61      f71:	e8 00 00 00 00       	call   f76 <leaf_cut_from_buffer+0xf66>	f72: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0f66      f76:	49 8b 3e             	mov    (%r14),%rdi
0f69      f79:	48 8b b4 24 88 00 00 00 	mov    0x88(%rsp),%rsi
0f71      f81:	31 d2                	xor    %edx,%edx
0f73      f83:	e8 00 00 00 00       	call   f88 <leaf_cut_from_buffer+0xf78>	f84: R_X86_64_PLT32	do_balance_mark_leaf_dirty-0x4
0f78      f88:	49 83 c6 10          	add    $0x10,%r14
0f7c      f8c:	4d 89 f4             	mov    %r14,%r12
0f7f      f8f:	49 c1 ec 03          	shr    $0x3,%r12
0f83      f93:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0f8d      f9d:	41 80 3c 14 00       	cmpb   $0x0,(%r12,%rdx,1)
0f92      fa2:	74 12                	je     fb6 <leaf_cut_from_buffer+0xfa6>
0f94      fa4:	4c 89 f7             	mov    %r14,%rdi
0f97      fa7:	e8 00 00 00 00       	call   fac <leaf_cut_from_buffer+0xf9c>	fa8: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0f9c      fac:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0fa6      fb6:	4d 8b 3e             	mov    (%r14),%r15
0fa9      fb9:	4d 85 ff             	test   %r15,%r15
0fac      fbc:	0f 84 ec 00 00 00    	je     10ae <leaf_cut_from_buffer+0x109e>
0fb2      fc2:	49 83 c7 28          	add    $0x28,%r15
0fb6      fc6:	4c 89 f8             	mov    %r15,%rax
0fb9      fc9:	48 c1 e8 03          	shr    $0x3,%rax
0fbd      fcd:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1)
0fc1      fd1:	74 12                	je     fe5 <leaf_cut_from_buffer+0xfd5>
0fc3      fd3:	4c 89 ff             	mov    %r15,%rdi
0fc6      fd6:	e8 00 00 00 00       	call   fdb <leaf_cut_from_buffer+0xfcb>	fd7: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0fcb      fdb:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
0fd5      fe5:	4d 8b 3f             	mov    (%r15),%r15
0fd8      fe8:	4d 8d 6f 18          	lea    0x18(%r15),%r13
0fdc      fec:	49 83 c7 02          	add    $0x2,%r15
0fe0      ff0:	4c 89 f8             	mov    %r15,%rax
0fe3      ff3:	48 c1 e8 03          	shr    $0x3,%rax
0fe7      ff7:	8a 04 10             	mov    (%rax,%rdx,1),%al
0fea      ffa:	84 c0                	test   %al,%al
0fec      ffc:	0f 85 3f 05 00 00    	jne    1541 <leaf_cut_from_buffer+0x1531>
0ff2     1002:	41 0f b7 07          	movzwl (%r15),%eax
0ff6     1006:	c1 e0 04             	shl    $0x4,%eax
0ff9     1009:	49 01 c5             	add    %rax,%r13
0ffc     100c:	48 8b 84 24 d0 00 00 00 	mov    0xd0(%rsp),%rax
1004     1014:	4c 8d 78 18          	lea    0x18(%rax),%r15
1008     1018:	4c 89 f8             	mov    %r15,%rax
100b     101b:	48 c1 e8 03          	shr    $0x3,%rax
100f     101f:	8a 04 10             	mov    (%rax,%rdx,1),%al
1012     1022:	84 c0                	test   %al,%al
1014     1024:	0f 85 3e 05 00 00    	jne    1568 <leaf_cut_from_buffer+0x1558>
101a     102a:	49 63 07             	movslq (%r15),%rax
101d     102d:	4c 8d 3c c5 04 00 00 00 	lea    0x4(,%rax,8),%r15
1025     1035:	4d 01 ef             	add    %r13,%r15
1028     1038:	4c 89 f8             	mov    %r15,%rax
102b     103b:	48 c1 e8 03          	shr    $0x3,%rax
102f     103f:	8a 04 10             	mov    (%rax,%rdx,1),%al
1032     1042:	84 c0                	test   %al,%al
1034     1044:	0f 85 46 05 00 00    	jne    1590 <leaf_cut_from_buffer+0x1580>
103a     104a:	66 41 29 2f          	sub    %bp,(%r15)
103e     104e:	80 3c 13 00          	cmpb   $0x0,(%rbx,%rdx,1)
1042     1052:	48 8b 9c 24 d0 00 00 00 	mov    0xd0(%rsp),%rbx
104a     105a:	74 12                	je     106e <leaf_cut_from_buffer+0x105e>
104c     105c:	48 89 df             	mov    %rbx,%rdi
104f     105f:	e8 00 00 00 00       	call   1064 <leaf_cut_from_buffer+0x1054>	1060: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
1054     1064:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
105e     106e:	48 8b 1b             	mov    (%rbx),%rbx
1061     1071:	41 80 3c 14 00       	cmpb   $0x0,(%r12,%rdx,1)
1066     1076:	74 08                	je     1080 <leaf_cut_from_buffer+0x1070>
1068     1078:	4c 89 f7             	mov    %r14,%rdi
106b     107b:	e8 00 00 00 00       	call   1080 <leaf_cut_from_buffer+0x1070>	107c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
1070     1080:	49 8b 36             	mov    (%r14),%rsi
1073     1083:	48 89 df             	mov    %rbx,%rdi
1076     1086:	31 d2                	xor    %edx,%edx
1078     1088:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
107f     108f:	5b                   	pop    %rbx
1080     1090:	41 5c                	pop    %r12
1082     1092:	41 5d                	pop    %r13
1084     1094:	41 5e                	pop    %r14
1086     1096:	41 5f                	pop    %r15
1088     1098:	5d                   	pop    %rbp
1089     1099:	31 c0                	xor    %eax,%eax
108b     109b:	31 c9                	xor    %ecx,%ecx
108d     109d:	45 31 c0             	xor    %r8d,%r8d
1090     10a0:	45 31 c9             	xor    %r9d,%r9d
1093     10a3:	45 31 d2             	xor    %r10d,%r10d
1096     10a6:	45 31 db             	xor    %r11d,%r11d
1099     10a9:	e9 00 00 00 00       	jmp    10ae <leaf_cut_from_buffer+0x109e>	10aa: R_X86_64_PLT32	do_balance_mark_leaf_dirty-0x4
109e     10ae:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
10a5     10b5:	5b                   	pop    %rbx
10a6     10b6:	41 5c                	pop    %r12
10a8     10b8:	41 5d                	pop    %r13
10aa     10ba:	41 5e                	pop    %r14
10ac     10bc:	41 5f                	pop    %r15
10ae     10be:	5d                   	pop    %rbp
10af     10bf:	31 c0                	xor    %eax,%eax
10b1     10c1:	31 c9                	xor    %ecx,%ecx
10b3     10c3:	45 31 c0             	xor    %r8d,%r8d
10b6     10c6:	45 31 c9             	xor    %r9d,%r9d
10b9     10c9:	45 31 d2             	xor    %r10d,%r10d
10bc     10cc:	45 31 db             	xor    %r11d,%r11d
10bf     10cf:	2e e9 00 00 00 00    	cs jmp 10d5 <leaf_cut_from_buffer+0x10c5>	10d1: R_X86_64_PLT32	__x86_return_thunk-0x4
10c5     10d5:	49 c1 ef 02          	shr    $0x2,%r15
10c9     10d9:	48 8b 84 24 88 00 00 00 	mov    0x88(%rsp),%rax
10d1     10e1:	4c 8d 68 20          	lea    0x20(%rax),%r13
10d5     10e5:	4c 89 e8             	mov    %r13,%rax
10d8     10e8:	48 c1 e8 03          	shr    $0x3,%rax
10dc     10ec:	80 3c 30 00          	cmpb   $0x0,(%rax,%rsi,1)
10e0     10f0:	74 51                	je     1143 <leaf_cut_from_buffer+0x1133>
10e2     10f2:	4c 89 4c 24 28       	mov    %r9,0x28(%rsp)
10e7     10f7:	4c 89 ef             	mov    %r13,%rdi
10ea     10fa:	66 44 89 9c 24 80 00 00 00 	mov    %r11w,0x80(%rsp)
10f3     1103:	48 89 8c 24 b0 00 00 00 	mov    %rcx,0xb0(%rsp)
10fb     110b:	e8 00 00 00 00       	call   1110 <leaf_cut_from_buffer+0x1100>	110c: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
1100     1110:	48 8b 8c 24 b0 00 00 00 	mov    0xb0(%rsp),%rcx
1108     1118:	44 0f b7 9c 24 80 00 00 00 	movzwl 0x80(%rsp),%r11d
1111     1121:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
1116     1126:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
111b     112b:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
1120     1130:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1125     1135:	4c 8b 14 24          	mov    (%rsp),%r10
1129     1139:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1133     1143:	4d 0f af 7d 00       	imul   0x0(%r13),%r15
1138     1148:	49 01 ef             	add    %rbp,%r15
113b     114b:	48 b8 ff ff ff ff ff ff ff 0f 	movabs $0xfffffffffffffff,%rax
1145     1155:	49 21 c7             	and    %rax,%r15
1148     1158:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
114c     115c:	84 c0                	test   %al,%al
114e     115e:	0f 85 98 0f 00 00    	jne    20fc <leaf_cut_from_buffer+0x20ec>
1154     1164:	4d 09 f7             	or     %r14,%r15
1157     1167:	8a 04 33             	mov    (%rbx,%rsi,1),%al
115a     116a:	84 c0                	test   %al,%al
115c     116c:	48 8b 6c 24 30       	mov    0x30(%rsp),%rbp
1161     1171:	4c 8b 64 24 70       	mov    0x70(%rsp),%r12
1166     1176:	0f 85 d2 0f 00 00    	jne    214e <leaf_cut_from_buffer+0x213e>
116c     117c:	4d 89 39             	mov    %r15,(%r9)
116f     117f:	48 8b 44 24 78       	mov    0x78(%rsp),%rax
1174     1184:	8a 04 30             	mov    (%rax,%rsi,1),%al
1177     1187:	84 c0                	test   %al,%al
1179     1189:	0f 85 0b 10 00 00    	jne    219a <leaf_cut_from_buffer+0x218a>
117f     118f:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
1184     1194:	8a 04 30             	mov    (%rax,%rsi,1),%al
1187     1197:	84 c0                	test   %al,%al
1189     1199:	49 89 d1             	mov    %rdx,%r9
118c     119c:	0f 85 3f 10 00 00    	jne    21e1 <leaf_cut_from_buffer+0x21d1>
1192     11a2:	66 41 83 fb 01       	cmp    $0x1,%r11w
1197     11a7:	0f 84 7b f7 ff ff    	je     928 <leaf_cut_from_buffer+0x918>
119d     11ad:	48 89 fa             	mov    %rdi,%rdx
11a0     11b0:	48 8b 44 24 48       	mov    0x48(%rsp),%rax
11a5     11b5:	0f b7 00             	movzwl (%rax),%eax
11a8     11b8:	39 e8                	cmp    %ebp,%eax
11aa     11ba:	0f 85 68 f7 ff ff    	jne    928 <leaf_cut_from_buffer+0x918>
11b0     11c0:	4d 8d 34 d1          	lea    (%r9,%rdx,8),%r14
11b4     11c4:	49 83 c6 10          	add    $0x10,%r14
11b8     11c8:	4d 8d 3c d1          	lea    (%r9,%rdx,8),%r15
11bc     11cc:	49 83 c7 11          	add    $0x11,%r15
11c0     11d0:	4c 89 f0             	mov    %r14,%rax
11c3     11d3:	48 c1 e8 03          	shr    $0x3,%rax
11c7     11d7:	8a 04 30             	mov    (%rax,%rsi,1),%al
11ca     11da:	84 c0                	test   %al,%al
11cc     11dc:	0f 85 46 10 00 00    	jne    2228 <leaf_cut_from_buffer+0x2218>
11d2     11e2:	4c 89 f8             	mov    %r15,%rax
11d5     11e5:	48 c1 e8 03          	shr    $0x3,%rax
11d9     11e9:	8a 04 30             	mov    (%rax,%rsi,1),%al
11dc     11ec:	84 c0                	test   %al,%al
11de     11ee:	0f 85 67 10 00 00    	jne    225b <leaf_cut_from_buffer+0x224b>
11e4     11f4:	66 41 83 3e 00       	cmpw   $0x0,(%r14)
11e9     11f9:	0f 84 29 f7 ff ff    	je     928 <leaf_cut_from_buffer+0x918>
11ef     11ff:	31 ff                	xor    %edi,%edi
11f1     1201:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	1204: R_X86_64_32S	.rodata..str+0x88a0
11f8     1208:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	120b: R_X86_64_32S	.rodata.str1.1+0x767b
11ff     120f:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx	1212: R_X86_64_32S	.rodata..str.37+0x1ba0
1206     1216:	41 b8 ae 04 00 00    	mov    $0x4ae,%r8d
120c     121c:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9	121f: R_X86_64_32S	.rodata.str1.1+0x767b
1213     1223:	e9 7e 11 00 00       	jmp    23a6 <leaf_cut_from_buffer+0x2396>
1218     1228:	41 8a 04 36          	mov    (%r14,%rsi,1),%al
121c     122c:	84 c0                	test   %al,%al
121e     122e:	0f 85 79 11 00 00    	jne    23ad <leaf_cut_from_buffer+0x239d>
1224     1234:	03 5c 24 30          	add    0x30(%rsp),%ebx
1228     1238:	41 8a 04 34          	mov    (%r12,%rsi,1),%al
122c     123c:	84 c0                	test   %al,%al
122e     123e:	4c 8b 64 24 70       	mov    0x70(%rsp),%r12
1233     1243:	0f 85 9c 11 00 00    	jne    23e5 <leaf_cut_from_buffer+0x23d5>
1239     1249:	89 5d 00             	mov    %ebx,0x0(%rbp)
123c     124c:	e9 c4 ef ff ff       	jmp    215 <leaf_cut_from_buffer+0x205>
1241     1251:	89 f9                	mov    %edi,%ecx
1243     1253:	80 e1 07             	and    $0x7,%cl
1246     1256:	fe c1                	inc    %cl
1248     1258:	38 c1                	cmp    %al,%cl
124a     125a:	0f 8c 4f ee ff ff    	jl     af <leaf_cut_from_buffer+0x9f>
1250     1260:	e8 00 00 00 00       	call   1265 <leaf_cut_from_buffer+0x1255>	1261: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1255     1265:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
125f     126f:	e9 3b ee ff ff       	jmp    af <leaf_cut_from_buffer+0x9f>
1264     1274:	44 89 f9             	mov    %r15d,%ecx
1267     1277:	80 e1 07             	and    $0x7,%cl
126a     127a:	38 c1                	cmp    %al,%cl
126c     127c:	0f 8c 7a ee ff ff    	jl     fc <leaf_cut_from_buffer+0xec>
1272     1282:	be 02 00 00 00       	mov    $0x2,%esi
1277     1287:	4c 89 ff             	mov    %r15,%rdi
127a     128a:	e8 00 00 00 00       	call   128f <leaf_cut_from_buffer+0x127f>	128b: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
127f     128f:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
1284     1294:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
1289     1299:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
128e     129e:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1298     12a8:	e9 4f ee ff ff       	jmp    fc <leaf_cut_from_buffer+0xec>
129d     12ad:	89 f9                	mov    %edi,%ecx
129f     12af:	80 e1 07             	and    $0x7,%cl
12a2     12b2:	38 c1                	cmp    %al,%cl
12a4     12b4:	0f 8c 5c ee ff ff    	jl     116 <leaf_cut_from_buffer+0x106>
12aa     12ba:	be 02 00 00 00       	mov    $0x2,%esi
12af     12bf:	e8 00 00 00 00       	call   12c4 <leaf_cut_from_buffer+0x12b4>	12c0: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
12b4     12c4:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
12b9     12c9:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
12be     12ce:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
12c8     12d8:	e9 39 ee ff ff       	jmp    116 <leaf_cut_from_buffer+0x106>
12cd     12dd:	44 89 f1             	mov    %r14d,%ecx
12d0     12e0:	80 e1 07             	and    $0x7,%cl
12d3     12e3:	38 c1                	cmp    %al,%cl
12d5     12e5:	0f 8c 90 fa ff ff    	jl     d7b <leaf_cut_from_buffer+0xd6b>
12db     12eb:	be 02 00 00 00       	mov    $0x2,%esi
12e0     12f0:	4c 89 f7             	mov    %r14,%rdi
12e3     12f3:	e8 00 00 00 00       	call   12f8 <leaf_cut_from_buffer+0x12e8>	12f4: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
12e8     12f8:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
12ed     12fd:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
12f2     1302:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
12fc     130c:	e9 6a fa ff ff       	jmp    d7b <leaf_cut_from_buffer+0xd6b>
1301     1311:	44 89 f9             	mov    %r15d,%ecx
1304     1314:	80 e1 07             	and    $0x7,%cl
1307     1317:	38 c1                	cmp    %al,%cl
1309     1319:	0f 8c 75 fa ff ff    	jl     d94 <leaf_cut_from_buffer+0xd84>
130f     131f:	be 02 00 00 00       	mov    $0x2,%esi
1314     1324:	4c 89 ff             	mov    %r15,%rdi
1317     1327:	e8 00 00 00 00       	call   132c <leaf_cut_from_buffer+0x131c>	1328: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
131c     132c:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1321     1331:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
1326     1336:	48 8b 34 24          	mov    (%rsp),%rsi
132a     133a:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1334     1344:	e9 4b fa ff ff       	jmp    d94 <leaf_cut_from_buffer+0xd84>
1339     1349:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
133e     134e:	80 e1 07             	and    $0x7,%cl
1341     1351:	38 c1                	cmp    %al,%cl
1343     1353:	0f 8c 5f fa ff ff    	jl     db8 <leaf_cut_from_buffer+0xda8>
1349     1359:	be 02 00 00 00       	mov    $0x2,%esi
134e     135e:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
1353     1363:	e8 00 00 00 00       	call   1368 <leaf_cut_from_buffer+0x1358>	1364: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1358     1368:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
135d     136d:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
1362     1372:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
1367     1377:	48 8b 34 24          	mov    (%rsp),%rsi
136b     137b:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1375     1385:	e9 2e fa ff ff       	jmp    db8 <leaf_cut_from_buffer+0xda8>
137a     138a:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
137f     138f:	80 e1 07             	and    $0x7,%cl
1382     1392:	38 c1                	cmp    %al,%cl
1384     1394:	0f 8c 36 fa ff ff    	jl     dd0 <leaf_cut_from_buffer+0xdc0>
138a     139a:	be 02 00 00 00       	mov    $0x2,%esi
138f     139f:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
1394     13a4:	e8 00 00 00 00       	call   13a9 <leaf_cut_from_buffer+0x1399>	13a5: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1399     13a9:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
139e     13ae:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
13a3     13b3:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
13a8     13b8:	48 8b 34 24          	mov    (%rsp),%rsi
13ac     13bc:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
13b6     13c6:	e9 05 fa ff ff       	jmp    dd0 <leaf_cut_from_buffer+0xdc0>
13bb     13cb:	89 d9                	mov    %ebx,%ecx
13bd     13cd:	80 e1 07             	and    $0x7,%cl
13c0     13d0:	fe c1                	inc    %cl
13c2     13d2:	38 c1                	cmp    %al,%cl
13c4     13d4:	0f 8c 7c fb ff ff    	jl     f56 <leaf_cut_from_buffer+0xf46>
13ca     13da:	48 89 df             	mov    %rbx,%rdi
13cd     13dd:	e8 00 00 00 00       	call   13e2 <leaf_cut_from_buffer+0x13d2>	13de: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
13d2     13e2:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
13dc     13ec:	e9 65 fb ff ff       	jmp    f56 <leaf_cut_from_buffer+0xf46>
13e1     13f1:	44 89 f1             	mov    %r14d,%ecx
13e4     13f4:	80 e1 07             	and    $0x7,%cl
13e7     13f7:	38 c1                	cmp    %al,%cl
13e9     13f9:	0f 8c 59 f5 ff ff    	jl     958 <leaf_cut_from_buffer+0x948>
13ef     13ff:	be 02 00 00 00       	mov    $0x2,%esi
13f4     1404:	4c 89 f7             	mov    %r14,%rdi
13f7     1407:	e8 00 00 00 00       	call   140c <leaf_cut_from_buffer+0x13fc>	1408: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
13fc     140c:	4c 8b 14 24          	mov    (%rsp),%r10
1400     1410:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
140a     141a:	e9 39 f5 ff ff       	jmp    958 <leaf_cut_from_buffer+0x948>
140f     141f:	44 89 f9             	mov    %r15d,%ecx
1412     1422:	80 e1 07             	and    $0x7,%cl
1415     1425:	38 c1                	cmp    %al,%cl
1417     1427:	0f 8c 40 f5 ff ff    	jl     96d <leaf_cut_from_buffer+0x95d>
141d     142d:	be 02 00 00 00       	mov    $0x2,%esi
1422     1432:	4c 89 ff             	mov    %r15,%rdi
1425     1435:	e8 00 00 00 00       	call   143a <leaf_cut_from_buffer+0x142a>	1436: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
142a     143a:	4c 8b 14 24          	mov    (%rsp),%r10
142e     143e:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1438     1448:	e9 20 f5 ff ff       	jmp    96d <leaf_cut_from_buffer+0x95d>
143d     144d:	44 89 f1             	mov    %r14d,%ecx
1440     1450:	80 e1 07             	and    $0x7,%cl
1443     1453:	38 c1                	cmp    %al,%cl
1445     1455:	0f 8c 1a ed ff ff    	jl     175 <leaf_cut_from_buffer+0x165>
144b     145b:	be 08 00 00 00       	mov    $0x8,%esi
1450     1460:	4c 89 f7             	mov    %r14,%rdi
1453     1463:	e8 00 00 00 00       	call   1468 <leaf_cut_from_buffer+0x1458>	1464: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1458     1468:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
145d     146d:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
1462     1472:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1467     1477:	4c 8b 14 24          	mov    (%rsp),%r10
146b     147b:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1475     1485:	e9 eb ec ff ff       	jmp    175 <leaf_cut_from_buffer+0x165>
147a     148a:	44 89 f9             	mov    %r15d,%ecx
147d     148d:	80 e1 07             	and    $0x7,%cl
1480     1490:	38 c1                	cmp    %al,%cl
1482     1492:	0f 8c ef ec ff ff    	jl     187 <leaf_cut_from_buffer+0x177>
1488     1498:	be 08 00 00 00       	mov    $0x8,%esi
148d     149d:	4c 89 ff             	mov    %r15,%rdi
1490     14a0:	e8 00 00 00 00       	call   14a5 <leaf_cut_from_buffer+0x1495>	14a1: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1495     14a5:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
149a     14aa:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
149f     14af:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
14a4     14b4:	4c 8b 14 24          	mov    (%rsp),%r10
14a8     14b8:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
14b2     14c2:	e9 c0 ec ff ff       	jmp    187 <leaf_cut_from_buffer+0x177>
14b7     14c7:	44 89 f1             	mov    %r14d,%ecx
14ba     14ca:	80 e1 07             	and    $0x7,%cl
14bd     14cd:	38 c1                	cmp    %al,%cl
14bf     14cf:	0f 8c 1c f9 ff ff    	jl     df1 <leaf_cut_from_buffer+0xde1>
14c5     14d5:	be 08 00 00 00       	mov    $0x8,%esi
14ca     14da:	4c 89 f7             	mov    %r14,%rdi
14cd     14dd:	e8 00 00 00 00       	call   14e2 <leaf_cut_from_buffer+0x14d2>	14de: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
14d2     14e2:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
14d7     14e7:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
14dc     14ec:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
14e1     14f1:	48 8b 34 24          	mov    (%rsp),%rsi
14e5     14f5:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
14ef     14ff:	e9 ed f8 ff ff       	jmp    df1 <leaf_cut_from_buffer+0xde1>
14f4     1504:	44 89 f9             	mov    %r15d,%ecx
14f7     1507:	80 e1 07             	and    $0x7,%cl
14fa     150a:	38 c1                	cmp    %al,%cl
14fc     150c:	0f 8c f1 f8 ff ff    	jl     e03 <leaf_cut_from_buffer+0xdf3>
1502     1512:	be 08 00 00 00       	mov    $0x8,%esi
1507     1517:	4c 89 ff             	mov    %r15,%rdi
150a     151a:	e8 00 00 00 00       	call   151f <leaf_cut_from_buffer+0x150f>	151b: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
150f     151f:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1514     1524:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
1519     1529:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
151e     152e:	48 8b 34 24          	mov    (%rsp),%rsi
1522     1532:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
152c     153c:	e9 c2 f8 ff ff       	jmp    e03 <leaf_cut_from_buffer+0xdf3>
1531     1541:	44 89 f9             	mov    %r15d,%ecx
1534     1544:	80 e1 07             	and    $0x7,%cl
1537     1547:	fe c1                	inc    %cl
1539     1549:	38 c1                	cmp    %al,%cl
153b     154b:	0f 8c b1 fa ff ff    	jl     1002 <leaf_cut_from_buffer+0xff2>
1541     1551:	4c 89 ff             	mov    %r15,%rdi
1544     1554:	e8 00 00 00 00       	call   1559 <leaf_cut_from_buffer+0x1549>	1555: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1549     1559:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
1553     1563:	e9 9a fa ff ff       	jmp    1002 <leaf_cut_from_buffer+0xff2>
1558     1568:	44 89 f9             	mov    %r15d,%ecx
155b     156b:	80 e1 07             	and    $0x7,%cl
155e     156e:	80 c1 03             	add    $0x3,%cl
1561     1571:	38 c1                	cmp    %al,%cl
1563     1573:	0f 8c b1 fa ff ff    	jl     102a <leaf_cut_from_buffer+0x101a>
1569     1579:	4c 89 ff             	mov    %r15,%rdi
156c     157c:	e8 00 00 00 00       	call   1581 <leaf_cut_from_buffer+0x1571>	157d: R_X86_64_PLT32	__asan_report_load4_noabort-0x4
1571     1581:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
157b     158b:	e9 9a fa ff ff       	jmp    102a <leaf_cut_from_buffer+0x101a>
1580     1590:	44 89 f9             	mov    %r15d,%ecx
1583     1593:	80 e1 07             	and    $0x7,%cl
1586     1596:	fe c1                	inc    %cl
1588     1598:	38 c1                	cmp    %al,%cl
158a     159a:	0f 8c aa fa ff ff    	jl     104a <leaf_cut_from_buffer+0x103a>
1590     15a0:	4c 89 ff             	mov    %r15,%rdi
1593     15a3:	e8 00 00 00 00       	call   15a8 <leaf_cut_from_buffer+0x1598>	15a4: R_X86_64_PLT32	__asan_report_load2_noabort-0x4
1598     15a8:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
15a2     15b2:	e9 93 fa ff ff       	jmp    104a <leaf_cut_from_buffer+0x103a>
15a7     15b7:	44 89 f1             	mov    %r14d,%ecx
15aa     15ba:	80 e1 07             	and    $0x7,%cl
15ad     15bd:	38 c1                	cmp    %al,%cl
15af     15bf:	0f 8c d2 f3 ff ff    	jl     997 <leaf_cut_from_buffer+0x987>
15b5     15c5:	be 02 00 00 00       	mov    $0x2,%esi
15ba     15ca:	4c 89 f7             	mov    %r14,%rdi
15bd     15cd:	e8 00 00 00 00       	call   15d2 <leaf_cut_from_buffer+0x15c2>	15ce: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
15c2     15d2:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
15cc     15dc:	e9 b6 f3 ff ff       	jmp    997 <leaf_cut_from_buffer+0x987>
15d1     15e1:	44 89 f9             	mov    %r15d,%ecx
15d4     15e4:	80 e1 07             	and    $0x7,%cl
15d7     15e7:	38 c1                	cmp    %al,%cl
15d9     15e9:	0f 8c ba f3 ff ff    	jl     9a9 <leaf_cut_from_buffer+0x999>
15df     15ef:	be 02 00 00 00       	mov    $0x2,%esi
15e4     15f4:	4c 89 ff             	mov    %r15,%rdi
15e7     15f7:	e8 00 00 00 00       	call   15fc <leaf_cut_from_buffer+0x15ec>	15f8: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
15ec     15fc:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
15f6     1606:	e9 9e f3 ff ff       	jmp    9a9 <leaf_cut_from_buffer+0x999>
15fb     160b:	49 89 cf             	mov    %rcx,%r15
15fe     160e:	89 d1                	mov    %edx,%ecx
1600     1610:	80 e1 07             	and    $0x7,%cl
1603     1613:	38 c1                	cmp    %al,%cl
1605     1615:	4c 89 f9             	mov    %r15,%rcx
1608     1618:	0f 8c 8a ec ff ff    	jl     2a8 <leaf_cut_from_buffer+0x298>
160e     161e:	be 02 00 00 00       	mov    $0x2,%esi
1613     1623:	48 89 d7             	mov    %rdx,%rdi
1616     1626:	48 89 d3             	mov    %rdx,%rbx
1619     1629:	e8 00 00 00 00       	call   162e <leaf_cut_from_buffer+0x161e>	162a: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
161e     162e:	4c 89 f9             	mov    %r15,%rcx
1621     1631:	48 89 da             	mov    %rbx,%rdx
1624     1634:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1629     1639:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
162e     163e:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1633     1643:	4c 8b 14 24          	mov    (%rsp),%r10
1637     1647:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1641     1651:	e9 52 ec ff ff       	jmp    2a8 <leaf_cut_from_buffer+0x298>
1646     1656:	49 89 cf             	mov    %rcx,%r15
1649     1659:	44 89 f1             	mov    %r14d,%ecx
164c     165c:	80 e1 07             	and    $0x7,%cl
164f     165f:	38 c1                	cmp    %al,%cl
1651     1661:	4c 89 f9             	mov    %r15,%rcx
1654     1664:	0f 8c 52 ec ff ff    	jl     2bc <leaf_cut_from_buffer+0x2ac>
165a     166a:	be 02 00 00 00       	mov    $0x2,%esi
165f     166f:	4c 89 f7             	mov    %r14,%rdi
1662     1672:	48 89 d3             	mov    %rdx,%rbx
1665     1675:	e8 00 00 00 00       	call   167a <leaf_cut_from_buffer+0x166a>	1676: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
166a     167a:	4c 89 f9             	mov    %r15,%rcx
166d     167d:	48 89 da             	mov    %rbx,%rdx
1670     1680:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1675     1685:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
167a     168a:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
167f     168f:	4c 8b 14 24          	mov    (%rsp),%r10
1683     1693:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
168d     169d:	e9 1a ec ff ff       	jmp    2bc <leaf_cut_from_buffer+0x2ac>
1692     16a2:	44 89 f1             	mov    %r14d,%ecx
1695     16a5:	80 e1 07             	and    $0x7,%cl
1698     16a8:	38 c1                	cmp    %al,%cl
169a     16aa:	0f 8c d0 f7 ff ff    	jl     e80 <leaf_cut_from_buffer+0xe70>
16a0     16b0:	be 02 00 00 00       	mov    $0x2,%esi
16a5     16b5:	4c 89 f7             	mov    %r14,%rdi
16a8     16b8:	e8 00 00 00 00       	call   16bd <leaf_cut_from_buffer+0x16ad>	16b9: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
16ad     16bd:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
16b2     16c2:	48 8b 34 24          	mov    (%rsp),%rsi
16b6     16c6:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
16c0     16d0:	e9 ab f7 ff ff       	jmp    e80 <leaf_cut_from_buffer+0xe70>
16c5     16d5:	44 89 f9             	mov    %r15d,%ecx
16c8     16d8:	80 e1 07             	and    $0x7,%cl
16cb     16db:	38 c1                	cmp    %al,%cl
16cd     16dd:	0f 8c af f7 ff ff    	jl     e92 <leaf_cut_from_buffer+0xe82>
16d3     16e3:	be 02 00 00 00       	mov    $0x2,%esi
16d8     16e8:	4c 89 ff             	mov    %r15,%rdi
16db     16eb:	e8 00 00 00 00       	call   16f0 <leaf_cut_from_buffer+0x16e0>	16ec: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
16e0     16f0:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
16e5     16f5:	48 8b 34 24          	mov    (%rsp),%rsi
16e9     16f9:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
16f3     1703:	e9 8a f7 ff ff       	jmp    e92 <leaf_cut_from_buffer+0xe82>
16f8     1708:	44 89 f1             	mov    %r14d,%ecx
16fb     170b:	80 e1 07             	and    $0x7,%cl
16fe     170e:	38 c1                	cmp    %al,%cl
1700     1710:	0f 8c 23 eb ff ff    	jl     239 <leaf_cut_from_buffer+0x229>
1706     1716:	be 04 00 00 00       	mov    $0x4,%esi
170b     171b:	4c 89 f7             	mov    %r14,%rdi
170e     171e:	e8 00 00 00 00       	call   1723 <leaf_cut_from_buffer+0x1713>	171f: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1713     1723:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1718     1728:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
171d     172d:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1722     1732:	4c 8b 14 24          	mov    (%rsp),%r10
1726     1736:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1730     1740:	e9 f4 ea ff ff       	jmp    239 <leaf_cut_from_buffer+0x229>
1735     1745:	44 89 f9             	mov    %r15d,%ecx
1738     1748:	80 e1 07             	and    $0x7,%cl
173b     174b:	38 c1                	cmp    %al,%cl
173d     174d:	0f 8c f8 ea ff ff    	jl     24b <leaf_cut_from_buffer+0x23b>
1743     1753:	be 04 00 00 00       	mov    $0x4,%esi
1748     1758:	4c 89 ff             	mov    %r15,%rdi
174b     175b:	e8 00 00 00 00       	call   1760 <leaf_cut_from_buffer+0x1750>	175c: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1750     1760:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1755     1765:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
175a     176a:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
175f     176f:	4c 8b 14 24          	mov    (%rsp),%r10
1763     1773:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
176d     177d:	e9 c9 ea ff ff       	jmp    24b <leaf_cut_from_buffer+0x23b>
1772     1782:	44 89 f1             	mov    %r14d,%ecx
1775     1785:	80 e1 07             	and    $0x7,%cl
1778     1788:	38 c1                	cmp    %al,%cl
177a     178a:	0f 8c ac f6 ff ff    	jl     e3c <leaf_cut_from_buffer+0xe2c>
1780     1790:	be 04 00 00 00       	mov    $0x4,%esi
1785     1795:	4c 89 f7             	mov    %r14,%rdi
1788     1798:	e8 00 00 00 00       	call   179d <leaf_cut_from_buffer+0x178d>	1799: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
178d     179d:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1792     17a2:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
1797     17a7:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
179c     17ac:	48 8b 34 24          	mov    (%rsp),%rsi
17a0     17b0:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
17aa     17ba:	e9 7d f6 ff ff       	jmp    e3c <leaf_cut_from_buffer+0xe2c>
17af     17bf:	44 89 f9             	mov    %r15d,%ecx
17b2     17c2:	80 e1 07             	and    $0x7,%cl
17b5     17c5:	38 c1                	cmp    %al,%cl
17b7     17c7:	0f 8c 81 f6 ff ff    	jl     e4e <leaf_cut_from_buffer+0xe3e>
17bd     17cd:	be 04 00 00 00       	mov    $0x4,%esi
17c2     17d2:	4c 89 ff             	mov    %r15,%rdi
17c5     17d5:	e8 00 00 00 00       	call   17da <leaf_cut_from_buffer+0x17ca>	17d6: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
17ca     17da:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
17cf     17df:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
17d4     17e4:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
17d9     17e9:	48 8b 34 24          	mov    (%rsp),%rsi
17dd     17ed:	48 ba 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rdx
17e7     17f7:	e9 52 f6 ff ff       	jmp    e4e <leaf_cut_from_buffer+0xe3e>
17ec     17fc:	44 89 f1             	mov    %r14d,%ecx
17ef     17ff:	80 e1 07             	and    $0x7,%cl
17f2     1802:	38 c1                	cmp    %al,%cl
17f4     1804:	0f 8c e1 e9 ff ff    	jl     1eb <leaf_cut_from_buffer+0x1db>
17fa     180a:	be 02 00 00 00       	mov    $0x2,%esi
17ff     180f:	4c 89 f7             	mov    %r14,%rdi
1802     1812:	e8 00 00 00 00       	call   1817 <leaf_cut_from_buffer+0x1807>	1813: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1807     1817:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
180c     181c:	4c 8b 14 24          	mov    (%rsp),%r10
1810     1820:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
181a     182a:	e9 bc e9 ff ff       	jmp    1eb <leaf_cut_from_buffer+0x1db>
181f     182f:	44 89 f9             	mov    %r15d,%ecx
1822     1832:	80 e1 07             	and    $0x7,%cl
1825     1835:	38 c1                	cmp    %al,%cl
1827     1837:	0f 8c c9 e9 ff ff    	jl     206 <leaf_cut_from_buffer+0x1f6>
182d     183d:	be 02 00 00 00       	mov    $0x2,%esi
1832     1842:	4c 89 ff             	mov    %r15,%rdi
1835     1845:	e8 00 00 00 00       	call   184a <leaf_cut_from_buffer+0x183a>	1846: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
183a     184a:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
183f     184f:	4c 8b 14 24          	mov    (%rsp),%r10
1843     1853:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
184d     185d:	e9 a4 e9 ff ff       	jmp    206 <leaf_cut_from_buffer+0x1f6>
1852     1862:	49 89 cf             	mov    %rcx,%r15
1855     1865:	44 89 f1             	mov    %r14d,%ecx
1858     1868:	80 e1 07             	and    $0x7,%cl
185b     186b:	38 c1                	cmp    %al,%cl
185d     186d:	4c 89 f9             	mov    %r15,%rcx
1860     1870:	0f 8c 99 ea ff ff    	jl     30f <leaf_cut_from_buffer+0x2ff>
1866     1876:	be 02 00 00 00       	mov    $0x2,%esi
186b     187b:	89 7c 24 20          	mov    %edi,0x20(%rsp)
186f     187f:	4c 89 f7             	mov    %r14,%rdi
1872     1882:	48 89 d3             	mov    %rdx,%rbx
1875     1885:	e8 00 00 00 00       	call   188a <leaf_cut_from_buffer+0x187a>	1886: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
187a     188a:	8b 7c 24 20          	mov    0x20(%rsp),%edi
187e     188e:	4c 89 f9             	mov    %r15,%rcx
1881     1891:	48 89 da             	mov    %rbx,%rdx
1884     1894:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1889     1899:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
188e     189e:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1898     18a8:	e9 62 ea ff ff       	jmp    30f <leaf_cut_from_buffer+0x2ff>
189d     18ad:	49 89 cf             	mov    %rcx,%r15
18a0     18b0:	44 89 e9             	mov    %r13d,%ecx
18a3     18b3:	80 e1 07             	and    $0x7,%cl
18a6     18b6:	38 c1                	cmp    %al,%cl
18a8     18b8:	4c 89 f9             	mov    %r15,%rcx
18ab     18bb:	0f 8c 60 ea ff ff    	jl     321 <leaf_cut_from_buffer+0x311>
18b1     18c1:	be 02 00 00 00       	mov    $0x2,%esi
18b6     18c6:	89 7c 24 20          	mov    %edi,0x20(%rsp)
18ba     18ca:	4c 89 ef             	mov    %r13,%rdi
18bd     18cd:	48 89 d3             	mov    %rdx,%rbx
18c0     18d0:	e8 00 00 00 00       	call   18d5 <leaf_cut_from_buffer+0x18c5>	18d1: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
18c5     18d5:	8b 7c 24 20          	mov    0x20(%rsp),%edi
18c9     18d9:	4c 89 f9             	mov    %r15,%rcx
18cc     18dc:	48 89 da             	mov    %rbx,%rdx
18cf     18df:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
18d4     18e4:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
18d9     18e9:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
18e3     18f3:	e9 29 ea ff ff       	jmp    321 <leaf_cut_from_buffer+0x311>
18e8     18f8:	49 89 cc             	mov    %rcx,%r12
18eb     18fb:	44 89 f1             	mov    %r14d,%ecx
18ee     18fe:	80 e1 07             	and    $0x7,%cl
18f1     1901:	38 c1                	cmp    %al,%cl
18f3     1903:	4c 89 e1             	mov    %r12,%rcx
18f6     1906:	0f 8c 60 ea ff ff    	jl     36c <leaf_cut_from_buffer+0x35c>
18fc     190c:	be 02 00 00 00       	mov    $0x2,%esi
1901     1911:	89 7c 24 20          	mov    %edi,0x20(%rsp)
1905     1915:	4c 89 f7             	mov    %r14,%rdi
1908     1918:	48 89 d3             	mov    %rdx,%rbx
190b     191b:	4d 89 c7             	mov    %r8,%r15
190e     191e:	48 89 6c 24 78       	mov    %rbp,0x78(%rsp)
1913     1923:	4c 89 d5             	mov    %r10,%rbp
1916     1926:	e8 00 00 00 00       	call   192b <leaf_cut_from_buffer+0x191b>	1927: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
191b     192b:	8b 7c 24 20          	mov    0x20(%rsp),%edi
191f     192f:	49 89 ea             	mov    %rbp,%r10
1922     1932:	48 8b 6c 24 78       	mov    0x78(%rsp),%rbp
1927     1937:	4c 89 e1             	mov    %r12,%rcx
192a     193a:	4d 89 f8             	mov    %r15,%r8
192d     193d:	48 89 da             	mov    %rbx,%rdx
1930     1940:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
193a     194a:	e9 1d ea ff ff       	jmp    36c <leaf_cut_from_buffer+0x35c>
193f     194f:	49 89 cc             	mov    %rcx,%r12
1942     1952:	44 89 e9             	mov    %r13d,%ecx
1945     1955:	80 e1 07             	and    $0x7,%cl
1948     1958:	38 c1                	cmp    %al,%cl
194a     195a:	4c 89 e1             	mov    %r12,%rcx
194d     195d:	0f 8c 1b ea ff ff    	jl     37e <leaf_cut_from_buffer+0x36e>
1953     1963:	be 02 00 00 00       	mov    $0x2,%esi
1958     1968:	89 7c 24 20          	mov    %edi,0x20(%rsp)
195c     196c:	4c 89 ef             	mov    %r13,%rdi
195f     196f:	48 89 d3             	mov    %rdx,%rbx
1962     1972:	4d 89 c7             	mov    %r8,%r15
1965     1975:	4d 89 d5             	mov    %r10,%r13
1968     1978:	e8 00 00 00 00       	call   197d <leaf_cut_from_buffer+0x196d>	1979: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
196d     197d:	8b 7c 24 20          	mov    0x20(%rsp),%edi
1971     1981:	4d 89 ea             	mov    %r13,%r10
1974     1984:	4c 89 e1             	mov    %r12,%rcx
1977     1987:	4d 89 f8             	mov    %r15,%r8
197a     198a:	48 89 da             	mov    %rbx,%rdx
197d     198d:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1987     1997:	e9 e2 e9 ff ff       	jmp    37e <leaf_cut_from_buffer+0x36e>
198c     199c:	49 89 cc             	mov    %rcx,%r12
198f     199f:	44 89 f1             	mov    %r14d,%ecx
1992     19a2:	80 e1 07             	and    $0x7,%cl
1995     19a5:	38 c1                	cmp    %al,%cl
1997     19a7:	4c 89 e1             	mov    %r12,%rcx
199a     19aa:	0f 8c 02 ea ff ff    	jl     3b2 <leaf_cut_from_buffer+0x3a2>
19a0     19b0:	be 02 00 00 00       	mov    $0x2,%esi
19a5     19b5:	89 7c 24 20          	mov    %edi,0x20(%rsp)
19a9     19b9:	4c 89 f7             	mov    %r14,%rdi
19ac     19bc:	48 89 d3             	mov    %rdx,%rbx
19af     19bf:	4d 89 c7             	mov    %r8,%r15
19b2     19c2:	4d 89 d5             	mov    %r10,%r13
19b5     19c5:	4c 89 5c 24 58       	mov    %r11,0x58(%rsp)
19ba     19ca:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
19bf     19cf:	e8 00 00 00 00       	call   19d4 <leaf_cut_from_buffer+0x19c4>	19d0: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
19c4     19d4:	4c 8b 4c 24 48       	mov    0x48(%rsp),%r9
19c9     19d9:	8b 7c 24 20          	mov    0x20(%rsp),%edi
19cd     19dd:	4c 8b 5c 24 58       	mov    0x58(%rsp),%r11
19d2     19e2:	4d 89 ea             	mov    %r13,%r10
19d5     19e5:	4c 89 e1             	mov    %r12,%rcx
19d8     19e8:	4d 89 f8             	mov    %r15,%r8
19db     19eb:	48 89 da             	mov    %rbx,%rdx
19de     19ee:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
19e8     19f8:	e9 b5 e9 ff ff       	jmp    3b2 <leaf_cut_from_buffer+0x3a2>
19ed     19fd:	49 89 cc             	mov    %rcx,%r12
19f0     1a00:	44 89 c9             	mov    %r9d,%ecx
19f3     1a03:	80 e1 07             	and    $0x7,%cl
19f6     1a06:	38 c1                	cmp    %al,%cl
19f8     1a08:	4c 89 e1             	mov    %r12,%rcx
19fb     1a0b:	0f 8c b3 e9 ff ff    	jl     3c4 <leaf_cut_from_buffer+0x3b4>
1a01     1a11:	be 02 00 00 00       	mov    $0x2,%esi
1a06     1a16:	89 7c 24 20          	mov    %edi,0x20(%rsp)
1a0a     1a1a:	4c 89 cf             	mov    %r9,%rdi
1a0d     1a1d:	48 89 d3             	mov    %rdx,%rbx
1a10     1a20:	4d 89 c7             	mov    %r8,%r15
1a13     1a23:	4d 89 d5             	mov    %r10,%r13
1a16     1a26:	4c 89 5c 24 58       	mov    %r11,0x58(%rsp)
1a1b     1a2b:	e8 00 00 00 00       	call   1a30 <leaf_cut_from_buffer+0x1a20>	1a2c: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1a20     1a30:	8b 7c 24 20          	mov    0x20(%rsp),%edi
1a24     1a34:	4c 8b 5c 24 58       	mov    0x58(%rsp),%r11
1a29     1a39:	4d 89 ea             	mov    %r13,%r10
1a2c     1a3c:	4c 89 e1             	mov    %r12,%rcx
1a2f     1a3f:	4d 89 f8             	mov    %r15,%r8
1a32     1a42:	48 89 da             	mov    %rbx,%rdx
1a35     1a45:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1a3f     1a4f:	e9 70 e9 ff ff       	jmp    3c4 <leaf_cut_from_buffer+0x3b4>
1a44     1a54:	89 d1                	mov    %edx,%ecx
1a46     1a56:	80 e1 07             	and    $0x7,%cl
1a49     1a59:	38 c1                	cmp    %al,%cl
1a4b     1a5b:	0f 8c 27 ec ff ff    	jl     688 <leaf_cut_from_buffer+0x678>
1a51     1a61:	be 02 00 00 00       	mov    $0x2,%esi
1a56     1a66:	48 89 d7             	mov    %rdx,%rdi
1a59     1a69:	48 89 d3             	mov    %rdx,%rbx
1a5c     1a6c:	4d 89 c6             	mov    %r8,%r14
1a5f     1a6f:	4d 89 cf             	mov    %r9,%r15
1a62     1a72:	e8 00 00 00 00       	call   1a77 <leaf_cut_from_buffer+0x1a67>	1a73: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1a67     1a77:	4d 89 f9             	mov    %r15,%r9
1a6a     1a7a:	4d 89 f0             	mov    %r14,%r8
1a6d     1a7d:	48 89 da             	mov    %rbx,%rdx
1a70     1a80:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1a7a     1a8a:	e9 f9 eb ff ff       	jmp    688 <leaf_cut_from_buffer+0x678>
1a7f     1a8f:	48 8b 8c 24 d8 00 00 00 	mov    0xd8(%rsp),%rcx
1a87     1a97:	80 e1 07             	and    $0x7,%cl
1a8a     1a9a:	38 c1                	cmp    %al,%cl
1a8c     1a9c:	0f 8c 0c ec ff ff    	jl     6ae <leaf_cut_from_buffer+0x69e>
1a92     1aa2:	be 02 00 00 00       	mov    $0x2,%esi
1a97     1aa7:	48 8b bc 24 d8 00 00 00 	mov    0xd8(%rsp),%rdi
1a9f     1aaf:	49 89 d6             	mov    %rdx,%r14
1aa2     1ab2:	4d 89 c7             	mov    %r8,%r15
1aa5     1ab5:	e8 00 00 00 00       	call   1aba <leaf_cut_from_buffer+0x1aaa>	1ab6: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1aaa     1aba:	4c 8b 4c 24 28       	mov    0x28(%rsp),%r9
1aaf     1abf:	4d 89 f8             	mov    %r15,%r8
1ab2     1ac2:	4c 89 f2             	mov    %r14,%rdx
1ab5     1ac5:	e9 e4 eb ff ff       	jmp    6ae <leaf_cut_from_buffer+0x69e>
1aba     1aca:	89 f9                	mov    %edi,%ecx
1abc     1acc:	80 e1 07             	and    $0x7,%cl
1abf     1acf:	38 c1                	cmp    %al,%cl
1ac1     1ad1:	0f 8c 1e ec ff ff    	jl     6f5 <leaf_cut_from_buffer+0x6e5>
1ac7     1ad7:	be 02 00 00 00       	mov    $0x2,%esi
1acc     1adc:	e8 00 00 00 00       	call   1ae1 <leaf_cut_from_buffer+0x1ad1>	1add: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1ad1     1ae1:	48 8b bc 24 80 00 00 00 	mov    0x80(%rsp),%rdi
1ad9     1ae9:	48 bb 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rbx
1ae3     1af3:	e9 fd eb ff ff       	jmp    6f5 <leaf_cut_from_buffer+0x6e5>
1ae8     1af8:	44 89 f1             	mov    %r14d,%ecx
1aeb     1afb:	80 e1 07             	and    $0x7,%cl
1aee     1afe:	38 c1                	cmp    %al,%cl
1af0     1b00:	0f 8c 01 ec ff ff    	jl     707 <leaf_cut_from_buffer+0x6f7>
1af6     1b06:	be 02 00 00 00       	mov    $0x2,%esi
1afb     1b0b:	4c 89 f7             	mov    %r14,%rdi
1afe     1b0e:	e8 00 00 00 00       	call   1b13 <leaf_cut_from_buffer+0x1b03>	1b0f: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1b03     1b13:	48 8b bc 24 80 00 00 00 	mov    0x80(%rsp),%rdi
1b0b     1b1b:	e9 e7 eb ff ff       	jmp    707 <leaf_cut_from_buffer+0x6f7>
1b10     1b20:	89 d9                	mov    %ebx,%ecx
1b12     1b22:	80 e1 07             	and    $0x7,%cl
1b15     1b25:	38 c1                	cmp    %al,%cl
1b17     1b27:	0f 8c 2f ec ff ff    	jl     75c <leaf_cut_from_buffer+0x74c>
1b1d     1b2d:	be 02 00 00 00       	mov    $0x2,%esi
1b22     1b32:	48 89 df             	mov    %rbx,%rdi
1b25     1b35:	e8 00 00 00 00       	call   1b3a <leaf_cut_from_buffer+0x1b2a>	1b36: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1b2a     1b3a:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1b2f     1b3f:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
1b34     1b44:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1b3e     1b4e:	e9 09 ec ff ff       	jmp    75c <leaf_cut_from_buffer+0x74c>
1b43     1b53:	44 89 f1             	mov    %r14d,%ecx
1b46     1b56:	80 e1 07             	and    $0x7,%cl
1b49     1b59:	38 c1                	cmp    %al,%cl
1b4b     1b5b:	0f 8c 12 ec ff ff    	jl     773 <leaf_cut_from_buffer+0x763>
1b51     1b61:	be 02 00 00 00       	mov    $0x2,%esi
1b56     1b66:	4c 89 f7             	mov    %r14,%rdi
1b59     1b69:	e8 00 00 00 00       	call   1b6e <leaf_cut_from_buffer+0x1b5e>	1b6a: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1b5e     1b6e:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1b63     1b73:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
1b68     1b78:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1b72     1b82:	e9 ec eb ff ff       	jmp    773 <leaf_cut_from_buffer+0x763>
1b77     1b87:	44 89 f1             	mov    %r14d,%ecx
1b7a     1b8a:	80 e1 07             	and    $0x7,%cl
1b7d     1b8d:	38 c1                	cmp    %al,%cl
1b7f     1b8f:	0f 8c 0e ec ff ff    	jl     7a3 <leaf_cut_from_buffer+0x793>
1b85     1b95:	be 02 00 00 00       	mov    $0x2,%esi
1b8a     1b9a:	4c 89 f7             	mov    %r14,%rdi
1b8d     1b9d:	e8 00 00 00 00       	call   1ba2 <leaf_cut_from_buffer+0x1b92>	1b9e: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1b92     1ba2:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1b9c     1bac:	e9 f2 eb ff ff       	jmp    7a3 <leaf_cut_from_buffer+0x793>
1ba1     1bb1:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
1ba6     1bb6:	80 e1 07             	and    $0x7,%cl
1ba9     1bb9:	38 c1                	cmp    %al,%cl
1bab     1bbb:	0f 8c fa eb ff ff    	jl     7bb <leaf_cut_from_buffer+0x7ab>
1bb1     1bc1:	be 02 00 00 00       	mov    $0x2,%esi
1bb6     1bc6:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1bbb     1bcb:	e8 00 00 00 00       	call   1bd0 <leaf_cut_from_buffer+0x1bc0>	1bcc: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1bc0     1bd0:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1bca     1bda:	e9 dc eb ff ff       	jmp    7bb <leaf_cut_from_buffer+0x7ab>
1bcf     1bdf:	44 89 f1             	mov    %r14d,%ecx
1bd2     1be2:	80 e1 07             	and    $0x7,%cl
1bd5     1be5:	38 c1                	cmp    %al,%cl
1bd7     1be7:	0f 8c 0d ec ff ff    	jl     7fa <leaf_cut_from_buffer+0x7ea>
1bdd     1bed:	be 02 00 00 00       	mov    $0x2,%esi
1be2     1bf2:	4c 89 f7             	mov    %r14,%rdi
1be5     1bf5:	e8 00 00 00 00       	call   1bfa <leaf_cut_from_buffer+0x1bea>	1bf6: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1bea     1bfa:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1bf4     1c04:	e9 f1 eb ff ff       	jmp    7fa <leaf_cut_from_buffer+0x7ea>
1bf9     1c09:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
1bfe     1c0e:	80 e1 07             	and    $0x7,%cl
1c01     1c11:	38 c1                	cmp    %al,%cl
1c03     1c13:	0f 8c f6 eb ff ff    	jl     80f <leaf_cut_from_buffer+0x7ff>
1c09     1c19:	be 02 00 00 00       	mov    $0x2,%esi
1c0e     1c1e:	48 8b 7c 24 28       	mov    0x28(%rsp),%rdi
1c13     1c23:	e8 00 00 00 00       	call   1c28 <leaf_cut_from_buffer+0x1c18>	1c24: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1c18     1c28:	e9 e2 eb ff ff       	jmp    80f <leaf_cut_from_buffer+0x7ff>
1c1d     1c2d:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
1c22     1c32:	80 e1 07             	and    $0x7,%cl
1c25     1c35:	38 c1                	cmp    %al,%cl
1c27     1c37:	0f 8c fe eb ff ff    	jl     83b <leaf_cut_from_buffer+0x82b>
1c2d     1c3d:	be 02 00 00 00       	mov    $0x2,%esi
1c32     1c42:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
1c37     1c47:	e8 00 00 00 00       	call   1c4c <leaf_cut_from_buffer+0x1c3c>	1c48: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1c3c     1c4c:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1c46     1c56:	e9 e0 eb ff ff       	jmp    83b <leaf_cut_from_buffer+0x82b>
1c4b     1c5b:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
1c50     1c60:	80 e1 07             	and    $0x7,%cl
1c53     1c63:	38 c1                	cmp    %al,%cl
1c55     1c65:	0f 8c ec eb ff ff    	jl     857 <leaf_cut_from_buffer+0x847>
1c5b     1c6b:	be 02 00 00 00       	mov    $0x2,%esi
1c60     1c70:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
1c65     1c75:	e8 00 00 00 00       	call   1c7a <leaf_cut_from_buffer+0x1c6a>	1c76: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1c6a     1c7a:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1c6f     1c7f:	4c 8b 14 24          	mov    (%rsp),%r10
1c73     1c83:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1c7d     1c8d:	e9 c5 eb ff ff       	jmp    857 <leaf_cut_from_buffer+0x847>
1c82     1c92:	44 89 f1             	mov    %r14d,%ecx
1c85     1c95:	80 e1 07             	and    $0x7,%cl
1c88     1c98:	38 c1                	cmp    %al,%cl
1c8a     1c9a:	0f 8c 87 ed ff ff    	jl     a27 <leaf_cut_from_buffer+0xa17>
1c90     1ca0:	be 02 00 00 00       	mov    $0x2,%esi
1c95     1ca5:	4c 89 f7             	mov    %r14,%rdi
1c98     1ca8:	e8 00 00 00 00       	call   1cad <leaf_cut_from_buffer+0x1c9d>	1ca9: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1c9d     1cad:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1ca2     1cb2:	4c 8b 14 24          	mov    (%rsp),%r10
1ca6     1cb6:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1cb0     1cc0:	e9 62 ed ff ff       	jmp    a27 <leaf_cut_from_buffer+0xa17>
1cb5     1cc5:	44 89 f9             	mov    %r15d,%ecx
1cb8     1cc8:	80 e1 07             	and    $0x7,%cl
1cbb     1ccb:	38 c1                	cmp    %al,%cl
1cbd     1ccd:	0f 8c 66 ed ff ff    	jl     a39 <leaf_cut_from_buffer+0xa29>
1cc3     1cd3:	be 02 00 00 00       	mov    $0x2,%esi
1cc8     1cd8:	4c 89 ff             	mov    %r15,%rdi
1ccb     1cdb:	e8 00 00 00 00       	call   1ce0 <leaf_cut_from_buffer+0x1cd0>	1cdc: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1cd0     1ce0:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1cd5     1ce5:	4c 8b 14 24          	mov    (%rsp),%r10
1cd9     1ce9:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1ce3     1cf3:	e9 41 ed ff ff       	jmp    a39 <leaf_cut_from_buffer+0xa29>
1ce8     1cf8:	44 89 f1             	mov    %r14d,%ecx
1ceb     1cfb:	80 e1 07             	and    $0x7,%cl
1cee     1cfe:	38 c1                	cmp    %al,%cl
1cf0     1d00:	0f 8c 55 ed ff ff    	jl     a5b <leaf_cut_from_buffer+0xa4b>
1cf6     1d06:	be 04 00 00 00       	mov    $0x4,%esi
1cfb     1d0b:	4c 89 f7             	mov    %r14,%rdi
1cfe     1d0e:	e8 00 00 00 00       	call   1d13 <leaf_cut_from_buffer+0x1d03>	1d0f: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1d03     1d13:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1d08     1d18:	4c 8b 14 24          	mov    (%rsp),%r10
1d0c     1d1c:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1d16     1d26:	e9 30 ed ff ff       	jmp    a5b <leaf_cut_from_buffer+0xa4b>
1d1b     1d2b:	44 89 f9             	mov    %r15d,%ecx
1d1e     1d2e:	80 e1 07             	and    $0x7,%cl
1d21     1d31:	38 c1                	cmp    %al,%cl
1d23     1d33:	0f 8c 34 ed ff ff    	jl     a6d <leaf_cut_from_buffer+0xa5d>
1d29     1d39:	be 04 00 00 00       	mov    $0x4,%esi
1d2e     1d3e:	4c 89 ff             	mov    %r15,%rdi
1d31     1d41:	e8 00 00 00 00       	call   1d46 <leaf_cut_from_buffer+0x1d36>	1d42: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1d36     1d46:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1d3b     1d4b:	4c 8b 14 24          	mov    (%rsp),%r10
1d3f     1d4f:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1d49     1d59:	e9 0f ed ff ff       	jmp    a6d <leaf_cut_from_buffer+0xa5d>
1d4e     1d5e:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
1d53     1d63:	80 e1 07             	and    $0x7,%cl
1d56     1d66:	38 c1                	cmp    %al,%cl
1d58     1d68:	0f 8c 15 ed ff ff    	jl     a83 <leaf_cut_from_buffer+0xa73>
1d5e     1d6e:	be 02 00 00 00       	mov    $0x2,%esi
1d63     1d73:	48 8b 7c 24 50       	mov    0x50(%rsp),%rdi
1d68     1d78:	e8 00 00 00 00       	call   1d7d <leaf_cut_from_buffer+0x1d6d>	1d79: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1d6d     1d7d:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1d72     1d82:	4c 8b 14 24          	mov    (%rsp),%r10
1d76     1d86:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1d80     1d90:	e9 ee ec ff ff       	jmp    a83 <leaf_cut_from_buffer+0xa73>
1d85     1d95:	48 8b 4c 24 68       	mov    0x68(%rsp),%rcx
1d8a     1d9a:	80 e1 07             	and    $0x7,%cl
1d8d     1d9d:	38 c1                	cmp    %al,%cl
1d8f     1d9f:	0f 8c f6 ec ff ff    	jl     a9b <leaf_cut_from_buffer+0xa8b>
1d95     1da5:	be 02 00 00 00       	mov    $0x2,%esi
1d9a     1daa:	48 8b 7c 24 68       	mov    0x68(%rsp),%rdi
1d9f     1daf:	e8 00 00 00 00       	call   1db4 <leaf_cut_from_buffer+0x1da4>	1db0: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1da4     1db4:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1da9     1db9:	4c 8b 14 24          	mov    (%rsp),%r10
1dad     1dbd:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1db7     1dc7:	e9 cf ec ff ff       	jmp    a9b <leaf_cut_from_buffer+0xa8b>
1dbc     1dcc:	44 89 f1             	mov    %r14d,%ecx
1dbf     1dcf:	80 e1 07             	and    $0x7,%cl
1dc2     1dd2:	38 c1                	cmp    %al,%cl
1dc4     1dd4:	0f 8c b7 ee ff ff    	jl     c91 <leaf_cut_from_buffer+0xc81>
1dca     1dda:	be 02 00 00 00       	mov    $0x2,%esi
1dcf     1ddf:	4c 89 f7             	mov    %r14,%rdi
1dd2     1de2:	e8 00 00 00 00       	call   1de7 <leaf_cut_from_buffer+0x1dd7>	1de3: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1dd7     1de7:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1de1     1df1:	e9 9b ee ff ff       	jmp    c91 <leaf_cut_from_buffer+0xc81>
1de6     1df6:	44 89 f9             	mov    %r15d,%ecx
1de9     1df9:	80 e1 07             	and    $0x7,%cl
1dec     1dfc:	38 c1                	cmp    %al,%cl
1dee     1dfe:	0f 8c a2 ee ff ff    	jl     ca6 <leaf_cut_from_buffer+0xc96>
1df4     1e04:	be 02 00 00 00       	mov    $0x2,%esi
1df9     1e09:	4c 89 ff             	mov    %r15,%rdi
1dfc     1e0c:	e8 00 00 00 00       	call   1e11 <leaf_cut_from_buffer+0x1e01>	1e0d: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1e01     1e11:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1e0b     1e1b:	e9 86 ee ff ff       	jmp    ca6 <leaf_cut_from_buffer+0xc96>
1e10     1e20:	49 89 ce             	mov    %rcx,%r14
1e13     1e23:	44 89 c9             	mov    %r9d,%ecx
1e16     1e26:	80 e1 07             	and    $0x7,%cl
1e19     1e29:	38 c1                	cmp    %al,%cl
1e1b     1e2b:	4c 89 f1             	mov    %r14,%rcx
1e1e     1e2e:	0f 8c 61 ea ff ff    	jl     895 <leaf_cut_from_buffer+0x885>
1e24     1e34:	be 08 00 00 00       	mov    $0x8,%esi
1e29     1e39:	4c 89 cb             	mov    %r9,%rbx
1e2c     1e3c:	4c 89 cf             	mov    %r9,%rdi
1e2f     1e3f:	44 89 dd             	mov    %r11d,%ebp
1e32     1e42:	e8 00 00 00 00       	call   1e47 <leaf_cut_from_buffer+0x1e37>	1e43: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1e37     1e47:	4c 89 f1             	mov    %r14,%rcx
1e3a     1e4a:	41 89 eb             	mov    %ebp,%r11d
1e3d     1e4d:	49 89 d9             	mov    %rbx,%r9
1e40     1e50:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
1e45     1e55:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
1e4a     1e5a:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1e4f     1e5f:	4c 8b 14 24          	mov    (%rsp),%r10
1e53     1e63:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1e5d     1e6d:	e9 23 ea ff ff       	jmp    895 <leaf_cut_from_buffer+0x885>
1e62     1e72:	49 89 cd             	mov    %rcx,%r13
1e65     1e75:	80 e1 07             	and    $0x7,%cl
1e68     1e78:	38 c1                	cmp    %al,%cl
1e6a     1e7a:	4c 89 e9             	mov    %r13,%rcx
1e6d     1e7d:	0f 8c 24 ea ff ff    	jl     8a7 <leaf_cut_from_buffer+0x897>
1e73     1e83:	be 08 00 00 00       	mov    $0x8,%esi
1e78     1e88:	4d 89 ce             	mov    %r9,%r14
1e7b     1e8b:	48 89 cf             	mov    %rcx,%rdi
1e7e     1e8e:	44 89 dd             	mov    %r11d,%ebp
1e81     1e91:	e8 00 00 00 00       	call   1e96 <leaf_cut_from_buffer+0x1e86>	1e92: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1e86     1e96:	4c 89 e9             	mov    %r13,%rcx
1e89     1e99:	41 89 eb             	mov    %ebp,%r11d
1e8c     1e9c:	4d 89 f1             	mov    %r14,%r9
1e8f     1e9f:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
1e94     1ea4:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
1e99     1ea9:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1e9e     1eae:	4c 8b 14 24          	mov    (%rsp),%r10
1ea2     1eb2:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1eac     1ebc:	e9 e6 e9 ff ff       	jmp    8a7 <leaf_cut_from_buffer+0x897>
1eb1     1ec1:	44 89 f1             	mov    %r14d,%ecx
1eb4     1ec4:	80 e1 07             	and    $0x7,%cl
1eb7     1ec7:	38 c1                	cmp    %al,%cl
1eb9     1ec9:	0f 8c f0 eb ff ff    	jl     abf <leaf_cut_from_buffer+0xaaf>
1ebf     1ecf:	be 08 00 00 00       	mov    $0x8,%esi
1ec4     1ed4:	4c 89 f7             	mov    %r14,%rdi
1ec7     1ed7:	e8 00 00 00 00       	call   1edc <leaf_cut_from_buffer+0x1ecc>	1ed8: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1ecc     1edc:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1ed1     1ee1:	4c 8b 14 24          	mov    (%rsp),%r10
1ed5     1ee5:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1edf     1eef:	e9 cb eb ff ff       	jmp    abf <leaf_cut_from_buffer+0xaaf>
1ee4     1ef4:	44 89 f9             	mov    %r15d,%ecx
1ee7     1ef7:	80 e1 07             	and    $0x7,%cl
1eea     1efa:	38 c1                	cmp    %al,%cl
1eec     1efc:	0f 8c cf eb ff ff    	jl     ad1 <leaf_cut_from_buffer+0xac1>
1ef2     1f02:	be 08 00 00 00       	mov    $0x8,%esi
1ef7     1f07:	4c 89 ff             	mov    %r15,%rdi
1efa     1f0a:	e8 00 00 00 00       	call   1f0f <leaf_cut_from_buffer+0x1eff>	1f0b: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1eff     1f0f:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1f04     1f14:	4c 8b 14 24          	mov    (%rsp),%r10
1f08     1f18:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1f12     1f22:	e9 aa eb ff ff       	jmp    ad1 <leaf_cut_from_buffer+0xac1>
1f17     1f27:	89 f9                	mov    %edi,%ecx
1f19     1f29:	80 e1 07             	and    $0x7,%cl
1f1c     1f2c:	38 c1                	cmp    %al,%cl
1f1e     1f2e:	0f 8c d2 eb ff ff    	jl     b06 <leaf_cut_from_buffer+0xaf6>
1f24     1f34:	be 04 00 00 00       	mov    $0x4,%esi
1f29     1f39:	e8 00 00 00 00       	call   1f3e <leaf_cut_from_buffer+0x1f2e>	1f3a: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1f2e     1f3e:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1f33     1f43:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
1f38     1f48:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1f3d     1f4d:	4c 8b 14 24          	mov    (%rsp),%r10
1f41     1f51:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1f4b     1f5b:	e9 a6 eb ff ff       	jmp    b06 <leaf_cut_from_buffer+0xaf6>
1f50     1f60:	44 89 f1             	mov    %r14d,%ecx
1f53     1f63:	80 e1 07             	and    $0x7,%cl
1f56     1f66:	38 c1                	cmp    %al,%cl
1f58     1f68:	0f 8c aa eb ff ff    	jl     b18 <leaf_cut_from_buffer+0xb08>
1f5e     1f6e:	be 04 00 00 00       	mov    $0x4,%esi
1f63     1f73:	4c 89 f7             	mov    %r14,%rdi
1f66     1f76:	e8 00 00 00 00       	call   1f7b <leaf_cut_from_buffer+0x1f6b>	1f77: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1f6b     1f7b:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1f70     1f80:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
1f75     1f85:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1f7a     1f8a:	4c 8b 14 24          	mov    (%rsp),%r10
1f7e     1f8e:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1f88     1f98:	e9 7b eb ff ff       	jmp    b18 <leaf_cut_from_buffer+0xb08>
1f8d     1f9d:	89 e9                	mov    %ebp,%ecx
1f8f     1f9f:	80 e1 07             	and    $0x7,%cl
1f92     1fa2:	38 c1                	cmp    %al,%cl
1f94     1fa4:	0f 8c 8d eb ff ff    	jl     b37 <leaf_cut_from_buffer+0xb27>
1f9a     1faa:	be 04 00 00 00       	mov    $0x4,%esi
1f9f     1faf:	48 89 fb             	mov    %rdi,%rbx
1fa2     1fb2:	48 89 ef             	mov    %rbp,%rdi
1fa5     1fb5:	e8 00 00 00 00       	call   1fba <leaf_cut_from_buffer+0x1faa>	1fb6: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1faa     1fba:	48 89 df             	mov    %rbx,%rdi
1fad     1fbd:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1fb2     1fc2:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
1fb7     1fc7:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1fbc     1fcc:	4c 8b 14 24          	mov    (%rsp),%r10
1fc0     1fd0:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
1fca     1fda:	e9 58 eb ff ff       	jmp    b37 <leaf_cut_from_buffer+0xb27>
1fcf     1fdf:	89 f9                	mov    %edi,%ecx
1fd1     1fe1:	80 e1 07             	and    $0x7,%cl
1fd4     1fe4:	38 c1                	cmp    %al,%cl
1fd6     1fe6:	0f 8c 5e eb ff ff    	jl     b4a <leaf_cut_from_buffer+0xb3a>
1fdc     1fec:	be 04 00 00 00       	mov    $0x4,%esi
1fe1     1ff1:	48 89 fb             	mov    %rdi,%rbx
1fe4     1ff4:	e8 00 00 00 00       	call   1ff9 <leaf_cut_from_buffer+0x1fe9>	1ff5: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
1fe9     1ff9:	48 89 df             	mov    %rbx,%rdi
1fec     1ffc:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
1ff1     2001:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
1ff6     2006:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
1ffb     200b:	4c 8b 14 24          	mov    (%rsp),%r10
1fff     200f:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2009     2019:	e9 2c eb ff ff       	jmp    b4a <leaf_cut_from_buffer+0xb3a>
200e     201e:	44 89 f1             	mov    %r14d,%ecx
2011     2021:	80 e1 07             	and    $0x7,%cl
2014     2024:	38 c1                	cmp    %al,%cl
2016     2026:	0f 8c 25 ec ff ff    	jl     c51 <leaf_cut_from_buffer+0xc41>
201c     202c:	be 04 00 00 00       	mov    $0x4,%esi
2021     2031:	4c 89 f7             	mov    %r14,%rdi
2024     2034:	e8 00 00 00 00       	call   2039 <leaf_cut_from_buffer+0x2029>	2035: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
2029     2039:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
202e     203e:	4c 8b 14 24          	mov    (%rsp),%r10
2032     2042:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
203c     204c:	e9 00 ec ff ff       	jmp    c51 <leaf_cut_from_buffer+0xc41>
2041     2051:	44 89 f9             	mov    %r15d,%ecx
2044     2054:	80 e1 07             	and    $0x7,%cl
2047     2057:	38 c1                	cmp    %al,%cl
2049     2059:	0f 8c 04 ec ff ff    	jl     c63 <leaf_cut_from_buffer+0xc53>
204f     205f:	be 04 00 00 00       	mov    $0x4,%esi
2054     2064:	4c 89 ff             	mov    %r15,%rdi
2057     2067:	e8 00 00 00 00       	call   206c <leaf_cut_from_buffer+0x205c>	2068: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
205c     206c:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
2061     2071:	4c 8b 14 24          	mov    (%rsp),%r10
2065     2075:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
206f     207f:	e9 df eb ff ff       	jmp    c63 <leaf_cut_from_buffer+0xc53>
2074     2084:	49 89 cf             	mov    %rcx,%r15
2077     2087:	44 89 c9             	mov    %r9d,%ecx
207a     208a:	80 e1 07             	and    $0x7,%cl
207d     208d:	38 c1                	cmp    %al,%cl
207f     208f:	4c 89 f9             	mov    %r15,%rcx
2082     2092:	0f 8c 51 e8 ff ff    	jl     8e9 <leaf_cut_from_buffer+0x8d9>
2088     2098:	be 08 00 00 00       	mov    $0x8,%esi
208d     209d:	4d 89 ce             	mov    %r9,%r14
2090     20a0:	4c 89 cf             	mov    %r9,%rdi
2093     20a3:	e8 00 00 00 00       	call   20a8 <leaf_cut_from_buffer+0x2098>	20a4: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
2098     20a8:	4c 89 f9             	mov    %r15,%rcx
209b     20ab:	4d 89 f1             	mov    %r14,%r9
209e     20ae:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
20a3     20b3:	4c 8b 14 24          	mov    (%rsp),%r10
20a7     20b7:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
20b1     20c1:	e9 23 e8 ff ff       	jmp    8e9 <leaf_cut_from_buffer+0x8d9>
20b6     20c6:	48 89 cf             	mov    %rcx,%rdi
20b9     20c9:	80 e1 07             	and    $0x7,%cl
20bc     20cc:	38 c1                	cmp    %al,%cl
20be     20ce:	0f 8c 23 e8 ff ff    	jl     8f7 <leaf_cut_from_buffer+0x8e7>
20c4     20d4:	be 08 00 00 00       	mov    $0x8,%esi
20c9     20d9:	4c 89 cb             	mov    %r9,%rbx
20cc     20dc:	e8 00 00 00 00       	call   20e1 <leaf_cut_from_buffer+0x20d1>	20dd: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
20d1     20e1:	49 89 d9             	mov    %rbx,%r9
20d4     20e4:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
20d9     20e9:	4c 8b 14 24          	mov    (%rsp),%r10
20dd     20ed:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
20e7     20f7:	e9 fb e7 ff ff       	jmp    8f7 <leaf_cut_from_buffer+0x8e7>
20ec     20fc:	49 89 cd             	mov    %rcx,%r13
20ef     20ff:	44 89 c9             	mov    %r9d,%ecx
20f2     2102:	80 e1 07             	and    $0x7,%cl
20f5     2105:	38 c1                	cmp    %al,%cl
20f7     2107:	4c 89 e9             	mov    %r13,%rcx
20fa     210a:	0f 8c 54 f0 ff ff    	jl     1164 <leaf_cut_from_buffer+0x1154>
2100     2110:	be 08 00 00 00       	mov    $0x8,%esi
2105     2115:	4d 89 cc             	mov    %r9,%r12
2108     2118:	4c 89 cf             	mov    %r9,%rdi
210b     211b:	44 89 dd             	mov    %r11d,%ebp
210e     211e:	e8 00 00 00 00       	call   2123 <leaf_cut_from_buffer+0x2113>	211f: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
2113     2123:	4c 89 e9             	mov    %r13,%rcx
2116     2126:	41 89 eb             	mov    %ebp,%r11d
2119     2129:	4d 89 e1             	mov    %r12,%r9
211c     212c:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
2121     2131:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
2126     2136:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
212b     213b:	4c 8b 14 24          	mov    (%rsp),%r10
212f     213f:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2139     2149:	e9 16 f0 ff ff       	jmp    1164 <leaf_cut_from_buffer+0x1154>
213e     214e:	48 89 cb             	mov    %rcx,%rbx
2141     2151:	80 e1 07             	and    $0x7,%cl
2144     2154:	38 c1                	cmp    %al,%cl
2146     2156:	0f 8c 20 f0 ff ff    	jl     117c <leaf_cut_from_buffer+0x116c>
214c     215c:	48 89 d8             	mov    %rbx,%rax
214f     215f:	be 08 00 00 00       	mov    $0x8,%esi
2154     2164:	4c 89 cb             	mov    %r9,%rbx
2157     2167:	48 89 c7             	mov    %rax,%rdi
215a     216a:	45 89 de             	mov    %r11d,%r14d
215d     216d:	e8 00 00 00 00       	call   2172 <leaf_cut_from_buffer+0x2162>	216e: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
2162     2172:	45 89 f3             	mov    %r14d,%r11d
2165     2175:	49 89 d9             	mov    %rbx,%r9
2168     2178:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
216d     217d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
2172     2182:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
2177     2187:	4c 8b 14 24          	mov    (%rsp),%r10
217b     218b:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2185     2195:	e9 e2 ef ff ff       	jmp    117c <leaf_cut_from_buffer+0x116c>
218a     219a:	48 8b 4c 24 48       	mov    0x48(%rsp),%rcx
218f     219f:	80 e1 07             	and    $0x7,%cl
2192     21a2:	38 c1                	cmp    %al,%cl
2194     21a4:	0f 8c e5 ef ff ff    	jl     118f <leaf_cut_from_buffer+0x117f>
219a     21aa:	be 02 00 00 00       	mov    $0x2,%esi
219f     21af:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
21a4     21b4:	44 89 db             	mov    %r11d,%ebx
21a7     21b7:	e8 00 00 00 00       	call   21bc <leaf_cut_from_buffer+0x21ac>	21b8: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
21ac     21bc:	41 89 db             	mov    %ebx,%r11d
21af     21bf:	48 8b 54 24 18       	mov    0x18(%rsp),%rdx
21b4     21c4:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
21b9     21c9:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
21be     21ce:	4c 8b 14 24          	mov    (%rsp),%r10
21c2     21d2:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
21cc     21dc:	e9 ae ef ff ff       	jmp    118f <leaf_cut_from_buffer+0x117f>
21d1     21e1:	48 8b 4c 24 40       	mov    0x40(%rsp),%rcx
21d6     21e6:	80 e1 07             	and    $0x7,%cl
21d9     21e9:	38 c1                	cmp    %al,%cl
21db     21eb:	0f 8c b1 ef ff ff    	jl     11a2 <leaf_cut_from_buffer+0x1192>
21e1     21f1:	be 02 00 00 00       	mov    $0x2,%esi
21e6     21f6:	48 8b 7c 24 40       	mov    0x40(%rsp),%rdi
21eb     21fb:	44 89 db             	mov    %r11d,%ebx
21ee     21fe:	e8 00 00 00 00       	call   2203 <leaf_cut_from_buffer+0x21f3>	21ff: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
21f3     2203:	41 89 db             	mov    %ebx,%r11d
21f6     2206:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
21fb     220b:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
2200     2210:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
2205     2215:	4c 8b 14 24          	mov    (%rsp),%r10
2209     2219:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2213     2223:	e9 7a ef ff ff       	jmp    11a2 <leaf_cut_from_buffer+0x1192>
2218     2228:	44 89 f1             	mov    %r14d,%ecx
221b     222b:	80 e1 07             	and    $0x7,%cl
221e     222e:	38 c1                	cmp    %al,%cl
2220     2230:	0f 8c ac ef ff ff    	jl     11e2 <leaf_cut_from_buffer+0x11d2>
2226     2236:	be 02 00 00 00       	mov    $0x2,%esi
222b     223b:	4c 89 f7             	mov    %r14,%rdi
222e     223e:	e8 00 00 00 00       	call   2243 <leaf_cut_from_buffer+0x2233>	223f: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
2233     2243:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
2238     2248:	4c 8b 14 24          	mov    (%rsp),%r10
223c     224c:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2246     2256:	e9 87 ef ff ff       	jmp    11e2 <leaf_cut_from_buffer+0x11d2>
224b     225b:	44 89 f9             	mov    %r15d,%ecx
224e     225e:	80 e1 07             	and    $0x7,%cl
2251     2261:	38 c1                	cmp    %al,%cl
2253     2263:	0f 8c 8b ef ff ff    	jl     11f4 <leaf_cut_from_buffer+0x11e4>
2259     2269:	be 02 00 00 00       	mov    $0x2,%esi
225e     226e:	4c 89 ff             	mov    %r15,%rdi
2261     2271:	e8 00 00 00 00       	call   2276 <leaf_cut_from_buffer+0x2266>	2272: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
2266     2276:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
226b     227b:	4c 8b 14 24          	mov    (%rsp),%r10
226f     227f:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2279     2289:	e9 66 ef ff ff       	jmp    11f4 <leaf_cut_from_buffer+0x11e4>
227e     228e:	31 ff                	xor    %edi,%edi
2280     2290:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	2293: R_X86_64_32S	.rodata..str+0x88a0
2287     2297:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	229a: R_X86_64_32S	.rodata.str1.1+0x2ce04
228e     229e:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx	22a1: R_X86_64_32S	.rodata..str.95+0x860
2295     22a5:	41 b8 41 04 00 00    	mov    $0x441,%r8d
229b     22ab:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9	22ae: R_X86_64_32S	.rodata.str1.1+0x2ce04
22a2     22b2:	50                   	push   %rax
22a3     22b3:	41 54                	push   %r12
22a5     22b5:	55                   	push   %rbp
22a6     22b6:	e8 00 00 00 00       	call   22bb <leaf_cut_from_buffer+0x22ab>	22b7: R_X86_64_PLT32	__reiserfs_panic-0x4
22ab     22bb:	89 e9                	mov    %ebp,%ecx
22ad     22bd:	80 e1 07             	and    $0x7,%cl
22b0     22c0:	38 c1                	cmp    %al,%cl
22b2     22c2:	0f 8c f2 e8 ff ff    	jl     bba <leaf_cut_from_buffer+0xbaa>
22b8     22c8:	be 04 00 00 00       	mov    $0x4,%esi
22bd     22cd:	49 89 fe             	mov    %rdi,%r14
22c0     22d0:	48 89 ef             	mov    %rbp,%rdi
22c3     22d3:	e8 00 00 00 00       	call   22d8 <leaf_cut_from_buffer+0x22c8>	22d4: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
22c8     22d8:	4c 89 f7             	mov    %r14,%rdi
22cb     22db:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
22d0     22e0:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
22d5     22e5:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
22da     22ea:	4c 8b 14 24          	mov    (%rsp),%r10
22de     22ee:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
22e8     22f8:	e9 bd e8 ff ff       	jmp    bba <leaf_cut_from_buffer+0xbaa>
22ed     22fd:	89 f9                	mov    %edi,%ecx
22ef     22ff:	80 e1 07             	and    $0x7,%cl
22f2     2302:	38 c1                	cmp    %al,%cl
22f4     2304:	0f 8c c4 e8 ff ff    	jl     bce <leaf_cut_from_buffer+0xbbe>
22fa     230a:	be 04 00 00 00       	mov    $0x4,%esi
22ff     230f:	e8 00 00 00 00       	call   2314 <leaf_cut_from_buffer+0x2304>	2310: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
2304     2314:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
2309     2319:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
230e     231e:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
2313     2323:	4c 8b 14 24          	mov    (%rsp),%r10
2317     2327:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2321     2331:	e9 98 e8 ff ff       	jmp    bce <leaf_cut_from_buffer+0xbbe>
2326     2336:	48 8b 4c 24 48       	mov    0x48(%rsp),%rcx
232b     233b:	80 e1 07             	and    $0x7,%cl
232e     233e:	38 c1                	cmp    %al,%cl
2330     2340:	0f 8c 9b e8 ff ff    	jl     be1 <leaf_cut_from_buffer+0xbd1>
2336     2346:	be 02 00 00 00       	mov    $0x2,%esi
233b     234b:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
2340     2350:	e8 00 00 00 00       	call   2355 <leaf_cut_from_buffer+0x2345>	2351: R_X86_64_PLT32	__asan_report_load_n_noabort-0x4
2345     2355:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
234a     235a:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
234f     235f:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
2354     2364:	4c 8b 14 24          	mov    (%rsp),%r10
2358     2368:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
2362     2372:	e9 6a e8 ff ff       	jmp    be1 <leaf_cut_from_buffer+0xbd1>
2367     2377:	4d 63 d4             	movslq %r12d,%r10
236a     237a:	4c 63 5c 24 30       	movslq 0x30(%rsp),%r11
236f     237f:	31 ff                	xor    %edi,%edi
2371     2381:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	2384: R_X86_64_32S	.rodata..str+0x88a0
2378     2388:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	238b: R_X86_64_32S	.rodata.str1.1+0x767b
237f     238f:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx	2392: R_X86_64_32S	.rodata..str.35+0x1a00
2386     2396:	41 b8 9a 04 00 00    	mov    $0x49a,%r8d
238c     239c:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9	239f: R_X86_64_32S	.rodata.str1.1+0x767b
2393     23a3:	50                   	push   %rax
2394     23a4:	41 53                	push   %r11
2396     23a6:	41 52                	push   %r10
2398     23a8:	e8 00 00 00 00       	call   23ad <leaf_cut_from_buffer+0x239d>	23a9: R_X86_64_PLT32	__reiserfs_panic-0x4
239d     23ad:	89 e9                	mov    %ebp,%ecx
239f     23af:	80 e1 07             	and    $0x7,%cl
23a2     23b2:	38 c1                	cmp    %al,%cl
23a4     23b4:	0f 8c 7a ee ff ff    	jl     1234 <leaf_cut_from_buffer+0x1224>
23aa     23ba:	be 04 00 00 00       	mov    $0x4,%esi
23af     23bf:	49 89 fe             	mov    %rdi,%r14
23b2     23c2:	48 89 ef             	mov    %rbp,%rdi
23b5     23c5:	e8 00 00 00 00       	call   23ca <leaf_cut_from_buffer+0x23ba>	23c6: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
23ba     23ca:	4c 89 f7             	mov    %r14,%rdi
23bd     23cd:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
23c2     23d2:	4c 8b 14 24          	mov    (%rsp),%r10
23c6     23d6:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
23d0     23e0:	e9 4f ee ff ff       	jmp    1234 <leaf_cut_from_buffer+0x1224>
23d5     23e5:	89 f9                	mov    %edi,%ecx
23d7     23e7:	80 e1 07             	and    $0x7,%cl
23da     23ea:	38 c1                	cmp    %al,%cl
23dc     23ec:	0f 8c 57 ee ff ff    	jl     1249 <leaf_cut_from_buffer+0x1239>
23e2     23f2:	be 04 00 00 00       	mov    $0x4,%esi
23e7     23f7:	e8 00 00 00 00       	call   23fc <leaf_cut_from_buffer+0x23ec>	23f8: R_X86_64_PLT32	__asan_report_store_n_noabort-0x4
23ec     23fc:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
23f1     2401:	4c 8b 14 24          	mov    (%rsp),%r10
23f5     2405:	48 be 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rsi
23ff     240f:	e9 35 ee ff ff       	jmp    1249 <leaf_cut_from_buffer+0x1239>
2404     2414:	31 ff                	xor    %edi,%edi
2406     2416:	48 c7 c6 00 00 00 00 	mov    $0x0,%rsi	2419: R_X86_64_32S	.rodata..str+0x88a0
240d     241d:	48 c7 c2 00 00 00 00 	mov    $0x0,%rdx	2420: R_X86_64_32S	.rodata.str1.1+0x767b
2414     2424:	48 c7 c1 00 00 00 00 	mov    $0x0,%rcx	2427: R_X86_64_32S	.rodata..str.33+0x1c20
241b     242b:	41 b8 90 04 00 00    	mov    $0x490,%r8d
2421     2431:	49 c7 c1 00 00 00 00 	mov    $0x0,%r9	2434: R_X86_64_32S	.rodata.str1.1+0x767b
2428     2438:	41 54                	push   %r12
242a     243a:	e8 00 00 00 00       	call   243f <__SCT__tp_func_xfs_fs_unfixed_corruption+0x7>	243b: R_X86_64_PLT32	__reiserfs_panic-0x4

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

