Return-Path: <linux-kernel+bounces-188833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B28CE797
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD07281E76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6212D770;
	Fri, 24 May 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha0IML8+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76884FB0
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563583; cv=none; b=JK6TB3ptPTaxTJvLP0fFEsFoUbSmH7CkxEZ6OseFRzOxI3B1oPPt8PNIQdCn2gGldFbmXWstTqkM3Fj5V78Uq6NZgV6GEQUITAgRCxgH8QLJtOb+bZn/opt58/vCBqAQm5DzJw4aNOcEmN0bEYtdNCG9iUo01t4GvPx99z6Kgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563583; c=relaxed/simple;
	bh=aDZobgKcjgBH8x7BP7/Z77aJDtrUfrd5/zvorQSgOVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwjFDtK3zU/EgjgC6QrOMoZV/vewD2nwTX1SbYRvNe9YZagoz4Z8xmk+0zhhz8YhTdJRYOyuR+8XknkWHmEtwSlouWSIPkdUkBYNi8AtbgN0Npw6APwDBZYaiAbtqd4rnQxgEsOf71dW8xgE5ezmoQQ6klYKA7yHrrn1yiGtVjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ha0IML8+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716563581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uB01d66pZUieIsqTZ3UHRU/AROTNpNxlGZSWTOYJbfE=;
	b=Ha0IML8+LVZMfesG8cgAr0qjtO5hmqneVc7XWFxeXcKaPITMKXjfd4STRkA/+IswzQrK0O
	Bb8VR7ZixHZXNZcH2yTbWqGcIDMZf4aqCiUP8FGSYgWZ7vQybDQt25CgeibHx3iYc2m8bf
	DjTPpXKni29ZIUMqIbmhFQuekWbs/ss=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-SfgTs5m0OmG2mONgRhdxAA-1; Fri, 24 May 2024 11:12:59 -0400
X-MC-Unique: SfgTs5m0OmG2mONgRhdxAA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2e95a6565a8so7396341fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563577; x=1717168377;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uB01d66pZUieIsqTZ3UHRU/AROTNpNxlGZSWTOYJbfE=;
        b=lsODuH5fBSCeAHFvCuPToy7aRibehlH3nhaKtVu/6rwjjlLRDGUlf8V8M1SlPjqxbj
         pkGssQgyMYG2d/AcAxQumskFgJGh1hdRs2rvtBL/WRLOYyZraCLuO9PqiRDdOq9S8I+X
         fzVxajgS1kDgtfjnhNHbHZSzPfggz4u6ak+qOuunqF1Oik0p97DMW4w7ASob0oYV/WtH
         i6pclhe8AZoPjl1crZ8YsvaH/GhM5hDtoCCJrOOMkWY3HmZc8860AYO7a1HGxFvl9Rsr
         Jy422sFLqp4qaxrsTYRDhpTLKvOxXvH9wZFmB7jPWqdIsVYdsW8x2mqs/f5Q+H+yZCJb
         VokQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn9zGL5P8Jd7P3quGO7CJIGg5Cj+Y4dxoy45VRVPNxhHlBx+Lhqi2pyPezbk3nplblo/z3LJBxM7+3PZn7zmrEn3uDB93DyHZMCEzd
X-Gm-Message-State: AOJu0YycBIBof3z+/05wyFgNguqgB/oHDA8H2rj9EWp3yMdC0gvpnjHj
	QIflE0V/osAc5MNLt3haOKgUM8S7y97rxpuV2GrTrmae2Yy4i2Br8nBydtYLS1QBvnxRoNVGZfW
	KVc7wh90yOOwBBMlLjYEIy89cwO66eRS9K4BcjOeIF32qlJQtCM+SsZoM3lv6Dw==
X-Received: by 2002:a2e:9842:0:b0:2e8:1999:ad35 with SMTP id 38308e7fff4ca-2e95b1cd5f4mr14348941fa.24.1716563577501;
        Fri, 24 May 2024 08:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZidOSXNGhkbOLkJOC44dWKydIsRAz8H9dGay9x48Y6QAdMCGRXN7Oaq1Smwj5jC3NTsi/gw==
X-Received: by 2002:a2e:9842:0:b0:2e8:1999:ad35 with SMTP id 38308e7fff4ca-2e95b1cd5f4mr14348721fa.24.1716563576941;
        Fri, 24 May 2024 08:12:56 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420fd37d5c0sm36123065e9.1.2024.05.24.08.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:12:55 -0700 (PDT)
Message-ID: <18259f7c-d57e-4504-91ec-90b7c87aad01@redhat.com>
Date: Fri, 24 May 2024 17:12:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm/ksm: refactor out try_to_merge_with_zero_page()
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
 hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
 <20240524-b4-ksm-scan-optimize-v1-1-053b31bd7ab4@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240524-b4-ksm-scan-optimize-v1-1-053b31bd7ab4@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.05.24 10:56, Chengming Zhou wrote:
> In preparation for later changes, refactor out a new function called
> try_to_merge_with_zero_page(), which tries to merge with zero page.
> 
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> ---
>   mm/ksm.c | 67 +++++++++++++++++++++++++++++++++++-----------------------------
>   1 file changed, 37 insertions(+), 30 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4dc707d175fa..cbd4ba7ea974 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -1531,6 +1531,41 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
>   	return err;
>   }
>   
> +/* This function returns 0 if the pages were merged, -EFAULT otherwise. */

No it doesn't. Check the "err = 0" case.

-- 
Cheers,

David / dhildenb


