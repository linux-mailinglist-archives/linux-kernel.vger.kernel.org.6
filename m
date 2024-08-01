Return-Path: <linux-kernel+bounces-271007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ACC944847
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BA71F23032
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E029616D327;
	Thu,  1 Aug 2024 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUExsWF/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7251607B8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504533; cv=none; b=J4CmXnZIeBfDrg9jAPtQwAOkMa5yG4FiYXQFJH2hTbzWEpncty+awzhCP1HRGD06VzPvMGcmzJVMr9V0Q/h2fOaRWM3RCez5woWI4gslJREAibx8KDKUaGj7rtpFK9lumgE9CBiQ1/oWjU92VTx+ZjbtSi4XiwBFQ9M0PgpZTms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504533; c=relaxed/simple;
	bh=fLh3nXiTZ79SrnXDwlxK1nph+PqB1c8nmjuKc2yWJaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoqK9AutTgRSb5i6ZKy5AVPN3dkWrfY7O2QWyombbnNHRH1Cun2Nf67t4SKIvCqBeIsgRFL4TCWuXKcV1cwBpNA+lRnBU1DfwCMYYdCGG0ouQwFrOYSLKipbxOK28lht1Hg7DADTtnPJfo1LmRWUU9i81CpXAMk41EM2d+x7rxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUExsWF/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722504529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zHpp359X9k0N0Pwsm/JB02XcbstIh3/H6VLDG6eFvUw=;
	b=FUExsWF/Lv04WCAkkhc2Dh+UXwsogRvonDBwIdBSz0O7WnHisOlI8AaqIbin7vbdjriWGn
	BYdqK2WmCseQvPkYb+yGaWYAwd0fo5SlJoCaUf+tr7wazHJH7Zr5KWF9+eWJoL/p7LLqem
	qLxLiWSWAw3uqXagoxlj1kiXNfqIiA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-CI-tlOsPMnWKvbGopm78ug-1; Thu, 01 Aug 2024 05:28:48 -0400
X-MC-Unique: CI-tlOsPMnWKvbGopm78ug-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-427b7a2052bso62514565e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722504527; x=1723109327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zHpp359X9k0N0Pwsm/JB02XcbstIh3/H6VLDG6eFvUw=;
        b=F/Gwx/O19fz/5+83WeKuJ8SGjAdSmhqKFea/HItE227HIzjPM3FmoNiDEt73xDINMG
         Ra+oB4U6B5ZUkb5CwCmMxpljOuoBQFeUEydYNAq0haYebnk5PzWMPG24wG8j0ZT8i/X2
         +qjkV5WtWDVvNjCdbiEV6H437au5U731tNtfchJETJaF2onR3yiFKntPFwXQWlmnxsYH
         jcv7yK16GwxbpNkUEnL2TPgTSIta14IUlqQX2ETgv73R4Co5XwrOrPM1LIsvuWs2qsG1
         wiiHRLV/j2DxKNjQGirfPq9qQK0ClwtULc/A+1/Leh/dSQdacVDNb8bJfu6GKEEBmQxi
         YMMw==
X-Forwarded-Encrypted: i=1; AJvYcCVoCI0ZSi7S+bCWdS++jxFU1cK0jtuOQJLPs3rcBWU0D/ALILg0SmORQnj7Ajh+ZhjujlLRXO+W3LkIvybctUdut50CpojfRHMGGgx8
X-Gm-Message-State: AOJu0Yy70kVHUbJPymxspyNpyuiphSLkQqb655ROoDb9qCRcEVZyEZbZ
	9vb6lFqtfRiu4oTMtl44zysPYSZAxOsuyOn9y03poLbLHLVXdDkx3vpiJ3pSp6vkjBOPbmp7STN
	ZnHQoLec86io0jk3ByAWq23lnlIlVxdyPZMogJgatKwp5jLcUTvUi4/gH1rQaNrjPkiE9mQ==
X-Received: by 2002:a05:600c:1552:b0:426:690d:d5b7 with SMTP id 5b1f17b1804b1-428b8a1b1cemr18663225e9.25.1722504527068;
        Thu, 01 Aug 2024 02:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpSauY45TG3d6gUSUvXBj9ZIpLCRWrjG1X1kDugKeupuCGkfRbZ13T7CuZwXK/ZlTtxir94Q==
X-Received: by 2002:a05:600c:1552:b0:426:690d:d5b7 with SMTP id 5b1f17b1804b1-428b8a1b1cemr18662975e9.25.1722504526513;
        Thu, 01 Aug 2024 02:28:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:5c00:e650:bcd7:e2a0:54fe? (p200300cbc7075c00e650bcd7e2a054fe.dip0.t-ipconnect.de. [2003:cb:c707:5c00:e650:bcd7:e2a0:54fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a251dsm50341745e9.10.2024.08.01.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 02:28:46 -0700 (PDT)
Message-ID: <cf840d88-389f-4846-9099-798a47c11e5b@redhat.com>
Date: Thu, 1 Aug 2024 11:28:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: Change the addition of totalcma_pages in the
 cma_init_reserved_mem
To: Hao Ge <hao.ge@linux.dev>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20240729080431.70916-1-hao.ge@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240729080431.70916-1-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.24 10:04, Hao Ge wrote:
> From: Hao Ge <gehao@kylinos.cn>
> 
> Replace the unnecessary division calculation with cma->count
> when update the value of totalcma_pages.
> 
> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> ---
>   mm/cma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 3e9724716bad..95d6950e177b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -202,7 +202,7 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>   	cma->order_per_bit = order_per_bit;
>   	*res_cma = cma;
>   	cma_area_count++;
> -	totalcma_pages += (size / PAGE_SIZE);
> +	totalcma_pages += cma->count;
>   
>   	return 0;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


