Return-Path: <linux-kernel+bounces-337463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CDB984A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFB71F221F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D021AC43B;
	Tue, 24 Sep 2024 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIscf1Ip"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7151DFFB
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199696; cv=none; b=jTG/wXJG+UOdo2/0eJrH+4VVpkhOT+6XCkz2/laPErbmQOYDB5Ut8UrZsdbIvZGuceV7TA6by206eWVL/4RWeQlz5A5tClTtwoIb/w+3G3wyl7l8c0POut5gi2hkDQlpArZLAo6sFvGQ3AzJJXrN6tdwTmgoD3/1T2CgxfkybNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199696; c=relaxed/simple;
	bh=hy8T1XGBz3Ygj8AVhFZ6UIZ2sfC7wXQMgFjj8l1x3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un0NwCskP02nVTwGInBZIsL4TmWJD7TdxtPoX6YoDnHQYovvf1WIfQcy3cw3oOyiU5BzchPtbOxAViWtJnoE/2i1bxtkF3N5FiubCVwrrsEVkQkeYszjYm5nY3ZSYe8ZCduwAlreN/MO8jIcI/V1K8cG52YdiB4yk6+rP7loEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIscf1Ip; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727199695; x=1758735695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hy8T1XGBz3Ygj8AVhFZ6UIZ2sfC7wXQMgFjj8l1x3Ao=;
  b=iIscf1Ip2A6lsrkhhDqj26Y3BcH+WYryyG77fTlTt1xo8gXgYZWiRvOf
   3Xkoi+QoSmbDJH5mgBfXar40LYKaKJZA4s/SfuiYS6+ywNAxMM1DQNgKg
   ywR72HAmGUdqqEuLlCFAzTUZsJsuQHoJe1tjgNaaAWOXg8/5MeHBTw6l5
   RHqQ4TMVzHY+Qx/+nYCpMeJV8lokGedrARxDHSlyDHoltUK17+Ph+ZH3B
   tRl/DL85M+qkMJ1r1hD75ZSjUY9fYhSvpEnnRZvQ1zVr+6tg8psY9oslS
   bM1nGCMeMB6121gcZq8fRR/3zfXxSD+Lz0u1CSv8GywZI8Az88qwWRlhV
   w==;
X-CSE-ConnectionGUID: Yo1mBz+OS3Gi3z0GHCdSfQ==
X-CSE-MsgGUID: UsUkzhm6TlG1fhmsrPwTUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26359067"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="26359067"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 10:41:34 -0700
X-CSE-ConnectionGUID: ZXUgU7qXRb+7AGbvkff/hA==
X-CSE-MsgGUID: Dv7S9i33RuWAawwVSIFQ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="72338152"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 24 Sep 2024 10:41:32 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st9XW-000Ief-06;
	Tue, 24 Sep 2024 17:41:30 +0000
Date: Wed, 25 Sep 2024 01:41:18 +0800
From: kernel test robot <lkp@intel.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2] mm: do not export const kfree and kstrdup variants
Message-ID: <202409250157.TXezi0Gp-lkp@intel.com>
References: <20240924050937.697118-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924050937.697118-1-senozhatsky@chromium.org>

Hi Sergey,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Sergey-Senozhatsky/mm-do-not-export-const-kfree-and-kstrdup-variants/20240924-131016
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240924050937.697118-1-senozhatsky%40chromium.org
patch subject: [PATCHv2] mm: do not export const kfree and kstrdup variants
config: loongarch-randconfig-r061-20240924 (https://download.01.org/0day-ci/archive/20240925/202409250157.TXezi0Gp-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250157.TXezi0Gp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250157.TXezi0Gp-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/zlib_inflate/zlib_inflate.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
>> ERROR: modpost: "kstrdup_const" [drivers/dax/kmem.ko] undefined!
>> ERROR: modpost: "kfree_const" [drivers/dax/kmem.ko] undefined!
>> ERROR: modpost: "kfree_const" [drivers/input/touchscreen/chipone_icn8505.ko] undefined!
>> ERROR: modpost: "kstrdup_const" [drivers/power/sequencing/pwrseq-core.ko] undefined!
>> ERROR: modpost: "kfree_const" [drivers/power/sequencing/pwrseq-core.ko] undefined!
>> ERROR: modpost: "kfree_const" [drivers/memstick/core/memstick.ko] undefined!
>> ERROR: modpost: "kfree_const" [net/bluetooth/bluetooth.ko] undefined!
>> ERROR: modpost: "kstrdup_const" [net/nfc/hci/hci.ko] undefined!
>> ERROR: modpost: "kfree_const" [net/nfc/hci/hci.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

