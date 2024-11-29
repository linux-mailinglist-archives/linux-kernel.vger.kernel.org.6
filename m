Return-Path: <linux-kernel+bounces-425554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718D9DE6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF6B214F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B81F19D8AC;
	Fri, 29 Nov 2024 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnB2YvSH"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0E19A298
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 12:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732884302; cv=none; b=fNFwATAFxRBc7p8Q3xQwrtxTDeROoUPsFGb/+JFTvj/40QlG8eqyI1qVRcqiBrN+6nQ9f8TJNkbIgm+Ad6dD+361Ju7Av7Ophqbe9lmiXhJdlCyKS0qi7CMb+FTvqmbbluBOy8SmKr10fZm5HwqHf6GFKFGt7BiiAqIRLOzrBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732884302; c=relaxed/simple;
	bh=hXRUVhUT7iuGMisSY5rTdmBe8+DVRRxrX/qutu0JmK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsKSeANMtPmQT61pnIg89lE5Ypc6JspKTl2PVHnme+uEkDkqglVPcrZED872LdQitS+HXc1WqAlMRCoppyb37tt+alJONHv79YmW/+91if24ZSiClg6kM89++67IWJ7y2v7EyRdQ8oYSIZV1UiwiYI5SxU3btwTpDwwQxKKBxyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gnB2YvSH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-432d86a3085so16106645e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732884299; x=1733489099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQHk4xgLP7Q9dv0sn0Vlg4Z+LAw3QiV2tT0lht9dhq0=;
        b=gnB2YvSHqs5NuhNCJFfrIE33ZtjCu0v0wGGgHDSG5830G8YO4/wQ4pnRs0sUBgsdiP
         xHREIc3bEjMV7e4iTWJWgmZrAH54xtsgq4vS9g5lX4gjXxqwvDy0O/OaACkW2RMIE5Bj
         b4D04at/TVctTPDyyV6ci4EZAp+bTAHh/X+se3s0oluZdxMUw0uXXBav57unG52gjHYf
         YxCb9w4u6ZvJKAJCU9qkbB9fRQoIySFBl5Ce7a44ahAmeGCWNyTP1+ToIRSGKeTVxVcU
         u06bRv20nnA5p12wv88FelhbuVhmRyOymBv78VatviURCzJPl14CXh/GvI4GW2YlJhwQ
         206A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732884299; x=1733489099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQHk4xgLP7Q9dv0sn0Vlg4Z+LAw3QiV2tT0lht9dhq0=;
        b=AUebVzEAH2hQJpESPCDQFeroiX6YUim3Nz2fGMyiyuTc6vz6Xgn1ulhy0h01khk7bq
         mXgBI64wgfODCa/Fp0y0Bo8Y2fzLa1qpKOlTA+IFXd/Opx0nBEEQAEKIrWrZTC/uTHju
         VqqiBII9rTKJCowHff3avgoAgwHzznzQBpwDbqCqYYiGe1eDR26N0qHqVo4EgPVUOtXc
         zCj0pQwYPcQiI8oQYMbb4A2cKP7O/pqKY8i2kWTZ5QM4+kjhbR5O+cTgTLetyUP4pww6
         b68xMs07IZrjRveq1DrBr1pRtzoTIsV4VjkCLNrxxlnOEo2geHvwOJOWy5JFSQcF5Jvz
         VLWg==
X-Forwarded-Encrypted: i=1; AJvYcCWt32RTVivEmzv6Jz4mNn8aOMMU/7gX5cSgN7X7cWDKNgHXTu5UTzgtYzDMx3c2ZYWZaBBFiRY6rTsgxzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4ymoxms0SUryNezYrxe7FsVfmoHBbY2mizgj0VWJBlgRzuX5F
	pxURn3blCAqSWw/5PgEGNSbHmlm9e7sKIyZNxBqn3MiFNWaWbW6ajccYSXHlwE4=
X-Gm-Gg: ASbGncvRJbM1njFwiG5on7L7b4mlVuELfb7gADQ7ngFIOwyiAwmLh0l0hzqYLnJ6dNl
	msYKbsOGyRSAvp7R4boN41eFxqYf4oTbY4wiae/uoJsh5jhpUMPGKudm4SjDOl65LBTv2EPs+GX
	waGnErZ7vCRcB96k/ZmMB+grMLPmDyx+1aHrWz/45nvCKLoeI5dWMbMIb4IYgLm6D48Aq/70rMY
	EDRyvi1E8r8yuN24ylQZwf5ukYzhIyiqLzNZuRZM1zcj/v0Jr4ZBAbtkhv7kks=
X-Google-Smtp-Source: AGHT+IF0w0Sal9lG2xneo79Z25errSE6iSLsCaFoKNGbaicJd22m1cUtOXxgp/Ku8MPgnlofoaablA==
X-Received: by 2002:a7b:ca55:0:b0:434:a1e7:27da with SMTP id 5b1f17b1804b1-434a9de8d23mr93783805e9.25.1732884299110;
        Fri, 29 Nov 2024 04:44:59 -0800 (PST)
Received: from [192.168.0.31] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68958sm4332449f8f.67.2024.11.29.04.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 04:44:58 -0800 (PST)
Message-ID: <52e3d25f-d142-4efd-b41e-e9b93acec529@linaro.org>
Date: Fri, 29 Nov 2024 12:44:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] clk: qcom: common: Add support for power-domain
 attachment
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-0-ca2826c46814@linaro.org>
 <20241128-b4-linux-next-24-11-18-clock-multiple-power-domains-v5-2-ca2826c46814@linaro.org>
 <9b9bf718-b5a5-4fef-810a-1206743495f6@linaro.org>
 <7cf4ce25-742c-48ff-99e0-bbbaea370e89@linaro.org>
 <4310164e-4000-4cff-a093-7986f71fc02a@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <4310164e-4000-4cff-a093-7986f71fc02a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/11/2024 11:44, Vladimir Zapolskiy wrote:
> On 11/29/24 13:39, Bryan O'Donoghue wrote:
>> On 29/11/2024 11:30, Vladimir Zapolskiy wrote:
>>>> +    ret = devm_pm_domain_attach_list(dev, &pd_data, &cc->pd_list);
>>>
>>> Please make a call to the function like this:
>>>
>>>       ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
>>
>> Passing &pd_data will cause devm_pd_domain_attach_list() to cycle
>> through the power-domains listed and do dev_pm_domain_attach_by_id();
> 
> Doesn't it cycle for pd_data.num_pd_names times? Which is zero.
> 
>> instead of dv_pm_domain_attach_by_name();
>>
>> That's what &pd_data is passed here. You want to have that simple
>> attachment of the power-domain list.
> 
> I look at dev_pm_domain_attach_list() function with my best efforts
> to concentrate and see no functional difference between your version
> and the one proposed by me since v1.
> 
> -- 
> Best wishes,
> Vladimir

You're right.

I tested again, NULL works. I'll v6.

---
bod

