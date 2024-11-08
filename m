Return-Path: <linux-kernel+bounces-402343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D551A9C269C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F291C21ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CEE1AA1FA;
	Fri,  8 Nov 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SP6vAW2D"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF91C1F11;
	Fri,  8 Nov 2024 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731097864; cv=none; b=WxAo/iNMRXp0Rt4F3cS4jYipdNzFKhF13jtnthpzpfvslWjM2peG9U19xZ75U8x1hIHpKhe9ZoYGluNFCuQp3FaJw6qPLCJjf8tFZUVl52SerkBQRNTX5y0hW6KCO8P6V4P6QbEXop9a038aFQDgFNi7iCU5BrM+1SycYaVgq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731097864; c=relaxed/simple;
	bh=eRCb2WzMBlgHzf350SW31GIAQjE4jPD10X4h87w82IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouaQbiaFh7nynWjlpK+FAEOsZlxNPZrXWeFvRSkS7xcF5y9zY9vbb/PY7gHr+7WSRr9+YPMe2ix3r2xtiSyHKpQfQ8FFSTqPSxnmyytjj4ZPr3ywRY/W8eY9YxbZomfrhJtQJirYa06IkiuZW+pAcGyzIXxYLSimkZ10j/mRuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SP6vAW2D; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so6296689a12.1;
        Fri, 08 Nov 2024 12:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731097859; x=1731702659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=975RhISS9snOVR5cT+Z99sFnn60KIbe7YuBqYHMl/W4=;
        b=SP6vAW2DMcVrxTVHPo/o8P9kMFBqx/z00bnXB3aKqJpxKiBEehi1t5dtveRGF1JRwy
         wLWVHyCmBTPsh1RQ2eATg+cK1S7vfUqsA0Ot2LlD0bDHIafX3wABhBYy+UkVHvMiJvo5
         ujESwYd4iW+/yaFfJD8y5vqj+B36aF61wFUsGM3k/1lWJinRKHetYtmhqT9CUvhucIwL
         HC9yF64MWLLxbAhu+RQwsA9/+OP35WSYX8OXpmV8uj1tTPajRNefbfAV2Q6d1h53UGCC
         ur6QLLXf8ppgTJfrHchKJJoJGptGfrkaY+fb5MpK19An6nCEJX6xoqWUkCba01QKYzLx
         NawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731097859; x=1731702659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=975RhISS9snOVR5cT+Z99sFnn60KIbe7YuBqYHMl/W4=;
        b=kXQolZWcOct0Pj/Fao2pBgCu4BAQFXPU/Fa9jftaibcysCo1gLH6tjwq2g2khzssIJ
         axeQqGVcYnXRYzeGrICqu9Cx4HIioIgNp5Yyo5anvXgrg+ljZ3ayiuHCUDMk6+ZXK/c4
         beQmZ02KZKt+kIsaTOVCcrD4/k9TcJCHYn60SGHUc+3kY75cj6dmNPAkWmQSjOuKMmSj
         M3M4pDQyU0qUSdWjlqjDyAgCHRioMbaB7itNu7QMx7ueaT6NXiw+VuFCIvlKtTXoa7WP
         DTt7Sd7UQgRzegfeOxkrK6ba47lySHXQuPUJfokeZrTe91D4Vwl5UamD/LmFYfEuE+cF
         UbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4SRlSDWbO5B7SjHx2LNGcc0I/5Q8tJ2E6Z1fSzA/8RZk+JOPR7PLegFKAt20vrDNhdF/q5w7vnR69@vger.kernel.org, AJvYcCXCjkSlY/u7IXFB0arI+aPsJmpkgdpdj/2UuAjNckTVC+pg0vbws0M7Srnr3U2hzWe6vFmDMmYi2q3R7Kt/@vger.kernel.org, AJvYcCXnJJ5z/dUC7dhEOKZD6u8moTPjMJowyvT7E8U71IlmkEEDjnhZESWyb852SFNlDP3ygBtTstlq19io@vger.kernel.org
X-Gm-Message-State: AOJu0YzzK1jS1rDt9U/VKcidMat06lLC3XAy7Di0vsc9ecMvnoKl+Lwr
	zJN6K+n3vBTXHSh/t6lBDzDwl6x3PL8qGI/lPU9bwUNVeO2RtaTT
X-Google-Smtp-Source: AGHT+IFnA8B3gdMncl9joVkiKED9mz5HN7VDKygr8RmfOVjjuIdQIDKMdQdT9VxpfjiqrYuVhJu+RQ==
X-Received: by 2002:a05:6402:2552:b0:5ce:c7b1:e052 with SMTP id 4fb4d7f45d1cf-5cf0a49307cmr3860824a12.9.1731097858843;
        Fri, 08 Nov 2024 12:30:58 -0800 (PST)
Received: from [172.20.10.2] ([37.63.10.207])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d7c3sm2329997a12.16.2024.11.08.12.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 12:30:58 -0800 (PST)
Message-ID: <d5d3f934-4f1c-43d9-aaf9-8de194d1f3b7@gmail.com>
Date: Fri, 8 Nov 2024 22:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: clock: actions,owl-cmu: convert to YAML
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241107143431.728669-1-ivo.ivanov.ivanov1@gmail.com>
 <a4begcrmbtotl2imd3eaxpdveagvwridy6ev5zmwzvjqt3ovfq@wyj2dj73xe3e>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <a4begcrmbtotl2imd3eaxpdveagvwridy6ev5zmwzvjqt3ovfq@wyj2dj73xe3e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




On 11/8/24 14:16, Krzysztof Kozlowski wrote:
> On Thu, Nov 07, 2024 at 04:34:31PM +0200, Ivaylo Ivanov wrote:
>> Convert the Actions Semi Owl CMU bindings to DT schema.
>>
>> Changes during conversion:
>>  - Since all Actions Semi Owl SoCs utilize the internal low frequency
>>    oscillator as a parent for some clocks, require it.
>>
>> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation: Please add
> Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
> or above your Signed-off-by tag. Tag is "received", when provided
> in a message replied to you on the mailing list. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for tags received on the version
> they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
>
> I cannot add other people's tags - toolsets ignore it.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> ...
>
>> +maintainers:
>> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> +
>> +description: |
>> +  The Actions Semi Owl Clock Management Unit generates and supplies clock
>> +  to various controllers within the SoC.
>> +
>> +  See also::
> Single ':'.

$ rg --files-with-matches "See also:" | wc -l
110

$ rg --files-with-matches "See also::" | wc -l
94

Having 94 matches of that out of all 110 definitely leads me to
think that this has been done on purpose, and is still being done.

Could you elaborate a bit more? If it's wrong, then shouldn't we
clean all the other bindings from that mistake?

Best regards, Ivo.

>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>


