Return-Path: <linux-kernel+bounces-390431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D995E9B79C2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989D12810AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDE19AD94;
	Thu, 31 Oct 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuhWtM4M"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4AF149C53
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374524; cv=none; b=Ma1gHBtWwzZQEc8WW4PqKfhHH6h2a3JGKIxNA/MaR7cu074dIfbFTcgFYDEOEHA0IBUcbRL9qWFKyp/ZsSxEI09zXzXpi+GWE5lMnwjrzv/Y32xVYLpKN2bNmTeEqXKpHJYRWs0cSylyLTxfc7LBQDW0Wzy6j/KTkhcggXdg05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374524; c=relaxed/simple;
	bh=iQpKNxvIb05MpQm+y9atDzZmLOvTbkp1qlvo2yvur2A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WwvbER99BccQ0i1+xtDorx39FMPIT8X+4Hq+TiKM2wa5BRbSfTXP1OPLFJUgWfOCmohVUuLAoNWqPOlAjqJDp0N/uLK3Pb/mlFYPVllYS5LRqqJM6Hnd5kLUe1kBu2CmKiwyz+eWzbPAy23XP5jGT+vWfd6QM0vpjVd5JBJIVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RuhWtM4M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d570728ebso120277f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730374520; x=1730979320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oRUOTicU+bHDCCOkusRo0Ym1My1gU89AdDAdqUCKaU=;
        b=RuhWtM4MQ+6JT+gGq3QMhqlW1cciglvcSaXqceckw/JU+rdv0EV4F/KD2gt+ID/hfS
         i7gWLnWZofvKcdUeyZ3O9xbAjXG6wmFL35cL53B/jodtzAyDSPGsjPb8fmETf07wP7MB
         YOvioj8roppfUBvtuLCt2lsP2e80nGxyNuEGcFwXzjMaNDNvFHGGQ50nbi5cX+EmbEVC
         LgrPRPJqPIxAWrkzbmZL32uYpDVIupG/LkbkwzhJvuGcKXYcRx2yJEMETxqGxQLcKWe5
         RENQYWjvo+xW5yodJP+/kcQxLgU3HPVHNy8P86Ew9BRNoPxkR2wtiQs9bwuVQr3nNblZ
         mMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730374520; x=1730979320;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oRUOTicU+bHDCCOkusRo0Ym1My1gU89AdDAdqUCKaU=;
        b=W2Xgh9bZriGVkF+DVaHRbJ2kj83nLUm5ihg7e5ZP9ZU0nhgO2Zcirm7nNfMbjsgUkh
         Wb0X89gurHS41nnx3ur62fAAPCNPHkDdUhtQmJfjqmLDuwreWMYFonQ4uhDMDpQzKK90
         sILz13iwXc3m8BsOkxOfGkEryvvaXvz15DtuZjYWp4EfM31fct/BCLaKoqEcfXacF1Qj
         F4Cm6IQtwH5J8Elh1mkXTk3oubMd3cNFttOl/gIY+tvq6zfvCxebianaHus1TEKR7MdS
         67cZgEd7qYMM1Q4JNKY/9PfsZeyBawquD5b47gQiFQepceWfYq4Zb4AYLcHmHtseCzRY
         aSPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFbpYtpxPepOt6sTWJcj68ZdlLA+x5mTE/gX9EsBzv9lmjneIgrA8wharMh/5ts41kvOgmeeYsdOrYcjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaSw21D8mDSJbxJOHRx7sBNiLdv7fOoSJxKvzDaaUblbPkx4ca
	/9I5OVDZYEqfiyiVuezUYmfuYOcXaE/R/x7xy2yP0Mv2yTkE5xmJnI5iE8qVqFQ=
X-Google-Smtp-Source: AGHT+IE5oeYC3TyYTIVtGeqMzi9DBlOsLAWU0F4mADy0vxIex1yr/ftV9jZNdZ9z35z0wVUuKtmR+Q==
X-Received: by 2002:a5d:6c6d:0:b0:37d:47f6:6fda with SMTP id ffacd0b85a97d-3806117dde8mr6744778f8f.7.1730374519947;
        Thu, 31 Oct 2024 04:35:19 -0700 (PDT)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce59csm167540e87.149.2024.10.31.04.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 04:35:19 -0700 (PDT)
Message-ID: <2131e750-f5e9-43e8-816f-924516336fce@linaro.org>
Date: Thu, 31 Oct 2024 13:35:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] i2c: qcom-cci: Remove the unused variable
 cci_clk_rate
Content-Language: en-US
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: loic.poulain@linaro.org, rfoss@kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abaci Robot <abaci@linux.alibaba.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
References: <20241029020931.42311-1-jiapeng.chong@linux.alibaba.com>
 <rql2u5k3esavdmpdzgo4l4up4ir7yjpdzc3qlmsvjvqalqzvjc@xspprcohlout>
 <f06dea2e-893b-4de5-89a3-e25af56afb31@linaro.org>
In-Reply-To: <f06dea2e-893b-4de5-89a3-e25af56afb31@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/24 13:13, Vladimir Zapolskiy wrote:
> Hi Andi,
> 
> On 10/31/24 12:44, Andi Shyti wrote:
>> Hi Jiapeng,
>>
>> On Tue, Oct 29, 2024 at 10:09:31AM +0800, Jiapeng Chong wrote:
>>> Variable ret is not effectively used, so delete it.
>>>
>>> drivers/i2c/busses/i2c-qcom-cci.c:526:16: warning: variable ‘cci_clk_rate’ set but not used.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11532
>>> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
>>
>> thanks for your patch! Applied to i2c/i2c-host
>>
>> Thanks,
>> Andi
>>
> 
> FWIW I've noticed that my Reviewed-by tag was added to the accepted change,
> while it was the conditional one... Actually I don't know how to be aware
> of such nuances, if only b4 tool is used, likely there is no way for it.
> 
> Hopefully I'm not too picky with it.

If it still matters, this one apparently unnoticed candidate would
have been a better choice:

https://lore.kernel.org/linux-i2c/20241031095339.76535-1-jiapeng.chong@linux.alibaba.com

--
Best wishes,
Vladimir


