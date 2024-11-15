Return-Path: <linux-kernel+bounces-410938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBBC9CF0A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7712925D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527E1E261D;
	Fri, 15 Nov 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3zkzqqW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5F1E25EE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685476; cv=none; b=mIyjxsYRHKqwGyPpbNQUgSIpQwUs4eo9Apsm+BitJsl6qATmo/4BrhGleklzRfylBu0ndTFY9JgdUO5W4iobcGzTZjnfPom91DHdVSl3+AWKaBSBhwzyW3EflUEDL73uddZ2SrAY7f1R5l7yJLfK1ehhpzTybgMXOxtu+jJuhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685476; c=relaxed/simple;
	bh=0pO3muSUYd7BCyJ+m8v8xzHdvk4SumDySs7N0eLzt+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DCcBWQCbbX2NUbSLKm5VOYS4+vf6u+ijL72gxPy1a68kHI0IiK4i8zCeIX+QFTPL+LaJpry1aEBc3H1pf0qaQF/IccBpWgnBPrvJoOS+fMdGreE6BTHGlchJfdIeRE9H1xIKdxwsS0sMip+RJRwaeI2xwFOBE4Z/Y1gYQg3f9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3zkzqqW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731685473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=paUdXD1BpR6sZOqYQvfJv0RARkZ9Ys1bkkJEF+QBuO8=;
	b=h3zkzqqWGFOhHpcBWiAJxGxO7AwJBpbkbzA7pqGMlpCtPAlXy7vAyM0h+/2QfDLMhs7XbK
	zvlYwRdbxvVgaNVDXM/QhGLRXUe5YQuFO+bV7tD3WlKrKmv/wDBfvncZEzamA7ha6CR5WV
	qdtdLk9xElhR7dQJuR2jOIsi9kyqLvU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-eNO_8DDsO5ClC-UFlwBN0Q-1; Fri, 15 Nov 2024 10:44:32 -0500
X-MC-Unique: eNO_8DDsO5ClC-UFlwBN0Q-1
X-Mimecast-MFC-AGG-ID: eNO_8DDsO5ClC-UFlwBN0Q
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d56061a4cso1077573f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731685471; x=1732290271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=paUdXD1BpR6sZOqYQvfJv0RARkZ9Ys1bkkJEF+QBuO8=;
        b=gJa21Fzpo/ufzjUf8nS8IGG2sQj9G77p7LphATGWXzNkel7lY4FUUyAWIgpjjoZZsR
         VeY5NMwn/yXAaM98xSdNhHkeeGJMhuALrdoZN4kD59XBJvmptHrTGxoiO8JtFkQ/YG3w
         RkhGzhvexjWulCTGBTOz9p5PhK0r/pw4EitimqF4hUT1i21+lJXPl8CvaAXEFIbddK+/
         L7QMpUOeNsf+pB5P9AZ1+HHymaTWR3lrOwm+z7Z9SEXXGhyfY8kSYSktH+8MUL8TS8fz
         YnRxzCL2ihIM76nJzxxDPP1n62jR/yJmu8TbtMUOvaFPTTKiFdf/fUlp73bVPWGBhtbp
         XJMg==
X-Forwarded-Encrypted: i=1; AJvYcCUKNLHLAPc/LqNTQIHTyn5A3oUcLQvmrE7741qL0opiUY0Yojy8jNDrWGLppuh+m5aqGG4leEb/9twTqx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysodNMccIB1QtYZcdUMLiSAil0yp3U3gpfysLGLeaK9Dyt3Aof
	j1d+3CxPZ4FBCqOA5CJoXi8FEhgU8AqsX1Bc3+7kfPmyA0UusJuHtIaqHimOznDrw4htKNYAvTg
	jeuTheOtHKK5A671qBvsOpxt1Rt8v8lvQmyDTWp2TWwPKL8ncgW+rzbBh8/J0Qw==
X-Received: by 2002:a05:6000:1866:b0:374:baeb:2ec with SMTP id ffacd0b85a97d-3822590780fmr2529764f8f.19.1731685470965;
        Fri, 15 Nov 2024 07:44:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETahaIV9mtTGvxFkCPLrOgQcTAmwN2Stx5iKuksJH04zsnRBNKB/Jkw4SihSPWybIjWyLFCg==
X-Received: by 2002:a05:6000:1866:b0:374:baeb:2ec with SMTP id ffacd0b85a97d-3822590780fmr2529751f8f.19.1731685470575;
        Fri, 15 Nov 2024 07:44:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c721:8100:177e:1983:5478:64ec? (p200300cbc7218100177e1983547864ec.dip0.t-ipconnect.de. [2003:cb:c721:8100:177e:1983:5478:64ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3199sm4659986f8f.22.2024.11.15.07.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 07:44:29 -0800 (PST)
Message-ID: <0387fb65-7c90-4766-9b9b-a4fb77709837@redhat.com>
Date: Fri, 15 Nov 2024 16:44:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Support large folios for tmpfs
To: Daniel Gomez <da.gomez@samsung.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hughd@google.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, ioworker0@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1731397290.git.baolin.wang@linux.alibaba.com>
 <CGME20241115131634eucas1p2db22b75fcc768a4bb6aa47ee180110cc@eucas1p2.samsung.com>
 <D5MS4CMG4N8F.1M5WPZ1T5UT0I@samsung.com>
 <3269e0a6-29a4-478b-842a-629efc8d5d59@redhat.com>
 <D5MV2HU1QPLI.1P2HM7OTCR997@samsung.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D5MV2HU1QPLI.1P2HM7OTCR997@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.11.24 16:35, Daniel Gomez wrote:
> On Fri Nov 15, 2024 at 2:35 PM CET, David Hildenbrand wrote:
>> On 15.11.24 14:16, Daniel Gomez wrote:
>>> On Tue Nov 12, 2024 at 8:45 AM CET, Baolin Wang wrote:
>>>> Traditionally, tmpfs only supported PMD-sized huge folios. However nowadays
>>>
>>> Nitpick:
>>> We are mixing here folios/page, PMD-size huge. For anyone not aware of
>>> Memory Folios conversion in the kernel I think this makes it confusing.
>>> Tmpfs has never supported folios so, this is not true. Can we rephrase
>>> it?
>>
>> We had the exact same discussion when we added mTHP support to anonymous
>> memory.
>>
>> I suggest you read:
>>
>> https://lkml.kernel.org/r/65dbdf2a-9281-a3c3-b7e3-a79c5b60b357@redhat.com
>>
>> Folios are an implementation detail on how we manage metadata. Nobody in
>> user space should even have to be aware of how we manage metadata for
>> larger chunks of memory ("huge pages") in the kernel.
> 
> I read it and I can't find where the use of "PMD-size huge folios" could
> be a valid term. Tmpfs has never supported "folios", so I think using
> "PMD-size huge pages" is more appropiate.

Oh sorry, I completely agree. Yes, we should use that.

-- 
Cheers,

David / dhildenb


