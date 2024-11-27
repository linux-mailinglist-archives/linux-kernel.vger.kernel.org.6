Return-Path: <linux-kernel+bounces-423742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A69DAC12
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4EE169654
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CCD201000;
	Wed, 27 Nov 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwwDQNOs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D892200BB5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726373; cv=none; b=YCsX0V17WaLDJVCwnXQVsTXA5sEe8mj6BTrkB+vwfVxEcn2qAHNjV19d8NBSqnu6mWfTL9ZnmDxWCKebbXBzZeGbOI+we+u+TkgbORiKQrBbB3PxxLuCnPTYIUKMjg3lHh1jpIqVKMseRKmJ/nmml5ICZnISyWruv/6JUhiEjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726373; c=relaxed/simple;
	bh=tG3Du9WkLxVRWLxqCHOORjzivhWmDRn7fpcFfQYdZyw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hrc03KsbbDTpMeb/OWr+tSl4Xg8OQ4nvM2wFnRvIMRUF/H64oXgu1CXvfAuyfE5fYSbYAHUQ4gqfPYTu7+MPPszUtAYPKJzhdVYPpsP7UAuB0sDZYIcGKUP9h2RUdRuVV8WygxhOE1eOzRd0eKzoAkhyX+7eMVh2H+PO0QoPadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwwDQNOs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732726371; x=1764262371;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tG3Du9WkLxVRWLxqCHOORjzivhWmDRn7fpcFfQYdZyw=;
  b=ZwwDQNOsoqwNFXqz7nB1O6teaEVNJmeu9Db3L5ko+GpC3f98dubEByLE
   zOEneXBf6lLcDFpvbdDDp7+vjBdreMd+ofyc0QpYRfN5tCyMSJuH3sno2
   gALkV5sa/FHL9it9wH8eMcJLkqpSIcrHz+RyHT9q0qUJVBeJkPLEtRW9o
   9w3KKRTiZms9BkBup0SSV4K0es14QytbSKP6zMYyFh6O7GDbQAnYAwyG/
   h3+Wupw5gYrkYH3EXp5zeW+dIHO5K/CzbjYh2EAeGX5yXIUgCp61qrnpe
   pCp72Ppz0VEtmWW8mrDfilfams88ZZ7sFJxGb2f9rJnSEmaDcembHEuC8
   A==;
X-CSE-ConnectionGUID: Hz2HE64FRd2T51h3QnYL/A==
X-CSE-MsgGUID: sOKRpaNsTxyowuSj+Jm97Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="44319673"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="44319673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 08:52:50 -0800
X-CSE-ConnectionGUID: cnAt4cbnQ5ubMdAHi2ComQ==
X-CSE-MsgGUID: WnibZDVGQee/KaEDdrzBoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="96750877"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 27 Nov 2024 08:52:49 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGLHT-0008As-1F;
	Wed, 27 Nov 2024 16:52:47 +0000
Date: Thu, 28 Nov 2024 00:52:32 +0800
From: kernel test robot <lkp@intel.com>
To: Marcelo Dalmas <marcelo.dalmas@ge.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:timers/urgent 1/1] ntp.c:undefined reference to `__divdi3'
Message-ID: <202411280033.x5N0rMoH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
head:   299130166e70124956c865a66a3669a61db1c212
commit: 299130166e70124956c865a66a3669a61db1c212 [1/1] ntp: Remove invalid cast in time offset math
config: m68k-m5407c3_defconfig (https://download.01.org/0day-ci/archive/20241128/202411280033.x5N0rMoH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411280033.x5N0rMoH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411280033.x5N0rMoH-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: kernel/time/ntp.o: in function `__do_adjtimex':
>> ntp.c:(.text+0xda6): undefined reference to `__divdi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

