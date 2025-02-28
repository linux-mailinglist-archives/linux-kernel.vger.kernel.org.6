Return-Path: <linux-kernel+bounces-539167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD147A4A1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CCC174224
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EDE279E3B;
	Fri, 28 Feb 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luJUqK4+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EEC2862A1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767420; cv=none; b=apYT9COA8x6lICtzQp3DXJEZLC5V/hGlEUa9V8MrjMAdbMUOCRGgytVkWQhGb9csNQW4qSBkmPOokscu0ZwN1oilnAQYGk55fmgm1GgvDnRkfxxl9WYaDiruXm9EHLbqhC/IwIDU2xh2OKlKnKhT+PTrk1bucHZ0kgrHJ8m7WSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767420; c=relaxed/simple;
	bh=EBNjv3QmmUKLkngAKWBkrnqQd8Uhk7FKcWRbkKxs+VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LDIScAssccM0CeWq5o7D3EwTBGTNY5Udy0/4XFBReS9EB594mpTssyvrNrpmj7ZTLYy+eil5tuG6735/bncRiDSU1IGconDMwHirhwA75rTADWtrtWV562yyPe0TVvol0i/wp4OpoRRv8zWS/8n0yeQyQL+P1D+IUoLhwlGhay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luJUqK4+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38b60so1479116a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767415; x=1741372215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBBYpB4hgweH6Clpvn0bScN6WwMSi1BpuOUxZoDm4hs=;
        b=luJUqK4+va92/sItUya7Seq6qtFfOmBgoJyC8ze4BwsiETzT0kQ+yrmCmoWtSaFHVb
         OrHO+O8PF9QCx0rUHWMnSSS990Qc+F4xM9BTIrx/wRaeazr4D4i6kxdokcx6FmdygcBD
         HDxNsOpJl8NVxDdPcG8Q5ZWhfu873Tic94kzYnc3V6OeYzjgNWg+uBz1/M2EdroAtkmz
         24TBVrClPuAFefwHai7LiXnyT/n8T6wMaC6SUoyOTPMsdU9VVhobn8839uAFNveKaZu2
         ZxfheB9oDvA+xcmJqMlNFYN2FG9iODhQoSPzgRZL54chwzcot6Gn/wgJv9hFutVdkq+c
         Hx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767415; x=1741372215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBBYpB4hgweH6Clpvn0bScN6WwMSi1BpuOUxZoDm4hs=;
        b=cnM21CFSBcHTmvAt2lXg2Yoc6Hy5wLq7UlRsRoWts08jzvPum5+rqr/fi9xVlNo72R
         gS437YpYiIu/f8gZ6je1GJrLurlM/sBEpqflk8+ENFAJ+HlkDphqxQKKY3utWlsgIpMq
         aFJq+WO7cdnPjR2S6yp6KU/z/1tiKsjR+94uk2GLmTXOC7+OZNSONmFNJW6ThxlFlWna
         IHHYNeLMXAp9D+y9Z/K5xT5qxZbcfctWGQ1bma+sQD6QVYE04Ps4sQ2oSmQiWL5XIKNg
         v0dpVyMTPL5qylimFtmSxQebXn1kbf81j1kJb+Fu7aZLJQiN8yXd1Mzy4j5MddZGynQB
         o1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCX9P34K+Kri4rwottykd0frUV5TvW1smsrp4OyhSYpm5i8bHzMRr2uyZ8UD4AdE8CpkXjgNYfUHmtjoEXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrSjdYhNS8cMMUskY2uiko8NG3ALL+Vf1tOwMwbSMNrSwMBfY
	C4DQzQlT2o5boqpgGukoJpohwMtfGU1Wxzk+1B02m7rNVm4h568KnJolW7Cis1ncwvnVkw==
X-Google-Smtp-Source: AGHT+IGJ1/QMzLpmOmVFjGTQ/4fFo0bzWyrrthdyD9uiwQoixag+hgh7PWEv/GbYJAbMW/NyrIAhOQFu
X-Received: from pjbpt14.prod.google.com ([2002:a17:90b:3d0e:b0:2fc:201d:6026])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b08:b0:2fa:13d9:39c
 with SMTP id 98e67ed59e1d1-2febab3e741mr7883201a91.14.1740767415176; Fri, 28
 Feb 2025 10:30:15 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:17 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-17-fvdl@google.com>
Subject: [PATCH v5 16/27] mm/hugetlb: move huge_boot_pages list init to hugetlb_bootmem_alloc
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of initializing the per-node hugetlb bootmem pages list
from the alloc function, we can now do it in a somewhat cleaner
way, since there is an explicit hugetlb_bootmem_alloc function.
Initialize the lists there.

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ea5f22182c6e..0f14a7736875 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3574,7 +3574,6 @@ static unsigned long __init hugetlb_pages_alloc_boot(struct hstate *h)
 static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 {
 	unsigned long allocated;
-	static bool initialized __initdata;
 
 	/* skip gigantic hugepages allocation if hugetlb_cma enabled */
 	if (hstate_is_gigantic(h) && hugetlb_cma_size) {
@@ -3582,17 +3581,6 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 		return;
 	}
 
-	/* hugetlb_hstate_alloc_pages will be called many times, initialize huge_boot_pages once */
-	if (!initialized) {
-		int i = 0;
-
-		for (i = 0; i < MAX_NUMNODES; i++)
-			INIT_LIST_HEAD(&huge_boot_pages[i]);
-		h->next_nid_to_alloc = first_online_node;
-		h->next_nid_to_free = first_online_node;
-		initialized = true;
-	}
-
 	/* do node specific alloc */
 	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
 		return;
@@ -4916,13 +4904,20 @@ bool __init hugetlb_bootmem_allocated(void)
 void __init hugetlb_bootmem_alloc(void)
 {
 	struct hstate *h;
+	int i;
 
 	if (__hugetlb_bootmem_allocated)
 		return;
 
+	for (i = 0; i < MAX_NUMNODES; i++)
+		INIT_LIST_HEAD(&huge_boot_pages[i]);
+
 	hugetlb_parse_params();
 
 	for_each_hstate(h) {
+		h->next_nid_to_alloc = first_online_node;
+		h->next_nid_to_free = first_online_node;
+
 		if (hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
 	}
-- 
2.48.1.711.g2feabab25a-goog


