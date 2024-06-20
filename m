Return-Path: <linux-kernel+bounces-222469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C76FE9101EF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78475283726
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2FF1AB37A;
	Thu, 20 Jun 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gACcXxg7"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA554720
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880493; cv=none; b=FMAKH6xQ0WIUB/BkLwqxW/UL9JV2S3QCOcbwNo+9SVDn50NB9sMauFYmjGbNM+ysrJZdTJmbzEZtVcvcvib1lJmFSoUpEoFtryafYUl2Y/GX6pNs+N/hpGH81vfMIex5vSl0M3vXiwFb3xdlJCARrUN+WU1KXOGhaDgLaUzdtZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880493; c=relaxed/simple;
	bh=WnwzDhWU2vuMNlVusbhTuup82VlccFT1cDbMuKQqgW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYlaHVKFcKPF8x8igAgzjXDNjyKCc3rtX20CrjDGEOqMgfe+15apeL27+mvaCHNsxI9mRiemJRMYvzp2eyZ9KteI0RzlehZPOvG21KtynJEsZHng7c8IA3Tf4yxFYbV1/Pf+4RQ6l5YLLF0CBuLAEmZJvAKq0S0tGooR2elnVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gACcXxg7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so82821166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718880490; x=1719485290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssi3u2sUWLAUnYFmjTL2KX+Ig53JDnPKZSLWW0Sd3zg=;
        b=gACcXxg7bYYKRuCnaOrVmEAbslu7EHh+ndMYY1usUgMCYvWS12bt2BaxjuAYbt8sdz
         M/BImD1oef7vb/rNaazK4NWRM1oOZLapCmcs937u/iR+QULoyEBNupivRpLmu3tqQzYj
         6IajViKQvQyx5pyan28mZQrUztZ/vw3m9FoORow82iM5yzNjtqzAo67gKiSbwwMNzF1V
         mQQqbyND1M8OyPDrPowypWjIJU6niBr6RqwePaAjp9MjDKBy64uSQqqcXFBbP5RNMvkZ
         HP3s5cDdT+jlFtm+62+Y79NmbwEnGe/kfKg7S1E9YeYSNzMeViGrst0dK7eEewbhb6hg
         VWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880490; x=1719485290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssi3u2sUWLAUnYFmjTL2KX+Ig53JDnPKZSLWW0Sd3zg=;
        b=KXEc9WW6FCLOG5LJik2pCG9WIyK3OUZe+XD8yE8gfjENr0BGlnw3cjQ/N7z8UFzOro
         ON5Wre12oF8SXx16Fgd/0p0CqoeDXxZK9dvoDPGHd36uNM8fhtV/o0Cer7wzESReGvdf
         PcYlg7qGGWNNB+quFwgLCYQ6OMhk+Gwikzfj7aEdR6uY5pQGr3HKj4WQRbp/X40sMg7s
         QlWt8nI701f72UN9iJf3/NRi8sWDJRQI7iW0/1KpZnJQi3IzvngUALgkamMzDTpPl6rv
         f76ernvsUFL4PNe9cuVyGsCHah36FDcWBALkleZ3aOs7Sxy2peVplO6Kyw7orpOei5+9
         gKjw==
X-Gm-Message-State: AOJu0YzkNva/CH2GOVs40VG80o1EljU645HT3Hd2qrpz1WoDni/Xd1AZ
	hzNsOW9IcmmwnNioUZtrn0WspMjE64tr2tYoicrfXfStQix8Y2MlDH9ry358aXY=
X-Google-Smtp-Source: AGHT+IEfCXv2Nqgqup0/L5GJOy515Z9CxKRQ0kVK99cSNe8qdURehmaOtNg9bR51juUSUN9B19qLlQ==
X-Received: by 2002:a17:906:b88d:b0:a68:379d:d623 with SMTP id a640c23a62f3a-a6fab648910mr248443966b.36.1718880489903;
        Thu, 20 Jun 2024 03:48:09 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:107a:8a0:b540:2c8? ([2a00:f41:9028:9df3:107a:8a0:b540:2c8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f9c86esm753096966b.219.2024.06.20.03.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:48:09 -0700 (PDT)
Message-ID: <e84c3ab5-4064-425f-8c04-1d49f0425234@linaro.org>
Date: Thu, 20 Jun 2024 12:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Add tracepoints in
 bwmon_intr_thread
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_rgottimu@quicinc.com
References: <20240619135140.3581119-1-quic_kshivnan@quicinc.com>
 <a30fb728-d832-4309-8415-a28fed301e27@linaro.org>
 <461966ee-11ce-45e7-8ea8-abbb71431458@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <461966ee-11ce-45e7-8ea8-abbb71431458@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/20/24 10:55, Shivnandan Kumar wrote:
> 
> 
> On 6/20/2024 12:46 AM, Konrad Dybcio wrote:
>>
>>
>> On 6/19/24 15:51, Shivnandan Kumar wrote:
>>> Add tracepoint for tracing the measured traffic in kbps,
>>> up_kbps and down_kbps in bwmon. This information is valuable
>>> for understanding what bwmon hw measures at the system cache
>>> level and at the DDR level which is helpful in debugging
>>> bwmon behavior.
>>>
>>> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
>>> ---
>>>   MAINTAINERS                        |  1 +
>>>   drivers/soc/qcom/icc-bwmon.c       |  7 +++--
>>>   drivers/soc/qcom/trace_icc-bwmon.h | 49 ++++++++++++++++++++++++++++++
>>>   3 files changed, 55 insertions(+), 2 deletions(-)
>>>   create mode 100644 drivers/soc/qcom/trace_icc-bwmon.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 242fc612fbc5..1b410c0183bb 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -18573,6 +18573,7 @@ M:    Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>   L:    linux-arm-msm@vger.kernel.org
>>>   S:    Maintained
>>>   F: Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>>> +F:    drivers/soc/qcom/trace_icc-bwmon.h
>>>   F:    drivers/soc/qcom/icc-bwmon.c
>>>
>>>   QUALCOMM IOMMU
>>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>>> index fb323b3364db..9b5ac1e62673 100644
>>> --- a/drivers/soc/qcom/icc-bwmon.c
>>> +++ b/drivers/soc/qcom/icc-bwmon.c
>>> @@ -17,6 +17,8 @@
>>>   #include <linux/pm_opp.h>
>>>   #include <linux/regmap.h>
>>>   #include <linux/sizes.h>
>>> +#define CREATE_TRACE_POINTS
>>> +#include "trace_icc-bwmon.h"
>>>
>>>   /*
>>>    * The BWMON samples data throughput within 'sample_ms' time. With three
>>> @@ -645,9 +647,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
>>>       struct icc_bwmon *bwmon = dev_id;
>>>       unsigned int irq_enable = 0;
>>>       struct dev_pm_opp *opp, *target_opp;
>>> -    unsigned int bw_kbps, up_kbps, down_kbps;
>>> +    unsigned int bw_kbps, up_kbps, down_kbps, meas_kbps;
>>>
>>> -    bw_kbps = bwmon->target_kbps;
>>> +    meas_kbps = bw_kbps = bwmon->target_kbps;
>>>
>>>       target_opp = dev_pm_opp_find_bw_ceil(bwmon->dev, &bw_kbps, 0);
>>
>> This breaks bwmon, as dev_pm_opp_find_bw_ceil is now fed a random
>> (uninitialized variable) value
>>
> 
> Thank you for reviewing the patch.
> I didn't get it, still the variable "bw_kbps" is being initialized along with "meas_kbps". Which variable are you referring to as being fed to dev_pm_opp_find_bw_ceil  with an uninitialized value?

Oh this one's on me, I skipped over the middle assignment.. Sorry!

Konrad

