Return-Path: <linux-kernel+bounces-514278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8748A35500
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A80A16E32A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226613DDAA;
	Fri, 14 Feb 2025 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1S5aCJg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47370825
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501236; cv=none; b=dqaS9kS5RjnhgnTLka2+Uv/Lw6QZTNbJVhSmVaR7QsIP5u2EHaCMZ58kZJx9s8t2jH6jfJKvINIJWee8YgR/mnljp6igKYC0i9ZdGqllO8Y4xPuEY7XDnCasLkuAQLwioRDP2kYMbSvSoaaWOYg4pRQoEkJK0nwjGnzk4qF/Dgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501236; c=relaxed/simple;
	bh=OBDOMbCu/54QoG/82en1R6lfwoODk1RsBgQAU745tNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VS8J+4RktG0NVdwb8kxq24kCCobMGhJ5U+fugA/eFHnE47k2fo3gee0AJBc++5S9lwHsejxogqgb91f1vkCAjczTjAM2QmziKt0lWHdDkntmVUX8mCCaNpjmVlYig9Q3hZiDK1y0AZWvfswgn++dztDM8OPhxwVFLyDf4XickmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1S5aCJg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739501235; x=1771037235;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OBDOMbCu/54QoG/82en1R6lfwoODk1RsBgQAU745tNg=;
  b=C1S5aCJgTem/QSKdIQIHH/Uf7zuHpKQeXTcUOAI3ZycDofblH/TRHI4+
   7cJBrUNj3PwDA0EKJtYrug4MGF2ESnuHms+4A+JT6rzW1EKneLApIn3/v
   TocKDKk4mORMy3WQCmk05NAX8F/mGQ/0ckZsPYbLxDE7THk6Ap6p9wtoc
   Hlt6T9KhDXKm064WgkRxL5SwhYjWiMTX7Loz1Fy0pm5JPp1mO0lQR4+CV
   7KUnhCwzqFg20AhtEDY8rBFTTtpBFeeB2fJ8GUe4piex8Sbl9rQveIDEK
   MCgGyZUL+sQl1UMowfXZbdtOcTVlx6GD/CE2EnQI3wcvGiMBvbbQ3oMc5
   Q==;
X-CSE-ConnectionGUID: IMnDEBTDTKq9AbJED7XEmg==
X-CSE-MsgGUID: VsvPVnExQTKZSIOJaEaEVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40386787"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40386787"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 18:47:15 -0800
X-CSE-ConnectionGUID: rIF8BeCIQQKZqDbCSuTZdg==
X-CSE-MsgGUID: HOpTxSljQwCD9pY4XIjBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113320191"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 13 Feb 2025 18:45:03 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tilhN-0018zJ-0C;
	Fri, 14 Feb 2025 02:45:01 +0000
Date: Fri, 14 Feb 2025 10:44:11 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Chinner <dchinner@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: fs/xfs/xfs_linux.h:280 kmem_to_page() warn: unsigned '_x' is never
 less than zero.
Message-ID: <202502141023.Rdalsdag-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68763b29e0a6441f57f9ee652bbf8e7bc59183e5
commit: afdc115559c57a48ad697219cec1d16962ad9e30 xfs: move kmem_to_page()
date:   1 year ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250214/202502141023.Rdalsdag-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502141023.Rdalsdag-lkp@intel.com/

New smatch warnings:
fs/xfs/xfs_linux.h:280 kmem_to_page() warn: unsigned '_x' is never less than zero.
fs/xfs/xfs_linux.h:280 kmem_to_page() warn: unsigned '_x' is never less than zero.
fs/xfs/xfs_linux.h:280 kmem_to_page() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
fs/xfs/xfs_buf.c:724 xfs_buf_get_map() error: we previously assumed 'bp' could be null (see line 707)
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting

vim +/_x +280 fs/xfs/xfs_linux.h

   271	
   272	/*
   273	 * Helper for IO routines to grab backing pages from allocated kernel memory.
   274	 */
   275	static inline struct page *
   276	kmem_to_page(void *addr)
   277	{
   278		if (is_vmalloc_addr(addr))
   279			return vmalloc_to_page(addr);
 > 280		return virt_to_page(addr);
   281	}
   282	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

