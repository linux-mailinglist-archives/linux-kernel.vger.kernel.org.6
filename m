Return-Path: <linux-kernel+bounces-394080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C679BAA70
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A311B1F22504
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6573218E372;
	Mon,  4 Nov 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOqJbfSt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CC1632FD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684496; cv=none; b=qCNWF2yGYt2FpyT7JRBDMzcxp3QxfFMhEjEyjzNafk/qHeAJQfDZ8PHxlhzNdQZRKMKxCRJQDZSEFHUkUde3qjr3jf3cyAA/Whfe46Ct/CGAkKWBHTfBf5q2KG1A3NojBGHjxvyozgJ3Epd+xhNK7jwIMl1y6nw1GHtTZ3awK9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684496; c=relaxed/simple;
	bh=9Mo7wGqz6s7crUy5qVuQrT8coCrETc0vIKYA+xJAaKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KA1KUwrYemu6GDoqM+G+qozdCkO68lCntXlMpGDLlUZwr8FeTyJdhtsFo3bj16ieZYKvBjBoyPwC4+fXiLuf0or8NAd2rPlo1edwzOKmjiwPj/Go6vtMFjQ8GtUF0cIh2gkLAqeZFsWqq2kFhr+D9cmXenbXD10pWOC7ONbJzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOqJbfSt; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684495; x=1762220495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Mo7wGqz6s7crUy5qVuQrT8coCrETc0vIKYA+xJAaKc=;
  b=WOqJbfSt56IN9UnEV1/c9aIi3UATGM04EiHWRp2VdDDoP32wPEbOdwTP
   N3D2qrzLpuEOHaNkflFiczoDtkWw/uIPBb/KajYqI+iewd2JyztrU+cs+
   //qyvNTmuvSzzEuKb38f3YwOZl+g1glKd/YJSWKlW/eBdS0MBWKeVXFp6
   FBBoENNiDfDFP9PCFqQSVq1MNIKCoXrHZjUimM04eN1mxjEKdHWoIAe7a
   W8Hn8Eq7HmxABY2TPxa2fSc2tdGQjJm4Wtm1DEl6nbC324oS4+vqc1jRy
   R0u/MEvj67GNFyHxdHBUaLw3woanndNNZS+ksN0kG6sWPW48CxxmhmKld
   g==;
X-CSE-ConnectionGUID: 7itchcR3TniYlL3pIWp9ww==
X-CSE-MsgGUID: Nc1SijOwTIiOYEeJKmJDlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221934"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221934"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:35 -0800
X-CSE-ConnectionGUID: uKqJmu2aRlyLFuPqUxXnCQ==
X-CSE-MsgGUID: GTi+UJ5ITWCvA4fOgAqPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020887"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:34 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/19] iommu/vt-d: Increase buffer size for device name
Date: Mon,  4 Nov 2024 09:40:29 +0800
Message-ID: <20241104014040.106100-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

GCC is not happy with the current code, e.g.:

.../iommu/intel/dmar.c:1063:9: note: ‘sprintf’ output between 6 and 15 bytes into a destination of size 13
 1063 |         sprintf(iommu->name, "dmar%d", iommu->seq_id);

When `make W=1` is supplied, this prevents kernel building. Fix it by
increasing the buffer size for device name and use sizeoF() instead of
hard coded constants.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241014104529.4025937-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 2 +-
 drivers/iommu/intel/iommu.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index eaf862e8dea1..e16c2b1d7633 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1060,7 +1060,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		err = iommu->seq_id;
 		goto error;
 	}
-	sprintf(iommu->name, "dmar%d", iommu->seq_id);
+	snprintf(iommu->name, sizeof(iommu->name), "dmar%d", iommu->seq_id);
 
 	err = map_iommu(iommu, drhd);
 	if (err) {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f9fba9a26dac..79692d7a26d1 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -720,7 +720,7 @@ struct intel_iommu {
 	int		msagaw; /* max sagaw of this iommu */
 	unsigned int	irq, pr_irq, perf_irq;
 	u16		segment;     /* PCI segment# */
-	unsigned char 	name[13];    /* Device Name */
+	unsigned char	name[16];    /* Device Name */
 
 #ifdef CONFIG_INTEL_IOMMU
 	unsigned long 	*domain_ids; /* bitmap of domains */
-- 
2.43.0


