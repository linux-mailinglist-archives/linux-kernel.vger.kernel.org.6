Return-Path: <linux-kernel+bounces-197784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C323E8D6F1A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320CF2826A1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C770114E2DA;
	Sat,  1 Jun 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/oHr3TL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4C42AA1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717233373; cv=none; b=ORozYnbPY8j5c4PSFRX/lMOvz1IDRlDgLPQzSClvltNRw1/TOb/sYZqFXtGeH+bWaDzvxJVdh7U1SNIEXRLZpW/MYtKzfiVITWNPryFRWALFWWehDGF3ei/uH/ErnuSk+4FGVqNDPB4voKNi/URYQM0lAjxuo+9z3cLC95g7WXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717233373; c=relaxed/simple;
	bh=T6/CPowi4thvbK601KZt4tAJbwgEaWyDdTOOsspbz0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lor7a6feYAA5zbnwRt6v/flyN6aTu/GZUotnivgXJ+RxBG9KbJbkp0LVvArABJVCQUSKymK/8L264r05Mz2Coqe8Wz3f383TxL2+Q9JgKjmsVW/0P5wBYAiuxZd7fYJMBNyoNt7eeth7WnFbX+VOPerUqhvCl8RkoJpbE4ZzDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/oHr3TL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717233371; x=1748769371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T6/CPowi4thvbK601KZt4tAJbwgEaWyDdTOOsspbz0o=;
  b=c/oHr3TLSp6bqo5ZsVC2aPNzxkxHzkhjnZ2H2uDyXV7UXwP0m5+2KHMB
   jQFB3ul08n/Lj955iodOYgCQ8hNtQeS3ZuQyF3UWwM8CxFo95KaM/4cIV
   /A9Kpf59DKxYz+7VaQ9LQomqalOd1/QIybC+XCekfAkAY14lBfnPWM1mA
   GEprjlPH6eNVjM4LCX5qkMrVwaJIIFKu6yzG/l2EyRKqz5Ukcdd48gTcx
   bffgZhQ14z3KyUj9nwtAIUTFSHeFM6BgP1tmchkm9wevgk/W2MqkoF6lf
   MO1AQMn538XgxblKCHAzoTd6mtcgnGWENZrhFVIFdhfHmsvBL/1wm8aCT
   g==;
X-CSE-ConnectionGUID: sPZr7aZGTK2qcN5lHHfNpQ==
X-CSE-MsgGUID: sDKELte5T7qJXiXQ/s9+Kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13972353"
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="13972353"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 02:16:11 -0700
X-CSE-ConnectionGUID: 6DckudI/SECIzNrhAbR7Rg==
X-CSE-MsgGUID: aDDBc9IuQ9emxbmkfXQcZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,207,1712646000"; 
   d="scan'208";a="36985450"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 01 Jun 2024 02:16:10 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDKqM-000IcP-0p;
	Sat, 01 Jun 2024 09:16:06 +0000
Date: Sat, 1 Jun 2024 17:16:03 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 run_tracer_selftest+0x2c0 (section: .text.unlikely) -> initcall_level_names
 (section: .init.data)
Message-ID: <202406011735.mZrn6TzP-lkp@intel.com>
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
head:   cc8ed4d0a8486c7472cd72ec3c19957e509dc68c
commit: 481461f5109919babbb393d6f68002936b8e2493 linux/export.h: make <linux/export.h> independent of CONFIG_MODULES
date:   10 months ago
config: xtensa-randconfig-r024-20220805 (https://download.01.org/0day-ci/archive/20240601/202406011735.mZrn6TzP-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240601/202406011735.mZrn6TzP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406011735.mZrn6TzP-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: run_tracer_selftest+0x2c0 (section: .text.unlikely) -> initcall_level_names (section: .init.data)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

