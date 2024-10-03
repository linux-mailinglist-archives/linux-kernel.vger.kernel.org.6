Return-Path: <linux-kernel+bounces-349485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D4C98F6D9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEAD8B22D26
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939B1B85C7;
	Thu,  3 Oct 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AttPN6u9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A661AC445;
	Thu,  3 Oct 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982762; cv=none; b=F/8kVWa0lkZJ/Mnrt7gE/EVCXaj+YkcUUjuBLY/39gSBmQYKU5STfkC+5iNVgnODh52Kp+kdMLB561nZlimzm3iLNHcX5EzhGkiHMCxoZxZoNN3EMlNT2KZ9X2GeOk3xbBqOuFcoAgltPwavhqPby97KWKe0RbjVHBEeOZJudaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982762; c=relaxed/simple;
	bh=sDrMH2vMq/rOASOnomz+Tq6S88RIiBBasNCK7KSIlt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeOHGjK4iA+yqggGLBCUjXEw2wWy2VvbPm4Be4ggG78q+aAAGegmrNC0rPBEYgngbZY0Yb1Xkl+cDZ2CYeBrheSHLv9IWKMQ21Dm4xn2F+SbYruutMDPmFAS/DQIXddAO9CHDeuMWetSV6Xbt+dUDYwID6Fo0htK5kadCacpu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AttPN6u9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727982761; x=1759518761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDrMH2vMq/rOASOnomz+Tq6S88RIiBBasNCK7KSIlt4=;
  b=AttPN6u9NSfpQTGlFw/EXtE0QLzTLHSnUXvoz5RDiL7NjU/e2UvTBgV9
   3efeLTiEBzgcI67gaInrwL6H6uJFwR1t3OsBYM5j4T+wmx9LBbfG0mrYg
   r1LyeUZrRz7DCHiTiSxuBMqVgIDRG/GYHlQqGKJuFlF+/yxkII+Ndsaj8
   9V+zqrpzWKn8iQSweejKDzZ7nYHBCeq222/R2TL6WBp81HAnI1ivewsFT
   ZocV1V0tzJSzbZUXEcRsQcaV+apR1Ps0BPOPzgwvzvjOx1dIDXVYV8Qaf
   edC4Yn7fqrOStasGWoOdCf8Zxh/jkoD0Slo6NxLg/tRzEF6NDgpAQ/OBE
   w==;
X-CSE-ConnectionGUID: +KIIyio5R+GAFRR1j8VU8w==
X-CSE-MsgGUID: aJyNdKIETTuOVwIHH7dynQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27287533"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27287533"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:12:36 -0700
X-CSE-ConnectionGUID: TkfdpTCnR326mxjRWMqr0w==
X-CSE-MsgGUID: KPr0GTWXQl+BqWmZhg6stA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74031042"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:12:36 -0700
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	x86@kernel.org
Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v7 4/4] x86/resctrl: Add new "mba_MBps_event" mount option to documentation
Date: Thu,  3 Oct 2024 12:12:28 -0700
Message-ID: <20241003191228.67541-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241003191228.67541-1-tony.luck@intel.com>
References: <20241003191228.67541-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New mount option may be used to choose a specific memory bandwidth
monitoring event to feed the MBA Software Controller(mba_sc) feedback
loop.

Resctrl will automatically switch to using total memory bandwidth
on systems that do not support monitroing local bandwidth.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/arch/x86/resctrl.rst | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a824affd741d..ab0868713f4a 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -35,7 +35,8 @@ about the feature from resctrl's info directory.
 
 To use the feature mount the file system::
 
- # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resctrl
+ # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps] \
+ [,mba_MBps_event=[mbm_local_bytes|mbm_total_bytes]][,debug]] /sys/fs/resctrl
 
 mount options are:
 
@@ -44,8 +45,14 @@ mount options are:
 "cdpl2":
 	Enable code/data prioritization in L2 cache allocations.
 "mba_MBps":
-	Enable the MBA Software Controller(mba_sc) to specify MBA
-	bandwidth in MiBps
+	Use a software feedback loop from the memory bandwidth monitoring
+	feature to automatically adjust memory bandwidth allocation
+	throttling so that the user can specify MBA control values in MiBps.
+	Defaults to using MBM local bandwidth, but will use total bandwidth on
+	systems that do not support local bandwidth monitoring.
+"mba_MBps_event=[mbm_local_bytes|mbm_total_bytes]":
+	Enable the "mba_MBps" option with an explicitly chosen monitor
+	event as input to the software feedback loop.
 "debug":
 	Make debug files accessible. Available debug files are annotated with
 	"Available only with debug option".
@@ -561,16 +568,24 @@ increase or vary although user specified bandwidth percentage is same.
 In order to mitigate this and make the interface more user friendly,
 resctrl added support for specifying the bandwidth in MiBps as well.  The
 kernel underneath would use a software feedback mechanism or a "Software
-Controller(mba_sc)" which reads the actual bandwidth using MBM counters
-and adjust the memory bandwidth percentages to ensure::
+Controller(mba_sc)" which reads the actual bandwidth using either local
+or total memory bandwidth MBM counters and adjusts the memory bandwidth
+percentages to ensure::
 
 	"actual bandwidth < user specified bandwidth".
 
 By default, the schemata would take the bandwidth percentage values
 where as user can switch to the "MBA software controller" mode using
-a mount option 'mba_MBps'. The schemata format is specified in the below
+the mount option 'mba_MBps' or explicitly choose which MBM event with
+the 'mba_MBps_event' option. The schemata format is specified in the below
 sections.
 
+The software feedback mechanism uses measurement of local
+memory bandwidth to make adjustments to throttling levels. If a system
+is running applications with poor NUMA locality users may want to use
+the "mba_MBps_event=mbm_total_bytes" mount option which will use total
+memory bandwidth measurements instead of local.
+
 L3 schemata file details (code and data prioritization disabled)
 ----------------------------------------------------------------
 With CDP disabled the L3 schemata format is::
-- 
2.46.1


