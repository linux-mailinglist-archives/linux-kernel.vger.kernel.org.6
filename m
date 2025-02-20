Return-Path: <linux-kernel+bounces-523845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4900DA3DC00
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C7D18830E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3D1A8F94;
	Thu, 20 Feb 2025 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZT608gIv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8D1BC4E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060190; cv=none; b=ciGNm6/+nEqNBiCVIyYCUo5gEDAEIGBACqChKW0Usuab0Yh+gppzD3T8i2WdJ1j8SzBqey38gtRS6eXBp6Fh23ggaePbE/aNbo1c51RLdHnjaUwkrsGhW0rcMdfy0CMBcUR6CmChaMJhtWhyCdxf3p0qjHPljC2JCwhJ1M/ifE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060190; c=relaxed/simple;
	bh=gXzeW9ai2Guvh9itt6p63XE/2CTBTxu+cwAc1m7lmts=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=l4QkJuNfl+bmUGXtG9IyxLHBiME6KzO3CJb9Yso1nqhCfGv6vlZMfrRyAF6b+I+rB71MpTZDO2+BKkvh8GOpOnkh4TlCaC6UsX+bYXX4EhciEE03YtJz5iOg5Trz8vqGPN308h4buDHB6ZjGAA2IeRpezeDNTxShRPv8RJBuUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZT608gIv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740060187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CImvjXTICIHMBGvZGwt/ho2nn0DU+r/iFE+ZRJOiir8=;
	b=ZT608gIvl+yO7YetxTHeQDmWkJd0WtVoCzFOdJsQlAIung1fayml3rYBznRmMOLcizlosd
	UwDMHJzbQ5OSfCrttINH3shLZEVnF5QSGorrSPiRAmhuLrEa+LOPryMEbgd7ihpTDdlyzc
	wyimQunwZEGMY1Wn2E07fYESz3/b4G0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-7l58sPZJNzC6zVRfozgVBQ-1; Thu, 20 Feb 2025 09:03:06 -0500
X-MC-Unique: 7l58sPZJNzC6zVRfozgVBQ-1
X-Mimecast-MFC-AGG-ID: 7l58sPZJNzC6zVRfozgVBQ_1740060186
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c09d661887so97482385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060186; x=1740664986;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CImvjXTICIHMBGvZGwt/ho2nn0DU+r/iFE+ZRJOiir8=;
        b=Zcux9Dh7ZzrOyvwjN3zrMp8Bi7w1HHZhdS2Efza+FjmLVMvIy0owSRvSlURsHvJvoo
         IJ1vMtpf+lT1t89oku+EEkQ8tBLT0BRgH3O6XqJQQvqIhl5ifDZl8NISVYWkoJl6ggVN
         KX9+OI/0df5AOgi6E02Jo2kCgG8zNUtG2LQYSZ/nWo08vIb7Q+E50mYNRxCTkRHWad+S
         rt+bcjQDSxh/w4Ni83ajWh6/mOC71W2uu1yVPN6GRjMHqASn7myP9CR8H5cAHe7D0EJ7
         AGT+wdtXa+fmhXElmELMfo0Re1RrVFnqqKQzg95x9OgOlkXgGNBBtEr1PlL4bNpzof1R
         qogA==
X-Forwarded-Encrypted: i=1; AJvYcCUcwJ+BEPI+L2kU1ShS27JsIuJKkEzZA08DMk5hDWN7NyOsCEk0AtECEF6zF3G0uHgBMWXAucCVsXikMnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ANV7dHhc03VmynyqsAkZbpG7IZODsE8+dxgGFuVmCJppG/MG
	bB/aH/FS8HaA0adjN0eoqo9VButVOPSECAgruNrs3A14ZcND0v3QTy3wnIcA6aG/3wgwvTvmEED
	YxMAV/8QeTUdp1imgZgh2QGJ7B67oYPYqrDtX7NJk9mVqRLSLK8OqH4Udp4r9CA==
X-Gm-Gg: ASbGncvw2YgmBNt1hcheSb6duWhX89VLf+ZefEoWXP4iD/awM641jNJhoFS/94BAQ29
	avQuZt4ezO8oOnwd/RRTy25eh2rbUEs+5Fz74D3GnYpNOBp4wmg+v0jakJAdPGwDKHPDCWCBY4m
	nMv0GV7BOjAwkhCEx0QsYmfi30yfF1TXbZtLiPN/aDKyH4cu/oxCLphzeENuBX/w7PMl0Omyel6
	jG/5CMqeeMaW3bd/5nsIZh6GGHUPO1oZEI+Gwj8jAZSqU+KsvSPmVj8ayL2DySWTY3TD+AVJefR
	XZoY/dRZBis3gn7mjRIBowrjQGS3V1Wp+YzA6UYfEXezpkGH
X-Received: by 2002:a05:620a:298c:b0:7c0:aa35:c3b7 with SMTP id af79cd13be357-7c0b51d5234mr971500385a.12.1740060185549;
        Thu, 20 Feb 2025 06:03:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH42gERnMKf0oupG97P66/YsA/i4VDnJAXrFhXYRnk+HlcvSmhDenfdx1QansA6igg+3HuYDQ==
X-Received: by 2002:a05:620a:298c:b0:7c0:aa35:c3b7 with SMTP id af79cd13be357-7c0b51d5234mr971497185a.12.1740060185195;
        Thu, 20 Feb 2025 06:03:05 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ad774f81sm321685485a.37.2025.02.20.06.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 06:03:04 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fdc09769-0595-4d45-9d6c-18ce7e98535d@redhat.com>
Date: Thu, 20 Feb 2025 09:03:03 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: add MUTEX_WARN_ON() into fast path
To: yunhui cui <cuiyunhui@bytedance.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250126033243.53069-1-cuiyunhui@bytedance.com>
 <CAEEQ3wmk5jBOPqD-5GUZ+463mcG919uuKVnBJrWedKLssVDBaA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEEQ3wmk5jBOPqD-5GUZ+463mcG919uuKVnBJrWedKLssVDBaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/25 7:49 AM, yunhui cui wrote:
> Hi All,
>
> Gentle ping. Any comments on this patch?
>
> On Sun, Jan 26, 2025 at 11:32 AM Yunhui Cui <cuiyunhui@bytedance.com> wrote:
>> Scenario: In platform_device_register, the driver misuses struct
>> device as platform_data, making kmemdup duplicate a device. Accessing
>> the duplicate may cause list corruption due to its mutex magic or list
>> holding old content.
>> It recurs randomly as the first mutex - getting process skips the slow
>> path and mutex check. Adding MUTEX_WARN_ON(lock->magic!= lock) in
>> __mutex_trylock_fast() makes it always happen.
>>
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>>   kernel/locking/mutex.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
>> index b36f23de48f1..19b636f60a24 100644
>> --- a/kernel/locking/mutex.c
>> +++ b/kernel/locking/mutex.c
>> @@ -143,6 +143,8 @@ static __always_inline bool __mutex_trylock_fast(struct mutex *lock)
>>          unsigned long curr = (unsigned long)current;
>>          unsigned long zero = 0UL;
>>
>> +       MUTEX_WARN_ON(lock->magic != lock);
>> +
>>          if (atomic_long_try_cmpxchg_acquire(&lock->owner, &zero, curr))
>>                  return true;
>>
>> --
>> 2.39.2
>>
LGTM

Acked-by: Waiman Long <longman@redhat.com>


