Return-Path: <linux-kernel+bounces-342246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16043988C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D25B214E2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD111A01C4;
	Fri, 27 Sep 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KH7tfbX6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A5187845
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476248; cv=none; b=f9EaU70ny2OQplKlg2awzw2Stall+xYnvxx51slDqey2q+2Vsmnhjfw1ziLKrUL/F3UJtjyLUJmLiIxbPq8a8N3AKkCsNPtKLo/FVGgm8hA7kRGMsP3F9rK/IUTVYst2ofAZa1iPpcKlEVR+i10CtXUfA0LdyV0Q3P8QUUrzIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476248; c=relaxed/simple;
	bh=ttrfHsONvmaa5Z7pnzmIoVPeEJfe4KJEl+ZE4aGApVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCWMgiuUc1JX8lgOsRuf0kAqb9recXSCCwa1SykB1bmujc7mSn31sTi327U7/h9p3Z185EerL9E3WwAKYxQoxXloTxjuQKhIY56ODiQe6Xtk+Pfyjx9xiNzv/forhFQRlM/j5F9wV9TwWXpyKFojW0V8mArGrCYT+KAYTfvibgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KH7tfbX6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727476247; x=1759012247;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ttrfHsONvmaa5Z7pnzmIoVPeEJfe4KJEl+ZE4aGApVc=;
  b=KH7tfbX6ecoEfcqESwhmaD2S3Ef85iqfpYvrJSDJtEoD6A9CZigPuZAp
   bZPKcz+blY/PuvBSWYdzFCFA4JvsKQiaepJIKUUn9qibS/9w5m3If2ixP
   uy9PFG5pgX0kjEQDlxaY93PYD8G1VAjjhTaxhkI00BcAbzMKRkzV3hLzl
   8FsyxL3Ma8iJUczzXEJiou5Li87WHCby/VPoKgblCh8a7B18gIQY0JmHv
   GmHhRSGyJYe+/Q9n/LKfDuziBrMXGukNqxPbzlJMBjM+NniuGrtx9Mvrg
   mrV26q1Sf6pMsRe+QZjt3mmTSjy1LZAE+kzTGfVsU79URCyiESAv2MMYs
   Q==;
X-CSE-ConnectionGUID: IVf/0LI3T2Kmsp62g0RIeQ==
X-CSE-MsgGUID: URzbo2OiSFKoopV1y6AyaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="26733561"
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="26733561"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 15:30:46 -0700
X-CSE-ConnectionGUID: EDYsaBfWRfma+gVyaA/j8g==
X-CSE-MsgGUID: 2xMw5I4ETv2h88eUbwe7dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,159,1725346800"; 
   d="scan'208";a="72643552"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 15:30:46 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/resctrl: Do not round up mba_MBps values in schemata file
Date: Fri, 27 Sep 2024 15:30:38 -0700
Message-ID: <20240927223038.41198-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mba_MBps mount option is used Linux initializes the
MBA control values in the schemata file to MBA_MAX_MBPS (which
is defined as U32_MAX). So the schemata file contains this line:

 MB:0=4294967295;1=4294967295

If a user edits the schemata file with vi(1) (or other editor) and
simply writes that line back, it gets changed to:

  MB:0=   4;1=   4

which sets maximum bandwidth to a very low value.

This happens because bw_validate() unconditionally rounds user supplied
values up to next multiple of r->membw.bw_gran. That results in a value
that will not fit into d->mbps_val[closid].

Rounding up only makes sense when mba_MBps is not enabled and control
values are expressed as percentage values.

Skip the roundup() when mba_MBps is enabled.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..ac636366c0cb 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -55,7 +55,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
+	*data = is_mba_sc(r) ? bw : roundup(bw, (unsigned long)r->membw.bw_gran);
 	return true;
 }
 
-- 
2.46.1


