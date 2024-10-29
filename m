Return-Path: <linux-kernel+bounces-386101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5F39B3F24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506521C2252B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36F38FAD;
	Tue, 29 Oct 2024 00:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Sdshq8td"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03060F9D6;
	Tue, 29 Oct 2024 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161458; cv=none; b=ZnaMgezZFPdpbPJzpio2TsmWfk6U0ucY78pcH4VA2CnIkg82aRop0LjNaPBK97iorkWWysFt/vOj6RpILMpfieTuUOXzFaZiPcsJkmedJlyV6I5Ru4YbQ1ip4/Attym/rx9yGdzN3hZu1x23qXWSuqzrRB+a32Z29yp5bmblItg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161458; c=relaxed/simple;
	bh=iYa9GLbU8mTvg0QZEgBm/tnKiX/52pJDSuqu2BXQW10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZsguXWX4z0p5AJGkZTnYF7TaDaZdkKb7eCvYrGIKICJ9B4gv3od81MicvXPGZaYIr1mNobqKzwqjC8z5//vXJjVwEH3+PjCFl43/Tnjwtd0tnL7vjb37MThyXZAribHoQotfCSUJhtE4EH83Av6vd9Oluk39xok+zuJg7lCr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Sdshq8td; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=w+ns6OSoZMKNPdhNYQfwqi4ljcYi8WU+6sPV1i33TG4=; b=Sdshq8tdeTIIZrwGdLocfz8Z1U
	/2xLHI03EpXyzG964+QjuqUdm7LDnIh4Fdiefj+fzZ0ATq0IkgA2c9zEpJ3pJlnMgD7k9smvtGXkj
	hNzBnBZuh21B65Mq9xtip4Ughf7wt4IwyKJ+siF42LigZgZe1s35ifUaMxw+H8QVKh+5hFekWf6pV
	9LdZlYmo9CCSvlkAMg8AqIn6xg6TPWB1FxT54SgAP8jMTLU+4xmdR9e6Gs9IAuDAyfdgJtWaa1QbK
	uP+1i0vmjaqC8pP3eE0NtDIBhZvDEBPSmyiTJav4TEdkcRhY6TL1w/oFvVRNU0g9q/mNQLqWviQ3N
	PxRkKfNw==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t5a1f-00GIrd-8G; Tue, 29 Oct 2024 01:23:59 +0100
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
Subject: [PATCH v2 3/4] mm: generalize the implementation of ``thp_anon=``
Date: Mon, 28 Oct 2024 21:13:07 -0300
Message-ID: <20241029002324.1062723-4-mcanal@igalia.com>
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

Currently, the function ``setup_thp_anon()`` is extremely tied to the
policies and bitmaps that currently exist for anon THP. This means that
we can't reuse the function if we implement a ``thp_shmem=``.

This commit extracts the behavior of the function to a new generic
function. The new function is exposed in common headers for future use
by mm/shmem.c.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 include/linux/huge_mm.h |  29 +++++++++++
 mm/huge_memory.c        | 109 ++++++++++++++++++----------------------
 2 files changed, 78 insertions(+), 60 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b94c2e8ee918..b82e9379f2bf 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -471,6 +471,35 @@ void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 			   pmd_t *pmdp, struct folio *folio);
 
+static inline int get_order_from_str(const char *size_str,
+				     const unsigned long thp_orders)
+{
+	unsigned long size;
+	char *endptr;
+	int order;
+
+	size = memparse(size_str, &endptr);
+
+	if (!is_power_of_2(size))
+		goto err;
+
+	order = get_order(size);
+	if (BIT(order) & ~thp_orders)
+		goto err;
+
+	return order;
+err:
+	pr_err("invalid size %s in boot parameter\n", size_str);
+	return -EINVAL;
+}
+
+struct thp_policy_bitmap {
+	const char *policy;
+	unsigned long bitmap;
+};
+
+int parse_huge_orders(char *p, struct thp_policy_bitmap *policies,
+		      const int num_policies, const unsigned long thp_orders);
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline bool folio_test_pmd_mappable(struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 832ca761b4c3..c61f4481cb6a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -958,91 +958,80 @@ static int __init setup_transparent_hugepage(char *str)
 }
 __setup("transparent_hugepage=", setup_transparent_hugepage);
 
-static inline int get_order_from_str(const char *size_str)
-{
-	unsigned long size;
-	char *endptr;
-	int order;
-
-	size = memparse(size_str, &endptr);
-
-	if (!is_power_of_2(size))
-		goto err;
-	order = get_order(size);
-	if (BIT(order) & ~THP_ORDERS_ALL_ANON)
-		goto err;
-
-	return order;
-err:
-	pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
-	return -EINVAL;
-}
-
-static char str_dup[PAGE_SIZE] __initdata;
-static int __init setup_thp_anon(char *str)
+int parse_huge_orders(char *p, struct thp_policy_bitmap *policies,
+		      const int num_policies, const unsigned long thp_orders)
 {
 	char *token, *range, *policy, *subtoken;
-	unsigned long always, inherit, madvise;
 	char *start_size, *end_size;
-	int start, end, nr;
-	char *p;
+	int start, end, nr, i;
+	bool policy_set;
 
-	if (!str || strlen(str) + 1 > PAGE_SIZE)
-		goto err;
-	strcpy(str_dup, str);
-
-	always = huge_anon_orders_always;
-	madvise = huge_anon_orders_madvise;
-	inherit = huge_anon_orders_inherit;
-	p = str_dup;
 	while ((token = strsep(&p, ";")) != NULL) {
 		range = strsep(&token, ":");
 		policy = token;
 
 		if (!policy)
-			goto err;
+			return 0;
 
 		while ((subtoken = strsep(&range, ",")) != NULL) {
+			policy_set = false;
+
 			if (strchr(subtoken, '-')) {
 				start_size = strsep(&subtoken, "-");
 				end_size = subtoken;
 
-				start = get_order_from_str(start_size);
-				end = get_order_from_str(end_size);
+				start = get_order_from_str(start_size, thp_orders);
+				end = get_order_from_str(end_size, thp_orders);
 			} else {
-				start = end = get_order_from_str(subtoken);
+				start = end = get_order_from_str(subtoken, thp_orders);
 			}
 
 			if (start < 0 || end < 0 || start > end)
-				goto err;
+				return 0;
 
 			nr = end - start + 1;
-			if (!strcmp(policy, "always")) {
-				bitmap_set(&always, start, nr);
-				bitmap_clear(&inherit, start, nr);
-				bitmap_clear(&madvise, start, nr);
-			} else if (!strcmp(policy, "madvise")) {
-				bitmap_set(&madvise, start, nr);
-				bitmap_clear(&inherit, start, nr);
-				bitmap_clear(&always, start, nr);
-			} else if (!strcmp(policy, "inherit")) {
-				bitmap_set(&inherit, start, nr);
-				bitmap_clear(&madvise, start, nr);
-				bitmap_clear(&always, start, nr);
-			} else if (!strcmp(policy, "never")) {
-				bitmap_clear(&inherit, start, nr);
-				bitmap_clear(&madvise, start, nr);
-				bitmap_clear(&always, start, nr);
-			} else {
-				pr_err("invalid policy %s in thp_anon boot parameter\n", policy);
-				goto err;
+
+			for (i = 0; i < num_policies; i++) {
+				if (!strcmp(policy, policies[i].policy)) {
+					bitmap_set(&policies[i].bitmap, start, nr);
+					policy_set = true;
+				} else
+					bitmap_clear(&policies[i].bitmap, start, nr);
+			}
+
+			if (!policy_set && strcmp(policy, "never")) {
+				pr_err("invalid policy %s in boot parameter\n", policy);
+				return 0;
 			}
 		}
 	}
 
-	huge_anon_orders_always = always;
-	huge_anon_orders_madvise = madvise;
-	huge_anon_orders_inherit = inherit;
+	return 1;
+}
+
+static char str_dup[PAGE_SIZE] __initdata;
+static int __init setup_thp_anon(char *str)
+{
+	struct thp_policy_bitmap policies[] = {
+		{ "always",  huge_anon_orders_always },
+		{ "madvise",  huge_anon_orders_madvise },
+		{ "inherit",  huge_anon_orders_inherit },
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
+			      THP_ORDERS_ALL_ANON))
+		goto err;
+
+	huge_anon_orders_always = policies[0].bitmap;
+	huge_anon_orders_madvise = policies[1].bitmap;
+	huge_anon_orders_inherit = policies[2].bitmap;
 	anon_orders_configured = true;
 	return 1;
 
-- 
2.46.2


