Return-Path: <linux-kernel+bounces-231057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8CA918593
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35FB51F270CC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9218C341;
	Wed, 26 Jun 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrj+d86Z"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEC18C329
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415134; cv=none; b=XoenLR7NRUgHeELGZcaUpL/YI7B8Xn29j20k5kKacG85vPZD5Qeg85EJxUnRkEYkmnRAu7uy8Pt46hT8lNMebFKzhcysTYN9O7D+bj/PkpjIF6NWVKJWRBQ0l7bVuwdNi30SRWG+LHS9qBDphAQuYrNiWkwEuxjX5fEJ172bM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415134; c=relaxed/simple;
	bh=b9k+mXfxl27EqM5YIofKt39pjaxTbsvGlDH1nq7O41o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcBZrWe9xh/hv18A1bZAY1B77PWG//kmjCNukLiYxbGtvJ6DLYb6X9kiMdUzCl8lKk+vw+CE/apN9gQINda6Mj6GQXeVNtnYqr+p4jL/XZJDRlivnzUBJJh8FxZD/SO9zb5+1RpWsx1dyWpqojURppvjO1fGWuAE+LJjV1MxluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hrj+d86Z; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6fe617966fso452237666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719415130; x=1720019930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWX6epKdcnes1BVALWYCRrndFt6MKcz2e4J8ahDY7Do=;
        b=hrj+d86Z+JHbH45J7HrkVIwFGsjTN/gjYLJ5WV+EzFzLFZNXgpVgY/slElE45QIFKs
         Ip8hL0IVnZ1xTeSAHVvQo5gJX/KJIuBwwUWszq8fDa5ey8Vxyl6Y19pIrCp9kOHDaaKh
         qRCQ9dNMgt5Vo9QF7648zQHjM3ZJHmkl+HRxyQFDxtrEOX6G32xjLDJi0Ah8fehBdZ6n
         4ryAAz4GxNPGpRME+nar1pFPq3qwBFaxIy2ujoJRFrDxsys6Z660aT3lQac5GH8ZUmPc
         kaVehfAdT457W4a4fRU7XP4vYTu0FgKiGNLUx7WSwRHx6DCNUenx10N2UHhZlTBTn+0S
         vaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719415130; x=1720019930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWX6epKdcnes1BVALWYCRrndFt6MKcz2e4J8ahDY7Do=;
        b=RJ/DtxbRp4E6Y/emVvC/CCDzoYzxzrr03MlRIJzFVxW42QoYjMGlOyir5jClTIA8SP
         k2v9vOU+icrlPTFox2s4AWmiw5E7+euaySqkpR+IT8SVPlx9BIqyxwXc/a0vZ1xG9aLG
         3/Yg+0Yk/K5cq70onWnVwkI0HPZ+KX5TjIxyNzw41aJdxEKHFxXYYZ7jyeJ1Iaw8O9OM
         OMFQu+rXGj1VLdogPy30MAm64GeJAZdmwEhxLDBDSs8EAv5unVqc8TG36roj3eokvvHj
         IlGktxgMVp33+/JRxYeciIJ6jmYQpQLNE+agH8G19SpPlwjbUtbHjX70ErqjSj2ORTId
         vj8A==
X-Forwarded-Encrypted: i=1; AJvYcCX0ssvPhXgaOFfOond+7i1IarXUQ1vWQylXCdCVcLpRWGrnI3DgXofRkMfzoD/Ba3iGoYe1IqAaevvOrTDXokhr76f/Pd/2d2b+Rrk+
X-Gm-Message-State: AOJu0Yxa5l/tIz7SZMyO/RMB/4S3YYeqeAysZYafHrbLpuFXJGdkO21M
	J4DBrythZto7UNF9pQ9fd2cnnBp6LdjwbUM82D7T0gEZo8QFmo+rmO/ls4cFUew=
X-Google-Smtp-Source: AGHT+IHVbJuwqet6BuccvsIB1H/YgQ7iwTU17brRzB9RNDp0i2d1W1e4iHsbU3BJglibyDfoq3N0tw==
X-Received: by 2002:a17:907:a80e:b0:a72:7e1e:62e6 with SMTP id a640c23a62f3a-a727e1e65cemr361086066b.63.1719415129850;
        Wed, 26 Jun 2024 08:18:49 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a727900d2f1sm161075866b.180.2024.06.26.08.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 08:18:48 -0700 (PDT)
Message-ID: <28ad9f30-7465-47cc-b514-41750a4c41ca@linaro.org>
Date: Wed, 26 Jun 2024 16:18:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] pinctrl: qcom: add sm4250 lpi pinctrl
To: Konrad Dybcio <konradybcio@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexey.klimov@linaro.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240612-sm4250-lpi-v4-0-a0342e47e21b@linaro.org>
 <CACRpkdZyupZmV+e=L0KR8ospH9P=wdUrMFvBnGXyfhLhW3-=PQ@mail.gmail.com>
 <65d76651-1956-412f-911a-046f0303a16a@kernel.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <65d76651-1956-412f-911a-046f0303a16a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/06/2024 16:07, Konrad Dybcio wrote:
> 
> 
> On 26.06.2024 12:04 PM, Linus Walleij wrote:
>> On Sat, Jun 22, 2024 at 6:49 PM Srinivas Kandagatla
>> <srinivas.kandagatla@linaro.org> wrote:
>>
>>> Add support for sm4250 lpi pinctrl.
>>>
>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> No major protests against v4 so patches applied!
> 
> This was never sent to me..
> 
seems like b4 auto-to-cc does not pick up your email ids from MAINTAINERS.

> We already have a driver for this SoC. 4250 and 6115 are the same
No, these are not same,  here are some differences.
- muxes for I2S mclk differ.
- soundwire muxes are different
- Slew rate offsets are different.

I have verified this before sending this new driver out.

--srini
> (except the former is frequency-capped): pinctrl-sm6115-lpass-lpi.c
> 
> Konrad

