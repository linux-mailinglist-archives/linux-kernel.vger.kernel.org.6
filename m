Return-Path: <linux-kernel+bounces-204100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253658FE422
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA55284C54
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B78194AFB;
	Thu,  6 Jun 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQjMXnYB"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B213AD25
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669198; cv=none; b=jsoTzxpe1E+GiLvVk1hWON7YqwONzG2OoA1tdNXwuKGpVrHHXPlKLWt3zFOYo/0FN4LrUliplwPEEzmUKkfny7mCDsqYtrRPA+bUHvS4ms0lVN7ovmv66YbLfctfFgJOK0eowkB6b2sO0d6IP2alhcIfIjqKH4BEjY3+zFFCvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669198; c=relaxed/simple;
	bh=7yqMPDznDpiL8lFjlVKRzVx4cLN7+U9oThj80jIYSNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=shsEopEn9g5DA4BeneZ0Z2bQCAdGAGmIkFt8G7DuGhViYKRAbbdsH5myww8xNu6QMCY2t+oGANdWYXVQmJqhVwk/WIQ2HifhiNwppPYZqtGLF1oXeYBn4yIN6nAYSut1itx26d4IflF2HuZFdXD1v2LEE3KQha3yUBnJ/RLfPRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQjMXnYB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a9a3bc085so992821a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717669195; x=1718273995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=E8YvX5EI2wc0H9n00qpTISjx1bC/h/DMfbIUgT6XEF4=;
        b=AQjMXnYBBCslhQrlYl3CttZri64Z9beGzp0+EdnIJOdMpRg8rTJUfDZJRwJirtVDSm
         fnnutAHJgEX247fHr6sKXojXcQoipkO1qjUEGZS/U+nCVp0JlF4oPjt0ahbNueNpvOtT
         niqlUYGd0q/Q4OmNIbvy/BjkWuWMpgUqQ5BvDj5Zdj1ZTqcLbo/fdpOtDUQjEjNcAvwd
         vr6lQqNlnlgBtZdLgYpMOsPucUrMrKWQgl1QjDSBA22ENc6B6xzpanQOtLKS/U7JTR4m
         nArs1IYuWu2Hr2wI/6jv2Tf32LZpy53xFnbbY2lZFbzlJg3jSrjZCQ7fSiM9mYjQhesP
         zpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717669195; x=1718273995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8YvX5EI2wc0H9n00qpTISjx1bC/h/DMfbIUgT6XEF4=;
        b=f8OJZmFINJDWuC4A/6QJbIqiwur/2oojBjs5UWoKK9P0cy7YCb98L9V11fzw0X/hgz
         5B5SRlF6QeupOwuhEP/b2X81McyfJBfjU6nBZBpdW9oQo0mSzxeWDTsuIpKwSxCxrr4c
         /xc7zdw0BjiSNUCqmjQHmcFQLgQ2IbWc2dsGzyg/L6/TgWPL3FEVdHAkVNNxtz62eOfG
         RLyH/cMRQa2trmvvHN94GBUahFJFOkFbGuamsxyW9Ih7Hb+9jy+nN9E1P7TuLcCQR0bW
         VtSI8j+PdmBJPhs6F7iiooK2DT2xAF9eqOgcA40VkaBYHaI3aigXPC6bfbZ4X6gTcaJ0
         5bhw==
X-Forwarded-Encrypted: i=1; AJvYcCUhRZC8rnVdpGTMKUZIK3DX6t7MwOQ5JyLtAgOaIdkfJiKql23nVsZviIN8v9D5Oy7XMJMvoA5UWx8sM9v95NaW+h5+5ZeNz0j27rkB
X-Gm-Message-State: AOJu0YwH0Yldmq9Z2d7nSRMDW/p9wcD6naP9YGCi2yU/OQcuiJhFEmiu
	74gFML6e7P6u+79QDP7Dt9Fqzzd6S7ACSySt5zmwbovl1mPq8iho+fkoNU2jwds=
X-Google-Smtp-Source: AGHT+IHao8vmS6CZL0mQeT34/mVfNEuj/p3dkCIEcmi8ED80pkR46tyldJVzFPLm+SVZjSujPLjgVg==
X-Received: by 2002:a50:8a88:0:b0:579:f1a3:664f with SMTP id 4fb4d7f45d1cf-57a8bc907cemr3690433a12.30.1717669195343;
        Thu, 06 Jun 2024 03:19:55 -0700 (PDT)
Received: from [192.168.128.139] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae10826asm846075a12.47.2024.06.06.03.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 03:19:55 -0700 (PDT)
Message-ID: <be986ed2-6fbe-406b-ac1a-12a254bb37d8@linaro.org>
Date: Thu, 6 Jun 2024 12:19:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 4/4] arm64: dts: qcom: sm8450-sony-xperia: correct
 touchscreen interrupt flags
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240605160032.150587-1-krzysztof.kozlowski@linaro.org>
 <20240605160032.150587-4-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240605160032.150587-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5.06.2024 6:00 PM, Krzysztof Kozlowski wrote:
> Interrupt flags 0x2008 looks like some downstream copy-paste, because
> generic GPIOLIB code, used by Qualcomm pin controller drivers, ignores
> flags outside of IRQ_TYPE_SENSE_MASK.  Probably the intention was to
> pass just 0x8, so IRQ_TYPE_LEVEL_LOW.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

I only tested on one 8450 device, but they're all:
- the same tlmm
- the same geni
- the same touchscreen

so I suppose it's alright

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # SM8450 PDX223

Konrad

