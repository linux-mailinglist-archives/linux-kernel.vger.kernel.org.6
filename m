Return-Path: <linux-kernel+bounces-377974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE579AC967
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C81B282018
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084211A7270;
	Wed, 23 Oct 2024 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7SsF34g"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B6130E58
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684132; cv=none; b=Bo7ppCra7LtCqATygEH+PwU/o1ty7KXu2snZR9sqvp1NS7LL3A9y3O08CAvMtT7uFO4fs2kCjC+tpEwKrZW/y9F/xlMx5Sz7M/4WXXtXDPr4rsZafiznjHiScKcDwxEVMOeieFXjpoJlfpS36bgNFsH4FaK3aaF1/381fBVMxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684132; c=relaxed/simple;
	bh=M7eKdv95aVVVxR3IvuAXd69pq5auXaZTG4VRnDXqIxU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IopJrCv7BZbMUUuzYYdtjMCv5kjy4KRAXPqHm5N6xj61QNgYk4y7UNY5y0HH6pVMjPR+/kBkHgzYGnl+YJ20diKRnkmdKXANqV+SEsry5U/tB2V74RT9P1RStreSPXOeZxxJYow57ujANUenUTC12FGdezHx5UzMBbMu4EcsACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7SsF34g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729684131; x=1761220131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M7eKdv95aVVVxR3IvuAXd69pq5auXaZTG4VRnDXqIxU=;
  b=D7SsF34gdj6bNr8qaptCACBqvli+0Op1D06pjJ0vHJ/psCooFg8UqJHQ
   HHt20nes5+2Mt7WB7/ixuQ8IkoiHQyiu5jKmksG2mZcpOl73OziVo3xWr
   l/l/VEJgqoBIPBQb1i57GLkpJGXWFjxu3J31sCZhbxkti8HrThJK3uE5T
   oo40a0/ozUY1vbhMOYASBDGfT/LvAoj/aghTDPIOE06xUGXS6JsB9pFOH
   rFBXC9T3QiUqRwTG8ngSbDTck/acJ9/3KMdour4aMJFiDOCLIu+cXhttO
   0VLcTYQMAtWt4fCtNQyDT1STNLMMfzNyFK9vgCx69pazac0QLvTA+AqOd
   Q==;
X-CSE-ConnectionGUID: tKfcxKeOQAqHD61ijgQhLw==
X-CSE-MsgGUID: miWj3m5SSPaJTqQvGMtt+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="54669111"
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="54669111"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 04:48:50 -0700
X-CSE-ConnectionGUID: YDvfa/R8QXyuu+fsgTGXFA==
X-CSE-MsgGUID: FKtA3PCfTSWFHymPZTYKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80358816"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 23 Oct 2024 04:48:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3Zr4-000UrY-1O;
	Wed, 23 Oct 2024 11:48:46 +0000
Date: Wed, 23 Oct 2024 19:48:45 +0800
From: kernel test robot <lkp@intel.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>
Subject: rust/helpers/mutex.c:11:6: sparse: sparse: symbol
 'rust_helper___mutex_init' was not declared. Should it be static?
Message-ID: <202410231939.DXitQG7R-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: d065cc76054d21e48a839a2a19ba99dbc51a4d11 rust: mutex: fix __mutex_init() usage in case of PREEMPT_RT
date:   4 weeks ago
config: um-randconfig-r133-20241023 (https://download.01.org/0day-ci/archive/20241023/202410231939.DXitQG7R-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410231939.DXitQG7R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410231939.DXitQG7R-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
   rust/helpers/helpers.c: note: in included file:
>> rust/helpers/mutex.c:11:6: sparse: sparse: symbol 'rust_helper___mutex_init' was not declared. Should it be static?
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

vim +/rust_helper___mutex_init +11 rust/helpers/mutex.c

    10	
  > 11	void rust_helper___mutex_init(struct mutex *mutex, const char *name,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

