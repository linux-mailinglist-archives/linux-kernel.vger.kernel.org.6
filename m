Return-Path: <linux-kernel+bounces-390411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5D39B7983
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACEBC1C2163B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E25199FB5;
	Thu, 31 Oct 2024 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opxZOszc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD211993B2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373470; cv=none; b=cLT7P9+MTD22vO+50qAqtjKJ2yfI936oiTzUfsUGNWLtgIY+faXGWD9bsjtCRdACASEh5htUpqQ7Klo/o7VbHQf2Z8BblLSO54dWTNScp+kSa1okK+BITfU7UT0Wu09rdwofD6R2WU4wFll9VJD6p7W0kuS23u4u2wn6YRnppUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373470; c=relaxed/simple;
	bh=8qknxn41wZoCsTggYSe2Lp0RhYFWnrMqzr0ogn95w1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMGStFb/G8WQNhE+dZD2Wy3vZo2VQycn6vxS8lE4H77SkEQDTcTXSmVR+TiSKWbGAwPD6qkeZzveFuBKYOw+kRoPiEh4Zagw3HcceEgc75nGOH23C9d/NDr0YgMaZqMqXF85V8+Xw76mQWzMFFx4FeD7GMm9vrTmj5vBGuuj87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opxZOszc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B97C4CEFC;
	Thu, 31 Oct 2024 11:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730373470;
	bh=8qknxn41wZoCsTggYSe2Lp0RhYFWnrMqzr0ogn95w1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=opxZOszcxk8pH+PeHnyEDyLZUKEDxFspaSCn+eDBAl/QBJeG44cvhG/oAk4x8yZ9E
	 OCkCSKtg3ar8FRYPblBv9u9ySP2LFPPwBI2wkAcHdZdaUp/7wOaGeAfofbiRK/Y+HZ
	 60NkVjD17TLRF1GgoKqkhjmVTXCedhQhMz+JAJ9wRCDeTyq4w1h/Zs9PGaLkvV9+Jt
	 icV+xMuYFMv1Edie0DRq4itYAJr7SNSaqamggxdmKaeRNlk23ddpD/CjZ4LyWk72Qr
	 q3TT6j+f88BqAg71vEhitDMBMpNnCobPcjbKBuHSlC17ZYR9GP7SBm02m6ek8tXRxT
	 TPqsaUkX/mZow==
Message-ID: <ac01fa3e-1d68-419f-8afc-f3ecf3f25b68@kernel.org>
Date: Thu, 31 Oct 2024 12:17:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers: soc: atmel: use automatic cleanup for
 device_node in atmel_soc_device_init()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
 <20241030-soc-atmel-soc-cleanup-v1-2-32b9e0773b14@gmail.com>
 <dfa83464-4632-45cf-a257-b9d9739d37e2@kernel.org>
 <99b12dee-43c3-4007-9c55-e2a884fc662b@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <99b12dee-43c3-4007-9c55-e2a884fc662b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2024 12:14, Javier Carrasco wrote:
> On 31/10/2024 12:07, Krzysztof Kozlowski wrote:
>> On 30/10/2024 18:10, Javier Carrasco wrote:
>>> Switch to a more robust approach to automatically release the node when
>>> it goes out of scope, dropping the need for explicit calls to
>>> of_node_put().
>>
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching. For bindings, the preferred subjects are
>> explained here:
>> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
>>
>> There is never a "drivers" prefix. Especially not first (because as
>> middle appears for FEW subsystems, not for SoC though).
>>
> 
> Thanks, I added that by mistake. I will fix that for v2.
> 
>>>
>>> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
>>> ---
>>>  drivers/soc/atmel/soc.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
>>> index 64b1ad063073..298b542dd1c0 100644
>>> --- a/drivers/soc/atmel/soc.c
>>> +++ b/drivers/soc/atmel/soc.c
>>> @@ -399,15 +399,12 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
>>>  
>>>  static int __init atmel_soc_device_init(void)
>>>  {
>>> -	struct device_node *np = of_find_node_by_path("/");
>>> +	struct device_node *np __free(device_node) = of_find_node_by_path("/");
>>>  
>>> -	if (!of_match_node(at91_soc_allowed_list, np)) {
>>> -		of_node_put(np);
>>
>> You just added this code. Don't add code which immediately you remove.
>> Squash two patches.
>>
>> Best regards,
>> Krzysztof
>>
> 
> 
> As I said in another thread, I split the solution into a first one to be
> applied to stable kernels, and a second one that uses a more robust
> approach that is not supported by all stable kernels.
> 

Same response as in other thread:

1. Then send backport for stable, if you care about stable. You inflate
history with irrational commits just instead of doing proper stable
backport.

2. Creating some commits purely for stable in the mainline kernel is not
a correct approach. We work here on mainline and in mainline this is one
logical change: fixing issue. Whether you fix issue with of_node_put or
cleanup or by removing of_find_node_by_path() call, it does not matter.
All of these are fixing the same, one issue.

If you think about stable kernels, then work on backports, not inflate
mainline kernel with multiple commits doing the same, creating
artificial history.

Best regards,
Krzysztof


