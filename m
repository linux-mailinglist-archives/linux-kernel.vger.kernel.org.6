Return-Path: <linux-kernel+bounces-370878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE739A3326
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604F5285120
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA4D15C13A;
	Fri, 18 Oct 2024 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsEKkSCY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59331153803;
	Fri, 18 Oct 2024 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729220667; cv=none; b=JGeDozaIFzHXWXDizSAI02/Dve7fVJM6BYhyIwIHf76bq51H0B1EeETD9BYHwY92pmlH3sAT991rnFGs518TAbHwW1Kbsb3QthlE0mgK5hn/OeP/djXDi3c3XkWG7BjGS2pv3abUpW6KNRq3+qIkGSPvNLj+w3Xd+JCSPbGloxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729220667; c=relaxed/simple;
	bh=djuchYQuBLuvo9UIkqsrjHzjsEE/wgloiTBbrI2vUaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YacF7k1feg3IzoymbvpWm0RTX74+oLZgM8yia1ZRDqi+O9EA1sGu9N3HLhi6vvX2kFu6RBIlIJxiTOjo2l4GE3rTCZ7ikTBffYbqTQQv+z9T6LzEmdh1VdslSa0JUDkJgA6kDgSlmajn0Ccd2TKJgsfAW1drllPb2Ud9i/4VAUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsEKkSCY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729220665; x=1760756665;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=djuchYQuBLuvo9UIkqsrjHzjsEE/wgloiTBbrI2vUaM=;
  b=CsEKkSCYaxskJ4GqTLXfRuydI3nJZ+yoPgEavslClgQ0QYw6XSkKe56C
   UAPRspxg2iG75uVjofve7lym55Y2SbB2pEXEgr994xNWDsJ3hwKGYzAeJ
   2IAiGbVU3Uhh6aUcSlaDpXVhv5z+ciYDs8j1beBwsFPvEdr2B7PKXNui1
   1/Vf0saTrO9ajEc2K4steA1Cq5Yjlg5cRTLYePtjIPv4HP87Jz3Bu1ZSX
   xlgZVU3u8mb3VO/iOYDHn5wxfNdekoPVqjs5ycyYQZd8357IpYVNglSc8
   Lh6wwGy9WBj95qK4gFBFNgpEMKShpj8+RWDID7pplNXWbLSSL9JLMgPMa
   g==;
X-CSE-ConnectionGUID: /zfJzASpRkmHGm6UTpb0+w==
X-CSE-MsgGUID: UsZ6sH6dSJm4GQdM+MtRFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39371207"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="39371207"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:04:01 -0700
X-CSE-ConnectionGUID: dY2UMfK0TNmMOxBJCroCdA==
X-CSE-MsgGUID: xiM8bEkASLyZ5H1Q+S4vLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="83812911"
Received: from mesiment-mobl2.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.125.109.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 20:04:01 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86/intel/pmc: Remove unnecessary ioremap
Date: Thu, 17 Oct 2024 20:03:56 -0700
Message-ID: <20241018030357.3580487-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241018030357.3580487-1-david.e.box@linux.intel.com>
References: <20241018030357.3580487-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmc_get_pmc() unnecessarily calls ioremap to access memory that is already
available through a variable passed in as an argument. Replace the
redundant ioremap call with direct use of the provided variable, and remove
the ioremap and iounmap calls.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core_ssram.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
index 70e03bd53740..d293e6e166e1 100644
--- a/drivers/platform/x86/intel/pmc/core_ssram.c
+++ b/drivers/platform/x86/intel/pmc/core_ssram.c
@@ -171,13 +171,7 @@ pmc_add_pmt(struct pmc_dev *pmcdev, u64 ssram_base, void __iomem *ssram)
 	u32 dvsec_offset;
 	u32 table, hdr;
 
-	ssram = ioremap(ssram_base, SSRAM_HDR_SIZE);
-	if (!ssram)
-		return;
-
 	dvsec_offset = readl(ssram + SSRAM_DVSEC_OFFSET);
-	iounmap(ssram);
-
 	dvsec = ioremap(ssram_base + dvsec_offset, SSRAM_DVSEC_SIZE);
 	if (!dvsec)
 		return;
-- 
2.43.0


