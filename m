Return-Path: <linux-kernel+bounces-371185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F429A3787
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A171F24554
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A59718C00B;
	Fri, 18 Oct 2024 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtZex81+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E613C816
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237652; cv=none; b=QYypzGUFdaQ7kotWmIiiSpR56cIKGSkGZ3iLeB+dYwkZ889svBXgovt2NDydJ7ZLasfC/L/8Ye8PJn9V/tRlojN1eqYIu/j/xLh91bYCcGzZCTxnfntW6csWqgUl2feLOxlLPMHF/wCgIU8uXFLPR67/subGs8k58EbqYMsFsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237652; c=relaxed/simple;
	bh=klVK9nbVC/zxCgbkIUJfea6P9OhIFi7aq1lg4YG4CfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9DE8Xt6QrBEuqW6ATzweM5D9FDStv23X2cpjpQdWeb+I0ZlvY09obNxUD0rI+PVszyzOeToxWwaCJaq7WcoBv5x+nn0AB+bThDzF0Ms3EIkB1Wr/bV3h4tyFhAAB+IjfPMlH53i6aNgl3xE0AdCX0LQ/LSXw/sHr4gwHEvEdk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtZex81+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729237650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CH7wbZneUeccrehxEZ99VWbUAMrM3ay/5kptR2VKwpw=;
	b=QtZex81+4wFLBOuhafqVBWy0EWliYLayyS/M7lmUiLpWxJoO+eVeGAAwVToIarbCGXU18l
	ivdR52KeKYkcsPpuUaXVy72Fr82hAT0fBadC+fxjaPUHHsuNhsqaJzwChffZivIyFOyAGW
	d+sXPYRIwcl1NdX0GD8HKiFhwykDpyQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-CUQ7o9hKP-iMetZFW_dJFw-1; Fri, 18 Oct 2024 03:47:28 -0400
X-MC-Unique: CUQ7o9hKP-iMetZFW_dJFw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d609ef9f7so883622f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729237647; x=1729842447;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CH7wbZneUeccrehxEZ99VWbUAMrM3ay/5kptR2VKwpw=;
        b=m6RpwtPFmqpc62lw8BFaxip3oUvap9BSURdMKeX6fvFiUoTupTJsiF70Cx6+WT3V9H
         BVnrsDsP7cF+UH4JLgWlKYseBSAIt7fmooA2o9YqPjcfao3NWTXCWReAI1gCZ3Aq4eeq
         US0Twu4fikekEJd5/Gm6ND4xaokLgj2w7uGVsPrB9sIagt6CfHtTpzreXqYO8H+9Qm1G
         eA0Evtay6QAC6Pp6iPcKvq2vM4/534S19k+9hwAWQFicUFNaEkxE/m0uqhim2fxM2YOE
         XnAWyzVKwCb9TRY28V5vYeRodfO/MPJ8fpoJDjYGrK4CnDGvh9W+s1HsPo5cNLlLOKy8
         qmZg==
X-Gm-Message-State: AOJu0YxrjEqDO0JQn7P6ygoO7fiGvIpwZEPlMZbi+zZtAbXL6+z9BDTe
	FkMaqC0680YFVi0hR4MQtxoybnlFcWjy7ENbn1y09K6YYOhN86bTVw3DYJPGYG+AYAZT5Bo4qyT
	RikX06zLmnwNK4sa7Z5i9W8saZOn/zR06sHALHDHYJ9FfYRG1ytDw01F3i9EcXA==
X-Received: by 2002:adf:e912:0:b0:37d:4d6c:e0ef with SMTP id ffacd0b85a97d-37eab6e41d0mr1058893f8f.43.1729237647558;
        Fri, 18 Oct 2024 00:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWSoZrkXChGl7Ccva5VugBnN8QlNn8SK1md3UitE5EUSNMR/y4kBFLWkLpe3S2Sq2kpFAuEg==
X-Received: by 2002:adf:e912:0:b0:37d:4d6c:e0ef with SMTP id ffacd0b85a97d-37eab6e41d0mr1058871f8f.43.1729237647118;
        Fri, 18 Oct 2024 00:47:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf066600sm1193190f8f.37.2024.10.18.00.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 00:47:25 -0700 (PDT)
Message-ID: <cc9d692a-846d-4ae4-af4b-c8de8b724df6@redhat.com>
Date: Fri, 18 Oct 2024 09:47:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/gup: stop leaking pinned pages in low memory
 conditions
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Minchan Kim <minchan@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241018011711.183642-1-jhubbard@nvidia.com>
 <20241018011711.183642-2-jhubbard@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241018011711.183642-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.10.24 03:17, John Hubbard wrote:
> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
> family of functions, and requests "too many" pages, then the call will
> erroneously leave pages pinned. This is visible in user space as an
> actual memory leak.
> 
> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
> to exhaust memory.
> 
> The root cause of the problem is this sequence, within
> __gup_longterm_locked():
> 
>      __get_user_pages_locked()
>      rc = check_and_migrate_movable_pages()
> 
> ...which gets retried in a loop. The loop error handling is incomplete,
> clearly due to a somewhat unusual and complicated tri-state error API.
> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
> happily returns the error, while leaving the pages pinned.

Sorry for another comment, I am taking my time to look into the code again in more detail ...

migrate_longterm_unpinnable_folios() will always unpin all pages: no matter which error it returns.

a) If it returns -EAGAIN, it unpinned all folios
b) If it returns any error it first calls unpin_folios().

So shouldn't the fix just be in check_and_migrate_movable_pages()?

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..81fc8314e687 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2403,8 +2403,9 @@ static int migrate_longterm_unpinnable_folios(
   * -EAGAIN. The caller should re-pin the entire range with FOLL_PIN and then
   * call this routine again.
   *
- * If an error other than -EAGAIN occurs, this indicates a migration failure.
- * The caller should give up, and propagate the error back up the call stack.
+ * If an error occurs, all folios are unpinned. If an error other than
+ * -EAGAIN occurs, this indicates a migration failure. The caller should give
+ * up, and propagate the error back up the call stack.
   *
   * If everything is OK and all folios in the range are allowed to be pinned,
   * then this routine leaves all folios pinned and returns zero for success.
@@ -2437,8 +2438,10 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
         long i, ret;
  
         folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-       if (!folios)
+       if (!folios) {
+               unpin_user_pages(pages, nr_pages);
                 return -ENOMEM;
+       }
  
         for (i = 0; i < nr_pages; i++)
                 folios[i] = page_folio(pages[i]);



Then, check_and_migrate_movable_pages() will never return with an error and
having folios pinned.


If check_and_migrate_movable_pages() -> check_and_migrate_movable_folios()
returns "0", all folios remain pinned an no harm is done.


Consequently, I think patch #2 is not really required, because it doesn't
perform the temporary allocation that could fail with -ENOMEM.


Sorry for taking a closer look only now ...

-- 
Cheers,

David / dhildenb


