Return-Path: <linux-kernel+bounces-280461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A594CAE8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF10B209E8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331CB16D33F;
	Fri,  9 Aug 2024 07:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUqudwC4"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A82905
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723187072; cv=none; b=goBP5Fo4r+2nutRGq2P706ni9iKnx5ByP1+YrOWrHAp7c3tlnvWQkHkaE0QAkNztQP2gLkIzdJ4N9i1UQ5kFku80F/5dos2sA7oWEpHHjCiheLWRskw0RIdys81Tgi+U9YEnqaxeXEJKOOg9SdAtYDJ5zSPFz2ZCvIPEEWSn8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723187072; c=relaxed/simple;
	bh=8R/x/FLVDwQrZ0rwxLynaPZ5hbdNuQ+yC2+LE22iwVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnz7QdYH1CG5qIebxFHWWUlOeJg1H7hiq+GuNb0Owk1xZJRkog/RS7F2kJAD1KhVdZMnOQv9k1I4ya8I6xEXyUPczZad3lKIpXsFoeOH+DY18L5qSj32nk0VHx9QQbbHMixgv5CjAiHz3PjSVceYG/UhWEljxWrddJOkMSqWZ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUqudwC4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso1344166b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723187070; x=1723791870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdToOVR8R9qNO1x23qVgI+jyK3cSKVgY8O7SCriXr6I=;
        b=fUqudwC4Lw+i/FusSQ7K2movxk+nHFBb/uUCTXMMEpPO0LuG8Hy0tqszngEuDJAFeG
         woL53KYvLxwEGAw4UOrg90QHS9qvTkCPwq1S5IsFT7pl2Np+TKVqMZ9n1/qsK9eTRCIy
         DUKc78W2J2jJGd2dfubonOveqTIKgdaugvf8w2uuoxtNCwXAx4p/CZDNikDPBXqpkaLt
         UCOeHECr7/rsg0w0O9eUp1V4P4939euHSlHO9azpOWse9u334JUzpQ1rlmx9RKI+TVRC
         KysZug/MbKxriVbSfN6quNeaQZXN5K7vuYMc990moyv/uU+pIlEvWtfQh19ZwxP+sova
         XOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723187070; x=1723791870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdToOVR8R9qNO1x23qVgI+jyK3cSKVgY8O7SCriXr6I=;
        b=sK9cs6RW3VqBv3nJ33s5tMG6ltMk7nlrp57sBeGw9r7YW3NS8Z2BlfKrADhRDzBEmb
         oa11b89ps1vQmkGQfflOJUyPs5sYW2k0ueL1Q1XdqqS7Df6bZLM9jbFLlBREygYWZI5s
         erU0KI1aI1aW6dTpFpqMLHPYdvNgApg1kzD90YuEac4MGRL2UJv4EyE13DkK10ZJWPxu
         8gBgphm8w5/+tIy9AEYhEA2BOgBuCXKhFtHrPhsojNj2tTPoxyPLOAXf/vN/xsatS9kk
         LAG54b2SkWx7kadembAwxHNzWmov5W/kxZPGCVQyidD1k2fhW1R5r/AJq3d3/5gPfnMe
         G7wA==
X-Forwarded-Encrypted: i=1; AJvYcCXw/YPZ++Hq1mvbfH85DMAKlCoNqWOqPBhp6v1xe1na/1OAqwdBg9bDqz3it/ssszcoIG7PXk8kH7U154VdW9653JrN2OcoJGVjifwe
X-Gm-Message-State: AOJu0Yy+JbPET05rfQBs6I4UxCiAkUj4Y4VBz0PCOqakMUhiWwOIeuc3
	pO/U2d+QQ1lFisDvv2xhkjGWR18qsumpIuh7Yv3W5XfcovynScPv
X-Google-Smtp-Source: AGHT+IEwKsXDwp1MzgW55+Gy4FSYeUfuHdbLgCuhROOzqo65n48JsgvZeIUX9OxU0djNpboUXXFabg==
X-Received: by 2002:a05:6a20:43a0:b0:1c4:7a11:9ef1 with SMTP id adf61e73a8af0-1c89fe9cf92mr900759637.15.1723187070285;
        Fri, 09 Aug 2024 00:04:30 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb20a025sm2066787b3a.34.2024.08.09.00.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 00:04:29 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	hanchuanhua@oppo.com,
	ioworker0@gmail.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	ziy@nvidia.com
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
Date: Fri,  9 Aug 2024 19:04:12 +1200
Message-Id: <20240809070412.33847-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
References: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >> I would appreciate if we leave the rmap out here.
> >>
> >> Can't we handle that when actually freeing the folio? folio_test_anon()
> >> is sticky until freed.
> >
> > To be clearer: we increment the counter when we set a folio anon, which
> > should indeed only happen in folio_add_new_anon_rmap(). We'll have to
> > ignore hugetlb here where we do it in hugetlb_add_new_anon_rmap().
> >
> > Then, when we free an anon folio we decrement the counter. (hugetlb
> > should clear the anon flag when an anon folio gets freed back to its
> > allocator -- likely that is already done).
> >
>
> Sorry that I am talking to myself: I'm wondering if we also have to
> adjust the counter when splitting a large folio to multiple
> smaller-but-still-large folios.

Hi David,

The conceptual code is shown below. Does this make more
sense to you? we have a line "mod_mthp_stat(new_order,
MTHP_STAT_NR_ANON, 1 << (order - new_order));"

@@ -3270,8 +3272,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 	/* reset xarray order to new order after split */
 	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
-	struct anon_vma *anon_vma = NULL;
+	bool is_anon = folio_test_anon(folio);
 	struct address_space *mapping = NULL;
+	struct anon_vma *anon_vma = NULL;
 	int order = folio_order(folio);
 	int extra_pins, ret;
 	pgoff_t end;
@@ -3283,7 +3286,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (new_order >= folio_order(folio))
 		return -EINVAL;
 
-	if (folio_test_anon(folio)) {
+	if (is_anon) {
 		/* order-1 is not supported for anonymous THP. */
 		if (new_order == 1) {
 			VM_WARN_ONCE(1, "Cannot split to order-1 folio");
@@ -3323,7 +3326,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 	if (folio_test_writeback(folio))
 		return -EBUSY;
 
-	if (folio_test_anon(folio)) {
+	if (is_anon) {
 		/*
 		 * The caller does not necessarily hold an mmap_lock that would
 		 * prevent the anon_vma disappearing so we first we take a
@@ -3437,6 +3440,10 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			}
 		}
 
+		if (is_anon) {
+			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+			mod_mthp_stat(new_order, MTHP_STAT_NR_ANON, 1 << (order - new_order));
+		}
 		__split_huge_page(page, list, end, new_order);
 		ret = 0;
 	} else {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 408ef3d25cf5..c869d0601614 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1039,6 +1039,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 	bool skip_kasan_poison = should_skip_kasan_poison(page);
 	bool init = want_init_on_free();
 	bool compound = PageCompound(page);
+	bool anon = PageAnon(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 
@@ -1130,6 +1131,9 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	debug_pagealloc_unmap_pages(page, 1 << order);
 
+	if (anon && compound)
+		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
+
 	return true;
 }
 
diff --git a/mm/rmap.c b/mm/rmap.c
index 8d432051e970..982862cbf5ba 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1467,6 +1467,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	}
 
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
+	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
 
 static __always_inline void __folio_add_file_rmap(struct folio *folio,

