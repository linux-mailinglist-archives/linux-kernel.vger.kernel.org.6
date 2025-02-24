Return-Path: <linux-kernel+bounces-529605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1FA4288E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35FD7A856B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDD726658A;
	Mon, 24 Feb 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKgbasYB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AA0266199
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416187; cv=none; b=rpGVco4Y0RDBzZf5iWT6phpnLE159ZFMpW3zrcp5MLo+cSd8CDtkysTAhqDF14r3Kv94vHx1UhA1ZRcJEkL1+2/OroickfZARYYMxgAY0kjePNvNOV3d3aEsEBxt8iQDLaZ8gFpsmvaMhoUEKNKm161msk/LaITclV0I+sAGj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416187; c=relaxed/simple;
	bh=jBMc/6KfiUuhsqx8U3JCMjpv5FKb+tGdfD4lU0RajKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1DcJ6Q3vIB0cZ30rDjCqYS7FcthiTPHtMuelUzt4Po/h8hTvDaOYeIAq/85BNlfpMGGSsXSrAHc6/f6bzRFUF4z/qU5P6IxgAkv7UYuLoLJaIn7c7b+ar0QzaHrsjN4pbUVSt0yGPB0biPKUIBQE4AxFBpp5YVS4SqfHrf7HWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKgbasYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
	b=jKgbasYB02yaCJ73nPuVCeeVAphtL8YpC5H4XOWwKtenVzDrvTUTyFqKUe9uXJhFjT5WBX
	TqdsBWlqI++5GO8x5frdfGpYkxKrOKjO3uoimWASuYTwvOv4OYsKMnveTyxybBo58ZMsz4
	vi5jdc/VBOGS1bxCvpKQwbh9KrLUacw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-bYNy1XJ6Npqc49XBDLE_Og-1; Mon, 24 Feb 2025 11:56:23 -0500
X-MC-Unique: bYNy1XJ6Npqc49XBDLE_Og-1
X-Mimecast-MFC-AGG-ID: bYNy1XJ6Npqc49XBDLE_Og_1740416182
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f37b4a72fso2695782f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416182; x=1741020982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
        b=Cqmqbj1eFKROrCmL+Tr9SlceABSkrdiI6rKndJpjtSzrdAdRIeqzj2+iFIPfpAa35A
         7e1Vu42jT3uvkxYmjudVtq3VsdrwYrzqiT8MCkOpXpzXbmbTPrTElUc3++fiTyf09DYr
         iEf3JT7o2A3tBRuWl1VwqV5re2r0AaBO80gISKJe6lN0acGR1b1lSQWEpzz/2Rl9aX3P
         y0fUSx8qon9qkc/WHTgiCwBDAdK8tje29yZ3x75BysQ2kCgQhkaAKS0IYLkZabA/L4AP
         aMJLeKaULoaAF3hF62NQ2cA4TvyrwpAAKKe9F+BckAczsJ/PlzFgpfXE2Z8hLAGWuwH3
         PYfg==
X-Gm-Message-State: AOJu0YwOuU2E1gE65XBaJ8HN1uGXsIZ3+VahodozhQUVOVKuNJx2oB25
	G0kNFuMxlfSeOwt7U4frWwMgvf9PdjHkLau9MJ7diDnN4XaY8MULKPF/5tBEAuG7tcOLnDv56ZR
	YWi09SBx/oO/EBc1oyMXVvqlFCf4PDwHZ42sn4YLAVNMD2FF1XMSUbYTJ6kE4T02XSIMHc2Rnpa
	6gwCLevNcTtuRODljoehckds/sHT23G6lPRj1o2sKa+fcf
X-Gm-Gg: ASbGncuulcnCbgN8VGPkeglTaV0Vx/jZRcfiGPx7bZvpGRml2YayEnKfvL8EUaoiyIX
	U6ai7L/F2A4CMKIJXvrtzQ2+5TtrO6fmBnZB+HeJ1R6Na1TJf/6JmXfBE/9q4gM9NEtDdypOOtc
	hP1g7Xf57JfD1cLfX0KetkyDCLVrM+Vw/Sm6W3fVDYDjMSDiITPqK1ceBxXSPhLwioROfgclWXb
	C7VN5Qs/wNgYlrUMcE0M4RBN+6dCgyuTjr0TbUYvxQcJPvNjMDXldeScJ6OmYQHZO2+JcnmXHjX
	s+/Mv6irdZ0blrsN3N6lUf26sC0I48cHe7WhSN2m/g==
X-Received: by 2002:a5d:6d82:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-38f6f3c507amr11123625f8f.1.1740416182394;
        Mon, 24 Feb 2025 08:56:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG35xVnH9LhIY4oSSBr3n8xfuxml7Goul51SSXyqtQOXZX4W9oDib+9PjJY2pvFXqp8djOQA==
X-Received: by 2002:a5d:6d82:0:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-38f6f3c507amr11123573f8f.1.1740416181836;
        Mon, 24 Feb 2025 08:56:21 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f8115sm32604557f8f.92.2025.02.24.08.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:21 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 08/20] mm/rmap: pass vma to __folio_add_rmap()
Date: Mon, 24 Feb 2025 17:55:50 +0100
Message-ID: <20250224165603.1434404-9-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need access to the destination MM when modifying the mapcount
large folios next. So pass in the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bcec8677f68df..8a7d023b02e0c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1242,8 +1242,8 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 }
 
 static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum rmap_level level,
-		int *nr_pmdmapped)
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_level level, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	const int orig_nr_pages = nr_pages;
@@ -1411,7 +1411,7 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 
 	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
@@ -1582,7 +1582,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
-- 
2.48.1


