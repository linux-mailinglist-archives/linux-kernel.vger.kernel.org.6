Return-Path: <linux-kernel+bounces-309020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263EC966547
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14CA2853C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378B1B3B3F;
	Fri, 30 Aug 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBSqsE76"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2C1B29CD
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031458; cv=none; b=NofVEKRNVgL43GkbZ0DnN138XIQ320BOeNh8Cv1qCEomvns6a66cnzA/Shy2GGmKSrb1o4e73Aulr5pmtY15RoWcrJah2fWiWhETnBZldReDSWRU3fjL6BXa6X3l5on2/GHyQRK+v9aBJz/LoPynpzOpRU084mvA1nQtRe0A4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031458; c=relaxed/simple;
	bh=cA2iD9tpTKALjsNKg4cK7d0r7NEnIc4OXL0iqNjVQas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfDaujfbnyD+gYu8T4wsJ+KXPB2rVPRplSYWjyjPUKWdVyvoNNd5BjbuXbqbvlri+Se5xKwdmylKdsarqI4tSH2h4F7vfK7YMlhC5sWmPKyCFBl9T5ufMud+3cfxpM++KfODAef/SiGkwVnl3x4KjHPzD1bfSaoakI3z2+aN/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBSqsE76; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725031456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=79jJ6MInpCkv9bFe/HpdfJmvMOKyzqf9UjYsEytN7fs=;
	b=FBSqsE76q79uGcx8aOBnHQ+cPpIMgudovfZ4XmKiDnpIbsEvD3+44wvlFo4EpStVDqez7l
	RCELZXTgDKQWTQXuoEjxIvC7orjHgepyXV1SJ6BMkjmlqltgtVC/abwQxNVC7Ef+Uu6I64
	8go3lEfG96CMGhga9kElVALFeMd2LEU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-x_YuvnPFP2uFz1NPthMAEQ-1; Fri, 30 Aug 2024 11:24:14 -0400
X-MC-Unique: x_YuvnPFP2uFz1NPthMAEQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb68e1706so17912705e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031453; x=1725636253;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=79jJ6MInpCkv9bFe/HpdfJmvMOKyzqf9UjYsEytN7fs=;
        b=P4Iya2PyWbFhLK2KZmgRH/kVIi2jdb57MnGnPUIChEtLvnEhOV4rwgzQlW5qZ5xKE5
         bfAX17Q00Yh4xLw5OZTvWzxMaXXSub1cgRJS8tCBKZ8p6EphiKca03aY7cOH7UcRHDf0
         oVNjprukqp+kARQQ1w4yPNEQQvSKb3ijvAElY9OXZ3PwBCXtJKEKvVr5TxvRwXYW005U
         QiRlrqydblZXvJVCZhAi7vfOtoQ4cKjO5PMuuA899msZN4Cq+uGUNY7eOK0LBnSqd6Se
         XxnF/dRIUSD6p1f1piSDZsrhG3j225SDXIvCnKRvgZ+0xMXKQ1HRVNR6YNFrmtXkzqPr
         MMpg==
X-Forwarded-Encrypted: i=1; AJvYcCU4uxt6Uo/a7ZjA8umHsDBJzdLm6iLlVupU6SXmxVb+cubpRqkyB5EkmHoK2AAJt3lWIhogY7SUUA5PulU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGhlPEh4tdIjbXBD5RF21e/0Ydx5q/ldk4AyYmSVmmurEMdRN
	xWG2tNNdS6S1hJrt/vEeuP2/Cqdd0nJ0onBwss+x1l4GFA45fe9W99VPBGUCqBxPWOx0WYVIl+2
	8u5qI6XucC2NiKT3TZgoRxoRaFkxhBB3QQF0HjpWV4ZA5eGRzV4MUzVF8THORUw==
X-Received: by 2002:a05:600c:1c83:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42bb0293da3mr44813575e9.14.1725031453572;
        Fri, 30 Aug 2024 08:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH4O6u4gArzc4jmU2ZB5GC5NGOYZ3pdyX/GaA15s2D874rBmYxaJ+zCxmW9GrAJ4tP/dyDuw==
X-Received: by 2002:a05:600c:1c83:b0:42b:a9b4:3f59 with SMTP id 5b1f17b1804b1-42bb0293da3mr44813225e9.14.1725031452717;
        Fri, 30 Aug 2024 08:24:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:f500:53dc:2395:6b94:fe8a? (p200300cbc706f50053dc23956b94fe8a.dip0.t-ipconnect.de. [2003:cb:c706:f500:53dc:2395:6b94:fe8a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bbe79f545sm14859925e9.2.2024.08.30.08.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 08:24:12 -0700 (PDT)
Message-ID: <fa76bdf0-81e4-4f7c-9dce-217ff8b464ee@redhat.com>
Date: Fri, 30 Aug 2024 17:24:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Petr Spacek <pspacek@isc.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, Liam Howlett <liam.howlett@oracle.com>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.08.24 13:41, Lorenzo Stoakes wrote:
> On Fri, Aug 30, 2024 at 11:56:36AM GMT, Petr Spacek wrote:
>> From: Petr Spacek <pspacek@isc.org>
>>
>> Raise default sysctl vm.max_map_count to INT_MAX, which effectively
>> disables the limit for all sane purposes. The sysctl is kept around in
>> case there is some use-case for this limit.
>>
>> The old default value of vm.max_map_count=65530 provided compatibility
>> with ELF format predating year 2000 and with binutils predating 2010. At
>> the same time the old default caused issues with applications deployed
>> in 2024.
>>
>> State since 2012: Linux 3.2.0 correctly generates coredump from a
>> process with 100 000 mmapped files. GDB 7.4.1, binutils 2.22 work with
>> this coredump fine and can actually read data from the mmaped addresses.
>>
>> Signed-off-by: Petr Spacek <pspacek@isc.org>
> 
> NACK.

Ageed, I could have sworn I NACKed a similar patch just months ago.

If you use that many memory mappings, you re doing something very, very 
wrong.

-- 
Cheers,

David / dhildenb


