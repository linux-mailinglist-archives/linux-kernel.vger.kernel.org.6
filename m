Return-Path: <linux-kernel+bounces-255126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268CB933C73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D2E5B21690
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB817F4FF;
	Wed, 17 Jul 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hyo6bFlp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D7717F393
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721216632; cv=none; b=LEr9ca3tpDRdcWEnQdEKisRDviQOU8Rjx463jTRwhPgEs3oQr/IzulMklDQGjTKC8g+52szpFugZBFXCx2H0SqNdCC6IwWIaTw2WReIKHwSbLaIXMfI4tIJY/6Xr1X/PkSunJhG7malJ4hj/f+G6tJbhaHs7aFSwOXgQy2PKiJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721216632; c=relaxed/simple;
	bh=4pGBLaVUdxkJUjKPJVohtmmrqGQumPWgEp0RcGinKkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1MvgshzvNennMH5XJFQa/C5pjGNEEI/pNUA7P8SfBTiNNGZv5zE6t0hEzZrE5wWzZdI6w+MkkLBBq89YhuL0CbmmSvrROPIeBeDdDH48bw9RCAopvhjorcdJNDlrcDLq3MDf42o1gAhZpFsIRM6FvYwMoxSe2kSNJnn54JbhjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hyo6bFlp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721216630; x=1752752630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4pGBLaVUdxkJUjKPJVohtmmrqGQumPWgEp0RcGinKkM=;
  b=Hyo6bFlpbe2Ldha/OfOKJxwkcls5eKFcvU0nNz7uExvfCIh0LEcgBoAr
   Y//8yITZFwbiC2+H5umA/QXqByKgJH5J7LoeWrGp+1vL6L258QeWnLedT
   98WP0fzkJPdoE1vHDeqPUpddjR1AoEhx1eMCIe/5Hi31Y+DTmVDxrwmXf
   rQmWru9h5+SfWbJmyRUnznY+rn8m80+or7ZYOuxZ11B77pAF6Z4W/rPpf
   tSnLWwi7xf4dXSJ75pvGkLi5mITgKAZ5GFdkwRw3e4+EtkO1gyeuftDHu
   On9Y0D4ABvw5eyQmde3X39w9Eg3J6Q0v0iAPKFkpTG2rupQd8EaijW5TV
   A==;
X-CSE-ConnectionGUID: 2Uyx3FHtTACwmzihZjDWxQ==
X-CSE-MsgGUID: eQsGZO/5SteQlXL1VLv0uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="22526886"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="22526886"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 04:43:41 -0700
X-CSE-ConnectionGUID: Xd7Mz7UaR6C/EPOp0OUsMw==
X-CSE-MsgGUID: 5ydpkAkZSpCCHXd8SpIcAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="50157202"
Received: from sbutnari-mobl1.ti.intel.com (HELO [10.245.246.16]) ([10.245.246.16])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 04:43:38 -0700
Message-ID: <05954a59-2bef-4262-bd91-cfe21d2381f2@linux.intel.com>
Date: Wed, 17 Jul 2024 13:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ld.lld: error: undefined symbol: iosf_mbi_available
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
References: <202407160704.zpdhJ8da-lkp@intel.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202407160704.zpdhJ8da-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/24 01:07, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3e7819886281e077e82006fe4804b0d6b0f5643b
> commit: 8d4ba1be3d2257606e04aff412829d8972670750 ASoC: SOF: pci: split PCI into different drivers
> date:   3 years, 4 months ago

This doesn't seem to be a problem on the latest code? was it intentional
to report a problem on such an old commit?

> config: i386-buildonly-randconfig-004-20240716 (https://download.01.org/0day-ci/archive/20240716/202407160704.zpdhJ8da-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240716/202407160704.zpdhJ8da-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407160704.zpdhJ8da-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: iosf_mbi_available
>    >>> referenced by byt.c
>    >>>               soc/sof/intel/byt.o:(byt_machine_select) in archive sound/built-in.a
> --
>>> ld.lld: error: undefined symbol: iosf_mbi_read
>    >>> referenced by byt.c
>    >>>               soc/sof/intel/byt.o:(byt_machine_select) in archive sound/built-in.a
> 

