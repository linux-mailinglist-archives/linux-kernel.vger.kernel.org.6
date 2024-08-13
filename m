Return-Path: <linux-kernel+bounces-284443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA65950103
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C8B1F24A30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE0518B499;
	Tue, 13 Aug 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKbP1pmw"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F9187349
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540276; cv=none; b=YsVtT0hGfU0P0yFDFioNnUjEDi+dcklGeLkFPpF5LLpwP7+aRCTX/SW/V/m2vLBWNBZAZ0ufpMvUSD8bwe5o2OcYvrYfoQ7xbD+HdQHl54gYkrvblIC7NOYau32z4h/p5I6aZ4Gzb1IERiAuTJinI6ijMwqs/6tCaJKmqJIa7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540276; c=relaxed/simple;
	bh=do/C/d29ou6KmjDkPU63o1DT8gW8kwDLnta8veTXUOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9EKlLjD9iGrWhRLTyTse1mu+F90aI70km7rGLEpCQYeTRgKBR7pYBHHlSl/HL8sy5ckXH9b4PKPEwW+2ACbAWhC0hLPDT6hBeqeBv7bEtN+e46yHXiiXfI02q0k/15QwRIq2AS0WshCUIXNRnZA3TPoF9g/ipb8MMC3Jt2x87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKbP1pmw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so46124811fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723540273; x=1724145073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG4ZtdcKBmn85nfDM9wiFUKVwLCE8owAzden3gat2Nw=;
        b=RKbP1pmw1lIHswksLP3O9Q5mzkn4Igw7LSRh7g/gkjXFFSd9loykZTadLIdslbOa30
         +TallsxoeG9HqvYKS3Gieq28AfrroIw+xPBwzWABvvg1rj9MvJIw+WvQLif52bBR5YXI
         q4N/wHuCNhz5KwkwPwQ6Q4HEPxgvKjj62PQZ2cy+15Pf/mqldiJhRqcHEXT4jlLiFHTV
         Hny/jaSRz7jnk1Nf9SiHxBVNXNeEV2MH2SG4Re7Ua2UkyuSgdL3Vs6Z61/HEg9Z9iGe3
         rE2sbDQG7J+OiVycSkL74CJZD5eMUY5P9/kvOyMHc5LLAHhajLeWzJkhqCI6yM3Trjot
         k33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723540273; x=1724145073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG4ZtdcKBmn85nfDM9wiFUKVwLCE8owAzden3gat2Nw=;
        b=c6IojzyG7idJ9ohyeYJRphDa1AI6ttpp7fCI4MUgNRrFfleV8+hcCHBEzfT7niQsJ3
         nFCWtfBhODQRtu5MMpjhHtxyzkC4gdltoIt0q8Uv5vBTYddbTBT/yCYRm5El8uZ/Wp+z
         TZ2w2AlZAg32efDz8if9IjpZRkPa9vmJVFW+yxA83p8zJ5pYwS+lpvkDCisdSbyTcEfT
         JbpMtRHEBoy9ua9RE9E22h3y3jDZIg5sLcUMsuL3oQ2jiQVoOXtWuEAMDr040CzHCNnh
         zQtVfSXT/n/3kIVeNrHee94HFxS4BNyjrS6Vr6YpN46IGrRMWF+OhDKtbzYg3MVLnh9Q
         caxA==
X-Forwarded-Encrypted: i=1; AJvYcCVznVpXHrNIVtfmGiKW3oOzjDD6SBo7jhQY9RSlfsKMvOqMSe+i/Rd+s6pJeFZ8MOAo5QTsWWxSTTMRELDuMJxihNNEthu7nCLnQnxE
X-Gm-Message-State: AOJu0YyHHNLNIOZGtGV8MG/c3/8L97zbsVXZRmpUTBk+nfBmgKEtjDJL
	x3Ikc6xS15pCzxZuV189a8990hKfiizD/bZug1swNFj5hk6L2BxR
X-Google-Smtp-Source: AGHT+IGeY5F41QhEKWicXr1SbWgdtrmXrumtsBHu3NjdSih2YR52YrYTfm2u/BqpkYFZyisOzbyMow==
X-Received: by 2002:a2e:f01:0:b0:2ef:2f8a:52d5 with SMTP id 38308e7fff4ca-2f2b8f078a4mr5471591fa.8.1723540272046;
        Tue, 13 Aug 2024 02:11:12 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f292069bb3sm10832561fa.139.2024.08.13.02.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 02:11:11 -0700 (PDT)
Message-ID: <128893ca-121d-45c6-8b95-e8e4456c9c07@gmail.com>
Date: Tue, 13 Aug 2024 12:11:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] regmap: Allow setting IRQ domain name suffix
To: Andy Shevchenko <andy@black.fi.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <776bc4996969e5081bcf61b9bdb5517e537147a3.1723120028.git.mazziesaccount@gmail.com>
 <ZrpdBL7GZKmXZ60g@black.fi.intel.com>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZrpdBL7GZKmXZ60g@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 22:05, Andy Shevchenko wrote:
> On Thu, Aug 08, 2024 at 03:36:28PM +0300, Matti Vaittinen wrote:
>> When multiple IRQ domains are created from the same device-tree node they
>> will get the same name based on the device-tree path. This will cause a
>> naming collision in debugFS when IRQ domain specific entries are created.
>>
>> The regmap-IRQ creates per instance IRQ domains. This will lead to a
>> domain name conflict when a device which provides more than one
>> interrupt line uses the regmap-IRQ.
>>
>> Add support for specifying an IRQ domain name suffix when creating a
>> regmap-IRQ controller.
> 
> ...
> 
>> +static int regmap_irq_create_domain(struct fwnode_handle *fwnode, int irq_base,
>> +				    const struct regmap_irq_chip *chip,
>> +				    struct regmap_irq_chip_data *d)
>> +{
>> +	struct irq_domain_info info = {
>> +		.fwnode = fwnode,
>> +		.size = chip->num_irqs,
>> +		.hwirq_max = chip->num_irqs,
>> +		.virq_base = irq_base,
>> +		.ops = &regmap_domain_ops,
>> +		.host_data = d,
>> +		.name_suffix = chip->domain_suffix,
>> +	};
>> +
>> +	d->domain = irq_domain_instantiate(&info);
>> +	if (IS_ERR(d->domain)) {
>> +		dev_err(d->map->dev, "Failed to create IRQ domain\n");
>> +		return PTR_ERR(d->domain);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +
> 
> One blank line is enough?

Sure. Thanks Andy!

Yours,
	--Matti

> 
>>   /**
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


