Return-Path: <linux-kernel+bounces-254797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A91A9337A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD01D1C23255
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4861BDD0;
	Wed, 17 Jul 2024 07:13:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F22374E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721200396; cv=none; b=P8qvkrajKQiW8GDf0IxDQrMNUStXWn+dwMqfFz2qJI4OTtmhBhHceRrWA2hrrA4OaLliqy/d5oUhBm79i3Ql+hx56CX5Ho6Q7USfy/fy66PlY16xPhO6u8SDZE3phbbduNWrI8/NlK3eTrWkAjEBWTRcVkBk4FPUzlXoUf/Urho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721200396; c=relaxed/simple;
	bh=h2bLedQsMscin+6dfEPrEQ0xc9IFwpLqy032eDAW428=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcC1gsmZSuyZaeGz5Ry2XYsEBJHg/I4ToFwNAOTxy6iPwwifppov3WMe13Z0/rVkMkTKaZMRwgR4h9hztehZhipkX50B9nm2wN+T1bauLBPjBh3pGU2kxDmLHKF/ZxbXuzuNiX93qgq6RjEk8J5bb09+udSeBLJ141wscTBlaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FE991063;
	Wed, 17 Jul 2024 00:13:40 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0F1E43F762;
	Wed, 17 Jul 2024 00:13:12 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 4/4] mm: Override mTHP "file_enabled" defaults at kernel cmdline
Date: Wed, 17 Jul 2024 08:12:56 +0100
Message-ID: <20240717071257.4141363-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717071257.4141363-1-ryan.roberts@arm.com>
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add thp_file= cmdline parameter to allow specifying the default
enablement of each supported file-backed THP size. The parameter accepts
the following format and can be provided multiple times to configure
each size:

  thp_file=<size>[KMG]:<value>

See Documentation/admin-guide/mm/transhuge.rst for more details.

Configuring the defaults at boot time is often necessary because its not
always possible to drop active executable pages from the page cache,
especially if they are well used like libc. The command line parameter
allows configuring the values before the first page is installed in the
page cache.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 Documentation/admin-guide/mm/transhuge.rst    | 13 ++++++
 mm/huge_memory.c                              | 45 ++++++++++++++++++-
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 48443ad12e3f..e3e99def5691 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6600,6 +6600,14 @@
 			See Documentation/admin-guide/mm/transhuge.rst for more
 			details.
 
+	thp_file=	[KNL]
+			Format: <size>[KMG]:always|always+exec|never
+			Can be used to control the default behavior of the
+			system with respect to file-backed transparent hugepages.
+			Can be used multiple times for multiple file-backed THP
+			sizes. See Documentation/admin-guide/mm/transhuge.rst
+			for more details.
+
 	threadirqs	[KNL,EARLY]
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index f53d43d986e2..2379ed4ad085 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -333,6 +333,19 @@ required. If ``thp_anon=`` is specified at least once, any anon THP sizes
 not explicitly configured on the command line are implicitly set to
 ``never``.
 
+Each supported file-backed THP size can be controlled by passing
+``thp_file=<size>[KMG]:<state>``, where ``<size>`` is the THP size and
+``<state>`` is one of ``always``, ``always+exec`` or ``never``.
+
+For example, the following will set 64K THP to ``always+exec``::
+
+	thp_file=64K:always+exec
+
+``thp_file=`` may be specified multiple times to configure all THP sizes as
+required. If ``thp_file=`` is specified at least once, any file-backed THP
+sizes not explicitly configured on the command line are implicitly set to
+``never``.
+
 Hugepages in tmpfs/shmem
 ========================
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 794d2790d90d..4d963dde7aea 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -83,6 +83,7 @@ unsigned long huge_anon_orders_inherit __read_mostly;
 unsigned long huge_file_orders_always __read_mostly;
 int huge_file_exec_order __read_mostly = -1;
 static bool anon_orders_configured;
+static bool file_orders_configured;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -774,7 +775,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 	 * (and therefore THP_ORDERS_ALL_FILE_DEFAULT) isn't a compile-time
 	 * constant so we have to do this here.
 	 */
-	huge_file_orders_always = THP_ORDERS_ALL_FILE_DEFAULT;
+	if (!file_orders_configured) {
+		huge_file_orders_always = THP_ORDERS_ALL_FILE_DEFAULT;
+		file_orders_configured = true;
+	}
 
 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
@@ -1008,6 +1012,45 @@ static int __init setup_thp_anon(char *str)
 }
 __setup("thp_anon=", setup_thp_anon);
 
+static int __init setup_thp_file(char *str)
+{
+	unsigned long size;
+	char *state;
+	int order;
+	int ret = 0;
+
+	if (!str)
+		goto out;
+
+	size = (unsigned long)memparse(str, &state);
+	order = ilog2(size >> PAGE_SHIFT);
+	if (*state != ':' || !is_power_of_2(size) || size <= PAGE_SIZE ||
+	    !(BIT(order) & THP_ORDERS_ALL_FILE_DEFAULT))
+		goto out;
+
+	state++;
+
+	if (!strcmp(state, "always")) {
+		set_bit(order, &huge_file_orders_always);
+		ret = 1;
+	} else if (!strcmp(state, "always+exec")) {
+		set_bit(order, &huge_file_orders_always);
+		huge_file_exec_order = order;
+		ret = 1;
+	} else if (!strcmp(state, "never")) {
+		clear_bit(order, &huge_file_orders_always);
+		ret = 1;
+	}
+
+	if (ret)
+		file_orders_configured = true;
+out:
+	if (!ret)
+		pr_warn("thp_file=%s: cannot parse, ignored\n", str);
+	return ret;
+}
+__setup("thp_file=", setup_thp_file);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-- 
2.43.0


