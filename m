Return-Path: <linux-kernel+bounces-206935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE330901006
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB831F2236F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 07:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8D149C65;
	Sat,  8 Jun 2024 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTvUqZvK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B97610C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717832727; cv=none; b=ZaJhhHNnFrm4nivt78P3GdlRuoZVItn93oCDjGsU+KCNgiYR4R9GnTce3V0Nv9T6WXnt0amGV56uniMejWH5INenbVoSB6vmfefTdm3H1pv1wy3p2Asevo7BgyvFX9ip6cKfvjhSy65U98/nibyncr0QR+/XUAReLzE2iKKMp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717832727; c=relaxed/simple;
	bh=0qxGBIGAeV+6/mYpcz2yW6HvdA8SWLHlev3qLo95vug=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lSYHmaWTD8A+iAHhFWqmpeKTDZTtQ+6kpLb07WHDt3Gn3KPRgD70PhV5O6Zp544a42fdtqyeeyyx0sj1HKpYs+tNq9pko6zQ0xum1k6u/X/6O8SNpyBYdA7Bo3TkKWDY0hNDOE+HF2RztWruvQDgmy/SB9eABhT11emFCNE/ubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTvUqZvK; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717832725; x=1749368725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0qxGBIGAeV+6/mYpcz2yW6HvdA8SWLHlev3qLo95vug=;
  b=bTvUqZvKCKs7bX/0+NIFaG4+HoLB1YLDLE6T8Q1tFJuGVcEHipHsA0RM
   il0ZMGg3KJFS0KRKxxZx5IwAsc7L+qwjbm/vjNNxF4MPNiRyUtIr8WH8F
   SjiV7IzFRaB1oAgDcjdMEvgzkNhHL5+0JJ+b9xN/SCq0MBpUWpEAP3JS+
   DQC/pOXM/fYMED+rjvOvGBlLzdEDyvvYtbGzh7igRapyGVlchbaGb5Do1
   aUODqHKpv+oviysZJFIBXW0o4n3a54QtBuF1qEUf029Kww880TEkC2NGP
   4AlAJDrnm7U/1ahsjlwkaWZRs93dmhUvZmzAX9Wch4blvdcyF+dQD7uO4
   w==;
X-CSE-ConnectionGUID: +LK5FOIETgqkFyyIyvv9jw==
X-CSE-MsgGUID: sJzWXxtHRpmLJNlrss+Www==
X-IronPort-AV: E=McAfee;i="6600,9927,11096"; a="32103211"
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="32103211"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 00:45:24 -0700
X-CSE-ConnectionGUID: Jt7DZv3tTGi6p0Wjd2KZgA==
X-CSE-MsgGUID: EEdnJdahRe+QJ/Ud6qjAig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,222,1712646000"; 
   d="scan'208";a="69728240"
Received: from lkp-server01.sh.intel.com (HELO 472b94a103a1) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Jun 2024 00:45:23 -0700
Received: from kbuild by 472b94a103a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFqlN-0001GY-1c;
	Sat, 08 Jun 2024 07:45:21 +0000
Date: Sat, 8 Jun 2024 15:45:01 +0800
From: kernel test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: riscv32-linux-ld: section .rodata VMA [c2566300,c2f0be8d] overlaps
 section .bss VMA [c2556000,c2892ad7]
Message-ID: <202406081518.k7yJ6Tja-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc772f8237f9b0c9ea3f34d0dc4a57d1f6a5070d
commit: 5fb70e7275a61dd404f684370e1add7fe0ebe9c5 netfs, 9p: Implement helpers for new write code
date:   5 weeks ago
config: riscv-randconfig-r022-20221204 (https://download.01.org/0day-ci/archive/20240608/202406081518.k7yJ6Tja-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406081518.k7yJ6Tja-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406081518.k7yJ6Tja-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv32-linux-ld: section .data LMA [00f80000,0148ce97] overlaps section .text LMA [000a0290,025662e7]
>> riscv32-linux-ld: section .rodata VMA [c2566300,c2f0be8d] overlaps section .bss VMA [c2556000,c2892ad7]
>> riscv32-linux-ld: section .data..percpu VMA [c2893000,c28a1633] overlaps section .rodata VMA [c2566300,c2f0be8d]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

