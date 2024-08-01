Return-Path: <linux-kernel+bounces-270848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E4944634
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1EA31C22010
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE816DEAF;
	Thu,  1 Aug 2024 08:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j81OKJuy"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5C1EB490
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499603; cv=none; b=F8lpfTJR1V4mTFsVRBNvOtLd2Sqh4VLqFbh3SkYzeohgvCpqJR2RUDySikFP5BZJJJmv94xvTl6ezdWoCceR4+pusMii4tWuCH09cHhHrgvzCYbPrF8oc98sH7gzb+aSxVeQBUM5iXwzMfIs5nzxeODsM/uUhE11Wbvv3BTOM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499603; c=relaxed/simple;
	bh=2UQaTyl+e4aUx3eXNpUXmhySHng2WsfhWsk90vQMGtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI1W8I/dYeMTOTTtguYmIjAWqy/6uSrouIenVQ5QCUBj0Zygi8kjGvewvew8Mnj2rwL5Y1mZvvMO2pA/S1gEVVvJdg86HizHqapWciABjoG0MwRLSoMu6rQF6MGXAC7awdeUu+L2solabCApC1Wgx9Pxi8Q2jjVYIYg4ZxWOwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j81OKJuy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso4888402b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722499601; x=1723104401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NqmfobhM9Iu7Hq/oR4TLKO0+O0Au9Wt4MOTa5p04eQ=;
        b=j81OKJuy/32AMQrC3sV2vH7777wCpdbYhmsu83JLGB6euXPssa5j7F/nUDFxwf/aw+
         VAeloCVyucvmIyQvMieclld7BSUH263gPbbpcXawE293dyX1MwQh5nZU5K49SbM9uB6s
         X9WPX8zukU9dhHkXwBzupizIeML9H9nBEKm+1NSqdi2/+kJ1xs8hmyW1bMvZWjlrQ4//
         PRjvCa5PrbfoICKDdsDH//3Z1L5I6AVkpnsNvlg0by+blFSGSa2ttsee4xTIoACkZZkm
         yAHr+gdp6svLY8OrnLs93rsyeXOPMJNJ5hpHlCReHnI76rjX0Twk4vF5+NGSnBEK0tJF
         7PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499601; x=1723104401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NqmfobhM9Iu7Hq/oR4TLKO0+O0Au9Wt4MOTa5p04eQ=;
        b=aH22xE+hVdUVU6hRpifS0tHqI1h9Q/kq85Idu4q3A79J4nqTjVa+Qpr2xMHdHNoOR+
         JmrYkOKo99naDsVsvarFpDYAJ7gqHDuwob2ItifJ2bqYUvNLgww0KytQoStZnPczsez5
         hAz86Ir03KHOsf0ocSEdEg53uNaxni5JadW3Labg1n8omvPwc54tDDNEEyhlVS0EFpNJ
         28w+59ewyr6MSpH6duWI5JahQOVTvH3cP8VqyRAfm4mG0BlR4PBjAFq5A8rCZCBEPsTh
         qxVgDXVyZIa5RNdopYy4G3zhDJTZgtLk/xSHIBKU8xdX3H5CSuy4iZOSWznfC1vwQsXx
         4ddg==
X-Forwarded-Encrypted: i=1; AJvYcCW019b8K+0EchVZEsLfbUQKke3VipYtfoPN7KsQvy3dVLhd+Gh0mytmJEQwydgu/uUKdA1QoxyL88PFXYsARKkTN8F4kcfdQPGFLkKF
X-Gm-Message-State: AOJu0Yxh7wKTpVbyfeUXGin8ezDOh1GzGcmtoU4405cJbQuqepiNHJAq
	rLPycSuLlhNdfeBk01u3/2UvShpkYDVfyhonZqv06Rdef5QfiNVB
X-Google-Smtp-Source: AGHT+IGxbCIWJgX57nzkzOiLmk1Eab1BOgmf2e8Msr8QfKK1U3/hCG7G68yLq2ntqW11hVx+v/P7Dw==
X-Received: by 2002:a05:6a00:2388:b0:70e:98e3:1b9d with SMTP id d2e1a72fcca58-7105d716163mr2034390b3a.18.1722499600614;
        Thu, 01 Aug 2024 01:06:40 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8215b3sm10965617b3a.121.2024.08.01.01.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:06:40 -0700 (PDT)
Message-ID: <0a88242c-f549-479c-9430-3b580629ca5f@gmail.com>
Date: Thu, 1 Aug 2024 16:06:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/22] mm/zsmalloc: update comments for page->zpdesc
 changes
To: Matthew Wilcox <willy@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
 42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-23-alexs@kernel.org>
 <20240730093726.GB16599@google.com>
 <8fc7939b-416a-4328-9df2-488f17783543@gmail.com>
 <20240731021619.GD16599@google.com>
 <c614ec0c-ff5c-4ef6-8542-53ee5308f62a@gmail.com>
 <20240801031304.GF16599@google.com> <ZqsClTYNqR5wYlJ6@casper.infradead.org>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <ZqsClTYNqR5wYlJ6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/1/24 11:35 AM, Matthew Wilcox wrote:
> On Thu, Aug 01, 2024 at 12:13:04PM +0900, Sergey Senozhatsky wrote:
>> On (24/07/31 12:14), Alex Shi wrote:
>>>> A bit of a different thing, still documentation related tho: do
>>>> we want to do something about comments that mention page_lock in
>>>> zsmalloc.c?
>>>
>>> Good question!
>>>
>>> There are some comments mentioned about the page_lock in the file, but missed
>>> in the header of file, so how about the following adding:
>>
>> And e.g. things like
>>
>> `The page locks trylock_zspage got will be released by __free_zspage.`
>>
>> Should this (and the rest) spell "zpdesc locks" or something? Or do
>> we still want to refer to it as "page lock"?
> 
> pages do not have locks.  folios have locks.  zpdesc sounds like it has
> a lock too.

Thanks willy and Sergey's suggestion! If I understand right, we'd better to update
all subpages calling in the file by zpdesc? 
Yes that's a bit more fit the code. So, is the following new patch fine?

=========
From 6699da8d62a22e9cba4ee4452b2805fc66920395 Mon Sep 17 00:00:00 2001
From: Alex Shi <alexs@kernel.org>
Date: Mon, 8 Jul 2024 20:26:20 +0800
Subject: [PATCH] mm/zsmalloc: update comments for page->zpdesc changes

Thanks for Sergey and Willy's suggestion!
After the page to zpdesc conversion, there still left few comments or
function named with page not zpdesc, let's update the comments and
rename function create_page_chain() as create_zpdesc_chain().

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/zsmalloc.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 1543a339b7f4..490cecea72f6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -17,14 +17,16 @@
  *
  * Usage of struct zpdesc fields:
  *	zpdesc->zspage: points to zspage
- *	zpdesc->next: links together all component pages of a zspage
+ *	zpdesc->next: links together all component zpdescs of a zspage
  *		For the huge page, this is always 0, so we use this field
  *		to store handle.
  *	zpdesc->first_obj_offset: PG_zsmalloc, lower 16 bit locate the first
  *		object offset in a subpage of a zspage
  *
  * Usage of struct zpdesc(page) flags:
- *	PG_private: identifies the first component page
+ *	PG_private: identifies the first component zpdesc
+ *	PG_lock: lock all component zpdescs for a zspage free, serialize with
+ *		 migration
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -191,7 +193,10 @@ struct size_class {
 	 */
 	int size;
 	int objs_per_zspage;
-	/* Number of PAGE_SIZE sized pages to combine to form a 'zspage' */
+	/*
+	 * Number of PAGE_SIZE sized zpdescs/pages to combine to
+	 * form a 'zspage'
+	 */
 	int pages_per_zspage;
 
 	unsigned int index;
@@ -913,7 +918,7 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	/*
 	 * Since zs_free couldn't be sleepable, this function cannot call
-	 * lock_page. The page locks trylock_zspage got will be released
+	 * lock_page. The zpdesc locks trylock_zspage got will be released
 	 * by __free_zspage.
 	 */
 	if (!trylock_zspage(zspage)) {
@@ -970,7 +975,7 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	set_freeobj(zspage, 0);
 }
 
-static void create_page_chain(struct size_class *class, struct zspage *zspage,
+static void create_zpdesc_chain(struct size_class *class, struct zspage *zspage,
 				struct zpdesc *zpdescs[])
 {
 	int i;
@@ -979,9 +984,9 @@ static void create_page_chain(struct size_class *class, struct zspage *zspage,
 	int nr_zpdescs = class->pages_per_zspage;
 
 	/*
-	 * Allocate individual pages and link them together as:
-	 * 1. all pages are linked together using zpdesc->next
-	 * 2. each sub-page point to zspage using zpdesc->zspage
+	 * Allocate individual zpdescs and link them together as:
+	 * 1. all zpdescs are linked together using zpdesc->next
+	 * 2. each sub-zpdesc point to zspage using zpdesc->zspage
 	 *
 	 * we set PG_private to identify the first zpdesc (i.e. no other zpdesc
 	 * has this flag set).
@@ -1039,7 +1044,7 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		zpdescs[i] = zpdesc;
 	}
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	init_zspage(class, zspage);
 	zspage->pool = pool;
 	zspage->class = class->index;
@@ -1366,7 +1371,7 @@ static unsigned long obj_malloc(struct zs_pool *pool,
 		/* record handle in the header of allocated chunk */
 		link->handle = handle | OBJ_ALLOCATED_TAG;
 	else
-		/* record handle to page->index */
+		/* record handle to zpdesc->handle */
 		zspage->first_zpdesc->handle = handle | OBJ_ALLOCATED_TAG;
 
 	kunmap_atomic(vaddr);
@@ -1699,19 +1704,19 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 #ifdef CONFIG_COMPACTION
 /*
  * To prevent zspage destroy during migration, zspage freeing should
- * hold locks of all pages in the zspage.
+ * hold locks of all component zpdesc in the zspage.
  */
 static void lock_zspage(struct zspage *zspage)
 {
 	struct zpdesc *curr_zpdesc, *zpdesc;
 
 	/*
-	 * Pages we haven't locked yet can be migrated off the list while we're
+	 * Zpdesc we haven't locked yet can be migrated off the list while we're
 	 * trying to lock them, so we need to be careful and only attempt to
-	 * lock each page under migrate_read_lock(). Otherwise, the page we lock
-	 * may no longer belong to the zspage. This means that we may wait for
-	 * the wrong page to unlock, so we must take a reference to the page
-	 * prior to waiting for it to unlock outside migrate_read_lock().
+	 * lock each zpdesc under migrate_read_lock(). Otherwise, the zpdesc we
+	 * lock may no longer belong to the zspage. This means that we may wait
+	 * for the wrong zpdesc to unlock, so we must take a reference to the
+	 * zpdesc prior to waiting for it to unlock outside migrate_read_lock().
 	 */
 	while (1) {
 		migrate_read_lock(zspage);
@@ -1786,7 +1791,7 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 		idx++;
 	} while ((zpdesc = get_next_zpdesc(zpdesc)) != NULL);
 
-	create_page_chain(class, zspage, zpdescs);
+	create_zpdesc_chain(class, zspage, zpdescs);
 	first_obj_offset = get_first_obj_offset(oldzpdesc);
 	set_first_obj_offset(newzpdesc, first_obj_offset);
 	if (unlikely(ZsHugePage(zspage)))
@@ -1797,8 +1802,8 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 {
 	/*
-	 * Page is locked so zspage couldn't be destroyed. For detail, look at
-	 * lock_zspage in free_zspage.
+	 * Page/zpdesc is locked so zspage couldn't be destroyed. For detail,
+	 * look at lock_zspage in free_zspage.
 	 */
 	VM_BUG_ON_PAGE(PageIsolated(page), page);
 
@@ -1825,7 +1830,7 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	/* We're committed, tell the world that this is a Zsmalloc page. */
 	__zpdesc_set_zsmalloc(newzpdesc);
 
-	/* The page is locked, so this pointer must remain valid */
+	/* The zpdesc/page is locked, so this pointer must remain valid */
 	zspage = get_zspage(zpdesc);
 	pool = zspage->pool;
 
@@ -1898,7 +1903,7 @@ static const struct movable_operations zsmalloc_mops = {
 };
 
 /*
- * Caller should hold page_lock of all pages in the zspage
+ * Caller should hold zpdesc locks of all in the zspage
  * In here, we cannot use zspage meta data.
  */
 static void async_free_zspage(struct work_struct *work)
-- 
2.43.0


