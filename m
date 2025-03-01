Return-Path: <linux-kernel+bounces-540068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0410A4AD37
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EDF3B76E6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5459F1E5B76;
	Sat,  1 Mar 2025 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXDi+HrY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECA1C3308;
	Sat,  1 Mar 2025 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852495; cv=none; b=hu6STwf50wCFx1z5jGM1xOL5XX2upMssBSG+FYJI2z4fP+fiQusPOBxpfUQwOWpgR5qIDNt4byHHNJxVZW9wI2r6Cf2n9NYhy8R9AeB3Mq/8tgTRHike32KIqgS0AYcZkatAKvzwTo4XXjSKOIA7KD347rDyUftAuj5/9fp2+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852495; c=relaxed/simple;
	bh=W55l/pUCAdveWF379Cya8xRZuTSRTba/xGgojnWUq6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMCXFEZu+UyJqU1amirGUHbJkoxiwQnk46OKHMW3bYm8mMXz3LQZL4xDqyba8zFCwKs+mhqIo1bbHWgQj+KFnN46vXU3yESD9xIxZmgKrw0puIhCDT98nqb7+sfT4ymmGtA9Bb9t9LdRpBcAWcFz7uriDhJ2+WvjROP6ooU4aWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXDi+HrY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740852494; x=1772388494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W55l/pUCAdveWF379Cya8xRZuTSRTba/xGgojnWUq6E=;
  b=gXDi+HrYjLH7yI1iXHuP5MjbHydgEkoW6t1UjmUqVH/gLEnDNSlDSij7
   hixOCB+V9t7ivLVNHzfo30DecpjJbwDv1XyMMZXSsxhgMnyQgWY0jHjqT
   6kbZ7a7uBtoIHRNX8/ww0rg9G6QAqK771W9h4syUdh1hKdmuyYf+22/7j
   ZFlBcoU5QRWpck9e1oc3jOhezM4l0DfZ++DmPy0mfy93p43pkKUYbHTnn
   QWsOvYyYJ3p1YcH+w1kHZeERJem0TL/6ri9CNmdXVJSpC+mtSvqWfPOMy
   fR8/2RuQzUTmHDUp8l5kPj8/9w5QBc7WLTUQXRSB1OHbSvSISp9jEbTDA
   Q==;
X-CSE-ConnectionGUID: 2Ho9+vjITa6K1br1Ovhe/g==
X-CSE-MsgGUID: JltUvSh4SbGN40y0EC6jNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="52751290"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="52751290"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:08:13 -0800
X-CSE-ConnectionGUID: QiERENeURFOimTASE61rGg==
X-CSE-MsgGUID: cFNZt0FoRbSKrY/nnMbfhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="122574038"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 01 Mar 2025 10:08:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRFu-000GXe-2W;
	Sat, 01 Mar 2025 18:08:06 +0000
Date: Sun, 2 Mar 2025 02:07:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Limonciello <superm1@kernel.org>,
	Luke Jones <luke@ljones.dev>, Xino Ni <nijs1@lenovo.com>,
	Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Cody T . -H . Chiu" <codyit@gmail.com>,
	John Martens <johnfanv2@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] platform/x86: Add lenovo-wmi drivers Documentation
Message-ID: <202503020122.t8BHxWLm-lkp@intel.com>
References: <20250225220037.16073-2-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225220037.16073-2-derekjohn.clark@gmail.com>

Hi Derek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on amd-pstate/linux-next]
[also build test WARNING on amd-pstate/bleeding-edge linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Derek-J-Clark/platform-x86-Add-lenovo-wmi-drivers-Documentation/20250226-060548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20250225220037.16073-2-derekjohn.clark%40gmail.com
patch subject: [PATCH v3 1/4] platform/x86: Add lenovo-wmi drivers Documentation
reproduce: (https://download.01.org/0day-ci/archive/20250302/202503020122.t8BHxWLm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020122.t8BHxWLm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
   Warning: Documentation/translations/zh_CN/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_CN/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
   Warning: Documentation/translations/zh_TW/admin-guide/README.rst references a file that doesn't exist: Documentation/dev-tools/kgdb.rst
   Warning: Documentation/translations/zh_TW/dev-tools/gdb-kernel-debugging.rst references a file that doesn't exist: Documentation/dev-tools/gdb-kernel-debugging.rst
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/wmi/devices/lenovo-wmi-other.rst
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/leds/backlight/ti,lp8864.yaml
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

