Return-Path: <linux-kernel+bounces-550817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEDDA5647D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2BD3B00DD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1614020CCCA;
	Fri,  7 Mar 2025 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+Z6jvjV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F320CCD3;
	Fri,  7 Mar 2025 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341616; cv=none; b=CggCDNyyn/aVEx5rjRv2rB5cW8JJf3bDSiWTRItUUfoIkdtQC6BhtvGkRz+oAFjnlYNnIzS+9dNz7/3xuEA3ExaEeM0DusQjhgosXHDsPKjNQtt7YqrohoPJ87cY0025HGZ9iWIylf4YFKWwUHUNNC326N7rSosTjSy+fjC24U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341616; c=relaxed/simple;
	bh=mOFf7JEY2xGc/lYu7abXxp5IEcE/c+c1U8ngnx9z+Bs=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=BnRr3pQZiUYrxyit0NJGtSUyaKBY2kkidtp+NFn3BhYvDi13nJuLonWHbjCKEq4Knwc4dxBqki6uJTWQhEyOGnqqqqKdMuuEItp/Rqs6bc2/tO9kUcF9VTLqXcPHOb3NSRpnaa+XG5+pzs8iqAanWWZv3AmHuh3RsUDTYMAcNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+Z6jvjV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741341615; x=1772877615;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mOFf7JEY2xGc/lYu7abXxp5IEcE/c+c1U8ngnx9z+Bs=;
  b=T+Z6jvjVdAh5tcK4i/u0WJqMbZ9yJ1irssypIix0/rX9vWI/gEfW5bdA
   KbCK1OSuARLjdYH7XhMikGvXMTTvlkkT1c1Q71mOwdSN8MMUhj34HsyK4
   xS8I0mZPFJ54vR0dfYs4Xgr/5/zN7HHXb/DyjXV7xw52pTUESlhCvRoLK
   GyYHYhED1JojpruCBMidCVKB9+GOcX/peRjdqluNWohrAsqBrRRKY38X5
   ewas1DGq+sMazwVLyp7KXiSS5h+zntMJxvGr9ufuDO+MXljvSsoAYMZ+M
   SsQywmLRkrYYgmZYDrNWQpQvfMaYpKgNmYPCsdyZ+aXMf8NSoHldoLnpy
   w==;
X-CSE-ConnectionGUID: mlFbde8ATBGUkcdcNzIONg==
X-CSE-MsgGUID: zweZwJxjQ3W1bo4YTs/jHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="46163495"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="46163495"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:00:15 -0800
X-CSE-ConnectionGUID: X6LSaZ3tTBGqh2x4tXsqpw==
X-CSE-MsgGUID: Te3pCXqERG2YBqfFWtS5kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124374586"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:00:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 07 Mar 2025 11:58:21 +0200
Subject: [GIT PULL] platform-drivers-x86 for v6.14-4
Message-ID: <pdx86-pr-20250307115821-1780710253@linux.intel.com>
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

 - amd/pmf:

     - Initialize 'cb_mutex'

     - Support for new version of PMF-TA

 - intel-hid: Fix volume buttons on Microsoft Surface Go 4 tablet

 - intel/vsec: Add Diamond Rapids support

 - thinkpad_acpi: Add battery quirk for ThinkPad X131e

Regards, i.


The following changes since commit b3e127dacad60a384c92baafdc74f1508bf7dd47:

  platform/x86: thinkpad_acpi: Fix registration of tpacpi platform driver (2025-02-12 13:49:37 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.14-4

for you to fetch changes up to 376a8c2a144397d9cf2a67d403dd64f4a7ff9104:

  platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA (2025-03-05 13:33:42 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v6.14-4

Fixes and new HW support:

 - amd/pmf:

     - Initialize 'cb_mutex'

     - Support for new version of PMF-TA

 - intel-hid: Fix volume buttons on Microsoft Surface Go 4 tablet

 - intel/vsec: Add Diamond Rapids support

 - thinkpad_acpi: Add battery quirk for ThinkPad X131e

The following is an automated shortlog grouped by driver:

amd/pmf:
 -  Initialize and clean up `cb_mutex`
 -  Propagate PMF-TA return codes
 -  Update PMF Driver for Compatibility with new PMF-TA

intel-hid:
 -  fix volume buttons on Microsoft Surface Go 4 tablet

intel/vsec:
 -  Add Diamond Rapids support

thinkpad_acpi:
 -  Add battery quirk for ThinkPad X131e

----------------------------------------------------------------
David E. Box (1):
      platform/x86/intel/vsec: Add Diamond Rapids support

Dmitry Panchenko (1):
      platform/x86: intel-hid: fix volume buttons on Microsoft Surface Go 4 tablet

Mario Limonciello (1):
      platform/x86/amd/pmf: Initialize and clean up `cb_mutex`

Mingcong Bai (1):
      platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Propagate PMF-TA return codes
      platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PMF-TA

 drivers/platform/x86/amd/pmf/core.c   |  2 ++
 drivers/platform/x86/amd/pmf/pmf.h    |  5 +++-
 drivers/platform/x86/amd/pmf/tee-if.c | 52 +++++++++++++++++++++++++----------
 drivers/platform/x86/intel/hid.c      |  7 +++++
 drivers/platform/x86/intel/vsec.c     |  7 +++++
 drivers/platform/x86/thinkpad_acpi.c  |  1 +
 6 files changed, 58 insertions(+), 16 deletions(-)

