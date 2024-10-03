Return-Path: <linux-kernel+bounces-349486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199798F6DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181181F21CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF93C1B85D2;
	Thu,  3 Oct 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJDfZXwK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3101AC430;
	Thu,  3 Oct 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727982763; cv=none; b=ESEa14YPB596bEYLF2c7JR3t4dCPj5mJ8KVqvhVBgmjL2wZbl0EcGHxztpaL6qrlq2rZ0vlYQLsylYp7jFMrw7YUHQ/YVEhkr25MgAcT9dmTRZwM+2spb4GHipQC/Jc5Lt1g4VTTP/mn+jTcpXgX2tf/NHwGYLDgjnYBQP6urDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727982763; c=relaxed/simple;
	bh=WFYp1PXddKTWJGxTZoXlPEcHf+ZdNBvnk1nW5zmKgLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYJ+ExNWqnzKmLDUBVpVRBAd3KVeIS6oPC9lUhmcfBljyT5GK3DbsX6POb2VCS/Ujfkkx9UETVBRvZ1GwAbpOXyj7CZu0jj8p4o2mf/xnBi4j0C1IkBChfyD/sthOoFouhdMBGOeGX9EQpupVu1TAy9Ifh0dO3Nf1nhI75jVeJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJDfZXwK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727982760; x=1759518760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WFYp1PXddKTWJGxTZoXlPEcHf+ZdNBvnk1nW5zmKgLo=;
  b=LJDfZXwKYoIAkbKLHcdyv07OpAdLM7ksNb4dj01NL5iFcmS8qCExd/9h
   2Ij2xqpAj7vx5rL82iGngIxikc1qC7NjFDC1q9HQ4ZLzd1x/UL+TH7szO
   e3AvLcW1z/fZlNhAUEdme3oV6p/x0HYPe+7YEbqOkk/jph6NdhQhUriMk
   Jzvy3cn6cyQKBCq7FNjCm4b52f7ZbbM3xtJAlSbTZG/dwxt2+rsxmWW+R
   e7/SDuh8Sjs5wusx/hxQTIdPyLvlc3XtgHSGELD6f9gaWb5JM+/FHznnS
   ZMFbJb43X+vz36N8jN3odE89YZTbhGDiIkuTyzClAzO+51Hgjfw8lSD7D
   Q==;
X-CSE-ConnectionGUID: AtdttTkYREK+PkRe4DZRfA==
X-CSE-MsgGUID: iXrlg1r8QwOasMUVddNQPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27287520"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27287520"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 12:12:36 -0700
X-CSE-ConnectionGUID: 889iCSLsR2WR+Hs3qxH9sg==
X-CSE-MsgGUID: dZRYd7NrTE+lrZro4P23xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74031039"
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
Subject: [PATCH v7 3/4] x86/resctrl: Use total bandwidth for mba_MBps option when local isn't present
Date: Thu,  3 Oct 2024 12:12:27 -0700
Message-ID: <20241003191228.67541-4-tony.luck@intel.com>
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

On Intel systems the memory bandwidth monitoring events are
independently enumerated. It is possible for a system to support
total memory bandwidth monitoring, but not support local bandwidth
monitoring. On such a system a user could not enable mba_sc mode.

Modify the existing "mba_MBps" mount option to switch to total bandwidth
monitoring if local monitoring is not available.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 606cf635ea94..433daaa4d125 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2777,6 +2777,8 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return invalfc(fc, msg);
 		if (is_mbm_local_enabled())
 			ctx->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+		else if (is_mbm_total_enabled())
+			ctx->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
 		else
 			return invalfc(fc, msg);
 		ctx->enable_mba_mbps = true;
-- 
2.46.1


