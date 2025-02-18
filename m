Return-Path: <linux-kernel+bounces-519243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A6A399C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB643A6CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B9239563;
	Tue, 18 Feb 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9wXWx9N"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990B8239070
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876240; cv=none; b=WVuy26qeXUomhiCz05rZJvrJMzyEkX93SLEmthKUCj37jrvxl0yb4j0XRQZ6cbIM9N2t52YyiFMqR++jXjiWPCMSSHXT43nLzXnX17qXDS1oP9n7QDP8cDy9q5sDtE5X1c2f30r2mm/10NQxzuMGqkQvBVko9mF8h1GaGG4qxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876240; c=relaxed/simple;
	bh=LubX0t00PQZ2oEXPO0X6RXTaLNq7dbPQv2kl6z90L44=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TUbuIrO5xpih65iOYRHrgUXlzSFHvFhGx6GmsuYXoZX+slH9FVfvqU+Pe4ZcBENWZk8MH4SCcu0NJjVmdUhlwfzwQONhgMBy4103+OzuTeGESScmXNVLXZmw46gVw4/roRGhdmRxcoD0f73WGIEsdtekBOAr/7D3DbKdbn1KMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9wXWx9N; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739876239; x=1771412239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LubX0t00PQZ2oEXPO0X6RXTaLNq7dbPQv2kl6z90L44=;
  b=H9wXWx9NkrmMjMwy0+FaFmGB+JWCRZy0u0zL8fXadGEGO3FXTZSufRrm
   4VhxuOLlWlnqGWQy5k2b5CiMQTCR7HbUtJ/EKMBq+C2PrPHgvsi8iLcl3
   v4WCqK4BfXLAite84vIUurE/16unM2bjkG8kdnPw4fq/2D728K56fXc/F
   oRUO7J0/ux6T4Q5/XT8mB/AeLhvn6PmKdMJR0RfT7BMjPN2eKVODdu3/+
   Fw8bBJ2WZP4vtsDGX5k7H8DoD4EnhkVG30R7CgvfR7VbZKmEp8IF158ex
   k+DmWmkilb6soM6+h/D2TGqNs7zdtNBkP2c64I0N6dm0Okg6emAkllkvu
   Q==;
X-CSE-ConnectionGUID: rrjzttH0TOiOiw4aWBu0iw==
X-CSE-MsgGUID: 6hOOy6c2QZSSDiYU/IjAlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40271251"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="40271251"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 02:57:18 -0800
X-CSE-ConnectionGUID: oYdwd7vTQ2OOgWKLc2logQ==
X-CSE-MsgGUID: UkuJdeyrREK5cjP4SJ+Hxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="137603166"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 18 Feb 2025 02:57:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkLFp-0000Qx-10;
	Tue, 18 Feb 2025 10:55:52 +0000
Date: Tue, 18 Feb 2025 18:54:23 +0800
From: kernel test robot <lkp@intel.com>
To: Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>
Subject: drivers/leds/leds-st1202.c:194:66-71: WARNING: conversion to bool
 not needed here
Message-ID: <202502181845.xESVrC61-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2408a807bfc3f738850ef5ad5e3fd59d66168996
commit: 939757aafeb9c266dda37657ee5f7a73ffd35ae2 leds: Add LED1202 I2C driver
date:   6 weeks ago
config: x86_64-randconfig-103-20250218 (https://download.01.org/0day-ci/archive/20250218/202502181845.xESVrC61-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502181845.xESVrC61-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/leds/leds-st1202.c:194:66-71: WARNING: conversion to bool not needed here

vim +194 drivers/leds/leds-st1202.c

   188	
   189	static int st1202_led_set(struct led_classdev *ldev, enum led_brightness value)
   190	{
   191		struct st1202_led *led = cdev_to_st1202_led(ldev);
   192		struct st1202_chip *chip = led->chip;
   193	
 > 194		return st1202_channel_set(chip, led->led_num, value == LED_OFF ? false : true);
   195	}
   196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

