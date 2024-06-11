Return-Path: <linux-kernel+bounces-210157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87410904011
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B50B284DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4A12E631;
	Tue, 11 Jun 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MiowAsTF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020201E531
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120004; cv=none; b=nwlbRIKF0D5/C7TZN1qkYZaDU0W6kVVYEfaduqlgstuq/p5Hw4lmPp5YH1Q6ajdmWuXsjLFGP7JcmcfArwnp5MO7y+MJmXKt9Wy9QUx0Ira/oRrsA0Z3fv/gdogYYdOykSGwFjo2VdQalZbkQrm1oKE9qe/2jT2cVAn8rEnLGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120004; c=relaxed/simple;
	bh=79HlnJxeUDJISSO9ee3AxI2/fXYaFI4VVjL2F/KxKoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ8jy2PJJ0FAtYWw+L2SvNrxXnkmHN69jvtxywledrWsoMaOS9wBJqtaOnxI18e0E/BIy9ns0Mg2ta6nm5zv5kHwxdiE5tOdXcIOIvFilwDb+honI+m9vQ9K4kE5XVSyGsE+SQbdeUsFUoQplvlf33KGlE60jvUGZS0ytpzR2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MiowAsTF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718120001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dO3XeXY+JI0Vowo94JdLCb+4j0Cttva0vSP/n5bA6I4=;
	b=MiowAsTFhfrGoMHNxfcm1zaM05nWDZydae2u3n1arqhb3uEl8/pzUW1Kzh7aQjnYb/rCwI
	1GGMwt94QSfjAYItX1lf1ps+oy/UCxDOzwSHa1Kwo8tr+JmPrxWkxzJ6nGT0Khzti8BUmX
	BGYprX9BTLEEtibsmk+1iYsjey/G50Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-qh0xTKD8PFeixvRy0xA72Q-1; Tue, 11 Jun 2024 11:33:20 -0400
X-MC-Unique: qh0xTKD8PFeixvRy0xA72Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-421805fadadso20223325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119999; x=1718724799;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dO3XeXY+JI0Vowo94JdLCb+4j0Cttva0vSP/n5bA6I4=;
        b=KO+7M5NUhmUPfwZ/zOiSLlMWeS/w10J1M9HGOYeXZT1QDJKE4nduTnX9YtE8mF2P9W
         MpttD9F/g25LE+akExT2i600aCMS26y7aNyO9GVeqUqRAq8epE7Urc/v64lLMLVvg2Hz
         o8twMxNnhjuXHoiyyUIeEcwLxg68haNdmj+IO9UzkCNvEcb+7wNA/Vv1h/GjjeZq1HSg
         MMRdYxRQ88X4hVSLDZKB7ZZFkvXKZDgys1yA2zBD4Qmntg3afzeDQnDOj9dIIXRpC8EH
         R7h7rytF6Nu6TDfaceSkhLgWqrtd5Hdk6xnW/OgLBw6N6g8g1yOYhcfufiokrSm4yfrF
         cF+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkiuh8B36dBFr9/5GEW3yNlrRbbvcTESn8x9Fk7/VCB0NDMuqKPxn313yjRoVtiX+ObFI4Cn3VtgsMFL7gy6Nzjm3ijbVsK1jCc+b+
X-Gm-Message-State: AOJu0YzPRNU1bwdu1dzZ50lmV4AYBcdlup1Gwt3lH0Ce8WRhGT9ow2fg
	JH1ZmPrCDllGcFG4fa+bnHLgOEL3TJnqBVWMy/mJd1S8F30tu5OKj25mPiaLBTOx5FMcKdQA1I5
	nawTgR8oSXQVUn0ElyKW3lKEEQ/ZYrfHaGj5S+qQnmm4Gjon+mC4pHYo+5qp33A==
X-Received: by 2002:a05:600c:1f91:b0:420:139e:9eda with SMTP id 5b1f17b1804b1-421649f0f98mr105394875e9.12.1718119999216;
        Tue, 11 Jun 2024 08:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNx0PgiAvDuHhT7ZWTkLM/vclPFjoJSNPZMCxmqUF/QamezwwUKbiwNRUW8RPFKCRqidXObg==
X-Received: by 2002:a05:600c:1f91:b0:420:139e:9eda with SMTP id 5b1f17b1804b1-421649f0f98mr105394705e9.12.1718119998793;
        Tue, 11 Jun 2024 08:33:18 -0700 (PDT)
Received: from ?IPV6:2003:cb:c748:ba00:1c00:48ea:7b5a:c12b? (p200300cbc748ba001c0048ea7b5ac12b.dip0.t-ipconnect.de. [2003:cb:c748:ba00:1c00:48ea:7b5a:c12b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe3cfsm214052765e9.9.2024.06.11.08.33.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 08:33:18 -0700 (PDT)
Message-ID: <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
Date: Tue, 11 Jun 2024 17:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
To: Andrew Bresticker <abrestic@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240611153216.2794513-1-abrestic@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.06.24 17:32, Andrew Bresticker wrote:
> The requirement that the head page be passed to do_set_pmd() was added
> in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> finish_fault() and filemap_map_pages() paths if the page to be inserted
> is anything but the head page for an otherwise suitable vma and pmd-sized
> page.
> 
> Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> ---
>   mm/memory.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f47a533014e..a1fce5ddacb3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
>   		return ret;
>   
> -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> +	if (folio_order(folio) != HPAGE_PMD_ORDER)
>   		return ret;
> +	page = &folio->page;
>   
>   	/*
>   	 * Just backoff if any subpage of a THP is corrupted otherwise

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


