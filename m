Return-Path: <linux-kernel+bounces-429636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A797A9E1F52
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 279ECB2B303
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54D91F4713;
	Tue,  3 Dec 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9LGKNqn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1FA1F12FF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235450; cv=none; b=aF86bjCIfA/KqGG1rw6pqdEPruAfF7G2roSN4XD/M4Ehl+VhQySScY0DthSslMj1DWqHwExTs4A3RNsFaBlLUwibiR+6XCqYksPo6M4aOL1wmI7X3SBPDJpNPub+OjECMrdSP72UngwynoV8YgEhaw1CERxpykLn8+p+w/rrZj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235450; c=relaxed/simple;
	bh=WOU4zX0IZYv+rrDs32UCT/CmDrz8X+8OFHdl5Lpr4kQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=obwH5e2Tayqf8tiijdoyCEXeGDojrpZTIspnBYwpTMR2UqVzeXnQUEIQ+EAK6ZbRQ+NkAy4OrSU0boZ0Hh6LDYC91nS5FBuu0oHYazCS/6aayL1BSCHxdKdEeODLPY4pRHkGfeznA4zumA2bwhF4NAXSwNfNUlJrwQn55UfguUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9LGKNqn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733235447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g0UJPIXjVniWobB5oSIOB8j5neo8aFF+B6iIK+MqXr4=;
	b=Z9LGKNqn20k+UZeQwlSE8FUzrIojdBYQLwAtEHURasgdKIEvRTZ7SFetKACgNFhNb0LOk4
	T+jRl1PXdHQ26kUoqSABeGafkwrTRlvdPwoN4UU01xog1vU9ikzavDgVLU+yuX2Vr6PfBr
	ZAuqkneOiZKt5iTahm3tpWOMdWhkcNI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-rYCpVsk4OEa4LmKz1kiAMA-1; Tue, 03 Dec 2024 09:17:25 -0500
X-MC-Unique: rYCpVsk4OEa4LmKz1kiAMA-1
X-Mimecast-MFC-AGG-ID: rYCpVsk4OEa4LmKz1kiAMA
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso2404035f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235444; x=1733840244;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0UJPIXjVniWobB5oSIOB8j5neo8aFF+B6iIK+MqXr4=;
        b=i8++kHQZoFKHhD24WE1w5so9Uitkmf08fgH/EiTerngzLWk4D5KwZ9Fuq4L22mjzxW
         /qfeQ6mAOgBtWXcl3KQd3A5iEXHqWTcj3bhM5gAzML1W5fSXAan6wCblJcc/q4c+ZnYd
         T+9iWJ7V70zdJ/izgwEYvpZggfBKu8RxLXjAstWw8oBHBQSEdZICoqHZ5pT8qw49/Ih+
         HU2Wm9g7qs9Jdn6yIIkiY7lT2MTeYCNmMmjyBKQQgTLsTgb9jQ8ljNJn11HFB1l6Xnc7
         e0L6vXsxEZoJ/n3i0n0BACO18+gZ61raEgdNIcY71IojIiTn7KR0t6+BQ/iow2JXSAKe
         8gWg==
X-Forwarded-Encrypted: i=1; AJvYcCW1VGpxEiVs+kSo8NV5xCp45KXTiWqwEmnhGGd76KvEzfrqZY1vY0mvopg38wQYsO4MM5zcmgE1QPd+VhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdDwctmH89AH9SR8HUC5lE8a7dyyr7//nqJxgz7m/DgBDTxjS
	ZltxhkqRTQljh47YdUP8putICZAo6Mj5mFbK56OjvdLV/c8hSI+5XnkAT/6P73KxQz9bG6SyNXi
	T7IyjBWs+wmd2Lru0YeVs1dtpjIoGsiJilvIhQ5ssKKBFGEjpZrSZl4NsP1QVmw==
X-Gm-Gg: ASbGncuQDCom7aVfZ308f402q+Digfhq/qcjK0o3Ge/AD5XlCUuF5E+1c0iGdJOHMTI
	Va+Hqaqu4ZSZcdhh60Qw7QAh6ovCPTs5iBrEwJYyWn9sALQEupC1N7L2Oko6t18gVINdZzbeR7b
	Sfm7lckpjuvc21Y5w5pVDA0gDSRnkERtJuCEmjczTS+VsuOJUhQk3wXkiCpNKHjmViBBtO/s4GV
	R7la1OwnU+MQ93DvUvKnXXtZQuN9T6QqkZm23F86RT2DZ4h+yKXU4GQpGzNW4txy9/s3hQRJg29
	gsQAXPmdEzaDQpmlPphZf/Q5atYRM03LauuxVtXThQ5nDWDxrf4mcLvwVuVKvgN9g9Tft15YW99
	tPw==
X-Received: by 2002:a05:6000:480a:b0:385:f638:c68a with SMTP id ffacd0b85a97d-385fd3f1977mr2515546f8f.30.1733235444163;
        Tue, 03 Dec 2024 06:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhcUleiGCjb0A8/C4qqTKwVZtO0c2SrVd/eJu0hedjuQq3Mrw7NR6qnhgdPIt2KyefdK9MXQ==
X-Received: by 2002:a05:6000:480a:b0:385:f638:c68a with SMTP id ffacd0b85a97d-385fd3f1977mr2515526f8f.30.1733235443794;
        Tue, 03 Dec 2024 06:17:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe4e6sm189502935e9.14.2024.12.03.06.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:17:22 -0800 (PST)
Message-ID: <926c6f86-82c6-41bb-a24d-5418163d5c5e@redhat.com>
Date: Tue, 3 Dec 2024 15:17:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smaps: count large pages smaller than PMD size to
 anonymous_thp
To: Wenchao Hao <haowenchao22@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrii Nakryiko <andrii@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Peter Xu <peterx@redhat.com>, Barry Song <21cnbao@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241203134949.2588947-1-haowenchao22@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241203134949.2588947-1-haowenchao22@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 14:49, Wenchao Hao wrote:
> Currently, /proc/xxx/smaps reports the size of anonymous huge pages for
> each VMA, but it does not include large pages smaller than PMD size.
> 
> This patch adds the statistics of anonymous huge pages allocated by
> mTHP which is smaller than PMD size to AnonHugePages field in smaps.
> 
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> ---
>   fs/proc/task_mmu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 38a5a3e9cba2..b655011627d8 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -717,6 +717,12 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>   		if (!folio_test_swapbacked(folio) && !dirty &&
>   		    !folio_test_dirty(folio))
>   			mss->lazyfree += size;
> +
> +		/*
> +		 * Count large pages smaller than PMD size to anonymous_thp
> +		 */
> +		if (!compound && PageHead(page) && folio_order(folio))
> +			mss->anonymous_thp += folio_size(folio);
>   	}
>   
>   	if (folio_test_ksm(folio))


I think we decided to leave this (and /proc/meminfo) be one of the last
interfaces where this is only concerned with PMD-sized ones:

Documentation/admin-guide/mm/transhuge.rst:

The number of PMD-sized anonymous transparent huge pages currently used by the
system is available by reading the AnonHugePages field in ``/proc/meminfo``.
To identify what applications are using PMD-sized anonymous transparent huge
pages, it is necessary to read ``/proc/PID/smaps`` and count the AnonHugePages
fields for each mapping. (Note that AnonHugePages only applies to traditional
PMD-sized THP for historical reasons and should have been called
AnonHugePmdMapped).



-- 
Cheers,

David / dhildenb


