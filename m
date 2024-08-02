Return-Path: <linux-kernel+bounces-272928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D294628A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08AEB289CBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77EF1A34D6;
	Fri,  2 Aug 2024 17:31:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85291A34A0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619898; cv=none; b=YkNEgZ222Hpc4vE6IymcTad1oVbEKx2EAhtUnpmVfgsjSAFBxcwvav0QF3NW26grYhI2dDVG9LzzKiF5I7zEhQkj0o0Gu56vt1zKGmRvgMEbXki8X9+Lq0KIlFaau31BxDLzgow/AOopBZG+GplYPDh/VpKdrciXgxqHI9o3fYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619898; c=relaxed/simple;
	bh=jVVbBkHgu6EbzAdE0+KawabwZeijzPi0OVSAEju0ZWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2hgpW596ORe77EIm/k6ijz9Unm0WfKJGd2yO9VRiUNK9erNtYA7HLxe/kj+b39Hm95DezNrNFKyLlx6rCU/bDIQk+iYJNAg+Wc/ezIjJaripQ2+TFrDNB7S+x0ad9knAVBLQsGDFfgu06jsM68X7tHVK/H4+IlE71NjY6Y3mJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4421C165C;
	Fri,  2 Aug 2024 10:32:02 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A1DC3F64C;
	Fri,  2 Aug 2024 10:31:33 -0700 (PDT)
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
	Dave Martin <dave.martin@arm.com>
Subject: [PATCH v4 29/39] x86/resctrl: Describe resctrl's bitmap size assumptions
Date: Fri,  2 Aug 2024 17:28:43 +0000
Message-Id: <20240802172853.22529-30-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

resctrl operates on configuration bitmaps and a bitmap of allocated
CLOSID, both are stored in a u32.

MPAM supports configuration/portion bitmaps and PARTIDs larger
than will fit in a u32.

Add some preprocessor values that make it clear why MPAM clamps
some of these values. This will make it easier to find code related
to these values if this resctrl behaviour ever changes.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
 include/linux/resctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 31a28151193d..1ebf705ec3c5 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -27,6 +27,17 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
+/*
+ * Resctrl uses a u32 as a closid bitmap. The maximum closid is 32.
+ */
+#define RESCTRL_MAX_CLOSID		32
+
+/*
+ * Resctrl uses u32 to hold the user-space config. The maximum bitmap size is
+ * 32.
+ */
+#define RESCTRL_MAX_CBM			32
+
 /* Walk all possible resources, with variants for only controls or monitors. */
 #define for_each_rdt_resource(_r)						\
 	for ((_r) = resctrl_arch_get_resource(0);				\
-- 
2.39.2


