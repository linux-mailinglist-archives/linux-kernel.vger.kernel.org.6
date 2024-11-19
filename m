Return-Path: <linux-kernel+bounces-414522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 666009D2960
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0811F21B72
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289E1D0490;
	Tue, 19 Nov 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fTafX3XF"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C91D0426
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029263; cv=none; b=siDx+5LA7Esu3OqDCSJVM4NQdLrFZB36Cmd08eojUIQHyJiUbBloEsj+UTuLi2Yo9mqRWORIZJWfiJbjngysuJbg7DHxOdXXWG+pYYKWH5BDzEUeiR0wWQrCpRHaITkviiMamxB4qCjY5UFL4GNVzI6Te9ECL1u/7HaT0jvrHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029263; c=relaxed/simple;
	bh=byCRkpmcjLYOiYuZ9sbi5crcjmK3Ichis8Fw/UWZ0gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgYxA94nbOENVKa5SB1SqBqgCL5D2RsIafv9ZHoJsg5rzb2psH/N0NNSwMsC17aUXld9fIpmzCTWVJPCu8bQSEkvO9M1ChbXbMLEe+p5+VG/Xr/pJhP29eEPI9kYYC7pC6rg8+nWtC/NirsuCakEcAMlDbTVqxjS36TS3+J3OI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fTafX3XF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e8607c2aso1258766e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 07:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732029259; x=1732634059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XApoDteQx8uwLmT1djRy37kdLKoweLorD9+kK8kGqhI=;
        b=fTafX3XFObAZyuMsqXEblfjYiF2gStJXvv6q7oXGfA5SSmVKJDd0t1nLfdobmoSuNZ
         Q+cYF3e6t+hclfhrSafgT0LtFtOv7FF9k7U0+F6mKMEbNpPipa8aQqBj1y8Ce/6Pq406
         gKWbdSiiYLCN5MY/D+J1ChAtCYxCLTuKZN76Y5qukjnydrNgc9WgLS1mn11Uj5iw3ccF
         N3XxzML01+2m9GvEJFX3T04XzZ7quAFWB4jYUNzGGrkBvutbonvTiNDFtWhE4RTu3Gn1
         U0vovqKSltYLi4fUegJs/Sst6BWWthxDCD+KzRrsL0BbX3r9BRg3AZeoUH3JHoat0MxU
         fWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029259; x=1732634059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XApoDteQx8uwLmT1djRy37kdLKoweLorD9+kK8kGqhI=;
        b=rdoSW0qzmr7BATotFh+5Vax8tHT+Qz9yacwwDiRERDSUZLbF0ZH44phzMdc9BvALXV
         CpsSx+nwgZdeNHluJcmDQSc7crsEDgjya/ZHSCA0C+odjTuOU110He9NCJwhYbuMBoyJ
         MJrRpPnagsKjZMITvFQjS2HojjRHicz49YAXnL+0aTKIi7eUShN5WEev7+ETBSUH+HZm
         bOQ0ajpsQadFYH18aIn6vtQB0QXk7ZmPIAcLd1es5bKvClWHSVNFsQLNYagzOG3dMG5r
         cHtpC1FKKJ5BINdlXpBecYp0Vdvd572U1CpDtpMrGE9SupQyeabVPsStZG2l4F4NKaIN
         THAA==
X-Forwarded-Encrypted: i=1; AJvYcCU04mMgHLCmlBIP06qlduDH9cSZa0kfRHhe3+NY8TfRyVbXXJ/YP8jHH47SrT9N5DigtgY7+9oA9tijwJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2/0meWoffdZi93MyH7iHoagSsVzYJdvwmnwro5MToBFvrcaZd
	kQ9gaHaERuL8WOJ2X+IRDpDaoW5yejN/ufoxHVlNQ3fod4bY25NdWe75d17rqYk=
X-Google-Smtp-Source: AGHT+IEUE1NmZYZC2AMtwb4y1seGjwr4lW0GYMgyKEoTqI2PAHQa8nbgWJxlnLMXfbEliJM6t9Jb8A==
X-Received: by 2002:a05:6512:2389:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53dab2a71bcmr7430240e87.30.1732029258740;
        Tue, 19 Nov 2024 07:14:18 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2946a3sm196687005e9.35.2024.11.19.07.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 07:14:18 -0800 (PST)
Message-ID: <1aa56690-1cd0-40e4-ab88-9445ad5b1877@linaro.org>
Date: Tue, 19 Nov 2024 15:14:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: qcom: x1e80100: Add CAMSS block
 definition
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
 <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-6-54075d75f654@linaro.org>
 <b91972e9-5cae-4a8c-b672-5b8d96d442d5@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b91972e9-5cae-4a8c-b672-5b8d96d442d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/11/2024 14:44, Vladimir Zapolskiy wrote:
>> +            interrupts = <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> 
> I've forgot to mention that you need to correct the interrupt type
> to rising edge, that's been disucssed.

Ah yes, I forgot about that.

Thanks

---
bod

