Return-Path: <linux-kernel+bounces-237816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB68E923E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EB41F242BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394011A00C2;
	Tue,  2 Jul 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="alNJDMZ5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C96A19DF82
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925888; cv=none; b=abY7Gsvnn00+/uv26QfFhqJF1LNFEPZ0c7uBdB8J8Nc2XDCs6RLD6gT/WRdky8IB9YXk76b65DrYOCRXHNVYW4A6E79Gk/Nl9wGZMwZ3VvF7IT5vCDNet4V5Z5mR7cBGYhSriJFMpPmogsJX5oiIGvgqm5gpDPbJpKwatHAVJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925888; c=relaxed/simple;
	bh=As/Aykdbt4v6c2/zxur0icfFP/KzwqKu7AKzmNTPDcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHXHUT6vzrdo7eP9ktVWSMGxoBznTZQaybsbmESHuOryeL/YQzuoEe4cAQmy9w8uttcbdZJUhBtUW+t+lDGk+Ran0AF6n4gD1/dFckcoG9Gm8J967jMbFVYdeV+KF94skj5Ahd1IQPYC0rSk0bE2o/UFUnikE8MFmpAaiCuOqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=alNJDMZ5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719925887; x=1751461887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=As/Aykdbt4v6c2/zxur0icfFP/KzwqKu7AKzmNTPDcw=;
  b=alNJDMZ56com2/WlphFtcGaJlyYK32DlATLbG0kAP9Bp4xgIjdLrar3I
   4mjEbSEG7PROImybLEVXe389tbz0mC3b10PgXru04xDlHNy7I/2Jy1Jau
   nrEUKpOm9xRWt+5qM8C5/cAeSYf4RzRpRMqLs/P6T1ajct1h/XwG9PYYX
   9QYdbxNqY3cwd0ym65zaA3OUemHh2RDsMUX22Lf+0B360StgjoS+q5Lxr
   V7I7kjttuDyR9AJ35163iD+dBPNOCtWxu9TxkXPfxXntmGRqzJXB9AOEM
   eWHxZ8Sjo9VpQ3L8AF/P2D5gJiefuTsB+isL0vflCcoZs9LxjtEQttt4+
   A==;
X-CSE-ConnectionGUID: qP9qrBN8T7m75KUUA86g6A==
X-CSE-MsgGUID: a8rrbJlGS8i9utMf9o/o7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27700007"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27700007"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:11:26 -0700
X-CSE-ConnectionGUID: GjlT4eamQJypxR+LYADpHA==
X-CSE-MsgGUID: MoMOyer4Q1uXsxLw/Dkazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50250835"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 02 Jul 2024 06:11:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] iommu/vt-d: Remove comment for def_domain_type
Date: Tue,  2 Jul 2024 21:08:34 +0800
Message-Id: <20240702130839.108139-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240702130839.108139-1-baolu.lu@linux.intel.com>
References: <20240702130839.108139-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for def_domain_type is outdated. Part of it is irrelevant.
Furthermore, it could just be deleted since the iommu_ops::def_domain_type
callback is properly documented in iommu.h, so individual implementations
shouldn't need to repeat that. Remove it to avoid confusion.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20240624024327.234979-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e9811bf2a4e..abf0097f899d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2177,17 +2177,6 @@ static bool device_rmrr_is_relaxable(struct device *dev)
 		return false;
 }
 
-/*
- * Return the required default domain type for a specific device.
- *
- * @dev: the device in query
- * @startup: true if this is during early boot
- *
- * Returns:
- *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
- *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
- *  - 0: both identity and dynamic domains work for this device
- */
 static int device_def_domain_type(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
-- 
2.34.1


