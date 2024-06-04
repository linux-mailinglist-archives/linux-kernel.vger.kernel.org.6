Return-Path: <linux-kernel+bounces-200661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C25D8FB31A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127F42846C6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948FA145B0A;
	Tue,  4 Jun 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgyxCXLC"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69981E519
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506145; cv=none; b=ZTP41ksNqUw6N6AgNjiXz0Ft2QSd6nCxl1oSZh7NAfObDXgDtVIAJNEwpGpiANKDW1a1DXo9P6yKpbDIPT6hC2JV/cvdJOJm6PaLg1hX6Ila6Yt3STJr6K1QnuGBURhR8r8HBQ3wpISipcHnX+XfHrF+yXbLWxP7DbhgowDXvqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506145; c=relaxed/simple;
	bh=Ksoyabm+YsXObk1/0WMbiqjM2Q8DdJ2hVktD0OxBgtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TyPGutgU4Y9EvYiVcIu9tQ84wTXxq8B0ClfS6tRq68qvUXjb5lPfQwvYhDSnGTksA7SmD7xQl+Il+kn+Z6AXL8BZ6niZO3FRJ/mc+MVY0PkivbnE2xd86230J4eK4eeULeZCVTw01Mh8PcgsLE6XS2m2y3Kr8MdZdPQ0++PRfzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgyxCXLC; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c24109aca8so1496492a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 06:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717506144; x=1718110944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MChTYhGzrz3KYD410VZi7VqQLRbgGN9BW4zzAlK391Y=;
        b=jgyxCXLCUgymrCnLbOljixdfoXBftmlMiIfRPPdfpNo+r4lS8Zxh+csYiOEBApKGQ/
         LrY2/EVSBXm1/+ZowS0YTfRNKhfSG94maHBDFifqCIEtNKp15DPJDB+eAZZ3bblQFbzC
         cUzseb7k+Bqtwvb9IZO3B3zqY5QYFLoOArbVd0WsPSONZrBp0W70y5qeFPNde1RgphAd
         fEMJcwwDv8YO5BzFcYuWw0cr2WB5oMxDvVJH1CJlZtKpXZXmoueWtYO25G7uAuAFAjG3
         9WyVWHajxmquuiFXGHIfDvXzjp6uwXU6WOu9/8t1pQU4nXuuJOIanYVxqhWqsO3sORXJ
         VXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717506144; x=1718110944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MChTYhGzrz3KYD410VZi7VqQLRbgGN9BW4zzAlK391Y=;
        b=CbptKNWCEm+gR0sTGPkp3Mc19mGft5cmg/++JVaIMW0367uh8V0ox63mG3xFqLLKdM
         w98vyO+zSgqtqNmQrvZXs+tn3BfMbhlAnxI6nq7PN+q94adpobUXDMaVhA0HnD0wQ7pZ
         wzfGfEreuftRLuvR1aQmPZaHB0gXTxwG6YamOZ2z8pg83MK0vvcvhhyRTYdSPLAF6ICU
         7LTA6sYcqZC/l6CFCdRNvk4QH8ci35ULVTCVJkXLs9V75BTs+5II3JQI8OQDO4xuUeFr
         8ZMl1K57IMJRZc1p1nXi3sUBrAKa6XnqOqPLD0QkwoANLMeOKGki7RxHN8MMmK9XQozN
         IZGg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5mvv113AZcIRL8k6iCt3Hfws/zSfbCzKqGvmEjZPz6d2ohYqyA2TtewK1HGSYEL1D3Zi/7GM5BFOGwlssEi5LHoWXoQfvMDuEmv5
X-Gm-Message-State: AOJu0YwGBNEKU3++LDCIpvzSk5j+U4AvNW4fpPveex6qNOv0wddRZbWS
	erI48S5Eexr+GA0rPQgGX/DC+hKARiA1D104KboQ2TbTodXSpdOq
X-Google-Smtp-Source: AGHT+IGu0NXkc7YMxuAXWfpe0K9cubaKltPxks/JHC1BZbVqB58WpEQWUlL3P9h9Nzr7jG6Z4wnpnA==
X-Received: by 2002:a17:90a:e02:b0:2b9:a7bf:8701 with SMTP id 98e67ed59e1d1-2c1dc588afemr12028084a91.21.1717506143628;
        Tue, 04 Jun 2024 06:02:23 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c2831aefsm8043247a91.38.2024.06.04.06.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 06:02:23 -0700 (PDT)
Message-ID: <d059e397-beea-43dc-8c58-d7833b1d8bd4@gmail.com>
Date: Tue, 4 Jun 2024 21:02:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging
 page
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, izik.eidus@ravellosystems.com,
 willy@infradead.org, aarcange@redhat.com, chrisw@sous-sol.org,
 hughd@google.com
References: <20240604042454.2012091-1-alexs@kernel.org>
 <20240604042454.2012091-2-alexs@kernel.org>
 <9ca730ce-2b2f-42d2-8c7a-78735a995c64@redhat.com>
 <4d299245-3166-4810-b22b-2a5b4f54a049@gmail.com>
 <7c6ae2a3-8ec3-4c9b-81c3-125f6973f0f3@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <7c6ae2a3-8ec3-4c9b-81c3-125f6973f0f3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/24 6:45 PM, David Hildenbrand wrote:
> On 04.06.24 12:26, Alex Shi wrote:
>>
>>
>> On 6/4/24 4:07 PM, David Hildenbrand wrote:
>>> On 04.06.24 06:24, alexs@kernel.org wrote:
>>>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>>>
>>>> We can put off the flush action util a merging is realy coming. That
>>>> could reduce some unmerge page flushing.
>>>> BTW, flushing only do at arm, mips and few other archs.
>>>>
>>>
>>> I'm no expert on that flushing, but I thought we would have to do the flushing before accessing page content -- before calculating the checksum etc.
>>>
>>> Now you would only do it before the pages_identical() check, but not when calculating the checksum.
>>>
>>
>> Hi David,
>>
>> Thanks a lot for comments!
>>
>> If calc_checksum() is wrong before pages_idential(), (that's just after page was write_protected, that's a real guarantee for page context secured) pages_identical could recheck and make thing right.
>>
> 
> Yes, but you would get more wrong checksums, resulting in more unnecessary pages_identical() checks.
> 
> That is missing from the description, and why we want to change that behavior.
> 
> What's the net win?
> 
>> And as to 2 flush functions here, I didn't see the guarantee for other writer from any other place. So maybe we should remove these flush action?
> 
> "I didn't see the guarantee for other writer from any other place" can you rephrase your comment?
> 
> If you mean "the process could modify that page concurrently", then you are right. But that's different than "the process modified the page in the past and we are reading stale content because we missed a flush".


Maybe moving the flush before checksum could relief some worries. :) 
But still no one knows what flush really help, since if page content only syncs to memory by the flush, the kernel or process can't be work with current code. 

thanks
Alex 


