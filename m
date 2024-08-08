Return-Path: <linux-kernel+bounces-279221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B076994BAAB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D38201C21B39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11881189F41;
	Thu,  8 Aug 2024 10:17:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B68B12F5B1
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112231; cv=none; b=XglyY5jrf/FsoN7cyVcXPZ9NkydoEE/Fhre1m88Z4jrrZawNkMwVPyAcJ5meJAa7OCJsukIML6Cq5GAGuvxWr1TwYp1npLpVl8phbrxlwG4mdjrPzepzKjPTmuNIppZBtGBl5xnYHEZDcoHbzv40uxt8z9/OLMu7u1i95DXBCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112231; c=relaxed/simple;
	bh=eKlxAn3MykGZ1MtaksQ5eHbuEVwkUA+gtiqS1gNeapc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH2fgX/SiwWIO5sVjzR9dyKgZQvMsbsyAlg5SvE8fEWggbuCVweucO0L4LktIvsfhYSJIuGCVg+y0CriEZ+DV3u6no+Mj+khnYCVDS0mxMNsqu00uRe98i6ZyXp4Z6TO4W0q2aXbw+ZT0ngSWXaEPdQIu7hq0zbKhtTwMgromOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0443FEC;
	Thu,  8 Aug 2024 03:17:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA0EF3F766;
	Thu,  8 Aug 2024 03:17:07 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Thu,  8 Aug 2024 11:16:59 +0100
Message-ID: <20240808101700.571701-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add thp_anon= cmdline parameter to allow specifying the default
enablement of each supported anon THP size. The parameter accepts the
following format and can be provided multiple times to configure each
size:

thp_anon=<size>[KMG]:<value>

See Documentation/admin-guide/mm/transhuge.rst for more details.

Configuring the defaults at boot time is useful to allow early user
space to take advantage of mTHP before its been configured through
sysfs.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

Hi All,

I've split this off from my RFC at [1] because Barry highlighted that he would
benefit from it immediately [2]. There are no changes vs the version in that
series.

It applies against today's mm-unstable (275d686abcb59). (although I had to fix a
minor build bug in stackdepot.c due to MIN() not being defined in this tree).

Thanks,
Ryan


 .../admin-guide/kernel-parameters.txt         |  8 +++
 Documentation/admin-guide/mm/transhuge.rst    | 26 +++++++--
 mm/huge_memory.c                              | 55 ++++++++++++++++++-
 3 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bcdee8984e1f0..5c79b58c108ec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6631,6 +6631,14 @@
 			<deci-seconds>: poll all this frequency
 			0: no polling (default)

+	thp_anon=	[KNL]
+			Format: <size>[KMG]:always|madvise|never|inherit
+			Can be used to control the default behavior of the
+			system with respect to anonymous transparent hugepages.
+			Can be used multiple times for multiple anon THP sizes.
+			See Documentation/admin-guide/mm/transhuge.rst for more
+			details.
+
 	threadirqs	[KNL,EARLY]
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 24eec1c03ad88..f63b0717366c6 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -284,13 +284,27 @@ that THP is shared. Exceeding the number would block the collapse::

 A higher value may increase memory footprint for some workloads.

-Boot parameter
-==============
+Boot parameters
+===============

-You can change the sysfs boot time defaults of Transparent Hugepage
-Support by passing the parameter ``transparent_hugepage=always`` or
-``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
-to the kernel command line.
+You can change the sysfs boot time default for the top-level "enabled"
+control by passing the parameter ``transparent_hugepage=always`` or
+``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
+kernel command line.
+
+Alternatively, each supported anonymous THP size can be controlled by
+passing ``thp_anon=<size>[KMG]:<state>``, where ``<size>`` is the THP size
+and ``<state>`` is one of ``always``, ``madvise``, ``never`` or
+``inherit``.
+
+For example, the following will set 64K THP to ``always``::
+
+	thp_anon=64K:always
+
+``thp_anon=`` may be specified multiple times to configure all THP sizes as
+required. If ``thp_anon=`` is specified at least once, any anon THP sizes
+not explicitly configured on the command line are implicitly set to
+``never``.

 Hugepages in tmpfs/shmem
 ========================
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0c3075ee00012..c2c0da1eb94e6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+static bool anon_orders_configured;

 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -672,7 +673,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
 	 * constant so we have to do this here.
 	 */
-	huge_anon_orders_inherit = BIT(PMD_ORDER);
+	if (!anon_orders_configured) {
+		huge_anon_orders_inherit = BIT(PMD_ORDER);
+		anon_orders_configured = true;
+	}

 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
@@ -857,6 +861,55 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);

+static int __init setup_thp_anon(char *str)
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
+	    !(BIT(order) & THP_ORDERS_ALL_ANON))
+		goto out;
+
+	state++;
+
+	if (!strcmp(state, "always")) {
+		clear_bit(order, &huge_anon_orders_inherit);
+		clear_bit(order, &huge_anon_orders_madvise);
+		set_bit(order, &huge_anon_orders_always);
+		ret = 1;
+	} else if (!strcmp(state, "inherit")) {
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_madvise);
+		set_bit(order, &huge_anon_orders_inherit);
+		ret = 1;
+	} else if (!strcmp(state, "madvise")) {
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_inherit);
+		set_bit(order, &huge_anon_orders_madvise);
+		ret = 1;
+	} else if (!strcmp(state, "never")) {
+		clear_bit(order, &huge_anon_orders_always);
+		clear_bit(order, &huge_anon_orders_inherit);
+		clear_bit(order, &huge_anon_orders_madvise);
+		ret = 1;
+	}
+
+	if (ret)
+		anon_orders_configured = true;
+out:
+	if (!ret)
+		pr_warn("thp_anon=%s: cannot parse, ignored\n", str);
+	return ret;
+}
+__setup("thp_anon=", setup_thp_anon);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
--
2.43.0


