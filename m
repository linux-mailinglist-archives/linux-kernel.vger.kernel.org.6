Return-Path: <linux-kernel+bounces-343574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC5989CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138D81C218E4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A36A17BB38;
	Mon, 30 Sep 2024 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzHFNN7G"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234621105
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727685131; cv=none; b=RF7iFy5vwuJUHD50PUD/VnPPbGALmLHwkg4ZTaZ26Ll/Qot8RrbjxZMuxFT0Mf25Rc75Tgha2Bz4UTsLHFwDMAgCPUmplHGGCKnqb7T28MQ9RLaLu3y9WSDN9Rs0GHb4iUjo4/ggQc6k/NcQSSxkfQz43w5SrU6i7op2NUtyEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727685131; c=relaxed/simple;
	bh=vjDswGq6qzpL0ELCkjz11cU+d1yIUQWLyrv7G9cBs7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mc4mcwzaW6//D5MZN9qkLGgfyxSKbvGDvaniBI9ZOhHwfUSBg9wEszdRi0dU1mT2htNQKV3zcDk9eWv4Pvv+AYJf8bHIDmC7WCqPMqg6levbbaSrNGsVmoSxz5iZrLYp/umKh4MTXZv8ld6kKvgw+nfug/MFvaXA9EtDbNT+n1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NzHFNN7G; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5389ef4c28eso373919e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727685128; x=1728289928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bda1ujvEw2DtigO9xhXKOUzZtK+oOjtZGeAQ6Cgn92c=;
        b=NzHFNN7GsOmIU4AyHXXROunwO6L2BEFWOJ7jw7ZSqQG7BLOYYqbdVg29kPidBT25/A
         0rd17z6m8PbTJ7GY3P/xXk/VCNgg+EZ1BzFAviRg/JD5AvnTV1FORSQSjV/DhsyjDr5G
         JzM6pxT//AlZj3RFyb0tKpO9IIqiO7LFRPRPaXLJBvQYgQU/lKTk1M8wpcomJxtY1o4g
         4xpg7OLA6tz8qlklMFDpT4eqjpiC4EgGuJcIEw15kYuuWsg2cqaEtqlW5rBvFqxlhwPC
         +pmF5YxNMY7+jJDf30kT5a2tE+Wexg96k9mB4LwSQOkBvKC5R4VuiYOOvWEtqoZR4Z9h
         HQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727685128; x=1728289928;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bda1ujvEw2DtigO9xhXKOUzZtK+oOjtZGeAQ6Cgn92c=;
        b=u84RDqbHY4CVKNAmLQhgQpjKJ6fEKeOar7S/dt6X8NdvmeqAfXFvTtkWNk5zyn8vJd
         WoKDziXhjLisPdC9JjV/tV+1f4Z2XgI2CLqkD4j1Xn4DJ3VjHweZvx6nO3P5aB5nK/vC
         W/nDsy0IVZYuqJFcu683ZHVoB1Jw15Rn8lHSt/c4bh3M3UXxvs3z9DbwzqgMdo/U1z3Z
         ieEPNdT1J+HiyLe1d+4Qf2PWBiMsArh3s//I0drROFe06G4pmqnbS6VcZHJyCJkvEx9Q
         +qHK0fjbDZI7U443R+TUNxp8YB4OE57SEyjxBBEILV68W4/mfZgVh/MjVBCH3U/vtvQg
         mwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvCspC8738oau3JGsz0x0Y6FyPrZBO7j1p7D3Ey+kuO2YzNOrEnuDT5rt2g47vKbeMlyyIx0Egko6Zw1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHYb0Q25ObPO9fd5Q9BiLEZOrx50eb+7ttWi3eNbwPINIoxX2
	75dL0sI49ZpgxJSIEhGzFaDKg+1Kx7S78iKhXsDKE6i/Ejdym4sD8ufnNKXSomI=
X-Google-Smtp-Source: AGHT+IH0lDtASpU4Bz/yJJ+DPMxpJva/WXZEzaaUSKmBmARfPfs62pt6dBtlPHX5lCsdiTR1si7/Fg==
X-Received: by 2002:a2e:a595:0:b0:2f1:75f4:a6a4 with SMTP id 38308e7fff4ca-2fabfc3725cmr9211601fa.3.1727685128428;
        Mon, 30 Sep 2024 01:32:08 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043b060sm1157672e87.227.2024.09.30.01.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 01:32:07 -0700 (PDT)
Message-ID: <18fd8a2c-0563-49a0-b2a4-78f0005576e9@linaro.org>
Date: Mon, 30 Sep 2024 11:32:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Depeng Shao <quic_depengs@quicinc.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, rfoss@kernel.org,
 todor.too@gmail.com, bryan.odonoghue@linaro.org, mchehab@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <9ed92660-5f42-4a1a-9261-b8800133972a@linaro.org>
 <ed012367-1bfd-4eef-931b-37e1ac839176@quicinc.com>
 <212c880a-9a09-4433-a049-eb15a0c32322@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <212c880a-9a09-4433-a049-eb15a0c32322@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 10:26, Krzysztof Kozlowski wrote:
> On 25/09/2024 17:13, Depeng Shao wrote:
>> Hi Vladimir,
>>
>> On 9/6/2024 11:56 PM, Vladimir Zapolskiy wrote:
>>
>>>> +            compatible = "qcom,sm8550-camss";
>>>> +
>>>> +            reg = <0 0x0acb7000 0 0xd00>,
>>>> +                  <0 0x0acb9000 0 0xd00>,
>>>> +                  <0 0x0acbb000 0 0xd00>,
>>>> +                  <0 0x0acca000 0 0xa00>,
>>>> +                  <0 0x0acce000 0 0xa00>,
>>>> +                  <0 0x0acb6000 0 0x1000>,
>>>> +                  <0 0x0ace4000 0 0x2000>,
>>>> +                  <0 0x0ace6000 0 0x2000>,
>>>> +                  <0 0x0ace8000 0 0x2000>,
>>>> +                  <0 0x0acea000 0 0x2000>,
>>>> +                  <0 0x0acec000 0 0x2000>,
>>>> +                  <0 0x0acee000 0 0x2000>,
>>>> +                  <0 0x0acf0000 0 0x2000>,
>>>> +                  <0 0x0acf2000 0 0x2000>,
>>>> +                  <0 0x0ac62000 0 0xf000>,
>>>> +                  <0 0x0ac71000 0 0xf000>,
>>>> +                  <0 0x0ac80000 0 0xf000>,
>>>> +                  <0 0x0accb000 0 0x2800>,
>>>> +                  <0 0x0accf000 0 0x2800>;
>>>
>>> Please sort the list above in numerical order, this will change positions
>>> of "vfe_lite0", "vfe_lite1" etc.
>>>
>>> Another note, since it's not possible to map less than a page, so I believe
>>> it might make sense to align all sizes to 0x1000.
> 
> And if Linux behavior changes then are you going to rewrite all the DTS
> for new size?

If Linux behaves properly with page size alignments today, then the selected
page size alignment for AMBA device IO memory regions is correct, hence any
future change from the correct IP device description to another one will be
invalid or noop.

There is nothing to worry about, I believe.

> No, the sizes reflect hardware register layout, not concept of pages.
> 

Absolutely they do. It might be a coincidence that both are aligned in
this particular case or another one.

> I don't think that we should be coming with more nitpicky ideas, one
> month after the patch was sent and reviewed.

The change is not yet ready to be accepted from the technical perspective.

--
Best wishes,
Vladimir

