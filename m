Return-Path: <linux-kernel+bounces-242188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA299284C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF6C1C2513D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CC9146A65;
	Fri,  5 Jul 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsLSy0xU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979A145FED
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170520; cv=none; b=P2EzBc3fAgCgcK/w6OcHWda+QWuEOFkpXyGcKGeQFx43Y1PKaMI4Z5Cqo5E8KkMtJyngXIHqKtydGXj0l5PWPS5S8etbki+petOj1JHiTrevkEa4jY1wEIBKmFRYhM5QTNFhIZa/g3r/lmJexE3nxv6LtnZKH8Y83sYKNG7+nYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170520; c=relaxed/simple;
	bh=VkOfb4GRFkR3GmdUWintxSIn9XZqSK7bfXDdy2wfc/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbAb1rsVFbGog7HwAi2eqEyXlvHWqV01zX4oCDl8vW8zdwqeYqSBGt4DRJZB9v+/7J+J79ufJaOQW6Z+2CJ4oDrAaDQswh8VvCYfMJ2az2SZrFzxJF8VYTuRdqijS+DqNQI17RsYQaO/VWuyuIygrOSwy43ytMB+SI2/bfV/dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsLSy0xU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720170518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kLSncZW2G47dCrYrw0elH8PWHvRnnZSmTqNmYVPtGkk=;
	b=IsLSy0xUUWy/tWoDbxHOFDQoo4Blr4PgjxsZ45GdOR/mKyiZRuN6nunGpXdMthtmxeHkRl
	N+Mybhst90VjxbBrleiW176TTm5UhOtUR3x4fRkf1T4Li6zeWYbcdMdea3q7LWcG9ae6Sw
	3LP3CPBk6Ok72yx7+FPdpP8eswCMDeQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-9eF7u3VKPWCDK_vFUcoZHw-1; Fri, 05 Jul 2024 05:08:35 -0400
X-MC-Unique: 9eF7u3VKPWCDK_vFUcoZHw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ea4178bafso711086e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 02:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170514; x=1720775314;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kLSncZW2G47dCrYrw0elH8PWHvRnnZSmTqNmYVPtGkk=;
        b=sT/kH49yIBMBrU5wh+fk3V1AGQ54alZ6WGijtiyTbQGzRsqo6I8VfLnCB8T12u2+RO
         hntak7Z7LsXIBdqQLqPdMGsYzm7H8peQoEzkN7glhMZav7sQD2+CKdFicj9VrW8FuY7K
         opJjo2xiUtxxCZq8U1YXq1GmHlyW17HAWUG2Xb39j8C+3tsG5lUYVt2YPorXv4+NobeP
         WbK38H7A2O8qBlLeRdFpL4sTZVapQSZXW235d15DVqgQJao+7Mt3wVZJpq9OevB2OYEH
         lbgsHHdTCaZNIPDZwE01YK4uivYizU65cEkG1FqdQAmlPjyWN9b0UZ0whchsyQzhZC8C
         2suA==
X-Forwarded-Encrypted: i=1; AJvYcCVeDhOff0inSgrgV7TGOz2FQiU8zP56bmWMIrv47pektwhoJonqSd9rCPXR7w/Ht3uzX1F+v7ztPRPHO9GvtafwGyghAQ6lOaayQG4A
X-Gm-Message-State: AOJu0YwPvpAMDL+gJyLOVVmMPXvmykN2p2CEu81vHuiqKabRYTxR4dWK
	QjT5X/GUQcAIarrh1E1rMEVEjU4qSe9JaOrJVdhZmMmn0ln3jWKxwyDuMHjmCXkVzMi6ev8m/Gw
	e6gu1ZC7MzobUlRabV3yMmsbY2yMHot/PE4EjgBYQ4feQtBXw2jbr3xUsm7rf3Q==
X-Received: by 2002:a05:6512:3c98:b0:52e:a60e:3a0a with SMTP id 2adb3069b0e04-52ea60e3be2mr1192761e87.2.1720170514418;
        Fri, 05 Jul 2024 02:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAoAwUORgLXzI29Jn7/prnFy2lTBG1PmjslR57Y6P0FC0SYvvTAA92CwIBmUODU5uxxuWjOQ==
X-Received: by 2002:a05:6512:3c98:b0:52e:a60e:3a0a with SMTP id 2adb3069b0e04-52ea60e3be2mr1192743e87.2.1720170513944;
        Fri, 05 Jul 2024 02:08:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:b500:3ed7:a1c7:447e:2279? (p200300cbc702b5003ed7a1c7447e2279.dip0.t-ipconnect.de. [2003:cb:c702:b500:3ed7:a1c7:447e:2279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca5casm53422175e9.32.2024.07.05.02.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 02:08:33 -0700 (PDT)
Message-ID: <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com>
Date: Fri, 5 Jul 2024 11:08:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: dj456119@gmail.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
 shy828301@gmail.com, ziy@nvidia.com, libang.li@antgroup.com,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>,
 Mingzhe Yang <mingzhe.yang@ly.com>
References: <20240704012905.42971-1-ioworker0@gmail.com>
 <20240704012905.42971-2-ioworker0@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240704012905.42971-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>   		i_mmap_unlock_read(mapping);
>   out:
>   	xas_destroy(&xas);
> -	if (is_thp)
> +	if (order >= HPAGE_PMD_ORDER)

We likely should be using "== HPAGE_PMD_ORDER" here, to be safe for the 
future.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


