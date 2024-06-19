Return-Path: <linux-kernel+bounces-221701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F04590F761
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 22:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4389B1C21E72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005B915748B;
	Wed, 19 Jun 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4CO2fHx"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC34158A3F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827635; cv=none; b=FtzXcCHCYDau4xEu5yRKxDX1iD6S3qckMSX01/oF+lG5km0m856tv4nEhgjmvzQZayF1Jp/2Cx3GzM+U4aPAQ7/fkB5uAmmhgWoqgacYvLDbkl12vmTF1pBVfrMc4pS9knzCcl0sSONeWPddX8FmMGSZmTnATvSlSLIqUzYx46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827635; c=relaxed/simple;
	bh=/cGu5fDl/w12kc3ON5hDJfk7z/YiFPwjDsYd3Ws1/kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPicxudSWR/DZKrKbe81HKqJWDShAVCx8dcCBTr1vzU/kRbHvBhDmWS4OZ3xMhuLU4uJyo/MnmjN3BWV7QXfMfK4PhIuZX3VazfVQ8ngIj2rfemViMGE+1hvt5eD/FVga9NznTxp3Vgyt35ll6Xl9Vq06S3LN2xuaT8ru4R9TBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U4CO2fHx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so33955866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718827632; x=1719432432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXltk2pj8KgRtNfCGdnICNOGzFk5REHMQ6uROpqHKxw=;
        b=U4CO2fHxu7QH2aNZf36iTOyKdqoFDkeR+KKR/dSZr/rN6+G/+IIEB4PdrSQk6Yg+xY
         ZYg16uMCNUVyaWWJDuUnlhiXEs7QfF/MPKVYS30frzSofvR70vpPRl7JHaKn/H3SuTqm
         NNZQn87kt5zUCcPUi9IOoPtwuOQrQy9Ky5jkWZVv09Fw0P9aCPW5cNkTyDl01ht9AwhT
         I3LQU5r8fWjS2YVunKTaWzcn3j0h/Z7WUrEyIFC5QnCAyJVD23tTWvy5DHG2FHZO0GrN
         +3jHfCDjed8T5ewJBvTBMbD4ZdFMQUUNGITqHDCBOSCdSMBb9xQysgKmJ2jPXD7ZugyC
         lK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718827632; x=1719432432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXltk2pj8KgRtNfCGdnICNOGzFk5REHMQ6uROpqHKxw=;
        b=AxG7M5tzfQT+A3WMlx412v/UL9qWfMg80qPkVO4DxhyBSg8NPZq8yIWom1m8OzGKZX
         agE00Zrw7iPp3rLt6/a4GP+vILOLlK+xaJtk+CS/udlTfqa7TsgkIfeFLVGnuZCjJ4r5
         4dUcfxchcZ9AuvgfydY205IIDzJEFPadPiIZOKNvuw23Z+H/ijk/PoCHg3MMv446c13q
         XxVh7teygdQimyWUGo8wt5kfwoZoUFzkz1Jgw0DLlqPuVEIvGhMhciy06b97lazSSn52
         UChEbonX3nFrxPB5s0zlaa/OUuVORZAYpGYQ1QOXQ+CdAq4SjIXdDnlodDzCnE9oWGvy
         3HMg==
X-Forwarded-Encrypted: i=1; AJvYcCUBZAjdDIRBvp7PCc2kjF6slFVffSUTuaDIdnlEq+MVoCNYs3f9PnSkbI2hOpptVi8k3tUEGubuyxx6XhZHhr+BIZBDvDXnceUQCMZT
X-Gm-Message-State: AOJu0YzlzGz1o83Yknt1G2ot0C+YQmpDWVrUq/m7RRmuSXhgkJc8ebeq
	+VedjNQZ9Yhjy0kclPlab8F0fpLlysmqzylBowYS4KWSyMxShflZkCgV/pkdriM=
X-Google-Smtp-Source: AGHT+IGpVLdKvW9x1TLtFMIVprraYeiwC+PZrOrqrJwwmY5vpjguuk33olStWp+zoX41leRasvQbKg==
X-Received: by 2002:a17:907:c30d:b0:a6f:3612:160 with SMTP id a640c23a62f3a-a6fa410b16cmr254820066b.14.1718827631493;
        Wed, 19 Jun 2024 13:07:11 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4dba:9578:7545:6874? ([2a00:f41:9028:9df3:4dba:9578:7545:6874])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f99a09fe8sm144535566b.9.2024.06.19.13.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 13:07:10 -0700 (PDT)
Message-ID: <f40a24da-d201-4d57-b472-6c98c0e2deaa@linaro.org>
Date: Wed, 19 Jun 2024 22:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 8/9] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Robert Marko <robimarko@gmail.com>,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <20230217-topic-cpr3h-v14-8-9fd23241493d@linaro.org>
 <CAPDyKFrNprXpdQBEzezyOJg6NJ8LLarZQV_mnQn5QyCrNmsRUw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAPDyKFrNprXpdQBEzezyOJg6NJ8LLarZQV_mnQn5QyCrNmsRUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/6/23 12:23, Ulf Hansson wrote:
> On Mon, 28 Aug 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> This commit introduces a new driver, based on the one for cpr v1,
>> to enable support for the newer Qualcomm Core Power Reduction
>> hardware, known downstream as CPR3, CPR4 and CPRh, and support
>> for MSM8998 and SDM630 CPU power reduction.
>>
>> In these new versions of the hardware, support for various new
>> features was introduced, including voltage reduction for the GPU,
>> security hardening and a new way of controlling CPU DVFS,
>> consisting in internal communication between microcontrollers,
>> specifically the CPR-Hardened and the Operating State Manager.
>>
>> The CPR v3, v4 and CPRh are present in a broad range of SoCs,
>> from the mid-range to the high end ones including, but not limited
>> to, MSM8953/8996/8998, SDM630/636/660/845.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> [Konrad: rebase, apply review comments]
>> Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]

>> +
>> +static void cpr_pd_detach_dev(struct generic_pm_domain *domain,
>> +                             struct device *dev)
>> +{
>> +       struct cpr_thread *thread = container_of(domain, struct cpr_thread, pd);
>> +       struct cpr_drv *drv = thread->drv;
>> +
>> +       mutex_lock(&drv->lock);
>> +
>> +       dev_dbg(drv->dev, "detach callback for: %s\n", dev_name(dev));
>> +       thread->attached_cpu_dev = NULL;
>> +
>> +       mutex_unlock(&drv->lock);
> 
> Don't you need to do some additional cleanup here? Like calling
> dev_pm_opp_of_remove_table() for example?
> 

Ouch, right..

[...]

>> +
>> +       /* CPR-Hardened performance states are managed in firmware */
>> +       if (desc->cpr_type == CTRL_TYPE_CPRH)
>> +               thread->pd.set_performance_state = cprh_dummy_set_performance_state;
> 
> The dummy function above always returns 0, without actually doing
> anything. I am trying to understand the purpose of this.
> 
> Would you mind elaborating on this a bit?

It looks like this was put in place to overcome the

.. && genpd->set_performance_state)

check in of_genpd_add_provider_onecell() that gatekeeps calling
functions that parse OPP tables from DT

[...]

> Note that, this was mostly a drive-by-review, looking at the genpd
> provider specific parts. In general this looks good to me, other than
> the minor comments I had above.

No worries, every time I open this file, I end up fixing more and
more things..

Konrad

