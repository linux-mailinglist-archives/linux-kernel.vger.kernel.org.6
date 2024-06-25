Return-Path: <linux-kernel+bounces-229538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59D0917095
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86FE1C21FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B03217A932;
	Tue, 25 Jun 2024 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvtD9A9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C621369B6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341480; cv=none; b=qVIyciNtFurYxrX01ZyIB5gZRry3IW48qZIxf9UAU6Hl1eWfAXLwpOdbaGh4obuLN31yzlx05geeUqoF8WpKlYfIyMycGnoyGmjlQgmrbVhesc11e7PMXlDNNwWhBvzNCFfvvc3BgGt0WbNkqr9amSrdefnZU6yJIHEZda1XM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341480; c=relaxed/simple;
	bh=fQyVBTpP56B/bxJYVIP44I8vSQytFd8sCgsDDjT0vyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IO6dI3WapyfXqNXpaCszeJHNTG7wFiVvkbBblSbmQl51nioUji0imGPPFp/6oprFyvMREG8nghQtz4CxjlPF9SXmKx+z4PHN1SIBrfy6TyaI3pPD2319qTZVmsRbrhZbldprXVJGtWb+ub0c70Wi01e9t1M5L8WI6qo76D9R3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvtD9A9u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719341477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JC695OXK/9mVgBUJtBiA47vPzO+xwrxN7c00IjPh0LY=;
	b=TvtD9A9uNso8teClOBizNkF7LiglVBpjbkHZIRLgWVgrKb+VDKEAE5sthstazkivHLAbjO
	oZN1f+8Ibmk8lp44Hs8kraiYdcjdItWcwlRw2uhX8SCyfalA9iqbcxbKfOFJx3QqzGY8IP
	SGqVvuwuGC5vMsvQqT4zwTMVK7OkP7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-pt3MC-k8MP6SQ_LjWShYiA-1; Tue, 25 Jun 2024 14:51:16 -0400
X-MC-Unique: pt3MC-k8MP6SQ_LjWShYiA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-421eed70e30so40686835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341475; x=1719946275;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JC695OXK/9mVgBUJtBiA47vPzO+xwrxN7c00IjPh0LY=;
        b=pYL/JFnqpNqnh+uPxeXR9cdFPJW/5tG8rgVz8j+I5GDPK6fKKpSpwnxWNUp0+ohJr8
         Dwz63R29m/K7FXICcPWSraAQOnW3RieRgmc9USYtdx/QC5AE3kPX8TFoQcu/23BWAGWo
         HCruDJroUtY3NuuiZto8BlOdRs3keRBOb/5pgbJRRzvu/EAxHhszwwie2wzW0X3e3Vo0
         61T2UEJuVGJ9jLCfkpSgfzQNfP/TbJXUadLbOBVQPyVqwjFtg6GDLb/VveNYwXrmjYY1
         60EArFZIymuZXM0546oKQ+d/BTSJo10zuiOolq2y7U3E2T7FrxtMOewUh5h4Af1tNCbv
         3qrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUI7Yz7eFW6JHNyfU0F00Vhmb08UakuYf1+/ZVRWBzOPJ7WLhKRZyxl3ga5oaXuXezOaeFgs8u4d/g4RH/opkT69RoY98QoTWnEpG/
X-Gm-Message-State: AOJu0YyIRFDEKnImqHjB7noS0MzGURY2qbvNL/MNM1C0KG8F81u4h32p
	Y3wm1zJLXg8LX0Ul6ah5t40Dnozen22U8HJhmc6ATzGajEX/R0rtB41R7QPODCfEYj3PSLHmadK
	fglbJZlKpD04lbBBKgXTckbGLFH5lHfq7dV6cNB3MdCVask1J+j8rZ/pkkMZ3Kw==
X-Received: by 2002:a05:600c:35c8:b0:424:8cc1:3ed9 with SMTP id 5b1f17b1804b1-4248cc14016mr57025665e9.20.1719341475352;
        Tue, 25 Jun 2024 11:51:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyadGgMbjx/qt+WfMBGzph+16gWei0ATkYZgVfezqTKLTq/Kkdr6NKUliHgZmdsqv5LZMwjA==
X-Received: by 2002:a05:600c:35c8:b0:424:8cc1:3ed9 with SMTP id 5b1f17b1804b1-4248cc14016mr57025515e9.20.1719341474989;
        Tue, 25 Jun 2024 11:51:14 -0700 (PDT)
Received: from [192.168.1.34] (p548825e3.dip0.t-ipconnect.de. [84.136.37.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424a5b1ed1csm25323815e9.0.2024.06.25.11.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 11:51:14 -0700 (PDT)
Message-ID: <33d9e4b3-4455-4431-81dc-e621cf383c22@redhat.com>
Date: Tue, 25 Jun 2024 20:51:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm/filemap: Limit page cache size to that supported
 by xarray
To: Andrew Morton <akpm@linux-foundation.org>, Gavin Shan <gshan@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, willy@infradead.org,
 hughd@google.com, torvalds@linux-foundation.org, zhenyzha@redhat.com,
 shan.gavin@gmail.com
References: <20240625090646.1194644-1-gshan@redhat.com>
 <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240625113720.a2fa982b5cb220b1068e5177@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.06.24 20:37, Andrew Morton wrote:
> On Tue, 25 Jun 2024 19:06:42 +1000 Gavin Shan <gshan@redhat.com> wrote:
> 
>> Currently, xarray can't support arbitrary page cache size. More details
>> can be found from the WARN_ON() statement in xas_split_alloc(). In our
>> test whose code is attached below, we hit the WARN_ON() on ARM64 system
>> where the base page size is 64KB and huge page size is 512MB. The issue
>> was reported long time ago and some discussions on it can be found here
>> [1].
>>
>> [1] https://www.spinics.net/lists/linux-xfs/msg75404.html
>>
>> In order to fix the issue, we need to adjust MAX_PAGECACHE_ORDER to one
>> supported by xarray and avoid PMD-sized page cache if needed. The code
>> changes are suggested by David Hildenbrand.
>>
>> PATCH[1] adjusts MAX_PAGECACHE_ORDER to that supported by xarray
>> PATCH[2-3] avoids PMD-sized page cache in the synchronous readahead path
>> PATCH[4] avoids PMD-sized page cache for shmem files if needed
> 
> Questions on the timing of these.
> 
> 1&2 are cc:stable whereas 3&4 are not.
> 
> I could split them and feed 1&2 into 6.10-rcX and 3&4 into 6.11-rc1.  A
> problem with this approach is that we're putting a basically untested
> combination into -stable: 1&2 might have bugs which were accidentally
> fixed in 3&4.  A way to avoid this is to add cc:stable to all four
> patches.
> 
> What are your thoughts on this matter?

Especially 4 should also be CC stable, so likely we should just do it 
for all of them.

-- 
Cheers,

David / dhildenb


