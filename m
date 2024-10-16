Return-Path: <linux-kernel+bounces-367870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986F9A07D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07934B25C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D2207211;
	Wed, 16 Oct 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXD8I7Zh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D3E206042
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729075929; cv=none; b=g7qGWmV1tK/fvoGZen2YLufnA6BWyqdtBTcMHN5Qo3FYzIGKLj55CqeSvNL43HgOi4oKZ04TfrQRz/JJMWpI9kJ7gDEAO7bbcuGcbkYTfRowGW7UbgueF43eXJuhlfGhj15TjZCSyntVnAu+wbJ4JJcdGjFHg6R1zzKmBiJ/onM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729075929; c=relaxed/simple;
	bh=kHvO6cMD7+Y2mZ3ub+f8kAMvCDz4oA82AXi5wleV3Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcpGXJ4Fec33BPyggwg6G86zzyrd9ZBlJLRTdtAdYXGW9uL/AqGp1HR3dksjUS2w5LuplepIdeW5hsaE61xtRtGCvDA7RfGRsDazrcZ/MD2zOSD1La6YHGhc939yNKwJL3yGIhtLliQPIre0x2jNyeiJ8vBRD4PD6QiJkEY9HZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXD8I7Zh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729075928; x=1760611928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kHvO6cMD7+Y2mZ3ub+f8kAMvCDz4oA82AXi5wleV3Cg=;
  b=JXD8I7ZhzBbDXouudAGavwYGYMeV1q07VxrkIY0Tx2GCB/+FI5p9sY0D
   pte+LfqgTVaxZE/P9Eolx3Rfj4HY0noTO5QeHb5/QgU04MPi/J28gnHo3
   5AV+oGMkz/510LRWjyX8K4TU/ldR3X3V1SN3q2rqk+xZuaQSe4/nauLFH
   YC+NF9gLA5raOQ4TLyIbYMmXNMCVE8FQasbFZCmx2MTmmwr9uMkWOWzI3
   ECJmejbWM8LSqS0vQvNI60cz6bDfi2oz5Cwnl9NjhD9cHigO7Rn7fL3/I
   Nkk3hdkgT6LeS0JeeQ5V7+ODdGKbIUPMqbWu/4kfWuc1D/5iCLAFdTvaR
   w==;
X-CSE-ConnectionGUID: cWqKRO3IQXWxjLszaRLJOA==
X-CSE-MsgGUID: VFyd7v/fQRGn2Xq1TRLPew==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28645805"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="28645805"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:52:05 -0700
X-CSE-ConnectionGUID: UAhH8tn8SDe2JjzxmdAlSw==
X-CSE-MsgGUID: LGYaMeeBRk+KuV68KdqVpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="115631222"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 16 Oct 2024 03:52:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E8E631E0; Wed, 16 Oct 2024 13:52:02 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v1 1/4] mfd: intel_soc_pmic_bxtwc: Switch to use ATTRIBUTE_GROUPS()
Date: Wed, 16 Oct 2024 13:49:51 +0300
Message-ID: <20241016105201.757024-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
References: <20241016105201.757024-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embrace ATTRIBUTE_GROUPS() to avoid boiler plate code.
While at it, move DEVICE_ATTR_ADMIN_RW() closer to the callbacks.

This should not introduce any functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index b7204072e93e..c130734f308e 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -364,6 +364,7 @@ static ssize_t addr_store(struct device *dev,
 
 	return count;
 }
+static DEVICE_ATTR_ADMIN_RW(addr);
 
 static ssize_t val_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -400,23 +401,14 @@ static ssize_t val_store(struct device *dev,
 	}
 	return count;
 }
-
-static DEVICE_ATTR_ADMIN_RW(addr);
 static DEVICE_ATTR_ADMIN_RW(val);
+
 static struct attribute *bxtwc_attrs[] = {
 	&dev_attr_addr.attr,
 	&dev_attr_val.attr,
 	NULL
 };
-
-static const struct attribute_group bxtwc_group = {
-	.attrs = bxtwc_attrs,
-};
-
-static const struct attribute_group *bxtwc_groups[] = {
-	&bxtwc_group,
-	NULL
-};
+ATTRIBUTE_GROUPS(bxtwc);
 
 static const struct regmap_config bxtwc_regmap_config = {
 	.reg_bits = 16,
-- 
2.43.0.rc1.1336.g36b5255a03ac


