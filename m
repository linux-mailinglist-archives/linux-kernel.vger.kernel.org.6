Return-Path: <linux-kernel+bounces-386100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B899B3F21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82E31C224E3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3681759F;
	Tue, 29 Oct 2024 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bTdXTTpk"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCD5C96;
	Tue, 29 Oct 2024 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161456; cv=none; b=BWGyJMr/kdbC4Z4s4xN5/Bhh8NsZuRC6l00BNW+0SHRx8cRu/sex1tA0B/Xb5rIl0Ln39fd+hM5NzphQ+KGWxwb8U8v2StyHFOeM2o425ZNFVFbVZZguRD7PFAqcBeXA5KA+EpEvJHhPzrauaRUimoWTtkL9PGbqIi9/bQD20YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161456; c=relaxed/simple;
	bh=tgup4Naod+yHf6BvrZZdrcCIgk5Ku9Q8LXpTZKnnyKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcOywnHUZHHnjS16P4002QBpy+fijafFgvj1KyR+gjc6rhas7e31BykdsuTT6E6DIo1jr6+ctGZiMK/mbFPC7d2thVRgQJXAYYpkldxrpJ7gy6rhKXO5NmQgLGzS55VQotrSRceazcTazl3WzvsUAKVLK4iSLudGdRXE/dMblB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bTdXTTpk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=f8gjxek9e09f6K3wtJdNM5s9pyafMNTnPC2fusopxIU=; b=bTdXTTpkXCmQP+P7vIFB9/gVW5
	q6pgvxDrtE0mWPVomEbGVstuXNZsRkNV9ZEFtTqYfYuGDSRsXA9Pgx0FLw7D770Qi0mSaxnkqeXM+
	RLbnLEuYpUUxQe5JQ6Bf99l/dCpjqnCgEl+AS1FOpqj2/+ihN6K1jjf+q8hVMB25f1ni71wDtz4/1
	cmiqN7ToZQCDuSjpsQ3xSnSeBUdV+faRG6Jy09C1DdxOLAgUOlC5HLpNxDZB+VUncT0p+MFUgtEmB
	uN6wWULCJjf+7D03vrK3hGIXYdTC9lg/9yt0Pr278kRwmWREl6D+JAKJBjVa23jE3Ec79yFI/sheN
	XJAAHk7Q==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5a1a-00GIrd-1C; Tue, 29 Oct 2024 01:23:54 +0100
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v2 2/4] mm: shmem: control THP support through the kernel command line
Date: Mon, 28 Oct 2024 21:13:06 -0300
Message-ID: <20241029002324.1062723-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241029002324.1062723-1-mcanal@igalia.com>
References: <20241029002324.1062723-1-mcanal@igalia.com>
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

By configuring the default hugepage allocation policy for the internal
shmem mount, applications that use shmem, such as the DRM GEM objects,
can take advantage of mTHP before it's been configured through sysfs.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 Documentation/admin-guide/mm/transhuge.rst    |  6 +++
 mm/shmem.c                                    | 53 +++++++++++++++----
 3 files changed, 57 insertions(+), 9 deletions(-)

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
index 745055c3dc09..9b5b02c4d1ab 100644
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
index 44282a296c33..26c1eb1b4b1d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -582,7 +582,6 @@ static bool shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
 	}
 }
 
-#if defined(CONFIG_SYSFS)
 static int shmem_parse_huge(const char *str)
 {
 	if (!strcmp(str, "never"))
@@ -599,7 +598,6 @@ static int shmem_parse_huge(const char *str)
 		return SHMEM_HUGE_FORCE;
 	return -EINVAL;
 }
-#endif
 
 #if defined(CONFIG_SYSFS) || defined(CONFIG_TMPFS)
 static const char *shmem_format_huge(int huge)
@@ -624,6 +622,20 @@ static const char *shmem_format_huge(int huge)
 }
 #endif
 
+static int shmem_valid_huge(int huge)
+{
+	if (!has_transparent_hugepage() &&
+			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
+		return -EINVAL;
+
+	/* Do not override huge allocation policy with non-PMD sized mTHP */
+	if (huge == SHMEM_HUGE_FORCE &&
+	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
+		return -EINVAL;
+
+	return 0;
+}
+
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		struct shrink_control *sc, unsigned long nr_to_free)
 {
@@ -5070,14 +5082,10 @@ static ssize_t shmem_enabled_store(struct kobject *kobj,
 	huge = shmem_parse_huge(tmp);
 	if (huge == -EINVAL)
 		return -EINVAL;
-	if (!has_transparent_hugepage() &&
-			huge != SHMEM_HUGE_NEVER && huge != SHMEM_HUGE_DENY)
-		return -EINVAL;
 
-	/* Do not override huge allocation policy with non-PMD sized mTHP */
-	if (huge == SHMEM_HUGE_FORCE &&
-	    huge_shmem_orders_inherit != BIT(HPAGE_PMD_ORDER))
-		return -EINVAL;
+	err = shmem_valid_huge(huge);
+	if (err)
+		return err;
 
 	shmem_huge = huge;
 	if (shmem_huge > SHMEM_HUGE_DENY)
@@ -5174,6 +5182,33 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
 	__ATTR(shmem_enabled, 0644, thpsize_shmem_enabled_show, thpsize_shmem_enabled_store);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE && CONFIG_SYSFS */
 
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE)
+
+static int __init setup_transparent_hugepage_shmem(char *str)
+{
+	int huge, ret = 0;
+
+	if (!str)
+		goto out;
+
+	huge = shmem_parse_huge(str);
+	if (huge == -EINVAL)
+		goto out;
+
+	ret = shmem_valid_huge(huge);
+	if (ret)
+		goto out;
+
+	shmem_huge = huge;
+	return 1;
+out:
+	pr_warn("transparent_hugepage_shmem= cannot parse, ignored\n");
+	return ret;
+}
+__setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
+
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 #else /* !CONFIG_SHMEM */
 
 /*
-- 
2.46.2


