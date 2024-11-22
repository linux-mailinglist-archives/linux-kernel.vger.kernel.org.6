Return-Path: <linux-kernel+bounces-418174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B508C9D5E01
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D2228648C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B871DE8B2;
	Fri, 22 Nov 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfXIemiU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CC1DE4FC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732274606; cv=none; b=FuobDp20xJ9wRdJbBSgvIv6zYU4jT6LVkyhtyQIm9Pek8dKQhekzEz6trOu63kYIfJ4cBvkRzHAUyGxCT17pptE2hWGSK5lINpP2T+KFTEIXj9Q0lCOJ52H57t9eUg91/O+838vhVsttk3a2piaJz+8qNhJ/VtzAjA8+nZ95acU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732274606; c=relaxed/simple;
	bh=pO+261NAsu8xxOoKV6ypcTEK0vG65eYlXzGSlbXxpj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn5X+CuO4DKIpNZ8gs326NYe+DdpGTzlne1gBdmFBd+HB6POekP+U8HdwdKHg5QwEUOYxoZHcspLVAFAZHxsMArMvj++3mD2d1VYl8cdEXhGeKJIWL02N4UxtSQ1PXBPlSXlAmuo/gd+Vle2xV1xMtNrAsOTBfNIk14/hD2Ns3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfXIemiU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732274604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=e4sNKfkYLbgxLymNaKWcz5EURpnwdMj1/RfxsrYkQxY=;
	b=gfXIemiU+jvvEoKyda6YE5O0/4HrsU3zx8RRCwTSKzqB+Xobnc/QKXpdOZWASIucGhx7H7
	/5QPUzgIg7H5yFDvrkkp+VmrpsrVjb8a4Cc9OJkV4XbOoJ/C0gVOubJFy3MwjjwhdHQrth
	TeH5/GNNOQZrRSqKnl8OF/UJg8OFAis=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-FGlyysqwPYaGwGqjLvD6Fg-1; Fri, 22 Nov 2024 06:23:23 -0500
X-MC-Unique: FGlyysqwPYaGwGqjLvD6Fg-1
X-Mimecast-MFC-AGG-ID: FGlyysqwPYaGwGqjLvD6Fg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3825a721afaso1145417f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 03:23:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732274602; x=1732879402;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e4sNKfkYLbgxLymNaKWcz5EURpnwdMj1/RfxsrYkQxY=;
        b=aFQSqKZsL26LbshHTHcKQJuPl+pYA3SsB6405sM1QOh9+JRWJPJzNYs0Si1dDwkGjq
         9QhGgqpxd9Z4CLP+9uZ6pL/zTdlQUnf5XqlSp0K8MThH1FDQcm/eWTDFdYYBG2/LD/LQ
         FJ1iigOye4plMU7V11Vu68JZXwJ30x333hBkuHPXz3pcKATkFuKHjd3SeIkPmqR1uzYv
         dWlJT8hZJKgmw/ANE8/DdDaIyJiolMec/nqSY2Ni5owBQDXm2n7jU8DR2SZeiCVro6My
         pob6YJ/1r0yZ1Wm8pHWKi5wGhIkW6Lu8QYGdQ2TS4bw2CF3ZIihpQpJ8EL0D69QxF+gC
         S2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzYJIv4nXXtjmoJy35V4eHesxOgQrH8sHEUwKoUhTJEUs9epvUYA5Ud0mp0+ZYROavWicOmhZGuK8o+GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT46ZV6uhS3b4RPcEvyE8DMuqybFdHGXBM6uuN2aRPTQoha1VJ
	pa02yv48DzuMh2S8Bix8G/Li0BG6Y4JeE1pt/UcsTKGYTNBqA4L/RTKriWlBNh/cqsRb7H1g++K
	gQ/dIBfNA6OCKw6uc/cEjQBXAjMTfoqUS5SoWepTlSnUWDb9hL4aNKX6stNSsWw==
X-Gm-Gg: ASbGncvHN6615i9PIsgOETmUc5QAKiVW1FDCA3Yv46w6QfBTHM+i+ls5a/BaPfamZIY
	gpG2wC4/6fmZz553t8GgYfWG9JaT6fY4zvOQFC+H/EQEhJrZUw1Gv1a15kHdpB8A1TESOxSHiWn
	bO3CVbfyQc9Lexh6P7Rzkqbd+yM4Ldgq72rzf+ALjLpQqNAVI7rGsSSU0GiyCSVxaK3b+vq44p1
	MJhlAfQ+xjEG4r8sjbxEJCToPDdxs8M5rG1l5uGcisC82E0vv6mRB+ujqpKyaHhFnoUMg/YkN3r
	IF5e2y0zgd4Roycz8czpzKCW/uY2yGWFKvdJbGwheYNUlhrOmySeBxq+uiFCnttk0n+K2/J7awM
	=
X-Received: by 2002:a5d:584d:0:b0:382:4aeb:91c7 with SMTP id ffacd0b85a97d-38260b5f9c8mr1533815f8f.18.1732274602051;
        Fri, 22 Nov 2024 03:23:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1O+JdrBe9e+xVNXaAjMvRC2BeHCRPSoNWXD2QnDk/kh+UW1Cva1MiLJ/BJpMJZRvC5Gl/qQ==
X-Received: by 2002:a5d:584d:0:b0:382:4aeb:91c7 with SMTP id ffacd0b85a97d-38260b5f9c8mr1533801f8f.18.1732274601710;
        Fri, 22 Nov 2024 03:23:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdb13sm86546165e9.15.2024.11.22.03.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 03:23:21 -0800 (PST)
Message-ID: <fa398c31-7135-457e-b97d-366c12685688@redhat.com>
Date: Fri, 22 Nov 2024 12:23:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] MM updates for 6.13-rc1
To: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118193001.6aefcadd7426feafedf824e1@linux-foundation.org>
 <ZzwVo0ZbuG37pHdR@casper.infradead.org>
 <20241121214229.8fe091954f9bf0d26f54ed88@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241121214229.8fe091954f9bf0d26f54ed88@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.11.24 06:42, Andrew Morton wrote:
> On Tue, 19 Nov 2024 04:35:47 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Mon, Nov 18, 2024 at 07:30:01PM -0800, Andrew Morton wrote:
>>> Matthew Wilcox (Oracle) (13):
>>>        ksm: use a folio in try_to_merge_one_page()
>>>        ksm: convert cmp_and_merge_page() to use a folio
>>
>> Unfortunately you left the crap patch in from Gaosheng.  Linus, can you
>> apply this fixup?
>>
>> >From 3d7e7319bbb3ced1dfb9c82bb7e8c7386380799b Mon Sep 17 00:00:00 2001
>> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Date: Mon, 18 Nov 2024 23:32:25 -0500
>> Subject: [PATCH] mm: Revert IS_ERR_OR_NULL check
>>
>> &foo->bar is address arithmetic, not a dereference of foo.
>> Huawei engineers seem particularly prone to not knowing this.
> 
> It isn't only Huawai people.  David acked Gaosheng's patch and it snuck
> past me (again).  People keep on getting tricked by this idiom and I
> think we'd be better off with some nicely named wrapper to help
> readers understand what's going on.

The helper we have is "folio_page(folio, 0)" ... and we do have a bunch 
of that usage in the kernel.

Likely we, want a more catchy helper that simply gives us the first (and 
for small folios the only) page.

... not able to come up with good names though. folio_page0(), 
folio_first_page(), ... :(

Once folios no longer overlay pages, the &folio->page trick will stop 
working I guess, and I recall a comment from Willy about that.

... and then we'd probably have to dereference the folio to obtain the 
"struct page"?

-- 
Cheers,

David / dhildenb


