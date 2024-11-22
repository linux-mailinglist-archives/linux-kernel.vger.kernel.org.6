Return-Path: <linux-kernel+bounces-418871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8529C9D6689
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4680E282EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B3A1DFE2B;
	Fri, 22 Nov 2024 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YVcbu7xR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FC1D9598;
	Fri, 22 Nov 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319925; cv=none; b=F+v6rjoqXBwG2OpRgIWH0CzXx7ljNDTT6UXdPQ9KThfpPMzpfrrH/uE5dxuktVQs+nrRiThSyBhR4ssHnAMpb5IZv6dAYCUYH/4EwFYB6kim4Ng7UTI4oWoBa8FS6PD1VFKdv1f98MxupuMEIW8yfEV1NANNEl9yq91mjv2hNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319925; c=relaxed/simple;
	bh=ysY/aIqy1UialU2bl9Cc0ocplEvrsKmpK3PGw6E++PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSVGWTSyWz3gJfdeoF/sTynKO3R3Gu+kD98z+lH8QIskyQvi5+90TYWQoFGfRksRWpfnnsM+xQpNzZEsRI3kaT2faxyhKdl6YLs9vJ2yfgTS1eATws2LkGW9AX0yBqExI+YNNfggmGCsbiXq/0MXGfVylwp9CS4oA++OSCkMX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YVcbu7xR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732319924; x=1763855924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysY/aIqy1UialU2bl9Cc0ocplEvrsKmpK3PGw6E++PY=;
  b=YVcbu7xR65wsWwgwdq7Zhdj4rleRYNl1t9XGhJkNrzDJn+RL8iFI7yCY
   +CnvjJpRQAhAqU/VGLXpNgt72diu32g0VLR6JkufRYw1UPQ/cJKopxbhb
   U/dNGUuZxiyjM7cWvbrbAahy4vxIBFAqW/J1RMI9KoXNREzT8jw+YdnwL
   I8MA3UHC4GitFfYYzQdQKcl7romsnV2DFujR9sR4fm6wqwyXa1Z4FkYqH
   27fjPOIi8OEWhhcjFd6Rl+5+GjXh4H04NRua05Ed2XVcaIGMsxP29ZJcT
   S3xJGVtbFk6lbXwzAuJAv2KHtGVlFWiLFSGEp2BmhcKU1inCYYn8UlHaA
   g==;
X-CSE-ConnectionGUID: a7bwt2BqTGyYdUT5AuwbOg==
X-CSE-MsgGUID: jghWpO5hQcyzpHZyKkdDoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32642755"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="32642755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:40 -0800
X-CSE-ConnectionGUID: KBW8D0VWQmuG/4fEO9nWCw==
X-CSE-MsgGUID: oeUJlIueQFyIJdm14Fagfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="90850916"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:58:39 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v10 7/8] x86/resctrl: Add write option to "mba_MBps_event" file
Date: Fri, 22 Nov 2024 15:58:31 -0800
Message-ID: <20241122235832.27498-8-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122235832.27498-1-tony.luck@intel.com>
References: <20241122235832.27498-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "mba_MBps" mount option provides an alternate method to control memory
bandwidth. Instead of specifying allowable bandwidth as a percentage of
maximum possible, the user provides a MiB/s limit value.

There is a file in each CTRL_MON group directory that shows the event
currently in use.

Allow writing that file to choose a different event.

A user can choose any of the memory bandwidth monitoring events listed in
/sys/fs/resctrl/info/L3_mon/mon_features independently for each CTRL_MON
group by writing to each of the "mba_MBps_event" files.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h    |  2 ++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 40 +++++++++++++++++++++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  3 +-
 3 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index ce10a883ecf8..6345ab3e0890 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -609,6 +609,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off);
 int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v);
 bool rdtgroup_cbm_overlaps(struct resctrl_schema *s, struct rdt_ctrl_domain *d,
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 5fa37b4ecc7a..536351159cc2 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -518,6 +518,46 @@ static int smp_mon_event_count(void *arg)
 	return 0;
 }
 
+ssize_t rdtgroup_mba_mbps_event_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	/* Valid input requires a trailing newline */
+	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+		return -EINVAL;
+	buf[nbytes - 1] = '\0';
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (!strcmp(buf, "mbm_local_bytes")) {
+		if (is_mbm_local_enabled())
+			rdtgrp->mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+		else
+			ret = -EINVAL;
+	} else if (!strcmp(buf, "mbm_total_bytes")) {
+		if (is_mbm_total_enabled())
+			rdtgrp->mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
+		else
+			ret = -EINVAL;
+	} else {
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		rdt_last_cmd_printf("Unsupported event id '%s'\n", buf);
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 int rdtgroup_mba_mbps_event_show(struct kernfs_open_file *of,
 				 struct seq_file *s, void *v)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 22265d3e238a..14fa6db578f4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1954,8 +1954,9 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mba_MBps_event",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_mba_mbps_event_write,
 		.seq_show	= rdtgroup_mba_mbps_event_show,
 	},
 	{
-- 
2.47.0


