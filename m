Return-Path: <linux-kernel+bounces-295847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBD595A20E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02BB1C22E98
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878DB1BAED5;
	Wed, 21 Aug 2024 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLZr1A/T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CF214E2EF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255325; cv=none; b=Hgco0VxofleG6F8Ygi6nwutWSahEPMBnJYka8PEuLfW1a36KPaCUzrwCNEe0AsQdcafd0kfNFbsNvMgI+3ujF9EhIhKpTmKBSvbicJ7hfz35T+0imceVGaJMAJL9KabPL8b3nVhyCsRJ7I95BFuyFTQMITkX17wzrhh/gl67LrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255325; c=relaxed/simple;
	bh=CjYYmTwMmRw/8sMqW2zsbuyrU0y3SJeljZTpvZGEtsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pw6nRxcb7imh4YFHRPsT09UzSbuB5xdIuwgIlVBaMyn+kQgQ+N8TQC4ElP5739ddFJUd7iHJiBHTbSXQ7RgQDEY2tEm2thouVYSGUEZGC/LBejLVmRTeVzi0vGC4a+CgbNMwJmxF+s++1kaVthfdz6/4yIgl7EQ6B8oj0lHLGu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLZr1A/T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724255325; x=1755791325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CjYYmTwMmRw/8sMqW2zsbuyrU0y3SJeljZTpvZGEtsU=;
  b=CLZr1A/TNe2jirOPt5HLLX9b8CsemgkX2JbLLuFX9hjpIHEWwg/Cq1zM
   BBqZwg2FPcykK+k/r7nZOiIg2LazHXfsnl7PGf/a6LlLgP5Dy3A+qqHRe
   iXcBBdgHMa0bcH7quElvPUy5AQXaiNA0CY6HbyOalP/e1/twdSDXNlXq0
   lbid/BbCmMWjVO0dzvOrNiXkKLtkD62EDUWPTtGpjkz5DarNG7QpAoz13
   5hOeJhOykBl6yaqY1NhxuZaSGVA++fAWtgGb+jXMbR1zesvs+LPg1cFwi
   X5vHrkKibzsy3qwRKNMcWncT0MtzK2AuCrr1Lxn5RRoMjaL9/B2l1ez32
   Q==;
X-CSE-ConnectionGUID: /VDkERZ7RNSsAywm61DrKw==
X-CSE-MsgGUID: 7i2YBPNFRGuG8R+lB5qI3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="13134996"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="13134996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:48:44 -0700
X-CSE-ConnectionGUID: UVTRbx3mQ/eqbUkZuMTCLg==
X-CSE-MsgGUID: nX3z1rYoTTKzopIcW5qL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61107975"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 21 Aug 2024 08:48:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id F0D7A268; Wed, 21 Aug 2024 18:48:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/5] driver core: fw_devlink: Clean up strings and mutex usages
Date: Wed, 21 Aug 2024 18:48:18 +0300
Message-ID: <20240821154839.604259-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strlen() + kmalloc() + snprintf() by kasprintf() ond other
string handling improvements.

Use guard() / scoped_guard() to handle fw_devlink mutex.

Andy Shevchenko (5):
  driver core: Sort headers
  driver core: Use kasprintf() instead of fixed buffer formatting
  driver core: Use guards for simple mutex locks
  driver core: Make use of returned value of dev_err_probe()
  driver core: Use 2-argument strscpy()

 drivers/base/core.c | 142 ++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 78 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


