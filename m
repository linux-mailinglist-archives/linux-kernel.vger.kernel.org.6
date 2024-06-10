Return-Path: <linux-kernel+bounces-207965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D549D901E94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66D31C21397
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD7745F4;
	Mon, 10 Jun 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kgyhg8UP"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743B3CA62
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012901; cv=none; b=WBUbPHblfOoAAN/BPS4ZPIUKKoe6TKS0DCsQVA8twfGnURgRbDHBFUJD+tO/Pri9gzKWapzjQOm18jPYY+vTxyyVJ/H9L5RZFKG+jxSNfBatloiOXoPHNlI/2arZRw7keErTMFCdWTlYlbkl8VEbw701D/cKtpqa/yKYzYuySbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012901; c=relaxed/simple;
	bh=yz5UXgktrm1OmtnGfF4heciSBKjtRB9npZl4EeMkMOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1680MTmtkZug23QbR97Xb2J5GoLkSkvlAWYzjsXrMnMjD1vk+4jAtjER7+WThA4ZxV+qG55LcUCB0Sg5+XSIKxUtkVxSQSigtlOQAsZwboGoXvWL/+I3E/Auc1XPD9SqmEhRPhKae6f9AGaRfpLLKkueQp3ScwoC1gvivdU+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kgyhg8UP; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFC691BF20A;
	Mon, 10 Jun 2024 09:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718012892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3o0fJjNj4JP0TVjAXgD7eXygR+eJ+q4ORuB5LSyFd+Y=;
	b=Kgyhg8UPaC0J69nmpfaonXblGn3t/yyfKce2ZAhN892k7F4HjIfAUEuXVH4RnuURdVFgp/
	j599GCn1AgGPHBvrPd5zRqy8+OSoZA/r7mc93ZDVklbVA4CyHZDkxG/7QF5w1V705JNvJj
	P0+44nKGzfpjTHK3XlbM41Hlq9NwFMpWG1PYheS6M/Dgk0ASxJU5vVUp8DtoH2Txzu4B97
	mxzeJC1gyg7JHpR7tYz0rljJDEdqvs4BFF2OZ4LKzZ838DA2iffVSiy0LJBsv/w2SYC2qu
	9JX9UWG085A2bA/YRdmIoWlhUt1d82Q+fi5hx21uYvClgiuUk6hZVLFAp/1v6w==
Message-ID: <ad6b8caf-0ad6-42da-9324-e4a33a05f0cc@bootlin.com>
Date: Mon, 10 Jun 2024 11:48:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: tps6594-regulator: Fix the number of irqs for
 TPS65224 and TPS6594
To: Nishanth Menon <nm@ti.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, m.nirmaladevi@ltts.com,
 bhargav.r@ltts.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 gregory.clement@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com
References: <20240603170100.2394402-1-thomas.richard@bootlin.com>
 <20240604121055.lztvn2wu62qqrla6@maximize>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240604121055.lztvn2wu62qqrla6@maximize>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 6/4/24 14:10, Nishanth Menon wrote:
> On 19:01-20240603, Thomas Richard wrote:
>> The number of irqs is computed to allocate the right amount of memory for
>> the irq data. An array of struct tps6594_regulator_irq_data is allocated
>> one time for all the irqs. Each irq uses one cell of the array.
>>
>> If the computed number of irqs is not correct, not allocated memory could
>> be used.
>>
>> Fix the	values used in the calculation for TPS6594 and TPS65224.
>>
>> Fixes: 00c826525fba (regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators)
>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>> ---
> 
> 
> Thanks a ton for fixing this - this solved a bunch of random regressions
> we were tracking:
> am62axx_sk, am69_sk, j721e-idk, j721s2-evm in addition to J7200 evm as
> well.
> 
> Tested-by: Nishanth Menon <nm@ti.com>
> 
> 
> This was definitely a 6.10 regression, could we fast track it in?

Hi Nishanth,

FYI, I also found an other 6.10 regression for j721s2-evm and j7200-evm:

https://lore.kernel.org/all/20240603082110.2104977-1-thomas.richard@bootlin.com/

Regards,

Thomas


