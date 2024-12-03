Return-Path: <linux-kernel+bounces-429176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87F69E182B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3DB1613E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323BD1E04AF;
	Tue,  3 Dec 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTHYt/Dq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8E1E0094
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733219264; cv=none; b=GnlID11sGYvlLbkzye8FSK3Y4hSXZCuOMhMrYW+czGyWggrqXtDqD0RECARi8oIppCFHa8ktuDvWjZaMJXtAUtWdADNjQosjZ1zgOEP4zxe2Ae+45wDLiMRuR7ahcMZQpeIi1R4xeENcO73slLx/nXp9zNsiDYch1mY8El+J7bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733219264; c=relaxed/simple;
	bh=nQnAQ+Xn4GTYc85x7Cl0jvymY0VksQi6xVz/eUTDGGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENvgGtUj2fBrqasTxy0d9TvDxPGu1W02tyHcvemRXT1U3EUgAJNIUPCYLb4mqdm22Egu6eGKzCpoa/lxv4fMk77+Tx1dYC9e2zmOxG0+hPIiSaK/1LO00Z2aQ+aoFu2yEZO2KcP6CKN9qUXjo+bGRzL5b6egSw/teeRJGtWIOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTHYt/Dq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733219261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adHjUEuwXA+ANkdOzZ/yc4IEWn5pdw/yGiEpqds38YQ=;
	b=LTHYt/DqGMSibx1iFflQ1nrwx0Pjc5tMsyA6cg3T+iyNzU8L/kbsfVlmQ2HqppHPZxMlry
	9FUCttKLLFoC0k2MPNq3CkUl++NZaWd8Xlk09rWvt2UpfnXY+MwhzLxa/8HE3uSPRLh3gO
	QfzWj0FExzrCSwqmdIPbOVZHU/kV0Ek=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-HLD5yYkXMZCS_Zh_sd2t2Q-1; Tue, 03 Dec 2024 04:47:40 -0500
X-MC-Unique: HLD5yYkXMZCS_Zh_sd2t2Q-1
X-Mimecast-MFC-AGG-ID: HLD5yYkXMZCS_Zh_sd2t2Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434c214c05aso18467815e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 01:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733219259; x=1733824059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adHjUEuwXA+ANkdOzZ/yc4IEWn5pdw/yGiEpqds38YQ=;
        b=r7VL2NrvHcFldR+0LgnrbpSU4bihKXzgCHri7DFIkPVDsFjLjpWnIYpP09sc4n0/v/
         Ai1+0qL19DLIp9uuuL6GU1ts5rk5n6M8DQqcouey+s+xDVpToYq+VrjzXlpHaFbqn3IF
         x2CbI/Le5Qnkvm/i+ILohoMGcR0B1AtZv8/GjTetQ/BiC/qX0bB3b9iWY13nDqVi/5E4
         BqU8CbHqR5czYdJCEYJ67VhRCzAh/gruuJLekfFWwkZzjZ4KjCF3I8f6VN8MSl6cptII
         cOYzmpdyPUntbCEKf7ZfRSi9KTahzfB2zcg2QSfZXQKuPHgE4i5zLvE9HCBEIVqtF8sl
         h6eQ==
X-Gm-Message-State: AOJu0YxSwvcxXUqf+hHI8a7RtMY2yJZ6DZDxVdgxMeZOqdiGQkmIQUNq
	Rpq4vm+6YKEHaOYjwiUWmESBRWr9UAn9vB1ZfTYUTNAyMWUPaFfHCX/2mDsvVAwYmQn9lwE3Cks
	ZvQhUPOmPNUuOjlCILuaBMqoMla7+YRkNPsvpvjMe8aSjxGPSkJipTVBsnsBCToIEnVTA58nUV6
	3+xv9cV5FLB3DXYPRLgPKDUflRIicpGD/kG9vYtCT7Y7Pq
X-Gm-Gg: ASbGncvMwdCZ9WEQzS33lS3sLeKVjqhdDvcfJGp40otc/kxlziWN4l3GfmZwibXDHMF
	ObJQjcSSLEHDsx/uc08/jorSj3hAG/Yb15RXjwAJI8VMG/xW4dtZAfjMZG3StwsgfrWLSRIi5k3
	U6tX/Ne2O7FREJy5i+h44QOweVatPtK6pBg1Pf4s6cgAic+eQfReL3FoGgekjn6TvquHgJgujSV
	sQoukY9QRH9WzKHJrCo0UDaCHy0fsRMQk0VK9ewR+afXLcrevhYaW7yKc646Lqi4YoRF5G6m8cK
	Vlnz8MZBKSaex3eUyAgYy/WuP+7kynaCaqw=
X-Received: by 2002:a05:600c:19d2:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-434d0a03be0mr13411345e9.23.1733219259584;
        Tue, 03 Dec 2024 01:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwdCbQ2+x4fQDn4t4+UDQwQ2YQY46+IOELCndGNvUKUKqg7eAlnbIgz+QXoKcPKq7fDw8IyQ==
X-Received: by 2002:a05:600c:19d2:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-434d0a03be0mr13411005e9.23.1733219259183;
        Tue, 03 Dec 2024 01:47:39 -0800 (PST)
Received: from localhost (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434aa763aaesm213653525e9.14.2024.12.03.01.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:47:37 -0800 (PST)
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
Subject: [PATCH RESEND v2 1/6] mm/page_isolation: don't pass gfp flags to isolate_single_pageblock()
Date: Tue,  3 Dec 2024 10:47:27 +0100
Message-ID: <20241203094732.200195-2-david@redhat.com>
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

The flags are no longer used, we can stop passing them to
isolate_single_pageblock().

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 7e04047977cf..e680d40d96de 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -286,7 +286,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * within a free or in-use page.
  * @boundary_pfn:		pageblock-aligned pfn that a page might cross
  * @flags:			isolation flags
- * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  * @skip_isolation:	the flag to skip the pageblock isolation in second
  *			isolate_single_pageblock()
@@ -306,8 +305,7 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * the in-use page then splitting the free page.
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
-			gfp_t gfp_flags, bool isolate_before, bool skip_isolation,
-			int migratetype)
+		bool isolate_before, bool skip_isolation, int migratetype)
 {
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
@@ -489,7 +487,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	bool skip_isolation = false;
 
 	/* isolate [isolate_start, isolate_start + pageblock_nr_pages) pageblock */
-	ret = isolate_single_pageblock(isolate_start, flags, gfp_flags, false,
+	ret = isolate_single_pageblock(isolate_start, flags, false,
 			skip_isolation, migratetype);
 	if (ret)
 		return ret;
@@ -498,7 +496,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		skip_isolation = true;
 
 	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
+	ret = isolate_single_pageblock(isolate_end, flags, true,
 			skip_isolation, migratetype);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
-- 
2.47.1


