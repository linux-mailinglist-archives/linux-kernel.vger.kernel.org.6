Return-Path: <linux-kernel+bounces-171456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55498BE484
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60B3028958B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E568B15E5D4;
	Tue,  7 May 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTn6Rbfx"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC792156F29
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089305; cv=none; b=AcaB8wZxh/ov4mnAl2Jungme55bBVpPCCwsOgNhOD0zELGRBu9Z3MBPZIqpzFZKbUH3R4QnyDaapWP838EZZ2tVxfyEpdMbLftL/zbTFwut7t5bjoL0pcCWsc+53M8bCK3vM7/CJPnu/17W0vSHW77mclyKWU25P9Nf1gvqBk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089305; c=relaxed/simple;
	bh=U3rGI4TXjzTskPSdX5hfRfaXW8W6u8mc2k9lgqQ4Kyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBhkFZ8RGoa8+RcPnJG9S+a5wRjN9eoaEdkpG/fp5Qe5KPC3tl+XdKLTUx8Vkin/OEyGVtdf03D98ZTqWaw2b45BOsDdgJxYIQ43sN0E6mA5OQi8NN6zJWcISTjlJcmotIKLqrTV3GFeN1OvM5zOSEI7rqY0nWoTsbzACH1CvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hTn6Rbfx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e3efa18e6aso6845161fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715089302; x=1715694102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eBYWPKKxIxo8aRFjjK9T2hA9r6Tr0Rm6zJjBWqA8aQQ=;
        b=hTn6RbfxugjDJ83Lc9VWNGsRvHgrKFgborM0GZE0mE1fdiNtMjJJnZhNUcYF3Lbyu5
         /Dg0qhjwaJ7RseO7gRyPZTGkE3L+qeCJToZd2jQj9wiooptBo+a8Z4wbV6Zl5dMuX3eQ
         pp5Ai+vbHm325mzuKIpXxctM7vOlJ2fVIKxlFgGbo7GWkkTnNNPJ/BrK+V+MOiu1eM9u
         S7wvbOeQGLjYV0SVRjIIELTTu8b0Iyqcdrvfj25PaFhXliZ/tVh9megjfu6ujWhcISGU
         O2pFB2fyxN6O7JwuF1PXR5bLqH/bn5Kaz9lh0wihpAUnNAD2K1OjgV0ROzavx2BeznJu
         3JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715089302; x=1715694102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBYWPKKxIxo8aRFjjK9T2hA9r6Tr0Rm6zJjBWqA8aQQ=;
        b=Q1YwKDAAjJ+FJY09v1kYbJt+BSmxDz6eeNuPVCRbtXMqePBtpG1+dd4vJ11Qwo3HWe
         XZ7BcxFA5xfnLAHyD9ppaZ7KS/cWW2+d6Dkm7kPQ5uZaKC24oBvLXmVJ6u9whkjB4OVv
         PAYhCiCTpU8NmihHIbUFIa/zLjAU0+hDehbnf3qPjR6XzzJqltP7wnNymep0UiQ5IHdZ
         4S8n5ckeq2hlRcgLdd+jzL6ntQguOAdp67nJ3x2CAw5tb6+p8RPnr0dF/tdkHkUYLl8W
         eGUnvJ5kplUPjkBcY4W8hkzjATjg4BlbuFu8kpLpHyMM04usanvJi4uI9ty8Sf8XsXVw
         yVMA==
X-Forwarded-Encrypted: i=1; AJvYcCXtQ5P7k7KK+ITQwPuecMOc+Ba3OqtBeVQ7Us7fss/mHPO7Cr8e1p7zncrnMMhUibojHYI3siseEIxrGqNLKUphMeHJPmZfbij+5oqq
X-Gm-Message-State: AOJu0YzykLO7V8c5K2xHsAyJSPznsKAFg9VIEIrXoT6rsqfP3Xt/RIkI
	ECUzT80iOCd0oZ7FOy9/Gk7KzaIh66T8qpnn34d4SlY3pzOdF2hlQw1mmgrYrD1Jm22AShMzu1i
	/
X-Google-Smtp-Source: AGHT+IFhusLgGPzXhOPfN0j+8HODL1lRzxw67tVfNgxWdHZALf7v7+cLKSB0NTJACUQLd+5spu3LXw==
X-Received: by 2002:a2e:7d0e:0:b0:2e1:eb38:d4b4 with SMTP id 38308e7fff4ca-2e3d9cb3781mr7358371fa.21.1715089301860;
        Tue, 07 May 2024 06:41:41 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c0d:408:fa88:abdb:17c2:cf24? ([2a00:f41:c0d:408:fa88:abdb:17c2:cf24])
        by smtp.gmail.com with ESMTPSA id i16-20020a2e8650000000b002e15aec44fesm2054159ljj.96.2024.05.07.06.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 06:41:41 -0700 (PDT)
Message-ID: <163a0c01-8f9f-48e6-89dc-2b702e755622@linaro.org>
Date: Tue, 7 May 2024 15:41:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for
 LDO's used
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Udipto Goswami <quic_ugoswami@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
 <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com>
 <90a5b641-af5b-4640-b2ad-85dbbab523bf@linaro.org>
 <CAA8EJpoWWXvJabcVqp+YSa8arQbLPC=v+XkvPZe6nwH7aaKnfQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpoWWXvJabcVqp+YSa8arQbLPC=v+XkvPZe6nwH7aaKnfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/24 13:55, Dmitry Baryshkov wrote:
> On Tue, 7 May 2024 at 14:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 5/2/24 15:12, Dmitry Baryshkov wrote:
>>> On Thu, 2 May 2024 at 15:33, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
>>>>
>>>> The Femto phy depends on 0.88/ 1.8/ 3.3V regulators for its operation.
>>>> If one of the regulators is not voted to the required minimum voltage
>>>> for phy to operate, then High speed mode of operation will fail.
>>>>
>>>> On certain targets like (qcm6490_rb3gen2) where the minimum voltage
>>>> of the regulator is lower than the operating voltage of the phy.
>>>> If not voted properly, the phy supply would be limited to the min value
>>>> of the LDO thereby rendering the phy non-operational.
>>>>
>>>> The current implementation of the regulators in the Femto PHY is not
>>>> setting the load and voltage for each LDO. The appropriate voltages and
>>>> loads required for the PHY to operate should be set.
>>>
>>> Please move min/max voltages to the DTS. There is no need to set them
>>> from the driver.
>>>
>>> Also, is there any reason why you can't use `regulator-initial-mode =
>>> <RPMH_REGULATOR_MODE_HPM>;` like other boards do?
>>
>> The point is to aggregate the values and switch to HPM if a threshold is
>> crossed (or stay in LPM otherwise)
> 
> I see that other boards use regulator-initial-mode for the USB PHY
> regulators. Are we going to change all of them too?

Not sure about initial mode yet.

> Also note, that while the combo QMP driver sets the loads, the pure
> USB QMP PHY driver doesn't set the loads. This way we can end up with
> the undervolted PHY.

Sounds like something to fix, then

Konrad

