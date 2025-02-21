Return-Path: <linux-kernel+bounces-525522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF2CA3F0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B4519E050C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC3208961;
	Fri, 21 Feb 2025 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nmiXNYn2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6943205E15
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130935; cv=none; b=ZqpwZkIZNZxmmmuyRBmkvpwLomjY6c20xGFCSfhuzj7CEWWqNi7Zb0Ihy5Zt57ByL8yVAfNginghFEOETFTOZgT3Zg4je1qmyowg7zNQLY7ZAzxJokCqpdo4n0VJPtUZf4y6l/ST4jLMKXmbdIhCLvScARU9kA+91DqgJGGn68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130935; c=relaxed/simple;
	bh=3d2Q2o3fJiHi3cJPY5LQ4dMhZv4asm/ZCUv1sU8Cby0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9D736ncGvps1G7zXt/UQtGujW9F9fXoZYTZBCDiKM1jMxEiXTv793l8Jk40KM1kmb0MEKHibU+Tg2PHqjISE6yH9GQjGeOCpqWjZEc1YWnKsjwwSXFDixph+mO797TxVkBCxDEqBzQSS2PdOmuYFtZy5tVqO5lzJAqGfuW704Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nmiXNYn2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43989226283so12785225e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740130932; x=1740735732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0J1Zwx7ue86k31iPRIPZZnmcI3lqDR1yT4y7QR55Zw=;
        b=nmiXNYn2abBlSDT+VzOFkFi7ImXLd9LMVco/Bw+50r7zsoF2yHY8TqX+FoFGBdPhQd
         Yo2YO96ALOdf1bWyc4B1LumgZ/nWv0s6Bi03BOCBsnalh9GQzncqYFFak9BCNLR6zuKK
         Gc/ItE9O4O6hX/UCwF9WD9SlzeCHZ0JGLSQEeXx+jJqbTwKSDnxnswtxBT5C/eY3BkEf
         f6ckh4SGW+Lh7mp3T1duZi6AYQFP7dYMnDj5NQ2Ed7cc+WGwOmqyGcFeO5jPkhE7Ca+O
         zMBeIWVdVuO7+bKo9yEEr8pcj580qhLknL6x2w9/WuZVEx/sHj9YxlV0FT4j5eMOBlE5
         K65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130932; x=1740735732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0J1Zwx7ue86k31iPRIPZZnmcI3lqDR1yT4y7QR55Zw=;
        b=WJ1A51rYnyscS1RAFip3RND5mj0sq8PJ/C/Q8h9IlELSvK7l2maP0hBI7ai6JGjUzp
         q2uBeOuQDfwdA2mVadCj7NqrC2zGFZUQMDOuxP1IMuEPMpgf05UFKqf9dve7EaXEGcGY
         QHA8PH8XOz4HS0k+t1DnTHA0nO6JLE8JB88LoHNjmQUcTGez2uLAq4xbzNPtqIn1+6M0
         2OjiSQo76FRsiWpupOBeO43Wmj9ImWkqiHGDmu/blAT0eNLhTcmkKtiDRl37Nbzw2X3U
         HQ7FfkGeu+H6S0dCOwmX/zrqWFhMXXYvb1D3L7IY9xp85pn7K02c9ePxlA98YMmW7xmD
         PrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAQ2j1ALD26giqRh5vz7ibUxJFSHYTcdwLMp3MZdumhR2TZrvZH8S5eFxuONI+2opqTpTvLkhUdmy/qRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmyTWK5UZMFmcRa79wdGg0U/tPa/+yinPK81xEvUp6BW+HLNNh
	b6F7AsUDlVRGwAbyMU5qnmNavE4zfH4V3N9RhPZbI1+xany/mz2dJhnbAUBNlQs=
X-Gm-Gg: ASbGncu6Wlo8IrbMYHaOLFHQ5ZMKldP/QEHa5QR66hOeaB+ca1R3xC7y/iIe2bBewvV
	vfdgd3PpVe0qHr3jh6F4h+bzT41hdGDcHIJNBV4E76DhUmk3J4HHs0ruSuOjynWjTxSA1spjwap
	XH+Kov/9oVuqDCQEKdw5XDtMT8WVTFpz1MSXruT+aJYr+p0a4nUKT9wAnnAUBSrSCi4Rk+DAFhO
	bXA2USh3j4Ekxx7mN+9UnJkJGJ9/ed7CtQ7NnH3wSZj/AK46JFiWmTrrnwi8RxXWHW37hAf1jgQ
	hlq94zL06MkeqlsmrnIyQusR1v6kSXohg+UtrU0ybQrfTSJqAs5L9ihNoJS3RbNPFcE=
X-Google-Smtp-Source: AGHT+IFroyABBpOsabWsgrl7KBQzfGBjKB3F9B9Cviyl/eoKnSnufExjTKsMZhY9Cx/IPYZ4EIrCAQ==
X-Received: by 2002:a05:600c:3151:b0:439:a1ef:c242 with SMTP id 5b1f17b1804b1-439ae18fdc1mr24592065e9.0.1740130932194;
        Fri, 21 Feb 2025 01:42:12 -0800 (PST)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399be79d92sm53108625e9.0.2025.02.21.01.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:42:11 -0800 (PST)
Message-ID: <85a51258-7cee-45b3-8760-bfbf943500c7@linaro.org>
Date: Fri, 21 Feb 2025 09:42:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] clk: qcom: videocc: Add support to attach multiple
 power domains
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250218-videocc-pll-multi-pd-voting-v1-0-cfe6289ea29b@quicinc.com>
 <20250218-videocc-pll-multi-pd-voting-v1-4-cfe6289ea29b@quicinc.com>
 <eec2869a-fa8f-4aaf-9fc5-e7a8baf0f864@linaro.org>
 <huluiiaqmunvmffoqadrhssd3kl2toutqtcw7rzamv3sqdglsf@7lz66x4sj3gv>
 <d4c4ecf0-9094-4341-8711-78a48e5d1344@linaro.org>
 <d444f1fb-42a0-48ef-83bc-d5aab9282b22@quicinc.com>
 <gzjyyl2kzv52zsewn5zf6ei65fymyi4pspvsmsjaqj5sklfxvc@bkg46saulni5>
 <fcc31cc7-67bd-4102-a53f-ebe66b4fd1a7@linaro.org>
 <3da96df2-1127-49bf-8114-282cc488c194@quicinc.com>
 <6b0684a0-a519-463f-b7be-176a4752a786@linaro.org>
 <r73hnpusatba3hvyckv7jw3dcvffgvoxwawlcvvxhuol5rrrk7@ngo3fiv7va6e>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <r73hnpusatba3hvyckv7jw3dcvffgvoxwawlcvvxhuol5rrrk7@ngo3fiv7va6e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/02/2025 00:10, Dmitry Baryshkov wrote:
>> +static int cam_cc_x1e80100_configure_plls(struct device *dev,
>> +                                         const struct qcom_cc_desc *desc,
>> +                                         struct regmap *regmap)
>> +{
>> +       int ret;
>> +
>> +       ret = devm_pm_runtime_enable(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_runtime_resume_and_get(dev);
>> +       if (ret)
>> +               return ret;
> I think, it's better to add desc->use_rpm. Then these two calls and
> pm_runtime_put() can go to a generic code.
> 
> Or maybe we can enable RPM for all clock controllers?

That second point is pretty interesting - I think at this stage ~ all of 
them do this boilerplate stuff over and over again ..

---
bod

