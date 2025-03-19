Return-Path: <linux-kernel+bounces-567934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43CA68C22
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E62C7A4085
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5C2253346;
	Wed, 19 Mar 2025 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="nEVsswCr"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA352512DA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385088; cv=none; b=tAEqmSbrs687zuodvS6r5EqsHSJzbLP7v1Bip5QOOesn/8e9GclS5/luURaOEPB6DG9tQXEU3NbJoxeGFEWJQ7Aj6YE+/ETepfN/NQHQEitJrjajC0kVUdSyAyELMiJvyaKwbXlGDOrbN3GE1Xn95UZQtH7LR0PfyQl89h3kezg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385088; c=relaxed/simple;
	bh=/l612sg75Uja1o1NjiZ0/+cOeL1Yx5rIICdOKYCvLtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9vEzQ+tdoUS6WK5G+U3Y8rKpLpcBD8sC7mDHG0lZ/n3AWcFqkGSjZRp98GQtpLQKh+5aVme0BaG1Qnl/o4LIFd4o7fV5RcoolAkcAPCL3BgsVUSJZJRQex4QOJASDNiv1wvbAWafKoZIYvc1GPDACfazTqRSJ0z5o1WRX5U3H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=nEVsswCr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so7386278a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742385086; x=1742989886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XjuEqbxb70zWO25+d3tN3N8uLlo3z0B0itj0TevOYE=;
        b=nEVsswCrcWRimVv3IX3EyzIPGIVc8rvOo5zns541MPSjCPgajAdlP/xeNuNjDw0UnZ
         IlTSxzkLtCvgyHJRbw8ctiVflPmFo2F7ZQmPDnOgbJYg+O0w+6MoNHoB/bHUQkP0e7BN
         yA2Skas9WigRMJgsOSg93nBGZ0oPakKnUV7LGyxeoqAHp0ULwr+1Ex1vXt7A5ytbYVwJ
         G0SPWt9acvq/j6m1PBGyB0M6CuH6SBJpSZjbWgFacmYIjoafCajy1WJsGYdcvnsmbbf5
         FRqCzh4E4QsQfTDutwheIrpi6HmdOPVp1a+uueFglOZWf2sZZxVpiMAvwHx2ibLW+M4N
         Kpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385086; x=1742989886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XjuEqbxb70zWO25+d3tN3N8uLlo3z0B0itj0TevOYE=;
        b=a0dbzmyMwbmY6V0RKBuin7PN7WTm7i/b7dZGkbSPhdmySjfFQa0D/lRFkWdWas6Vzh
         I6PCaotSCiMF5ed0hXsCLSwidLsQVj1Q/RqWjkeKuKMa50WPqD7t/rtmVjIEPn+K2EYb
         4xamsR736EHpg+Y3N8ROkn5ujr+eioz2W64ZSn0VNEe9qCPkjMJg4C6MQ2i3cVI6Ymli
         w2xVUMUOyZKdc/DW6zgRMiTD7YsjykJhCIDGgZzQGbzC+nB83+CPRA/alwtzboui1YAE
         vpqH1XfOB0A1ORDyXgdZt65qdnb5fzt7SXygRmc/cieD43clMps6o+0E1lWki9OMfWoR
         U8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3tIdzEFKO5xpHfYjMx9GznBnJUjNcOIGv18gIwhuIhWO/ZFSQZ3D5Q58iBjQRiKriolDRMYuslJQIIuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcGuoytWsbFHFzsnEMa5dkRDdUXC7mbz/Eq+pCNm7356go9kb
	Ep7zeK/LOh5OCsWvG5HKVBk5hflkFGwJYq5LhILjvJSVqYx7sEIV4HncoUZMy/I=
X-Gm-Gg: ASbGncumsHF3dGVUxrCyOtpZgnGFC4sygZudxVygK162Q+RLQu5uCDbAWHrgBZg119E
	tcNB4Sdmx8mkXtasxvVL7LZTiY9tN6u5SeEWJpSMQh9KzwaWkrjebWAGtqKU2zNOUkaLqkAhz2x
	nEnZlARPwlogO9/kQ4JsaPbVt2h9MRj3CXqO8NtY89kff4gpg9U6IXh2LoMYABmIVK1wytd9suF
	mvdsvwyEyU201DKasfvNYbhRA0Qp5AsZUm+ba9OgVt1GR9gemI/RSLsMOYYbX4SU3AskJfrZrOj
	EWg7I7jMtlTUcyAZp5lbIDQFX3xEiEo05FI3ZSYPfRf9zo8y3uj3wdScikyuk0sKEA7F
X-Google-Smtp-Source: AGHT+IGhjZrvNsCHZE3eGjx1ElWi189KImICdnFKn/7uc1+V/eDwoskYfYeRmlItwFCzuuJKYXSmdQ==
X-Received: by 2002:a17:90b:4a47:b0:2fe:84d6:cdf9 with SMTP id 98e67ed59e1d1-301be200c7bmr3227168a91.26.1742385086353;
        Wed, 19 Mar 2025 04:51:26 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf5b799dsm1336508a91.31.2025.03.19.04.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 04:51:25 -0700 (PDT)
Message-ID: <cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
Date: Wed, 19 Mar 2025 20:51:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devel@daynix.com
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
 <Z9pze3J2_zrTk_yC@linux.dev>
 <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
 <86plidmjwh.wl-maz@kernel.org>
 <bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
 <86o6xxmg87.wl-maz@kernel.org>
 <aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
 <86msdhmemw.wl-maz@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <86msdhmemw.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/03/19 20:41, Marc Zyngier wrote:
> On Wed, 19 Mar 2025 11:26:18 +0000,
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/19 20:07, Marc Zyngier wrote:
>>> On Wed, 19 Mar 2025 10:26:57 +0000,
>>>>
>>> But that'd be a new ABI, which again would require buy-in from
>>> userspace.  Maybe there is scope for an all CPUs, cycle-counter only
>>> PMUv3 exposed to the guest, but that cannot be set automatically, as
>>> we would otherwise regress existing setups.
>>>
>>> At this stage, and given that you need to change userspace, I'm not
>>> sure what the best course of action is.
>>
>> Having an explicit flag for the userspace is fine for QEMU, which I
>> care. It can flip the flag if and only if threads are not pinned to
>> one PMU and the machine is a new setup.
>>
>> I also wonder what regression you think setting it automatically causes.
> 
> The current behaviour is that if you don't specify anything other than
> creating a PMUv3 (without KVM_ARM_VCPU_PMU_V3_SET_PMU), you get *some*
> PMU, and userspace is responsible for running the vcpu on CPUs that
> will implement that PMU. When if does, all the counters, all the
> events are valid. If it doesn't, nothing counts, but the
> counters/events are still valid.
> 
> If you now add this flag automatically, the guest doesn't see the full
> PMU anymore. Only the cycle counter. That's the regression.

What about setting the flag automatically when a user fails to pin vCPUs 
to CPUs that are covered by one PMU? There would be no change if a user 
correctly pins vCPUs as it is. Otherwise, they will see a correct 
feature set advertised to the guest and the cycle counter working.

Regards,
Akihiko Odaki

> 
> Thanks,
> 
> 	M.
> 


