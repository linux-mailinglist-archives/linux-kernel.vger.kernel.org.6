Return-Path: <linux-kernel+bounces-426090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 323309DEED0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 04:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53488B21DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125117081A;
	Sat, 30 Nov 2024 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pj9Eyr06"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98F27726
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 03:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732936246; cv=none; b=M5J89VfP2agMyoaO1YAHCzK/QuBwiyot6U8PHJa/BtVtvWiVIemyKjrmip8MdP4CGbMNVtBtRGF6i2XpSxoB+VmHWIwxHQ8im3NqCyzcd47/7BcW/Y6MvNSgl5240Q3XjMpkPd+AgBpjljBoOch5VNgOrfqm9uI93VOAYnnON8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732936246; c=relaxed/simple;
	bh=W66v085d5gVKyHXUaX13kJgveM3TdWeJ9MvrX1y0Arg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sjPMO0qZhmIVZVgPwdXJXjmWEmLeSQAFB900mNq6qdPsScUq6KTgegsAmmgsTtVdxbb1ev7JPXcftlekHcLT8+pU8dHRPuVlZnculLm+HbwgXe8qd/4VIAeZhIk+jf425mjieI3bqaJ9jyfQlD3qy5n0C5hCkD8zOIlNHuwclbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pj9Eyr06; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732936243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOXnjCDY0JN44iHDAnxciRUXAVMaFevqkOsK1oNqHfY=;
	b=Pj9Eyr06usOIhMBcy/hh9j7Kafb1U57EmDeLIuo7rVSf/8t+kYFYQERwL6ByhmAj5uE6Ah
	74HoJZiEuXtC3yJPlvmAQxI6hlv9ZXuQWNQI5ivcWg2DabEELzaOVSMc9AZp+wgGmgeOPf
	4iYh+Un/idK5yAQ5+J4SmL3+2skD8bo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-HJkb6smpNTmtK4TGnFkw4Q-1; Fri, 29 Nov 2024 22:10:41 -0500
X-MC-Unique: HJkb6smpNTmtK4TGnFkw4Q-1
X-Mimecast-MFC-AGG-ID: HJkb6smpNTmtK4TGnFkw4Q
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668c56a158so35614021cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732936241; x=1733541041;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hOXnjCDY0JN44iHDAnxciRUXAVMaFevqkOsK1oNqHfY=;
        b=WTYAdjCz9deDIj3t85w4qryGnrWycp8yq6AlwJhwmPCdTM6YNUFb0b0N26n2ZEqHbm
         kyY3ac1TIe6WL8tWhGf5wxtS/rIwylnC75tcBAO3JosnYbjGi3v3rMSvQXSBB3csKKw6
         1eeNxnDFu8jVxpQSZCmpZz9Vr43Ilspacaqzjy5RriSK3NagYFXbGEFeVgukeKgxYhtz
         gSBTQ4IoI+qS7+77x46B0ApIUnL8Kqe6zheD04z2GwCbdSpkRftr3G3ZIiOvpJoMaNop
         8y5GDGmxOVGEyfQ50tqkPIgptZmd4BExPYyWsuf9qeAjPoU1x+aifUCI7nREFCUZiO3q
         x34A==
X-Forwarded-Encrypted: i=1; AJvYcCUXsWlevL5YGo+y+Pap7uxk3yn7YraA9zQqw28OAkA8PmwmAQkPHGvyfKuIloxcz1VdiYseQoHehnS5erU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTVFOEbdGNj3OHMBbV2M2UygN7huauTt4pC6Yftci+R8rZ4gMC
	rqkn/vFeiK9Be++myu2FzeJzhTF8T4TTocSdvw9ZRwxXDuaQ+ggw4Vop6PCcetajQhEVekXcLu6
	w1g4JJdqdUPvLBKY8CiYEYbRg+Jp2GMXvGWrVQGz7UgBqNlo+jd8n1okGWUHrTw==
X-Gm-Gg: ASbGncvaBOh9j6V/0SyWTYWEkJBKQcBDjczPGU4oZnzDF9euaz8uzSs46It4ixtk7D3
	oOldLsH7dAXOT9FoaRO8s5xaSQ/LPx3G4k3lTZiUhEsY+xtBnANH8gEiA+c6SgwLJ033C9FZUey
	opdcIyf1Kuq1KmzfrECbZCo4wj/JCv+CmvMWwkEiTrCMsQkTkdbQVGfwQ238r1noXMJwjRJjxnw
	Vj4wFzY1i9L2CExKpPgwZI4WW43HfGQU/t7Fehb+3nIQBsAsw==
X-Received: by 2002:a05:622a:1108:b0:466:85eb:6118 with SMTP id d75a77b69052e-466b359c9b0mr192319171cf.16.1732936241307;
        Fri, 29 Nov 2024 19:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9tItB86qdL74N5aF6p2XyFNXIIgRWvDAF0+xR4psOzyYKpJWYqVQSWz0gNR5lyIXNoRQ/OA==
X-Received: by 2002:a05:622a:1108:b0:466:85eb:6118 with SMTP id d75a77b69052e-466b359c9b0mr192318891cf.16.1732936241017;
        Fri, 29 Nov 2024 19:10:41 -0800 (PST)
Received: from [172.20.1.227] ([70.25.108.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4252d7esm23157431cf.75.2024.11.29.19.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 19:10:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e4d4db03-1d7d-4094-9fb9-47696e7f2894@redhat.com>
Date: Fri, 29 Nov 2024 22:10:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/nmi: Use trylock in __register_nmi_handler() when
 in_nmi()
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20241127233455.76904-1-longman@redhat.com>
 <20241128092800.GB35539@noisy.programming.kicks-ass.net>
 <15662315-0332-4c0e-95c9-928329a094a7@redhat.com>
 <89cdf387-f75f-472f-9f4b-e3582d1d2c93@redhat.com> <87ttbqvuyt.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87ttbqvuyt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/29/24 11:57 AM, Thomas Gleixner wrote:
> On Thu, Nov 28 2024 at 20:55, Waiman Long wrote:
>> On 11/28/24 8:06 PM, Waiman Long wrote:
>>> On 11/28/24 4:28 AM, Peter Zijlstra wrote:
>>>> On Wed, Nov 27, 2024 at 06:34:55PM -0500, Waiman Long wrote:
>>>>> The __register_nmi_handler() function can be called in NMI context from
>>>>> nmi_shootdown_cpus() leading to a lockdep splat like the following.
>>>> This seems fundamentally insane. Why are we okay with this?
>>> According to the functional comment of nmi_shootdown_cpus(),
>>>
>>>   * nmi_shootdown_cpus() can only be invoked once. After the first
>>>   * invocation all other CPUs are stuck in crash_nmi_callback() and
>>>   * cannot respond to a second NMI.
>>>
>>> That is why it has to insert the crash_nmi_callback() call with
>>> register_nmi_handler() here in the NMI context. Changing this will
>>> require a fundamental redesign of the way this shutdown process need
>>> to be handled and I am not knowledgeable enough to do that. I will
>>> certainly appreciate idea to handle it in a more graceful way.
>> One idea that I current have is to add a emergency callback pointer to
>> the nmi_desc structure which, if set, has priority over the handlers in
>> the linked list and will be called first. In this way,
>> nmi_shootdown_cpus() can set the pointer to point to
>> crash_nmi_callback() without the need to take a lock and insert another
>> handler at the front of the list. Please let me know if this idea is
>> acceptable or not.
> That's way more sane.

Thanks for the feedback, I will work on a patch to do just that.

Cheers,
Longman


