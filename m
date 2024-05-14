Return-Path: <linux-kernel+bounces-178895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8F68C592E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830FE285A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AAE17EBB9;
	Tue, 14 May 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sk8Lvnh+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB717EB82
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702289; cv=none; b=NIt9QFM/rHE/O4P/VmgR8jKOBCCOZOK20gxnqcujAmr7SSQGireCqWxk+I0w4DSwUSptXiT8xYdba18uzwnqci4oUjCkv03WMg4AYHyw20KZ3jpjx7nPVVBQbFWFq7HA2IJVaclLgN5tvbC7ZLIgcyZ9BBeZPNm4vGKTdcpiulw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702289; c=relaxed/simple;
	bh=zT17jq1ESsKCxuHpaoXUkdMPkR4Exgf3s7RzFjUHYtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUYnlGDv62RU0vef7bTbVXQnxoGK/LajBOpwpd3Y7lyg1/jogp+JUNsx0FxyWCAOGhUmwfjmToBn518mm33H9D4TBNxbajNYA8bt+1EHZwPpDPt2bw2CriP3R5I+2S/9ZO7LZ/9zIooTzD1GkVYxrDeh6VQtu/4HomP1lCnh2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sk8Lvnh+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715702286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bqrlRJNafQyJHdgH1KpdNVL6dTLfmVAhQ2Ho9SfW90E=;
	b=Sk8Lvnh+QoG6VYyYCdLEnhJ6uFet6CJ6fGfQhghEz6q2ZF3U6U9MtLkXI4Mlok1HCIIs30
	cJFUL7D20T4EpdFL6XU8m8T/aqufHss8zcMVSZW8M/rRLczLSQRRuaAuZYTx9UirhOS05O
	kGWvY+qDhTEi3RoDPLBvNOi51Gp/+u0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-mjZUxC5fO8aD9mJv8LbWJw-1; Tue, 14 May 2024 11:58:03 -0400
X-MC-Unique: mjZUxC5fO8aD9mJv8LbWJw-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so5256288a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 08:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702280; x=1716307080;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bqrlRJNafQyJHdgH1KpdNVL6dTLfmVAhQ2Ho9SfW90E=;
        b=CWU/Fl5SCi69IqHqOvEwRQzz7Xug6Gq2zfWmAjJRysDruMJQtvzh4BLDQmL+SYuDbP
         VPBcH56XzOdi1hot4Uq+7zYDi7lWZ4v+US6FZZH7866hcggClE7kYVy4xXC1M8MPsFIG
         MNwud0PxsLIqxmShwXK3S70qM6udj960X1xKfx10aeA+3mYEU0T1CG/8P7/Uf8bLfLTj
         BRYk/opgd1JD90gZMOh0PtoQpsIPzM+mAH0DQqVDkt0GLMzNj/Nl/8yMkWc7TOCMeS5F
         Tom5Pp5podbpSyHB+y7QlrGg/Ml7xB4d2aij4krbpdkI8hgHZrKbiO4k1VXfGcc6R+pF
         x2FA==
X-Forwarded-Encrypted: i=1; AJvYcCVvGPZcjSJU3Wa+nPYSGvJvFO8mnKdjX9zMeSHTR8pdf65W/cnlREBBhOdqmaF4dx+mBJUbpnyr8zechzcxeiNOVeJ+5iv1kXZE4sGM
X-Gm-Message-State: AOJu0YygX+G/7UQ9qnKARgOtdhhEKXmXqnUk0j4Rl/7Ggl/rsXlHPqYj
	vlf2JMyePHM9nmJXfWXspCJI3vOOc/KAHGl0xp0Y29aXp9QD9A2klYEXwIgXIwCAgDc7YekvMnT
	frTpxCIxLObi7G10v0BEbeiqsrUMfAk6RjtElh772HmTS7Ld7SuKUV6mm2YgB4A==
X-Received: by 2002:a05:6a21:789c:b0:1af:cecb:b64a with SMTP id adf61e73a8af0-1afde0af156mr14024885637.9.1715702280311;
        Tue, 14 May 2024 08:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOA4+iNQa1n9S/4UBr9eFOf508dhs/YigFAhH1ZwBGEa7xJs3zDQZQrZfPqFxkb+kzuHIqFA==
X-Received: by 2002:a05:6a21:789c:b0:1af:cecb:b64a with SMTP id adf61e73a8af0-1afde0af156mr14024865637.9.1715702279879;
        Tue, 14 May 2024 08:57:59 -0700 (PDT)
Received: from [172.21.1.2] ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b1b1d13sm99438985ad.0.2024.05.14.08.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 08:57:59 -0700 (PDT)
Message-ID: <a8571d06-67db-450a-a3e4-d5bc9350a9ab@redhat.com>
Date: Tue, 14 May 2024 17:57:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Catalin Marinas <catalin.marinas@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
 <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
 <ZkM_WXxEQo51mrK5@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZkM_WXxEQo51mrK5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.05.24 12:39, Catalin Marinas wrote:
> On Fri, May 10, 2024 at 10:13:02AM -0700, Yang Shi wrote:
>> On 5/10/24 5:11 AM, Catalin Marinas wrote:
>>> On Tue, May 07, 2024 at 03:35:58PM -0700, Yang Shi wrote:
>>>> The atomic RMW instructions, for example, ldadd, actually does load +
>>>> add + store in one instruction, it may trigger two page faults, the
>>>> first fault is a read fault, the second fault is a write fault.
>>>>
>>>> Some applications use atomic RMW instructions to populate memory, for
>>>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>>>> at launch time) between v18 and v22.
>>> I'd also argue that this should be optimised in openjdk. Is an LDADD
>>> more efficient on your hardware than a plain STR? I hope it only does
>>> one operation per page rather than per long. There's also MAP_POPULATE
>>> that openjdk can use to pre-fault the pages with no additional fault.
>>> This would be even more efficient than any store or atomic operation.
>>
>> It is not about whether atomic is more efficient than plain store on our
>> hardware or not. It is arch-independent solution used by openjdk.
> 
> It may be arch independent but it's not a great choice. If you run this
> on pre-LSE atomics hardware (ARMv8.0), this operation would involve
> LDXR+STXR and there's no way for the kernel to "upgrade" it to a write
> operation on the first LDXR fault.
> 
> It would be good to understand why openjdk is doing this instead of a
> plain write. Is it because it may be racing with some other threads
> already using the heap? That would be a valid pattern.

Maybe openjdk should be switching to MADV_POPULATE_WRITE. QEMU did that 
for the preallocate/populate use case.

-- 
Cheers,

David / dhildenb


