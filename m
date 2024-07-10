Return-Path: <linux-kernel+bounces-247252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D792CD26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303A41C2337D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D9112FF63;
	Wed, 10 Jul 2024 08:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2s5EvpI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE985947
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600599; cv=none; b=gWy6Ebvc3qs6kO1Woaba+9rMpegGoG3ouNky9/2Z3esu4VKNAn8t3WretfOp4LikvkZEYFfzzg1vHrIe+wlrh9tYs06gfjlzJ/yOUmGYAq4hc+UFtspFMjXcMoVeWvYZQA9At/g6RfjMI0tdoRjm7CqT6C53ew101NLVsRsTmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600599; c=relaxed/simple;
	bh=evQLV0pO07i+iE+j9o5IcO3BTGx5gXIQVZCSP53bD4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a7bjA+merRyUdC6w2CfsdjrVrAfBVbWMAGA8V9NFq5YwDG/Bwc+smvRTLVIYzDB62rC+fd2xHMYfwG5AdjME5I8n2B9LybMOeAfuZidfH7yZxxD2ugC/9WmIsY54llRKrTWYqQ72cpWi0J8oSHkHN9UvBOSTaPLUYWor7w90Ch8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2s5EvpI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600598; x=1752136598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=evQLV0pO07i+iE+j9o5IcO3BTGx5gXIQVZCSP53bD4c=;
  b=i2s5EvpIrGL8PWLMrKJ6Yokec1BEZ0w7tcIApQ8NiQ2oeqybRp+87Fvv
   pS4wEiV2kPVPYYdPVxYKSwhtTchm6+omXGeCGP7mxtEhivwnTy1Ohxgy5
   TKFUzzV/uZDL0uwPwjjX9e2mu5/t8SaGZgZhbhOk1j3QcAGG2gdSDdPvL
   VbiDhCoQ/3viOjlfm123Fs9ew454Jg5sKatNHOOKecB2/R136vXqAICqO
   HCyRcvTPKpjNa/tjpXZhAf7O5Ut5KRWmuSLBaDFpkgTNeC9xmceftnPC8
   XFBJOhoWWZ0/9rno3S2jdoVphGJ+RZ1Hdvt+JzmAendhv3On8LmHvb4m4
   g==;
X-CSE-ConnectionGUID: j72UTGOGQ1S1Y0cUAKeo4Q==
X-CSE-MsgGUID: wJC+cFU+TMaOu1Z0oo82IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17770965"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="17770965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:37 -0700
X-CSE-ConnectionGUID: VbKz419FR6GpZFxj3Xqo7Q==
X-CSE-MsgGUID: P3YDkvMtSiSWQygHyqEpHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48236135"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 10 Jul 2024 01:36:35 -0700
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
Subject: [PATCH 1/3] iommufd: Remove IOMMUFD_PAGE_RESP_FAILURE
Date: Wed, 10 Jul 2024 16:33:39 +0800
Message-Id: <20240710083341.44617-2-baolu.lu@linux.intel.com>
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

The response code of IOMMUFD_PAGE_RESP_FAILURE was defined to be
equivalent to the "Response Failure" in PCI spec, section 10.4.2.1.
This response code indicates that one or more pages within the
associated request group have encountered or caused an unrecoverable
error. Therefore, this response disables the PRI at the function.

Modern I/O virtualization technologies, like SR-IOV, share PRI among
the assignable device units. Therefore, a response failure on one unit
might cause I/O failure on other units.

Remove this response code so that user space can only respond with
SUCCESS or INVALID. The VMM is recommended to emulate a failure response
as a PRI reset, or PRI disable and changing to a non-PRI domain.

Fixes: c714f15860fc ("iommufd: Add fault and response message definitions")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/uapi/linux/iommufd.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index ede2b464a761..e31385b75d0b 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -765,14 +765,10 @@ struct iommu_hwpt_pgfault {
  * @IOMMUFD_PAGE_RESP_INVALID: Could not handle this fault, don't retry the
  *                             access. This is the "Invalid Request" in PCI
  *                             10.4.2.1.
- * @IOMMUFD_PAGE_RESP_FAILURE: General error. Drop all subsequent faults from
- *                             this device if possible. This is the "Response
- *                             Failure" in PCI 10.4.2.1.
  */
 enum iommufd_page_response_code {
 	IOMMUFD_PAGE_RESP_SUCCESS = 0,
 	IOMMUFD_PAGE_RESP_INVALID,
-	IOMMUFD_PAGE_RESP_FAILURE,
 };
 
 /**
-- 
2.34.1


