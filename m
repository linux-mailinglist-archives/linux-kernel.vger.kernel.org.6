Return-Path: <linux-kernel+bounces-373882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580269A5E67
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E0EB22251
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09141E0DEE;
	Mon, 21 Oct 2024 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIAsGnCN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EF1DDC1E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498615; cv=none; b=UwpYidLzdLKW5qBIYsZmkBj+x2N4jyf6Tgt5FP/AiftTLKtyvjHLThlg+9mXUs4RcaBxZfpV8VgrJsHKu6dgqF94Pd8QJqIA6bv0T2pr7i0x8Vpzc3Ay0DkzLPhB8iHLyfxbsm7ns4RowHp2XUgeUYvWrVX2MTdoDgexWBzTUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498615; c=relaxed/simple;
	bh=zG8389AzEcTqHbq/aHLbTOlVn9gUHn2FDnw8cKkmpCM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kJD4gv7VH/xzLOghSfrZAdbUoCv+TI/ZLtsX8LvGXLw3qsqzEjJgpLknQvt4TPLyjeQllftH6Zf0nNtRJzrzQRWfqXkIxETC+mWj8VfXIQuJj5Ox8q1eoHX+5cKcBfmBau42IxjL7xzPb/eNIqFC1I5ULDueEzELPdPO89WmZ1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIAsGnCN; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729498613; x=1761034613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zG8389AzEcTqHbq/aHLbTOlVn9gUHn2FDnw8cKkmpCM=;
  b=lIAsGnCNspk168n7JLjIE65YFUjclOlcCfCjhTes/sqyd/Mb1aAbPAWx
   4QplCQ2eNAZt51mE6SUtovGyGoJqhqNCYbY3w2g7V9sa9spW9dAniVyVs
   hcQtHdf5HyFmbIEWmxLg14WBeAFXOunWfW4NR1n1sGZzpWNYNocEyRUmg
   2NWk0CkTPCB+kzuSnvvSWKvv6dUPpJib3PrnR3EbawjaOGDKkc4pZkw5R
   TYskFtOvGWnehwseQuc/6eTzIqSdjWE25g+q0w3izWAxcysyY7pR2CkSu
   Hz3vT8SE4O/LKFuv9elSNJY/kYIl7Qm0Pu90Bd/77p7NF+++RWZ8d199O
   A==;
X-CSE-ConnectionGUID: 6kBZrZZET0OvSzG5YeGpCA==
X-CSE-MsgGUID: Iul4aYLrSs2liLPLfEkI7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="28847512"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="28847512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:16:53 -0700
X-CSE-ConnectionGUID: H9O/iqP6Qvy1tSU49oEzRg==
X-CSE-MsgGUID: vf1Da8lrSkKq8wMHAA8HVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="102772650"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Oct 2024 01:16:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2nar-000RMa-03;
	Mon, 21 Oct 2024 08:16:49 +0000
Date: Mon, 21 Oct 2024 16:16:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jordan Niethe <jniethe5@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse: sparse:
 restricted __be64 degrades to integer
Message-ID: <202410211611.R5rf8B37-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42f7652d3eb527d03665b09edac47f85fb600924
commit: 6ccbbc33f06adaf79acde18571c6543ad1cb4be6 KVM: PPC: Add helper library for Guest State Buffers
date:   1 year, 1 month ago
config: powerpc64-randconfig-r131-20241021 (https://download.01.org/0day-ci/archive/20241021/202410211611.R5rf8B37-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce: (https://download.01.org/0day-ci/archive/20241021/202410211611.R5rf8B37-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410211611.R5rf8B37-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse: sparse: restricted __be64 degrades to integer
>> arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse: sparse: incorrect type in initializer (different base types) @@     expected long long left_value @@     got restricted __be64 const __left @@
   arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse:     expected long long left_value
   arch/powerpc/kvm/test-guest-state-buffer.c:70:25: sparse:     got restricted __be64 const __left
   arch/powerpc/kvm/test-guest-state-buffer.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/umh.h, include/linux/kmod.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +70 arch/powerpc/kvm/test-guest-state-buffer.c

    24	
    25	static void test_adding_element(struct kunit *test)
    26	{
    27		const struct kvmppc_gs_elem *head, *curr;
    28		union {
    29			__vector128 v;
    30			u64 dw[2];
    31		} u;
    32		int rem;
    33		struct kvmppc_gs_buff *gsb;
    34		size_t size = 0x1000;
    35		int i, rc;
    36		u64 data;
    37	
    38		gsb = kvmppc_gsb_new(size, 0, 0, GFP_KERNEL);
    39		KUNIT_ASSERT_NOT_ERR_OR_NULL(test, gsb);
    40	
    41		/* Single elements, direct use of __kvmppc_gse_put() */
    42		data = 0xdeadbeef;
    43		rc = __kvmppc_gse_put(gsb, KVMPPC_GSID_GPR(0), 8, &data);
    44		KUNIT_EXPECT_GE(test, rc, 0);
    45	
    46		head = kvmppc_gsb_data(gsb);
    47		KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(head), KVMPPC_GSID_GPR(0));
    48		KUNIT_EXPECT_EQ(test, kvmppc_gse_len(head), 8);
    49		data = 0;
    50		memcpy(&data, kvmppc_gse_data(head), 8);
    51		KUNIT_EXPECT_EQ(test, data, 0xdeadbeef);
    52	
    53		/* Multiple elements, simple wrapper */
    54		rc = kvmppc_gse_put_u64(gsb, KVMPPC_GSID_GPR(1), 0xcafef00d);
    55		KUNIT_EXPECT_GE(test, rc, 0);
    56	
    57		u.dw[0] = 0x1;
    58		u.dw[1] = 0x2;
    59		rc = kvmppc_gse_put_vector128(gsb, KVMPPC_GSID_VSRS(0), &u.v);
    60		KUNIT_EXPECT_GE(test, rc, 0);
    61		u.dw[0] = 0x0;
    62		u.dw[1] = 0x0;
    63	
    64		kvmppc_gsb_for_each_elem(i, curr, gsb, rem) {
    65			switch (i) {
    66			case 0:
    67				KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(curr),
    68						KVMPPC_GSID_GPR(0));
    69				KUNIT_EXPECT_EQ(test, kvmppc_gse_len(curr), 8);
  > 70				KUNIT_EXPECT_EQ(test, kvmppc_gse_get_be64(curr),
    71						0xdeadbeef);
    72				break;
    73			case 1:
    74				KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(curr),
    75						KVMPPC_GSID_GPR(1));
    76				KUNIT_EXPECT_EQ(test, kvmppc_gse_len(curr), 8);
    77				KUNIT_EXPECT_EQ(test, kvmppc_gse_get_u64(curr),
    78						0xcafef00d);
    79				break;
    80			case 2:
    81				KUNIT_EXPECT_EQ(test, kvmppc_gse_iden(curr),
    82						KVMPPC_GSID_VSRS(0));
    83				KUNIT_EXPECT_EQ(test, kvmppc_gse_len(curr), 16);
    84				kvmppc_gse_get_vector128(curr, &u.v);
    85				KUNIT_EXPECT_EQ(test, u.dw[0], 0x1);
    86				KUNIT_EXPECT_EQ(test, u.dw[1], 0x2);
    87				break;
    88			}
    89		}
    90		KUNIT_EXPECT_EQ(test, i, 3);
    91	
    92		kvmppc_gsb_reset(gsb);
    93		KUNIT_EXPECT_EQ(test, kvmppc_gsb_nelems(gsb), 0);
    94		KUNIT_EXPECT_EQ(test, kvmppc_gsb_len(gsb),
    95				sizeof(struct kvmppc_gs_header));
    96	
    97		kvmppc_gsb_free(gsb);
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

