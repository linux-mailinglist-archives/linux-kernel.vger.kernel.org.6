Return-Path: <linux-kernel+bounces-552345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE2A578C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7394716F02D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 06:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6B19047C;
	Sat,  8 Mar 2025 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UngE8yea"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAF17A318;
	Sat,  8 Mar 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741414838; cv=none; b=mQ2ORyrgab1d5lqzvaV9LWo5zV4GSl782imxOSamSVZgGmsd5Wa8b0uWAn7culYeiaB5hvRKxjT55F9uR13+e+EyLVMJrgbRxEpUWlMHriC19KWWdncX/oumBd7TSF58sw/TvFEqqL9/4HEgIEwizieow+YzHQWfr7piNmI6JRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741414838; c=relaxed/simple;
	bh=5YfqZTbEGIseGzwqMQm6Q/pxFyZ7sTTqrLNxwSsyqPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTXrOjrlije/A6tj59sV17nlTntn9PS1Y/H6fa2NMcj7eD4Fcn35RTf9u+Nhk7Aksg02M7y9DCS4u/66krmrITfoS5SZzwDHV9+HYAelioC54KszmHxZ1GZtRl/ijGJVnYNChZlz7ybYQZK/LViOrAO4TaCQYIm8qzDLZXgHrIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UngE8yea; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741414835; x=1772950835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5YfqZTbEGIseGzwqMQm6Q/pxFyZ7sTTqrLNxwSsyqPc=;
  b=UngE8yeayas6Tx3Bdc3bNuuFhwChrat7UM3tPDbFIy3W1pzvgwqZBgW/
   YIEYRvrU5M76euPiL2UVHCxpvmxssHnSB+Rm/PqoHFmIN5efT+YO2Q9eA
   2gPj7rByDaiGhpKoCBYmybdptDWwjHENldV3OFpUmKLXQkORb+EWXLQlu
   lIF+CevsX4lNQTbZu3qqqlCMIX4JZsQWjHYRdt7XwQUwmKhCP6HzMiryl
   /GhHZAnDJd2xUrUGGL2ZBpXhIcKKLEC83VtfeXo19tNUFw+HyFHCytebV
   xslg9JDdkoDM/3C5AsW1hmtX18ceFebUXfkM+hP3IrLkQVa7p93TuVbrT
   w==;
X-CSE-ConnectionGUID: M7TwBbLMQpmLFNSDsqDZAQ==
X-CSE-MsgGUID: mkNXwAsoRVS1yNhAZ2txIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42611147"
X-IronPort-AV: E=Sophos;i="6.14,231,1736841600"; 
   d="scan'208";a="42611147"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 22:20:34 -0800
X-CSE-ConnectionGUID: TBMUlj87R0qD7RzuhIEVTg==
X-CSE-MsgGUID: aA64BUCcSjudK9qzQo3J1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123689338"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Mar 2025 22:20:30 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqnXv-0001Zs-2J;
	Sat, 08 Mar 2025 06:20:27 +0000
Date: Sat, 8 Mar 2025 14:20:22 +0800
From: kernel test robot <lkp@intel.com>
To: wangweidong.a@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	perex@perex.cz, tiwai@suse.com, ivprusov@salutedevices.com,
	jack.yu@realtek.com, zhoubinbin@loongson.cn,
	luca.ceresoli@bootlin.com, quic_pkumpatl@quicinc.com,
	paulha@opensource.cirrus.com, rf@opensource.cirrus.com,
	nuno.sa@analog.com, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	yijiangtao@awinic.com
Subject: Re: [PATCH V2 2/2] ASoC: codecs: Add aw88166 amplifier driver
Message-ID: <202503081433.xufVVq8t-lkp@intel.com>
References: <20250228034958.181934-3-wangweidong.a@awinic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228034958.181934-3-wangweidong.a@awinic.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1e15510b71c99c6e49134d756df91069f7d18141]

url:    https://github.com/intel-lab-lkp/linux/commits/wangweidong-a-awinic-com/ASoC-dt-bindings-Add-schema-for-awinic-aw88166/20250228-115709
base:   1e15510b71c99c6e49134d756df91069f7d18141
patch link:    https://lore.kernel.org/r/20250228034958.181934-3-wangweidong.a%40awinic.com
patch subject: [PATCH V2 2/2] ASoC: codecs: Add aw88166 amplifier driver
config: x86_64-buildonly-randconfig-004-20250308 (https://download.01.org/0day-ci/archive/20250308/202503081433.xufVVq8t-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250308/202503081433.xufVVq8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503081433.xufVVq8t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> sound/soc/codecs/snd-soc-aw88166.o: warning: objtool: .text.aw_dev_dsp_update_cfg: unexpected end of section

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

