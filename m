Return-Path: <linux-kernel+bounces-278896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCC994B647
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB081F21C37
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E47176FA1;
	Thu,  8 Aug 2024 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OICjT0aq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A017625B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095009; cv=none; b=dpjRDj8tr0NN1zqVdbTOaHU5Zjubz1wVdwyzN1d8YfbDxquTnKRdjZR7T5y5+hyLwLm2x45yy55Nyv7c6iyiD0+eO3vnKDz7ceZImyud9YUqVktbSuuqWTexMQGB1qc+RwmgWvi7huMr99xkT844BaR/IngpVTT8d4VmmNEqH/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095009; c=relaxed/simple;
	bh=KN0cY/a9FX3IDvhE0fyWohVFNPIypbPP5KjmORMXHOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/uDb1x2HAPDE+8x8F7qVodRw9+gA1NOtFiwgJlZIhWBYcv9yQZdj1bObjICj5LnzSV4r6zjS3MhVkImoAbZO5ehe/mEa4QkRseAOPW4HAMatDMim2dbMG1PM5Gj+4c9Xc0xFi/iuAOpRYcHSPxnaTtNob3x96H8TNLd5T0KOt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OICjT0aq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52fc4388a64so790875e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723095006; x=1723699806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nad1XTaxK3UKHHR8/8Fx3UaYoxu11FGqjPFBkHuQWQo=;
        b=OICjT0aq4480KDF0+R/QMCZYsfQ6lkCxMin7DoN2Pjy3mZaOGijIrSwJTluPKv0wwx
         +Ho0jnDt3nL5Q2WjZn7ZDhy4P+/qbma0jiSydBGadrDVJYjEG2q0zTtz7E/XQf3PCbLV
         KSmBDyapAihJUEnrqQ6zAaPuyl1vwC4HNJufTNeBohgNPB4w7mqU4vRCmFxgc9TJJMjd
         rrHqPMeL3QJnr0vHMoN45pRJN9VaT6V4h4NgeEZtdYPTpRCf0qdx9cJ0stG4PIkr3CxN
         Ea79kVH2fUiHrcrwycyq2dtReaXPr5JxNPLrktp/yqZelLKmBzKhJLcJ3almmHTsUkje
         D/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723095006; x=1723699806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nad1XTaxK3UKHHR8/8Fx3UaYoxu11FGqjPFBkHuQWQo=;
        b=MsbrNWjdC6+FeitiYtNPVzWyUIgdyWGgOxUSwYJeIhkiXmDelrHGqgYvae/5b4fFyI
         c77+lVjUW63BwDE87XWEdX6yPnnuBYvJ/vl+2sXXkC8VC3aQtSOTKnaccEVUXMlW6wlH
         bZfz7YxUyH6tFDKNYPECQMWkoxaUMW60eOL9BffdA4KsnOK4FR5S79IXXcjabGHf4Too
         b3vDXwOpY3utIiaHjLagFQ9ZbdT4t/Q/fwCm75Mwt7yweLu5V4+73GxdSGUOX9259TUU
         7tLa5KsGDGLqKqlkcb31Jt9bFxDiSOQQZJJt/kQ5M7tgUN2s1JarkhUhl2+C74mz+5di
         wHMw==
X-Forwarded-Encrypted: i=1; AJvYcCXeeQmsi91cOc5hc6OfcNd96rtYg6/K0PrHd5eQeJS+J/Wlogize6Wu+QKDglX86mNqFh0OuMRS4Gn0ZaxczYRBoXb7Dw1sFASsa1tz
X-Gm-Message-State: AOJu0Yxr8BBFGs3x6Zp5XFD/AhxyEwujyuCo7hVLnxLLTOjeaL0on+vw
	XY3eGqLqilqrBS8LwueEmJ85sflJ55ne6Pfrca4TsQXEtDn3CidxAND95g==
X-Google-Smtp-Source: AGHT+IHbgKvTbc7S21df5W+RMuxCzjxTqAL1QaOGQ8KbKYMbaFrp3gZKq3sDo6vQc2Za9oZRJA0X1g==
X-Received: by 2002:a05:6512:318d:b0:52f:c2fa:b213 with SMTP id 2adb3069b0e04-530e588b99emr508158e87.55.1723095004778;
        Wed, 07 Aug 2024 22:30:04 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de481efesm482037e87.286.2024.08.07.22.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 22:30:04 -0700 (PDT)
Message-ID: <3bb91178-bc0a-4c93-a6f5-a685ff9a667c@gmail.com>
Date: Thu, 8 Aug 2024 08:30:03 +0300
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
 <87plrpvzmg.ffs@tglx> <12228ec5-cf2f-47b2-842d-ce336d921260@gmail.com>
 <87jzhpscql.ffs@tglx> <2eb39a8f-cc58-4774-836c-e6293300a4d9@gmail.com>
 <87a5ho4hb6.ffs@tglx> <87r0b02umj.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <87r0b02umj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/24 18:57, Thomas Gleixner wrote:
> Matti!
> 
> On Wed, Aug 07 2024 at 15:02, Thomas Gleixner wrote:
>> On Tue, Aug 06 2024 at 14:51, Matti Vaittinen wrote:
>>> Hence I'd rather learn from a small explanation (what is the
>>> expected .size) than by fixing this after I see regression reports from
>>> real users of the irq_domain_create_legacy() :)
>>
>> So the size of the domain is sum of the parameters @size and
>> @first_hwirq. That's so that the hardware interrupt is zero indexed for
>> an array based lookup.

Ah, thanks. This was what I expected, but wasn't really sure. Makes sense.

>> The association obviously wants only the @size parameter because that's
>> what the caller wants interrupts for as it obviously can't provide
>> interrupts below @first_hwirq.

Still makes sense :) I'll fix my patches based on this, thanks :)

> For more background.
> 
> The legacy domain is for configurations which have fixed interrupt
> numbers either in general or for parts of the interrupt space.
> 
> The trivial case is that there is a single interrupt domain with
> interrupt numbers from 0 to $MAX.
> 
> But there are cases which have the interrupt space devided into chunks:
> 
> hwirq	virq        domain
> 0-15    0-15        A
> 16-31   16-31       B
> ...
> 
> To support such configurations in the irq domain world, the legacy
> domain was added. Similar to that is the simple domain which allows the
> caller to specify a linux interrupt number from which the domain should
> start. See
> 
> 1bc04f2cf8c2 ("irq_domain: Add support for base irq and hwirq in legacy mappings")
> 781d0f46d81e ("irq_domain: Standardise legacy/linear domain selection")
> 
> for further enlightment.

Thomas - Thank You. I appreciate the time you took to explain this 
further. I didn't really expect it :) I was more afraid of getting a 
reply: "Please, go read the code and don't expect others to do your 
work." :) This explanation and the pointers to commits are very much 
appreciated!

I think I've seen code where some drivers used fixed IRQs - but this was 
a long long time ago in a galaxy far far away :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


