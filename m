Return-Path: <linux-kernel+bounces-171212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CC8BE146
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161B91C21BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E37152E18;
	Tue,  7 May 2024 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YX7+LXtT"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4F15252F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082199; cv=none; b=trGqbAQ6+0KMiKj3bUn1P5G7YoZ0gnf+rYMxQq+S++r9G+SrkF/I7DzGdsYAM91zGX9J342FkZsQtOIY73Y07qCyoL8CvgvUaqGogS4qrgSPE/pwfkOfHltveJVKKTDHh3PID4XQ9q1EFIzT0WaZfvoWu9MLp0VxI6JmDCYAw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082199; c=relaxed/simple;
	bh=nJmQfa/G63amUHNoyNPPruCS1yE59OplOKYnfKXgiM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6xI97VO8xlrGcb8gWl+03V9n0yUL9E6jMFa9FT4sF2dwZoPL4tLCNDT5sKrWzdQRnKjJsimpSlagOMN1sGT55ngWgaQWDcc1wCvUa0o+rFug4CojQRiilmk5zj4vGqwTH7HF9LON/FrS3k7Ck+F4yGdMG2D6ktel9t2YjvHtRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YX7+LXtT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f29e80800so3310523e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715082195; x=1715686995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCCDWmEOxdrYyg03QGM9HCNXy8fqBDtdzIoCPdDROW0=;
        b=YX7+LXtTF5V7RKwwlL+PLYY/0BXJ5KWbXgprejd3wFVd1HU7X4eIEzoQ0ZC+j0aydy
         RtGtkscZ2CThkKXGSugkEnZJ+3cqlo85qD8ZpFT0EIa6Jc+WwJ63iGdbHWy3+rQufRFd
         ncOIZu2HTRd12OjUTCY9pYSH+aRQ5Qa8gdSBD1DCBx3JJq+k/IiVPKkxYvfxknbuokch
         aSxsYdB3Q/JxxYK97vRv8+KQ4Q1B+/z63JNdAzs2xii0BAO5WocndJcXo6WjB5/4ipad
         /7nWI75U61ZCqSPOyXofn3ZsQ4GKxu7mGnvN1i4l7xs0fq4/H4dv0IoSaHUUoWHAWdf6
         9v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715082195; x=1715686995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCCDWmEOxdrYyg03QGM9HCNXy8fqBDtdzIoCPdDROW0=;
        b=my/meqF3nSUo9GL5WSKdQptuH87iYTBbVIOMQ7eiGoN/M0WfnckbrgFRWhjyuHcMzT
         w7Bt2+zQlrpGRHrEBJKYaaL0913kTNXPK8uLjU9bcUpJspuqbEdbmtghHIkVHjrFj+JO
         ghOFo881WmUdyzHMdJ57+cpN4r5SD5ZIFb+CeMcpIntAoXe5FI+hjYvgmfzwYEvR6p2m
         7Sf7zMw+9BEE6mZDIcGF7KYhlWaY2Wrc5UTBuMkX/nSs8jjCRQo3slSbEoq7qof49dp8
         n+oDUnAwUMEiIVDDp5PoAKDRJ3O7hFri7sqthMEo39HQV0ufA/BeABbFVvMv6lARJzqn
         nTjg==
X-Forwarded-Encrypted: i=1; AJvYcCXg8AGri+QeVk78IWBzeI4ejt201qfc9NWZx+aifLddp4ZQEkcUqQxA8D9UFKElOe+AOw/fCRV7q03qmLdue2A8sM2dazSTC4JHS4Rk
X-Gm-Message-State: AOJu0YwEv7YHh7PZv3veBU26Apw1C3XDsCvmZms9jE//dMNow0hII3/D
	fxc6AESz96YIp/afzs+WXEEuYvq2DSpdwvFYhmRtTOyZHada4WWjEIFPRDwLwSw=
X-Google-Smtp-Source: AGHT+IEatV3ixiUCg3FxqsVCLWRFRBRCA8gGTMCNaxxmiDHfSI+2iThDhqWAlx33/+UViLds+bPqkg==
X-Received: by 2002:ac2:58cc:0:b0:515:cfaf:737 with SMTP id u12-20020ac258cc000000b00515cfaf0737mr6627843lfo.9.1715082195460;
        Tue, 07 May 2024 04:43:15 -0700 (PDT)
Received: from [172.30.205.144] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id h2-20020a19ca42000000b005196e3e8a84sm2121235lfj.177.2024.05.07.04.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 04:43:15 -0700 (PDT)
Message-ID: <90a5b641-af5b-4640-b2ad-85dbbab523bf@linaro.org>
Date: Tue, 7 May 2024 13:43:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for
 LDO's used
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Udipto Goswami <quic_ugoswami@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
 <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/2/24 15:12, Dmitry Baryshkov wrote:
> On Thu, 2 May 2024 at 15:33, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
>>
>> The Femto phy depends on 0.88/ 1.8/ 3.3V regulators for its operation.
>> If one of the regulators is not voted to the required minimum voltage
>> for phy to operate, then High speed mode of operation will fail.
>>
>> On certain targets like (qcm6490_rb3gen2) where the minimum voltage
>> of the regulator is lower than the operating voltage of the phy.
>> If not voted properly, the phy supply would be limited to the min value
>> of the LDO thereby rendering the phy non-operational.
>>
>> The current implementation of the regulators in the Femto PHY is not
>> setting the load and voltage for each LDO. The appropriate voltages and
>> loads required for the PHY to operate should be set.
> 
> Please move min/max voltages to the DTS. There is no need to set them
> from the driver.
> 
> Also, is there any reason why you can't use `regulator-initial-mode =
> <RPMH_REGULATOR_MODE_HPM>;` like other boards do?

The point is to aggregate the values and switch to HPM if a threshold is
crossed (or stay in LPM otherwise)

Konrad

