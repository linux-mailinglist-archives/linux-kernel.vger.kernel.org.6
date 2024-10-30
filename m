Return-Path: <linux-kernel+bounces-388731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488F9B63A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878341F21CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EAE1EB9F2;
	Wed, 30 Oct 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dZPbD1RG"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CA1E882A;
	Wed, 30 Oct 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293441; cv=none; b=NApk5mn9rf2yfeV17YLFeblEHvXYgVj+nEkCH+SWz5tWwwXHW4m/JdtcxW9LkdqJZHl5yPpSNtyJcaCAJtvL/D4Q843eryoFulRfgwSEs6St14fsjk8v9fgNV8DJQnKKQ6q/zKJSc8ecwa4nMAfWDY1d1u9yw+B1gozfUEfyd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293441; c=relaxed/simple;
	bh=WHDW6fX+oMXYCLEt0nAgO3gmMKuaWGuMvaqGUhibnzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRM8r6adN/8N+bJZbXzLME9VtAUOwWJbUhrmtaTA0ztXi6FxnppzQWYbWy5Qz31zfUa8r1x3sw7N3pmOCcEZ1xcCG/aR9ayDh9c88YMXemgr4dMMANdFJqTdhqAfnN/mGfOkQJK/2MHpwbKQnBV0Kz3P4p15rpOLUo1mlKXBbjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dZPbD1RG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KhLqGBl5TV6NmgS4fHCrJuFzbGHnT6xMy1eOztxHavg=; b=dZPbD1RG6pReVV1dOCJ0ApCQE/
	KzEL6y45ASLkh2mZ6IeR+Eujl9rct/rDPOZ83WttX0a2JnM/jPkILvD+T0CS1O5Olxar+9Q2txQgR
	Hc7ff5FWE9Pv3eP/oubI1C816wuK+LM1F3z7HDPPRJo/k+ewyEHQW40C1eA5cWEtpV3PsS/v5kRiD
	bO3sCfaKSyrrA29QeAjdQavHF/2hKaiS/ivzOOj6tjZo2dBqaxqJwpuPLPi5p45fhnWqIMePahczs
	k9qHbvmOgJ0DYa8a/yr0tvRmLhev8Hz6lhBu/O1TWP2/vvH5kVvfJOf7dp5iTMUL0AntC/DQuow/r
	qeguRXuQ==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t68MN-00H5h8-Qy; Wed, 30 Oct 2024 14:03:40 +0100
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
Subject: [PATCH v3 2/4] mm: shmem: control THP support through the kernel command line
Date: Wed, 30 Oct 2024 09:58:56 -0300
Message-ID: <20241030130308.1066299-3-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241030130308.1066299-1-mcanal@igalia.com>
References: <20241030130308.1066299-1-mcanal@igalia.com>
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


