Return-Path: <linux-kernel+bounces-282932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D312794EACB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAFC1F227BE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6EC16F0DB;
	Mon, 12 Aug 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLf7tXOI"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9B170A06
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458302; cv=none; b=qz1euAbxEYnpoteIT2XBtuAsqE6SRWwuLnEguj6+kufFfdHJz6r79jgZLa5xSSm+77vt1g9SZXRvdBWE0+mb+iS5zsX5uhPW5UG6ZF06zMzy5eZrBf3fxONtN+C4CKNQZfB9dUtZYczeK6fujTb7t3m+q842UJakY/Rl4uICpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458302; c=relaxed/simple;
	bh=w3SK7SKb4/dBFqijs/mFmekgN6rDEc30JHbbMN1cG2c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sNRvj6ObX4lBrJVOAhVmGkBhoqCg2FdqBPXgauB5g4X7/gqTZTyge6et7uhN6AW0PGu3voUGi/7FtaPqI55tQwBzk3KyAdxeL0wFSP65YviMMXrBJLjktDUBk8F79e/rNUp/v+h1uwDSeImVlRRdJLd0DPNw/EAaigk4B7BMkGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLf7tXOI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so3229264a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723458300; x=1724063100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSwvP6dNgKH28DNmEeTEiBm7zurXGy8bxZZfYwW8Zsw=;
        b=kLf7tXOIoUSH8qJJy04TI29lC+Gk6WdTSOQrg6bmzi0D0w/m0xie9B7Sm62WqsJSKa
         m6WtendqK0ROwN7TJcdBZnohHY3mBRtfw+NWrorVR191QPQ5b3mJ30dv+DG7WFZPtuVY
         4Uctv6cV9Jc8guaVVWd8f1RHwxEBLP8L31RUzNsTd+wUTXmYE2buBCCH0ZH/uIEwQ0zL
         ysjmYhPSXp/wuucWTmY3VthCQA/cUz2TX+I07TuQY9iI2TXhJtdE9g6uEmLp7FKujHwr
         PAMZ1V0sYgPmBXGoZcgjmffnLuyhOqmOMu8507OR5KWCS5Wah+8/xeHmLX7EvUxs9Au0
         HhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723458300; x=1724063100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSwvP6dNgKH28DNmEeTEiBm7zurXGy8bxZZfYwW8Zsw=;
        b=jhzvisN9WwNrk2B5TdHR2reuoCq59HipX2LC5p1EyHTZCk1xNjawZML90IBBw8lwkS
         32oVZ3ZmmpGuv21p7p0cqLj0pIKrLtcuzf9lC3wVyNt7qJHZWcyPmhatfYz+ZsRPDThd
         D4ZDqGcZYtXRy4R9V31KGsn3jGHwpcqCmZZVfdujh+Lawh9m0JgXiSGZ7NBcq6Gc/gAs
         n87RSc/B5S57uJLfO0Hj/EaZpGl+XrDIxslv4wTia364UkcOhtH1s8A+faYfUPhgobyq
         LKzATZII9ID9aRPdhZP1LGSWAVfOceFjAZ6ExAwa7vv2LXwPVYieWC1wLNomR/AV8LD8
         N89Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKrsMcY9ZHrpKrezJo0/sSdozPxOfS2p6b6HurY6Pm+vKO3SR+AnmNvCGVE9kt7dlBXgOkAP9B3Q/M3VNbfpC+pP/9U8lNBB4EJY7c
X-Gm-Message-State: AOJu0Yzjfq+EGAa5Fx5OsAO6F4c/W1ARoslOnsKyavujK1EzOyuFqvDG
	hBHWWFgcC4N4/1ogFMFFKP9QTaEzJlKP+loP91JoAvhpQR5Z5N5W
X-Google-Smtp-Source: AGHT+IEXr7/VY2siBiPSeb5Eccp77TnE0XKvKtCrJQj3OxZSPs+ep5Cn4wVehtUADo6Hucz4Ay5wrw==
X-Received: by 2002:a17:90a:1582:b0:2cb:3749:7baf with SMTP id 98e67ed59e1d1-2d1e7fc113cmr9861198a91.17.1723458299750;
        Mon, 12 Aug 2024 03:24:59 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9dc8b58sm8566977a91.53.2024.08.12.03.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 03:24:59 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v3] mm: Override mTHP "enabled" defaults at kernel cmdline
Date: Mon, 12 Aug 2024 22:24:45 +1200
Message-Id: <20240812102445.162087-1-21cnbao@gmail.com>
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
-v3:
  * support formats as below, Per David's suggestion
    thp_anon=16K-64K:always;128K,512K:inherit;256K:madvise;1M-2M:never
  * document the relationship between transparent_hugepage
    and thp_anon better, Per David;
  *
  Hi Baolin,
  I am taking your Reviewed-by because the code has
  changed quite a lot.

 .../admin-guide/kernel-parameters.txt         |   9 ++
 Documentation/admin-guide/mm/transhuge.rst    |  37 ++++--
 mm/huge_memory.c                              | 112 +++++++++++++++++-
 3 files changed, 150 insertions(+), 8 deletions(-)

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
index 1a12c011e2df..e8eeb8111f6e 100644
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
@@ -922,6 +926,112 @@ static int __init setup_transparent_hugepage(char *str)
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
+		pr_err("invalid size %s order %d in thp_anon boot parameter\n",
+			size_str, order);
+		return -EINVAL;
+	}
+
+	return order;
+}
+
+static inline void set_bits(unsigned long *var, int start, int end)
+{
+	int i;
+
+	for (i = start; i <= end; i++)
+		set_bit(i, var);
+}
+
+static inline void clear_bits(unsigned long *var, int start, int end)
+{
+	int i;
+
+	for (i = start; i <= end; i++)
+		clear_bit(i, var);
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
+				set_bits(&always, start, end);
+				clear_bits(&inherit, start, end);
+				clear_bits(&madvise, start, end);
+			} else if (!strcmp(policy, "madvise")) {
+				set_bits(&madvise, start, end);
+				clear_bits(&inherit, start, end);
+				clear_bits(&always, start, end);
+			} else if (!strcmp(policy, "inherit")) {
+				set_bits(&inherit, start, end);
+				clear_bits(&madvise, start, end);
+				clear_bits(&always, start, end);
+			} else if (!strcmp(policy, "never")) {
+				clear_bits(&inherit, start, end);
+				clear_bits(&madvise, start, end);
+				clear_bits(&always, start, end);
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


