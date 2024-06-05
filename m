Return-Path: <linux-kernel+bounces-203248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C28FD855
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9421F22E13
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692C15FA8F;
	Wed,  5 Jun 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A50sO0eC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB86E139D00
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717622520; cv=none; b=he8ANfWd51yaDkkriCeNHtfahppD/o4idf3w7Wb7KHc/2FNePTadRf7FkAi/EOpIrzYi46aVdhOoFqZ7El5kibumt7w+khvJ6e7uPn3PZZqmWfJpGu2kc++7JTXgZoGjfzJiraY+1dxEvXgy+zl5MwULT4Ta0ivc4IUS13rKXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717622520; c=relaxed/simple;
	bh=Qc3m+In7q6R+uy35WlCxQJ9rhymGQbbIYBejG40+EAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9BVW8yFkAZ0kPMjkV67edPuKfCjMikuIAIgHzNq3F4wQAezc//udDTz8OSOLhU5lL/sMZ3xKowrb2zoO394jLtSjXyh/+uxq5rE0z/v599SHvAWn3zBhQPG8FCYjK5y1Ku8cIZMuKr66ntQgsYKiwnmunlXUZfHAdlKonfLE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A50sO0eC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717622517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q6guOYJrLrFlpYszneZcHobnkFGNTsHvKaDHPs9XpUQ=;
	b=A50sO0eCZdcakUuXJxvn3T3e80DJ296BiKSzpk7STipAwTdnIkW8KzI4+qSfdVDE7zN4TN
	4c4I8orpO7D7NEgp/Y9BOy0wf8+zFAcTczeCTZOA7+7n54SBvBb1knXm3sR4f68ZY4oBD3
	kN9dLCGY+rjJBETQlsKLJpyJA+vF7bo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-xnxhcw4JOP-8bxeUNGvRhA-1; Wed, 05 Jun 2024 17:21:51 -0400
X-MC-Unique: xnxhcw4JOP-8bxeUNGvRhA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6ae4a58fa7cso503026d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 14:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717622510; x=1718227310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6guOYJrLrFlpYszneZcHobnkFGNTsHvKaDHPs9XpUQ=;
        b=SjlXM3UfuLa2sAT7rLs4NgZWtR4ueqSXcXHa9jJ8nIZaib/FQ4moga4aGQoqlOVOD6
         WUR8YGAPtBw4mwj32aSi3nZwguMVhMPAnLGIDwGgxelGOxAr9CneN8hNy1omCxJrfE8d
         gVP1Gpqr8xWy58V7GjFJasjs85/ZnLGZlU9Ji96VPFdYgEtF90s0ip03omJdkOThUpd1
         Fy0XlelNALpPE4gkE5E46TlC9fxEuuewQsSFHOAQvKtPp6bX9jZGJtpKAxQYJrKx0ZlB
         uS980s3YW4b55AANeF4n9PeZaeeBSU81RjAY+U0hcltRUo4/MHrAR+CCEGeyNPrtHur1
         GQ0w==
X-Gm-Message-State: AOJu0Yw+wIGjMwy2ByoXoYV/nsBBu/jojT3Gzumd+u7iCNJlBaoFeShL
	vLlSw8gjtyuBNI5evMFjEcNQIsJWzMbGHSJOv4EUUg51qVFGm7O2b7NVceiNNACJFNCqlaUE0Gl
	DE1Bgy81BGjnLJPHku09RABLSf5URetJDFysxYwP7juXL162mWkO66mnSqGAGxmNmTR7z2wKUzm
	hY1WjLMPEu/L9+j2Nwt/tod8yICgirJL578dhbQ/oeSvI=
X-Received: by 2002:a05:620a:2886:b0:794:edc7:1566 with SMTP id af79cd13be357-795240df187mr386800485a.4.1717622510094;
        Wed, 05 Jun 2024 14:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/geT55RHJOuBFW7WU7jX5S3mLJfm9lo9rhjmiuT/dUaQZocvdbrgkL6NqCoC3YnHeG8ne9Q==
X-Received: by 2002:a05:620a:2886:b0:794:edc7:1566 with SMTP id af79cd13be357-795240df187mr386796285a.4.1717622509326;
        Wed, 05 Jun 2024 14:21:49 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3290417sm471861785a.135.2024.06.05.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:21:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Dan Williams <dan.j.williams@intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
Date: Wed,  5 Jun 2024 17:21:46 -0400
Message-ID: <20240605212146.994486-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
pages: they map PFNs directly, and they don't allocate page_ext at all even
if there's struct page around.  One may reference devm_memremap_pages().

When both ZONE_DEVICE and page-table-check enabled, then try to map some
dax memories, one can trigger kernel bug constantly now when the kernel was
trying to inject some pfn maps on the dax device:

 kernel BUG at mm/page_table_check.c:55!

While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for page
fault resolutions, skip all the checks if page_ext doesn't even exist in
pgtable checker, which applies to ZONE_DEVICE but maybe more.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/page_table_check.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 4169576bed72..509c6ef8de40 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -73,6 +73,9 @@ static void page_table_check_clear(unsigned long pfn, unsigned long pgcnt)
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
 
+	if (!page_ext)
+		return;
+
 	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
@@ -110,6 +113,9 @@ static void page_table_check_set(unsigned long pfn, unsigned long pgcnt,
 	page = pfn_to_page(pfn);
 	page_ext = page_ext_get(page);
 
+	if (!page_ext)
+		return;
+
 	BUG_ON(PageSlab(page));
 	anon = PageAnon(page);
 
@@ -140,7 +146,10 @@ void __page_table_check_zero(struct page *page, unsigned int order)
 	BUG_ON(PageSlab(page));
 
 	page_ext = page_ext_get(page);
-	BUG_ON(!page_ext);
+
+	if (!page_ext)
+		return;
+
 	for (i = 0; i < (1ul << order); i++) {
 		struct page_table_check *ptc = get_page_table_check(page_ext);
 
-- 
2.45.0


