Return-Path: <linux-kernel+bounces-347133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B0B98CE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9237BB21447
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FB6194A66;
	Wed,  2 Oct 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoZPqwU9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3262942A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856069; cv=none; b=CrqwklsetbVDWkNE7GlT1/HCasUWTbNJQSMYl+YmTiaFrBRdhJ/79fLr/6rApR0pIWL9e2pKjmT9qT0j2JNYtEeZu0Ne2vLpFfahTS9/+66IRzfQHdyiZ6+zA0Ofrg6Eom8qCNLtw5wRgWnuOFpUx2BkuOCiqhFeSdpem++ljMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856069; c=relaxed/simple;
	bh=W1/RxTrXILcH4rl7tbA+EuN/c7SpVtjyGNtesYNKmas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCFH5pNgAFwsOu4W6c7SK3jrcBw9NMM7Mckd4f2grp8lrhPBIyrY+rwS32xV2n03TCg9AXT9oy06OeSoDYKY/HVxepMWEii3JD9kvBWu4Oy+r+1VfOyC5EyH7zvRBsJiWhpMoPsc91FI8VhEGWhLuc1luSffhDuK8KJFBWpJqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoZPqwU9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727856068; x=1759392068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W1/RxTrXILcH4rl7tbA+EuN/c7SpVtjyGNtesYNKmas=;
  b=PoZPqwU9v3cdJvziRcmRQpTtbpxQU95f5H/yqO/xujWm5cjQkg7zNWFw
   oZpMNaHIH/e152BHy3A0MEFxbv1ZLUlptnkkabS2PC9PLdj5zITsZHJXL
   xv+v9D4unEyP7BLL4Aa/+vj+JxwZwmg4SJJQEf+pVe9O7Bgljm4uJN5m5
   fGmk8Sry+JXGEm8rkmeAnSLjczQ7+xN0kyWYGdQyLMmnsSvTjwHtzPeJ4
   yfEb9l3FZP7aTWo3hFGq0sAHRqba5OoW7FwOVOTWzpj3ZkQU/ALfquwZJ
   wR+DJJlkePu7H+GwMgYsGjNd4i4rymtHidla/UiO91WIV0bhPIszkuOny
   A==;
X-CSE-ConnectionGUID: GHaqOWZuTLG59sDQeHOYvQ==
X-CSE-MsgGUID: z4jfga1yRlmTc2Z7LJyFCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26519369"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="26519369"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:01:07 -0700
X-CSE-ConnectionGUID: tMQWD4WwTiartgPgU+hnQA==
X-CSE-MsgGUID: ypbTPhgIS+Kla3iZ6sevBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="78673841"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 02 Oct 2024 01:01:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svuIA-000RmT-0G;
	Wed, 02 Oct 2024 08:01:02 +0000
Date: Wed, 2 Oct 2024 16:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: Shenghao Ding <shenghao-ding@ti.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, baojun.xu@ti.com, 13564923607@139.com,
	13916275206@139.com, navada@ti.com, v-hampiholi@ti.com,
	m-shrivastava1@ti.com, sakshi@ti.com, sandeepk@ti.com,
	robinchen@ti.com, alsa-devel@alsa-project.org,
	Shenghao Ding <shenghao-ding@ti.com>
Subject: Re: [RESEND PATCH v4] MAINTAINERS: update entries in TEXAS
 INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add
 entries for haptic driver
Message-ID: <202410021557.FByBO9Dp-lkp@intel.com>
References: <20241002011147.1345-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002011147.1345-1-shenghao-ding@ti.com>

Hi Shenghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc1 next-20241002]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shenghao-Ding/MAINTAINERS-update-entries-in-TEXAS-INSTRUMENTS-LOW-MIDDLE-POWER-AUDIO-AMPLIFIER-ASoC-HDA-DRIVERS-and-add-entries-for-ha/20241002-091259
base:   linus/master
patch link:    https://lore.kernel.org/r/20241002011147.1345-1-shenghao-ding%40ti.com
patch subject: [RESEND PATCH v4] MAINTAINERS: update entries in TEXAS INSTRUMENTS LOW/MIDDLE-POWER AUDIO AMPLIFIER (ASoC/HDA) DRIVERS and add entries for haptic driver
reproduce: (https://download.01.org/0day-ci/archive/20241002/202410021557.FByBO9Dp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410021557.FByBO9Dp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/tpa6130a2.txt
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

