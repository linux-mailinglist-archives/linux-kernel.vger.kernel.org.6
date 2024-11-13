Return-Path: <linux-kernel+bounces-408332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA389C7D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06F928312C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 21:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6122071F2;
	Wed, 13 Nov 2024 21:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCcWoUlO"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FD208230
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532486; cv=none; b=sOUklym4Zy67IK0kLFpb8x9UgFwsWFEYpDYXdjp+s8Zhcokfp5HFNxBky/JsQnXJzK43QlRAS4Dp0qhguDGnPgWnCktkAUL0ekbaeMglCTrwRDqQCqo9lCs9AIpqDtHhyMbHS8UFqipqgspe90O0GNjmWRF4cjl8mizSjBWOm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532486; c=relaxed/simple;
	bh=y+NzpzejYDg4WwOMqqSlho5bizSCTIJ8a/DFv7RBwKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYIkF/HVstTsLsnnvurVbC0NWhHo9ui8RYyZkuzYGTedqaOZLBIyNoMphA5mqweQu9KDoYus2PHVegwpU6njdK15J74bqLUfTA/GJMNJYw0CnQsew/9RklS6cbxK49mjsCBDjChPar3XgqzRxFQcyF6Jcz0KNEwLbuV6W3T/DC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jCcWoUlO; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539e4488012so304247e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731532483; x=1732137283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWW4xpmzM2Fe1J6uTpcvQOhcfcmzKCMrCiJfOhpikeI=;
        b=jCcWoUlOSIEJzMqVqVAuyakW/kOeFOdvmx8GIVxu2F9+/s24CVonHzZkwfnOeeYxsW
         InJofXlAMa9XGzNA/xk7pQWbd5spUUWNUPKzOMoPQckaEzyE/pHJz23b9n0ekaMjqHeZ
         0786W6P2v7+swdBTtxiZrjp32yRgCQK113OX5hW2fpdS3mvpF5x3i9UaB+MM3Bvdf+Hs
         +SYBDyqpvOn7VbWZaM7bP3dF24hfkgLslcIuMjjsKQC03ZDSi6TfxWcC2vjpu4cHEFM/
         Wf5O1wTVl3mn/VGtoMsvNa2GbnToLDojkCKgXPG/0ALYaJpF9lbYkADiNf8+ORLl/So5
         adRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731532483; x=1732137283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWW4xpmzM2Fe1J6uTpcvQOhcfcmzKCMrCiJfOhpikeI=;
        b=Z8IMbmGcTJBOM+37Ooc3B44dxWAvIa6ZAc4hfcwTU1IQ8Qb0ffN0tvENiqbBknSouZ
         +ItYKXw+ATigybhBT9buhii0GASsdpjKMmebNzLPUL8wVNManSLP4osjqfOLRqnoEYLG
         2sJGUNuFYSQVHkU6gmFWHpHOnHbq7u+/uOYKrvyTBVs3pLIJYAx8EM7FN4L5vhSy/IK5
         yPCYkam/RQKU4Dxs/m3XvV+p/XwTXSBUe+DDcOvLQ/VVPzzj7bB+Fs096/q5OLtqAJ1e
         hQUNDQEm8M4JSn/FB9Y39yqqLKmmBQ3MKNjnumspspYvGc0zegjRqgC0zf6Oi4+dzC1/
         CdbA==
X-Forwarded-Encrypted: i=1; AJvYcCU5isCM6lu0fi4Ejx6Ci68+JQYF72LF2SlJLStusciTW4mD/e8aukCQYLlc2Yo9TGv/kdzGUKoPvNP+2mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvmr+iahHVfEZMFzyrCVI8RJ/y26rcGBIS9nlFlo4CdGP0yHz
	A3ULEhszj8kO2xHNOm4zVbBri8uy42lnhMZpuPcRh7v/bZVmz7GUa69wmfooSx4=
X-Google-Smtp-Source: AGHT+IE/abjEKPW1/bwyS2SME/i+tt3LJv7ehOsjOAcpnovPFLmxI8e0bu/XOCMufARKSCnFQIPMNQ==
X-Received: by 2002:a05:6512:2387:b0:536:9efb:bb19 with SMTP id 2adb3069b0e04-53d862628f1mr3057095e87.3.1731532483168;
        Wed, 13 Nov 2024 13:14:43 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826862f8sm2297338e87.101.2024.11.13.13.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 13:14:42 -0800 (PST)
Message-ID: <8f07e440-8a56-4315-bb79-b630649a9116@linaro.org>
Date: Wed, 13 Nov 2024 23:14:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] media: qcom: camss: Add MSM8953 resources
Content-Language: en-US
To: barnabas.czeman@mainlining.org,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Vladimir Lypak <vladimir.lypak@gmail.com>
References: <20241103-camss-msm8953-v4-0-48d0ec75958d@mainlining.org>
 <20241103-camss-msm8953-v4-3-48d0ec75958d@mainlining.org>
 <6833ebc6-9210-471a-8ca6-5f3605155f33@linaro.org>
 <412b3252f1ca795fbcfaf5e466e94642@mainlining.org>
 <67d014f1-9424-4b88-b031-096a5596c5c8@linaro.org>
 <eda3d0ae-50eb-43b2-a234-93b209fbcdeb@linaro.org>
 <ffa2a863c8a9b99582ad6648600d372b@mainlining.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <ffa2a863c8a9b99582ad6648600d372b@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/24 17:32, barnabas.czeman@mainlining.org wrote:
> On 2024-11-13 16:23, Bryan O'Donoghue wrote:
>> On 13/11/2024 13:28, Vladimir Zapolskiy wrote:
>>> So, we have to rely on the documentation here. Bryan, can you please
>>> check, if VDDA_MIPI_CSI pad on MSM8916 and/or MSM8953 is related to
>>> CSIPHY or CSID power supply? Thank you in advance.
>>
>> No there's really no indication in the documents I have how the input
>> gets routed internally, CSID, CSIPHY, both.. not clear.
>>
>> I think Barnabás is right, the best source of information we have for
>> this one is the downstream dtsi => CSID.
> I have found the regulator also in downstream msm_csid driver i hope it
> helps a bit.
> https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.10.6.2.c26-01500-89xx.0/drivers/media/platform/msm/camera_v2/sensor/csid/msm_csid.c#L73
> 

Agreed, since the documentation is ambiguous about the voltage supply,
the best deal is to follow the downstream code here.

Please fix the review findings in the dt-bindings, and rebase the driver
changes on top of the linux-next, also please consider to add CCI and
CAMSS device tree nodes into the msm8953.dtsi file.

--
Best wishes,
Vladimir

