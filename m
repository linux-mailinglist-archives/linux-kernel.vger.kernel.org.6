Return-Path: <linux-kernel+bounces-556650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A239A5CCE0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D983D3A433B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A07262D10;
	Tue, 11 Mar 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wYQkBdrV"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7E1C3C07
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741715719; cv=none; b=H6LVzjFvfIxGdKtzAbv15XIJrPlutgOeVznRrN9/nAWiL3GQcZQn8rlFVJjVMc80SOq7JkioVj/nTJeQHaZB9gyxQUQlOINjuPOopX4WWAGA3xEvEihRVIztcu1c8Xc7Gv2eNj/NtNHlKE29dzZmkX0BCtYknlYZTaLC7b9fCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741715719; c=relaxed/simple;
	bh=+n9E1X52Of+0Qd+ZQ0Y1r8563ZihbOxSI8RKMEktnvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8ScmbQIcovwos3jtlXzzVaiaav0vxyKPAYSdh8YIlxW3J974GXd1tqiv9DF2yY8YO8I7seMX8On6ZqnLkUd5jQbEUNQzS4KbGIx1lsr18oqPg69btV1GqO5oG1rdc2UGOVMOmyfkvx6aShrs0/PIrOP8RlMtuEV8R/g8NE9Ba8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wYQkBdrV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30bf9a3ee2eso3420211fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741715715; x=1742320515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WdQTyBopz7mxHzFVAna3izLewrTUpKF7sAoJQrcvvs=;
        b=wYQkBdrV7OtpiN/eS7rKhy7tGjLocD06JeYnOKwcUQjDAFSIMEA0p0JerMXAmxLtJq
         x4G0fu1cfrPB5otAhGjkPpeVEN2bS1UxmI0LJx/gaekp5Txy+8eMDRsH9sbV9VlXee+W
         Igd6bzOT9FVRlYuZp24RSSFUIHP2/kAqn2R4RLXtYndUXjFQqF/DVO/2/yPs17SXxv8r
         6g6B5UYdDMXwBTJPZLYUjPgi5YvWLEBbKZiA+nmyeKFhhds3j4Nd3r746QSEfHB71bR+
         JBewqJwOlRDPPAptk+katq/IZmA6OAyJzWF9oSiHeAoDbaMyIlE6gZIZoFzuPQ9vyg/M
         1v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741715715; x=1742320515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WdQTyBopz7mxHzFVAna3izLewrTUpKF7sAoJQrcvvs=;
        b=pECVwpu44bd27abqf/e47/Lz7f+lPq1xjLd1GrG92uFiUo5hNqkSBbWUx0nLTKnpaf
         EZdDtG+J7DmB6S7wUDjmMHRchoC091mJr5Zjp+tLY+jQVBcTNJ4ZUhgZfXGYY4O0bhWm
         5zPSktx3WQVrP7N1OhiNMY4kisYRb3hHZ2LD2B/yiX6u9VSo4XXrClpeFOcZ9p42dmKW
         DZLLKNybLJPHlaSOWw7sBadzyQ/J5Lsz0fPuIorcwsBypqxJytAZWxmwY0gtpg1we47o
         IbS5YYhZRwf1wsmn+1pJxG24WX5p892SoUWHSaGZyYodmsTqm57AnO5zPPLt9oI3QnOV
         n6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDi1EkG50PWNaJKkGeukXbtycS5zTVcyiVQT7ZMANtKPgUgbUP+iU7sP5zd8XgmuG3qExXJV+6B8vFL2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyEM8CodNSsxOm3qMCh79SunipzeU9dYK1/2aRozMo5AdsU5f
	CtWOrorigCM8ccYDswItaOkwuFDR7f3BbZA0mPMePjbnwDCaYoHdQYb6aP+ND6sbitc3EpqaZ8r
	UpzI=
X-Gm-Gg: ASbGncsiWPV1rSQ99a/M50H2K2jVTLrZCTUeNW0CsHYxUUmfz9lXeQpjvPhe/93Qk2t
	dTiIYAtqWAkfuln6zGLkw2Z3HZaOMXa9HRD4beYWtBQZjy0vBvksx2mMfwvwnfOSybtd9A0/G2h
	g2TEMl8p9+NGcoHKZ9EoC0/zrNnuAcwpkukE5PcdBhOgnsH8XnP5nk50iKP1SWki7QrrVvNJrVQ
	/7F6cUM6+nb9FEnWN9om5ODtvm6MpCAUgd5elyvhtVZ2imsRbHn9JDaD6yImTMZXoniEAQ/aCB2
	AHDcH9tDefRGZdULmvUFuPkR6yIzhtOdJs3x8dhcg2CXEAthz1AQ6iBp9UxGRSVZ6dlHNcAVoNh
	uELc5nLWPxZ3fM1jwrHTy2hc=
X-Google-Smtp-Source: AGHT+IFaFjSbRxdirUqUTeBI9TYH3RQnaCLtmtz58LmMZdcdbTD1mseF//sb+hUuzIm6th6cicp37Q==
X-Received: by 2002:a05:6512:b08:b0:545:2338:f5f8 with SMTP id 2adb3069b0e04-549abac0ae5mr660729e87.6.1741715714536;
        Tue, 11 Mar 2025 10:55:14 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae580c5sm1865024e87.70.2025.03.11.10.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 10:55:13 -0700 (PDT)
Message-ID: <caa00d62-b24d-4db7-9e12-170a10c073e3@linaro.org>
Date: Tue, 11 Mar 2025 19:55:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] clk: qcom: Add support to attach multiple power
 domains in cc probe
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <CMTYKKilQJYeHUYYKvlqnwv4Q2P-58Ic1v1ndS9HQ8Yhq2xpHuNThibFDjXDEQ1PyNbx__f9BVBr0peoTUdvPg==@protonmail.internalid>
 <20250306-videocc-pll-multi-pd-voting-v2-0-0cd00612bc0e@quicinc.com>
 <5a45fd25-74ed-46e3-b0e3-5adf92b5e9f7@linaro.org>
 <46d4f090-3e31-414f-abfc-3d1018913c56@linaro.org>
 <9e6fdcfe-3c6d-44c7-95a3-7652c0650bf4@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <9e6fdcfe-3c6d-44c7-95a3-7652c0650bf4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 14:10, Bryan O'Donoghue wrote:
> On 11/03/2025 10:12, Vladimir Zapolskiy wrote:
>> On 3/11/25 11:52, Bryan O'Donoghue wrote:
>>> On 06/03/2025 08:55, Jagadeesh Kona wrote:
>>>> In some of the recent chipsets, PLLs require more than one power domain
>>>> to be kept ON to configure the PLL. But the current code doesn't enable
>>>> all the required power domains while configuring the PLLs, this leads
>>>> to functional issues due to suboptimal settings of PLLs.
>>>>
>>>> To address this, add support for handling runtime power management,
>>>> configuring plls and enabling critical clocks from qcom_cc_really_probe.
>>>> The clock controller can specify PLLs, critical clocks, and runtime PM
>>>> requirements in the descriptor data. The code in qcom_cc_really_probe()
>>>> ensures all necessary power domains are enabled before configuring PLLs
>>>> or critical clocks.
>>>>
>>>> This series updates SM8450 & SM8550 videocc drivers to handle rpm,
>>>> configure PLLs and enable critical clocks from within
>>>> qcom_cc_really_probe()
>>>> using above support, so video PLLs are configured properly.
>>>>
>>>> This series fixes the below warning reported in SM8550 venus testing due
>>>> to video_cc_pll0 not properly getting configured during videocc probe
>>>>
>>>> [   46.535132] Lucid PLL latch failed. Output may be unstable!
>>>>
>>>> The patch adding support to configure the PLLs from common code is
>>>> picked from below series and updated it.
>>>> https://lore.kernel.org/all/20250113-support-pll-reconfigure-
>>>> v1-0-1fae6bc1062d@quicinc.com/
>>>>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>>> Changes in v2:
>>>>     - Added support to handle rpm, PLL configuration and enable critical
>>>>       clocks from qcom_cc_really_probe() in common code as per v1
>>>> commments
>>>>       from Bryan, Konrad and Dmitry
>>>>     - Added patches to configure PLLs from common code
>>>>     - Updated the SM8450, SM8550 videocc patches to use the newly
>>>>       added support to handle rpm, configure PLLs from common code
>>>>     - Split the DT change for each target separately as per
>>>>       Dmitry comments
>>>>     - Added R-By and A-By tags received on v1
>>>> - Link to v1: https://lore.kernel.org/r/20250218-videocc-pll-multi-
>>>> pd-voting-v1-0-cfe6289ea29b@quicinc.com
>>>>
>>>> ---
>>>> Jagadeesh Kona (7):
>>>>          dt-bindings: clock: qcom,sm8450-videocc: Add MXC power domain
>>>>          clk: qcom: common: Manage rpm, configure PLLs & AON clks in
>>>> really probe
>>>>          clk: qcom: videocc-sm8450: Move PLL & clk configuration to
>>>> really probe
>>>>          clk: qcom: videocc-sm8550: Move PLL & clk configuration to
>>>> really probe
>>>>          arm64: dts: qcom: Add MXC power domain to videocc node on SM8450
>>>>          arm64: dts: qcom: Add MXC power domain to videocc node on SM8550
>>>>          arm64: dts: qcom: Add MXC power domain to videocc node on SM8650
>>>>
>>> This list looks sparse.
>>>
>>> - camcc is missing
>>> - x1e is missing
>>> - sm8650 and sm8750 and both also missing
>>>
>>
>> Since there are concerns about DT bindings ABI change of CAMCC given by
>> Krzysztof, likely CAMCC changes shall not be inserted into this series.
>>
>> -- 
>> Best wishes,
>> Vladimir
> 
> drivers/clk/qcom/camcc-sm8650.c
> drivers/clk/qcom/camcc-x1e80100.c
> 
> In fact we appear to be amending the dts but not the driver for the 8650
> here.

I kindly ask to elaborate here.

This series does not touch CAMCC at all, and if the series touches CAMCC,
then it changes DT ABI, which is objected. Or is it for some reason
objected only for SM8550 and not for the other platforms? More information
is needed.

--
Best wishes,
Vladimir

