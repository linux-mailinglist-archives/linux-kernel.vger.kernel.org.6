Return-Path: <linux-kernel+bounces-210920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E11904A35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0BBF1C23B51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 04:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC90282ED;
	Wed, 12 Jun 2024 04:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKjrNjIb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68352224C9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167663; cv=none; b=uaRi/UWzKSPCgJOMsuSHWzGSUaW7+DMsTW9dp5Gcoa/TBn/jCJCrv388HO5sFCyn7Xnru7SftXk9OZN4pH5xVumsLUlcAypzfBR5q5LnreJtx/jjentBau9JZA1YVX3lxSxzSDsLFMwzIjOkSMfYTM48EUousF5mZ93E/1PkpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167663; c=relaxed/simple;
	bh=DwOaQl3v4kXfyBw+OsCGIk1eo2nvMrlf7McHTzHa+40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I1OprKngicLn9vpY8Dg/8GVIqyIhw3JvznMkk1P+diUuKEzVjAw7BcsYjlziAEusbYS5evHHHcOju4tw+FtIQ+Nqi1gGhQbBXUjXsLwzHSTH9sI9pjhH+9JbzaUMdVez5cmAMWJv4JtT+vjq6D7/abqURyFLsRm3Sk28dwka1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKjrNjIb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718167661; x=1749703661;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=DwOaQl3v4kXfyBw+OsCGIk1eo2nvMrlf7McHTzHa+40=;
  b=EKjrNjIblNlrJ7SMZJ/QkQIAgxj5bp8OG6GyFAmVw/ysR0G24ySvXJWc
   k4Sl7FOasJzgyist/CkcuQhp0E2QA7cgYjs0LjDcqIb2uJEkX6Ff99ixO
   E2AP1KkYrD9kwiY8RRK73zW1SdGg0ENXPr5t6h6Ppyl3zh7IAOKa6zVT0
   A9U+on1tk23ZfQI0OCqBcTXUiycptbzqlfm51+ggzJ8QyHtw9p5UNDOhd
   pbBVIi2Ldj79Jjv1JK/CbrkWkIbDBTFCd4eZRlcc3gsRiaZiLSk5vaYz0
   9omQwQUEbwdzTeynxzS3DYHyIjY48hwWxlt2GyH1vCBzFlkUae1mgQvNw
   Q==;
X-CSE-ConnectionGUID: FQkuoO9qTRitQaKmYnv8Pg==
X-CSE-MsgGUID: AI1sFhL3RC2wgtH0OM88uw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15038684"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15038684"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:47:40 -0700
X-CSE-ConnectionGUID: arkobFfVQEynY0OdfwYIeA==
X-CSE-MsgGUID: Vq54Ex0LRrep1F5oIRtuhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39630490"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.213.170.70])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:47:39 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 11 Jun 2024 23:47:31 -0500
Subject: [PATCH] testing: nvdimm: Add MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-nvdimm-test-mod-warn-v1-1-4a583be68c17@intel.com>
X-B4-Tracking: v=1; b=H4sIAGIoaWYC/x3MQQqAIBBA0avErBvQjIyuEi1Mp5qFFhoWRHdPW
 r7F/w8kikwJhuqBSJkT76FA1hXYzYSVkF0xNKJpRSclhuzYezwpneh3h5eJAXu7aK1UJ2aloaR
 HpIXvfztO7/sBL1PC5GYAAAA=
To: nvdimm@lists.linux.dev
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718167658; l=1841;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=DwOaQl3v4kXfyBw+OsCGIk1eo2nvMrlf7McHTzHa+40=;
 b=ZG57LJpHjEvng6K4xUdJD9QsKjnJk8zQ84LIS2EZlf3lc9O9OLmWe+xKxyiXGQec7tOHXhbFL
 43sQTJ5p5T7Do5vn4Wob8GoIMKsVpGJBLWDbsw6X+G+jHO3c+JbRF0M
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

When building with W=1 the following errors are seen:

WARNING: modpost: missing MODULE_DESCRIPTION() in tools/testing/nvdimm/test/nfit_test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in tools/testing/nvdimm/test/ndtest.o

Add the required MODULE_DESCRIPTION() to the test platform device
drivers.

Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Jeff I'm not seeing a patch to cover these cases for the missing module
descriptions you have been sending out.  If you have an outstanding
patch I missed could you point me to it?  Otherwise I believe this
cleans up the nvdimm tree.
---
 tools/testing/nvdimm/test/ndtest.c | 1 +
 tools/testing/nvdimm/test/nfit.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index b438f3d053ee..892e990c034a 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -987,5 +987,6 @@ static __exit void ndtest_exit(void)
 
 module_init(ndtest_init);
 module_exit(ndtest_exit);
+MODULE_DESCRIPTION("Test non-NFIT devices");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("IBM Corporation");
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index a61df347a33d..cfd4378e2129 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -3382,5 +3382,6 @@ static __exit void nfit_test_exit(void)
 
 module_init(nfit_test_init);
 module_exit(nfit_test_exit);
+MODULE_DESCRIPTION("Test ACPI NFIT devices");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Intel Corporation");

---
base-commit: 2df0193e62cf887f373995fb8a91068562784adc
change-id: 20240611-nvdimm-test-mod-warn-8cf773360b37

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


