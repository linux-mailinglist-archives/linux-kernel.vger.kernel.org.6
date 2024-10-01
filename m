Return-Path: <linux-kernel+bounces-345367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCA98B543
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5EC6B21028
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47B1BD005;
	Tue,  1 Oct 2024 07:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvmlKSph"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070501BC9FE;
	Tue,  1 Oct 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766784; cv=none; b=ZOWGsthUWjW3pqAgMlFMHS96C+mc+hsinnKwby4Popq68cTf5jKhOaaJz51lgddDHg2fKsbfkV6m7I68ZqBhD4E4oWrXCJeCVPDM1ezkmpWa1+XgB59Kxv36K/W3wbVF3359Z6SfZg5yBuRrgDy8xWekmLhrOYWuMFVKAtqsB+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766784; c=relaxed/simple;
	bh=oo0jhgcjQerWWWBHBdkvBF8qqrs8eFFKDatX+5p5lDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5p5w0i9V62knpf3aSA2LSM41PZQsu1tfrzvjSIRzF6DVszDK3Ou2IxflR5DXQEIB0HVLAJIf4tqyFfRgO5blNSxwInhPpyVVnNoq/duESX8q5Df5MlqHYtmqP14MrCrwC5UjNjOmGxlpitJHODNHtDthM00/oDp9dqpK8RNcKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvmlKSph; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727766782; x=1759302782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oo0jhgcjQerWWWBHBdkvBF8qqrs8eFFKDatX+5p5lDA=;
  b=bvmlKSphuK0BZ9MuL+QImBlNgupsgR8Ft/POQjMFrvajjR6K2wo20vtH
   VBT+db+oIx3ov5+KJ9uMQ4zheaqR2+aXRSaj60Y77Z2L7sW8QwugNRUqP
   7zceoVhk2mul97u8P0yHEFuuwCLvqfE3KgCfnmul93AbsNhkPK9j6XNEN
   g8TWddCls+HooUiQkzexMYQxX7yFpeJ7SAB7uSy3eXtmh5u2IyqRLqO4a
   QnGDNB+HdEMupvZuLzAip17KMhc9d4JcoxEELhNlZeU6ApYeYsGuQend3
   36WmUY3n262fJbQv2ZnV2B9C0t/m1fMwjsm7jGyacDTMzM+l1DAAKSNBm
   w==;
X-CSE-ConnectionGUID: 1nk1OnERSDKXghznbzFsMA==
X-CSE-MsgGUID: sj0KkRmbQOGYgNgq0Rq3oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30584195"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30584195"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 00:13:01 -0700
X-CSE-ConnectionGUID: oDf7UcsMS46wzIx+seWPgA==
X-CSE-MsgGUID: 6iXj3I0DTamoZlAFF+V9Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78532287"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Oct 2024 00:13:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svX45-000QMr-15;
	Tue, 01 Oct 2024 07:12:57 +0000
Date: Tue, 1 Oct 2024 15:12:26 +0800
From: kernel test robot <lkp@intel.com>
To: Maya Matuszczyk <maccraft123mc@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/3] platform: arm64: Add driver for Lenovo Yoga Slim
 7x's EC
Message-ID: <202410011448.NB5fJNNX-lkp@intel.com>
References: <20240927185345.3680-2-maccraft123mc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927185345.3680-2-maccraft123mc@gmail.com>

Hi Maya,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.12-rc1 next-20241001]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maya-Matuszczyk/platform-arm64-Add-driver-for-Lenovo-Yoga-Slim-7x-s-EC/20240928-025757
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240927185345.3680-2-maccraft123mc%40gmail.com
patch subject: [PATCH 2/3] platform: arm64: Add driver for Lenovo Yoga Slim 7x's EC
config: sh-randconfig-002-20241001 (https://download.01.org/0day-ci/archive/20241001/202410011448.NB5fJNNX-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011448.NB5fJNNX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011448.NB5fJNNX-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_input_allocate_device" [drivers/platform/arm64/lenovo-yoga-slim7x.ko] undefined!
>> ERROR: modpost: "input_register_device" [drivers/platform/arm64/lenovo-yoga-slim7x.ko] undefined!
>> ERROR: modpost: "input_set_capability" [drivers/platform/arm64/lenovo-yoga-slim7x.ko] undefined!
>> ERROR: modpost: "input_event" [drivers/platform/arm64/lenovo-yoga-slim7x.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

