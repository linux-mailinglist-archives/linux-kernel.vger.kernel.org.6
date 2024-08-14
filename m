Return-Path: <linux-kernel+bounces-285725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFF39511D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 04:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC47B22174
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 02:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B5182B5;
	Wed, 14 Aug 2024 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZ+/g5y5"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDD017BDC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723600994; cv=none; b=Bfi6o/de6S5mRTAXLmML5yqFk4sCwrMAJ6hQvZ0tNI8UJrhinGJB/YlHW/NP1m/1i1p2i6iEGMNQ0Fc2ED/4/7+Wijsn/yVb6zqomf41jx9yYsgaWAO7dz6YwSDPlcMyJu9iArmUCdV+04zXuplvz8+F8Vzx3py42qkIcHVXk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723600994; c=relaxed/simple;
	bh=+QmBxbuYODkQVzcxZgj84On/OzEFEP6MhX8kVEiqQZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6YTOWvwYb/TyknMEuitdfS7L84PNe5e7Eb8FMr5s5+yY5uRSfN5kzxi0ZI919npLVnkwxssn/xYTHLlE6gcItqu5Ii2+Sag5+bhi6iKFILPfUFWBEPJvG6yDxUIGrs9BHLh2I4/n/7vgEv0+1vPAwPxgkKwQ94zeLsIpebVujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZ+/g5y5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd6ed7688cso54448565ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723600992; x=1724205792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8pN1/0/watTUQfYOs3nJpvPLJBzfi893UM4WQLVxvc=;
        b=UZ+/g5y57Icz19H9+QBPvxqpX1ZFGd/TcE9QSU9/bUjvQgwiFoc3pJov6DqxlogJ6j
         pHTtylPtalxzfjiXpTu+Rf0tVh86sro9Gn9ArmKRWZrJ021oCHTJx9yc7L1GBZKQs7vU
         zbnzZcfh7k5Ea21mZKw+jjAjyH/MBGy3pB149jv5zX9lGC+6rq98r+KVLBrH8SRpgyQf
         l2KD/2AFpPpEFgw5ePhu34SLbQJBEGA95GsPCNSBKOOI9Sloa2F3+UQelE1G0Wl7u2FF
         ZUfHkNQHu1oc+2KIlgkdIR7tMj/y4BegQifUEqI8Gqw/PQpXzqhDpbximxqbmqXezSv9
         dZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723600992; x=1724205792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8pN1/0/watTUQfYOs3nJpvPLJBzfi893UM4WQLVxvc=;
        b=lt9pftjjSrtQYDOsdnhKH0jct9JoAM2fa8Z/R1Hya03isaktDD26l6luU+g3B8hxim
         FwjJmUaYWX3fgpLQtkKXPAlyDl5tqyooNnhJ7MYl5jDG9fiH8RYIpRzA9JYfRBgNzF1r
         zF2e3xDOGQXRUb2ucgvVrM0YYuiMDJIzH+VjQBZ7PNqrmTSWRZfWmcIdgVn3F2C/ou7/
         p6SeSsvuX/Ioz0BvEk0DMXC73MHK9n2fyoxSw4VF1n5u93kiEKHf0HDEm4LG9zrlAL3s
         CLBpW8fPA2QfL6s5cYQXqkS1YIoTyzSCZkXn/E7IomZI7QFaWeiLDl6hlf//554nCpJy
         KWQg==
X-Forwarded-Encrypted: i=1; AJvYcCV4AU8IM56KLE2hLNRs96IyGZaFlm3dBM/L4iZf8AJdUiIs4tuRquCuc3lVOoUxC3HNxd/LuDVWP+aRDZoRWt6D+ylbV7o3qW12bIaH
X-Gm-Message-State: AOJu0Yz4IqALyKewijxTIUPNnANLjuO+sIp80s6zHXDeseAROlCB+ecG
	I5ZyF6Cdi6LcWD+W0u7Jacz613jKw6roeSZLFIpUxCT5llgEcSJkxgcwhw==
X-Google-Smtp-Source: AGHT+IFBNlYMlCcz/DGQe5EopNsp5sX1l8GX98RpBxhXVTVvNuB838o6ZTSivCDHHrKiErh8z5GlKA==
X-Received: by 2002:a17:902:c943:b0:1fd:9269:72f0 with SMTP id d9443c01a7336-201d64a5b41mr16614065ad.47.1723600992349;
        Tue, 13 Aug 2024 19:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd12f0bfsm19898655ad.61.2024.08.13.19.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 19:03:11 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com
Subject: [PATCH v4] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Wed, 14 Aug 2024 14:02:47 +1200
Message-Id: <20240814020247.67297-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

Add thp_anon= cmdline parameter to allow specifying the default
enablement of each supported anon THP size. The parameter accepts the
following format and can be provided multiple times to configure each
size:

thp_anon=<size>,<size>[KMG]:<value>;<size>-<size>[KMG]:<value>

An example:

thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never

See Documentation/admin-guide/mm/transhuge.rst for more details.

Configuring the defaults at boot time is useful to allow early user
space to take advantage of mTHP before its been configured through
sysfs.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v4:
 * use bitmap APIs to set and clear bits. thanks very much for
   David's comment!

 .../admin-guide/kernel-parameters.txt         |  9 ++
 Documentation/admin-guide/mm/transhuge.rst    | 37 +++++--
 mm/huge_memory.c                              | 96 ++++++++++++++++++-
 3 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f0057bac20fb..d0d141d50638 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6629,6 +6629,15 @@
 			<deci-seconds>: poll all this frequency
 			0: no polling (default)
 
+	thp_anon=	[KNL]
+			Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
+			state is one of "always", "madvise", "never" or "inherit".
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
index 7072469de8a8..528e1a19d63f 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -284,13 +284,36 @@ that THP is shared. Exceeding the number would block the collapse::
 
 A higher value may increase memory footprint for some workloads.
 
-Boot parameter
-==============
-
-You can change the sysfs boot time defaults of Transparent Hugepage
-Support by passing the parameter ``transparent_hugepage=always`` or
-``transparent_hugepage=madvise`` or ``transparent_hugepage=never``
-to the kernel command line.
+Boot parameters
+===============
+
+You can change the sysfs boot time default for the top-level "enabled"
+control by passing the parameter ``transparent_hugepage=always`` or
+``transparent_hugepage=madvise`` or ``transparent_hugepage=never`` to the
+kernel command line.
+
+Alternatively, each supported anonymous THP size can be controlled by
+passing ``thp_anon=<size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>``,
+where ``<size>`` is the THP size and ``<state>`` is one of ``always``,
+``madvise``, ``never`` or ``inherit``.
+
+For example, the following will set 16K, 32K, 64K THP to ``always``,
+set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
+to ``never``::
+
+	thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
+
+``thp_anon=`` may be specified multiple times to configure all THP sizes as
+required. If ``thp_anon=`` is specified at least once, any anon THP sizes
+not explicitly configured on the command line are implicitly set to
+``never``.
+
+``transparent_hugepage`` setting only affects the global toggle. If
+``thp_anon`` is not specified, PMD_ORDER THP will default to ``inherit``.
+However, if a valid ``thp_anon`` setting is provided by the user, the
+PMD_ORDER THP policy will be overridden. If the policy for PMD_ORDER
+is not defined within a valid ``thp_anon``, its policy will default to
+``never``.
 
 Hugepages in tmpfs/shmem
 ========================
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1a12c011e2df..c5f4e97b49de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+static bool anon_orders_configured;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -737,7 +738,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
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
@@ -922,6 +926,96 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
+static inline int get_order_from_str(const char *size_str)
+{
+	unsigned long size;
+	char *endptr;
+	int order;
+
+	size = memparse(size_str, &endptr);
+	order = fls(size >> PAGE_SHIFT) - 1;
+	if ((1 << order) & ~THP_ORDERS_ALL_ANON) {
+		pr_err("invalid size %s(order %d) in thp_anon boot parameter\n",
+			size_str, order);
+		return -EINVAL;
+	}
+
+	return order;
+}
+
+static char str_dup[PAGE_SIZE] __meminitdata;
+static int __init setup_thp_anon(char *str)
+{
+	char *token, *range, *policy, *subtoken;
+	unsigned long always, inherit, madvise;
+	char *start_size, *end_size;
+	int start, end;
+	char *p;
+
+	if (!str || strlen(str) + 1 > PAGE_SIZE)
+		goto err;
+	strcpy(str_dup, str);
+
+	always = huge_anon_orders_always;
+	madvise = huge_anon_orders_madvise;
+	inherit = huge_anon_orders_inherit;
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
+			if (!strcmp(policy, "always")) {
+				bitmap_set(&always, start, end - start + 1);
+				bitmap_clear(&inherit, start, end - start + 1);
+				bitmap_clear(&madvise, start, end - start + 1);
+			} else if (!strcmp(policy, "madvise")) {
+				bitmap_set(&madvise, start, end - start + 1);
+				bitmap_clear(&inherit, start, end - start + 1);
+				bitmap_clear(&always, start, end - start + 1);
+			} else if (!strcmp(policy, "inherit")) {
+				bitmap_set(&inherit, start, end - start + 1);
+				bitmap_clear(&madvise, start, end - start + 1);
+				bitmap_clear(&always, start, end - start + 1);
+			} else if (!strcmp(policy, "never")) {
+				bitmap_clear(&inherit, start, end - start + 1);
+				bitmap_clear(&madvise, start, end - start + 1);
+				bitmap_clear(&always, start, end - start + 1);
+			} else {
+				pr_err("invalid policy %s in thp_anon boot parameter\n", policy);
+				goto err;
+			}
+		}
+	}
+
+	huge_anon_orders_always = always;
+	huge_anon_orders_madvise = madvise;
+	huge_anon_orders_inherit = inherit;
+	anon_orders_configured = true;
+	return 1;
+
+err:
+	pr_warn("thp_anon=%s: cannot parse, ignored\n", str);
+	return 0;
+}
+__setup("thp_anon=", setup_thp_anon);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-- 
2.34.1


