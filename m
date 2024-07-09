Return-Path: <linux-kernel+bounces-245359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DF592B1A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB569B21069
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731CA149C40;
	Tue,  9 Jul 2024 07:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1WSRoLR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFCF1494C9
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511673; cv=none; b=VTanFaeNozu/5A6s7FtPx4GM0So7u28ZIStYNghQKlsgk/tvPMErVcDEr41fr2yoNbLcgeRvs+wo3lPz2f9NFB7UehgB1WzHt5shIaVT+2SRf58Skc45nfda7UwE8vJdP30NAkY7yEpdFqkymAyxH6xNMdAdL6NATcUUwCQPxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511673; c=relaxed/simple;
	bh=MMsuJU0InjaKt4rGvZmobdGpwtorJvKt4BuhI7xfidA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpYhDkHa/EdtCOelfw+PPHUaAP61bL8QV+NaFRqeluTJZt2GfRX71Szor2tlI3aitHEs9j7TZq2hAvk6R/DdyJ9+UiZowNU3rjzg9pe1ldCIS4xdiZ710r8mzkUAqdgDzO0Xj5EDTP7zT007V1f6qvNFErxOCn1bMmAVNDuNHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1WSRoLR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720511670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=68B8EPN3YFyy6+KSbSIJxBNw84fUsaIeFi5BL01QjI8=;
	b=H1WSRoLRYlyFS8h0GCW27hdKc2qN/Nlc+4nUxtTBXVG9TxSXOc0biHoVbB8zEtiukR3Ajq
	xfNrdULovIj9MABMaXdyDZGCe28mhfXaTtALBZwBmpyHGupBgV/eAP0raPSib1lOHyBoRl
	TMRR7h/x+FW5u+MkId/NZsjgHCWgrH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-G9SUEb5IMbmyix5ZbF3aPg-1; Tue, 09 Jul 2024 03:54:28 -0400
X-MC-Unique: G9SUEb5IMbmyix5ZbF3aPg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3679e7eeda6so2971697f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511667; x=1721116467;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=68B8EPN3YFyy6+KSbSIJxBNw84fUsaIeFi5BL01QjI8=;
        b=JnT2gwLV1z4Lq3u6QDLOvJwcncMXKHyc3LzKQa6k4BVdBA13i5W5XRfWvR5iRIfGtg
         EZrNgQMetrL/r2QcAXl9LudbVHZUfpLg8wdTIlapQrGcGoFDUxSzRqaNPPNgeixySZDl
         1R9v+zVZavNJl8+0RuvCovj9QqnZGTQ1RQGkGvLZo8cdZL2UXUPKx7tnfXdjBQe2HLMs
         zGwqqhP6JC1EwRIn/k3zXBWql2U/ngQWoJzDtgZgC4J1qj4kKz47Xdep042GpVtWgrb7
         j0+YRZVLJvOKk2MpJl/WJZrmOvaAP6dwNn/Z66L5EGLkZ1rrzUz68BhonuxGsLGFxapD
         kltg==
X-Forwarded-Encrypted: i=1; AJvYcCXI9EXt5OEp1qLlC8CG8n13foT0hzQ46TqL+jEroPKnB/45pCt/cjygKnydygz70oi9n9/o3cetUW6b2DOyEXsuJuqiPMkT3nhARtyE
X-Gm-Message-State: AOJu0YwDld5YwHlb7B2JjC/pykMbPpBf5kMf9rNeEOUZZAaeXF+vNJMu
	fOiopJItseqG1RXkTcLofg8RRrdm5jKTqdM+JXrD7bTUpRF7n97VfekkliQmbi+WG0Q0+Q03lPj
	JU6cEOKbNX9u4eUoGze8zLvSklEW+bzpVzNPBNd1f1BlZmB3KXsOD0HDWgYlZFg==
X-Received: by 2002:adf:f007:0:b0:367:9409:f7f7 with SMTP id ffacd0b85a97d-367cea8f907mr1306679f8f.31.1720511667450;
        Tue, 09 Jul 2024 00:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhuAyiI+tvoNnLPpf7RhVOM/lUyKy7oWHSqtwGyXfopjwXTFBdOcOPxGz3uH/Csq6h4Z4osw==
X-Received: by 2002:adf:f007:0:b0:367:9409:f7f7 with SMTP id ffacd0b85a97d-367cea8f907mr1306657f8f.31.1720511666967;
        Tue, 09 Jul 2024 00:54:26 -0700 (PDT)
Received: from [10.236.5.245] ([88.128.88.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde89108sm1767696f8f.55.2024.07.09.00.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 00:54:26 -0700 (PDT)
Message-ID: <dcef4f35-565b-4b10-b3b1-ee1406fb5a88@redhat.com>
Date: Tue, 9 Jul 2024 09:54:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: shmem: Rename mTHP shmem counters
To: Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang
 <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Zi Yan <ziy@nvidia.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240708112445.2690631-1-ryan.roberts@arm.com>
 <CAGsJ_4zH72FyLq5gJm215oiWrtd6uf40L_F1UO6cFZ4sy7qt0A@mail.gmail.com>
 <744749c3-4506-40d9-ac48-0dbc59689f92@arm.com>
 <10b201b1-53d3-4f62-be8e-996aa95d2b99@redhat.com>
 <0240add9-4c56-4f66-b761-494cc2cf8fb5@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0240add9-4c56-4f66-b761-494cc2cf8fb5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.07.24 09:47, Ryan Roberts wrote:
> On 08/07/2024 21:50, David Hildenbrand wrote:
>> On 08.07.24 14:29, Ryan Roberts wrote:
>>> On 08/07/2024 12:36, Barry Song wrote:
>>>> On Mon, Jul 8, 2024 at 11:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> The legacy PMD-sized THP counters at /proc/vmstat include
>>>>> thp_file_alloc, thp_file_fallback and thp_file_fallback_charge, which
>>>>> rather confusingly refer to shmem THP and do not include any other types
>>>>> of file pages. This is inconsistent since in most other places in the
>>>>> kernel, THP counters are explicitly separated for anon, shmem and file
>>>>> flavours. However, we are stuck with it since it constitutes a user ABI.
>>>>>
>>>>> Recently, commit 66f44583f9b6 ("mm: shmem: add mTHP counters for
>>>>> anonymous shmem") added equivalent mTHP stats for shmem, keeping the
>>>>> same "file_" prefix in the names. But in future, we may want to add
>>>>> extra stats to cover actual file pages, at which point, it would all
>>>>> become very confusing.
>>>>>
>>>>> So let's take the opportunity to rename these new counters "shmem_"
>>>>> before the change makes it upstream and the ABI becomes immutable.
>>>>
>>>> Personally, I think this approach is much clearer. However, I recall
>>>> we discussed this
>>>> before [1], and it seems that inconsistency is a concern?
>>>
>>> Embarrassingly, I don't recall that converstation at all :-| but at least what I
>>> said then is consistent with what I've done in this patch.
>>>
>>> I think David's conclusion from that thread was to call them FILE_, and add both
>>> shmem and pagecache counts to those counters, meaning we can keep the same name
>>> as legacy THP counters. But those legacy THP counters only count shmem, and I
>>> don't think we would get away with adding pagecache counts to those at this
>>> point? (argument: they have been around for long time and there is a risk that
>>> user space relies on them and if they were to dramatically increase due to
>>> pagecache addition now that could break things). In that case, there is still
>>> inconsistency, but its worse; the names are consistent but the semantics are
>>> inconsistent.
>>>
>>> So my vote is to change to SHMEM_ as per this patch :)
>>
>> I also forgot most of the discussion, but these 3 legacy counters are really
>> only (currently) incremented for shmem. I think my idea was to keep everything
>> as FILE_ for now, maybe at some point make the pagecache also use them, and then
>> maybe have separate FILE_ + SHMEM_.
>>
>> But yeah, likely it's best to only have "shmem" here for now, because who knows
>> what we can actually change about the legacy counters. But it's always though
>> messing with legacy stuff that is clearly suboptimal ...
> 
> Sorry David, I've read your response a bunch of times and am still not
> completely sure what you are advocating for.
> 
> To make my proposal crystal clear, I think we should leave the legacy counters
> alone - neither change their name nor what they count (which is _only_ shmem). I
> think we should rename the new mTHP counters to "shmem" and have them continue
> to only count shmem. Then additionally, I think we should introduce new "file"
> mTHP counters that count the page cache allocations (that's a future set of
> patches, which I'm working on together with user controls to determine which
> mTHP sizes can be used by page cache).
> 
> As suggested by Barry, I propose to also improve the documentation for the
> legacy counters to make it clear that dispite their name being "file" they are
> actually counting "shmem". I'll do this for v2.

Yes, and please. Likely we should document for the legacy ones (if not 
already done) that they only track PMD-sized THPs.

> 
> David, would you support this approach? If so, I'd like to push this forwards
> asap so that it gets into v6.11 to avoid ever exposing the mthp counters with
> the "file" name.

Yes, sorry for not being clear.

-- 
Cheers,

David / dhildenb


