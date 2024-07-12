Return-Path: <linux-kernel+bounces-250037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B482092F351
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3621F22BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1C4683;
	Fri, 12 Jul 2024 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9/L16Gj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D154414
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746781; cv=none; b=RtnHrnV8qsBWsOpB8/KymMsgoLk8Bmtsjz9lagkyQbe8q6+/UG9mvewwfAdzwHpposgUUB1aRUrdDfpy0LLDDj4+kxW9NOFUgoPp+tNBGeD+uzLi+d+c/soX0lCG2knMdXNgNbuGPLZ5eGHNMCgyKokr9idFDOzKRB7uHzx9LxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746781; c=relaxed/simple;
	bh=9W3qMAABfCwDAOFwPbFbPgnwIBkxuhQAEZy6g1KB6vU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HNk53zzHKHka1THwqP9MTW9GGiVbjXGmfCV6Z6YXH6//9UgwEYqDxfnIP5FXKPnIaHcTGEW4GQAxmo74BtbU+kntVb2gMgqcBJlru9QWtS6pna2/JhiCLS+Fmo3+6GOwQD2Z47x2534d3EryHzNX/R2F6hxZXZzqKwOKXm7frhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9/L16Gj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720746780; x=1752282780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9W3qMAABfCwDAOFwPbFbPgnwIBkxuhQAEZy6g1KB6vU=;
  b=E9/L16GjJi0g8/5NRGEE2eeZh8nKv6VqbcDqWfxElCBsWmFKWy66poO3
   Ff91hPd0Ykk5d9Rxakj0Vul1vjoJ70kVXcc6DwbMF7K04x2BRGPyAlZVr
   VUJuwE4Qkcx/ZfBWNYHkFMLvlA+i4UFD2Tbn5MClUBVOaxICDKDzeGm/z
   KFMzMZP4aWLXAqLokB+CPtOVyQVQuAAXeBlJuMEH3QbAnpYNfQOsdnWze
   s51ckk0Xg54e++5PiGFRtALKUNub9BB/JihPLQuylTmcQ1HKJDYFe6IUo
   sx/622ExS/wnEPV7kbSjljh/QNkYEb4b7XbGHzPrYhSwAuwUz++6gX8ji
   w==;
X-CSE-ConnectionGUID: aUCV1cB0TeuQjiecjI+qiw==
X-CSE-MsgGUID: jk8uE/64S4avAMaFLj7KxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="29321571"
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="29321571"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 18:12:59 -0700
X-CSE-ConnectionGUID: Ap4Na5AXT62xayUqx+zsfA==
X-CSE-MsgGUID: kuJJVvpWTo+h0FQYNgYJQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,201,1716274800"; 
   d="scan'208";a="48829797"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 18:12:58 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sS4qG-000a9i-0t;
	Fri, 12 Jul 2024 01:12:56 +0000
Date: Fri, 12 Jul 2024 09:12:18 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/wfamnae-next20240710-cbc 13/13]
 ./usr/include/linux/usb/video.h:403:15: error: unknown type name 'offsetof'
Message-ID: <202407120926.PaHnpipg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/wfamnae-next20240710-cbc
head:   811bc7260e24cf06adefdbf8debb2a83d213e02d
commit: 73efb8d9b6a2ba4b07021861a1760ec742ddf432 [13/13] usb: video: Avoid -Wflex-array-member-not-at-end warning
config: i386-buildonly-randconfig-001-20240711 (https://download.01.org/0day-ci/archive/20240712/202407120926.PaHnpipg-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240712/202407120926.PaHnpipg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407120926.PaHnpipg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/usb/video.h:403:15: error: unknown type name 'offsetof'
     403 | static_assert(offsetof(struct uvc_input_header_descriptor, bmaControls) ==
         |               ^~~~~~~~
   ./usr/include/linux/usb/video.h:19:1: note: 'offsetof' is defined in header '<stddef.h>'; did you forget to '#include <stddef.h>'?
      18 | #include <linux/types.h>
     +++ |+#include <stddef.h>
      19 | 
>> ./usr/include/linux/usb/video.h:405:15: error: expected declaration specifiers or '...' before string constant
     405 |               "struct member outside of __struct_group()");
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

