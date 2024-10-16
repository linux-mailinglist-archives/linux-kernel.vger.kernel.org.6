Return-Path: <linux-kernel+bounces-368614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B219A124E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391321C249C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26722141A0;
	Wed, 16 Oct 2024 19:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7jc2qbY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA212E75
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105609; cv=none; b=hovXzZzP6OjwbyQdY+OqxmDuOWbBQsQj17IeATNsB7d8SlUXykDK+0BwGY857JOkc3WvRxrHeNUYId4Oe2x7WfIDeDgPhRojOCGhCS27VHxi51nUIBuIPthM1xCQR6DOpooHaKLtOC1Le7NdMwslrbfv4Q01MWUEqB5/inurX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105609; c=relaxed/simple;
	bh=YgmrGEqzK1Ys0pxhLhfCmeIQoc6TgpXEwuLXueDOBB0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FB09ILCm8c5roI1Q39H+5nhctxT7SHOO+ot9SyKJw8y5ZAawwOS7TT/6q6Bbb3eTzvaDgU28K7PgNLiZv/BmSge0kLWljO7JWUuHgWdKwGildo92tianttMj3oyiFbINZ1bJ77Cwzb/yWwcx+MSzuJD6ysqySCX3a9Eddo2HNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7jc2qbY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729105608; x=1760641608;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YgmrGEqzK1Ys0pxhLhfCmeIQoc6TgpXEwuLXueDOBB0=;
  b=T7jc2qbY2fB0bI2NQLdyY4j6YWiw8Hz8YG29GF0iGSgf5tz8hTNNae0r
   YLp73OIbqq/IiuwTkDRyMeWSKCA+sNaC1GslKZnshYi4QR7HBEGW+c5I9
   2Eu6RG4CfwFI2sB4feJMSH2fEaNaH47yApbKu6SQijS7dBzeGh2xYfeJt
   qJz94vA1LpS0Py1oqnFQfO72b9v8/ypQQH+YeSubZ0vQZTfvCzkNnB2Dd
   SG2RMkZ+hcaB/725ZS1U0mGLL6/Dz+CS+/IpBgat+b6zMIUn0V9+/vhsf
   SrtgH1BN0OadWrbHsjiSj0bDKucZLUCeWkDmVbTIF1zR6j6gIYNBrt9ug
   Q==;
X-CSE-ConnectionGUID: hJQrHxSmTpy9IhSb22yC0A==
X-CSE-MsgGUID: NPu1ARbPRi2NdWWD0VecpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28013165"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28013165"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 12:06:41 -0700
X-CSE-ConnectionGUID: WNQWn4/eRFqm6lxsQ96uZQ==
X-CSE-MsgGUID: BpLYZa/NTNWdyAxOJB5cvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="115761987"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Oct 2024 12:06:40 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t19Lx-000LJb-2x;
	Wed, 16 Oct 2024 19:06:37 +0000
Date: Thu, 17 Oct 2024 03:06:29 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: htmldocs: <built-in>:1:10: fatal error:
 './include/linux/compiler-version.h' file not found
Message-ID: <202410170214.gy9lNemy-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
commit: ce6ed1c4c9876c2880f52f18c41ef2a30d070bc5 kbuild: rebuild GCC plugins when the compiler is upgraded
date:   3 years, 7 months ago
reproduce: (https://download.01.org/0day-ci/archive/20241017/202410170214.gy9lNemy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410170214.gy9lNemy-lkp@intel.com/

All errors (new ones prefixed by >>):

>> <built-in>:1:10: fatal error: './include/linux/compiler-version.h' file not found
       1 | #include "./include/linux/compiler-version.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
>> <built-in>:1:10: fatal error: './include/linux/compiler-version.h' file not found
       1 | #include "./include/linux/compiler-version.h"
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.
   make[1]: *** [scripts/Makefile.build:116: scripts/mod/devicetable-offsets.s] Error 1
   make[1]: *** [scripts/Makefile.build:271: scripts/mod/empty.o] Error 1

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

