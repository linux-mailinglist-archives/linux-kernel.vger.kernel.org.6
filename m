Return-Path: <linux-kernel+bounces-420948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1A9D84A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CDA168C99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BB199935;
	Mon, 25 Nov 2024 11:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GvAO4zUc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E629192D91
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534970; cv=none; b=cg0VgQ4I8evHIYUCLN4wBk8Oh1qir7FJnuWaeyaHW0zTvRk7WiJDc0UYbkJ/ISP/SZnsn/Y/9f6HkLJ8LSFyedHlzAgBPwbRhYknSQF2FYwmQeq2DN/UpQCvfTYLVKM5C1VRKKFQcgZWvIbH8nusJDpWNH/AlfLzohNQ9Tud918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534970; c=relaxed/simple;
	bh=/tvYCZ2YN+fHWCx8kb6FLlRxDsTEAuSmzNv0Qt9XmIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXgNWZi54yPeLRuZwsk7KBlkZYSw+NNqalDCIKCuSBEvHH2NTiIna+jcn305PcxgPcEL8k931VgynYgW8Ivkt8b2mpARLPpr0W3Mn3AN3HTvNX+816s7PBZ19tkddAR1w9OULx0d5jeWXontGkMIYYyoTjbQZ+Dee2lEehCfJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GvAO4zUc; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732534970; x=1764070970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/tvYCZ2YN+fHWCx8kb6FLlRxDsTEAuSmzNv0Qt9XmIY=;
  b=GvAO4zUcy2WdqsGEzBRSSAISsUFwqV0ahhonrIHNUwKmsZddCYxxrqUd
   pl0O1J6hwJcR0ZVTqDInkdczQATz9b4JTtoS+9rRNPYwjYsbpIe1u4DoO
   7cm41ksF4x8PP+tqrvf5PywHlgmsJ8YLiPP0fDeBm8Nd2HFb7OL5PKXMA
   egx6QP+RVJc/ISH0bvY5OV/V6CsNE4mH4iKx/yyLSvUpMwogld6Fm33uu
   2UwUFrAoTNI4YzDKfa/yHSu103g4GjvQzQtDuEfYF1A1oSeXmB7eY3u63
   F8MT8gVwr1v0GTy/4PXylgPiiJsWbh6OyhPPBzdD86LZ4L60X/nYBBlq8
   w==;
X-CSE-ConnectionGUID: eelbconuTJaRFizfUYeHSA==
X-CSE-MsgGUID: 2XiaGqeWQhGUvo8/xIo5nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="43699120"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="43699120"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 03:42:49 -0800
X-CSE-ConnectionGUID: MTmHcvOASc+QL/oqKW29QQ==
X-CSE-MsgGUID: yoIqH574SOqq/islBK6hdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="95654008"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Nov 2024 03:42:46 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFXUK-0006GH-0h;
	Mon, 25 Nov 2024 11:42:44 +0000
Date: Mon, 25 Nov 2024 19:42:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mateusz Guzik <mjguzik@gmail.com>, tglx@linutronix.de, bp@alien8.de,
	andy@kernel.org, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH 2/2] string: retire bcmp()
Message-ID: <202411251926.sIYJ9sEV-lkp@intel.com>
References: <20241123094729.1099378-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123094729.1099378-3-mjguzik@gmail.com>

Hi Mateusz,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/hardening]
[also build test ERROR on tip/master tip/x86/core linus/master v6.12 next-20241125]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/x86-callthunks-s-bcmp-memcmp/20241125-110959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
patch link:    https://lore.kernel.org/r/20241123094729.1099378-3-mjguzik%40gmail.com
patch subject: [PATCH 2/2] string: retire bcmp()
config: arm-footbridge_defconfig (https://download.01.org/0day-ci/archive/20241125/202411251926.sIYJ9sEV-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241125/202411251926.sIYJ9sEV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411251926.sIYJ9sEV-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "bcmp" [fs/fat/fat.ko] undefined!
>> ERROR: modpost: "bcmp" [fs/isofs/isofs.ko] undefined!
>> ERROR: modpost: "bcmp" [fs/nfsd/nfsd.ko] undefined!
>> ERROR: modpost: "bcmp" [drivers/net/slip/slhc.ko] undefined!
>> ERROR: modpost: "bcmp" [drivers/usb/core/usbcore.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

