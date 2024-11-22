Return-Path: <linux-kernel+bounces-417613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0569D56AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 01:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576DA1F228AA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA6B676;
	Fri, 22 Nov 2024 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCbU0AWm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438B7494
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234943; cv=none; b=fEKAcjkThiGb1J7fy+PfUbHepl0xUR1gfwpTdsgqKIl73E7c70/U6xHOePw+2MfAaUNXvdjPuIiMJ7aa9DnMSLQAZDU3olJS4bkUS+dnnHPRyUWgLMqOqNyqZveZ5IRR2wvhnbZf8Gb0NGcTud3NCZrLdlgZ57ZZNUaqyheaELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234943; c=relaxed/simple;
	bh=ON/sWBHgX12yEyoAUSoYeEV0P4oWcexF5z8ooY8/p+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tymGyVSZy0LLExgvO24QpUv+wIBpC97GBAYLKTnFa6Mv0NzHC6oRC2cqlD6xzFR+w5+pJO08Fz4gtuTXPrzQrdX/76nWjBqxhpdnspdrIve8xdV+Kqizowha6rCD2mnwUdcOPgnqmU2BGAwPFjL9GDcZSDVkspk/tzkwdo+skD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCbU0AWm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732234942; x=1763770942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ON/sWBHgX12yEyoAUSoYeEV0P4oWcexF5z8ooY8/p+I=;
  b=SCbU0AWmI0Qen4peSEEiTcoyNlKGpo9iYZcusau4eYYsrrdT+6OtS/UE
   DyuW+njlPNzo1Tf+aSBtiH76OpUD9Dh/BXUDisbfzaKN+0bLXyQzbxgPU
   fbrkF1Z8sEAFOKk55jSRYdexR86uDKuTeFvAMUAwEicixLqZCz76q0t84
   M/iC/aci2leYEbqvcRnxkyFSszrHTbGjkUNbtdJKMHgaGyotQ0P2c7xB3
   cjjBYNo2uUMgIH7a8AIMvMrO7SGt+ziuxxnHcOnlLPAFLZg/ASCCUYF2z
   eI3R5s7m5Z+5HzY5YNT7CZjJqvr79z+1p3ScnNkIIURHFGgnaTNqV8BXN
   w==;
X-CSE-ConnectionGUID: g7w4Lu+2TdOfzJTZf+bm4A==
X-CSE-MsgGUID: +5JEBhcNSTG4e42/gN4IbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="31734580"
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="31734580"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 16:22:21 -0800
X-CSE-ConnectionGUID: znIJqu/2S02Qf6TOw8jWAA==
X-CSE-MsgGUID: mMj5JEo/QuWrsYMwK4+DQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,174,1728975600"; 
   d="scan'208";a="90833919"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Nov 2024 16:22:16 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEHR7-0003VX-2H;
	Fri, 22 Nov 2024 00:22:13 +0000
Date: Fri, 22 Nov 2024 08:21:16 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de, alex.murray@canonical.com, andrew.cooper3@citrix.com,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] [v2] x86/cpu: Help users notice when running old Intel
 microcode
Message-ID: <202411220850.Ev9wmbR6-lkp@intel.com>
References: <20241120185835.485F3BDA@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120185835.485F3BDA@davehans-spike.ostc.intel.com>

Hi Dave,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-linus]
[also build test WARNING on linus/master v6.12 next-20241121]
[cannot apply to tip/x86/core tip/auto-latest tip/smp/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dave-Hansen/x86-cpu-Help-users-notice-when-running-old-Intel-microcode/20241121-141349
base:   driver-core/driver-core-linus
patch link:    https://lore.kernel.org/r/20241120185835.485F3BDA%40davehans-spike.ostc.intel.com
patch subject: [PATCH] [v2] x86/cpu: Help users notice when running old Intel microcode
config: x86_64-randconfig-123-20241121 (https://download.01.org/0day-ci/archive/20241122/202411220850.Ev9wmbR6-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220850.Ev9wmbR6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220850.Ev9wmbR6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/cpu/common.c:200:1: sparse: sparse: symbol 'gdt_page' redeclared with different type (different address spaces):
   arch/x86/kernel/cpu/common.c:200:1: sparse:    struct gdt_page [addressable] [noderef] [toplevel] __percpu gdt_page
   arch/x86/kernel/cpu/common.c: note: in included file (through arch/x86/include/asm/stackprotector.h, include/linux/stackprotector.h):
   arch/x86/include/asm/desc.h:49:1: sparse: note: previously declared as:
   arch/x86/include/asm/desc.h:49:1: sparse:    struct gdt_page extern [addressable] [toplevel] gdt_page
>> arch/x86/kernel/cpu/common.c:1321:19: sparse: sparse: symbol 'cpu_latest_microcdoe' was not declared. Should it be static?
   arch/x86/kernel/cpu/common.c:2059:1: sparse: sparse: symbol 'fixed_percpu_data' redeclared with different type (different address spaces):
   arch/x86/kernel/cpu/common.c:2059:1: sparse:    struct fixed_percpu_data [addressable] [noderef] [toplevel] __percpu fixed_percpu_data
   arch/x86/kernel/cpu/common.c: note: in included file (through arch/x86/include/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/thread_info.h, ...):
   arch/x86/include/asm/processor.h:417:1: sparse: note: previously declared as:
   arch/x86/include/asm/processor.h:417:1: sparse:    struct fixed_percpu_data extern [addressable] [toplevel] fixed_percpu_data
   arch/x86/kernel/cpu/common.c: note: in included file (through arch/x86/include/asm/stackprotector.h, include/linux/stackprotector.h):
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *
   arch/x86/kernel/cpu/common.c: note: in included file (through arch/x86/include/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/thread_info.h, ...):
   arch/x86/include/asm/processor.h:421:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got char ( * )[40] @@
   arch/x86/include/asm/processor.h:421:31: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/processor.h:421:31: sparse:     got char ( * )[40]
   arch/x86/kernel/cpu/common.c: note: in included file (through arch/x86/include/asm/stackprotector.h, include/linux/stackprotector.h):
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *
   arch/x86/include/asm/desc.h:54:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __percpu *__vpp_verify @@     got struct gdt_page * @@
   arch/x86/include/asm/desc.h:54:16: sparse:     expected void const [noderef] __percpu *__vpp_verify
   arch/x86/include/asm/desc.h:54:16: sparse:     got struct gdt_page *

vim +/cpu_latest_microcdoe +1321 arch/x86/kernel/cpu/common.c

  1320	
> 1321	struct x86_cpu_id cpu_latest_microcdoe[] = {
  1322	#include "microcode/intel-ucode-defs.h"
  1323		{}
  1324	};
  1325	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

