Return-Path: <linux-kernel+bounces-247253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C863092CD27
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83350286616
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992013C685;
	Wed, 10 Jul 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUS0yKf4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B013213D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600604; cv=none; b=rM/xVdNMDV9rUImrJBpOMnzoR+MB8vIop1zmAW+vIgRHq3Mvzz27b8OSJU/JCHTHDAUfgNhene5AQizaFXw1TrtXggTKumWgUlFXKaaJ5kD0do0vMWpfae2dmcOYIKzWF7+IRFugW6qKbbSAuFZecm77xzfpamC4q8mQsDcNA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600604; c=relaxed/simple;
	bh=QE6yDlRdiuYRWqF9/WCzWvWO0J0BeZi/moyxfPUj4eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RfvJDQOdJyooVUBbo6RhacR7k4htTbC+JhyWHlnOPGioUPRJl6i1HjyZZYStTE7KqB24979o8WI186L9KVDNJ7vftzPj2WbYMI87RV1rmW+B4+bWT01rYqzD+D0wbGH9GfLAzFyIukTScoTlofFCArgeG2lsEJmv3ZsSzrkdqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUS0yKf4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600603; x=1752136603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QE6yDlRdiuYRWqF9/WCzWvWO0J0BeZi/moyxfPUj4eE=;
  b=EUS0yKf4ADmIhJ3diYkq7jo+heWF7KmAQygGkaJuhj2ulIc/V9jA47gS
   YqW3Px7a7mUqmyBjMv2td6jAqb40nSIys2zzL8sVYwk2HSR2r0IKYpQNx
   8P58UYfneh+4Fw2h+wxTIV6Jhjztr2UMJxBIuhY/pMZycdMuEHuUkzXvN
   Vp16StcYMHBAr+1bnwV3Af/J3jI4q2g0KIJJu2hqsk3uUuN8srj6Cti6a
   xQaYwfx9KxBxmNbRpaqXLyDXSVpypP110kOB2xwD/8W4cMi8M8PhdStqn
   J0NH1wBHkNK89kbA1wQNx7JC9SC1nhRkTNd9pvK4c7BQiPkxHvf3KNRGK
   A==;
X-CSE-ConnectionGUID: AfJNwO1RRXqjzFtucDjqVw==
X-CSE-MsgGUID: nPz7xGk6R1eEbaBhDJAAlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770981"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770981"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:42 -0700
X-CSE-ConnectionGUID: 7Idk2f7NQdOGX7N/MG4Jdw==
X-CSE-MsgGUID: ndSlM5TFQCWk1L1ooNVDrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236160"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/3] iommufd: Add check on user response code
Date: Wed, 10 Jul 2024 16:33:40 +0800
Message-Id: <20240710083341.44617-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710083341.44617-1-baolu.lu@linux.intel.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The response code from user space is only allowed to be SUCCESS or
INVALID. All other values are treated by the device as a response
code of Response Failure according to PCI spec, section 10.4.2.1.
This response disables the Page Request Interface for the Function.

Add a check in iommufd_fault_fops_write() to avoid invalid response
code.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 54d6cd20a673..044b9b97da31 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -305,6 +305,12 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		if (rc)
 			break;
 
+		if (response.code != IOMMUFD_PAGE_RESP_SUCCESS &&
+		    response.code != IOMMUFD_PAGE_RESP_INVALID) {
+			rc = -EINVAL;
+			break;
+		}
+
 		group = xa_erase(&fault->response, response.cookie);
 		if (!group) {
 			rc = -EINVAL;
-- 
2.34.1


