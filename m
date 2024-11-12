Return-Path: <linux-kernel+bounces-405326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC59C4FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE11F2148D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B120E014;
	Tue, 12 Nov 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RijQOClj"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620A20DD45
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397565; cv=none; b=MsDN8u95sxR6zrg+0/FXlvAyRMPKmyJubpdXs00Kn9w52Dc3C/dbDGB1AF7bnVxUsp24AnKVx+LdnLysZn3SpYL9dZj758OrvPT3UXxYeqGOCpHzpwLviasrQZOZtTvdWNOGFwt3HXaAZr+Kan2x1XMuG+Fr8vrQAKKEw5FCuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397565; c=relaxed/simple;
	bh=vSXmYGGtW0f45md3LO6/fvpa0u6LzyoaIloZAN8fmVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biUF7cRaOiFVYBNF2b5xiCVDCH9LZ5/PxlaezCEPVztPLJn+mOD/2kBzDpssE1L+xl4I12JG/3g8udJKGoF+B/9O3e5sWm2ozp0jLgDnErUzUyLjr7KKyX1xEODPpPoZxEQ9og8dTc1+dEW5dVVZatysqKpsE35sSfUDHXgyVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RijQOClj; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731397560; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=mOCJluRojGIhiFhKxbeJdF6tM55rkRyZI48QBIuEF6A=;
	b=RijQOClj4iHpEULXd41QvhBbOxNvwNxshECWy3k7mFeJJNypwLek3QpQxu3YaEbKNrl2mSnz2K9+qtZebhihidTeHx80o3DBka3B11Xl2k1fXSTUIxXqVIWVdVeBen56HkLntucPpsdHcZmvlYAdBiF4tHVuIRRLx6fUpB+zSnQ=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WJGC0DF_1731397558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 12 Nov 2024 15:45:59 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm: shmem: add a kernel command line to change the default huge policy for tmpfs
Date: Tue, 12 Nov 2024 15:45:51 +0800
Message-Id: <64091a3d5a8c5edb0461fae203cfcf6f302a19ce.1731397290.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the tmpfs can allow to allocate any sized large folios, and the default
huge policy is still 'never'. Thus adding a new command line to change
the default huge policy will be helpful to use the large folios for tmpfs,
which is similar to the 'transparent_hugepage_shmem' cmdline for shmem.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 Documentation/admin-guide/mm/transhuge.rst    |  6 +++++
 mm/shmem.c                                    | 23 ++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b48d744d99b0..007e6cfada3e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6943,6 +6943,13 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
 
+	transparent_hugepage_tmpfs= [KNL]
+			Format: [always|within_size|advise|never]
+			Can be used to control the default hugepage allocation policy
+			for the tmpfs mount.
+			See Documentation/admin-guide/mm/transhuge.rst
+			for more details.
+
 	trusted.source=	[KEYS]
 			Format: <string>
 			This parameter identifies the trust source as a backend
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 5034915f4e8e..9ae775eaacbe 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -332,6 +332,12 @@ allocation policy for the internal shmem mount by using the kernel parameter
 seven valid policies for shmem (``always``, ``within_size``, ``advise``,
 ``never``, ``deny``, and ``force``).
 
+Similarly to ``transparent_hugepage_shmem``, you can control the default
+hugepage allocation policy for the tmpfs mount by using the kernel parameter
+``transparent_hugepage_tmpfs=<policy>``, where ``<policy>`` is one of the
+four valid policies for tmpfs (``always``, ``within_size``, ``advise``,
+``never``). The tmpfs mount default policy is ``never``.
+
 In the same manner as ``thp_anon`` controls each supported anonymous THP
 size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem``
 has the same format as ``thp_anon``, but also supports the policy
diff --git a/mm/shmem.c b/mm/shmem.c
index a3203cf8860f..021760e91cea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -548,6 +548,7 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 /* ifdef here to avoid bloating shmem.o when not necessary */
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
+static int tmpfs_huge __read_mostly = SHMEM_HUGE_NEVER;
 
 /**
  * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
@@ -4780,7 +4781,12 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbinfo->gid = ctx->gid;
 	sbinfo->full_inums = ctx->full_inums;
 	sbinfo->mode = ctx->mode;
-	sbinfo->huge = ctx->huge;
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	if (ctx->seen & SHMEM_SEEN_HUGE)
+		sbinfo->huge = ctx->huge;
+	else
+		sbinfo->huge = tmpfs_huge;
+#endif
 	sbinfo->mpol = ctx->mpol;
 	ctx->mpol = NULL;
 
@@ -5259,6 +5265,21 @@ static int __init setup_transparent_hugepage_shmem(char *str)
 }
 __setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
 
+static int __init setup_transparent_hugepage_tmpfs(char *str)
+{
+	int huge;
+
+	huge = shmem_parse_huge(str);
+	if (huge < 0) {
+		pr_warn("transparent_hugepage_tmpfs= cannot parse, ignored\n");
+		return huge;
+	}
+
+	tmpfs_huge = huge;
+	return 1;
+}
+__setup("transparent_hugepage_tmpfs=", setup_transparent_hugepage_tmpfs);
+
 static char str_dup[PAGE_SIZE] __initdata;
 static int __init setup_thp_shmem(char *str)
 {
-- 
2.39.3


