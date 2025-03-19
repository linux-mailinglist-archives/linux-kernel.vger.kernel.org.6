Return-Path: <linux-kernel+bounces-568061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DE0A68DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49EEF1888ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164002561D8;
	Wed, 19 Mar 2025 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OhjMfts0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C352528F1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742390412; cv=none; b=Te/0BLFqf3DZW5KGbOIczR2tM2j0Lut2GFJUVMoxKJgqrRHw6bqk17glmVFG9yaoY51O2dDYjA3GjSqgARry10j4v4/wfYG2QiRxaj7lBh6D+kK0n55oUQNm2qmTkfDJIipI+QbG6/DIMPxoMd2vNAeFTqb9DDq5tWMuj3LTH04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742390412; c=relaxed/simple;
	bh=csDtD+S612wZH5ir8CRxqrH2IyiTpQU+1Qwx8eO6q5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m/3ahuJ5OAH60t1yMqrsCF5KSeZ7q2hOmhHpNh0tW140eDQryUlDL2BOakmsbQtsM9FaljO0GsmrUwABrybSHvYqM75QMQEVmmwEv7FMKgDN7kQePHbJqsLBn6b3HXLK8CCZ8EBZbrTHvxAuLEd+1wpn6gblIgXIh0s3XWg7ldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OhjMfts0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742390411; x=1773926411;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=csDtD+S612wZH5ir8CRxqrH2IyiTpQU+1Qwx8eO6q5I=;
  b=OhjMfts0IslxZBveGcZi69y/IwkJE29Op0uWqhKzzvbjtgCYXgMxkJrQ
   eFPy/v97cGgsnAGoksJcj8b4MDVNIUPeoSsqYLhofXfRjsiGZgr4roE+v
   UmBzG/K8S66Hoku2sfKaY+MQ2e/fgFTgFUp8G9RXDi0BOK58wK9u9hl0T
   1MVXsYyzjuII5jqNsVgH/7o8x3cmq8tJfQvEPeRZ+J7xCXUV7gINpkaK5
   zr2wQVY+dSInQUpRC+0CCZFekwMKFdMUcop9Y5y6ARLC3fqOEaunhxiiX
   4BeMV/geZI93RZuOLUQkauEBlp3nZQc8mb8AahjMxx4cX1gur8QE2syI3
   A==;
X-CSE-ConnectionGUID: MCkBfY4MTH6g2GDpat7QJQ==
X-CSE-MsgGUID: mA1pKfdtQEGSc4AsLyI9Ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="31157603"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="31157603"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 06:20:07 -0700
X-CSE-ConnectionGUID: ERYdeZbPQoOcDdzTGFZlDQ==
X-CSE-MsgGUID: c/Y4WQfRT3eUVUPoG2sfFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127693359"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 Mar 2025 06:20:05 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tutL0-000Egm-2o;
	Wed, 19 Mar 2025 13:20:02 +0000
Date: Wed, 19 Mar 2025 21:19:10 +0800
From: kernel test robot <lkp@intel.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: atags_to_fdt.c:undefined reference to `stackleak_track_stack'
Message-ID: <202503192111.5qN6JR9O-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   81e4f8d68c66da301bb881862735bd74c6241a19
commit: 2335c9cb831faba1a4efcc612886073b6f175fe4 ARM: 9407/1: Add support for STACKLEAK gcc plugin
date:   9 months ago
config: arm-randconfig-r054-20250319 (https://download.01.org/0day-ci/archive/20250319/202503192111.5qN6JR9O-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192111.5qN6JR9O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192111.5qN6JR9O-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/boot/compressed/atags_to_fdt.o: in function `atags_to_fdt':
>> atags_to_fdt.c:(.text+0x9c): undefined reference to `stackleak_track_stack'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

