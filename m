Return-Path: <linux-kernel+bounces-512894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADBFA33EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC373A88F3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B68221559;
	Thu, 13 Feb 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJgxN7Dy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84968227EB4;
	Thu, 13 Feb 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449022; cv=none; b=aQMMWjFUcRpgRAPppAJuTV+jhd0D8vBq6lf04SlFxIMm591/ZZwz45avB8tNhSdBbQVmedjVH4Gy7AKO8ekLOBN7UbNLb4pEe3WY5+NtEFHzqibdo+2mOyfK/CjX75UOgTM9O9VytVdVqvb+GfL4j62C4DZNjLAz9I+XyKFTSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449022; c=relaxed/simple;
	bh=PLI4dCWIwEmcxYIFTmNuux/2FCidmxwYyPrRcIjMlZg=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=fJD3NeFPIDqWh6ceCf9oahY77L7mPiuBT7+sjNZB2MRKq5S9m+jrPSdgUdpHrCt6GfxpcJMGVtZThK4ACk8bU3qraMH5Lpf9Tg887yEzf3DCsR3gqOOKP7JEVmj05/KNcq+qS5kLsD5J1H3SqHJHx7D9AlharES3VcUF9SoLHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJgxN7Dy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739449020; x=1770985020;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PLI4dCWIwEmcxYIFTmNuux/2FCidmxwYyPrRcIjMlZg=;
  b=OJgxN7DyX9PsuE2nFLZJWuvuyN5OAgYDQrZ58N5Bjhm2vZYni6TDW4rl
   iHF+daG662SVhANbt3i9ZyzE6wuMdUgf/TghqttLGuOXXnhmjyRss64Ae
   Zr6XLY43bPO4W7k+zvgmYHmNH6zJO7SusZdklH/NDda8ByQv2kgyj8nmP
   kXqQSrnO7NTYslj4eB10huOGeZMtYDSkLLLsGWxXsSNdNrjHJfgzq9zis
   6L4REUBwlVQbAYmMGZ6rvUR7PiaMUFmoW2beE0PzofZVpWLEXC+SK3GnK
   swGtM5ZxD/xVAwb7A+I3E8/JdkdDYyoc8UT2rEcQbW7+vR7fqe1h11yGk
   Q==;
X-CSE-ConnectionGUID: doN4rek1RK+23gPPHNsREQ==
X-CSE-MsgGUID: 2OruXDcYQ7Ww3aBRMQv+bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="42983664"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="42983664"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:16:59 -0800
X-CSE-ConnectionGUID: Z9dpytLfRxO+JwlXHozSQw==
X-CSE-MsgGUID: RovsuE5kSF2RNqWsxCMhgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="112994338"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:16:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Thu, 13 Feb 2025 14:14:23 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.14-3
Message-ID: <pdx86-pr-20250213141423-15116495@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.14.

Fixes and new HW support:

 - thinkpad_acpi:

     - Fix registration of tpacpi platform driver

     - Support fan speed in ticks per revolution (Thinkpad X120e)

     - Support V9 DYTC profiles (new Thinkpad AMD platforms)

 - int3472: Handle GPIO "enable" vs "reset" variation (ov7251)

Regards, i.


The following changes since commit a787ab73e2e43c0a3df10bc8d9b9b7a679129d49:

  platform/x86/intel/ifs: Update documentation with image download path (2025-02-04 10:00:45 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-3

for you to fetch changes up to b3e127dacad60a384c92baafdc74f1508bf7dd47:

  platform/x86: thinkpad_acpi: Fix registration of tpacpi platform driver (2025-02-12 13:49:37 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.14-3

Fixes and new HW support:

 - thinkpad_acpi:

     - Fix registration of tpacpi platform driver

     - Support fan speed in ticks per revolution (Thinkpad X120e)

     - Support V9 DYTC profiles (new Thinkpad AMD platforms)

 - int3472: Handle GPIO "enable" vs "reset" variation (ov7251)

The following is an automated shortlog grouped by driver:

int3472:
 -  Call "reset" GPIO "enable" for INT347E
 -  Use correct type for "polarity", call it gpio_flags

thinkpad_acpi:
 -  Fix invalid fan speed on ThinkPad X120e
 -  Fix registration of tpacpi platform driver
 -  Support for V9 DYTC platform profiles

----------------------------------------------------------------
Mark Pearson (2):
      platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles
      platform/x86: thinkpad_acpi: Fix registration of tpacpi platform driver

Sakari Ailus (2):
      platform/x86: int3472: Use correct type for "polarity", call it gpio_flags
      platform/x86: int3472: Call "reset" GPIO "enable" for INT347E

Sybil Isabel Dorsett (1):
      platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e

 drivers/platform/x86/intel/int3472/discrete.c | 85 ++++++++++++++++++++-------
 drivers/platform/x86/thinkpad_acpi.c          | 61 ++++++++++++++-----
 2 files changed, 110 insertions(+), 36 deletions(-)

