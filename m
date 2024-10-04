Return-Path: <linux-kernel+bounces-350890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC4B990AB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12922847C9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9FF21D2DB;
	Fri,  4 Oct 2024 18:06:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285A1E2843
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065202; cv=none; b=qKvHuJxGrXlEG5yMnXhki22X94pKvQ3IqXeiwqoN/a3Yc1YHQ6aOHvTOyf3EuxcJ8GrlQ0MCUXsg/wWE3S5p5shtoxd1KE9EkuCj5lGwuNVbck9qsk8MgBJI9fSkHXFrMsoNS5pKN3LO+juzS1ZWuQi31VaZ6nvVSJ3fzahp65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065202; c=relaxed/simple;
	bh=z3WrjgQvl0mDaNBnV7UtT2w81Avy9u+imYwNF8SNfYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=htVgymh6JaWNhhY52+fbmbz95OwDdBzrEY4wQ+RrMqiNKyK304MVfbTYzaMhQZ4ZM+9VL/h7mygC3xB/7vDRVbpxE+dXNjg+uRJNCwpIFCe3292wchxRsA3fDJL8LREumKGHR8DymO76vf2sGZ/V5Bb98P70yBFcBdlizxlTMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE8EC150C;
	Fri,  4 Oct 2024 11:07:10 -0700 (PDT)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 290EC3F58B;
	Fri,  4 Oct 2024 11:06:38 -0700 (PDT)
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
Subject: [PATCH v5 30/40] x86/resctrl: Describe resctrl's bitmap size assumptions
Date: Fri,  4 Oct 2024 18:03:37 +0000
Message-Id: <20241004180347.19985-31-james.morse@arm.com>
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

resctrl operates on configuration bitmaps and a bitmap of allocated
CLOSID, both are stored in a u32.

MPAM supports configuration/portion bitmaps and PARTIDs larger
than will fit in a u32.

Add some preprocessor values that make it clear why MPAM clamps
some of these values. This will make it easier to find code related
to these values if this resctrl behaviour ever changes.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 include/linux/resctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index bbce79190b13..7af6c40764ed 100644
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


