Return-Path: <linux-kernel+bounces-282786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC3694E88B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC692830A7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3530416B39E;
	Mon, 12 Aug 2024 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1QgNmHh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AD1876;
	Mon, 12 Aug 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451327; cv=none; b=bu0esfYBHG4iyMUqPK84h++t3UoNhaMN3g6NmqLqZKGNrKBxGbjgPpv82g7FYrUFsjQ+HLxI3+2tcfmIrTbtE/o5dj4Utp4qKmu4nUfm1hm5xl20498Re2EoZmRQ7vr5GGzg2i7rEsJdC3wcravnAGl+AAC2RiI7NpRLiRHX7HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451327; c=relaxed/simple;
	bh=0M1fQkS60er+ydlOsWy5h+tl7oPBevn87IbSZPifRdc=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=AOrAk/ourSiJ5DwJiGxeFBaja9B5/IBGzEJoZzdG/DojJUoHX86Wsfc5GsdUeWpj2LC665hYdIEPcOLhqfV3xiN/CFtle99rI/NFfjundcm7O+0iAirwoD8UnCPYuvQz51IDpEAjAnVCIvC9jD38GMGfkiorG03WNL8S/0Xb9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1QgNmHh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723451326; x=1754987326;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0M1fQkS60er+ydlOsWy5h+tl7oPBevn87IbSZPifRdc=;
  b=G1QgNmHhDj8C4y/HSAHXz5RA76q//SrCkA/SvZ8lUPKwSL6ZFeyiAeXp
   3hba7SgQboyQMs1HbN6N8PBPxOAFz7Mmrp944gUzK2u144ec6klJnAGUB
   GGdcdnDeKpS+98o3fraPwskJZPBtTE0Nn0qDvWElaHh7W0e54NaRqB+CD
   g9CfK9Pgso9vy+Mfkm/mzpXD+s8nOz/8Wb3flpdXfvxE7ZPIx+fiDGQhu
   Dp1k4mpMQgDppVKE4X5ScND8apmDfmuZGHzBjVh/SvMZsrNK5c6LQqsNc
   CVD+b0MbgJeqKYb7YYJEZhQmRZXbpHPXi5SatOZv8pQDvovzhYbKxjaDU
   Q==;
X-CSE-ConnectionGUID: mD0XD0A2SC2sFw+UGOuqSQ==
X-CSE-MsgGUID: 7jv1cKo7Re2vGAZ5ejfyWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="21426605"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="21426605"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 01:28:45 -0700
X-CSE-ConnectionGUID: 96SLpzlMSzqNGO5YJJxH9g==
X-CSE-MsgGUID: plkxinwkRt26y2l22WwE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="58749285"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.25])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 01:28:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andy@kernel.org>
Date: Mon, 12 Aug 2024 11:09:14 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.11-3
Message-ID: <pdx86-pr-20240812110914-2175928819@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.11. While the ideapad
concurrency fix itself is relatively straightforward, it required
moving code around and adding a bit of supporting infrastructure to
have a clean inter-driver interface. This shows up in the diffstats.

Fixes:
- ideapad-laptop / lenovo-ymc: Protect VPC calls with a mutex
- amd/pmf: Query HPD data also when ALS is disabled

Regards, i.


The following changes since commit 3114f77e9453daa292ec0906f313a715c69b5943:

  platform/x86/intel/ifs: Initialize union ifs_status to zero (2024-07-31 12:37:34 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.11-3

for you to fetch changes up to 7cc06e729460a209b84d3db4db56c9f85f048cc2:

  platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands (2024-08-08 15:03:09 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.11-3

Fixes:
- ideapad-laptop / lenovo-ymc: Protect VPC calls with a mutex
- amd/pmf: Query HPD data also when ALS is disabled

The following is an automated shortlog grouped by driver:

amd/pmf:
 -  Fix to Update HPD Data When ALS is Disabled

ideapad-laptop:
 -  add a mutex to synchronize VPC commands
 -  introduce a generic notification chain
 -  move ymc_trigger_ec from lenovo-ymc

----------------------------------------------------------------
Gergo Koteles (3):
      platform/x86: ideapad-laptop: introduce a generic notification chain
      platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
      platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Fix to Update HPD Data When ALS is Disabled

 drivers/platform/x86/Kconfig          |   1 +
 drivers/platform/x86/amd/pmf/spc.c    |  32 +++-----
 drivers/platform/x86/ideapad-laptop.c | 148 ++++++++++++++++++++++++++++++----
 drivers/platform/x86/ideapad-laptop.h |   9 +++
 drivers/platform/x86/lenovo-ymc.c     |  60 +-------------
 5 files changed, 155 insertions(+), 95 deletions(-)

