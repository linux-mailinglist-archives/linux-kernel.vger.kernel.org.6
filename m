Return-Path: <linux-kernel+bounces-214526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BAE9085F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50971F23DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F027218413E;
	Fri, 14 Jun 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3v5cUsZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46E14D29B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352954; cv=none; b=tume/oKGZf4rlnOb5vns/WhS8z65vI10veKb2iIhKJ7MThNOzO3xSS+W6xh+DRqDuWUwTjVimSAzsYyTD/g2Z/g5Jlkd7Nr2LAkSlwuJvdzP+VNiZCJz8fzi+uyjdAOlpDkgGyu8olumT6xXoVXKfNuj13KlvhBA8FzvUqQyc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352954; c=relaxed/simple;
	bh=JTg212cyLBxaCs/2EKMc+U1OdhQhoEbf6RlCrTdH/7k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jx2M4A4LAgJFzHbZHKTciq+YMijdtQsIuHFpOEdRctXxxMElgSInsR2bV+djmdvjvrlk5rNCiPkBXZv5S8BGUB4XI7ocZwFPyC35zJanHPSDL92MBRqrMmRkMQqW4zbzporkC1KlOsJ06uqwt4D9UgzEimwpO7fetW9ImiJpxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3v5cUsZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718352949; x=1749888949;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JTg212cyLBxaCs/2EKMc+U1OdhQhoEbf6RlCrTdH/7k=;
  b=A3v5cUsZri+dzviyQTyUE1wfe1t0yxYvQ5vVZNyUyQZkjUs6LgalwsNM
   LQVgIQIocy4XhrneRADg7Vb6aFxPY4JdDLoeEYCJdBewzSaO1ZdeoBEBL
   mzi2lss6BG8MGB5FZHyER3JwCA/dBKGgrJtlTVcAu14/bje3tHy4ER/QC
   916ij8tC1j2xWKSab/wwpu5GfBz0P0FliEcxRrKfB9MGerWejFxXEZXwI
   p/EIsAvomP9+n6IyaEZvkas83A984YBTdgBMpDn5ZWEJOZQEi3DzVt6+b
   ezBveRHGdhjmlpIJAx7GfvNteVaGtU48VGDdrElSik0MfMd4owoE+oFIk
   w==;
X-CSE-ConnectionGUID: I8xtGh0dRyO3Ac4Wu7+A4A==
X-CSE-MsgGUID: nGIJpUfMSd2BpJHXEfXlzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15010641"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15010641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 01:15:47 -0700
X-CSE-ConnectionGUID: siLlnFM7RSeEtCizvDNJqA==
X-CSE-MsgGUID: Tw4jUV84SPO/hE/hDs2gxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40316907"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 14 Jun 2024 01:15:45 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sI263-00011A-17;
	Fri, 14 Jun 2024 08:15:43 +0000
Date: Fri, 14 Jun 2024 16:15:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:x86/alternatives 14/14] arch/x86/kvm/kvm.o: warning: objtool:
 .altinstr_replacement+0xc5: call without frame pointer save/setup
Message-ID: <202406141648.jO9qNGLa-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/alternatives
head:   f776e41fdcc4141876ef6f297318ab04c2382eb7
commit: f776e41fdcc4141876ef6f297318ab04c2382eb7 [14/14] x86/alternative: Replace the old macros
config: x86_64-buildonly-randconfig-r001-20211209 (https://download.01.org/0day-ci/archive/20240614/202406141648.jO9qNGLa-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406141648.jO9qNGLa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406141648.jO9qNGLa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/kvm.o: warning: objtool: .altinstr_replacement+0xc5: call without frame pointer save/setup


objdump-func vmlinux.o .altinstr_replacement:
0000 0000000000000000 <.altinstr_replacement>:
0000        0:	48 0f ba ec 3f       	bts    $0x3f,%rsp
0005        5:	e8 00 00 00 00       	call   a <.altinstr_replacement+0xa>	6: R_X86_64_PLT32	entry_ibpb-0x4
000a        a:	e8 00 00 00 00       	call   f <.altinstr_replacement+0xf>	b: R_X86_64_PLT32	clear_bhb_loop-0x4
000f        f:	e9 00 00 00 00       	jmp    14 <.altinstr_replacement+0x14>	10: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
0014       14:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 1b <.altinstr_replacement+0x1b>	17: R_X86_64_PC32	mds_verw_sel-0x4
001b       1b:	49 c7 c4 10 00 00 00 	mov    $0x10,%r12
0022       22:	e8 01 00 00 00       	call   28 <.altinstr_replacement+0x28>
0027       27:	cc                   	int3
0028       28:	e8 01 00 00 00       	call   2e <.altinstr_replacement+0x2e>
002d       2d:	cc                   	int3
002e       2e:	48 83 c4 10          	add    $0x10,%rsp
0032       32:	49 ff cc             	dec    %r12
0035       35:	75 eb                	jne    22 <.altinstr_replacement+0x22>
0037       37:	0f ae e8             	lfence
003a       3a:	90                   	nop
003b       3b:	90                   	nop
003c       3c:	e8 01 00 00 00       	call   42 <.altinstr_replacement+0x42>
0041       41:	cc                   	int3
0042       42:	48 83 c4 08          	add    $0x8,%rsp
0046       46:	0f ae e8             	lfence
0049       49:	e8 00 00 00 00       	call   4e <.altinstr_replacement+0x4e>	4a: R_X86_64_PLT32	entry_ibpb-0x4
004e       4e:	0f 01 ca             	clac
0051       51:	e8 00 00 00 00       	call   56 <.altinstr_replacement+0x56>	52: R_X86_64_PLT32	xen_error_entry-0x4
0056       56:	0f 01 ca             	clac
0059       59:	e8 00 00 00 00       	call   5e <.altinstr_replacement+0x5e>	5a: R_X86_64_PLT32	xen_error_entry-0x4
005e       5e:	0f 01 ca             	clac
0061       61:	e8 00 00 00 00       	call   66 <.altinstr_replacement+0x66>	62: R_X86_64_PLT32	xen_error_entry-0x4
0066       66:	0f 01 ca             	clac
0069       69:	e8 00 00 00 00       	call   6e <.altinstr_replacement+0x6e>	6a: R_X86_64_PLT32	xen_error_entry-0x4
006e       6e:	0f 01 ca             	clac
0071       71:	e8 00 00 00 00       	call   76 <.altinstr_replacement+0x76>	72: R_X86_64_PLT32	xen_error_entry-0x4
0076       76:	0f 01 ca             	clac
0079       79:	e8 00 00 00 00       	call   7e <.altinstr_replacement+0x7e>	7a: R_X86_64_PLT32	xen_error_entry-0x4
007e       7e:	0f 01 ca             	clac
0081       81:	e8 00 00 00 00       	call   86 <.altinstr_replacement+0x86>	82: R_X86_64_PLT32	xen_error_entry-0x4
0086       86:	0f 01 ca             	clac
0089       89:	e8 00 00 00 00       	call   8e <.altinstr_replacement+0x8e>	8a: R_X86_64_PLT32	xen_error_entry-0x4
008e       8e:	0f 01 ca             	clac
0091       91:	e8 00 00 00 00       	call   96 <.altinstr_replacement+0x96>	92: R_X86_64_PLT32	xen_error_entry-0x4
0096       96:	0f 01 ca             	clac
0099       99:	e8 00 00 00 00       	call   9e <.altinstr_replacement+0x9e>	9a: R_X86_64_PLT32	xen_error_entry-0x4
009e       9e:	0f 01 ca             	clac
00a1       a1:	e8 00 00 00 00       	call   a6 <.altinstr_replacement+0xa6>	a2: R_X86_64_PLT32	xen_error_entry-0x4
00a6       a6:	0f 01 ca             	clac
00a9       a9:	e8 00 00 00 00       	call   ae <.altinstr_replacement+0xae>	aa: R_X86_64_PLT32	xen_error_entry-0x4
00ae       ae:	0f 01 ca             	clac
00b1       b1:	e8 00 00 00 00       	call   b6 <.altinstr_replacement+0xb6>	b2: R_X86_64_PLT32	xen_error_entry-0x4
00b6       b6:	0f 01 ca             	clac
00b9       b9:	e8 00 00 00 00       	call   be <.altinstr_replacement+0xbe>	ba: R_X86_64_PLT32	xen_error_entry-0x4
00be       be:	0f 01 ca             	clac
00c1       c1:	e8 00 00 00 00       	call   c6 <.altinstr_replacement+0xc6>	c2: R_X86_64_PLT32	xen_error_entry-0x4
00c6       c6:	0f 01 ca             	clac
00c9       c9:	e8 00 00 00 00       	call   ce <.altinstr_replacement+0xce>	ca: R_X86_64_PLT32	xen_error_entry-0x4
00ce       ce:	0f 01 ca             	clac
00d1       d1:	e8 00 00 00 00       	call   d6 <.altinstr_replacement+0xd6>	d2: R_X86_64_PLT32	xen_error_entry-0x4
00d6       d6:	0f 01 ca             	clac
00d9       d9:	e8 00 00 00 00       	call   de <.altinstr_replacement+0xde>	da: R_X86_64_PLT32	xen_error_entry-0x4
00de       de:	0f 01 ca             	clac
00e1       e1:	0f 01 ca             	clac
00e4       e4:	e8 00 00 00 00       	call   e9 <.altinstr_replacement+0xe9>	e5: R_X86_64_PLT32	xen_error_entry-0x4
00e9       e9:	0f 01 ca             	clac
00ec       ec:	e8 00 00 00 00       	call   f1 <.altinstr_replacement+0xf1>	ed: R_X86_64_PLT32	xen_error_entry-0x4
00f1       f1:	0f 01 ca             	clac
00f4       f4:	e8 00 00 00 00       	call   f9 <.altinstr_replacement+0xf9>	f5: R_X86_64_PLT32	xen_error_entry-0x4
00f9       f9:	0f 01 ca             	clac
00fc       fc:	e8 00 00 00 00       	call   101 <.altinstr_replacement+0x101>	fd: R_X86_64_PLT32	xen_error_entry-0x4
0101      101:	0f 01 ca             	clac
0104      104:	e8 00 00 00 00       	call   109 <.altinstr_replacement+0x109>	105: R_X86_64_PLT32	xen_error_entry-0x4
0109      109:	0f 01 ca             	clac
010c      10c:	e8 00 00 00 00       	call   111 <.altinstr_replacement+0x111>	10d: R_X86_64_PLT32	xen_error_entry-0x4
0111      111:	0f 01 ca             	clac
0114      114:	e8 00 00 00 00       	call   119 <.altinstr_replacement+0x119>	115: R_X86_64_PLT32	xen_error_entry-0x4
0119      119:	0f 01 ca             	clac
011c      11c:	e8 00 00 00 00       	call   121 <.altinstr_replacement+0x121>	11d: R_X86_64_PLT32	xen_error_entry-0x4
0121      121:	0f 01 ca             	clac
0124      124:	e8 00 00 00 00       	call   129 <.altinstr_replacement+0x129>	125: R_X86_64_PLT32	xen_error_entry-0x4
0129      129:	0f 01 ca             	clac
012c      12c:	e8 00 00 00 00       	call   131 <.altinstr_replacement+0x131>	12d: R_X86_64_PLT32	xen_error_entry-0x4
0131      131:	0f 01 ca             	clac
0134      134:	e8 00 00 00 00       	call   139 <.altinstr_replacement+0x139>	135: R_X86_64_PLT32	xen_error_entry-0x4
0139      139:	e9 00 00 00 00       	jmp    13e <.altinstr_replacement+0x13e>	13a: R_X86_64_PC32	.entry.text+0x15e3
013e      13e:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 145 <.altinstr_replacement+0x145>	141: R_X86_64_PC32	mds_verw_sel-0x4
0145      145:	48 0f ba ef 3f       	bts    $0x3f,%rdi
014a      14a:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 151 <.altinstr_replacement+0x151>	14d: R_X86_64_PC32	mds_verw_sel-0x4
0151      151:	0f ae f0             	mfence
0154      154:	b8 2b 00 00 00       	mov    $0x2b,%eax
0159      159:	8e e8                	mov    %eax,%gs
015b      15b:	48 0f ba e8 3f       	bts    $0x3f,%rax
0160      160:	0f ae e8             	lfence
0163      163:	e8 00 00 00 00       	call   168 <.altinstr_replacement+0x168>	164: R_X86_64_PLT32	entry_ibpb-0x4
0168      168:	0f ae e8             	lfence
016b      16b:	48 0f ba e8 3f       	bts    $0x3f,%rax
0170      170:	e8 00 00 00 00       	call   175 <.altinstr_replacement+0x175>	171: R_X86_64_PLT32	entry_ibpb-0x4
0175      175:	0f ae e8             	lfence
0178      178:	0f ae e8             	lfence
017b      17b:	48 0f ba e8 3f       	bts    $0x3f,%rax
0180      180:	e8 00 00 00 00       	call   185 <.altinstr_replacement+0x185>	181: R_X86_64_PLT32	entry_ibpb-0x4
0185      185:	0f 01 ca             	clac
0188      188:	0f ae e8             	lfence
018b      18b:	48 0f ba ea 3f       	bts    $0x3f,%rdx
0190      190:	e8 00 00 00 00       	call   195 <.altinstr_replacement+0x195>	191: R_X86_64_PLT32	entry_ibpb-0x4
0195      195:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 19c <.altinstr_replacement+0x19c>	198: R_X86_64_PC32	mds_verw_sel-0x4
019c      19c:	48 b9 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rcx
01a6      1a6:	e9 00 00 00 00       	jmp    1ab <.altinstr_replacement+0x1ab>	1a7: R_X86_64_PC32	.init.text+0x31c5
01ab      1ab:	e9 00 00 00 00       	jmp    1b0 <.altinstr_replacement+0x1b0>	1ac: R_X86_64_PC32	.init.text+0x31f6
01b0      1b0:	e9 00 00 00 00       	jmp    1b5 <.altinstr_replacement+0x1b5>	1b1: R_X86_64_PC32	.init.text+0x3267
01b5      1b5:	e9 00 00 00 00       	jmp    1ba <.altinstr_replacement+0x1ba>	1b6: R_X86_64_PC32	.init.text+0x3202
01ba      1ba:	e9 00 00 00 00       	jmp    1bf <.altinstr_replacement+0x1bf>	1bb: R_X86_64_PC32	.text+0x3959
01bf      1bf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
01c4      1c4:	0f ae e8             	lfence
01c7      1c7:	0f 31                	rdtsc
01c9      1c9:	0f 01 f9             	rdtscp
01cc      1cc:	0f ae e8             	lfence
01cf      1cf:	0f 31                	rdtsc
01d1      1d1:	0f 01 f9             	rdtscp
01d4      1d4:	0f ae e8             	lfence
01d7      1d7:	0f 31                	rdtsc
01d9      1d9:	0f 01 f9             	rdtscp
01dc      1dc:	e8 00 00 00 00       	call   1e1 <.altinstr_replacement+0x1e1>	1dd: R_X86_64_PLT32	clear_page_rep-0x4
01e1      1e1:	e8 00 00 00 00       	call   1e6 <.altinstr_replacement+0x1e6>	1e2: R_X86_64_PLT32	clear_page_erms-0x4
01e6      1e6:	e9 00 00 00 00       	jmp    1eb <.altinstr_replacement+0x1eb>	1e7: R_X86_64_PC32	.text+0x8a3b
01eb      1eb:	e9 00 00 00 00       	jmp    1f0 <.altinstr_replacement+0x1f0>	1ec: R_X86_64_PC32	.text+0x8a9a
01f0      1f0:	e9 00 00 00 00       	jmp    1f5 <.altinstr_replacement+0x1f5>	1f1: R_X86_64_PC32	.text+0x8b02
01f5      1f5:	e9 00 00 00 00       	jmp    1fa <.altinstr_replacement+0x1fa>	1f6: R_X86_64_PC32	.text+0x8aeb
01fa      1fa:	e9 00 00 00 00       	jmp    1ff <.altinstr_replacement+0x1ff>	1fb: R_X86_64_PC32	.text+0x8fd9
01ff      1ff:	e9 00 00 00 00       	jmp    204 <.altinstr_replacement+0x204>	200: R_X86_64_PC32	.text+0x8f9b
0204      204:	e9 00 00 00 00       	jmp    209 <.altinstr_replacement+0x209>	205: R_X86_64_PC32	.text+0x8f89
0209      209:	e9 00 00 00 00       	jmp    20e <.altinstr_replacement+0x20e>	20a: R_X86_64_PC32	.text+0x90b8
020e      20e:	e9 00 00 00 00       	jmp    213 <.altinstr_replacement+0x213>	20f: R_X86_64_PC32	.text+0x90cd
0213      213:	e9 00 00 00 00       	jmp    218 <.altinstr_replacement+0x218>	214: R_X86_64_PC32	.text+0x9167
0218      218:	e9 00 00 00 00       	jmp    21d <.altinstr_replacement+0x21d>	219: R_X86_64_PC32	.text+0x90e3
021d      21d:	e9 00 00 00 00       	jmp    222 <.altinstr_replacement+0x222>	21e: R_X86_64_PC32	.text+0x9147
0222      222:	e9 00 00 00 00       	jmp    227 <.altinstr_replacement+0x227>	223: R_X86_64_PC32	.text+0x90e3
0227      227:	e9 00 00 00 00       	jmp    22c <.altinstr_replacement+0x22c>	228: R_X86_64_PC32	.text+0x9192
022c      22c:	e9 00 00 00 00       	jmp    231 <.altinstr_replacement+0x231>	22d: R_X86_64_PC32	.text+0x90e3
0231      231:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
023b      23b:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0245      245:	e9 00 00 00 00       	jmp    24a <.altinstr_replacement+0x24a>	246: R_X86_64_PC32	.text+0x939b
024a      24a:	0f 01 cb             	stac
024d      24d:	0f ae e8             	lfence
0250      250:	0f 01 ca             	clac
0253      253:	0f 01 ca             	clac
0256      256:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0260      260:	e9 00 00 00 00       	jmp    265 <.altinstr_replacement+0x265>	261: R_X86_64_PC32	.text+0x9e59
0265      265:	e9 00 00 00 00       	jmp    26a <.altinstr_replacement+0x26a>	266: R_X86_64_PC32	.text+0x9e9a
026a      26a:	e9 00 00 00 00       	jmp    26f <.altinstr_replacement+0x26f>	26b: R_X86_64_PC32	.noinstr.text+0x1b4
026f      26f:	e9 00 00 00 00       	jmp    274 <.altinstr_replacement+0x274>	270: R_X86_64_PC32	.text+0xa1d9
0274      274:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
027e      27e:	e9 00 00 00 00       	jmp    283 <.altinstr_replacement+0x283>	27f: R_X86_64_PC32	.noinstr.text+0x8df
0283      283:	e9 00 00 00 00       	jmp    288 <.altinstr_replacement+0x288>	284: R_X86_64_PC32	.init.text+0x4f9e
0288      288:	e9 00 00 00 00       	jmp    28d <.altinstr_replacement+0x28d>	289: R_X86_64_PC32	.noinstr.text+0x1444
028d      28d:	e9 00 00 00 00       	jmp    292 <.altinstr_replacement+0x292>	28e: R_X86_64_PC32	.text+0xb876
0292      292:	0f 01 cb             	stac
0295      295:	e8 00 00 00 00       	call   29a <.altinstr_replacement+0x29a>	296: R_X86_64_PLT32	rep_stos_alternative-0x4
029a      29a:	0f 01 ca             	clac
029d      29d:	e9 00 00 00 00       	jmp    2a2 <.altinstr_replacement+0x2a2>	29e: R_X86_64_PC32	.text+0xbddf
02a2      2a2:	0f 01 cb             	stac
02a5      2a5:	e8 00 00 00 00       	call   2aa <.altinstr_replacement+0x2aa>	2a6: R_X86_64_PLT32	rep_stos_alternative-0x4
02aa      2aa:	0f 01 ca             	clac
02ad      2ad:	e9 00 00 00 00       	jmp    2b2 <.altinstr_replacement+0x2b2>	2ae: R_X86_64_PC32	.init.text+0x5aba
02b2      2b2:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
02bc      2bc:	48 be 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rsi
02c6      2c6:	e9 00 00 00 00       	jmp    2cb <.altinstr_replacement+0x2cb>	2c7: R_X86_64_PC32	.init.text+0x62de
02cb      2cb:	e9 00 00 00 00       	jmp    2d0 <.altinstr_replacement+0x2d0>	2cc: R_X86_64_PC32	.init.text+0x630e
02d0      2d0:	e9 00 00 00 00       	jmp    2d5 <.altinstr_replacement+0x2d5>	2d1: R_X86_64_PC32	.init.text+0x6365
02d5      2d5:	e9 00 00 00 00       	jmp    2da <.altinstr_replacement+0x2da>	2d6: R_X86_64_PC32	.init.text+0x632f
02da      2da:	e9 00 00 00 00       	jmp    2df <.altinstr_replacement+0x2df>	2db: R_X86_64_PC32	.init.text+0x6e3d
02df      2df:	e9 00 00 00 00       	jmp    2e4 <.altinstr_replacement+0x2e4>	2e0: R_X86_64_PC32	.init.text+0x8b3e
02e4      2e4:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 2eb <.altinstr_replacement+0x2eb>	2e7: R_X86_64_PC32	.init.data+0x4f71c
02eb      2eb:	e8 00 00 00 00       	call   2f0 <.altinstr_replacement+0x2f0>	2ec: R_X86_64_PLT32	__alt_reloc_selftest-0x4
02f0      2f0:	e9 00 00 00 00       	jmp    2f5 <.altinstr_replacement+0x2f5>	2f1: R_X86_64_PC32	.text+0xdf24
02f5      2f5:	e9 00 00 00 00       	jmp    2fa <.altinstr_replacement+0x2fa>	2f6: R_X86_64_PC32	.text+0xdfb1
02fa      2fa:	e9 00 00 00 00       	jmp    2ff <.altinstr_replacement+0x2ff>	2fb: R_X86_64_PC32	.text+0xdf56
02ff      2ff:	e9 00 00 00 00       	jmp    304 <.altinstr_replacement+0x304>	300: R_X86_64_PC32	.text+0xefed
0304      304:	e9 00 00 00 00       	jmp    309 <.altinstr_replacement+0x309>	305: R_X86_64_PC32	.text+0xf097
0309      309:	e9 00 00 00 00       	jmp    30e <.altinstr_replacement+0x30e>	30a: R_X86_64_PC32	.text+0xf653
030e      30e:	e9 00 00 00 00       	jmp    313 <.altinstr_replacement+0x313>	30f: R_X86_64_PC32	.text+0xf761
0313      313:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
031d      31d:	48 be 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rsi
0327      327:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0331      331:	0f ae e8             	lfence
0334      334:	0f 31                	rdtsc
0336      336:	0f 01 f9             	rdtscp
0339      339:	e9 00 00 00 00       	jmp    33e <.altinstr_replacement+0x33e>	33a: R_X86_64_PC32	.init.text+0xa343
033e      33e:	e9 00 00 00 00       	jmp    343 <.altinstr_replacement+0x343>	33f: R_X86_64_PC32	.ref.text+0x584
0343      343:	e9 00 00 00 00       	jmp    348 <.altinstr_replacement+0x348>	344: R_X86_64_PC32	.ref.text+0x5a7
0348      348:	e9 00 00 00 00       	jmp    34d <.altinstr_replacement+0x34d>	349: R_X86_64_PC32	.text+0x11ba7
034d      34d:	e9 00 00 00 00       	jmp    352 <.altinstr_replacement+0x352>	34e: R_X86_64_PC32	.text+0x11bd0
0352      352:	e9 00 00 00 00       	jmp    357 <.altinstr_replacement+0x357>	353: R_X86_64_PC32	.text+0x11be6
0357      357:	e9 00 00 00 00       	jmp    35c <.altinstr_replacement+0x35c>	358: R_X86_64_PC32	.text+0x11b97
035c      35c:	e9 00 00 00 00       	jmp    361 <.altinstr_replacement+0x361>	35d: R_X86_64_PC32	.text+0x11d3b
0361      361:	e9 00 00 00 00       	jmp    366 <.altinstr_replacement+0x366>	362: R_X86_64_PC32	.text+0x11de0
0366      366:	e9 00 00 00 00       	jmp    36b <.altinstr_replacement+0x36b>	367: R_X86_64_PC32	.text+0x11e2f
036b      36b:	e9 00 00 00 00       	jmp    370 <.altinstr_replacement+0x370>	36c: R_X86_64_PC32	.text+0x11e06
0370      370:	e9 00 00 00 00       	jmp    375 <.altinstr_replacement+0x375>	371: R_X86_64_PC32	.text+0x11d2c
0375      375:	e9 00 00 00 00       	jmp    37a <.altinstr_replacement+0x37a>	376: R_X86_64_PC32	.text+0x11e59
037a      37a:	e9 00 00 00 00       	jmp    37f <.altinstr_replacement+0x37f>	37b: R_X86_64_PC32	.text+0x11e75
037f      37f:	e9 00 00 00 00       	jmp    384 <.altinstr_replacement+0x384>	380: R_X86_64_PC32	.text+0x11d2c
0384      384:	48 0f ae 37          	xsaveopt64 (%rdi)
0388      388:	48 0f c7 27          	xsavec64 (%rdi)
038c      38c:	48 0f c7 2f          	xsaves64 (%rdi)
0390      390:	e9 00 00 00 00       	jmp    395 <.altinstr_replacement+0x395>	391: R_X86_64_PC32	.text+0x122a8
0395      395:	e9 00 00 00 00       	jmp    39a <.altinstr_replacement+0x39a>	396: R_X86_64_PC32	.text+0x123d9
039a      39a:	e9 00 00 00 00       	jmp    39f <.altinstr_replacement+0x39f>	39b: R_X86_64_PC32	.text+0x12461
039f      39f:	e9 00 00 00 00       	jmp    3a4 <.altinstr_replacement+0x3a4>	3a0: R_X86_64_PC32	.text+0x125a3
03a4      3a4:	e9 00 00 00 00       	jmp    3a9 <.altinstr_replacement+0x3a9>	3a5: R_X86_64_PC32	.text+0x1265e
03a9      3a9:	e9 00 00 00 00       	jmp    3ae <.altinstr_replacement+0x3ae>	3aa: R_X86_64_PC32	.text+0x1268a
03ae      3ae:	48 0f c7 1f          	xrstors64 (%rdi)
03b2      3b2:	e9 00 00 00 00       	jmp    3b7 <.altinstr_replacement+0x3b7>	3b3: R_X86_64_PC32	.text+0x128ca
03b7      3b7:	e9 00 00 00 00       	jmp    3bc <.altinstr_replacement+0x3bc>	3b8: R_X86_64_PC32	.text+0x12a5e
03bc      3bc:	e9 00 00 00 00       	jmp    3c1 <.altinstr_replacement+0x3c1>	3bd: R_X86_64_PC32	.text+0x12b2f
03c1      3c1:	48 0f c7 1f          	xrstors64 (%rdi)
03c5      3c5:	e9 00 00 00 00       	jmp    3ca <.altinstr_replacement+0x3ca>	3c6: R_X86_64_PC32	.text+0x12c57
03ca      3ca:	48 0f c7 1f          	xrstors64 (%rdi)
03ce      3ce:	e9 00 00 00 00       	jmp    3d3 <.altinstr_replacement+0x3d3>	3cf: R_X86_64_PC32	.text+0x12d4c
03d3      3d3:	e9 00 00 00 00       	jmp    3d8 <.altinstr_replacement+0x3d8>	3d4: R_X86_64_PC32	.noinstr.text+0x18d4
03d8      3d8:	e9 00 00 00 00       	jmp    3dd <.altinstr_replacement+0x3dd>	3d9: R_X86_64_PC32	.text+0x12f10
03dd      3dd:	e9 00 00 00 00       	jmp    3e2 <.altinstr_replacement+0x3e2>	3de: R_X86_64_PC32	.text+0x13072
03e2      3e2:	0f 01 cb             	stac
03e5      3e5:	e8 00 00 00 00       	call   3ea <.altinstr_replacement+0x3ea>	3e6: R_X86_64_PLT32	rep_movs_alternative-0x4
03ea      3ea:	0f 01 ca             	clac
03ed      3ed:	e9 00 00 00 00       	jmp    3f2 <.altinstr_replacement+0x3f2>	3ee: R_X86_64_PC32	.text+0x13130
03f2      3f2:	e9 00 00 00 00       	jmp    3f7 <.altinstr_replacement+0x3f7>	3f3: R_X86_64_PC32	.text+0x131bf
03f7      3f7:	48 0f ae 37          	xsaveopt64 (%rdi)
03fb      3fb:	48 0f c7 27          	xsavec64 (%rdi)
03ff      3ff:	48 0f c7 2f          	xsaves64 (%rdi)
0403      403:	0f 01 cb             	stac
0406      406:	e8 00 00 00 00       	call   40b <.altinstr_replacement+0x40b>	407: R_X86_64_PLT32	rep_movs_alternative-0x4
040b      40b:	0f 01 ca             	clac
040e      40e:	e9 00 00 00 00       	jmp    413 <.altinstr_replacement+0x413>	40f: R_X86_64_PC32	.text+0x13335
0413      413:	e9 00 00 00 00       	jmp    418 <.altinstr_replacement+0x418>	414: R_X86_64_PC32	.text+0x13379
0418      418:	e9 00 00 00 00       	jmp    41d <.altinstr_replacement+0x41d>	419: R_X86_64_PC32	.text+0x1340f
041d      41d:	0f 01 cb             	stac
0420      420:	0f 01 ca             	clac
0423      423:	48 0f c7 1f          	xrstors64 (%rdi)
0427      427:	0f 01 cb             	stac
042a      42a:	0f 01 ca             	clac
042d      42d:	0f 01 cb             	stac
0430      430:	0f 01 ca             	clac
0433      433:	48 0f c7 1f          	xrstors64 (%rdi)
0437      437:	e9 00 00 00 00       	jmp    43c <.altinstr_replacement+0x43c>	438: R_X86_64_PC32	.text+0x13635
043c      43c:	0f 01 cb             	stac
043f      43f:	e8 00 00 00 00       	call   444 <.altinstr_replacement+0x444>	440: R_X86_64_PLT32	rep_movs_alternative-0x4
0444      444:	0f 01 ca             	clac
0447      447:	e9 00 00 00 00       	jmp    44c <.altinstr_replacement+0x44c>	448: R_X86_64_PC32	.text+0x136e5
044c      44c:	0f 01 cb             	stac
044f      44f:	e8 00 00 00 00       	call   454 <.altinstr_replacement+0x454>	450: R_X86_64_PLT32	rep_stos_alternative-0x4
0454      454:	0f 01 ca             	clac
0457      457:	e9 00 00 00 00       	jmp    45c <.altinstr_replacement+0x45c>	458: R_X86_64_PC32	.text+0x137e0
045c      45c:	0f 01 cb             	stac
045f      45f:	0f 01 ca             	clac
0462      462:	0f 01 cb             	stac
0465      465:	e8 00 00 00 00       	call   46a <.altinstr_replacement+0x46a>	466: R_X86_64_PLT32	rep_stos_alternative-0x4
046a      46a:	0f 01 ca             	clac
046d      46d:	0f 01 cb             	stac
0470      470:	0f 01 ca             	clac
0473      473:	e9 00 00 00 00       	jmp    478 <.altinstr_replacement+0x478>	474: R_X86_64_PC32	.text+0x1389a
0478      478:	e9 00 00 00 00       	jmp    47d <.altinstr_replacement+0x47d>	479: R_X86_64_PC32	.text+0x1390c
047d      47d:	e9 00 00 00 00       	jmp    482 <.altinstr_replacement+0x482>	47e: R_X86_64_PC32	.init.text+0xa8af
0482      482:	e9 00 00 00 00       	jmp    487 <.altinstr_replacement+0x487>	483: R_X86_64_PC32	.init.text+0xaa05
0487      487:	e9 00 00 00 00       	jmp    48c <.altinstr_replacement+0x48c>	488: R_X86_64_PC32	.init.text+0xaa33
048c      48c:	e9 00 00 00 00       	jmp    491 <.altinstr_replacement+0x491>	48d: R_X86_64_PC32	.text+0x13abf
0491      491:	e9 00 00 00 00       	jmp    496 <.altinstr_replacement+0x496>	492: R_X86_64_PC32	.text+0x13d18
0496      496:	e9 00 00 00 00       	jmp    49b <.altinstr_replacement+0x49b>	497: R_X86_64_PC32	.text+0x13d99
049b      49b:	e9 00 00 00 00       	jmp    4a0 <.altinstr_replacement+0x4a0>	49c: R_X86_64_PC32	.text+0x14187
04a0      4a0:	e9 00 00 00 00       	jmp    4a5 <.altinstr_replacement+0x4a5>	4a1: R_X86_64_PC32	.text+0x141c3
04a5      4a5:	e9 00 00 00 00       	jmp    4aa <.altinstr_replacement+0x4aa>	4a6: R_X86_64_PC32	.text+0x142c3
04aa      4aa:	e9 00 00 00 00       	jmp    4af <.altinstr_replacement+0x4af>	4ab: R_X86_64_PC32	.text+0x143f1
04af      4af:	e9 00 00 00 00       	jmp    4b4 <.altinstr_replacement+0x4b4>	4b0: R_X86_64_PC32	.text+0x14402
04b4      4b4:	e9 00 00 00 00       	jmp    4b9 <.altinstr_replacement+0x4b9>	4b5: R_X86_64_PC32	.init.text+0xab39
04b9      4b9:	e9 00 00 00 00       	jmp    4be <.altinstr_replacement+0x4be>	4ba: R_X86_64_PC32	.init.text+0xab31
04be      4be:	e9 00 00 00 00       	jmp    4c3 <.altinstr_replacement+0x4c3>	4bf: R_X86_64_PC32	.init.text+0xb36c
04c3      4c3:	e9 00 00 00 00       	jmp    4c8 <.altinstr_replacement+0x4c8>	4c4: R_X86_64_PC32	.init.text+0xb3c9
04c8      4c8:	e9 00 00 00 00       	jmp    4cd <.altinstr_replacement+0x4cd>	4c9: R_X86_64_PC32	.init.text+0xb4dc
04cd      4cd:	e9 00 00 00 00       	jmp    4d2 <.altinstr_replacement+0x4d2>	4ce: R_X86_64_PC32	.init.text+0xb769
04d2      4d2:	e9 00 00 00 00       	jmp    4d7 <.altinstr_replacement+0x4d7>	4d3: R_X86_64_PC32	.init.text+0xb757
04d7      4d7:	e9 00 00 00 00       	jmp    4dc <.altinstr_replacement+0x4dc>	4d8: R_X86_64_PC32	.init.text+0xb761
04dc      4dc:	e9 00 00 00 00       	jmp    4e1 <.altinstr_replacement+0x4e1>	4dd: R_X86_64_PC32	.text+0x14488
04e1      4e1:	e9 00 00 00 00       	jmp    4e6 <.altinstr_replacement+0x4e6>	4e2: R_X86_64_PC32	.text+0x144aa
04e6      4e6:	e9 00 00 00 00       	jmp    4eb <.altinstr_replacement+0x4eb>	4e7: R_X86_64_PC32	.text+0x144a1
04eb      4eb:	e9 00 00 00 00       	jmp    4f0 <.altinstr_replacement+0x4f0>	4ec: R_X86_64_PC32	.text+0x153e8
04f0      4f0:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
04fa      4fa:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0504      504:	e9 00 00 00 00       	jmp    509 <.altinstr_replacement+0x509>	505: R_X86_64_PC32	.text+0x176fe
0509      509:	e9 00 00 00 00       	jmp    50e <.altinstr_replacement+0x50e>	50a: R_X86_64_PC32	.text+0x176dc
050e      50e:	e9 00 00 00 00       	jmp    513 <.altinstr_replacement+0x513>	50f: R_X86_64_PC32	.text+0x176eb
0513      513:	e9 00 00 00 00       	jmp    518 <.altinstr_replacement+0x518>	514: R_X86_64_PC32	.text+0x176f6
0518      518:	e9 00 00 00 00       	jmp    51d <.altinstr_replacement+0x51d>	519: R_X86_64_PC32	.text+0x17723
051d      51d:	e9 00 00 00 00       	jmp    522 <.altinstr_replacement+0x522>	51e: R_X86_64_PC32	.text+0x17743
0522      522:	e9 00 00 00 00       	jmp    527 <.altinstr_replacement+0x527>	523: R_X86_64_PC32	.text+0x180c6
0527      527:	e9 00 00 00 00       	jmp    52c <.altinstr_replacement+0x52c>	528: R_X86_64_PC32	.text+0x187df
052c      52c:	e9 00 00 00 00       	jmp    531 <.altinstr_replacement+0x531>	52d: R_X86_64_PC32	.text+0x18832
0531      531:	e9 00 00 00 00       	jmp    536 <.altinstr_replacement+0x536>	532: R_X86_64_PC32	.text+0x18858
0536      536:	e9 00 00 00 00       	jmp    53b <.altinstr_replacement+0x53b>	537: R_X86_64_PC32	.text+0x18853
053b      53b:	e9 00 00 00 00       	jmp    540 <.altinstr_replacement+0x540>	53c: R_X86_64_PC32	.text+0x18fa0
0540      540:	e9 00 00 00 00       	jmp    545 <.altinstr_replacement+0x545>	541: R_X86_64_PC32	.text+0x18fa7
0545      545:	e9 00 00 00 00       	jmp    54a <.altinstr_replacement+0x54a>	546: R_X86_64_PC32	.init.text+0xc685
054a      54a:	e9 00 00 00 00       	jmp    54f <.altinstr_replacement+0x54f>	54b: R_X86_64_PC32	.text+0x19c8c
054f      54f:	e9 00 00 00 00       	jmp    554 <.altinstr_replacement+0x554>	550: R_X86_64_PC32	.text+0x19c93
0554      554:	e9 00 00 00 00       	jmp    559 <.altinstr_replacement+0x559>	555: R_X86_64_PC32	.text+0x19c87
0559      559:	0f 30                	wrmsr
055b      55b:	e9 00 00 00 00       	jmp    560 <.altinstr_replacement+0x560>	55c: R_X86_64_PC32	.init.text+0xdd15
0560      560:	e9 00 00 00 00       	jmp    565 <.altinstr_replacement+0x565>	561: R_X86_64_PC32	.init.text+0xdd1c
0565      565:	e9 00 00 00 00       	jmp    56a <.altinstr_replacement+0x56a>	566: R_X86_64_PC32	.text+0x1a96d
056a      56a:	e9 00 00 00 00       	jmp    56f <.altinstr_replacement+0x56f>	56b: R_X86_64_PC32	.init.text+0xdd86
056f      56f:	e9 00 00 00 00       	jmp    574 <.altinstr_replacement+0x574>	570: R_X86_64_PC32	.init.text+0xe666
0574      574:	e9 00 00 00 00       	jmp    579 <.altinstr_replacement+0x579>	575: R_X86_64_PC32	.text+0x1b550
0579      579:	e9 00 00 00 00       	jmp    57e <.altinstr_replacement+0x57e>	57a: R_X86_64_PC32	.text+0x1b5bb
057e      57e:	e9 00 00 00 00       	jmp    583 <.altinstr_replacement+0x583>	57f: R_X86_64_PC32	.text+0x1b5e4
0583      583:	e9 00 00 00 00       	jmp    588 <.altinstr_replacement+0x588>	584: R_X86_64_PC32	.init.text+0xed82
0588      588:	e9 00 00 00 00       	jmp    58d <.altinstr_replacement+0x58d>	589: R_X86_64_PC32	.text+0x1e22f
058d      58d:	e9 00 00 00 00       	jmp    592 <.altinstr_replacement+0x592>	58e: R_X86_64_PC32	.init.text+0x103a2
0592      592:	e9 00 00 00 00       	jmp    597 <.altinstr_replacement+0x597>	593: R_X86_64_PC32	.init.text+0x10cc7
0597      597:	e9 00 00 00 00       	jmp    59c <.altinstr_replacement+0x59c>	598: R_X86_64_PC32	.init.text+0x1154f
059c      59c:	87 04 25 10 d3 5f ff 	xchg   %eax,0xffffffffff5fd310
05a3      5a3:	87 04 25 00 d3 5f ff 	xchg   %eax,0xffffffffff5fd300
05aa      5aa:	87 04 25 10 d3 5f ff 	xchg   %eax,0xffffffffff5fd310
05b1      5b1:	87 04 25 10 d3 5f ff 	xchg   %eax,0xffffffffff5fd310
05b8      5b8:	87 34 25 00 d3 5f ff 	xchg   %esi,0xffffffffff5fd300
05bf      5bf:	44 87 24 25 10 d3 5f ff 	xchg   %r12d,0xffffffffff5fd310
05c7      5c7:	44 87 24 25 10 d3 5f ff 	xchg   %r12d,0xffffffffff5fd310
05cf      5cf:	87 04 25 10 d3 5f ff 	xchg   %eax,0xffffffffff5fd310
05d6      5d6:	87 04 25 10 d3 5f ff 	xchg   %eax,0xffffffffff5fd310
05dd      5dd:	87 34 25 00 d3 5f ff 	xchg   %esi,0xffffffffff5fd300
05e4      5e4:	87 04 25 10 d3 5f ff 	xchg   %eax,0xffffffffff5fd310
05eb      5eb:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
05f2      5f2:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
05f9      5f9:	87 3c 25 00 d3 5f ff 	xchg   %edi,0xffffffffff5fd300
0600      600:	87 b7 00 d0 5f ff    	xchg   %esi,-0xa03000(%rdi)
0606      606:	87 04 25 b0 d0 5f ff 	xchg   %eax,0xffffffffff5fd0b0
060d      60d:	0f ae e8             	lfence
0610      610:	0f 31                	rdtsc
0612      612:	0f 01 f9             	rdtscp
0615      615:	e8 00 00 00 00       	call   61a <.altinstr_replacement+0x61a>	616: R_X86_64_PLT32	clear_page_rep-0x4
061a      61a:	e8 00 00 00 00       	call   61f <.altinstr_replacement+0x61f>	61b: R_X86_64_PLT32	clear_page_erms-0x4
061f      61f:	e9 00 00 00 00       	jmp    624 <.altinstr_replacement+0x624>	620: R_X86_64_PC32	.text+0x25b68
0624      624:	e9 00 00 00 00       	jmp    629 <.altinstr_replacement+0x629>	625: R_X86_64_PC32	.text+0x25b64
0629      629:	e9 00 00 00 00       	jmp    62e <.altinstr_replacement+0x62e>	62a: R_X86_64_PC32	.text+0x25ba0
062e      62e:	e9 00 00 00 00       	jmp    633 <.altinstr_replacement+0x633>	62f: R_X86_64_PC32	.text+0x25de6
0633      633:	e9 00 00 00 00       	jmp    638 <.altinstr_replacement+0x638>	634: R_X86_64_PC32	.text+0x25d7d
0638      638:	e8 00 00 00 00       	call   63d <.altinstr_replacement+0x63d>	639: R_X86_64_PLT32	clear_page_rep-0x4
063d      63d:	e8 00 00 00 00       	call   642 <.altinstr_replacement+0x642>	63e: R_X86_64_PLT32	clear_page_erms-0x4
0642      642:	e9 00 00 00 00       	jmp    647 <.altinstr_replacement+0x647>	643: R_X86_64_PC32	.text+0x2785b
0647      647:	e9 00 00 00 00       	jmp    64c <.altinstr_replacement+0x64c>	648: R_X86_64_PC32	.init.text+0x15006
064c      64c:	e9 00 00 00 00       	jmp    651 <.altinstr_replacement+0x651>	64d: R_X86_64_PC32	.noinstr.text+0x1bdf
0651      651:	e9 00 00 00 00       	jmp    656 <.altinstr_replacement+0x656>	652: R_X86_64_PC32	.init.text+0x15d22
0656      656:	e8 00 00 00 00       	call   65b <.altinstr_replacement+0x65b>	657: R_X86_64_PLT32	clear_page_rep-0x4
065b      65b:	e8 00 00 00 00       	call   660 <.altinstr_replacement+0x660>	65c: R_X86_64_PLT32	clear_page_erms-0x4
0660      660:	e9 00 00 00 00       	jmp    665 <.altinstr_replacement+0x665>	661: R_X86_64_PC32	.text+0x2af79
0665      665:	e9 00 00 00 00       	jmp    66a <.altinstr_replacement+0x66a>	666: R_X86_64_PC32	.init.text+0x16499
066a      66a:	e9 00 00 00 00       	jmp    66f <.altinstr_replacement+0x66f>	66b: R_X86_64_PC32	.init.text+0x16556
066f      66f:	e9 00 00 00 00       	jmp    674 <.altinstr_replacement+0x674>	670: R_X86_64_PC32	.init.text+0x1653a
0674      674:	e9 00 00 00 00       	jmp    679 <.altinstr_replacement+0x679>	675: R_X86_64_PC32	.init.text+0x16469
0679      679:	e9 00 00 00 00       	jmp    67e <.altinstr_replacement+0x67e>	67a: R_X86_64_PC32	.text+0x2b3ba
067e      67e:	e9 00 00 00 00       	jmp    683 <.altinstr_replacement+0x683>	67f: R_X86_64_PC32	.text+0x2b3fe
0683      683:	e9 00 00 00 00       	jmp    688 <.altinstr_replacement+0x688>	684: R_X86_64_PC32	.text+0x2b3fb
0688      688:	e9 00 00 00 00       	jmp    68d <.altinstr_replacement+0x68d>	689: R_X86_64_PC32	.text+0x2b472
068d      68d:	e9 00 00 00 00       	jmp    692 <.altinstr_replacement+0x692>	68e: R_X86_64_PC32	.text+0x2b483
0692      692:	e9 00 00 00 00       	jmp    697 <.altinstr_replacement+0x697>	693: R_X86_64_PC32	.text+0x2b5d6
0697      697:	e9 00 00 00 00       	jmp    69c <.altinstr_replacement+0x69c>	698: R_X86_64_PC32	.text+0x2b57f
069c      69c:	e9 00 00 00 00       	jmp    6a1 <.altinstr_replacement+0x6a1>	69d: R_X86_64_PC32	.text+0x2b646
06a1      6a1:	e9 00 00 00 00       	jmp    6a6 <.altinstr_replacement+0x6a6>	6a2: R_X86_64_PC32	.text+0x2b67c
06a6      6a6:	e9 00 00 00 00       	jmp    6ab <.altinstr_replacement+0x6ab>	6a7: R_X86_64_PC32	.text+0x2b788
06ab      6ab:	e9 00 00 00 00       	jmp    6b0 <.altinstr_replacement+0x6b0>	6ac: R_X86_64_PC32	.text+0x2b7cc
06b0      6b0:	e9 00 00 00 00       	jmp    6b5 <.altinstr_replacement+0x6b5>	6b1: R_X86_64_PC32	.text+0x2b7dc
06b5      6b5:	e9 00 00 00 00       	jmp    6ba <.altinstr_replacement+0x6ba>	6b6: R_X86_64_PC32	.text+0x2b820
06ba      6ba:	e9 00 00 00 00       	jmp    6bf <.altinstr_replacement+0x6bf>	6bb: R_X86_64_PC32	.text+0x2b846
06bf      6bf:	e9 00 00 00 00       	jmp    6c4 <.altinstr_replacement+0x6c4>	6c0: R_X86_64_PC32	.text+0x2b853
06c4      6c4:	e9 00 00 00 00       	jmp    6c9 <.altinstr_replacement+0x6c9>	6c5: R_X86_64_PC32	.meminit.text+0x1313
06c9      6c9:	e9 00 00 00 00       	jmp    6ce <.altinstr_replacement+0x6ce>	6ca: R_X86_64_PC32	.meminit.text+0x14ec
06ce      6ce:	e9 00 00 00 00       	jmp    6d3 <.altinstr_replacement+0x6d3>	6cf: R_X86_64_PC32	.meminit.text+0x1508
06d3      6d3:	e9 00 00 00 00       	jmp    6d8 <.altinstr_replacement+0x6d8>	6d4: R_X86_64_PC32	.init.text+0x1670f
06d8      6d8:	e9 00 00 00 00       	jmp    6dd <.altinstr_replacement+0x6dd>	6d9: R_X86_64_PC32	.init.text+0x16701
06dd      6dd:	e9 00 00 00 00       	jmp    6e2 <.altinstr_replacement+0x6e2>	6de: R_X86_64_PC32	.init.text+0x16734
06e2      6e2:	e9 00 00 00 00       	jmp    6e7 <.altinstr_replacement+0x6e7>	6e3: R_X86_64_PC32	.init.text+0x16790
06e7      6e7:	e9 00 00 00 00       	jmp    6ec <.altinstr_replacement+0x6ec>	6e8: R_X86_64_PC32	.init.text+0x1675a
06ec      6ec:	e9 00 00 00 00       	jmp    6f1 <.altinstr_replacement+0x6f1>	6ed: R_X86_64_PC32	.meminit.text+0x1687
06f1      6f1:	e9 00 00 00 00       	jmp    6f6 <.altinstr_replacement+0x6f6>	6f2: R_X86_64_PC32	.meminit.text+0x175f
06f6      6f6:	e9 00 00 00 00       	jmp    6fb <.altinstr_replacement+0x6fb>	6f7: R_X86_64_PC32	.meminit.text+0x159b
06fb      6fb:	e9 00 00 00 00       	jmp    700 <.altinstr_replacement+0x700>	6fc: R_X86_64_PC32	.meminit.text+0x18f4
0700      700:	e9 00 00 00 00       	jmp    705 <.altinstr_replacement+0x705>	701: R_X86_64_PC32	.meminit.text+0x18aa
0705      705:	e9 00 00 00 00       	jmp    70a <.altinstr_replacement+0x70a>	706: R_X86_64_PC32	.meminit.text+0x19ea
070a      70a:	e9 00 00 00 00       	jmp    70f <.altinstr_replacement+0x70f>	70b: R_X86_64_PC32	.meminit.text+0x18a7
070f      70f:	e9 00 00 00 00       	jmp    714 <.altinstr_replacement+0x714>	710: R_X86_64_PC32	.meminit.text+0x1927
0714      714:	e9 00 00 00 00       	jmp    719 <.altinstr_replacement+0x719>	715: R_X86_64_PC32	.meminit.text+0x18aa
0719      719:	e9 00 00 00 00       	jmp    71e <.altinstr_replacement+0x71e>	71a: R_X86_64_PC32	.meminit.text+0x18a7
071e      71e:	e9 00 00 00 00       	jmp    723 <.altinstr_replacement+0x723>	71f: R_X86_64_PC32	.text+0x2b9f2
0723      723:	e9 00 00 00 00       	jmp    728 <.altinstr_replacement+0x728>	724: R_X86_64_PC32	.text+0x2ba33
0728      728:	e9 00 00 00 00       	jmp    72d <.altinstr_replacement+0x72d>	729: R_X86_64_PC32	.text+0x2b9d1
072d      72d:	e9 00 00 00 00       	jmp    732 <.altinstr_replacement+0x732>	72e: R_X86_64_PC32	.text+0x2ba0e
0732      732:	e9 00 00 00 00       	jmp    737 <.altinstr_replacement+0x737>	733: R_X86_64_PC32	.text+0x2b9d1
0737      737:	e9 00 00 00 00       	jmp    73c <.altinstr_replacement+0x73c>	738: R_X86_64_PC32	.text+0x2bb4e
073c      73c:	e9 00 00 00 00       	jmp    741 <.altinstr_replacement+0x741>	73d: R_X86_64_PC32	.text+0x2bb6e
0741      741:	e9 00 00 00 00       	jmp    746 <.altinstr_replacement+0x746>	742: R_X86_64_PC32	.init.text+0x1684a
0746      746:	e9 00 00 00 00       	jmp    74b <.altinstr_replacement+0x74b>	747: R_X86_64_PC32	.init.text+0x1682b
074b      74b:	e9 00 00 00 00       	jmp    750 <.altinstr_replacement+0x750>	74c: R_X86_64_PC32	.init.text+0x16827
0750      750:	e9 00 00 00 00       	jmp    755 <.altinstr_replacement+0x755>	751: R_X86_64_PC32	.init.text+0x168a0
0755      755:	e9 00 00 00 00       	jmp    75a <.altinstr_replacement+0x75a>	756: R_X86_64_PC32	.init.text+0x1687f
075a      75a:	e9 00 00 00 00       	jmp    75f <.altinstr_replacement+0x75f>	75b: R_X86_64_PC32	.init.text+0x1684a
075f      75f:	e9 00 00 00 00       	jmp    764 <.altinstr_replacement+0x764>	760: R_X86_64_PC32	.text+0x2bdf5
0764      764:	e9 00 00 00 00       	jmp    769 <.altinstr_replacement+0x769>	765: R_X86_64_PC32	.text+0x2be8a
0769      769:	e9 00 00 00 00       	jmp    76e <.altinstr_replacement+0x76e>	76a: R_X86_64_PC32	.text+0x2bebd
076e      76e:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0778      778:	e9 00 00 00 00       	jmp    77d <.altinstr_replacement+0x77d>	779: R_X86_64_PC32	.text+0x2c3fc
077d      77d:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0787      787:	e9 00 00 00 00       	jmp    78c <.altinstr_replacement+0x78c>	788: R_X86_64_PC32	.text+0x2c75d
078c      78c:	e9 00 00 00 00       	jmp    791 <.altinstr_replacement+0x791>	78d: R_X86_64_PC32	.text+0x2c790
0791      791:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
079b      79b:	0f 0d 88 e0 00 00 00 	prefetchw 0xe0(%rax)
07a2      7a2:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
07ac      7ac:	e9 00 00 00 00       	jmp    7b1 <.altinstr_replacement+0x7b1>	7ad: R_X86_64_PC32	.init.text+0x16af4
07b1      7b1:	e9 00 00 00 00       	jmp    7b6 <.altinstr_replacement+0x7b6>	7b2: R_X86_64_PC32	.text+0x2cde5
07b6      7b6:	e9 00 00 00 00       	jmp    7bb <.altinstr_replacement+0x7bb>	7b7: R_X86_64_PC32	.text+0x2ce17
07bb      7bb:	e9 00 00 00 00       	jmp    7c0 <.altinstr_replacement+0x7c0>	7bc: R_X86_64_PC32	.text+0x2d2b6
07c0      7c0:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
07ca      7ca:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
07d4      7d4:	e9 00 00 00 00       	jmp    7d9 <.altinstr_replacement+0x7d9>	7d5: R_X86_64_PC32	.text+0x2d77a
07d9      7d9:	e9 00 00 00 00       	jmp    7de <.altinstr_replacement+0x7de>	7da: R_X86_64_PC32	.text+0x2d829
07de      7de:	e9 00 00 00 00       	jmp    7e3 <.altinstr_replacement+0x7e3>	7df: R_X86_64_PC32	.text+0x2d8bd
07e3      7e3:	e9 00 00 00 00       	jmp    7e8 <.altinstr_replacement+0x7e8>	7e4: R_X86_64_PC32	.text+0x2e598
07e8      7e8:	e9 00 00 00 00       	jmp    7ed <.altinstr_replacement+0x7ed>	7e9: R_X86_64_PC32	.text+0x2e65b
07ed      7ed:	e9 00 00 00 00       	jmp    7f2 <.altinstr_replacement+0x7f2>	7ee: R_X86_64_PC32	.text+0x2e844
07f2      7f2:	e9 00 00 00 00       	jmp    7f7 <.altinstr_replacement+0x7f7>	7f3: R_X86_64_PC32	.text+0x2e844
07f7      7f7:	e9 00 00 00 00       	jmp    7fc <.altinstr_replacement+0x7fc>	7f8: R_X86_64_PC32	.text+0x2e8a4
07fc      7fc:	e9 00 00 00 00       	jmp    801 <.altinstr_replacement+0x801>	7fd: R_X86_64_PC32	.text+0x2e902
0801      801:	e9 00 00 00 00       	jmp    806 <.altinstr_replacement+0x806>	802: R_X86_64_PC32	.text+0x2e931
0806      806:	e9 00 00 00 00       	jmp    80b <.altinstr_replacement+0x80b>	807: R_X86_64_PC32	.text+0x2e9ba
080b      80b:	e9 00 00 00 00       	jmp    810 <.altinstr_replacement+0x810>	80c: R_X86_64_PC32	.text+0x2ec55
0810      810:	e9 00 00 00 00       	jmp    815 <.altinstr_replacement+0x815>	811: R_X86_64_PC32	.text+0x2eb8a
0815      815:	e9 00 00 00 00       	jmp    81a <.altinstr_replacement+0x81a>	816: R_X86_64_PC32	.text+0x2eb8f
081a      81a:	e9 00 00 00 00       	jmp    81f <.altinstr_replacement+0x81f>	81b: R_X86_64_PC32	.text+0x2eb16
081f      81f:	0f 30                	wrmsr
0821      821:	0f 30                	wrmsr
0823      823:	e9 00 00 00 00       	jmp    828 <.altinstr_replacement+0x828>	824: R_X86_64_PC32	.text+0x2f155
0828      828:	e9 00 00 00 00       	jmp    82d <.altinstr_replacement+0x82d>	829: R_X86_64_PC32	.text+0x2f405
082d      82d:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0837      837:	e9 00 00 00 00       	jmp    83c <.altinstr_replacement+0x83c>	838: R_X86_64_PC32	.text+0x2f65c
083c      83c:	66 0f ae 38          	clflushopt (%rax)
0840      840:	66 0f ae 38          	clflushopt (%rax)
0844      844:	e9 00 00 00 00       	jmp    849 <.altinstr_replacement+0x849>	845: R_X86_64_PC32	.text+0x3041e
0849      849:	e9 00 00 00 00       	jmp    84e <.altinstr_replacement+0x84e>	84a: R_X86_64_PC32	.text+0x3041b
084e      84e:	e9 00 00 00 00       	jmp    853 <.altinstr_replacement+0x853>	84f: R_X86_64_PC32	.text+0x30454
0853      853:	e9 00 00 00 00       	jmp    858 <.altinstr_replacement+0x858>	854: R_X86_64_PC32	.text+0x304c5
0858      858:	e9 00 00 00 00       	jmp    85d <.altinstr_replacement+0x85d>	859: R_X86_64_PC32	.text+0x30481
085d      85d:	e9 00 00 00 00       	jmp    862 <.altinstr_replacement+0x862>	85e: R_X86_64_PC32	.text+0x307bd
0862      862:	e9 00 00 00 00       	jmp    867 <.altinstr_replacement+0x867>	863: R_X86_64_PC32	.text+0x30809
0867      867:	e9 00 00 00 00       	jmp    86c <.altinstr_replacement+0x86c>	868: R_X86_64_PC32	.text+0x30ca3
086c      86c:	66 0f ae 38          	clflushopt (%rax)
0870      870:	e9 00 00 00 00       	jmp    875 <.altinstr_replacement+0x875>	871: R_X86_64_PC32	.text+0x32f23
0875      875:	e9 00 00 00 00       	jmp    87a <.altinstr_replacement+0x87a>	876: R_X86_64_PC32	.text+0x32f56
087a      87a:	e9 00 00 00 00       	jmp    87f <.altinstr_replacement+0x87f>	87b: R_X86_64_PC32	.init.text+0x171b0
087f      87f:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0889      889:	48 b9 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rcx
0893      893:	e9 00 00 00 00       	jmp    898 <.altinstr_replacement+0x898>	894: R_X86_64_PC32	.text+0x34f6f
0898      898:	e9 00 00 00 00       	jmp    89d <.altinstr_replacement+0x89d>	899: R_X86_64_PC32	.text+0x34f6b
089d      89d:	e9 00 00 00 00       	jmp    8a2 <.altinstr_replacement+0x8a2>	89e: R_X86_64_PC32	.text+0x34fa1
08a2      8a2:	e9 00 00 00 00       	jmp    8a7 <.altinstr_replacement+0x8a7>	8a3: R_X86_64_PC32	.init.text+0x1740e
08a7      8a7:	e9 00 00 00 00       	jmp    8ac <.altinstr_replacement+0x8ac>	8a8: R_X86_64_PC32	.text+0x350e3
08ac      8ac:	e9 00 00 00 00       	jmp    8b1 <.altinstr_replacement+0x8b1>	8ad: R_X86_64_PC32	.text+0x350a1
08b1      8b1:	e9 00 00 00 00       	jmp    8b6 <.altinstr_replacement+0x8b6>	8b2: R_X86_64_PC32	.text+0x35239
08b6      8b6:	e9 00 00 00 00       	jmp    8bb <.altinstr_replacement+0x8bb>	8b7: R_X86_64_PC32	.text+0x35262
08bb      8bb:	e9 00 00 00 00       	jmp    8c0 <.altinstr_replacement+0x8c0>	8bc: R_X86_64_PC32	.text+0x353cf
08c0      8c0:	e9 00 00 00 00       	jmp    8c5 <.altinstr_replacement+0x8c5>	8c1: R_X86_64_PC32	.text+0xb3026
08c5      8c5:	e9 00 00 00 00       	jmp    8ca <.altinstr_replacement+0x8ca>	8c6: R_X86_64_PC32	.text+0xb305a
08ca      8ca:	e9 00 00 00 00       	jmp    8cf <.altinstr_replacement+0x8cf>	8cb: R_X86_64_PC32	.text+0xb30ac
08cf      8cf:	49 bf 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%r15
08d9      8d9:	e9 00 00 00 00       	jmp    8de <.altinstr_replacement+0x8de>	8da: R_X86_64_PC32	.text+0xba83c
08de      8de:	0f 01 cb             	stac
08e1      8e1:	0f ae e8             	lfence
08e4      8e4:	0f 01 ca             	clac
08e7      8e7:	0f 01 ca             	clac
08ea      8ea:	0f 01 cb             	stac
08ed      8ed:	e8 00 00 00 00       	call   8f2 <.altinstr_replacement+0x8f2>	8ee: R_X86_64_PLT32	rep_stos_alternative-0x4
08f2      8f2:	0f 01 ca             	clac
08f5      8f5:	f3 0f b8 c7          	popcnt %edi,%eax
08f9      8f9:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0903      903:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
090d      90d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0912      912:	0f 01 cb             	stac
0915      915:	0f ae e8             	lfence
0918      918:	0f 01 ca             	clac
091b      91b:	0f 01 cb             	stac
091e      91e:	0f ae e8             	lfence
0921      921:	0f 01 ca             	clac
0924      924:	0f 01 ca             	clac
0927      927:	0f 01 ca             	clac
092a      92a:	e9 00 00 00 00       	jmp    92f <.altinstr_replacement+0x92f>	92b: R_X86_64_PC32	.text+0x135151
092f      92f:	e8 00 00 00 00       	call   934 <.altinstr_replacement+0x934>	930: R_X86_64_PLT32	clear_page_rep-0x4
0934      934:	e8 00 00 00 00       	call   939 <.altinstr_replacement+0x939>	935: R_X86_64_PLT32	clear_page_erms-0x4
0939      939:	e9 00 00 00 00       	jmp    93e <.altinstr_replacement+0x93e>	93a: R_X86_64_PC32	.text+0x13562e
093e      93e:	e9 00 00 00 00       	jmp    943 <.altinstr_replacement+0x943>	93f: R_X86_64_PC32	.text+0x135c0d
0943      943:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
094d      94d:	e9 00 00 00 00       	jmp    952 <.altinstr_replacement+0x952>	94e: R_X86_64_PC32	.text+0x14fe44
0952      952:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
095c      95c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0961      961:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
096b      96b:	e9 00 00 00 00       	jmp    970 <.altinstr_replacement+0x970>	96c: R_X86_64_PC32	.text+0x1bed5e
0970      970:	e9 00 00 00 00       	jmp    975 <.altinstr_replacement+0x975>	971: R_X86_64_PC32	.text+0x1c41f3
0975      975:	e9 00 00 00 00       	jmp    97a <.altinstr_replacement+0x97a>	976: R_X86_64_PC32	.text+0x1c42c1
097a      97a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
097f      97f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0984      984:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
098e      98e:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0998      998:	e9 00 00 00 00       	jmp    99d <.altinstr_replacement+0x99d>	999: R_X86_64_PC32	.text+0x1d335a
099d      99d:	e9 00 00 00 00       	jmp    9a2 <.altinstr_replacement+0x9a2>	99e: R_X86_64_PC32	.text+0x1d353f
09a2      9a2:	e9 00 00 00 00       	jmp    9a7 <.altinstr_replacement+0x9a7>	9a3: R_X86_64_PC32	.text+0x1d3549
09a7      9a7:	e9 00 00 00 00       	jmp    9ac <.altinstr_replacement+0x9ac>	9a8: R_X86_64_PC32	.text+0x1da1a2
09ac      9ac:	0f 01 cb             	stac
09af      9af:	e8 00 00 00 00       	call   9b4 <.altinstr_replacement+0x9b4>	9b0: R_X86_64_PLT32	rep_movs_alternative-0x4
09b4      9b4:	0f 01 ca             	clac
09b7      9b7:	0f 01 cb             	stac
09ba      9ba:	e8 00 00 00 00       	call   9bf <.altinstr_replacement+0x9bf>	9bb: R_X86_64_PLT32	rep_movs_alternative-0x4
09bf      9bf:	0f 01 ca             	clac
09c2      9c2:	0f 0d 48 f8          	prefetchw -0x8(%rax)
09c6      9c6:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
09d0      9d0:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
09da      9da:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
09e4      9e4:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
09ee      9ee:	e8 00 00 00 00       	call   9f3 <.altinstr_replacement+0x9f3>	9ef: R_X86_64_PLT32	clear_page_rep-0x4
09f3      9f3:	e8 00 00 00 00       	call   9f8 <.altinstr_replacement+0x9f8>	9f4: R_X86_64_PLT32	clear_page_erms-0x4
09f8      9f8:	e8 00 00 00 00       	call   9fd <.altinstr_replacement+0x9fd>	9f9: R_X86_64_PLT32	clear_page_rep-0x4
09fd      9fd:	e8 00 00 00 00       	call   a02 <.altinstr_replacement+0xa02>	9fe: R_X86_64_PLT32	clear_page_erms-0x4
0a02      a02:	e9 00 00 00 00       	jmp    a07 <.altinstr_replacement+0xa07>	a03: R_X86_64_PC32	.text+0x1f5c28
0a07      a07:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0a0c      a0c:	e9 00 00 00 00       	jmp    a11 <.altinstr_replacement+0xa11>	a0d: R_X86_64_PC32	.text+0x1f8d2c
0a11      a11:	e9 00 00 00 00       	jmp    a16 <.altinstr_replacement+0xa16>	a12: R_X86_64_PC32	.text+0x1f8e04
0a16      a16:	e9 00 00 00 00       	jmp    a1b <.altinstr_replacement+0xa1b>	a17: R_X86_64_PC32	.text+0x1fd4ca
0a1b      a1b:	e9 00 00 00 00       	jmp    a20 <.altinstr_replacement+0xa20>	a1c: R_X86_64_PC32	.text+0x1fd4d4
0a20      a20:	e9 00 00 00 00       	jmp    a25 <.altinstr_replacement+0xa25>	a21: R_X86_64_PC32	.text+0x1fdb9a
0a25      a25:	e9 00 00 00 00       	jmp    a2a <.altinstr_replacement+0xa2a>	a26: R_X86_64_PC32	.text+0x1fdc3f
0a2a      a2a:	e9 00 00 00 00       	jmp    a2f <.altinstr_replacement+0xa2f>	a2b: R_X86_64_PC32	.text+0x1ff6bc
0a2f      a2f:	e9 00 00 00 00       	jmp    a34 <.altinstr_replacement+0xa34>	a30: R_X86_64_PC32	.text+0x1ff6b5
0a34      a34:	0f 01 cb             	stac
0a37      a37:	0f ae e8             	lfence
0a3a      a3a:	0f 01 ca             	clac
0a3d      a3d:	0f 01 ca             	clac
0a40      a40:	0f 01 cb             	stac
0a43      a43:	0f ae e8             	lfence
0a46      a46:	0f 01 ca             	clac
0a49      a49:	0f 01 ca             	clac
0a4c      a4c:	e9 00 00 00 00       	jmp    a51 <.altinstr_replacement+0xa51>	a4d: R_X86_64_PC32	.text+0x20592b
0a51      a51:	e9 00 00 00 00       	jmp    a56 <.altinstr_replacement+0xa56>	a52: R_X86_64_PC32	.text+0x205ba1
0a56      a56:	e9 00 00 00 00       	jmp    a5b <.altinstr_replacement+0xa5b>	a57: R_X86_64_PC32	.text+0x205da0
0a5b      a5b:	e9 00 00 00 00       	jmp    a60 <.altinstr_replacement+0xa60>	a5c: R_X86_64_PC32	.text+0x205fda
0a60      a60:	e9 00 00 00 00       	jmp    a65 <.altinstr_replacement+0xa65>	a61: R_X86_64_PC32	.text+0x2060f2
0a65      a65:	e9 00 00 00 00       	jmp    a6a <.altinstr_replacement+0xa6a>	a66: R_X86_64_PC32	.text+0x206488
0a6a      a6a:	e9 00 00 00 00       	jmp    a6f <.altinstr_replacement+0xa6f>	a6b: R_X86_64_PC32	.text+0x206502
0a6f      a6f:	e9 00 00 00 00       	jmp    a74 <.altinstr_replacement+0xa74>	a70: R_X86_64_PC32	.text+0x206963
0a74      a74:	e9 00 00 00 00       	jmp    a79 <.altinstr_replacement+0xa79>	a75: R_X86_64_PC32	.text+0x206a92
0a79      a79:	e9 00 00 00 00       	jmp    a7e <.altinstr_replacement+0xa7e>	a7a: R_X86_64_PC32	.text+0x20701f
0a7e      a7e:	e9 00 00 00 00       	jmp    a83 <.altinstr_replacement+0xa83>	a7f: R_X86_64_PC32	.text+0x207037
0a83      a83:	e9 00 00 00 00       	jmp    a88 <.altinstr_replacement+0xa88>	a84: R_X86_64_PC32	.text+0x20706a
0a88      a88:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0a92      a92:	e9 00 00 00 00       	jmp    a97 <.altinstr_replacement+0xa97>	a93: R_X86_64_PC32	.text+0x20736b
0a97      a97:	e9 00 00 00 00       	jmp    a9c <.altinstr_replacement+0xa9c>	a98: R_X86_64_PC32	.text+0x20739e
0a9c      a9c:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0aa6      aa6:	e9 00 00 00 00       	jmp    aab <.altinstr_replacement+0xaab>	aa7: R_X86_64_PC32	.text+0x20981e
0aab      aab:	e9 00 00 00 00       	jmp    ab0 <.altinstr_replacement+0xab0>	aac: R_X86_64_PC32	.text+0x209be2
0ab0      ab0:	e9 00 00 00 00       	jmp    ab5 <.altinstr_replacement+0xab5>	ab1: R_X86_64_PC32	.text+0x209d5c
0ab5      ab5:	e9 00 00 00 00       	jmp    aba <.altinstr_replacement+0xaba>	ab6: R_X86_64_PC32	.text+0x209e34
0aba      aba:	e9 00 00 00 00       	jmp    abf <.altinstr_replacement+0xabf>	abb: R_X86_64_PC32	.text+0x20a2c4
0abf      abf:	e9 00 00 00 00       	jmp    ac4 <.altinstr_replacement+0xac4>	ac0: R_X86_64_PC32	.text+0x20a32d
0ac4      ac4:	e9 00 00 00 00       	jmp    ac9 <.altinstr_replacement+0xac9>	ac5: R_X86_64_PC32	.text+0x20a4c6
0ac9      ac9:	e9 00 00 00 00       	jmp    ace <.altinstr_replacement+0xace>	aca: R_X86_64_PC32	.text+0x20a931
0ace      ace:	0f 01 cb             	stac
0ad1      ad1:	e8 00 00 00 00       	call   ad6 <.altinstr_replacement+0xad6>	ad2: R_X86_64_PLT32	rep_movs_alternative-0x4
0ad6      ad6:	0f 01 ca             	clac
0ad9      ad9:	e8 00 00 00 00       	call   ade <.altinstr_replacement+0xade>	ada: R_X86_64_PLT32	clear_page_rep-0x4
0ade      ade:	e8 00 00 00 00       	call   ae3 <.altinstr_replacement+0xae3>	adf: R_X86_64_PLT32	clear_page_erms-0x4
0ae3      ae3:	0f 01 cb             	stac
0ae6      ae6:	e8 00 00 00 00       	call   aeb <.altinstr_replacement+0xaeb>	ae7: R_X86_64_PLT32	rep_movs_alternative-0x4
0aeb      aeb:	0f 01 ca             	clac
0aee      aee:	e9 00 00 00 00       	jmp    af3 <.altinstr_replacement+0xaf3>	aef: R_X86_64_PC32	.text+0x20b117
0af3      af3:	e9 00 00 00 00       	jmp    af8 <.altinstr_replacement+0xaf8>	af4: R_X86_64_PC32	.text+0x20b188
0af8      af8:	e9 00 00 00 00       	jmp    afd <.altinstr_replacement+0xafd>	af9: R_X86_64_PC32	.text+0x20b1b8
0afd      afd:	e9 00 00 00 00       	jmp    b02 <.altinstr_replacement+0xb02>	afe: R_X86_64_PC32	.text+0x20b205
0b02      b02:	e9 00 00 00 00       	jmp    b07 <.altinstr_replacement+0xb07>	b03: R_X86_64_PC32	.text+0x20b0e8
0b07      b07:	e9 00 00 00 00       	jmp    b0c <.altinstr_replacement+0xb0c>	b08: R_X86_64_PC32	.text+0x20b78a
0b0c      b0c:	e9 00 00 00 00       	jmp    b11 <.altinstr_replacement+0xb11>	b0d: R_X86_64_PC32	.text+0x20b856
0b11      b11:	e9 00 00 00 00       	jmp    b16 <.altinstr_replacement+0xb16>	b12: R_X86_64_PC32	.text+0x20b872
0b16      b16:	e9 00 00 00 00       	jmp    b1b <.altinstr_replacement+0xb1b>	b17: R_X86_64_PC32	.text+0x20b8a5
0b1b      b1b:	e9 00 00 00 00       	jmp    b20 <.altinstr_replacement+0xb20>	b1c: R_X86_64_PC32	.text+0x20ba6c
0b20      b20:	e9 00 00 00 00       	jmp    b25 <.altinstr_replacement+0xb25>	b21: R_X86_64_PC32	.text+0x20bc75
0b25      b25:	e9 00 00 00 00       	jmp    b2a <.altinstr_replacement+0xb2a>	b26: R_X86_64_PC32	.text+0x20bc8d
0b2a      b2a:	e9 00 00 00 00       	jmp    b2f <.altinstr_replacement+0xb2f>	b2b: R_X86_64_PC32	.text+0x20c389
0b2f      b2f:	e9 00 00 00 00       	jmp    b34 <.altinstr_replacement+0xb34>	b30: R_X86_64_PC32	.text+0x20dde6
0b34      b34:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0b3e      b3e:	e9 00 00 00 00       	jmp    b43 <.altinstr_replacement+0xb43>	b3f: R_X86_64_PC32	.text+0x20e469
0b43      b43:	e9 00 00 00 00       	jmp    b48 <.altinstr_replacement+0xb48>	b44: R_X86_64_PC32	.text+0x20e485
0b48      b48:	e9 00 00 00 00       	jmp    b4d <.altinstr_replacement+0xb4d>	b49: R_X86_64_PC32	.text+0x20e759
0b4d      b4d:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0b57      b57:	e9 00 00 00 00       	jmp    b5c <.altinstr_replacement+0xb5c>	b58: R_X86_64_PC32	.text+0x20f1dc
0b5c      b5c:	e9 00 00 00 00       	jmp    b61 <.altinstr_replacement+0xb61>	b5d: R_X86_64_PC32	.text+0x210b7b
0b61      b61:	e9 00 00 00 00       	jmp    b66 <.altinstr_replacement+0xb66>	b62: R_X86_64_PC32	.text+0x210b93
0b66      b66:	e9 00 00 00 00       	jmp    b6b <.altinstr_replacement+0xb6b>	b67: R_X86_64_PC32	.text+0x210b75
0b6b      b6b:	e9 00 00 00 00       	jmp    b70 <.altinstr_replacement+0xb70>	b6c: R_X86_64_PC32	.text+0x210b93
0b70      b70:	e9 00 00 00 00       	jmp    b75 <.altinstr_replacement+0xb75>	b71: R_X86_64_PC32	.text+0x210d20
0b75      b75:	e9 00 00 00 00       	jmp    b7a <.altinstr_replacement+0xb7a>	b76: R_X86_64_PC32	.text+0x210d14
0b7a      b7a:	e9 00 00 00 00       	jmp    b7f <.altinstr_replacement+0xb7f>	b7b: R_X86_64_PC32	.text+0x210f25
0b7f      b7f:	e9 00 00 00 00       	jmp    b84 <.altinstr_replacement+0xb84>	b80: R_X86_64_PC32	.text+0x210f5a
0b84      b84:	e9 00 00 00 00       	jmp    b89 <.altinstr_replacement+0xb89>	b85: R_X86_64_PC32	.text+0x211be6
0b89      b89:	e9 00 00 00 00       	jmp    b8e <.altinstr_replacement+0xb8e>	b8a: R_X86_64_PC32	.text+0x211c3c
0b8e      b8e:	e9 00 00 00 00       	jmp    b93 <.altinstr_replacement+0xb93>	b8f: R_X86_64_PC32	.text+0x211c07
0b93      b93:	e9 00 00 00 00       	jmp    b98 <.altinstr_replacement+0xb98>	b94: R_X86_64_PC32	.text+0x211cc7
0b98      b98:	e9 00 00 00 00       	jmp    b9d <.altinstr_replacement+0xb9d>	b99: R_X86_64_PC32	.text+0x211bf0
0b9d      b9d:	e9 00 00 00 00       	jmp    ba2 <.altinstr_replacement+0xba2>	b9e: R_X86_64_PC32	.text+0x211f09
0ba2      ba2:	e9 00 00 00 00       	jmp    ba7 <.altinstr_replacement+0xba7>	ba3: R_X86_64_PC32	.text+0x212230
0ba7      ba7:	e9 00 00 00 00       	jmp    bac <.altinstr_replacement+0xbac>	ba8: R_X86_64_PC32	.text+0x212262
0bac      bac:	e9 00 00 00 00       	jmp    bb1 <.altinstr_replacement+0xbb1>	bad: R_X86_64_PC32	.text+0x212786
0bb1      bb1:	e9 00 00 00 00       	jmp    bb6 <.altinstr_replacement+0xbb6>	bb2: R_X86_64_PC32	.text+0x2127ba
0bb6      bb6:	e9 00 00 00 00       	jmp    bbb <.altinstr_replacement+0xbbb>	bb7: R_X86_64_PC32	.text+0x2127f3
0bbb      bbb:	e9 00 00 00 00       	jmp    bc0 <.altinstr_replacement+0xbc0>	bbc: R_X86_64_PC32	.text+0x212e63
0bc0      bc0:	e9 00 00 00 00       	jmp    bc5 <.altinstr_replacement+0xbc5>	bc1: R_X86_64_PC32	.text+0x212e7f
0bc5      bc5:	e8 00 00 00 00       	call   bca <.altinstr_replacement+0xbca>	bc6: R_X86_64_PLT32	clear_page_rep-0x4
0bca      bca:	e8 00 00 00 00       	call   bcf <.altinstr_replacement+0xbcf>	bcb: R_X86_64_PLT32	clear_page_erms-0x4
0bcf      bcf:	e8 00 00 00 00       	call   bd4 <.altinstr_replacement+0xbd4>	bd0: R_X86_64_PLT32	clear_page_rep-0x4
0bd4      bd4:	e8 00 00 00 00       	call   bd9 <.altinstr_replacement+0xbd9>	bd5: R_X86_64_PLT32	clear_page_erms-0x4
0bd9      bd9:	e8 00 00 00 00       	call   bde <.altinstr_replacement+0xbde>	bda: R_X86_64_PLT32	clear_page_rep-0x4
0bde      bde:	e8 00 00 00 00       	call   be3 <.altinstr_replacement+0xbe3>	bdf: R_X86_64_PLT32	clear_page_erms-0x4
0be3      be3:	e8 00 00 00 00       	call   be8 <.altinstr_replacement+0xbe8>	be4: R_X86_64_PLT32	clear_page_rep-0x4
0be8      be8:	e8 00 00 00 00       	call   bed <.altinstr_replacement+0xbed>	be9: R_X86_64_PLT32	clear_page_erms-0x4
0bed      bed:	e8 00 00 00 00       	call   bf2 <.altinstr_replacement+0xbf2>	bee: R_X86_64_PLT32	clear_page_rep-0x4
0bf2      bf2:	e8 00 00 00 00       	call   bf7 <.altinstr_replacement+0xbf7>	bf3: R_X86_64_PLT32	clear_page_erms-0x4
0bf7      bf7:	e9 00 00 00 00       	jmp    bfc <.altinstr_replacement+0xbfc>	bf8: R_X86_64_PC32	.text+0x213e9b
0bfc      bfc:	e9 00 00 00 00       	jmp    c01 <.altinstr_replacement+0xc01>	bfd: R_X86_64_PC32	.text+0x213f9a
0c01      c01:	e9 00 00 00 00       	jmp    c06 <.altinstr_replacement+0xc06>	c02: R_X86_64_PC32	.text+0x213fcf
0c06      c06:	e9 00 00 00 00       	jmp    c0b <.altinstr_replacement+0xc0b>	c07: R_X86_64_PC32	.text+0x214424
0c0b      c0b:	48 be 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rsi
0c15      c15:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c1f      c1f:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c29      c29:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c33      c33:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c3d      c3d:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c47      c47:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c51      c51:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c5b      c5b:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c65      c65:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0c6f      c6f:	e9 00 00 00 00       	jmp    c74 <.altinstr_replacement+0xc74>	c70: R_X86_64_PC32	.text+0x21e012
0c74      c74:	e9 00 00 00 00       	jmp    c79 <.altinstr_replacement+0xc79>	c75: R_X86_64_PC32	.text+0x21e0b4
0c79      c79:	e9 00 00 00 00       	jmp    c7e <.altinstr_replacement+0xc7e>	c7a: R_X86_64_PC32	.text+0x21e63e
0c7e      c7e:	e9 00 00 00 00       	jmp    c83 <.altinstr_replacement+0xc83>	c7f: R_X86_64_PC32	.text+0x21eaad
0c83      c83:	e9 00 00 00 00       	jmp    c88 <.altinstr_replacement+0xc88>	c84: R_X86_64_PC32	.text+0x21ebbe
0c88      c88:	e9 00 00 00 00       	jmp    c8d <.altinstr_replacement+0xc8d>	c89: R_X86_64_PC32	.text+0x21eb0c
0c8d      c8d:	e9 00 00 00 00       	jmp    c92 <.altinstr_replacement+0xc92>	c8e: R_X86_64_PC32	.text+0x21eb28
0c92      c92:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0c9c      c9c:	e9 00 00 00 00       	jmp    ca1 <.altinstr_replacement+0xca1>	c9d: R_X86_64_PC32	.text+0x21f5ac
0ca1      ca1:	e9 00 00 00 00       	jmp    ca6 <.altinstr_replacement+0xca6>	ca2: R_X86_64_PC32	.text+0x21f5cc
0ca6      ca6:	e9 00 00 00 00       	jmp    cab <.altinstr_replacement+0xcab>	ca7: R_X86_64_PC32	.text+0x21f602
0cab      cab:	e9 00 00 00 00       	jmp    cb0 <.altinstr_replacement+0xcb0>	cac: R_X86_64_PC32	.text+0x21fb41
0cb0      cb0:	e9 00 00 00 00       	jmp    cb5 <.altinstr_replacement+0xcb5>	cb1: R_X86_64_PC32	.text+0x21fb76
0cb5      cb5:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0cbf      cbf:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0cc9      cc9:	e9 00 00 00 00       	jmp    cce <.altinstr_replacement+0xcce>	cca: R_X86_64_PC32	.text+0x2217d9
0cce      cce:	e9 00 00 00 00       	jmp    cd3 <.altinstr_replacement+0xcd3>	ccf: R_X86_64_PC32	.text+0x221910
0cd3      cd3:	e9 00 00 00 00       	jmp    cd8 <.altinstr_replacement+0xcd8>	cd4: R_X86_64_PC32	.text+0x221939
0cd8      cd8:	e9 00 00 00 00       	jmp    cdd <.altinstr_replacement+0xcdd>	cd9: R_X86_64_PC32	.text+0x221f69
0cdd      cdd:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0ce7      ce7:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
0cf1      cf1:	e9 00 00 00 00       	jmp    cf6 <.altinstr_replacement+0xcf6>	cf2: R_X86_64_PC32	.text+0x22267b
0cf6      cf6:	e9 00 00 00 00       	jmp    cfb <.altinstr_replacement+0xcfb>	cf7: R_X86_64_PC32	.text+0x22282f
0cfb      cfb:	e9 00 00 00 00       	jmp    d00 <.altinstr_replacement+0xd00>	cfc: R_X86_64_PC32	.text+0x22284b
0d00      d00:	e9 00 00 00 00       	jmp    d05 <.altinstr_replacement+0xd05>	d01: R_X86_64_PC32	.text+0x2230a6
0d05      d05:	e9 00 00 00 00       	jmp    d0a <.altinstr_replacement+0xd0a>	d06: R_X86_64_PC32	.text+0x2230ab
0d0a      d0a:	e9 00 00 00 00       	jmp    d0f <.altinstr_replacement+0xd0f>	d0b: R_X86_64_PC32	.text+0x2230de
0d0f      d0f:	e9 00 00 00 00       	jmp    d14 <.altinstr_replacement+0xd14>	d10: R_X86_64_PC32	.text+0x2230ec
0d14      d14:	e9 00 00 00 00       	jmp    d19 <.altinstr_replacement+0xd19>	d15: R_X86_64_PC32	.text+0x223ff6
0d19      d19:	e9 00 00 00 00       	jmp    d1e <.altinstr_replacement+0xd1e>	d1a: R_X86_64_PC32	.text+0x2246ae
0d1e      d1e:	e9 00 00 00 00       	jmp    d23 <.altinstr_replacement+0xd23>	d1f: R_X86_64_PC32	.text+0x2246e1
0d23      d23:	e9 00 00 00 00       	jmp    d28 <.altinstr_replacement+0xd28>	d24: R_X86_64_PC32	.text+0x225d97
0d28      d28:	e9 00 00 00 00       	jmp    d2d <.altinstr_replacement+0xd2d>	d29: R_X86_64_PC32	.text+0x22715d
0d2d      d2d:	e9 00 00 00 00       	jmp    d32 <.altinstr_replacement+0xd32>	d2e: R_X86_64_PC32	.text+0x2278fb
0d32      d32:	e9 00 00 00 00       	jmp    d37 <.altinstr_replacement+0xd37>	d33: R_X86_64_PC32	.text+0x227915
0d37      d37:	e9 00 00 00 00       	jmp    d3c <.altinstr_replacement+0xd3c>	d38: R_X86_64_PC32	.text+0x227948
0d3c      d3c:	e9 00 00 00 00       	jmp    d41 <.altinstr_replacement+0xd41>	d3d: R_X86_64_PC32	.text+0x227ebc
0d41      d41:	e9 00 00 00 00       	jmp    d46 <.altinstr_replacement+0xd46>	d42: R_X86_64_PC32	.text+0x227f94
0d46      d46:	e9 00 00 00 00       	jmp    d4b <.altinstr_replacement+0xd4b>	d47: R_X86_64_PC32	.text+0x228c3a
0d4b      d4b:	e9 00 00 00 00       	jmp    d50 <.altinstr_replacement+0xd50>	d4c: R_X86_64_PC32	.text+0x22915d
0d50      d50:	e9 00 00 00 00       	jmp    d55 <.altinstr_replacement+0xd55>	d51: R_X86_64_PC32	.text+0x2292a1
0d55      d55:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d5a      d5a:	e9 00 00 00 00       	jmp    d5f <.altinstr_replacement+0xd5f>	d5b: R_X86_64_PC32	.text+0x22ba41
0d5f      d5f:	e9 00 00 00 00       	jmp    d64 <.altinstr_replacement+0xd64>	d60: R_X86_64_PC32	.init.text+0x22382
0d64      d64:	e9 00 00 00 00       	jmp    d69 <.altinstr_replacement+0xd69>	d65: R_X86_64_PC32	.text+0x22bed9
0d69      d69:	e9 00 00 00 00       	jmp    d6e <.altinstr_replacement+0xd6e>	d6a: R_X86_64_PC32	.text+0x22beff
0d6e      d6e:	e9 00 00 00 00       	jmp    d73 <.altinstr_replacement+0xd73>	d6f: R_X86_64_PC32	.text+0x22bf1b
0d73      d73:	e9 00 00 00 00       	jmp    d78 <.altinstr_replacement+0xd78>	d74: R_X86_64_PC32	.text+0x22c261
0d78      d78:	e9 00 00 00 00       	jmp    d7d <.altinstr_replacement+0xd7d>	d79: R_X86_64_PC32	.text+0x22c400
0d7d      d7d:	e9 00 00 00 00       	jmp    d82 <.altinstr_replacement+0xd82>	d7e: R_X86_64_PC32	.text+0x22c65c
0d82      d82:	e9 00 00 00 00       	jmp    d87 <.altinstr_replacement+0xd87>	d83: R_X86_64_PC32	.text+0x22c66a
0d87      d87:	e9 00 00 00 00       	jmp    d8c <.altinstr_replacement+0xd8c>	d88: R_X86_64_PC32	.text+0x22c742
0d8c      d8c:	e9 00 00 00 00       	jmp    d91 <.altinstr_replacement+0xd91>	d8d: R_X86_64_PC32	.text+0x22c84f
0d91      d91:	e9 00 00 00 00       	jmp    d96 <.altinstr_replacement+0xd96>	d92: R_X86_64_PC32	.text+0x22cb03
0d96      d96:	e9 00 00 00 00       	jmp    d9b <.altinstr_replacement+0xd9b>	d97: R_X86_64_PC32	.text+0x22cb5f
0d9b      d9b:	e9 00 00 00 00       	jmp    da0 <.altinstr_replacement+0xda0>	d9c: R_X86_64_PC32	.text+0x22d388
0da0      da0:	e9 00 00 00 00       	jmp    da5 <.altinstr_replacement+0xda5>	da1: R_X86_64_PC32	.text+0x22d8ff
0da5      da5:	e9 00 00 00 00       	jmp    daa <.altinstr_replacement+0xdaa>	da6: R_X86_64_PC32	.text+0x22d95f
0daa      daa:	e9 00 00 00 00       	jmp    daf <.altinstr_replacement+0xdaf>	dab: R_X86_64_PC32	.text+0x22d9bf
0daf      daf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0db4      db4:	e9 00 00 00 00       	jmp    db9 <.altinstr_replacement+0xdb9>	db5: R_X86_64_PC32	.text+0x22f47b
0db9      db9:	e9 00 00 00 00       	jmp    dbe <.altinstr_replacement+0xdbe>	dba: R_X86_64_PC32	.text+0x22f514
0dbe      dbe:	e9 00 00 00 00       	jmp    dc3 <.altinstr_replacement+0xdc3>	dbf: R_X86_64_PC32	.text+0x230496
0dc3      dc3:	e9 00 00 00 00       	jmp    dc8 <.altinstr_replacement+0xdc8>	dc4: R_X86_64_PC32	.text+0x230ecf
0dc8      dc8:	e9 00 00 00 00       	jmp    dcd <.altinstr_replacement+0xdcd>	dc9: R_X86_64_PC32	.text+0x230fbd
0dcd      dcd:	e9 00 00 00 00       	jmp    dd2 <.altinstr_replacement+0xdd2>	dce: R_X86_64_PC32	.text+0x2311a8
0dd2      dd2:	e8 00 00 00 00       	call   dd7 <.altinstr_replacement+0xdd7>	dd3: R_X86_64_PLT32	clear_page_rep-0x4
0dd7      dd7:	e8 00 00 00 00       	call   ddc <.altinstr_replacement+0xddc>	dd8: R_X86_64_PLT32	clear_page_erms-0x4
0ddc      ddc:	e8 00 00 00 00       	call   de1 <.altinstr_replacement+0xde1>	ddd: R_X86_64_PLT32	clear_page_rep-0x4
0de1      de1:	e8 00 00 00 00       	call   de6 <.altinstr_replacement+0xde6>	de2: R_X86_64_PLT32	clear_page_erms-0x4
0de6      de6:	e8 00 00 00 00       	call   deb <.altinstr_replacement+0xdeb>	de7: R_X86_64_PLT32	clear_page_rep-0x4
0deb      deb:	e8 00 00 00 00       	call   df0 <.altinstr_replacement+0xdf0>	dec: R_X86_64_PLT32	clear_page_erms-0x4
0df0      df0:	0f 0d 0f             	prefetchw (%rdi)
0df3      df3:	0f 0d 08             	prefetchw (%rax)
0df6      df6:	e9 00 00 00 00       	jmp    dfb <.altinstr_replacement+0xdfb>	df7: R_X86_64_PC32	.text+0x23219b
0dfb      dfb:	e9 00 00 00 00       	jmp    e00 <.altinstr_replacement+0xe00>	dfc: R_X86_64_PC32	.text+0x2322a2
0e00      e00:	e8 00 00 00 00       	call   e05 <.altinstr_replacement+0xe05>	e01: R_X86_64_PLT32	clear_page_rep-0x4
0e05      e05:	e8 00 00 00 00       	call   e0a <.altinstr_replacement+0xe0a>	e06: R_X86_64_PLT32	clear_page_erms-0x4
0e0a      e0a:	e8 00 00 00 00       	call   e0f <.altinstr_replacement+0xe0f>	e0b: R_X86_64_PLT32	clear_page_rep-0x4
0e0f      e0f:	e8 00 00 00 00       	call   e14 <.altinstr_replacement+0xe14>	e10: R_X86_64_PLT32	clear_page_erms-0x4
0e14      e14:	e9 00 00 00 00       	jmp    e19 <.altinstr_replacement+0xe19>	e15: R_X86_64_PC32	.text+0x235489
0e19      e19:	e8 00 00 00 00       	call   e1e <.altinstr_replacement+0xe1e>	e1a: R_X86_64_PLT32	clear_page_rep-0x4
0e1e      e1e:	e8 00 00 00 00       	call   e23 <.altinstr_replacement+0xe23>	e1f: R_X86_64_PLT32	clear_page_erms-0x4
0e23      e23:	e9 00 00 00 00       	jmp    e28 <.altinstr_replacement+0xe28>	e24: R_X86_64_PC32	.text+0x23587f
0e28      e28:	e8 00 00 00 00       	call   e2d <.altinstr_replacement+0xe2d>	e29: R_X86_64_PLT32	clear_page_rep-0x4
0e2d      e2d:	e8 00 00 00 00       	call   e32 <.altinstr_replacement+0xe32>	e2e: R_X86_64_PLT32	clear_page_erms-0x4
0e32      e32:	e8 00 00 00 00       	call   e37 <.altinstr_replacement+0xe37>	e33: R_X86_64_PLT32	clear_page_rep-0x4
0e37      e37:	e8 00 00 00 00       	call   e3c <.altinstr_replacement+0xe3c>	e38: R_X86_64_PLT32	clear_page_erms-0x4
0e3c      e3c:	e8 00 00 00 00       	call   e41 <.altinstr_replacement+0xe41>	e3d: R_X86_64_PLT32	clear_page_rep-0x4
0e41      e41:	e8 00 00 00 00       	call   e46 <.altinstr_replacement+0xe46>	e42: R_X86_64_PLT32	clear_page_erms-0x4
0e46      e46:	e9 00 00 00 00       	jmp    e4b <.altinstr_replacement+0xe4b>	e47: R_X86_64_PC32	.text+0x238e90
0e4b      e4b:	e9 00 00 00 00       	jmp    e50 <.altinstr_replacement+0xe50>	e4c: R_X86_64_PC32	.text+0x238e80
0e50      e50:	e9 00 00 00 00       	jmp    e55 <.altinstr_replacement+0xe55>	e51: R_X86_64_PC32	.text+0x23998d
0e55      e55:	e9 00 00 00 00       	jmp    e5a <.altinstr_replacement+0xe5a>	e56: R_X86_64_PC32	.text+0x239b38
0e5a      e5a:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e5e      e5e:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e62      e62:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e66      e66:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e6a      e6a:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e6e      e6e:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e72      e72:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e76      e76:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e7a      e7a:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e7e      e7e:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e82      e82:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e86      e86:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e8a      e8a:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e8e      e8e:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e92      e92:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e96      e96:	48 0f c7 0e          	cmpxchg16b (%rsi)
0e9a      e9a:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e9e      e9e:	48 0f c7 0e          	cmpxchg16b (%rsi)
0ea2      ea2:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0ea6      ea6:	48 0f c7 0e          	cmpxchg16b (%rsi)
0eaa      eaa:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0eae      eae:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0eb3      eb3:	e9 00 00 00 00       	jmp    eb8 <.altinstr_replacement+0xeb8>	eb4: R_X86_64_PC32	.text+0x2496ba
0eb8      eb8:	e9 00 00 00 00       	jmp    ebd <.altinstr_replacement+0xebd>	eb9: R_X86_64_PC32	.text+0x2497d2
0ebd      ebd:	e9 00 00 00 00       	jmp    ec2 <.altinstr_replacement+0xec2>	ebe: R_X86_64_PC32	.text+0x249805
0ec2      ec2:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0ecc      ecc:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
0ed6      ed6:	e9 00 00 00 00       	jmp    edb <.altinstr_replacement+0xedb>	ed7: R_X86_64_PC32	.text+0x24a918
0edb      edb:	e9 00 00 00 00       	jmp    ee0 <.altinstr_replacement+0xee0>	edc: R_X86_64_PC32	.text+0x24a94d
0ee0      ee0:	e9 00 00 00 00       	jmp    ee5 <.altinstr_replacement+0xee5>	ee1: R_X86_64_PC32	.text+0x24bdce
0ee5      ee5:	e9 00 00 00 00       	jmp    eea <.altinstr_replacement+0xeea>	ee6: R_X86_64_PC32	.text+0x24d056
0eea      eea:	e9 00 00 00 00       	jmp    eef <.altinstr_replacement+0xeef>	eeb: R_X86_64_PC32	.text+0x24d101
0eef      eef:	e9 00 00 00 00       	jmp    ef4 <.altinstr_replacement+0xef4>	ef0: R_X86_64_PC32	.text+0x24d1ef
0ef4      ef4:	e9 00 00 00 00       	jmp    ef9 <.altinstr_replacement+0xef9>	ef5: R_X86_64_PC32	.init.text+0x25366
0ef9      ef9:	e9 00 00 00 00       	jmp    efe <.altinstr_replacement+0xefe>	efa: R_X86_64_PC32	.init.text+0x25352
0efe      efe:	e9 00 00 00 00       	jmp    f03 <.altinstr_replacement+0xf03>	eff: R_X86_64_PC32	.init.text+0x253a0
0f03      f03:	e9 00 00 00 00       	jmp    f08 <.altinstr_replacement+0xf08>	f04: R_X86_64_PC32	.init.text+0x25623
0f08      f08:	e9 00 00 00 00       	jmp    f0d <.altinstr_replacement+0xf0d>	f09: R_X86_64_PC32	.init.text+0x2562d
0f0d      f0d:	e9 00 00 00 00       	jmp    f12 <.altinstr_replacement+0xf12>	f0e: R_X86_64_PC32	.init.text+0x2560d
0f12      f12:	e9 00 00 00 00       	jmp    f17 <.altinstr_replacement+0xf17>	f13: R_X86_64_PC32	.init.text+0x25772
0f17      f17:	e9 00 00 00 00       	jmp    f1c <.altinstr_replacement+0xf1c>	f18: R_X86_64_PC32	.init.text+0x2577c
0f1c      f1c:	e9 00 00 00 00       	jmp    f21 <.altinstr_replacement+0xf21>	f1d: R_X86_64_PC32	.init.text+0x2576b
0f21      f21:	e9 00 00 00 00       	jmp    f26 <.altinstr_replacement+0xf26>	f22: R_X86_64_PC32	.text+0x24ea04
0f26      f26:	e9 00 00 00 00       	jmp    f2b <.altinstr_replacement+0xf2b>	f27: R_X86_64_PC32	.text+0x24e9ef
0f2b      f2b:	e9 00 00 00 00       	jmp    f30 <.altinstr_replacement+0xf30>	f2c: R_X86_64_PC32	.init.text+0x25854
0f30      f30:	e9 00 00 00 00       	jmp    f35 <.altinstr_replacement+0xf35>	f31: R_X86_64_PC32	.init.text+0x25ab2
0f35      f35:	e9 00 00 00 00       	jmp    f3a <.altinstr_replacement+0xf3a>	f36: R_X86_64_PC32	.init.text+0x25af1
0f3a      f3a:	e9 00 00 00 00       	jmp    f3f <.altinstr_replacement+0xf3f>	f3b: R_X86_64_PC32	.init.text+0x25abc
0f3f      f3f:	e9 00 00 00 00       	jmp    f44 <.altinstr_replacement+0xf44>	f40: R_X86_64_PC32	.init.text+0x25ac6
0f44      f44:	e9 00 00 00 00       	jmp    f49 <.altinstr_replacement+0xf49>	f45: R_X86_64_PC32	.init.text+0x25a71
0f49      f49:	e9 00 00 00 00       	jmp    f4e <.altinstr_replacement+0xf4e>	f4a: R_X86_64_PC32	.text+0x24eb85
0f4e      f4e:	e9 00 00 00 00       	jmp    f53 <.altinstr_replacement+0xf53>	f4f: R_X86_64_PC32	.text+0x24eb8c
0f53      f53:	e9 00 00 00 00       	jmp    f58 <.altinstr_replacement+0xf58>	f54: R_X86_64_PC32	.text+0x24ec15
0f58      f58:	e9 00 00 00 00       	jmp    f5d <.altinstr_replacement+0xf5d>	f59: R_X86_64_PC32	.text+0x24ec1c
0f5d      f5d:	e9 00 00 00 00       	jmp    f62 <.altinstr_replacement+0xf62>	f5e: R_X86_64_PC32	.meminit.text+0x4437
0f62      f62:	e9 00 00 00 00       	jmp    f67 <.altinstr_replacement+0xf67>	f63: R_X86_64_PC32	.meminit.text+0x460d
0f67      f67:	e9 00 00 00 00       	jmp    f6c <.altinstr_replacement+0xf6c>	f68: R_X86_64_PC32	.meminit.text+0x4617
0f6c      f6c:	e9 00 00 00 00       	jmp    f71 <.altinstr_replacement+0xf71>	f6d: R_X86_64_PC32	.text+0x24ec93
0f71      f71:	e9 00 00 00 00       	jmp    f76 <.altinstr_replacement+0xf76>	f72: R_X86_64_PC32	.meminit.text+0x4be9
0f76      f76:	e9 00 00 00 00       	jmp    f7b <.altinstr_replacement+0xf7b>	f77: R_X86_64_PC32	.meminit.text+0x4c6c
0f7b      f7b:	e9 00 00 00 00       	jmp    f80 <.altinstr_replacement+0xf80>	f7c: R_X86_64_PC32	.meminit.text+0x4c67
0f80      f80:	e9 00 00 00 00       	jmp    f85 <.altinstr_replacement+0xf85>	f81: R_X86_64_PC32	.meminit.text+0x4d2a
0f85      f85:	e9 00 00 00 00       	jmp    f8a <.altinstr_replacement+0xf8a>	f86: R_X86_64_PC32	.meminit.text+0x4d2a
0f8a      f8a:	e9 00 00 00 00       	jmp    f8f <.altinstr_replacement+0xf8f>	f8b: R_X86_64_PC32	.meminit.text+0x4d26
0f8f      f8f:	e9 00 00 00 00       	jmp    f94 <.altinstr_replacement+0xf94>	f90: R_X86_64_PC32	.meminit.text+0x4f90
0f94      f94:	e9 00 00 00 00       	jmp    f99 <.altinstr_replacement+0xf99>	f95: R_X86_64_PC32	.text+0x253e0f
0f99      f99:	e9 00 00 00 00       	jmp    f9e <.altinstr_replacement+0xf9e>	f9a: R_X86_64_PC32	.text+0x2553d6
0f9e      f9e:	e9 00 00 00 00       	jmp    fa3 <.altinstr_replacement+0xfa3>	f9f: R_X86_64_PC32	.text+0x2555d7
0fa3      fa3:	e9 00 00 00 00       	jmp    fa8 <.altinstr_replacement+0xfa8>	fa4: R_X86_64_PC32	.text+0x25610c
0fa8      fa8:	e9 00 00 00 00       	jmp    fad <.altinstr_replacement+0xfad>	fa9: R_X86_64_PC32	.text+0x25665c
0fad      fad:	e9 00 00 00 00       	jmp    fb2 <.altinstr_replacement+0xfb2>	fae: R_X86_64_PC32	.text+0x257523
0fb2      fb2:	e9 00 00 00 00       	jmp    fb7 <.altinstr_replacement+0xfb7>	fb3: R_X86_64_PC32	.text+0x257c3c
0fb7      fb7:	e9 00 00 00 00       	jmp    fbc <.altinstr_replacement+0xfbc>	fb8: R_X86_64_PC32	.text+0x257be1
0fbc      fbc:	e9 00 00 00 00       	jmp    fc1 <.altinstr_replacement+0xfc1>	fbd: R_X86_64_PC32	.text+0x25a77b
0fc1      fc1:	e8 00 00 00 00       	call   fc6 <.altinstr_replacement+0xfc6>	fc2: R_X86_64_PLT32	clear_page_rep-0x4
0fc6      fc6:	e8 00 00 00 00       	call   fcb <.altinstr_replacement+0xfcb>	fc7: R_X86_64_PLT32	clear_page_erms-0x4
0fcb      fcb:	e8 00 00 00 00       	call   fd0 <.altinstr_replacement+0xfd0>	fcc: R_X86_64_PLT32	clear_page_rep-0x4
0fd0      fd0:	e8 00 00 00 00       	call   fd5 <.altinstr_replacement+0xfd5>	fd1: R_X86_64_PLT32	clear_page_erms-0x4
0fd5      fd5:	e8 00 00 00 00       	call   fda <.altinstr_replacement+0xfda>	fd6: R_X86_64_PLT32	clear_page_rep-0x4
0fda      fda:	e8 00 00 00 00       	call   fdf <.altinstr_replacement+0xfdf>	fdb: R_X86_64_PLT32	clear_page_erms-0x4
0fdf      fdf:	e9 00 00 00 00       	jmp    fe4 <.altinstr_replacement+0xfe4>	fe0: R_X86_64_PC32	.text+0x25d5c8
0fe4      fe4:	e9 00 00 00 00       	jmp    fe9 <.altinstr_replacement+0xfe9>	fe5: R_X86_64_PC32	.text+0x25e0b3
0fe9      fe9:	e9 00 00 00 00       	jmp    fee <.altinstr_replacement+0xfee>	fea: R_X86_64_PC32	.text+0x27084c
0fee      fee:	e9 00 00 00 00       	jmp    ff3 <.altinstr_replacement+0xff3>	fef: R_X86_64_PC32	.text+0x270924
0ff3      ff3:	e9 00 00 00 00       	jmp    ff8 <.altinstr_replacement+0xff8>	ff4: R_X86_64_PC32	.text+0x2727a6
0ff8      ff8:	e9 00 00 00 00       	jmp    ffd <.altinstr_replacement+0xffd>	ff9: R_X86_64_PC32	.text+0x272856
0ffd      ffd:	e9 00 00 00 00       	jmp    1002 <.altinstr_replacement+0x1002>	ffe: R_X86_64_PC32	.text+0x27327b
1002     1002:	e9 00 00 00 00       	jmp    1007 <.altinstr_replacement+0x1007>	1003: R_X86_64_PC32	.meminit.text+0x53f5
1007     1007:	e9 00 00 00 00       	jmp    100c <.altinstr_replacement+0x100c>	1008: R_X86_64_PC32	.meminit.text+0x5473
100c     100c:	e9 00 00 00 00       	jmp    1011 <.altinstr_replacement+0x1011>	100d: R_X86_64_PC32	.init.text+0x2732f
1011     1011:	e9 00 00 00 00       	jmp    1016 <.altinstr_replacement+0x1016>	1012: R_X86_64_PC32	.init.text+0x27339
1016     1016:	e9 00 00 00 00       	jmp    101b <.altinstr_replacement+0x101b>	1017: R_X86_64_PC32	.text+0x27338c
101b     101b:	e9 00 00 00 00       	jmp    1020 <.altinstr_replacement+0x1020>	101c: R_X86_64_PC32	.text+0x273e85
1020     1020:	e9 00 00 00 00       	jmp    1025 <.altinstr_replacement+0x1025>	1021: R_X86_64_PC32	.text+0x273eba
1025     1025:	e9 00 00 00 00       	jmp    102a <.altinstr_replacement+0x102a>	1026: R_X86_64_PC32	.init.text+0x27866
102a     102a:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
1034     1034:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
103e     103e:	0f 01 cb             	stac
1041     1041:	0f ae e8             	lfence
1044     1044:	0f 01 ca             	clac
1047     1047:	0f 01 ca             	clac
104a     104a:	0f 01 cb             	stac
104d     104d:	0f ae e8             	lfence
1050     1050:	0f 01 ca             	clac
1053     1053:	0f 01 ca             	clac
1056     1056:	0f 01 cb             	stac
1059     1059:	0f ae e8             	lfence
105c     105c:	0f 01 ca             	clac
105f     105f:	0f 01 ca             	clac
1062     1062:	0f 01 cb             	stac
1065     1065:	0f ae e8             	lfence
1068     1068:	0f 01 ca             	clac
106b     106b:	0f 01 ca             	clac
106e     106e:	0f 01 cb             	stac
1071     1071:	e8 00 00 00 00       	call   1076 <.altinstr_replacement+0x1076>	1072: R_X86_64_PLT32	rep_movs_alternative-0x4
1076     1076:	0f 01 ca             	clac
1079     1079:	0f 01 cb             	stac
107c     107c:	e8 00 00 00 00       	call   1081 <.altinstr_replacement+0x1081>	107d: R_X86_64_PLT32	rep_movs_alternative-0x4
1081     1081:	0f 01 ca             	clac
1084     1084:	0f 01 cb             	stac
1087     1087:	e8 00 00 00 00       	call   108c <.altinstr_replacement+0x108c>	1088: R_X86_64_PLT32	rep_movs_alternative-0x4
108c     108c:	0f 01 ca             	clac
108f     108f:	0f 01 cb             	stac
1092     1092:	0f ae e8             	lfence
1095     1095:	0f 01 ca             	clac
1098     1098:	0f 01 ca             	clac
109b     109b:	f3 0f b8 c7          	popcnt %edi,%eax
109f     109f:	0f 01 cb             	stac
10a2     10a2:	e8 00 00 00 00       	call   10a7 <.altinstr_replacement+0x10a7>	10a3: R_X86_64_PLT32	rep_stos_alternative-0x4
10a7     10a7:	0f 01 ca             	clac
10aa     10aa:	e9 00 00 00 00       	jmp    10af <.altinstr_replacement+0x10af>	10ab: R_X86_64_PC32	.text+0x2c6fc4
10af     10af:	e9 00 00 00 00       	jmp    10b4 <.altinstr_replacement+0x10b4>	10b0: R_X86_64_PC32	.text+0x2c6ff7
10b4     10b4:	e9 00 00 00 00       	jmp    10b9 <.altinstr_replacement+0x10b9>	10b5: R_X86_64_PC32	.text+0x2c711a
10b9     10b9:	e9 00 00 00 00       	jmp    10be <.altinstr_replacement+0x10be>	10ba: R_X86_64_PC32	.text+0x2c71a1
10be     10be:	e9 00 00 00 00       	jmp    10c3 <.altinstr_replacement+0x10c3>	10bf: R_X86_64_PC32	.text+0x2c7249
10c3     10c3:	e9 00 00 00 00       	jmp    10c8 <.altinstr_replacement+0x10c8>	10c4: R_X86_64_PC32	.text+0x2dad1f
10c8     10c8:	e9 00 00 00 00       	jmp    10cd <.altinstr_replacement+0x10cd>	10c9: R_X86_64_PC32	.text+0x2db5ec
10cd     10cd:	e9 00 00 00 00       	jmp    10d2 <.altinstr_replacement+0x10d2>	10ce: R_X86_64_PC32	.text+0x2dbc3e
10d2     10d2:	e9 00 00 00 00       	jmp    10d7 <.altinstr_replacement+0x10d7>	10d3: R_X86_64_PC32	.text+0x2dbd15
10d7     10d7:	e9 00 00 00 00       	jmp    10dc <.altinstr_replacement+0x10dc>	10d8: R_X86_64_PC32	.text+0x2dc08f
10dc     10dc:	e9 00 00 00 00       	jmp    10e1 <.altinstr_replacement+0x10e1>	10dd: R_X86_64_PC32	.text+0x2dc5e3
10e1     10e1:	e9 00 00 00 00       	jmp    10e6 <.altinstr_replacement+0x10e6>	10e2: R_X86_64_PC32	.text+0x2dc9e8
10e6     10e6:	e9 00 00 00 00       	jmp    10eb <.altinstr_replacement+0x10eb>	10e7: R_X86_64_PC32	.text+0x2dca6d
10eb     10eb:	e9 00 00 00 00       	jmp    10f0 <.altinstr_replacement+0x10f0>	10ec: R_X86_64_PC32	.text+0x2dcaaa
10f0     10f0:	e9 00 00 00 00       	jmp    10f5 <.altinstr_replacement+0x10f5>	10f1: R_X86_64_PC32	.text+0x2dcb60
10f5     10f5:	e9 00 00 00 00       	jmp    10fa <.altinstr_replacement+0x10fa>	10f6: R_X86_64_PC32	.text+0x2dce1e
10fa     10fa:	e9 00 00 00 00       	jmp    10ff <.altinstr_replacement+0x10ff>	10fb: R_X86_64_PC32	.text+0x2dce9e
10ff     10ff:	e9 00 00 00 00       	jmp    1104 <.altinstr_replacement+0x1104>	1100: R_X86_64_PC32	.text+0x2dd2d5
1104     1104:	e9 00 00 00 00       	jmp    1109 <.altinstr_replacement+0x1109>	1105: R_X86_64_PC32	.text+0x2dd2e9
1109     1109:	e9 00 00 00 00       	jmp    110e <.altinstr_replacement+0x110e>	110a: R_X86_64_PC32	.text+0x2dd3c9
110e     110e:	e9 00 00 00 00       	jmp    1113 <.altinstr_replacement+0x1113>	110f: R_X86_64_PC32	.text+0x2e930a
1113     1113:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
111d     111d:	49 bf 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%r15
1127     1127:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
1131     1131:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
113b     113b:	0f 01 cb             	stac
113e     113e:	e8 00 00 00 00       	call   1143 <.altinstr_replacement+0x1143>	113f: R_X86_64_PLT32	rep_stos_alternative-0x4
1143     1143:	0f 01 ca             	clac
1146     1146:	0f 01 cb             	stac
1149     1149:	e8 00 00 00 00       	call   114e <.altinstr_replacement+0x114e>	114a: R_X86_64_PLT32	rep_stos_alternative-0x4
114e     114e:	0f 01 ca             	clac
1151     1151:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1156     1156:	f3 48 0f b8 c7       	popcnt %rdi,%rax
115b     115b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1160     1160:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1165     1165:	f3 48 0f b8 c7       	popcnt %rdi,%rax
116a     116a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
116f     116f:	0f 01 cb             	stac
1172     1172:	0f 01 ca             	clac
1175     1175:	0f 01 cb             	stac
1178     1178:	0f 01 ca             	clac
117b     117b:	0f 01 cb             	stac
117e     117e:	0f ae e8             	lfence
1181     1181:	0f 01 ca             	clac
1184     1184:	0f 01 cb             	stac
1187     1187:	0f ae e8             	lfence
118a     118a:	0f 01 ca             	clac
118d     118d:	0f 01 cb             	stac
1190     1190:	e8 00 00 00 00       	call   1195 <.altinstr_replacement+0x1195>	1191: R_X86_64_PLT32	rep_movs_alternative-0x4
1195     1195:	0f 01 ca             	clac
1198     1198:	0f 01 cb             	stac
119b     119b:	e8 00 00 00 00       	call   11a0 <.altinstr_replacement+0x11a0>	119c: R_X86_64_PLT32	rep_movs_alternative-0x4
11a0     11a0:	0f 01 ca             	clac
11a3     11a3:	0f 01 cb             	stac
11a6     11a6:	e8 00 00 00 00       	call   11ab <.altinstr_replacement+0x11ab>	11a7: R_X86_64_PLT32	rep_movs_alternative-0x4
11ab     11ab:	0f 01 ca             	clac
11ae     11ae:	0f 01 cb             	stac
11b1     11b1:	e8 00 00 00 00       	call   11b6 <.altinstr_replacement+0x11b6>	11b2: R_X86_64_PLT32	rep_movs_alternative-0x4
11b6     11b6:	0f 01 ca             	clac
11b9     11b9:	0f 01 cb             	stac
11bc     11bc:	e8 00 00 00 00       	call   11c1 <.altinstr_replacement+0x11c1>	11bd: R_X86_64_PLT32	rep_movs_alternative-0x4
11c1     11c1:	0f 01 ca             	clac
11c4     11c4:	0f 01 cb             	stac
11c7     11c7:	e8 00 00 00 00       	call   11cc <.altinstr_replacement+0x11cc>	11c8: R_X86_64_PLT32	rep_movs_alternative-0x4
11cc     11cc:	0f 01 ca             	clac
11cf     11cf:	0f 01 cb             	stac
11d2     11d2:	e8 00 00 00 00       	call   11d7 <.altinstr_replacement+0x11d7>	11d3: R_X86_64_PLT32	rep_stos_alternative-0x4
11d7     11d7:	0f 01 ca             	clac
11da     11da:	0f 01 cb             	stac
11dd     11dd:	e8 00 00 00 00       	call   11e2 <.altinstr_replacement+0x11e2>	11de: R_X86_64_PLT32	rep_stos_alternative-0x4
11e2     11e2:	0f 01 ca             	clac
11e5     11e5:	f3 48 0f b8 c7       	popcnt %rdi,%rax
11ea     11ea:	f3 48 0f b8 c7       	popcnt %rdi,%rax
11ef     11ef:	f3 48 0f b8 c7       	popcnt %rdi,%rax
11f4     11f4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
11f9     11f9:	f3 0f b8 c7          	popcnt %edi,%eax
11fd     11fd:	f3 0f b8 c7          	popcnt %edi,%eax
1201     1201:	0f 01 cb             	stac
1204     1204:	0f ae e8             	lfence
1207     1207:	0f 01 ca             	clac
120a     120a:	0f 01 ca             	clac
120d     120d:	0f ae e8             	lfence
1210     1210:	0f 01 cb             	stac
1213     1213:	e8 00 00 00 00       	call   1218 <.altinstr_replacement+0x1218>	1214: R_X86_64_PLT32	rep_movs_alternative-0x4
1218     1218:	0f 01 ca             	clac
121b     121b:	0f 01 cb             	stac
121e     121e:	e8 00 00 00 00       	call   1223 <.altinstr_replacement+0x1223>	121f: R_X86_64_PLT32	rep_movs_alternative-0x4
1223     1223:	0f 01 ca             	clac
1226     1226:	f3 0f b8 c7          	popcnt %edi,%eax
122a     122a:	f3 0f b8 c7          	popcnt %edi,%eax
122e     122e:	48 b8 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rax
1238     1238:	0f 01 cb             	stac
123b     123b:	0f ae e8             	lfence
123e     123e:	0f 01 ca             	clac
1241     1241:	48 ba 00 f0 ff ff ff ff ff 00 	movabs $0xfffffffffff000,%rdx
124b     124b:	0f 01 cb             	stac
124e     124e:	0f ae e8             	lfence
1251     1251:	0f 01 ca             	clac
1254     1254:	9c                   	pushf
1255     1255:	41 5e                	pop    %r14
1257     1257:	0f 01 ca             	clac
125a     125a:	41 56                	push   %r14
125c     125c:	9d                   	popf
125d     125d:	9c                   	pushf
125e     125e:	41 5d                	pop    %r13
1260     1260:	0f 01 ca             	clac
1263     1263:	41 55                	push   %r13
1265     1265:	9d                   	popf
1266     1266:	9c                   	pushf
1267     1267:	5b                   	pop    %rbx
1268     1268:	0f 01 ca             	clac
126b     126b:	53                   	push   %rbx
126c     126c:	9d                   	popf
126d     126d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1272     1272:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1277     1277:	f3 0f b8 c7          	popcnt %edi,%eax
127b     127b:	f3 0f b8 c7          	popcnt %edi,%eax
127f     127f:	0f 01 cb             	stac
1282     1282:	e8 00 00 00 00       	call   1287 <.altinstr_replacement+0x1287>	1283: R_X86_64_PLT32	rep_stos_alternative-0x4
1287     1287:	0f 01 ca             	clac
128a     128a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
128f     128f:	e9 00 00 00 00       	jmp    1294 <.altinstr_replacement+0x1294>	1290: R_X86_64_PC32	.text+0x4ccf2b
1294     1294:	e9 00 00 00 00       	jmp    1299 <.altinstr_replacement+0x1299>	1295: R_X86_64_PC32	.text+0x4ccf4e
1299     1299:	f3 48 0f b8 c7       	popcnt %rdi,%rax
129e     129e:	e9 00 00 00 00       	jmp    12a3 <.altinstr_replacement+0x12a3>	129f: R_X86_64_PC32	.init.text+0x42c77
12a3     12a3:	e9 00 00 00 00       	jmp    12a8 <.altinstr_replacement+0x12a8>	12a4: R_X86_64_PC32	.init.text+0x42c90
12a8     12a8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12ad     12ad:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12b2     12b2:	e9 00 00 00 00       	jmp    12b7 <.altinstr_replacement+0x12b7>	12b3: R_X86_64_PC32	.init.text+0x44237
12b7     12b7:	f3 0f b8 c7          	popcnt %edi,%eax
12bb     12bb:	f3 0f b8 c7          	popcnt %edi,%eax
12bf     12bf:	f3 0f b8 c7          	popcnt %edi,%eax
12c3     12c3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12c8     12c8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12cd     12cd:	f3 0f b8 c7          	popcnt %edi,%eax
12d1     12d1:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12d6     12d6:	e9 00 00 00 00       	jmp    12db <.altinstr_replacement+0x12db>	12d7: R_X86_64_PC32	.text+0x5b99d9
12db     12db:	e9 00 00 00 00       	jmp    12e0 <.altinstr_replacement+0x12e0>	12dc: R_X86_64_PC32	.text+0x5ea3f4
12e0     12e0:	e9 00 00 00 00       	jmp    12e5 <.altinstr_replacement+0x12e5>	12e1: R_X86_64_PC32	.text+0x5ea43a
12e5     12e5:	0f 01 cb             	stac
12e8     12e8:	0f 01 ca             	clac
12eb     12eb:	0f 01 cb             	stac
12ee     12ee:	e8 00 00 00 00       	call   12f3 <.altinstr_replacement+0x12f3>	12ef: R_X86_64_PLT32	rep_movs_alternative-0x4
12f3     12f3:	0f 01 ca             	clac
12f6     12f6:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
12f8     12f8:	0f 01 cb             	stac
12fb     12fb:	0f ae e8             	lfence
12fe     12fe:	0f 01 ca             	clac
1301     1301:	0f 01 cb             	stac
1304     1304:	0f ae e8             	lfence
1307     1307:	0f 01 ca             	clac
130a     130a:	0f ae e8             	lfence
130d     130d:	0f 31                	rdtsc
130f     130f:	0f 01 f9             	rdtscp
1312     1312:	0f ae e8             	lfence
1315     1315:	0f 31                	rdtsc
1317     1317:	0f 01 f9             	rdtscp
131a     131a:	0f ae e8             	lfence
131d     131d:	0f 31                	rdtsc
131f     131f:	0f 01 f9             	rdtscp
1322     1322:	0f ae e8             	lfence
1325     1325:	0f 31                	rdtsc
1327     1327:	0f 01 f9             	rdtscp
132a     132a:	0f 01 cb             	stac
132d     132d:	0f 01 ca             	clac
1330     1330:	0f 01 cb             	stac
1333     1333:	0f 01 ca             	clac
1336     1336:	0f 01 cb             	stac
1339     1339:	0f 01 ca             	clac
133c     133c:	0f 01 cb             	stac
133f     133f:	0f 01 ca             	clac
1342     1342:	0f 01 cb             	stac
1345     1345:	0f ae e8             	lfence
1348     1348:	0f 01 ca             	clac
134b     134b:	0f 01 cb             	stac
134e     134e:	0f ae e8             	lfence
1351     1351:	0f 01 ca             	clac
1354     1354:	0f 01 cb             	stac
1357     1357:	0f ae e8             	lfence
135a     135a:	0f 01 ca             	clac
135d     135d:	0f 01 cb             	stac
1360     1360:	0f ae e8             	lfence
1363     1363:	0f 01 ca             	clac
1366     1366:	0f 01 ca             	clac
1369     1369:	0f 01 cb             	stac
136c     136c:	e8 00 00 00 00       	call   1371 <.altinstr_replacement+0x1371>	136d: R_X86_64_PLT32	rep_movs_alternative-0x4
1371     1371:	0f 01 ca             	clac
1374     1374:	48 83 fa 20          	cmp    $0x20,%rdx
1378     1378:	0f 82 00 00 00 00    	jb     137e <.altinstr_replacement+0x137e>	137a: R_X86_64_PC32	.noinstr.text+0x25a2
137e     137e:	48 89 d1             	mov    %rdx,%rcx
1381     1381:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
1383     1383:	e9 00 00 00 00       	jmp    1388 <.altinstr_replacement+0x1388>	1384: R_X86_64_PLT32	__x86_return_thunk-0x4
1388     1388:	48 89 d1             	mov    %rdx,%rcx
138b     138b:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
138d     138d:	e9 00 00 00 00       	jmp    1392 <.altinstr_replacement+0x1392>	138e: R_X86_64_PLT32	__x86_return_thunk-0x4
1392     1392:	0f 01 cb             	stac
1395     1395:	0f 01 ca             	clac
1398     1398:	0f 01 cb             	stac
139b     139b:	0f 01 ca             	clac
139e     139e:	0f 01 cb             	stac
13a1     13a1:	0f 01 ca             	clac
13a4     13a4:	0f 01 cb             	stac
13a7     13a7:	0f 01 ca             	clac
13aa     13aa:	0f 01 cb             	stac
13ad     13ad:	0f 01 ca             	clac
13b0     13b0:	0f 01 cb             	stac
13b3     13b3:	0f 01 ca             	clac
13b6     13b6:	0f 01 cb             	stac
13b9     13b9:	0f 01 ca             	clac
13bc     13bc:	0f 01 cb             	stac
13bf     13bf:	0f 01 ca             	clac
13c2     13c2:	0f 01 ca             	clac
13c5     13c5:	0f ae e8             	lfence
13c8     13c8:	ff e0                	jmp    *%rax
13ca     13ca:	cc                   	int3
13cb     13cb:	ff e0                	jmp    *%rax
13cd     13cd:	0f ae e8             	lfence
13d0     13d0:	ff e1                	jmp    *%rcx
13d2     13d2:	cc                   	int3
13d3     13d3:	ff e1                	jmp    *%rcx
13d5     13d5:	0f ae e8             	lfence
13d8     13d8:	ff e2                	jmp    *%rdx
13da     13da:	cc                   	int3
13db     13db:	ff e2                	jmp    *%rdx
13dd     13dd:	0f ae e8             	lfence
13e0     13e0:	ff e3                	jmp    *%rbx
13e2     13e2:	cc                   	int3
13e3     13e3:	ff e3                	jmp    *%rbx
13e5     13e5:	0f ae e8             	lfence
13e8     13e8:	ff e4                	jmp    *%rsp
13ea     13ea:	cc                   	int3
13eb     13eb:	ff e4                	jmp    *%rsp
13ed     13ed:	0f ae e8             	lfence
13f0     13f0:	ff e5                	jmp    *%rbp
13f2     13f2:	cc                   	int3
13f3     13f3:	ff e5                	jmp    *%rbp
13f5     13f5:	0f ae e8             	lfence
13f8     13f8:	ff e6                	jmp    *%rsi
13fa     13fa:	cc                   	int3
13fb     13fb:	ff e6                	jmp    *%rsi
13fd     13fd:	0f ae e8             	lfence
1400     1400:	ff e7                	jmp    *%rdi
1402     1402:	cc                   	int3
1403     1403:	ff e7                	jmp    *%rdi
1405     1405:	0f ae e8             	lfence
1408     1408:	41 ff e0             	jmp    *%r8
140b     140b:	cc                   	int3
140c     140c:	41 ff e0             	jmp    *%r8
140f     140f:	0f ae e8             	lfence
1412     1412:	41 ff e1             	jmp    *%r9
1415     1415:	cc                   	int3
1416     1416:	41 ff e1             	jmp    *%r9
1419     1419:	0f ae e8             	lfence
141c     141c:	41 ff e2             	jmp    *%r10
141f     141f:	cc                   	int3
1420     1420:	41 ff e2             	jmp    *%r10
1423     1423:	0f ae e8             	lfence
1426     1426:	41 ff e3             	jmp    *%r11
1429     1429:	cc                   	int3
142a     142a:	41 ff e3             	jmp    *%r11
142d     142d:	0f ae e8             	lfence
1430     1430:	41 ff e4             	jmp    *%r12
1433     1433:	cc                   	int3
1434     1434:	41 ff e4             	jmp    *%r12
1437     1437:	0f ae e8             	lfence
143a     143a:	41 ff e5             	jmp    *%r13
143d     143d:	cc                   	int3
143e     143e:	41 ff e5             	jmp    *%r13
1441     1441:	0f ae e8             	lfence
1444     1444:	41 ff e6             	jmp    *%r14
1447     1447:	cc                   	int3
1448     1448:	41 ff e6             	jmp    *%r14
144b     144b:	0f ae e8             	lfence
144e     144e:	41 ff e7             	jmp    *%r15
1451     1451:	cc                   	int3
1452     1452:	41 ff e7             	jmp    *%r15
1455     1455:	0f 01 cb             	stac
1458     1458:	e8 00 00 00 00       	call   145d <.altinstr_replacement+0x145d>	1459: R_X86_64_PLT32	rep_movs_alternative-0x4
145d     145d:	0f 01 ca             	clac
1460     1460:	66 0f ae 38          	clflushopt (%rax)
1464     1464:	66 0f ae 30          	clwb   (%rax)
1468     1468:	0f 01 cb             	stac
146b     146b:	0f 01 ca             	clac

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

