Return-Path: <linux-kernel+bounces-545396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A1A4EC71
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803177ACB70
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631D24EA9F;
	Tue,  4 Mar 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzB3Gi66"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4DA1F583E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741114206; cv=none; b=Pk37mbltJgQfiRETYGwk8J8K4hWieFn4xnJ84tS/D3oELxz5BwGAOn5RsoijuBJcEY2GLW6H7HrnOYqWTela6YdcBnUyer+6kK0x41pgZZc0Vb2t8jbDzX5vubPknB7iiw+e6sfj7vXpN1UZdfjsvoq1bcYYiL/ZCARFP+ufO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741114206; c=relaxed/simple;
	bh=ERDSiQRCm2WziHCfxkR9TWnvgzH+j6+KMNNxZfF4lWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ou/dZpZEQMrP0CSoXVKRm/DqLCTk9G5ndKctTGar0vh+UAWAMFNPCW59wXDfqSnd9YA442jlXDuWsqUU+AohhQ3EQ7aeXdE6pPVWhupRiGo7z2jw48rsU3Hd4OprAQZkOSZkm15eRtdDkS1a2x6aThZ+tscRTB/YLxoaP187sXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzB3Gi66; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741114205; x=1772650205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ERDSiQRCm2WziHCfxkR9TWnvgzH+j6+KMNNxZfF4lWE=;
  b=KzB3Gi66euFArwO0URpDfCMe5BsZQdXjpdJwsO0JpSJOClHsD29xTZ05
   YtykOXQYrE0vCOXWxYpOHkzgvCRXf4/86RbKGe4f8UtKj+qXlPi8fizDh
   redo7fFZ0GlcuqMYkKf8gXT1pIvhy+VOZPVq74oa0i85gPjsg514ro9Jp
   5fLrLJP4tFf0bwkDnJRiHHJTRC8wPfDXOBmFx7rBQLtKhFQZ6pjpUVq1s
   XhK+fteVKXiYx8n1RrxwhWjCLySh8Qo5Pqd3Xm+hxb1qVH1/0XBmGwkbW
   O3VarGZyV6vuKPjI+myqfjzyYE2OSBzhvBCXNgx2qV29wzsygB/Uqv3Uq
   Q==;
X-CSE-ConnectionGUID: SyA3HwUNSU+Rasx3V2+QIg==
X-CSE-MsgGUID: ttvmOaVyQcigCVLgBwX+zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41300918"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41300918"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 10:50:04 -0800
X-CSE-ConnectionGUID: L2gp5m1iTESUO//o6ZLqsw==
X-CSE-MsgGUID: PJuqkSteSBei5ABb7SshKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118193970"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 04 Mar 2025 10:50:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpXL4-000K9m-0h;
	Tue, 04 Mar 2025 18:49:58 +0000
Date: Wed, 5 Mar 2025 02:49:38 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Eggers <ceggers@arri.de>,
	Russell King <linux@armlinux.org.uk>,
	Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker
 script
Message-ID: <202503050230.820w99b6-lkp@intel.com>
References: <20250224125414.2184-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224125414.2184-1-ceggers@arri.de>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.14-rc5 next-20250304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Eggers/ARM-avoid-that-vectors-are-removed-during-linker-garbage-collection/20250224-210146
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250224125414.2184-1-ceggers%40arri.de
patch subject: [PATCH v2 1/2] ARM: substitute OVERLAY description in linker script
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20250305/202503050230.820w99b6-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503050230.820w99b6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503050230.820w99b6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: section .vectors.bhb.bpiall virtual address range overlaps with .vectors.bhb.loop8
   >>> .vectors.bhb.bpiall range is [0xFFFF0000, 0xFFFF001F]
   >>> .vectors.bhb.loop8 range is [0xFFFF0000, 0xFFFF001F]
--
>> ld.lld: error: section .vectors.bhb.loop8 virtual address range overlaps with .vectors
   >>> .vectors.bhb.loop8 range is [0xFFFF0000, 0xFFFF001F]
   >>> .vectors range is [0xFFFF0000, 0xFFFF001F]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

