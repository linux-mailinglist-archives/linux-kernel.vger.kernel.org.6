Return-Path: <linux-kernel+bounces-342086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB953988A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264CF2856A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E901C231E;
	Fri, 27 Sep 2024 18:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zo1LkZL/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF11C0DFB;
	Fri, 27 Sep 2024 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463168; cv=none; b=VgCeI5nFCtTqlDYrVr/hV4/YhPi+rIRyerUP/dvLc+wdkTeFbQYDJ76sipmVPBwSmIi6zyVhlrQwW9pTvyaiI36A1LC+MLkGawzs8gcwaK+Y4Dt6AQ5HtL9lIAMpcaaX6FUELyse1u5OJtP/7mKKuCOYcV8RH+5/k5n7dQ+JYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463168; c=relaxed/simple;
	bh=203UkJqxBjjkoqPoeWBy/1uekbBBYdPDC/ITMGd3trc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcpdxXP2gmUPlKe0TAadITrkc4aZVkRatCwm7/uGvfkn3x7VcaU70KbVITjv28OnwqPiNUWkh9lX35vxBj5+cB74fUNsm1kN3hu8pSLpfkDhbT+LwJXnHTViJDp/xq27rkzyDGoSh/ncHUOVzsvMh7ghmqflfHooXKQba9Kqqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zo1LkZL/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727463168; x=1758999168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=203UkJqxBjjkoqPoeWBy/1uekbBBYdPDC/ITMGd3trc=;
  b=Zo1LkZL/pWz4NMt/6dWZ080y6ibH1LFWeaHUWosgfttbqmYrXfH95OKH
   OKXPqX58khl1tpP6bbNyccwoF0AU+rakzvotg5tmDMoxr57hEu93emc1G
   1oHWAjuOnIitx+m2nWir4XlHb0qXya86R9dYMO3KCAeiO5LSoyXxHrJ+r
   RGl4j0cNCqT2S156fxYrmg1sBT01YjPmOs64Adg1fosFsY8Kgxqg5yqOF
   sxaT3r/WIA/bDTq2XYFJ5LspjkqRcpK+f16nj0pD1/vBwpyimPWUg/BC3
   NRV6BUXKp4APWSBKig0Y/f5vj7te55xAgFoItsyjqZGUo0PJaSQQ3PrTV
   Q==;
X-CSE-ConnectionGUID: 3TZgEbQmQk+dxoiJbqdAQw==
X-CSE-MsgGUID: 18rCCUrKRrKxdBc1o5+sSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26422049"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="26422049"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:52:48 -0700
X-CSE-ConnectionGUID: 8b47YgqmSPiNhZSZBaiugw==
X-CSE-MsgGUID: EKRSrMH8R+yj4Dslq7EwXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="103398126"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 11:52:47 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] Documentation: core-api/cpuhotplug: Fix missing prefix
Date: Fri, 27 Sep 2024 11:52:29 -0700
Message-ID: <20240927185229.2362599-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing cpuhp_ prefix in cpuhp_remove_multi_state().

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 Documentation/core-api/cpu_hotplug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index dcb0e379e5e8..33e8e80b5e00 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -616,7 +616,7 @@ ONLINE section for notifications on online and offline operation::
    ....
    cpuhp_remove_instance(state, &inst2->node);
    ....
-   remove_multi_state(state);
+   cpuhp_remove_multi_state(state);
 
 
 Testing of hotplug states
-- 
2.46.1


