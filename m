Return-Path: <linux-kernel+bounces-520051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6060A3A520
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55C23B17FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13DA27FE7A;
	Tue, 18 Feb 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDTseKTl"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1327426E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902641; cv=none; b=LvdrVNtCy6zFgCH4F0Gqvt+YdvygDAKbc/UB2jwlNPYK1+fj0AlqWDtVNNm6Oa1Rj8uKCGtK/md3aU/d7iCYDcU1kXfEh4JQ2U0ypPlc5pWILs1rNhb2OIlOYMpO3PaXGNujtJN3uTO9VZJX03jvGMP7bcxMpcSOCmk4OQWIPAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902641; c=relaxed/simple;
	bh=nF7VnURWI+W4hi1BGT8EliZkhVgcgjctoTXyyeYITwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uTYA/AQQpJlRkfueiFnk03Ua8EXPQEZ4hH10XGL5HySop43zUJK66TII6Tyg4DvzBzLc2OGR6r3e4UyyvRBKzs2G1oTB41kElX/GxjEjRR1lr7C+OA9p6ypbV35ZWJZ2uqPLNJGnsAzwXwLtpQwebxvbABL9FGxmmecVAr2hVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDTseKTl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso11409503a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739902639; x=1740507439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LI59bwMf14K7zqmv7lidvyJaJYBmHXGc9XaKmUDK00o=;
        b=SDTseKTlvxbfYzCzvqHwnzw1WzqwyfMb1uWdATzzboft93IYKCQtdVs3kPfqvzvPn/
         px13WQ8iz2tgU1HiMSDGfj+Fqc04+YXdJY2eXdvQVsuE/eTLuLkUJDkzWfXOCYcTJzld
         /V+9gChZ7/T9Rx/JEOYowrD5P2zk1/VFiBNru/zfyGBdGIHxB0L2aSfgwwg+3coKoPF8
         VZ5pbuZO1S9+6k95NshvWV2/NR6/UPpxD6+26KfRfT2NEwa6DRhI/n3gtkENFzZBf/GI
         lNXM0cfWuEy0/tZwUEOm2pBvqfHogHBl8BogD8wGRcLK0DobCrSdv7ZqRBxSKfQdLk8G
         b+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739902639; x=1740507439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LI59bwMf14K7zqmv7lidvyJaJYBmHXGc9XaKmUDK00o=;
        b=XJjjy1Nvwu8uDcOoJNiNCmtkfvj1Iiuxl21rrXjBJK31u4dx5NILxZhGQ+HaSHaf+o
         9rK0IUluLZC7UgrBUMDby81aavl0+C5vXYjWqQ7+jH/gYYql5MDXRuDGn1Gwp1cuxv+a
         DKft7fZ45AzVOHOkjBWj7qr73n/Mf+5UctluhkM5sZVRS68nQBVBVIde31G+4GDzcqL9
         HUM4KCYYQjmrTfmbv/jEjPRo2BrIBxj4URnokovix6I5a0uYblJn98ZTRqTePRc1pY8S
         0DuallOOtZF/tdVKNSuk/iMM4Jl20JdSuPL1GEWcPLcXKQ540wEFx7jddgLNajZXsOLo
         WQYA==
X-Forwarded-Encrypted: i=1; AJvYcCVGHwYCcbnW4wmLXY5rKlmJeGUOqhpZA8PNEnPGCBsuPl9KtthYfQ6LNNQskN+TsRndvYzRVvQ6H1a0rw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyY1nZ1VZtk4NOkKAHzh2S5BnZBMEwrc4/vjKR97UTvGV4kkd7
	8H1LIFGQFUiMTb+hOi5xlPl7i9m5UnuKfhFMiYEfFD1ZCTeLuc/tJPyAkYB2IyWpmVOelA==
X-Google-Smtp-Source: AGHT+IG9foWIdjzRTrMdjif1U8LT9wkYyvNc0HI0vWqalqwP0zFxC1Vsnt6pOAwRi/AdmSVzfgrNzojU
X-Received: from pfbcb13.prod.google.com ([2002:a05:6a00:430d:b0:730:8636:67d7])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1a89:b0:725:cfa3:bc6b
 with SMTP id d2e1a72fcca58-732617757c7mr27894680b3a.3.1739902639374; Tue, 18
 Feb 2025 10:17:19 -0800 (PST)
Date: Tue, 18 Feb 2025 18:16:36 +0000
In-Reply-To: <20250218181656.207178-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250218181656.207178-9-fvdl@google.com>
Subject: [PATCH v4 08/27] x86/mm: make register_page_bootmem_memmap handle PTE mappings
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, Frank van der Linden <fvdl@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

register_page_bootmem_memmap expects that vmemmap pages handed
to it are PMD-mapped, and that the number of pages to call
get_page_bootmem on is PMD-aligned.

This is currently a correct assumption, but will no longer be
true once pre-HVO of hugetlb pages is implemented.

Make it handle PTE-mapped vmemmap pages and a nr_pages argument
that is not necessarily PAGES_PER_SECTION.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 arch/x86/mm/init_64.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..6e8e4ef5312a 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1599,11 +1599,14 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		pmd = pmd_offset(pud, addr);
+		if (pmd_none(*pmd)) {
+			next = (addr + PAGE_SIZE) & PAGE_MASK;
+			continue;
+		}
+
+		if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
-			pmd = pmd_offset(pud, addr);
-			if (pmd_none(*pmd))
-				continue;
 			get_page_bootmem(section_nr, pmd_page(*pmd),
 					 MIX_SECTION_INFO);
 
@@ -1614,12 +1617,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 					 SECTION_INFO);
 		} else {
 			next = pmd_addr_end(addr, end);
-
-			pmd = pmd_offset(pud, addr);
-			if (pmd_none(*pmd))
-				continue;
-
-			nr_pmd_pages = 1 << get_order(PMD_SIZE);
+			nr_pmd_pages = (next - addr) >> PAGE_SHIFT;
 			page = pmd_page(*pmd);
 			while (nr_pmd_pages--)
 				get_page_bootmem(section_nr, page++,
-- 
2.48.1.601.g30ceb7b040-goog


