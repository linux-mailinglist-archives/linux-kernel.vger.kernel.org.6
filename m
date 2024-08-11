Return-Path: <linux-kernel+bounces-282395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62594E34F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39B91F220ED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398CA158D98;
	Sun, 11 Aug 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p559lYce"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3D79F4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723411295; cv=none; b=hCIq7vkwZjTnpOEEOiHm5yqEFBHJX4btWHatDSzabVsEhJMeJ02vrpFX59ZXZHL9ymeSLJzKgUX8wnbu4bVNRt5DxYg2xm5Wnq6N3OUTsQ1gKVHEpNYaCl2AKjQQc6cikVr4M8BsKBsKKf6w/l2t0h+poMJ9INSCW/n+OZxeIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723411295; c=relaxed/simple;
	bh=zdJH9lPfRzalvjW3zjAuD7vEMsNp2Y7O1sie0Q/il8Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p+w3QuAh1PNL7QwkbgJZfTSODbi0ZU9IbRWRUIdaiHLdEG7L6rwOrg86T9hjWlPHEVR7Gim7TmQZofhQmlFozyg6ZQqzq/jSYfuHJcXKRysFzPWoxdydcIg/wN7EqSt6mIwRp9hemuJhzS4nZKbRJzsaOkI11vqak+EuLXMqQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p559lYce; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-672bea19dd3so85705757b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723411293; x=1724016093; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBxodn3ncL47aIchV0k38iOmKnnFrlE+aQTP6s51zh8=;
        b=p559lYcehw5QEWItECtwpAEWCzTpMKhzEexY/arfXA+fTN0rCrz/wkRDcKi30SYTie
         RcGnhypuoC3jgHPsQKv2x/oE+Z+ZOr/mI2rqqg2/pHr+u4N7X81u5ASLvQvaULoJ7OzV
         xBvnDAqHUeCQ0nCi38V+9X+V+3wAXJTpI7SuCXsBbjzpzvUSY8tvGD0v1icMkNW8WV/3
         V26CXzmjeFMfrSaSnZVWSr9HWk+iFr2wg9bYijtw5Ks+yGcciZv+YWcs+v5mOtCXIjJJ
         Ij1Bs2e3idhsdazINqpw19Idbk1bRendQGcWLU3pIyxHCFovsJz0RXgUHE/3Z0wDHsPk
         CSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723411293; x=1724016093;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBxodn3ncL47aIchV0k38iOmKnnFrlE+aQTP6s51zh8=;
        b=bXsGmpFw2Pg/oQo4m2DoXmsr91MhuyW4NX4YRvCUyI621J1/H5MHSN7+wd+iiaSeIh
         T0IEeSJfIkLFisF2OwPTfZ0OKq/xBMLSs+wE7fBJS7/bDz5Gemh86kmVrRDOAsaiBVal
         v4IDBu3Zlz8kIvABtVhWZpBpjSG4Kp4odD8qknocEkC8dRUxuVBzfTiBGi30cOLMSYFk
         HxkyZq4vXTnXTz72HnkHZS8Kqv5ipta3bPgLuTV8eYcb4BbSv8HDYtz+86RHKLLDrwEQ
         +5JiAiqP3IGTeFOdB6f8Y0z6Lt+0ij9Swst+JudMat68n0/ayU3S2zkwh73SqVxl6bbQ
         NL2A==
X-Forwarded-Encrypted: i=1; AJvYcCXfqQoi8pXzbOOVr1dF23/vzrYtwXHLOElCNFyjT3C4gFiasildyOz2emBgEMYOBej0BQtiDeXxZo3DHWh2p+/ztDaIFKHrvrcQIssA
X-Gm-Message-State: AOJu0YzBaRWFm4wqWCHO1tYjKQ0vlT4c88+VN0CJYNQUtSgRZBjElVGy
	8r5BGvrMhXypqZOs9iL1EioH+HFjAo0bgKE2ZuIg3+wJ7YUkEqGlRFsliPNLjXhRzCem6/4rsDE
	T2A==
X-Google-Smtp-Source: AGHT+IFDMuZv5daYo57AB4TlP3rAjpDKVJCYpQFPl2Vwy95c8vjlp62B/QB4tXK7JtoEaxQaoZ9BYYpvXVY=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:c9c:12b4:a1e3:7f10])
 (user=yuzhao job=sendgmr) by 2002:a25:aa8e:0:b0:e02:ba8f:2bd5 with SMTP id
 3f1490d57ef6-e0eb9a01882mr133827276.7.1723411292989; Sun, 11 Aug 2024
 14:21:32 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:21:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240811212129.3074314-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 0/3] mm/hugetlb: alloc/free gigantic folios
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"

Use __GFP_COMP for gigantic folios can greatly reduce not only the
complexity in the code but also the allocation and free time.

Approximate LOC to mm/hugetlb.c: -200, +50

Allocate and free 500 1GB hugeTLB memory without HVO by:
  time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages

       Before  After
Alloc  ~13s    ~10s
Free   ~15s    <1s

The above magnitude generally holds for multiple x86 and arm64 CPU
models.

Yu Zhao (3):
  mm/contig_alloc: support __GFP_COMP
  mm/cma: add cma_alloc_folio()
  mm/hugetlb: use __GFP_COMP for gigantic folios

 include/linux/cma.h     |   1 +
 include/linux/hugetlb.h |   9 +-
 mm/cma.c                |  47 +++++---
 mm/compaction.c         |  48 +-------
 mm/hugetlb.c            | 244 ++++++++--------------------------------
 mm/internal.h           |   9 ++
 mm/page_alloc.c         | 111 +++++++++++++-----
 7 files changed, 177 insertions(+), 292 deletions(-)


base-commit: b447504e1fed49fabbc03d6c2530126824f87c92
prerequisite-patch-id: 9fe502f7c87a9f951d0aee61f426bd85bc43ef74
-- 
2.46.0.76.ge559c4bf1a-goog


