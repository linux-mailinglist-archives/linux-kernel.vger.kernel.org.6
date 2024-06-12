Return-Path: <linux-kernel+bounces-211798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE709056F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E0F1F27C26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66B180A62;
	Wed, 12 Jun 2024 15:34:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECB21802CF;
	Wed, 12 Jun 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718206461; cv=none; b=IrREZPlBvPqlqJ9wd3VqRLGa0Ty0/S+LhBqYzgwa/rEh/yBFgbMEpYnt3CGpmiJvuHeHygS2A0gZyUirT5q5+Nh5xIUUAOLgK6RgXODJYkzZ0NkIUT8tmGoXhJPTPzYHw2j9WY8IIX3XbszeJ1cBikt3X/H1NEjCx10tdl83edg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718206461; c=relaxed/simple;
	bh=AEH1PF2oiR9AWSog4ZyajYHOgBRYvq3XpSnXr5FyMaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thILJJkTXVYOghb/Wn9M2OCKWKL0bWqMqXUG4YNvGuqbipPrxZPyGJiQ6J0hKrBPGPhFAOE7vDwCx5jAnxqU2akSAv6X8sn/7zE+RZW1GycGDB58G8bYP914TcPkC4/l6uooX/TmtOlCKWMNsbEYk4mac1PJe4cnpY8f3A3v5WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FA481042;
	Wed, 12 Jun 2024 08:34:42 -0700 (PDT)
Received: from [10.1.29.46] (e110479.arm.com [10.1.29.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E861B3F73B;
	Wed, 12 Jun 2024 08:34:14 -0700 (PDT)
Message-ID: <7fdc23ff-fd55-4347-ac61-dd115eff6ff1@arm.com>
Date: Wed, 12 Jun 2024 16:34:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mfd: axp20x: AXP717: Fix missing IRQ status
 registers range
To: Lee Jones <lee@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Ryan Walklin <ryan@testtoast.com>,
 Chris Morgan <macroalpha82@gmail.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-2-andre.przywara@arm.com>
 <20240502093907.GM5338@google.com>
 <56aef347-7582-497e-be02-d82eda7b3528@arm.com>
 <20240612152510.GE1504919@google.com>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240612152510.GE1504919@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/06/2024 16:25, Lee Jones wrote:
> On Wed, 12 Jun 2024, Andre Przywara wrote:
> 
>> Hi Lee,
>>
>> On 02/05/2024 10:39, Lee Jones wrote:
>>> On Thu, 18 Apr 2024, Andre Przywara wrote:
>>>
>>>> While we list the "IRQ status *and acknowledge*" registers as volatile,
>>>> they are missing from the writable range array, so acknowledging any
>>>> interrupts was met with an -EIO error.
>>>>
>>>> Add the five registers that hold those bits to the writable array.
>>>>
>>>> Fixes: b5bfc8ab2484 ("mfd: axp20x: Add support for AXP717 PMIC")
>>>> Reported-by: Chris Morgan <macromorgan@hotmail.com>
>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>> ---
>>>>    drivers/mfd/axp20x.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>
>>> Acked-by: Lee Jones <lee@kernel.org>
>>
>> Can you please take just this patch as a fix for 6.10? This fixes the power
>> key operation.
>> This applies cleanly on top of v6.10-rc3, so there is no need for any extra
>> immutable branch or coordination with regulator.
>> (The same is true independently for patch 2/5, on the regulator side).
> 
> What does the Fixes: commit break?
> 
> Or is it the case that it never worked properly?

The interrupt part never worked properly, but so far that's only needed 
for the power key operation. Unfortunately that part wasn't tested 
properly initially, so the patches were merged into your tree before that.

Cheers,
Andre

