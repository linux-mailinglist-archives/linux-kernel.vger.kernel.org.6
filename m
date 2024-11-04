Return-Path: <linux-kernel+bounces-394827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4B9BB48F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A4B1F22E54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8361B5ED0;
	Mon,  4 Nov 2024 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTNjvs2X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF381B3725
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722815; cv=none; b=hAjDA+fiDBSj9SY1lDaZ3v6a4p/SYbK+zPJ6tWXtVWo7IHA3oR7v/UZ7djEwoTREXxaVP9YbZJHtRR1X0VTlAluIutM0V+gvIgkoDtVugdjtzK+sfk/TTp4TSQ1J0waZpjYtxq3cGhrHJ2wdHEyJr/NRlqx80n3c106l8sxKZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722815; c=relaxed/simple;
	bh=iymMYskLNA0yLhjo9zMkvE4jjlFdCX5KVdQQg7XrdHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UFXNmVGxsGPA/4DjUBintHaKyh5Jf2XxcGKWKNkb9D8bBXIdeW5HqHNURIuGYhcQYiErpCvlRpoQvrUZpNZsS9Wb0kWIV8uQuWDQg8ImkF3KBIzuMLRvAL7vQrpF1vkONKgF/3Hldyf6dSckmZhuxl6Tous/t14vkEJayyzRkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTNjvs2X; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730722813; x=1762258813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iymMYskLNA0yLhjo9zMkvE4jjlFdCX5KVdQQg7XrdHQ=;
  b=cTNjvs2XMRYnQRZSXJWJnQx7V2AoY47CUhZrCB7lTYq6osTMTJsDfdfK
   I91UJzhgqqbMQ5EUPCa5T+qrvlX0t0bPgP3x2dXywrNhGV1btnEvUpJZi
   9rTcKniH6CaNEE+DKzdzuA3ixSI89yVRU2AVRbLiXHI2+W6Vq4QEu0jmm
   OY19udKqgBFe3caU2AznuzCh9EvDQPF9gTNGhdarX4JvyOLTqTyMwqJSh
   fLogjk+S4gt9j0aLpkWOBzFHYUxxz07kFwnpoRHeyonptrQFnAcDO+evS
   PJqyj37XmpONJ4skees3K0bTGKITcGdbF1T2qVSiC7UHGGGw/8O8il5RF
   Q==;
X-CSE-ConnectionGUID: 8O/rZp5AQu6jHFCk+UQZ4w==
X-CSE-MsgGUID: MVAm71LBQT+z0YuiFAiilA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40965896"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40965896"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 04:20:13 -0800
X-CSE-ConnectionGUID: GzBX5GqdRJeRAnjhm99Z5A==
X-CSE-MsgGUID: LEGVHN6BQrKPfteylDXi4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="114427900"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Nov 2024 04:20:11 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7w41-000koL-1m;
	Mon, 04 Nov 2024 12:20:09 +0000
Date: Mon, 4 Nov 2024 20:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202411042037.Zv3idYtx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ville,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59b723cd2adbac2a34fc8e12c74ae26ae45bf230
commit: 74bde7581df3e18061119e1b27b63d0a9ea57b7a drm/sti: Allow build with COMPILE_TEST=y
date:   5 months ago
config: sh-randconfig-r111-20241104 (https://download.01.org/0day-ci/archive/20241104/202411042037.Zv3idYtx-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241104/202411042037.Zv3idYtx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411042037.Zv3idYtx-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/sti/sti_mixer.c:145:47: sparse:     got void *
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     expected void *addr
   drivers/gpu/drm/sti/sti_mixer.c:168:38: sparse:     got void [noderef] __iomem *

vim +145 drivers/gpu/drm/sti/sti_mixer.c

a5f81078a56c6a Vincent Abriou 2016-02-04  139  
a5f81078a56c6a Vincent Abriou 2016-02-04  140  static void mixer_dbg_mxn(struct seq_file *s, void *addr)
a5f81078a56c6a Vincent Abriou 2016-02-04  141  {
a5f81078a56c6a Vincent Abriou 2016-02-04  142  	int i;
a5f81078a56c6a Vincent Abriou 2016-02-04  143  
a5f81078a56c6a Vincent Abriou 2016-02-04  144  	for (i = 1; i < 8; i++)
a5f81078a56c6a Vincent Abriou 2016-02-04 @145  		seq_printf(s, "-0x%08X", (int)readl(addr + i * 4));
a5f81078a56c6a Vincent Abriou 2016-02-04  146  }
a5f81078a56c6a Vincent Abriou 2016-02-04  147  

:::::: The code at line 145 was first introduced by commit
:::::: a5f81078a56c6ab57b7db2402ac64c34338004c5 drm/sti: add debugfs entries for MIXER crtc

:::::: TO: Vincent Abriou <vincent.abriou@st.com>
:::::: CC: Vincent Abriou <vincent.abriou@st.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

