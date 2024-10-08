Return-Path: <linux-kernel+bounces-355237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAE8994D92
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443C01F21B5C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3BE1DED4B;
	Tue,  8 Oct 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcAkuCaK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B61DE4CD
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392791; cv=none; b=ByB3HGIPLAyyyjKlxB3hp+99A2+d8YFX1AwaD/JAT+2epaXL9Ovjk6xVJEHEFfBbVPn+x3k9jROP1zjpPxoI9obop8CEHHGxJQ5a4W3fYoELuP+F+UWk7heEzgfZTL1a5vdgVozQcDxAIjVEu91sCRjcpCUNMRwFbzfEGKHIFD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392791; c=relaxed/simple;
	bh=e/RzCpNaK+NmmR6NN9uItRC8Ly48169xHDUkHFd6fXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wpma3xYmL2BMir/iRBDD46QSKQPIBptfEryVEJfjx5VcuqOu49jFopQNdosPzwy5d17DsUG8r/Jo+vKVPkQ1SHCUhF0Dd532ZXVTAoQevrlf85JCIFzhC1V/7KT9uS7tyl3HWB9cYMLsnk1hqcBpccoi28gTZsQrjJJ/d2nhYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcAkuCaK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728392788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qR1UZ3ptlV1Q3PKNLC/ya1lH+GCtB5j8K5Uybv88IhA=;
	b=ZcAkuCaKeMUmas7KzaiztQUN3rhIvY+IENTU03aJGLOR75WS4jktbzK9RV/zlzGB81D2oy
	nTHsWYjY9H8U+pbiVSnB71QNgHPqoAs2N8bjMLsHpSRoHpw70XIB0dcfwjdNkUJv5kNwi/
	/ov4ntW0j3eI6uv1BVghkB9aa/g9c+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-AwFInn85PraqFb9VSoqRwA-1; Tue, 08 Oct 2024 09:06:27 -0400
X-MC-Unique: AwFInn85PraqFb9VSoqRwA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso36120805e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728392786; x=1728997586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qR1UZ3ptlV1Q3PKNLC/ya1lH+GCtB5j8K5Uybv88IhA=;
        b=o9+acC0jHtjzhYgdnEU/uJDczW28CxMGFwbk2ss/Qi8YXO2VUzZovvFJnbWi5nHM1h
         2gHIqUJX2uBGFzf5xpMa/Po17YGIHO6PpRx4wnMwV3dZKQZ1OzkO6vgEj/hqvnK22Cfi
         qGkZN3V7NnZX9amBMxxqzU7PulhucozbpJ3IaVyIF78Ra6XUruuFQq37dvEHPiKeCvZj
         F0KYc1ZXuO4jEN2wOTFEA7znRFqjU5Wo4zF2Ryn7bnG7whgbbu1x8HqI/NVE38NZIjdw
         o2WcIp4c/Sn15xvKBcFy1al3q13GSikdcVtwPbAHp2GHUZnsonYQroZKdsR306KG+6jM
         OlpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuSDOf6uOznh8vYL93cwgT6XCzBNuVLQ+Pg+rsXrKPNRiUqIvunsk9Sy582aoQnG6o7o5uXpIYVrkVYwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztRxaaxMF0be9aceaTNo1ZfCcV61l25geIgIJGdHNuNFhalhkA
	8E+2vtk4i8pVkmlqgkWxxfyH0Sj8+fbPKzBzV3wvSGl4bXJSSTT/GDjAtYqRHtqWVgLuV3wJPqy
	EA1MVbw5ZGiwWsbeke9bhYotru/7/UPA8PONFDLN2xlbBbnKfMJOvGj18wW1nkg==
X-Received: by 2002:a05:600c:45c6:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42f85abebdcmr101987105e9.18.1728392786109;
        Tue, 08 Oct 2024 06:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE7IvtgKJRopcQJvNbp61W3JZHbPRBkLE5HixWlNZQuBdnwj2pN8DkvY0pE4hqZUfxj+rmeg==
X-Received: by 2002:a05:600c:45c6:b0:426:51dc:f6cd with SMTP id 5b1f17b1804b1-42f85abebdcmr101986775e9.18.1728392785661;
        Tue, 08 Oct 2024 06:06:25 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72f:c700:a76f:473d:d5cf:25a8? (p200300cbc72fc700a76f473dd5cf25a8.dip0.t-ipconnect.de. [2003:cb:c72f:c700:a76f:473d:d5cf:25a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8334bsm109654325e9.7.2024.10.08.06.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:06:25 -0700 (PDT)
Message-ID: <b8272cb4-aee8-45ad-8dff-353444b3fa74@redhat.com>
Date: Tue, 8 Oct 2024 15:06:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
To: Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org
References: <20241007182315.401167-1-ziy@nvidia.com>
 <9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
 <84D24C40-AC10-4FF7-B5F6-63FADD523297@nvidia.com>
 <be1a1c1b-4630-41e2-a79a-57447851017d@suse.cz>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <be1a1c1b-4630-41e2-a79a-57447851017d@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.10.24 14:57, Vlastimil Babka wrote:
> On 10/8/24 13:52, Zi Yan wrote:
>> On 8 Oct 2024, at 4:26, David Hildenbrand wrote:
>>
>>>
>>> I remember we discussed that in the past and that we do *not* want to sprinkle these CONFIG_INIT_ON_ALLOC_DEFAULT_ON checks all over the kernel.
>>>
>>> Ideally, we'd use GFP_ZERO and have the buddy just do that for us? There is the slight chance that we zero-out when we're not going to use the allocated folio, but ... that can happen either way even with the current code?
>>
>> I agree that putting CONFIG_INIT_ON_ALLOC_DEFAULT_ON here is not ideal, but
> 
> Create some nice inline wrapper for the test and it will look less ugly? :)
> 
>> folio_zero_user() uses vmf->address to improve cache performance by changing
>> subpage clearing order. See commit c79b57e462b5 ("mm: hugetlb: clear target
>> sub-page last when clearing huge page”). If we use GFP_ZERO, we lose this
>> optimization. To keep it, vmf->address will need to be passed to allocation
>> code. Maybe that is acceptable?
> 
> I'd rather not change the page allocation code for this...

Although I'm curious if that optimization from 2017 is still valuable :)

-- 
Cheers,

David / dhildenb


