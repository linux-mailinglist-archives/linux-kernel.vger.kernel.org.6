Return-Path: <linux-kernel+bounces-173726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5278C04A0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE6D1C217BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20912FF99;
	Wed,  8 May 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kPsPc8pn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF8612B148
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194159; cv=none; b=nCpnqbdSysknA2dfnv1QbzwIMTx2e2bkYvY2+vr5GZm6+e5yD8rHwqZPYtpsCYlXQ4bORNTCMLdz10aWCGh5erReI6d8EpQvPS2HuYPjCo72V8XZA8vqJuc8+ux/z+BWLTXn0O00UzTiTZp7SZBXGz+aa3Rd/q4lFqYcpOOgG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194159; c=relaxed/simple;
	bh=/hfXqf+HTt4Bem0bq2/vnuIng70k8rV4Ap+IFcrwpdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ao+BSg+YoNk6f3gZk3pIxdODMDnQs2064M8rDyVdCO5jUMP69QR565OH2Wy5Otj5WM7L/6piuRHWnZ0H7SBe2FQuZTV40mVtlAHeb3Kv03jsKcdwMRJkoEkp8B248e+DLoFekgW++po6owsiLWPeJJhaHbvrIqlLoxzEuY8lvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kPsPc8pn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194158; x=1746730158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/hfXqf+HTt4Bem0bq2/vnuIng70k8rV4Ap+IFcrwpdo=;
  b=kPsPc8pnKDNcROGB4EeI7P6fPtfNJCe8H9XWWbbdC5hhw39PYmsS1ffn
   T79Ky2RnBCtpawdC/EugXhg7xDxKF7DhaUTi/AUY7Rc6UCgb3bY4re3iz
   9wpo8GIr9mhRknZ79h2GEf5UiyG48xlAF3uM8DkD3Ev2lKrqHWDxeyqSG
   VKvpv9ji5ReexZo4pe86/Ux4xv8dc3sNdiTEL8LShjRS7IGScu7Uw4GQL
   DEb2Wr+yUOhS+IoaQFmNbuZ4+W4FDHRLcsc9+S1F2RLW3rJF+L+3roxAf
   4tlIe7Gb1fSxhI80gICKuqwGg72le64CLAmKDQLdL0dT7zxgBaHHfYN4+
   g==;
X-CSE-ConnectionGUID: N38XWADaTyuSB3MXm0Mn5g==
X-CSE-MsgGUID: Acrpgi0tQXmnC5BvImCIfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591013"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591013"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:15 -0700
X-CSE-ConnectionGUID: 51HvJbAaRAmhbNeRbyd90Q==
X-CSE-MsgGUID: xPmDBIqqTLGq48gGU2AIsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024948"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 708E4109; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 00/10] misc: eeprom_93xx46: Get rid of legacy GPIO APIs
Date: Wed,  8 May 2024 21:46:53 +0300
Message-ID: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver and its solely consumer (via platform data) are using old
GPIO APIs, convert them for good. On top some spring cleanups and fixes.

Andy Shevchenko (10):
  misc: eeprom_93xx46: Make use of device properties
  eeprom: digsy_mtc: Fix 93xx46 driver probe failure
  eeprom: digsy_mtc: Convert to use GPIO descriptors
  misc: eeprom_93xx46: Hide legacy platform data in the driver
  misc: eeprom_93xx46: Remove ->prepare() and ->finish() customisation
  misc: eeprom_93xx46: Use spi_message_init_with_transfers()
  misc: eeprom_93xx46: Convert to use kstrtox()
  misc: eeprom_93xx46: Replace explicit castings with proper specifiers
  misc: eeprom_93xx46: Use string_choices API instead of ternary
    operator
  misc: eeprom_93xx46: Convert to DEVICE_ATTR_WO()

 drivers/misc/eeprom/digsy_mtc_eeprom.c |  46 +++----
 drivers/misc/eeprom/eeprom_93xx46.c    | 178 ++++++++++++-------------
 include/linux/eeprom_93xx46.h          |  32 -----
 3 files changed, 102 insertions(+), 154 deletions(-)
 delete mode 100644 include/linux/eeprom_93xx46.h

-- 
2.43.0.rc1.1336.g36b5255a03ac


