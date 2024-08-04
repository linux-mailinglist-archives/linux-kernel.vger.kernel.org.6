Return-Path: <linux-kernel+bounces-274009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF819470BF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A323B209D9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3101D136658;
	Sun,  4 Aug 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ht3zVVoK"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B139C1D530
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722807564; cv=none; b=g38LzCr3hVSMnCGszX9WZbBARltVTPD8vsV6PExa6tJ79cHMb1XrynshG4uZFFLIVpJLoAwtA5V5nnESOepujLiWpJQ+hzPcTacu113WJin9d+Ukple/wrKcj475/eCnqLVbysjCiT6oUyU36cgqxUYMSUqU2RoPu3LQTJx8AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722807564; c=relaxed/simple;
	bh=7F3OtARw/cs6dPtZKv0yBqOXRYjYPp8LLhLECkvVnw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaPubk/AxHZocVAeio20aBQ84T3taZFfqapTLwma3c4kJxeMA44c2Yo64MK+2f0IYD8bzO6gFrV+KxvaGqq8S+TEuWaB9zpCNVBlFL2rkIwPpvkyGvY+0fFEFMsMRRM6XOaP9xYPC3Tcsb/hylgqg7YNK2H+FJeR/eUF4WKboAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ht3zVVoK; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52f00427236so1783119e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722807561; x=1723412361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9T6GzYfa6uyFTS+KxoC8wkXUs+Fe55+La0GAR+Mj6fc=;
        b=Ht3zVVoKdvk+djiZQHnNJe8QY11xH/UO4EMGpHntakw/wh/9topiOUKR64MIZi/NdP
         B7YAnoVasYP78QrJA6ud63Hl4032F4I7MspUQxLeFcX1nOYTXTyzkqfldmPrvSkxFSMq
         mPfYNul2/wFfXReIpnAglRKF8dA2h+bPk4j+IQ4FyiEe7vDVOy2meob2sCf5QrbvL1Rx
         yUPShLCtXFw8xhbjUTZFCzh4WoHWlMRdK5vsYxn2xNNUf38xwBKdjKciTd3OLzwQl6Ya
         lvwE5wdhDZDExiANZPn795RzxWBOJcYURxbSalyvg+UI9TYIb59xAsyHUii4OqJwYRW5
         wEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722807561; x=1723412361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9T6GzYfa6uyFTS+KxoC8wkXUs+Fe55+La0GAR+Mj6fc=;
        b=Qak2aMqLYswLbs6jglePG9dCZwyUQ8X1LAuRd+D+3BmIENBRCMmGi3BDNLlfm6PFXA
         tiib7hWqFMqrn2/7/lhbmGDRqwP4Tu3cgNyCrlGZCwIrZse4kVJGQVbx0KnQl24KoEqi
         WjNNobl1fD7Dpjk9BNkii64AL1k81oBlj+tn5rJ0C6UeCmtNGwyz2EcjsnYQLtm+DW1G
         tnISdbVOqphMQKQuq4pUO2Hbb1grRQzYKRxru2rI6u10AfClViErw/fX+N1TBqIR1G78
         KbuohmZc60k9cAyqiXtqPdlEMgLftsAESMVziFbvEQ4sXtqO8VFN+GiedhOIvJHDon8Q
         gBNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqpTh6lsjyhQ6etIOrrlE3UkscwzxgT4O929k1/DsYS84Kj/DXRicyTepcP2c72EfJMEQEvYOAB4e9tMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdV/Kt4RYouXOZENUEmmZbtO/aEw2Hk1Yns7i74P6TtH4QH0uA
	KqLuVh1orf+tB8VB5M6qTJ5SRLc27A6JtvwDxpUuXWOnmz6JdVFWFtNQ8zP5Jr4=
X-Google-Smtp-Source: AGHT+IEfaHhH9+DaRGjUBTUcRKkGohppCDLDMJixdqzSmwNSyM7pVDdYzGLv7kucTAMzF/75LA2/FA==
X-Received: by 2002:a05:6512:280a:b0:52c:def2:d8af with SMTP id 2adb3069b0e04-530bb395763mr3221698e87.4.1722807560677;
        Sun, 04 Aug 2024 14:39:20 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba35949sm909065e87.224.2024.08.04.14.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 14:39:20 -0700 (PDT)
Message-ID: <7d4fbb0d-9595-429f-bcdb-1b53f4d49d0d@linaro.org>
Date: Mon, 5 Aug 2024 00:39:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/2] dt-bindings: clock: qcom: Drop required-opps in
 required on SM8650 camcc
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>, kernel test robot <lkp@intel.com>
References: <20240801064448.29626-1-quic_jkona@quicinc.com>
 <20240801064448.29626-3-quic_jkona@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20240801064448.29626-3-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 09:44, Jagadeesh Kona wrote:
> On SM8650, the minimum voltage corner supported on MMCX from cmd-db is
> sufficient for clock controllers to operate and there is no need to specify
> the required-opps. Hence remove the required-opps property from the list of
> required properties for SM8650 camcc bindings.
> 
> This fixes:
> 
> arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: clock-controller@ade0000:
> 'required-opps' is a required property
> 
> arch/arm64/boot/dts/qcom/sm8650-mtp.dtb: clock-controller@ade0000:
> 'required-opps' is a required property
> 
> arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: clock-controller@ade0000:
> 'required-opps' is a required property
> 
> Fixes: 1ae3f0578e0e ("dt-bindings: clock: qcom: Add SM8650 camera clock controller")
> Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Closes: https://lore.kernel.org/all/0f13ab6b-dff1-4b26-9707-704ae2e2b535@linaro.org/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407070147.C9c3oTqS-lkp@intel.com/
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

--
Best wishes,
Vladimir

