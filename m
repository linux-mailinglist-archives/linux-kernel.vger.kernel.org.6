Return-Path: <linux-kernel+bounces-244349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0935092A301
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BB1282689
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAC82890;
	Mon,  8 Jul 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgsYj2pe"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8806680C0B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442432; cv=none; b=ir4jVx/AhWcXQfzJe0XJmmvkY9v1KlzzIMY7yTeJ+zItyWIunYiw6wmyZJZ6s5dcrv45WS4pgUrACPWcyCG3HNY5AXM+qJqjPCsh86CDKyt6R3qTfHGWZqbloqAv2tNIagWHOSwbF+V1TAaUq3qNXG91PQdKMi+sOZEKKTv3804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442432; c=relaxed/simple;
	bh=vvgi/RasdvTD2NF5Mx7HNpAvidOhoB4MR1JAXkBlUpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTJ18weGjBcLtv1ZvPNs/2EY9mIqzaA6tS9ZH0BrdwlNUY8gWbN5QvUgCHrQfKxE2g19ApHzljubF4aUaNyPd6T4BrdJDc04pizZqujJ3MZdJI6ZKw5zd0qnBaS0rU+dCOkZ/10jpBrm1p3HzPJ56UB7cDOKI8edxROxmdYdAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgsYj2pe; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee9b1b422fso14662821fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720442429; x=1721047229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+Whh6bWY3mpvjW5HXS4H+odUmaXy084wqKiNex3vo8=;
        b=LgsYj2peKawbqyFfsSpz/KVzR7Jk6CeurQwEmtn2yAMTu7ZoZMG3DhZlrVuvyICWwi
         8Sc3OZl7orm1ysFNxPeZuM1Im403eggL+E5Ur65MEbnEUfoAct7DcGYHrOsw6xVacjis
         exJsjMYUYboeydbKIufckzPUm8kVvqM4+Axwz0AfCvNQqGCHdODpqc5JB0LYvRMdGSod
         jr2wXSEfVuKYo7LBQPJHY6akT1WfxLiFYCDN3cKw3pYrUBwzEB0CIDL7lB50nSy67/55
         y4TmsMqKWSVE0XJmESUowrIBGqe9MuwAmEuhtBWMWwFXwSqB+MkaR/oEvshxLx7VFLsw
         /iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442429; x=1721047229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+Whh6bWY3mpvjW5HXS4H+odUmaXy084wqKiNex3vo8=;
        b=NyQNYcedAKAEiYyC1vdwuIakciV9PmNpId0ysuc6vCZqcHrUKM5PEDQPejNYhc6tR2
         zKkNWo7N9Eky+Br5Euagsz+n/bZkEt+OWQSGR3G3ig12oM1f5BQ8EymPgLIcOeBwWjmS
         Bm6Bm3FzKLd0csnsWzzy7Fxt6kj4aqCSOTJ/cwAaeq3WfeHWKUUWJQQ0o/WwUqkbrxHv
         /xidGBTBn+flB4VdbUGla4VZmAcKTCZheUQwlVnXqz0MGzhLAymuiYJwHhqhZpPAP4W1
         Sp5VUJGHcMcIT/gqfVHdC5ntOwIT+SFaKFk1wpoY2zF1EJrTyKLu4QUEsJwGx/E/9q1A
         L/vg==
X-Forwarded-Encrypted: i=1; AJvYcCVii807zAlzDfgNjDmumMQQhZWO/cow1LAQGCCk0mWoJQhImx5+QTYreyO1f/7Bzy19yrC0JdmTwY6iUG0JR5XbPoCZ/eJOtlQOnF/s
X-Gm-Message-State: AOJu0YzUb0XJUF1/J+OfS34GVAVpWuCzPFyHYsLLD93x251/6knHqMFv
	3ZJ9wzVGPID584yPtxTJSNzPpL1bDtkOfIThle2n+UKYUMMN55YD
X-Google-Smtp-Source: AGHT+IEUORe0gm9zDqx1wQFqboyJFAoNnXEOgYYuzn1avyKysiKTvP7Ny1GNhBz7nq+p7SBK5f+8mQ==
X-Received: by 2002:a2e:a813:0:b0:2ee:9533:dcba with SMTP id 38308e7fff4ca-2ee9533dd80mr32616451fa.26.1720442428221;
        Mon, 08 Jul 2024 05:40:28 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee9b4a839bsm6480601fa.111.2024.07.08.05.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:40:27 -0700 (PDT)
Message-ID: <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
Date: Mon, 8 Jul 2024 15:40:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] regmap: Allow setting IRQ domain name suffix
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1719830185.git.mazziesaccount@gmail.com>
 <fd13fcc9dd785d69b8450c8e9c26d860fcab7da8.1719830185.git.mazziesaccount@gmail.com>
 <87plrpvzmg.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <87plrpvzmg.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/24 21:13, Thomas Gleixner wrote:
> On Mon, Jul 01 2024 at 13:59, Matti Vaittinen wrote:
>> +static int regmap_irq_create_domain(struct fwnode_handle *fwnode, int irq_base,
>> +				    const struct regmap_irq_chip *chip,
>> +				    struct regmap_irq_chip_data *d)
>> +{
>> +	struct irq_domain_info info = {
>> +		.fwnode = fwnode,
>> +		.size = irq_base + chip->num_irqs,
>> +		.hwirq_max = irq_base + chip->num_irqs,
> 
> This is not correct. irq_base is the linux interrupt number base. The
> first_hwirq argument of irq_domain_create_legacy() is 0.

I tried to pick the logic from the implementation of the 
irq_domain_create_legacy() - but I must've missed something. I will 
re-check this.

> 
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
>> +	if (irq_base)
>> +		irq_domain_associate_many(d->domain, irq_base, 0, chip->num_irqs);
> 
> I wonder whether this can be handled at the core. Let me stare at it.

Thanks Thomas! I'll wait for your ideas before re-spinning this series :)

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


