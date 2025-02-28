Return-Path: <linux-kernel+bounces-537884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02912A49212
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85EC189315B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887CF1D5165;
	Fri, 28 Feb 2025 07:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xh/qEr4B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92B61CAA6C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727269; cv=none; b=CgbZ7CTvkcShW6+DsOzFyTJ2GXAP1dvGPs9UJHc9vP9EXvKHdRWyDufGWtImwcAtwYP4JpwED8PUY/WFMpj0BGfS+gOR09u6cme8LfKrGBynnDMFtg82oY8fcpKDelkXXulkRwaROvIEtuj1jo2iWfaKJWDm8Mg2T223tjvMxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727269; c=relaxed/simple;
	bh=LiGS3+6W4VSmf7HQmdSuxLihLsGhBnmgTm1eWOTnPMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fQlzqVTeWtd/UmAUxHh9jt/58cMyJkt2jNrRtXrWzCDiIFH4MMiSZzfNNn3pikTYeHFHBNCuVOGjXRK9vKa8r/c74w978LJH7Wni1SrcWVdjIvyu/0t8oP6fzJZq1gywxS4m8pAANou68MbGb0ZY5hIAcRreONrqKKd/olncVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xh/qEr4B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727267; x=1772263267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LiGS3+6W4VSmf7HQmdSuxLihLsGhBnmgTm1eWOTnPMo=;
  b=Xh/qEr4BxFK1GZBWQezpog/y+CjvykEp6pz5DH0GXUm8bVafZgUdpJ8z
   6K+gjvJGwfPd7jEuNH/IZETuTWH9DHS+R1HFltKETtxKUdSAFMMh6WBwe
   VuezOwVyTudQUHtl6IlDZY5T8CWtC0pBqVj8dsj9KA5pQiTnHmT7z5MjB
   tRNq6DaCeYv1dh1S8gDME9bCIyAq6ieVTu12YcXXC7UYgk7ge6gX2uaGe
   9oFaV1U4Wns/QtiR/ikWR1Og6OdtAZHs4YdW81dgdMa2fJ0lk1zFcskIO
   0T1PC/XUnXf6C6AhpeCG08TI2Rzt7QIhzkUxd3lovxEtcuF/w2c7FjJ3x
   w==;
X-CSE-ConnectionGUID: X2jW5kNISSyoWyvJdvFRDA==
X-CSE-MsgGUID: TDrJq5S3RRGv9OjMbSPhXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="29242637"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="29242637"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:21:06 -0800
X-CSE-ConnectionGUID: AovqdcdhTDGSC0sXB8Nryg==
X-CSE-MsgGUID: 0R8SLaQyThiei2WV3iTnFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="140487428"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 23:21:03 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	bleung@chromium.org,
	groeck@chromium.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/2] regulator: cros-ec: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 12:50:57 +0530
Message-Id: <20250228072057.151436-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228072057.151436-1-raag.jadav@intel.com>
References: <20250228072057.151436-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to use devm_kmemdup_array() and while at it, make the size robust
against type changes.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/regulator/cros-ec-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index fb9643ed7a49..fb0767b33a36 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -138,8 +138,8 @@ static int cros_ec_regulator_init_info(struct device *dev,
 	data->num_voltages =
 		min_t(u16, ARRAY_SIZE(resp.voltages_mv), resp.num_voltages);
 	data->voltages_mV =
-		devm_kmemdup(dev, resp.voltages_mv,
-			     sizeof(u16) * data->num_voltages, GFP_KERNEL);
+		devm_kmemdup_array(dev, resp.voltages_mv, data->num_voltages,
+				   sizeof(resp.voltages_mv[0]), GFP_KERNEL);
 	if (!data->voltages_mV)
 		return -ENOMEM;
 
-- 
2.34.1


