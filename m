Return-Path: <linux-kernel+bounces-429223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC889E1A4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B9FB30438
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B961E1C35;
	Tue,  3 Dec 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6SHasp1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC91E1A08
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733221259; cv=none; b=DaW4SX6VFoTQhqN6+4CaoTVQwGA1Kh28EicW73PvriE7DGPcmOKH8ZCcRT2fYlLO1n3shzqXnV9duOxlPDXC5z0AcCZeIZ08TqaEhPpDW8szRvEe5bYBN/m2SxHk4WYoG07ZNZTHbjWhKgmIIHaD+dCJUuhwsjTIXPULQtvgFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733221259; c=relaxed/simple;
	bh=05yCmh1K1wjem+5g+IcnHPf81FJnqIxWMWF+emmc374=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axCU20Fj9gGpMJn1J7pNfkOiOEWY/4XrvAEjRaI8z9U4mYT1g/nhLdJI3yGrHqeuR6DdlO3qMiFOPJvLp3IAZLosMdBJMQAlgTceScI9pBo6PxlD/90tTW9w+s0Y4Dinz5lfqEUIoMYNN+5msmw6kyJg4lawAOnOr30Ar5ZA6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6SHasp1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733221256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KuXsCiN6CgNOK8uGVa8JAJ/kvrPxb05TY8tmye2AuS8=;
	b=N6SHasp1jX9CJsaIAi7BKgZwXebm43nSSl45geObc2MvMwlkuCd40kVvARnjjR5pjhr89z
	7Q7NsKxiui6ujz5VHQhhbjBiXQ04/jxWF1HiEe9t3nR0rWxtw6iTEdd/42UtAn8R0jcxhk
	sok25VBuk9AgHShrUzcDzYsd/mgRWoE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-xc8apC4OPOabURqD3TN6hA-1; Tue, 03 Dec 2024 05:20:54 -0500
X-MC-Unique: xc8apC4OPOabURqD3TN6hA-1
X-Mimecast-MFC-AGG-ID: xc8apC4OPOabURqD3TN6hA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e9c69929so1054087f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733221253; x=1733826053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuXsCiN6CgNOK8uGVa8JAJ/kvrPxb05TY8tmye2AuS8=;
        b=qEqj19gK/547E+TIaEhAtyog0ZkJFtDA5wsaybl4I9EgOrWBzp65jKaGlEdIqC3YKB
         MBcmjrjgG+Efjo484JD1bFwbheukckNm7IInXq9eQvPB85AUJFAIZvQMRSTIsomUhFks
         SnblFoTtlznyeYmDYHkZrzPe9iVKL8gMoqOpLpiqLgBJtJZiwdOLNqoPmVCLL1yw5f0E
         4DWSkuRnsx56FAeU4rgarAd2hmX1c/ngbfZpFBWpXYSgp2V7FIvVYn0u6kJHWAEPLwFb
         ic7rWilDqsfzz41GNM8eIGSIuPzoPXmIvJom8msC1PzHCsasXvW34xJwGJepMsyeLq9A
         5hXg==
X-Gm-Message-State: AOJu0YwqctVGHgd48/ncZTPVlYYBFS6zyrncTuMIDTngkrPmN8bXunii
	OktnbKIr0vmwZONeHxmWKlqTWLY0M93a5WQW829KXSpV+Kp07TK5CvLUsX+qU05iGrkZvV41kC7
	TKHWMl2ePk+I1BOrQ8ZZyXym7TPHbjzMRMxWOCODM3XSiQbaCsYQiAevcmjtKrxgyxrbvhDr1jr
	XEFNFZ/eW+qdRbKJx08VnJ+qUzGTpQ8OUPOVAB0/MPDO6B
X-Gm-Gg: ASbGncusLzmUcMOb8CFaTLL+wngaHzmtxRNbOakl8Rb6eA4xjR9u2kdEBDx3jh92SWt
	z24WoY8Vouc3a6CCx3rXGB079JXVHM/U5eworedPFdP7UmigRZqs0Geu1KV7bWH77rM2R2s6UfV
	NO5H0QgoVAQ1waplHTXdEx8S1w/lvuglGQ3IeGc6bEkEsitSKBUV6BtP02qDsYA8f1TNMc4kdL2
	E6Y4jjyhjHsWbG7o4K5KXBSqHFJptrLbtDwE//YB2xP4Rg43xf9k5LnKWIa1WrgV68mGIURG8a0
	UpTqEcdA3cCVeyXX3dwuKhDJF3iutiXPOpg=
X-Received: by 2002:a5d:6c66:0:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-385fd3cd6f7mr1829094f8f.22.1733221252908;
        Tue, 03 Dec 2024 02:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUcQBJBdR4HizHodyjl1EPzzMhS7ngLuPEyY3t7jpaROf1CDbcTOfyfWdG/a/wFh72Na9XPA==
X-Received: by 2002:a5d:6c66:0:b0:385:f1f2:13f1 with SMTP id ffacd0b85a97d-385fd3cd6f7mr1829074f8f.22.1733221252515;
        Tue, 03 Dec 2024 02:20:52 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385ccd3a56fsm14953673f8f.62.2024.12.03.02.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:20:52 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH RESEND v1] mm/memory_hotplug: move debug_pagealloc_map_pages() into online_pages_range()
Date: Tue,  3 Dec 2024 11:20:50 +0100
Message-ID: <20241203102050.223318-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the near future, we want to have a single way to handover PageOffline
pages to the buddy, whereby they could have:

(a) Never been exposed to the buddy before: kept PageOffline when onlining
    the memory block.
(b) Been allocated from the buddy, for example using
    alloc_contig_range() to then be set PageOffline,

Let's start by making generic_online_page() less special compared to
ordinary page freeing (e.g., free_contig_range()), and perform the
debug_pagealloc_map_pages() call unconditionally, even when the online
callback might decide to keep the pages offline.

All pages are already initialized with PageOffline, so nobody touches
them either way.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

SMTP server issues, resending so it reaches linux-mm as well.

---
 mm/memory_hotplug.c | 10 +++++++++-
 mm/page_alloc.c     |  6 ------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c43b4e7fb298..20af14e695c7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -650,6 +650,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * this and the first chunk to online will be pageblock_nr_pages.
 	 */
 	for (pfn = start_pfn; pfn < end_pfn;) {
+		struct page *page = pfn_to_page(pfn);
 		int order;
 
 		/*
@@ -664,7 +665,14 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 		else
 			order = MAX_PAGE_ORDER;
 
-		(*online_page_callback)(pfn_to_page(pfn), order);
+		/*
+		 * Exposing the page to the buddy by freeing can cause
+		 * issues with debug_pagealloc enabled: some archs don't
+		 * like double-unmappings. So treat them like any pages that
+		 * were allocated from the buddy.
+		 */
+		debug_pagealloc_map_pages(page, 1 << order);
+		(*online_page_callback)(page, order);
 		pfn += (1UL << order);
 	}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cc3296cf8c95..01927f03af0b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1293,12 +1293,6 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 			set_page_count(p, 0);
 		}
 
-		/*
-		 * Freeing the page with debug_pagealloc enabled will try to
-		 * unmap it; some archs don't like double-unmappings, so
-		 * map it first.
-		 */
-		debug_pagealloc_map_pages(page, nr_pages);
 		adjust_managed_page_count(page, nr_pages);
 	} else {
 		for (loop = 0; loop < nr_pages; loop++, p++) {
-- 
2.47.1


