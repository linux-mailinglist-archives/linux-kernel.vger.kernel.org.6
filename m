Return-Path: <linux-kernel+bounces-344701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB998ACF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A050B212D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C04199223;
	Mon, 30 Sep 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXtUNT5C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1391917F1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724936; cv=none; b=AWfnF4mJgZ+9T/EsAndS76iI8bsqgcFeiyc6/21k9bi2O5H9Txw8YeXmFQFyBMWAOExYNIWxHTri6+dDyeY0EezfH3L3Bjmh/mreuoIFMKGeVsxaMmRlRflB+xBFLHBG54ypBpQ5ivPYs8hO5qUNxCmq57WCeCG3TmyfyWySS8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724936; c=relaxed/simple;
	bh=gSM6ncWi2n2pfXNxWSneiDhqk1mXU4FWk5a/kfbjBLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LDTw8tIOmJpL7oNK1cV2Hvzy3PYIyU4xy16/saWk27URDx+oo3mn26DiXrO1D39gijqddCkZbEgAX+r1XTwZdIOdTiwjGBtg3LOjDgEw0F2KgL4g2iH8GhtJH0s7P7whw0kAZP4kLLrl2RoPEZO/CBVnxTMBbAPnZx7mDlalzqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXtUNT5C; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727724934; x=1759260934;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gSM6ncWi2n2pfXNxWSneiDhqk1mXU4FWk5a/kfbjBLA=;
  b=JXtUNT5C8rDRKiamXycU0BrM6nFndwr1oV/sM5UTSbbjcMYW3mWu+byw
   /2PkbNIz8b+ezdR0Ihq1YCzic+Kw/n71gVwiVZ5YnHUlGfK9YsOH/jdU3
   eJkK5LDAI6FFiT8kmzDQHSe1q5akDKuG5Wol6/i5CG1z/1QiW05x8Uown
   usPWiXwroFvIcOXq4Lv8xV+wcS8bA5tUr2lLl5B1opHy8hk3y4FwWrYoq
   tQVKEC90klrgXEExjwyklnf69xai7whS3N+cuXXdgHsrCszm0YRxe4IbK
   k0pxCEZPoksE/B+9N+f2AR9jvLtKjyScEO/kpykyEw36SdfcuDNCHXf1j
   A==;
X-CSE-ConnectionGUID: 1Krx7fsRRiqrD4DirMzolw==
X-CSE-MsgGUID: 0hmXG5uNS/61h1ALuJ5/7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26960734"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26960734"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 12:35:33 -0700
X-CSE-ConnectionGUID: A7EpxQF8Rqmk8aSK14+TTg==
X-CSE-MsgGUID: mdqH7C12SzGpyGDGjw420A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78150924"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Sep 2024 12:35:31 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svMB7-000Pob-0w;
	Mon, 30 Sep 2024 19:35:29 +0000
Date: Tue, 1 Oct 2024 03:34:48 +0800
From: kernel test robot <lkp@intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: arch/loongarch/kernel/machine_kexec.o: warning: objtool:
 kexec_shutdown_secondary+0x54: stack state mismatch: cfa1=3+0 cfa2=3+16
Message-ID: <202410010338.tG5tc5tI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Brian,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9852d85ec9d492ebef56dc5f229416c925758edc
commit: ab6b1010dab68f6d4bf063517db4ce2d63554bc6 cpumask: Switch from inline to __always_inline
date:   6 weeks ago
config: loongarch-randconfig-r064-20240825 (https://download.01.org/0day-ci/archive/20241001/202410010338.tG5tc5tI-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410010338.tG5tc5tI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410010338.tG5tc5tI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/loongarch/kernel/machine_kexec.o: warning: objtool: kexec_shutdown_secondary+0x54: stack state mismatch: cfa1=3+0 cfa2=3+16
   arch/loongarch/kernel/machine_kexec.o: warning: objtool: .text: unexpected end of section


objdump-func vmlinux.o kexec_shutdown_secondary:

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

