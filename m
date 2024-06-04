Return-Path: <linux-kernel+bounces-199949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECF08FA81A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FAC28406C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 02:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D913D88C;
	Tue,  4 Jun 2024 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taLOJr1h"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4713D2BA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466772; cv=none; b=YWo3mQZaT5aERDXdejpMnXbGfiZAUFrKPHBTsYDjQFKygQDU+cF/HE4zT2sAogZ2gvD+fdmOPSPG7WO1vHEvxcr+uQcnPXCqsJ0NHbAmSzgcehkk6dMmxEmqFVeLvNBEqQFxVxPKIK97I9kVEfoMvQbNh0XS9oDFyffi5/q4t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466772; c=relaxed/simple;
	bh=msjeUsgEzzOjOpUWHfas3LCKMX1t6e6yDLl0uelE9mg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dM3741wbQ/d20iLyB3fGeYj0NL3lncmOd/nOznuiB4tUGyWMAe2oXI//MvWCDy40UcKjg7ahsZeq5sNTTlxRnFWvc7hMsrjfIBM8/iS7A3bm3kGGytruW8KlbXP9eCl/yp+3IMDwv/nx1rzvkV918l8QTR3RklG7tNvHTcnBSdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=taLOJr1h; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa744fe2f9so870793276.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 19:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717466769; x=1718071569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TjWUm/jwk/hpgAY6bYVVdFyPbNpQM4PAlbOY34rPVUc=;
        b=taLOJr1helQgcs2JhlL6kdfSnGBKeG/3LVHEiZ9Vdl5nRWjTl5YAUPzrEnyV9eehYF
         Lxvqu8GQguXVjnt+E+h3sKyGTdazv6oYbh8jbATK48mqlft9bxuGvXpzkMlcyxx0SnvY
         uK3Fo+k11KYaD5fnNdh0XSdJXpm0XxUECkpBf5a9g/8WjBtjJH7prgII0v8mCsdMx+sB
         6HOcbPdetq7ONLQaH6i/lEDQVMtbHmv66iCpffsbl3f64k351lwEFGmYo0KLSjcYCVLu
         Y26QnOD9lh4PL5F7kOCHx3MAeDrCH9lAaXONfMbsCVOuGbF2hygVxJUi0b9fw26gH59t
         xUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717466769; x=1718071569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjWUm/jwk/hpgAY6bYVVdFyPbNpQM4PAlbOY34rPVUc=;
        b=R8qBfC2H1w7RyE2ybp0wQ965IknmrUwW5nM+DX6C/f7CypeRFablcSp0vVx4dccBMt
         xWZYKBLTe0THNjPcjuAdHMGyJxEysj7ktbqmbOA4VYGVZgDNxm6Z7upL6dqEkvg3WNao
         3jNpvvXrO3aIkzTRhnrZUtvSBF+nh/ndW3eNAaDGspr1zUxk/akak4vEjUS/kEKve75c
         O76Hw9PQ5qmt3HMTc2e+C5ZJUBL90R9rM+PR4jgAlHs/9VKMqFxlNKUfYj/EQAgHDZpj
         QWZ91W6TlhSHXxVv5pPjCrnV69M3ZcwBJi+dImFrbz34kpl8i+AAabgQLL40ONZADGUA
         zEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4mL4LurP3ECNNTYKCN1Qq8uPRaD/lszopaGUrAYiTeGRRjfAx0Y0VVFhHo49MamuQ1QMmBEleZ4sgmlcn/RfxPzTmnCOBqUM28hhk
X-Gm-Message-State: AOJu0YynT3ZS2sPvLfWTOIonQ142AAQRqzfvPZN0REhmL6OqRwMqLGx0
	Cb1Sw7bcSr0+DQ5t9njrL+UHCdVk8NtZWVoLNguDOub7547tEYXXN/8GtE/dkcYKwbxZueyXZvT
	GxZ/2xw==
X-Google-Smtp-Source: AGHT+IEDfb+3JEeKpiUuy5LGS6SnXp9v414pUptf89nU5rjiLVpz5pdRpN0kM4+F2bCDbN9n10wQa2F2tJMo
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:367f:7387:3dd2:73f1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:110d:b0:df1:d00c:130c with SMTP
 id 3f1490d57ef6-dfa73bf59bcmr1176974276.5.1717466768619; Mon, 03 Jun 2024
 19:06:08 -0700 (PDT)
Date: Mon,  3 Jun 2024 19:05:42 -0700
In-Reply-To: <20240604020549.1017540-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240604020549.1017540-1-yuanchu@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240604020549.1017540-2-yuanchu@google.com>
Subject: [PATCH v2 1/8] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the non-leaf pmd accessed bit and ignore the accessed bit on
the pte if it's on a different node, skipping a generation update as
well. If another scan occurrs on the same node as said skipped pte.
the non-leaf pmd accessed bit might remain cleared and the pte accessed
bits won't be checked. While this is sufficient for reclaim-driven
aging, where the goal is to select a reasonably cold page, the access
can be missed when aging proactively for workingset estimation of a of a
node/memcg.

In more detail, get_pfn_folio returns NULL if the folio's nid != node
under scanning, so the page table walk skips processing of said pte. Now
the pmd_young flag on this pmd is cleared, and if none of the pte's are
accessed before another scan occurrs on the folio's node, the pmd_young
check fails and the pte accessed bit is skipped.

Since force_scan disables various other optimizations, we check
force_scan to ignore the non-leaf pmd accessed bit.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d55e8d07ffc4..73f3718b33f7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3548,7 +3548,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
-- 
2.45.1.467.gbab1589fc0-goog


