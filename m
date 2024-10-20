Return-Path: <linux-kernel+bounces-373138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE119A52E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580F02835C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001DC15E90;
	Sun, 20 Oct 2024 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+S6bFDp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4418BE8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729405406; cv=none; b=Sxh48Cxwl5njZIYWyHPfubFkZ1YMaqdXhU9jIDSm6GZo4EjMdODBGHrrvkE7rzVaqlp1AKwPya/QNCpzfgQTC/tyCCyHcAM2v7GMYKpt0JEsvk1q/5L459hLRW/Q8o2JqqFIDgGg6HsyyUgmT0rVbSo7PYxoeFGyWLR4YGQVKW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729405406; c=relaxed/simple;
	bh=YOgoFs16A+Y3ecRnnziswAMdFiSgBFhfuQnmuNNhXEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W01C3PZmyKXQ1mgil0+S2IRYcwP2ONI4dYVvzDNvaCOGvtD+wy78wi6+GEotcZgFnKf3r6BDzmkP+YmJ/H0y+BxvdQ27FJrWJo3KPqknTI7UHT+nAHMrmE4S8qKF5NtigSwHzhcFCK05YQ/7k94eNKt6PVvcQd4E+moWkPvWkMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+S6bFDp; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729405404; x=1760941404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOgoFs16A+Y3ecRnnziswAMdFiSgBFhfuQnmuNNhXEs=;
  b=O+S6bFDpDuWiW5Sh6E64JoZy+REAT6mVuGtasg80awCLK4x7c7XynSAG
   EWkyJEQQ9ygLe8eD24vTi2y1sJhLqR98Y6nFWpchDu5/UT6WVJufihRCb
   9lmpfdcHHvhgiamJB0bAky4yBVq5R8ZZwOcBmRCgaRdsC9+eD5w6XptJb
   vKds3qL1qlIUJ8nfY9FElI45NIZuTw6JAiq2JGH3e1hO1LjQEqSEOrCKu
   /W7ynTSjkVg2aGA6oNP3ltecQiCSVmw9wbMlk+qPqdQSX8R7gVtK/I8ty
   Yfe6DGVmhbKk/0pp07h30nfE8s1MlxWhCW0QZRGGmh03/Np/S/gOW+9hp
   A==;
X-CSE-ConnectionGUID: VFzS5IoIQpq3rmw2wXB1VA==
X-CSE-MsgGUID: p7z7ivEeSsW1lT+WXnW4FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="29117573"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="29117573"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2024 23:23:23 -0700
X-CSE-ConnectionGUID: o2wIV/AdRvqdj2qMlY04HQ==
X-CSE-MsgGUID: esxB1rTeSJ2S6sjBYarB8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="79157493"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Oct 2024 23:23:22 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2PLT-000Pyn-1H;
	Sun, 20 Oct 2024 06:23:19 +0000
Date: Sun, 20 Oct 2024 14:23:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ba Jing <bajing@cmss.chinamobile.com>, mporter@kernel.crashing.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	alex.bou9@gmail.com, linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: Re: [PATCH] rapidio: rio-access: remove unused macros
Message-ID: <202410201348.MoFc4X0v-lkp@intel.com>
References: <20241015000207.5047-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015000207.5047-1-bajing@cmss.chinamobile.com>

Hi Ba,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ba-Jing/rapidio-rio-access-remove-unused-macros/20241017-152330
base:   linus/master
patch link:    https://lore.kernel.org/r/20241015000207.5047-1-bajing%40cmss.chinamobile.com
patch subject: [PATCH] rapidio: rio-access: remove unused macros
config: i386-buildonly-randconfig-002-20241020 (https://download.01.org/0day-ci/archive/20241020/202410201348.MoFc4X0v-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201348.MoFc4X0v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201348.MoFc4X0v-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/rapidio/rio-access.c:52:1: error: use of undeclared identifier 'RIO_8_BAD'
      52 | RIO_LOP_READ(8, u8, 1)
         | ^
   drivers/rapidio/rio-access.c:29:6: note: expanded from macro 'RIO_LOP_READ'
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:171:1: note: expanded from here
     171 | RIO_8_BAD
         | ^
>> drivers/rapidio/rio-access.c:53:1: error: use of undeclared identifier 'RIO_16_BAD'
      53 | RIO_LOP_READ(16, u16, 2)
         | ^
   drivers/rapidio/rio-access.c:29:6: note: expanded from macro 'RIO_LOP_READ'
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:174:1: note: expanded from here
     174 | RIO_16_BAD
         | ^
>> drivers/rapidio/rio-access.c:54:1: error: use of undeclared identifier 'RIO_32_BAD'
      54 | RIO_LOP_READ(32, u32, 4)
         | ^
   drivers/rapidio/rio-access.c:29:6: note: expanded from macro 'RIO_LOP_READ'
      29 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:177:1: note: expanded from here
     177 | RIO_32_BAD
         | ^
   drivers/rapidio/rio-access.c:55:1: error: use of undeclared identifier 'RIO_8_BAD'
      55 | RIO_LOP_WRITE(8, u8, 1)
         | ^
   drivers/rapidio/rio-access.c:48:6: note: expanded from macro 'RIO_LOP_WRITE'
      48 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:180:1: note: expanded from here
     180 | RIO_8_BAD
         | ^
   drivers/rapidio/rio-access.c:56:1: error: use of undeclared identifier 'RIO_16_BAD'
      56 | RIO_LOP_WRITE(16, u16, 2)
         | ^
   drivers/rapidio/rio-access.c:48:6: note: expanded from macro 'RIO_LOP_WRITE'
      48 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:183:1: note: expanded from here
     183 | RIO_16_BAD
         | ^
   drivers/rapidio/rio-access.c:57:1: error: use of undeclared identifier 'RIO_32_BAD'
      57 | RIO_LOP_WRITE(32, u32, 4)
         | ^
   drivers/rapidio/rio-access.c:48:6: note: expanded from macro 'RIO_LOP_WRITE'
      48 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:186:1: note: expanded from here
     186 | RIO_32_BAD
         | ^
   drivers/rapidio/rio-access.c:105:1: error: use of undeclared identifier 'RIO_8_BAD'
     105 | RIO_OP_READ(8, u8, 1)
         | ^
   drivers/rapidio/rio-access.c:81:6: note: expanded from macro 'RIO_OP_READ'
      81 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:25:1: note: expanded from here
      25 | RIO_8_BAD
         | ^
   drivers/rapidio/rio-access.c:106:1: error: use of undeclared identifier 'RIO_16_BAD'
     106 | RIO_OP_READ(16, u16, 2)
         | ^
   drivers/rapidio/rio-access.c:81:6: note: expanded from macro 'RIO_OP_READ'
      81 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:28:1: note: expanded from here
      28 | RIO_16_BAD
         | ^
   drivers/rapidio/rio-access.c:107:1: error: use of undeclared identifier 'RIO_32_BAD'
     107 | RIO_OP_READ(32, u32, 4)
         | ^
   drivers/rapidio/rio-access.c:81:6: note: expanded from macro 'RIO_OP_READ'
      81 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:31:1: note: expanded from here
      31 | RIO_32_BAD
         | ^
   drivers/rapidio/rio-access.c:108:1: error: use of undeclared identifier 'RIO_8_BAD'
     108 | RIO_OP_WRITE(8, u8, 1)
         | ^
   drivers/rapidio/rio-access.c:100:6: note: expanded from macro 'RIO_OP_WRITE'
     100 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:34:1: note: expanded from here
      34 | RIO_8_BAD
         | ^
   drivers/rapidio/rio-access.c:109:1: error: use of undeclared identifier 'RIO_16_BAD'
     109 | RIO_OP_WRITE(16, u16, 2)
         | ^
   drivers/rapidio/rio-access.c:100:6: note: expanded from macro 'RIO_OP_WRITE'
     100 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:37:1: note: expanded from here
      37 | RIO_16_BAD
         | ^
   drivers/rapidio/rio-access.c:110:1: error: use of undeclared identifier 'RIO_32_BAD'
     110 | RIO_OP_WRITE(32, u32, 4)
         | ^
   drivers/rapidio/rio-access.c:100:6: note: expanded from macro 'RIO_OP_WRITE'
     100 |         if (RIO_##size##_BAD) return RIO_BAD_SIZE;                      \
         |             ^
   <scratch space>:40:1: note: expanded from here
      40 | RIO_32_BAD
         | ^
   12 errors generated.


vim +/RIO_8_BAD +52 drivers/rapidio/rio-access.c

394b701ce4fbfd Matt Porter 2005-11-07  51  
394b701ce4fbfd Matt Porter 2005-11-07 @52  RIO_LOP_READ(8, u8, 1)
394b701ce4fbfd Matt Porter 2005-11-07 @53  RIO_LOP_READ(16, u16, 2)
394b701ce4fbfd Matt Porter 2005-11-07 @54  RIO_LOP_READ(32, u32, 4)
394b701ce4fbfd Matt Porter 2005-11-07  55  RIO_LOP_WRITE(8, u8, 1)
394b701ce4fbfd Matt Porter 2005-11-07  56  RIO_LOP_WRITE(16, u16, 2)
394b701ce4fbfd Matt Porter 2005-11-07  57  RIO_LOP_WRITE(32, u32, 4)
394b701ce4fbfd Matt Porter 2005-11-07  58  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

