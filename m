Return-Path: <linux-kernel+bounces-187619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FC38CD54F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DEB1C228DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CB14B081;
	Thu, 23 May 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7SzhgsT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF614A62B
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473004; cv=none; b=lByzZM0Xus0fQlXBC3j17k30uwqGh8cX3hVNFISNZAl/6h21nJj6uiAEMS2kUS+NKpFNoToADBsjT9WqPydG5jzmRHH7gTJ4qnzZYce0JgGGk1HINCJqaPInRq/H74+o/ESKaM/agVrjLUmiYUQ7EyJlWd8D+nkKdfkhraBY9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473004; c=relaxed/simple;
	bh=jxBKTzoJOVyEA32cE+YGMZK++whGJj6vvOgzMyjakoY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AqDPYlCsyLNduNwQNQDhjCASVyJ+3loYEzNzEJbEUdhnrLkq/Gmp+JrNUG+MENVtTha2xopgxHfhIt6/uDl1lSdwktcjcH2GkxHN1f4ED0aagZjNQDL/4kG9BODTAvqfFl6uBjldKp+86Vh5dveMWBOabyNgQidvI/fy1hI4H7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7SzhgsT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716473002; x=1748009002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jxBKTzoJOVyEA32cE+YGMZK++whGJj6vvOgzMyjakoY=;
  b=J7SzhgsTOmqbuXKcCC4f6XTxNt1nfIv6N+t+gUAtkd6nsQKMa/xrSi5d
   JO06pymV/zRLb1FIKtsXf0v55PkFaTTNbyriNVjy+Q4LAIT8KiB91Phlv
   3zeutQa+pB7QiTXW3tRx2QmM+8ZexGttYywMn/h7Ggx2uL65JzpzlRUWQ
   Y/YBSIpPx+H5wmj+hoJY2A4+EetTJ99CjXYtRJ8HWXb0bSJXZjMgmw7XN
   zyv0Blpozr8X/sDoDifUBeOyB3S1C1uz4PbXgMduzXiVgj/zHQ5FJiUZI
   v8Vk0RvNHLBZvTSNfSa4tiYyOioNmsSEP+1JaegA6+4jN2IXQ/YyDEqz0
   A==;
X-CSE-ConnectionGUID: ZzoCrDyWTeqASW8SOmwTbw==
X-CSE-MsgGUID: mOESHmbDQ5WbxCI0ObH3aw==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="24201702"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="24201702"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 07:03:14 -0700
X-CSE-ConnectionGUID: ntJ1y5dDSbuxoHApWddrqw==
X-CSE-MsgGUID: dObKMKDbSwmrqc9kclILPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; 
   d="scan'208";a="38074404"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 23 May 2024 07:03:13 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sA92E-0002xn-2Z;
	Thu, 23 May 2024 14:03:10 +0000
Date: Thu, 23 May 2024 22:02:25 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 tracing_gen_ctx+0x64 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202405232113.H66VwtsE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c760b3725e52403dc1b28644fb09c47a83cacea6
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   10 months ago
config: xtensa-randconfig-r121-20240523 (https://download.01.org/0day-ci/archive/20240523/202405232113.H66VwtsE-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240523/202405232113.H66VwtsE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405232113.H66VwtsE-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x4c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: tracing_gen_ctx+0x64 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

