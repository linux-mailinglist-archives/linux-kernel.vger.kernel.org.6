Return-Path: <linux-kernel+bounces-230058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEA59177EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C29B282A86
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64613D89B;
	Wed, 26 Jun 2024 05:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADILI5oe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2D13AD28
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378540; cv=none; b=u52wrkizAxfJZdFyb6oTGY3IUmWFE1O4S2bHtY2hKcupkzoXzZ45rrr8D52423HYUPrf8pyTUPuWYZxOS+jN9VTAtmv4IIAd64x/WZ6OFg+WJUYliiyXXn6k3msA2osKfnfHPSe/VTlRx3wSLGvP+cRg2oploCmLbofggDiVQwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378540; c=relaxed/simple;
	bh=jc8ar5pB3yTNfAKOdzaBpfkxOFzuPaQ7kzRKDlgwXfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRN51F1E/FHGXDqLeT5ikS6aSjdGBF6f4Ps6x/0ms115FyxG6eKodiEW8Gz8QaoYxXWEfKF96HZuB/GPBmqY1AppcZzCOeaAccWghtvlnxQr/H0ToA71IuPRNfsJRK8n/ggVWMS84kPGJ2gi9dspk8ba8dQBvIGFbNmaFn5bssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADILI5oe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719378538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lKdnQfLmgCvfg1/bGVpHdQOE7llBxQ0KTseDI0hZ8WQ=;
	b=ADILI5oem/KP69pDIqZzE3nDn54ymYvU9NGJ8EeE0r0qBjGSjQrzxHc7ukQlC4stsKV6x1
	QWyZeFISYImJ1Ooz5zrJ6zZUtIsJ5Tw9ERY8RZFPFLc7Mp+fpHnwauFcU7VGaJOIand1WN
	Zxlbq93olipo+ag6YyQTmJfif1hQ2DE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-4wVZgPwENFu3VT1oy7ipKQ-1; Wed, 26 Jun 2024 01:08:51 -0400
X-MC-Unique: 4wVZgPwENFu3VT1oy7ipKQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3634a634f8aso2981124f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378530; x=1719983330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKdnQfLmgCvfg1/bGVpHdQOE7llBxQ0KTseDI0hZ8WQ=;
        b=TuKtaCoApFVJP/SKZW7O2a4dHLwaRBhTvLpldWl3Xd7nOuCm2GkcWrQjDrqNyPMR21
         MQsKRwgh0CPjJGHPhYu8a2Vi+/f42b+idzYjZ1hM/LtATlbcnzttPl00GrM0KPOQmroJ
         0VoIJ8RsirwCTcunAplQeMOvmGgnty7yOod1dhrLsZIkDmOLoLchfKLhIVlgdOd5bvpL
         zHHberwnX3kJFkMwJjCLG0iEt5kZLgjAtMlBpSbFEhyVfFwQQzQPjs1JxmvhGyFGs2jA
         jUcfQusHtuIPq7lCGSXToiF5lkxBL0uOjZkEz0zOy/2VpuojNqhgIq7+uauLa24TEO9E
         d66g==
X-Forwarded-Encrypted: i=1; AJvYcCVPiKuuTer9nUF+uuRPx9eiFGa7gzJivTb74vEDthWBG7qbQK2udeoJebifoi6QZy+KbndUmTN2cawc2xECSQbG2Ps3yg+3Mz+8YoHF
X-Gm-Message-State: AOJu0YxmAep92Tkdi99e7yx9fAZdmZe/3ddBJ007nMQ88i2QpsGh8OZf
	WNbLbrpeHIiQLK/lNXLoIQVJPM+mSsC/gIjaxGOE0l+WTXoljjg8uDdGl502TGO98vDRY/wL6un
	+hA+Ul0SVgUjncKjRroY3t85DYc9E3vNCRRfpgYEKTsai6agMF4kQOmzddWcqig==
X-Received: by 2002:a5d:64cc:0:b0:35f:2fa7:ef14 with SMTP id ffacd0b85a97d-366e96beaa2mr7213535f8f.60.1719378529860;
        Tue, 25 Jun 2024 22:08:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGOW9U3sHUzQRtqv84MAnok/aGQBUtS6qQp4TKNFq5tQVam0t32z8wr6Hl57XUuE+zp1eibA==
X-Received: by 2002:a5d:64cc:0:b0:35f:2fa7:ef14 with SMTP id ffacd0b85a97d-366e96beaa2mr7213525f8f.60.1719378529433;
        Tue, 25 Jun 2024 22:08:49 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b8597sm14592184f8f.36.2024.06.25.22.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 22:08:48 -0700 (PDT)
Message-ID: <96e0915c-e836-4413-81ea-37bbb6abba6b@redhat.com>
Date: Wed, 26 Jun 2024 07:08:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm/zsmalloc: use a proper page type
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
 Minchan Kim <minchan@kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20240529111904.2069608-1-david@redhat.com>
 <20240529111904.2069608-4-david@redhat.com>
 <20240530050123.GA8400@google.com> <ZlnebQ0dRUvx2SgP@casper.infradead.org>
 <345161ac-3b42-48aa-ab3d-3b183316479a@redhat.com>
 <20240625153338.8a4d049857d59e692a0d31e6@linux-foundation.org>
 <20240626044122.GA15925@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240626044122.GA15925@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.06.24 06:41, Sergey Senozhatsky wrote:
> On (24/06/25 15:33), Andrew Morton wrote:
>> On Fri, 31 May 2024 16:32:04 +0200 David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 31.05.24 16:27, Matthew Wilcox wrote:
>>>> On Thu, May 30, 2024 at 02:01:23PM +0900, Sergey Senozhatsky wrote:
>>>>       1409:       83 c0 01                add    $0x1,%eax
>>>>                   if (mapcount < PAGE_MAPCOUNT_RESERVE + 1)
>>>>       140c:       83 f8 81                cmp    $0xffffff81,%eax
>>>>       140f:       7d 63                   jge    1474 <filemap_unaccount_folio+0x8
>>>> 4>
>>>>           if (folio_test_hugetlb(folio))
>>>>       1411:       80 7b 33 84             cmpb   $0x84,0x33(%rbx)
>>>>       1415:       74 4e                   je     1465 <filemap_unaccount_folio+0x75>
>>>>
>>>> so we go from "mov, and, cmp, je" to just "cmpb, je", which must surely
>>>> be faster to execute as well as being more compact in the I$ (6 bytes vs 15).
>>>>
>>>> Anyway, not tested but this is the patch I used to generate the above.
>>>> More for comment than application.
>>>
>>> Right, it's likely very similar to my previous proposal to use 8 bit
>>> (uint8_t) for the type.
>>>
>>> https://lore.kernel.org/all/00ba1dff-7c05-46e8-b0d9-a78ac1cfc198@redhat.com/
>>>
>>> I would prefer if we would do that separately; unless someone is able to
>>> raise why we care about zram + 256KiB that much right now. (claim: we don't)
>>>
>>
>> iow, "this is ok for now", yes?
> 
> Perhaps.  I'm not in position to claim that zram + 256KiB PAGE_SIZE is
> irrelevant, but I'm also not in position to claim the opposite.
> 
> Matthew and David have ideas/proposals/patches to fix it should 256KiB
> PAGE_SIZE become an issue.

Yes, let's keep it simple for now. There are various ways to handle that 
if there is really the need to. 256KiB is not particularly common (quite 
the opposite I would claim), and a simple fix would be dedicating 18 
instead of 16 bit.

Long-term, we should handle it more cleanly though, and there are also 
various ways forward (store offset in page, separate allocation like 
memdesc for metadata, etc.).

Mess with turning page types from flags into values should be a separate 
effort, because requires more care (e.g., PAGE_SLAB_MAPCOUNT_VALUE).

-- 
Cheers,

David / dhildenb


