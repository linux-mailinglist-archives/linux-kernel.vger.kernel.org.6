Return-Path: <linux-kernel+bounces-539156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383E7A4A19A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2330C189B280
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9892280A3B;
	Fri, 28 Feb 2025 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDSlDzTH"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAA27FE7F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 18:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767401; cv=none; b=dgX9AU5JjmqjrGGQEQ/LBAQtNd0TVUgF6+1/pSazQ+PjGdii6SaFeq2lCF2tU66nuhTSrKR8cf8PjLHoerMLkeMUDtZkkO157qL1GNXAS5dzFmGpEOvqvQQwAdfsaZiZzWIHkBk5FOMkdul9jBdbJbJAmKBMk4l12vaVDZUmovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767401; c=relaxed/simple;
	bh=uXyYOXDU0aeoS4KbS7TXHQWHQaLj/wkyH4OQB/o5oDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHLQ2BFQGUDvettxR8M5zwH9cysR1xMstEzcm1ylMBWYFvF3OFY4trAsqMtdVb9BrmF6H5H/UaaExED/SBoUQLjWoHUNT/Bi/aJbCTGNDTYQRFa7IGE9ezhdyhH83CftpmTHi5q61PKBfPDfA5PEpMJnCQG1FBH1JGZoARGAURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDSlDzTH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fvdl.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2feb8d29740so2891793a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740767399; x=1741372199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OPcdQrMWcNv7Zau8OEpT7S16MfDg/G7TA8+N5ucsG+E=;
        b=rDSlDzTHiXd6EMUONnN34Uy0gllSgpx9iZFcAbgZ4ofKQyFpRtevOnUrIbNw9x+oGS
         0QCornZaRPRxBmRoM9ZiWWE51YZB0ktLgd9DfhUsQTPO+lxqUYxy+tu3Cxqp3ag3tMBo
         DckBWJGiwt4Sa70OjdVIP+la5m4zpvw3NhQ6quq+c7lsLcH+E62x458H5enxTPYi1LCq
         IHllIdRjD8PONggtA6e+eSxfkXYqzfSBzVf2q4fL9XXd6qt/OqVK7ewQFhP8tCzQ1NH3
         /MBgB0diENryszCQKhjvczoFOYRMKw0KceQk5P5U+ZRDER5Y/sWh3bpdUZloCZkB/mKv
         +DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767399; x=1741372199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPcdQrMWcNv7Zau8OEpT7S16MfDg/G7TA8+N5ucsG+E=;
        b=W4VtIZpBEnhKO1cWpvWPuL+IiVDf/Du2n6IuHsdxJ71gFgHLJPZ+nA+ASXT6KDlNyl
         HmtDw78jPxtmP20PlDou9YkwllM4ARaIKMgOfWYitR1QboWPcku+Meg+X4hGn5cfT7If
         jgvQWgXpkMnmwc3CpVW5XJOHK8/RyaObjYFDi3HchjAQ659YClaWFlVeHdxrHkd2Edim
         RtiJzgiipkN+KsbCFiVuvAWGyYGNzfD+ATWayqNwJW3z5+E40VKl55MelqUk0AxatOvt
         S9Ob1EW410BYYcfWARDZJZCzsp1LnzQ1hKT2ODQOeO6JHGCzCca5+Osmp+ffLDpoMc6K
         f/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1JcqDl9hNJlcGGeExTfArQKMd7poLr7RyXagBo+1mRVT/nLy3buMRAPJI1vtc1Tfax3uw1upm5D3BbFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1CRculjq5gmgY2kwLJ9sD/BdcfXL2kti9e63gl1hiMavqpvkE
	fNEnucWJK+I6yVDA4xyLm4Lr6zZeYh/Cu/138rSxHOV7VAOwU6/LKoMRtpk2Dkw7PkBOrw==
X-Google-Smtp-Source: AGHT+IEc3NQ9Go14+cTqU/Rv73CdPaJm8EFFQ8SG1wAZVrkhFUHYZ37HYVGqfmxLOr8BdLrKJjaxUlZ8
X-Received: from pjur6.prod.google.com ([2002:a17:90a:d406:b0:2fc:ccfe:368])
 (user=fvdl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc7:b0:2ef:31a9:95c6
 with SMTP id 98e67ed59e1d1-2febab5bf2fmr7679905a91.14.1740767399073; Fri, 28
 Feb 2025 10:29:59 -0800 (PST)
Date: Fri, 28 Feb 2025 18:29:07 +0000
In-Reply-To: <20250228182928.2645936-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228182928.2645936-1-fvdl@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228182928.2645936-7-fvdl@google.com>
Subject: [PATCH v5 06/27] mm/hugetlb: use online nodes for bootmem allocation
From: Frank van der Linden <fvdl@google.com>
To: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: yuzhao@google.com, usamaarif642@gmail.com, joao.m.martins@oracle.com, 
	roman.gushchin@linux.dev, ziy@nvidia.com, david@redhat.com, 
	Frank van der Linden <fvdl@google.com>
Content-Type: text/plain; charset="UTF-8"

Later commits will move hugetlb bootmem allocation to earlier
in init, when N_MEMORY has not yet been set on nodes. Use
online nodes instead. At most, this wastes just a few cycles
once during boot (and most likely none).

Signed-off-by: Frank van der Linden <fvdl@google.com>
---
 mm/hugetlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6d7ebc75b86..0592c076cd36 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3152,7 +3152,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
 		goto found;
 	}
 	/* allocate from next node when distributing huge pages */
-	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
+	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_ONLINE]) {
 		m = memblock_alloc_try_nid_raw(
 				huge_page_size(h), huge_page_size(h),
 				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
@@ -4546,8 +4546,8 @@ void __init hugetlb_add_hstate(unsigned int order)
 	for (i = 0; i < MAX_NUMNODES; ++i)
 		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
 	INIT_LIST_HEAD(&h->hugepage_activelist);
-	h->next_nid_to_alloc = first_memory_node;
-	h->next_nid_to_free = first_memory_node;
+	h->next_nid_to_alloc = first_online_node;
+	h->next_nid_to_free = first_online_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/SZ_1K);
 
-- 
2.48.1.711.g2feabab25a-goog


