Return-Path: <linux-kernel+bounces-176042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A31308C2936
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53614287048
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8661118E25;
	Fri, 10 May 2024 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmIe+DRu"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53117BA2
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361961; cv=none; b=qe9IwJufkcRPe2Km7ohGeFD8NbLxSdbrT2Ncn0jUsw73IBOAOhr/TIMVx7yAMp8ouSEp6UubIzBEUrbQ14Gj0sGuyKGKRI4WiuklcVHiNObsr05OmOPiQCtKLRh7Xp63BuQxsYl1vBKydeu+9Dahv2Rw7v5SbBvgndPEkS/odwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361961; c=relaxed/simple;
	bh=wZeYjtuwgYcICc8dB0xr2MD2edWcT8RMosk9Qo1UWOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PFekCWyD04p+43LfqkV7cQXuA3CAVmiz3JeXCflTDBYJYWOkmJzO9lnl5kjsvjqtKKTmDp4NQKgU4X8WoBJ/n/0SQRFW0uEJ1mdwyGKxGeichu02Whcmz1SK+IpUyxG+zRqa4paTf7jixXecjk45lHqDbn1YRn8yD+Ad5SbgXeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmIe+DRu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59b81d087aso582803666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715361957; x=1715966757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vdPSQiADLpJdWcJT86VUdEp+yfjE3R3oqb+jGkEgXsM=;
        b=GmIe+DRu4ru1EoIN3MRqXHrp5CTF2hxeZSjwEF3Ec0jY/tz7dnpA9JiYyKB59vYC1l
         Z9mBmJux58Xsbt3azTHOFPRvPZy6e011qicckYl4F4ZtfdRTGAGZ9wafQ2wUTZWf5T3A
         4qcSuDbEDhNh5KDGIaOSDu2QxINFTC9GU+TGYRoEVT+25p9g2NSKW7/ES5twe5aDtSVx
         r6n63pQ6I6vX/QEr4Rjt6Qa+r6YBxh95VS0SyCT3cROoRUGJfPpDMYqCfhB08UKALQIT
         7sAmAo1eVp7ZFhNDMAESJ8bD017ZSYrglMmKUXeDKYvATF5MS7Fz9WAEV6UdyV1I+YUk
         wGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715361957; x=1715966757;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdPSQiADLpJdWcJT86VUdEp+yfjE3R3oqb+jGkEgXsM=;
        b=OLXF/Azv0XDZEngAfbLkLB5bs4MT7EZZIbeTTHTA0Clj4ftLc/ldSTQVFItZPmsj2d
         5rVyRAfzErSZGQ2GmeW9Sbv9G2s/dxGkBLZbUC+kjyODbkhGMzb2no4jkWBMLzvg/9L+
         LOtX66d6DdJ417IPt4gdKpQAU5APX1LBqiv/sCAisfAmdCOPyRqwP/J8mAYNRdK51AR5
         79rBeBp2ScPTL5dMYCFwvmxJGoWqbJ3sPINp4hqQHkabuM+PTMn1L2Gnoj5/3FSTxJKM
         Ar5toFGRp37cHY3fd1xlAgnJTIP9JEe3CGQnuElE+Db7KP0EloNydgDax7Y+SduQjPNO
         I84g==
X-Forwarded-Encrypted: i=1; AJvYcCWsAY9Hhso9hJ7tW08GaIzl3RQ1ZRhCKIdS5/2vSk23vEdtJFFhv2g2DhzRtaGeZIEN8b6qInc56YVkIvLPtcKwFA+vr4IBGSCJEH2K
X-Gm-Message-State: AOJu0YxLRHaPSix9u310Qk8eH8k6h5Sujxu8uHv32rAwqZQ/srzAQIao
	gZRnR0XUVMLQpNOdRH7AnuIobfbZn9mFXz+X6xM/hbx5y0IV1rltzNX6oBYsLw0=
X-Google-Smtp-Source: AGHT+IFkrvmT40I3UyyspYoDEueQs0vfUcWLdpzdlVYfte422rI1yyUSBBpLttzzaekTIzz4I0Wfag==
X-Received: by 2002:a50:ab0c:0:b0:572:459f:c7ab with SMTP id 4fb4d7f45d1cf-5734d6f004bmr3078565a12.28.1715361957294;
        Fri, 10 May 2024 10:25:57 -0700 (PDT)
Received: from [192.168.62.15] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb83sm2028668a12.46.2024.05.10.10.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 10:25:56 -0700 (PDT)
Message-ID: <7ea1f4d7-ddb9-43a1-91c0-477dfde87da1@linaro.org>
Date: Fri, 10 May 2024 19:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: apss-ipq-pll: remove 'config_ctl_hi_val' from
 Stromer pll configs
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, Varadarajan Narayanan
 <quic_varada@quicinc.com>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
References: <20240509-stromer-config-ctl-v1-1-6034e17b28d5@gmail.com>
 <baa81202-f129-4ec2-baca-6ca8b476a37d@linaro.org>
 <21cedacd-f454-4eb8-9b2b-33a14592a6c1@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <21cedacd-f454-4eb8-9b2b-33a14592a6c1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.05.2024 6:25 PM, Kathiravan Thirumoorthy wrote:
> 
> 
> On 5/10/2024 12:23 AM, Konrad Dybcio wrote:
>> On 9.05.2024 10:08 AM, Gabor Juhos wrote:
>>> Since the CONFIG_CTL register is only 32 bits wide in the Stromer
>>> and Stromer Plus PLLs , the 'config_ctl_hi_val' values from the
>>> IPQ5018 and IPQ5332 configurations are not used so remove those.
>>>
>>> No functional changes.
>>>
>>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
>>> ---
>>
>> Hm, it sounds suspicious that we'd have these settings then.. Could somebody from
>> QC please confirm that everything's alright here?
> 
> 
> I checked the HW doc and yes in both IPQ5018 and IPQ5332 CONFIG_CTL_U register is not implemented. I see offset of CONFIG_CTL_U register is removed in the change[1] by Gabor.

Thanks

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

