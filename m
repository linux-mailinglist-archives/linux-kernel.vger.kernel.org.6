Return-Path: <linux-kernel+bounces-388729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1509B63A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606FD1C20CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAD1EABA5;
	Wed, 30 Oct 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="BW9uTa1p"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED751E3DD8;
	Wed, 30 Oct 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293440; cv=none; b=g03UYsf2LctQK8e3ZvDXQRbTdD7AYlyMxujvKn44Gr+JPSXrMb+h1evK3kfcD70T0EiBhbNBVlETb6jBZa3mVDJ42pJFpo69tRGkJKYHKzAC0pMOFRQviim/ok9/Hbb2EtVwcwoJbcgwedxMbI+Hr9kDVbo8QLWNlo7z2NySryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293440; c=relaxed/simple;
	bh=3BdWMCxoyfe+3Y1LDRhREBxO/8sHpeJgxr5Vut4kmsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4tZvY58G+bxk4KgXyxntjOnv9WW5ZfRzC5N80LjA58vqfUOeZCEw4YqYV1qS1WZ35tchuqz8Ktp+6YtLFd1s30MeptScXGpyHZ7PtYPFHyg4qNu2ZVv0dFujxx3B2oYjoUINs/y3CwRp6k2Ac1xLpr6oZdHxdZgBG/VOOyZheM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=BW9uTa1p; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Jtek6fKyThwdm08oQdbY7JhOEaPOoD9jVitbx9tAXxg=; b=BW9uTa1pzhUhZZqbRwkIsyDC59
	1Vq8aXhWnRUGP5lrQnw5L7p1Vw3ReEVgwhFAZ2xp22wBF5oaGWLGz9poI+qn3mFlP7o+cnWktvUk/
	KCWRXISj+4FJGASbNU583nK9FN7wkCJN4R3rcUWMISmkh3J6wOL/o6HpCfVR38FwDJcZxfQxUdAPu
	rFgp38z4cxZT/UVT/5HwNnArqbcTd4I1KBGdQgrBF5lz1aS7f3FXuO7r3arhcs1Gl25VQoedCL0D0
	BgDs9vVSFC6i7FA4L9xMwky7mIlwctV9KyDdf1h6d7DrDg5pQYE9LjUDfMcCCliiDh2unDt11jW1T
	jIYYyPYA==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t68MT-00H5h8-4T; Wed, 30 Oct 2024 14:03:45 +0100
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
Subject: [PATCH v3 3/4] mm: shmem: override mTHP shmem default with a kernel parameter
Date: Wed, 30 Oct 2024 09:58:57 -0300
Message-ID: <20241030130308.1066299-4-mcanal@igalia.com>
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

Add the ``thp_shmem=`` kernel command line to allow specifying the
default policy of each supported shmem hugepage size. The kernel parameter
accepts the following format:

thp_shmem=<size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>

For example,

thp_shmem=16K-64K:always;128K,512K:inherit;256K:advise;1M-2M:never;4M-8M:within_size

By configuring the default policy of several shmem hugepages, the user
can take advantage of mTHP before it's been configured through sysfs.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 .../admin-guide/kernel-parameters.txt         |  10 ++
 Documentation/admin-guide/mm/transhuge.rst    |  17 +++
 mm/shmem.c                                    | 109 +++++++++++++++++-
 3 files changed, 135 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index acabb04d0dd4..b48d744d99b0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6700,6 +6700,16 @@
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
 
+	thp_shmem=	[KNL]
+			Format: <size>[KMG],<size>[KMG]:<policy>;<size>[KMG]-<size>[KMG]:<policy>
+			Control the default policy of each hugepage size for the
+			internal shmem mount. <policy> is one of policies available
+			for the shmem mount ("always", "inherit", "never", "within_size",
+			and "advise").
+			It can be used multiple times for multiple shmem THP sizes.
+			See Documentation/admin-guide/mm/transhuge.rst for more
+			details.
+
 	topology=	[S390,EARLY]
 			Format: {off | on}
 			Specify if the kernel should make use of the cpu
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 9b5b02c4d1ab..47e7fc30e22d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -332,6 +332,23 @@ allocation policy for the internal shmem mount by using the kernel parameter
 seven valid policies for shmem (``always``, ``within_size``, ``advise``,
 ``never``, ``deny``, and ``force``).
 
+In the same manner as ``thp_anon`` controls each supported anonymous THP
+size, ``thp_shmem`` controls each supported shmem THP size. ``thp_shmem``
+has the same format as ``thp_anon``, but also supports the policy
+``within_size``.
+
+``thp_shmem=`` may be specified multiple times to configure all THP sizes
+as required. If ``thp_shmem=`` is specified at least once, any shmem THP
+sizes not explicitly configured on the command line are implicitly set to
+``never``.
+
+``transparent_hugepage_shmem`` setting only affects the global toggle. If
+``thp_shmem`` is not specified, PMD_ORDER hugepage will default to
+``inherit``. However, if a valid ``thp_shmem`` setting is provided by the
+user, the PMD_ORDER hugepage policy will be overridden. If the policy for
+PMD_ORDER is not defined within a valid ``thp_shmem``, its policy will
+default to ``never``.
+
 Hugepages in tmpfs/shmem
 ========================
 
diff --git a/mm/shmem.c b/mm/shmem.c
index dfcc88ec6e34..c2299fa0b345 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -136,6 +136,7 @@ static unsigned long huge_shmem_orders_always __read_mostly;
 static unsigned long huge_shmem_orders_madvise __read_mostly;
 static unsigned long huge_shmem_orders_inherit __read_mostly;
 static unsigned long huge_shmem_orders_within_size __read_mostly;
+static bool shmem_orders_configured __initdata;
 #endif
 
 #ifdef CONFIG_TMPFS
@@ -5027,7 +5028,8 @@ void __init shmem_init(void)
 	 * Default to setting PMD-sized THP to inherit the global setting and
 	 * disable all other multi-size THPs.
 	 */
-	huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
+	if (!shmem_orders_configured)
+		huge_shmem_orders_inherit = BIT(HPAGE_PMD_ORDER);
 #endif
 	return;
 
@@ -5180,6 +5182,26 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 
+static inline int get_order_from_str(const char *size_str)
+{
+	unsigned long size;
+	char *endptr;
+	int order;
+
+	size = memparse(size_str, &endptr);
+
+	if (!is_power_of_2(size))
+		goto err;
+	order = get_order(size);
+	if (BIT(order) & ~THP_ORDERS_ALL_FILE_DEFAULT)
+		goto err;
+
+	return order;
+err:
+	pr_err("invalid size %s in thp_shmem boot parameter\n", size_str);
+	return -EINVAL;
+}
+
 static int __init setup_transparent_hugepage_shmem(char *str)
 {
 	int huge;
@@ -5195,6 +5217,91 @@ static int __init setup_transparent_hugepage_shmem(char *str)
 }
 __setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
 
+static char str_dup[PAGE_SIZE] __initdata;
+static int __init setup_thp_shmem(char *str)
+{
+	char *token, *range, *policy, *subtoken;
+	unsigned long always, inherit, madvise, within_size;
+	char *start_size, *end_size;
+	int start, end, nr;
+	char *p;
+
+	if (!str || strlen(str) + 1 > PAGE_SIZE)
+		goto err;
+	strscpy(str_dup, str);
+
+	always = huge_shmem_orders_always;
+	inherit = huge_shmem_orders_inherit;
+	madvise = huge_shmem_orders_madvise;
+	within_size = huge_shmem_orders_within_size;
+	p = str_dup;
+	while ((token = strsep(&p, ";")) != NULL) {
+		range = strsep(&token, ":");
+		policy = token;
+
+		if (!policy)
+			goto err;
+
+		while ((subtoken = strsep(&range, ",")) != NULL) {
+			if (strchr(subtoken, '-')) {
+				start_size = strsep(&subtoken, "-");
+				end_size = subtoken;
+
+				start = get_order_from_str(start_size);
+				end = get_order_from_str(end_size);
+			} else {
+				start = end = get_order_from_str(subtoken);
+			}
+
+			if (start < 0 || end < 0 || start > end)
+				goto err;
+
+			nr = end - start + 1;
+			if (!strcmp(policy, "always")) {
+				bitmap_set(&always, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else if (!strcmp(policy, "advise")) {
+				bitmap_set(&madvise, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else if (!strcmp(policy, "inherit")) {
+				bitmap_set(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else if (!strcmp(policy, "within_size")) {
+				bitmap_set(&within_size, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+			} else if (!strcmp(policy, "never")) {
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+				bitmap_clear(&within_size, start, nr);
+			} else {
+				pr_err("invalid policy %s in thp_shmem boot parameter\n", policy);
+				goto err;
+			}
+		}
+	}
+
+	huge_shmem_orders_always = always;
+	huge_shmem_orders_madvise = madvise;
+	huge_shmem_orders_inherit = inherit;
+	huge_shmem_orders_within_size = within_size;
+	shmem_orders_configured = true;
+	return 1;
+
+err:
+	pr_warn("thp_shmem=%s: error parsing string, ignoring setting\n", str);
+	return 0;
+}
+__setup("thp_shmem=", setup_thp_shmem);
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 #else /* !CONFIG_SHMEM */
-- 
2.46.2


