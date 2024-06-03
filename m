Return-Path: <linux-kernel+bounces-199100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 449858D821C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A721F211DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A112D769;
	Mon,  3 Jun 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAm5oKSM"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E412D750
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417156; cv=none; b=uZkPpeFLCmGRbBeTlSvRTsWMleJ2DWqkITQVhrSyt5lepH0CeJ6Kn84ezJziulGlz9stROzsU09Hk2V1BWGJRXh/dfuWoBsUa4R0VbPQ8o3wiJKG6gsotsw+2QwD+l1Y0b9QAsNLR+8clpuWvS944CP5J6hUsyKyMTCQTALp99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417156; c=relaxed/simple;
	bh=F0E9C22tDPo0Z1od7//5qNNx7pzC4Rvgy7rMX8/Lftk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiVTNhGt8Yh9Tt3qPHFSJXZYGuHA2KBHPT+cbbCBHNFRRb3nKhIT4f+akas1TLV8Upj/a3V95NX2XJ5Sj9pdV/wcOfA1F7u00KwrtKVfbpr23m9p4wL3jES2dflrPAVFFDyLACxZPCMyIpZpEthLPsZ39Zs/oJHSQw4mmUSfFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAm5oKSM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso59721471fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717417152; x=1718021952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTbPmLecH7Pt2eK8k023/6qFrX2BwjOFK4xkfjYNDto=;
        b=ZAm5oKSMkiSi33kMyBDiXU7ZCWV3pgkAeWKhynia8XeOOTOXeYAOfdEt+cX5665Wmb
         ejZ76IATvulyEqXFb2Tj9/FUxAvQekkXVOEuIl4EKlSjlVj3n2KdSJj3STa3jpFogIY1
         sFoH94wwpksAjazUlb8VtCohHrTZP5ryuJA+C1GTRWxoKr3SFC3judtXxy9S89hqaHiC
         dmYbfL1LPUQPPKaPV75xHAfiGlOJEczb7CsVEHGk6bS1/hrupMLfL0JChbJXNdZLMTgx
         ChYfhfxPbPqkSdwnkrTM3nTS1EQP9bC0haYO2O6DBdwVaOGxz+078Pdz3XCx53oe0wpM
         91Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717417152; x=1718021952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTbPmLecH7Pt2eK8k023/6qFrX2BwjOFK4xkfjYNDto=;
        b=BlAWGNdPJ0rxzcdbgaBNpigiIqLc3Bduc8pFV9nkhvgF5JGbU5vUw856p37P6UawrX
         c8Gaj8l0NgoI8u1AUytOFRsnUBntvfi9k/JIMs6erDvqYijqlGdtqk+6F8G8OqQdCTOJ
         8dDdQ9SCCrKd1xZzapxW3EfSswnV8R0UkRgVEUUKhMuDmSvRfddc6RxliDe56TgxE/D9
         okVoHLEyFiLhSnsC3GkFjgo2A8AJXEOHHRcXmlnRJfeq6ova+WRt4G9086vdaOqx97qI
         qQAriKiC9XnsFcUdakVEiidtHQ9GphNTJ9e/d3MBqcqN+BN7UpZXYKexr2Uc2AhvwuTq
         DoHg==
X-Forwarded-Encrypted: i=1; AJvYcCU7TNIPF/7hM4ngIyEddwuUQ4b/wCwo860cEAEXnt2+lVgDQt9Jg8JYAMmb3fRDutCEegoC7NX3Y8Su4/rspaCeUhktR1X0wC0veil8
X-Gm-Message-State: AOJu0YzHThF5T7AKK266HVR+n9r4RUvjrkfHzOpiT1pj8JgwJnU03uV4
	1CmBP+RerRqWoAZd6Qubd9yyecK7D19LUeCI2PYAT8cgIS+nWBGFZ+2RAA==
X-Google-Smtp-Source: AGHT+IEtE5RQJhFDe8uo/eyyiQ159w2x4MnldhhkOhVTsyqtSDkJ/I4f0MQ6PllYvSwKjQ/q0RS9wg==
X-Received: by 2002:a2e:91c4:0:b0:2ea:7def:dc93 with SMTP id 38308e7fff4ca-2ea95166fc8mr64844041fa.27.1717417151720;
        Mon, 03 Jun 2024 05:19:11 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ea91cc7cd3sm12200771fa.92.2024.06.03.05.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 05:19:11 -0700 (PDT)
Message-ID: <77c64d75-43fa-47bf-bb3a-e0e49d51189d@gmail.com>
Date: Mon, 3 Jun 2024 15:19:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] irqdomain: Allow giving name suffix for domain
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1716533790.git.mazziesaccount@gmail.com>
 <2ea1749587d9e5a74a80a8eee7caf58c3e954a6e.1716533790.git.mazziesaccount@gmail.com>
 <87h6ea72f9.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <87h6ea72f9.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas,

Thanks for taking a look at this.

On 6/3/24 13:20, Thomas Gleixner wrote:
> On Fri, May 24 2024 at 11:18, Matti Vaittinen wrote:
>> When multiple IRQ domains are created from same device-tree node they
> 
> s/IRQ/interrupt/
> 
> Also most of your sentences lack a substantial amount of articles.

Usual ack for any language related comments. I'll try to proofread and 
improve.

>> will get same name based on the device-tree path. This will cause a
>> naming collision in debugFS when IRQ domain specific entries are
>> created.
>>
>> One use-case for being able to create multiple IRQ domains / single
>> device node is using regmap-IRQ controller code for devices which
>> provide more than one physical IRQ.
> 
> This does not make sense. Why do you need multiple interrupt domains if
> there is more than one physical interrupt?

I'll try to explain myself better below.

>> It seems much cleaner to instantiate
> 
> 'It seems' is not a technical argument.

I am always having problems claiming something is _absolutely_ cleaner, 
as "clean" or "messy" are subjective and depend on reader. To me this is 
cleaner. Also, Mark Brown thought it is cleaner. Still, it does not mean 
this is absolutely cleaner for everyone. I am open to suggestions how to 
rephrase.

>> own regmap-IRQ controller for each parent IRQ because most of the regmap
>> IRQ properties are really specific to parent IRQ.
> 
> Now you start talking about parent interrupts. Can you please make your
> mind up and concisely explain what this is about?

I hope I can explain what I am after here. I am also very happy when 
incorrect terminology is pointed out! So, it'd be great to know if I 
should use 'parent' or 'physical IRQ' here after I explain this further.

What I am dealing with is an I2C device (PMIC) which provides two GPIO 
IRQ lines for SOC. This is what I meant by "physical IRQs".

----------------	INTB IRQ	-----------------
|		|-----------------------|		|
|	PMIC	|			|    SOC	|
|		|-----------------------|		|
-----------------	ERRB IRQ	-----------------


Both the INTB and ERRB can report various events, and correct event can 
be further read from the PMIC registers when IRQ line is asserted. I 
think this is business as usual.

I'd like to use the regmap_irq for representing these events as separate 
'IRQs' (which can be handled using handlers registered with 
request_threaded_irq() as usual).

Here, when talking about 'parent IRQ', I was referring to ERRB or INTB 
as 'parent IRQ'. My thinking was that, the regmap IRQ instance uses INTB 
or ERRB as it's parent IRQ, which it splits (demuxes) to separate "child 
IRQs" for the rest of the PMIC drivers to use. I'd be grateful if better 
terms were suggested so that readers can stay on same page with me.

After talking with Mark:

we both thought it'd be cleaner to have separate regmap IRQ instances 
for the ERRB and INTB lines. This makes sense (to me) because a lot of 
(almost all of?) the regmap IRQ internal data describe the IRQ line 
related things like registers related to the IRQ line, IRQ line polarity 
etc. Hence, making single regmap-IRQ instance to support more than one 
<please, add what is the correct term for INTB / ERRB like line> would 
require duplicating a plenty of the regmap data. This would make 
registering an regmap-IRQ entity much more complex and additionally it'd 
also complicate the internals of the regmap-IRQ. It'd be a bit like 
trying to fill and drink a six-pack of lemonade at once, instead of 
going a bottle by bottle :)

>> -struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
>> +struct irq_domain *irq_domain_create_legacy_named(struct fwnode_handle *fwnode,
>>   					 unsigned int size,
>>   					 unsigned int first_irq,
>>   					 irq_hw_number_t first_hwirq,
>>   					 const struct irq_domain_ops *ops,
>> -					 void *host_data)
>> +					 void *host_data, const char *name_suffix)
>>   {
>>   	struct irq_domain *domain;
>>   
>> -	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
>> +	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size,
>> +				  0, ops, host_data, name_suffix);
>>   	if (domain)
>>   		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
>>   
>>   	return domain;
>>   }
>> +EXPORT_SYMBOL_GPL(irq_domain_create_legacy_named);
> 
> What for? This new stuff is not going to be used for legacy setups with
> hard coded Linux interrupt numbers. So there is no point to add a
> function plus an export which is never used.

Thanks for pointing this out. I am more than glad to drop this. It'll 
just mean that the regmap-IRQ (which supports using the legacy domains) 
should warn if user tries to use legacy domain with name suffix. Mark, 
does this sound reasonable to you?

Thanks for all the input!
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


