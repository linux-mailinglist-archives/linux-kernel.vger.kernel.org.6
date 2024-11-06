Return-Path: <linux-kernel+bounces-398126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC809BE5D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727FD1F21547
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5231DED76;
	Wed,  6 Nov 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ERMWO/4g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039957333
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730893450; cv=none; b=jZqYTjW/eqIF1Y2KjylobEIitOeoHtTNMjtBjKn6FgdJ2xlwKBhRrgJB2mhZWS0aFRM1/Pf92qTHTz7Zr2fgb2ftEAZWCygC6HtMKRIlWO4fVE+MJbupGl9QWnsb0fMDLJt44rLRHRi0bTR9oYY4nb2D2ilACxymUW4dotZxPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730893450; c=relaxed/simple;
	bh=4TxdLOMe7YjIIYFFusZngVbuFO/o9a6sr+thsWPcBSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E72cG+QSrQw8GGIlkkiamcC9Hw+w8NaTosi/CWGaZ5wl5mvev3vOoHvDMnv/ZkGkDvPPsPDl8YDMgqrVqDaLwsNSdE84tKo/cswiV/HgBTL7nUW+oPhPo9y8yS3F26jY/cMpAALhFc2FI8FoJjEFoyPQ+1i0aoqKlgjf//1VdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ERMWO/4g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730893449; x=1762429449;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4TxdLOMe7YjIIYFFusZngVbuFO/o9a6sr+thsWPcBSw=;
  b=ERMWO/4g8AKmwPNtZSnw7XsJH/WSLPPt3xA2SKJTbOKvYscmav7PxG+3
   haNF1scfpZUHSs6+zr2004I+W4RJ5h3kF8ThBSwMR6wPZK9cC6WuKkgQ7
   I4oTxF1ZB4KjPnNSP4k6q9FPA0ngDjNFPzU+acmbMzngXuR2unD2bK7uT
   0RkqOaGFxkqQgbc6gZIwqbHJQwBBKR+lkN/rMVhVt8+v4hv4DI6DWg0mC
   N0YaNjcejLX96wxgtwnfXUo8FPN4+ET/exggsasvRQ5rnR1gkH/LJmbkk
   x6byDcoa2Zrfputnai60BSrMJfCUBbd3OzreYkxC3y07IPVimbAhB5Juq
   A==;
X-CSE-ConnectionGUID: mlTzul8tTW2xQrd28C8lfA==
X-CSE-MsgGUID: VOdA+dutQLGi2ZS3X2MK/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30540442"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30540442"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 03:44:08 -0800
X-CSE-ConnectionGUID: nCOHqIWGR4+VvcIovipxdA==
X-CSE-MsgGUID: AKe41/oMT1OGhJevKVcYEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="89349774"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 03:44:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C2557A4B; Wed, 06 Nov 2024 13:44:05 +0200 (EET)
Date: Wed, 6 Nov 2024 13:44:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] auxdisplay for 6.13-1
Message-ID: <ZytWhTAeAIrzEyb9@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Hi Linus,

New cycle new tiny update to auxdisplay subsystem. The changes were
a few weeks in Linux Next without reported problems. Please, apply
to v6.13-rc1 (or to current cycle if you want, there shouldn't be
any dependencies or conflicts),

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.13-1

for you to fetch changes up to 0b028ff7e70ecbe5240ad92e36a664af5cf7f382:

  auxdisplay: Remove unused functions (2024-10-08 20:48:18 +0300)

----------------------------------------------------------------
auxdisplay for v6.13-1

 * Move Holtek 16k33 driver to use agnostic i2c_get_match_data()
 * Miscellaneuous cleanups

The following is an automated git shortlog grouped by driver:

cfag12864b:
 - Remove unused functions

ht16k33:
 - Make use of i2c_get_match_data()
 - Drop explicit initialization of struct i2c_device_id::driver_data to 0

lcd2s:
 - Drop explicit initialization of struct i2c_device_id::driver_data to 0

----------------------------------------------------------------
Andy Shevchenko (1):
      auxdisplay: ht16k33: Make use of i2c_get_match_data()

Dr. David Alan Gilbert (1):
      auxdisplay: Remove unused functions

Uwe Kleine-König (1):
      auxdisplay: Drop explicit initialization of struct i2c_device_id::driver_data to 0

 drivers/auxdisplay/cfag12864b.c | 12 ------------
 drivers/auxdisplay/ht16k33.c    | 10 +++++-----
 drivers/auxdisplay/lcd2s.c      |  2 +-
 include/linux/cfag12864b.h      | 17 -----------------
 4 files changed, 6 insertions(+), 35 deletions(-)

-- 
With Best Regards,
Andy Shevchenko



