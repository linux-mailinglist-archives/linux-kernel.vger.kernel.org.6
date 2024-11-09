Return-Path: <linux-kernel+bounces-402940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B529C2EB7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D1EB21607
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F08319E7F9;
	Sat,  9 Nov 2024 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oM+ZguEX"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184519D8A4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731172931; cv=none; b=QxIfqWv7kp0KWDfWhUOfhiBfgvDbVsOoT9MjAGZQ0T02gMDd1bGDV64095Def89cn9Q5irh21aNdD3T43VbecKoATxyqGUtoEKdtxXufCSjpY8V//E/5pawvRQFt6Y60mLIAArdoeWrmEk9HUY5Iiz/jaowxfq5jsVDR7TzVkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731172931; c=relaxed/simple;
	bh=pgL8gsiXuEpe78oaOwjEtqdG8Xlsm054EJXb7d6pd7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQtjDfFu93GGlGNx6awpJHvQgm72AfKm3rnJ6qbbtC7gURKjdbLYiCtQNe47TttqEXu2ElJMWpMQ76Ws9Iha/B+YszTRxsYM5kh/zNbPIfcp4ghAoN3FFBASAKEgtufpFHUeegkhirwjP8B334QzspsVZfcEfBS1QNhMfbFgngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oM+ZguEX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315839a7c9so29919085e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731172928; x=1731777728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5H+n8hKwMU/rFaCD0qvnq17NXDKqhdH26m0nFiBdOLY=;
        b=oM+ZguEXfwzEOX3QoaBZ5AcZCNo3KI6oNA5P44mMKID10EwP9JZbM25g8mpw0Pge3m
         xmz4TT4ncIYvgiKY9m/YnaJXaVXEc1aRf6/OnZZ28agEBr4iWdXXCzek21ODu6mXvDWV
         bxTHhDfQHkuOUS1ejUnQpYvXxkEphxXk7IO5U81BKczVK2B43aRP3EeR+iQHhqnDMll+
         anMkN6tqyqtnHugdP+h9EGdk0tu6uoJc8kpBiOP+PjxkyR+OEvtyIAlvpiEofuL5xcFy
         +qj9REtU4d4J1NsHQfuMfTYNSg0eavkLLd2TcINy3UcFW+WXp0MoodbD0mkcIJOBBCFz
         Casg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731172928; x=1731777728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5H+n8hKwMU/rFaCD0qvnq17NXDKqhdH26m0nFiBdOLY=;
        b=vIaQF5QBWOT94WzhsZy3O2avwbWblveFQElcDhba+UKs3XhplR/NNllI1TffgRS1qA
         91nULSzMXMvwVidayABDW6ZIMOFsrhovObKF+GvZigYW8BbG/o+8OiESbzUrQ+CWd5Md
         FPAvn5nW38sIuCM0vEgXEmBp5MeD093R+85I0BOKCkEytwGgWwwvqf6hS7r813o+U5Jj
         dSQXB3I9kfI4uFiJmThhZuQYkz6gD+ypV3VsEqCoj8Ra6naeBqh47rIPf8bYMILZYGmh
         R/3XToKVtcgIG/h791jJ/y0+AwzBcUSt9Z6q1OoBW1Z1wM/lQJ6sGvvxb4ku+koRToI6
         acHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTQP/TXmr+uuu3wq+hxOA8K4qROOvb4jQR60Hs9/gVQcvPOUOyjFmXOmufsKa6uPhD7NF2XNYzFFQcI/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOZhG2MQjSigdjF1Q934eQUOmoaO9O1w0E1KBmbwtNoG6qK8T
	MuM2irDrvDRPtOC9oDdS/r2J5MLSw1ingH5pfPCimfvd3SF3knXQmw8kxz/Zwmg=
X-Google-Smtp-Source: AGHT+IE1RYOVGklIyE1IORLaNjLIY04lZliu8TKuSyMeu3g+/8dlg1C+LHnaQGhacvYdKXljs5Yrzg==
X-Received: by 2002:a05:6000:418a:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-381f186d1a8mr4237152f8f.19.1731172928458;
        Sat, 09 Nov 2024 09:22:08 -0800 (PST)
Received: from [192.168.0.48] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed997320sm8285603f8f.47.2024.11.09.09.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 09:22:07 -0800 (PST)
Message-ID: <d4afdd01-3147-4cfc-820a-f6004637e6bf@linaro.org>
Date: Sat, 9 Nov 2024 17:22:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] clk: qcom: videocc-qcs615: Add QCS615 video
 clock controller driver
To: Taniya Das <quic_tdas@quicinc.com>, Bjorn Andersson
 <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241108-qcs615-mm-clockcontroller-v3-0-7d3b2d235fdf@quicinc.com>
 <20241108-qcs615-mm-clockcontroller-v3-10-7d3b2d235fdf@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241108-qcs615-mm-clockcontroller-v3-10-7d3b2d235fdf@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/11/2024 04:09, Taniya Das wrote:
> +static struct gdsc vcodec0_gdsc = {
> +	.gdscr = 0x874,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0x6,
> +	.pd = {
> +		.name = "vcodec0_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = HW_CTRL_TRIGGER | POLL_CFG_GDSCR,
> +};
> +
> +static struct gdsc venus_gdsc = {
> +	.gdscr = 0x814,
> +	.en_rest_wait_val = 0x2,
> +	.en_few_wait_val = 0x2,
> +	.clk_dis_wait_val = 0x6,
> +	.pd = {
> +		.name = "venus_gdsc",
> +	},
> +	.pwrsts = PWRSTS_OFF_ON,
> +	.flags = POLL_CFG_GDSCR,
> +};
> +

This looks good to me, except; could you please check if venus gdsc 
should be the parent of vcodec0.

If so, please add it in, otherwise.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

