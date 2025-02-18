Return-Path: <linux-kernel+bounces-520056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D709A3A526
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC21889502
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9135D28A2B2;
	Tue, 18 Feb 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0fHqhLL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49953280A52
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902647; cv=none; b=hVi6VyCc76hEhjIgvZmVoxxtdGC0qZibW+sbiHYYkVLoBahWC423Yp3iawtFPwflhYDbrqQ2GFQrcIlWpk8rKjROBottv53Y6A1Wcxq475NV43OnZ4xJ/Mp3m+PZg/EJrxd4+iZx48+lqoorrwRorcI05iI/FsEX35CHPTHP3bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902647; c=relaxed/simple;
	bh=vn7EyvyBDrgba+MbpgDvq7UiFKPU4I81xdjXm4x8dEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V6SCRIoheBRqmEY/8ha62WuNHFobgBsD10t3FNMuTNIU1RRC++X3s2v5Qd9ZPfuI0QQdgbdsL2g04pf2kYU3cFbZaBwjCerux4SdmU+5nT+7J7jdhDvgGqqyLSPIca0R71f4SSl65rjwovA46YUzZ1jLdNrxd2AZQD3DXfNLqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0fHqhLL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d8599659so99368745ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902646; x=1740507446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvfAfabT3FOQzTKFA/T5HKTcXvHT3pHZFdKCEk/uJyk=;
        b=b0fHqhLLGW/zvZxydNkph2IWUk31ggQFGM+su83dQJPKbCwqV4RXuELcBNyc0TSkhp
         Qg6S5N+VI8J8MUiy0ofc2uztRomZ/Se2SHzWhJAoRrv+X6GyKfd6I7iBSXkCazu/tK3d
         B7Lh1tA+EU+03gPWl/MJdw/SS0HvysFQEA/H0i+61BPC6F7huFsNOlk6NSdvNMlopA9O
         RD5ByjZn6DbVtqO+h2DDEIeSNWU5rykBU3wnQJ2ILmVpPEKoMX66e7G9kVKS7NJPSYXx
         IbL1hIeMZ8kb8vqocTGZ1wy936QDMRogqvHmNtTAy6RqCADTp7R7fsdFv7ylvW0eg+N7
         IrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902646; x=1740507446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvfAfabT3FOQzTKFA/T5HKTcXvHT3pHZFdKCEk/uJyk=;
        b=Xrrw590SWSt1NLU6bICCTLrqOXNGOzyRnrNqcoU+e9O5xT79weMnphdIeJunivgtUC
         TGcT+6mEFpVvowWXf21ax7RpjT2az2DFjEKpyGEP41IqspUBpj5Io5675S6K0naB9sA9
         7nEeQSVOh3ZYuC0zHEhpDjfk45VIvXXmL+0wQyrspiPSrSTlO8mljS5weo6SRS4oYwBr
         izBsEkuggOtX0yNVcXq4cnmyEA9tGhYMxe0jcqvGIJu2THdHdmk7eL8+Y3hrgeMdLyw2
         eSMAvGyb/QR4Tgmad0pxXPA8DlT0fCtG0kgto38raVQKhpd/k2PTjGlqgo20bwgqq5ET
         a6MA==
X-Forwarded-Encrypted: i=1; AJvYcCWrrSfYqeeNP94UsSNW8CGQFOfr+O3V+AK2IaduFIAwgmz6aPxAX1zotI1HpmXO6t+5qr3G6Bz8vApwLaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5Fa74FC6z9/bQLq6vjhrHHx30x6zsHF71gNsTOZYGwf6P/uh
	5swvpLZmvuxDcAZ3lfkB0UGWVXR0+7zZB5WfK51sBarIWFK3rzNq5yzcbROgMo3FbUQArg==
X-Google-Smtp-Source: AGHT+IFvSNPdBbepKEoVoWi1qQOaCYkORgQpakxpUeNt43f5okQM/hLmZPRepQHlQe973YIHv4a3xcRy
X-Received: from pgbda5.prod.google.com ([2002:a05:6a02:2385:b0:ad7:38bc:1096])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999e:b0:1ee:764b:ae2b
 with SMTP id adf61e73a8af0-1eed4ff48b2mr424330637.27.1739902645700; Tue, 18
 Feb 2025 10:17:25 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:40 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-13-fvdl@google.com>
Subject: [PATCH v4 12/27] mm: define __init_reserved_page_zone function
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Sometimes page structs must be unconditionally initialized
as reserved, regardless of DEFERRED_STRUCT_PAGE_INIT.

Define a function, __init_reserved_page_zone, containing
code that already did all of the work in init_reserved_page,
and make it available for use.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/internal.h |  1 +
 mm/mm_init.c  | 38 +++++++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 109ef30fee11..57662141930e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1448,6 +1448,7 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
+void __meminit __init_reserved_page_zone(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9f1e41c3dde6..925ed6564572 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -650,6 +650,28 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+/*
+ * Initialize a reserved page unconditionally, finding its zone first.
+ */
+void __meminit __init_reserved_page_zone(unsigned long pfn, int nid)
+{
+	pg_data_t *pgdat;
+	int zid;
+
+	pgdat = NODE_DATA(nid);
+
+	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
+		struct zone *zone = &pgdat->node_zones[zid];
+
+		if (zone_spans_pfn(zone, pfn))
+			break;
+	}
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+
+	if (pageblock_aligned(pfn))
+		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
+}
+
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat)
 {
@@ -708,24 +730,10 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 
 static void __meminit init_reserved_page(unsigned long pfn, int nid)
 {
-	pg_data_t *pgdat;
-	int zid;
-
 	if (early_page_initialised(pfn, nid))
 		return;
 
-	pgdat = NODE_DATA(nid);
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *zone = &pgdat->node_zones[zid];
-
-		if (zone_spans_pfn(zone, pfn))
-			break;
-	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
-
-	if (pageblock_aligned(pfn))
-		set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_MOVABLE);
+	__init_reserved_page_zone(pfn, nid);
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
-- 
2.48.1.601.g30ceb7b040-goog


