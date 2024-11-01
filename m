Return-Path: <linux-kernel+bounces-392601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4909B960F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E283A282AA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D741CC8B3;
	Fri,  1 Nov 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="p6BC5Tlk"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB721CC158;
	Fri,  1 Nov 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480291; cv=none; b=bLHCFzqoB2kjJU/9bnFTm30mc1b3l2FTUCULVv6p+qQP2NMSNCJP+TRYNi2dmxeIwakUJYICqbRO2MWt8/mI1ed03yERfmM3yPOL5sEGsH3H1pRCOOWJ/ldCmEz9oZLveRjLe6vF2EubxKu8xxOyC/AiwwEFhW9eO3L38pTWKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480291; c=relaxed/simple;
	bh=rSE9zcJLkMMGgws1yEaZNTSWmvxFHcQmfXpDGn/u1GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NwHm4VFkaUz7C6lHFdkfx+erVO1tShyj5oaCj+yLHzYGNJJwEB+8ekEyY7BdVGF9UG/TqYBWynRZBQ//HT8dnOsj60TISv9p4zyp3zvnVUgNY6q6dPkwktZSXPaTzeHznv6MpkYYG90xXSVW0KhiYg+6Wd05lvjth54dVsTuSME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=p6BC5Tlk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=O29dCXx+phviG21mQhq8obCWSt3spMP5spSqVzL91xU=; b=p6BC5TlkYl1DzocJbUreIvt+mi
	QUQiD0X/QqVmAhFfPnCZ0DyuPHPVxcnHzKJTX/fRHHEJVi+LWZZniaI6ZUEQdH8tf44MPaga+ZUMj
	ySQK/up940WgZ4PCL+0aZt81SPtTbPe9oEzbihUalr1uYIZZFReb3bpLOXAeFNZ9JsRkI95c639/U
	/OFsyRR2hq+0+T2EIGYWzWIuN4F98W+cBP3IYlg93OwCFZc3dXF5e1VnCLHa2O6CuPiXolUXFD4wJ
	KDoQlnKnfojnzTuBXLo/muxVEAlqtrxx68QdYsqySbyJyb+eU8uTTvBcDO/fQF6iKZeuwehieC/M0
	9f2QG4Iw==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uyD-000VPu-14; Fri, 01 Nov 2024 17:57:57 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v5 2/5] mm: shmem: control THP support through the kernel command line
Date: Fri,  1 Nov 2024 13:54:06 -0300
Message-ID: <20241101165719.1074234-4-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101165719.1074234-2-mcanal@igalia.com>
References: <20241101165719.1074234-2-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new kernel command line to control the hugepage allocation policy
for the internal shmem mount, ``transparent_hugepage_shmem``. The
parameter is similar to ``transparent_hugepage`` and has the following
format:

transparent_hugepage_shmem=<policy>

where ``<policy>`` is one of the seven valid policies available for
shmem.

Configuring the default huge page allocation policy for the internal
shmem mount can be beneficial for DRM GPU drivers. Just as CPU
architectures, GPUs can also take advantage of huge pages, but this is
possible only if DRM GEM objects are backed by huge pages.

Since GEM uses shmem to allocate anonymous pageable memory, having control
over the default huge page allocation policy allows for the exploration of
huge pages use on GPUs that rely on GEM objects backed by shmem.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 Documentation/admin-guide/mm/transhuge.rst    |  6 ++
 mm/shmem.c                                    | 72 +++++++++++++------
 3 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1666576acc0e..acabb04d0dd4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6926,6 +6926,13 @@
 			See Documentation/admin-guide/mm/transhuge.rst
 			for more details.
 
+	transparent_hugepage_shmem= [KNL]
+			Format: [always|within_size|advise|never|deny|force]
+			Can be used to control the hugepage allocation policy for
+			the internal shmem mount.
+			See Documentation/admin-guide/mm/transhuge.rst
+			for more details.
+
 	trusted.source=	[KEYS]
 			Format: <string>
 			This parameter identifies the trust source as a backend
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index abdf10a1c7db..9c6f6da612c4 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -326,6 +326,12 @@ PMD_ORDER THP policy will be overridden. If the policy for PMD_ORDER
 is not defined within a valid ``thp_anon``, its policy will default to
 ``never``.
 
+Similarly to ``transparent_hugepage``, you can control the hugepage
+allocation policy for the internal shmem mount by using the kernel parameter
+``transparent_hugepage_shmem=<policy>``, where ``<policy>`` is one of the
+seven valid policies for shmem (``always``, ``within_size``, ``advise``,
+``never``, ``deny``, and ``force``).
+
 Hugepages in tmpfs/shmem
 ========================
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 275251abd596..dfcc88ec6e34 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -582,24 +582,39 @@ static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 	}
 }
 
-#if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
+	int huge;
+
+	if (!str)
+		return -EINVAL;
+
 	if (!strcmp(str, "never"))
-		return SHMEM_HUGE_NEVER;
-	if (!strcmp(str, "always"))
-		return SHMEM_HUGE_ALWAYS;
-	if (!strcmp(str, "within_size"))
-		return SHMEM_HUGE_WITHIN_SIZE;
-	if (!strcmp(str, "advise"))
-		return SHMEM_HUGE_ADVISE;
-	if (!strcmp(str, "deny"))
-		return SHMEM_HUGE_DENY;
-	if (!strcmp(str, "force"))
-		return SHMEM_HUGE_FORCE;
-	return -EINVAL;
+		huge = SHMEM_HUGE_NEVER;
+	else if (!strcmp(str, "always"))
+		huge = SHMEM_HUGE_ALWAYS;
+	else if (!strcmp(str, "within_size"))
+		huge = SHMEM_HUGE_WITHIN_SIZE;
+	else if (!strcmp(str, "advise"))
+		huge = SHMEM_HUGE_ADVISE;
+	else if (!strcmp(str, "deny"))
+		huge = SHMEM_HUGE_DENY;
+	else if (!strcmp(str, "force"))
+		huge = SHMEM_HUGE_FORCE;
+	else
+		return -EINVAL;
+
+	if (!has_transparent_hugepage() &&
+	    huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
+		return -EINVAL;
+
+	/* Do not override huge allocation policy with non-PMD sized mTHP */
+	if (huge == SHMEM_HUGE_FORCE &&
+	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
+		return -EINVAL;
+
+	return huge;
 }
-#endif
 
 #if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
 static const char *shmem_format_huge(int huge)
@@ -5066,15 +5081,7 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 
 	huge = shmem_parse_huge(tmp);
 	if (huge == -EINVAL)
-		return -EINVAL;
-	if (!has_transparent_hugepage() &&
-			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
-		return -EINVAL;
-
-	/* Do not override huge allocation policy with non-PMD sized mTHP */
-	if (huge == SHMEM_HUGE_FORCE &&
-	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
-		return -EINVAL;
+		return huge;
 
 	shmem_huge = huge;
 	if (shmem_huge > SHMEM_HUGE_DENY)
@@ -5171,6 +5178,25 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
 	__ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, thpsize_shmem_enabled_store);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
+
+static int __init setup_transparent_hugepage_shmem(char *str)
+{
+	int huge;
+
+	huge = shmem_parse_huge(str);
+	if (huge == -EINVAL) {
+		pr_warn("transparent_hugepage_shmem= cannot parse, ignored\n");
+		return huge;
+	}
+
+	shmem_huge = huge;
+	return 1;
+}
+__setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
+
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 #else /* !CONFIG_SHMEM */
 
 /*
-- 
2.46.2


