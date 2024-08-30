Return-Path: <linux-kernel+bounces-309352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C062D966942
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0340A1C226D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903151BC07D;
	Fri, 30 Aug 2024 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DfVnQpe2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECAE33CD1
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725044675; cv=none; b=GEfrv3vFsMvNehh7VhgcMf/b1pErup2RDQFXC67TdLUd3QxgW0c0X6oxtSjUC4kQ9XeqEuKgnZx5ldIvDCRa0D+gBDSsJaLby8nQYUwSTwYfYob17+92HyKFL30t3qK7g9QRq/xU6HFbxdb/+GA/r2ipPBoSlr7m2k9ocNxF/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725044675; c=relaxed/simple;
	bh=768uChLj28ZUvwd6FRzExWXXuwJbLiP7QZxl0LVbwHM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pDSZHNOq4F7J6jN1TttOdJfE9rmFmCcgOWRN0jveeYwAHR++OOZmKrTQkLeXtuv4tRazjUphWn/ZHxptLIRC/ORO9GetZz9mRd9WpHJSKd2B/U2pC2jODv4JgZCGuQRwNoVti67mymmKO/lmHx/OQL0PmV03GVyeWNrj4H40ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DfVnQpe2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725044673; x=1756580673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=768uChLj28ZUvwd6FRzExWXXuwJbLiP7QZxl0LVbwHM=;
  b=DfVnQpe2b4Viup3DiX+y5k8VrMyS6Y27D9G9heiuG2vdNMmu0NhuUHY6
   vhInxPHQ1cA5eZas5ZGiqBH70fKAclrN4kRb/ahaA0WBFkB9rXmKnCcPB
   YMFv/Hl+bE/BlWm8w0QyTmNQy6bYvY4/95HWMaWvTrF5L8eSTrX8c4lsV
   AX9Jj1v8CeJFuWhNYCerrbWzyBXKaPTNTEWfQMeiUfJzvQpyz/FMBnL32
   xuJY0HwvgVrmyj2IkC4NAxs2KD7KKxI/nIv+NA2Bi0SJNFzUAUb5UlCVr
   RGbAITkp2A8FNud0XNlA3ksM38gyTauOXRPnAOPzQgg+g9I+VRBUH0Gqe
   Q==;
X-CSE-ConnectionGUID: rNHi/WjwTTSW4lu2gUwKEg==
X-CSE-MsgGUID: W2zYjyt4ThGbkXaEUTetCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23500726"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="23500726"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 12:04:33 -0700
X-CSE-ConnectionGUID: plZKGkXDS7mBFjRYcJcgFw==
X-CSE-MsgGUID: QSGaFKq2StylUcou/xFm3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="68833598"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Aug 2024 12:04:31 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sk6v7-0001wu-0B;
	Fri, 30 Aug 2024 19:04:29 +0000
Date: Sat, 31 Aug 2024 03:03:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Lukas Czerner <lczerner@redhat.com>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: fs/ext4/super.c:2054:1: error: unused function 'ctx_set_flags'
Message-ID: <202408310303.6OpqRWeH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   20371ba120635d9ab7fc7670497105af8f33eb08
commit: 1ff20307393e17dc57fde62226df625a3a3c36e9 ext4: unconditionally enable the i_version counter
date:   1 year, 11 months ago
config: x86_64-sof-customedconfig-amd-defconfig (https://download.01.org/0day-ci/archive/20240831/202408310303.6OpqRWeH-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408310303.6OpqRWeH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408310303.6OpqRWeH-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/ext4/super.c:1750:19: error: unused variable 'deprecated_msg' [-Werror,-Wunused-const-variable]
    1750 | static const char deprecated_msg[] =
         |                   ^~~~~~~~~~~~~~
>> fs/ext4/super.c:2054:1: error: unused function 'ctx_set_flags' [-Werror,-Wunused-function]
    2054 | EXT4_SET_CTX(flags); /* set only */
         | ^~~~~~~~~~~~~~~~~~~
   fs/ext4/super.c:2032:20: note: expanded from macro 'EXT4_SET_CTX'
    2032 | static inline void ctx_set_##name(struct ext4_fs_context *ctx,          \
         |                    ^~~~~~~~~~~~~~
   <scratch space>:56:1: note: expanded from here
      56 | ctx_set_flags
         | ^~~~~~~~~~~~~
   2 errors generated.


vim +/ctx_set_flags +2054 fs/ext4/super.c

6e47a3cc68fc52 Lukas Czerner 2021-10-27  2053  
e3952fcce1aad9 Lukas Czerner 2022-02-01 @2054  EXT4_SET_CTX(flags); /* set only */
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2055  EXT4_SET_CTX(mount_opt);
e3952fcce1aad9 Lukas Czerner 2022-02-01  2056  EXT4_CLEAR_CTX(mount_opt);
e3952fcce1aad9 Lukas Czerner 2022-02-01  2057  EXT4_TEST_CTX(mount_opt);
6e47a3cc68fc52 Lukas Czerner 2021-10-27  2058  EXT4_SET_CTX(mount_opt2);
e3952fcce1aad9 Lukas Czerner 2022-02-01  2059  EXT4_CLEAR_CTX(mount_opt2);
e3952fcce1aad9 Lukas Czerner 2022-02-01  2060  EXT4_TEST_CTX(mount_opt2);
e3952fcce1aad9 Lukas Czerner 2022-02-01  2061  

:::::: The code at line 2054 was first introduced by commit
:::::: e3952fcce1aad934f1322843b564ff86256444b2 ext4: fix remount with 'abort' option

:::::: TO: Lukas Czerner <lczerner@redhat.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

