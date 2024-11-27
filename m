Return-Path: <linux-kernel+bounces-423289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF129DA572
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F878B215AD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A0194C6A;
	Wed, 27 Nov 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHtRaSdZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71195140360
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702094; cv=none; b=lcLdb1JrR/HVBPIryVX5WeWuycw9vx+kjpn5E4IyhIsr8wSlnS7PUPX5rzSNnJiAEnr2BDkbPQhh3w2rRduEBk+hUaXSunSLbRXBxm4GoOK/WqKSbCFqQ9c6x0ewhEx0KCl5KX2v8+0o6IevTC51J7v8BRh47LUoy+OnULCKJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702094; c=relaxed/simple;
	bh=1wYdaPmzVqji5M3GxmovC3Zj+XeGWy2u3W+DFazHNkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSeTGE+pdo7AptRE+n7hWC+Z2fVqJruH1SBqy7UuVhnUun8TYMRFuLLWwG2SWQcalJJnEBIdhK555FOBj0tvSXwqOL8ezsUM2Mddf/xOiy1QjUbXIA2wFLf7Z7QljgjFjP/cmC0oSzLn+1jqWAnKA3ZQ8PC5/1pDqB0cnyt8JP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHtRaSdZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de92be287so3261660e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732702091; x=1733306891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rCu4RjgL9sjTK1Y/mVpJR4JTwQ+AC5Kyvpq82ug2qT0=;
        b=cHtRaSdZqDkSe768u9xPzsvaTvwXiFLqWREttBYkQlwESvEB8kEpRNqweWrpdutjd/
         j14kKC7RLLC/unzxm+QHwJO/3o77cbPbmcUwcUnFgIzZeICeSHF1KPEaqyqUN/8iO71C
         7CLZkY9+Z1QwiQ3yinuCIMMOvGWP2HzkWClV97MxXrz5iF6gfIcB3+vJMkR5LJn+GsEu
         yZebx+YmygG3Eq7lOGH8Fy7I5Mfz9TzefScCVvwitGngKD+Yct3AR3lDGQh2YeLm5mmI
         rMKGgaTt/DAS+CTkkJkZsHmMjG4P2cHcVqEaEmnH5nJwthkHqs+Imo9BRbE+LX4y2MdW
         m9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732702091; x=1733306891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rCu4RjgL9sjTK1Y/mVpJR4JTwQ+AC5Kyvpq82ug2qT0=;
        b=R3zTm1sl2wtdRLibme2TFwEZJ2ifnSssWjJww8K2fxqD50spQEd+FxE6SXxiJW5q+6
         EHm0LyzokwRdTz+aYDj6E0tJgnaoSE7YS9yUr0tT+fEkt9UWaAqpTHvZu0+jq9gGsYya
         lZr8R66lB2jsKCAxmxgsAr6cR3j/0Z3ZH8ASu/dcD8RjulsNWPKaof02aw+7/ba79mLY
         fzrHLweDQEGBNDeaaJoikQqUH+vSotmdDRdjOn87W6VC6yOMIJxM5XZ0NIznEEty4RvI
         b6JOqu2YvZE5YXIVCTU/yawaFuSEi9FggcWq3RgZ0/QsEGjlhUrdDHZCaPtXGwpLwMgQ
         boXA==
X-Forwarded-Encrypted: i=1; AJvYcCW/NEHBr+GJsfA//Z6apQBJFAV8RRa08GEROJaLfUnJWbjT5V0lkN1WIkDvmWLPCONA2Ur61yNsEzKUFEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuGuRXOHhvpe6KoeXQhTzm1LcGInv8U2KCs73wdAP8nET0Q/F
	tBOtDLrwUm24W5wrjNH0u3nQ0vakkkxh/g7x1ueoYK7QXD64qM0d/84SUvzCi3Q=
X-Gm-Gg: ASbGncsYNgJZu6h8AQVKToeFkgO7FtAP9Me8UutrcIdlbz+ZAOq5ymt03WqDiWW+7gP
	dZRgtREoyuoQwClBa4JKwHkcfCSewlAOxgJ+0WZf77BfvTl5c0A6bLuwtJlkBt3mt/fM6mi1lK6
	aSUWbhxaa6Yj896IZ39OMgdc9KY5CWb4NLtNYdYesuM5dUDl9NjRhaDJvqrqb7WQ2hna7uf/wS0
	ElzxclkpWjXh5xGPSOi2R4Po8jAz1hAcAIv/1LQdx/nOUzFNZcWoyjgLZgG
X-Google-Smtp-Source: AGHT+IGxq8BlPg4q00veCMjMl/I7UbvSpUijaUSLSmoOjASs//gstZCBp1O3F7Ag68LEG7c8y5MI+w==
X-Received: by 2002:a05:6512:1247:b0:53d:deb5:3376 with SMTP id 2adb3069b0e04-53df010b17bmr1794334e87.40.1732702090527;
        Wed, 27 Nov 2024 02:08:10 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50a9de1d0sm684549666b.0.2024.11.27.02.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 02:08:10 -0800 (PST)
Message-ID: <5daac1da-9196-4330-b604-5e2073d43f19@linaro.org>
Date: Wed, 27 Nov 2024 10:08:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/12] KVM: arm64: Swap TRFCR on guest switch
To: Oliver Upton <oliver.upton@linux.dev>
Cc: suzuki.poulose@arm.com, coresight@lists.linaro.org,
 kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Rob Herring (Arm)" <robh@kernel.org>, Shiqi Liu <shiqiliu@hust.edu.cn>,
 Fuad Tabba <tabba@google.com>, James Morse <james.morse@arm.com>,
 Mark Brown <broonie@kernel.org>, Raghavendra Rao Ananta
 <rananta@google.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241112103717.589952-1-james.clark@linaro.org>
 <20241112103717.589952-12-james.clark@linaro.org>
 <Zz4c5LmQnK2SD5HO@linux.dev>
 <5f2eb0fa-c7ca-4e25-b713-6a9bf3d355b9@linaro.org>
 <Z0X2BBBaDejFfATp@linux.dev>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <Z0X2BBBaDejFfATp@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/11/2024 4:23 pm, Oliver Upton wrote:
> On Thu, Nov 21, 2024 at 12:50:10PM +0000, James Clark wrote:
>>
>>
>> On 20/11/2024 5:31 pm, Oliver Upton wrote:
>>> On Tue, Nov 12, 2024 at 10:37:10AM +0000, James Clark wrote:
>>>> +void kvm_set_trfcr(u64 host_trfcr, u64 guest_trfcr)
>>>> +{
>>>> +	if (kvm_arm_skip_trace_state())
>>>> +		return;
>>>> +
>>>> +	if (has_vhe())
>>>> +		write_sysreg_s(guest_trfcr, SYS_TRFCR_EL12);
>>>> +	else
>>>> +		if (host_trfcr != guest_trfcr) {
>>>> +			*host_data_ptr(host_debug_state.trfcr_el1) = guest_trfcr;
>>>
>>> Huh? That's going into host_debug_state, which is the dumping grounds
>>> for *host* context when entering a guest.
>>>
>>> Not sure why we'd stick a *guest* value in there...
>>>
>>
>> Only to save a 3rd storage place for trfcr when just the register and one
>> place is technically enough. But yes if it's more readable to have
>> guest_trfcr_el1 separately then that makes sense.
> 
> Yeah, since this is all per-cpu data at this point rather than per-vCPU,
> it isn't the end of the world to use a few extra bytes.
> 
>> That works, it would be nice to have it consistent and have it that way for
>> filtering, like kvm_set_guest_trace_filters(bool kernel, bool user). But I
>> suppose we can justify not doing it there because we're not really
>> interpreting the TRFCR value just writing it whole.
> 
> Agreed, the biggest thing I'd want to see in the exported interfaces
> like this is to have enable/disable helpers to tell KVM when a driver
> wants KVM to start/stop managing a piece of state while in a guest.
> 
> Then the hypervisor code can blindly save/restore some opaque values to
> whatever registers it needs to update.
> 
>>> What if trace is disabled in the guest or in the host? Do we need to
>>> synchronize when transitioning from an enabled -> disabled state like we
>>> do today?
>>>
>>
>> By synchronize do you mean the tsb_csync()? I can only see it being
>> necessary for the TRBE case because then writing to the buffer is fatal.
>> Without TRBE the trace sinks still work and the boundary of when exactly
>> tracing is disabled in the kernel isn't critical.
> 
> Ack, I had the blinders on that we cared only about TRBE here.
> 
>>> I took a stab at this, completely untested of course && punts on
>>> protected mode. But this is _generally_ how I'd like to see everything
>>> fit together.
>>>
>>
>> Would you expect to see the protected mode stuff ignored if I sent another
>> version more like yours below? Or was that just skipped to keep the example
>> shorter?
> 
> Skipped since I slapped this together in a hurry.
> 
>> I think I'm a bit uncertain on that one because removing HAS_TRBE means you
>> can't check if TRBE is enabled or not in protected mode and it will go wrong
>> if it is.
> 
> The protected mode hypervisor will need two bits of information.
> Detecting that the feature is present can be done in the kernel so long
> as the corresponding static key / cpucap is toggled before we drop
> privileges.
> 
> Whether or not it is programmable + enabled is a decision that must be
> made by observing hardware state from the hypervisor before entering a
> guest.
> 
> [...]
> 
>>> +void kvm_enable_trbe(u64 guest_trfcr)
>>> +{
>>> +	if (WARN_ON_ONCE(preemptible()))
>>> +		return;
>>> +
>>> +	if (has_vhe()) {
>>> +		write_sysreg_s(guest_trfcr, SYS_TRFCR_EL12);
>>> +		return;
>>> +	}
>>> +
>>> +	*host_data_ptr(guest_trfcr_el1) = guest_trfcr;
>>> +	host_data_set_flag(HOST_TRBE_ENABLED);
>>
>> FWIW TRBE and TRF are separate features, so this wouldn't do the filtering
>> correctly if TRBE wasn't in use, but I can split it out into
>> separate kvm_enable_trbe(void) and kvm_set_guest_filters(u64 guest_trfcr).
> 
> KVM manages the same piece of state (TRFCR_EL1) either way though right?
> 
> The expectation I had is that KVM is informed any time a trace session
> (TRBE or otherwise) is enabled/disabled on a CPU, likely with a TRFCR_EL1
> of 0 if guest mode is excluded.
> 
> The function names might need massaging, but I was hoping to have a
> single set of enable/disable knobs to cover all bases here.
> 

I sent another version, it did come out much simpler and still does all 
the same things as before.

I didn't manage to make a single enable/disable knob though. The thing 
is the filtering is set on the source side of the driver and trbe is a 
sink thing. I would have to couple them together and add knowledge of 
the sink type to the source to make it work.

That would then open up the possibility for anyone adding a new source 
to get the trbe bit wrong in the future. Having KVM override the filter 
setting when trbe is in use seems a lot safer and easier to understand.



