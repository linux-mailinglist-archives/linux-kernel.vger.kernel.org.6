Return-Path: <linux-kernel+bounces-273232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A87946620
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4931F22291
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524D13AD39;
	Fri,  2 Aug 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqTcExcs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A849658;
	Fri,  2 Aug 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641170; cv=none; b=dTyO/l5WeVjh09W4i8APb9bfRiaz+xRqSZmOMqmkC0gpjACb/rOU9nPBvkW/qvvHIC7kQrSNhfjtJWvxv438ZvnghkuIinyDs7Js7tyHsZZzTLhkFcJb05MpF1f7MLjqTmfhVSAmO2j0Y4sBPm3wqqw4oEsmeTuE7TVcuFMD3fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641170; c=relaxed/simple;
	bh=Jcbz/gg6+XN0P/pOczsu0ej73zhPm485GKcdKVXxrxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkbY4CVBmC1sMM49lRkqwJvaSO+gPTFnGNvojNI5mQV6wqTyAVsM+0SzqYrUL/ghZHAKg7a+UIbxT8gqLpa6V0VkyVJLVHkn1NZvgudS/0bWb2Cw3y62Rn0BlCA8t/VYMZkxu9o5QbLCTIytRckClT4wVPtlNBe8jcmtlDcdKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqTcExcs; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722641168; x=1754177168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jcbz/gg6+XN0P/pOczsu0ej73zhPm485GKcdKVXxrxw=;
  b=TqTcExcs9AQMeTr1MQazFb1tDgIglkmFKOHe0OqasZHHdz0PHNL5r0/o
   3Kf6QN66m/WcSRhY3gPCpvKzivxk6uvxq+PIi+RVQj8yh813MDI/sKTSt
   vJUJlJg6rZfhWgFfszHoeEDP0OUIUpUtKDICUPnNGTtAvkysXz/tXR7+g
   SyuMyeGUh25y+gyhu7McvczLm3DsJKnJLR8NMo0xSI2YS86rwKvdWziij
   6xlwRHcfUOOKw1tepu50mL6lZnJyzfL+46VWBtjSv3Ncugv/h0lrxSOFT
   enBQjEjON3Kp4MK26B8eoF3NUUcGQPX7AU1HKM9wk2SNCws5q0o4btj1v
   w==;
X-CSE-ConnectionGUID: LsDsW5kWSBmtjwpDoUiR8Q==
X-CSE-MsgGUID: dXce+mZaT06lWtYaVjy9oA==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="31302943"
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="31302943"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 16:26:08 -0700
X-CSE-ConnectionGUID: RUOZqdf4TWqzhKsdVGEqzQ==
X-CSE-MsgGUID: URWv0Wf2Q9+Bu6lYSUhg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,259,1716274800"; 
   d="scan'208";a="86496105"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 02 Aug 2024 16:26:04 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sa1es-000xXP-1m;
	Fri, 02 Aug 2024 23:26:02 +0000
Date: Sat, 3 Aug 2024 07:25:53 +0800
From: kernel test robot <lkp@intel.com>
To: Stanley Chu <stanley.chuys@gmail.com>, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, linux-i3c@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com, cpchiang1@nuvoton.com
Subject: Re: [PATCH v1 2/2] i3c: master: Add Nuvoton npcm845 i3c master driver
Message-ID: <202408030639.LBZ5zgGw-lkp@intel.com>
References: <20240801071946.43266-3-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801071946.43266-3-yschu@nuvoton.com>

Hi Stanley,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chu/dt-bindings-i3c-Add-NPCM845-i3c-controller/20240802-183617
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240801071946.43266-3-yschu%40nuvoton.com
patch subject: [PATCH v1 2/2] i3c: master: Add Nuvoton npcm845 i3c master driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240803/202408030639.LBZ5zgGw-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408030639.LBZ5zgGw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408030639.LBZ5zgGw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/i3c/master/npcm845-i3c-master.c:655:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
     655 |         default:
         |         ^
   drivers/i3c/master/npcm845-i3c-master.c:655:2: note: insert 'break;' to avoid fall-through
     655 |         default:
         |         ^
         |         break; 
>> drivers/i3c/master/npcm845-i3c-master.c:1112:9: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
    1112 |                         if ((NPCM_I3C_MSTATUS_STATE_IDLE(reg) |
         |                             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                               ||
    1113 |                              NPCM_I3C_MSTATUS_STATE_SLVREQ(reg)) &&
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/i3c/master/npcm845-i3c-master.c:67:42: note: expanded from macro 'NPCM_I3C_MSTATUS_STATE_IDLE'
      67 | #define   NPCM_I3C_MSTATUS_STATE_IDLE(x) (NPCM_I3C_MSTATUS_STATE(x) == 0)
         |                                          ^
   drivers/i3c/master/npcm845-i3c-master.c:1112:9: note: cast one or both operands to int to silence this warning
   drivers/i3c/master/npcm845-i3c-master.c:67:42: note: expanded from macro 'NPCM_I3C_MSTATUS_STATE_IDLE'
      67 | #define   NPCM_I3C_MSTATUS_STATE_IDLE(x) (NPCM_I3C_MSTATUS_STATE(x) == 0)
         |                                          ^
>> drivers/i3c/master/npcm845-i3c-master.c:2353:12: error: incompatible function pointer types initializing 'void (*)(struct platform_device *)' with an expression of type 'int (struct platform_device *)' [-Wincompatible-function-pointer-types]
    2353 |         .remove = npcm_i3c_master_remove,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.


vim +2353 drivers/i3c/master/npcm845-i3c-master.c

  2350	
  2351	static struct platform_driver npcm_i3c_master = {
  2352		.probe = npcm_i3c_master_probe,
> 2353		.remove = npcm_i3c_master_remove,
  2354		.driver = {
  2355			.name = "npcm845-i3c-master",
  2356			.of_match_table = npcm_i3c_master_of_match_tbl,
  2357		},
  2358	};
  2359	module_platform_driver(npcm_i3c_master);
  2360	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

