Return-Path: <linux-kernel+bounces-186580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C66738CC5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B50B21520
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818E1459F7;
	Wed, 22 May 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WuWa1yPQ"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F9A46AF
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716400717; cv=none; b=c6FXq0AQP3blHbj+fRmY1yGtGDGNmE/TFye1wviIdANH8yM2zdALZhHiDw9FnIjA8tjzuFtfKe1DYUpcCOkXJErTxgc1J5c97VQP7y6Fo8oaBFxd6rz17gmr7IJEp4ZnDFoOegt3Mx2A8VTxpP7kGRJtxSkJh06TARaEDxGx6T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716400717; c=relaxed/simple;
	bh=KHtjUV6hq4+rlIaz3j9gjf64yGiJ3KvmjKV4jrwK75o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp5a3tm9gVm7PKQ03ccXWRMceYHdO0+99FiObXlD3/lZZWqN6VkVnzUS6aWDju84xneyUKPpJVwoWdmPF0xprEuMJqmjcgsfkJ+ku58JDoH7QS6gM0hfnqW3/N1J5BTa1t9udRHp8rexnEt72lNIZVN/moRG2CGZSHk8U6IC4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WuWa1yPQ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so9781935a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716400714; x=1717005514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDjgxjQNPkugOrLyZyXLah/SP6Onds09Ci82FsfoJ7s=;
        b=WuWa1yPQGcy+YQAiOiMriKhhJBxbAlBpcXmOaZftj0zVD/+DjNuoLvfoxhTuFL5lD1
         GW+Wa7vgg8jZqzeHpCrD75XFu83tSp21VquNCV2xrOC6qaGq6GbbZujBvak6lxMvQujQ
         5GN76CrhpTfEEjbB3N5A3yug5Ey4RKHPrAtpfIQrzahnAedX5bDFcalMBHsl0+fg0ib+
         v3uknsO8ZJjghw2RAAUz6Nqkligzdk3soZ7oQHc5U6I2dXKviIOY8MRD1YJLRlpBedT/
         T03+oO7ywYuVOOEMtBxThA35f2XcMwuJdYgqoeP834uT2R+GRQZ0o7RCTQ3uXCpdrvBk
         w14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400714; x=1717005514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDjgxjQNPkugOrLyZyXLah/SP6Onds09Ci82FsfoJ7s=;
        b=XSmrnrU08FjN96ul5EUVK4zTMnehrwl+s0clxVKzkDmy8PZG+xk3r1tgVmcPUvF8oH
         0maLnvEH4FiwwlTWzmsOAlKNL8pqyTnxnmp98bCukwGluUUEPlJQjEaoNGe9HMY9GieV
         QQOHmlWLnK0RR/WQj/dbIre1yjNTIm+J1OIrUJ7AA8XXTgCii9a9f6vIRNMTkTeDLkjF
         94+BRnLLy17f/Xk0zQcPKaBv1PnR9mIOz752BFxyayAkEX+ulTi7tWbquO1w9fTX4apx
         vTFtepRI5ghEbTtGVKxUh7lijEDTT/Zj/qWhPJBq/md2v0iSRlGhG8ksNJvEFKrRAXs9
         YXdA==
X-Forwarded-Encrypted: i=1; AJvYcCVIGxHIGQAwOusqIhZRbEYTGCXAGCZQWCPZjpgi6zv9Bbcozb3fuORa7+4FWqSMkKshzYP2WpT6Zw2w/fQ2sthq7oMSvl7a5jdgKKPB
X-Gm-Message-State: AOJu0Yy3EVJXRGg0ug9DDnjWRQGzTVi++OrzCl2qA2FMg7LBXeIb4VmI
	lCemLrM3QsQJgziSIdOGOwie0ooicA9BpTWI/DnH3xFTnQDhINwrk0MZXWpFgiE=
X-Google-Smtp-Source: AGHT+IHIXP+9W1GeGeDPzlPjLyeKLhorAeQkIesoa4XDvfytfPy0Ek37adgpCPH6xsZIk4Tj3obC4A==
X-Received: by 2002:a17:906:2c0f:b0:a5c:3072:5084 with SMTP id a640c23a62f3a-a62281635aemr183227366b.59.1716400713983;
        Wed, 22 May 2024 10:58:33 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c55:53ae:8e0f:24ed:3702:e958? ([2a00:f41:c55:53ae:8e0f:24ed:3702:e958])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b014f6sm1835623066b.145.2024.05.22.10.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 10:58:33 -0700 (PDT)
Message-ID: <b199a7bb-6d59-43b1-9a7e-000c661b00a5@linaro.org>
Date: Wed, 22 May 2024 19:58:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: pmic-arb: Pass the correct of_node to
 irq_domain_add_tree
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org
References: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
 <CAA8EJprgXSF=x834=PRXrHhh7VRyynbApnO-iFoE=cLYFzM6iQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprgXSF=x834=PRXrHhh7VRyynbApnO-iFoE=cLYFzM6iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/22/24 14:06, Dmitry Baryshkov wrote:
> On Wed, 22 May 2024 at 14:38, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>> Currently, irqchips for all of the subnodes (which represent a given
>> bus master) point to the parent wrapper node. This is no bueno, as
>> no interrupts arrive, ever (because nothing references that node).
>>
>> Fix that by passing a reference to the respective master's of_node.
>>
>> Worth noting, this is a NOP for devices with only a single master
>> described.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/spmi/spmi-pmic-arb.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>> index 791cdc160c51..46ea93f78dcd 100644
>> --- a/drivers/spmi/spmi-pmic-arb.c
>> +++ b/drivers/spmi/spmi-pmic-arb.c
>> @@ -1737,8 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>>
>>          dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
>>
>> -       bus->domain = irq_domain_add_tree(dev->of_node,
>> -                                         &pmic_arb_irq_domain_ops, bus);
>> +       bus->domain = irq_domain_add_tree(node, pmic_arb_irq_domain_ops, bus);
> 
> Shouldn't it be &pmic_arb_irq_domain_ops ?

Yes. Between testing and editing the patch to un-break the line I managed
to.. break the patch..

Konrad

