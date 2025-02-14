Return-Path: <linux-kernel+bounces-515682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17EA3679F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5165A16F6E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81601DB153;
	Fri, 14 Feb 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="av9hwt0p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00B17E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739569179; cv=none; b=qRI7R6EXy5MR3Qj35dYjCpF/prkf2x6M8kvUKlrPwYrL+DnrAjydqKG3M3tLQ3Qvo1wNSQ8cOPh7rc4mXSsJfduO99gM13PF2tmkKc82qQJbvU0wi6FEBkd++KaGSM0TXEP6O+4K6ETjAHf612oMxOEzcuda+HV+5iDpGuxU424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739569179; c=relaxed/simple;
	bh=Ud2XzNUL0wqbOx5fnJ1fr4oV3M7u1BmFSqvck0X8ovE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ELN6AEEqm6VqAjBTTPkrNHZNO/4k3VpLfoFuGSXZLugDwg9h1sKKkQGLNspaRr+PdwV2ogaj6xlBhNqCuf9yfuLP+Xq1FbR3pg6q9bpBqoZYulULWqjEhaYmTuPvKdy7V2ZueeVCI52BaEg11Ix14r6dh4Hme58tXVVUWeglugQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=av9hwt0p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739569176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iv/lNCfjwdkeR4nF0oUU9k7rRpcxsvGhnFm9RShrjfY=;
	b=av9hwt0pVgwv0Zk0h3R0X1PThn46HHB9+n3dlHMYtPVln3hNyn8drWhYBp6pCFbJb2ckkv
	8VwAvOJhVHtcCiapuu8CwBpNVw3OwfN/RJu0/F7q4pxl8nIDmqhysTkR29VquwIWIrNZaQ
	rjvaq9KOyrJdw/As/8tH85p8a3rAdiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-dQcbzKI_PUW0M6DoZ3sv-w-1; Fri, 14 Feb 2025 16:39:35 -0500
X-MC-Unique: dQcbzKI_PUW0M6DoZ3sv-w-1
X-Mimecast-MFC-AGG-ID: dQcbzKI_PUW0M6DoZ3sv-w_1739569174
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394b2c19ccso20552255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739569174; x=1740173974;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iv/lNCfjwdkeR4nF0oUU9k7rRpcxsvGhnFm9RShrjfY=;
        b=Uv7hfbYauwqsKLkZkxR+xKngQQ7B0WrG1JVvxuL+9o6+5iWsbvDFFygOnzCS0pEOcK
         G33sXoC6lJ4jpTxUFKm4Efqef0jmjl8JW4E/cqJW7VGmLqDHVcSFlpCRM/13nL6+Pnhf
         5NxEyE1ny4JLCaTcFHAm4Qe1cRckC3+jJJieVyxfiZON4CXz4jL21XRDYEAeyZGhposB
         dRjtkafrj4l90M7qg76Ny29uXAX1A0dD3TnLUfEndGkKyWXxlnyB5TzA3aqqfa7iJdlV
         jhJtsp+goMm2qX4a0DZ55yBt4QXGDqvDCyprFP0B3a34JlSJN8ImINcKc6JbDHhrZ0ZA
         +Zxg==
X-Forwarded-Encrypted: i=1; AJvYcCXFjoIQ8fu/e99uWLOELPd/dZZYSnlmHLi3wHRO6GVzS7XKJX1gT/u8xMsh1FaLEG2Ua6ODyNz8fFy4wZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzstSZk8Qz+5l+y6gWbTea679fvDeNQNb99ddYdaVxw4I7uCD12
	mE3qVmsXYZJIGKq4PDFvMQU4DNMVldluxO/KNijdtHe+dneRtNUJGixnFFwiZNl7LOp8/+1A0Cp
	wCaRHlsAOjz2M2H6quJe1/nOrMIyWVz8tyYF4cGhtz4LgJJKTIPc6UrsgPazCxw==
X-Gm-Gg: ASbGncsbQXZqfFleqqC1xLMJN6vJOH6wzTNWQBrFX/62U3toYwF3M/Q8PParUPk3sjW
	SMNfAbvJ8yfIe4mzRIzsDo6wVzNpo4oMIWcqfN3Cpkr4cQHLyFqcVF+0yfqjn2FhcsPmQKbAweo
	4Yp7W1+K3l+7ynWBtA6EDpf81jcNqLPcJjYa0PF4/tm0HlvLOIeiLhPdXqVb8dCEr4N2Q0iy/fE
	kb+SrcRVGMZWojni+XXITiWvJXGcE8ON+tasfXUJO59RTimtqVfwA008RiWnPnv770bnRWmCe5q
	0bBwhfmYAv4KwO6ckpkOqYs275/npWrnC4kWPq978hzVSK8eJZBKy63ihKvn3eg2LvEG2eZGC9W
	sDu0xH+jL9vVoEJgeF0rYUJD/pPq/oP7v
X-Received: by 2002:a05:600c:1d1a:b0:439:5756:ad4c with SMTP id 5b1f17b1804b1-4396e6c1885mr11847525e9.14.1739569173827;
        Fri, 14 Feb 2025 13:39:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBOiE8GdsHWkJu3JJujPjuarO3/1Mi20BwQfSP+o4X6JnyFijzaTOnDc+qmAg5cAL4PBux9Q==
X-Received: by 2002:a05:600c:1d1a:b0:439:5756:ad4c with SMTP id 5b1f17b1804b1-4396e6c1885mr11847325e9.14.1739569173434;
        Fri, 14 Feb 2025 13:39:33 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617dab54sm55056285e9.6.2025.02.14.13.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 13:39:32 -0800 (PST)
Message-ID: <c90376b4-0a8b-4db9-8b84-39325b1ac57e@redhat.com>
Date: Fri, 14 Feb 2025 22:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm: Provide page mask in struct follow_pfnmap_args
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
 mitchell.augustin@canonical.com, clg@redhat.com, akpm@linux-foundation.org,
 linux-mm@kvack.org
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
 <20250205231728.2527186-5-alex.williamson@redhat.com>
 <20250214101735.4b180123.alex.williamson@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250214101735.4b180123.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.02.25 18:17, Alex Williamson wrote:
> 
> Nudge.  Peter Xu provided an R-b for the series.  Would any other mm
> folks like to chime in here to provide objection or approval for this
> change and merging it through the vfio tree?  Series[1].  Thanks!
> 

Only skimmed over it, nothing jumped at me except ...

Nitpicking:

I was wondering if "page mask" really the right term here. I know that 
we use it in some context (gup, hugetlb, zeropage) to express "mask this 
off and you get the start of the aligned huge page".

For something that walks PFNMAPs (page frames without any real "huge 
page" logical metadata etc. grouping) it was uintuitive for me at first.

addr_mask or pfn_mask (shifted addr_mask) would have been clearer for me.

No strong opinion, just what came to mind while reading this ...

-- 
Cheers,

David / dhildenb


