Return-Path: <linux-kernel+bounces-367070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467FE99FE40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9DAB26253
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563FE136672;
	Wed, 16 Oct 2024 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUB0J35f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4F42AA4;
	Wed, 16 Oct 2024 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042029; cv=none; b=Y/scmAyhFT4hgCgV0kfM2gcN+QlRQv1IFtZ3cRSwZ73OhGVLpVFh84j7BD6NmnGx7GUGv2bFdTfDiHJh2qU5WGOKy67xRO47T5BjJQ0mz8PK2tVB9M44eTw1WzMJWfE59W4V0Fs0FTIEQm1YoBmErRqI+fkRVbQ6k6IKER6rigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042029; c=relaxed/simple;
	bh=HJMAzk6TCzSstS6gquuELWdF1vJtpUiAEcwM2yjG5D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk1WnDWhOK5v84iWtylsdMQah3bzXHBh3To2OfReDW9VHTrWVyGcI01nwq0GskYpe0yxqhYC7iGEVuzQ2xU8Sc2/fSqJHbKezTlcGU/v+g+1cHOtBAW26AbrzHLRQl7x5Jj7v8EVyhc2tKr+INnFxRtbV7RZ5es/vA5QJMoDu5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUB0J35f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729042028; x=1760578028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HJMAzk6TCzSstS6gquuELWdF1vJtpUiAEcwM2yjG5D4=;
  b=BUB0J35f/efXv4ABG84A5wEz2oMoo8v+76mTrJB/c5PqPWHmOhqrdf6U
   TBl40cSPhPXpCANMQs4NAB81rWlHPfCWHY0WdlPGwcO1EdvtvwZTY0FLK
   m1qSoQOxr/zWAVwI1/13Rta1mn5jd9oxpS04TxwTkchzCG8/0xf194dNg
   UdlMtpFjdBZwiXfm/htV8+fH8+yZ5B5cdtSvO0lhuMSCc1RWdmT624XTI
   2H2n3/ofcZkp0640HuFh4rxX5vOv79uIVyWYVrnug/OasGLOkGxwObgLK
   66F6XPHE+ULRXPbamMMvElsjSKX1YcNPVk5OB4jsvqDmmy7tZIK7Cfx9Z
   A==;
X-CSE-ConnectionGUID: AYkFe8QeS1+mJKxqJJeCcA==
X-CSE-MsgGUID: DbM7t1o6TK+JijdUTgOj0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32162213"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32162213"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 18:27:07 -0700
X-CSE-ConnectionGUID: BVwuHcGoTxCUU1FcOHQXCg==
X-CSE-MsgGUID: HOxmxGeSQRSaZ/fhM05eCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78084569"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 Oct 2024 18:27:03 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0soX-000K7q-0o;
	Wed, 16 Oct 2024 01:27:01 +0000
Date: Wed, 16 Oct 2024 09:26:18 +0800
From: kernel test robot <lkp@intel.com>
To: Christian dos Santos de Lima <christiansantoslima21@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	~lkcamp/patches@lists.sr.ht
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] rust: transmute: Add implementation for FromBytes
 trait
Message-ID: <202410160946.XR7mVFjR-lkp@intel.com>
References: <20241012070121.110481-1-christiansantoslima21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012070121.110481-1-christiansantoslima21@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on rust/rust-next]
[also build test ERROR on next-20241015]
[cannot apply to linus/master v6.12-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-dos-Santos-de-Lima/rust-transmute-Add-implementation-for-FromBytes-trait/20241012-150333
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20241012070121.110481-1-christiansantoslima21%40gmail.com
patch subject: [PATCH v2] rust: transmute: Add implementation for FromBytes trait
config: um-randconfig-002-20241015 (https://download.01.org/0day-ci/archive/20241016/202410160946.XR7mVFjR-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project bfe84f7085d82d06d61c632a7bad1e692fd159e4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410160946.XR7mVFjR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410160946.XR7mVFjR-lkp@intel.com/

All errors (new ones prefixed by >>):

   |                                                   ^
   In file included from rust/helpers/helpers.c:10:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
   |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
   |                                                   ^
   In file included from rust/helpers/helpers.c:10:
   In file included from rust/helpers/blk.c:3:
   In file included from include/linux/blk-mq.h:5:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   585 |         __raw_writeb(value, PCI_IOBASE + addr);
   |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
   |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
   |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   693 |         readsb(PCI_IOBASE + addr, buffer, count);
   |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   701 |         readsw(PCI_IOBASE + addr, buffer, count);
   |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   709 |         readsl(PCI_IOBASE + addr, buffer, count);
   |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   718 |         writesb(PCI_IOBASE + addr, buffer, count);
   |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   727 |         writesw(PCI_IOBASE + addr, buffer, count);
   |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   736 |         writesl(PCI_IOBASE + addr, buffer, count);
   |                 ~~~~~~~~~~ ^
   13 warnings generated.
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
   clang diag: include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   clang diag: include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>> error[E0432]: unresolved import `crate::transmute::AsBytes`
   --> rust/kernel/uaccess.rs:12:17
   |
   12 |     transmute::{AsBytes, FromBytes},
   |                 ^^^^^^^
   |                 |
   |                 no `AsBytes` in `transmute`
   |                 help: a similar name exists in the module: `ToBytes`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

