Return-Path: <linux-kernel+bounces-306597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2847F9640FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A01C0B22575
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C1F18E042;
	Thu, 29 Aug 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N80c+WHA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9834718A6D4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926228; cv=none; b=JpVdMmaplu3H5g02X1OgsTTlF5AsmD1wZjosx6gVPXkwWzg++6eQ/FxJJzHiKpTbJMDtLfw6O9vK0aVZaafXa1rjQrXR/oivhZvf7pUm+ynSTVuUlL67CCHqacl1++26F+OdoUSoD8bWlyMbfmspoygKvbOmnVYHNEUwgnOZ2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926228; c=relaxed/simple;
	bh=Lt/9ND4lk2gsg2G4bm2hpuneDuZWchDQV3zw1+AFHoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uX6RMtbMUkAscECiiVe1TDc5K9BHsZ93/Ve1i2krURmVCpyRQZz5IkmSQ5KPkfDZJ14XZNUMaBRqFJ1AkjEJGvnO72a8eHouslGVwY9mXaZADmcvpjYPV++zqGlz8r71SYmHEUlcQnnZ7/kR85zdKLxRFctsZ6v7L62YUufvi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N80c+WHA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a83597ce5beso81141266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926224; x=1725531024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x88YAxOWPM6Vm2Gaxr6swuFJGR/lRbnBdiJSpLORFsA=;
        b=N80c+WHAPfZQua9L7jxqTPEQYmzuAn/Me3xpn/usPwy99sFXFU/IBtiNmtZV9OjVwi
         NKJgUABSWjP/OQkfRiuoob1elcgffh3GEI8XohAKehZ0ErmKsbKwl1l2afVFruKVE/Sz
         9gCTxO12KDcTIbTHEwNJ7zlfZHsVxU+hsJy7QJ8F7fsoSrcR+ikwbU/ZGYT3MzqtplfS
         yflhLxdoPXgJA9/+OMmDSdA9ntdVPp+BIraeU3ybB8+qP9MHulXgIgv11dekIYssPt0F
         2R3yq4up4X9dw1rS3QOSo5xVms+1r3o7qkopBZtfNdFmk8FfrMGNFUYJql1gx3XRCo2E
         +snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926224; x=1725531024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x88YAxOWPM6Vm2Gaxr6swuFJGR/lRbnBdiJSpLORFsA=;
        b=o+eJI3Z8vftQL8/ROtzFg9BrfXMlxyd2SNhvtSZXg90FSRp5aWwi7HAQ/gwJjoLmra
         rAOHOsDQfLi1NmrVQlFag1FXToIpAOmPTa0FyVtcLBwX3+yvx38ng1rbOX4BPABAOzmU
         9N3j4QmGrIyzEBsT6jOekIutKwuGYfwtgy9owdFtb7dJxKhnH+4cC4V7Tsu4MPRCUTqE
         nd0uMhkj3aR3Z9iWVi09yBQ6lKGn68IrHIFU99+0qb0IJWuLbvjVbYXvGgatzN7y3qVZ
         28oNlon2Umx3yYoBQFherzQBKmIo+uD+F1f09n1N8AYSyxh0Wk9xU/8aMi70sUyTrUIU
         ltdw==
X-Forwarded-Encrypted: i=1; AJvYcCUEEHMf+NrHGimr7vZxz0NzEI4A1twdRS4j7b8Nxk9U2ne9mRs0BE0/Bp/cruPMyZuRYi8drw9+2Izvzbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEt+yJmF4f7CSz9U3nyp2VzZGj2VR1ipBKgypU2Q9mDUJsexEy
	rmPof5ZKz4aJ12q24Z5eyR8kroUfWC09dfjRCq003WMEIYq5qXmjCTY4WHUs298=
X-Google-Smtp-Source: AGHT+IFNZz/FqMD/n7Lr2gtCtPCnz6hc+vHB01WkC69OIprExbTP7zO8xXE9q+kqD8YaMxA/hnBEXg==
X-Received: by 2002:a17:907:9407:b0:a6f:5609:954f with SMTP id a640c23a62f3a-a898c41445bmr156461566b.12.1724926223712;
        Thu, 29 Aug 2024 03:10:23 -0700 (PDT)
Received: from [192.168.0.25] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988feb32asm58908166b.23.2024.08.29.03.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 03:10:23 -0700 (PDT)
Message-ID: <c3ee4cd4-a4a6-421c-9114-fba5ecc365da@linaro.org>
Date: Thu, 29 Aug 2024 11:10:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Enable shared SE support over I2C
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20240829092418.2863659-1-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240829092418.2863659-1-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/08/2024 10:24, Mukesh Kumar Savaliya wrote:
> This Series adds support to share QUP based I2C SE between subsystems.
> Each subsystem should have its own GPII which interacts between SE and
> GSI DMA HW engine.
> 
> Subsystem must acquire Lock over the SE on GPII channel so that it
> gets uninterrupted control till it unlocks the SE. It also makes sure
> the commonly shared TLMM GPIOs are not touched which can impact other
> subsystem or cause any interruption. Generally, GPIOs are being
> unconfigured during suspend time.
> 
> GSI DMA engine is capable to perform requested transfer operations
> from any of the SE in a seamless way and its transparent to the
> subsystems. Make sure to enable “qcom,shared-se” flag only while
> enabling this feature. I2C client should add in its respective parent
> node.
> 
> ---
> Mukesh Kumar Savaliya (4):
>    dt-bindindgs: i2c: qcom,i2c-geni: Document shared flag
>    dma: gpi: Add Lock and Unlock TRE support to access SE exclusively
>    soc: qcom: geni-se: Export function geni_se_clks_off()
>    i2c: i2c-qcom-geni: Enable i2c controller sharing between two
>      subsystems
> 
>   .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |  4 ++
>   drivers/dma/qcom/gpi.c                        | 37 ++++++++++++++++++-
>   drivers/i2c/busses/i2c-qcom-geni.c            | 29 +++++++++++----
>   drivers/soc/qcom/qcom-geni-se.c               |  4 +-
>   include/linux/dma/qcom-gpi-dma.h              |  6 +++
>   include/linux/soc/qcom/geni-se.h              |  3 ++
>   6 files changed, 74 insertions(+), 9 deletions(-)
> 

In the cover letter please give an example of Serial Engine sharing.



