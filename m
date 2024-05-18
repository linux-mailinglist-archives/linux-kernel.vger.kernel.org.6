Return-Path: <linux-kernel+bounces-182892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDCB8C9168
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBE41C20BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 14:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6FC3D97A;
	Sat, 18 May 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvkT8kzk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C551DA32
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716041422; cv=none; b=jnQ2iE97veFy9l36MeCySFGMNnwGbK16sjNb15gV/uxRxgqZepdZtrfaSPu+SQT5o9nm5F+uDCTMImQWnFJ7HvrBszvNKFOubSixawDMi7IEagVAlnwvdpXgg8EKI7UbbZ+R14bk6mJNiPB5881Ph3Tju0BT/JepPbadwmlpaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716041422; c=relaxed/simple;
	bh=yLD0OsCbkI+YpiMeqRS7gCN0eyJxc/7jSzSTKOnaQHA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RTni7c9OA+QqiXcgUTp3JqXo8UidBI1Re8nTGi3RT9Hr3QqDaULDhsBiIooVBVwsSHPtSeb0vk0H65ETJdHKzgATasnQ9L8HwxM5i5TH5N5jK8ZGwuzs5Ig2d/Hw4wU/0Fln3dYCZ+hCnv0ArsnFjnLRiQZV7z/jI1H+/TGadvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvkT8kzk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716041420; x=1747577420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yLD0OsCbkI+YpiMeqRS7gCN0eyJxc/7jSzSTKOnaQHA=;
  b=TvkT8kzkIlkc7irBiMtCeVl/UoqTdjAIIe1cNB0FGRnxv6wmBqC7IhY6
   V1OVTFP6xS416qt+tzkt4XvafqlFnqJADQVLdsL1FRu7w+DRf7ug+5Kx3
   9FOtY//gZ2s8lHX38b7QaKObcjFd0X3xC9Zv13A9ULMhyrDZcbLHg86Xd
   +so/ceJz6ZDusRlHkhN8COSBjWnd4r0R5QOqS8X4Vw6S3mAiF97lU2Y6X
   HDQHI30G6Sd2PeEV7xAGCCioDYAI60UZrg5tDdhzi6AJDf3Vk4O31wvvC
   CjEZefHDBURm3LY4CMsJklyy9TmyE/aEQ6b0TKdTX8ckOWXOv+FOvnOn8
   Q==;
X-CSE-ConnectionGUID: MPfHUr6JSHKEifCv45/GxA==
X-CSE-MsgGUID: YfRtxouZQKKN7YWAZXZPEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12330032"
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="12330032"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 07:10:19 -0700
X-CSE-ConnectionGUID: QUYvhp+OQqqsGoUP7dutDA==
X-CSE-MsgGUID: smuNWGKESFKrRURpUJwTIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,171,1712646000"; 
   d="scan'208";a="55298246"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 May 2024 07:10:18 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s8KlM-0002GD-14;
	Sat, 18 May 2024 14:10:16 +0000
Date: Sat, 18 May 2024 22:09:44 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: other.c:undefined reference to `devm_led_classdev_register_ext'
Message-ID: <202405182256.FsKBjIzG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b377b4868ef17b040065bd468668c707d2477a5
commit: 9426adb0326a87ed2fa9d010c4c18189047e0c11 platform/x86: x86-android-tablets: Create LED device for Xiaomi Pad 2 bottom bezel touch buttons
date:   4 days ago
config: i386-buildonly-randconfig-004-20240118 (https://download.01.org/0day-ci/archive/20240518/202405182256.FsKBjIzG-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240518/202405182256.FsKBjIzG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405182256.FsKBjIzG-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/platform/x86/x86-android-tablets/other.o: in function `xiaomi_mipad2_init':
>> other.c:(.init.text+0x97): undefined reference to `devm_led_classdev_register_ext'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

