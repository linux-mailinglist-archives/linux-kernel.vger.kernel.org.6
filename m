Return-Path: <linux-kernel+bounces-404646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 102139C462B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C431C286E45
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4321AAE1B;
	Mon, 11 Nov 2024 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InJPxOgz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388C15699D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354712; cv=none; b=O6zDL7Gy+IEMQ+kMjoEIG9NgfbgZSwi/Yaz1UxzvHPs/zBbDUF5ltsIBXJkjclCmPWzc7VW1IiAO0gGb9vaWouNSA9O72pBoySiFr8ZoH78iHV4mM5FWLSnlODkO9+XcMMlT9dSJOyF+inffk0BTOXpS7MhOeR7ycocD4NRbNKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354712; c=relaxed/simple;
	bh=Ginp/Aj3fpyekJ57u5EWYN684ZGzrIRyJjoPahOu5NU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZuH7OpehLs2RULo3yOKRPR49in3L1XyWXEE5bhb43MCjy6n3TAp5J0yIsiAx4ujUTptDB44WxZhrHD6en+OW2CL6/9Uj5eWnO9PwklTGTcD/AbLLlNzcP6EYj9oWVEXxjYZ2YPJ2L7F/TRz7pg9BW6uu30FMxXss85G6w/A+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=InJPxOgz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731354709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cxkp09Wn6xOqNmAsLyuA2bs9IEHpbeHvn+LarSYd7M8=;
	b=InJPxOgzsiMjwajGx8DHYehot3bXk2Cxcn6RR9C3ETok7Ufrcfv0KMlLXD2dJsx4h9DAk5
	C/5Eb2YIm0vVknoB/adpDC7IG/N3lQyX8iBxk8YSWZX/mnO2TTLl4MpXchRu0purrcLm4v
	dWSnfutFdxdleJst9kyrfyCtN/HL/4A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-HqJ-KjhWMFW_fmQrlQoLuQ-1; Mon, 11 Nov 2024 14:51:47 -0500
X-MC-Unique: HqJ-KjhWMFW_fmQrlQoLuQ-1
X-Mimecast-MFC-AGG-ID: HqJ-KjhWMFW_fmQrlQoLuQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43159603c92so34255515e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354707; x=1731959507;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cxkp09Wn6xOqNmAsLyuA2bs9IEHpbeHvn+LarSYd7M8=;
        b=rA5v4F5+mn+fcXmC2zc71y0nrGYGymJH+nYm9ICf5NqRr2SD3rIqcgWB8XiJnh3E+p
         FH7KMeQkfhf6DchyWJsmIP7GaV9xYnHsvnxEbtoQrJ56CwOUvc/zKii2AvThOm5s0wma
         cHCqNFaqGwJM/JeYtk62YS0XsbyDajDslBdMt6DsxRLSVL1pz/etJyw5tHXb0xerjJYZ
         mV4OmHUUtMc92ykyDRz5WIlAmsH59N9can/eOyJkso6Fm5GtWxpAiQRpbBL+x5IuTt07
         /kfoRMYMrABu4OOsaln5btdCLWFEbb8anP0MbQXh9EOlJNkFXYSkHvlni4iVzfoyCrb+
         WtYA==
X-Forwarded-Encrypted: i=1; AJvYcCWJrmkQQ84YBzdmqlsUtAu/mlK+Vqa3dy3NCyKGi/HQisGfvGHkdRJ/Ry6beDadkZ7Ii6caNpSPb/m3frY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi6qrmnzXiLP/0dbPkn0pfO0Cmf/pJtwzKX2kYZKjBQPFZmIQx
	xS9PYYZaBMBqhf5v1r0kDKvXJNTXy4bq6INvTODjzbdfGeqR85Lnv6L1YFRSSYgbjNy65w6uT0A
	91uwi1UdF5HzTl9vlpGtf39B2JHU7QBzh+ifpqJyEkP14Xv80AwuGrcKFT8wwqg==
X-Received: by 2002:a05:600c:46c4:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-432b75031famr119885405e9.8.1731354706750;
        Mon, 11 Nov 2024 11:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP9RVZ1kNZ/IBhv/CWvkVmEuo+FVjt7CB9tKWAyy/O5wR+vlyuuD+hH5TPvQjBnioIekuhSw==
X-Received: by 2002:a05:600c:46c4:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-432b75031famr119885205e9.8.1731354706416;
        Mon, 11 Nov 2024 11:51:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2? (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de. [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970d89sm13972099f8f.8.2024.11.11.11.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 11:51:45 -0800 (PST)
Message-ID: <17bb7fe8-c859-40e5-8ded-be343196880f@redhat.com>
Date: Mon, 11 Nov 2024 20:51:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: factor out the order calculation into a new
 helper
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1731038280.git.baolin.wang@linux.alibaba.com>
 <d3272b090b4f6fe92457d487c7b9f825ba72c1b5.1731038280.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d3272b090b4f6fe92457d487c7b9f825ba72c1b5.1731038280.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.11.24 05:12, Baolin Wang wrote:
> Factor out the order calculation into a new helper, which can be reused
> by shmem in the following patch.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   include/linux/pagemap.h | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bcf0865a38ae..d796c8a33647 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -727,6 +727,16 @@ typedef unsigned int __bitwise fgf_t;
>   
>   #define FGP_WRITEBEGIN		(FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE)
>   
> +static inline unsigned int filemap_get_order(size_t size)
> +{
> +	unsigned int shift = ilog2(size);
> +
> +	if (shift <= PAGE_SHIFT)
> +		return 0;
> +
> +	return shift - PAGE_SHIFT;
> +}
> +

I'd have added some words somewhere, how this differs to get_order() 
[calculated order might not have space to fit the complete size] and why 
[avoid over-allocation].

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


