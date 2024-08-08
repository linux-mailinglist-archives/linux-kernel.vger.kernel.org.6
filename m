Return-Path: <linux-kernel+bounces-279808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7570D94C216
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328792824C5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2518FC93;
	Thu,  8 Aug 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WudtNyBp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B318CC0C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132539; cv=none; b=Mkl/Gvqyay03qxbkKrDwY1zZSK3e7nPA1NzFHnjCB3qg45tAExshJ99qRUv5292GRRBvZeiEVeKzozsSAwqKb5zLlRcDxIzhMxNw76nWNv4cPKqbeDV3FVIsSWDxoOjlLd2ymhIxwqii4Xeykfm9BIPxGNJjm6jbp/1kpGeNKMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132539; c=relaxed/simple;
	bh=hkUN0tL7OPFhLRCTXMeLFN0WoP3v55qIupj1WtHHn8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S428wybcZTtQME/hLikRDQmqfMGFRw/ieacc5uDvDik8dyu9VkjEOug8bvT74aXQrern4gDN/2AKKtCOXm8G3NQKfs4U3RvDpBYIa8HF3wOLV8SaXCUkqMTq/M3T1aW6UOc0F4V77GZyLuuzT6IBJdMzuv/z5+3aGeMwRYzb3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WudtNyBp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723132537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KjIwb0Uc1j0HJA7Fw0hbZnOMCfIVEyhwBtCs977xA80=;
	b=WudtNyBpCgjP4KpnPZ04oESJwwhmtJe/e+TvH2CApU01y7tYAY46Z2e2IoQtNyPmGtyTcR
	bICXgKdQAvCvHIRxCUSrOHLH14vM/drmIRzM0BtGNVefjDAR07Kzq91wj7QMGNjbwqutW0
	liF4IchSsuHDxo1XBMC7HoBs4mWRuHU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-qgrPqj_rMRePDsaqvyIksg-1; Thu, 08 Aug 2024 11:55:36 -0400
X-MC-Unique: qgrPqj_rMRePDsaqvyIksg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428ea5b1479so7680725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 08:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132534; x=1723737334;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KjIwb0Uc1j0HJA7Fw0hbZnOMCfIVEyhwBtCs977xA80=;
        b=hs8lZrs9ee0I4Bee3xix7cMNcUzcDlwsBdhCl7CAQ5rUCBCT6S2/K3b7pqt6QFFeCS
         fe8aquiwhJ3TVNwqCcuVqt/55qNVvVyQc4CQMFgDuxDGmu+E5wLVP/C8JHbN/FDxKM/Y
         ME7pysQrTt5i3DlTQW2aTkr8qWRvk/7/+MtEeBzPW1nFcrJKIcGr0mbltUY5kV+jrnM7
         9Tp523OnVyYim0NGpErEl064C6eaWw5Xp0+RALoagRI7m9nO6dQWpOxrz5eXXTRjaca8
         8rmAPveVG12cCtEueTVv2uWQoeZQXKySjBf8F6IzOXxLj0HQsTBPWMlPQ45L+3MwRlih
         tnbw==
X-Forwarded-Encrypted: i=1; AJvYcCUJiZPowwuHqCuMA4QYqzDMRPFE8ADRBGeM0yXGsraEJd2/TvYuS7c2JidptQp7atOik2nGvwnNFSxe8Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjHi+GwG+LZuwUskeqIOW4fY4+ZVgNFxwkH4AAEqrMwxgOJYuv
	JBp3nQII+laayJ1x9gdKafujhnTLqhbyNUgVu8WHE5AXdPjO3tAFSHFSowMsJaN133/gehYSPJI
	uOVKIRJSjMs/Gjb17XHu6I1+7Xl30XmT+HSlK3EW3G/8KMlIE93xUO9ifRCEsKw==
X-Received: by 2002:a05:600c:4f0d:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-4290af3b106mr16758545e9.27.1723132533660;
        Thu, 08 Aug 2024 08:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhNoWAFNR0DabW+dWwylod88m8pIlx1WeTwbBqkqq01maSS8UThxumnXGIDxIu2Z/tjZLgDw==
X-Received: by 2002:a05:600c:4f0d:b0:426:5440:8541 with SMTP id 5b1f17b1804b1-4290af3b106mr16758195e9.27.1723132533170;
        Thu, 08 Aug 2024 08:55:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905991434sm82833915e9.30.2024.08.08.08.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 08:55:32 -0700 (PDT)
Message-ID: <5adb120e-5408-43a6-b418-33dc17c086f0@redhat.com>
Date: Thu, 8 Aug 2024 17:55:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] mm: split underutilized THPs
To: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, baohua@kernel.org,
 ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
 cerasuolodomenico@gmail.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
 <20240807134732.3292797-5-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240807134732.3292797-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 15:46, Usama Arif wrote:
> This is an attempt to mitigate the issue of running out of memory when THP
> is always enabled. During runtime whenever a THP is being faulted in
> (__do_huge_pmd_anonymous_page) or collapsed by khugepaged
> (collapse_huge_page), the THP is added to  _deferred_list. Whenever memory
> reclaim happens in linux, the kernel runs the deferred_split
> shrinker which goes through the _deferred_list.
> 
> If the folio was partially mapped, the shrinker attempts to split it.
> A new boolean is added to be able to distinguish between partially
> mapped folios and others in the deferred_list at split time in
> deferred_split_scan. Its needed as __folio_remove_rmap decrements
> the folio mapcount elements, hence it won't be possible to distinguish
> between partially mapped folios and others in deferred_split_scan
> without the boolean.

Just so I get this right: Are you saying that we might now add fully 
mapped folios to the deferred split queue and that's what you want to 
distinguish?

If that's the case, then could we use a bit in folio->_flags_1 instead?

Further, I think you forgot to update at least one instance if a 
list_empty(&folio->_deferred_list) check where we want to detect 
"partially mapped". Please go over all and see what needs adjustments.

I would actually suggest to split decoupling of "_deferred_list" and 
"partially mapped" into a separate preparation patch.

-- 
Cheers,

David / dhildenb


