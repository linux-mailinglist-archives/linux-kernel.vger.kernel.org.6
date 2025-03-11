Return-Path: <linux-kernel+bounces-555640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DCA5BAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BB03AF6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F8224244;
	Tue, 11 Mar 2025 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYQawrW+"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C241E7C2B;
	Tue, 11 Mar 2025 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681128; cv=none; b=QqLrWYN5JS7oDRgZ9lKv6PBcsCj5rtOpCly1LxyjhMcWkUD/8j5TTONGH3mFsGdPI9nZlPD5CNvTcSLdw6Z2s5mrvFMsHj5GOVPp0UTNSze5+9Pynw/gtBPBac5S8G3zpXcY7WDAcaQ81PydUIo+8SWKKfeYLenzR9TCoWY0KAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681128; c=relaxed/simple;
	bh=zXoRkiEUeNdaqaQv6jVMKKYWW/tCEPHxH66N+vuLs0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rn1mRlZ8o6ie5IAGr5gjGKcX5bq0ZHD5GgBZ6dm33bky2fBWa1A9W0KWCBv+mVTnA0c9O66Gsms5c+25n+reKFu+a6WG2oOhqn0NHSt+uBeMXsXbah0WC6CDZZngueLrflLReecYY0wWvEuasx4txG37/b4IVpcTzQFX3hD91+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYQawrW+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaec61d0f65so1028700566b.1;
        Tue, 11 Mar 2025 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741681125; x=1742285925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r60VLRjOftkHGoBqvawtyRS1YyQH6tDVCblEoFcS268=;
        b=AYQawrW+btDeLEZE3f3Teyt4V1iKnr4JwK+jUKk/7NGeTKv1Sc3rUUwQEM02FR5QXL
         VZMWpu7ae6X6G7eo8ied2HWhqOE9+Vx2Vnq8YobgZfADmR3csyJ3RUTIO+aNKt5Xl1PX
         TxXBxazNercinR3/LxF9AwGZ/fIqq0SSbVXhsXBoBcrE3IoCMc+MaGgAvO4r3g7tvXoi
         0/q8h0HpgSO9gyof14I7QIA63pgSzxmGRvVrGPPtx0GIDPXAKCNIyLEDasmXUuEicwOg
         4xpTX0+xpTpOrVgc8rRi132rESVzrSg5YsbOjxxjGMCam7s7j9zOmId7to4GjO9EyD17
         mcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681125; x=1742285925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r60VLRjOftkHGoBqvawtyRS1YyQH6tDVCblEoFcS268=;
        b=Rm78se2WGR84t2OhujF9rz77v9kDJF4QFK0+QSISq5dqlxJnKo4jPWlvG4ldoLBpdh
         LsvdEe49X7hZohV5RnzaPomxuMQxZBdAckcju7I53GXo70ur8lBTwKy7cDcYOfRiy48z
         AEIEydJWLl9GlUKsWCdih1cw2Odrc5ihSq7WnMztlINKKFDlHwZ0XqRl0OsifNgKyIJw
         WC8X+wNXfbmQU9QW4u137mZsD1AEovVODTSDHFQfS86sozNO1qht9t/xN4TRYEb9O+of
         DcVzh/PNQfpxGothJ3cpUfTFbFsHmXYyBuiiXHmGMYIajVNn1h5XT+bDRD0WwHKuJvB+
         1Xxg==
X-Forwarded-Encrypted: i=1; AJvYcCWE0rSRVWFZLjxdJoK69skhGpMOGroB2bPHilXMpecL5qGq0xaHYkaLlsXQ2585UZzjgPXhdbBXoYgd36KR@vger.kernel.org, AJvYcCX0zql5NRqFynXUOtr7EuVDYJZZtaOITCpgWBykn4SOnpFMwMFZuxy5j6clWHWwdPk1wolpEB9Y/g00@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1tqGVqALTH5mOdNb0u64l2C33ZFU6t+ivNdjgpE0XMUkvH7dR
	PYKFLIOaEdSu8HhkXXRgS/aRErj6mmxwsBmXHZBGjTVi8FIfjbgo5/ZYiFNT
X-Gm-Gg: ASbGncuhQfRtwHR88euwA+Pcem1PT9Ioi2P2F5kR7P72I1AY0h/NJlAJDHApFYunFdm
	8TZgCT40zivgNW1nUVxM27Lp4yTEaiUoxVf+2uV7dZvZZSL5AhT7jCkpuHnw6NY5Gd99NFnv6uy
	NQTBV0wcLXdcKOMyqA3uHJvGQssk+eQbStpPBXcIuWhEx+84CFeDwfIowvgo1dq09AXnSs+LG/F
	7hvpfMOMgXv8MdPzMZd2KDvrApMvIouAJTftEKT0QUzbex659FWWIeWV1M3xYW3WHLYaH8PEf6L
	7PGSWm6v7n0Q1tqXdtL3GWmiCqV+JBDn8YcX8+61tm9nhEE7YVRK0Q==
X-Google-Smtp-Source: AGHT+IFqwPmHHBuy1mII02V8OsP5GtPxQ3z1KRgPYgKJP4M5dDUYaG5S9PlaLTZ0q1EM60MgyhbgTA==
X-Received: by 2002:a17:907:3f2a:b0:ac2:9a4:89a8 with SMTP id a640c23a62f3a-ac252ed4960mr1945973966b.47.1741681124678;
        Tue, 11 Mar 2025 01:18:44 -0700 (PDT)
Received: from [192.168.1.130] ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac298412a9asm351669266b.156.2025.03.11.01.18.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 01:18:44 -0700 (PDT)
Message-ID: <38293dea-3207-40e9-a29b-cd5b74904b8f@gmail.com>
Date: Tue, 11 Mar 2025 09:18:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: vendor-prefixes: Add Ultratronik
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?B?R29yYW4gUmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310154804.326943-1-goran.radni@gmail.com>
 <20250310154804.326943-2-goran.radni@gmail.com>
 <3d0747b5-e73f-4212-893b-08f5a58b2cc4@kernel.org>
Content-Language: en-US
From: Goran Radenovic <goran.radni@gmail.com>
In-Reply-To: <3d0747b5-e73f-4212-893b-08f5a58b2cc4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ok, thanks!

Best regards
Goran

On 10.03.25 17:03, Krzysztof Kozlowski wrote:
> On 10/03/2025 16:47, Goran Rađenović wrote:
>> From: Goran Rađenović <gradenovic@ultratronik.de>
>>
>> Ultratronik GmbH is a German electronics company:
>> https://www.ultratronik-ems.de/
>>
>> Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index 5079ca6ce1d1..563d319fb73e 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -1599,6 +1599,8 @@ patternProperties:
>>       description: U.S. Robotics Corporation
>>     "^utoo,.*":
>>       description: Aigo Digital Technology Co., Ltd.
>> +  "^ux,.*":
> Vendor prefixes shall match company name or domain, so: ultratronik
>
>> +    description: Ultratronik GmbH
>>     "^v3,.*":
>>       description: V3 Semiconductor
>>     "^vaisala,.*":
>
> Best regards,
> Krzysztof

