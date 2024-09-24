Return-Path: <linux-kernel+bounces-336729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E24983FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30681C20B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87DA14BF9B;
	Tue, 24 Sep 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZcW5iL3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C154FAD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165266; cv=none; b=HHnlAoQhhV847aKQjZVptyzAvO4Eu6XQz/CnfDfrigGOztm/maYLXZxT8+/1CxLerwKXE6Fp1Vxzf0c+G9/Uo9xOnan1uOdeNUBuGL+ubirr4/ifecE99PeT/7pfVW4odWTe3W4Pqe8ld69euvv0gKLTIgqwQjgz1+3kEkfVWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165266; c=relaxed/simple;
	bh=bUDUnqY7WuAjtHUH3BhBUOdHZWQX1jkaA02EYXNzW/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pnu9kujdteRzbGm+RncFw8uJ0v5apJC5vFk2oNzlgpAuJqvqmy/U0YnYwOelDERsgvp9mRWSU6g1oEfJ6FBE4pywv9fsJOb1Na6X4/c5j3K6SI5YpWXl4c0elmlK/S00ktxaWciYQ7adjQ/TwX5ctr76Br/Y67+SSjcgOiWTw0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZcW5iL3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727165263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=otybeEe4GpmIRdyihwrPRZdCQ/gO5EGD00lkw+BaG24=;
	b=fZcW5iL3zSCUOAwHoEHScTgg0Ex3TtdgfTVVJCqVXyGpviPowT8ecSMQG69hEQUn/LJiXV
	DBdZAJij0vztkAzfP+i8K5BzIjFaN/O1KAE72aAtTuB0ZMzQ2pL50XBTXevslbdFF7HuKj
	GuZ+3JJZPFG1axgEj2OkZGN4bkvcbwo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-LATcfNmlO7u0Q0sYTvGqMg-1; Tue, 24 Sep 2024 04:07:42 -0400
X-MC-Unique: LATcfNmlO7u0Q0sYTvGqMg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb0ed9072so48394255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 01:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727165261; x=1727770061;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otybeEe4GpmIRdyihwrPRZdCQ/gO5EGD00lkw+BaG24=;
        b=Vuj8HaJ6vKy3qcBpjY93B9jbel9umLUqyDkwHNd7Z/UT2Vj3WqAuhwg8dnuG1/kGZd
         RXoWVVZEbelGkv4r5bGY6iMNNAjqJMS06iddVxC/bpYBeOLYab4jAD4zVfg63W+sVP8h
         lJhOvhOG8sITbkm6ojI9BM1qGKqGdba7RTIMK4v8TPNSwQzsL2qh6auU678WG61dZNvZ
         u2OGm0IXXvYtlx1g1LhveqBXQ/T0Mxyi1o4vXWwxx3y/UmzpTlfmnKfO8tp0BVxaAGAS
         kO9WQ+vvq8ldgExehbZfPMasfpJJl9cWki+ovkuLscbQ3I8oz3qAYCGGSDU4J68GfByW
         hbTw==
X-Forwarded-Encrypted: i=1; AJvYcCXr7fHpP0dJHnc69Omodj/tqbrdiVdL4+f5g+Y0h6hskKiwnkcVx8oXbBcVifpK1cf4y4vMy2atFuKlWHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyltvkhJtVtWlMAzBcv/5dSRu1F3Ye2Ko4Xlwoj6W8gWi7CAiIn
	Ygu81opyQm0Zob//dFWxc0arb82PvgIC4NYmxAMiX6yjOlG2+fuvdhQ75bS0Hxo9ws1pajH1Poh
	ZlMQZq1Lm4qu0r/eWeKc053niYRXO0DvSsmbr6/bj3UF668sVrtEDei8DQraPJA==
X-Received: by 2002:a05:600c:3ba4:b0:42c:bd4d:e8ab with SMTP id 5b1f17b1804b1-42e7abfcde6mr142274965e9.10.1727165260815;
        Tue, 24 Sep 2024 01:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEajrlIu5dHxPp/lNmEyzt2+B013i1vx3XNnEIikYdXlc/rRnsJXTYaHpxiLgiex2FHEroyjQ==
X-Received: by 2002:a05:600c:3ba4:b0:42c:bd4d:e8ab with SMTP id 5b1f17b1804b1-42e7abfcde6mr142274615e9.10.1727165260331;
        Tue, 24 Sep 2024 01:07:40 -0700 (PDT)
Received: from [10.202.151.204] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e902984e0sm13641955e9.15.2024.09.24.01.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 01:07:39 -0700 (PDT)
Message-ID: <66d5e0c1-a6f2-47fd-9a5b-7651457beb43@redhat.com>
Date: Tue, 24 Sep 2024 10:07:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] m68k: Define NR_CPUS
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20240923235617.1584056-1-linux@roeck-us.net>
 <aa23abe3-7236-4b9e-b237-3b822ac9d186@redhat.com>
 <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAMuHMdVEfPtwps0A29WvHcwgo3f+3nTBiGn1PFxoYy1dxPsUMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.09.24 09:48, Geert Uytterhoeven wrote:
> Hi David,
> 
> On Tue, Sep 24, 2024 at 9:34 AM David Hildenbrand <david@redhat.com> wrote:
>> On 24.09.24 01:56, Guenter Roeck wrote:
>>> v2: Instead of trying to make SPLIT_PTE_PTLOCKS depend on the
>>>       existence of NR_CPUS, define NR_CPUS for m68k.
>>
>> Okay, looks like we're cleaning up CONFIG_NR_CPUS for good.
>>
>> I'm back from conference travel tomorrow; I'll then throw in the following
>> into cross compilers and fixup any other arch that needs attention:
>>
>>
>> diff --git a/include/linux/threads.h b/include/linux/threads.h
>> index 1674a471b0b4..e31715e6746b 100644
>> --- a/include/linux/threads.h
>> +++ b/include/linux/threads.h
>> @@ -13,8 +13,7 @@
>>     * bit of memory.  Use nr_cpu_ids instead of this except for static bitmaps.
>>     */
>>    #ifndef CONFIG_NR_CPUS
>> -/* FIXME: This should be fixed in the arch's Kconfig */
>> -#define CONFIG_NR_CPUS 1
>> +#error "CONFIG_NR_CPUS not defined"
>>    #endif
>>
>>    /* Places which use this should consider cpumask_var_t. */
> 
> This is gonna trigger on almost all architectures if CONFIG_SMP=n.

Right, probably it's not as easy as:

diff --git a/mm/Kconfig b/mm/Kconfig
index 09aebca1cae3..b9566312fc9c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -581,6 +581,13 @@ endif # MEMORY_HOTPLUG
  config ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
         bool
  
+if !SMP
+
+config NR_CPUS
+       default 1
+
+endif # !SMP
+
  # Heavily threaded applications may benefit from splitting the mm-wide
  # page_table_lock, so that faults on different parts of the user address
  # space can be handled with less contention: split it at this NR_CPUS.


-- 
Cheers,

David / dhildenb


