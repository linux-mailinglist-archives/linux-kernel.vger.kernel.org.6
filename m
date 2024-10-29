Return-Path: <linux-kernel+bounces-386102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933139B3F26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F7D2833D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4537BB0A;
	Tue, 29 Oct 2024 00:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="icCQQT2l"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C917BD6;
	Tue, 29 Oct 2024 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161459; cv=none; b=MSVbkE5LlljWEpwhcK/4gnFjP8328ODdxf5gAAjZEyUD2N2pFtuG0lNKWjg0ZfUkX/vWXK4irBcaTjlxI2Er6nV+9kNSlviiK77vUB8QDtkhPboemK3jMmCnpCkIYmccy8yEU6YKCxyDtVFXXT+I1br81qLaekwmt5vhTOWgwbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161459; c=relaxed/simple;
	bh=DDEEbY5NKTODUyQzjfOpOKJVymT68lWkQwWLp7Dd1PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpTM6Aaz3ez8z6UKeeTUTsj1mwyEQGEsWCSypvNJnteMoyKAM83ISgUqNqW25XmRRx9ZYWBQY8miY/9PJaL2MXRwa6gg3yYS9ZfKOTLgcQ0mPW+bJT/jPJY01OUMYs80abqDI2mU9GFw3DC0By0dUXfzz9Zr925Pd6RvdI1VqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=icCQQT2l; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BwshJwo48RIhJnqvpdLmCKcZc0vOflKYESOeF9s3h5g=; b=icCQQT2lxYD/Bkswn+kH5dOcQl
	4OyL053b9xdV1IU4hvc3z6E6kEqCdEQKIEOC3InqAVEdZmg0nkJYzr+9gIoHMpwBzRVEPPwROwdcz
	1raCGT8RCC7Uh3t7hjq/6slsuJgezXZxSUq/LCx//sXBjGDMmcZ7r1nBGM9G1BoVBC2Hq6ZqUHRYk
	31RYRo3CfcM+ElquSuLvP2lxg7i46wfBU+3vacpv/2Rd5XwuCzqZksb1AGiXJZJe93JRyWhLd5r1U
	/P0X6aHHZdihEbdOoe/XLiNuG6lQRhNlmCNnt3Pwcpm5Max35hEfROmuCh3Doo7ExtT6383OxEDOZ
	/B+mHGrg==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5a1k-00GIrd-8p; Tue, 29 Oct 2024 01:24:04 +0100
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
Subject: [PATCH v2 4/4] mm: shmem: override mTHP shmem default with a kernel parameter
Date: Mon, 28 Oct 2024 21:13:08 -0300
Message-ID: <20241029002324.1062723-5-mcanal@igalia.com>
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
 .../admin-guide/kernel-parameters.txt         | 10 +++++
 Documentation/admin-guide/mm/transhuge.rst    | 17 +++++++++
 mm/shmem.c                                    | 38 ++++++++++++++++++-
 3 files changed, 64 insertions(+), 1 deletion(-)

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
index 26c1eb1b4b1d..37951bb863dd 100644
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
 
@@ -5184,6 +5186,7 @@ struct kobj_attribute thpsize_shmem_enabled_attr =
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 
+
 static int __init setup_transparent_hugepage_shmem(char *str)
 {
 	int huge, ret = 0;
@@ -5207,6 +5210,39 @@ static int __init setup_transparent_hugepage_shmem(char *str)
 }
 __setup("transparent_hugepage_shmem=", setup_transparent_hugepage_shmem);
 
+static char str_dup[PAGE_SIZE] __initdata;
+static int __init setup_thp_shmem(char *str)
+{
+	struct thp_policy_bitmap policies[] = {
+		{ "always",  huge_shmem_orders_always },
+		{ "inherit",  huge_shmem_orders_inherit },
+		{ "advise",  huge_shmem_orders_madvise },
+		{ "within_size",  huge_shmem_orders_within_size }
+	};
+	char *p;
+
+	if (!str || strlen(str) + 1 > PAGE_SIZE)
+		goto err;
+
+	strscpy(str_dup, str);
+	p = str_dup;
+
+	if (!parse_huge_orders(p, policies, ARRAY_SIZE(policies),
+			      THP_ORDERS_ALL_FILE_DEFAULT))
+		goto err;
+
+	huge_shmem_orders_always = policies[0].bitmap;
+	huge_shmem_orders_inherit = policies[1].bitmap;
+	huge_shmem_orders_madvise = policies[2].bitmap;
+	huge_shmem_orders_within_size = policies[3].bitmap;
+	shmem_orders_configured = true;
+	return 1;
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


