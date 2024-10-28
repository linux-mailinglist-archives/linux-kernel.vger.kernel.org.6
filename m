Return-Path: <linux-kernel+bounces-385178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6A9B337F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191141F252F4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F31DD9A6;
	Mon, 28 Oct 2024 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwJIhHxK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8241DD54E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125720; cv=none; b=gtvdMJVlUifl+Il5k2SsrM/rMxRTeokoH6yD/PHJIPRcttX+JNlHMRZBNCjDRz2Wq1hWbzwvs1QDMBPKzXhhYGl9cnYT4MrBk4v4kEnoC4+o9gIs+xWbUgQwSjkUPc4J06CgIxNshwK+cmuAQjlkskpLEG9TfR6WCxWJEHmewtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125720; c=relaxed/simple;
	bh=ZPvADLPo1CwEKXH3CCsb6bpJ62yDuIZz4jakldxnuOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q35JhtTpFlv6G2d39CvUe0Ii6sGV3380tGaPdIOXz1BzX6eclyowfm3ls3KYzUKSyf4sH0NWWy4zvEnmwJI7rWYJW+/pKblolggDZ8zvpQpmULZYWfsF7og0PL4/WNkHKzKvMwJL8kWw+LVyn1/1lcwRVi7MNTC9+qhUK7EQ5z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gwJIhHxK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730125717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qOy9OG+ZXKuxMPyAv0gTRkCQfW9zhduP0gXBpaCiYWE=;
	b=gwJIhHxKetj5eyXXgNP8ncvoQnPi3vXOsW5x1pbjMt0/3srToqYB89+/wIeyFHh7lSUI9j
	cKEgJCFBy7GuWHZyOuNn1TYOKPy3zo+ONqLe/B9Fb9ZLnyHuJe9VthJljYn6oWie60BWiq
	mIyxOSLXP1JEg/EkSsL7WyqxdXUYKSc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-qZ0DfNPtOsGyqaFLLFVq9Q-1; Mon, 28 Oct 2024 10:28:35 -0400
X-MC-Unique: qZ0DfNPtOsGyqaFLLFVq9Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43163a40ee0so33751255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730125714; x=1730730514;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOy9OG+ZXKuxMPyAv0gTRkCQfW9zhduP0gXBpaCiYWE=;
        b=ISL/YwzdIKTOtlOGfdyvJyK0aZzR6xOUhop2rLcNi2E+ersigtwv74WViRpiHbqLsG
         T6nKZjaUwuVwRLyzmdCdRdsTGVDPdcUVEPAra8sctnT0IUZiP+TQzKirS2QBEPKga/JB
         Ki7Or1ekW00jrRdBzUorVTNu12MMBXbSsvqAea1HzzG4ZWbCjYtauVtxjwKOno5UDqmX
         ymOpsSrrWSZZzh24H3CHOCD5kc2xlfMZN1jPNMp4aHyiSppcGbmZDXuelmRG0c5eA65X
         V5ygBYxeDWmWf8Xuji2HWZEFIvzRL/glf0/YzsEmtjVeZvAzRBoxEYEBoJNJHwarmbWf
         JpJA==
X-Forwarded-Encrypted: i=1; AJvYcCWDmJr4ALyXq+r2GhsfCbTFQZRhLPHjjMYunQEi6ECaf+9Q5st/eyDpEmBI+NVnatSxjvMWYtobuk929Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymzrG7T8CZLUSOEpQxYAXzOJiFJBS/My1JXjbyta56dhgvpUQg
	dxwsllu/5qFwzufvFMxmPVHX1VzuC+0RNyynknj8ZDs3BjpVZYsgnMD48a4M4YJ6nHFO8VOX2YA
	bXBYn91uJn87sUH9lli1i3N2b3jRD6FRoYw0Pqoy7L7+6B1SVOwjj5Z4WTDWahA==
X-Received: by 2002:a05:600c:358f:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-4319ad2cc31mr66170785e9.30.1730125714429;
        Mon, 28 Oct 2024 07:28:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpXBw2a0Pw+D2c3brupRGVgYeUvZ4oMJqKJG/jyeHSqqazjXa2rmebJgCBhvtoTtc2d0XcCA==
X-Received: by 2002:a05:600c:358f:b0:426:647b:1bfc with SMTP id 5b1f17b1804b1-4319ad2cc31mr66170305e9.30.1730125713500;
        Mon, 28 Oct 2024 07:28:33 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f875esm110575925e9.37.2024.10.28.07.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 07:28:33 -0700 (PDT)
Message-ID: <1716d6da-bd48-4a9d-90bd-9e510a42df59@redhat.com>
Date: Mon, 28 Oct 2024 15:28:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: delete the unused put_pages_list()
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Yang Shi
 <shy828301@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.24 21:14, Hugh Dickins wrote:
> The last user of put_pages_list() converted away from it in 6.10 commit
> 06c375053cef ("iommu/vt-d: add wrapper functions for page allocations"):
> delete put_pages_list().

In that commit we now manually iterate over the list and call put_page() 
on each entry ... I would suspect that to perform worse ;)

In any case, the function surely is unused now.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


