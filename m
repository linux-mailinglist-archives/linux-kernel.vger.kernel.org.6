Return-Path: <linux-kernel+bounces-203883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7228FE193
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB331C24193
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331F13E02E;
	Thu,  6 Jun 2024 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYhqBZgH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E013DDC5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663796; cv=none; b=GLV5kBHSlOz5JheiVc2dS5tb4N/1age4uz0uk2gXhWyEa9lobdKpfM0+KRzVjrPzYlbH4PKM1PHQmgeDEfapriEha0yqmxBSL5OK+9C9sOfBqNSnha6tT1kGoeg8UnFcvPw3nP08Wd6hAA8+AxlFqFHHqyFBhbyXdZN6CZTOcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663796; c=relaxed/simple;
	bh=aMUEx0MW4us6hb8BliY4lBAyJXwHPDYq42Qe5Gw2PjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YoS6f0xfJ8bkwEUPxeFBR+y79hlUragQcyE55uaeWOdTmTMKQAuMgpN8iwdyrld+UkzVRl7iyaoZxbu8PF95JcPgseE8CzlfPUOJ9UsMiZ8YAMkn6pEsKdSsCz5wDI6jg+wZA8GMm5iM5mY0V3YhDfbabFP4tj1Pj6nIwbE0Pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYhqBZgH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717663793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lEpJnmAooHs+q1LFotn8BVE0vCgeP6/jAH+eJ4bkGBk=;
	b=QYhqBZgHklwEx81MgEANbmvpNUx/+VerXt+ZoM5M1XnEdZ9OE/HiRnn/KoyWEox5V4npWz
	iRtCcgBueyIxAozSdBNxX7VpckYW//JaSHW7yVdRXPtmP6E8ybCA+e2GVawiRLRcnVz34S
	Rk/oqBS3RxGpkH7PHuiiMnZ+oDABJT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-pl7vGRJhMb6SZhV-iJVAtw-1; Thu, 06 Jun 2024 04:49:47 -0400
X-MC-Unique: pl7vGRJhMb6SZhV-iJVAtw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42158087ac3so5948445e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663786; x=1718268586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lEpJnmAooHs+q1LFotn8BVE0vCgeP6/jAH+eJ4bkGBk=;
        b=HTKFSM1TUelDOJ3h6+VsTOECiYY34cxmFY/ICE4mJKgJxUz6mYeM7R0nJW2xqi6bIQ
         VtWZUBXQ1ykhb1dpwgvlrNwyHIk+srerWOc5KUM8S25KxZRG62c+w185bkB8w8Tnv8Tl
         GCdN6IR7bQ6W80YJISMjHRx6iYSbpUqa01lv7oF27VpRQauPdtmZ+jJ0XxtXCMOU2FdP
         cfSMGJ4P8NbMTjCHXdHR4tYZ/4TZfUkg99mxENAap6f0CvmzN6kWQNzI5LIapiDSzj8c
         Dzei5TXiOy5/YkXsq27HZ5DutJqYNYqFCxDS82LQ7CQ3PKkyuTxRfkyjoIlLL8Xleybz
         ovYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5XVfrOAmtyBOd7Hew/hyqE6ZmxViu9ABLhnIjax+9DA7PRgjaBPn1eyMKJ0BfPHdjlVYYN6OxTd8SkxPfDSD9TZWZ/w9McciDWHP+
X-Gm-Message-State: AOJu0YxT6IvtikR6H2adHecd0PhhKNCFIKw3RuynUvrIUF7FaVJq2LCL
	ScjWatanZ/uyRQbAiUk2orYU2JB89EOcIaHHrko5PQ2eA7kv8mqSap2zZ1aGHqc+4iDt9lGoxL5
	gHItmd7pMncFJ+EpuhhUFL3YTczqNyl+b+hkUTIHwYXCmg0NDhtPXduvDgDWxgg==
X-Received: by 2002:a05:600c:35d5:b0:421:2a49:cf1a with SMTP id 5b1f17b1804b1-421562cf5eemr39435415e9.3.1717663786728;
        Thu, 06 Jun 2024 01:49:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPLdCuxtoHagi5sdkDyBRD0h6nfwzft3hnKCM/ujmHRO8cEm3x7XIk+SC0dnJrubFZQZm4Jw==
X-Received: by 2002:a05:600c:35d5:b0:421:2a49:cf1a with SMTP id 5b1f17b1804b1-421562cf5eemr39435215e9.3.1717663786249;
        Thu, 06 Jun 2024 01:49:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c2cd2d3sm13895045e9.41.2024.06.06.01.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 01:49:45 -0700 (PDT)
Message-ID: <8e4cd345-2530-4ace-a596-a0fa6911a35e@redhat.com>
Date: Thu, 6 Jun 2024 10:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Yang Shi <yang@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240605203723.643329-1-yang@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240605203723.643329-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.06.24 22:37, Yang Shi wrote:
> The atomic RMW instructions, for example, ldadd, actually does load +
> add + store in one instruction, it will trigger two page faults per the
> ARM64 architecture spec, the first fault is a read fault, the second
> fault is a write fault.
> 
> Some applications use atomic RMW instructions to populate memory, for
> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
> at launch time) between v18 and v22 in order to permit use of memory
> concurrently with pretouch.
> 
> But the double page fault has some problems:
> 
> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>     readonly PTE for the read fault.  The write fault will trigger a
>     write-protection fault (CoW).  The CoW will allocate a new page and
>     make the PTE point to the new page, this needs TLB invalidations.  The
>     tlb invalidation and the mandatory memory barriers may incur
>     significant overhead, particularly on the machines with many cores.
> 
> 2. Break up huge pages.  If THP is on the read fault will install huge
>     zero pages.  The later CoW will break up the huge page and allocate
>     base pages instead of huge page.  The applications have to rely on
>     khugepaged (kernel thread) to collapse huge pages asynchronously.
>     This also incurs noticeable performance penalty.
> 
> 3. 512x page faults with huge page.  Due to #2, the applications have to
>     have page faults for every 4K area for the write, this makes the speed
>     up by using huge page actually gone.

All interesting and valid points.

As raised, the app likely really should be using MADV_POPULATE_WRITE.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Cheers,

David / dhildenb


