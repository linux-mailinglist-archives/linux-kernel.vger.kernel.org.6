Return-Path: <linux-kernel+bounces-350875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E0990AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1821C22DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEAF1DD896;
	Fri,  4 Oct 2024 18:05:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DEF1DD893
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065159; cv=none; b=WXC02FIEal3qAQQVRHuoOd24hgckzEQNLE4tP2YIL0dVCZ7pxwdKTmx9Vwv4gLaQ2iEfPJLTk+CGgFd8nwH7yMwiMgLxZAEoliB9704fIpFOHK6dFTwyjs8wUMb4N5cLCjJ/SpkPaZJvZhkibQed5TfwBhXFyTmDcR/+dZLF3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065159; c=relaxed/simple;
	bh=6BZAb2vUsJ/dRvuDFFaUk0iUxIHAgjVy8aTCbsATmOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhGlcz7MV4arcZZ/jYFqqWTcHjk3gv+ecgWTGZ4eTCD7U/IidqWomV9CEQ+d+uGBndBBxo34lqsOE4i559vOXNzWUEdCoEyAMBiDUP9eLWmFPDfceWduzyKC654NUXZlTsF1uhjzT56hpdqB7Yk4Ecme+kh8e8QJgurFMwPVKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41924339;
	Fri,  4 Oct 2024 11:06:27 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E19C3F58B;
	Fri,  4 Oct 2024 11:05:54 -0700 (PDT)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
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
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Subject: [PATCH v5 17/40] x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
Date: Fri,  4 Oct 2024 18:03:24 +0000
Message-Id: <20241004180347.19985-18-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The for_each_*_rdt_resource() helpers walk the architecture's array
of structures, using the resctrl visible part as an iterator. These
became over-complex when the structures were split into a
filesystem and architecture-specific struct. This approach avoided
the need to touch every call site, and was done before there was a
helper to retrieve a resource by rid.

Once the filesystem parts of resctrl are moved to /fs/, both the
architecture's resource array, and the definition of those structures
is no longer accessible. To support resctrl, each architecture would
have to provide equally complex macros.

Rewrite the macro to make use of resctrl_arch_get_resource(), and
move these to the core header so existing x86 arch code continues
to use them.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
Changes since v3:
 * Restructure the existing macros instead of open-coding the for loop.

Changes since v1:
 * [Whitespace only] Fix bogus whitespace introduced in
   rdtgroup_create_info_dir().

 * [Commit message only] Typo fix:
   s/architectures/architecture's/g
---
 arch/x86/kernel/cpu/resctrl/internal.h | 29 --------------------------
 include/linux/resctrl.h                | 18 ++++++++++++++++
 2 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4e2ec1fed2ff..a434daa6dba4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -472,14 +472,6 @@ extern struct rdt_hw_resource rdt_resources_all[];
 extern struct rdtgroup rdtgroup_default;
 extern struct dentry *debugfs_resctrl;
 
-static inline struct rdt_resource *resctrl_inc(struct rdt_resource *res)
-{
-	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(res);
-
-	hw_res++;
-	return &hw_res->r_resctrl;
-}
-
 static inline bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level l)
 {
 	return rdt_resources_all[l].cdp_enabled;
@@ -489,27 +481,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable);
 
 void arch_mon_domain_online(struct rdt_resource *r, struct rdt_mon_domain *d);
 
-/*
- * To return the common struct rdt_resource, which is contained in struct
- * rdt_hw_resource, walk the resctrl member of struct rdt_hw_resource.
- */
-#define for_each_rdt_resource(r)					      \
-	for (r = &rdt_resources_all[0].r_resctrl;			      \
-	     r <= &rdt_resources_all[RDT_NUM_RESOURCES - 1].r_resctrl;	      \
-	     r = resctrl_inc(r))
-
-#define for_each_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable || r->mon_capable)
-
-#define for_each_alloc_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->alloc_capable)
-
-#define for_each_mon_capable_rdt_resource(r)				      \
-	for_each_rdt_resource(r)					      \
-		if (r->mon_capable)
-
 /* CPUID.(EAX=10H, ECX=ResID=1).EAX */
 union cpuid_0x10_1_eax {
 	struct {
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 8894aed3c593..f75f0409ae09 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,6 +26,24 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
+/* Walk all possible resources, with variants for only controls or monitors. */
+#define for_each_rdt_resource(_r)						\
+	for ((_r) = resctrl_arch_get_resource(0);				\
+	     (_r)->rid < RDT_NUM_RESOURCES - 1;					\
+	     (_r) = resctrl_arch_get_resource((_r)->rid + 1))
+
+#define for_each_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->alloc_capable || (r)->mon_capable)
+
+#define for_each_alloc_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->alloc_capable)
+
+#define for_each_mon_capable_rdt_resource(r)				      \
+	for_each_rdt_resource((r))					      \
+		if ((r)->mon_capable)
+
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
-- 
2.39.2


