Return-Path: <linux-kernel+bounces-295486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB51959BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D59B283C47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4625E192587;
	Wed, 21 Aug 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdPeFXnH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275916B3B7;
	Wed, 21 Aug 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242961; cv=none; b=QsHIgh+r6TtzdIYacRj68iqHePqLyGx9mSIEOziBIc7X9h3KKvmME92+mVkpkOUBVb4vlsHpsUS8b6OhPO1Hs+IBUluMWqinW+DL2iUnaVwXDrTLGL2PtvoL8KZJ2D2qFJ7+aWrJpG4NUYsXF/gwdjskhSMQiBh8xxbVdLKsMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242961; c=relaxed/simple;
	bh=sNzlKdxKngZ+ICVxZLqHWMC10KYHTm5HeQx0B6HUSsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rm7XIUgxUhGEI8Jaep0Qcwzcg22y2knTxhu6jtc8noOksMfIhFCTe2fnXeF0NV7G2/6mCV7TOam6AkGI2A9yNszzoXeMH92mGfGbmUIKY2oBL5+R8Agxac7VylKXZ7t17P+fkj6oRNis4SOm7djWsjmUuhWCPuHwXxnFJUR2WUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdPeFXnH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724242961; x=1755778961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sNzlKdxKngZ+ICVxZLqHWMC10KYHTm5HeQx0B6HUSsY=;
  b=TdPeFXnHEgcaQcCwFXwI43u4kHeDF1aHk7qYDR/0yhSRHoC1OL1Wx/pN
   LHxFMcJQA5wqytDpimy0Gx/IFVV0ctXEOnqL18NEd087VHm6NkOF+CPlk
   n1PGlwbQlkgqSaItih9LEWwTKIZ+YtXsTxEFO2LHduGuZKSVTZCD7dwa+
   3vZk/xD0vcYQ3eTprVjpdFk7UhNFtRiY/24uRnLKLDqQi8LZ5Wga6pM+9
   FLojMD6kccH75etQop7DrBdlVzWUdtZ/WRjwGKMTW3WnU2oPKVKL8CdKF
   61lfzJV3y/eHsmADLpQzzlnaIDGmftAVyzVMbsOwdaeitKC/C5CDFgOZG
   w==;
X-CSE-ConnectionGUID: tSyOdNeXTsiTCMAvhx/YSA==
X-CSE-MsgGUID: waCb2kRxRmiQqiB56UHKuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45123248"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45123248"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 05:22:38 -0700
X-CSE-ConnectionGUID: rqHONEAhQSmSw3jMQ2nFog==
X-CSE-MsgGUID: cKq/yA4oQMOiGnCdmPUl9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61057197"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 05:22:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DFCCF43E; Wed, 21 Aug 2024 15:22:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v1 0/4] platform/x86: int3472: A few cleanups
Date: Wed, 21 Aug 2024 15:20:39 +0300
Message-ID: <20240821122233.3761645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few cleanups to the driver. It includes an amendment to
dev_err_probe() to ignore 0 error code. The patches 1 and 2 are
dependent, while patches 2 and 3 may be applied in any order.

Assumed to go via PDx86 tree if no objections to the code.

Andy Shevchenko (4):
  driver core: Ignore 0 in dev_err_probe()
  platform/x86: int3472: Simplify dev_err_probe() usage
  platform/x86: int3472: Use GPIO_LOOKUP() macro
  platform/x86: int3472: Use str_high_low()

 drivers/base/core.c                           |  4 ++++
 drivers/platform/x86/intel/int3472/discrete.c | 14 ++++----------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


