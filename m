Return-Path: <linux-kernel+bounces-255267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFA5933E33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5819283DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580AB181323;
	Wed, 17 Jul 2024 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wlc8THT3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CE18130A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225538; cv=none; b=Uzzth1v/5wNLvo2K6zqGOtpOcgQGFubYPhJWGMBMx5c5TXztG8zKCu3Zuhp/eQGChNs4ud3f07O17Zozmqd45EWmY5X/J2Spqc7/NDEger2PG2j79mF3csu72clRBOmBFf65Ns+uanfrec44enpBt4vIRTJ0CBzj2TiQ9GtNvj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225538; c=relaxed/simple;
	bh=Q5MyQH+yVVxh76EUeQMGf6MQdvj13PRQid8x5Ji99cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bIroQHrsqr3kDAWR3Vm8FO3+ZPw/bjcDEspp31wdRZsZ3GguF3ogxFfUcjhvsEELaYtdAc5HzWWpbarmLqxo/aynzWUrOuYt07Rnj04pjIpopumL8Kl0X/jFzpAV+SZfLfuh47QBpDisKaTHl78juNF5I5UcfNYpbeQUSgUDcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wlc8THT3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721225537; x=1752761537;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q5MyQH+yVVxh76EUeQMGf6MQdvj13PRQid8x5Ji99cg=;
  b=Wlc8THT3TZcBoCFtzexlVebZeUWp4D71JcHV8VAbiN0zZYxTSwG1ZCIq
   zXjsURpkk0JZmhAdAc85kY7huQNLHpyl9chJq2er+AlyYpvLkX5ok62dQ
   y8s1PVSGknD+FjT0Bu5ynV1psHt9+jniB5/aA6FxX0G+CNR/a7uj0iPhv
   CdotIes+66ByVCofOTLT5Sp0CdIrthYN3HQiX6yBnHXL5hhPSMcjYDoaz
   bwZqjh26d7YTI6fPjCSHwNB5xp8efjCzBcZ389ApsE9IrJs1p2t2qIlF2
   qFbNgNxeGayXUU7fugk0UugKA/plbGMoV37D2hy2LrhePt2AoI1FxZMA8
   A==;
X-CSE-ConnectionGUID: 6G0+RoY/SUWl9dtnnuhibw==
X-CSE-MsgGUID: /pvyvRK+TSaUlwlYynE02g==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18869676"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="18869676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 07:12:16 -0700
X-CSE-ConnectionGUID: lMbBYjH4TESxk9XrMfQYWA==
X-CSE-MsgGUID: A0Db5CyKQJ2J6d9F7FAGaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="50460365"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Jul 2024 07:12:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sU5O8-000gNI-1g;
	Wed, 17 Jul 2024 14:12:12 +0000
Date: Wed, 17 Jul 2024 22:11:31 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc 13/13]
 ./usr/include/linux/usb/video.h:403:60: warning: type specifier missing,
 defaults to 'int'
Message-ID: <202407172246.JMnOxzX5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
head:   e3597892cb471e5732700d17c2cca098f3148759
commit: 73efb8d9b6a2ba4b07021861a1760ec742ddf432 [13/13] usb: video: Avoid -Wflex-array-member-not-at-end warning
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240717/202407172246.JMnOxzX5-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240717/202407172246.JMnOxzX5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407172246.JMnOxzX5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/linux/usb/video.h:403:60: warning: type specifier missing, defaults to 'int' [-Wimplicit-int]
     403 | static_assert(offsetof(struct uvc_input_header_descriptor, bmaControls) ==
         |                                                            ^
         |                                                            int
   ./usr/include/linux/usb/video.h:403:15: warning: type specifier missing, defaults to 'int' [-Wimplicit-int]
     403 | static_assert(offsetof(struct uvc_input_header_descriptor, bmaControls) ==
         |               ^
         |               int
   ./usr/include/linux/usb/video.h:403:73: error: expected ')'
     403 | static_assert(offsetof(struct uvc_input_header_descriptor, bmaControls) ==
         |                                                                         ^
   ./usr/include/linux/usb/video.h:403:14: note: to match this '('
     403 | static_assert(offsetof(struct uvc_input_header_descriptor, bmaControls) ==
         |              ^
   ./usr/include/linux/usb/video.h:403:1: warning: type specifier missing, defaults to 'int' [-Wimplicit-int]
     403 | static_assert(offsetof(struct uvc_input_header_descriptor, bmaControls) ==
         | ^
         | int
   3 warnings and 1 error generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

