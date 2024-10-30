Return-Path: <linux-kernel+bounces-388358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 573CA9B5E63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD050B222AD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF231E1C3B;
	Wed, 30 Oct 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFKAhdAv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FB91DFE16
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278906; cv=none; b=Asq5iVLKCELO3VcpXViS5ncjvEXwN8XBe+6WQY44tZyeVCfAZji3ES70f1s4lPFb4AYHLYivHtH4O0rI/N5qn6uOmSQMW6lxP/ERHifcHyI+IdhLZVvsmH3jeU2cBlBI7K+GW8rqlkT097u2c5BvlPUC1r2DyBjt8ke4jfOIaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278906; c=relaxed/simple;
	bh=6h10EfQhMf1llyk2Ua0SxyrKsSGdD2R0249St1QRHH8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rL/Ny/hyuTNBFvTAb30I7Sqolw4vuc2V4ZwLgR7J/cDqcAC+7+o3cC5Ywmu9W97xIuAb210ozjpBVNdHY1UWDZ1XZ0lhhLPUyF0+MnapHctTUdKNpCbkSkIztSQUI30DyLSqZTnwrzca7/dWa+DepFy10PEYeUeBsmT79cD7JCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFKAhdAv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730278902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=B3oNQtWjmVfOSuRS0yOG4HoLYU5KFckRnJCojoYJWc4=;
	b=PFKAhdAvaiJNF2jLE52UoVpg227c4WJP/rZJWI93YChmLiPZF8kOqtN1UwhINa0IqWmmbT
	IJAMml2bu59LgDFUxM541aLkgzWAUHo/LYd50RJbP46DlRrRujio2M8xGDEHsn6rMBCy0T
	57kHpbGwHUrEsF5r8Y1PJBYF9lKPFSo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-GzVlSsYmO_mW62TKHiQipA-1; Wed, 30 Oct 2024 05:01:41 -0400
X-MC-Unique: GzVlSsYmO_mW62TKHiQipA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2fb50ced198so43452491fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730278899; x=1730883699;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B3oNQtWjmVfOSuRS0yOG4HoLYU5KFckRnJCojoYJWc4=;
        b=tp/YmT0bK5YST5b3BjK6iox3zlpiSU1AAxaWk75vcHgPpWYtNyEc0Zg6I5lLKHniFK
         T8BqzLQdEyecLoY6SB0nhKolNNRc+XAIZqiNt+eBDugWCdafUc9YtZRki+Bx8SrOSIdH
         J8Li5qNrVBC5HWf+6a+kKwClddeF5EW0tC+/CeN4nUCrcQe7COGEALWX0wib3DV5e1Nx
         lRBPiBsxFJ5f+pC0B4Q8DGtZ/3JvKzcdsC78ThWRS78HfZT9Ko8ELVHnBF9f5iv/y0Ey
         wYJtQzTVwrEO4th4WUZ5EOIxbmOhGoYPuDrXEG3zjR5f8PtmjOHRHLdozYqmzszYR7X8
         f3+A==
X-Forwarded-Encrypted: i=1; AJvYcCVPuvG4Y2WvZY10gsMoDpPuFnaF5E4fIUFgn/D7+hldDU7r1XNmGFVK7/4CwiOgoYene62NrE2NCO7OyqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7fRTGZSEN67Qs9o9+LUGHCvFq3TxaC3ET1FJpgS7PGOKBVzb
	rj51o4BJx3ir3IvfhUvEa12ra4s0KsRzLKkFXfnAECyzBQUlWYK6pxFHnUF5td27GW/BjMFMDlb
	CL7R1GldnQb8ZYs7A7kgO6Kic6ET+1OFbuLomgxtYHJ9tdZ5/BmuH2fO++ile+A==
X-Received: by 2002:a2e:802:0:b0:2fb:2bda:3872 with SMTP id 38308e7fff4ca-2fcbe0ae3a7mr47413591fa.45.1730278899341;
        Wed, 30 Oct 2024 02:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5FfAWQp1vFPxdP0DYAfLw5Vq+9hd5RVWm4YqzrM/jLlYop8ysedEQnZimny5RNx3Qk/fizA==
X-Received: by 2002:a2e:802:0:b0:2fb:2bda:3872 with SMTP id 38308e7fff4ca-2fcbe0ae3a7mr47413361fa.45.1730278898842;
        Wed, 30 Oct 2024 02:01:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9403bfsm14911565e9.21.2024.10.30.02.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 02:01:38 -0700 (PDT)
Message-ID: <8d9dc103-47c5-4719-971a-31efb091432a@redhat.com>
Date: Wed, 30 Oct 2024 10:01:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: restore the ability to pin more than 2GB at a
 time
From: David Hildenbrand <david@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 linux-stable@vger.kernel.org, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dongwon Kim <dongwon.kim@intel.com>,
 Hugh Dickins <hughd@google.com>, Junxiao Chang <junxiao.chang@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Oscar Salvador <osalvador@suse.de>
References: <20241030030116.670307-1-jhubbard@nvidia.com>
 <ZyG0VKUpFttPF30f@infradead.org>
 <249d2614-0bcc-4ca8-b24e-7c0578a81dce@nvidia.com>
 <ZyG3GAvTHpRL9tnU@infradead.org>
 <ea81f12a-95a3-4b9d-90e7-53a5d9c910be@nvidia.com>
 <ZyG5IumNPMUDBQOq@infradead.org>
 <fa766610-4a0c-4d75-90fd-6c781fadee73@nvidia.com>
 <87r07yp0ng.fsf@nvdebian.thelocal>
 <128d04dd-2d48-4a98-8537-49589b4db1c3@nvidia.com>
 <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bfee966f-807d-4668-b353-159a6e8066f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 09:34, David Hildenbrand wrote:
> On 30.10.24 07:50, John Hubbard wrote:
>> On 10/29/24 11:18 PM, Alistair Popple wrote:
>>> John Hubbard <jhubbard@nvidia.com> writes:
>>>> On 10/29/24 9:42 PM, Christoph Hellwig wrote:
>>>>> On Tue, Oct 29, 2024 at 09:39:15PM -0700, John Hubbard wrote:
>> ...
>>>>> Because pinning down these amounts of memoryt is completely insane.
>>>>> I don't mind the switch to kvmalloc, but we need to put in an upper
>>>>> bound of what can be pinned.
>>>>
>>>> I'm wondering though, how it is that we decide how much of the user's
>>>> system we prevent them from using? :)  People with hardware accelerators
>>>> do not always have page fault capability, and yet these troublesome
>>>> users insist on stacking their system full of DRAM and then pointing
>>>> the accelerator to it.
>>>>
>>>> How would we choose a value? Memory sizes keep going up...
>>>
>>> The obvious answer is you let users decide. I did have a patch series to
>>> do that via a cgroup[1]. However I dropped that series mostly because I
>>> couldn't find any users of such a limit to provide feedback on how they
>>> would use it or how they wanted it to work.
>>>
>>
>> Trawling through the discussion there, I see that Jason Gunthorpe mentioned:
>>
>> "Things like VFIO & KVM use cases effectively pin 90% of all system memory"
> 
> The unusual thing is not the amount of system memory we are pinning but
> *how many* pages we try pinning in the single call.
> 
> If you stare at vfio_pin_pages_remote, we seem to be batching it.
> 
> long req_pages = min_t(long, npage, batch->capacity);
> 
> Which is
> 
> #define VFIO_BATCH_MAX_CAPACITY (PAGE_SIZE / sizeof(struct page *))
> 
> 
> So you can fix this in your driver ;)
> 
> 
> We should maybe try a similar limit internally: if you call
> pin_user_pages_remote() with a large number, we'll cap it at some magic
> value (similar to above). The caller will simply realize that not all
> pages were pinned and will retry.
> 
> See get_user_pages_remote(): "Returns either number of pages pinned
> (which may be less than the number requested), or an error. Details
> about the return value:"
> 
> 
> Alternatively, I recall there was a way to avoid the temporary
> allocation ... let me hack up a prototype real quick.

Completely untested (also note the interesting TODO):


 From a23984b4f1a39ec984489fbe16708aedf4f9db95 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 30 Oct 2024 10:00:50 +0100
Subject: [PATCH] tmp

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  mm/gup.c | 120 ++++++++++++++++++++++++++++++++++++-------------------
  1 file changed, 78 insertions(+), 42 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..8807b36c2363 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2273,20 +2273,56 @@ struct page *get_dump_page(unsigned long addr)
  #endif /* CONFIG_ELF_CORE */
  
  #ifdef CONFIG_MIGRATION
+
+/*
+ * An array of either pages or folios. While we could currently interpret a
+ * list of folios like a list of pages, it would only work as long as
+ * "struct folio" overlays "struct page" -- and it would not allow for
+ * avoiding page_folio() calls.
+ */
+struct pages_or_folios {
+	union {
+		struct page **pages;
+		struct folio **folios;
+		void **entries;
+	};
+	bool has_folios;
+	long nr_entries;
+};
+
+static struct folio *pofs_get_folio(struct pages_or_folios *pofs, long i)
+{
+	if (pofs->has_folios)
+		return pofs->folios[i];
+	return page_folio(pofs->pages[i]);
+}
+
+static void pofs_clear_entry(struct pages_or_folios *pofs, long i)
+{
+	pofs->entries[i] = NULL;
+}
+
+static void pofs_unpin(struct pages_or_folios *pofs)
+{
+	if (pofs->has_folios)
+		unpin_folios(pofs->folios, pofs->nr_entries);
+	else
+		unpin_user_pages(pofs->pages, pofs->nr_entries);
+}
+
  /*
   * Returns the number of collected folios. Return value is always >= 0.
   */
  static unsigned long collect_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+		struct list_head *movable_folio_list,
+		struct pages_or_folios *pofs)
  {
  	unsigned long i, collected = 0;
  	struct folio *prev_folio = NULL;
  	bool drain_allow = true;
  
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
  
  		if (folio == prev_folio)
  			continue;
@@ -2310,6 +2346,11 @@ static unsigned long collect_longterm_unpinnable_folios(
  			drain_allow = false;
  		}
  
+		/*
+		 * TODO: if isolation fails we might already have it in the
+		 * list, if pages of different folios are interleaved
+		 * (e.g., COW). We might want to check all entries in the list.
+		 */
  		if (!folio_isolate_lru(folio))
  			continue;
  
@@ -2328,15 +2369,14 @@ static unsigned long collect_longterm_unpinnable_folios(
   * failure (or partial success).
   */
  static int migrate_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+		struct list_head *movable_folio_list,
+		struct pages_or_folios *pofs)
  {
  	int ret;
  	unsigned long i;
  
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
  
  		if (folio_is_device_coherent(folio)) {
  			/*
@@ -2344,7 +2384,7 @@ static int migrate_longterm_unpinnable_folios(
  			 * convert the pin on the source folio to a normal
  			 * reference.
  			 */
-			folios[i] = NULL;
+			pofs_clear_entry(pofs, i);
  			folio_get(folio);
  			gup_put_folio(folio, 1, FOLL_PIN);
  
@@ -2363,8 +2403,8 @@ static int migrate_longterm_unpinnable_folios(
  		 * calling folio_isolate_lru() which takes a reference so the
  		 * folio won't be freed if it's migrating.
  		 */
-		unpin_folio(folios[i]);
-		folios[i] = NULL;
+		unpin_folio(pofs_get_folio(pofs, i));
+		pofs_clear_entry(pofs, i);
  	}
  
  	if (!list_empty(movable_folio_list)) {
@@ -2387,12 +2427,24 @@ static int migrate_longterm_unpinnable_folios(
  	return -EAGAIN;
  
  err:
-	unpin_folios(folios, nr_folios);
+	pofs_unpin(pofs);
  	putback_movable_pages(movable_folio_list);
  
  	return ret;
  }
  
+static long check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
+{
+	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
+
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
+	if (!collected)
+		return 0;
+
+	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
+}
+
  /*
   * Check whether all folios are *allowed* to be pinned indefinitely (longterm).
   * Rather confusingly, all folios in the range are required to be pinned via
@@ -2412,41 +2464,25 @@ static int migrate_longterm_unpinnable_folios(
  static long check_and_migrate_movable_folios(unsigned long nr_folios,
  					     struct folio **folios)
  {
-	unsigned long collected;
-	LIST_HEAD(movable_folio_list);
-
-	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
-						       nr_folios, folios);
-	if (!collected)
-		return 0;
+	struct pages_or_folios pofs = {
+		.folios = folios,
+		.has_folios = true,
+		.nr_entries = nr_folios,
+	};
  
-	return migrate_longterm_unpinnable_folios(&movable_folio_list,
-						  nr_folios, folios);
+	return check_and_migrate_movable_pages_or_folios(&pofs);
  }
  
-/*
- * This routine just converts all the pages in the @pages array to folios and
- * calls check_and_migrate_movable_folios() to do the heavy lifting.
- *
- * Please see the check_and_migrate_movable_folios() documentation for details.
- */
+/* See check_and_migrate_movable_folios(). */
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
  					    struct page **pages)
  {
-	struct folio **folios;
-	long i, ret;
+	struct pages_or_folios pofs = {
+		.pages = pages,
+		.nr_entries = nr_pages,
+	};
  
-	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-	if (!folios)
-		return -ENOMEM;
-
-	for (i = 0; i < nr_pages; i++)
-		folios[i] = page_folio(pages[i]);
-
-	ret = check_and_migrate_movable_folios(nr_pages, folios);
-
-	kfree(folios);
-	return ret;
+	return check_and_migrate_movable_pages_or_folios(&pofs);
  }
  #else
  static long check_and_migrate_movable_pages(unsigned long nr_pages,
-- 
2.47.0


-- 
Cheers,

David / dhildenb


