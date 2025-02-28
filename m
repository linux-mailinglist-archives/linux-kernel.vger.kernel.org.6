Return-Path: <linux-kernel+bounces-539356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDED4A4A363
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD1E189CE45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581C27A253;
	Fri, 28 Feb 2025 20:01:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E8027A242
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772877; cv=none; b=Kv4W+WyFnNPmPbhcH/SPwJvc/7epxZLipOFlCcZSITDb/IVqOQiHbsbzfJBC1PrktMNKHOMFVGrjfg3J31AT/++dGmSUstd6xzGxeoNHMbLUg71zpYNkGVmg9r8nMIIpQEH7Q0emS6hvdeLRVVQq+0hH33dg+T/BHR/4fcfx9ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772877; c=relaxed/simple;
	bh=XV8GbrYhWEoeIG+MGgdMn1SF9ftL2PaJc6LmxfsQ350=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LMJSF5OeG4pAZDHL6r94qpcWrvLsj6cW60YhZI7vStdqzZ+Z/pJ494R3AdJ+TpsDSW7EDY+hrFe4AiKFNDQY6T7ewbGnDVesrygY7cByEM7sqm92eFSlhXfbYO5pKzlw6NcQxFFG/DzDvZZxLWoBCQTNvo5mT1JNaKoHjY3PRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64D8919F0;
	Fri, 28 Feb 2025 12:01:30 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22F333F5A1;
	Fri, 28 Feb 2025 12:01:12 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com
Subject: [PATCH v7 21/49] x86/resctrl: Move mba_mbps_default_event init to filesystem code
Date: Fri, 28 Feb 2025 19:58:45 +0000
Message-Id: <20250228195913.24895-22-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mba_mbps_default_event is initialised base on whether mbm_local or
mbm_total is supported. In the case of both, it is initialised to
mbm_local. mba_mbps_default_event is initialised in core.c's
get_rdt_mon_resources(), while all the readers are in rdtgroup.c.

After this code is split into architecture specific and filesystem code,
get_rdt_mon_resources() remains part of the architecture code, which
would mean mba_mbps_default_event has to be exposed by the filesystem
code.

Move the initialisation to the filesystem's resctrl_mon_resource_init()

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/core.c    | 5 -----
 arch/x86/kernel/cpu/resctrl/monitor.c | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 943e4c56077b..2c352938d18d 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -925,11 +925,6 @@ static __init bool get_rdt_mon_resources(void)
 	if (!rdt_mon_features)
 		return false;
 
-	if (resctrl_arch_is_mbm_local_enabled())
-		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
-	else if (resctrl_arch_is_mbm_total_enabled())
-		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
-
 	return !rdt_get_mon_l3_config(r);
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 27d983121b0a..306b06ba32db 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1213,6 +1213,11 @@ int __init resctrl_mon_resource_init(void)
 					 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 	}
 
+	if (resctrl_arch_is_mbm_local_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_LOCAL_EVENT_ID;
+	else if (resctrl_arch_is_mbm_total_enabled())
+		mba_mbps_default_event = QOS_L3_MBM_TOTAL_EVENT_ID;
+
 	return 0;
 }
 
-- 
2.39.5


