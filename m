Return-Path: <linux-kernel+bounces-261721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C3793BB51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CFB1C2192C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2258318028;
	Thu, 25 Jul 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c46Nkvyw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AB17722;
	Thu, 25 Jul 2024 03:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721878853; cv=none; b=u7Q1hQp/jrDRJdgCxLCyUf1hhJ45V2K8YxhuKqP04Fqj+4sWvbPyJrzFWZxDO4TO2A99xJ2L6+2mtqruMiLAeYSBVOJ0hOw/7gkLHCMExzG5fXnla5bZtaJpeMmNPobM7+aui2PuC/BD9tJTTkEfqWe+b7kzAekefST+cyvPiVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721878853; c=relaxed/simple;
	bh=+/SfHcWvZuzX5BpxFTHb0SOKVhDlmAD0pvwxtii3/9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1/9PKCm/7gLqnsIj+KczO9nmnnh80m3iBGHbqvn51NrQ7PDajJaknhkYs571OBJHU8FxHYgbf5PrCD8wAnUxncbSD/C3MZYKrO8YFL4q6F1His2n612frLXCgKy+3C/1X81TDQA10XRMJQCICzHcKgR8PSH68x2CpMeBE4vH4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c46Nkvyw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721878851; x=1753414851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+/SfHcWvZuzX5BpxFTHb0SOKVhDlmAD0pvwxtii3/9s=;
  b=c46NkvywEzrrW3OzAG6kl1linE543u1D/A8CK5aasu7+fHdd0SL41TBe
   yC/EFC/IfcVGJJBGgxA3mVFKNLSY7co4/ozCvZSwK/I3UatjTqFZx/8TK
   4BgYzLTxKHEHJvav/jAYsfh6oaWiCsZwrT4BbRNhIKBH6HQrU1VJAf+oL
   unP+u9/4A+rurWG6befxKON7mGGpHP2B31q0evoOTjFQlotmx7Rt0/ygi
   ttCGjLOsXucDk3TChRFAxStDdxHTsLmD1fEir+PV9AlZacw6oqFikKmlI
   UM127QPL3/XpyQgFEqucP/MFe05eduvytiPYArHP56kFJ1rRznTlWXZ4w
   Q==;
X-CSE-ConnectionGUID: gIRzvfBfSvq9MMbWSQTdOQ==
X-CSE-MsgGUID: HaKJdgM5SqWskyPFP5eDBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="31011505"
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="31011505"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 20:40:51 -0700
X-CSE-ConnectionGUID: OPYShQlcTvOHVabSwQwkdw==
X-CSE-MsgGUID: D07xcoM9SzSpX0iEQmX2Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,234,1716274800"; 
   d="scan'208";a="52817584"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Jul 2024 20:40:48 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWpLR-000nii-1V;
	Thu, 25 Jul 2024 03:40:45 +0000
Date: Thu, 25 Jul 2024 11:40:08 +0800
From: kernel test robot <lkp@intel.com>
To: Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>,
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, mustafa.eskieksi@gmail.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Carlos Ferreira <carlosmiguelferreira.2003@gmail.com>
Subject: Re: [PATCH v4 1/2] HP: wmi: added support for 4 zone keyboard rgb
Message-ID: <202407251136.aymIqEw3-lkp@intel.com>
References: <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719100011.16656-2-carlosmiguelferreira.2003@gmail.com>

Hi Carlos,

kernel test robot noticed the following build warnings:

[auto build test WARNING on lee-leds/for-leds-next]
[also build test WARNING on v6.10]
[cannot apply to linus/master next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Ferreira/HP-wmi-added-support-for-4-zone-keyboard-rgb/20240719-180603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git for-leds-next
patch link:    https://lore.kernel.org/r/20240719100011.16656-2-carlosmiguelferreira.2003%40gmail.com
patch subject: [PATCH v4 1/2] HP: wmi: added support for 4 zone keyboard rgb
config: i386-kismet-CONFIG_LEDS_CLASS_MULTICOLOR-CONFIG_HP_WMI-0-0 (https://download.01.org/0day-ci/archive/20240725/202407251136.aymIqEw3-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240725/202407251136.aymIqEw3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407251136.aymIqEw3-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR when selected by HP_WMI
   WARNING: unmet direct dependencies detected for LEDS_CLASS_MULTICOLOR
     Depends on [n]: NEW_LEDS [=n] && LEDS_CLASS [=n]
     Selected by [y]:
     - HP_WMI [=y] && X86_PLATFORM_DEVICES [=y] && X86_PLATFORM_DRIVERS_HP [=y] && ACPI_WMI [=y] && INPUT [=y] && (RFKILL [=y] || RFKILL [=y]=n)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

