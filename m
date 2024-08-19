Return-Path: <linux-kernel+bounces-291814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D333956748
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D6B1C2083A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55615CD7C;
	Mon, 19 Aug 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCyG1q32"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1416115CD79
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060448; cv=none; b=pEK4TWsHs5l22uC4DnqlXi9z38Nm/q8cHGVD0PI84/0An+9gzBHglUPNcoB4lvMRD87zpPkfHwYfMc8XZM9fqJSjSTQ2gMw6woG81ed2sus0uU0hWn3mPEG8/t7bMScbtIo3XLzMGjk+jkYjpV8wu4ZFOZz3tuCA/kMgE4R5ITQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060448; c=relaxed/simple;
	bh=JGbdVz/5+jitrQZrmv4Fv445Ge5RQuDOQPSGX7JoJQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uImQjB46q/EpKPMfAlxKe7ef6mIry59P32lhF+PE9jXWh8xV4zii2Zm1QcXNfnq4bAbFQsnOby7We0Y4wuZGCAqUOAJj1bpREKU0Mlrk/KPsYzY/GlrxZzgYyBEWzCJriEJYhock1lub7TfuuDCK11SDf26ELsgzr4NKWnF+p9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCyG1q32; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724060446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cXW1cF8K+5+u4xFBSuc8nAxV8cU09T30MZM8Wz4ddbs=;
	b=jCyG1q32GvoD4RP+8F1032aHJs3A2kAGGCWQzG9baDlBbWSqvYw/MzTA4zLXdSgORV4IVs
	WL4lHlDRyB7YVz3d0jjrIVvw2zLLwnjXwKeFfsuJQMqxJOdN95u1ngK3+pD+fCZp51blQs
	gDM7WDA2fBn5FFWeMy1noz+GsS/HSRE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-r0Q_tlWqNqK10kxXS8AsBw-1; Mon, 19 Aug 2024 05:40:44 -0400
X-MC-Unique: r0Q_tlWqNqK10kxXS8AsBw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5bec5a6557cso1206068a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 02:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724060443; x=1724665243;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXW1cF8K+5+u4xFBSuc8nAxV8cU09T30MZM8Wz4ddbs=;
        b=niFwXKhiV0NrtvDPFBf/42Y6TxUyVL+pCM62e3fQrDnpZdRFWd7vHUY8jsE1CIMOzv
         bBXdoJyMSCEuJyoFF0+OhY6nfJCBzRjdnVbfmigpzVfbOQyuSDaLHdX+n6BNqdx+3QLF
         Vsdu039UIfAkATwD3sz0cIpEkT70MTdg9fAYMXw0TtfD9RiLcGuzD8e2zy062XDyv20L
         stckaY7f4JHWZz9/MioLAOiJUACgUM8eVduSLh8kJ/jeyhw59LHmEYoW7+odoCRVfAS9
         suuASX1ScCPE+u2T6lkCBQLaFgOTpY/aSSoqXHzcQG6Kaqyp/9qI6CKQr0fY+FfzCsiP
         DL/w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3V6HvF5PG8dTrIoOGRGfPq6Jbr6wTULCHsy5PO8wn7J9CeODSsYJFOU0Egs66KQCf29Vlj4rInHpurFtcU9G2pSPlxg5twC02S0l
X-Gm-Message-State: AOJu0YySZI2eKcNaoSSiOq0ZnaX+aRNVQya20NT7c3OR+p8XVRte5B3J
	aOFnHaT/pep4kNIGS5HLTndDMg7v+n313lD/N4riHBpGJYs3KDJ1EJGYYeWfoStzcrlY22xdXkV
	E9BJLZI1cUHOYWKZRPYhQP1KqBzR2s9ZdY07Y7TDvvIiqgza3ytrYdzYFbjQ9WQ==
X-Received: by 2002:a05:6402:2681:b0:5be:dd2d:83 with SMTP id 4fb4d7f45d1cf-5bedd2d02e2mr4872626a12.6.1724060443419;
        Mon, 19 Aug 2024 02:40:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGws/7I3pTXo8c3kRiarILZUokJINfdeWzMiZ6LGdatplCUWGCS+TvzBnyG3IssGsZDcV5ZzQ==
X-Received: by 2002:a05:6402:2681:b0:5be:dd2d:83 with SMTP id 4fb4d7f45d1cf-5bedd2d02e2mr4872612a12.6.1724060442968;
        Mon, 19 Aug 2024 02:40:42 -0700 (PDT)
Received: from [100.81.188.195] ([178.24.249.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7ed31sm5569279a12.67.2024.08.19.02.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 02:40:42 -0700 (PDT)
Message-ID: <966bfe10-6123-48db-95b7-ade2f794700d@redhat.com>
Date: Mon, 19 Aug 2024 11:40:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mm: khugepaged: use the number of pages in the folio
 to check the reference count
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org
Cc: hughd@google.com, willy@infradead.org, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1724054125.git.baolin.wang@linux.alibaba.com>
 <c6038c7e823d4162f745147628616f7876585a97.1724054125.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c6038c7e823d4162f745147628616f7876585a97.1724054125.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.24 10:14, Baolin Wang wrote:
> Use the number of pages in the folio to check the reference count as
> preparation for supporting shmem mTHP collapse.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   mm/khugepaged.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f11b4f172e61..60d95f08610c 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1994,7 +1994,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   		/*
>   		 * We control three references to the folio:

^ "three" is wrong now.

>   		 *  - we hold a pin on it;
> -		 *  - one reference from page cache;
> +		 *  - nr_pages reference from page cache;
>   		 *  - one from lru_isolate_folio;
>   		 * If those are the only references, then any new usage
>   		 * of the folio will have to fetch it from the page
> @@ -2002,7 +2002,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   		 * truncate, so any new usage will be blocked until we
>   		 * unlock folio after collapse/during rollback.
>   		 */
> -		if (folio_ref_count(folio) != 3) {
> +		if (folio_ref_count(folio) != 2 + folio_nr_pages(folio)) {
>   			result = SCAN_PAGE_COUNT;
>   			xas_unlock_irq(&xas);
>   			folio_putback_lru(folio);
> @@ -2185,7 +2185,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>   		folio_clear_active(folio);
>   		folio_clear_unevictable(folio);
>   		folio_unlock(folio);
> -		folio_put_refs(folio, 3);
> +		folio_put_refs(folio, 2 + folio_nr_pages(folio));
>   	}
>   
>   	goto out;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


