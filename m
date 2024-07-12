Return-Path: <linux-kernel+bounces-250493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA5692F879
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346A22838D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0614F109;
	Fri, 12 Jul 2024 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abOh2T+A"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A3C14600B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778091; cv=none; b=DDtzXfttyzQpohlMa39BkC3NmTog1PudEjH1L5OAYA+brHoU82gDHITbGYWNRZd18qAgXiatEqQTlXBOlkV0Alc4tJanVmYjzNM24VxPqq2bZLX1irfZEEJTtVBmbv1rIM5o4L3rc7reqb0vNuakH8QY9y95q/MtNJT38GiJkuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778091; c=relaxed/simple;
	bh=0EHyVYUm+nhOIMyjF0qXrLcKScZWSXFE3KlYuk5bhag=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dLqsZvjnyjVP12rfMSzFmaW5iswzgfEqR5UsisbPsAPrORLQppCB51e6uNpbLVG0tc0xmUVgsOAhYQ8tAb2ItN36ktKeKf49jg4/Fua71mmZjDSgg+30W6jCWRKuNi04J1QUH9dLCkq1hnmlEQty2+YszvXQQ2WUV0Nn2nkB6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abOh2T+A; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-59a47d5c22aso136812a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720778088; x=1721382888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pFarToQcBAfs6/zZ3KxBjQqvHfbYLRHa6Rvj0qeALC8=;
        b=abOh2T+AyxwvdZwl8sykbeEIh81eCN5aYImMrh7J34cBZ9uxG9mFlDU19sdVXqczRy
         1WtD9Ls2HhmE/+9sUg1ux2d3bl9lwFLvxjGh9JZBPjOTCU3qFMZwgNubG2XFc/lJnqX5
         EfD73p3jlDVDV2/SMT2lwvxrv6yQphWC/xbpxd6AUPcDjELcocOOj+YLjfEf603b7lQm
         87wgefVutb7oqHJUpSvKHVfpMTv0IlZSVxYGDWKMg8YxlRRNI+lWuE3DketG493YECow
         icLHoMAemr9tJvN7RQcPDgMwHH0Kj73qsdsUKTqOS8j4dAOFco6jRBNRr+1NAqrnuSHc
         7R0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778088; x=1721382888;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFarToQcBAfs6/zZ3KxBjQqvHfbYLRHa6Rvj0qeALC8=;
        b=B+eTKkAp1mI17rhIb2PLF2EYEYJpYmlNGp7drQYi+rFJ+SpXLHitW4scnGgwySrBuI
         Yjh8n/5LvegpMe9gW/yMh14qBKHtzFaWABHU6mqtd5Sew2cIjzDSoJzygMz07U1P5jYj
         IftNQQ6e9/yfxyV/4GVEmgj/8dRNX8mEOAmU0KW5Ijg7dJHSMsvA1iMeZpkjaDHiiZD0
         kCE13+3kgjE1i20h9NfutBA+KJ5WcR1cG94D5gCGhLkvqPTVmntun3w0CDbj+0rYgv/B
         ItGtLas0/VVcDDjET25XAPQISC4tGpO57Gf1PbE/uoimKT648wW+e0PRtUB585r6WSEP
         NknA==
X-Forwarded-Encrypted: i=1; AJvYcCXb9wuwQOZQfbWXpfid+X0Il8nVnYvJayP2kgmqNMQQWdCS6OKHyAD9+TN0FH6tX2sV5QO3sIRrr7hnz9swgHl4ezeIpmKPjZuWmQR8
X-Gm-Message-State: AOJu0Yz4ghBRkP98Oz7A/hYSgclUd0yjiZ+BgHCl1PgNUqN431uUNuXn
	CKc26uz5b6EIhYRKww7URXmVH+LMtd2a700A2YgACms03t9jFs3xoI/apmD54jSWDkD69RP5mlB
	l
X-Google-Smtp-Source: AGHT+IFe9k8flo1HTWUWxTj4wgCOcEsCxMxM2KjHvlE6NvwP3oNQDCf6EAaxugji8FXkF5AGVu/Tsw==
X-Received: by 2002:a05:6402:2794:b0:58d:ebf9:4e2b with SMTP id 4fb4d7f45d1cf-594ba98f46bmr7884764a12.2.1720778086737;
        Fri, 12 Jul 2024 02:54:46 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bc4e81a6sm4369823a12.49.2024.07.12.02.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 02:54:46 -0700 (PDT)
Message-ID: <512601f7-0299-487b-ba7d-7941cf1f0151@linaro.org>
Date: Fri, 12 Jul 2024 11:54:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/clocksource/qcom: Add missing iounmap() on
 errors in msm_dt_timer_init() function.
From: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Ankit Agrawal <agrawal.ag.ankit@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240712082747.GA182658@bnew-VirtualBox>
 <a6ae5f72-76e2-4c80-8039-b3bb07ce3a3d@linaro.org>
Content-Language: en-US
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <a6ae5f72-76e2-4c80-8039-b3bb07ce3a3d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.07.2024 11:51 AM, Konrad Dybcio wrote:
> On 12.07.2024 10:27 AM, Ankit Agrawal wrote:
>> Add the missing iounmap() when clock frequency fails to get read by the
>> of_property_read_u32() call, or if the call to msm_timer_init() fails.
>>
>> Signed-off-by: Ankit Agrawal <agrawal.ag.ankit@gmail.com>
>> ---
> 
> For your future submissions: run:
> 
> /scripts/checkpatch.pl -g $(git describe --abbrev=0)..
> 
> to run some static checks, such as "title is rather long"
> 
> 
> ..but I don't mind!
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Also:

Fixes: 6e3321631ac2 ("ARM: msm: Add DT support to msm_timer")

Konrad

