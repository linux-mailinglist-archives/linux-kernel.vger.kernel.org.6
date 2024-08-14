Return-Path: <linux-kernel+bounces-285825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D795133E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 05:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED8EB21F39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 03:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC643F9D2;
	Wed, 14 Aug 2024 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BYC33fIp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4927B64C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 03:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723607698; cv=none; b=tpUD8XiRr6sf770XkMGw91XQsbYJIVRMbO2If8rNcN1ULUwZ+r2eCjRfnEjEmStvGtI2r6Q4r31pToCb5n3EL0DmJ93r1gl0dMamsdJ8yWmPcd4bkWjePaRO4RwKCRcgojQYmljk+zHwn3PXUsxEfTNrTGrhi9fs9AF70SFRiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723607698; c=relaxed/simple;
	bh=8IyvOQOfGpFKeAaP5n3L292Z4LLj0hI+GireXsoEBWc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uGLPdPCzuyBKC4k+cCzYLoElIflU0s8nxs5aAEOR35YRZvc7+p0/l4KRCemysf3sfX6uqPUpwMul6c3rpZFytJkNnh4Sslb+O245qbU3Y2kWuDnBn5q/zGXncDSkIl50hk5urjEzs+q/KH6Q9X6+ZxOyQTamc5CICPFjKGj00WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BYC33fIp; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-650ab31aabdso124303467b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723607695; x=1724212495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dojELHFyDppIdE3uONGGsnU1QQoUNwuzSISVMqCfDh4=;
        b=BYC33fIpAL8Q/E95H7sUkbuyGFFxE3oBFBbzAve4sU+Rq+mBz4HD+tAIXrt/P3LET0
         QZOSpHoBxn0oXpVP7Q/pc7Qxu3EMBxNTnzg81+tdnV2OH4GGqfEh3dOsrCba69JO6RUi
         AO7mDBpWMspbacrol0k8oWi5iu5XJmP2haf+gcHBMVLSQqXHgksqXUo+R8j8sFvHsceB
         jLRGhkx/GbvcTftOp3d2M881RdOxUN05VJlzLEyltV1urn5/oT+bKosWjeDe4Vj3STz3
         TbZnGrfP+Hcf+EOzP76Q75U5JFid/fI5hX4GsTQF4QN9McUxh2aZmmB6+89IDdoB+KvK
         ZNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723607695; x=1724212495;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dojELHFyDppIdE3uONGGsnU1QQoUNwuzSISVMqCfDh4=;
        b=elwyOMODl7d543Kp8sxKlERtGQkky5uyu/xPgmPR93D1K4AH7vd2ghFAZyJW6JOWeo
         vlT7JUd+Qi/NV2z2HIhpfghOR8S/Wzr/cl+pwG4aJcrNY0i9DvOJBKMFBB7DkulsCKAy
         6eMpcc+8A2/8pGT4r5PmIp+5bocRZlRNrqfyVD6espwe41kon2A2TtFiiWttb6gahIQp
         YYu6q6VHywddBPUomi2v1HpBxN1ilzIjWjRwIqwjioPXAg1AOPPDNt7q0TODJjYR1iNg
         S/N/bOFQu9KpMREFsVQ4MtfzJuqClC+UnlMyUEDZyeWfGxfJI6qCTJmBICdxx1piSUki
         0rFg==
X-Forwarded-Encrypted: i=1; AJvYcCWJJmIC3WdcEdmdFvi3Ne3rvxNDbkGfqf7NIaqQCbqbt5fC8fMOXaEc11b24f55EXqkThmBKzkapO14uRBih9eHvkaJuUbKk69r6/HG
X-Gm-Message-State: AOJu0Yx5Y+hIJFBZ8M1gC0dE5JoWBgdqRKqnZTM7fJgea9kBmcB4LnDx
	ouLgndySTL77DSn53BkC7ml7gNOci+GRYLqx8mTXMUsVJBC7Q4neurqs+VxQwmALibv5CyU3BfQ
	0FQ==
X-Google-Smtp-Source: AGHT+IE0SHTqsS6rDRUrhReJmeN4jaED2Ug+f6SvEIuYHmKPDmD+bYFFa/luE+VatDOpvCNmvgdK+TkgKII=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c8ad:fcc7:f7cf:f2fd])
 (user=yuzhao job=sendgmr) by 2002:a81:b507:0:b0:691:55ea:8572 with SMTP id
 00721157ae682-6ac9a75c2e4mr210237b3.8.1723607695580; Tue, 13 Aug 2024
 20:54:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 21:54:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240814035451.773331-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v2 0/3] mm/hugetlb: alloc/free gigantic folios
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Use __GFP_COMP for gigantic folios can greatly reduce not only the
amount of code but also the allocation and free time.

Approximate LOC to mm/hugetlb.c: +60, -240

Allocate and free 500 1GB hugeTLB memory without HVO by:
  time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

       Before  After
Alloc  ~13s    ~10s
Free   ~15s    <1s

The above magnitude generally holds for multiple x86 and arm64 CPU
models.

Perf profile before:
  Alloc
    - 99.99% alloc_pool_huge_folio
       - __alloc_fresh_hugetlb_folio
          - 83.23% alloc_contig_pages_noprof
             - 47.46% alloc_contig_range_noprof
                - 20.96% isolate_freepages_range
                     16.10% split_page
                - 14.10% start_isolate_page_range
                - 12.02% undo_isolate_page_range

  Free
    - update_and_free_pages_bulk
       - 87.71% free_contig_range
          - 76.02% free_unref_page
             - 41.30% free_unref_page_commit
                - 32.58% free_pcppages_bulk
                   - 24.75% __free_one_page
               13.96% _raw_spin_trylock
         12.27% __update_and_free_hugetlb_folio

Perf profile after:
  Alloc
    - 99.99% alloc_pool_huge_folio
         alloc_gigantic_folio
       - alloc_contig_pages_noprof
          - 59.15% alloc_contig_range_noprof
             - 20.72% start_isolate_page_range
               20.64% prep_new_page
             - 17.13% undo_isolate_page_range

  Free
    - update_and_free_pages_bulk
       - __folio_put
       - __free_pages_ok
            7.46% free_tail_page_prepare
          - 1.97% free_one_page
               1.86% __free_one_page

Yu Zhao (3):
  mm/contig_alloc: support __GFP_COMP
  mm/cma: add cma_{alloc,free}_folio()
  mm/hugetlb: use __GFP_COMP for gigantic folios

 include/linux/cma.h     |  16 +++
 include/linux/gfp.h     |  23 ++++
 include/linux/hugetlb.h |   9 +-
 mm/cma.c                |  55 ++++++--
 mm/compaction.c         |  41 +-----
 mm/hugetlb.c            | 293 ++++++++--------------------------------
 mm/page_alloc.c         | 111 ++++++++++-----
 7 files changed, 226 insertions(+), 322 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


