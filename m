Return-Path: <linux-kernel+bounces-169553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8692B8BCA48
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59B01C210C9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3A1422C3;
	Mon,  6 May 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvfJr6CD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA061422B4
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714986608; cv=none; b=GHDBFhlY/cl2WUDNw0K3aGljNRqoyKt2GJJsDaLLqGnef9+ccZO8Xk7ohiPM0cXMHctmdG+SewTZOnS90MNuUbwHJKGRG7takO+XN486/KaZpq1CF/ucLvby7AjKtgHn3P1Q+puLIlNmTzuU/e/ZAJScJ1vd8Zd2uYFg7l9DzII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714986608; c=relaxed/simple;
	bh=LfkWaDaKna8Q2wIP4LNcK3tRP9+y668zcU2f3tOs9G8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ctDoPKB7k26eGu1yed3RVsdwaWQTNRI9j7PSEhJAd52dPnJZ+HS81MT4YSmBvdb0QCvfgg0b6CnhsuU7cGeJxry1gYjZaQtS2F+2TGG/RQVfIi3LGWPlgXsNF8zX6jnYzH5oWo7T0uAGU36dNTx1vUPhAmfoGrmOtxMCAl84uGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvfJr6CD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714986607; x=1746522607;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=LfkWaDaKna8Q2wIP4LNcK3tRP9+y668zcU2f3tOs9G8=;
  b=CvfJr6CDp2ms5RqmKPaaktlfVnNgKHqR9vIUyZzVRB4H8wzQEacmcEK1
   q3lW1/JVw068OaQDTlLsl3vSW/sITYh6H3UuV270YugZE0HBciQlHxTri
   X3dCNuNOB8Y0HudeZYtWodm6O3RBeJYKPbcZ99guCJxRhCiaWFpzCKWex
   nqdXqYdCdkbBB6sdIf1N76n29t+ivi0NEzgFtQmyMGqbCrI3NEZiBsNs7
   QQh77sAgFJWOEiANsRNGpnYQQuZncHyu85LeNnab1HgIpEtEfypzPJKyw
   hIrISmq+/xKMzwpBCKJBk/BCFDwtqtENF8UQcVPaT9xR2XJ8fds8u4g1Q
   g==;
X-CSE-ConnectionGUID: pgJb8JuLSseNi97uQ2JhCw==
X-CSE-MsgGUID: YeZMcmObRaGSeh/npHNvaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="22132746"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="22132746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:10:07 -0700
X-CSE-ConnectionGUID: 7Td+01oBQGmes6jPjTXwBA==
X-CSE-MsgGUID: WTqFPQCHS8aXafbVhEV6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="32775451"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 06 May 2024 02:10:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2BA532A44; Mon, 06 May 2024 11:35:33 +0300 (EEST)
Date: Mon, 6 May 2024 11:35:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] auxdisplay for 6.10-1
Message-ID: <ZjiWVdJPyFiN0oYe@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Tiny update (as was expected) to auxdisplay subsystem. It was a few weeks
in the Linux Next without reported problems. Please, pull for v6.10-rc1.

Thanks,

With Best Regards,
Andy Shevchenko

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.10-1

for you to fetch changes up to 93ee235f55d3e1c881e766a320cedcad0b9aca42:

  auxdisplay: charlcd: Don't rebuild when CONFIG_PANEL_BOOT_MESSAGE=y (2024-04-11 13:34:29 +0300)

----------------------------------------------------------------
auxdisplay for v6.10-1

* A couple of non-critical build fixes to Character LCD library
* Miscellaneous fixes here and there

The following is an automated git shortlog grouped by driver:

charlcd:
 -  Don't rebuild when CONFIG_PANEL_BOOT_MESSAGE=y
 -  Add missing MODULE_DESCRIPTION()

linedisp:
 -  Group display drivers together

seg-led-gpio:
 -  Convert to platform remove callback returning void

----------------------------------------------------------------
Andy Shevchenko (3):
      auxdisplay: linedisp: Group display drivers together
      auxdisplay: charlcd: Add missing MODULE_DESCRIPTION()
      auxdisplay: charlcd: Don't rebuild when CONFIG_PANEL_BOOT_MESSAGE=y

Uwe Kleine-König (1):
      auxdisplay: seg-led-gpio: Convert to platform remove callback returning void

 drivers/auxdisplay/Kconfig        | 346 ++++++++++++++++++++------------------
 drivers/auxdisplay/Makefile       |  10 +-
 drivers/auxdisplay/charlcd.c      |   3 +
 drivers/auxdisplay/seg-led-gpio.c |   6 +-
 4 files changed, 189 insertions(+), 176 deletions(-)

-- 
With Best Regards,
Andy Shevchenko



