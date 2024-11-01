Return-Path: <linux-kernel+bounces-392603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A651C9B9615
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0A282F40
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7604E1CDFCE;
	Fri,  1 Nov 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="S3IrxxJW"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD31CBE95;
	Fri,  1 Nov 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480298; cv=none; b=GBn74c8+zzlkTvbJ+2e6guwbqhKuAeXoGRTYNPSnVECNnk8boD6LrMqiIeT6e4gN9ROkUS83VsIguYQs9I2kzfS6O00TPjcx8/nZX1GGmW6pMbV1Y51luzFvDaaAywAV0prxTVo1R72AiLgfhWBvM8wV54kN3SmWZ9yLR66I6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480298; c=relaxed/simple;
	bh=t0gVvn1fm0+Ylnlo8YrHN/+e9/MYu7TlgLFa+Ir0jFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/I8hgYIS/klRIPcrKTDh9DbocD5RUJZxpFcN2+gvj4JA2U080nSknfcWYFb/w6yvXjzAILy0OqOIokEvpJuAS16kGK0nOGxcYIv1zxMBVjCnOTZwPJhqDW97QVsX2Zgnla2ZKO+jCgicoIEvhmBWYc/mzTF/WaRgqUOAAkRkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=S3IrxxJW; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CkGKvkV3mc7ind0IGB8Z7rq8Fs5Gz/hW7rWK8pt2t0Q=; b=S3IrxxJWRTtT5fHJKdV2venR33
	ozEECWoZpl/tQV/QbSa7EDzHaCXu+o/ivjtn4mwaNPAplGnvQJQvYZU2ag/yo3q6fEOZw0zB6/Gfh
	0OSV4Nd7PXCmRbdZqRGK+stMdW2N/eOCIiS/bT1GW7anznvh/UtpU4amuZmhv3AfFLrkUC1SuhXj7
	vIUZFt0at6Jc9vezFXf7Abz6VlKT2zkuC1UsWsSQQbC3xJRagkVSsvF6tNnIKwClVJYg1/zuIlljQ
	/FFyHvnnW21rRgPr2En8tCizZD4BYd1Wj0RIFmZ9fiomODnAdyuCy8p+lDfMH1S9YB7RcNpvDv6IF
	C+ZJeDqw==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uyK-000VPu-6X; Fri, 01 Nov 2024 17:58:05 +0100
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
Subject: [PATCH v5 3/5] mm: move ``get_order_from_str()`` to internal.h
Date: Fri,  1 Nov 2024 13:54:07 -0300
Message-ID: <20241101165719.1074234-5-mcanal@igalia.com>
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

In order to implement a kernel parameter similar to ``thp_anon=`` for
shmem, we'll need the function ``get_order_from_str()``.

Instead of duplicating the function, move the function to a shared
header, in which both mm/shmem.c and mm/huge_memory.c will be able to
use it.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 mm/huge_memory.c | 38 +++++++++++++++-----------------------
 mm/internal.h    | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f92068864469..a6edbd8c4f49 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -958,26 +958,6 @@ static int __init setup_transparent_hugepage(char *str)
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
 static char str_dup[PAGE_SIZE] __initdata;
 static int __init setup_thp_anon(char *str)
 {
@@ -1007,10 +987,22 @@ static int __init setup_thp_anon(char *str)
 				start_size = strsep(&subtoken, "-");
 				end_size = subtoken;
 
-				start = get_order_from_str(start_size);
-				end = get_order_from_str(end_size);
+				start = get_order_from_str(start_size, THP_ORDERS_ALL_ANON);
+				end = get_order_from_str(end_size, THP_ORDERS_ALL_ANON);
 			} else {
-				start = end = get_order_from_str(subtoken);
+				start_size = end_size = subtoken;
+				start = end = get_order_from_str(subtoken,
+								 THP_ORDERS_ALL_ANON);
+			}
+
+			if (start == -EINVAL) {
+				pr_err("invalid size %s in thp_anon boot parameter\n", start_size);
+				goto err;
+			}
+
+			if (end == -EINVAL) {
+				pr_err("invalid size %s in thp_anon boot parameter\n", end_size);
+				goto err;
 			}
 
 			if (start < 0 || end < 0 || start > end)
diff --git a/mm/internal.h b/mm/internal.h
index d5b93c5b6364..5a7302baeed7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1291,6 +1291,28 @@ static inline bool alloc_zeroed(void)
 			&init_on_alloc);
 }
 
+/*
+ * Parses a string with mem suffixes into its order. Useful to parse kernel
+ * parameters.
+ */
+static inline int get_order_from_str(const char *size_str,
+				     unsigned long valid_orders)
+{
+	unsigned long size;
+	char *endptr;
+	int order;
+
+	size = memparse(size_str, &endptr);
+
+	if (!is_power_of_2(size))
+		return -EINVAL;
+	order = get_order(size);
+	if (BIT(order) & ~valid_orders)
+		return -EINVAL;
+
+	return order;
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
-- 
2.46.2


