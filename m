Return-Path: <linux-kernel+bounces-434653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEF59E696C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F018844E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05E1DBB3A;
	Fri,  6 Dec 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqjBTK2L"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB71D9A48
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475370; cv=none; b=VrxDEo+G5bp98fiwyhsuDMio1Al59pZ2PJ8yeANDv0R1hUwwipYBN8t7g54j0mfJ1plMiVsKtX5TDLtR27bOitEqiGDvbFr2hbXQjaM2ZSMWSpkLCuZYjoag9MGmAOz3ELi5Onls7nf8ACC4CmJvcAJHdxK2NN0+ZYS8NgOFtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475370; c=relaxed/simple;
	bh=DOJSPP8Ve2tC1hqg6s8VuO/WQMxAmJRjapcFvpY/mN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5aojamvURn7ACeAJQIVPTRICfOv08hJEuGW6U+ZKGgqu7ZwGbBY+BqswUdx2NA8FOYcIBkYNmduqXOfn2ExqzzxMhz2tSAan2URZaiQR/o0socXeUpuTFWrZROYui86cKSU3z+S1XCxjco22IjFUdsgpNu8zEAG2UWSgQjphFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqjBTK2L; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so2260325e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733475367; x=1734080167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HSgIBcefpJRbNbP13a1FZf8AfN5Xy4J6ToBZHWVVMys=;
        b=uqjBTK2LnLCT4Puzgv0UDYqSPs8w/0Xfio5MMHCgBh6S75/Epqn7duUI5UJ0OS5Ld+
         f7kQkHZd8XuIbRwyupwVV/N0WZHrAHG3WSOInwclfNoLOnHQHtDLw7DE51zsNbiRtZO5
         7Ac5XnX24wV3vLb7r+uAeYmCXOc1i7wljm+hKOjc4VdXEDoXx6Nqnay0cqjwV+0jun0y
         eHU0TRrr6K+hUB4D4dhrWOb+UMDB1ySIyDv4Jv4S2FjzB1iS/PzHtzs4k9lN6luORSoN
         iwKd7jpJ00EhjXukbGRq9JPSb2RQrSzFxOhRfWNvWwE7C6RBWqJOf4tw43NpVwlQfsPw
         tg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733475367; x=1734080167;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSgIBcefpJRbNbP13a1FZf8AfN5Xy4J6ToBZHWVVMys=;
        b=SJmEF42ImUtaaoVVk43SjqFx0esQDjbCnfJoczQQWNme/SCfefjKmwoUKw/ah2wX2J
         2YwaW2p8nwJ8uIjUWY6FMEe6eJR5s0jgQUIbcezfgLrZenr3NLtAOkBvUlM2VIuxcrF1
         ezbExfZqhmLdhl447PQJmlJpCDeDLWg78eVV2RtL5nQNUi/H/+ny4Yubzuzgs2eiW0IU
         ue0JmiUTikKZV7eix44/VO7nfkO191ON41g6mzsHoQQRFiHwfEb3RQs7j6TeBHDL5zkP
         UpgFlscDhGLHhDP5I0TBwKDEaz4sdy/TSrea922tS9keCYnHncA8NrKP2GZ4D9UWrHk8
         KOQw==
X-Forwarded-Encrypted: i=1; AJvYcCX1XKfad+WhmvYgutos73vj0e5n8yT0hDPojr2LT/hYP1iB2qK5xZprdvgzyKxPQIkOjWXKzN9Vu7hisJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9gcjJ+Xujq8P4wnFylX0Vl8nyhEt8ZqNi9bU81zteYa1E9dJ
	p9YIeSACeBHGCij50hZZDR4T+0yFt+yJI8s4/FqJw0nY70121Wn6owB7wlIKaww=
X-Gm-Gg: ASbGncsAeKpZEdYH2PX+UwbyViF9EnJQD9/n14tSsdFn49xCrCWs0i+iORpErXX15wz
	b6/GpDsxcwTHdA9Hqj0W2fC9UxDed+q3T82TZB7YG5bVcbrWaHdbgwwx4UeWAMneF/bty10wsir
	Ofl8bxaOCE56ra1GF5BN+ylaE8SHQQfmAs8nc5MfFnXt9sTtHmm7XvANEYVnUYWOpQ1nZnLfJg4
	NgSRUiiKA29vTH08+mCKZn19ZqnVYMNpkgdEmJtaJLnUVEDCA2llLIZXGq+rfGbpovkQQ==
X-Google-Smtp-Source: AGHT+IEJvS0U1Yqa4mhRHpeQALlox2SfL5+RyU5QXY7e06ype6AbxxfKlQptSFPvutZ5Alxw9Zn8ig==
X-Received: by 2002:a05:600c:4f82:b0:432:dc5a:b301 with SMTP id 5b1f17b1804b1-434ddeda72amr7187515e9.8.1733475365566;
        Fri, 06 Dec 2024 00:56:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd5asm86345175e9.40.2024.12.06.00.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 00:56:04 -0800 (PST)
Message-ID: <28afe0ac-5d16-4786-9259-6de5d090b491@linaro.org>
Date: Fri, 6 Dec 2024 09:56:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sm8750-mtp: Enable CDSP and mention
 MPSS
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241122-b4-sm8750-cdsp-v1-0-9a69a889d1b7@linaro.org>
 <20241122-b4-sm8750-cdsp-v1-3-9a69a889d1b7@linaro.org>
 <d43a2a74-9867-42b7-8810-df081f037831@oss.qualcomm.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d43a2a74-9867-42b7-8810-df081f037831@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 18:34, Konrad Dybcio wrote:
> On 22.11.2024 4:26 PM, Krzysztof Kozlowski wrote:
>> Enable the CDSP on MPT8750 board and add firmware for the modem, however
>> keep it as failed because modem crashes after booting for unknown
>> reasons.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
>> index 8eeed7f2f7766326cfc7830002768087e9783b9b..e2562ea5996ddfb1bee03b367082f4e1890131f3 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
>> @@ -791,6 +791,21 @@ &remoteproc_adsp {
>>  	status = "okay";
>>  };
>>  
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/sm8750/cdsp.mbn",
>> +			"qcom/sm8750/cdsp_dtb.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/sm8750/modem.mbn",
>> +			"qcom/sm8750/modem_dtb.mbn";
>> +
>> +	/* Modem crashes with "DOG detects stalled initialization" */
>> +	status = "fail";
> 
> That is a bad sign, let's hold off merging this as we may be
> missing some resource..

Luckily there are reports that all modems on recent boards crash (sm8550
and newer), so probably nothing wrong was in this DTS. :)

Best regards,
Krzysztof

