Return-Path: <linux-kernel+bounces-431179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB929E3A63
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65563B2BC16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37E1B415A;
	Wed,  4 Dec 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQ7+584v"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA1C1AA1DF
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315854; cv=none; b=O+TusmyIfEwg0K1tp6ogbMrZa/X8q2Ja12Xt8YvgslRZiHH8OIeZSDRDsn0FjAKSPz3wQAoI5qiMJVURAhOuyZj3swS6sMb6vH7LKCUsFD13DKIKGegi1U09ngIDL5TvPLZK8m3n80W485FyqMYmKiaw6sr6ZofsGKwRviy2has=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315854; c=relaxed/simple;
	bh=f4JdU7Rzzmj+R1/OxrSn7f29PwCd20slBxMMB9kdPKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kZR6SJemz5rWKpQx9eiIl27p/KVrlz3yGHt2ZquqffZlkovcP0EL5/S6vwFuFqNSC+CZZ0AxDzf2WmddqplbcJGzmhJlU77vbdpc4F9baaRNrxtBjVcVt5tksX8HGGzNNMLf8xCo+nmcCs8N88OhEZvoQQMLaHdLzN0sp9LzSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PQ7+584v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a12d106dso6827345e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733315851; x=1733920651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qn3ZnxaGnMmpvUaH/GWWsPm6fs0ctmSrJSJyOBSwzM=;
        b=PQ7+584vap2efqAj383P/ocERXP5pUqCVX37ySM/5PH4LNUSQIB5LGPFlCgDfTLMj4
         UGSJ5IcAsCxarP0dv78ry1H6KOR2MtcYA93RKAk2CCIuxJl0xLXe3f9DFEsTMQMUfEiE
         xCnsASuTe7PCCcaw59WSNEFCj9EDX87IdYgFxpZLo5LBsRzBZzAIGMoe7QjcAbcQrYDu
         N9v2k1fVZ0LmxX1DPgWbO12NTbqpjbcvrAo3YUN47GOr6VTj5Q1kUNkau52BTk7W7gAS
         jJ68aG4SK3bPW7TvZSNRcJ6BTu2wB+qFWCO4i17t/M4dKaYrEvz/7ecTQLO34HV/OlEU
         ygBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733315851; x=1733920651;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qn3ZnxaGnMmpvUaH/GWWsPm6fs0ctmSrJSJyOBSwzM=;
        b=pKMtyjZ4gKjRygbhkIk9bB8lYoyEVnVYEG4B+AySOZL+La0YYxrRr7rPwT77Fv+SfX
         w2HAjAEDIiekX20Ea3wClVSs1pXtQa84t+3P2kAdNr9DcvTGOIZiCl0CUTf68ty20hc0
         MqaKXl8GRdIOxKQP0RqcjZsGnHrxeYeGdHFMiOe9Un65BHl1610A/g10woA4xBjfOmMF
         LCDyQxtgxt+TzeNe2Odf+sabKoL5nHFvhBWiMXKa9qQYCuOWSKlTSshdEcYnlpr2iCcY
         wgOS5xfesQCScpK/eOnTj/KoLbSvu8vWHvuViRQZpPSqTxR3qkiftKXqeubjwGI7BxK+
         hpwA==
X-Forwarded-Encrypted: i=1; AJvYcCWjMT72oWmHoC4EcGvLaAKI/fBcouk3lHAQjEQC18ZuZvcBj2B/dUEDiUsNUfiOtC/BPT648AemOx2haag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3O/0xEY4dI9HNtGYeNBueOtU0FVk2N3IkKwTcuGvQb+F19yhY
	dKwVBU8NZ0iKLfUMLdV3CWfoKJgmuSiza8we261p2ExLK3+NryDXKNRl+twytBY=
X-Gm-Gg: ASbGncvnVYISWX0Le7KMfr+FsLxXcBoSJlUbHvHffrf1XdjprXXsJfMUr2yQoEwkCdZ
	gp2hVXnu6/Sg5o7vLdwJWYGFYzjnryTgO3P0bnAsVjW6qKkGznymF9vpq4t1/BM6juEw9rNSwQH
	0WXtxSOBd5VbE/nDazR7n5kRJ+CoK18J8kY2lUVNCpG0S4PotKsQr87wl/wSBGe3KvxDerbVopI
	Y7Vw3CQp/wIGKgWzTmgSVUp1KTtR7KbFOhSGquW2y7EgqEB35rczSdIJ9v+OvLDxHfI+w==
X-Google-Smtp-Source: AGHT+IEeTkgOdeZUpGGaxGsdrx0QZvZ/CXigi7dcaDUgno+cC1CWkj77HFnwYP7ok2mKArIY6+M5Qw==
X-Received: by 2002:a05:600c:46cf:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-434d0a1f397mr20263365e9.7.1733315850582;
        Wed, 04 Dec 2024 04:37:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cbd72sm23817815e9.44.2024.12.04.04.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 04:37:30 -0800 (PST)
Message-ID: <03631258-545f-4f31-a849-9450a1a50ae7@linaro.org>
Date: Wed, 4 Dec 2024 13:37:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: Drop unused header includes
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241204110348.100841-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241204110348.100841-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/12/2024 12:03, Krzysztof Kozlowski wrote:
> Drivers should include only headers they use so drop:
> 1. of.h and of_address.h: When no OF call is used (of_device_id is
>    coming from mod_devicetable.h).
> 2. clk.h, property.h and reset-controller.h: No calls to clock consumer
>    or reset framework, no fwnode/property calls.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/clk/qcom/camcc-sa8775p.c      | 1 -
>  drivers/clk/qcom/camcc-sc7180.c       | 1 -
>  drivers/clk/qcom/camcc-sc7280.c       | 1 -
>  drivers/clk/qcom/camcc-sm4450.c       | 1 -
>  drivers/clk/qcom/camcc-sm7150.c       | 1 -
>  drivers/clk/qcom/camcc-sm8150.c       | 1 -
>  drivers/clk/qcom/camcc-sm8250.c       | 1 -
>  drivers/clk/qcom/dispcc-qcm2290.c     | 1 -
>  drivers/clk/qcom/dispcc-sc8280xp.c    | 2 --
>  drivers/clk/qcom/dispcc-sdm845.c      | 1 -
>  drivers/clk/qcom/dispcc-sm4450.c      | 1 -
>  drivers/clk/qcom/dispcc-sm6115.c      | 1 -
>  drivers/clk/qcom/dispcc-sm7150.c      | 1 -
>  drivers/clk/qcom/dispcc-sm8250.c      | 1 -
>  drivers/clk/qcom/dispcc-sm8450.c      | 2 --
>  drivers/clk/qcom/dispcc-sm8550.c      | 2 --
>  drivers/clk/qcom/dispcc-sm8750.c      | 2 --
This file should not be part of this patchset. I'll wait for review and
send a v2 tomorrow.

Best regards,
Krzysztof

