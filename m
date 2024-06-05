Return-Path: <linux-kernel+bounces-202149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498B8FC860
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DA828255C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7FE18FDAD;
	Wed,  5 Jun 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjLI+PwX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BB1946CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581240; cv=none; b=SuHRqUCx7DXDmFth8h1n5JkI1R5r0ai3YVPvA0jG0smKQu5KOSywUlnVM1ARdiXcdBxQAjOb+lU2fNjPEfmpSG1efX/gAeHuw6vlb+/k9+MslBrD37wXNp5Vb1+kLqOH4B8kHKcJrwyqhHidU/ICR1SnhSyEN50WX92FRd0zldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581240; c=relaxed/simple;
	bh=alZg2KdiBuuGS6YV9j+dcMHSDjU1hh++DbOKGrdKCow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AdhRVXQSHAPrHujQolLTTs7h7tZt14TzqT0naAGI2xjjV/WaFP/A00MPriCfvqp+KNYbfsjiek1890DyDdCO7RWEG7+0g4eQcmeJRhn8RRsrkx6Pzj3yoTFWEY2k7hCneCU2aepoqopc4UssOKujwAvLo8If8mixigFS4Dvo1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjLI+PwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717581238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qc4gnloxVtNIKn+gv7pn1dGX6eYs/tuldfqNgcN/8gE=;
	b=OjLI+PwXIWzxIX/ScZojPfg2zi/zAMYePs8QLxzgurWLKoqapK3NBB+ELKBUyEPvOctBot
	0P2K2koQZZDO85t6Y4kpKlZH7yPVWSD9XQ0XPpeHm3Pu/z/80Y3QhROs2EtYJLXyurgg38
	xBrKyhdXUBdDqn1FtswH81yvf9wfdXE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-fjHzKKfvMo-JN-XerZoRzw-1; Wed, 05 Jun 2024 05:53:56 -0400
X-MC-Unique: fjHzKKfvMo-JN-XerZoRzw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3580f213373so4485446f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717581235; x=1718186035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qc4gnloxVtNIKn+gv7pn1dGX6eYs/tuldfqNgcN/8gE=;
        b=BkrHYBZ/QxUfCd6p/FdlPyFp9HYrNZKtZThl38Qn4nVO42jxL5m2j4zs23ueYL2Bl1
         V8dqrinUPiOPkeZGaB8O+m2d5jin/yl5DHRZZTBZmAh5A4Tl02noibnfQ3CUlWk9iwOa
         xtFghLDftXMMxR+W1leYXbN3VRD3sioNdW/f1GzfgosdAPKDUxnPhNsB1D704nmVOSsE
         gaUliG9zB4Bq88CUz8pdjdq9wqPIOtZn5oLP9IkbYXPZt8gV+soy/NbPXMIklpwUBZ/4
         clwORS21Va6Tfd6TI/M026sh4XbFpv6cXK/Zs3clHKva7NxQx1ieBvHCKjvN4d6RovBd
         H6DA==
X-Forwarded-Encrypted: i=1; AJvYcCUCIXkuMtSzQvFKaU0xhClmRNe1XYb+g8WVW1faQIJ5j+2LBCtQzlB0OY17wpXGFwN8PdrPr0C7Yl+JR5guhJ125IABsJSwchJvgjh3
X-Gm-Message-State: AOJu0YzdLgg3Qz+vUwsYVZpAO+TKBDehGHG/gLQTdH3PuPbdb54MJbms
	aquVjfd5mmjzZEopn6HkUKTWdtYGqmSMSag0IogEkJR2HrX/8vXvoqbtaJaZuyAQYU8Ku+0HCpk
	rvgA/iTRT31OpeQXfTiStpCm6ibqAi6cW5TCX7l9D5Yo8v+EAlVIKZklHy/QThiNrueIGLA==
X-Received: by 2002:adf:e262:0:b0:354:fb6c:2198 with SMTP id ffacd0b85a97d-35e8404a092mr1479931f8f.8.1717581234899;
        Wed, 05 Jun 2024 02:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPlo6P6GE0de/C6za7a9pVJU+LAIwJw4hYKRY8hNAvIsVhQWVzirhotEuSx12XtNl1QuiPvQ==
X-Received: by 2002:adf:e262:0:b0:354:fb6c:2198 with SMTP id ffacd0b85a97d-35e8404a092mr1479921f8f.8.1717581234481;
        Wed, 05 Jun 2024 02:53:54 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23a9a.dip0.t-ipconnect.de. [79.242.58.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04e48b9sm14006744f8f.64.2024.06.05.02.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 02:53:54 -0700 (PDT)
Message-ID: <7063920f-963a-4b3e-a3f3-c5cc227bc877@redhat.com>
Date: Wed, 5 Jun 2024 11:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: don't check page lru flag before draining it
From: David Hildenbrand <david@redhat.com>
To: yangge1116 <yangge1116@126.com>, akpm@linux-foundation.org,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
References: <1717498121-20926-1-git-send-email-yangge1116@126.com>
 <0d7a4405-9a2e-4bd1-ba89-a31486155233@redhat.com>
 <dc7a0b61-8d3f-7205-2f6d-c2b12500947a@126.com>
 <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <776de760-e817-43b2-bd00-8ce96f4e37a8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05.06.24 11:41, David Hildenbrand wrote:
> On 05.06.24 03:18, yangge1116 wrote:
>>
>>
>> 在 2024/6/4 下午9:47, David Hildenbrand 写道:
>>> On 04.06.24 12:48, yangge1116@126.com wrote:
>>>> From: yangge <yangge1116@126.com>
>>>>
>>>> If a page is added in pagevec, its ref count increases one, remove
>>>> the page from pagevec decreases one. Page migration requires the
>>>> page is not referenced by others except page mapping. Before
>>>> migrating a page, we should try to drain the page from pagevec in
>>>> case the page is in it, however, folio_test_lru() is not sufficient
>>>> to tell whether the page is in pagevec or not, if the page is in
>>>> pagevec, the migration will fail.
>>>>
>>>> Remove the condition and drain lru once to ensure the page is not
>>>> referenced by pagevec.
>>>
>>> What you are saying is that we might have a page on which
>>> folio_test_lru() succeeds, that was added to one of the cpu_fbatches,
>>> correct?
>>
>> Yes
>>
>>>
>>> Can you describe under which circumstances that happens?
>>>
>>
>> If we call folio_activate() to move a page from inactive LRU list to
>> active LRU list, the page is not only in LRU list, but also in one of
>> the cpu_fbatches.
>>
>> void folio_activate(struct folio *folio)
>> {
>>        if (folio_test_lru(folio) && !folio_test_active(folio) &&
>>            !folio_test_unevictable(folio)) {
>>            struct folio_batch *fbatch;
>>
>>            folio_get(folio);
>>            //After this, folio is in LRU list, and its ref count have
>> increased one.
>>
>>            local_lock(&cpu_fbatches.lock);
>>            fbatch = this_cpu_ptr(&cpu_fbatches.activate);
>>            folio_batch_add_and_move(fbatch, folio, folio_activate_fn);
>>            local_unlock(&cpu_fbatches.lock);
>>        }
>> }
> 
> Interesting, the !SMP variant does the folio_test_clear_lru().
> 
> It would be really helpful if we could reliably identify whether LRU
> batching code has a raised reference on a folio.
> 
> We have the same scenario in
> * folio_deactivate()
> * folio_mark_lazyfree()
> 
> In folio_batch_move_lru() we do the folio_test_clear_lru(folio).
> 
> No expert on that code, I'm wondering if we could move the
> folio_test_clear_lru() out, such that we can more reliably identify
> whether a folio is on the LRU batch or not.

I'm sure there would be something extremely broken with the following
(I don't know what I'm doing ;) ), but I wonder if there would be a way
to make something like that work (and perform well enough?).

diff --git a/mm/swap.c b/mm/swap.c
index 67786cb771305..642e471c3ec5a 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -212,10 +212,6 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
         for (i = 0; i < folio_batch_count(fbatch); i++) {
                 struct folio *folio = fbatch->folios[i];
  
-               /* block memcg migration while the folio moves between lru */
-               if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
-                       continue;
-
                 folio_lruvec_relock_irqsave(folio, &lruvec, &flags);
                 move_fn(lruvec, folio);
  
@@ -255,8 +251,9 @@ static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
   */
  void folio_rotate_reclaimable(struct folio *folio)
  {
-       if (!folio_test_locked(folio) && !folio_test_dirty(folio) &&
-           !folio_test_unevictable(folio) && folio_test_lru(folio)) {
+       if (folio_test_lru(folio) && !folio_test_locked(folio) &&
+           !folio_test_dirty(folio) && !folio_test_unevictable(folio) &&
+           folio_test_clear_lru(folio)) {
                 struct folio_batch *fbatch;
                 unsigned long flags;
  
@@ -354,7 +351,7 @@ static void folio_activate_drain(int cpu)
  void folio_activate(struct folio *folio)
  {
         if (folio_test_lru(folio) && !folio_test_active(folio) &&
-           !folio_test_unevictable(folio)) {
+           !folio_test_unevictable(folio) && folio_test_clear_lru(folio)) {
                 struct folio_batch *fbatch;
  
                 folio_get(folio);
@@ -699,6 +696,8 @@ void deactivate_file_folio(struct folio *folio)
         /* Deactivating an unevictable folio will not accelerate reclaim */
         if (folio_test_unevictable(folio))
                 return;
+       if (!folio_test_clear_lru(folio))
+               return;
  
         folio_get(folio);
         local_lock(&cpu_fbatches.lock);
@@ -718,7 +717,8 @@ void deactivate_file_folio(struct folio *folio)
  void folio_deactivate(struct folio *folio)
  {
         if (folio_test_lru(folio) && !folio_test_unevictable(folio) &&
-           (folio_test_active(folio) || lru_gen_enabled())) {
+           (folio_test_active(folio) || lru_gen_enabled()) &&
+           folio_test_clear_lru(folio)) {
                 struct folio_batch *fbatch;
  
                 folio_get(folio);
@@ -740,7 +740,8 @@ void folio_mark_lazyfree(struct folio *folio)
  {
         if (folio_test_lru(folio) && folio_test_anon(folio) &&
             folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
-           !folio_test_unevictable(folio)) {
+           !folio_test_unevictable(folio) &&
+           folio_test_clear_lru(folio)) {
                 struct folio_batch *fbatch;
  
                 folio_get(folio);



-- 
Cheers,

David / dhildenb


