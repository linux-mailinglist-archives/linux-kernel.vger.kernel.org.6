Return-Path: <linux-kernel+bounces-196638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F00808D5F29
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58DFEB22A19
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301611422D5;
	Fri, 31 May 2024 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQKqoAcS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69CB14295
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149740; cv=none; b=mVWJS/cwQzOTCv2Irpou6mfbozBY44ayNOjeFLw5CK8b8fFkwNay/KtTVb3yCJW5WsSnqTqsMnf7GYHpZzBvV8s2tqUVJNaGEwgA7VmjwLnmBAmUDfl+nZEGBs0BMGQQcGphjtpCBpyFO9d3OcwW2b61xg6HuVUcWBxVwKxaCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149740; c=relaxed/simple;
	bh=80+oZV2Hwc0+u8PDDdgEnVBFWtZUX0L56/jzAaDbVBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEo4zh/GnVZs3mB/lrHYXtf5vrJOzNtT/1P+hSdTFIKshjh0w0N61bdEPcQtPcAtEOTc+w4jciz2dvLNlOhXshVUjqS3meCuN3Ytq79IzcCG+r7qxtnATy8vKyQzqM9YS3VAwq1dPREPObdQhYynKR+AIxyy4vyDcS/wKFlRQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQKqoAcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717149737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MJ04lQJ+GBKpWEjJ+VxNTs5PlYqhFbGa0udLArxovdk=;
	b=DQKqoAcSGKq1St7KGOssc4nCC0onBIefWNjeWFP9styK7xgWWkfE6TyokTyTYb7oxHxxNO
	B0l+3cdxKvxT6i8QGfAEemzneGpPCc0O8QqKM2F1rAYM8tEku9DJKShpsRd173kjebr/L4
	GOinff2NW/GpEkrTBH+As8G16QSsU7Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-InWB4tl9ObmNWZYnWVWORw-1; Fri, 31 May 2024 06:02:15 -0400
X-MC-Unique: InWB4tl9ObmNWZYnWVWORw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dd0cc1a7bso437120f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717149734; x=1717754534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MJ04lQJ+GBKpWEjJ+VxNTs5PlYqhFbGa0udLArxovdk=;
        b=JIm28doziLez/1tfCLAFxCbsh9LSUKEz0g43v6hxqjREBQX+XkAgjerjPMhfRAm6J4
         6lxTjAippIwNPcZ3Q7N08eADerI0SocLHM7PCsTeT/QIyAlEhkZvpNVPnhGlbcXDL6YT
         gEIeo3FXcgQDrsbpF1iE5viG4b3U/mC1KNC/QHZrlNuwzLgk1ul1IRbcULXxnbINKGzp
         DAQb+YLuZMVRJwKH9fc2sJ4NUvcPWtf3wreyr/uj0LiRYCcbW8nbTkQ5nWkGnqyXLIvy
         IdGJE7KDkxRd6y0axx/F6HKl++GQiv1F0EqNI9O6JQgtHLxDjVBGt1NeSSMwO41J24JZ
         rm8g==
X-Forwarded-Encrypted: i=1; AJvYcCXauQBBH5DAAKlf8Aq5vrUAJHRExBWU0dMb13r8qswvTBpTBlnJUcUBeqtn5yF/I7CtkyHQ2BlhRTCEt3NhBICUOU2IhIAANNpLwdik
X-Gm-Message-State: AOJu0Yw54LnIZTY5BaUBKZ4xMpXI9fzhXRQ4eCq9Nuxunvix9hW6A/cY
	q7RezIzgW5QWYRZov9TBECqaQEjbCqQ272zcyCprrEoHrJ9rrzjud78+F9bZr6NGRNhOYohKVyl
	7mdX3YxAOIU6So1+Ep7coo5Mak19g81t8ZWV23dw//fAKPnLQjNgCqk7d6/r8hzQQmK0CVg==
X-Received: by 2002:adf:f742:0:b0:357:3e5a:6c90 with SMTP id ffacd0b85a97d-35e0f36d84amr1071436f8f.57.1717149734542;
        Fri, 31 May 2024 03:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeS5HZkW4qvB1V7nYN9JjTsjl8P5wxpf8txKd3ben3bh4FQXh41fFVj5GVr3OQUJJT77+d7w==
X-Received: by 2002:adf:f742:0:b0:357:3e5a:6c90 with SMTP id ffacd0b85a97d-35e0f36d84amr1071406f8f.57.1717149733967;
        Fri, 31 May 2024 03:02:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:a000:d4df:4b8f:37d4:59e4? (p200300cbc717a000d4df4b8f37d459e4.dip0.t-ipconnect.de. [2003:cb:c717:a000:d4df:4b8f:37d4:59e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04d9c68sm1477783f8f.56.2024.05.31.03.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 03:02:13 -0700 (PDT)
Message-ID: <f073e363-f6b2-41df-84b3-4b2cfa2267a8@redhat.com>
Date: Fri, 31 May 2024 12:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: userfaultfd: Use swap() in double_pt_lock()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20240531091643.67778-1-jiapeng.chong@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240531091643.67778-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.05.24 11:16, Jiapeng Chong wrote:
> Use existing swap() function rather than duplicating its implementation.
> 
> ./mm/userfaultfd.c:1006:13-14: WARNING opportunity for swap()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9266
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   mm/userfaultfd.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index defa5109cc62..5e7f2801698a 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -995,14 +995,8 @@ void double_pt_lock(spinlock_t *ptl1,
>   	__acquires(ptl1)
>   	__acquires(ptl2)
>   {
> -	spinlock_t *ptl_tmp;
> -
> -	if (ptl1 > ptl2) {
> -		/* exchange ptl1 and ptl2 */
> -		ptl_tmp = ptl1;
> -		ptl1 = ptl2;
> -		ptl2 = ptl_tmp;
> -	}
> +	if (ptl1 > ptl2)
> +		swap(ptl1, ptl2);
>   	/* lock in virtual address order to avoid lock inversion */
>   	spin_lock(ptl1);
>   	if (ptl1 != ptl2)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


