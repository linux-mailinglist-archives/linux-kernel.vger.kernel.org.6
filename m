Return-Path: <linux-kernel+bounces-430895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05189E36EE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A8A2B27928
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EB01AB52D;
	Wed,  4 Dec 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+4+o2CI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73F7442F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305605; cv=none; b=ZbhX2v28ZLmTPx8k9OeAtEclizy1WW52tdyhACAMn+hr/h+9Vm4R36jWXgL7rsxmy90lP3EVBMWlUEB9haKCMpx1HoMsBvsEQSWBSxQftYYu/UXFWr89s4wI9Ix29Hhkux5ILaWT+/bfrHjaRIYVTcZ5ZeErVNtBrH4OaTN7Mww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305605; c=relaxed/simple;
	bh=gROiBzCzK+7XS19+RUNsvDwf0G6aZVX8Fp4jmG6kXUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KXmQO8cVaa7XFO0rx7inRVdTqOOeYA/btR/NEJzrQ591LZL90vDrFpxpdcehx7I+Vr+sDXgZisJXFStnNxpQ8Kyo1QnxlzF6AzM5IfaqGmemGNaRyCUg8GWkQFS7OAehTioB7WCgYrNY7y6UOqQK46/nr9O4HG1vURfnIdtmGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+4+o2CI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733305602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YRAqhfi0rcfgVq/GFhN7dijeUq/tFTo66aJfQateYJw=;
	b=L+4+o2CIq/ZLUa1xZnYavjjOq5ItC5VAPexHW3QS79IJMpnse1CfsdfE+XEeRAbw7WupcP
	nNigww8sGYPNvyic878lnC3yJiWCaycZyRuggpDXxRJEfrffRsCsFprB1l8FhhgEL+tDu9
	L8nezjqAovfW9QB7kheLa4d9i6HdS1A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-q81H_G8nPP2Xo31jepvSNA-1; Wed, 04 Dec 2024 04:46:40 -0500
X-MC-Unique: q81H_G8nPP2Xo31jepvSNA-1
X-Mimecast-MFC-AGG-ID: q81H_G8nPP2Xo31jepvSNA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4349e08ae91so49305495e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 01:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305599; x=1733910399;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRAqhfi0rcfgVq/GFhN7dijeUq/tFTo66aJfQateYJw=;
        b=KhLmjlo0j7Jli1EQ37DZRF7k0CskID+Ux81+oKE3Cloqv9RuJK15lkCZU73i9ttUQH
         AA3mBP9ZWWpeb8IOBlCKYK1F4NrWvxlnrLgKVc4+8gYGuSaepXIhPAacTxNy8p8sn+3z
         MVV7TDQa1UdTX5/MHOQP2d9aWLMkhs7FudHDrQ4RRop0glmBDZ0lcTvfvuuKz3Uo+5jh
         auTK2L7Ff4RRYLvLpTVRXNhdXy82MKTTF0zgOFUMZcuyeTXybuOUEqbw6kNVC/pFHnrZ
         9/AVbx0GOBD8Ja9YwUZHbt6/8OpHvEzFDsW8/jFf3W+gCCUzCQFpH/RppygBRIJJCwuw
         YnhQ==
X-Gm-Message-State: AOJu0YyRGUqMie0g9Ou0sApEe+551Dry34+xDMwRzMWzB9y/dZk2bstb
	kTiOlrM4KRcs41pHWosjEkiKYXjAalOpR1y2QtjhXBtdTr/6Tfcm93oA2VljDdpxDzeznICZJss
	VTU0kPW0YlP8msQrfHPuJqBbTnCU57bVV6i6+VglPr9CnCu2FbCj/vIER03nfqA==
X-Gm-Gg: ASbGncvfwF2oJu47+uUkzWrCwwkYb+hD2HXlpaYm09t3/JyZUPrWtAOW+Ke7kGcwkUC
	kYJqCee9w3vXjwmGE4JHt3twbbv7yl2XHzPdN72Y2ObvoM1QZxyGKoy4LthKhgBGarPsa0cIE8X
	Xf6tKxiRkct5lDm4Sg+5rg8X7gpfjohaIZGncioii7cpJ8E8PMjTGzJmTaKMf8w6/SeBPHDTUt/
	j9XRK/2m+0QLIpcpPmrTOeVJ9artidZhoT2x4Y80Q2I1PX74nIeIDbCrLXNwRxTewatdqqxhc3B
	hYVRwXXNXD4V78sVUXtBvAo3XhSfCuG76HhedVh41OxS/v7ZBmUOYLgA6yeIMTH9FSNvHsBs2Zw
	ttQ==
X-Received: by 2002:a5d:64cb:0:b0:385:e43a:4ded with SMTP id ffacd0b85a97d-385fd42d1b4mr5226400f8f.57.1733305599647;
        Wed, 04 Dec 2024 01:46:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj87FbNevjh4iVXX3pUKCZweRAnCBd4fI1DVIPcpNdBNX/OLFOmstYbmfV56A+UY56x6TjYQ==
X-Received: by 2002:a5d:64cb:0:b0:385:e43a:4ded with SMTP id ffacd0b85a97d-385fd42d1b4mr5226383f8f.57.1733305599351;
        Wed, 04 Dec 2024 01:46:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:e100:38d6:8aa1:11b0:a20a? (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a522sm17765557f8f.52.2024.12.04.01.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:46:38 -0800 (PST)
Message-ID: <0a745263-c6a2-40db-bb40-4d6129e7e66f@redhat.com>
Date: Wed, 4 Dec 2024 10:46:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] mm/memory_hotplug: move
 debug_pagealloc_map_pages() into online_pages_range()
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
References: <20241203102050.223318-1-david@redhat.com>
 <Z08jp0KSh6Hw_eJt@localhost.localdomain>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z08jp0KSh6Hw_eJt@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 16:28, Oscar Salvador wrote:
> On Tue, Dec 03, 2024 at 11:20:50AM +0100, David Hildenbrand wrote:
>> In the near future, we want to have a single way to handover PageOffline
>> pages to the buddy, whereby they could have:
>>
>> (a) Never been exposed to the buddy before: kept PageOffline when onlining
>>      the memory block.
>> (b) Been allocated from the buddy, for example using
>>      alloc_contig_range() to then be set PageOffline,
>>
>> Let's start by making generic_online_page() less special compared to
> 
> This got me confused for a moment. I'd have said "making
> __free_pages_core" less special? As that is where we were calling
> debug_pagealloc_map_pages() if the context  on the context.

Well, yes, but it's really generic_online_page()->__free_pages_core() 
that triggers this exact code only.

@Andrew, can you fix that up?

s/generic_online_page()/generic_online_page()->__free_pages_core()/

> 
>> ordinary page freeing (e.g., free_contig_range()), and perform the
>> debug_pagealloc_map_pages() call unconditionally, even when the online
>> callback might decide to keep the pages offline.
>>
>> All pages are already initialized with PageOffline, so nobody touches
>> them either way.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Cheers,

David / dhildenb


