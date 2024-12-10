Return-Path: <linux-kernel+bounces-440259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F959EBAE2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF66188263C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDED14E2CC;
	Tue, 10 Dec 2024 20:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSd3fOqZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5013BAE2;
	Tue, 10 Dec 2024 20:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862735; cv=none; b=C3QiL+DfE74Dv28weWo3boquTzwWEPa5LK1gLkP9alCyUE9hbVF+ZrIa2QnOlRuPqEaQeX+Va5XlPb/Oq5OeX1hGFPt2SbMFe7fNJmGKf2r/dn1amNbGGNxSZy2DHAEj4KZ3ohf+wYs/zc5XCjlXzcR3RJC60AHC7pqfHGM1x+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862735; c=relaxed/simple;
	bh=fRRT9H846MYj9Znz9D84KeZLYxPRIT7+mCTNq1vecr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EsS5TtGjhq9OJL2cgOeS5OGKo0SRNDQhN9OLe5rZnQSnt7fGQIfaXYTPvHr/BBPmd0HTeM0ZfXM5ztwCFBJdB47FQoSZfrEU9drF2IqwkJdTEOjP7Nc0b37OJlngzsjVRip6BSTmCJyOLZnRvOsNEnM/TKo9dmGomii7Q9zksi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSd3fOqZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862734; x=1765398734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fRRT9H846MYj9Znz9D84KeZLYxPRIT7+mCTNq1vecr8=;
  b=QSd3fOqZMDakTcQW6IkfIl7yPip5jps7K+c04tBjc8owxhvIABNxfBFd
   sKbNBsHNSLajRG7LWn3jshZCRr/HKV/R2nC5DXkr4JPwTJrZu//g6sDKo
   msebjXYs2ywM3DsH9EyEyvSCWCVbPtx8owacY7AUx4G/ehdcNie/73N2B
   PcSW9KrNeDns2JAVU6GWxpnFRoZ1aWplln9ROhSJ0O/3coAIBG2mrWN8G
   c0BXuAVcYpzm03OPbVgZ7NuedK5Lmlhhoqs5S4mR2D20UmfYx76i9sV0q
   IFLAj5O1p9dTdvVUPnDzC6vTr7pX4oMEBEvMvsxIgau34Gxajt95Wcr2v
   g==;
X-CSE-ConnectionGUID: SuoKx+FYQ/eaQI3CYH4MIQ==
X-CSE-MsgGUID: Mptv2n2yTV2ZE1DA7GChpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="44699211"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="44699211"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:32:14 -0800
X-CSE-ConnectionGUID: V7rGjv6CR/++4tUuT1PXfw==
X-CSE-MsgGUID: D7qJU8YpRk63IH3jcKxJcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126338564"
Received: from jithudellxeon.sc.intel.com ([172.25.103.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:32:13 -0800
From: Jithu Joseph <jithu.joseph@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	jithu.joseph@intel.com,
	tony.luck@intel.com,
	ashok.raj.linux@gmail.com
Subject: [PATCH] platform/x86/intel/ifs: Add Clearwater Forest to CPU support list
Date: Tue, 10 Dec 2024 12:31:52 -0800
Message-Id: <20241210203152.1136463-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Clearwater Forest (INTEL_ATOM_DARKMONT_X) to the x86 match table of
Intel In Field Scan (IFS) driver, enabling IFS functionality on this
processor.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index bc252b883210..1ae50702bdb7 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -20,6 +20,7 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 	X86_MATCH(INTEL_GRANITERAPIDS_X, ARRAY_GEN0),
 	X86_MATCH(INTEL_GRANITERAPIDS_D, ARRAY_GEN0),
 	X86_MATCH(INTEL_ATOM_CRESTMONT_X, ARRAY_GEN1),
+	X86_MATCH(INTEL_ATOM_DARKMONT_X, ARRAY_GEN1),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);

base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.34.1


