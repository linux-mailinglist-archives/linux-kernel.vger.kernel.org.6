Return-Path: <linux-kernel+bounces-246186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E7C92BEB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EC2285B46
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981E319D09C;
	Tue,  9 Jul 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dIejPo47"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6765D1DFCF
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539950; cv=none; b=If151fheL0vpTrSRH+BIUtIXSp2jU8TAR6NgHxjJazp9nGHt/F7M2BQAbj1BLu3H4DcKoxNsiMfRigq5D1ebGsckPS5FCzrNlUO1kP1AMm1IvB4sLxq2czfBH4Iiwg9RQyWcuzB/VyBwi8Bw0NtaWYybSDU8oagWn7qpieEGVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539950; c=relaxed/simple;
	bh=Kow0Kh24AuKtPvlxmcW7w5kWbM0ZjwJheuA5qfIhBGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6GuLceoTB6Y+p5purLefmbx2NID3yjO3DDfbp5KNJwqy0RGLHLywI0pqyoZen8YXQEZTR7jvjVZDoD1+B70eG0gjAYWr04GwSX/tFnRaZjMiZyd+9xKtIFmMB6mo+V7FI6Y1do1wqXIkcIwpwYQRdDD6jHvBgknFixQPaIWJ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dIejPo47; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso8296695e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720539948; x=1721144748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clrWidEGWWb7l5qAYeI3OPed/nSTgBQ7vf4x2SNX1dg=;
        b=dIejPo47zvyMKRvFOa6K9tLPkzr0pZF2jPqABGPM2hxAEmY/xEDCN982g83/Qapcz2
         NIjTlAWv9Ju44grvWwA/DUVi5FEdQ/Z8pzXkc0l7bHgUGDYXbMi358abXRrhJAOPmBfg
         cG05Nxmkj5jft4Oc6lAdKyeoG/utMNzJF7/+QverOuUl2KtylXMnpk7Gml9matnmlerE
         wqI12lBZBWrHlGnE3X3HRczbf/XukBeCd6NLco9B1rNDi+opLsVb+tj7/BHYt+uBJqyG
         aASODmQLhfYaaJBJXNDya4RfBz39ljap78s3wwMvY3GR+WSbrGLEGklgBRSlJhOurCu2
         OQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539948; x=1721144748;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clrWidEGWWb7l5qAYeI3OPed/nSTgBQ7vf4x2SNX1dg=;
        b=NyGhAsypldyfMriKmIKHP3M/hYupUNFMW2iElggfgiRIQBevnB1y42UNsSCbPxYz9F
         Oapwuz9H2unCpYnzlgXJQQTCVH8ITITv1jejHLct/43SDoBnVvcV+G+b3dny4nptV3Nd
         cB/cxlecSzsAD/rjBOHO/Gs4JibpdycHlETo7Kq0sT4uLTqCNkP1pXXjfcvlPMF7Ep7Z
         moQV8xaNuLjdd2S8UranvfQqqI314aRXOPY7wJC8n1SbXO0dKyder823vAG+DaYKnGWf
         V2CQubWDCXtmooB97BLO0DNv9wiS8lmWEeR5H1If0khNJw5xQJ8hj4g+LVX0iwLEOJOl
         iMOQ==
X-Gm-Message-State: AOJu0YyvodVYpIl00KQDzydD1tUvmbz8nXPeFf57nM6zFqU+fAHVXMmL
	NRW8Gfo8RSDLejAliNjZxwe6hAVIDsSW16MuWo6A2M6YLQpJ40z7GLK9nJ/T0W0=
X-Google-Smtp-Source: AGHT+IFLpPh9rDHh+Cj/f7TeYnsUSsIQHZnBJ26pWs4umPfFjYOH+my5M+Njgcp2s1ifcefyktakbA==
X-Received: by 2002:a5d:6288:0:b0:367:9ab5:2c80 with SMTP id ffacd0b85a97d-367cead86f8mr1762676f8f.57.1720539947806;
        Tue, 09 Jul 2024 08:45:47 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:cf24:cce:17df:12ab? ([2a05:6e02:1041:c10:cf24:cce:17df:12ab])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367cdfb2281sm2889772f8f.115.2024.07.09.08.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 08:45:47 -0700 (PDT)
Message-ID: <2101ef47-0000-4f88-9b57-8ebd5de32791@linaro.org>
Date: Tue, 9 Jul 2024 17:45:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] clocksource: realtek: Add timer driver for
 rtl-otto platforms
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, tglx@linutronix.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 tsbogend@alpha.franken.de, paulburton@kernel.org, peterz@infradead.org,
 mail@birger-koblitz.de, bert@biot.com, john@phrozen.org, sander@svanheule.net
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, kabel@kernel.org, ericwouds@gmail.com,
 Markus Stockhausen <markus.stockhausen@gmx.de>
References: <20240705021520.2737568-1-chris.packham@alliedtelesis.co.nz>
 <20240705021520.2737568-8-chris.packham@alliedtelesis.co.nz>
 <1bd8c455-567c-4523-8d8e-0e7cbc8210fd@linaro.org>
 <6b4d33cd-35b5-4f34-8ef5-14fb34b2ceaf@alliedtelesis.co.nz>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <6b4d33cd-35b5-4f34-8ef5-14fb34b2ceaf@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/07/2024 23:30, Chris Packham wrote:
> Hi Daniel,
> 
> On 8/07/24 21:53, Daniel Lezcano wrote:
>> On 05/07/2024 04:15, Chris Packham wrote:
>>> The timer/counter block on the Realtek SoCs provides up to 5 timers. It
>>> also includes a watchdog timer which is handled by the
>>> realtek_otto_wdt.c driver.
>>>
>>> One timer will be used per CPU as a local clock event generator. An
>>> additional timer will be used as an overal stable clocksource.
>>
>> Does the mips arch have a local timer per cpu timer and a broadcast 
>> timer already integrated in the GIC ?
> 
> I'm far from an expert but as best I can tell no. This SoC doesn't use 
> the mti,gic it uses realtek,rtl-intc instead.


Ok, thanks for clarifying


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


