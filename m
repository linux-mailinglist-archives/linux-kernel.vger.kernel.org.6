Return-Path: <linux-kernel+bounces-551077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52259A567D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575BA174C15
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EF3218EA1;
	Fri,  7 Mar 2025 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwYZmmO4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F3920E001
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741350669; cv=none; b=TVVKj2ZUy4Gli5qEP2BQkaUZHC+Y5pgG+VOtOFmydqPaYsWSXIahBLH9RDH219dj3nIxsqtTTxICRb4ohgjFagZ/vHFBPbfV1KfQTbJiVnJ8UvDlXyA7p1RP9gs+sUWgrjmQhixDJwh2hj1g7RtLKe2Tnh4JD8AtVJVgplt7LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741350669; c=relaxed/simple;
	bh=/DfnoP9BOvlv/etn/gwHlgqlvTGYVq3fn72OEE7vBAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G12J7zpIzjrdR3dTcg1tnGqiW6rIxrMgmFC6bnZiJXEVoCJiFq4j5rwI/qhDvma+Ayo5ujFuN0ntfrwuULfDCDoN28WPcok6cAIWNC8GnQb4LH0ToNOga+ySQ4gksoHQE9s/XVcNx9DSa/zLsIHTEeuhAWJIFFH4hgsaiQV2F+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwYZmmO4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741350668; x=1772886668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/DfnoP9BOvlv/etn/gwHlgqlvTGYVq3fn72OEE7vBAU=;
  b=ZwYZmmO4MWQ1XsSD5po6mHszAIxvUl+yoHXAMFvOH18UxYFTR6Y8a4fq
   B4qy6EWj5vMzcEkv/nCw/To6/5VPCY8iz9XGMVjGOqFD7zrPKm9hC5T8n
   Ry2aHTZ3qA4yojDpAKvIbU0bnoWXdrL3Pa4rdb+6Hw2R19GiJWhRsjWu9
   CWSq52RexHL6nF3MRGOnuZ4Mwa73JkDs2i7DbdrHN4sNu0awiNDqkfkV3
   zmI5FdyStYt814HhFUEKRUCGX7RtrnKRj5H8f0fIHi3Cmw355DjR51FKL
   1MdJW5AZb+HpGRR9NIVpdksNH28AK9paUw0tqZyyKw+OQ1x249sjKzs1+
   w==;
X-CSE-ConnectionGUID: OKYbDQxORaWsamddhyko6A==
X-CSE-MsgGUID: Zhy/R95mRHuE7vXoHDSFbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42274953"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42274953"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:31:06 -0800
X-CSE-ConnectionGUID: vJceECq4Ry6BOajat4kKzw==
X-CSE-MsgGUID: 0DmmofkrTwKfbm7uHBe8Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124230491"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 07 Mar 2025 04:31:04 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqWqz-0000Sn-38;
	Fri, 07 Mar 2025 12:31:01 +0000
Date: Fri, 7 Mar 2025 20:30:53 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: don't use asm/ UAPI headers
Message-ID: <202503072041.LhDGl9Vn-lkp@intel.com>
References: <20250305-nolibc-asm-headers-v1-1-f2053def2ee7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-nolibc-asm-headers-v1-1-f2053def2ee7@linutronix.de>

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cb839e0cc881b4abd4a2e64cd06c2e313987a189]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Wei-schuh/tools-nolibc-don-t-use-asm-UAPI-headers/20250305-155035
base:   cb839e0cc881b4abd4a2e64cd06c2e313987a189
patch link:    https://lore.kernel.org/r/20250305-nolibc-asm-headers-v1-1-f2053def2ee7%40linutronix.de
patch subject: [PATCH] tools/nolibc: don't use asm/ UAPI headers
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072041.LhDGl9Vn-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> tools/include/nolibc/sys.h: linux/signal.h is included more than once.

vim +14 tools/include/nolibc/sys.h

    11	
    12	/* system includes */
    13	#include <linux/unistd.h>
  > 14	#include <linux/signal.h>  /* for SIGCHLD */
    15	#include <linux/termios.h>
    16	#include <linux/mman.h>
    17	#include <linux/fs.h>
    18	#include <linux/loop.h>
    19	#include <linux/time.h>
    20	#include <linux/auxvec.h>
    21	#include <linux/fcntl.h> /* for O_* and AT_* */
    22	#include <linux/stat.h>  /* for statx() */
    23	#include <linux/prctl.h>
    24	#include <linux/resource.h>
    25	#include <linux/utsname.h>
  > 26	#include <linux/signal.h>
    27	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

