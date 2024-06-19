Return-Path: <linux-kernel+bounces-220411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6574B90E162
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF111F2303E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB5AD2FA;
	Wed, 19 Jun 2024 01:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yenc8zSE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338806AAD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761419; cv=none; b=OPyGmjpdKKWZTjGAhOHVAnQKJr7mlwccGUZ/XwFi6ESD+RgHViwU4WZIAf+L5N8OYzTEqGuJJ09FygMRpb6RTi1d2rOqDXc3Er+/Fg5CiMTtFMhtps1h8WSJts/jLtpsVc13gu5X6AbjzQNL7lV/xHeST87/PJ7m/aFheWUDYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761419; c=relaxed/simple;
	bh=RI6tYISrPF7j4/EL01q64TNlSOmJrZJaeTBYjndtdaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z3BORRBA5D/KZxHkYTd0Uri5630hXmifIS96J9hVBOt3BRrOt3nc28M3qbSX9jrdmgIQMZ9PiAzGtD3zQpS5C9LzQ3krGijzIwGGGuLAfyYHkKlmN8Zsp8qJ7+o0OFT4Q/ps1x6Y23Es/SBYcvlbyk3+MJlo8scJltX/rKi2GJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yenc8zSE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718761415; x=1750297415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RI6tYISrPF7j4/EL01q64TNlSOmJrZJaeTBYjndtdaU=;
  b=Yenc8zSEXkEB9lzfjO/4H29XG1B7AGMbSmgFxKhbJSrAQHHRHmFOBbPz
   NCi3QjZSTkh8GMqGoPRfnOm77Ry5b8oQvPaX1aXvCB4dxAeRThqTzbFUs
   90v5YyDI8i8Ar7fCF3d2GSPDQZndEYHEunA46FVnVDFRY+kkTnZ7L56Y5
   AszemFJIIBXSOHyAIzoA6TxwFfekwFVWZpFqGse9FSRQHglhJscNdnIKV
   ykXVXoDTjsoG7xdnUc/oVAGg57vat4lJyl1dRLm+P0vMvpPVPw/azIJVQ
   nNkcweshljZGCHYT9GwVjSnSBqMXvDKrTWZVLAo9GAkhq9Smz6y+FlZKs
   w==;
X-CSE-ConnectionGUID: LmpyZj0STJiEDSo5dfSpbQ==
X-CSE-MsgGUID: CTBPJSYRRgGzJUarL+qB5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="18592673"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="18592673"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 18:43:35 -0700
X-CSE-ConnectionGUID: DyMMBET+TD6IdNpwRjM62g==
X-CSE-MsgGUID: LYwRwUCFThykgT+adqFppg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="72954575"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Jun 2024 18:43:32 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJkME-00068l-22;
	Wed, 19 Jun 2024 01:43:30 +0000
Date: Wed, 19 Jun 2024 09:43:13 +0800
From: kernel test robot <lkp@intel.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:x86/alternatives 14/14] arch/x86/kvm/emulate.o: warning:
 objtool: .altinstr_replacement+0x12: call without frame pointer save/setup
Message-ID: <202406190909.XhOnJC4Z-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-r005-20220613 (https://download.01.org/0day-ci/archive/20240619/202406190909.XhOnJC4Z-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240619/202406190909.XhOnJC4Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406190909.XhOnJC4Z-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kvm/emulate.o: warning: objtool: .altinstr_replacement+0x12: call without frame pointer save/setup


objdump-func vmlinux.o .altinstr_replacement:
0000 0000000000000000 <.altinstr_replacement>:
0000        0:	48 0f ba ec 3f       	bts    $0x3f,%rsp
0005        5:	e8 00 00 00 00       	call   a <.altinstr_replacement+0xa>	6: R_X86_64_PLT32	entry_untrain_ret-0x4
000a        a:	e8 00 00 00 00       	call   f <.altinstr_replacement+0xf>	b: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
000f        f:	e8 00 00 00 00       	call   14 <.altinstr_replacement+0x14>	10: R_X86_64_PLT32	entry_ibpb-0x4
0014       14:	31 c0                	xor    %eax,%eax
0016       16:	48 0f ba e8 3f       	bts    $0x3f,%rax
001b       1b:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 23 <.altinstr_replacement+0x23>	1f: R_X86_64_PC32	pcpu_hot+0xc
0023       23:	e8 00 00 00 00       	call   28 <.altinstr_replacement+0x28>	24: R_X86_64_PLT32	clear_bhb_loop-0x4
0028       28:	e9 00 00 00 00       	jmp    2d <.altinstr_replacement+0x2d>	29: R_X86_64_PLT32	swapgs_restore_regs_and_return_to_usermode-0x4
002d       2d:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 34 <.altinstr_replacement+0x34>	30: R_X86_64_PC32	mds_verw_sel-0x4
0034       34:	49 c7 c4 10 00 00 00 	mov    $0x10,%r12
003b       3b:	e8 01 00 00 00       	call   41 <.altinstr_replacement+0x41>
0040       40:	cc                   	int3
0041       41:	e8 01 00 00 00       	call   47 <.altinstr_replacement+0x47>
0046       46:	cc                   	int3
0047       47:	48 83 c4 10          	add    $0x10,%rsp
004b       4b:	49 ff cc             	dec    %r12
004e       4e:	75 eb                	jne    3b <.altinstr_replacement+0x3b>
0050       50:	0f ae e8             	lfence
0053       53:	65 48 c7 05 00 00 00 00 ff ff ff ff 	movq   $0xffffffffffffffff,%gs:0x0(%rip)        # 5f <.altinstr_replacement+0x5f>	57: R_X86_64_PC32	pcpu_hot+0x8
005f       5f:	90                   	nop
0060       60:	90                   	nop
0061       61:	e8 01 00 00 00       	call   67 <.altinstr_replacement+0x67>
0066       66:	cc                   	int3
0067       67:	48 83 c4 08          	add    $0x8,%rsp
006b       6b:	0f ae e8             	lfence
006e       6e:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 77 <.altinstr_replacement+0x77>	72: R_X86_64_PC32	pcpu_hot+0xb
0077       77:	e8 00 00 00 00       	call   7c <.altinstr_replacement+0x7c>	78: R_X86_64_PLT32	entry_untrain_ret-0x4
007c       7c:	e8 00 00 00 00       	call   81 <.altinstr_replacement+0x81>	7d: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
0081       81:	e8 00 00 00 00       	call   86 <.altinstr_replacement+0x86>	82: R_X86_64_PLT32	entry_ibpb-0x4
0086       86:	b0 fc                	mov    $0xfc,%al
0088       88:	48 c1 e0 38          	shl    $0x38,%rax
008c       8c:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 94 <.altinstr_replacement+0x94>	90: R_X86_64_PC32	pcpu_hot+0xc
0094       94:	0f 01 ca             	clac
0097       97:	e8 00 00 00 00       	call   9c <.altinstr_replacement+0x9c>	98: R_X86_64_PLT32	xen_error_entry-0x4
009c       9c:	0f 01 ca             	clac
009f       9f:	e8 00 00 00 00       	call   a4 <.altinstr_replacement+0xa4>	a0: R_X86_64_PLT32	xen_error_entry-0x4
00a4       a4:	0f 01 ca             	clac
00a7       a7:	e8 00 00 00 00       	call   ac <.altinstr_replacement+0xac>	a8: R_X86_64_PLT32	xen_error_entry-0x4
00ac       ac:	0f 01 ca             	clac
00af       af:	e8 00 00 00 00       	call   b4 <.altinstr_replacement+0xb4>	b0: R_X86_64_PLT32	xen_error_entry-0x4
00b4       b4:	0f 01 ca             	clac
00b7       b7:	e8 00 00 00 00       	call   bc <.altinstr_replacement+0xbc>	b8: R_X86_64_PLT32	xen_error_entry-0x4
00bc       bc:	0f 01 ca             	clac
00bf       bf:	e8 00 00 00 00       	call   c4 <.altinstr_replacement+0xc4>	c0: R_X86_64_PLT32	xen_error_entry-0x4
00c4       c4:	0f 01 ca             	clac
00c7       c7:	e8 00 00 00 00       	call   cc <.altinstr_replacement+0xcc>	c8: R_X86_64_PLT32	xen_error_entry-0x4
00cc       cc:	0f 01 ca             	clac
00cf       cf:	e8 00 00 00 00       	call   d4 <.altinstr_replacement+0xd4>	d0: R_X86_64_PLT32	xen_error_entry-0x4
00d4       d4:	0f 01 ca             	clac
00d7       d7:	e8 00 00 00 00       	call   dc <.altinstr_replacement+0xdc>	d8: R_X86_64_PLT32	xen_error_entry-0x4
00dc       dc:	0f 01 ca             	clac
00df       df:	e8 00 00 00 00       	call   e4 <.altinstr_replacement+0xe4>	e0: R_X86_64_PLT32	xen_error_entry-0x4
00e4       e4:	0f 01 ca             	clac
00e7       e7:	e8 00 00 00 00       	call   ec <.altinstr_replacement+0xec>	e8: R_X86_64_PLT32	xen_error_entry-0x4
00ec       ec:	0f 01 ca             	clac
00ef       ef:	e8 00 00 00 00       	call   f4 <.altinstr_replacement+0xf4>	f0: R_X86_64_PLT32	xen_error_entry-0x4
00f4       f4:	0f 01 ca             	clac
00f7       f7:	e8 00 00 00 00       	call   fc <.altinstr_replacement+0xfc>	f8: R_X86_64_PLT32	xen_error_entry-0x4
00fc       fc:	0f 01 ca             	clac
00ff       ff:	e8 00 00 00 00       	call   104 <.altinstr_replacement+0x104>	100: R_X86_64_PLT32	xen_error_entry-0x4
0104      104:	0f 01 ca             	clac
0107      107:	e8 00 00 00 00       	call   10c <.altinstr_replacement+0x10c>	108: R_X86_64_PLT32	xen_error_entry-0x4
010c      10c:	0f 01 ca             	clac
010f      10f:	e8 00 00 00 00       	call   114 <.altinstr_replacement+0x114>	110: R_X86_64_PLT32	xen_error_entry-0x4
0114      114:	0f 01 ca             	clac
0117      117:	e8 00 00 00 00       	call   11c <.altinstr_replacement+0x11c>	118: R_X86_64_PLT32	xen_error_entry-0x4
011c      11c:	0f 01 ca             	clac
011f      11f:	e8 00 00 00 00       	call   124 <.altinstr_replacement+0x124>	120: R_X86_64_PLT32	xen_error_entry-0x4
0124      124:	0f 01 ca             	clac
0127      127:	0f 01 ca             	clac
012a      12a:	e8 00 00 00 00       	call   12f <.altinstr_replacement+0x12f>	12b: R_X86_64_PLT32	xen_error_entry-0x4
012f      12f:	0f 01 ca             	clac
0132      132:	e8 00 00 00 00       	call   137 <.altinstr_replacement+0x137>	133: R_X86_64_PLT32	xen_error_entry-0x4
0137      137:	0f 01 ca             	clac
013a      13a:	e8 00 00 00 00       	call   13f <.altinstr_replacement+0x13f>	13b: R_X86_64_PLT32	xen_error_entry-0x4
013f      13f:	0f 01 ca             	clac
0142      142:	e8 00 00 00 00       	call   147 <.altinstr_replacement+0x147>	143: R_X86_64_PLT32	xen_error_entry-0x4
0147      147:	0f 01 ca             	clac
014a      14a:	e8 00 00 00 00       	call   14f <.altinstr_replacement+0x14f>	14b: R_X86_64_PLT32	xen_error_entry-0x4
014f      14f:	0f 01 ca             	clac
0152      152:	e8 00 00 00 00       	call   157 <.altinstr_replacement+0x157>	153: R_X86_64_PLT32	xen_error_entry-0x4
0157      157:	0f 01 ca             	clac
015a      15a:	e8 00 00 00 00       	call   15f <.altinstr_replacement+0x15f>	15b: R_X86_64_PLT32	xen_error_entry-0x4
015f      15f:	0f 01 ca             	clac
0162      162:	e8 00 00 00 00       	call   167 <.altinstr_replacement+0x167>	163: R_X86_64_PLT32	xen_error_entry-0x4
0167      167:	0f 01 ca             	clac
016a      16a:	e8 00 00 00 00       	call   16f <.altinstr_replacement+0x16f>	16b: R_X86_64_PLT32	xen_error_entry-0x4
016f      16f:	0f 01 ca             	clac
0172      172:	e8 00 00 00 00       	call   177 <.altinstr_replacement+0x177>	173: R_X86_64_PLT32	xen_error_entry-0x4
0177      177:	0f 01 ca             	clac
017a      17a:	e8 00 00 00 00       	call   17f <.altinstr_replacement+0x17f>	17b: R_X86_64_PLT32	xen_error_entry-0x4
017f      17f:	0f 01 ca             	clac
0182      182:	e8 00 00 00 00       	call   187 <.altinstr_replacement+0x187>	183: R_X86_64_PLT32	xen_error_entry-0x4
0187      187:	0f 01 ca             	clac
018a      18a:	e8 00 00 00 00       	call   18f <.altinstr_replacement+0x18f>	18b: R_X86_64_PLT32	xen_error_entry-0x4
018f      18f:	0f 01 ca             	clac
0192      192:	e8 00 00 00 00       	call   197 <.altinstr_replacement+0x197>	193: R_X86_64_PLT32	xen_error_entry-0x4
0197      197:	0f 01 ca             	clac
019a      19a:	e8 00 00 00 00       	call   19f <.altinstr_replacement+0x19f>	19b: R_X86_64_PLT32	xen_error_entry-0x4
019f      19f:	e9 00 00 00 00       	jmp    1a4 <.altinstr_replacement+0x1a4>	1a0: R_X86_64_PC32	.entry.text+0xe9d
01a4      1a4:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 1ab <.altinstr_replacement+0x1ab>	1a7: R_X86_64_PC32	mds_verw_sel-0x4
01ab      1ab:	48 0f ba ef 3f       	bts    $0x3f,%rdi
01b0      1b0:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 1b7 <.altinstr_replacement+0x1b7>	1b3: R_X86_64_PC32	mds_verw_sel-0x4
01b7      1b7:	0f ae f0             	mfence
01ba      1ba:	b8 2b 00 00 00       	mov    $0x2b,%eax
01bf      1bf:	8e e8                	mov    %eax,%gs
01c1      1c1:	48 0f ba e8 3f       	bts    $0x3f,%rax
01c6      1c6:	0f ae e8             	lfence
01c9      1c9:	e8 00 00 00 00       	call   1ce <.altinstr_replacement+0x1ce>	1ca: R_X86_64_PLT32	entry_untrain_ret-0x4
01ce      1ce:	e8 00 00 00 00       	call   1d3 <.altinstr_replacement+0x1d3>	1cf: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
01d3      1d3:	e8 00 00 00 00       	call   1d8 <.altinstr_replacement+0x1d8>	1d4: R_X86_64_PLT32	entry_ibpb-0x4
01d8      1d8:	b0 fc                	mov    $0xfc,%al
01da      1da:	48 c1 e0 38          	shl    $0x38,%rax
01de      1de:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 1e6 <.altinstr_replacement+0x1e6>	1e2: R_X86_64_PC32	pcpu_hot+0xc
01e6      1e6:	0f ae e8             	lfence
01e9      1e9:	48 0f ba e8 3f       	bts    $0x3f,%rax
01ee      1ee:	e8 00 00 00 00       	call   1f3 <.altinstr_replacement+0x1f3>	1ef: R_X86_64_PLT32	entry_untrain_ret-0x4
01f3      1f3:	e8 00 00 00 00       	call   1f8 <.altinstr_replacement+0x1f8>	1f4: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
01f8      1f8:	e8 00 00 00 00       	call   1fd <.altinstr_replacement+0x1fd>	1f9: R_X86_64_PLT32	entry_ibpb-0x4
01fd      1fd:	b0 fc                	mov    $0xfc,%al
01ff      1ff:	48 c1 e0 38          	shl    $0x38,%rax
0203      203:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 20b <.altinstr_replacement+0x20b>	207: R_X86_64_PC32	pcpu_hot+0xc
020b      20b:	0f ae e8             	lfence
020e      20e:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 217 <.altinstr_replacement+0x217>	212: R_X86_64_PC32	pcpu_hot+0xb
0217      217:	0f ae e8             	lfence
021a      21a:	48 0f ba e8 3f       	bts    $0x3f,%rax
021f      21f:	e8 00 00 00 00       	call   224 <.altinstr_replacement+0x224>	220: R_X86_64_PLT32	entry_untrain_ret-0x4
0224      224:	e8 00 00 00 00       	call   229 <.altinstr_replacement+0x229>	225: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
0229      229:	e8 00 00 00 00       	call   22e <.altinstr_replacement+0x22e>	22a: R_X86_64_PLT32	entry_ibpb-0x4
022e      22e:	b0 fc                	mov    $0xfc,%al
0230      230:	48 c1 e0 38          	shl    $0x38,%rax
0234      234:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 23c <.altinstr_replacement+0x23c>	238: R_X86_64_PC32	pcpu_hot+0xc
023c      23c:	0f 01 ca             	clac
023f      23f:	0f ae e8             	lfence
0242      242:	48 0f ba ea 3f       	bts    $0x3f,%rdx
0247      247:	e8 00 00 00 00       	call   24c <.altinstr_replacement+0x24c>	248: R_X86_64_PLT32	entry_untrain_ret-0x4
024c      24c:	e8 00 00 00 00       	call   251 <.altinstr_replacement+0x251>	24d: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
0251      251:	e8 00 00 00 00       	call   256 <.altinstr_replacement+0x256>	252: R_X86_64_PLT32	entry_ibpb-0x4
0256      256:	31 c0                	xor    %eax,%eax
0258      258:	48 0f ba e8 3f       	bts    $0x3f,%rax
025d      25d:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 265 <.altinstr_replacement+0x265>	261: R_X86_64_PC32	pcpu_hot+0xc
0265      265:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 26c <.altinstr_replacement+0x26c>	268: R_X86_64_PC32	mds_verw_sel-0x4
026c      26c:	e9 00 00 00 00       	jmp    271 <.altinstr_replacement+0x271>	26d: R_X86_64_PC32	.init.text+0x4753
0271      271:	e9 00 00 00 00       	jmp    276 <.altinstr_replacement+0x276>	272: R_X86_64_PC32	.text+0x42dd
0276      276:	f3 48 0f b8 c7       	popcnt %rdi,%rax
027b      27b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0280      280:	f3 0f b8 c7          	popcnt %edi,%eax
0284      284:	e9 00 00 00 00       	jmp    289 <.altinstr_replacement+0x289>	285: R_X86_64_PC32	.text+0x9473
0289      289:	e9 00 00 00 00       	jmp    28e <.altinstr_replacement+0x28e>	28a: R_X86_64_PC32	.text+0x9495
028e      28e:	e9 00 00 00 00       	jmp    293 <.altinstr_replacement+0x293>	28f: R_X86_64_PC32	.text+0x94b0
0293      293:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0298      298:	f3 48 0f b8 c7       	popcnt %rdi,%rax
029d      29d:	f3 48 0f b8 c7       	popcnt %rdi,%rax
02a2      2a2:	e9 00 00 00 00       	jmp    2a7 <.altinstr_replacement+0x2a7>	2a3: R_X86_64_PC32	.text+0xabe5
02a7      2a7:	e9 00 00 00 00       	jmp    2ac <.altinstr_replacement+0x2ac>	2a8: R_X86_64_PC32	.text+0xb361
02ac      2ac:	e9 00 00 00 00       	jmp    2b1 <.altinstr_replacement+0x2b1>	2ad: R_X86_64_PC32	.text+0xb3d8
02b1      2b1:	f3 0f b8 c7          	popcnt %edi,%eax
02b5      2b5:	0f ae e8             	lfence
02b8      2b8:	0f 31                	rdtsc
02ba      2ba:	0f 01 f9             	rdtscp
02bd      2bd:	0f ae e8             	lfence
02c0      2c0:	0f 31                	rdtsc
02c2      2c2:	0f 01 f9             	rdtscp
02c5      2c5:	0f ae e8             	lfence
02c8      2c8:	0f 31                	rdtsc
02ca      2ca:	0f 01 f9             	rdtscp
02cd      2cd:	f3 48 0f b8 c7       	popcnt %rdi,%rax
02d2      2d2:	f3 48 0f b8 c7       	popcnt %rdi,%rax
02d7      2d7:	e9 00 00 00 00       	jmp    2dc <.altinstr_replacement+0x2dc>	2d8: R_X86_64_PC32	.init.text+0x8561
02dc      2dc:	e9 00 00 00 00       	jmp    2e1 <.altinstr_replacement+0x2e1>	2dd: R_X86_64_PC32	.text+0x190a5
02e1      2e1:	e9 00 00 00 00       	jmp    2e6 <.altinstr_replacement+0x2e6>	2e2: R_X86_64_PC32	.text+0x190cc
02e6      2e6:	e9 00 00 00 00       	jmp    2eb <.altinstr_replacement+0x2eb>	2e7: R_X86_64_PC32	.text+0x19111
02eb      2eb:	e9 00 00 00 00       	jmp    2f0 <.altinstr_replacement+0x2f0>	2ec: R_X86_64_PC32	.text+0x1910b
02f0      2f0:	e9 00 00 00 00       	jmp    2f5 <.altinstr_replacement+0x2f5>	2f1: R_X86_64_PC32	.text+0x1919d
02f5      2f5:	e9 00 00 00 00       	jmp    2fa <.altinstr_replacement+0x2fa>	2f6: R_X86_64_PC32	.text+0x19374
02fa      2fa:	e9 00 00 00 00       	jmp    2ff <.altinstr_replacement+0x2ff>	2fb: R_X86_64_PC32	.text+0x19a4c
02ff      2ff:	e9 00 00 00 00       	jmp    304 <.altinstr_replacement+0x304>	300: R_X86_64_PC32	.text+0x19c0f
0304      304:	e9 00 00 00 00       	jmp    309 <.altinstr_replacement+0x309>	305: R_X86_64_PC32	.text+0x19bbe
0309      309:	e9 00 00 00 00       	jmp    30e <.altinstr_replacement+0x30e>	30a: R_X86_64_PC32	.text+0x19c2f
030e      30e:	e9 00 00 00 00       	jmp    313 <.altinstr_replacement+0x313>	30f: R_X86_64_PC32	.text+0x19c00
0313      313:	e9 00 00 00 00       	jmp    318 <.altinstr_replacement+0x318>	314: R_X86_64_PC32	.text+0x19d50
0318      318:	e9 00 00 00 00       	jmp    31d <.altinstr_replacement+0x31d>	319: R_X86_64_PC32	.text+0x19e1c
031d      31d:	e9 00 00 00 00       	jmp    322 <.altinstr_replacement+0x322>	31e: R_X86_64_PC32	.text+0x19dd2
0322      322:	e9 00 00 00 00       	jmp    327 <.altinstr_replacement+0x327>	323: R_X86_64_PC32	.text+0x19e22
0327      327:	e9 00 00 00 00       	jmp    32c <.altinstr_replacement+0x32c>	328: R_X86_64_PC32	.text+0x19e51
032c      32c:	e9 00 00 00 00       	jmp    331 <.altinstr_replacement+0x331>	32d: R_X86_64_PC32	.text+0x19e57
0331      331:	e9 00 00 00 00       	jmp    336 <.altinstr_replacement+0x336>	332: R_X86_64_PC32	.text+0x19e22
0336      336:	e9 00 00 00 00       	jmp    33b <.altinstr_replacement+0x33b>	337: R_X86_64_PC32	.text+0x1a264
033b      33b:	e9 00 00 00 00       	jmp    340 <.altinstr_replacement+0x340>	33c: R_X86_64_PC32	.text+0x1a2ac
0340      340:	e9 00 00 00 00       	jmp    345 <.altinstr_replacement+0x345>	341: R_X86_64_PC32	.text+0x1a2a6
0345      345:	e9 00 00 00 00       	jmp    34a <.altinstr_replacement+0x34a>	346: R_X86_64_PC32	.text+0x1a291
034a      34a:	e9 00 00 00 00       	jmp    34f <.altinstr_replacement+0x34f>	34b: R_X86_64_PC32	.text+0x1a437
034f      34f:	e9 00 00 00 00       	jmp    354 <.altinstr_replacement+0x354>	350: R_X86_64_PC32	.text+0x1a4fc
0354      354:	e9 00 00 00 00       	jmp    359 <.altinstr_replacement+0x359>	355: R_X86_64_PC32	.text+0x1a5c8
0359      359:	e9 00 00 00 00       	jmp    35e <.altinstr_replacement+0x35e>	35a: R_X86_64_PC32	.text+0x1a71b
035e      35e:	e9 00 00 00 00       	jmp    363 <.altinstr_replacement+0x363>	35f: R_X86_64_PC32	.text+0x1a7f2
0363      363:	e9 00 00 00 00       	jmp    368 <.altinstr_replacement+0x368>	364: R_X86_64_PC32	.text+0x1af3a
0368      368:	f3 0f b8 c7          	popcnt %edi,%eax
036c      36c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0371      371:	0f 01 cb             	stac
0374      374:	e8 00 00 00 00       	call   379 <.altinstr_replacement+0x379>	375: R_X86_64_PLT32	rep_movs_alternative-0x4
0379      379:	0f 01 ca             	clac
037c      37c:	0f 01 cb             	stac
037f      37f:	e8 00 00 00 00       	call   384 <.altinstr_replacement+0x384>	380: R_X86_64_PLT32	rep_movs_alternative-0x4
0384      384:	0f 01 ca             	clac
0387      387:	0f 01 cb             	stac
038a      38a:	e8 00 00 00 00       	call   38f <.altinstr_replacement+0x38f>	38b: R_X86_64_PLT32	rep_movs_alternative-0x4
038f      38f:	0f 01 ca             	clac
0392      392:	0f 01 cb             	stac
0395      395:	e8 00 00 00 00       	call   39a <.altinstr_replacement+0x39a>	396: R_X86_64_PLT32	rep_movs_alternative-0x4
039a      39a:	0f 01 ca             	clac
039d      39d:	e9 00 00 00 00       	jmp    3a2 <.altinstr_replacement+0x3a2>	39e: R_X86_64_PC32	.text+0x32418
03a2      3a2:	e9 00 00 00 00       	jmp    3a7 <.altinstr_replacement+0x3a7>	3a3: R_X86_64_PC32	.text+0x32338
03a7      3a7:	0f 01 cb             	stac
03aa      3aa:	e8 00 00 00 00       	call   3af <.altinstr_replacement+0x3af>	3ab: R_X86_64_PLT32	rep_movs_alternative-0x4
03af      3af:	0f 01 ca             	clac
03b2      3b2:	e9 00 00 00 00       	jmp    3b7 <.altinstr_replacement+0x3b7>	3b3: R_X86_64_PC32	.text+0x3b7dc
03b7      3b7:	0f ae e8             	lfence
03ba      3ba:	0f 31                	rdtsc
03bc      3bc:	0f 01 f9             	rdtscp
03bf      3bf:	e9 00 00 00 00       	jmp    3c4 <.altinstr_replacement+0x3c4>	3c0: R_X86_64_PC32	.text+0x3f64c
03c4      3c4:	0f 01 cb             	stac
03c7      3c7:	0f ae e8             	lfence
03ca      3ca:	0f 01 cb             	stac
03cd      3cd:	0f ae e8             	lfence
03d0      3d0:	0f 01 ca             	clac
03d3      3d3:	0f 01 cb             	stac
03d6      3d6:	0f ae e8             	lfence
03d9      3d9:	0f 01 ca             	clac
03dc      3dc:	e9 00 00 00 00       	jmp    3e1 <.altinstr_replacement+0x3e1>	3dd: R_X86_64_PC32	.text+0x4358a
03e1      3e1:	0f 01 cb             	stac
03e4      3e4:	0f ae e8             	lfence
03e7      3e7:	0f 01 ca             	clac
03ea      3ea:	0f 01 cb             	stac
03ed      3ed:	0f ae e8             	lfence
03f0      3f0:	0f 01 ca             	clac
03f3      3f3:	0f 01 ca             	clac
03f6      3f6:	0f 01 cb             	stac
03f9      3f9:	0f ae e8             	lfence
03fc      3fc:	0f 01 ca             	clac
03ff      3ff:	0f 01 cb             	stac
0402      402:	0f ae e8             	lfence
0405      405:	0f 01 ca             	clac
0408      408:	0f 01 ca             	clac
040b      40b:	e9 00 00 00 00       	jmp    410 <.altinstr_replacement+0x410>	40c: R_X86_64_PC32	.text+0x47248
0410      410:	e9 00 00 00 00       	jmp    415 <.altinstr_replacement+0x415>	411: R_X86_64_PC32	.text+0x483dd
0415      415:	e9 00 00 00 00       	jmp    41a <.altinstr_replacement+0x41a>	416: R_X86_64_PC32	.text+0x483dd
041a      41a:	e9 00 00 00 00       	jmp    41f <.altinstr_replacement+0x41f>	41b: R_X86_64_PC32	.text+0x48504
041f      41f:	e9 00 00 00 00       	jmp    424 <.altinstr_replacement+0x424>	420: R_X86_64_PC32	.text+0x484b3
0424      424:	e9 00 00 00 00       	jmp    429 <.altinstr_replacement+0x429>	425: R_X86_64_PC32	.text+0x4c09e
0429      429:	e8 00 00 00 00       	call   42e <.altinstr_replacement+0x42e>	42a: R_X86_64_PLT32	__x86_indirect_thunk_rsi-0x4
042e      42e:	0f ae e8             	lfence
0431      431:	ff d6                	call   *%rsi
0433      433:	e8 00 00 00 00       	call   438 <.altinstr_replacement+0x438>	434: R_X86_64_PLT32	__x86_indirect_thunk_rax-0x4
0438      438:	0f ae e8             	lfence
043b      43b:	ff d0                	call   *%rax
043d      43d:	e8 00 00 00 00       	call   442 <.altinstr_replacement+0x442>	43e: R_X86_64_PLT32	__x86_indirect_thunk_rdx-0x4
0442      442:	0f ae e8             	lfence
0445      445:	ff d2                	call   *%rdx
0447      447:	e8 00 00 00 00       	call   44c <.altinstr_replacement+0x44c>	448: R_X86_64_PLT32	__x86_indirect_thunk_rdx-0x4
044c      44c:	0f ae e8             	lfence
044f      44f:	ff d2                	call   *%rdx
0451      451:	e8 00 00 00 00       	call   456 <.altinstr_replacement+0x456>	452: R_X86_64_PLT32	__x86_indirect_thunk_rdx-0x4
0456      456:	0f ae e8             	lfence
0459      459:	ff d2                	call   *%rdx
045b      45b:	f3 0f b8 c7          	popcnt %edi,%eax
045f      45f:	f3 0f b8 c7          	popcnt %edi,%eax
0463      463:	f3 0f b8 c7          	popcnt %edi,%eax
0467      467:	e9 00 00 00 00       	jmp    46c <.altinstr_replacement+0x46c>	468: R_X86_64_PC32	.text+0x6b34b
046c      46c:	e9 00 00 00 00       	jmp    471 <.altinstr_replacement+0x471>	46d: R_X86_64_PC32	.text+0x6b343
0471      471:	e9 00 00 00 00       	jmp    476 <.altinstr_replacement+0x476>	472: R_X86_64_PC32	.text+0x6c62b
0476      476:	e9 00 00 00 00       	jmp    47b <.altinstr_replacement+0x47b>	477: R_X86_64_PC32	.text+0x6bf24
047b      47b:	e9 00 00 00 00       	jmp    480 <.altinstr_replacement+0x480>	47c: R_X86_64_PC32	.text+0x6c17b
0480      480:	0f 01 cb             	stac
0483      483:	0f ae e8             	lfence
0486      486:	0f 01 ca             	clac
0489      489:	0f 01 ca             	clac
048c      48c:	0f 01 cb             	stac
048f      48f:	0f ae e8             	lfence
0492      492:	0f 01 ca             	clac
0495      495:	0f 01 ca             	clac
0498      498:	0f 01 cb             	stac
049b      49b:	0f ae e8             	lfence
049e      49e:	0f 01 ca             	clac
04a1      4a1:	0f 01 ca             	clac
04a4      4a4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
04a9      4a9:	f3 48 0f b8 c7       	popcnt %rdi,%rax
04ae      4ae:	f3 48 0f b8 c7       	popcnt %rdi,%rax
04b3      4b3:	e9 00 00 00 00       	jmp    4b8 <.altinstr_replacement+0x4b8>	4b4: R_X86_64_PC32	.text+0x8c222
04b8      4b8:	e9 00 00 00 00       	jmp    4bd <.altinstr_replacement+0x4bd>	4b9: R_X86_64_PC32	.noinstr.text+0x285
04bd      4bd:	0f 01 cb             	stac
04c0      4c0:	e8 00 00 00 00       	call   4c5 <.altinstr_replacement+0x4c5>	4c1: R_X86_64_PLT32	rep_movs_alternative-0x4
04c5      4c5:	0f 01 ca             	clac
04c8      4c8:	0f 01 cb             	stac
04cb      4cb:	e8 00 00 00 00       	call   4d0 <.altinstr_replacement+0x4d0>	4cc: R_X86_64_PLT32	rep_movs_alternative-0x4
04d0      4d0:	0f 01 ca             	clac
04d3      4d3:	0f 01 cb             	stac
04d6      4d6:	e8 00 00 00 00       	call   4db <.altinstr_replacement+0x4db>	4d7: R_X86_64_PLT32	rep_movs_alternative-0x4
04db      4db:	0f 01 ca             	clac
04de      4de:	e9 00 00 00 00       	jmp    4e3 <.altinstr_replacement+0x4e3>	4df: R_X86_64_PC32	.init.text+0xb5e8
04e3      4e3:	e9 00 00 00 00       	jmp    4e8 <.altinstr_replacement+0x4e8>	4e4: R_X86_64_PC32	.text+0x8deb0
04e8      4e8:	0f 30                	wrmsr
04ea      4ea:	e9 00 00 00 00       	jmp    4ef <.altinstr_replacement+0x4ef>	4eb: R_X86_64_PC32	.text+0x91c28
04ef      4ef:	e9 00 00 00 00       	jmp    4f4 <.altinstr_replacement+0x4f4>	4f0: R_X86_64_PC32	.noinstr.text+0x62c
04f4      4f4:	e9 00 00 00 00       	jmp    4f9 <.altinstr_replacement+0x4f9>	4f5: R_X86_64_PC32	.noinstr.text+0x63e
04f9      4f9:	0f ae e8             	lfence
04fc      4fc:	0f 01 cb             	stac
04ff      4ff:	e8 00 00 00 00       	call   504 <.altinstr_replacement+0x504>	500: R_X86_64_PLT32	rep_movs_alternative-0x4
0504      504:	0f 01 ca             	clac
0507      507:	0f 00 2d 00 00 00 00 	verw   0x0(%rip)        # 50e <.altinstr_replacement+0x50e>	50a: R_X86_64_PC32	mds_verw_sel-0x4
050e      50e:	48 c7 c1 10 00 00 00 	mov    $0x10,%rcx
0515      515:	e8 01 00 00 00       	call   51b <.altinstr_replacement+0x51b>
051a      51a:	cc                   	int3
051b      51b:	e8 01 00 00 00       	call   521 <.altinstr_replacement+0x521>
0520      520:	cc                   	int3
0521      521:	48 83 c4 10          	add    $0x10,%rsp
0525      525:	48 ff c9             	dec    %rcx
0528      528:	75 eb                	jne    515 <.altinstr_replacement+0x515>
052a      52a:	0f ae e8             	lfence
052d      52d:	65 48 c7 05 00 00 00 00 ff ff ff ff 	movq   $0xffffffffffffffff,%gs:0x0(%rip)        # 539 <.altinstr_replacement+0x539>	531: R_X86_64_PC32	pcpu_hot+0x8
0539      539:	90                   	nop
053a      53a:	90                   	nop
053b      53b:	e8 01 00 00 00       	call   541 <.altinstr_replacement+0x541>
0540      540:	cc                   	int3
0541      541:	48 83 c4 08          	add    $0x8,%rsp
0545      545:	0f ae e8             	lfence
0548      548:	e8 00 00 00 00       	call   54d <.altinstr_replacement+0x54d>	549: R_X86_64_PLT32	clear_bhb_loop-0x4
054d      54d:	0f 30                	wrmsr
054f      54f:	e8 00 00 00 00       	call   554 <.altinstr_replacement+0x554>	550: R_X86_64_PLT32	clear_page_rep-0x4
0554      554:	e8 00 00 00 00       	call   559 <.altinstr_replacement+0x559>	555: R_X86_64_PLT32	clear_page_erms-0x4
0559      559:	e9 00 00 00 00       	jmp    55e <.altinstr_replacement+0x55e>	55a: R_X86_64_PC32	.text+0xaf2cf
055e      55e:	e9 00 00 00 00       	jmp    563 <.altinstr_replacement+0x563>	55f: R_X86_64_PC32	.text+0xaf44c
0563      563:	e9 00 00 00 00       	jmp    568 <.altinstr_replacement+0x568>	564: R_X86_64_PC32	.text+0xaf512
0568      568:	e9 00 00 00 00       	jmp    56d <.altinstr_replacement+0x56d>	569: R_X86_64_PC32	.text+0xaff2b
056d      56d:	e9 00 00 00 00       	jmp    572 <.altinstr_replacement+0x572>	56e: R_X86_64_PC32	.text+0xb040b
0572      572:	0f 30                	wrmsr
0574      574:	e9 00 00 00 00       	jmp    579 <.altinstr_replacement+0x579>	575: R_X86_64_PC32	.text+0xb0649
0579      579:	e9 00 00 00 00       	jmp    57e <.altinstr_replacement+0x57e>	57a: R_X86_64_PC32	.text+0xb06dc
057e      57e:	e9 00 00 00 00       	jmp    583 <.altinstr_replacement+0x583>	57f: R_X86_64_PC32	.text+0xb0e0c
0583      583:	e9 00 00 00 00       	jmp    588 <.altinstr_replacement+0x588>	584: R_X86_64_PC32	.text+0xb18ed
0588      588:	e9 00 00 00 00       	jmp    58d <.altinstr_replacement+0x58d>	589: R_X86_64_PC32	.text+0xb2677
058d      58d:	e9 00 00 00 00       	jmp    592 <.altinstr_replacement+0x592>	58e: R_X86_64_PC32	.text+0xb49b8
0592      592:	e9 00 00 00 00       	jmp    597 <.altinstr_replacement+0x597>	593: R_X86_64_PC32	.text+0xb4a06
0597      597:	e9 00 00 00 00       	jmp    59c <.altinstr_replacement+0x59c>	598: R_X86_64_PC32	.text+0xb6066
059c      59c:	e9 00 00 00 00       	jmp    5a1 <.altinstr_replacement+0x5a1>	59d: R_X86_64_PC32	.text+0xb6041
05a1      5a1:	e9 00 00 00 00       	jmp    5a6 <.altinstr_replacement+0x5a6>	5a2: R_X86_64_PC32	.noinstr.text+0xa2f
05a6      5a6:	48 c7 c0 10 00 00 00 	mov    $0x10,%rax
05ad      5ad:	e8 01 00 00 00       	call   5b3 <.altinstr_replacement+0x5b3>
05b2      5b2:	cc                   	int3
05b3      5b3:	e8 01 00 00 00       	call   5b9 <.altinstr_replacement+0x5b9>
05b8      5b8:	cc                   	int3
05b9      5b9:	48 83 c4 10          	add    $0x10,%rsp
05bd      5bd:	48 ff c8             	dec    %rax
05c0      5c0:	75 eb                	jne    5ad <.altinstr_replacement+0x5ad>
05c2      5c2:	0f ae e8             	lfence
05c5      5c5:	65 48 c7 05 00 00 00 00 ff ff ff ff 	movq   $0xffffffffffffffff,%gs:0x0(%rip)        # 5d1 <.altinstr_replacement+0x5d1>	5c9: R_X86_64_PC32	pcpu_hot+0x8
05d1      5d1:	90                   	nop
05d2      5d2:	90                   	nop
05d3      5d3:	e8 01 00 00 00       	call   5d9 <.altinstr_replacement+0x5d9>
05d8      5d8:	cc                   	int3
05d9      5d9:	48 83 c4 08          	add    $0x8,%rsp
05dd      5dd:	0f ae e8             	lfence
05e0      5e0:	e9 00 00 00 00       	jmp    5e5 <.altinstr_replacement+0x5e5>	5e1: R_X86_64_PC32	.noinstr.text+0xa50
05e5      5e5:	e8 00 00 00 00       	call   5ea <.altinstr_replacement+0x5ea>	5e6: R_X86_64_PLT32	entry_untrain_ret-0x4
05ea      5ea:	e8 00 00 00 00       	call   5ef <.altinstr_replacement+0x5ef>	5eb: R_X86_64_PLT32	srso_alias_untrain_ret-0x4
05ef      5ef:	e8 00 00 00 00       	call   5f4 <.altinstr_replacement+0x5f4>	5f0: R_X86_64_PLT32	entry_ibpb-0x4
05f4      5f4:	31 c0                	xor    %eax,%eax
05f6      5f6:	48 0f ba e8 3f       	bts    $0x3f,%rax
05fb      5fb:	65 48 89 05 00 00 00 00 	mov    %rax,%gs:0x0(%rip)        # 603 <.altinstr_replacement+0x603>	5ff: R_X86_64_PC32	pcpu_hot+0xc
0603      603:	0f 01 cb             	stac
0606      606:	e8 00 00 00 00       	call   60b <.altinstr_replacement+0x60b>	607: R_X86_64_PLT32	rep_stos_alternative-0x4
060b      60b:	0f 01 ca             	clac
060e      60e:	e8 00 00 00 00       	call   613 <.altinstr_replacement+0x613>	60f: R_X86_64_PLT32	clear_page_rep-0x4
0613      613:	e8 00 00 00 00       	call   618 <.altinstr_replacement+0x618>	614: R_X86_64_PLT32	clear_page_erms-0x4
0618      618:	e9 00 00 00 00       	jmp    61d <.altinstr_replacement+0x61d>	619: R_X86_64_PC32	.text+0xbc7f5
061d      61d:	e9 00 00 00 00       	jmp    622 <.altinstr_replacement+0x622>	61e: R_X86_64_PC32	.text+0xbc885
0622      622:	e9 00 00 00 00       	jmp    627 <.altinstr_replacement+0x627>	623: R_X86_64_PC32	.text+0xbc8f5
0627      627:	e9 00 00 00 00       	jmp    62c <.altinstr_replacement+0x62c>	628: R_X86_64_PC32	.text+0xbc8de
062c      62c:	e9 00 00 00 00       	jmp    631 <.altinstr_replacement+0x631>	62d: R_X86_64_PC32	.text+0xbcc39
0631      631:	e9 00 00 00 00       	jmp    636 <.altinstr_replacement+0x636>	632: R_X86_64_PC32	.text+0xbd24b
0636      636:	e9 00 00 00 00       	jmp    63b <.altinstr_replacement+0x63b>	637: R_X86_64_PC32	.text+0xbd20d
063b      63b:	e9 00 00 00 00       	jmp    640 <.altinstr_replacement+0x640>	63c: R_X86_64_PC32	.text+0xbd127
0640      640:	e9 00 00 00 00       	jmp    645 <.altinstr_replacement+0x645>	641: R_X86_64_PC32	.text+0xbd184
0645      645:	e9 00 00 00 00       	jmp    64a <.altinstr_replacement+0x64a>	646: R_X86_64_PC32	.text+0xbd371
064a      64a:	e9 00 00 00 00       	jmp    64f <.altinstr_replacement+0x64f>	64b: R_X86_64_PC32	.text+0xbd351
064f      64f:	e9 00 00 00 00       	jmp    654 <.altinstr_replacement+0x654>	650: R_X86_64_PC32	.text+0xbd424
0654      654:	e9 00 00 00 00       	jmp    659 <.altinstr_replacement+0x659>	655: R_X86_64_PC32	.text+0xbd386
0659      659:	e9 00 00 00 00       	jmp    65e <.altinstr_replacement+0x65e>	65a: R_X86_64_PC32	.text+0xbd404
065e      65e:	e9 00 00 00 00       	jmp    663 <.altinstr_replacement+0x663>	65f: R_X86_64_PC32	.text+0xbd386
0663      663:	e9 00 00 00 00       	jmp    668 <.altinstr_replacement+0x668>	664: R_X86_64_PC32	.text+0xbd44f
0668      668:	e9 00 00 00 00       	jmp    66d <.altinstr_replacement+0x66d>	669: R_X86_64_PC32	.text+0xbd386
066d      66d:	e9 00 00 00 00       	jmp    672 <.altinstr_replacement+0x672>	66e: R_X86_64_PC32	.text+0xbd6a7
0672      672:	0f 01 cb             	stac
0675      675:	0f ae e8             	lfence
0678      678:	0f 01 ca             	clac
067b      67b:	0f 01 ca             	clac
067e      67e:	e9 00 00 00 00       	jmp    683 <.altinstr_replacement+0x683>	67f: R_X86_64_PC32	.noinstr.text+0xbe5
0683      683:	e9 00 00 00 00       	jmp    688 <.altinstr_replacement+0x688>	684: R_X86_64_PC32	.text+0xbe94b
0688      688:	e9 00 00 00 00       	jmp    68d <.altinstr_replacement+0x68d>	689: R_X86_64_PC32	.noinstr.text+0x15c4
068d      68d:	e9 00 00 00 00       	jmp    692 <.altinstr_replacement+0x692>	68e: R_X86_64_PC32	.init.text+0xda6a
0692      692:	e9 00 00 00 00       	jmp    697 <.altinstr_replacement+0x697>	693: R_X86_64_PC32	.noinstr.text+0x249a
0697      697:	0f 01 cb             	stac
069a      69a:	e8 00 00 00 00       	call   69f <.altinstr_replacement+0x69f>	69b: R_X86_64_PLT32	rep_stos_alternative-0x4
069f      69f:	0f 01 ca             	clac
06a2      6a2:	e9 00 00 00 00       	jmp    6a7 <.altinstr_replacement+0x6a7>	6a3: R_X86_64_PC32	.text+0xc13ec
06a7      6a7:	e9 00 00 00 00       	jmp    6ac <.altinstr_replacement+0x6ac>	6a8: R_X86_64_PC32	.text+0xc187f
06ac      6ac:	0f 01 cb             	stac
06af      6af:	e8 00 00 00 00       	call   6b4 <.altinstr_replacement+0x6b4>	6b0: R_X86_64_PLT32	rep_stos_alternative-0x4
06b4      6b4:	0f 01 ca             	clac
06b7      6b7:	e9 00 00 00 00       	jmp    6bc <.altinstr_replacement+0x6bc>	6b8: R_X86_64_PC32	.init.text+0xf2d7
06bc      6bc:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 6c3 <.altinstr_replacement+0x6c3>	6bf: R_X86_64_PC32	.init.data+0x5171c
06c3      6c3:	e8 00 00 00 00       	call   6c8 <.altinstr_replacement+0x6c8>	6c4: R_X86_64_PLT32	__alt_reloc_selftest-0x4
06c8      6c8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
06cd      6cd:	e9 00 00 00 00       	jmp    6d2 <.altinstr_replacement+0x6d2>	6ce: R_X86_64_PC32	.text+0xc49ac
06d2      6d2:	e9 00 00 00 00       	jmp    6d7 <.altinstr_replacement+0x6d7>	6d3: R_X86_64_PC32	.text+0xc4a48
06d7      6d7:	e9 00 00 00 00       	jmp    6dc <.altinstr_replacement+0x6dc>	6d8: R_X86_64_PC32	.text+0xc49db
06dc      6dc:	e9 00 00 00 00       	jmp    6e1 <.altinstr_replacement+0x6e1>	6dd: R_X86_64_PC32	.text+0xc49ef
06e1      6e1:	e9 00 00 00 00       	jmp    6e6 <.altinstr_replacement+0x6e6>	6e2: R_X86_64_PC32	.text+0xc600b
06e6      6e6:	e9 00 00 00 00       	jmp    6eb <.altinstr_replacement+0x6eb>	6e7: R_X86_64_PC32	.init.text+0x12090
06eb      6eb:	e9 00 00 00 00       	jmp    6f0 <.altinstr_replacement+0x6f0>	6ec: R_X86_64_PC32	.init.text+0x12b3f
06f0      6f0:	e9 00 00 00 00       	jmp    6f5 <.altinstr_replacement+0x6f5>	6f1: R_X86_64_PC32	.init.text+0x12d37
06f5      6f5:	0f ae e8             	lfence
06f8      6f8:	0f 31                	rdtsc
06fa      6fa:	0f 01 f9             	rdtscp
06fd      6fd:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0702      702:	e9 00 00 00 00       	jmp    707 <.altinstr_replacement+0x707>	703: R_X86_64_PC32	.init.text+0x136e8
0707      707:	e9 00 00 00 00       	jmp    70c <.altinstr_replacement+0x70c>	708: R_X86_64_PC32	.ref.text+0x52e
070c      70c:	e9 00 00 00 00       	jmp    711 <.altinstr_replacement+0x711>	70d: R_X86_64_PC32	.ref.text+0x551
0711      711:	e9 00 00 00 00       	jmp    716 <.altinstr_replacement+0x716>	712: R_X86_64_PC32	.text+0xc8fa3
0716      716:	e9 00 00 00 00       	jmp    71b <.altinstr_replacement+0x71b>	717: R_X86_64_PC32	.text+0xc9129
071b      71b:	e9 00 00 00 00       	jmp    720 <.altinstr_replacement+0x720>	71c: R_X86_64_PC32	.text+0xc93e2
0720      720:	e9 00 00 00 00       	jmp    725 <.altinstr_replacement+0x725>	721: R_X86_64_PC32	.text+0xc9429
0725      725:	e9 00 00 00 00       	jmp    72a <.altinstr_replacement+0x72a>	726: R_X86_64_PC32	.text+0xc9452
072a      72a:	e9 00 00 00 00       	jmp    72f <.altinstr_replacement+0x72f>	72b: R_X86_64_PC32	.text+0xc947f
072f      72f:	e9 00 00 00 00       	jmp    734 <.altinstr_replacement+0x734>	730: R_X86_64_PC32	.text+0xc9413
0734      734:	e9 00 00 00 00       	jmp    739 <.altinstr_replacement+0x739>	735: R_X86_64_PC32	.text+0xc96ce
0739      739:	e9 00 00 00 00       	jmp    73e <.altinstr_replacement+0x73e>	73a: R_X86_64_PC32	.text+0xc97f2
073e      73e:	e9 00 00 00 00       	jmp    743 <.altinstr_replacement+0x743>	73f: R_X86_64_PC32	.text+0xc9887
0743      743:	e9 00 00 00 00       	jmp    748 <.altinstr_replacement+0x748>	744: R_X86_64_PC32	.text+0xc98b5
0748      748:	e9 00 00 00 00       	jmp    74d <.altinstr_replacement+0x74d>	749: R_X86_64_PC32	.text+0xc9845
074d      74d:	e9 00 00 00 00       	jmp    752 <.altinstr_replacement+0x752>	74e: R_X86_64_PC32	.text+0xc96a3
0752      752:	e9 00 00 00 00       	jmp    757 <.altinstr_replacement+0x757>	753: R_X86_64_PC32	.text+0xc9984
0757      757:	e9 00 00 00 00       	jmp    75c <.altinstr_replacement+0x75c>	758: R_X86_64_PC32	.text+0xc99ca
075c      75c:	e9 00 00 00 00       	jmp    761 <.altinstr_replacement+0x761>	75d: R_X86_64_PC32	.text+0xc99c3
0761      761:	e9 00 00 00 00       	jmp    766 <.altinstr_replacement+0x766>	762: R_X86_64_PC32	.text+0xc99b3
0766      766:	48 0f ae 37          	xsaveopt64 (%rdi)
076a      76a:	48 0f c7 27          	xsavec64 (%rdi)
076e      76e:	48 0f c7 2f          	xsaves64 (%rdi)
0772      772:	e9 00 00 00 00       	jmp    777 <.altinstr_replacement+0x777>	773: R_X86_64_PC32	.text+0xca092
0777      777:	e9 00 00 00 00       	jmp    77c <.altinstr_replacement+0x77c>	778: R_X86_64_PC32	.text+0xca235
077c      77c:	e9 00 00 00 00       	jmp    781 <.altinstr_replacement+0x781>	77d: R_X86_64_PC32	.text+0xca2d5
0781      781:	e9 00 00 00 00       	jmp    786 <.altinstr_replacement+0x786>	782: R_X86_64_PC32	.text+0xca4cf
0786      786:	e9 00 00 00 00       	jmp    78b <.altinstr_replacement+0x78b>	787: R_X86_64_PC32	.text+0xca5a8
078b      78b:	e9 00 00 00 00       	jmp    790 <.altinstr_replacement+0x790>	78c: R_X86_64_PC32	.text+0xca6aa
0790      790:	e9 00 00 00 00       	jmp    795 <.altinstr_replacement+0x795>	791: R_X86_64_PC32	.text+0xca6e3
0795      795:	48 0f c7 1f          	xrstors64 (%rdi)
0799      799:	e9 00 00 00 00       	jmp    79e <.altinstr_replacement+0x79e>	79a: R_X86_64_PC32	.text+0xca9d6
079e      79e:	e9 00 00 00 00       	jmp    7a3 <.altinstr_replacement+0x7a3>	79f: R_X86_64_PC32	.text+0xcac05
07a3      7a3:	e9 00 00 00 00       	jmp    7a8 <.altinstr_replacement+0x7a8>	7a4: R_X86_64_PC32	.text+0xcab76
07a8      7a8:	48 0f c7 1f          	xrstors64 (%rdi)
07ac      7ac:	e9 00 00 00 00       	jmp    7b1 <.altinstr_replacement+0x7b1>	7ad: R_X86_64_PC32	.text+0xcaea2
07b1      7b1:	48 0f c7 1f          	xrstors64 (%rdi)
07b5      7b5:	e9 00 00 00 00       	jmp    7ba <.altinstr_replacement+0x7ba>	7b6: R_X86_64_PC32	.text+0xcae58
07ba      7ba:	e9 00 00 00 00       	jmp    7bf <.altinstr_replacement+0x7bf>	7bb: R_X86_64_PC32	.noinstr.text+0x29d1
07bf      7bf:	0f 01 cb             	stac
07c2      7c2:	e8 00 00 00 00       	call   7c7 <.altinstr_replacement+0x7c7>	7c3: R_X86_64_PLT32	rep_movs_alternative-0x4
07c7      7c7:	0f 01 ca             	clac
07ca      7ca:	e9 00 00 00 00       	jmp    7cf <.altinstr_replacement+0x7cf>	7cb: R_X86_64_PC32	.text+0xcb358
07cf      7cf:	e9 00 00 00 00       	jmp    7d4 <.altinstr_replacement+0x7d4>	7d0: R_X86_64_PC32	.text+0xcb47f
07d4      7d4:	e9 00 00 00 00       	jmp    7d9 <.altinstr_replacement+0x7d9>	7d5: R_X86_64_PC32	.text+0xcb515
07d9      7d9:	e9 00 00 00 00       	jmp    7de <.altinstr_replacement+0x7de>	7da: R_X86_64_PC32	.text+0xcb5c9
07de      7de:	48 0f ae 37          	xsaveopt64 (%rdi)
07e2      7e2:	48 0f c7 27          	xsavec64 (%rdi)
07e6      7e6:	48 0f c7 2f          	xsaves64 (%rdi)
07ea      7ea:	0f 01 cb             	stac
07ed      7ed:	e8 00 00 00 00       	call   7f2 <.altinstr_replacement+0x7f2>	7ee: R_X86_64_PLT32	rep_movs_alternative-0x4
07f2      7f2:	0f 01 ca             	clac
07f5      7f5:	e9 00 00 00 00       	jmp    7fa <.altinstr_replacement+0x7fa>	7f6: R_X86_64_PC32	.text+0xcb76d
07fa      7fa:	e9 00 00 00 00       	jmp    7ff <.altinstr_replacement+0x7ff>	7fb: R_X86_64_PC32	.text+0xcb7d4
07ff      7ff:	e9 00 00 00 00       	jmp    804 <.altinstr_replacement+0x804>	800: R_X86_64_PC32	.text+0xcb871
0804      804:	0f 01 cb             	stac
0807      807:	0f 01 ca             	clac
080a      80a:	48 0f c7 1f          	xrstors64 (%rdi)
080e      80e:	0f 01 cb             	stac
0811      811:	0f 01 ca             	clac
0814      814:	0f 01 cb             	stac
0817      817:	0f 01 ca             	clac
081a      81a:	48 0f c7 1f          	xrstors64 (%rdi)
081e      81e:	e9 00 00 00 00       	jmp    823 <.altinstr_replacement+0x823>	81f: R_X86_64_PC32	.text+0xcbab6
0823      823:	0f 01 cb             	stac
0826      826:	e8 00 00 00 00       	call   82b <.altinstr_replacement+0x82b>	827: R_X86_64_PLT32	rep_movs_alternative-0x4
082b      82b:	0f 01 ca             	clac
082e      82e:	e9 00 00 00 00       	jmp    833 <.altinstr_replacement+0x833>	82f: R_X86_64_PC32	.text+0xcbb70
0833      833:	0f 01 cb             	stac
0836      836:	e8 00 00 00 00       	call   83b <.altinstr_replacement+0x83b>	837: R_X86_64_PLT32	rep_stos_alternative-0x4
083b      83b:	0f 01 ca             	clac
083e      83e:	e9 00 00 00 00       	jmp    843 <.altinstr_replacement+0x843>	83f: R_X86_64_PC32	.text+0xcbc5f
0843      843:	0f 01 cb             	stac
0846      846:	0f 01 ca             	clac
0849      849:	0f 01 cb             	stac
084c      84c:	e8 00 00 00 00       	call   851 <.altinstr_replacement+0x851>	84d: R_X86_64_PLT32	rep_stos_alternative-0x4
0851      851:	0f 01 ca             	clac
0854      854:	0f 01 cb             	stac
0857      857:	0f 01 ca             	clac
085a      85a:	e9 00 00 00 00       	jmp    85f <.altinstr_replacement+0x85f>	85b: R_X86_64_PC32	.text+0xcbd27
085f      85f:	e9 00 00 00 00       	jmp    864 <.altinstr_replacement+0x864>	860: R_X86_64_PC32	.text+0xcbdb9
0864      864:	e9 00 00 00 00       	jmp    869 <.altinstr_replacement+0x869>	865: R_X86_64_PC32	.init.text+0x1408b
0869      869:	e9 00 00 00 00       	jmp    86e <.altinstr_replacement+0x86e>	86a: R_X86_64_PC32	.text+0xcbff1
086e      86e:	e9 00 00 00 00       	jmp    873 <.altinstr_replacement+0x873>	86f: R_X86_64_PC32	.text+0xcc1b4
0873      873:	e9 00 00 00 00       	jmp    878 <.altinstr_replacement+0x878>	874: R_X86_64_PC32	.init.text+0x146a5
0878      878:	e9 00 00 00 00       	jmp    87d <.altinstr_replacement+0x87d>	879: R_X86_64_PC32	.init.text+0x1469e
087d      87d:	e9 00 00 00 00       	jmp    882 <.altinstr_replacement+0x882>	87e: R_X86_64_PC32	.text+0xcc219
0882      882:	e9 00 00 00 00       	jmp    887 <.altinstr_replacement+0x887>	883: R_X86_64_PC32	.init.text+0x14898
0887      887:	e9 00 00 00 00       	jmp    88c <.altinstr_replacement+0x88c>	888: R_X86_64_PC32	.init.text+0x148cc
088c      88c:	e9 00 00 00 00       	jmp    891 <.altinstr_replacement+0x891>	88d: R_X86_64_PC32	.text+0xcc578
0891      891:	e9 00 00 00 00       	jmp    896 <.altinstr_replacement+0x896>	892: R_X86_64_PC32	.text+0xcc5be
0896      896:	e9 00 00 00 00       	jmp    89b <.altinstr_replacement+0x89b>	897: R_X86_64_PC32	.text+0xcc6d5
089b      89b:	e9 00 00 00 00       	jmp    8a0 <.altinstr_replacement+0x8a0>	89c: R_X86_64_PC32	.text+0xcc831
08a0      8a0:	e9 00 00 00 00       	jmp    8a5 <.altinstr_replacement+0x8a5>	8a1: R_X86_64_PC32	.text+0xcc83b
08a5      8a5:	e9 00 00 00 00       	jmp    8aa <.altinstr_replacement+0x8aa>	8a6: R_X86_64_PC32	.init.text+0x1495c
08aa      8aa:	e9 00 00 00 00       	jmp    8af <.altinstr_replacement+0x8af>	8ab: R_X86_64_PC32	.init.text+0x149c1
08af      8af:	e9 00 00 00 00       	jmp    8b4 <.altinstr_replacement+0x8b4>	8b0: R_X86_64_PC32	.init.text+0x14b7d
08b4      8b4:	e9 00 00 00 00       	jmp    8b9 <.altinstr_replacement+0x8b9>	8b5: R_X86_64_PC32	.init.text+0x14e97
08b9      8b9:	e9 00 00 00 00       	jmp    8be <.altinstr_replacement+0x8be>	8ba: R_X86_64_PC32	.init.text+0x14e85
08be      8be:	e9 00 00 00 00       	jmp    8c3 <.altinstr_replacement+0x8c3>	8bf: R_X86_64_PC32	.init.text+0x14e8f
08c3      8c3:	e9 00 00 00 00       	jmp    8c8 <.altinstr_replacement+0x8c8>	8c4: R_X86_64_PC32	.text+0xcc904
08c8      8c8:	e9 00 00 00 00       	jmp    8cd <.altinstr_replacement+0x8cd>	8c9: R_X86_64_PC32	.text+0xcc926
08cd      8cd:	e9 00 00 00 00       	jmp    8d2 <.altinstr_replacement+0x8d2>	8ce: R_X86_64_PC32	.text+0xcc91d
08d2      8d2:	e9 00 00 00 00       	jmp    8d7 <.altinstr_replacement+0x8d7>	8d3: R_X86_64_PC32	.text+0xcc98d
08d7      8d7:	e9 00 00 00 00       	jmp    8dc <.altinstr_replacement+0x8dc>	8d8: R_X86_64_PC32	.text+0xcc9a1
08dc      8dc:	e9 00 00 00 00       	jmp    8e1 <.altinstr_replacement+0x8e1>	8dd: R_X86_64_PC32	.text+0xcc9ce
08e1      8e1:	e9 00 00 00 00       	jmp    8e6 <.altinstr_replacement+0x8e6>	8e2: R_X86_64_PC32	.text+0xcc9f2
08e6      8e6:	e9 00 00 00 00       	jmp    8eb <.altinstr_replacement+0x8eb>	8e7: R_X86_64_PC32	.text+0xcd30c
08eb      8eb:	e9 00 00 00 00       	jmp    8f0 <.altinstr_replacement+0x8f0>	8ec: R_X86_64_PC32	.text+0xd048e
08f0      8f0:	e9 00 00 00 00       	jmp    8f5 <.altinstr_replacement+0x8f5>	8f1: R_X86_64_PC32	.text+0xd0468
08f5      8f5:	e9 00 00 00 00       	jmp    8fa <.altinstr_replacement+0x8fa>	8f6: R_X86_64_PC32	.text+0xd0477
08fa      8fa:	e9 00 00 00 00       	jmp    8ff <.altinstr_replacement+0x8ff>	8fb: R_X86_64_PC32	.text+0xd0484
08ff      8ff:	e9 00 00 00 00       	jmp    904 <.altinstr_replacement+0x904>	900: R_X86_64_PC32	.text+0xd04bf
0904      904:	e9 00 00 00 00       	jmp    909 <.altinstr_replacement+0x909>	905: R_X86_64_PC32	.text+0xd04df
0909      909:	e9 00 00 00 00       	jmp    90e <.altinstr_replacement+0x90e>	90a: R_X86_64_PC32	.text+0xd0ee6
090e      90e:	e9 00 00 00 00       	jmp    913 <.altinstr_replacement+0x913>	90f: R_X86_64_PC32	.text+0xd1963
0913      913:	e9 00 00 00 00       	jmp    918 <.altinstr_replacement+0x918>	914: R_X86_64_PC32	.text+0xd212e
0918      918:	e9 00 00 00 00       	jmp    91d <.altinstr_replacement+0x91d>	919: R_X86_64_PC32	.text+0xd204a
091d      91d:	e9 00 00 00 00       	jmp    922 <.altinstr_replacement+0x922>	91e: R_X86_64_PC32	.text+0xd204a
0922      922:	e9 00 00 00 00       	jmp    927 <.altinstr_replacement+0x927>	923: R_X86_64_PC32	.text+0xd204a
0927      927:	e9 00 00 00 00       	jmp    92c <.altinstr_replacement+0x92c>	928: R_X86_64_PC32	.text+0xd2dce
092c      92c:	e9 00 00 00 00       	jmp    931 <.altinstr_replacement+0x931>	92d: R_X86_64_PC32	.text+0xd2dd5
0931      931:	e9 00 00 00 00       	jmp    936 <.altinstr_replacement+0x936>	932: R_X86_64_PC32	.text+0xd2dc3
0936      936:	e9 00 00 00 00       	jmp    93b <.altinstr_replacement+0x93b>	937: R_X86_64_PC32	.init.text+0x17982
093b      93b:	e9 00 00 00 00       	jmp    940 <.altinstr_replacement+0x940>	93c: R_X86_64_PC32	.init.text+0x17989
0940      940:	0f 30                	wrmsr
0942      942:	e9 00 00 00 00       	jmp    947 <.altinstr_replacement+0x947>	943: R_X86_64_PC32	.text+0xd3c43
0947      947:	e9 00 00 00 00       	jmp    94c <.altinstr_replacement+0x94c>	948: R_X86_64_PC32	.init.text+0x18b02
094c      94c:	e9 00 00 00 00       	jmp    951 <.altinstr_replacement+0x951>	94d: R_X86_64_PC32	.init.text+0x1912b
0951      951:	e9 00 00 00 00       	jmp    956 <.altinstr_replacement+0x956>	952: R_X86_64_PC32	.text+0xd4e39
0956      956:	e9 00 00 00 00       	jmp    95b <.altinstr_replacement+0x95b>	957: R_X86_64_PC32	.text+0xd4f27
095b      95b:	e9 00 00 00 00       	jmp    960 <.altinstr_replacement+0x960>	95c: R_X86_64_PC32	.text+0xd4f70
0960      960:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0965      965:	e9 00 00 00 00       	jmp    96a <.altinstr_replacement+0x96a>	966: R_X86_64_PC32	.text+0xd7250
096a      96a:	e9 00 00 00 00       	jmp    96f <.altinstr_replacement+0x96f>	96b: R_X86_64_PC32	.text+0xd730b
096f      96f:	e9 00 00 00 00       	jmp    974 <.altinstr_replacement+0x974>	970: R_X86_64_PC32	.text+0xd730b
0974      974:	e9 00 00 00 00       	jmp    979 <.altinstr_replacement+0x979>	975: R_X86_64_PC32	.text+0xd7369
0979      979:	f7 f1                	div    %ecx
097b      97b:	e9 00 00 00 00       	jmp    980 <.altinstr_replacement+0x980>	97c: R_X86_64_PC32	.text+0xd774d
0980      980:	e9 00 00 00 00       	jmp    985 <.altinstr_replacement+0x985>	981: R_X86_64_PC32	.text+0xd8884
0985      985:	e9 00 00 00 00       	jmp    98a <.altinstr_replacement+0x98a>	986: R_X86_64_PC32	.init.text+0x1a3cd
098a      98a:	e9 00 00 00 00       	jmp    98f <.altinstr_replacement+0x98f>	98b: R_X86_64_PC32	.text+0xdac3b
098f      98f:	e9 00 00 00 00       	jmp    994 <.altinstr_replacement+0x994>	990: R_X86_64_PC32	.init.text+0x1be51
0994      994:	e9 00 00 00 00       	jmp    999 <.altinstr_replacement+0x999>	995: R_X86_64_PC32	.init.text+0x1c321
0999      999:	0f ae e8             	lfence
099c      99c:	0f 31                	rdtsc
099e      99e:	0f 01 f9             	rdtscp
09a1      9a1:	0f ae e8             	lfence
09a4      9a4:	0f 31                	rdtsc
09a6      9a6:	0f 01 f9             	rdtscp
09a9      9a9:	0f ae e8             	lfence
09ac      9ac:	0f 31                	rdtsc
09ae      9ae:	0f 01 f9             	rdtscp
09b1      9b1:	e9 00 00 00 00       	jmp    9b6 <.altinstr_replacement+0x9b6>	9b2: R_X86_64_PC32	.cpuidle.text+0x198
09b6      9b6:	e9 00 00 00 00       	jmp    9bb <.altinstr_replacement+0x9bb>	9b7: R_X86_64_PC32	.cpuidle.text+0x11d
09bb      9bb:	e9 00 00 00 00       	jmp    9c0 <.altinstr_replacement+0x9c0>	9bc: R_X86_64_PC32	.text+0xe94d1
09c0      9c0:	f3 48 0f b8 c7       	popcnt %rdi,%rax
09c5      9c5:	e9 00 00 00 00       	jmp    9ca <.altinstr_replacement+0x9ca>	9c6: R_X86_64_PC32	.text+0xea66f
09ca      9ca:	e9 00 00 00 00       	jmp    9cf <.altinstr_replacement+0x9cf>	9cb: R_X86_64_PC32	.text+0xeadbd
09cf      9cf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
09d4      9d4:	e9 00 00 00 00       	jmp    9d9 <.altinstr_replacement+0x9d9>	9d5: R_X86_64_PC32	.init.text+0x2160b
09d9      9d9:	0f ae e8             	lfence
09dc      9dc:	0f 31                	rdtsc
09de      9de:	0f 01 f9             	rdtscp
09e1      9e1:	0f ae e8             	lfence
09e4      9e4:	0f 31                	rdtsc
09e6      9e6:	0f 01 f9             	rdtscp
09e9      9e9:	f3 48 0f b8 c7       	popcnt %rdi,%rax
09ee      9ee:	87 04 25 10 c3 5f ff 	xchg   %eax,0xffffffffff5fc310
09f5      9f5:	87 04 25 00 c3 5f ff 	xchg   %eax,0xffffffffff5fc300
09fc      9fc:	87 04 25 10 c3 5f ff 	xchg   %eax,0xffffffffff5fc310
0a03      a03:	87 04 25 10 c3 5f ff 	xchg   %eax,0xffffffffff5fc310
0a0a      a0a:	87 34 25 00 c3 5f ff 	xchg   %esi,0xffffffffff5fc300
0a11      a11:	44 87 24 25 10 c3 5f ff 	xchg   %r12d,0xffffffffff5fc310
0a19      a19:	44 87 24 25 10 c3 5f ff 	xchg   %r12d,0xffffffffff5fc310
0a21      a21:	87 04 25 10 c3 5f ff 	xchg   %eax,0xffffffffff5fc310
0a28      a28:	44 87 24 25 10 c3 5f ff 	xchg   %r12d,0xffffffffff5fc310
0a30      a30:	87 04 25 00 c3 5f ff 	xchg   %eax,0xffffffffff5fc300
0a37      a37:	44 87 24 25 10 c3 5f ff 	xchg   %r12d,0xffffffffff5fc310
0a3f      a3f:	87 04 25 10 c3 5f ff 	xchg   %eax,0xffffffffff5fc310
0a46      a46:	87 1c 25 10 c3 5f ff 	xchg   %ebx,0xffffffffff5fc310
0a4d      a4d:	87 04 25 00 c3 5f ff 	xchg   %eax,0xffffffffff5fc300
0a54      a54:	87 1c 25 10 c3 5f ff 	xchg   %ebx,0xffffffffff5fc310
0a5b      a5b:	87 04 25 10 c3 5f ff 	xchg   %eax,0xffffffffff5fc310
0a62      a62:	87 3c 25 00 c3 5f ff 	xchg   %edi,0xffffffffff5fc300
0a69      a69:	87 3c 25 00 c3 5f ff 	xchg   %edi,0xffffffffff5fc300
0a70      a70:	87 3c 25 00 c3 5f ff 	xchg   %edi,0xffffffffff5fc300
0a77      a77:	87 b7 00 c0 5f ff    	xchg   %esi,-0xa04000(%rdi)
0a7d      a7d:	87 04 25 b0 c0 5f ff 	xchg   %eax,0xffffffffff5fc0b0
0a84      a84:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0a89      a89:	0f ae e8             	lfence
0a8c      a8c:	0f 31                	rdtsc
0a8e      a8e:	0f 01 f9             	rdtscp
0a91      a91:	e8 00 00 00 00       	call   a96 <.altinstr_replacement+0xa96>	a92: R_X86_64_PLT32	clear_page_rep-0x4
0a96      a96:	e8 00 00 00 00       	call   a9b <.altinstr_replacement+0xa9b>	a97: R_X86_64_PLT32	clear_page_erms-0x4
0a9b      a9b:	e9 00 00 00 00       	jmp    aa0 <.altinstr_replacement+0xaa0>	a9c: R_X86_64_PC32	.text+0xf34ed
0aa0      aa0:	e8 00 00 00 00       	call   aa5 <.altinstr_replacement+0xaa5>	aa1: R_X86_64_PLT32	clear_page_rep-0x4
0aa5      aa5:	e8 00 00 00 00       	call   aaa <.altinstr_replacement+0xaaa>	aa6: R_X86_64_PLT32	clear_page_erms-0x4
0aaa      aaa:	e9 00 00 00 00       	jmp    aaf <.altinstr_replacement+0xaaf>	aab: R_X86_64_PC32	.init.text+0x25806
0aaf      aaf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0ab4      ab4:	e9 00 00 00 00       	jmp    ab9 <.altinstr_replacement+0xab9>	ab5: R_X86_64_PC32	.init.text+0x26b3f
0ab9      ab9:	f3 0f b8 c7          	popcnt %edi,%eax
0abd      abd:	e9 00 00 00 00       	jmp    ac2 <.altinstr_replacement+0xac2>	abe: R_X86_64_PC32	.init.text+0x282c2
0ac2      ac2:	e8 00 00 00 00       	call   ac7 <.altinstr_replacement+0xac7>	ac3: R_X86_64_PLT32	clear_page_rep-0x4
0ac7      ac7:	e8 00 00 00 00       	call   acc <.altinstr_replacement+0xacc>	ac8: R_X86_64_PLT32	clear_page_erms-0x4
0acc      acc:	e9 00 00 00 00       	jmp    ad1 <.altinstr_replacement+0xad1>	acd: R_X86_64_PC32	.text+0xf9d05
0ad1      ad1:	e9 00 00 00 00       	jmp    ad6 <.altinstr_replacement+0xad6>	ad2: R_X86_64_PC32	.text+0xfa32b
0ad6      ad6:	e9 00 00 00 00       	jmp    adb <.altinstr_replacement+0xadb>	ad7: R_X86_64_PC32	.text+0xfa50f
0adb      adb:	e9 00 00 00 00       	jmp    ae0 <.altinstr_replacement+0xae0>	adc: R_X86_64_PC32	.init.text+0x28c1b
0ae0      ae0:	e9 00 00 00 00       	jmp    ae5 <.altinstr_replacement+0xae5>	ae1: R_X86_64_PC32	.meminit.text+0x15e1
0ae5      ae5:	e9 00 00 00 00       	jmp    aea <.altinstr_replacement+0xaea>	ae6: R_X86_64_PC32	.meminit.text+0x15e1
0aea      aea:	e9 00 00 00 00       	jmp    aef <.altinstr_replacement+0xaef>	aeb: R_X86_64_PC32	.text+0xfa67c
0aef      aef:	e9 00 00 00 00       	jmp    af4 <.altinstr_replacement+0xaf4>	af0: R_X86_64_PC32	.text+0xfab4b
0af4      af4:	e9 00 00 00 00       	jmp    af9 <.altinstr_replacement+0xaf9>	af5: R_X86_64_PC32	.text+0xfbb72
0af9      af9:	e9 00 00 00 00       	jmp    afe <.altinstr_replacement+0xafe>	afa: R_X86_64_PC32	.text+0xfbb72
0afe      afe:	e9 00 00 00 00       	jmp    b03 <.altinstr_replacement+0xb03>	aff: R_X86_64_PC32	.text+0xfbd15
0b03      b03:	e9 00 00 00 00       	jmp    b08 <.altinstr_replacement+0xb08>	b04: R_X86_64_PC32	.text+0xfbe0e
0b08      b08:	0f 0d 88 98 00 00 00 	prefetchw 0x98(%rax)
0b0f      b0f:	e9 00 00 00 00       	jmp    b14 <.altinstr_replacement+0xb14>	b10: R_X86_64_PC32	.text+0xfd073
0b14      b14:	e9 00 00 00 00       	jmp    b19 <.altinstr_replacement+0xb19>	b15: R_X86_64_PC32	.text+0xfd6ec
0b19      b19:	e9 00 00 00 00       	jmp    b1e <.altinstr_replacement+0xb1e>	b1a: R_X86_64_PC32	.text+0xfea2c
0b1e      b1e:	e9 00 00 00 00       	jmp    b23 <.altinstr_replacement+0xb23>	b1f: R_X86_64_PC32	.text+0xfea2c
0b23      b23:	e9 00 00 00 00       	jmp    b28 <.altinstr_replacement+0xb28>	b24: R_X86_64_PC32	.text+0xfeaae
0b28      b28:	e9 00 00 00 00       	jmp    b2d <.altinstr_replacement+0xb2d>	b29: R_X86_64_PC32	.text+0xfeb32
0b2d      b2d:	e9 00 00 00 00       	jmp    b32 <.altinstr_replacement+0xb32>	b2e: R_X86_64_PC32	.text+0xfeb56
0b32      b32:	e9 00 00 00 00       	jmp    b37 <.altinstr_replacement+0xb37>	b33: R_X86_64_PC32	.text+0xfec02
0b37      b37:	e9 00 00 00 00       	jmp    b3c <.altinstr_replacement+0xb3c>	b38: R_X86_64_PC32	.text+0xfef3c
0b3c      b3c:	e9 00 00 00 00       	jmp    b41 <.altinstr_replacement+0xb41>	b3d: R_X86_64_PC32	.text+0xfee25
0b41      b41:	e9 00 00 00 00       	jmp    b46 <.altinstr_replacement+0xb46>	b42: R_X86_64_PC32	.text+0xfee2a
0b46      b46:	e9 00 00 00 00       	jmp    b4b <.altinstr_replacement+0xb4b>	b47: R_X86_64_PC32	.text+0xff034
0b4b      b4b:	0f 30                	wrmsr
0b4d      b4d:	0f 30                	wrmsr
0b4f      b4f:	e9 00 00 00 00       	jmp    b54 <.altinstr_replacement+0xb54>	b50: R_X86_64_PC32	.text+0xff413
0b54      b54:	e9 00 00 00 00       	jmp    b59 <.altinstr_replacement+0xb59>	b55: R_X86_64_PC32	.text+0xff852
0b59      b59:	e9 00 00 00 00       	jmp    b5e <.altinstr_replacement+0xb5e>	b5a: R_X86_64_PC32	.text+0xffc48
0b5e      b5e:	66 0f ae 38          	clflushopt (%rax)
0b62      b62:	66 0f ae 38          	clflushopt (%rax)
0b66      b66:	e9 00 00 00 00       	jmp    b6b <.altinstr_replacement+0xb6b>	b67: R_X86_64_PC32	.text+0x100cc2
0b6b      b6b:	e9 00 00 00 00       	jmp    b70 <.altinstr_replacement+0xb70>	b6c: R_X86_64_PC32	.text+0x1013de
0b70      b70:	66 0f ae 38          	clflushopt (%rax)
0b74      b74:	e9 00 00 00 00       	jmp    b79 <.altinstr_replacement+0xb79>	b75: R_X86_64_PC32	.init.text+0x29ce1
0b79      b79:	e9 00 00 00 00       	jmp    b7e <.altinstr_replacement+0xb7e>	b7a: R_X86_64_PC32	.init.text+0x29de9
0b7e      b7e:	e9 00 00 00 00       	jmp    b83 <.altinstr_replacement+0xb83>	b7f: R_X86_64_PC32	.text+0x105d8d
0b83      b83:	e9 00 00 00 00       	jmp    b88 <.altinstr_replacement+0xb88>	b84: R_X86_64_PC32	.text+0x105dce
0b88      b88:	e9 00 00 00 00       	jmp    b8d <.altinstr_replacement+0xb8d>	b89: R_X86_64_PC32	.text+0x105f01
0b8d      b8d:	e9 00 00 00 00       	jmp    b92 <.altinstr_replacement+0xb92>	b8e: R_X86_64_PC32	.text+0x106057
0b92      b92:	e9 00 00 00 00       	jmp    b97 <.altinstr_replacement+0xb97>	b93: R_X86_64_PC32	.text+0x1064c2
0b97      b97:	e9 00 00 00 00       	jmp    b9c <.altinstr_replacement+0xb9c>	b98: R_X86_64_PC32	.text+0x1a45fd
0b9c      b9c:	e9 00 00 00 00       	jmp    ba1 <.altinstr_replacement+0xba1>	b9d: R_X86_64_PC32	.text+0x1a4843
0ba1      ba1:	e9 00 00 00 00       	jmp    ba6 <.altinstr_replacement+0xba6>	ba2: R_X86_64_PC32	.text+0x1a598d
0ba6      ba6:	0f 01 cb             	stac
0ba9      ba9:	0f ae e8             	lfence
0bac      bac:	0f 01 ca             	clac
0baf      baf:	0f 01 ca             	clac
0bb2      bb2:	0f 01 cb             	stac
0bb5      bb5:	e8 00 00 00 00       	call   bba <.altinstr_replacement+0xbba>	bb6: R_X86_64_PLT32	rep_stos_alternative-0x4
0bba      bba:	0f 01 ca             	clac
0bbd      bbd:	f3 0f b8 c7          	popcnt %edi,%eax
0bc1      bc1:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bc6      bc6:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bcb      bcb:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bd0      bd0:	e9 00 00 00 00       	jmp    bd5 <.altinstr_replacement+0xbd5>	bd1: R_X86_64_PC32	.text+0x1dace8
0bd5      bd5:	e9 00 00 00 00       	jmp    bda <.altinstr_replacement+0xbda>	bd6: R_X86_64_PC32	.text+0x1dacfe
0bda      bda:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bdf      bdf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0be4      be4:	e9 00 00 00 00       	jmp    be9 <.altinstr_replacement+0xbe9>	be5: R_X86_64_PC32	.text+0x1fb3ee
0be9      be9:	e9 00 00 00 00       	jmp    bee <.altinstr_replacement+0xbee>	bea: R_X86_64_PC32	.text+0x1fb404
0bee      bee:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bf3      bf3:	0f 0d 0f             	prefetchw (%rdi)
0bf6      bf6:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0bfb      bfb:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c00      c00:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c05      c05:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c0a      c0a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c0f      c0f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c14      c14:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c19      c19:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c1e      c1e:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c23      c23:	0f 01 cb             	stac
0c26      c26:	0f ae e8             	lfence
0c29      c29:	0f 01 ca             	clac
0c2c      c2c:	0f 01 cb             	stac
0c2f      c2f:	0f ae e8             	lfence
0c32      c32:	0f 01 ca             	clac
0c35      c35:	0f 01 ca             	clac
0c38      c38:	0f 01 ca             	clac
0c3b      c3b:	e8 00 00 00 00       	call   c40 <.altinstr_replacement+0xc40>	c3c: R_X86_64_PLT32	clear_page_rep-0x4
0c40      c40:	e8 00 00 00 00       	call   c45 <.altinstr_replacement+0xc45>	c41: R_X86_64_PLT32	clear_page_erms-0x4
0c45      c45:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c4a      c4a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c4f      c4f:	0f ae e8             	lfence
0c52      c52:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c57      c57:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c5c      c5c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c61      c61:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c66      c66:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c6b      c6b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c70      c70:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c75      c75:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c7a      c7a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c7f      c7f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0c84      c84:	0f 01 cb             	stac
0c87      c87:	0f ae e8             	lfence
0c8a      c8a:	0f 01 ca             	clac
0c8d      c8d:	0f 01 ca             	clac
0c90      c90:	0f 01 cb             	stac
0c93      c93:	e8 00 00 00 00       	call   c98 <.altinstr_replacement+0xc98>	c94: R_X86_64_PLT32	rep_movs_alternative-0x4
0c98      c98:	0f 01 ca             	clac
0c9b      c9b:	0f 01 cb             	stac
0c9e      c9e:	e8 00 00 00 00       	call   ca3 <.altinstr_replacement+0xca3>	c9f: R_X86_64_PLT32	rep_movs_alternative-0x4
0ca3      ca3:	0f 01 ca             	clac
0ca6      ca6:	0f 0d 4a f8          	prefetchw -0x8(%rdx)
0caa      caa:	e8 00 00 00 00       	call   caf <.altinstr_replacement+0xcaf>	cab: R_X86_64_PLT32	clear_page_rep-0x4
0caf      caf:	e8 00 00 00 00       	call   cb4 <.altinstr_replacement+0xcb4>	cb0: R_X86_64_PLT32	clear_page_erms-0x4
0cb4      cb4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0cb9      cb9:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0cbe      cbe:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0cc3      cc3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0cc8      cc8:	e9 00 00 00 00       	jmp    ccd <.altinstr_replacement+0xccd>	cc9: R_X86_64_PC32	.init.text+0x3c45f
0ccd      ccd:	0f 01 cb             	stac
0cd0      cd0:	0f ae e8             	lfence
0cd3      cd3:	0f 01 ca             	clac
0cd6      cd6:	0f 01 ca             	clac
0cd9      cd9:	0f 01 cb             	stac
0cdc      cdc:	0f ae e8             	lfence
0cdf      cdf:	0f 01 ca             	clac
0ce2      ce2:	0f 01 ca             	clac
0ce5      ce5:	e9 00 00 00 00       	jmp    cea <.altinstr_replacement+0xcea>	ce6: R_X86_64_PC32	.text+0x3281ea
0cea      cea:	e9 00 00 00 00       	jmp    cef <.altinstr_replacement+0xcef>	ceb: R_X86_64_PC32	.text+0x328313
0cef      cef:	e9 00 00 00 00       	jmp    cf4 <.altinstr_replacement+0xcf4>	cf0: R_X86_64_PC32	.text+0x329334
0cf4      cf4:	e9 00 00 00 00       	jmp    cf9 <.altinstr_replacement+0xcf9>	cf5: R_X86_64_PC32	.text+0x329594
0cf9      cf9:	e9 00 00 00 00       	jmp    cfe <.altinstr_replacement+0xcfe>	cfa: R_X86_64_PC32	.text+0x329704
0cfe      cfe:	e9 00 00 00 00       	jmp    d03 <.altinstr_replacement+0xd03>	cff: R_X86_64_PC32	.text+0x329877
0d03      d03:	e9 00 00 00 00       	jmp    d08 <.altinstr_replacement+0xd08>	d04: R_X86_64_PC32	.text+0x32999f
0d08      d08:	e9 00 00 00 00       	jmp    d0d <.altinstr_replacement+0xd0d>	d09: R_X86_64_PC32	.text+0x32a2e4
0d0d      d0d:	e9 00 00 00 00       	jmp    d12 <.altinstr_replacement+0xd12>	d0e: R_X86_64_PC32	.text+0x32a357
0d12      d12:	e9 00 00 00 00       	jmp    d17 <.altinstr_replacement+0xd17>	d13: R_X86_64_PC32	.text+0x32a6ed
0d17      d17:	e9 00 00 00 00       	jmp    d1c <.altinstr_replacement+0xd1c>	d18: R_X86_64_PC32	.text+0x32a769
0d1c      d1c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0d21      d21:	e9 00 00 00 00       	jmp    d26 <.altinstr_replacement+0xd26>	d22: R_X86_64_PC32	.text+0x32dca6
0d26      d26:	e9 00 00 00 00       	jmp    d2b <.altinstr_replacement+0xd2b>	d27: R_X86_64_PC32	.text+0x32e6a3
0d2b      d2b:	e9 00 00 00 00       	jmp    d30 <.altinstr_replacement+0xd30>	d2c: R_X86_64_PC32	.text+0x32eb82
0d30      d30:	e8 00 00 00 00       	call   d35 <.altinstr_replacement+0xd35>	d31: R_X86_64_PLT32	clear_page_rep-0x4
0d35      d35:	e8 00 00 00 00       	call   d3a <.altinstr_replacement+0xd3a>	d36: R_X86_64_PLT32	clear_page_erms-0x4
0d3a      d3a:	e9 00 00 00 00       	jmp    d3f <.altinstr_replacement+0xd3f>	d3b: R_X86_64_PC32	.text+0x32f435
0d3f      d3f:	0f 01 cb             	stac
0d42      d42:	e8 00 00 00 00       	call   d47 <.altinstr_replacement+0xd47>	d43: R_X86_64_PLT32	rep_movs_alternative-0x4
0d47      d47:	0f 01 ca             	clac
0d4a      d4a:	e8 00 00 00 00       	call   d4f <.altinstr_replacement+0xd4f>	d4b: R_X86_64_PLT32	clear_page_rep-0x4
0d4f      d4f:	e8 00 00 00 00       	call   d54 <.altinstr_replacement+0xd54>	d50: R_X86_64_PLT32	clear_page_erms-0x4
0d54      d54:	0f 01 cb             	stac
0d57      d57:	e8 00 00 00 00       	call   d5c <.altinstr_replacement+0xd5c>	d58: R_X86_64_PLT32	rep_movs_alternative-0x4
0d5c      d5c:	0f 01 ca             	clac
0d5f      d5f:	e9 00 00 00 00       	jmp    d64 <.altinstr_replacement+0xd64>	d60: R_X86_64_PC32	.text+0x330972
0d64      d64:	e9 00 00 00 00       	jmp    d69 <.altinstr_replacement+0xd69>	d65: R_X86_64_PC32	.text+0x3334ef
0d69      d69:	e9 00 00 00 00       	jmp    d6e <.altinstr_replacement+0xd6e>	d6a: R_X86_64_PC32	.text+0x33567c
0d6e      d6e:	e8 00 00 00 00       	call   d73 <.altinstr_replacement+0xd73>	d6f: R_X86_64_PLT32	clear_page_rep-0x4
0d73      d73:	e8 00 00 00 00       	call   d78 <.altinstr_replacement+0xd78>	d74: R_X86_64_PLT32	clear_page_erms-0x4
0d78      d78:	e9 00 00 00 00       	jmp    d7d <.altinstr_replacement+0xd7d>	d79: R_X86_64_PC32	.text+0x3389d9
0d7d      d7d:	e9 00 00 00 00       	jmp    d82 <.altinstr_replacement+0xd82>	d7e: R_X86_64_PC32	.text+0x338f01
0d82      d82:	e9 00 00 00 00       	jmp    d87 <.altinstr_replacement+0xd87>	d83: R_X86_64_PC32	.text+0x3391da
0d87      d87:	e9 00 00 00 00       	jmp    d8c <.altinstr_replacement+0xd8c>	d88: R_X86_64_PC32	.text+0x34293f
0d8c      d8c:	e9 00 00 00 00       	jmp    d91 <.altinstr_replacement+0xd91>	d8d: R_X86_64_PC32	.text+0x343e18
0d91      d91:	e9 00 00 00 00       	jmp    d96 <.altinstr_replacement+0xd96>	d92: R_X86_64_PC32	.text+0x344d5f
0d96      d96:	e9 00 00 00 00       	jmp    d9b <.altinstr_replacement+0xd9b>	d97: R_X86_64_PC32	.text+0x34506b
0d9b      d9b:	e9 00 00 00 00       	jmp    da0 <.altinstr_replacement+0xda0>	d9c: R_X86_64_PC32	.text+0x34522e
0da0      da0:	e9 00 00 00 00       	jmp    da5 <.altinstr_replacement+0xda5>	da1: R_X86_64_PC32	.text+0x3452e5
0da5      da5:	e9 00 00 00 00       	jmp    daa <.altinstr_replacement+0xdaa>	da6: R_X86_64_PC32	.text+0x3453d8
0daa      daa:	e9 00 00 00 00       	jmp    daf <.altinstr_replacement+0xdaf>	dab: R_X86_64_PC32	.text+0x34a42b
0daf      daf:	e9 00 00 00 00       	jmp    db4 <.altinstr_replacement+0xdb4>	db0: R_X86_64_PC32	.text+0x34c5a3
0db4      db4:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0db9      db9:	e9 00 00 00 00       	jmp    dbe <.altinstr_replacement+0xdbe>	dba: R_X86_64_PC32	.text+0x355c31
0dbe      dbe:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0dc3      dc3:	e8 00 00 00 00       	call   dc8 <.altinstr_replacement+0xdc8>	dc4: R_X86_64_PLT32	clear_page_rep-0x4
0dc8      dc8:	e8 00 00 00 00       	call   dcd <.altinstr_replacement+0xdcd>	dc9: R_X86_64_PLT32	clear_page_erms-0x4
0dcd      dcd:	0f 0d 0f             	prefetchw (%rdi)
0dd0      dd0:	0f 0d 08             	prefetchw (%rax)
0dd3      dd3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0dd8      dd8:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0ddd      ddd:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0de2      de2:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0de7      de7:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0dec      dec:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0df1      df1:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0df5      df5:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0dfa      dfa:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0dff      dff:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e03      e03:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0e08      e08:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e0c      e0c:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0e11      e11:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e15      e15:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0e1a      e1a:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e1e      e1e:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0e23      e23:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e27      e27:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0e2c      e2c:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e30      e30:	65 48 0f c7 0e       	cmpxchg16b %gs:(%rsi)
0e35      e35:	0f 0d 0c 03          	prefetchw (%rbx,%rax,1)
0e39      e39:	e9 00 00 00 00       	jmp    e3e <.altinstr_replacement+0xe3e>	e3a: R_X86_64_PC32	.text+0x37fe68
0e3e      e3e:	e9 00 00 00 00       	jmp    e43 <.altinstr_replacement+0xe43>	e3f: R_X86_64_PC32	.text+0x380dfc
0e43      e43:	e9 00 00 00 00       	jmp    e48 <.altinstr_replacement+0xe48>	e44: R_X86_64_PC32	.text+0x3814a4
0e48      e48:	e9 00 00 00 00       	jmp    e4d <.altinstr_replacement+0xe4d>	e49: R_X86_64_PC32	.text+0x382483
0e4d      e4d:	e9 00 00 00 00       	jmp    e52 <.altinstr_replacement+0xe52>	e4e: R_X86_64_PC32	.text+0x385020
0e52      e52:	e9 00 00 00 00       	jmp    e57 <.altinstr_replacement+0xe57>	e53: R_X86_64_PC32	.text+0x386a51
0e57      e57:	e8 00 00 00 00       	call   e5c <.altinstr_replacement+0xe5c>	e58: R_X86_64_PLT32	clear_page_rep-0x4
0e5c      e5c:	e8 00 00 00 00       	call   e61 <.altinstr_replacement+0xe61>	e5d: R_X86_64_PLT32	clear_page_erms-0x4
0e61      e61:	e8 00 00 00 00       	call   e66 <.altinstr_replacement+0xe66>	e62: R_X86_64_PLT32	clear_page_rep-0x4
0e66      e66:	e8 00 00 00 00       	call   e6b <.altinstr_replacement+0xe6b>	e67: R_X86_64_PLT32	clear_page_erms-0x4
0e6b      e6b:	e8 00 00 00 00       	call   e70 <.altinstr_replacement+0xe70>	e6c: R_X86_64_PLT32	clear_page_rep-0x4
0e70      e70:	e8 00 00 00 00       	call   e75 <.altinstr_replacement+0xe75>	e71: R_X86_64_PLT32	clear_page_erms-0x4
0e75      e75:	e9 00 00 00 00       	jmp    e7a <.altinstr_replacement+0xe7a>	e76: R_X86_64_PC32	.text+0x389432
0e7a      e7a:	e9 00 00 00 00       	jmp    e7f <.altinstr_replacement+0xe7f>	e7b: R_X86_64_PC32	.text+0x399dc1
0e7f      e7f:	e9 00 00 00 00       	jmp    e84 <.altinstr_replacement+0xe84>	e80: R_X86_64_PC32	.text+0x399f44
0e84      e84:	e9 00 00 00 00       	jmp    e89 <.altinstr_replacement+0xe89>	e85: R_X86_64_PC32	.text+0x39b16c
0e89      e89:	e9 00 00 00 00       	jmp    e8e <.altinstr_replacement+0xe8e>	e8a: R_X86_64_PC32	.text+0x39b56a
0e8e      e8e:	f3 0f b8 c7          	popcnt %edi,%eax
0e92      e92:	f3 0f b8 c7          	popcnt %edi,%eax
0e96      e96:	f3 0f b8 c7          	popcnt %edi,%eax
0e9a      e9a:	f3 0f b8 c7          	popcnt %edi,%eax
0e9e      e9e:	f3 0f b8 c7          	popcnt %edi,%eax
0ea2      ea2:	f3 0f b8 c7          	popcnt %edi,%eax
0ea6      ea6:	0f 01 cb             	stac
0ea9      ea9:	0f ae e8             	lfence
0eac      eac:	0f 01 ca             	clac
0eaf      eaf:	0f 01 ca             	clac
0eb2      eb2:	0f 01 cb             	stac
0eb5      eb5:	0f ae e8             	lfence
0eb8      eb8:	0f 01 ca             	clac
0ebb      ebb:	0f 01 ca             	clac
0ebe      ebe:	0f 01 cb             	stac
0ec1      ec1:	0f ae e8             	lfence
0ec4      ec4:	0f 01 ca             	clac
0ec7      ec7:	0f 01 ca             	clac
0eca      eca:	0f 01 cb             	stac
0ecd      ecd:	0f ae e8             	lfence
0ed0      ed0:	0f 01 ca             	clac
0ed3      ed3:	0f 01 ca             	clac
0ed6      ed6:	0f 01 cb             	stac
0ed9      ed9:	e8 00 00 00 00       	call   ede <.altinstr_replacement+0xede>	eda: R_X86_64_PLT32	rep_movs_alternative-0x4
0ede      ede:	0f 01 ca             	clac
0ee1      ee1:	0f 01 cb             	stac
0ee4      ee4:	e8 00 00 00 00       	call   ee9 <.altinstr_replacement+0xee9>	ee5: R_X86_64_PLT32	rep_movs_alternative-0x4
0ee9      ee9:	0f 01 ca             	clac
0eec      eec:	0f 01 cb             	stac
0eef      eef:	e8 00 00 00 00       	call   ef4 <.altinstr_replacement+0xef4>	ef0: R_X86_64_PLT32	rep_movs_alternative-0x4
0ef4      ef4:	0f 01 ca             	clac
0ef7      ef7:	0f 01 cb             	stac
0efa      efa:	0f ae e8             	lfence
0efd      efd:	0f 01 ca             	clac
0f00      f00:	0f 01 ca             	clac
0f03      f03:	f3 0f b8 c7          	popcnt %edi,%eax
0f07      f07:	41 0f 0d 4d 00       	prefetchw 0x0(%r13)
0f0c      f0c:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f11      f11:	0f 01 cb             	stac
0f14      f14:	e8 00 00 00 00       	call   f19 <.altinstr_replacement+0xf19>	f15: R_X86_64_PLT32	rep_stos_alternative-0x4
0f19      f19:	0f 01 ca             	clac
0f1c      f1c:	e9 00 00 00 00       	jmp    f21 <.altinstr_replacement+0xf21>	f1d: R_X86_64_PC32	.text+0x41cfdb
0f21      f21:	e9 00 00 00 00       	jmp    f26 <.altinstr_replacement+0xf26>	f22: R_X86_64_PC32	.text+0x41e9e7
0f26      f26:	41 0f 0d 0e          	prefetchw (%r14)
0f2a      f2a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f2f      f2f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f34      f34:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f39      f39:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f3e      f3e:	e8 00 00 00 00       	call   f43 <.altinstr_replacement+0xf43>	f3f: R_X86_64_PLT32	clear_page_rep-0x4
0f43      f43:	e8 00 00 00 00       	call   f48 <.altinstr_replacement+0xf48>	f44: R_X86_64_PLT32	clear_page_erms-0x4
0f48      f48:	e8 00 00 00 00       	call   f4d <.altinstr_replacement+0xf4d>	f49: R_X86_64_PLT32	clear_page_rep-0x4
0f4d      f4d:	e8 00 00 00 00       	call   f52 <.altinstr_replacement+0xf52>	f4e: R_X86_64_PLT32	clear_page_erms-0x4
0f52      f52:	f3 0f b8 c7          	popcnt %edi,%eax
0f56      f56:	f3 0f b8 c7          	popcnt %edi,%eax
0f5a      f5a:	f3 0f b8 c7          	popcnt %edi,%eax
0f5e      f5e:	f3 0f b8 c7          	popcnt %edi,%eax
0f62      f62:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f67      f67:	f3 0f b8 c7          	popcnt %edi,%eax
0f6b      f6b:	f3 0f b8 c7          	popcnt %edi,%eax
0f6f      f6f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f74      f74:	f3 0f b8 c7          	popcnt %edi,%eax
0f78      f78:	e8 00 00 00 00       	call   f7d <.altinstr_replacement+0xf7d>	f79: R_X86_64_PLT32	clear_page_rep-0x4
0f7d      f7d:	e8 00 00 00 00       	call   f82 <.altinstr_replacement+0xf82>	f7e: R_X86_64_PLT32	clear_page_erms-0x4
0f82      f82:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f87      f87:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0f8c      f8c:	e8 00 00 00 00       	call   f91 <.altinstr_replacement+0xf91>	f8d: R_X86_64_PLT32	clear_page_rep-0x4
0f91      f91:	e8 00 00 00 00       	call   f96 <.altinstr_replacement+0xf96>	f92: R_X86_64_PLT32	clear_page_erms-0x4
0f96      f96:	e8 00 00 00 00       	call   f9b <.altinstr_replacement+0xf9b>	f97: R_X86_64_PLT32	clear_page_rep-0x4
0f9b      f9b:	e8 00 00 00 00       	call   fa0 <.altinstr_replacement+0xfa0>	f9c: R_X86_64_PLT32	clear_page_erms-0x4
0fa0      fa0:	e8 00 00 00 00       	call   fa5 <.altinstr_replacement+0xfa5>	fa1: R_X86_64_PLT32	clear_page_rep-0x4
0fa5      fa5:	e8 00 00 00 00       	call   faa <.altinstr_replacement+0xfaa>	fa6: R_X86_64_PLT32	clear_page_erms-0x4
0faa      faa:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0faf      faf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0fb4      fb4:	0f 01 cb             	stac
0fb7      fb7:	e8 00 00 00 00       	call   fbc <.altinstr_replacement+0xfbc>	fb8: R_X86_64_PLT32	rep_stos_alternative-0x4
0fbc      fbc:	0f 01 ca             	clac
0fbf      fbf:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0fc4      fc4:	f3 0f b8 c7          	popcnt %edi,%eax
0fc8      fc8:	f3 0f b8 c7          	popcnt %edi,%eax
0fcc      fcc:	f3 0f b8 c7          	popcnt %edi,%eax
0fd0      fd0:	f3 0f b8 c7          	popcnt %edi,%eax
0fd4      fd4:	f3 0f b8 c7          	popcnt %edi,%eax
0fd8      fd8:	f3 0f b8 c7          	popcnt %edi,%eax
0fdc      fdc:	f3 0f b8 c7          	popcnt %edi,%eax
0fe0      fe0:	f3 0f b8 c7          	popcnt %edi,%eax
0fe4      fe4:	0f 01 cb             	stac
0fe7      fe7:	0f ae e8             	lfence
0fea      fea:	0f 01 ca             	clac
0fed      fed:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0ff2      ff2:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0ff7      ff7:	f3 48 0f b8 c7       	popcnt %rdi,%rax
0ffc      ffc:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1001     1001:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1006     1006:	f3 48 0f b8 c7       	popcnt %rdi,%rax
100b     100b:	0f 01 cb             	stac
100e     100e:	0f ae e8             	lfence
1011     1011:	0f 01 ca             	clac
1014     1014:	0f 01 cb             	stac
1017     1017:	0f ae e8             	lfence
101a     101a:	0f 01 ca             	clac
101d     101d:	0f 01 cb             	stac
1020     1020:	e8 00 00 00 00       	call   1025 <.altinstr_replacement+0x1025>	1021: R_X86_64_PLT32	rep_movs_alternative-0x4
1025     1025:	0f 01 ca             	clac
1028     1028:	0f 01 cb             	stac
102b     102b:	e8 00 00 00 00       	call   1030 <.altinstr_replacement+0x1030>	102c: R_X86_64_PLT32	rep_movs_alternative-0x4
1030     1030:	0f 01 ca             	clac
1033     1033:	0f 01 cb             	stac
1036     1036:	0f 01 ca             	clac
1039     1039:	0f 01 cb             	stac
103c     103c:	0f 01 ca             	clac
103f     103f:	0f 01 cb             	stac
1042     1042:	e8 00 00 00 00       	call   1047 <.altinstr_replacement+0x1047>	1043: R_X86_64_PLT32	rep_movs_alternative-0x4
1047     1047:	0f 01 ca             	clac
104a     104a:	0f 01 cb             	stac
104d     104d:	e8 00 00 00 00       	call   1052 <.altinstr_replacement+0x1052>	104e: R_X86_64_PLT32	rep_movs_alternative-0x4
1052     1052:	0f 01 ca             	clac
1055     1055:	0f 01 cb             	stac
1058     1058:	e8 00 00 00 00       	call   105d <.altinstr_replacement+0x105d>	1059: R_X86_64_PLT32	rep_movs_alternative-0x4
105d     105d:	0f 01 ca             	clac
1060     1060:	0f 01 cb             	stac
1063     1063:	e8 00 00 00 00       	call   1068 <.altinstr_replacement+0x1068>	1064: R_X86_64_PLT32	rep_movs_alternative-0x4
1068     1068:	0f 01 ca             	clac
106b     106b:	0f 01 cb             	stac
106e     106e:	e8 00 00 00 00       	call   1073 <.altinstr_replacement+0x1073>	106f: R_X86_64_PLT32	rep_stos_alternative-0x4
1073     1073:	0f 01 ca             	clac
1076     1076:	0f 01 cb             	stac
1079     1079:	e8 00 00 00 00       	call   107e <.altinstr_replacement+0x107e>	107a: R_X86_64_PLT32	rep_stos_alternative-0x4
107e     107e:	0f 01 ca             	clac
1081     1081:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1086     1086:	f3 48 0f b8 c7       	popcnt %rdi,%rax
108b     108b:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1090     1090:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1095     1095:	f3 0f b8 c7          	popcnt %edi,%eax
1099     1099:	f3 0f b8 c7          	popcnt %edi,%eax
109d     109d:	0f 01 cb             	stac
10a0     10a0:	0f ae e8             	lfence
10a3     10a3:	0f 01 ca             	clac
10a6     10a6:	0f 01 ca             	clac
10a9     10a9:	0f 01 cb             	stac
10ac     10ac:	e8 00 00 00 00       	call   10b1 <.altinstr_replacement+0x10b1>	10ad: R_X86_64_PLT32	rep_movs_alternative-0x4
10b1     10b1:	0f 01 ca             	clac
10b4     10b4:	0f ae e8             	lfence
10b7     10b7:	0f 01 cb             	stac
10ba     10ba:	e8 00 00 00 00       	call   10bf <.altinstr_replacement+0x10bf>	10bb: R_X86_64_PLT32	rep_movs_alternative-0x4
10bf     10bf:	0f 01 ca             	clac
10c2     10c2:	f3 48 0f b8 c7       	popcnt %rdi,%rax
10c7     10c7:	0f 01 cb             	stac
10ca     10ca:	0f ae e8             	lfence
10cd     10cd:	0f 01 ca             	clac
10d0     10d0:	0f 01 cb             	stac
10d3     10d3:	0f ae e8             	lfence
10d6     10d6:	0f 01 ca             	clac
10d9     10d9:	f3 48 0f b8 c7       	popcnt %rdi,%rax
10de     10de:	f3 48 0f b8 c7       	popcnt %rdi,%rax
10e3     10e3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
10e8     10e8:	f3 48 0f b8 c7       	popcnt %rdi,%rax
10ed     10ed:	f3 0f b8 c7          	popcnt %edi,%eax
10f1     10f1:	f3 0f b8 c7          	popcnt %edi,%eax
10f5     10f5:	e9 00 00 00 00       	jmp    10fa <.altinstr_replacement+0x10fa>	10f6: R_X86_64_PC32	.cpuidle.text+0x328
10fa     10fa:	e9 00 00 00 00       	jmp    10ff <.altinstr_replacement+0x10ff>	10fb: R_X86_64_PC32	.cpuidle.text+0x2cb
10ff     10ff:	e9 00 00 00 00       	jmp    1104 <.altinstr_replacement+0x1104>	1100: R_X86_64_PC32	.cpuidle.text+0x3e7
1104     1104:	e9 00 00 00 00       	jmp    1109 <.altinstr_replacement+0x1109>	1105: R_X86_64_PC32	.cpuidle.text+0x38b
1109     1109:	e9 00 00 00 00       	jmp    110e <.altinstr_replacement+0x110e>	110a: R_X86_64_PC32	.cpuidle.text+0x4bb
110e     110e:	e9 00 00 00 00       	jmp    1113 <.altinstr_replacement+0x1113>	110f: R_X86_64_PC32	.cpuidle.text+0x45e
1113     1113:	e9 00 00 00 00       	jmp    1118 <.altinstr_replacement+0x1118>	1114: R_X86_64_PC32	.cpuidle.text+0x587
1118     1118:	e9 00 00 00 00       	jmp    111d <.altinstr_replacement+0x111d>	1119: R_X86_64_PC32	.cpuidle.text+0x529
111d     111d:	e9 00 00 00 00       	jmp    1122 <.altinstr_replacement+0x1122>	111e: R_X86_64_PC32	.text+0x9ea5c1
1122     1122:	e9 00 00 00 00       	jmp    1127 <.altinstr_replacement+0x1127>	1123: R_X86_64_PC32	.cpuidle.text+0x6a1
1127     1127:	e9 00 00 00 00       	jmp    112c <.altinstr_replacement+0x112c>	1128: R_X86_64_PC32	.cpuidle.text+0x621
112c     112c:	e9 00 00 00 00       	jmp    1131 <.altinstr_replacement+0x1131>	112d: R_X86_64_PC32	.text+0xa1de4b
1131     1131:	e9 00 00 00 00       	jmp    1136 <.altinstr_replacement+0x1136>	1132: R_X86_64_PC32	.text+0xa1f427
1136     1136:	e9 00 00 00 00       	jmp    113b <.altinstr_replacement+0x113b>	1137: R_X86_64_PC32	.text+0xa3c056
113b     113b:	e9 00 00 00 00       	jmp    1140 <.altinstr_replacement+0x1140>	113c: R_X86_64_PC32	.cpuidle.text+0x99c
1140     1140:	e9 00 00 00 00       	jmp    1145 <.altinstr_replacement+0x1145>	1141: R_X86_64_PC32	.cpuidle.text+0xa9c
1145     1145:	e9 00 00 00 00       	jmp    114a <.altinstr_replacement+0x114a>	1146: R_X86_64_PC32	.text+0xa4422e
114a     114a:	e9 00 00 00 00       	jmp    114f <.altinstr_replacement+0x114f>	114b: R_X86_64_PC32	.text+0xa44192
114f     114f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1154     1154:	f3 0f b8 c7          	popcnt %edi,%eax
1158     1158:	f3 0f b8 c7          	popcnt %edi,%eax
115c     115c:	0f 01 cb             	stac
115f     115f:	e8 00 00 00 00       	call   1164 <.altinstr_replacement+0x1164>	1160: R_X86_64_PLT32	rep_stos_alternative-0x4
1164     1164:	0f 01 ca             	clac
1167     1167:	f3 48 0f b8 c7       	popcnt %rdi,%rax
116c     116c:	e9 00 00 00 00       	jmp    1171 <.altinstr_replacement+0x1171>	116d: R_X86_64_PC32	.text+0xb56231
1171     1171:	e9 00 00 00 00       	jmp    1176 <.altinstr_replacement+0x1176>	1172: R_X86_64_PC32	.text+0xb56249
1176     1176:	e9 00 00 00 00       	jmp    117b <.altinstr_replacement+0x117b>	1177: R_X86_64_PC32	.init.text+0x669bd
117b     117b:	e9 00 00 00 00       	jmp    1180 <.altinstr_replacement+0x1180>	117c: R_X86_64_PC32	.init.text+0x669d6
1180     1180:	f3 0f b8 c7          	popcnt %edi,%eax
1184     1184:	e9 00 00 00 00       	jmp    1189 <.altinstr_replacement+0x1189>	1185: R_X86_64_PC32	.text+0xb9227f
1189     1189:	66 0f ae 3f          	clflushopt (%rdi)
118d     118d:	66 0f ae 7e ff       	clflushopt -0x1(%rsi)
1192     1192:	66 0f ae 38          	clflushopt (%rax)
1196     1196:	e9 00 00 00 00       	jmp    119b <.altinstr_replacement+0x119b>	1197: R_X86_64_PC32	.text+0xb923c1
119b     119b:	e9 00 00 00 00       	jmp    11a0 <.altinstr_replacement+0x11a0>	119c: R_X86_64_PC32	.text+0xb9282f
11a0     11a0:	e9 00 00 00 00       	jmp    11a5 <.altinstr_replacement+0x11a5>	11a1: R_X86_64_PC32	.text+0xb9288f
11a5     11a5:	f3 0f b8 c7          	popcnt %edi,%eax
11a9     11a9:	f3 0f b8 c7          	popcnt %edi,%eax
11ad     11ad:	f3 0f b8 c7          	popcnt %edi,%eax
11b1     11b1:	f3 48 0f b8 c7       	popcnt %rdi,%rax
11b6     11b6:	f3 0f b8 c7          	popcnt %edi,%eax
11ba     11ba:	f3 0f b8 c7          	popcnt %edi,%eax
11be     11be:	f3 0f b8 c7          	popcnt %edi,%eax
11c2     11c2:	e8 00 00 00 00       	call   11c7 <.altinstr_replacement+0x11c7>	11c3: R_X86_64_PLT32	clear_page_rep-0x4
11c7     11c7:	e8 00 00 00 00       	call   11cc <.altinstr_replacement+0x11cc>	11c8: R_X86_64_PLT32	clear_page_erms-0x4
11cc     11cc:	0f 01 c1             	vmcall
11cf     11cf:	0f 01 d9             	vmmcall
11d2     11d2:	0f 01 c1             	vmcall
11d5     11d5:	0f 01 d9             	vmmcall
11d8     11d8:	0f 01 c1             	vmcall
11db     11db:	0f 01 d9             	vmmcall
11de     11de:	0f 01 c1             	vmcall
11e1     11e1:	0f 01 d9             	vmmcall
11e4     11e4:	0f 01 c1             	vmcall
11e7     11e7:	0f 01 d9             	vmmcall
11ea     11ea:	0f 01 c1             	vmcall
11ed     11ed:	0f 01 d9             	vmmcall
11f0     11f0:	0f 01 c1             	vmcall
11f3     11f3:	0f 01 d9             	vmmcall
11f6     11f6:	0f 01 c1             	vmcall
11f9     11f9:	0f 01 d9             	vmmcall
11fc     11fc:	0f 01 c1             	vmcall
11ff     11ff:	0f 01 d9             	vmmcall
1202     1202:	0f 01 c1             	vmcall
1205     1205:	0f 01 d9             	vmmcall
1208     1208:	0f 01 c1             	vmcall
120b     120b:	0f 01 d9             	vmmcall
120e     120e:	0f 01 c1             	vmcall
1211     1211:	0f 01 d9             	vmmcall
1214     1214:	0f 01 c1             	vmcall
1217     1217:	0f 01 d9             	vmmcall
121a     121a:	f3 0f b8 c7          	popcnt %edi,%eax
121e     121e:	f3 0f b8 c7          	popcnt %edi,%eax
1222     1222:	f3 0f b8 c7          	popcnt %edi,%eax
1226     1226:	f3 0f b8 c7          	popcnt %edi,%eax
122a     122a:	f3 0f b8 c7          	popcnt %edi,%eax
122e     122e:	f3 0f b8 c7          	popcnt %edi,%eax
1232     1232:	f3 0f b8 c7          	popcnt %edi,%eax
1236     1236:	f3 0f b8 c7          	popcnt %edi,%eax
123a     123a:	f3 0f b8 c7          	popcnt %edi,%eax
123e     123e:	f3 0f b8 c7          	popcnt %edi,%eax
1242     1242:	f3 0f b8 c7          	popcnt %edi,%eax
1246     1246:	f3 0f b8 c7          	popcnt %edi,%eax
124a     124a:	0f 01 cb             	stac
124d     124d:	0f 01 ca             	clac
1250     1250:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1255     1255:	f3 48 0f b8 c7       	popcnt %rdi,%rax
125a     125a:	f3 0f b8 c7          	popcnt %edi,%eax
125e     125e:	f3 0f b8 c7          	popcnt %edi,%eax
1262     1262:	e9 00 00 00 00       	jmp    1267 <.altinstr_replacement+0x1267>	1263: R_X86_64_PC32	.text+0xf3cc90
1267     1267:	f3 0f b8 c7          	popcnt %edi,%eax
126b     126b:	f3 0f b8 c7          	popcnt %edi,%eax
126f     126f:	e9 00 00 00 00       	jmp    1274 <.altinstr_replacement+0x1274>	1270: R_X86_64_PC32	.text+0xf4ae05
1274     1274:	0f 0d 0e             	prefetchw (%rsi)
1277     1277:	0f 0d 0e             	prefetchw (%rsi)
127a     127a:	f3 0f b8 c7          	popcnt %edi,%eax
127e     127e:	f3 0f b8 c7          	popcnt %edi,%eax
1282     1282:	f3 0f b8 c7          	popcnt %edi,%eax
1286     1286:	f3 0f b8 c7          	popcnt %edi,%eax
128a     128a:	0f 0d 0a             	prefetchw (%rdx)
128d     128d:	0f 0d 08             	prefetchw (%rax)
1290     1290:	0f 0d 0b             	prefetchw (%rbx)
1293     1293:	f3 0f b8 c7          	popcnt %edi,%eax
1297     1297:	f3 48 0f b8 c7       	popcnt %rdi,%rax
129c     129c:	0f 01 cb             	stac
129f     129f:	e8 00 00 00 00       	call   12a4 <.altinstr_replacement+0x12a4>	12a0: R_X86_64_PLT32	rep_stos_alternative-0x4
12a4     12a4:	0f 01 ca             	clac
12a7     12a7:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12ac     12ac:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12b1     12b1:	f3 0f b8 c7          	popcnt %edi,%eax
12b5     12b5:	f3 0f b8 c7          	popcnt %edi,%eax
12b9     12b9:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12be     12be:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12c3     12c3:	f3 0f b8 c7          	popcnt %edi,%eax
12c7     12c7:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12cc     12cc:	f3 0f b8 c7          	popcnt %edi,%eax
12d0     12d0:	f3 0f b8 c7          	popcnt %edi,%eax
12d4     12d4:	f3 0f b8 c7          	popcnt %edi,%eax
12d8     12d8:	f3 0f b8 c7          	popcnt %edi,%eax
12dc     12dc:	f3 0f b8 c7          	popcnt %edi,%eax
12e0     12e0:	e9 00 00 00 00       	jmp    12e5 <.altinstr_replacement+0x12e5>	12e1: R_X86_64_PC32	.text+0x1593b4f
12e5     12e5:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12ea     12ea:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12ef     12ef:	f3 0f b8 c7          	popcnt %edi,%eax
12f3     12f3:	f3 48 0f b8 c7       	popcnt %rdi,%rax
12f8     12f8:	f3 0f b8 c7          	popcnt %edi,%eax
12fc     12fc:	e9 00 00 00 00       	jmp    1301 <.altinstr_replacement+0x1301>	12fd: R_X86_64_PC32	.init.text+0x8d2e3
1301     1301:	e9 00 00 00 00       	jmp    1306 <.altinstr_replacement+0x1306>	1302: R_X86_64_PC32	.init.text+0x8d449
1306     1306:	f3 0f b8 c7          	popcnt %edi,%eax
130a     130a:	f3 0f b8 c7          	popcnt %edi,%eax
130e     130e:	f3 0f b8 c7          	popcnt %edi,%eax
1312     1312:	f3 0f b8 c7          	popcnt %edi,%eax
1316     1316:	f3 0f b8 c7          	popcnt %edi,%eax
131a     131a:	f3 48 0f b8 c7       	popcnt %rdi,%rax
131f     131f:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1324     1324:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1329     1329:	f3 0f b8 c7          	popcnt %edi,%eax
132d     132d:	f3 0f b8 c7          	popcnt %edi,%eax
1331     1331:	f3 48 0f b8 c7       	popcnt %rdi,%rax
1336     1336:	f3 48 0f b8 c7       	popcnt %rdi,%rax
133b     133b:	0f 01 cb             	stac
133e     133e:	e8 00 00 00 00       	call   1343 <.altinstr_replacement+0x1343>	133f: R_X86_64_PLT32	rep_stos_alternative-0x4
1343     1343:	0f 01 ca             	clac
1346     1346:	e9 00 00 00 00       	jmp    134b <.altinstr_replacement+0x134b>	1347: R_X86_64_PC32	.text+0x1850cf6
134b     134b:	e9 00 00 00 00       	jmp    1350 <.altinstr_replacement+0x1350>	134c: R_X86_64_PC32	.text+0x1850d5e
1350     1350:	0f 01 cb             	stac
1353     1353:	0f 01 ca             	clac
1356     1356:	0f 01 cb             	stac
1359     1359:	e8 00 00 00 00       	call   135e <.altinstr_replacement+0x135e>	135a: R_X86_64_PLT32	rep_movs_alternative-0x4
135e     135e:	0f 01 ca             	clac
1361     1361:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
1363     1363:	0f ae e8             	lfence
1366     1366:	0f 31                	rdtsc
1368     1368:	0f 01 f9             	rdtscp
136b     136b:	0f ae e8             	lfence
136e     136e:	0f 31                	rdtsc
1370     1370:	0f 01 f9             	rdtscp
1373     1373:	0f ae e8             	lfence
1376     1376:	0f 31                	rdtsc
1378     1378:	0f 01 f9             	rdtscp
137b     137b:	0f ae e8             	lfence
137e     137e:	0f 31                	rdtsc
1380     1380:	0f 01 f9             	rdtscp
1383     1383:	0f ae e8             	lfence
1386     1386:	0f 31                	rdtsc
1388     1388:	0f 01 f9             	rdtscp
138b     138b:	0f 01 cb             	stac
138e     138e:	0f 01 ca             	clac
1391     1391:	0f 01 cb             	stac
1394     1394:	0f 01 ca             	clac
1397     1397:	0f 01 cb             	stac
139a     139a:	0f 01 ca             	clac
139d     139d:	0f 01 cb             	stac
13a0     13a0:	0f 01 ca             	clac
13a3     13a3:	0f 01 cb             	stac
13a6     13a6:	0f ae e8             	lfence
13a9     13a9:	0f 01 ca             	clac
13ac     13ac:	0f 01 cb             	stac
13af     13af:	0f ae e8             	lfence
13b2     13b2:	0f 01 ca             	clac
13b5     13b5:	0f 01 cb             	stac
13b8     13b8:	0f ae e8             	lfence
13bb     13bb:	0f 01 ca             	clac
13be     13be:	0f 01 cb             	stac
13c1     13c1:	0f ae e8             	lfence
13c4     13c4:	0f 01 ca             	clac
13c7     13c7:	0f 01 ca             	clac
13ca     13ca:	0f 01 cb             	stac
13cd     13cd:	e8 00 00 00 00       	call   13d2 <.altinstr_replacement+0x13d2>	13ce: R_X86_64_PLT32	rep_movs_alternative-0x4
13d2     13d2:	0f 01 ca             	clac
13d5     13d5:	48 83 fa 20          	cmp    $0x20,%rdx
13d9     13d9:	0f 82 00 00 00 00    	jb     13df <.altinstr_replacement+0x13df>	13db: R_X86_64_PC32	.noinstr.text+0x4382
13df     13df:	48 89 d1             	mov    %rdx,%rcx
13e2     13e2:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
13e4     13e4:	e9 00 00 00 00       	jmp    13e9 <.altinstr_replacement+0x13e9>	13e5: R_X86_64_PLT32	__x86_return_thunk-0x4
13e9     13e9:	48 89 d1             	mov    %rdx,%rcx
13ec     13ec:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
13ee     13ee:	e9 00 00 00 00       	jmp    13f3 <.altinstr_replacement+0x13f3>	13ef: R_X86_64_PLT32	__x86_return_thunk-0x4
13f3     13f3:	0f 01 cb             	stac
13f6     13f6:	0f 01 ca             	clac
13f9     13f9:	0f 01 cb             	stac
13fc     13fc:	0f 01 ca             	clac
13ff     13ff:	0f 01 cb             	stac
1402     1402:	0f 01 ca             	clac
1405     1405:	0f 01 cb             	stac
1408     1408:	0f 01 ca             	clac
140b     140b:	0f 01 cb             	stac
140e     140e:	0f 01 ca             	clac
1411     1411:	0f 01 cb             	stac
1414     1414:	0f 01 ca             	clac
1417     1417:	0f 01 cb             	stac
141a     141a:	0f 01 ca             	clac
141d     141d:	0f 01 cb             	stac
1420     1420:	0f 01 ca             	clac
1423     1423:	0f 01 ca             	clac
1426     1426:	0f ae e8             	lfence
1429     1429:	ff e0                	jmp    *%rax
142b     142b:	cc                   	int3
142c     142c:	ff e0                	jmp    *%rax
142e     142e:	0f ae e8             	lfence
1431     1431:	ff e1                	jmp    *%rcx
1433     1433:	cc                   	int3
1434     1434:	ff e1                	jmp    *%rcx
1436     1436:	0f ae e8             	lfence
1439     1439:	ff e2                	jmp    *%rdx
143b     143b:	cc                   	int3
143c     143c:	ff e2                	jmp    *%rdx
143e     143e:	0f ae e8             	lfence
1441     1441:	ff e3                	jmp    *%rbx
1443     1443:	cc                   	int3
1444     1444:	ff e3                	jmp    *%rbx
1446     1446:	0f ae e8             	lfence
1449     1449:	ff e4                	jmp    *%rsp
144b     144b:	cc                   	int3
144c     144c:	ff e4                	jmp    *%rsp
144e     144e:	0f ae e8             	lfence
1451     1451:	ff e5                	jmp    *%rbp
1453     1453:	cc                   	int3
1454     1454:	ff e5                	jmp    *%rbp
1456     1456:	0f ae e8             	lfence
1459     1459:	ff e6                	jmp    *%rsi
145b     145b:	cc                   	int3
145c     145c:	ff e6                	jmp    *%rsi
145e     145e:	0f ae e8             	lfence
1461     1461:	ff e7                	jmp    *%rdi
1463     1463:	cc                   	int3
1464     1464:	ff e7                	jmp    *%rdi
1466     1466:	0f ae e8             	lfence
1469     1469:	41 ff e0             	jmp    *%r8
146c     146c:	cc                   	int3
146d     146d:	41 ff e0             	jmp    *%r8
1470     1470:	0f ae e8             	lfence
1473     1473:	41 ff e1             	jmp    *%r9
1476     1476:	cc                   	int3
1477     1477:	41 ff e1             	jmp    *%r9
147a     147a:	0f ae e8             	lfence
147d     147d:	41 ff e2             	jmp    *%r10
1480     1480:	cc                   	int3
1481     1481:	41 ff e2             	jmp    *%r10
1484     1484:	0f ae e8             	lfence
1487     1487:	41 ff e3             	jmp    *%r11
148a     148a:	cc                   	int3
148b     148b:	41 ff e3             	jmp    *%r11
148e     148e:	0f ae e8             	lfence
1491     1491:	41 ff e4             	jmp    *%r12
1494     1494:	cc                   	int3
1495     1495:	41 ff e4             	jmp    *%r12
1498     1498:	0f ae e8             	lfence
149b     149b:	41 ff e5             	jmp    *%r13
149e     149e:	cc                   	int3
149f     149f:	41 ff e5             	jmp    *%r13
14a2     14a2:	0f ae e8             	lfence
14a5     14a5:	41 ff e6             	jmp    *%r14
14a8     14a8:	cc                   	int3
14a9     14a9:	41 ff e6             	jmp    *%r14
14ac     14ac:	0f ae e8             	lfence
14af     14af:	41 ff e7             	jmp    *%r15
14b2     14b2:	cc                   	int3
14b3     14b3:	41 ff e7             	jmp    *%r15
14b6     14b6:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14bf <.altinstr_replacement+0x14bf>	14ba: R_X86_64_PC32	pcpu_hot+0xb
14bf     14bf:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14c8 <.altinstr_replacement+0x14c8>	14c3: R_X86_64_PC32	pcpu_hot+0xb
14c8     14c8:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14d1 <.altinstr_replacement+0x14d1>	14cc: R_X86_64_PC32	pcpu_hot+0xb
14d1     14d1:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14da <.altinstr_replacement+0x14da>	14d5: R_X86_64_PC32	pcpu_hot+0xb
14da     14da:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14e3 <.altinstr_replacement+0x14e3>	14de: R_X86_64_PC32	pcpu_hot+0xb
14e3     14e3:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14ec <.altinstr_replacement+0x14ec>	14e7: R_X86_64_PC32	pcpu_hot+0xb
14ec     14ec:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14f5 <.altinstr_replacement+0x14f5>	14f0: R_X86_64_PC32	pcpu_hot+0xb
14f5     14f5:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 14fe <.altinstr_replacement+0x14fe>	14f9: R_X86_64_PC32	pcpu_hot+0xb
14fe     14fe:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 1507 <.altinstr_replacement+0x1507>	1502: R_X86_64_PC32	pcpu_hot+0xb
1507     1507:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 1510 <.altinstr_replacement+0x1510>	150b: R_X86_64_PC32	pcpu_hot+0xb
1510     1510:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 1519 <.altinstr_replacement+0x1519>	1514: R_X86_64_PC32	pcpu_hot+0xb
1519     1519:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 1522 <.altinstr_replacement+0x1522>	151d: R_X86_64_PC32	pcpu_hot+0xb
1522     1522:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 152b <.altinstr_replacement+0x152b>	1526: R_X86_64_PC32	pcpu_hot+0xb
152b     152b:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 1534 <.altinstr_replacement+0x1534>	152f: R_X86_64_PC32	pcpu_hot+0xb
1534     1534:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 153d <.altinstr_replacement+0x153d>	1538: R_X86_64_PC32	pcpu_hot+0xb
153d     153d:	65 48 c1 3d 00 00 00 00 05 	sarq   $0x5,%gs:0x0(%rip)        # 1546 <.altinstr_replacement+0x1546>	1541: R_X86_64_PC32	pcpu_hot+0xb
1546     1546:	e9 00 00 00 00       	jmp    154b <.altinstr_replacement+0x154b>	1547: R_X86_64_PC32	.text..__x86.return_thunk+0x3a
154b     154b:	e9 00 00 00 00       	jmp    1550 <.altinstr_replacement+0x1550>	154c: R_X86_64_PLT32	warn_thunk_thunk-0x4
1550     1550:	0f 01 cb             	stac
1553     1553:	e8 00 00 00 00       	call   1558 <.altinstr_replacement+0x1558>	1554: R_X86_64_PLT32	rep_movs_alternative-0x4
1558     1558:	0f 01 ca             	clac
155b     155b:	66 0f ae 38          	clflushopt (%rax)
155f     155f:	66 0f ae 30          	clwb   (%rax)
1563     1563:	0f 01 cb             	stac
1566     1566:	0f 01 ca             	clac

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

