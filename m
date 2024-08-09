Return-Path: <linux-kernel+bounces-280976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B916294D18C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1808FB21A66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0642195FEC;
	Fri,  9 Aug 2024 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UT81Uh87"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69764195FEF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211276; cv=none; b=ffY/5TuBrHsa3cjKlGYxYjO+8vmpqAFW0g5DMljpWXDwVZFpcjOtRTctQ/eoS7/WAIXTj1/qKhLqFEZzj7n9geIrTvndkXDu9CKyM0smUxVZn70yD/UpOmduInbbToZwSdrgjOPNQvtyHuPKegWOYBeya1dWuwhdfMyKHRlNnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211276; c=relaxed/simple;
	bh=h/gETMxwSX7PKWGfoK6CtdX0CU+AONkas3R8CWNCc4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=debL+Mu2ArhM70760wMI26nFk4CicpA9fKTjZNr1QM1U5MLWiuKRLz0nruUIiY6yntYjW44bdFt8seuiL1vga3YULjVjmdLOrMSXVVaMNWdkTGz3zVzV7N5/wKBrBv7wWT/y08Wnqji5bFOu2Eoc9kmRiR1nM3bAoCpD4VwcSRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UT81Uh87; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723211274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=abAgUi1+Zy9/7Tnhw4Fiy6iRsAPB01YF1mBbZxXtcPw=;
	b=UT81Uh87wSmwLbjvzPL9jVCgRfIgVXMYw0Suivl64Rjuu+aSXvN5mwPp4k7zHONFO1/6Ly
	eKHnK/JLAZyOY3wpE8QYTeYBP0NdDmeoAoOfE05p19X1G8jy3t8VOxxdiH/Owscp6LbW9s
	tw3sJZ5spZgBuimNPD1g15jeXDpMLE4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-X6fCCbbcNfiKQqaWlh1FEA-1; Fri, 09 Aug 2024 09:47:53 -0400
X-MC-Unique: X6fCCbbcNfiKQqaWlh1FEA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816aacabcso14782935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211272; x=1723816072;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=abAgUi1+Zy9/7Tnhw4Fiy6iRsAPB01YF1mBbZxXtcPw=;
        b=wcVhZm/0+0dQIVZ86/GhzSUncffPnCirzyLX2MmafcMaWyKgUThQblrbmmbQeqg4Un
         T7ssBFrxOkLNH4ovOIlsK4FOyE1nIxy8vdKsqOxArxydd4fAXgJBcHYJWrZj0Bw8/8mz
         jbrMCmLt6Gooux2IEsS1AreHXarF+39ZSG6xvMp7SpJupAQrYCqZBCh0qOzNcax6G3iG
         dBJereqYW3eTas70pCKGKRB80v3Zb/Orj5IWNcp/LRCQbapY1L+HucnZRvQOHDVqIv00
         pzq51oEvfqylQwzTiTAHf/3Ief1S16P90Eg0sPMZ1Pq4mI/wyDNBLSPBjdU4YVnacWqz
         k3ag==
X-Forwarded-Encrypted: i=1; AJvYcCWxafDv1VfNL25BiW1Y/t63W0F1ChD3W/xM1JHQrKb+npiFNKt7uzWmaCgZ+hTQ8jRjjtDDO6pDui0ONBpfEm6Xeq9edCSM9MjmSf0s
X-Gm-Message-State: AOJu0Yx9MOATthCyUZ+uwtiNPj5B94vU0P+Aihciw9po+o5kuzijN5o5
	TuKxy5B2ugLqKJsIlVAKCOtBz5osbc9mUzxHA//ipwBHxmEps/OIswE7r08qMR+GYo3eO9PMI4y
	QFUKSIYULW4qoPDMVXfG41Y/Ys/ogf2AiDbgpF98zaBPle3nMrctqHgUodia9xQ==
X-Received: by 2002:a05:600c:81e:b0:426:6ed2:6130 with SMTP id 5b1f17b1804b1-429c3a22f76mr10113495e9.14.1723211271807;
        Fri, 09 Aug 2024 06:47:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9qBwJZyeDlqvfoQ6FAb16ltqAXPnmsE5wmIP3HkLigyWZbF2pZDcU9Kn8974AQAtPb2jfSA==
X-Received: by 2002:a05:600c:81e:b0:426:6ed2:6130 with SMTP id 5b1f17b1804b1-429c3a22f76mr10113115e9.14.1723211271304;
        Fri, 09 Aug 2024 06:47:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:3f00:d228:bd67:7baa:d604? (p200300d82f093f00d228bd677baad604.dip0.t-ipconnect.de. [2003:d8:2f09:3f00:d228:bd67:7baa:d604])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059713c4sm132070245e9.12.2024.08.09.06.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 06:47:50 -0700 (PDT)
Message-ID: <761ba58e-9d6f-4a14-a513-dcc098c2aa94@redhat.com>
Date: Fri, 9 Aug 2024 15:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: Retry migration earlier upon refcount mismatch
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org,
 willy@infradead.org
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 osalvador@suse.de, baolin.wang@linux.alibaba.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 ioworker0@gmail.com, gshan@redhat.com, mark.rutland@arm.com,
 kirill.shutemov@linux.intel.com, hughd@google.com, aneesh.kumar@kernel.org,
 yang@os.amperecomputing.com, peterx@redhat.com, broonie@kernel.org,
 mgorman@techsingularity.net, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
References: <20240809103129.365029-1-dev.jain@arm.com>
 <20240809103129.365029-2-dev.jain@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240809103129.365029-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.08.24 12:31, Dev Jain wrote:
> As already being done in __migrate_folio(), wherein we backoff if the
> folio refcount is wrong, make this check during the unmapping phase, upon
> the failure of which, the original state of the PTEs will be restored and
> the folio lock will be dropped via migrate_folio_undo_src(), any racing
> thread will make progress and migration will be retried.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/migrate.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e7296c0fb5d5..477acf996951 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1250,6 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   	}
>   
>   	if (!folio_mapped(src)) {
> +		/*
> +		 * Someone may have changed the refcount and maybe sleeping
> +		 * on the folio lock. In case of refcount mismatch, bail out,
> +		 * let the system make progress and retry.
> +		 */
> +		struct address_space *mapping = folio_mapping(src);
> +
> +		if (folio_ref_count(src) != folio_expected_refs(mapping, src))
> +			goto out;

This really seems to be the latest point where we can "easily" back off 
and unlock the source folio -- in this function :)

I wonder if we should be smarter in the migrate_pages_batch() loop when 
we start the actual migrations via migrate_folio_move(): if we detect 
that a folio has unexpected references *and* it has waiters 
(PG_waiters), back off then and retry the folio later. If it only has 
unexpected references, just keep retrying: no waiters -> nobody is 
waiting for the lock to make progress.

For example, when migrate_folio_move() fails with -EAGAIN, check if 
there are waiters (PG_waiter?) and undo+unlock to try again later.

But I'm not really a migration expert, so only my 2 cents :)

>   		__migrate_folio_record(dst, old_page_state, anon_vma);
>   		return MIGRATEPAGE_UNMAP;
>   	}

-- 
Cheers,

David / dhildenb


