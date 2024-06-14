Return-Path: <linux-kernel+bounces-215097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA86908E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3C6B2A306
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C6B1AC447;
	Fri, 14 Jun 2024 15:02:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B941AC442
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377367; cv=none; b=bqW5CEnmpYr9zBqfRA4p635sBYdMK43T9frFQt5VdPIcV7wDb0z4e82nbgFDOhqLAwLxzm2qFG0fY4tU9nbNy2RHxWsNJu1KTkVzkBV8hMxSmGZH+OS6aTNfoNdd0GUoMwv8sqZxYw5e5QZ67uY1dgpLgemWoXzQaNeZ1m40YMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377367; c=relaxed/simple;
	bh=XzyY1VYxH0Tt/pg7qvgDUvhr+hjVQGV0sJ/Tk5PDMEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QyhWbc3nxPsY8DH1EtrMdxaO7/zW7kesUxMumySnIGqWuLA2g5C63ib+Y0LPD8dtbRLe7B9bGb2+IxfNeTvd52nWJK+6U756+zUZB4cfk3hz62S9RyKg88MM1K5wXiJot8l1Ub3tf8h8rXbs5WPeELJVHS4mti2xtcVGD/U41Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C3B31BCA;
	Fri, 14 Jun 2024 08:03:10 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4223F5A1;
	Fri, 14 Jun 2024 08:02:42 -0700 (PDT)
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
Subject: [PATCH v3 29/38] x86/resctrl: Describe resctrl's bitmap size assumptions
Date: Fri, 14 Jun 2024 15:00:24 +0000
Message-Id: <20240614150033.10454-30-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240614150033.10454-1-james.morse@arm.com>
References: <20240614150033.10454-1-james.morse@arm.com>
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
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 include/linux/resctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index d67225f95ee1..3fc5f760e041 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,6 +26,17 @@ int proc_resctrl_show(struct seq_file *m,
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
 /**
  * enum resctrl_conf_type - The type of configuration.
  * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
-- 
2.39.2


