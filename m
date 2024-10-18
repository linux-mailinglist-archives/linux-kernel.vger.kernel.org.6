Return-Path: <linux-kernel+bounces-371510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E65E9A3C12
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FA31F218D6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854E6202651;
	Fri, 18 Oct 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgNAt2iS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E72022F9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248632; cv=none; b=EnRsYjzuHTFbwvwCBQRK+t6c5yqCX4vsCa+Ei9MsmGmYZiUudwMhpoZY+zGQe98UAH5XsPWWPSOXX8V529unTfOdR2UCTACF8D+W/gF/8DTpd/KNPfBtz+Od8x/JnfWxiaaPONqeU5xGLN2YXtJdbIyVWvg5nXmP3ThuplGVyaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248632; c=relaxed/simple;
	bh=vLwrNSDn5CDvAYJfdeF5uOSbK4yFpug8WuUdxW1LJGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbESt5G6wiqfObjCmoQtv2chX2CArl80ARW0PpI45GDenrBbIDDCGHC6bm17Lv552k+3RqMGMnZ0/wJiBQCBN2HdzJPXNvQ/8HGtDJuql3t148kO4CUFLqytG2ychW2XiGR4VeNQZIDl/p+x+271g/ylCdPPzSCXWbpSsq/1CCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgNAt2iS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729248630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9j32ojQ0GPRUhqGNpYdeTxP58MLjAvuuDe0iHTqFEjk=;
	b=cgNAt2iSfaCai8KbnBGMEV8Fih+3M9tC2xJDw/Mh/fNzMOMzpJqvuX22Go4sPy4mLTBgDi
	l2OGzKIZ9X+oe3xbwM2TDqsd64NNmOC4CMsxP8JDpx3R9CNxhR4rP9oebGTO3WgLqUEexS
	lEHPpTDaSkYj3VDiZThGTiamDtRjS40=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-stDgPCooNImWp-6vulbusw-1; Fri, 18 Oct 2024 06:50:23 -0400
X-MC-Unique: stDgPCooNImWp-6vulbusw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315ad4938fso12613255e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248622; x=1729853422;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9j32ojQ0GPRUhqGNpYdeTxP58MLjAvuuDe0iHTqFEjk=;
        b=CGY0ywCbsDkcxe9mMNinG4nkPVlbaYOQJzuZfwsLEuM6fgnihtoAkHCgI6ctUzY8fh
         IuqgoV5yfpuiY17AfQyln9IbuOtz3A8M7KF061BgAoDBe7Eqdpjdi6dbji+wrc0Q/msK
         3jHE9sx4YiGffBj0DkdmC33iSSgDlwcFsBNmwt9VXwDPEl78fIlGAyFzbHlsrVE/2E/E
         Gk1F8nVMcvUlWrP1hBGQNistWpxkpl22+R7Rd6WquEOXSu2uYwJHG9WSl3Mtvs9C9KfZ
         RZ+mVnIX8V+RLcHoKrMh1pbnkAus37fT0kM1DefzgrTAcXHKyTjjoFXSq/TxaWBAIkZw
         G2OA==
X-Forwarded-Encrypted: i=1; AJvYcCWRhKu0USuoTKJwLgfPs0zQKRJkOhp2ftGKFg07MBnYn6o9Aq3owv1/y7i+Ug7CQYguOSW+3G2zcGh5Ew0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uVqwiO3B9jfBWqneg9jyJ+Wn+Z9YrUiiRmDoA6flhiZbnO7X
	pBuHJuex5QLJooPd2ASbp8oPVuJ1t5Z1mnWgPKHg31R1HDBmtBX3PsOUvYtBCfozCLfLOhlwd2I
	/mBuw2fp7w520HWpXdzrpNXmNd33uEQ5FbI1PlU/6uAPRuqQSMU5jR2XWk6sP5A==
X-Received: by 2002:a05:600c:1e04:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-4316162297emr13409585e9.7.1729248622599;
        Fri, 18 Oct 2024 03:50:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEagPWPgVUAOku8Km4mAY8r4X7/Bukh6/Vv6unuT+/+jB9LmgYA+MOyZgOIWIT3C5VdrnHORg==
X-Received: by 2002:a05:600c:1e04:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-4316162297emr13409395e9.7.1729248622171;
        Fri, 18 Oct 2024 03:50:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316067dd6csm24339675e9.8.2024.10.18.03.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:50:21 -0700 (PDT)
Message-ID: <f6f62ef5-a57e-44d3-94be-d5472d2c55ca@redhat.com>
Date: Fri, 18 Oct 2024 12:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove redundant condition for THP folio
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 willy@infradead.org
Cc: ziy@nvidia.com, ying.huang@intel.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241018094151.3458-1-dev.jain@arm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241018094151.3458-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.10.24 11:41, Dev Jain wrote:
> folio_test_pmd_mappable() implies folio_test_large(), therefore,
> simplify the expression for is_thp.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..b43e7b105559 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1731,7 +1731,7 @@ static int migrate_pages_batch(struct list_head *from,
>   
>   		list_for_each_entry_safe(folio, folio2, from, lru) {
>   			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_pmd_mappable(folio);
>   			nr_pages = folio_nr_pages(folio);
>   
>   			cond_resched();

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


