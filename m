Return-Path: <linux-kernel+bounces-170350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D68BD585
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1A81C20B09
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA7815ADA0;
	Mon,  6 May 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mq0xAbuQ"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C575FDA5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024395; cv=none; b=F9qbryZMpsrO8G4J6C+E+BZ1dbJTQI0tNglH9Vf9wsT19xpyfqq1VAgrJT0Yheac0s6dT7mP2dqrtepXJ31Gpj1JdbC5oxqFQWeDYu8UqJLrnlGNssChHiUF1U/Tz255lv+vNLuv8zct2JoVq3zhi9L6sSplqJYCv+k4AF5NAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024395; c=relaxed/simple;
	bh=kSbC0P1iih9AHBDll0/qcniTyFWdHujHDEZeNGz4bcU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hmd+fhHhrBuI8XqVQ9k/gXLo3vMZqOLWIJW/dT5JXUqOOI2RJJczRgFrtbJet6wTAeS+iSx2kmIF1libjl0FaIXl9ySPncWuJQX0XJ/7B2uqN2bubhUlP7XCEw6FfzYFrkPfMCxUPMKAqFTBZnckuxq0986NVYCqaDDYjvhttRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mq0xAbuQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c6e3e74-cb0e-4f9e-81a5-751731130722@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715024392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3/ApWtpZdFKL65BEqeavRpFjRU1ETt/whrh56InYF4=;
	b=mq0xAbuQFZiNjxVWdwOuDhQyfJSF2ruAzqMGvg4b7GE7mUSjNn7WTq6u5xiRX/f69KeIuG
	hk6/ERsagPQ4wqy7s7W85YqCh8ZCMCzJj1hGMThUZX6gMFRKOO2BgYXL39CxqC8jjIYbnI
	/OFeacgHwu8swolD7wk0PoCKJbh43Jc=
Date: Mon, 6 May 2024 15:39:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] pinctrl: zynqmp: Support muxing individual pins
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Michal Simek <michal.simek@amd.com>, linux-gpio@vger.kernel.org,
 Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240503162217.1999467-1-sean.anderson@linux.dev>
 <20240503162217.1999467-3-sean.anderson@linux.dev>
 <ZjkuzKEt2aiHIwg_@surfacebook.localdomain>
 <628abfa4-7e7a-4be1-ab4c-f01b7a90e4af@linux.dev>
Content-Language: en-US
In-Reply-To: <628abfa4-7e7a-4be1-ab4c-f01b7a90e4af@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/6/24 15:38, Sean Anderson wrote:
> On 5/6/24 15:26, Andy Shevchenko wrote:
>> Fri, May 03, 2024 at 12:22:17PM -0400, Sean Anderson kirjoitti:
>>> While muxing groups of pins at once can be convenient for large
>>> interfaces, it can also be rigid. This is because the group is set to
>>> all pins which support a particular function, even though not all pins
>>> may be used. For example, the sdhci0 function may be used with a 8-bit
>>> eMMC, 4-bit SD card, or even a 1-bit SD card. In these cases, the extra
>>> pins may be repurposed for other uses, but this is not currently
>>> allowed.
>>> 
>>> Add a new group for each pin which can be muxed. These groups are part
>>> of each function the pin can be muxed to. We treat group selectors
>>> beyond the number of groups as "pin" groups. To set this up, we
>>> initialize groups before functions, and then create a bitmap of used
>>> pins for each function. These used pins are appended to the function's
>>> list of groups.
>> 
>> ...
>> 
>>> +			for (pin = 0; pin < groups[resp[i]].npins; pin++)
>>> +				set_bit(groups[resp[i]].pins[pin], used_pins);
>> 
>> Why atomic bit operation?
> 
> The name was easier to remember. I can make it non-atomic.
> 
>> ...
>> 
>>> +	fgroups = devm_kcalloc(dev, func->ngroups + npins, sizeof(*fgroups),
>> 
>> size_add() from overflow.h.
> 
> OK
> 
>>> +			       GFP_KERNEL);
>>> +	if (!fgroups)
>>> +		return -ENOMEM;
>> 
>> ...
>> 
>>> +	for (i = 0; i < func->ngroups; i++) {
>>> +		fgroups[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%d_grp",
>>> +					    func->name, i);
>>> +		if (!fgroups[i])
>>> +			return -ENOMEM;
>>> +	}
>> 
>> Hmm... Can this benefit from devm_kasprintf_strarray()?
>> 
> 
> I don't think so, since the prefix is different for each group.

Sorry, the prefix is the same, but we have to use this format as to not
break the devicetree ABI.

--Sean


