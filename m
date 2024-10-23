Return-Path: <linux-kernel+bounces-378013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC5B9AC9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC340283172
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B681AC892;
	Wed, 23 Oct 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y40OO046"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88741AC43A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686149; cv=none; b=QZ8rhinAXTWoAKN9uuSFAz4J3VerOlxsJkJP+hm8pIXjttZMRBrpg5nXL0D31P9s+bFMJ7gcS8mQMTJT4gQSE273kw4Wq8ocTXEd/+B8Zxv2nBh8PCUOQELHfoT/vInhJVB5y0zTWRv1pEIpQRlsNTVE8M5AJcZaka3bFJ6/3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686149; c=relaxed/simple;
	bh=rwBwAvMIx7/9+1wSq0q/nHb0RenRypT6/zh49zhcFMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGhxIaUtudTO7QXWualUOyay2ZZh7DMhlP1LCy5DMqEeBd/ntiC769CFQmOyTGSegqJhsVsSp8rrzWFgLUOw0ovUx24YP4DVF7h39cJnypr814vgl8GCAmEcTrIAvAHkaAd1epfsQtJlm4gnR3PBZ2LIRm4h0M7kIRn39H5YSR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y40OO046; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729686144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6oJ8j7/D+YbCC+kVmfyxUurzSaVJ+Q4pzHrbkRxsKSo=;
	b=Y40OO046O2+Rk7SleDR27sJK5Q9K0nnPZIQtvIBlL5PrQuZ2kCYbK7bayhvn7qFxgCKPyQ
	LfQYk0lbSec1j+q1aqQfhoBN4d5fplJSxah7Ur3mXr+iK2kYEaK3nkco6ogOMXO8RbyaQ1
	hmdlQYn967nmjOBGzQsqY9pF2mnvTb0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-wQ6kSyyzPpO96HS9BYmw5Q-1; Wed, 23 Oct 2024 08:22:21 -0400
X-MC-Unique: wQ6kSyyzPpO96HS9BYmw5Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4cf04bcfso3149951f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 05:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729686140; x=1730290940;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6oJ8j7/D+YbCC+kVmfyxUurzSaVJ+Q4pzHrbkRxsKSo=;
        b=eQI/4S39etFGEG7dk/ZE50cdYR4G0ZluKVQw3k2ZS9mI1zJsLCZ61++Tg3pGsCl5Fg
         ZqRQFKbn5lRebBLd7KkoL8+2ZtTw4SWigcj+yl2kVdMbVt4Ixsp1B+59qXeNxZmCYDX1
         Yapmf4C+9jIA/K+BgyxRF1Tsxra/szdWzxhnGwvS13xWuVMmY88LO67SBtEM8QyjcQ5R
         k2a4TOBjVHeWn3Fz5zOF68w0F7qqkPfnCJU5Y519H/Gl7eEi0PWJFiwH1BchlSIkZppb
         QCj3BttXST2XTynz1+9M3S7oIuXHsO0NLmX8eeglCLKnE8nQIi4sun70fpN8mA8Kj4q2
         vQ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlhgDq7knfBg2RlZXqLIfLdLDTW9Br12dhJObz3oqVxZKSnR9bKiUln24yk6KkwbILJ+n2KoK47GO4nxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJh0i8PjYa2DoAvemi+V6wghyWDBbHZCaphtYPaL+0iX35/LCa
	A2R6cOFxOBGrMlFp6unn0uDQ6/rwJBiLcLWelpg0293xgq4OM5nJRk+L9Cwufd7wqc3NiUB7alo
	ns4dtd76KUZ/K/4v0yJQUGPIg9XsUCsuy+opW8ekcxtvZc+Vkqv6QEu+/ZaOI0dE/OMvMWSKp
X-Received: by 2002:adf:ef8d:0:b0:36c:ff0c:36d7 with SMTP id ffacd0b85a97d-37efcee5a39mr1641058f8f.2.1729686140129;
        Wed, 23 Oct 2024 05:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHCIHHhMiV0AOaFyo0Rb1wzPTzM2s7Pz3pDrYn9AaMWsH2Mx628Ab1qHOPQJ6EVozcp+Dkxw==
X-Received: by 2002:adf:ef8d:0:b0:36c:ff0c:36d7 with SMTP id ffacd0b85a97d-37efcee5a39mr1641038f8f.2.1729686139646;
        Wed, 23 Oct 2024 05:22:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:cd00:c139:924e:3595:3b5? (p200300cbc70ccd00c139924e359503b5.dip0.t-ipconnect.de. [2003:cb:c70c:cd00:c139:924e:3595:3b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b71sm8795914f8f.14.2024.10.23.05.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 05:22:19 -0700 (PDT)
Message-ID: <7da9f43f-e2a8-4079-8b1d-d7b16d8f388e@redhat.com>
Date: Wed, 23 Oct 2024 14:22:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] s390/kdump: make is_kdump_kernel() consistently return
 "true" in kdump environments only
To: Alexander Egorenkov <egorenar@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
References: <20241023090651.1115507-1-david@redhat.com>
 <87ttd3t3v7.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <87ttd3t3v7.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.10.24 14:12, Alexander Egorenkov wrote:
> Hi David,
> 
> 
> David Hildenbrand <david@redhat.com> writes:
> 
>> Similarly provide a custom is_kdump_kernel() implementation that will only
>> return "true" in kdump environments, and will do so consistently during
>> boot.
>>
>> Update the documentation of is_dump_available().
> 
> A small typo here:
> 
> is_dump_available() -> dump_available()
> 
>> @@ -587,16 +587,16 @@ int smp_store_status(int cpu)
>>    *    with sigp stop-and-store-status. The firmware or the boot-loader
>>    *    stored the registers of the boot CPU in the absolute lowcore in the
>>    *    memory of the old system.
>> - * 3) kdump and the old kernel did not store the CPU state,
>> - *    or stand-alone kdump for DASD
>> - *    condition: OLDMEM_BASE != NULL && !is_kdump_kernel()
>> + * 3) kdump or stand-alone kdump for DASD
>> + *    condition: OLDMEM_BASE != NULL && !is_ipl_type_dump() == false
> 
> Here is a typo in the condition, a redundant '!' before is_ipl_type_dump().
> 

Thanks for catching these! Too much going back and forth ... :)

> Otherwise, looks very good to me.

Thanks for the fast review. I assume these can be fixed up when 
applying. But please let me know if a v3 is preferred, and I can send 
one after waiting a couple of days.

-- 
Cheers,

David / dhildenb


