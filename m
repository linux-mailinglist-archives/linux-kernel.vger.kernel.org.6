Return-Path: <linux-kernel+bounces-211238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E62904EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1246B1F221C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2E116D9AB;
	Wed, 12 Jun 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyVWd1Cm"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581616D330
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183618; cv=none; b=bGw9GsjgMkS24HV41xI6O/WZiiWGpep4lnvG9EyaQ94lzezWilSf9anoseZHXKe8Qghy62hlofjpncin7tUsJqUOt5hqeJBcollOsqQwPHXCeNfABCA/7RG1bbxBsEXDE9AS/gQeHotBMvVpkh5Kwa28fCE6IQPorQxUY2ldxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183618; c=relaxed/simple;
	bh=j8FlzZswyZrdWHuPm4vDFTQ0SQ+sH3WR6PptS3UTEGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDHEw718zpY+sXpQluaqjZEFtmdqo5NKasUHcIxO8/c83896RctFHZLzVZcYS5LxdpZv6SMG5dKGFJ0Fgwz5aMvUoOHUbeC68Om4fzL4TpFdYMVnVbw2yhRb2LzVPs0gRj+U2+PsqyebF2wITFsk0SIkU7CsRODzds80Vc+BTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyVWd1Cm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c778b5742so4455697a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718183615; x=1718788415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2RaRwZY/TeqpJK2AA/6tfR5bEggSmTNICLDhm6oAAGY=;
        b=OyVWd1Cmmmxw96C54WnpScAn5EzrEyrveCZdgcq+HvjlmkbKhhAb9Zi7MttsYvkyMD
         pAJfb5kAyVcLfMAC9R+HYH2DiH2mASNu5wELPstfrUnJa2DvlTVOcPMXrpe6Vt+6aqEj
         vxkKcofl+9FgsrYUc9vZKh+FMvSJsMXl/1O8L5oHz5n143hIOk89fAmFYODyTBC8eTeJ
         cvVocoQfVdIARPc6dm43D4/BZsUbPubrLfKPN0Z+gQBjY7er/zHlqAi1l7AZMAxrDT1c
         zX7opef87xLSL647qSj8ikmatesBkE3G4gsBwuDEAH/5aPXID8DZxZj4xEJ+Lv5yID3Q
         MB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183615; x=1718788415;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RaRwZY/TeqpJK2AA/6tfR5bEggSmTNICLDhm6oAAGY=;
        b=h9DKv0AU5EBxR/UiH0VLU0AazHPNQ7au714vKpfLfheR1d3UDHEJxGqb5PCHt2MVb2
         1Up/Hq+q/t9W6ym2+TRwB78mxRu3Zx9z+MF014QjlW9ens6SdNek+zy6yagT/oz7Nxg+
         aVV1pMgqGtem5fVPTvjE8MbeMaJSXpp81Y/oFKlMfKcCQT57igIrAAP38Ni0uiySWLD8
         DoqCz2AcOGGSNETKxdP1fZCgkijx1qfddGGJbn78WhBKobvJJOR8jtmMQKevfQUVgweP
         Hzj/kHPAECAX1UM1Ubsen3vL1ifSn0kVqpw0qk3HlsbOWm7cjhr73H9xkayNKgj8JNlS
         7DMA==
X-Forwarded-Encrypted: i=1; AJvYcCVMg4cajSQ1zz+m+eElwZv8uRAq99YBSYnEqXPjLiiA1ZuyTcnTKEnzmiXflWvvGsbxaQUFU7fD31YtZnXf1ZvkEx0uqVJ4P7dXaPti
X-Gm-Message-State: AOJu0Yykf6MvytqYwsNaL477YeXq1gyz2rKWk1trtIBRJi1ujGLJTy1o
	Ikmz2pz7tkiosZlmg/UytjwmahG2F38DlLuQ4ngLfXVMMLVfknEbOWvyrYR+CRCj736ea5IHX2h
	Y
X-Google-Smtp-Source: AGHT+IHLw5sP1+Su4LuW1t4YjjnNqCfmuAZ6LUlmL9sCtLZoSuUFnNPVMoQI48zPX496swrW4hoDLw==
X-Received: by 2002:a50:9f45:0:b0:57c:8049:a9a with SMTP id 4fb4d7f45d1cf-57ca97495a3mr817656a12.2.1718183614654;
        Wed, 12 Jun 2024 02:13:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57ca472956bsm1393045a12.29.2024.06.12.02.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 02:13:34 -0700 (PDT)
Message-ID: <47ddbc43-889a-4def-8e39-e4f166eae667@linaro.org>
Date: Wed, 12 Jun 2024 11:13:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document
 FPGA syscon
To: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20240518203903.119608-1-krzysztof.kozlowski@linaro.org>
 <171741897752.2195655.18414699008765504203.b4-ty@arm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <171741897752.2195655.18414699008765504203.b4-ty@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2024 14:51, Sudeep Holla wrote:
> On Sat, 18 May 2024 22:39:02 +0200, Krzysztof Kozlowski wrote:
>> Add dedicated bindings for the FPGA syscon registers on ARM Juno board,
>> to fully document the block and also fix dtbs_check warning:
>>
>>   juno.dtb: apbregs@10000: compatible: ['syscon', 'simple-mfd'] is too short
> 
> Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!
> 
> [1/2] dt-bindings: arm: arm,juno-fpga-apb-regs: document FPGA syscon
>       https://git.kernel.org/sudeep.holla/c/3e295d8b4731
> [2/2] arm64: dts: juno: add dedicated FPGA syscon compatible
>       https://git.kernel.org/sudeep.holla/c/2e84e7ed7b02

Thanks. It seems your tree is not in the linux-next or this branch is
not in next, because these patches are not available in next after a
week. Maybe you need to update the branches being fed to next (including
pending-fixes etc.).

Best regards,
Krzysztof


