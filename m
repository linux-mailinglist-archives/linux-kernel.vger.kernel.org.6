Return-Path: <linux-kernel+bounces-239640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE9B926371
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9A91F23D74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E51EB27;
	Wed,  3 Jul 2024 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OME98eeL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8A018C08
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720017013; cv=none; b=E7Ye0L9MACvbEg5aFlXLGsSVVjwnQcwq4SwJr5y6Sns6o3abbaohLfrhr8GPxZsZOm9u+0k2hOW38GZb5xr6YUTFGuDlnJDqw+UtBCUzt+zNVOOM5DAhvbAy0o03d8B9WxYah9PdWDZYX0O5n+oLoX8ITFq6kYm7hWWuDDYAPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720017013; c=relaxed/simple;
	bh=703hhRSpknmH8TbKJyDrP7eger1IOJLJ7Yp6gEEIU5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhB55KNXLybuotXsRfRSuYY7hkrAB7Akb+W0R4JrISiSLkHSWWOteGAblDntgx+bCmi+TLiAa3ozzGTaU4RBBBUkK3PDEw/BnI2Z2CJXteN4a8fSwY2mYPXRSDysMR7q6dfyd9fnoYUB3Mrf2fWqMevb/DVY/xa0d+NNkUFutcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OME98eeL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-361785bfa71so3773609f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720017011; x=1720621811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uMdQw5W+def7pihp9EhrnCgDBaY8Iz8fouuXaSiQ08=;
        b=OME98eeLhuWzT/j9kMrnOj2s71aM9YvTM3YlSVGVokKT8ss6JAAzCaJyJyX0ADTU+a
         cn3Rcir7LQfU/I3xiKj7GJNNzX+4w9yyouK7ZCGUFa9cZMTKSmz9l3zfEbubv9WzTAxP
         sRjym+eQ5SbCWBATdDTYXoSeKnJJclg8ckTxj+3B660VK8F4HSBl/EA637IMnoZFQhZN
         PdTBd2ioRpJH0jCpljp+egCvtnK3zcimEThyx/MHU5ypV9BPRXLsUqKEoO+nokqUnTD8
         XkQTPZaHkNZuYR58EoMYPY39urwT+snt+/0BsS8Y82OZA8HdfFMHs17/IXESRvS+Qcw7
         KjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720017011; x=1720621811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uMdQw5W+def7pihp9EhrnCgDBaY8Iz8fouuXaSiQ08=;
        b=WUAiHVzF4zBB8BSRf3Rz6U9WH55lBVQfqhmuiAuxSduqRHVQT09PnHd6esxsKkITZo
         in3lPscTkyPqrpW1dMvwMJx3rFw6MD0N22X6Mt0CixT2JiYsi8E+DqhHby+L6jmRxEaX
         oBDOiPTKkEPaPutIJ+7ewKoXXmSRVv03BOl+4NAA0tpML3iZq5a9E9ACDSBWkn/+zWcW
         BNNtU72HONlwTPf1B3EX2U66h4TMY0fNlZQKvp5iCGcTAk3ROJ+8U+WnBgU9ECHmIHgC
         XjaIvltwHSYokPcV6zqliB2vbKAs0Syf2cGzgmTcraVBGOaKrinsP8JaOBXEXclfqOZG
         C/Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXJKys3u4EZk/cewXiYqnul4D0ic/io6/1Y3MVj2IOfQbE8tWDjvsMuPNoPA1NJFX25nJd3w5dITtwiDUJ0wkHPOGQT6BeLJsaBZmtQ
X-Gm-Message-State: AOJu0YwRHsxAtAEd69SPYXl5z3ThvawhU1eteaN1BpDevoTLlEFqjIUV
	Wf3oY5zOKEaPItXwZzS9YCPW7nqZn8atWQmvvwX0A7jtm6HXaCsd9Wrqr5zkvIg=
X-Google-Smtp-Source: AGHT+IFMA3j+9ZoVQ1XUOszmpt90crPyACidhPK2ftUVLUgtC81roKmr7IVwuI6zp4tDlyFz7yqSlw==
X-Received: by 2002:a5d:6d83:0:b0:367:89e7:72a2 with SMTP id ffacd0b85a97d-36789e773b2mr3889568f8f.22.1720017010701;
        Wed, 03 Jul 2024 07:30:10 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc4c9sm16033873f8f.86.2024.07.03.07.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:30:10 -0700 (PDT)
Message-ID: <49b2504f-e5ab-4ea9-aefb-bc9c7f71f5fc@linaro.org>
Date: Wed, 3 Jul 2024 15:30:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure to stop CAMSS stream (sc8280xp)
To: Johan Hovold <johan@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZoVNHOTI0PKMNt4_@hovoldconsulting.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ZoVNHOTI0PKMNt4_@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 14:07, Johan Hovold wrote:
> Is this a known issue with CAMSS or is something missing in the sc8280xp
> integration?

A known issue on my end, I also want to root cause intermittent sensor 
startup failure, before switching on the sensor upstream for more common 
use.


> I'm using the following (squashed) devicetree patch from Bryan to enable
> the camera (everything else is upstream):
> 
> 	https://github.com/jhovold/linux/commit/85b41b8d0efd418509df548592f95b43b9663409
> 
> The issue was there with 6.9 as well so it's not a (recent) regression.
> 
> Probing the camera sometimes, but infrequently, also fails with:
> 
> 	qcom-camss ac5a000.camss: Failed to power up pipeline: -13

Yes this. If you recall on the pm8010 I had mentioned to you about a 
wait-time to startup the regulator - thinking it was the regulator 
causing this error.

More likely the GPIO reset polarity or delay needs to be tweaked in the 
sensor driver.

> and I'm seeing the following warning on every boot:
> 
> 	i2c-qcom-cci ac4c000.cci: Found 19200000 cci clk rate while 37500000 was expected

That's hanging around for quite a long time 19.2 MHz is a perfectly 
valid clock, useless error message.

---
bod

