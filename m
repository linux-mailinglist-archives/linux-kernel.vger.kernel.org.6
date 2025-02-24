Return-Path: <linux-kernel+bounces-529616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AC0A428BB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58DD419C1288
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD930268698;
	Mon, 24 Feb 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K51PjnkB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC290267F41
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416211; cv=none; b=ke86jCSnd1o0L1RHaJPzhCSMem7kppwcjwjkzBfBfKS2OmldokKM+JXTmt5TzrqB1qz3esVh9pjo4oduTSHvBlzoCiU1KOQgm1e0g6yKTJK4EoND590/cGe4bHyFVgTMU/O6srM6np4HYfQUOPrEDvrTBpHOSWMt+I9n/Js8ywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416211; c=relaxed/simple;
	bh=qpkZkgDQSCpDOrawHj8ee8It7p8kTmPkI0TP7miUP/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ss9fl+C8G2VvOVT0Y6peGaPYyq3zvhZkUJPrN5odKWvA0A44p1vt6pBv8JkIqQOZq88nPmgGeFl1CD0zKLMmXWPLiWk5hkum9suyf40qtxIQ1gXMUGOPzD6fu0sOnXghIsxGayni6FEFfnfbK1Il9zZRfHXrD6fz5yx7eyI5wEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K51PjnkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4IIiK38txs39RTm2yNSD9uzsg2Epj+W/QUBXdJN6a7s=;
	b=K51PjnkBDK9AvOSH4NkFDDdNw0hDO3FlKi9FH6vLn2UDFFhm+yADFC8S6KSB8dlEb1et6+
	SqR+nLZBQKaP1hsvKtzBuZb34mWa94DiyoI4h5544KQp+tQLapv7hhbpQ3wRqsdL+bsLBN
	V8AV8O5G2q0UZzdxmHPLAvXMveUWPRM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84--N238KgcO0eWp7ExCw9R-g-1; Mon, 24 Feb 2025 11:56:45 -0500
X-MC-Unique: -N238KgcO0eWp7ExCw9R-g-1
X-Mimecast-MFC-AGG-ID: -N238KgcO0eWp7ExCw9R-g_1740416204
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so1894295f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416204; x=1741021004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IIiK38txs39RTm2yNSD9uzsg2Epj+W/QUBXdJN6a7s=;
        b=RK3MwhempaLINMZ9xINFFyKfe4v97ex67co50cHBVcbFcUTchjHTTA59TetoYmtLmh
         0tP1i3x/NgbgTKj6WG8OG3CNyybjNn83scolPgZek+PyjF1QFZfGdyxyIcQG/nSWYKVO
         0syF8FI0npQlWoWVxU84FwUdFzzrP88VAPR6VrC0TTcJzzEQ8019BgXweKMKIEJr73MG
         5lBtKYxieIteAllJznlNLnCl41L7xgiVhYjibsDqQFxNLzhnDvObgS1lHnnTYOMhopxL
         8zKj4kKDsgjb8zW1tEmA0cETTQptqX//WKdZkqclvCEH6qyA0efLFJQFd4fnmLjx3p9G
         y7kw==
X-Gm-Message-State: AOJu0YzZsOYC21eoZSJaN97D0B5IcKUweKyO4F7FAGJ1s2+y3n313cEt
	QsZDUvWXDFBFxohx4NBa6+cte6CBKIlQUeFkGpyJ1+x4uurDEMU3rIPugjEoPOUoEsH8LFPD0sl
	HqT/uN3OfbHSk9MJmmD1nfZlfN3Fsy6ByFjKoQ8dkwWaifi1r0mAXnt4WHVmva4eyehtjreyQMg
	SVJwUNZgnQloT5RTprTNLlom+Yn9pZ3lJC1k2ELoC1vmkv
X-Gm-Gg: ASbGncvvy43i8j9GM0I/SvtcZbEXTfnpTQjryK40xc1cqErKywTCtNA7/f5X/hY+mfS
	BCxKiFYCUduPtoNmJj+CW+U8OXYJP+OxtaCDBiwE1qfXbbH65EQIBHxmaIFTy/x0KdZq2okLiaN
	Ltx3KjVicXfJ6omsE0xYfwI5Iq1Qj9SQ1Mv0+QT/vXPjk7YTjYzoIKALeTTXONhJrUinh/tnUyU
	GwDC8EPeUKqyPFvyklSsivOXAboJWGFuGnhYeVlCGgQzOjOdB916Z4l8UNEkjOs7H8klygmVpn2
	UAC32u3ZUKtyO/Ov0vrOOInQMIjDpjt1jQHZ+lINGw==
X-Received: by 2002:a5d:5f90:0:b0:38d:c6b8:9fe1 with SMTP id ffacd0b85a97d-38f6f51d885mr12699092f8f.24.1740416204207;
        Mon, 24 Feb 2025 08:56:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHr48iDkbeT3BD6T31jawE7AoIz4aDQ8fc4EtI1CIkHNhBzvnREnXgHgZXA/JhJC2+PnfKZ2A==
X-Received: by 2002:a5d:5f90:0:b0:38d:c6b8:9fe1 with SMTP id ffacd0b85a97d-38f6f51d885mr12699040f8f.24.1740416203760;
        Mon, 24 Feb 2025 08:56:43 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f25914171sm32572475f8f.53.2025.02.24.08.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:43 -0800 (PST)
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
Subject: [PATCH v2 18/20] fs/proc/task_mmu: remove per-page mapcount dependency for "mapmax" (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon, 24 Feb 2025 17:56:00 +0100
Message-ID: <20250224165603.1434404-19-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

For calculating "mapmax", we now use the average per-page mapcount in
a large folio instead of the per-page mapcount.

For hugetlb folios and folios that are not partially mapped into MMs,
there is no change.

Likely, this change will not matter much in practice, and an alternative
might be to simple remove this stat with CONFIG_NO_PAGE_MAPCOUNT.
However, there might be value to it, so let's keep it like that and
document the behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst | 5 +++++
 fs/proc/task_mmu.c                 | 7 ++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08ba..1aa190017f796 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -686,6 +686,11 @@ Where:
 node locality page counters (N0 == node0, N1 == node1, ...) and the kernel page
 size, in KB, that is backing the mapping up.
 
+Note that some kernel configurations do not track the precise number of times
+a page part of a larger allocation (e.g., THP) is mapped. In these
+configurations, "mapmax" might corresponds to the average number of mappings
+per page in such a larger allocation instead.
+
 1.2 Kernel data
 ---------------
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 80839bbf9657f..d7ee842367f0f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2862,7 +2862,12 @@ static void gather_stats(struct page *page, struct numa_maps *md, int pte_dirty,
 			unsigned long nr_pages)
 {
 	struct folio *folio = page_folio(page);
-	int count = folio_precise_page_mapcount(folio, page);
+	int count;
+
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		count = folio_precise_page_mapcount(folio, page);
+	else
+		count = min_t(int, folio_average_page_mapcount(folio), 1);
 
 	md->pages += nr_pages;
 	if (pte_dirty || folio_test_dirty(folio))
-- 
2.48.1


