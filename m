Return-Path: <linux-kernel+bounces-228294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC863915DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E11283961
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4BB13C9A2;
	Tue, 25 Jun 2024 04:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AesDX6SI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916EF6A039
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719290515; cv=none; b=WpEo3vqI+6Si1FBdbvghZagDB86MEV4ICaZm37iDCnf5IdvxvFe2ZPENCHH/mzsc92ZniWjgtz5ytBIjzhdE4O+xab3+MoDh/0EFh28u+pTMtvCwQKXyV7g/sYTwpflb+k4KgRz/clGjA+UA5UqLdSiBKqRLtz0z+z0NEGnS8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719290515; c=relaxed/simple;
	bh=AEcb9uoqY+haPLqWfC41LsegM3/wAyvPwHBCs4Y7rZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHDtTeP8Y0tVLHozrnkZmLRWJiLWgE6xknTXrSMKGshM/rk55HUCDC5v2+dgzmTfgK17yisyquzJCMGRDG+K797c195OrVJ17YLKiFNqYZ3JO6ekandw7bv80TZzkFJ7BvYfkBb4fz1HQ1EXGpAwe4dCrPCR4Bd08C7lWABrP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AesDX6SI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719290513; x=1750826513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AEcb9uoqY+haPLqWfC41LsegM3/wAyvPwHBCs4Y7rZk=;
  b=AesDX6SIgv8qY3uowqE1y3aAxm5mZnjVeUHF6KvXxpHVeGqf4GaKgt8X
   wQCPEzfd9hHHP0JNfK4OcalXVw/JtuDFgmySn+JSl/60zKnwJAMv8P6VX
   Qdm+WqHDKhJ33sJv7gcGibjwFrNvhLmEj33goHJA4EdmvP1n/3R8kKPcs
   lOuk/ARPKMGCpAJVhfVZB5x0ARnCpUeFaZCKc02zwoGQhlymEQOQqhBcS
   A0HnHVvucQ7cZGCQZxNeAVRUrBmAyCMDDk4Gkp9vcYZrbtL/xcFKeBWHF
   MX4YRbgVy1YIIHxw6QOjwgfgNjbxgV0ZCZQyTX3nlq67cPVHNPhdCdl2m
   Q==;
X-CSE-ConnectionGUID: web/2JdSQUuaYE/4AbI9yQ==
X-CSE-MsgGUID: P5ogwqoHSwyuNKVJzlnhKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16164835"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16164835"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 21:41:52 -0700
X-CSE-ConnectionGUID: zgda8c7aSNSRIlf4R2jC8g==
X-CSE-MsgGUID: 4qs8bsahR3ei6/HzT5LCoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43390330"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 24 Jun 2024 21:41:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 1/1] iommu/vt-d: Downgrade warning for pre-enabled IR
Date: Tue, 25 Jun 2024 12:39:12 +0800
Message-Id: <20240625043912.258036-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Emitting a warning is overkill in intel_setup_irq_remapping() since the
interrupt remapping is pre-enabled. For example, there's no guarantee
that kexec will explicitly disable interrupt remapping before booting a
new kernel. As a result, users are seeing warning messages like below
when they kexec boot a kernel, though there is nothing wrong:

 DMAR-IR: IRQ remapping was enabled on dmar18 but we are not in kdump mode
 DMAR-IR: IRQ remapping was enabled on dmar17 but we are not in kdump mode
 DMAR-IR: IRQ remapping was enabled on dmar16 but we are not in kdump mode
 ... ...

Downgrade the severity of this message to avoid user confusion.

CC: Paul Menzel <pmenzel@molgen.mpg.de>
Link: https://lore.kernel.org/linux-iommu/5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/irq_remapping.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index e4a70886678c..e090ca07364b 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -597,8 +597,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 	if (ir_pre_enabled(iommu)) {
 		if (!is_kdump_kernel()) {
-			pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
-				iommu->name);
+			pr_info_once("IRQ remapping was enabled on %s but we are not in kdump mode\n",
+				     iommu->name);
 			clear_ir_pre_enabled(iommu);
 			iommu_disable_irq_remapping(iommu);
 		} else if (iommu_load_old_irte(iommu))
-- 
2.34.1


