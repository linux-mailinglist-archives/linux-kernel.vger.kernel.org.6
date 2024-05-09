Return-Path: <linux-kernel+bounces-174341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A38C0D65
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF86C28317B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA9214A607;
	Thu,  9 May 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gWlfH0cy"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06653149C7C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246366; cv=none; b=RX3ELcAcjMl8k2U2zMSSDNQ1dhOIPfVN+9fYDrIJgOGC8Uwona2aZGf8131q9QjioAUe/F88DI1wUhrRwrHmDbhc2blkkudUy+3XL408HK/tq+/VTqMAAz2kw0uqWa6gG/JLF3H+YyC/XxcR4ioIcxmyLKx+VJhLRhZ88GMJld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246366; c=relaxed/simple;
	bh=CTwGFffSiQNAm7ecRbthFprpYRygzcgDpf2Oi1r9lqA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hxxEIhM2vp6z4g4rdux2UIlWNpCgvBJp9VlL7L9fdjZtHI+0X78wCdYVa08ZYD3IKKJt1XfptUUB391gScVXKNFis0ynODjuMOBE2dfodarNcVkKXD894/W0NVex3XKXq1oqitCHRWnUXXvik+Qsq0kkaOhGSJmfhFnc2z2KUeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gWlfH0cy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso147817966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715246363; x=1715851163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uht1zdKhlYFVJL9EGVPr4p9yniGLLIKRgyA9B3Yasp4=;
        b=gWlfH0cy2TFqK6FUGUUMsvbL0OHgaD01UwnptT32rA6Lg7INvpOIrogO6c9E4GZs/2
         bXLDfaZ7Ys1qVLy7SLZ00GGzBeC1EqttJ4EZHJu3ZQHEdQfZtD8vWz3vicP94/8SLkwi
         ROoo3as2NrY172+ZkvTbdA465Y4AEUa8GjjXazq4QO2C2QSNhPat2Y9LoraSsAXSoXYV
         Zx560gWu+tK9xNnZvnBCPsxWruEJ7aEEZhidYns85zfHrzVCtgF3m4aInkxpkY5otgdE
         Pr2Zpt9VzfU7RFYbu+1NgLpTJwblK42JmUBj8fY30kdCiix7W4aZr+CUHbpUPELtjVYD
         /oPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246363; x=1715851163;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uht1zdKhlYFVJL9EGVPr4p9yniGLLIKRgyA9B3Yasp4=;
        b=h3kwhUp4aR02pwaiWTGkRtOS0MI1JxAMJGXtpX9yhOBuAEGKI0/F/5Q8Zol1ngGAu1
         90nNttn42DsYvIS7WcBf9S6gozOMZmPfq7zu35YJHItRrWpHQqljoXFL9SUg3R13g3Bt
         FpMuglRGVG4YK3bVnl+fZ2wZF9p4LTFdUgv4C0TpOjbc9nAFq3C100RpZrbKmqiI7jKa
         gpiM3FS03iVVZVf3HsZ8Fe2+OEOQri8AEchaL/18db8o/0OVKBFLcCSBsREUNxhK13Sb
         a8ixt9HfdRzeQnRkq0HisuRf29PRDBpJF6Qzxnph6EcJabWj6na3C9BPQhcD57HbxN18
         gX8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6H2CkRZn9ifdbOfYEVjLUYYmbz8i21ynlVXWG+hryjiHOUSunhFDpXwvk2Xh1/GWX3muoQ9fRy5J4hLJuEdGJUajKfoO0uM6VeeC6
X-Gm-Message-State: AOJu0YyqxXDixM/KJf0SpudvumO137rcuhXOQpcOQlN7sz1nzMJ4EIr7
	mm1Ih4q/NWXnv8PSrI6avOr8DvzsTgE5BcgP7QzZq1NYFYEi0U3Xz5xNGjre3oY=
X-Google-Smtp-Source: AGHT+IGvNTVI6AoqewPpnKdSF5KorluIJnY6BiV0Z8DEdl2WDYhm61Cn7QcUWAloFRe/OuodFFkR0A==
X-Received: by 2002:a17:906:ecef:b0:a59:c62c:2122 with SMTP id a640c23a62f3a-a59fb94a408mr290143266b.8.1715246363346;
        Thu, 09 May 2024 02:19:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01724sm52048466b.162.2024.05.09.02.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 02:19:22 -0700 (PDT)
Message-ID: <62f8ce02-9e8b-4d5c-809d-1f042a6da3fc@linaro.org>
Date: Thu, 9 May 2024 11:19:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: display: panel: Add Starry-er88577
 support
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>,
 dmitry.torokhov@gmail.com, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org,
 benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240509064959.23550-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240509064959.23550-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <82685064-5163-4f83-88c8-b29fcb63ef08@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <82685064-5163-4f83-88c8-b29fcb63ef08@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 10:40, Krzysztof Kozlowski wrote:
> 
>> +
>> +maintainers:
>> +  - Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: starry,er88577
>> +
>> +  pp3300-supply: true
>> +  reg: true
> 
> Hm, I wonder why we do not have constraints here in most of the bindings...
> 

I'll send a patchset adding maxItems to other cases, so please use
maxItems here instead.

Best regards,
Krzysztof


