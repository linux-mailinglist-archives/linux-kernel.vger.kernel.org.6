Return-Path: <linux-kernel+bounces-415517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D53CE9D374B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F64B1F243F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8809619CCFC;
	Wed, 20 Nov 2024 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSHwIsVY"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B217799F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095821; cv=none; b=EFuapYN76ySwTGKuWaR1xCnsh61iCoCNKRuIWZAgAxcr+LNKvkHPs51Rk2Kf73l/mfukpTRX5BKAoFNx7uFAFTtsFgrcsCz6IXvHYtdnw19kPde8qFd6xI6WVYUT2tuVjdbDFGeHPBFJMKJUNvE/x90HeaehN7jkD8uxUOuOFLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095821; c=relaxed/simple;
	bh=3IYRdTUfO3yDGyAuYaGAOpNJ3n3ybKoAhhl963CdxV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEHO2RpGdcZOjW+pmHcFWNSrA5N3CZ3LUgFkXuA6PD8m06eHg0NC18WUCDCnkagTdsoD4cKWrMUCYxjfMrZERMTELS5BpjMfmazt2c+yHoazoWmhL/rsbJZWKLFbpdT1iQEohC15PSQSN9JYZfUA9v1cTU7bUllPaREtIzJ0LDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hSHwIsVY; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so6327539a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732095818; x=1732700618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnMuJVLT9f8LFRD+CDKFKXxiScl2L/4chGY+NToAMxA=;
        b=hSHwIsVYJmJ40Xuu6jpjX4sClYWAqX3ezuXl6LOP8BA13B9F9lwOJv9dCtjMcdIHoh
         3BemI87PoSWQqAGsLingHeYuGdx8wCebDGuatE0ltqZnO3pphUBwVbwS/ZFsjb3DvdNq
         jW6epmzhhDypvHU0Mo4zg05apHgvm8XCShvU3YRWs7Dci1GV7Lbv8iAraEQy8qB4KOM3
         SHWKFkThlat0YVX2Jl/9/9M7t8ogjIHhpFZocwjc+s6mDOxwmYaAdaS6T7zzjiWtvTeS
         4pe9iYgv8clLGc8NXvKXnH2R8BVFEsApV4QL7F+SRjjfhvdesUSDwk88PdhUTsIMy7BO
         TXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732095818; x=1732700618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnMuJVLT9f8LFRD+CDKFKXxiScl2L/4chGY+NToAMxA=;
        b=MYhhADEgSD6DM02L1nXvc2nI2f8ifwBPGJxGPrG91H41amZm31n1BQtA3/R1RbSUnS
         CnmTj5YOMvfNLiaDGWls1dNZNzFZqUZxEuBxlLgkMFgI8DAIhqweX5O17gn0ZpR0LA2e
         3f8NoYvsSOejoJjMDDIOW6AoL9W0NGG0p2XNgT+d73oNilQiC1rOj1r7t8DTciGnS1Mf
         nBImckAv4ErzBCMgqf6g4ZDI46ARebBqWNrB1r5lk0TW4NNxYE8w9kIlcWIPR9d88095
         q1ax9xS1gpHYM+ejF21hO2Ao7nDlRqKdLNu+Zt9Sp8AJJzIr797dcVK61qTr2RHuF8MV
         Ka0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNp0IGQXoWsKfubqZu08P+c6JFAYV0bUn/Yul2ELx/vZI79VEOrDi/oUtnHRjYEERurWhuNQT/b0iN/k8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFhM4aO7qEIEprHFVayvy1hfZvoOpMSz2ZFQoBh6loUACezDu
	jgVmLbY0AFNAUJBSWWa5kvDL/BWDhf+Utf5uAk1vgM3QtisBOXh+itSwT00BGsLhFiCqfiSkxkp
	LLl4=
X-Google-Smtp-Source: AGHT+IHPRVJgISuT50tHDUxOcColFsHDGhCQoGsxkLXqTG91NWmfuCwkbfL9wtykWsiswaDg+PK2jg==
X-Received: by 2002:a05:6402:2807:b0:5ce:fa47:18b6 with SMTP id 4fb4d7f45d1cf-5cff4c41f5fmr982907a12.12.1732095818491;
        Wed, 20 Nov 2024 01:43:38 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cff44de59bsm615495a12.2.2024.11.20.01.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 01:43:38 -0800 (PST)
Message-ID: <0f6241cf-8938-4c3b-82ef-fbfd29676bd7@linaro.org>
Date: Wed, 20 Nov 2024 09:43:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/12] KVM: arm64: arm_spe: Give SPE enabled state to
 KVM
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: coresight@lists.linaro.org, kvmarm@lists.linux.dev,
 Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Fuad Tabba
 <tabba@google.com>, James Morse <james.morse@arm.com>,
 Shiqi Liu <shiqiliu@hust.edu.cn>, Mark Brown <broonie@kernel.org>,
 Raghavendra Rao Ananta <rananta@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241112103717.589952-1-james.clark@linaro.org>
 <20241112103717.589952-8-james.clark@linaro.org> <Zz2o9XryCezwAf61@linux.dev>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Zz2o9XryCezwAf61@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/11/2024 9:16 am, Oliver Upton wrote:
> Hi James,
> 
> On Tue, Nov 12, 2024 at 10:37:06AM +0000, James Clark wrote:
>> Currently in nVHE, KVM has to check if SPE is enabled on every guest
>> switch even if it was never used. Because it's a debug feature and is
>> more likely to not be used than used, give KVM the SPE buffer status to
>> allow a much simpler and faster do-nothing path in the hyp.
>>
>> This is always called with preemption disabled except for probe/hotplug
>> which gets wrapped with preempt_disable().
> 
> Unless the performance penalty of checking if SPE is measurably bad, I'd
> rather we keep things as-is.
> 
> Folks that want to go fast are probably using VHE to begin with. As you
> note below, we need the hypervisor to decide if SPE is enabled based on
> hardware in protected mode anyway. Using a common flow for protected and
> non-protected configs keeps complexity down and increases the likelihood
> SPE save/restore code actually gets tested.
> 

I'm not sure if there is any measurable difference. This change was 
actually in response to this review from Marc here [1]:

   > Why do we need to save anything if nothing was enabled, which is
   > *all the time*? I'm sorry to break it to you, but nobody uses these
   > features.  So I'd like them to have zero cost when not in use.

   > Surely there is something there that should say "yup, tracing" or
   > not (such as the enable bits), which would avoid hitting the sysreg
   > pointlessly?

I suppose I could have taken the "zero cost" bit a bit too literally and 
maybe there were some simpler optimizations that didn't involve strongly 
coupling the driver to KVM. At least for enable/disable, for filtering 
it would still be required.

I'm trying to think if there is some middle ground where there is a 
systemwide flag or static key that gets set on the very first SPE or 
trace session. In theory it could be simpler than this per-cpu enable 
disable stuff, but in the end it pretty much ends up needing the same 
info from the driver (and has the same protected mode issue). So you 
might as well do it as fine grained as this or not at all like you suggest.

[1]: https://lore.kernel.org/linux-arm-kernel/86bk832jza.wl-maz@kernel.org/


