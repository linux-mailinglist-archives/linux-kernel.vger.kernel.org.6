Return-Path: <linux-kernel+bounces-539176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BA4A4A1B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC273A4DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3D27AA7F;
	Fri, 28 Feb 2025 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7Ppxl9/"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10D277033
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767431; cv=none; b=LnqdSk+kFm0WIE/9BjaQBO8iMm8ielQtmV4Nv1zyHqOEIRhnDztkVL6iPdCl/A0vW9wS7MULQYQ5c0mLNes++foQSFWHKXUj4EFoTHZHijWyelekKww/WlpTX0/4AY3NN6z9pEQRLhCsnigHgRrmD+QDgwuxxcx2BJvlErJqUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767431; c=relaxed/simple;
	bh=7Acur164byQ0STeNcJdwq9eVToq5iNa+oJyKcDPpqPU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezh9lCwA0ME0ruyfkUIJOpqYmDglC+kVZ9S178C+lEkILRShN/ofKwPprevLLeXdOOTsANZPumJummI52uMd9nFH/iuyKdIE0Ed3ODbqOGyptJllQez5YEBdx0UWP3GQTKqV43A3An+Q37uP5pCpEbaWKb7t31FDvHQUp0Momp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m7Ppxl9/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc3e239675so8300490a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767429; x=1741372229; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SJXuy9g+fIYCpUv35AHIylFJGRqMuxPCbt3E+0p7mQw=;
        b=m7Ppxl9/bdSS/bg/4tvvMaDmUARFBACgN219cRFc2ZsWuHDR3yWL33PG2Z2WcQXM1q
         IT8RkQiLN9psHuZzTxnnu0PNmPM2SPQwYtKDPi6A+IDDg4sR851U1OGDPW86wxyEJ8Na
         SpysYTgc+l4xxGPKD5hsS5ePJAhfL/iKQCDeccNSpKCknhL4YxDE0D9ShYjsg+UBXYAZ
         hqnH07eiEqsxtBTrFB8uX9UyXZqfy3/Fxpb1Ol6sEdSyQhBGsBGOhKiueJQJix5wM+kR
         FekTlHomSUSog82ynZBYAsjypTqxemyllQrMhidErGyU+qRNwd4mYiOKgynLgBu6Y2f9
         wt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767429; x=1741372229;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJXuy9g+fIYCpUv35AHIylFJGRqMuxPCbt3E+0p7mQw=;
        b=FucC7b+HakL6Q8hrTyqxPo2OiM07heVIVUix7ve0YUWwsskpgA4dJmG31nvBWCckQO
         TNq4npubxkDgqdJyGhXU66y6dpWkb4fWYwhp4aNr7AqH138ENVHVrD+YyttUesprP02W
         zgaQQDDWR5LC+6BIGJWfRoSWKm4/OI4BGI4imDg0eCG2LzFRO3tiCcKxxA5LrfoGMs1t
         hvY8C/PZXHlDGUE9rGU2HEPfE+Kmb2DydshFVTlZf59+K1oIaM31OdjQGH0Yvq6vF4fs
         zbtNY/24ZTZxxOgBAQZv4QIsjc2HAmY8VyoYusBLLQdX3tW7vuikRtjjh/ybLLiNalSP
         cgVg==
X-Forwarded-Encrypted: i=1; AJvYcCV3VIhGxET0NURHPpOXjSeR1BAqi5Bf23B9kZiTaZnBvDaC67rkbfpIesKOLfxzkZCaR3Uhx3XrT73ld7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRU495WswhwSVbnSuiwwvw8lbbHaejup79VB6HtOTq7jX/Xlxj
	IWc0huD+gY6Xo+jx4pttdtKlBnaB2TOjgFbI5/Gw1RRbnGElu59ngXrWm+gFdwjsEX6VJQ==
X-Google-Smtp-Source: AGHT+IGyWQ5eAZFcGmvk4D9+09d3FgZW3zWgk6sQSpIGwMbzM1TQ8agrO5NPaNt1FY233n8g7xNvD2p7
X-Received: from pjyp12.prod.google.com ([2002:a17:90a:e70c:b0:2d8:8340:8e46])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c88:b0:2ee:ee77:2263
 with SMTP id 98e67ed59e1d1-2febab2ecd6mr7718548a91.7.1740767429126; Fri, 28
 Feb 2025 10:30:29 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:26 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-26-fvdl@google.com>
Subject: [PATCH v5 25/27] mm/hugetlb: add hugetlb_cma_only cmdline option
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an option to force hugetlb gigantic pages to be allocated using
CMA only (if hugetlb_cma is enabled). This avoids a fallback to
allocation from the rest of system memory if the CMA allocation
fails. This makes the size of hugetlb_cma a hard upper boundary
for gigantic hugetlb page allocations.

This is useful because, with a large CMA area, the kernel's
unmovable allocations will have less room to work with and it
is undesirable for new hugetlb gigantic page allocations
to be done from that remaining area. It will eat in to the space
available for unmovable allocations, leading to unwanted system
behavior (OOMs because the kernel fails to do unmovable allocations).

So, with this enabled, an administrator can force a hard upper
bound for runtime gigantic page allocations, and have more
predictable system behavior.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 mm/hugetlb.c                                    | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ae21d911d1c7..491628ac071a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1892,6 +1892,13 @@
 			hugepages using the CMA allocator. If enabled, the
 			boot-time allocation of gigantic hugepages is skipped.
 
+	hugetlb_cma_only=
+			[HW,CMA,EARLY] When allocating new HugeTLB pages, only
+			try to allocate from the CMA areas.
+
+			This option does nothing if hugetlb_cma= is not also
+			specified.
+
 	hugetlb_free_vmemmap=
 			[KNL] Requires CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 			enabled.
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 634dc53f1e3e..0b483c466656 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -59,6 +59,7 @@ struct hstate hstates[HUGE_MAX_HSTATE];
 static struct cma *hugetlb_cma[MAX_NUMNODES];
 static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initdata;
 #endif
+static bool hugetlb_cma_only;
 static unsigned long hugetlb_cma_size __initdata;
 
 __initdata struct list_head huge_boot_pages[MAX_NUMNODES];
@@ -1510,6 +1511,9 @@ static struct folio *alloc_gigantic_folio(struct hstate *h, gfp_t gfp_mask,
 	}
 #endif
 	if (!folio) {
+		if (hugetlb_cma_only)
+			return NULL;
+
 		folio = folio_alloc_gigantic(order, gfp_mask, nid, nodemask);
 		if (!folio)
 			return NULL;
@@ -4738,6 +4742,9 @@ static __init void hugetlb_parse_params(void)
 
 		hcp->setup(hcp->val);
 	}
+
+	if (!hugetlb_cma_size)
+		hugetlb_cma_only = false;
 }
 
 /*
@@ -7850,6 +7857,13 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 
 early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
 
+static int __init cmdline_parse_hugetlb_cma_only(char *p)
+{
+	return kstrtobool(p, &hugetlb_cma_only);
+}
+
+early_param("hugetlb_cma_only", cmdline_parse_hugetlb_cma_only);
+
 void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
-- 
2.48.1.711.g2feabab25a-goog


