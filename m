Return-Path: <linux-kernel+bounces-290536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A085955574
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 06:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BAB1C22857
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 04:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2947F81720;
	Sat, 17 Aug 2024 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3xwNS+N"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB26101DE
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723870567; cv=none; b=AsbZtQgKqCDyYQZ1xHhDGnia+Sbms0oPrx/r7GKyOvrofMlIxLq+rtlCD6J3BtDx3BiM/q4eATXBvh3spwJRGRt1JQJjfkvwdi8H+Uuq04ycsWX/VY+wXxgQOZxueSSP2/AO7fMhtpDGT40NTWs96HWUFIMbiTO5Vl92DyXhOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723870567; c=relaxed/simple;
	bh=hgsOVRrRqAf3YVZwNJg1GTvX+JPAgwuaKzsarkTH5fY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k1jOvfX8XlU77+dSL9zy51dKjxnbS0NdUVHfng/vlvFxJpDwn17dvUFbjVIZ3YjQ3LUEQ0BgZOKaZrj2nkbHc7XRcF0AGMr30w9+MPbQCqlrovgt9TcSLjSvzWto87IRwcKEK87gb3KIeUXyqqEv5Tvifw4zxwv64MouB1akHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3xwNS+N; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7126d62667bso1694487b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723870565; x=1724475365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90Dn5cjzDzLtyzWrS/a8MBAYblFtGSEi8TOi7CgPMA0=;
        b=B3xwNS+NEnrzvhCG+PvoWTig/6ekupz3cghpA4DI79A8C8YYI4nGcbnbgBUPHdu1Uc
         CM0tfuKoLIyz/NcdFez2UZU42ZcwNNpSToCDg6Me02O9EfnwFmBVJqxR82btPjNAvFny
         w6ABtchH2ZoHHIcUaA+GLfMTIWNa/cWWpVdGF2ZpA640hVbfruLcJDaSoH8PXecL3a8J
         /ZHGB1r6GDWn95pdUZTdIV+inovxwjn3Eadd3VOwH8NsMWkGPJYZP7VxtguBDIG/A2l8
         wSaOmYZWFPDFf3OLESGcmlVC+nQxnRmmkIecZWADtLxICr9zMHQMEsRd/dxL4V3+/I8W
         WlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723870565; x=1724475365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90Dn5cjzDzLtyzWrS/a8MBAYblFtGSEi8TOi7CgPMA0=;
        b=mPMjedjpIAoSHeMPIpXRzvHlMwjYyr56joRWki9W8i3UrxT2HyAWL5vJKcb1dGMiV3
         QnwSMEy3kZ8xaxIF5SJUlnNSzI7JfXvS4fNQwr839VMZ0BRqMqPf8tCiVso5MwwQp4Vk
         GfBCssFj2sLqqz/9x/lHBxyNik9aHgs5Uyvl22VR9wQ1Cj9vqJIRlLF0+zQ/eiaShY1b
         ZBBwyoiwYxsds8PfEatK+XQ4+GO/nD782Ew+dnrWpFmuey4MpP5AUozhQ3RCyC7oQ25f
         dBehn7NTbcqq0qMof5K9iiBBjPhEeF9Nttq0C+FdgHEG9UD7a0O6NQkLdwzHPAngxeKQ
         Wqpg==
X-Forwarded-Encrypted: i=1; AJvYcCXWqqinZZwBipym57pE2MtGAAxD4fIVlcEpxHnNA6jNLr+xTEM21a6aD9H9A1YRgbDoKfZKGeynQfvTlWfdTxGH9dw3l7ffzyobS0ce
X-Gm-Message-State: AOJu0YzJT5qA8tN54LWsKSv1SMcbLNPJH5ff0PD/QrhhxSX7WayHWsd6
	rxS9EovwS5Tx0am78ypfJ10KtdewHCL93eEdrJyzSw2FuDzQxPku
X-Google-Smtp-Source: AGHT+IHNKqt8weUm9VZF1ryifXfv4BG6d1BYy0/Vgx1L5ZhHaR/NdgwqOBdZQNBPwmxij2Y4NjwLsw==
X-Received: by 2002:a05:6a00:3d01:b0:70d:2497:383 with SMTP id d2e1a72fcca58-713c4e72710mr6199987b3a.18.1723870564663;
        Fri, 16 Aug 2024 21:56:04 -0700 (PDT)
Received: from Barrys-MBP.hub ([2407:7000:8942:5500:fd84:292a:c6d0:8b67])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61dc763sm3809014a12.39.2024.08.16.21.56.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Aug 2024 21:56:04 -0700 (PDT)
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
Subject: [PATCH v5] mm: override mTHP "enabled" defaults at kernel cmdline
Date: Sat, 17 Aug 2024 16:55:16 +1200
Message-Id: <20240817045516.58037-1-21cnbao@gmail.com>
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
Cc: David Hildenbrand <david@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lance Yang <ioworker0@gmail.com>
---
 -v5:
 * collect Baolin's reviewed-by and tested-by tags, thanks!
 * use get_order and check size is power 2, David, Baolin;
 * use proper __initdata

.../admin-guide/kernel-parameters.txt         |   9 ++
 Documentation/admin-guide/mm/transhuge.rst    |  38 +++++--
 mm/huge_memory.c                              | 100 +++++++++++++++++-
 3 files changed, 139 insertions(+), 8 deletions(-)

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
index 60522f49178b..4468851b6ecb 100644
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
index 69cef10ed9aa..c8ca577526cf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -82,6 +82,7 @@ unsigned long huge_zero_pfn __read_mostly = ~0UL;
 unsigned long huge_anon_orders_always __read_mostly;
 unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
+static bool anon_orders_configured __initdata;
 
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
@@ -756,7 +757,10 @@ static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
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
@@ -941,6 +945,100 @@ static int __init setup_transparent_hugepage(char *str)
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
+	if ((1 << order) & ~THP_ORDERS_ALL_ANON)
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
+	pr_warn("thp_anon=%s: cannot parse, ignored\n", str);
+	return 0;
+}
+__setup("thp_anon=", setup_thp_anon);
+
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
 	if (likely(vma->vm_flags & VM_WRITE))
-- 
2.39.3 (Apple Git-146)


