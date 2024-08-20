Return-Path: <linux-kernel+bounces-293812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D406D958534
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24C76B25D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D518E035;
	Tue, 20 Aug 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GunIu2lp"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A818E02C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151184; cv=none; b=f1PYsVsxlPmtfiUlz+2aHB6KEEwggQO1aSqLXat/M9ZYoQMGzLtZYGLa42vyx/L6GCb+4HohzvdRHMfFQyaCNzeTjwg4qJCTh68NqfKLcbjmMbTxVG5HykPLNyHaytHUkDSn016oxIsIr2Q5Bm2s+dCvajuv1zcp3x4iqSiXFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151184; c=relaxed/simple;
	bh=77u6L3TA/5ECmrAhLZTcmaOEnUo+oh/Jh2kuPWIy798=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hqFiPYqN1BDWjSXK4n947uke+NiyaWG6f0ZRiSDIZn35jEgtdDC7ChPqkZlC9Qxh7cOSTv3N/exYlNueIJLcL/xYlgze//CpGGtc7wtt6TqBWErbM5r4oppGxBW3HC0OYiD8DK27iorR73DRqcKoJf9xsRYDKpOlBiD6Iy6625k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GunIu2lp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d399da0b5so4523966b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724151182; x=1724755982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcW/bXC7hiuTbCcrDe23N8Cg3ZczxDN7qEUeTv5fisY=;
        b=GunIu2lp/6fP85DWgr0JAoVuBxO58RwR6kTuGfcW1zbYgwEToOn6MYUk4xI2O58kLJ
         5SRg5AM6SCplBfp8I8qG+iJnsvLwiSAsm3NLjvkhSCA04qS8QxrXrC+wqST3OVxUQb8M
         ThCt4GHLo5ab58K1KMOH2v8mL+1N4ww/srxZrio1BGsZtMfDQY8i/Hpn7TvQS+f3oIV2
         /UmJbHrU1Gy4KDgwPqbjQ6/+H7EChpNNKfY69Xrc+YRszwhVwCum3y2TtoQeLT/khu/F
         mKH97OSm+5lwj/tTxu9nDP+GRUMr8wGA0UZch1Aaamxwcmy756V0E3+J/ELdliPJPgT9
         u4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724151182; x=1724755982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcW/bXC7hiuTbCcrDe23N8Cg3ZczxDN7qEUeTv5fisY=;
        b=a1pM5SXOVpP3lIE73s2JS9ZI0tKPJBqalsU6YzBLHCBefXkuQUjX1kIjbc3rrhmzYd
         eoeDoiLX/5Ri4JEXlmPWAz/jq1nzBuBRSF+p1tZHOxEXVQdSIfQS3GJTu/XOivkt2dHi
         iKyhRxRZrBBtBF5GQcRm40zGurNhHJwBtCXOx4U4fteYSSvmFjIv6IgobBsgydxN7QRS
         yKCWG4uuPXNMt3PxOsZrF9z/j0Su3dyMHla0ot9XqxYL+2Qrm9argejuCmGOl7k2UJ5c
         LX6QRwu+J13sxbcIHdWbbdsUWHdkBpcqtoOgX9mNX4YNYFGBMLpo6w5YAGyK4DZto97/
         wa0A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3CrwhR2EqHrlrBF7QY8kLC36dcYUARrSD4c0GoKy2ndA6ayzpGAPiozfHn+/xUypYt75wefGl1nsrvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9yy3+2I+brxZLXC5L7VpOhEVvWS+xFv6LeOjzYPMPdL87ODDf
	1JTRjihC+HANdv7nOKxvjXfOZYQdaHBvJcKbKi0IvwSjNwGM3iBX4AOt5kLf
X-Google-Smtp-Source: AGHT+IF38pbSlDGIT7/HZwuM+owas8KMnZZ0O9atxXpxvjUqeDab00Pf4MaOZPDuvlR15sLjij9KDg==
X-Received: by 2002:a05:6a20:2d29:b0:1c2:8cc4:9084 with SMTP id adf61e73a8af0-1c905025ed4mr19724289637.34.1724151181677;
        Tue, 20 Aug 2024 03:53:01 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:9018:5cd2:579f:48d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d97f2asm9051571a91.53.2024.08.20.03.52.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Aug 2024 03:53:01 -0700 (PDT)
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
Subject: [PATCH v6] mm: override mTHP "enabled" defaults at kernel cmdline
Date: Tue, 20 Aug 2024 22:52:44 +1200
Message-Id: <20240820105244.62703-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Roberts <ryan.roberts@arm.com>

Add thp_anon= cmdline parameter to allow specifying the default enablement
of each supported anon THP size.  The parameter accepts the following
format and can be provided multiple times to configure each size:

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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lance Yang <ioworker0@gmail.com>
---
 -v6:
  * collect acked-by of David, thanks!
  * some minor cleanup according to David's comments

 .../admin-guide/kernel-parameters.txt         |  9 ++
 Documentation/admin-guide/mm/transhuge.rst    | 38 +++++--
 mm/huge_memory.c                              | 98 ++++++++++++++++++-
 3 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f0057bac20fb..8dd0aefea01e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6629,6 +6629,15 @@
 			<deci-seconds>: poll all this frequency
 			0: no polling (default)
 
+	thp_anon=	[KNL]
+			Format: <size>,<size>[KMG]:<state>;<size>-<size>[KMG]:<state>
+			state is one of "always", "madvise", "never" or "inherit".
+			Control the default behavior of the system with respect
+			to anonymous transparent hugepages.
+			Can be used multiple times for multiple anon THP sizes.
+			See Documentation/admin-guide/mm/transhuge.rst for more
+			details.
+
 	threadirqs	[KNL,EARLY]
 			Force threading of all interrupt handlers except those
 			marked explicitly IRQF_NO_THREAD.
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..79435c537e21 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -284,13 +284,37 @@ that THP is shared. Exceeding the number would block the collapse::
 
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
+where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE and
+supported anonymous THP)  and ``<state>`` is one of ``always``, ``madvise``,
+``never`` or ``inherit``.
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
index d90d6e94a800..df3199e1715c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -81,6 +81,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+static bool anon_orders_configured __initdata;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -733,7 +734,8 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
 	 * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
 	 * constant so we have to do this here.
 	 */
-	huge_anon_orders_inherit = BIT(PMD_ORDER);
+	if (!anon_orders_configured)
+		huge_anon_orders_inherit = BIT(PMD_ORDER);
 
 	*hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
 	if (unlikely(!*hugepage_kobj)) {
@@ -918,6 +920,100 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
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
+	if (BIT(order) & ~THP_ORDERS_ALL_ANON)
+		goto err;
+
+	return order;
+err:
+	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
+	return -EINVAL;
+}
+
+static char str_dup[PAGE_SIZE] __initdata;
+static int __init setup_thp_anon(char *str)
+{
+	char *token, *range, *policy, *subtoken;
+	unsigned long always, inherit, madvise;
+	char *start_size, *end_size;
+	int start, end, nr;
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
+			nr = end - start + 1;
+			if (!strcmp(policy, "always")) {
+				bitmap_set(&always, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+			} else if (!strcmp(policy, "madvise")) {
+				bitmap_set(&madvise, start, nr);
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&always, start, nr);
+			} else if (!strcmp(policy, "inherit")) {
+				bitmap_set(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
+			} else if (!strcmp(policy, "never")) {
+				bitmap_clear(&inherit, start, nr);
+				bitmap_clear(&madvise, start, nr);
+				bitmap_clear(&always, start, nr);
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
+	pr_warn("thp_anon=%s: error parsing string, ignoring setting\n", str);
+	return 0;
+}
+__setup("thp_anon=", setup_thp_anon);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-- 
2.39.3 (Apple Git-146)


