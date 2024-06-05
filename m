Return-Path: <linux-kernel+bounces-202211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CC8FC936
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86132828D9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38770191474;
	Wed,  5 Jun 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8NSWNTv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545A18FDB6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583946; cv=none; b=jNO1QdnvOxiCHMa4ub0H//LcN0S8QTdutmbG7mmMS9R8E/Uf0DkUeOE5ho432ZfYZNuiLMQl6Evl9oRPGKbrIfTSVtWTN8PRzmi/D4mkYyRoevbF/rfTxQvMEQEo6aTwPOtL448fnObu9ARCYlsFObT7krOZACVZeAga/TRDPco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583946; c=relaxed/simple;
	bh=VvM20Va9f/3Jcznbtr8vEeRKrsyYzLAxUsUx+p7REsY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=huf5e4SUAsvp5k13veIWCN8XBZI/OgftsWusGyQxwLrP7Y8UUGR5DmyjoyxSOFDWGjbC67AMY+TkMLIEXT/q4CvN2Joc0fHakvmx5ZRVRL8CJA4+lIIJhXBqkHb3f5fbXfVZ1x7XUPO216YkDn3uxdsEZ5mwYwMRu4yO8RZar20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8NSWNTv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717583944; x=1749119944;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VvM20Va9f/3Jcznbtr8vEeRKrsyYzLAxUsUx+p7REsY=;
  b=I8NSWNTvyXA0qmbWSQdIb86+CkAaOlhtcnH+pA5ro5tRAnVRZvXY1aDn
   EKaqE40b0vT4DcDuqtoeQsaHkmmuZCBvaWZ2RtmKnzHkUyfY2kWvmumRM
   voXEhFVq4jKaTJthtdFXQMscp7a3z86Iw32E7yEzxqrMkKlr8hU8dbNQk
   BcGYs62oyvjtZdHUqgEJpY7HKQfJj7r2njKnB9bYlZEb6z4SmDZ9VNsVq
   0tQCi4f6jVZ6ksaJUDqcIEng4UZx9586ktgYRqKUCty1MdAleDB1+z+mh
   RIJTX0tOFa3KDPVKJ1kuZgbBPzMumQcyWn5imw8S3VjgfV5ia4Ub9wBxf
   w==;
X-CSE-ConnectionGUID: 7FaIpLRxR+anyBUonp/5JQ==
X-CSE-MsgGUID: GhAtwsEdRlOYIsKWJtIwzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="24840428"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="24840428"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:39:04 -0700
X-CSE-ConnectionGUID: JJaiTeXxQ9SEnWvBzwC/LQ==
X-CSE-MsgGUID: CA+rae0mQEOhWOWuPPxCLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="38188285"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 05 Jun 2024 03:39:00 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEo2H-0001OD-30;
	Wed, 05 Jun 2024 10:38:35 +0000
Date: Wed, 5 Jun 2024 18:37:09 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miroslav Benes <mbenes@suse.cz>
Subject: vmlinux.o: warning: objtool: do_write_buffer.cold+0x0: unreachable
 instruction
Message-ID: <202406051817.YrjweBSk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   32f88d65f01bf6f45476d7edbe675e44fb9e1d58
commit: 5e3992fe72748ed3892be876f09d4d990548b7af objtool: Limit unreachable warnings to once per function
date:   1 year, 1 month ago
config: x86_64-randconfig-c024-20220425 (https://download.01.org/0day-ci/archive/20240605/202406051817.YrjweBSk-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051817.YrjweBSk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051817.YrjweBSk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   vmlinux.o: warning: objtool: cfi_chip_setup+0x178: unreachable instruction
   vmlinux.o: warning: objtool: cfi_probe_chip+0x72: unreachable instruction
   vmlinux.o: warning: objtool: cfi_staa_resume+0x154: unreachable instruction
   vmlinux.o: warning: objtool: do_write_buffer+0x1bf: unreachable instruction
   vmlinux.o: warning: objtool: do_unlock_oneblock+0x136: unreachable instruction
   vmlinux.o: warning: objtool: do_lock_oneblock+0x136: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock+0x108: unreachable instruction
   vmlinux.o: warning: objtool: do_read_onechip+0x10a: unreachable instruction
   vmlinux.o: warning: objtool: fixup_sst39vf_rev_b+0x12c: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_resume+0x183: unreachable instruction
   vmlinux.o: warning: objtool: cfi_check_err_status+0x16b: unreachable instruction
   vmlinux.o: warning: objtool: chip_ready+0x154: unreachable instruction
   vmlinux.o: warning: objtool: do_panic_write_oneword+0x114: unreachable instruction
   vmlinux.o: warning: objtool: do_write_oneword_once+0x115: unreachable instruction
   vmlinux.o: warning: objtool: fixup_sst38vf640x_sectorsize+0x13d: unreachable instruction
   vmlinux.o: warning: objtool: put_chip.isra.0+0x35e: unreachable instruction
   vmlinux.o: warning: objtool: get_chip+0x4f4: unreachable instruction
   vmlinux.o: warning: objtool: do_write_oneword+0x2de: unreachable instruction
   vmlinux.o: warning: objtool: do_atmel_unlock+0x16e: unreachable instruction
   vmlinux.o: warning: objtool: do_atmel_lock+0x17a: unreachable instruction
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x16d: unreachable instruction
   vmlinux.o: warning: objtool: do_otp_lock+0x1a1: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_chip+0x355: unreachable instruction
   vmlinux.o: warning: objtool: do_write_buffer+0x19e: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock+0x356: unreachable instruction
   vmlinux.o: warning: objtool: do_ppb_xxlock+0x166: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_read+0x15b: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_otp_walk+0x24c: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_reset.isra.0+0x178: unreachable instruction
   vmlinux.o: warning: objtool: cfi_amdstd_secsi_read+0x3b1: unreachable instruction
   vmlinux.o: warning: objtool: do_otp_write+0x14b: unreachable instruction
   vmlinux.o: warning: objtool: do_read_secsi_onechip+0x288: unreachable instruction
   vmlinux.o: warning: objtool: fixup_LH28F640BF+0x110: unreachable instruction
   vmlinux.o: warning: objtool: do_getlockstatus_oneblock+0xc7: unreachable instruction
   vmlinux.o: warning: objtool: inval_cache_and_wait_for_operation+0xad: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_resume+0x1b7: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_suspend+0x247: unreachable instruction
   vmlinux.o: warning: objtool: put_chip.isra.0+0x1e1: unreachable instruction
   vmlinux.o: warning: objtool: chip_ready+0xde: unreachable instruction
   vmlinux.o: warning: objtool: do_write_oneword+0xbf: unreachable instruction
   vmlinux.o: warning: objtool: do_otp_lock+0x64: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock+0xee: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_reset.isra.0+0x178: unreachable instruction
   vmlinux.o: warning: objtool: do_write_buffer+0x1b2: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_point+0x3ce: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_read+0x28d: unreachable instruction
   vmlinux.o: warning: objtool: fwh_xxlock_oneblock+0x174: unreachable instruction
   vmlinux.o: warning: objtool: do_xxlock_oneblock+0x104: unreachable instruction
   vmlinux.o: warning: objtool: do_otp_read+0x23f: unreachable instruction
   vmlinux.o: warning: objtool: cfi_intelext_otp_walk+0x747: unreachable instruction
   vmlinux.o: warning: objtool: jedec_reset+0x95: unreachable instruction
   vmlinux.o: warning: objtool: cfi_jedec_setup+0x3b2: unreachable instruction
   vmlinux.o: warning: objtool: jedec_probe_chip+0x2ec: unreachable instruction
   vmlinux.o: warning: objtool: cfi_probe_chip.cold+0x0: unreachable instruction
   vmlinux.o: warning: objtool: do_erase_oneblock.cold+0x0: unreachable instruction
>> vmlinux.o: warning: objtool: do_write_buffer.cold+0x0: unreachable instruction
   vmlinux.o: warning: objtool: jedec_probe_chip.cold+0x0: unreachable instruction


objdump-func vmlinux.o do_write_buffer.cold:
0000 0000000000032b1d <do_write_buffer.cold>:
0000    32b1d:	0f b7 d1             	movzwl %cx,%edx
0003    32b20:	be 02 00 00 00       	mov    $0x2,%esi
0008    32b25:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	32b28: R_X86_64_32S	.data+0xaa9920
000f    32b2c:	89 4c 24 08          	mov    %ecx,0x8(%rsp)
0013    32b30:	e8 00 00 00 00       	call   32b35 <do_write_buffer.cold+0x18>	32b31: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0018    32b35:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
001c    32b39:	e9 00 00 00 00       	jmp    32b3e <cfi_staa_write_buffers.cold>	32b3a: R_X86_64_PC32	.text+0x14539bc
0000 0000000000033a94 <do_write_buffer.cold>:
0000    33a94:	be ff 00 00 00       	mov    $0xff,%esi
0005    33a99:	48 89 84 24 90 00 00 00 	mov    %rax,0x90(%rsp)
000d    33aa1:	48 63 c1             	movslq %ecx,%rax
0010    33aa4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	33aa7: R_X86_64_32S	.data+0xaad1a0
0017    33aab:	48 89 c2             	mov    %rax,%rdx
001a    33aae:	4c 89 9c 24 98 00 00 00 	mov    %r11,0x98(%rsp)
0022    33ab6:	4c 89 94 24 88 00 00 00 	mov    %r10,0x88(%rsp)
002a    33abe:	4c 89 8c 24 80 00 00 00 	mov    %r9,0x80(%rsp)
0032    33ac6:	89 4c 24 78          	mov    %ecx,0x78(%rsp)
0036    33aca:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
003b    33acf:	e8 00 00 00 00       	call   33ad4 <do_write_buffer.cold+0x40>	33ad0: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0040    33ad4:	8b 4c 24 78          	mov    0x78(%rsp),%ecx
0044    33ad8:	4c 8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%r9
004c    33ae0:	49 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r8
0056    33aea:	4c 8b 94 24 88 00 00 00 	mov    0x88(%rsp),%r10
005e    33af2:	48 8b 84 24 90 00 00 00 	mov    0x90(%rsp),%rax
0066    33afa:	83 f9 3f             	cmp    $0x3f,%ecx
0069    33afd:	4c 8b 9c 24 98 00 00 00 	mov    0x98(%rsp),%r11
0071    33b05:	0f 86 00 00 00 00    	jbe    33b0b <do_write_buffer.cold+0x77>	33b07: R_X86_64_PC32	.text+0x146fd05
0077    33b0b:	48 89 de             	mov    %rbx,%rsi
007a    33b0e:	48 c1 ee 03          	shr    $0x3,%rsi
007e    33b12:	42 0f b6 14 06       	movzbl (%rsi,%r8,1),%edx
0083    33b17:	48 89 de             	mov    %rbx,%rsi
0086    33b1a:	83 e6 07             	and    $0x7,%esi
0089    33b1d:	40 38 f2             	cmp    %sil,%dl
008c    33b20:	7f 08                	jg     33b2a <do_write_buffer.cold+0x96>
008e    33b22:	84 d2                	test   %dl,%dl
0090    33b24:	0f 85 b1 00 00 00    	jne    33bdb <do_write_buffer.cold+0x147>
0096    33b2a:	0f b6 33             	movzbl (%rbx),%esi
0099    33b2d:	48 8b 54 24 70       	mov    0x70(%rsp),%rdx
009e    33b32:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	33b35: R_X86_64_32S	.data+0xaad160
00a5    33b39:	4c 89 9c 24 98 00 00 00 	mov    %r11,0x98(%rsp)
00ad    33b41:	89 8c 24 90 00 00 00 	mov    %ecx,0x90(%rsp)
00b4    33b48:	48 89 84 24 88 00 00 00 	mov    %rax,0x88(%rsp)
00bc    33b50:	4c 89 94 24 80 00 00 00 	mov    %r10,0x80(%rsp)
00c4    33b58:	4c 89 4c 24 78       	mov    %r9,0x78(%rsp)
00c9    33b5d:	e8 00 00 00 00       	call   33b62 <do_write_buffer.cold+0xce>	33b5e: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
00ce    33b62:	4c 8b 4c 24 78       	mov    0x78(%rsp),%r9
00d3    33b67:	4c 8b 94 24 80 00 00 00 	mov    0x80(%rsp),%r10
00db    33b6f:	49 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%r8
00e5    33b79:	48 8b 84 24 88 00 00 00 	mov    0x88(%rsp),%rax
00ed    33b81:	8b 8c 24 90 00 00 00 	mov    0x90(%rsp),%ecx
00f4    33b88:	4c 8b 9c 24 98 00 00 00 	mov    0x98(%rsp),%r11
00fc    33b90:	e9 00 00 00 00       	jmp    33b95 <do_write_buffer.cold+0x101>	33b91: R_X86_64_PC32	.text+0x146fd05
0101    33b95:	0f b7 d1             	movzwl %cx,%edx
0104    33b98:	be 02 00 00 00       	mov    $0x2,%esi
0109    33b9d:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	33ba0: R_X86_64_32S	.data+0xaac840
0110    33ba4:	89 0c 24             	mov    %ecx,(%rsp)
0113    33ba7:	e8 00 00 00 00       	call   33bac <do_write_buffer.cold+0x118>	33ba8: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0118    33bac:	4c 89 f2             	mov    %r14,%rdx
011b    33baf:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
0120    33bb4:	8b 0c 24             	mov    (%rsp),%ecx
0123    33bb7:	48 c1 ea 03          	shr    $0x3,%rdx
0127    33bbb:	48 c1 e0 2a          	shl    $0x2a,%rax
012b    33bbf:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
012f    33bc3:	75 09                	jne    33bce <do_write_buffer.cold+0x13a>
0131    33bc5:	49 8b 5f 30          	mov    0x30(%r15),%rbx
0135    33bc9:	e9 00 00 00 00       	jmp    33bce <do_write_buffer.cold+0x13a>	33bca: R_X86_64_PC32	.text+0x146f8f1
013a    33bce:	4c 89 f7             	mov    %r14,%rdi
013d    33bd1:	e8 00 00 00 00       	call   33bd6 <do_write_buffer.cold+0x142>	33bd2: R_X86_64_PLT32	__asan_report_load8_noabort-0x4
0142    33bd6:	8b 0c 24             	mov    (%rsp),%ecx
0145    33bd9:	eb ea                	jmp    33bc5 <do_write_buffer.cold+0x131>
0147    33bdb:	48 89 df             	mov    %rbx,%rdi
014a    33bde:	89 8c 24 90 00 00 00 	mov    %ecx,0x90(%rsp)
0151    33be5:	48 89 84 24 88 00 00 00 	mov    %rax,0x88(%rsp)
0159    33bed:	4c 89 94 24 80 00 00 00 	mov    %r10,0x80(%rsp)
0161    33bf5:	4c 89 4c 24 78       	mov    %r9,0x78(%rsp)
0166    33bfa:	e8 00 00 00 00       	call   33bff <do_write_buffer.cold+0x16b>	33bfb: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
016b    33bff:	4c 8b 9c 24 98 00 00 00 	mov    0x98(%rsp),%r11
0173    33c07:	8b 8c 24 90 00 00 00 	mov    0x90(%rsp),%ecx
017a    33c0e:	48 8b 84 24 88 00 00 00 	mov    0x88(%rsp),%rax
0182    33c16:	4c 8b 94 24 80 00 00 00 	mov    0x80(%rsp),%r10
018a    33c1e:	4c 8b 4c 24 78       	mov    0x78(%rsp),%r9
018f    33c23:	e9 02 ff ff ff       	jmp    33b2a <do_write_buffer.cold+0x96>
0000 0000000000034872 <do_write_buffer.cold>:
0000    34872:	0f b7 d1             	movzwl %cx,%edx
0003    34875:	be 01 00 00 00       	mov    $0x1,%esi
0008    3487a:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	3487d: R_X86_64_32S	.data+0xab3040
000f    34881:	44 89 4c 24 08       	mov    %r9d,0x8(%rsp)
0014    34886:	89 0c 24             	mov    %ecx,(%rsp)
0017    34889:	e8 00 00 00 00       	call   3488e <do_write_buffer.cold+0x1c>	3488a: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
001c    3488e:	8b 0c 24             	mov    (%rsp),%ecx
001f    34891:	44 8b 4c 24 08       	mov    0x8(%rsp),%r9d
0024    34896:	e9 00 00 00 00       	jmp    3489b <do_write_buffer.cold+0x29>	34897: R_X86_64_PC32	.text+0x147d7b2
0029    3489b:	48 63 c1             	movslq %ecx,%rax
002c    3489e:	be ff 00 00 00       	mov    $0xff,%esi
0031    348a3:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	348a6: R_X86_64_32S	.data+0xab31c0
0038    348aa:	4c 89 9c 24 90 00 00 00 	mov    %r11,0x90(%rsp)
0040    348b2:	48 89 c2             	mov    %rax,%rdx
0043    348b5:	44 89 8c 24 88 00 00 00 	mov    %r9d,0x88(%rsp)
004b    348bd:	4c 89 94 24 80 00 00 00 	mov    %r10,0x80(%rsp)
0053    348c5:	4c 89 44 24 78       	mov    %r8,0x78(%rsp)
0058    348ca:	89 4c 24 70          	mov    %ecx,0x70(%rsp)
005c    348ce:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
0061    348d3:	e8 00 00 00 00       	call   348d8 <do_write_buffer.cold+0x66>	348d4: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0066    348d8:	8b 4c 24 70          	mov    0x70(%rsp),%ecx
006a    348dc:	4c 8b 44 24 78       	mov    0x78(%rsp),%r8
006f    348e1:	48 b8 00 00 00 00 00 fc ff df 	movabs $0xdffffc0000000000,%rax
0079    348eb:	4c 8b 94 24 80 00 00 00 	mov    0x80(%rsp),%r10
0081    348f3:	44 8b 8c 24 88 00 00 00 	mov    0x88(%rsp),%r9d
0089    348fb:	83 f9 3f             	cmp    $0x3f,%ecx
008c    348fe:	4c 8b 9c 24 90 00 00 00 	mov    0x90(%rsp),%r11
0094    34906:	0f 86 00 00 00 00    	jbe    3490c <do_write_buffer.cold+0x9a>	34908: R_X86_64_PC32	.text+0x147d9ae
009a    3490c:	48 89 de             	mov    %rbx,%rsi
009d    3490f:	48 c1 ee 03          	shr    $0x3,%rsi
00a1    34913:	0f b6 14 06          	movzbl (%rsi,%rax,1),%edx
00a5    34917:	48 89 de             	mov    %rbx,%rsi
00a8    3491a:	83 e6 07             	and    $0x7,%esi
00ab    3491d:	40 38 f2             	cmp    %sil,%dl
00ae    34920:	7f 08                	jg     3492a <do_write_buffer.cold+0xb8>
00b0    34922:	84 d2                	test   %dl,%dl
00b2    34924:	0f 85 83 00 00 00    	jne    349ad <do_write_buffer.cold+0x13b>
00b8    3492a:	0f b6 33             	movzbl (%rbx),%esi
00bb    3492d:	48 8b 54 24 68       	mov    0x68(%rsp),%rdx
00c0    34932:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	34935: R_X86_64_32S	.data+0xab3180
00c7    34939:	4c 89 9c 24 90 00 00 00 	mov    %r11,0x90(%rsp)
00cf    34941:	44 89 8c 24 88 00 00 00 	mov    %r9d,0x88(%rsp)
00d7    34949:	89 8c 24 80 00 00 00 	mov    %ecx,0x80(%rsp)
00de    34950:	4c 89 54 24 78       	mov    %r10,0x78(%rsp)
00e3    34955:	4c 89 44 24 70       	mov    %r8,0x70(%rsp)
00e8    3495a:	e8 00 00 00 00       	call   3495f <do_write_buffer.cold+0xed>	3495b: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
00ed    3495f:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
00f2    34964:	4c 8b 44 24 70       	mov    0x70(%rsp),%r8
00f7    34969:	4c 8b 54 24 78       	mov    0x78(%rsp),%r10
00fc    3496e:	8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%ecx
0103    34975:	44 8b 8c 24 88 00 00 00 	mov    0x88(%rsp),%r9d
010b    3497d:	48 c1 e0 2a          	shl    $0x2a,%rax
010f    34981:	4c 8b 9c 24 90 00 00 00 	mov    0x90(%rsp),%r11
0117    34989:	e9 00 00 00 00       	jmp    3498e <do_write_buffer.cold+0x11c>	3498a: R_X86_64_PC32	.text+0x147d9ae
011c    3498e:	0f b7 d1             	movzwl %cx,%edx
011f    34991:	be 01 00 00 00       	mov    $0x1,%esi
0124    34996:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi	34999: R_X86_64_32S	.data+0xab3000
012b    3499d:	89 0c 24             	mov    %ecx,(%rsp)
012e    349a0:	e8 00 00 00 00       	call   349a5 <do_write_buffer.cold+0x133>	349a1: R_X86_64_PLT32	__ubsan_handle_shift_out_of_bounds-0x4
0133    349a5:	8b 0c 24             	mov    (%rsp),%ecx
0136    349a8:	e9 00 00 00 00       	jmp    349ad <do_write_buffer.cold+0x13b>	349a9: R_X86_64_PC32	.text+0x147dcba
013b    349ad:	48 89 df             	mov    %rbx,%rdi
013e    349b0:	89 8c 24 80 00 00 00 	mov    %ecx,0x80(%rsp)
0145    349b7:	4c 89 54 24 78       	mov    %r10,0x78(%rsp)
014a    349bc:	4c 89 44 24 70       	mov    %r8,0x70(%rsp)
014f    349c1:	e8 00 00 00 00       	call   349c6 <do_write_buffer.cold+0x154>	349c2: R_X86_64_PLT32	__asan_report_load1_noabort-0x4
0154    349c6:	4c 8b 54 24 78       	mov    0x78(%rsp),%r10
0159    349cb:	4c 8b 44 24 70       	mov    0x70(%rsp),%r8
015e    349d0:	4c 8b 9c 24 90 00 00 00 	mov    0x90(%rsp),%r11
0166    349d8:	44 8b 8c 24 88 00 00 00 	mov    0x88(%rsp),%r9d
016e    349e0:	8b 8c 24 80 00 00 00 	mov    0x80(%rsp),%ecx
0175    349e7:	e9 3e ff ff ff       	jmp    3492a <do_write_buffer.cold+0xb8>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

