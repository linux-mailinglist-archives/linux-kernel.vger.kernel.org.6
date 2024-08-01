Return-Path: <linux-kernel+bounces-271020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467CF944884
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7A121F2800A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53079184533;
	Thu,  1 Aug 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QdWY0r/n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472F184536
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504808; cv=none; b=QVGuujLLkWDQDXjK0rVu1qPO8ry8tAv+X0HADz0EpkyBmMePy07ovs7E1ePDM+Um1He+/dGU4ZnHPt8z/pYCd43wENJNNaiaZSq7HZnzgiiGXF2PchuKDh9XD365BmfNTSTG0kcq2EbTi783jpjClhsH8y244XaemA2kbi8+tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504808; c=relaxed/simple;
	bh=qoHo9McR9z6BYuAyhnqNZe9ZuEOxKD6jJkFnnUJKXzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q380AUlSeURwPP0q0mmpaGxksXB1L4KD5vq33wbquLJIH5NckA6NFfvC8xB/Wh/9W6XGXdXro94E4XtCv7k/kRuLUuq53O6aJND1e0kuiy32WS22jaIMyXiT8basRrzKWPQvCrkvLSI3DjSl/oCAC3MTcs8k074oltCKq4ejugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QdWY0r/n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722504804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sLXqfsBH+7KyNG7/uuZi6mautKAwsxhIgQaoMiRA1p4=;
	b=QdWY0r/nDjdKPIE0ySmPz884n+9JYiM6/p9qfWyRLjsrUoyNB8DdCeJ4JH7/bL7a+NTz4w
	oYtGgtGg2Mi0WQnUbcwm4374ooQv4fsYseLwL/GixQV94oH8MgS24rLv/IsTxxbguS//3h
	OVaXnVhhJclgxOSFnkAR/ybLtMoi/cc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-miyP_QfQMGOgfwqCMjVGKQ-1; Thu, 01 Aug 2024 05:33:23 -0400
X-MC-Unique: miyP_QfQMGOgfwqCMjVGKQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-368448dfe12so910943f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504802; x=1723109602;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sLXqfsBH+7KyNG7/uuZi6mautKAwsxhIgQaoMiRA1p4=;
        b=L9r6zaWMszPWF2zpTDlMwvuXzoI/bLMvJXJv2DbHPtty7azDSeyC5fcHrWIdS/ZZ3A
         kQ1/L3eK0gXvl6SOPJ/KIuDfBwHpDbieEiz8Z4pMrsITNf9HF0dM7Ik6+3F8Yi1Kz3SW
         +IEHEf/C4v018CZ9IZ3OzkQEPvSqmZb2KMPDJ4OPgojgXrinR3UqiljJUT5UQGERBX8X
         vlEFvHU4/Sx3+I8JhWYQA2mqoHW05F2KLdIxh7Z6tlbxJ3drQ/sx6Z5dS0HSzY7JgBTJ
         2FHlk045A8z3q/8a7N5m+ixvwj/4H/vDvZrM1h8AMee8tpRtxcYNGuw4+0t8dD8yxbHj
         GwCg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXrGxNe6nvDN8Wa7BD9bq8QxJsC6BFvoRayMOG/1CKTF7JfEvjffLQRiqSwXqKZRC/oERwGCKpu/6Dr6a4LE7eyx1qAudUQdMbWIJ
X-Gm-Message-State: AOJu0YzUcLJhCdtJJxjQRjA/sqSnURpRDRDxuXWc5zsTKSnAL8yi2Nos
	uTnggF1EV4EEDPF46tvcI2Msms72O65JQskxAbXNZgeCu/i9YmFFclmXvqj3pRwSDlteiUG//xC
	fiQJJIFXmiYrng3kkyJwhSxT79I2/NlRXL7Y7oCCzQXctOLgEaiakMgZ0dbgXXQ==
X-Received: by 2002:a05:6000:144d:b0:367:895f:619e with SMTP id ffacd0b85a97d-36bb359d1camr815772f8f.11.1722504801994;
        Thu, 01 Aug 2024 02:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/heK2udYQw8AV5R+mx/dv56mwC6hCjVhpsvhsrfIylOeKjaFuFUQERaFi7WvrnS7oyxE4Wg==
X-Received: by 2002:a05:6000:144d:b0:367:895f:619e with SMTP id ffacd0b85a97d-36bb359d1camr815749f8f.11.1722504801549;
        Thu, 01 Aug 2024 02:33:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb6405csm50737225e9.34.2024.08.01.02.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:33:21 -0700 (PDT)
Message-ID: <01e36e70-4e3e-464f-a14b-57a892b07f61@redhat.com>
Date: Thu, 1 Aug 2024 11:33:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: test_hmm: Use min() to improve dmirror_exclusive()
To: Thorsten Blum <thorsten.blum@toblux.com>, jglisse@redhat.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240726131245.161695-1-thorsten.blum@toblux.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240726131245.161695-1-thorsten.blum@toblux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.07.24 15:12, Thorsten Blum wrote:
> Use min() to simplify the dmirror_exclusive() function and improve its
> readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>   lib/test_hmm.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index ee20e1f9bae9..056f2e411d7b 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -799,10 +799,7 @@ static int dmirror_exclusive(struct dmirror *dmirror,
>   		unsigned long mapped = 0;
>   		int i;
>   
> -		if (end < addr + (ARRAY_SIZE(pages) << PAGE_SHIFT))
> -			next = end;
> -		else
> -			next = addr + (ARRAY_SIZE(pages) << PAGE_SHIFT);
> +		next = min(end, addr + (ARRAY_SIZE(pages) << PAGE_SHIFT));

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


