Return-Path: <linux-kernel+bounces-255244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A43933DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A9D1F219C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCC01802DA;
	Wed, 17 Jul 2024 13:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fLEsva+l"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5D41802A5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224058; cv=none; b=ccqjYGomHMvQQ6DJ6MB2kH9EnHmqoakYrWaijHtjnTamPSl2PFaWk+cqtPxayPbPCl16VJdATRBLtaJ/lY11NrvFmBLH+J8AV4bKR06ZTnZCjSb774geroU/aG8kBKD9dpyJPdt1CH7PtF8we7LbZQTTkXqda8v9mWR1JD65C24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224058; c=relaxed/simple;
	bh=3YXQ3Jp1Vw9VmoXeCe7hEucINqL8LN3lNkb2lR+5R+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1Wl5bbMaXS13+FrXohOJVEJ4MlCiGsfDbNvkIsMkHFBX/TrbfTTUZTozbvl9LqL81ATWbgIo/+Nmkuto3xsbnQY6HE8wphTUMrgHYfSsmSL6WGUoKFSJksXXxu/c1dnK11duywnduC67VABAacDa1QsID2L3LTehyZywqpLvBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fLEsva+l; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70af02bbb89so343723b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721224055; x=1721828855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBpW59picKN4VaRpDNbT71+2koRZ3tbahdtbsssxVqY=;
        b=fLEsva+lOzqgP4X3rM6nXQ8erbd2UD+vSOKhlXE2BEtTV9/z4+ao2wfTCimpE9OvYL
         3Oi07jBV3NXeGlgfY8w8ubpgOdB806Iuwx6TYOGT2kmav54zFIK6UJ13UNnNRi0VeVyd
         LMsrbApu2vXRVgyMoJjNB5AQJXn6X+/CHJ2KHwmZrOYLTEAoxP0v5lIHywj+IAXNePE/
         4f4ExKvO9bhYlY+RW/SAX5eIpsG+CH3z1Y64ODzSge3yt0mfbChGBtqKfJfvEos81E+2
         Lo7eAYbVOXsBdzwerTTQawkgTiN445izZbSTR1eECwhzHbLhxIPUTZR4QjHH5bh/vY18
         napQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224055; x=1721828855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBpW59picKN4VaRpDNbT71+2koRZ3tbahdtbsssxVqY=;
        b=So0QhjuxOLUFJJFDchIY35TL0Zn+KI09i1yLlDA2yf1dnQrchuane437hj9PVnEZxt
         obYAEAKAwV8BpzNLH9/qzKpCqGUgQcSxiDl06G60WloOGaAUdb69HSeGI5LllQDfjLVX
         5jj5EHBUhL2DHbsPrD6f42QES8yZdo3Wblbf+bR9OyP4jW2GfLzNinU6JoIntLr9B1Zl
         AuViT8lpl0r27ZJw6nAVwEBTEE1fiHq1fAQLvPHg1xHzc2L8lZZAAB1AU/0kKb8jUTOO
         KCSWBucBLIzYbcZ40+sxaXC/unzAdMZdfDohWIbT9yokq+wItAn1giM7s/GYFWIfYjqC
         yJwA==
X-Forwarded-Encrypted: i=1; AJvYcCWSqcjBRlmA2K6WSqnBL90DOW26kcILQkx3MGsCy74z1k5UFTXF05vkFibBKRlD9wHFCwhnQa2trRedf6dHttmBCBXaSkqbCWTf6cPU
X-Gm-Message-State: AOJu0YwuVJWtXbDrRYIMQnV5O1mAwUnTYtk1SDXUU+9uumEFTZQU3iwz
	iF9+uCHtmA7gC2a1hvXP7MhmNMlE2hutW8BJvtA+j5WJynzJxszZORfCe58G/Kg=
X-Google-Smtp-Source: AGHT+IHxw4bA3LWgtRU+YCa2X8Fc71AQA7LAYI4IkNfRbYCBvMwnBVW5kGHw/SElv4tOqos0SFFZEw==
X-Received: by 2002:a05:6a00:2d9b:b0:70b:705f:43ba with SMTP id d2e1a72fcca58-70ce50316c6mr1087853b3a.4.1721224055153;
        Wed, 17 Jul 2024 06:47:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca7865sm8104592b3a.158.2024.07.17.06.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 06:47:34 -0700 (PDT)
Message-ID: <5b974edc-0029-48a1-b181-6beef36869e1@rivosinc.com>
Date: Wed, 17 Jul 2024 15:47:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] RISC-V: hwprobe: sort EXT_KEY()s in hwprobe_isa_ext0()
 alphabetically
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
References: <20240717-dedicate-squeamish-7e4ab54df58f@spud>
 <cba0c880-a1b2-4bb8-bef0-d280d87ec308@rivosinc.com>
 <20240717-unluckily-collide-1aa35c97662c@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240717-unluckily-collide-1aa35c97662c@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 17/07/2024 15:42, Conor Dooley wrote:
> On Wed, Jul 17, 2024 at 03:34:06PM +0200, Clément Léger wrote:
>> On 17/07/2024 10:54, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> Currently the entries appear to be in a random order (although according
>>> to Palmer he has tried to sort them by key value) which makes it harder
>>> to find entries in a growing list, and more likely to have conflicts as
>>> all patches are adding to the end of the list. Sort them alphabetically
>>> instead.
>>>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>>  		if (has_fpu()) {
>>> -			EXT_KEY(ZFH);
>>> -			EXT_KEY(ZFHMIN);
>>> -			EXT_KEY(ZFA);
>>>  			EXT_KEY(ZCD);
>>>  			EXT_KEY(ZCF);
>>> +			EXT_KEY(ZFA);
>>> +			EXT_KEY(ZFH);
>>> +			EXT_KEY(ZFHMIN);
>>>  		}
>>>  #undef EXT_KEY
>>>  	}
>>
>> I'd prefer that to be done after removing the "if
>> (has_vector()/has_fpu()) by using the .validate callback for ISA
>> extension. This way, you'll have only a single commit reordering everything.
> 
> Right, and I do have some WIP for that here
> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/log/?h=validate_fpu_and_vector
> but won't be sending that until it's cleaned up after the merge window.
> I was intentionally sending this during it so that there would be no
> moving pieces for this to conflict with - because it will conflict with
> any other patch adding things to the list tails.

Makes sense. If you think it's worth it:

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

