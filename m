Return-Path: <linux-kernel+bounces-272933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6246946290
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B90BB22F00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07941AB80A;
	Fri,  2 Aug 2024 17:31:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCA1AB7E7
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722619914; cv=none; b=aO/YQGG8j28AGR9K+9QZb+xEk+KuuwKEMeDOIkDyumURmEQzXOukhx0ty5zKd8YniRQxLzPUUuHydnSKUpyfUtlWTx717VNJnvvHW4iArLMcCiNQq0sr9IJ/JJL3+BKubPVIUoNNMa0DnbXggRCSMUFYPk31j4XyPMi7vTyPDFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722619914; c=relaxed/simple;
	bh=x8YilEwZUVKsc87DxGOOMNGEJvjKkJaVTSOQPkN7cr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a5hfISjyeeXH7b8JDXFGTdMGDjTQdfYhgiQk/VtygPk6Q23Ez1Lft1qT7uMZfKfiZiN91MGu6NvO5t+9rJf7iZ6waPXOb6YXSwaa8M1poYewiKIv7bL+2a4OcSUD4LHZeIiR7xBeMg7QjT8q4LnnGeoI1issvgrFa//C7Q515W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B0B31042;
	Fri,  2 Aug 2024 10:32:18 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B12303F64C;
	Fri,  2 Aug 2024 10:31:49 -0700 (PDT)
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
Subject: [PATCH v4 34/39] x86/resctrl: Add end-marker to the resctrl_event_id enum
Date: Fri,  2 Aug 2024 17:28:48 +0000
Message-Id: <20240802172853.22529-35-james.morse@arm.com>
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

The resctrl_event_id enum gives names to the counter event numbers on x86.
These are used directly by resctrl.

To allow the MPAM driver to keep an array of these the size of the enum
needs to be known.

Add a 'num_events' define which can be used to size an array. This isn't
a member of the enum to avoid updating switch statements that would
otherwise be missing a case.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
---
 include/linux/resctrl_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
index 51c51a1aabfb..70226f5ab3e3 100644
--- a/include/linux/resctrl_types.h
+++ b/include/linux/resctrl_types.h
@@ -51,4 +51,6 @@ enum resctrl_event_id {
 	QOS_L3_MBM_LOCAL_EVENT_ID	= 0x03,
 };
 
+#define QOS_NUM_EVENTS		(QOS_L3_MBM_LOCAL_EVENT_ID + 1)
+
 #endif /* __LINUX_RESCTRL_TYPES_H */
-- 
2.39.2


