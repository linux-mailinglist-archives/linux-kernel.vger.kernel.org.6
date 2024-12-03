Return-Path: <linux-kernel+bounces-429183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3272C9E183E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC55716707A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE541E1C18;
	Tue,  3 Dec 2024 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qag3v4xK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADDD1E1A36
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219278; cv=none; b=Cc9pldlmytVBdwP/Ogv3v4hQX5u4Gv5T1Qofc80N639qr6dCPYykbvoYAPdcErFnq01JdC058YnofZptg76lgLXC73MrKIuVAKHgUP2PHJJ4VZO7VGTb0XkbTaMsoaJYfLgkHwJWzWSJJMe8vmdIzaQ2QKAIPwxvuNJxJAKXCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219278; c=relaxed/simple;
	bh=zqRmnKKh1kPNJZoY6ULf4DwM5/SkuHAG0kEMtPX7EWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bp1m9d5+jvOBZpUuKzaMSVpFkRqpyVmSxBEc3LwFu/915l6nMFArPHuoUCsFN+QnVYHGXBXca0wRDFueg/XKC0YwsKpibRt50ZWmI/Xk7WrdU2INwvZlmFePPe4prEj4TSTZvP5QuV58ELgZgyQOSnl07yTSzP6CMzxvMqrrEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qag3v4xK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xX/Q3/3Rp0ILyMXyKGOcZrJDDur/TZdwfSuBal5fAnM=;
	b=Qag3v4xK3lXWxeLz8Zb6EPUl+JkGkpXBwGPq75GEpipaUhN0o1Rm65PR8DRJYBDlCrdn7l
	O9sDbak5//WZ8UG1bhdkHB8N05HkKca9APEDNi6lSFyzgTrVJ38/TVQMVfmuzK4W2NIeSi
	rXsWe52yS8f9GzptE5V5zJvwiQFveQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-yX6fukVSO86l5fjPfxrkzg-1; Tue, 03 Dec 2024 04:47:54 -0500
X-MC-Unique: yX6fukVSO86l5fjPfxrkzg-1
X-Mimecast-MFC-AGG-ID: yX6fukVSO86l5fjPfxrkzg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385de8e0416so2187048f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219273; x=1733824073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xX/Q3/3Rp0ILyMXyKGOcZrJDDur/TZdwfSuBal5fAnM=;
        b=lFQFZSgDwfSftQok9UPBwnhonT22TjThLwvwlPPfofoxkbacMLy3gIfDIKzMtH02tz
         nZcVoHWZOQpLCx6iv2kOyZrmLrLY8ry94As7aNqUd4lWpenbGvRjZmm0cx9Ltrw6WTCe
         Gt8OSt+n3nr1lCiS4D71jRimIQh+P144cKiEZ31YET1WeOGipt0kahTgcZVrK1vIuKKI
         YzG+OIzMQ1aRbI469JgGEZ6HkIv5iSut9JRzRYB12MrA12BlYyvb+fLVxZni/K/LTsXt
         32kc2VU7kdts1P3yBqKfdc7XlV9KhCX/4B8Cnd1HImMkAOuuyFjNC30uaDBNL+6t1Wkb
         evAA==
X-Gm-Message-State: AOJu0YzWQLAaqeJl5SGyzWVbBvNVbDgmwrgRhQlm9dgZsj4/5x4egtLY
	PMzsNO/T3elwiC+H9j8oDZs095BOeN88rI86Kq+Jbgyuh+6211hsu5zDVmJ++Q//Qe2eZwcNJGO
	1PW+IZ1EEOaayx+/Un1Wn2h4bKgsk/g3IZm4rPw3PWXu56cP7sKSZsRU03Hk6AfNx4Ar1ubkOWR
	p5tI1fkMxzbSvJvtmemgJWbqNPwzR+9NMfcekta85zNEEe
X-Gm-Gg: ASbGncsH2U1JEaOKd8VPmKpBhrkpwm/FYlzJxizZKsqZZmQFI1vGHnc3+2rUYL4FW9d
	n6ZiP0+rSmQo2PE/gHCQqHTWtDORWGKRA2LJoCN42d8mRgx3F9NJ2fSw327e7zRYC6lO7qhnKjp
	gb1gB+phDmDrN0KQnNV7xYoza7SUmqcTnRMymj/a6ryVNqqaKdCl5nAs2ohYKDi+vNnfmb2JwM3
	9GEzNH1A72jEx965npOKnAfZWcDsxC8pHLFy1zqFkG4VHkZbpy1IRZYWkF+vN3RECtFZlgTKHz+
	/oykKENgA/h2BCD1+oaevmiQOs3LZpIKiLQ=
X-Received: by 2002:a5d:64e8:0:b0:385:d7f9:f15d with SMTP id ffacd0b85a97d-385fd3f2203mr1331603f8f.11.1733219273255;
        Tue, 03 Dec 2024 01:47:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDQ5OaqVY3m0DLSpLsQFBtVdXjpTP6F01guYNPwPEOIqC9M1Xr0t++bvv36PMaxbsj7juBag==
X-Received: by 2002:a5d:64e8:0:b0:385:d7f9:f15d with SMTP id ffacd0b85a97d-385fd3f2203mr1331571f8f.11.1733219272794;
        Tue, 03 Dec 2024 01:47:52 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ccd68c1bsm15299309f8f.84.2024.12.03.01.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:52 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH RESEND v2 6/6] powernv/memtrace: use __GFP_ZERO with alloc_contig_pages()
Date: Tue,  3 Dec 2024 10:47:32 +0100
Message-ID: <20241203094732.200195-7-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203094732.200195-1-david@redhat.com>
References: <20241203094732.200195-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_contig_pages()->alloc_contig_range() now supports __GFP_ZERO,
so let's use that instead to resolve our TODO.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 31 +++++------------------
 1 file changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 877720c64515..4ac9808e55a4 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -88,26 +88,6 @@ static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
 	}
 }
 
-static void memtrace_clear_range(unsigned long start_pfn,
-				 unsigned long nr_pages)
-{
-	unsigned long pfn;
-
-	/* As HIGHMEM does not apply, use clear_page() directly. */
-	for (pfn = start_pfn; pfn < start_pfn + nr_pages; pfn++) {
-		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
-			cond_resched();
-		clear_page(__va(PFN_PHYS(pfn)));
-	}
-	/*
-	 * Before we go ahead and use this range as cache inhibited range
-	 * flush the cache.
-	 */
-	flush_dcache_range_chunked((unsigned long)pfn_to_kaddr(start_pfn),
-				   (unsigned long)pfn_to_kaddr(start_pfn + nr_pages),
-				   FLUSH_CHUNK_SIZE);
-}
-
 static u64 memtrace_alloc_node(u32 nid, u64 size)
 {
 	const unsigned long nr_pages = PHYS_PFN(size);
@@ -119,17 +99,18 @@ static u64 memtrace_alloc_node(u32 nid, u64 size)
 	 * by alloc_contig_pages().
 	 */
 	page = alloc_contig_pages(nr_pages, GFP_KERNEL | __GFP_THISNODE |
-				  __GFP_NOWARN, nid, NULL);
+				  __GFP_NOWARN | __GFP_ZERO, nid, NULL);
 	if (!page)
 		return 0;
 	start_pfn = page_to_pfn(page);
 
 	/*
-	 * Clear the range while we still have a linear mapping.
-	 *
-	 * TODO: use __GFP_ZERO with alloc_contig_pages() once supported.
+	 * Before we go ahead and use this range as cache inhibited range
+	 * flush the cache.
 	 */
-	memtrace_clear_range(start_pfn, nr_pages);
+	flush_dcache_range_chunked((unsigned long)pfn_to_kaddr(start_pfn),
+				   (unsigned long)pfn_to_kaddr(start_pfn + nr_pages),
+				   FLUSH_CHUNK_SIZE);
 
 	/*
 	 * Set pages PageOffline(), to indicate that nobody (e.g., hibernation,
-- 
2.47.1


