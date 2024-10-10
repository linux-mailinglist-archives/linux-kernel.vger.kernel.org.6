Return-Path: <linux-kernel+bounces-358292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49433997CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 785031C22127
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418919EED3;
	Thu, 10 Oct 2024 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRcaVMNu"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3431618A6D4
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728540375; cv=none; b=pKeMcyJiVY43NdWhXllLTHpA1qgzBfmxipt2P6gafWitiVt4ZdckXRbVZqn1HdAXBTvHd/fCwCyK3yQD7E/C9qlDWSY4sNDYi2LgA40eKwBsq8PzkFRodQkgQ+efP8xYXQkNgY3lRaycdHkmzMVYtJkx98+G9pFZWcnU2Yg0lpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728540375; c=relaxed/simple;
	bh=wDI9M0VUTK2V07yTXbkJn/eodimdWecJgH31V1EdOjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucKNogjGI5kJj07UwV42oLLhOv22ApklvAyvojlLSDkHaihkO148HlzmwstjSp59Nz306rNsyiZbwKjZHz+NoJbN1TdF+J8OJlT73A/n7UsRNABeKbM4cIaeFvppOcv6KCeAb8XYsLfe865aAqhqbz32/eZX6/K2QQN9m9v0wEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRcaVMNu; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so547509e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728540372; x=1729145172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDmfkcHsaZoE+Z/j0j3jVrFX1zabGcs5ByvLRQ2W7IY=;
        b=NRcaVMNuxFI4TGhxiBpc8yHXoOM56RmdaTV/c8vFdUm41uDxjf4vRwr3Sx+RMLujYf
         Nt2smPKg4uwid28GX72lZwgmxn6C1ExPQy87Z4KjNeBE0E9CwAiNqW8Kb+vHmly+Bz8s
         7HEUZpbf8XzM7DSsFh4QxGHx6ryCvi3/b/eGho8q10jc5x+rVifdEQ2u+qfgNbguqqVP
         WFkhqtC80oV//RvodfXN789ThWC52tXd6anr7chz4GWJW4o6E+c3EVuk35RfFcaR01Cb
         gVuh93okMYAOcvlPqYVXN8W03mM5z5sWfo4msaLZi2QDQpd8e39FkbCAvGEz6zes+bC9
         L/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728540372; x=1729145172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDmfkcHsaZoE+Z/j0j3jVrFX1zabGcs5ByvLRQ2W7IY=;
        b=alnO780fxdwux36iT4yq2vp6XuFFK7eZsFAgB3jM6ia7FED8/9IteRfapECt5qTCpS
         M1rT8vAqh+/slilzXwuPaN05ns9URiu/se/g3pCA0aJz1bMdcjLt2ZYpokPYcfi5xmxZ
         cB745VgUUtMRMz+B7F4Vx4eVRyh4R2kBsqgTgRnHhENDEH2TcCCbLApeGqwRjW7Hkf9Q
         QA/MdLhfQaRhziMfLWZtig4HGNZnNnLPynTesR8S4Y0kaEclk/6dOoEvPe7pRBoUo2RU
         m71UeMp+sgyM6qwkTRGMJ1U4cAp3pxeIMjDKv3zHNhU60il73BOra8MqfC3yh+CSUBRb
         kpiA==
X-Forwarded-Encrypted: i=1; AJvYcCU9pLJa0OKIvUBD88Mn/WD0772WqbzKu//NOmrp1IzbxsiC4qvQCuNV7uZZNpT4BQBAuhsSEFZlrQ8Ogv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGA5uI/AnDxNFT5WfQ+vYMWDuvFrx1jz+18emlLw5YZDh7in3j
	vbbKuVXukws0f1LSXgmV58ZzNvI1LhznGjuhUzow4KpwdXAPECi4
X-Google-Smtp-Source: AGHT+IF6IqkDzrfo7ZML+sPDXjd4gGptwZ3UgFrYw2RAuo5wopw6fuzvOt0tKS4XDgclnGrkqczkQg==
X-Received: by 2002:a05:6512:230a:b0:52f:c5c0:2879 with SMTP id 2adb3069b0e04-539c92b1adfmr1540595e87.41.1728540371982;
        Wed, 09 Oct 2024 23:06:11 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb6c8711sm114848e87.88.2024.10.09.23.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 23:06:11 -0700 (PDT)
Message-ID: <786b739c-8f4a-4222-bfa3-68b2ff26bf6c@gmail.com>
Date: Thu, 10 Oct 2024 09:06:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mfd: bd96801: Add ERRB IRQ
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
References: <cover.1727931468.git.mazziesaccount@gmail.com>
 <dda4464443fba81f79d5f8d73947dbd63083cff2.1727931468.git.mazziesaccount@gmail.com>
 <20241009161113.GA661995@google.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20241009161113.GA661995@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/10/2024 19:11, Lee Jones wrote:
> On Thu, 03 Oct 2024, Matti Vaittinen wrote:
> 
>> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
>> handling can in many cases be omitted because it is used to inform fatal
>> IRQs, which usually kill the power from the SOC.
>>
>> There may however be use-cases where the SOC has a 'back-up' emergency
>> power source which allows some very short time of operation to try to
>> gracefully shut down sensitive hardware. Furthermore, it is possible the
>> processor controlling the PMIC is not powered by the PMIC. In such cases
>> handling the ERRB IRQs may be beneficial.
>>
>> Add support for ERRB IRQs.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>> Revision history:
>> New series (only ERRB addition)
>> v2:
>> 	- Suffle local variables in probe()
>> 	- Unify and improve the error prints when adding regmap IRQ chip for
>> 	  INTB or ERRB fails.
>> v1:
>> 	- use devm allocation for regulator_res
>> 	- use goto skip_errb instead of an if (errb)
>> 	- constify immutable structs
>>
>> Old series (All BD96801 functionality + irqdomain and regmap changes)
>> v2 => v3:
>> 	- No changes
>> v1 => v2:
>> 	- New patch
>> ---
>>   drivers/mfd/rohm-bd96801.c | 275 ++++++++++++++++++++++++++++++++-----
>>   1 file changed, 241 insertions(+), 34 deletions(-)
> 
> Are the 2 patches tied together or can they be taken separately?
> 

I tried compiling the commits individually, and there should be no 
compilation dependencies between them. The MFD commit introduces the 
IRQs the regulator commit is using - but the regulator code should not 
abort if getting the ERRB IRQs fails - assuming I read the code right. I 
don't have the BD96801 at my hands to test right now (I'm not in the 
office).

Also, the ERRB IRQ registration is only attempted if ERRB IRQs are given 
in device-tree. I don't think we have users who run the bleeding-edge 
upstream and I'd be _very_ surprized if there are users who run newest 
upstream (or subsystem trees) AND have added ERRBs to device-tree.

So, I'd say it should be safe to take em separately, but sure it'd be 
nice to have them landing in same release.

Yours,
	-- Matti

