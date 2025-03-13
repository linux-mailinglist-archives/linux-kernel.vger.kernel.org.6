Return-Path: <linux-kernel+bounces-560168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5AFA5FEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52407A6294
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE81F12E7;
	Thu, 13 Mar 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xZmFUlHD"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B141F180F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889517; cv=none; b=qvGK45pVXRz4Kilcb5Tm/FiHtDrMOm6h4PfiF83LxCV13+wwm2OO4IzacQh2kCfwx+7sgS0zVKR2XE3Y6En0mU8otY0rJLDVzRrVJ7CTe3IhjXc5MRJqkniRakYZFNyvoj18cDjfstQkyWxgBlcmbrQM260+WDMLEnoQ+uuqa7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889517; c=relaxed/simple;
	bh=S1m2mc+yGnN4a5PigzsimvcF9PVJTalTzczZMp/6AK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgUl44l+EoToLRQODlAVpvjkZviVbgkAvOi9aBmfun13ARByRvHaDIsUCQJtPiJi7tYD6xDFn0MGYDWHbdn+/1x/TVeBlWqRGH6lhcqqQ+fL3fUhOr5Qi9cwxu3fWB0FHwXVd0fhAp6NzeMbCASh2GwFCEnoArJ0za5MQvMTEQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xZmFUlHD; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ced8c2eb7so9317505e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741889514; x=1742494314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pdfFaB/k81zEw2QO02syAUWJ0A/YbE7SLXQbmysWgY=;
        b=xZmFUlHDDz7rC/so6v03PHagsW0e4S800gW8qdIH8JMEmWoQKYGtKSjLv51mSX3hKM
         CwZlD6sAT8oVYpNSpgN4S3UXwx+kNUB5cE8t033WiOZ8jqa4uoiLyCRSlnl8lnTUpa4/
         0QTVJw8Tx2K/ptckBDgEMUZX6yZwHSYhPK3fyUfwR77JMvGTeIPEysEoL3QoBudqjZKl
         qtGJ15eiXKhJ4kBkEq/XtVGoSCi7D+7D6Fj51TjTQi6tbRNvq1dkct4i3Td6Ora1HY7Q
         VL+4EGeTMagOzEDTwRJ3auI3Cz6NAWtVPhOOLxlz2v2izN8m9bjINM/A1WIis54Givj4
         ARmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741889514; x=1742494314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pdfFaB/k81zEw2QO02syAUWJ0A/YbE7SLXQbmysWgY=;
        b=hEplSOqpLJUdq+dvPZZdOY8R+Yg3Bpq0HcCNSgwjyYeBf1YaNvrrJ74froMwXNQpyE
         /x8pqi+S84fzIKn13CU23Daang1Ak8TNzXByLzd7UA3BtTfMZtvmwbd8oMsq4KIb8r0G
         RRIMt1z8hJX3rCyda/5UszKGWJqWu56Olg+vcdIT0uYPjuEt1ykzCDDEronHM2cCrQuy
         Un0u560VW9uoHnrJrFjOsRXFD42pXAETBcERS3OAzgnhgcgKKXsPYZrzmtxVUGy25xxD
         2BDC912w4HZ4lruyR9GJpr3zMdTlUB4GfdISYYWm/uWCyPwlhg/FTe9ijhk8LxIUYRWh
         knqg==
X-Gm-Message-State: AOJu0Yx/u/PhvwgOXB/yVRQR6eLJTrGqGqv1XTNymFo5demi+nuJCA7J
	HmWp2wAVyd846wSPMKdJ0J8aj3D3kFQ587YF12qWXAL9elKGi0B2gofoOojmhe/9EBQ4SuJmnrf
	qQf2hfExbRA==
X-Google-Smtp-Source: AGHT+IHRjd714WqfAw15oFXCnMwvJ6lJg1SUh1wqrNovE6dSYYDgAsuTLSBaeJXNp59r6szjiAIaZ5iRK8TFZQ==
X-Received: from wmbez8.prod.google.com ([2002:a05:600c:83c8:b0:43c:fc61:959c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e8f:b0:43c:fb95:c76f with SMTP id 5b1f17b1804b1-43d1d897497mr5845225e9.9.1741889514676;
 Thu, 13 Mar 2025 11:11:54 -0700 (PDT)
Date: Thu, 13 Mar 2025 18:11:26 +0000
In-Reply-To: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250313-asi-page-alloc-v1-7-04972e046cea@google.com>
Subject: [PATCH RFC HACKS 07/11] mm/slub: Set __GFP_SENSITIVE for reclaimable slabs
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Junaid Shahid <junaids@google.com>, Reiji Watanabe <reijiw@google.com>, 
	Patrick Bellasi <derkling@google.com>, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

It's not currently possible allocate reclaimable, nonsensitive pages.
For the moment, just add __GFP_SENSITIVE.

This will need to be fixed before this can be a [PATCH].

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/slub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3cd1fc76ac9398fa7718cedb42385..132e894e96df20f2e2d69d0b602b4719cdc072f5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5559,7 +5559,11 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 		s->allocflags |= GFP_DMA32;
 
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
-		s->allocflags |= __GFP_RECLAIMABLE;
+		/*
+		 * TODO: Cannot currently allocate reclaimable, nonsensitive
+		 * pages. For the moment, just add __GFP_SENSITIVE.
+		 */
+		s->allocflags |= __GFP_RECLAIMABLE | __GFP_SENSITIVE;
 
 	/*
 	 * Determine the number of objects per slab

-- 
2.49.0.rc1.451.g8f38331e32-goog


