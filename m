Return-Path: <linux-kernel+bounces-449135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F49F4A59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74903188F8AF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A0E1F03D5;
	Tue, 17 Dec 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIohFbbu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602B1EF088
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436540; cv=none; b=Z+03anF0ShkQbwzNitqZk2s4uD5CKVCBQ6kgLeNWnp0D390dwdUG7hC2wZdk9LNLJTlX1w05GtzWZth8XJrbttlC+IIQaxVz2mALJyJlcoZnGt9Jq9R/iPdSqnn3Hikk4NLXyMhYu+RDNb+Ni1P/cYwaJ7qgTlGftRKaxAq3two=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436540; c=relaxed/simple;
	bh=Gtx92NWXtla/g6fR5MyaWGb8lx1uqob3FhGvYDUMzTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbiDYzdkbuuYKiD/sqnV9Lgyfj6Q3uTZjjVhow3zGerEtRyF1Tk5ootAFZhkEtZEWR+Pj+KAXVVJxA3eoM6jMeWfR7+fMt9ykb/w/9fOi4H2+ro3AFlJfIvnNKczRND8d1/wUzsdZsHgPJuTd9+E3mlTJ+lh9reprL5EgI+xRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIohFbbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734436537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kEwDrlCbBrUk54g8AGMOmgZCLUfa4o57y7xkE6nDk2U=;
	b=QIohFbbuCKitEXRMF5ZTit4QZYmTjU97tQ1azuyvAsaXFwaIIWpTUTlxJmu+/BiDC+iTL+
	OJNWrPC/2L4IjmaJsXdNY6/pMeOgSrNItlHQjLUodZuZ3v2bUzjEyqfEYAp9HmE7MB+I6A
	5TRPgbaVeGp6S5Eo+UskLgVzLD+wVOY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-80ptpcABMBaW-903torj9A-1; Tue, 17 Dec 2024 06:55:36 -0500
X-MC-Unique: 80ptpcABMBaW-903torj9A-1
X-Mimecast-MFC-AGG-ID: 80ptpcABMBaW-903torj9A
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361c040ba8so23262995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 03:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436535; x=1735041335;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kEwDrlCbBrUk54g8AGMOmgZCLUfa4o57y7xkE6nDk2U=;
        b=wzRIss1ErlDrNLMIOx3DTclll2IHIb/Rz561rC3JtOWsT7TfALmxR+KLpc9cvCO0vn
         29usvtI7+qzfI3Bk2WDDDE8rZiIPgBjyK021h8/kXXlH9G10czdswBXFMiAz5Sr04z91
         Puhb4m1Z3gzRULeMSMgmp2CZNPtRPj1oVd1t+5yUaBSSiObRCcSzwxEcA46AZ9tOwFn2
         MgVn5jEYiNK+bL+t11iZR+IWrEOvvsbyRgxVWB9bx5Loo4x8CLcxwbRloSEq8pyYTubo
         qgtpFGu9P4RQb6Lv5TGcXe8xhgx5NDRR3TZXUwui16FVlG9gBqRJdmax6RHJAG8ybXcJ
         v1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBBCUiXm7782i7XCCRxrUrwhKKjwN0tEnWTT1m2AUBwOrq5rZrjCLo+xz5ilBgFTW9x4sdFIgn2Hj9bMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXFaoeZXDl9TYi498YDml0fOIddDFVTa3qri2bryt5b+b/CFb
	zP63hfSD85qJ2NrSqwzIPauNk7EmQima5P5nc/Tb0iPFIXoahs3KZqd5VvULPiXfJSvMjmYqhOF
	57D9/EjrbFB7JWpjq7dsRVV9SLvHDyAlUyPiGcLuezUBES++C0bF0vzncT0bosw==
X-Gm-Gg: ASbGncuQQs4Rvy425Mvk8DFl+i5XsLNl6HexIDEoBIPUZWbi6AU1Nptip7F6iXAKqlS
	CcP8zLguNvBLJn8vAQxePe0Eb1r9Gqx/FGaTqEML7DgkrufTiYDvGuakcUg5fjk6WRwO2BNfkXV
	G7xL0faOLyi76ANOPmVd0G0YVoQC8PV2Tv5a50j/Zpye263kGCNNQ5qRsOnGYhpn3mmv70+fR/Y
	I7kL5LJLInqmMYlFtut7GX5DVZgLw2RTssQHbh9rgo6JP97CiiLsCxs2tdu9YXzFCelIinMlLH9
	o1VMLzHbjXBUZnc=
X-Received: by 2002:a05:600c:4ed4:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-4362aa589f0mr153696675e9.14.1734436534789;
        Tue, 17 Dec 2024 03:55:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6sxdAZ6XBiw99mjzJly9HuRexehQ04HevRYkMrPE4HIzit2jWTUMadhwxDN+GRKye3S2E7A==
X-Received: by 2002:a05:600c:4ed4:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-4362aa589f0mr153696345e9.14.1734436534440;
        Tue, 17 Dec 2024 03:55:34 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362571776asm168383885e9.40.2024.12.17.03.55.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 03:55:33 -0800 (PST)
Message-ID: <c9e45248-089e-4041-8f7e-98203a0831cf@redhat.com>
Date: Tue, 17 Dec 2024 12:55:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
To: jane.chu@oracle.com, Liu Shixin <liushixin2@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 Kenneth W Chen <kenneth.w.chen@intel.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Nanyong Sun <sunnanyong@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20241214104401.1052550-1-liushixin2@huawei.com>
 <a4e938ec-ed63-41bf-8c5b-a3697a0fea04@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a4e938ec-ed63-41bf-8c5b-a3697a0fea04@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.12.24 19:33, jane.chu@oracle.com wrote:
> On 12/14/2024 2:44 AM, Liu Shixin wrote:
> 
>> The folio refcount may be increased unexpectly through try_get_folio() by
>> caller such as split_huge_pages. In huge_pmd_unshare(), we use refcount to
>> check whether a pmd page table is shared. The check is incorrect if the
>> refcount is increased by the above caller, and this can cause the page
>> table leaked:
> 
> hugetlb and THP don't overlap, right?  how does split_huge_pages() end
> up messing up huge_pmd_share() ?
> 
> Am I missing something?
> 

If first grabs a reference to then check if it's a THP. So we can end up 
grabbing anything temporarily.


In general, we'll have to be smarter about what we try grabbing, but 
handling races for now is tricky.

-- 
Cheers,

David / dhildenb


