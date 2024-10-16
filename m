Return-Path: <linux-kernel+bounces-367871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 309ED9A07D2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA241C27E77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A78205159;
	Wed, 16 Oct 2024 10:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V1302f3D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DC9206967
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075939; cv=none; b=LPyh3du3Y7idYxC8oS2r1Kf5ly0iG8dCWj04D67Xn/DAHshd1Ttj1PQaT1lkBw2qV0rZUJ8igzlasfIwWGFHpsCpT5Wu5/2vhGXnpFtprXLyJ56hbdhIf3xl7V1yuKw0TPfPGXtIX5bPz5blriBCAczrp0TBLIdkTrceUuM24eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075939; c=relaxed/simple;
	bh=BzaJJzTUq6easOwl76PakwPS7wu4rnks80LcXrTleus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBw7T1fbzix94lLAfDbid7juxzzhxxWNhgqzg4vKMO5/nVEtNpPT8iqxCNbWSSxRoJJ1rp1avhUKCOcCIQaBDLLnpkO6oKQY3XhuC1TRqdy9Dc0ZU/MuyPaq3oGCadGUhPM+ZiB2Kn2U3IvX39iffdnpo94Z9TlTwF92XKEn2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V1302f3D; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729075938; x=1760611938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BzaJJzTUq6easOwl76PakwPS7wu4rnks80LcXrTleus=;
  b=V1302f3DHukUerMsnh/tcm2R83qkv0PG2GWKhwXdnFYTtwRFolRHezC8
   i5A/J/Q55RVs5CS6ZLOiWSUFCjq4/t3U8qIPq7LRJiD+XWpS3U2rKT/DI
   mg9ADvUQ0EZNrnm+jnoMCVLvjv3D1uogu3k3FwJpfxLIUoNdF9B/Ks8OS
   X2ngrBG83BTGuvVyIuWAH+y2HnkyzpvbCqVyvAJT8WLNCz4VjRK+XvBnO
   yKwDsE8JOLSFSW2nuimjCf9QNNxGNKMQtoM7GkYQwGgJ5O2FhsfcJ4+4M
   ogQ2yK4EY+yQkoRw0tnkh2NO6AltgyG5Pox3WX6sYSwgH76ezcooMZi+2
   Q==;
X-CSE-ConnectionGUID: Pmx/QHrSSLmESWdShFxcIw==
X-CSE-MsgGUID: MVVm13rKSruhsUtZCURcZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="31382470"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="31382470"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:52:05 -0700
X-CSE-ConnectionGUID: c/Q5G6aASzeCnoJKIZ/Apw==
X-CSE-MsgGUID: r4aNL/lJQtO3jD1CSCZtxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82740097"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 03:52:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DB039331; Wed, 16 Oct 2024 13:52:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 0/4] mfd: intel_soc_pmic_bxtwc: A few cleanups
Date: Wed, 16 Oct 2024 13:49:50 +0300
Message-ID: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on the fixes series against the driver I have noticed some
places that can be improved using better APIs or approaches. Hence this
mini-series. The plus statistics is due to the patch 2 that brought
missed inclusions to the code (instead of using a proxy header).

Have been tested on Intel Joule device.

Andy Shevchenko (4):
  mfd: intel_soc_pmic_bxtwc: Switch to use ATTRIBUTE_GROUPS()
  mfd: intel_soc_pmic_bxtwc: Don't use "proxy" headers
  mfd: intel_soc_pmic_bxtwc: Use temporary variable for struct device
  mfd: intel_soc_pmic_bxtwc: Deduplicate error messages

 drivers/mfd/intel_soc_pmic_bxtwc.c | 45 +++++++++++++++++-------------
 1 file changed, 26 insertions(+), 19 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


