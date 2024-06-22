Return-Path: <linux-kernel+bounces-225521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2D29131BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F328690A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5291758E;
	Sat, 22 Jun 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC6Z4utj"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3940615E8B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719025395; cv=none; b=Qd29kV/iqV9dd7SAvOW5wtpoTeztdNqz/a5xbmnqOxOTSSuMBxbu6ofXK1NzHajae4DBorJJmU4rx1mtQhFzUscTUTXYQo42OIujceUmtvlS4Kr1NJ5Ra1E0S8Ha7vtTloLX7ozYp4eYnEqVNFdzAApNXZ+dVbXyxVEjRmwO+XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719025395; c=relaxed/simple;
	bh=EHYQtmjxsgdG8M8GNOiN5E9bImvjxps5ecgF0RFLFl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYvPQq4DxUzu4KkFuSSP5QHG2lY6Eg6mDNKspNxKt7OvTn1uJvSqWC180R51i1KzE2Ro32fCBQknwYJyvXuk/azO9PQr6a1NV0DUnJQFgqgw2YHokhv8GaeDLQvME5JpWMIr3Kq40ZBzDaXBZtjcoqc7JsfYVlSeBPyvq3Ma78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC6Z4utj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70667943931so179905b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719025393; x=1719630193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65NmH14GHPU7cpQuxZpTQNNeNlAoovyzm058ERg2Xuw=;
        b=TC6Z4utjklXhQIP42q0z8krwY8EicTGuzfTYe9mWz98WS9ZLdobFX86dI3NJ3ywcot
         jvJ6DL2/JDlpSxt9v6onsFdL0k/s5AHySvrh0i7RILodLoRqu6ycHWEXSuwiGP1PCfZX
         UjdzLWl7IzNVELWcFj0qrG1Bt9tausG9UH6jUwR7CfRU6vMBFGVXAz3PpnSPEM74NoA/
         QLxxL5JvgRR/6lLlEUHwGqF5IY37l1am72E3bfW0fP7/q6MLu6HBtyo53szR7LKZKwIj
         lr/a84TVagUXS7ubf1sg95VBZrqIF+562blDBBfRreIUTLrEFZH4eEP+hz8Q5GLCUyPe
         yelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719025393; x=1719630193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65NmH14GHPU7cpQuxZpTQNNeNlAoovyzm058ERg2Xuw=;
        b=iXE8HyFsgSyU6NEilK9ZerIQbsBhb37vB3Mbz1kRatIr3gOOS9QPp7yGOkFKv4TxIi
         lyOet3KZ6yaUHYuk0yf7CA+KMvh1XWv0qX50mMzqg8b95Aq32KHws2Lj7/gmYfNQFem5
         F2513gq49kqryPdgnI39WcS3fqW1nuJQXywa/QddYOkf+dfLq1iPVWP/M9zECL4AcjJD
         u8ydl1Nnw+DMeAAHw4NTI99BAb7Wi5tvGTN7nsyZzYGWCQeYp18+wPuCZwP2USc49rF7
         1YDCT+TbzM8hk9AE/PXlHufq4e9ibL+l8CEoVzHmZd5M+koFVjIVpjxfcOJqVbl6+l/q
         vKJw==
X-Forwarded-Encrypted: i=1; AJvYcCUPbOTHrygzmV5Kt7dsxfdkTxjR+AUhR1y3VFOGvjPSMbqGC0cbRZiU+6N0adj/qq4kr++r/Nx3WFH8qBsz9yzqThLHPhhdYsYB7JkT
X-Gm-Message-State: AOJu0YxrwLhnH0UXJlBytGJU5c4VBCYCQ+bufg0OPo4/6ld+8dkdCk12
	1Y4LyeGnpHX4WVPR0v/h5rkC6GJoo5bZV2f/Du6vT+nCgTWfgGIS
X-Google-Smtp-Source: AGHT+IHc/r6is/zY8phKNX+2LLsnBPGxaCP+UtI2f3FTXM0auYwzn5mRA7w5/PdKcGYLfzRjgrr4IA==
X-Received: by 2002:a05:6a00:1d1c:b0:706:31d9:9c9d with SMTP id d2e1a72fcca58-70631d99de7mr10747841b3a.7.1719025393317;
        Fri, 21 Jun 2024 20:03:13 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651254c67sm2196086b3a.97.2024.06.21.20.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 20:03:12 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuanshuai@oppo.com,
	yuzhao@google.com
Subject: Re: [PATCH v2 1/3] mm: extend rmap flags arguments for folio_add_new_anon_rmap
Date: Sat, 22 Jun 2024 15:02:56 +1200
Message-Id: <20240622030256.43775-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617231137.80726-2-21cnbao@gmail.com>
References: <20240617231137.80726-2-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>
> From: Barry Song <v-songbaohua@oppo.com>
>
> In the case of a swap-in, a new anonymous folio is not necessarily
> exclusive. This patch updates the rmap flags to allow a new anonymous
> folio to be treated as either exclusive or non-exclusive. To maintain
> the existing behavior, we always use EXCLUSIVE as the default setting.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Shuai Yuan <yuanshuai@oppo.com>
> ---

Hi Andrew,

Could you please help squash the following change (a documentation
enhancement suggested by David) into this patch?

From: Barry Song <v-songbaohua@oppo.com>
Date: Sat, 22 Jun 2024 14:51:38 +1200
Subject: [PATCH] mm: enhence doc for extend rmap flags arguments for
 folio_add_new_anon_rmap

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/rmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index df1a43295c85..9a8d9c848168 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1394,7 +1394,9 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
  *
  * Like folio_add_anon_rmap_*() but must only be called on *new* folios.
  * This means the inc-and-test can be bypassed.
- * The folio does not have to be locked.
+ * The folio doesn't necessarily need to be locked while it's exclusive
+ * unless two threads map it concurrently. However, the folio must be
+ * locked if it's shared.
  *
  * If the folio is pmd-mappable, it is accounted as a THP.
  */
@@ -1406,6 +1408,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	int nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
+	VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 	__folio_set_swapbacked(folio);
-- 
2.34.1

