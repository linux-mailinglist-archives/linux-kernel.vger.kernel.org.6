Return-Path: <linux-kernel+bounces-207589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D6901955
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 04:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50671C20DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 02:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC74C74;
	Mon, 10 Jun 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PU8t2yvC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B9E23A8;
	Mon, 10 Jun 2024 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717985223; cv=none; b=Bpx9+NY6TecFM/kEQzN/7RQ9T70ACFExy1IJEIDcnzImqotYINwtEJ95VV5ZedAZ6LMaR5hiT3qtwOadBfIGUy+3Y0STgaIGTJ3l4UlLGw87jgjkbTrh+5VGcLuvsaRKTWqUy1ZzYEb2KLoA2DKiMFhi22qpf0fbCTPbtq5k/6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717985223; c=relaxed/simple;
	bh=BxBGZGWx+C9rblxwyMFADPhIL0QUhuc2bQiAUmd5EGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpaVAWKQiuXUIb0ytFfDtop3+TEpH0SjNedpstr9dL4Ap1qCSuR2WYVOr2GgDxrAYl86o1QdkydLMKW7H3DAU6LCH6cTqlvO6h3x8y9vss5LvnHTq8xmPMrX/Kfy13u/xZB+GM1pIAJF/Fq8TVP/oxAMO9rDSpStuldhSkmBv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PU8t2yvC; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717985222; x=1749521222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxBGZGWx+C9rblxwyMFADPhIL0QUhuc2bQiAUmd5EGk=;
  b=PU8t2yvCyrLNo85iB4NPysd+bhojPfvjLIQI62H0menCNTyr0RVo/2ha
   +rTcn0O7SZuAXvtwUnHRKFWvo4Y3dI1LxvzfpIexpQbVqu8cNggwxSU3T
   gTcbCUgKs1WqivPhGTlOx501w+jAZV5EADFQS97jzdgxt2fhOhAKKEGmm
   p9cgbSTs/5hs/GNc1ybL9BqbrtHY2/pHB+MqECahb3J71vSHZhISEP8IL
   Jmf4lWucVQevQl4qTCk82Eg2MNqprs6M0rlGdo3H12G6ue+NkXoOxO3Pq
   gyA88IDyUqBCyW2UobYDAZJH1974OD1ClJuhwyxXyVSfzCyc66bhMob6J
   Q==;
X-CSE-ConnectionGUID: df8vIWVwTcCLwLsMnFxfrQ==
X-CSE-MsgGUID: xL4AWHz5RKiAPPPFjJbuUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="37158544"
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="37158544"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 19:07:01 -0700
X-CSE-ConnectionGUID: WsWdOVlBSRaV2wNn8PWhuw==
X-CSE-MsgGUID: uPYyZUXTQcuo/3UeegYPOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,226,1712646000"; 
   d="scan'208";a="69699937"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 09 Jun 2024 19:06:59 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sGUQy-0001lK-03;
	Mon, 10 Jun 2024 02:06:56 +0000
Date: Mon, 10 Jun 2024 10:06:46 +0800
From: kernel test robot <lkp@intel.com>
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of security-bugs
Message-ID: <202406100911.QBMVtIpz-lkp@intel.com>
References: <20240610003520.33839-1-dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610003520.33839-1-dzm91@hust.edu.cn>

Hi Dongliang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.10-rc3 next-20240607]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dongliang-Mu/docs-zh_CN-update-the-translation-of-security-bugs/20240610-083729
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/20240610003520.33839-1-dzm91%40hust.edu.cn
patch subject: [PATCH v2] docs/zh_CN: update the translation of security-bugs
reproduce: (https://download.01.org/0day-ci/archive/20240610/202406100911.QBMVtIpz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406100911.QBMVtIpz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`rt_link<../../networking/netlink_spec/rt_link>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Documentation/userspace-api/netlink/netlink-raw.rst: :doc:`tc<../../networking/netlink_spec/tc>`
   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: Documentation/translations/zh_TW/admin-guide/reporting-issues.rst references a file that doesn't exist: Documentation/translations/zh_CN/admin-guide/security-bugs.rst
>> Warning: Documentation/translations/zh_TW/admin-guide/reporting-issues.rst references a file that doesn't exist: Documentation/translations/zh_CN/admin-guide/security-bugs.rst
>> Warning: Documentation/translations/zh_TW/process/submitting-patches.rst references a file that doesn't exist: Documentation/translations/zh_CN/admin-guide/security-bugs.rst
   Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

