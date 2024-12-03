Return-Path: <linux-kernel+bounces-429394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F59E1B76
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0027D28498B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821241E47C6;
	Tue,  3 Dec 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzmmbIgF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4BA3398B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227062; cv=none; b=Xax5NVXTIrJjIt3SiXhq3dp7SzC2TAEL7g2fSgIlegQPXph15Gin6hDbG7vLlVw+nPK8zMXJDITkV/sZqHy2bpQrGWLXcr/lArGIshOAR+fEOpwQbpEKeFIpB8HRLwjlUNCr53JC+s7GIi7134y3hhLpsQ6En3I6cJVp2N7Pcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227062; c=relaxed/simple;
	bh=oa7CXms/GKV1T8t5geonI6cFVukCSbJ2eR6wh9IzpCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DKhwpqyh4PENnug1dUWTYL5bN9GKTEByHHdHQlC4y2K35qJrfHp65aTRdr22hQQba4tmCvz5IukM/q/cPntlzOGCyPWf/FZDRHV1kohmhab6lnZblNNghJ60/qGi1yGArFZ/ZtWQofNcii5DDwvwLFtlTK2F0Hy3pe7mSaAHKM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzmmbIgF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733227061; x=1764763061;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oa7CXms/GKV1T8t5geonI6cFVukCSbJ2eR6wh9IzpCg=;
  b=WzmmbIgFMj8KZQ2IUnOgKfpHJAji9djlEHVOGCBTRZ8ochzpsqUOGgg+
   w3p0njuEBjTCj7AtO6T/u8bv0N7NiXH/lZSuF8ncSxErlTvw3TORE0NDU
   OknHceWlqDAZJJEhA9hnvyZHizVzu7fd5XsvP85q4rEu1koLEqDddiTbF
   WOJ2SMmMzIFIZc986dONTG4ju3+ad8Y/JrkPl6UbQq2FcB1ek31tGm2rq
   jjVI9kLkpE+qiCmC0KBMW6SYdkyGfJ1Arn0n5dl589vKeguCykPXPPpzL
   VVMISh5XKuvzTCWAFVEQrtm+aMxE5rErSEbzqtUN4p+eTs+8ENy3Jz3Qu
   w==;
X-CSE-ConnectionGUID: iU1rMEIpQgiyFC5dgpbWsA==
X-CSE-MsgGUID: lqCV6T1OSmmwNET7wC5Qlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33359529"
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="33359529"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 03:57:40 -0800
X-CSE-ConnectionGUID: uO7NnBIvQvGRA6rM/vXAPg==
X-CSE-MsgGUID: PoP9TxhKRp6CQ9QgVRqKqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,205,1728975600"; 
   d="scan'208";a="97488314"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Dec 2024 03:57:39 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIRX7-0000cl-05;
	Tue, 03 Dec 2024 11:57:37 +0000
Date: Tue, 3 Dec 2024 19:57:20 +0800
From: kernel test robot <lkp@intel.com>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Gwendal Grignou <gwendal@chromium.org>
Subject: drivers/power/supply/cros_usbpd-charger.c:15:49: warning: '%d'
 directive writing between 1 and 11 bytes into a region of size 5
Message-ID: <202412031910.gddwrzU5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 47f11e0b40e97f373da4efbacee0a9526c816ed5 mfd / platform: cros_ec: Move cros-ec core driver out from MFD
date:   5 years ago
config: arm64-randconfig-004-20240106 (https://download.01.org/0day-ci/archive/20241203/202412031910.gddwrzU5-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031910.gddwrzU5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031910.gddwrzU5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/power/supply/cros_usbpd-charger.c: In function 'cros_usbpd_charger_probe':
>> drivers/power/supply/cros_usbpd-charger.c:15:49: warning: '%d' directive writing between 1 and 11 bytes into a region of size 5 [-Wformat-overflow=]
      15 | #define CHARGER_USBPD_DIR_NAME                  "CROS_USBPD_CHARGER%d"
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/cros_usbpd-charger.c:656:45: note: in expansion of macro 'CHARGER_USBPD_DIR_NAME'
     656 |                         sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/cros_usbpd-charger.c:15:68: note: format string is defined here
      15 | #define CHARGER_USBPD_DIR_NAME                  "CROS_USBPD_CHARGER%d"
         |                                                                    ^~
   drivers/power/supply/cros_usbpd-charger.c:15:49: note: directive argument in the range [-2147483641, 2147483646]
      15 | #define CHARGER_USBPD_DIR_NAME                  "CROS_USBPD_CHARGER%d"
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/cros_usbpd-charger.c:656:45: note: in expansion of macro 'CHARGER_USBPD_DIR_NAME'
     656 |                         sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
         |                                             ^~~~~~~~~~~~~~~~~~~~~~
   drivers/power/supply/cros_usbpd-charger.c:656:25: note: 'sprintf' output between 20 and 30 bytes into a destination of size 23
     656 |                         sprintf(port->name, CHARGER_USBPD_DIR_NAME, i);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +15 drivers/power/supply/cros_usbpd-charger.c

f68b883e8fad23 Sameer Nanda  2018-05-02  14  
3af15cfacd1eef Fabien Parent 2018-08-10 @15  #define CHARGER_USBPD_DIR_NAME			"CROS_USBPD_CHARGER%d"
3af15cfacd1eef Fabien Parent 2018-08-10  16  #define CHARGER_DEDICATED_DIR_NAME		"CROS_DEDICATED_CHARGER"
3af15cfacd1eef Fabien Parent 2018-08-10  17  #define CHARGER_DIR_NAME_LENGTH		(sizeof(CHARGER_USBPD_DIR_NAME) >= \
3af15cfacd1eef Fabien Parent 2018-08-10  18  					 sizeof(CHARGER_DEDICATED_DIR_NAME) ? \
3af15cfacd1eef Fabien Parent 2018-08-10  19  					 sizeof(CHARGER_USBPD_DIR_NAME) : \
3af15cfacd1eef Fabien Parent 2018-08-10  20  					 sizeof(CHARGER_DEDICATED_DIR_NAME))
f68b883e8fad23 Sameer Nanda  2018-05-02  21  #define CHARGER_CACHE_UPDATE_DELAY		msecs_to_jiffies(500)
f68b883e8fad23 Sameer Nanda  2018-05-02  22  #define CHARGER_MANUFACTURER_MODEL_LENGTH	32
f68b883e8fad23 Sameer Nanda  2018-05-02  23  

:::::: The code at line 15 was first introduced by commit
:::::: 3af15cfacd1eef7f223802d49a88cae23c509183 power: supply: cros: add support for dedicated port

:::::: TO: Fabien Parent <fparent@baylibre.com>
:::::: CC: Sebastian Reichel <sre@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

