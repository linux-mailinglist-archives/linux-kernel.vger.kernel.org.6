Return-Path: <linux-kernel+bounces-422972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6654E9DA0AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 03:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F106B281E79
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2B3FB9C;
	Wed, 27 Nov 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRioCE/r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D01BC3F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732675105; cv=none; b=gRb+ZCJK0CWheWDvgOpGh8dSFTIPVFbzt/mxaBeA5thF6qv5To5BAs3+PRhpFk+d9hT4HdDMJu5qQLRhmDa4SVsNrepTMsPocETjy4jMbL0fCJ4GhYxxv4sD7kwl3TZQujViz8HdkxPqIvIF44wcCBOlVGjwLsC9GnXyhbcajiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732675105; c=relaxed/simple;
	bh=YK83F2+u9ZrupkvFrEEQdPxsZgYtoYaXi3uAGJ4lCc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nkmJ0co2WR7iIUoU8v380vH6wSdEuwDra4nDsx2O1dptTciG0NjqkWbqQDGUzVBQAVSFdZqQoLteDE1QHRAY6t5WKNv5TiGDMqiA86POzDhlL24y6BA4q7cJdMt317zgYNZGnnKucvKBCfj8J4Co7gQrluPFtTMsUkdS2OvDZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRioCE/r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732675104; x=1764211104;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YK83F2+u9ZrupkvFrEEQdPxsZgYtoYaXi3uAGJ4lCc0=;
  b=dRioCE/rACK2zMo5JyjxxJ+LYxCAG5c/aA6nsJ39GRsz3NuUe4ylc4nA
   HXTqW7+XemlxSHb9il06Ng7UINyiLtiara6JiZLFQ15F+Z3ydx5ZmO3uN
   O4kVVwD5Ia0fXgvTphVsJMi3XRG5g5/ni7Glef2ssz6EbRnB9nRPD8dCL
   jv17X3onezC45GuskPAiqS+J5T5zwsyjvzrO26qPrjsqH+rKxJDlEITah
   b89ESnSKMWFtkIhl3Olr6GLOvjzotLcjxu/3loXPYsgSQfLgi5dQzdlmW
   ZwsMOjthAqU0IidV5NxQHHtOswbxmCjYQpqw4fakEa0Z8qD32ADpidx0x
   Q==;
X-CSE-ConnectionGUID: 6x72l2dBSZ2f8o44ekfkIg==
X-CSE-MsgGUID: ai9KrjxKRlOjMPe8oBdStg==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="43928038"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="43928038"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 18:38:24 -0800
X-CSE-ConnectionGUID: grAEcnecRbenEfrNeejE7g==
X-CSE-MsgGUID: mhdVxv1gQ2SwpnQS83dnJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="96218937"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Nov 2024 18:38:21 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tG7wZ-0007fg-1I;
	Wed, 27 Nov 2024 02:38:19 +0000
Date: Wed, 27 Nov 2024 10:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
Subject: rust/helpers/jump_label.c:10:5: sparse: sparse: symbol
 'rust_helper_static_key_count' was not declared. Should it be static?
Message-ID: <202411271011.gFsgMWRv-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b50ecc5aca4d18f1f0c4942f5c797bc85edef144
commit: 6e59bcc9c8adec9a5bbedfa95a89946c56c510d9 rust: add static_branch_unlikely for static_key_false
date:   3 weeks ago
config: um-randconfig-r111-20241126 (https://download.01.org/0day-ci/archive/20241127/202411271011.gFsgMWRv-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241127/202411271011.gFsgMWRv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411271011.gFsgMWRv-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
>> rust/helpers/jump_label.c:10:5: sparse: sparse: symbol 'rust_helper_static_key_count' was not declared. Should it be static?
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/mutex.c:11:6: sparse: sparse: symbol 'rust_helper___mutex_init' was not declared. Should it be static?
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/spinlock.c:16:6: sparse: sparse: context imbalance in 'rust_helper_spin_lock' - wrong count at exit
   rust/helpers/spinlock.c:21:6: sparse: sparse: context imbalance in 'rust_helper_spin_unlock' - unexpected unlock

vim +/rust_helper_static_key_count +10 rust/helpers/jump_label.c

     8	
     9	#ifndef CONFIG_JUMP_LABEL
  > 10	int rust_helper_static_key_count(struct static_key *key)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

