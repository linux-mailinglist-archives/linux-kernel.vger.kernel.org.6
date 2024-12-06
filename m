Return-Path: <linux-kernel+bounces-434351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291419E6558
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D737F284A19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07718FDD8;
	Fri,  6 Dec 2024 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrJZSCnP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6FECF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458574; cv=none; b=jbY8V/8B0DfJLHPaALYL+m2br7Sm3PnbPvJggtFwmokitsQbVxa4Hj6JipKjz+xF4rGdC8lfrIYVR/pdJ4ONpi2YWdcgn4YMaLE0WguQdE2R6EsBliSSRqfvxoqkla3OX9sAFYl4VORkP+mgewJs6rALyotvrXbu5kgzqucBams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458574; c=relaxed/simple;
	bh=TNFqmVd1z78dgLfuqGyutcyen6nVLw52mmErF2wMABU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q4/QBp/DSoctJEA97cfBBt/xKfkaoO62ePEpG3PoW1leZJxvbEMoR1H+q165TnClk3golSUqfc6oqtgAuZ9pCLM3amerXNK41vtmEQmXS366DIbDZd6XY8eW89CZhf4m7you0HiM8I1LEeYbtexpH6KnEhu2Dxy0HXxOYQvNw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrJZSCnP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733458571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrQxEZbTUg5YENyUBfVhcYyO8YFCyviVW1TghA3uX1A=;
	b=MrJZSCnPns0CPYf0SlpzZsggm7HNHssKkWcYfp+49/MVGmP78GN+cdlL+CGuCJH55moydC
	hnbjSCXHG0fMKIQnvhlPr98MBFseOsuo6lhIovhPiO0LClbvKh7HL2amihqu9eTGFfao4B
	gzYub04V4qv181F7gq43yMuKu89ohgA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-0wlyFlPEOcq2qfHioXdN2A-1; Thu, 05 Dec 2024 23:16:09 -0500
X-MC-Unique: 0wlyFlPEOcq2qfHioXdN2A-1
X-Mimecast-MFC-AGG-ID: 0wlyFlPEOcq2qfHioXdN2A
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-841a54a6603so270432139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458569; x=1734063369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nrQxEZbTUg5YENyUBfVhcYyO8YFCyviVW1TghA3uX1A=;
        b=XwjkrQsXHvnPAj2pfc52nSu3pr8vlY75O3m/oNw9rNkgX7oaJap7eMihztv7bv8JdU
         I/KNPwyGq0fXqG8FCdMCtyseP0zJsgIgKlNyRzOzUCiryB3cE+HnJ/1eyZIKdmMchEhf
         wgV5WQQRunCoyeLRLN+UVo7wNJGL/lob47yGW2okRpO/OB4PEnPKXNAdGeINETMGLBAE
         ifD1t+0Gvxwh/SOGBBNZdZOfc00QvfKBKePbmRN23SDL3GAsf5Nu6AbPSeeWVB/9lYK5
         Op+XrqgRbcQAcO/3GnuIKg16OL5UOcuAmTnz4do9LBqjpG7+S5eul5mCL8dncWTJIO8K
         VeOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7f9vpPJkiaVUVN6bptOI8VcdIg+C8/Usp0MT5p8GQhTGTQPfr/AptHYuUuGCFDjvoy5XLDnrN6dNbK6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xdkq2l1hFaJtul5MvnM6qjE+EfmUToa7ejDbIc8roqqw8aQO
	dPa/7SZZomRZ6YvFAU9Iwl8xq2+UV90u+fSVmx6HN4cFPZOZxEclKKNfa8+7tl8pnOsCqzaqLtu
	0mI2IXwm3Gg08AwPcjupoFP4xDTW21qlgizPJu4ltu7I05bYvnOBxQgHDUeKVxg==
X-Gm-Gg: ASbGncsSpvOIWeP7xtabRPjm6a2IXzDUjq7ZP2LxNjV1sM0AU4pAK3RirLKNXgwuEHz
	nlVRAi9/1CABEAxpktVzUBHqi5wH1aUV/xexGDtejb3RM5wsZ24rHs2LX8KaDOPTS0f9fSJTRlA
	84XEKODlcEnn8CtfQf5UNqZFe9dg23PZC3cm3cSAfCpR/rWh1JusCzYSqrYY9x797G+D6Cx7D5m
	x8BFXWGbrhD/QzNEAXYBo1kctsjNfZOcL0jCHgncCbPHSbcWHmC8X3Lj7boI6y6OjiMDdta0Npr
	fbWdt9AE0XM57cdZGw==
X-Received: by 2002:a6b:6511:0:b0:842:ff2d:c3de with SMTP id ca18e2360f4ac-8447e202021mr197685239f.1.1733458569243;
        Thu, 05 Dec 2024 20:16:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0Bs82cM/Ko+/M6IR6+M4jXgYgvLe/gTvzwlAGtStp6ZOPDaz/p4QComdQBSWOFynJZ0DwxA==
X-Received: by 2002:a6b:6511:0:b0:842:ff2d:c3de with SMTP id ca18e2360f4ac-8447e202021mr197684439f.1.1733458569014;
        Thu, 05 Dec 2024 20:16:09 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e286222bbasm626371173.149.2024.12.05.20.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 20:16:08 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <55b5441a-6323-4ec7-aafc-f00af7e85707@redhat.com>
Date: Thu, 5 Dec 2024 23:16:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/nmi: Add an emergency handler in nmi_desc & use it
 in nmi_shootdown_cpus()
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20241203150732.182065-1-longman@redhat.com> <87h67jsif0.ffs@tglx>
 <7aa93137-4b5e-474f-a99c-47acffdf71a3@redhat.com> <87zflbqqar.ffs@tglx>
 <59b254dc-acf6-4114-b6b4-a7ae517bfa06@redhat.com>
 <9765a61a-e832-4491-af02-97b8736411ef@redhat.com> <87r06mqnnv.ffs@tglx>
 <1166fd72-8a4a-489f-9de5-7c06b70b0ad4@redhat.com> <87ikryq9ik.ffs@tglx>
Content-Language: en-US
In-Reply-To: <87ikryq9ik.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/5/24 1:17 PM, Thomas Gleixner wrote:
> On Thu, Dec 05 2024 at 08:22, Waiman Long wrote:
>> On 12/5/24 8:12 AM, Thomas Gleixner wrote:
>>>> Actually, crash_nmi_callback() can return in the case of the crashing
>>>> CPUs, though all the other CPUs will not return once called. So I
>>>> believe the current form is correct. I will update the comment to
>>>> reflect that.
>>> Why would you continue servicing the NMI on a CPU which just crashed?
>> According to crash_nmi_callback(),
>>
>>           /*
>>            * Don't do anything if this handler is invoked on crashing cpu.
>>            * Otherwise, system will completely hang. Crashing cpu can get
>>            * an NMI if system was initially booted with nmi_watchdog
>> parameter.
>>            */
>>           if (cpu == crashing_cpu)
>>                   return NMI_HANDLED;
>>
>> The crashing CPU still has work to do after shutting down other CPUs. It
>> can't wait there forever without completing other crashing actions. The
>> only thing I can see we can do is to return immediately without
>> servicing other less important nmi handlers in the list.
> I understand that, but in case that the crashed CPU receives an NMI and
> sees that the emergency handler is set, shouldn't it stop the NMI
> processing instead of trying to go through perf and what not when the
> system is already in a fragile state. i.e.:
>
>         if (emergemcy_handler) {
>            emergency_handler();
>            return;
>         }

That is what I suggest in my last sentence. I will update the patch 
according.

Cheers,
Longman


