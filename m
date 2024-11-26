Return-Path: <linux-kernel+bounces-422619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CECD9D9BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D87164246
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEA1D90A2;
	Tue, 26 Nov 2024 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZyTJJTAA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EA11187
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640356; cv=none; b=Y++04DX18bJWiB5qFEq9H2BmsaeToobqMXTi+GnbHN2MwMrEQ8znIamVvoYo7b3zYD+2ScCJFWR4I36brSdVprrlhxfoVb0R3V+61GHrm0d7mWDmpTaxwt6pDszsOgydLq152xJoaWdIzH3Y7ctNGRau+eUuk6vaTLyWI/3chkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640356; c=relaxed/simple;
	bh=Wwm5m98lf1T8S9SwxIBtlmeTtv/4D+EhhHes4WNOA2E=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Snm+h9KdYUJy+aKLMFOhC9WmTjvfe7Bg/RIEhiD2iG7MXFYuLZSqL1sq3pwGUuKvMbzlRc1KTsk0yXrfAcnNLOvcTsUAqKQVdwbofSd9LLcSVeTCHsjNg1nCQp2qDGgxhVXL9iS3xBSeF9mIYxK6kUpgukjLX3+EvOupbfRH5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZyTJJTAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732640353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfwAUTEkCBSJRetY/z93FAYZhUtOgtlO/ePiMJ03JhU=;
	b=ZyTJJTAABVOgxde4miSSwnSUpeNL3sdGXrf7L2dhf2uw3vr4WwApRydnPjai9mZQGB3pKY
	OGj0xc0/UXnCT1LEeEBSvD3gHppCj9QC2HZOfZcZdAU/Q/nckNO3BBKfuZuR/qbLyhp7hB
	D2ngTTBOTrycXEyY6V84mj/5lbRJ+og=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-gP1m_xFtNDy5Vvo_uNR9BQ-1; Tue, 26 Nov 2024 11:59:11 -0500
X-MC-Unique: gP1m_xFtNDy5Vvo_uNR9BQ-1
X-Mimecast-MFC-AGG-ID: gP1m_xFtNDy5Vvo_uNR9BQ
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-843eb4505e7so32593839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640351; x=1733245151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfwAUTEkCBSJRetY/z93FAYZhUtOgtlO/ePiMJ03JhU=;
        b=aeKj0n/LUKKSi46ZghZlBOvOv4TEkB+4duxFQtEi8IwLKs/l8KBMqu/CqHKSC4z1fn
         eYi0um+HiQDqkDDSel2scLsl6fG9/9D1CSXaLejR2veXiPK6DgO2lDO/qyVtni5vy7AX
         QQVI/kQx4zGjyxdp2w5ybtzwqTQ2M8VO3LnSnnRi1pR6TrbASQgKsJSKS84I+3PSpyuQ
         KbPds5Kcdad7Iy1eST2LmDgp7ZlwFePf4klX2o11N/74Ex2j0UQnuw3QJ2n0vAaKy3ED
         wLHkN+FjOOPtfKwzfeVR8gkFpE7tm9gjK38YZqtKnFJz5BrmhCMc67S564xtyHkG6tmq
         aDog==
X-Forwarded-Encrypted: i=1; AJvYcCXxzFoj/Mg/JAmyyPylT76r2e3OD4Lvf0a/+G5jM6gDg5aGXt2l17EdcdVxZHy8+7eOcx/izKOOU/O5bFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFJcMa18DFH2jBdfYgYNNwqdzinJ4M5dk9my3UnPWDTrtKXsb
	rSNbL02mmS9jbLz7ab1x/TegwQNioukSRmqX0pvAlZpycU/8IgrDjFi17FiEX6U+LM5xfKaGInJ
	uCxZMFeXLY0D8JU7gj2aFuVmbB/k/A2AHB3csrfel1plXkRpcs9WQFu2ObIX+sQ==
X-Gm-Gg: ASbGncv+KMU9347kJYWKtfm+nWYIype5BTTloPp02xFVSeLT2+tYMkl09jh2Oj7tiuN
	Ttw0tQveVD8FHsmsJ9nE5tenOrvizbYza4o7D6QQVoilSEwQwO2eUWvmONhqx73gbns1upf671y
	MoUxvofiabFHODw+o89VlVzVXR8ca4KRaeBpI7MuzQmiQEWy9Vz+EnZhhAGC4UjEMmGFepl2hDz
	4+8rcOj4SPgqAPrOZtt+Km4aCqxpkdctYibMjfR4ao3T6PnDj7Kb1WwxhsB10VUdNzQyM/P/CrB
	FReCoYIev7c6sdqt8soY
X-Received: by 2002:a05:6602:3416:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-843eceaecf4mr11257739f.2.1732640351291;
        Tue, 26 Nov 2024 08:59:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGuUIrsmpD2nyyr2nlz0r/65HSulSWQ8fTKZWOuQhPW1NivEiWGecHiw9sP62ticKt/lJs8A==
X-Received: by 2002:a05:6602:3416:b0:83a:872f:4b98 with SMTP id ca18e2360f4ac-843eceaecf4mr11256039f.2.1732640350992;
        Tue, 26 Nov 2024 08:59:10 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8419e23255asm101800839f.35.2024.11.26.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 08:59:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
Date: Tue, 26 Nov 2024 11:59:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <20241126112000.UkTwR0Iv@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241126112000.UkTwR0Iv@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/26/24 6:20 AM, Sebastian Andrzej Siewior wrote:
> On 2024-11-25 15:54:48 [-0500], Waiman Long wrote:
>>> FWIW, the description of commit 560af5dc839 is misleading. It says
>>> "Enable
>>> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what
>>> the
>>> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
>>> enabled. It is all or nothing.
>>>
>> I think we can relax it by
>>
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 5d9eca035d47..bfdbd3fa2d29 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -1399,7 +1399,7 @@ config PROVE_LOCKING
>>   config PROVE_RAW_LOCK_NESTING
>>          bool
>>          depends on PROVE_LOCKING
>> -       default y
>> +       default y if ARCH_SUPPORTS_RT
>>          help
>>           Enable the raw_spinlock vs. spinlock nesting checks which ensure
>>           that the lock nesting rules for PREEMPT_RT enabled kernels are
>>
>> Sebastian, what do you think?
> All the changes Guenter proposed make sense and were limited to sparc.
> So we could apply that. Limiting the option to the RT architectures
> would silence the warnings. If there is no interest in getting RT on
> sparc there is probably no interest in getting the lock ordering
> straight.
> I remember PeterZ did not like the option in the beginning but there was
> no way around it especially since printk triggered it on boot.
> I'm fine with both solutions (fixing sparc or limiting
> PROVE_RAW_LOCK_NESTING). I leave the final judgment to the locking
> people.

Right now, ARCH_SUPPORTS_RT is defined for most of the major arches 
where most of the testings are being done. So even if we limit this to 
just those arches, we will not lose much testing anyway. This does have 
the advantage of not forcing other legacy arches from doing extra works 
with no real gain from their point of view.

Cheers,
Longman


