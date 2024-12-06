Return-Path: <linux-kernel+bounces-434779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15389E6B36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CA4283F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEF11FC7E5;
	Fri,  6 Dec 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYB0k+N9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07BF1FBC80
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479206; cv=none; b=HVJxb1OSiSh/nyXbAjn47chq7He2QPf9ggWH+TZcJBLuM6aPB3yj+7xR6J6SBvacdi3SWE8ZCjYduLx4M1WSfVqSI/Jh4ecrGxV7yNMqLbsyuPcKpv8mcJhBS0A3SQN3U2sj6W0mOLchKxaugC6ZSW2GqrWDdzJEgVdIY2G+B3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479206; c=relaxed/simple;
	bh=LFJiDpzlsP6nVVYvks1diP4hEAKXeXiGTcenZUPZU7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhJVoQ0S1YHNYPqitfmCiQyaTNcaA+IVLZqUJQsgesUeDI+1tvNLuMjKlvMkSqirEDisXj79IEekLFdjR42g9HBlM8myQdj16Tfv5L40v3jhzk+nRmvvGtqnIaC4SsCt9fS5+PO1Az3fXj05hT9r2v3jrwoXA75wT0JE7S2KO8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYB0k+N9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733479203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IA4ZMoyJsW9kk7MRivWjZHMd3/6CwxZEtrg2OJXZFBo=;
	b=ZYB0k+N9pNIYwykmS6dIK4elWSdOKMPIH1WPR2f7UxD47TaHvkR2MIxe0Wv3qofMcMubUy
	rUx+qkKGC/6i66911S9Ci/5FmG7lmwMdWiwgSPsk/NBBBF5U8cplFP9gRAKyH0Ci2TqKIJ
	EUaXYNNJ/Nga34/14rbKr23rDee63zo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-aq8KjNrnOiekd6mlg0hLRw-1; Fri, 06 Dec 2024 05:00:02 -0500
X-MC-Unique: aq8KjNrnOiekd6mlg0hLRw-1
X-Mimecast-MFC-AGG-ID: aq8KjNrnOiekd6mlg0hLRw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385df115288so860995f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 02:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733479201; x=1734084001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA4ZMoyJsW9kk7MRivWjZHMd3/6CwxZEtrg2OJXZFBo=;
        b=gbERPEUECdJwXUD765L/Cp64/kLk2KW9rqdXV8S4WPNRqrTSJQcjWjuEyXQJyWHu3v
         OJZ5PW1Op9yK7gkzGabC9e+g4rzR6czGP/Ncg6a96VuIa+zAakO4oG3CNE+1nb6/OqdQ
         QqDeeLBPWseDebx3sKYWdz8UalTCYEuqKJyTmlXZEqzjXNqpl8d1E5NmYTOrv0WbcWP6
         z0okIc8mztrKzG2okSp2hBZoMXZdYLnp2eaLR38xKc+7pFzC3BBv2sU76J30ch/lOcO6
         eo61Au33Lgvf1BEJftzuCC/V2hlqDdl0M9l/Lq5Mmh+gFFPLhSA9NzuqCRQXhVQptZU7
         ZYyQ==
X-Gm-Message-State: AOJu0YycHGdTjDA6L+sT8SAP17Mkc8C1P7oM+UheeB2ptFnL+4yvW0Ez
	jDZD2lamVIeekYxLhGiPuqkv//iMGSpO301vY7iMSDhGRBzuJ+C/5rq6huG/1rpya+b8KHw4Ctk
	w/Mk8E7qUyDN+uF3TqoZQsl+h1PEEoIEJVIIp5Q8OkaoKkXeUskZZK+zCJMbQChWsX+SNWg7dEa
	kFAli+kaspddJ/r8PMTW42yjAP7DsUNNqZBwrVU1DF2vyb
X-Gm-Gg: ASbGncsVZpwLkCYFH8zo3roWoaRn+j9SiStluto5i5xXpF/FU4qUrZDvfLdDlqmaPBI
	kzcnzq/ij1l7Mf1ffw3PSd3XfQFCXvhuDVtjPXiyRXvx6lRbmLMk3w9GP6zdt7d3AWxbrVMML+q
	1oFKFhUq9RDVnRoPz/Pvuw3w/G0QzNWf45TMFndNTgZpcwAvzOoT3k2nse3FLiH0zi9DMEQXt3b
	SaLmTh9oLM3ICNXP/14Siom/IWTIl4iV6fzPcIyylrV1NeNOlJRlZO6tJ2j7HRehiIz9XEMo2DZ
	chRrLWrX6MCwBAQfWn+E7C7e4bxuTDlrMQs=
X-Received: by 2002:a5d:64ef:0:b0:386:2ebe:7aeb with SMTP id ffacd0b85a97d-3862ebe7e3amr588712f8f.44.1733479201298;
        Fri, 06 Dec 2024 02:00:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS7q3Y3cr64iMaChXRU6kWOrDr/y/KtXu/TH4x76fjE0yJJ3g/J9U0CFiziA1wkJGitb1OUA==
X-Received: by 2002:a5d:64ef:0:b0:386:2ebe:7aeb with SMTP id ffacd0b85a97d-3862ebe7e3amr588688f8f.44.1733479200834;
        Fri, 06 Dec 2024 02:00:00 -0800 (PST)
Received: from localhost (p200300cbc71bd0001d1f238eaeafdbf7.dip0.t-ipconnect.de. [2003:cb:c71b:d000:1d1f:238e:aeaf:dbf7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3862e3fe716sm769370f8f.7.2024.12.06.01.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:59:59 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yu Zhao <yuzhao@google.com>
Subject: [PATCH v1 2/2] mm/page_isolation: fixup isolate_single_pageblock() comment regarding splitting free pages
Date: Fri,  6 Dec 2024 10:59:51 +0100
Message-ID: <20241206095951.98007-3-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206095951.98007-1-david@redhat.com>
References: <20241206095951.98007-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's fixup the comment, documenting how free_one_page_maybe_split()
comes into play.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c608e9d728655..63fddf283e681 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -298,11 +298,10 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * pagelbocks.
  * [      MAX_PAGE_ORDER         ]
  * [  pageblock0  |  pageblock1  ]
- * When either pageblock is isolated, if it is a free page, the page is not
- * split into separate migratetype lists, which is supposed to; if it is an
- * in-use page and freed later, __free_one_page() does not split the free page
- * either. The function handles this by splitting the free page or migrating
- * the in-use page then splitting the free page.
+ * When either pageblock is isolated, if it is an in-use page and freed later,
+ * __free_one_page_maybe_split() will split the free page if required. If the
+ * page is already free, this function handles this by splitting the free page
+ * through move_freepages_block_isolate()->__free_one_page_maybe_split().
  */
 static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 		bool isolate_before, bool skip_isolation, int migratetype)
-- 
2.47.1


