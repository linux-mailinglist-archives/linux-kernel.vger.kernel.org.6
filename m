Return-Path: <linux-kernel+bounces-282566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7339594E5DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17551F22128
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC814A4DF;
	Mon, 12 Aug 2024 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfhz0p4p"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D829A0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723438163; cv=none; b=OVkZlaAyt8/UJGkC/woKSCEy6kAcQ9aynipbMfo9hDz1bkOLy8dwo/JIVZMG7x/zsWxMPAYtVTTOCZfOd3Z5szyHdWetqZRMk570eqWbaZhzaIwwiOgSBZT1G553HKz6LbV8urrCpQeyq/YpluMVTuNEwqer9K/bzM7m6SEvBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723438163; c=relaxed/simple;
	bh=5VgnuB9y23ZxWERJCpyu6hh9PB22AGxPFSbb/AHyQII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWgeZpKLw5e9Y77E94nMRUARnHMz8UOqm1+S4BLKzbQXs8ggBRQgtQh/XBd+FOYoI8CR6Kz/JeL6iu1yM3OyIhT3ejso+onl69EuCP02iL4d6r5OEihSvmwuNKKvmbiLQRDiaY+1T5rL5efwgqTIZv+OzoCh56FCQ3CXICpREpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfhz0p4p; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so4666596a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723438160; x=1724042960; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qpq3LPqm61lcZ3ArBnzJ/3LDps9wXJ9LbD1MIjBOKqk=;
        b=Mfhz0p4pPDoGrsahImAVgfhRr9FypsFvotI5ZYeP/WK24QM0GSmBlUwNnZZqRdNRdj
         gQ+mH6ycw2MQ2hrY/U2BElSnxb+Uez79BEhDiWSrbt6ZVKR2jpbfKR8oh05uv2Z5Yk1M
         uWjPJ1aPk9bxrKOvQYPehI1Ld3v0meN7U7AsfpzqABnWh4/NxPIU6uIiNZUycgQNa/ek
         6UhWfSBsCNdL6KIAeyB/p7s7JCzlm0uhendWDQvHRSZ/uPxARz+fWcuONZdkb5ounIr/
         NOMcDCe03ejcESrE6qqSt20oLpTOcgRLEeaWLT83eyP6zkBX/4R8YxjhiO2y9u6M7xmp
         7lMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723438160; x=1724042960;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpq3LPqm61lcZ3ArBnzJ/3LDps9wXJ9LbD1MIjBOKqk=;
        b=IfHTrgky9JqKCcbTPSzE9b41/+PftEk32IqYRUoed8EpLXNloFhN8lV3SuSYgBgWQE
         q5wNo3KxXplLVmHQtM57Inoc0bALvOCCydlWEp+druvc0F2LTDQ0U32XEMluxKiA+BGQ
         KAomu8IDsywrvZOtX/fkGlZ/+iAziZRJQgjZSsr1tPIpmTPbf1vwLPM36IAhEwxF1Bzi
         iIiZKD9+oFFNSby6fj1+8Wf7B5wgnEkWV1Map5bxzDWllt6wuiBMR7/9Lif4LjfQy5sv
         mA7sSrjqR5It8Y9qaicY1Wgnu4nbfPbxoQQxqjWSXaIE5fMYW9WXROCGDVZpKXaCbbrF
         R+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUWTwpwyQ+3pvJNl6yyn92RNK3BNqJpAJwBKdaKdBYGjIhX3gcFCVcSf62NUn/8+cZueCZ1fcJPYkSXrvVRH5jwrVTindpYgcXdl+yJ
X-Gm-Message-State: AOJu0YylahIntlA1JQvRKZDda/xXGi8VRVwM4Nx3BCgNsUYZ3IQJpiS6
	vKqNA07gw6osf35vi6bv+DN3b+QVtYBVja0cvjJGjjRXOmcAH2xr
X-Google-Smtp-Source: AGHT+IE7qNtRHiWSXri3JkwIDsfJkJy1SPSZAsiJ/9zS+oo1xDwuodEP3kHjNAIedcu/4q/sCynWTQ==
X-Received: by 2002:a17:907:1c0e:b0:a7a:9447:3e8b with SMTP id a640c23a62f3a-a80aa59eb36mr585387966b.25.1723438159639;
        Sun, 11 Aug 2024 21:49:19 -0700 (PDT)
Received: from f (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb11a533sm196522766b.96.2024.08.11.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 21:49:19 -0700 (PDT)
Date: Mon, 12 Aug 2024 06:49:00 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yin Fengwei <fengwei.yin@intel.com>
Cc: David Hildenbrand <david@redhat.com>, 
	kernel test robot <oliver.sang@intel.com>, Peter Xu <peterx@redhat.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Matthew Wilcox <willy@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	WANG Xuerui <kernel@xen0n.name>, linux-mm@kvack.org, ying.huang@intel.com, feng.tang@intel.com
Subject: Re: [linus:master] [mm] c0bff412e6: stress-ng.clone.ops_per_sec
 -2.9% regression
Message-ID: <wbbieqyyjqy7ulbta6muzepxwxi6galwvhjdxpqaqbeljzpcer@dpeoqrbkl5p2>
References: <202407301049.5051dc19-oliver.sang@intel.com>
 <193e302c-4401-4756-a552-9f1e07ecedcf@redhat.com>
 <439265d8-e71e-41db-8a46-55366fdd334e@intel.com>
 <90477952-fde2-41d7-8ff4-2102c45e341d@redhat.com>
 <6uxnuf2gysgabyai2r77xrqegb7t7cc2dlzjz6upwsgwrnfk3x@cjj6on3wqm4x>
 <5a67c103-1d9d-440d-8bed-bbfa7d3ecf71@redhat.com>
 <CAGudoHH4NGgPdTe2yL33TNNFriPM9mVM=0_iuh5dLuesZXQMAQ@mail.gmail.com>
 <5c0979a2-9a56-4284-82d2-42da62bda4a5@redhat.com>
 <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e0d029-0a64-4b27-bd62-cf9a3577d7ff@intel.com>

On Mon, Aug 12, 2024 at 12:43:08PM +0800, Yin Fengwei wrote:
> Hi David,
> 
> On 8/1/24 09:44, David Hildenbrand wrote:
> > On 01.08.24 15:37, Mateusz Guzik wrote:
> > > On Thu, Aug 1, 2024 at 3:34 PM David Hildenbrand <david@redhat.com>
> > > wrote:
> > > > 
> > > > On 01.08.24 15:30, Mateusz Guzik wrote:
> > > > > On Thu, Aug 01, 2024 at 08:49:27AM +0200, David Hildenbrand wrote:
> > > > > > Yes indeed. fork() can be extremely sensitive to each
> > > > > > added instruction.
> > > > > > 
> > > > > > I even pointed out to Peter why I didn't add the
> > > > > > PageHuge check in there
> > > > > > originally [1].
> > > > > > 
> > > > > > "Well, and I didn't want to have runtime-hugetlb checks in
> > > > > > PageAnonExclusive code called on certainly-not-hugetlb code paths."
> > > > > > 
> > > > > > 
> > > > > > We now have to do a page_folio(page) and then test for hugetlb.
> > > > > > 
> > > > > >       return folio_test_hugetlb(page_folio(page));
> > > > > > 
> > > > > > Nowadays, folio_test_hugetlb() will be faster than at
> > > > > > c0bff412e6 times, so
> > > > > > maybe at least part of the overhead is gone.
> > > > > > 
> > > > > 
> > > > > I'll note page_folio expands to a call to _compound_head.
> > > > > 
> > > > > While _compound_head is declared as an inline, it ends up being big
> > > > > enough that the compiler decides to emit a real function instead and
> > > > > real func calls are not particularly cheap.
> > > > > 
> > > > > I had a brief look with a profiler myself and for single-threaded usage
> > > > > the func is quite high up there, while it manages to get out with the
> > > > > first branch -- that is to say there is definitely performance lost for
> > > > > having a func call instead of an inlined branch.
> > > > > 
> > > > > The routine is deinlined because of a call to page_fixed_fake_head,
> > > > > which itself is annotated with always_inline.
> > > > > 
> > > > > This is of course patchable with minor shoveling.
> > > > > 
> > > > > I did not go for it because stress-ng results were too unstable for me
> > > > > to confidently state win/loss.
> > > > > 
> > > > > But should you want to whack the regression, this is what I would look
> > > > > into.
> > > > > 
> > > > 
> > > > This might improve it, at least for small folios I guess:
> Do you want us to test this change? Or you have further optimization
> ongoing? Thanks.

I verified the thing below boots, I have no idea about performance. If
it helps it can be massaged later from style perspective.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5769fe6e4950..2d5d61ab385b 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -194,34 +194,13 @@ enum pageflags {
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
-/*
- * Return the real head page struct iff the @page is a fake head page, otherwise
- * return the @page itself. See Documentation/mm/vmemmap_dedup.rst.
- */
+const struct page *_page_fixed_fake_head(const struct page *page);
+
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
 	if (!static_branch_unlikely(&hugetlb_optimize_vmemmap_key))
 		return page;
-
-	/*
-	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
-	 * struct page. The alignment check aims to avoid access the fields (
-	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
-	 * cold cacheline in some cases.
-	 */
-	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
-	    test_bit(PG_head, &page->flags)) {
-		/*
-		 * We can safely access the field of the @page[1] with PG_head
-		 * because the @page is a compound page composed with at least
-		 * two contiguous pages.
-		 */
-		unsigned long head = READ_ONCE(page[1].compound_head);
-
-		if (likely(head & 1))
-			return (const struct page *)(head - 1);
-	}
-	return page;
+	return _page_fixed_fake_head(page);
 }
 #else
 static inline const struct page *page_fixed_fake_head(const struct page *page)
@@ -235,7 +214,7 @@ static __always_inline int page_is_fake_head(const struct page *page)
 	return page_fixed_fake_head(page) != page;
 }
 
-static inline unsigned long _compound_head(const struct page *page)
+static __always_inline unsigned long _compound_head(const struct page *page)
 {
 	unsigned long head = READ_ONCE(page->compound_head);
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 829112b0a914..3fbc00db607a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -19,6 +19,33 @@
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
 
+/*
+ * Return the real head page struct iff the @page is a fake head page, otherwise
+ * return the @page itself. See Documentation/mm/vmemmap_dedup.rst.
+ */
+const struct page *_page_fixed_fake_head(const struct page *page)
+{
+	/*
+	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
+	 * struct page. The alignment check aims to avoid access the fields (
+	 * e.g. compound_head) of the @page[1]. It can avoid touch a (possibly)
+	 * cold cacheline in some cases.
+	 */
+	if (IS_ALIGNED((unsigned long)page, PAGE_SIZE) &&
+	    test_bit(PG_head, &page->flags)) {
+		/*
+		 * We can safely access the field of the @page[1] with PG_head
+		 * because the @page is a compound page composed with at least
+		 * two contiguous pages.
+		 */
+		unsigned long head = READ_ONCE(page[1].compound_head);
+
+		if (likely(head & 1))
+			return (const struct page *)(head - 1);
+	}
+	return page;
+}
+
 /**
  * struct vmemmap_remap_walk - walk vmemmap page table
  *

