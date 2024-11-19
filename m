Return-Path: <linux-kernel+bounces-414321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB809D2642
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209331F21A25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746D1CC89E;
	Tue, 19 Nov 2024 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwnhQHFe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D41384BF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021173; cv=none; b=EXGmj5Sa37+3cfclv1AW6MLjDGYBr4VTClS/h/SGu0wwj3WoouMAJwByWqz8J+aRZxE/136Zu41kkYZ1NnF1pjJCHkiFyrOsAVeEB5p16fxbgXORF5ot0+rZf4t6eqshR3HBwRMhJZ+9L811nwlUV1dJv6SGMdwk2CuHHb4ZSP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021173; c=relaxed/simple;
	bh=IN+ggY/XCTTmUI/Awhlr71K+bTuUmuoPfu1jtw9DyRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dRmabfj7nwfbNA0SpvGd9Mw6Sd3erghzcOkAPCGnVBgvX5hcObeFmgOdg0AzIAIAw4g4YKDGGPNU2ABOu6Aof0JTXM4+3K/LDiUei3QImYwjDrgSyJYJDxkXCQ5QqrmO+LZIX8cbX67gxYDUcbcYhnPZMp+99ZsUpqC47sv3fVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwnhQHFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732021170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gVT1g24M5r+wzM+AQBulUo3lI/a8mcLn5gbsVpDtls8=;
	b=ZwnhQHFeZnpZeUJFLm6BVmJD8lGurioqDHlDlXQqi0HOXYiQz2e6PxhA0iNH+JcOnTKX+J
	7E+lRtqmQMB9shVJZ6SDyvEWm5ZQVKjlsqZ733MgDDSrYMl+eHi5OE18krTV7SmejsCY05
	uf4PLM+juvMVEFv4XqiGvw8KBxMasfw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-7K3h62KPMFyAca0mqySJWA-1; Tue, 19 Nov 2024 07:59:28 -0500
X-MC-Unique: 7K3h62KPMFyAca0mqySJWA-1
X-Mimecast-MFC-AGG-ID: 7K3h62KPMFyAca0mqySJWA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38231e6b4cbso2626584f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 04:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732021168; x=1732625968;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVT1g24M5r+wzM+AQBulUo3lI/a8mcLn5gbsVpDtls8=;
        b=orOP25MnvN2646V3BHpUUmkdNlytZGMIsLmSwytLmkKo4ZQZ/H/vF1hTRWuhebZWXy
         EUYRjACUV5pjIYSguOwPXatJOOV9VfRAZDauNmmTMg5PPz3HXjKrsfC5A7ZIj3JGo7bQ
         X8HBCrC7uKd7VaE26enRO7P8NwbNGHP6tXSC+huukGyu6ci4g6iZbbW9oZoKzFeYSMxi
         N5CFE/ltXmgJH8JuvVBkXDhTqlLynr0IjM0a2RzEzjZg3NESa/AbpM1t2uZuarflNgy1
         kmoTYIwMeHjWmsdpAcj5+bUPBM3XblCaRaFADe9SLIFVtTinHUMpHS2WmX06L6CTZdId
         NpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvp4skzoF1aCejZI6NRiGT52IpzxofvSMnLJ6GrjkLy38cJZQnmy/l2GaZcpJWSyxpFfOVuA/OaIDbuj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiIWn06U5x348iHYwlbIX3P1XcyPtlFwuuytl8lIlGrOBpe77
	Hm5Kf7+2Ulv70Xt/9wkYV9QenYDKVE084b1VlWR4SpJMazSoDm8DyfajEWra1Jankl5tMuSoOtu
	IsRoNRfZCV2PLrovTNarqBlA8sXhQ7EUJoTqPqzjFrX1g+6+TR9DZsf4X2RwhWw==
X-Received: by 2002:a5d:5849:0:b0:382:46ea:113f with SMTP id ffacd0b85a97d-38246ea1865mr7446963f8f.10.1732021167773;
        Tue, 19 Nov 2024 04:59:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2DXhegNEIcJ5spc0ntbCBCiKem89Pf3lCVBhdkEHlrw8XBZ8qUqklZ5TMropxQpz/0G11Qw==
X-Received: by 2002:a5d:5849:0:b0:382:46ea:113f with SMTP id ffacd0b85a97d-38246ea1865mr7446938f8f.10.1732021167468;
        Tue, 19 Nov 2024 04:59:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3? (p200300cbc74bd00003a9de5c9ae6ccb3.dip0.t-ipconnect.de. [2003:cb:c74b:d000:3a9:de5c:9ae6:ccb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3824988d465sm5177226f8f.98.2024.11.19.04.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 04:59:26 -0800 (PST)
Message-ID: <5a83683b-9e7e-4583-bc47-2a008b9d3c87@redhat.com>
Date: Tue, 19 Nov 2024 13:59:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove 'return;' at the end of void
 cma_activate_area()
To: winterver <295107659@qq.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <tencent_E213136E4B8D60D984B3095D9C2E2F0FD107@qq.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <tencent_E213136E4B8D60D984B3095D9C2E2F0FD107@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.24 12:59, winterver wrote:
> From: Jiale Yang <295107659@qq.com>
> 
> Remove 'return;' at the end of void cma_activate_area(). It's a void
> function, so an ending return statement is unnecessary.
> 
> Signed-off-by: Jiale Yang <295107659@qq.com>
> ---
>   mm/cma.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 2d9fae939..070399bce 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -135,7 +135,6 @@ static void __init cma_activate_area(struct cma *cma)
>   	totalcma_pages -= cma->count;
>   	cma->count = 0;
>   	pr_err("CMA area %s could not be activated\n", cma->name);
> -	return;
>   }
>   
>   static int __init cma_init_reserved_areas(void)

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


