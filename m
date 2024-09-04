Return-Path: <linux-kernel+bounces-315948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74996C8FE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8B31F266D5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E7913D297;
	Wed,  4 Sep 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/Tt8mvP"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109177E6
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725483264; cv=none; b=myyYWDlrI4ykYSCtez/4oXUfu9/6dzc29pOK1K//FG9dia+IjhZzPYac4xDNAqTLD7KD79ZEeMkxepnFhx4nRAwlAP8i1UFRQ1vwOaSEDvDcZoylfOcRxGRB8wfGtT1arzog0Hs+Whkf8+z9cG6Z8iBCiLgXKF1uFC/N3Xsgk4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725483264; c=relaxed/simple;
	bh=Ar6esdgnXpcn8oHruRMthSRZHY4RtL0LI+9aHQCKP8Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C5GMnW+MPaNeZv9FCKfxDgSLKP7UF8+PNbEOf3OXkZ7ITwAHR5LzzGi9Ua+6XvCJti52kvUfeKRwGh7hipnGgw7hbZSBpIYdOFegV5uwa8B9IH7Fupw2AstqywnbmDdUwW9CwI8GsV0F9YOk+hOMvv4C4Nl4+2Uefj5e64Gh07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/Tt8mvP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e03623b24ddso200743276.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725483262; x=1726088062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8wW8R+MHjMe6Movf5KpIkdjuSKAp7NEYib8XCqV/wxI=;
        b=L/Tt8mvPbHHmu3xmpNmAYlmCy3k3MqBjrPNMETv524/1KvFtl0bXv9dVLEEthN0my6
         g93xT7zpQuItrK+81phJ/O9SD5hs9ary0pvb9X6gmbmqkMeVjJZB1ZIbC5zWimFlKI3a
         OMvemMvvm1Ay+TZq+z6n7P1PHnbVxKzPGkzpuJocmDM4S4bKN52/uY0hmexrtCmUO9Jf
         ok7Bu/+QVd65PPr7MI1dJSF13vXDEzzvNIbKoLVNYdP7VWeJxIh46P+ssnLEm6pkgZRp
         8VEbg2nb4/aMzKb9T2DWdzLtsHVxCZ+qrKwDOP2n9EbUkjSbbvIcu9YZd0y0B8Qbg97w
         msYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725483262; x=1726088062;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wW8R+MHjMe6Movf5KpIkdjuSKAp7NEYib8XCqV/wxI=;
        b=WG4LCyC/Ot2yARLN3qy5O8RF7F3C/i7CdbRJp0TidTV26myIiElOMkq2kg+kFe1e/H
         FlCJHW7qFUuXdzBC5kqo1Pdi00iXejZI9ffL74ismJyO6Q4+se2TMhx8gyFoJhofC8fH
         I2+Nj4zClS7Q6f9BoMpC67zAUwmsVGWHQ+T1fawQxTNqoIkUQVutqyzZzS4wL9Nv0iPS
         ZvlgYSWd+17mrqwzPk5JeQEcfageWeYOHWjb0AbZJv4Y2Jzn60kw+GrGAtRb/D0xJVUl
         6qOdi4XPQ0RFXmOkHdPUPqhlKLj0fnSwMmBnlTYcRGzBB4lJC0DKj+M7m8zEymbbLgvu
         gWUA==
X-Forwarded-Encrypted: i=1; AJvYcCUZwiNnxhWYBy7ellNYfCoQrp3w+VQJVN2Z/7U6TDVdCaAE3qVBMqv3QHKgBDahpB3SWg83vtglz9UF0V0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4wVwIjC7Yd63Ympvep+0u6mE5/U+Lj+/S3sABOTXnLLlpABx
	uZ50R97FnYHzWvzDjCYOwmqq55rCC6thUAcs6uO43nXxYYWGnA+CS1LHmlzsQ4hFoZaQuFoNqVg
	ANb10fGl/5gLAFKk0Xw==
X-Google-Smtp-Source: AGHT+IFB3LFvRGR28dsEVnjNSxmCKIJPF4I9vUm7XHFxsYvTLrDOZ9dN4Ac49G8pX6q1R5j6LIG9hqwVRHFDcGcP
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:df8b:0:b0:e1d:7ce:4844 with SMTP id
 3f1490d57ef6-e1d07ce4908mr16614276.4.1725483262002; Wed, 04 Sep 2024 13:54:22
 -0700 (PDT)
Date: Wed,  4 Sep 2024 20:54:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240904205419.821776-1-yosryahmed@google.com>
Subject: [PATCH] mm: page_alloc: fix missed updates of PGFREE in free_unref_{page/folios}
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@techsingularity.net>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Brendan Jackman <jackmanb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

PGFREE is currently updated in two code paths:
- __free_pages_ok(): for pages freed to the buddy allocator.
- free_unref_page_commit(): for pages freed to the pcplists.

Before commit df1acc856923 ("mm/page_alloc: avoid conflating IRQs
disabled with zone->lock"), free_unref_page_commit() used to fallback to
freeing isolated pages directly to the buddy allocator through
free_one_page(). This was done _after_ updating PGFREE, so the counter
was correctly updated.

However, that commit moved the fallback logic to its callers (now called
free_unref_page() and free_unref_folios()), so PGFREE was no longer
updated in this fallback case.

Now that the code has developed, there are more cases in
free_unref_page() and free_unref_folios() where we fallback to calling
free_one_page() (e.g. !pcp_allowed_order(), pcp_spin_trylock() fails).
These cases also miss updating PGFREE.

To make sure PGFREE is updated in all cases where pages are freed to the
buddy allocator, move the update down the stack to free_one_page().

This was noticed through code inspection, although it should be
noticeable at runtime (at least with some workloads).

Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

I am not really sure if not updating PGFREE for isolated pages was an
intentional choice when it was made, but it seems like we are missing
updating PGFREE for more cases now, which looks wrong.

---
 mm/page_alloc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c242d61fc4fd8..57872af9c897c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1238,6 +1238,8 @@ static void free_one_page(struct zone *zone, struct page *page,
 	spin_lock_irqsave(&zone->lock, flags);
 	split_large_buddy(zone, page, pfn, order, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
+
+	__count_vm_events(PGFREE, 1 << order);
 }
 
 static void __free_pages_ok(struct page *page, unsigned int order,
@@ -1246,12 +1248,8 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	unsigned long pfn = page_to_pfn(page);
 	struct zone *zone = page_zone(page);
 
-	if (!free_pages_prepare(page, order))
-		return;
-
-	free_one_page(zone, page, pfn, order, fpi_flags);
-
-	__count_vm_events(PGFREE, 1 << order);
+	if (free_pages_prepare(page, order))
+		free_one_page(zone, page, pfn, order, fpi_flags);
 }
 
 void __meminit __free_pages_core(struct page *page, unsigned int order,
-- 
2.46.0.469.g59c65b2a67-goog


