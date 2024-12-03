Return-Path: <linux-kernel+bounces-429177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333E9E182F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 372D616321B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC271E0B80;
	Tue,  3 Dec 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdmVWFr3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8671E1E04BE
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219268; cv=none; b=cqyj0vvz36HjLhgakM6bzI4KQw2d7FB616+9gQelAwgoQfj/WbL8hBXAxP8O9mWQorecxd6ZsiGkxrEMDgrAlqsX+nxH/AohZkjDHHNgKKScHcBu3PG9AFi6PR0bQ9abUjxxH23uwqy1qON1X7/R/qgS4PcEgU24nlk/7LPBXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219268; c=relaxed/simple;
	bh=o2mUFz9Qo0EEvVKmfnY1eKUoFVJY4p7UuPM/vzelNKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0wSAVe3TAXfsvVHJdhlF0/YGeyQRyFVhCnf5jHq01VZ9r+ruTRpOJdWO2Mv+JFrU0xRf1gYLt0UjsE3JxXhFyheq+DZuMy5K1PLol8tLSDC5kTfptaGFxfhX95WfNiBPkwDPF7GqtgdMEU9a2zB9rQwYNFjuYzJ1Ht/F3hdQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HdmVWFr3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPPCObfnf5xw33aPmiPyCg8m61901qLXiqhqw8UMgIQ=;
	b=HdmVWFr3L8OpjabRroq5GQYQrd+8V8VvRjQvCU2u/o6QltFK9pCmzHeX/bw7wrzM+ncU9U
	CcFkfJukj9u9bi2k0RQpiI9QiizyIH/x8750KsI4QklG0Lod3lE3a2pHIwTUfinPLOyWhA
	9IysE9q/fAW9IloXkWhSY8RMcQ/O62E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-rjA6AV-XN7mU3rlcfYYJzQ-1; Tue, 03 Dec 2024 04:47:44 -0500
X-MC-Unique: rjA6AV-XN7mU3rlcfYYJzQ-1
X-Mimecast-MFC-AGG-ID: rjA6AV-XN7mU3rlcfYYJzQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso49902505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219262; x=1733824062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPPCObfnf5xw33aPmiPyCg8m61901qLXiqhqw8UMgIQ=;
        b=kxTv7Ci2WZLsXVbC44XTJDwGqCwTOrMrvM+tTeZzfB9g2nR08EeCXqWDAtrCyKnVAd
         qAux1kk7nxixARGQsKmyvx+P7O1Mdap1StP8nzNNI1Kdgd2tDIoOVRqNqxN0lFJItJoT
         uN0wSjxOeRs8Pc1VBu7biJsW0CGHuXxexJpJfrfKsOFSAsYlf95tfCMscpX0D5HGMWI9
         jjUjYzQ1INJfj7J9eiD+BCfl1eVC1vIvsZklB19aVysNDvj55nc17zWkpAm6XEB2merz
         hR8JNtm47D+5abWV63YCUB68sRfuGsd8AwQ7JUJ+3iS38x2zsTZ/W+dUa2QBD479va8J
         SpUA==
X-Gm-Message-State: AOJu0YxkLmMsSkXY7DkYnRAgDgiTdp62UCEUzvTRLw3+94SalLBe+21q
	mz2ZWuTwBkFQ8Z4l+puxSjjLZSLudKyuVOQ09GGXmTHbiLTSHz7NYTIMQyAIEU9n5oycyl2Xnsk
	BLCqka8asSyvRG11wCq2IAWkUkX/HeXEgu7SUvaHMTc6msXEfPogG2tGZAv9Cv57HVT3B4AH6sl
	I/94Uc6RZgVKDEOJAjJ1YiERHnRkgUetsGy2hEP9cTq1Mq
X-Gm-Gg: ASbGncvX/JtIMKP2vn2W0Bt1N9FhA6/ypP7KSnQ6xsbXJ3m1N14FKteFcXIY9ci22TR
	ZgnikVl1c03fMKBikxAjmxtfnEUSl9ER9B8itKbqX6+Z9ouqo5xxTj7euvCPNoZfP9zX/QCG/nl
	3PRiJqvjKaizx2t7WC+Yn1eBmSnCliVQmvD+JsKTDYSs8+IUWMLRMlKzrzu0OTw2l2axEETtPqv
	XbFDUOeuR3u10x9Nvdr7ahpXRjBiGGV8WhSsWrSBcOarugkSxvRkO99AuP+MpesipLi3Scn4WU3
	JHxZBA+6qBN8YKFuUWHNTGixu+w9gilof+o=
X-Received: by 2002:a05:600c:5491:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-434d0a0e312mr13336315e9.21.1733219262457;
        Tue, 03 Dec 2024 01:47:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNQApWxNUm3SxdrUec7I7codm1+2ABsn7OxpSKkkoTEG3/Y5H+HiqJe5tT8Yop4NW8Dk8lkg==
X-Received: by 2002:a05:600c:5491:b0:431:5c3d:1700 with SMTP id 5b1f17b1804b1-434d0a0e312mr13336025e9.21.1733219262074;
        Tue, 03 Dec 2024 01:47:42 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434b0dbe2e7sm183143505e9.11.2024.12.03.01.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:40 -0800 (PST)
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
Subject: [PATCH RESEND v2 2/6] mm/page_isolation: don't pass gfp flags to start_isolate_page_range()
Date: Tue,  3 Dec 2024 10:47:28 +0100
Message-ID: <20241203094732.200195-3-david@redhat.com>
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

The parameter is unused, so let's stop passing it.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-isolation.h | 2 +-
 mm/memory_hotplug.c            | 3 +--
 mm/page_alloc.c                | 2 +-
 mm/page_isolation.c            | 4 +---
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 73dc2c1841ec..898bb788243b 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -31,7 +31,7 @@ bool move_freepages_block_isolate(struct zone *zone, struct page *page,
 				  int migratetype);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags, gfp_t gfp_flags);
+			     int migratetype, int flags);
 
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c43b4e7fb298..9b184ba064a0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1992,8 +1992,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
-				       MEMORY_OFFLINE | REPORT_FAILURE,
-				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
+				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
 		reason = "failure to isolate range";
 		goto failed_removal_pcplists_disabled;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cc3296cf8c95..f371fbf2145b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6451,7 +6451,7 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
 	 * put back to page allocator so that buddy can use them.
 	 */
 
-	ret = start_isolate_page_range(start, end, migratetype, 0, gfp_mask);
+	ret = start_isolate_page_range(start, end, migratetype, 0);
 	if (ret)
 		goto done;
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index e680d40d96de..c608e9d72865 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -442,8 +442,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  *					 and PageOffline() pages.
  *			REPORT_FAILURE - report details about the failure to
  *			isolate the range
- * @gfp_flags:		GFP flags used for migrating pages that sit across the
- *			range boundaries.
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in
  * the range will never be allocated. Any free pages and pages freed in the
@@ -476,7 +474,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			     int migratetype, int flags, gfp_t gfp_flags)
+			     int migratetype, int flags)
 {
 	unsigned long pfn;
 	struct page *page;
-- 
2.47.1


