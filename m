Return-Path: <linux-kernel+bounces-346389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82B098C431
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBF1F22D2B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BC1CBEB4;
	Tue,  1 Oct 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwIg5iss"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534511C9EC4;
	Tue,  1 Oct 2024 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802513; cv=none; b=eyid71dwVpt2Wg1e10CImdFhrQEDOf4Q6ox+mEP9L3Lx3PNcffKLiHRRVaWJoJh8gifVJG7Pkj6P4rtiPuxgW1eKnJ6GqW/o6bIP+FXNYCFN4wFib+9RrV75cxiVOv5lFDqyIFWkerKkKSofEXQz/91+DBzfx8Z8ZIwEHV7Y8Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802513; c=relaxed/simple;
	bh=x9qS3OGnFSdonytmwL2yb0fSr6z3/lZCELKVc9njKzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RFaBvtV5b2dwo7nt8dqTBN11NnTqI1gSYoKU5DLgq50stG1VgYD/lKK0LgIm3vLcX4BG0QRVthDKb1mBgHy3HlcHcM+kaWJewCGoRRuPWprpNx7AkfbGAAOVjFG0fe4/EVFcu8LXGwbl97fVwVqIf0g9pqMmZwLbCtAIphNNqLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwIg5iss; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727802512; x=1759338512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x9qS3OGnFSdonytmwL2yb0fSr6z3/lZCELKVc9njKzs=;
  b=nwIg5issbubiZA3vByK6CwrxjlJ2y1G0jFbdpNmaJgoe/JAKLyvCS/vs
   wGPhbPNs5wreMfYi3bpo8DKozUd4ep54GrSLLtYnDUcYsYEIoiIs3Etvc
   B9uN/qhZJwn85PxNWu0ReYfFhYYBq+qEAuZNxjC1pPFfgmiX6mqgcCPdT
   C+hkcW7RJh/zxfBjQ+DaPcywvdJSc0y11u3XWxw/fG+ewcVNUvWz/aI/1
   cgo7JzcKYyM4cexJkzx0rsDecW6RDdP1bszB301QOQRp5S4YJXABcl9LN
   SjXNmWbc1V8zhzP3/ge/rjFgRTFhfyQsgrIIrHZD11G/xd34Moe1si0Qb
   Q==;
X-CSE-ConnectionGUID: 0hGXiFngQHmLCNRdfstbJw==
X-CSE-MsgGUID: 4O0PUHloTq2z9p7d3E61tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27042839"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27042839"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:08:27 -0700
X-CSE-ConnectionGUID: JoPpcILYRg2wEnYLPu82/w==
X-CSE-MsgGUID: ZAEfh2yYRfuIUszAx1AzHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="104557561"
Received: from jithudellxeon.sc.intel.com ([172.25.103.66])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 10:08:27 -0700
From: Jithu Joseph <jithu.joseph@intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	jithu.joseph@intel.com,
	tony.luck@intel.com,
	ashok.raj.linux@gmail.com
Subject: [PATCH] MAINTAINERS: Update Intel In Field Scan(IFS) entry
Date: Tue,  1 Oct 2024 10:08:08 -0700
Message-Id: <20241001170808.203970-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ashok is no longer with Intel and his e-mail address will start bouncing
soon.  Update his email address to the new one he provided to ensure
correct contact details in the MAINTAINERS file.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..89fb731384ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11496,7 +11496,7 @@ F:	include/uapi/linux/idxd.h
 
 INTEL IN FIELD SCAN (IFS) DEVICE
 M:	Jithu Joseph <jithu.joseph@intel.com>
-R:	Ashok Raj <ashok.raj@intel.com>
+R:	Ashok Raj <ashok.raj.linux@gmail.com>
 R:	Tony Luck <tony.luck@intel.com>
 S:	Maintained
 F:	drivers/platform/x86/intel/ifs

base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.34.1


