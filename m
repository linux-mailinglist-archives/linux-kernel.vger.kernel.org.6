Return-Path: <linux-kernel+bounces-173716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2188C0485
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3359728520F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D005985626;
	Wed,  8 May 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RY6z9kKQ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801AA39FC1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193602; cv=none; b=NRD3gCL7cE7c4vahPNJU8xgfIqqKym+VQGECJa32vE2YKEIO7ZBI1drRIxa0Rw3oQG/1g5AtXes3aW7svkhfW/SVawYqGl+dDWNFl9Zp/N6H9g/ZUn1CTDqVEEuNc3iOvoNM9/wUsxTz5xPrVQZTi1FS/zIMTdT4ZtGej7zN0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193602; c=relaxed/simple;
	bh=hoHi3AjYgp2H4mxjsiI6khkQzm1qsZ0lI7XMou4a9g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y29fk7G/XbqBTbdtKyGZ7Wdl864/kO5dasr9B7jncv78ydqYcGEaSrvcJ7wsdfapO3UclrxrFNypaYNpXxkU8kjgu3bWh73oSpQSzX+EC3QKg7GC20ijIbZYrAThaMIyOoaR83O8kWZbC/0NOguPDFUMOQ2ZDl+vK3ov3tr4F4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RY6z9kKQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f3761c96aso4077e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 11:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715193599; x=1715798399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9I4ZgOvNPHMd1mVaqCXOzp4qB4tIGn/b7upIZyGwo=;
        b=RY6z9kKQwxLwYRv2NzS1AU+3qPK1yjj++z3Ig2AxRZKj8IaF2DWxaIrKuyGCA4ZkFW
         5NqyEKmHB7PaAyOt9mVIoM45Ok3gInZwzwY0/qWk2CDkonhKE0YqFctAJekOkQVKOODy
         DKTbdXPsmbvQUnOi6ughbbJDhIhCiMi3YsYPnZzT6fQMvcqaiLAzqU7cz2hsx4Y80f27
         AlzXwBfg8cyd+6ys18s/zvC7K5pxOgT24UcifX05OnLGkEf7r0q3uX6qKIYM++I/KQYX
         8algsV9iI0PCUh1dqO5vimWW9/q5qV1/ULKiq8/W5W5Lgq53OwCc8+p0OjXtQx804xey
         6rrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715193599; x=1715798399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ9I4ZgOvNPHMd1mVaqCXOzp4qB4tIGn/b7upIZyGwo=;
        b=Nr55xSvbkv9io9Qzg4lNaj5431A2cYHvGeCF4C8iUP/eHoj6YC+YG4mVNrO4Hwd1SK
         WMqczn5X63gscuvRSOeGxA24GzcMeXZ4W/EaJG6ci9IyfCQMs+dQtw2b8A7oGtPRVPIr
         x6wpqopFPOomK3Y6e/77z1MS9V8MQXeUpRtf5qplN9+5KhBQ7zHlyY+L6Ni2i0TTOLmi
         NrcdkMe2HwAcsVuoKNWIEpwiz66XvMN22wnlVhIshbuPQQInVYfkNMXA+pUn05bTzB2W
         iGVXltxHvDGP6c3eaEH8nbO9VWyTydvuj2aTmmH8O4ljqeB1MePbzip37IjEqi+tZPDt
         Pd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDNqwG2FqdoMN+ZQ6SSe1LWnRr3c8jveoS5SDRoLx/gJziKBnJZcMK596oAx9nl39aAKoNQAbUcYUtPdusZXKKS5okyU8u90yelTmG
X-Gm-Message-State: AOJu0Ywg1RHSz3kMtmGKdCfYm9ruea9Dd6E0aND5VPZtVdFswk7ZkqGl
	F/7uUZwG9tV1hZB/otE/14uydZj18p+vh33h2bdYzPS/zvC2qFf2eWnV7KZ94zo=
X-Google-Smtp-Source: AGHT+IFcKJO0kqjUVP3Onb+Gg2SFImiD+z8mGQ3L0TQ4exBwG5dLqQVdwkigSlwdxqTJ8W78ypgZYQ==
X-Received: by 2002:ac2:4e14:0:b0:51e:fb8d:796e with SMTP id 2adb3069b0e04-5217c372db5mr3607513e87.3.1715193598528;
        Wed, 08 May 2024 11:39:58 -0700 (PDT)
Received: from [172.30.204.208] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512324600b0051b0f4e1b0dsm2619915lfr.276.2024.05.08.11.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 11:39:58 -0700 (PDT)
Message-ID: <0e898bff-6208-44a6-8ad7-1dd5856321c6@linaro.org>
Date: Wed, 8 May 2024 20:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sa8775p: mark ethernet devices
 as DMA-coherent
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240507-mark_ethernet_devices_dma_coherent-v3-0-dbe70d0fa971@quicinc.com>
 <20240507-mark_ethernet_devices_dma_coherent-v3-1-dbe70d0fa971@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240507-mark_ethernet_devices_dma_coherent-v3-1-dbe70d0fa971@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/8/24 03:31, Sagar Cheluvegowda wrote:
> Ethernet devices are cache coherent, mark it as such in the dtsi.
> 
> Fixes: ff499a0fbb23 ("arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface")
> Fixes: e952348a7cc7 ("arm64: dts: qcom: sa8775p: add a node for EMAC1")
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

