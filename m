Return-Path: <linux-kernel+bounces-370883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC49A3339
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AD32855B4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E769155A2F;
	Fri, 18 Oct 2024 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVhnMs77"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B695F291E;
	Fri, 18 Oct 2024 03:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729221186; cv=none; b=jU5w4t1FenevoJ78cQrtds73rRDv71+hIj7ZdUYWk8QgJEOfheDGExDN4wncIHBLFMjNS4+s43RJsuAiVdf0oyf5XE2nc2t3tRjFHqithuvKoXo2x96ED/XgpyNtIpcM4aZpQgGMCOvro11ICCDpubCmoSh2+NCEt+Kiz7xCXdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729221186; c=relaxed/simple;
	bh=Mbhk6OVowHcpsMN07TUo495OKjlMt8B1HvFFI4oWGt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuoYxTnz90tT5WirVzHE6t4NYeE4oMZ3YxO4XM9S+fhWiKkK8CgkuYtKgZiklz7bFlO/zB9HUIuwwOQNjKJRfn7BoXpr1o1k4Cnqur0BdH7rR3ApL5q+aIFglCjY0xbdh3SSgW9hOweJqmHvxXG/pzTSPKgxaJXk8nVPGi6VglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVhnMs77; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729221185; x=1760757185;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mbhk6OVowHcpsMN07TUo495OKjlMt8B1HvFFI4oWGt0=;
  b=EVhnMs77bROw7zgaKjMUBoShazAP5HIugojP9uMNxhYFDnO3YLsC9N5Z
   I6XXOzoMFnYAseX0tVezoIe1g4FoelCDQ6o2NcvLRP9hBgZysuUABLjup
   KM2QvnIItXtpHQXU+bvp24BVxTwrbFbamcn0552InFcZCSGV8l5LD1MqC
   dyERxbnxR0hF0M1steeOcxwOnYDAmWdjCCFacONwGaCyvdNEYDDJ3WuU1
   zbxiJggbQwXOE9lbdNXF7ffkVfn8p1T5qJcNjA7Z65nXwnfLHnoFTEbpY
   Gme6QqcJzuXbHxPNNjL4adX5AeRZvDJxWj9ecqnIxo+iFk8UbcCuDXlFz
   A==;
X-CSE-ConnectionGUID: 7BUbnZONSgWkjrVFHOE+bA==
X-CSE-MsgGUID: Au6r/8yeT3ehWSExpaxdsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28951359"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28951359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:13:04 -0700
X-CSE-ConnectionGUID: SVxD1VEAT/y+R+nIehCDkg==
X-CSE-MsgGUID: bCSa7BIaSjeXOIA2YxV1FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83569646"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 20:13:02 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t1dQB-000ND5-1w;
	Fri, 18 Oct 2024 03:12:59 +0000
Date: Fri, 18 Oct 2024 11:12:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Federico Vaga <federico.vaga@vaga.pv.it>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: remove Documentation/dontdiff
Message-ID: <202410181003.R1XoCTwa-lkp@intel.com>
References: <87y12m1zk4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y12m1zk4.fsf@trenco.lwn.net>

Hi Jonathan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lwn/docs-next]
[also build test WARNING on linus/master v6.12-rc3 next-20241017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Corbet/docs-remove-Documentation-dontdiff/20241018-001340
base:   git://git.lwn.net/linux.git docs-next
patch link:    https://lore.kernel.org/r/87y12m1zk4.fsf%40trenco.lwn.net
patch subject: [PATCH] docs: remove Documentation/dontdiff
reproduce: (https://download.01.org/0day-ci/archive/20241018/202410181003.R1XoCTwa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410181003.R1XoCTwa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
>> Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

