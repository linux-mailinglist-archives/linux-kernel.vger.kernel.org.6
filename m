Return-Path: <linux-kernel+bounces-361901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A695999AEA9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3462849C0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C611D26F3;
	Fri, 11 Oct 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mv65ICT0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427B51A070E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728685726; cv=none; b=BEIcXxzN0bzmuNTwHgumryBHM/llPKbJbpl2g/+wsfOeKEKuLLfHuhKQ0rPmlBtJcua6frlfPq2ow7GgcSQrCL62oFrmoHTWSUBg2bLMNdzvoZ1to+uY4zRfFyK8a2trIisyRkP7M7eTMe/i5UdzeKMWBg/5vNSX4HosXbfw52s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728685726; c=relaxed/simple;
	bh=F6JLjXHUVVi0zfCY2Lznvqc4UtULEP3AD56INv2/5uE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fHEwmwgiNzn2ph6RY7FWR3591H7GcelVdmotBYx8AvM9HnxFT6ckJX71PLQr+RDvSBDVjJOxvFjeZvzr7iKIUY2xMGn+HYFqqB61Hd5t6Cevk6ngYzjcDBON1erbuY7+7vhJNi0OBSE3JQg3jmWOymfspK+YLjAOJpTJbVdiSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mv65ICT0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728685723; x=1760221723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F6JLjXHUVVi0zfCY2Lznvqc4UtULEP3AD56INv2/5uE=;
  b=Mv65ICT03hyILWmyjb6W64mM3Uwkf9Y4aKWOVM4m5Ske95CtdtoCYrYf
   QLQTO4JHVqXFO86UDDAx8Mq+el0nPo2svVWltmQzDacVFIWNkZ/4LmIoj
   /wIMYBF0Ix+iXZiGoT+rmp3ToWE198XBplETRSb0NxCxYKcSYo884YczQ
   iiG7/IeJSZoqfDoB+fIZGYomERjX4HsBjK3zPc7fr3jAO8DrwsN06Wm6D
   rMhdOEgEMsyHN5Bw9qjNifIMztwXVKNJ74TD1Y+1768aENZa0ZV9NS4Oh
   OEnqNjNlqjsrdmetsqhABbcKhodj6mLL1OLMk/Ubzt4Cx5M6M015o8HhA
   w==;
X-CSE-ConnectionGUID: FlNrDwW/S2uKf8Fa1csv7w==
X-CSE-MsgGUID: HZ4W/WvnRdSxBwtwM4/9LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28204458"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="28204458"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 15:28:43 -0700
X-CSE-ConnectionGUID: OJuNjMN8T6639UQbmwL9KQ==
X-CSE-MsgGUID: rfbZGBtERMO3zZIl6bOTeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="77346538"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Oct 2024 15:28:41 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szO7j-000Cnn-0i;
	Fri, 11 Oct 2024 22:28:39 +0000
Date: Sat, 12 Oct 2024 06:28:24 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: ld.lld: error: unknown argument '-dp'
Message-ID: <202410120650.7F80VaWZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d227fcc72223cbdd34d0ce13541cbaab5e0d72f
commit: dd3a7ee91e0ce0b03d22e974a79e8247cc99959b hardening: Adjust dependencies in selection of MODVERSIONS
date:   13 days ago
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241012/202410120650.7F80VaWZ-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 70e0a7e7e6a8541bcc46908c592eed561850e416)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241012/202410120650.7F80VaWZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410120650.7F80VaWZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: unknown argument '-dp'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

