Return-Path: <linux-kernel+bounces-369130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFA09A194C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF839B25366
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DDC7E583;
	Thu, 17 Oct 2024 03:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XVgh+yOu"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE77C8F6C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729135547; cv=none; b=qP0L8evp1Si+iMH1bDtf38fWYycsVQDr4KlHSILNw1kWn0JSbjfCjdN0maCCK/T34+4wPXhFUo3nBS81Vr1w3y9OMhgGpj9pgGyiUAa0lOYziUfapu4ZFYXVn1Piv45GtEvFXSVEHjHBkai6dzZ8ywi4ApfbpQOV8M3I9Ts/i1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729135547; c=relaxed/simple;
	bh=imCL1m4BIcB95ncEb8kEhZkGxOtX4M/m1Anw4W4/2N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPte19GZjBnQzfda/w3u2zUxV7VpjZG7QeA6TGWQp1SOLYFXeEVzQeT4+H2BEdN1aulQY6m86GIglFxKYRwjgxV1zZ4MO+zx2wk93uIFe9h2B5bpTLwv+tlyXVDDEPqPOux6njT/WQMeh/x1RGbiX8S8XH4ra9o4sQGloADL3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XVgh+yOu; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729135541; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=9WfeWxzTjli81jKhloyV8TsWg0tcegzsoqDI3F/SNH8=;
	b=XVgh+yOuSzBofOrDfepGDsXn7wdhC2T4MOquoiwW6GFbx22m5nlxh7qiBqFsXQtlO5Gn3yFht1l/P0qzr9Q1t5IEX+SFS5HgTmDbWbB5mqKcggFYFHfCHc5vXp0EJJAjttlQSOhiXpptBlP6mvCPdBhsStngFA2bbHcrr7ZwxTk=
Received: from 30.74.144.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHJGsIc_1729135540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 11:25:40 +0800
Message-ID: <2b3572e1-a618-4f86-979d-87f59282fe8f@linux.alibaba.com>
Date: Thu, 17 Oct 2024 11:25:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read
 performance
To: Yang Shi <shy828301@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
 <Zw_d0EVAJkpNJEbA@casper.infradead.org>
 <CAHbLzkogrubD_rPH7zf1T454r-BsxL951YH=rGAfNqPZJSCGow@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAHbLzkogrubD_rPH7zf1T454r-BsxL951YH=rGAfNqPZJSCGow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/17 01:33, Yang Shi wrote:
> On Wed, Oct 16, 2024 at 8:38 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Wed, Oct 16, 2024 at 06:09:30PM +0800, Baolin Wang wrote:
>>> @@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>>                if (folio) {
>>>                        folio_unlock(folio);
>>>
>>> -                     page = folio_file_page(folio, index);
>>> -                     if (PageHWPoison(page)) {
>>> +                     if (folio_test_hwpoison(folio) ||
>>> +                         (folio_test_large(folio) &&
>>> +                          folio_test_has_hwpoisoned(folio))) {
>>
>> Hm, so if we have hwpoison set on one page in a folio, we now can't read
>> bytes from any page in the folio?  That seems like we've made a bad
>> situation worse.
> 
> Yeah, I agree. I think we can fallback to page copy if
> folio_test_has_hwpoisoned is true. The PG_hwpoison flag is per page.
> 
> The folio_test_has_hwpoisoned is kept set if the folio split is failed
> in memory failure handler.

Right. I can still keep the page size copy if 
folio_test_has_hwpoisoned() is true. Some sample changes are as follow.

Moreover, I noticed shmem splice_read() and write() also simply return 
an error if the folio_test_has_hwpoisoned() is true, without any 
fallback to page granularity. I wonder if it is worth adding page 
granularity support as well?

diff --git a/mm/shmem.c b/mm/shmem.c
index 7e79b6a96da0..f30e24e529b9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3111,9 +3111,11 @@ static ssize_t shmem_file_read_iter(struct kiocb 
*iocb, struct iov_iter *to)

         for (;;) {
                 struct folio *folio = NULL;
+               struct page *page = NULL;
                 unsigned long nr, ret;
                 loff_t end_offset, i_size = i_size_read(inode);
                 size_t fsize;
+               bool fallback_page_copy = false;

                 if (unlikely(iocb->ki_pos >= i_size))
                         break;
@@ -3127,13 +3129,16 @@ static ssize_t shmem_file_read_iter(struct kiocb 
*iocb, struct iov_iter *to)
                 if (folio) {
                         folio_unlock(folio);

-                       if (folio_test_hwpoison(folio) ||
-                           (folio_test_large(folio) &&
-                            folio_test_has_hwpoisoned(folio))) {
+                       page = folio_file_page(folio, index);
+                       if (PageHWPoison(page)) {
                                 folio_put(folio);
                                 error = -EIO;
                                 break;
                         }
+
+                       if (folio_test_large(folio) &&
+                           folio_test_has_hwpoisoned(folio))
+                               fallback_page_copy = true;
                 }

                 /*
@@ -3147,7 +3152,7 @@ static ssize_t shmem_file_read_iter(struct kiocb 
*iocb, struct iov_iter *to)
                         break;
                 }
                 end_offset = min_t(loff_t, i_size, iocb->ki_pos + 
to->count);
-               if (folio)
+               if (folio && likely(!fallback_page_copy))
                         fsize = folio_size(folio);
                 else
                         fsize = PAGE_SIZE;
@@ -3160,8 +3165,13 @@ static ssize_t shmem_file_read_iter(struct kiocb 
*iocb, struct iov_iter *to)
                          * virtual addresses, take care about potential 
aliasing
                          * before reading the page on the kernel side.
                          */
-                       if (mapping_writably_mapped(mapping))
-                               flush_dcache_folio(folio);
+                       if (mapping_writably_mapped(mapping)) {
+                               if (unlikely(fallback_page_copy))
+                                       flush_dcache_page(page);
+                               else
+                                       flush_dcache_folio(folio);
+                       }
+
                         /*
                          * Mark the page accessed if we read the beginning.
                          */
@@ -3171,7 +3181,10 @@ static ssize_t shmem_file_read_iter(struct kiocb 
*iocb, struct iov_iter *to)
                          * Ok, we have the page, and it's up-to-date, so
                          * now we can copy it to user space...
                          */
-                       ret = copy_folio_to_iter(folio, offset, nr, to);
+                       if (unlikely(fallback_page_copy))
+                               ret = copy_page_to_iter(page, offset, 
nr, to);
+                       else
+                               ret = copy_folio_to_iter(folio, offset, 
nr, to);
                         folio_put(folio);
                 } else if (user_backed_iter(to)) {
                         /*

