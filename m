Return-Path: <linux-kernel+bounces-537882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2EAA4920E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923151892C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C391C75E2;
	Fri, 28 Feb 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B622MtcT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC331BC09F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727265; cv=none; b=W9A/7wnPRriG5UrX3ZDxiANonwXm9DKL0YDt+WTkLF/+eaTSqrUhiJLo6BpVLtxDMJpuz5DVGMawVkdMTLiQqHYD2n/EtTfKRYkSHR1XnAJl7bdCwmqWWthih15aY9fEBoeJ6vAJa6FQp6QV5wml3UsZdryjLQoNcxZ9R68/eGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727265; c=relaxed/simple;
	bh=A43sWN4sdLq3tQc+IB25Ps/3Ig8snwsi8Gmk90X6cpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVvL3NAd+/TsCaGDFaTvVWn/uz1eLFbKmr/a7IGXWEv1JVN4kNr6qSUcjYD4IIEQ3AHVVIyblqZI7xJ4YHv65P5a2IRhaf7/YGj4NsLPMyydIhjQ2eFkgYSVnxPC0omJ3omjFro+jSkmR3eoYtSM02EC6xB2In26S/FXHA00ILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B622MtcT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727264; x=1772263264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A43sWN4sdLq3tQc+IB25Ps/3Ig8snwsi8Gmk90X6cpQ=;
  b=B622MtcTJ7kzgBt4Jf95GfzR7nDnJrS4pXwni70Bjyo2sLZHwzqIcpzC
   WfXyKU59tXSkTOTicqfg6/vgQtQXkJ6Uetn7nB3Ktj4JoHtXjbVSA6zp3
   397KwxnNm3VpgD3tm11lks1O8sKBwfAEU4YRXKNoNfjuub1+4xdRpDsv/
   4JX0SckmwXVNyWNO/whqhEt5WJl/IIHrJve5ggrQMqXxpKazjUonRk/1Z
   M2hpiuagUmp/5gljxqK8xRpguNIdCQr9PjvxNjlmZ2UVTp6viMBeiWHF5
   r5P4/pT5/jCv3dpeBBXAXpNnlwpL/6Ce0OtxPs06+/KA2oV85Vn1FF7M1
   g==;
X-CSE-ConnectionGUID: q1QJdl+aQOatMuwoOR7YZA==
X-CSE-MsgGUID: D73y4TiBT3WQnl0LAm5rfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="29242633"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="29242633"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:21:03 -0800
X-CSE-ConnectionGUID: gIFgZDghSzejx2cajWge2A==
X-CSE-MsgGUID: jAB4UOhXSMyeYYdroocPYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="140487411"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa002.fm.intel.com with ESMTP; 27 Feb 2025 23:21:01 -0800
From: Raag Jadav <raag.jadav@intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	bleung@chromium.org,
	groeck@chromium.org,
	andriy.shevchenko@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/2] regulator: devres: use devm_kmemdup_array()
Date: Fri, 28 Feb 2025 12:50:56 +0530
Message-Id: <20250228072057.151436-2-raag.jadav@intel.com>
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

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/regulator/devres.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 36164aec30e8..ab238579879c 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -332,9 +332,8 @@ int devm_regulator_bulk_get_const(struct device *dev, int num_consumers,
 				  const struct regulator_bulk_data *in_consumers,
 				  struct regulator_bulk_data **out_consumers)
 {
-	*out_consumers = devm_kmemdup(dev, in_consumers,
-				      num_consumers * sizeof(*in_consumers),
-				      GFP_KERNEL);
+	*out_consumers = devm_kmemdup_array(dev, in_consumers, num_consumers,
+					    sizeof(*in_consumers), GFP_KERNEL);
 	if (*out_consumers == NULL)
 		return -ENOMEM;
 
-- 
2.34.1


