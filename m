Return-Path: <linux-kernel+bounces-326413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C1A976807
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7689EB22F6F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00854224CF;
	Thu, 12 Sep 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2PiO1QY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB4176FCF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141289; cv=none; b=oY18BuWMdUZx63uyRk2qTAW1Wy5E0DgeThKIT0yiY+7W8k4nYNJTPFCPXnZnrHuC4AQDmnUFEUq9kOK8yC8IV52cBtk9aolnnivZx5zmlIYUbRQMUKm63hwskuuJR+T+n1orMO8UNDmvf4ttVurzFdvr3wwf4ei2YI4+dWksE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141289; c=relaxed/simple;
	bh=Heof43DyvfqRJlRi0bBeyPYxJf13DtSSsWQ+FAooBOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=leEXAxNx7A/KheZTcADZBJ7VLf/9S3GJFmUAAPAOI5OVJJczazb8sE1wlWxgmVIUs/SrCEi/LaOYzu19zf/17lompcbNJGK6lo1CdiRSMckkYX/AeDMCa4f3njANiCuqKZMpcD7flzQJxm7zvs2hKjBG3IeaWxetWFPFdLY/v30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2PiO1QY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a81bd549eso104268066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 04:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726141286; x=1726746086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzc1SB9FR1O0Hrrsa6BC4Sqb7TXAInj7HgbZ9sPm2/s=;
        b=c2PiO1QYeAB6e+2rWgvYegE4mql9jjepoLT8xkXpkTHe+mqD1bnVT42vtPN3u8cnVf
         iPKmDyY3NdYm9rvL3SyDj/4H/TQB//fteLoXsRxg9YS9s73dVTy2mpTEcuYNpABZpbHn
         jfXyIWmi+MBX5NkuoNro8/cEdw8uAKzeyituls1+ggbnxKFyNyqgPPu42vnKLM97XouD
         pZp0nsG0sGl4hGwb/8qnApcTBsbgb/z00HdaqQf5ew60j3X8PFEWCzIEiEGJ1MRsoDDT
         ZYFERopwb2aj2zuusC9Nw2QZKTKUmog3pkR8CjWMiFdxCh+8Pb4SOwmh6xafEEcKsOBN
         MQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141286; x=1726746086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzc1SB9FR1O0Hrrsa6BC4Sqb7TXAInj7HgbZ9sPm2/s=;
        b=UmyezzSdTAfrvl7/Hj8bIgqFqYbEjPYRrlyxV87ZdMM3U8DY0B5Ye+RENtY/l+NzKt
         2S8iugTa/D+VXnSMlujDcdwQHDlyWNghg3+VdvGrL9FyhDAqqe2QjrZo02Zcj0VngvU5
         bhEYwxQ/Ayk0OG55+I2qLwOw+DKh2WXQq5Hyq5dI+Bn2sslzarB8qu3xW+DSzWqxueWn
         brqcT59NZx0gs+Fg6WBl0MvQAM2dvrL3TVqiNYgG+tXScuZsf4gVSow4AXwsdjpnWPSo
         GpQZcmQKOUMJbPNZqQvE/B772WsryEpRGiU4K5UXpvYFzjSeSoTUFCveuHir8C5e09zU
         o9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7fWm6ISRd1WF/u5jISW2JzcIGexZ+mSNsxF4EgJM9FuRk2kNDlT60liPMcW8bh5WqGbIH9IJBJBVP0mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqbC1hrJ4+ILCVtQGX8DuU87biIUVbSmmzwmXre4vhelid+0c
	WFnNdHj0ELjQl4wzWWjgQkpf/kpo2RUIj9uADngO074PhDIwYtwQE05V4sBIf4k=
X-Google-Smtp-Source: AGHT+IF2wx3/sCQSoXraGqXOBRLBye6JAmeptMCNWTKtJqhL/MIXqZonIUqoAEP5C6ftg/j1PBtCNw==
X-Received: by 2002:a17:907:e6e8:b0:a86:7ddf:2909 with SMTP id a640c23a62f3a-a90294fcf3bmr253511866b.14.1726141285775;
        Thu, 12 Sep 2024 04:41:25 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25ce9ed6sm729090166b.165.2024.09.12.04.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 04:41:25 -0700 (PDT)
Message-ID: <82dd61ab-83c0-4f9c-a2ee-e00473f4ff23@linaro.org>
Date: Thu, 12 Sep 2024 12:41:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] dt-bindings: media: camss: Add qcom,sm8550-camss
 binding
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@quicinc.com, Yongsheng Li <quic_yon@quicinc.com>
References: <20240812144131.369378-1-quic_depengs@quicinc.com>
 <20240812144131.369378-8-quic_depengs@quicinc.com>
 <b1b4a866-fa64-4844-a49b-dfdcfca536df@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <b1b4a866-fa64-4844-a49b-dfdcfca536df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/09/2024 09:22, Vladimir Zapolskiy wrote:
>> +
>> +  vdda-phy-supply:
>> +    description:
>> +      Phandle to a regulator supply to PHY core block.
>> +
>> +  vdda-pll-supply:
>> +    description:
>> +      Phandle to 1.2V regulator supply to PHY refclk pll block.
>> +
> 
> Here the supplies should be split into ones, which are specific to CSI 
> blocks,
> and I believe they shall be set as optional.

In principle I agree with that, each CSIPHY should have its own vdda-phy 
and vdda-pll regulator specified.

In practice though I don't believe its necessary, below.

> The proposed names are:
> 
> vdda-phy-01-supply
> vdda-pll-01-supply
> vdda-phy-23-supply
> vdda-pll-23-supply
> vdda-phy-46-supply
> vdda-pll-46-supply
> vdda-phy-57-supply
> vdda-pll-57-supply

In principle, you're right, we need to expand the name set here.

> I understand that what I ask is much more clumsy, and it could be seen 
> even as
> unneeded, however it'll be the right set of properties to describe the 
> CAMSS IP
> in this respect
I think the following naming would be better as it matches the 
power-grid naming in the docs.

csiphyX-vdda-phy-supply
csiphyX-vdda-pll-supply

=>

// voltage domain = vdd_a_csi_01_09 = regulator l1e
csiphy0-vdda-phy-supply = <&vreg_l1e_0p9>;

// voltage domain = vdd_a_csi_01_1p2 = regulator l3e
csiphy0-vdda-pll-supply = <&vreg_l3e_1p2>;

//
csiphy1-vdda-phy-supply = <&vreg_l1e_0p9>;
csiphy1-vdda-pll-supply = <&vreg_l3e_1p2>;

Where X indicates the CSIPHY number.

So in fact, in practice we don't need to differentiate these entries.

Checking x1e80100 ...

csiphy0

vdda-phy-supply = <&vreg_l2c_0p9>;
vdda-pll-supply = <&vreg_l1c_1p2>;

This is also the case for csiphy 1/2/4

So, I _don't_ believe this is work we need to do, since its the same 
regulator for each PHY.

---
bod

