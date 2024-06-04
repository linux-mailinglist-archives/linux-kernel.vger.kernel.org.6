Return-Path: <linux-kernel+bounces-200401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637A8FAF90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B209B21B89
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D14B1448E5;
	Tue,  4 Jun 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cejBNBca"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D31448C7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495632; cv=none; b=oZtk6/YORQu08FpgDRkfOoZcISZhRlohjaHJDIUMMrkbixH4OfxKmSryO4IRExJYSYAV8EfphouS4lKUfp1/j/oLv7Gz0dzKIDt9IEY37O/OGHsMGz+0CbB4m7Ov6IS0Qc6J+surPDwvxJfgbssEAcmT9n8aFQdVPIIe00JZQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495632; c=relaxed/simple;
	bh=EIzX0VIvifNR7gGUEdS6bX/YrhY0gPgKdvPUsu/FbJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g+f0+RQ7jJxtNj1pwzwcL6sjt5u7Cu8RKJCIv/hCPyzUdij1aLPhRSf5njzHjh6+kwLOd7NJufUcqugp1BkUulreQzDU5cfXVkNArMtOR8BumyiCxE7P4Z0xLX7yXd6+d8eAaEgpN80s76cMntSPFtFtEkw7bGrMYiX46912TYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cejBNBca; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354f14bd80cso670703f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717495628; x=1718100428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rREN7Lq+ZZE1PC3y79zUdv9feU8GRmXp9AxvPR/Fz4w=;
        b=cejBNBcaMEwCuB9QHeW1o+z4VwVs9cbjNIO5yGP0oRuWS699L44l2er/8i0Gl4aADf
         ABONzvUR+1O4ChwDlnt+7XjLpL9sFrMWSh5zdYW7Lg/Zg5Uf/2wnagzoLbpj6QrhgQxP
         ywJBHXrcYntxxGpsty63BzTJxxFfKoagqXRzJfDwuypZqfWFJyKCMAVLHNsLY9ZOzGJG
         EhP8gFyVKuWqoMebpoO0hBDizqxlxDEgfOsdv/5TdyDKeyQD8+WitoFpYFcTtCrH2gpj
         IcFnuuBFxh/kbVjbnBHSqiIy0xy3xtgOwozL3pSFiVhiLv1cIe9U1MNnd8O/tLlVgtcZ
         iWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495628; x=1718100428;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rREN7Lq+ZZE1PC3y79zUdv9feU8GRmXp9AxvPR/Fz4w=;
        b=RgTXZ0hBMRkmRIyEv4AMftEHoAbY2uqtE2VV/Z/VB+I2w/Bvd/cLkCOOXPSMz91QSt
         knsooGFpiBuC3+yXIwiI0B1HlKEmlgebG0ArJ4gc9RhIA7KFcuFuIjl7tsc6dG/xH8fC
         RCovluBR5rX/4wAbnV30SiBFkoUQk2Cd3m9BH9i3KgbMwxf4w4cHd5dbXgU/aQ3RWmIl
         NgN/U6rM1u+KLh3sUCN6ki/wcfWHvMzdpswtYhdGqRThw2r+e+hvodsTzMXZtd4VgWtd
         sr4ZaKJvJIJrX2NNaQhB+faaEuPYP6l9Qqj6nL9v1c6Tw+5tJ0Ldl+MPUmqabSQYVLhb
         KpNw==
X-Forwarded-Encrypted: i=1; AJvYcCXiwu5Jl4rd2KZ68i8myDdCiFfSWn1CuqKGKuyqfhDa7urWMlRA7ibt84EWplc9NSW/EZGFALK/HbB99ZGSSajLJ6/j2nKd5qIqpmo4
X-Gm-Message-State: AOJu0Yy4OuvTp4tXp1fIdPdYK18NolUwGfBu3A8OemS29y/wWrRtpe6X
	CPzKApT85uPkoorrKQadeUq5Tljk8KzrReYHWF3SWLCX0/+4DLxcI/xiunxkQdQ=
X-Google-Smtp-Source: AGHT+IHIFBH97nu/qudGQsBoxLpAJnB6xF/3E1+QcVBFBu5Nbi57Xz/fzOO2UyGDiSasa3JhUJ1acA==
X-Received: by 2002:adf:ee0b:0:b0:354:dfdb:f3e with SMTP id ffacd0b85a97d-35e0f25a556mr9634044f8f.1.1717495628354;
        Tue, 04 Jun 2024 03:07:08 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04cb1e7sm11047792f8f.43.2024.06.04.03.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 03:07:07 -0700 (PDT)
Message-ID: <a4f462c5-3410-4bd9-93b1-ad26f36d282f@linaro.org>
Date: Tue, 4 Jun 2024 12:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: stratix10: socdk: drop unneeded flash
 address/size-cells
To: Dinh Nguyen <dinguyen@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240401141025.98125-1-krzk@kernel.org>
 <6d2cf4d9-0b6d-4fb2-a130-7695baa118c3@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6d2cf4d9-0b6d-4fb2-a130-7695baa118c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/04/2024 14:30, Dinh Nguyen wrote:
> On 4/1/24 09:10, Krzysztof Kozlowski wrote:
>> Flash node uses single "partition" node to describe partitions, so
>> remove deprecated address/size-cells properties to also fix dtc W=1
>> warnings:
>>
>>    socfpga_stratix10_socdk.dts:182.10-211.4: Warning (avoid_unnecessary_addr_size): /soc@0/spi@ff8d2000/flash@0: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>> index 26173f0b0051..4eee777ef1a1 100644
>> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
>> @@ -180,8 +180,6 @@ rtc@68 {
>>   &qspi {
>>   	status = "okay";
>>   	flash@0 {
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>>   		compatible = "micron,mt25qu02g", "jedec,spi-nor";
>>   		reg = <0>;
>>   		spi-max-frequency = <100000000>;
> 
> All patches applied!

This was two months ago, so it should reach v6.10-rc1. It is neither in
v6.10-rc1 nor in linux-next.

Are you sure you applied this?

Are your trees in linux-next?

Best regards,
Krzysztof


