Return-Path: <linux-kernel+bounces-225655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB65913355
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0761F2318C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C7215359B;
	Sat, 22 Jun 2024 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2p/2zlI"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853014D2B3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719055413; cv=none; b=FP+AUS1H0uuj8oThJ28vKRUqZscazhX/2Ao9IHNoNLEe5tkJIGPSQccq6kPBG381fbDp2NvCUjVNFs+mF0AgTCOsaWJvXG4GJQNbQRzyI/C5rv4JbZMixi09H+2ICVqe+Q3awOfJmsP4f7PUN5nIBjs2x/eXXxDbz2yDFi4wDJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719055413; c=relaxed/simple;
	bh=s8IcRfDXQj8f4kTCAOTtkNej/CuRn/sZJe1kkX5GCWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MU1Za49Fx21FnHaUEUzaOWv2OAtjROEIKoAxq/q2MrFs99iJQ/NTbolEwWxhGGkoKt1UW1H2bB+IkI8w+fyWm/eUxyK6yf+m7hGTJBIlRT0NBpIEkqOvNnu+uOYJzdtHAZVVOYcEelG23ZPzyhGEZSN3SM4kPtjod9pPpzVcll8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j2p/2zlI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6fe118805dso46867166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719055410; x=1719660210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v7v8etS9lc99/NCTpKj/r0Kcu15d2+tzcAbXByqh6yU=;
        b=j2p/2zlI7fw/6R3RYdDQGWezho0/ahqytxSqmxl1cEIwZTsrv7HpQrIRFAdM4xWcTa
         DzDOlU6MfC12qQUJtKeM1JBOvemn3g2P/r85wtInh6tw8N3DJsJDzODjyrwd+7QCuCPT
         tazw9LarU47LqgChYt/iUnmD0nJXEMFqS0TqZ34AXdCq1UVVuHFOv2ehxD33VqvtHJJU
         NlHCKQm0Bjcah85xB51xz+s0K7M9/o3dGiFtBwXpsou0zQhyLCFAMsSLNZ4UAteXlOUf
         0XCSJ3Nba4kWiPYI/twm9D8aUs53LW+/1KHLg2qiPfYF0HaFadm7E/5OoXEwcsMTWfN1
         Q1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719055410; x=1719660210;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7v8etS9lc99/NCTpKj/r0Kcu15d2+tzcAbXByqh6yU=;
        b=L1wxJhcbrXnE/l4zx8CVN5kNDNaAarBvKooRxBJHpKA/gipoCMeeWrEvcl/RN1O+NB
         EbhehG+b7pH5M6OU3h53f3i2UllhzREhGedu7OJ1kFk4gvCDBNMBvy3y3vUsVVK+JZ3F
         BMHB4e/lCFQtwYf1+XJdy7A+zjMN3LTqUGfnFYIbsgxPLo7WcIUTv7qtRV2dFLo0g+df
         WWR7rlTNmxJYnr4QcS9+rfok/5mm2ipugb1bnRJvLvT6u4Y7A870kwVxn89kyw1J4WnR
         J/n59yIg5j40zKbS6R9UfNt7ZDlpYyEF09tuO4R7HD0NddZrJc6T/5w7Tpxmv9VY0ZXZ
         xijg==
X-Forwarded-Encrypted: i=1; AJvYcCX4uou9FT4lc96mhQRHdOWPBx7o0qQUp4xps0NyJIK/F5hJMRm0p8L3lEa8sPq2pejVvvR4+SKvLIsedhjQ347kxNt2VOk7tmkFWT8O
X-Gm-Message-State: AOJu0Yzc7JuXq5nL64fCW5VHs4cgJNCx0E3Tt/TR6NSQHMp0A50E9AWX
	dqWhT3cmxmXMWqVLpU4ykGaZFpVnKtC7uJj++9X4n7BMiUuMuIa1gcOV0Zv1UxM=
X-Google-Smtp-Source: AGHT+IEaoEAn8s4dir0EPAEpXEjAqmTi0SuzROmlVCniI2u8CE3A38eP7o8hGM5gEEfcIY0BHPKDcg==
X-Received: by 2002:a17:907:1606:b0:a6f:b19d:90ac with SMTP id a640c23a62f3a-a6fb19d9667mr734379866b.69.1719055409489;
        Sat, 22 Jun 2024 04:23:29 -0700 (PDT)
Received: from [192.168.128.35] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7242aa3c00sm11177366b.225.2024.06.22.04.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 04:23:29 -0700 (PDT)
Message-ID: <a9144943-317e-4727-b96b-532b5d56ceb1@linaro.org>
Date: Sat, 22 Jun 2024 13:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] clk: qcom: dispcc-sm8650: Update the GDSC wait_val
 fields and flags
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240621-topic-sm8650-upstream-fix-dispcc-v1-0-7b297dd9fcc1@linaro.org>
 <20240621-topic-sm8650-upstream-fix-dispcc-v1-5-7b297dd9fcc1@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240621-topic-sm8650-upstream-fix-dispcc-v1-5-7b297dd9fcc1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.06.2024 4:01 PM, Neil Armstrong wrote:
> Update the GDSC wait_val fields and flags as per the default hardware values.
> Add the missing POLL_CFG_GDSCR flag.
> 
> Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Bump: part of this patch is a broader problem that should have a
more generic solution: [1]

Konrad

[1] https://lore.kernel.org/linux-arm-msm/514cd1cb-4fb2-489d-bc4b-d332fd4d381e@linaro.org/

