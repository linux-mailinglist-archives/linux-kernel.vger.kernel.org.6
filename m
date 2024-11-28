Return-Path: <linux-kernel+bounces-424343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CF9DB33C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B701677CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C614B945;
	Thu, 28 Nov 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VZi5KW16"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B23146A97
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732779664; cv=none; b=eSUmiC/dSG5WMWSstKBxjAdm90Okc3BQVh+9z+2pkEQhb6TpG8IuC/B9GnrbvftBbqPnG3ttW4f/EXUgjQnLJrHbRtR6t6oNI/M30m1vCzwfBLS2UYObl4kI66lNlBWOTfHQN3WcAXs61eE4aIhUsf+SCD/z9Yt7JRdBAL2Nr80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732779664; c=relaxed/simple;
	bh=KKs8n9SiIVFutlMptcdOlmFgvqAP2MvkuEKFRQEFfHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFp6D/FBspvLUIsLHhl/ZH3sZBn2PAWy2RPDIMVCVt4WIQBa/bWRU/sIHZcZJm/MyFkZy0E8BOD9oLrtoYDt/cYPnjuzURox8ALfHWFF3molMErJStPGdcMJdZV91TBWnlRQi/VQWYdRoIdlY5lL+UYK+1p9w9TQ9UG5t6EAxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VZi5KW16; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732779659; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UjYAYqlkSGfPZJ/FlT3GkxA+JCX542ZQmJh945HHSHc=;
	b=VZi5KW16nfnP/meeoupv4HZEf3oQKHma8eZykUmqdysyawBens3s5v63TdskS+LhxBPGFtcxTvGTby5ix/BifNVEqqJ9QgG+48xNbLwzIIX2aPCCV5vW14evxv8PF1qUo+e3Q5vAuJDfe6hUecH0mbu+thPiLO+HKDqVHuw39R8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WKP.Wl-_1732779657 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Nov 2024 15:40:58 +0800
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
Subject: [PATCH v3 4/6] mm: shmem: add a kernel command line to change the default huge policy for tmpfs
Date: Thu, 28 Nov 2024 15:40:42 +0800
Message-Id: <ff390b2656f0d39649547f8f2cbb30fcb7e7be2d.1732779148.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
References: <cover.1732779148.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the tmpfs can allow to allocate any sized large folios, and the default
huge policy is still preferred to be 'never'. Due to tmpfs not behaving like
other file systems in some cases as previously explained by David[1]:
"
I think I raised this in the past, but tmpfs/shmem is just like any
other file system .. except it sometimes really isn't and behaves much
more like (swappable) anonymous memory. (or mlocked files)

There are many systems out there that run without swap enabled, or with
extremely minimal swap (IIRC until recently kubernetes was completely
incompatible with swapping). Swap can even be disabled today for shmem
using a mount option.

That's a big difference to all other file systems where you are
guaranteed to have backend storage where you can simply evict under
memory pressure (might temporarily fail, of course).

I *think* that's the reason why we have the "huge=" parameter that also
controls the THP allocations during page faults (IOW possible memory
over-allocation). Maybe also because it was a new feature, and we only
had a single THP size.
"

Thus adding a new command line to change the default huge policy will be
helpful to use the large folios for tmpfs, which is similar to the
'transparent_hugepage_shmem' cmdline for shmem.

[1] https://lore.kernel.org/all/cbadd5fe-69d5-4c21-8eb8-3344ed36c721@redhat.com/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++++++
 Documentation/admin-guide/mm/transhuge.rst    |  6 +++++
 mm/shmem.c                                    | 23 ++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0ca670..e73383450240 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6987,6 +6987,13 @@
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
index 54eaa724c153..8a602fc61edb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -553,6 +553,7 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 /* ifdef here to avoid bloating shmem.o when not necessary */
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
+static int tmpfs_huge __read_mostly = SHMEM_HUGE_NEVER;
 
 /**
  * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
@@ -4951,7 +4952,12 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
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
 
@@ -5502,6 +5508,21 @@ static int __init setup_transparent_hugepage_shmem(char *str)
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


