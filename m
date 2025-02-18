Return-Path: <linux-kernel+bounces-520070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9136A3A536
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75231739B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB722F5A2;
	Tue, 18 Feb 2025 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dcw0wYzL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62CD231838
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902668; cv=none; b=A8vwHJ+IhyF0WiR1tz7+P1GYjtmuRNl3Y4LWy1XgNpZMFC/I8dUnIOfFc4CM43MtEKjmVjE+iRB+qYgrSU1CqR84kh30O1RaSi07eiLGoJ6CK9w9dii8kxgMW+2HdclX/8PZ75YjP7gJ+TE88rr8LegtjorQuJJpTuIp0hxEXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902668; c=relaxed/simple;
	bh=A8ImzonnB7if/XN85ZlpSO03cvoYD/Ff9++9PdHTh88=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i/9QR83y5EXwM6ypieHFUZiHrI/ei1q641qtTbRGRngsJ6DI//mc7QcFCxGOeoU8k8vAeKBDrstLgn2ww9w87qJX0uAvYJLN0rL/eXs+Vr7J58cRk0jRqr7132doZ/rOOa7+Y1y66i/E9J8+mtWf/aU/4/GDpBa9MdtwgKx4r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dcw0wYzL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ee2e7746so87693195ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902666; x=1740507466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jPC4tchnt1N2YhIqVh3vzNfsaSlSSanvoj/zggZqrBE=;
        b=Dcw0wYzLRAh6HwglyaamozICJ/r+X96rt8xjoXj+z6d+gwNE1S6ZXuRIQiV8JiB7ZR
         yq1Ux6NrM6YL7cgYo6tJsIVSkeez4UTHH3PeoWD7PvoB1Zj1A0YI+NzmeUMZq6ciTWqU
         8eapsAmkXOJq85/MjynRdU4IKK2e6jOz735Mpbo4gI7S4DosQmrLCSyBX6AeMP0K1qT1
         xhU3onnwAXLfxrWQi5eVojZLKSFqXdzmoa92pqhvdLga4/cn4asCzeKz9agb+PYZsQzM
         AmsJp5CNaCKLo2CoCyxua+diwdjFjloRv2caIHD7xXM5ss0yKNjLp48U6TbEAR2Z3pPz
         OZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902666; x=1740507466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jPC4tchnt1N2YhIqVh3vzNfsaSlSSanvoj/zggZqrBE=;
        b=uR9LhqDpbG4Qh9LiNu3BnYHbCDanK2THXtLBCy52xkE3M+blXjJqXK/lKaceHeY0zL
         q1KX/w/3Mmke4eLRKPv62m4DKrE75GBfsd54GtJmp6yqagtQhni4Ca5NkZifutRnfEYt
         owG22YzsDQqIOkbFDmYBglmhOoH3u6PDJEd4or65zsrVuRLkPcu+pfcYQmngKUFVIaCH
         B9UTkHdJ/Fav1O+EWI/DMUz/62HHlNyTzjcS+9RAP0LxNWmjhZmq68Z77H6OklkMGin8
         FlNaPpo2UgewZbhXr6EGfSg6dIkgMB6PAw3ZM2vhLbmIGwX0yjpb+10a/jucjj1/lTTG
         3Asw==
X-Forwarded-Encrypted: i=1; AJvYcCVObvLKRUGNwQnrLEucn81XAxUoOpt5bWEhnK/hEd+36ZVlzFgnCk9kmb35OyveH1pe7stDCuXvh53pPfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZqsjXF+IvK8DEPOBl3y9GrT2nTal5qAA3iOrEVtvB/0wOUjn
	j78x13eXB3mFPymIYSsWIKol+h7KCDcQR7q5wbUIlNy3lF/qLTBorGzFKM8fZcEXEp7yeQ==
X-Google-Smtp-Source: AGHT+IEtEjZxSkaHGNUqLkCYYCbWC6D2V31JmuFgG4Dg2Vo0lypjwM3EadejgHbXDL3fVjUh+UqlBkvb
X-Received: from pfbga8.prod.google.com ([2002:a05:6a00:6208:b0:725:e4b6:901f])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c70b:b0:1ee:c6bf:7c49
 with SMTP id adf61e73a8af0-1eed4e3f207mr456118637.6.1739902666173; Tue, 18
 Feb 2025 10:17:46 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:53 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-26-fvdl@google.com>
Subject: [PATCH v4 25/27] mm/hugetlb: add hugetlb_cma_only cmdline option
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
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
2.48.1.601.g30ceb7b040-goog


