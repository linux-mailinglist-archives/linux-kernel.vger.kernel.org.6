Return-Path: <linux-kernel+bounces-404235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA09C4136
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BE9AB21674
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0A519E7F3;
	Mon, 11 Nov 2024 14:47:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8251BC58
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336439; cv=none; b=l7FSUCwIk1Tue2QG4EOTrVv/VVXLNSva3ST2Bnyk/8QT9rf/Jswnni9CK/9DvnAdSiYXNuwsQGWsYZLTDzNpaLzGs2R7UagFVTlUuwSThGem/ISR1Rv3PuWDxH2e4Px890SZU14Q08kUov6fJgicLmfi4KkcVolnW7mmPM6xWG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336439; c=relaxed/simple;
	bh=WoTU98/Y9O8cBA8GGCb/K2bkPlDNa/WZtZv17vgCG7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ads8D2phYlN1PuwFNgHkjxrFMM+27MZusE8PbWoruUmQVVBWIv9JjzKLB3RFuc3gNxggEIbAPj2001XOFTDoWy1kpYrhHjIn0ScyjHzEBxegGkjRq8Mc9yW0EH46ftCF8pIggt9q7j+3b9j1OMoqIV8+4gIKSZRU7KysnE2OmKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9491CE0;
	Mon, 11 Nov 2024 06:47:44 -0800 (PST)
Received: from [10.57.79.116] (unknown [10.57.79.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C84D03F66E;
	Mon, 11 Nov 2024 06:47:12 -0800 (PST)
Message-ID: <a4168463-98e3-4048-bb38-ffc96983766f@arm.com>
Date: Mon, 11 Nov 2024 14:47:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwtracing: Switch back to struct
 platform_driver::remove()
Content-Language: en-GB
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241111110922.334610-2-u.kleine-koenig@baylibre.com>
 <87h68duaez.fsf@ubik.fi.intel.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <87h68duaez.fsf@ubik.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi

On 11/11/2024 14:12, Alexander Shishkin wrote:
> Uwe Kleine-König <u.kleine-koenig@baylibre.com> writes:
> 
>> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
>> return void") .remove() is (again) the right callback to implement for
>> platform drivers.
>>
>> Convert all platform drivers below drivers/hwtracing to use .remove(),
>> with the eventual goal to drop struct platform_driver::remove_new(). As
>> .remove() and .remove_new() have the same prototypes, conversion is done
>> by just changing the structure member name in the driver initializer.
>>
>> Also adapt some whitespace to make indention consistent.
>>
>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> 
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
>> ---
>> Hello,
>>
>> I did a single patch for all of drivers/hwtracing. While I usually
>> prefer to do one logical change per patch, this seems to be
>> overengineering here as the individual changes are really trivial and
>> shouldn't be much in the way for stable backports. But I'll happily
>> split the patch if you prefer it split. Maybe split for coresight vs.
>> intel_th? Also if you object the indentation stuff, I can rework that.
> 
> I'm fine with it as is.
> 
>> This is based on today's next, if conflicts arise when you apply it at
>> some later time and don't want to resolve them, feel free to just drop
>> the changes to the conflicting files. I'll notice and followup at a
>> later time then. Or ask me for a fixed resend. (Having said that, I
>> recommend b4 am -3 + git am -3 which should resolve most conflicts just
>> fine.)
> 
> Does anybody want to pick this up or should I? I'm fine either way, but
> if there are any conflicts they won't be from my end of things, so it
> might make sense to take it via the coresight path.

I am happy to take them via coresight tree and queue them for v6.14

Suzuki

> 
> Thanks,
> --
> Alex


