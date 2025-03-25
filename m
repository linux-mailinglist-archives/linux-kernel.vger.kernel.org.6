Return-Path: <linux-kernel+bounces-575947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B7A70925
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0055216F8E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BA1AE875;
	Tue, 25 Mar 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT9YSFk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF8A19B5B1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928128; cv=none; b=dB9TlDlIQLIJosE4dbXysy3H4i5b1KxztLGYcs251Z6pGirYAHNM5zk6fhgBqNhQCclRLM1fJdkFCRWc5La8lFIQ1p15mT9wU4l2P1MjY4hfj3ayFdlSJvuA5aMYLATAUvosWopJEQmjnwmMcUEP+tQq3pewEiKWMKFiLZvFTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928128; c=relaxed/simple;
	bh=czQfqjHXT8AC/TqCowPb/ICdTvn8xVWPY8Fynodl96M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwAU44cu2oYxHRtGxCdu1wHOhXxCPlLAv5H0XcEuMonaJgB/rmY0S0kI8WL24XbTZrFFvtfojD6xzEPvtxCHra5xtAXDrJ+j5yrqucX/xv+pA01rAS8BuutgonUaA6pic3T+CVXA0VsDkaZ1Dcl9hawP9YbQ2gjuFoqina32R4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT9YSFk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DDCC4CEE4;
	Tue, 25 Mar 2025 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742928128;
	bh=czQfqjHXT8AC/TqCowPb/ICdTvn8xVWPY8Fynodl96M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aT9YSFk6b9jkufAk8kVmC33X31kyb1aWzVts36xbMEwix/lf/heysclGqCnFWMPaQ
	 M5fMzZCi7tLYMYeqIBepcMRgQ2BNS5aprNXd7kk/JaSgkzmF8w0s++eF3RHz85xPW3
	 Za3LXHmNDwDoGTBQPSuJAAZZXRCZ+SUeN5BTpLJO/ru3v6BdDprTljPvvWL1L41c1U
	 khocGo3TsCC4vXVEbKHQ3NMznx6LrPG4Y2tJV7hCM7M+ACTtq7pQq+e8qaf+GoWNEC
	 Z+oTMtpEwl/akWMEoj3TovduRdJQ5FgkGzQZT7YhR9xOd8IlUMyn3TxNeleTcsQLO9
	 aUidFygrY1VaA==
Message-ID: <e9216aaf-f53e-4256-bb73-489c2261d4c5@kernel.org>
Date: Tue, 25 Mar 2025 19:42:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, dl-S32 <S32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <bb7e4740-9608-4534-9c19-3ac066e2aa8f@kernel.org>
 <1bf2d9ad-325e-4b1d-8440-ddbc90eabc67@linaro.org>
 <9ca80442-15c8-4f2d-ac11-8096b2cd83ad@kernel.org>
 <ff213c29-2a17-4776-a575-35e398e560ec@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ff213c29-2a17-4776-a575-35e398e560ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/03/2025 19:38, Daniel Lezcano wrote:
> On 25/03/2025 13:30, Krzysztof Kozlowski wrote:
>> On 25/03/2025 13:23, Daniel Lezcano wrote:
> 
> [ ... ]
> 
>>>>> +	if (!stm_instances->clocksource && (stm_instances->features & STM_CLKSRC)) {
>>>>> +
>>>>> +		/*
>>>>> +		 * First probed STM will be a clocksource
>>>>> +		 */
>>>>> +		ret = nxp_stm_clocksource_init(dev, name, base, clk);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +		stm_instances->clocksource++;
>>>>
>>>> That's racy. Devices can be brought async, ideally. This should be
>>>> rather idr or probably entire structure protected with a mutex.
>>>
>>> Mmh, interesting. I never had to think about this problem before
>>>
>>> Do you know at what moment the probing is parallelized ?
>>
>> You don't have PROBE_PREFER_ASYNCHRONOUS, so currently this will be
>> still sync, but I don't think we want it to be that way forever. I think
>> new drivers should not rely on implicit sync, because converting it
>> later to async will be difficult. It's easier to design it now or even
>> choose async explicitly (after testing).
> 
> I gave a try and sometimes I reach the warnings below. I suspect the 
> underlying code in the time framework is not yet ready for that.
> 
> Even if it could be a good candidate for parallelizing the boot, this 
> driver should stay sync ATM. Except if someone has the willing to dig 
> into the core framework to find out the race when switching the 
> clockevent. I think a thread is setting a timer while we are switching 
> the driver.
> 
> IMO, this core framework is too sensitive for this kind of change now.
> 
> Alternatively, I can put anyway the lock which is harmless for the sync 
> code but making the driver race free. The async flag can be put later.


Yes, that's what I meant, although indeed good point that clocksource is
way too early to be async. In that case this part is up to you, maybe my
suggestion was not correct.


Best regards,
Krzysztof

