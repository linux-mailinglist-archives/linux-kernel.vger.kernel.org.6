Return-Path: <linux-kernel+bounces-429178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6E69E1831
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A021D280C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87951E0DA7;
	Tue,  3 Dec 2024 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO0P47Sj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56351E0B78
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219269; cv=none; b=pXz6UwwN6YM0KjslBtb5gZCnRK5YZT1I9bAV6ZbVp/flMmbZnvkf3UA5mtL2rFmRVPG00VFfFCyhOZCE4ScmlSrPD2WrUiARnZXhGm4jedjovlFu6deRBejvDHmPFxrZjSq+cFW2dfR0fJ5i+1BdItIUc64Qide8C9wjcRd/i0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219269; c=relaxed/simple;
	bh=n45GhTq8SepWMrRk6KmDNVm5gUB+gB/12JUs1rFL2Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnSpkfN61Kj34y9IhOFzjvCvaZsXoqACI70Mf5Sk9KeLX11dr/7UwUu2mIFfloZRbh7VkrFQLUcEm9eobxgJEnHn0nSagZjO9VmCrUbqdMfMkIvXgkLPx1RXONkQFtaGDKePcUdknDtv+fMdwB6Mb9kV0O8Kiq/plb2A/6hKjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iO0P47Sj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LU3Y8BABokL9EuVXZz3YTSIe3emDP78aZncO4AsTCRE=;
	b=iO0P47SjavAj0xgi2i73WgsAdJ1E0QhiaiHH9UaDw6FEjdXCUOIY3desMmD2yDMn97PtYR
	73LBWAAtI9w6mn80ySkTJNKD3Ha5f0Sa+ZOS3EWk3ZRl7zhN1FGJ1b8gIa2ssHFZTlk1WS
	jqM36j7zxFM7jhU3z4K+WD5ye7ZP9XQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-aeAPzsTvOYegG69KBJ22LQ-1; Tue, 03 Dec 2024 04:47:45 -0500
X-MC-Unique: aeAPzsTvOYegG69KBJ22LQ-1
X-Mimecast-MFC-AGG-ID: aeAPzsTvOYegG69KBJ22LQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434a467e970so37367135e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219264; x=1733824064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU3Y8BABokL9EuVXZz3YTSIe3emDP78aZncO4AsTCRE=;
        b=r6ZrqZjsrg5tAI1dIWYV7SCH5pNtMOfwDsXSL77xYfHm4YcWM1h/XgKDEEc27Cvdye
         TA9pDbwAw42CebVmte7dppTXkAXBOG7lkuYdWN7O5iQO2zfFqXxNlgCZDbVt26UIzBbd
         mMcwgGK2oVq8fgRz207VSaJt4w5j4tuKnf+DpLQP07BZASzpPLZ/FPzaXaBCzZL+pV2x
         vQJ7DUEzRbX5BJRI709rd+QbQvIRRzyppGCBwan0etJDpcfvvvrwuqHhywycI0a/xc69
         1kYIVcofOtnzRkBpPqGXR344aKzwROd80U+LOgEk3Ux91mYdrqx0hIlGjmiYDwEe4U9D
         rvwA==
X-Gm-Message-State: AOJu0YwUuE7D521yceZLHAD2e52DRpalqhoD35g/ESDAaXcGVaIFNPpK
	rSXB73cHsSyWxwlpOWxUdM82R36tVoHsDMzS31k+152LbwgMNQrObmOpUCaaMsAlj9qWIVIBuy/
	YWpJJLOsTKc1Vyiza1FjKJezs9LrA8f6lkN3OfFuoRrJ7CU8PBPnz/9bkPMHH3+f4iNeqGcw+Tv
	iuMUmygMfTaKZqt/sXtiuSIXfAwZXiCfYOjW7JvuQAi8yk
X-Gm-Gg: ASbGnctikpyqsZt6XZeA3bZ0KTctvKo5bUQRfYe0PvzfqEltA7iMXaj31ABEiXD2rrl
	l3xqi4T2tXla+4i2e4lskU4Zy+ZFX4ZtJIY1Tvgts2LKKChOPG6Ag59YSScUwatPzbvTi62mo6D
	RJz5YYQtDrhvMN6QrYhyhCanUlk9NzfT+Kq0H+Y5MQ4Ty2q/hvJrYAoUG7+XTBjHbfY+4yDChRf
	njU1aZRsw1IfAecBHePaWItNxRRIgehIbyk4n49zw95gC6MzbQ7yn9eEfo31gr2CO8c6+QCG+jR
	BV4Rq1NXTNCgwH38yMSTGKKvq/oEd9/4I9o=
X-Received: by 2002:a05:600c:1ca2:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-434d0a03d92mr14496315e9.25.1733219264420;
        Tue, 03 Dec 2024 01:47:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3m9gr407PRBCaVgPUBaqcArqFbwV0w48JRDx7WvhZgMUXfRC/MZaf7nSG/r3cgNlikqmXCw==
X-Received: by 2002:a05:600c:1ca2:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-434d0a03d92mr14496015e9.25.1733219263982;
        Tue, 03 Dec 2024 01:47:43 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434aa7e5e59sm218218545e9.44.2024.12.03.01.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:43 -0800 (PST)
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
Subject: [PATCH RESEND v2 3/6] mm/page_alloc: make __alloc_contig_migrate_range() static
Date: Tue,  3 Dec 2024 10:47:29 +0100
Message-ID: <20241203094732.200195-4-david@redhat.com>
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

The single user is in page_alloc.c.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h   | 4 ----
 mm/page_alloc.c | 5 ++---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 74713b44bedb..4bd3685c33ef 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -839,10 +839,6 @@ int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
 
-int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end,
-					int migratetype);
-
 /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
 void init_cma_reserved_pageblock(struct page *page);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f371fbf2145b..ce7589a4ec01 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6284,9 +6284,8 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
  * @migratetype: using migratetype to filter the type of migration in
  *		trace_mm_alloc_contig_migrate_range_info.
  */
-int __alloc_contig_migrate_range(struct compact_control *cc,
-					unsigned long start, unsigned long end,
-					int migratetype)
+static int __alloc_contig_migrate_range(struct compact_control *cc,
+		unsigned long start, unsigned long end, int migratetype)
 {
 	/* This function is based on compact_zone() from compaction.c. */
 	unsigned int nr_reclaimed;
-- 
2.47.1


