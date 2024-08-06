Return-Path: <linux-kernel+bounces-275966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57211948C8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B111FB21985
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BC16D4F1;
	Tue,  6 Aug 2024 10:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPbquOJe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E191BDA8F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722938613; cv=none; b=e5E44Wh+vnw7MScNQZNeKNZ31ZY0mltlJBQyDpdCRKfro2Q3FP+oDdDV2yOyj9NH3zRIcuRC48abv+rGRmFhAvASoIP0RsP/dGfQIY1ajEmKEH22LrefqrIHfQpo1Uk/sys6BhkKQNomsj6Sz5JJeJy86IduHKT7oTyaMSfT5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722938613; c=relaxed/simple;
	bh=6VDJg2q0Pms9imKEOgl9hv5CvalODEseeH7ts3QHROM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NCzmH0BACzW7n1+zqUTo7xK2aAOAK6lYgcSeZvwzmNPt1/IR5v7cQ8+nYaT3ZADWw2CPno2REpvgpc0EAvcewHp9L55ISFEdtgfwjFRHVkCw5hc6/gOk78OxEj7rYCHAD9rNtot0eSB30sDX+Si1hlVFVKvGs7DJsQRH8nVBT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPbquOJe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722938610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bgKUr6jif0ys53qB1n+utj32ZaC+P0IMdQH7NvSw5o4=;
	b=KPbquOJenIGbQ5QojTygFqyxOyDZVmbPNYdqydefFM/vg39uTSY8gcTFo5p4nGYtcnMy1g
	bOHU6v5hF227/JFefJyz/uW3IClB55tD4TFZTH7vPIVBnSm9jkHg+/o3JlANFLdtIpp+S+
	AWGQb9r3oFy1kCQJo4FPxfiBLLKz8Bs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-X3bcqgWUPkqSUW5PNY3V9g-1; Tue, 06 Aug 2024 06:03:29 -0400
X-MC-Unique: X3bcqgWUPkqSUW5PNY3V9g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef2a44c3dfso4358881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 03:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722938608; x=1723543408;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bgKUr6jif0ys53qB1n+utj32ZaC+P0IMdQH7NvSw5o4=;
        b=AjQPHtpGP2Z5NOqThjKdPZfWZEFQ3yGBOpx5eE8WbiFgpg8wKoV1t0+rT4EPo95oHo
         XQYycj11mztX9DqvDK3NcgyqwHaFuTRGIKzuihxbHanCvmFt7n/5b1eCrrFWL+REgagP
         O6KUxPGIWiFHm/+Fm9QraTPTlfElia4z3xVgWS3nZxSOHh8plxatV0ACLSbXaOsWzc72
         99iz7zNuvybMC8KPzoq+NJ0ZPDPsNvqP3oEjTloEqcDZ0Nd+taBZPkWb2oFQCcY2urKE
         JDYmatY+6c7/alY7Pm9X201kBLRQ/HDohk1Kd0xPioda/E90LYOrrCokTprZNjFWJAHG
         s5LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfZzHjyMQd1aJTsZaZAZnVZsw5Lqg9OzBJxhUDnYfstoqT2Q2dyqi2y0N3lsbAGs3FfmB4K4QG3C+F1bqfFTP02DYm+0NA9iHFg2Wy
X-Gm-Message-State: AOJu0Yx4FWcZLmtSH91vDhWcpGkNna9qJwpl2X0XNTpJAFYe62vc26gB
	HEY30rTRYHVBJ+Sucpf3kR+aCBLggtiHIhPvIjYfr4+XDNRANvDsLOYYGz6MreKGpa72jzOmZvS
	GzNknoP0Nd0LOBE0n/2pVhadorGC4HZ/FnE7CBIf8y2YWJymQPv3I2gqmQ1TuHw==
X-Received: by 2002:a2e:914b:0:b0:2ef:17ee:62b0 with SMTP id 38308e7fff4ca-2f15aa8368bmr102971091fa.2.1722938607752;
        Tue, 06 Aug 2024 03:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDWpK1rNaFPNuP9VBsXJMe+hBHNj54PFw4G+1WArEqaTVBZhlXcvM1Mh3AkfAZC1X5AtJ0zQ==
X-Received: by 2002:a2e:914b:0:b0:2ef:17ee:62b0 with SMTP id 38308e7fff4ca-2f15aa8368bmr102970681fa.2.1722938607189;
        Tue, 06 Aug 2024 03:03:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:8500:f83c:3602:5300:88af? (p200300cbc73f8500f83c3602530088af.dip0.t-ipconnect.de. [2003:cb:c73f:8500:f83c:3602:5300:88af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8ad9ddsm234729945e9.17.2024.08.06.03.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 03:03:26 -0700 (PDT)
Message-ID: <a5f059a0-32d6-453e-9d18-1f3bfec3a762@redhat.com>
Date: Tue, 6 Aug 2024 12:03:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] mm/huge_memory: convert split_huge_pages_pid()
 from follow_page() to folio_walk
From: David Hildenbrand <david@redhat.com>
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Mark Brown <broonie@kernel.org>
References: <20240802155524.517137-1-david@redhat.com>
 <20240802155524.517137-8-david@redhat.com>
 <e1d44e36-06e4-4d1c-8daf-315d149ea1b3@arm.com>
 <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ac97ccdc-ee1e-4f07-8902-6360de80c2a0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.24 11:56, David Hildenbrand wrote:
> On 06.08.24 11:46, Ryan Roberts wrote:
>> On 02/08/2024 16:55, David Hildenbrand wrote:
>>> Let's remove yet another follow_page() user. Note that we have to do the
>>> split without holding the PTL, after folio_walk_end(). We don't care
>>> about losing the secretmem check in follow_page().
>>
>> Hi David,
>>
>> Our (arm64) CI is showing a regression in split_huge_page_test from mm selftests from next-20240805 onwards. Navigating around a couple of other lurking bugs, I was able to bisect to this change (which smells about right).
>>
>> Newly failing test:
>>
>> # # ------------------------------
>> # # running ./split_huge_page_test
>> # # ------------------------------
>> # # TAP version 13
>> # # 1..12
>> # # Bail out! Still AnonHugePages not split
>> # # # Planned tests != run tests (12 != 0)
>> # # # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0
>> # # [FAIL]
>> # not ok 52 split_huge_page_test # exit=1
>>
>> It's trying to split some pmd-mapped THPs then checking and finding that they are not split. The split is requested via /sys/kernel/debug/split_huge_pages, which I believe ends up in this function you are modifying here. Although I'll admit that looking at the change, there is nothing obviously wrong! Any ideas?
> 
> Nothing jumps at me as well. Let me fire up the debugger :)

Ah, very likely the can_split_folio() check expects a raised refcount 
already.

-- 
Cheers,

David / dhildenb


