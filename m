Return-Path: <linux-kernel+bounces-556993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9E6A5D20E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EC53B18CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D00C264633;
	Tue, 11 Mar 2025 21:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/yhf+Ow"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603F264F93
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730042; cv=none; b=RzgMgUa7VTxGk2j9UhaCHh1j/ropHUfG+BAfeMYEy3Kdppey230RHdazfUlS8Et/fYaqOzT86zO6EcJUKjoXooKPNmabZERBoB/blZd5kRXEGtakxskTTEWAPtI0lg6FPWQ47WHp8/en/KjVDLuUXJTYZWpIZjJxHpt6ww+vs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730042; c=relaxed/simple;
	bh=ZgzE4thBCoSTa+dcViXPcQn5/G3IUHp1o/3wzyNpJ6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnOzZsjWgTwjQE20aDJzhMd+XuRyOrFOXxjDIr+vle7A/yGSVM68iFLFwGZwy2gTV2gZYBpE0/k/rnFKY1UVS+Ecms1CvFc4UXj0MAghP62zfR9ukqFei+MFhnwoa0fuUN3M12xwwhIXF/KRAPP4AZAj9Em69lxL3D0CkxWvLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f/yhf+Ow; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54995620c02so520373e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741730038; x=1742334838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X5gsB+0yYh8xE9yPNlTczFYo/dqiaFhvnnAdkeUoWJg=;
        b=f/yhf+Ow6qLnHeu7fpBARK6iQQyRmHWvFObl/a0hci1teamJW+UNUazoTQxxo7esNl
         arQvnfnn6Eq+GUuglGzFjCRxlPy3bGNrmpA7ZWCmnuNPB9lsq6CTUuQn/n6i1o4XdJpZ
         WYP7WVSZou2lt+5F8OHTinmJSjsNNe/IaaQ2XeS7BNvGbr4MUehdokjGbMjXFobxE1qL
         cwTYeXwwdp9u+Kz/q5/1SuPIPxv3hIvJwvOTEHOTzO8tYdmtCoYFq/nw8w7PxTh9YWrg
         R25eUG17re6Scd0jjMyQ6S5xoM6tAYGXlJn4JyxKoFswjSCyDehZf/Dg9nsICyE0UNn+
         wQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730038; x=1742334838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X5gsB+0yYh8xE9yPNlTczFYo/dqiaFhvnnAdkeUoWJg=;
        b=Pc4fcU4sO2jr6BvQRECU6Tvlul/MkTm9ORcyZu93Ddu0QnhJOTbh3jEMW/WutNzYeQ
         KjeZBLkn24dd0Qf+8imzvu4+FKobVuVAquVf39/wzcU9p8G9bFLwWLNukVZgni92GXPg
         Bk8LCuQFoPYaq98lpZaI+WmTa47uX8N7eMpPfUpdk7YOFubjsIZI4GdKQPoAW4+OO5Cw
         f6YIuQQoHC09YZVe9hbSp1WUNxWza8eBr8RSv8adH3EtnXwmL5dDlej/2+MjkZcFmBbB
         /3Ds94+AcrOvEyOtCulSQvC1J0A9XYYG45K9sYy2Vr3aC2A+zH0MT3BEJs6lzgpe+fZU
         AxGg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+Pfck52NTxz4uiggKhAZRZES6j2Ah2WESGGVjPJMt79s249PahfBjRLEk32zYEZrEXXaXNdcqk8hp0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNE/scdt22XdICbBagJ2ESldEcw6AzJOpgsMobvSoyulCA+v9r
	ShF0n4tsN9JHg9jIFHchG2hbjl4ptqTVWyYHdZqfnIBc7dqM4nsYVB1mI+VhPpM=
X-Gm-Gg: ASbGnctqIBLxByG5qPcxN/+ZKQdasrNLBeSmetrCxbWWhAHHH3HDMUAzfW81KDRcF8M
	VfaLj9iSJuabVfJF+9+aStqwhtq/NJnYKI4T8HB7f0/n4QbI3BEHdJnVODlv0vBcwDfv3T/YVSc
	eohjUMQBmWlt64s71ypw5TS6UfaQ1NiaWwYXpIpruq9NwbZQbXyaSIslhcmGyd9HzCrVKRCZhcf
	umDSB7v/52ExEKd1tBh3QrgCygwIOZRTUPWDAdNTrRyINc8mzh+/2B5P86dWyVvLVhumw329Fbk
	OC2A9Zm3qD989fCJUAxiTbo6LCSi6Dtra96a3uQMUT6D1dug9D9lVRb+X6QsdxijTH7k4CwLPtg
	uowhR6ANrzcDFsUcME4oZ2IsPfEInPzQqYQ==
X-Google-Smtp-Source: AGHT+IFMqD7MP0QO68gqxLROvT5NFpnEwxTOzpskeLzkJrA9xPbwOTw4OmpOx0RaAr9lWptyIlaMyw==
X-Received: by 2002:a05:6512:3b10:b0:545:6f1:948d with SMTP id 2adb3069b0e04-549abacc9e6mr613771e87.7.1741730037032;
        Tue, 11 Mar 2025 14:53:57 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae462c6sm1910515e87.4.2025.03.11.14.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:53:55 -0700 (PDT)
Message-ID: <70d6acfc-739a-4c0a-9087-77e16c6ac989@linaro.org>
Date: Tue, 11 Mar 2025 23:53:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] dt-bindings: media: Add qcom,x1e80100-camss
Content-Language: ru-RU
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-0-c2964504131c@linaro.org>
 <20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-1-c2964504131c@linaro.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20250119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v4-1-c2964504131c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryan.

On 1/19/25 02:54, Bryan O'Donoghue wrote:
> Add bindings for qcom,x1e80100-camss in order to support the camera
> subsystem for x1e80100 as found in various Co-Pilot laptops.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

<snip>

> +
> +  reg-names:
> +    items:
> +      - const: csid_wrapper
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy4
> +      - const: csitpg0
> +      - const: csitpg1
> +      - const: csitpg2
> +      - const: vfe_lite0
> +      - const: vfe_lite1
> +      - const: vfe0
> +      - const: vfe1

Here I'm a bit lost about the selected ordering rule, I kindly
ask for a clarification.

In ASCII the underscore symbol '_' goes way after any 7-bit symbols
including '0' and other digits, but this is violated in the sorting
order above.

The expected sorting order would rather be like this one:

   - const: csid0
   - const: csid1
   - const: csid2
   - const: csid_lite0
   - const: csid_lite1
   - const: csid_wrapper
   - const: csiphy0
   - const: csiphy1
   - const: csiphy2
   - const: csiphy4
   - const: csitpg0
   - const: csitpg1
   - const: csitpg2
   - const: vfe0
   - const: vfe1
   - const: vfe_lite0
   - const: vfe_lite1

> +
> +  clocks:
> +    maxItems: 29
> +
> +  clock-names:
> +    items:
> +      - const: camnoc_rt_axi
> +      - const: camnoc_nrt_axi

Okay, there might be some explanations about the underscore symbol,
anyway I would appreciate to get them, but here it's definitely
incorrect, it's very unlikely that the symbol 'r' precedes 'n'.

> +      - const: core_ahb
> +      - const: cpas_ahb
> +      - const: cpas_fast_ahb
> +      - const: cpas_vfe0
> +      - const: cpas_vfe1
> +      - const: cpas_vfe_lite
> +      - const: cphy_rx_clk_src
> +      - const: csid
> +      - const: csid_csiphy_rx
> +      - const: csiphy0
> +      - const: csiphy0_timer
> +      - const: csiphy1
> +      - const: csiphy1_timer
> +      - const: csiphy2
> +      - const: csiphy2_timer
> +      - const: csiphy4
> +      - const: csiphy4_timer
> +      - const: gcc_axi_hf
> +      - const: gcc_axi_sf
> +      - const: vfe0
> +      - const: vfe0_fast_ahb
> +      - const: vfe1
> +      - const: vfe1_fast_ahb
> +      - const: vfe_lite
> +      - const: vfe_lite_ahb
> +      - const: vfe_lite_cphy_rx
> +      - const: vfe_lite_csid
> +
> +  interrupts:
> +    maxItems: 13
> +
> +  interrupt-names:
> +    items:
> +      - const: csid0
> +      - const: csid1
> +      - const: csid2
> +      - const: csid_lite0
> +      - const: csid_lite1
> +      - const: csiphy0
> +      - const: csiphy1
> +      - const: csiphy2
> +      - const: csiphy4
> +      - const: vfe0
> +      - const: vfe1
> +      - const: vfe_lite0
> +      - const: vfe_lite1

Same as above.

> +  interconnects:
> +    maxItems: 4
> +
> +  interconnect-names:
> +    items:
> +      - const: cam_ahb
> +      - const: cam_hf_mnoc
> +      - const: cam_sf_mnoc
> +      - const: cam_sf_icp_mnoc
> +

--
Best wishes,
Vladimir

