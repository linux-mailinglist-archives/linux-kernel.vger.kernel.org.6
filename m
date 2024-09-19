Return-Path: <linux-kernel+bounces-333735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AB497CD17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8451C21546
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54121A0700;
	Thu, 19 Sep 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTJ999Gh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E51990D8;
	Thu, 19 Sep 2024 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767287; cv=none; b=JrOKA5Vtc3GjnzgJQznDJ5afRM7LdLvme8vjHGjC2IvheJjBSlZhuLjIF7/tP9BpxFyY7BDMwnVxTTq35ILoVsUi6G840PoPpSZ7HrEiULqb2HOr6sYzMGwH8TdUaeVJCkndB12mt9xCYy8TqbE3ydJFr0F8WY3JCsV6URo06JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767287; c=relaxed/simple;
	bh=guYKRTBp+HoRGl/rUbPzYYRUnzTsljzxQ19fv8/MGos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRe6QzyXYdOoRxerg9qzqoUaSoFaCcFY2qS+bGU5Br+DTnxqgMC2TbIdPMX7TpkzeYU+qPExeFFUXgsvSFmPJYv0gA0DGglskro1t2c2uSEtUKAwpMavIfUJxN9T946x2vtRVKIDVcnFqYdUPzVAfIAJ4Wxhs2/RlhrgIdXwuKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTJ999Gh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726767286; x=1758303286;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=guYKRTBp+HoRGl/rUbPzYYRUnzTsljzxQ19fv8/MGos=;
  b=FTJ999Ghnbgv3nWt8m7z2+KGCcQGtxdbK7j8ym8sZTuqPmSskXQclJSX
   BrK6bBlCICidDHOUJ+qpm2c7y/Q/JNLman5A9oulZJb6mdAJDLzyqXODI
   I34DV3uD+D3hYpDCJdk7k2QD6ZCVcKkkPXKJS9X6R56g20RYuy/LX6DDk
   zcJ+w6mwoJDNZscZWeG3081F8tKxjovLMA5jDKvglQ6Rxs7uxYRwG6VNP
   0ZfFnei3Nhnw5ygFRt/tbV+s5xwTTLxKWUYJ5YosRBK0F0BTqXdyeLKLr
   rcdE7mF136FC9W8owSsS5y8cVrVWYnLIikMQ2ElRKPjKfk4PCfr/NfOEb
   A==;
X-CSE-ConnectionGUID: wCpPOYY8Rjy240O0bizI3w==
X-CSE-MsgGUID: wUDXIxhJTGuzU1L/vIRzuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25847225"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25847225"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:34:45 -0700
X-CSE-ConnectionGUID: W2tkVgWxSd6RQTFU1Fakvw==
X-CSE-MsgGUID: Oz0oakV6RN6B+IpTlYheyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="100844311"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 10:34:45 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Tianfei zhang <tianfei.zhang@intel.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>,
	Michael Adler <michael.adler@intel.com>
Subject: [PATCH] hwmon: intel-m10-bmc-hwmon: relabel Columbiaville to CVL Die Temperature
Date: Thu, 19 Sep 2024 13:34:17 -0400
Message-ID: <20240919173417.867640-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consistently use CVL instead of Columbiaville, since CVL is already
being used in all other sensor labels for the Intel N6000 card.

Fixes: e1983220ae14 ("hwmon: intel-m10-bmc-hwmon: Add N6000 sensors")
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
Reviewed-by: Michael Adler <michael.adler@intel.com>
---
 drivers/hwmon/intel-m10-bmc-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index ca2dff158925..96397ae6ff18 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -358,7 +358,7 @@ static const struct m10bmc_sdata n6000bmc_temp_tbl[] = {
 	{ 0x4f0, 0x4f4, 0x4f8, 0x52c, 0x0, 500, "Board Top Near FPGA Temperature" },
 	{ 0x4fc, 0x500, 0x504, 0x52c, 0x0, 500, "Board Bottom Near CVL Temperature" },
 	{ 0x508, 0x50c, 0x510, 0x52c, 0x0, 500, "Board Top East Near VRs Temperature" },
-	{ 0x514, 0x518, 0x51c, 0x52c, 0x0, 500, "Columbiaville Die Temperature" },
+	{ 0x514, 0x518, 0x51c, 0x52c, 0x0, 500, "CVL Die Temperature" },
 	{ 0x520, 0x524, 0x528, 0x52c, 0x0, 500, "Board Rear Side Temperature" },
 	{ 0x530, 0x534, 0x538, 0x52c, 0x0, 500, "Board Front Side Temperature" },
 	{ 0x53c, 0x540, 0x544, 0x0, 0x0, 500, "QSFP1 Case Temperature" },
-- 
2.46.1


