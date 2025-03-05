Return-Path: <linux-kernel+bounces-547312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BD2A505C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EDA03A1676
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9AC1A23B1;
	Wed,  5 Mar 2025 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeVR+l4P"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B0151992;
	Wed,  5 Mar 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193538; cv=none; b=WK/L02wfSlmSN94FoewaVhqDIfL475co5s+yYkGJU93G+QgPUX+LTxZoNkiYGW5ZycfmEKgbIU5vNTU+tUZTdz4gvtDOADPvSUmWqzyzb3hc0nHF3s5UTuu5Liul4XZMB77YiyaCRWRCLsRYsPTz6M2J8qjNcUHk9t2OWa7zEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193538; c=relaxed/simple;
	bh=YTnJljWItT/TZiEZ+iXZU1PBs+E2Gtx+J6Pg8f6NAKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuFBM1LpgVkwi92et+ZwbAPnVI4zYWzNnRCvpEKZZ96ujl6JycGb7fqqwo4NvqDVL4NkqfavP1Kkb6RHnuqUFgq+4Bdip14xqWRWmt7OjydQyuhTeDad1Vmg1z/FYkjgsGvlrTkF6rlzd1k74pMs4ftYozdWwxWScuUisPkeijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeVR+l4P; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e53b3fa7daso6231888a12.2;
        Wed, 05 Mar 2025 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741193535; x=1741798335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TN7dJ7nISnXyySEUqU25KmhCCTIJAKDIXS/YmlH1ZlU=;
        b=jeVR+l4Pe6MBW4Pe6EDvz+n8DUHy/OhPYfDV3ju876P+P2uI949mbqpmOoa4H8H5kz
         7SRKDkS/7vK5CAi6co/u6U0op4rcRDzRP3QMnkdUmqnCF+SIzZ7SOzHmRXQPtqx1TVrm
         J21iasyNHCOEpiKjSqAjYdwIBpXjKyRWITXhhp8XFk6oXx8d4V7DVkpo8YtubbsoBX8N
         EBh9oqCwclF13itI3cpUPSJcVASHIMfbu0rD4hxxGRtv92B65Px6G4f3Fm4dvSeR/Dxx
         UPflyE3uDx5iYw2t4HCAZ5Zc9NQoZn0SGFRq1NzXQLv5OwFlTAB/QDNG2DG2zPNfX7ye
         vong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193535; x=1741798335;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TN7dJ7nISnXyySEUqU25KmhCCTIJAKDIXS/YmlH1ZlU=;
        b=r267j/IJqNQBnEUiwNS3oiJnAyVDhJSMEAWmligtXp+fKfMUaLXntXcZmBrjqFn2FQ
         DcJa+L4LD90LFtM0JZT8fWRrwdb4TV3FJNhP/WDNTq9EftbFDvHBCjGpV0vbE3liovjL
         2+/xZLJvhPmO+6Yw/XkuW6kcDc90DEdi6w/L+YkaTWoMIe+dJVWaGk1zka3Mec/qCF2M
         2pHTAEFj/1vj6RruGQ64xZFVzanBb08Zh5nLkDBkI0KGnBIWlTd6Mwokrt8jURjt9edZ
         2zffXg+KttHGeQXrbV6nCugH79PBl7W6b1IRZe1o+NWS0R3ZPwwc4wQvBInaJeyrV7bD
         Xelg==
X-Forwarded-Encrypted: i=1; AJvYcCVDdx7XN1WM0eNdCguL+ncUNQCezNhrl0NQNmhb4Veoa1LmuwvSjlJE73wD61/KGqxMonljhaI3paLW@vger.kernel.org, AJvYcCVlVa2xDfWVSuRmKBbJC1q3tWIS9YVNVdxEZ7/Ipu/uKnTwTwhcdk9AY0IXN/9kElIP8+1IoxdaYBhql9+z@vger.kernel.org
X-Gm-Message-State: AOJu0YxbUEV9aLmFqSni4XQM2yuZMckAqoDAnl9Lcs15c08QwX0y0eA7
	9OKCGfyVbA2SWkI/OCPl5vkD16hGWmQYJMusxI5ANuZS894E2YpK
X-Gm-Gg: ASbGncs6OZ70lUgOqgNAMz0WDKzArPNec8M/U8nLhXbRRfZpseOU8EugGBd6FdaqF5l
	ImS934gqUT1lHbTmkznuL1gDwPsHW1wi5K8jo6GAUqVr6yBQfDUSX5t6oJ6T2+RS4E35ubY2W0S
	PGGJd5OikRhpzm2A50H4FC/2uKAvUaxKW7hurvTHZq3jEqQ8jKoErHiAvAtX/znZ1+qlqmplFOJ
	HjmRjpGw7ICW26mP9pEEytzOakQ1rEmUkWZ6gaSww/0kLRTeExK+z5XTJzk+9O/6FO/04Bsrft3
	jjhvfWL/Q2BWCmljuERds4+JBoMlnGDB4eSgRAtGpyqgXJkxKEdeQMute4t9eIP/2VAs0sx4INc
	bBqXkV3j0PvOva8a1TtM=
X-Google-Smtp-Source: AGHT+IGa33gWH8DfappKMWnwXtxakFLXNeMsVDV2sfglAO9PuEomgg6n3nyUhy0aaBLlS6tO2n4JYg==
X-Received: by 2002:a05:6402:2356:b0:5dc:d10a:1be8 with SMTP id 4fb4d7f45d1cf-5e59f405bafmr4178199a12.19.1741193534946;
        Wed, 05 Mar 2025 08:52:14 -0800 (PST)
Received: from [192.168.50.244] (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5992d29e3sm1978178a12.31.2025.03.05.08.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:52:13 -0800 (PST)
Message-ID: <51cefa7f-df05-49d4-9006-59ed216915a4@gmail.com>
Date: Wed, 5 Mar 2025 17:52:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] dt-bindings: mfd: brcm,bcm59056: Add compatible
 for BCM59054
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250304-bcm59054-v6-0-ae8302358443@gmail.com>
 <20250304-bcm59054-v6-2-ae8302358443@gmail.com>
 <20250304141933.GA2543583-robh@kernel.org>
From: Artur Weber <aweber.kernel@gmail.com>
Content-Language: en-US
In-Reply-To: <20250304141933.GA2543583-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4.03.2025 15:19, Rob Herring wrote:
> On Tue, Mar 04, 2025 at 07:20:33AM +0100, Artur Weber wrote:
>> The BCM59054 MFD is fairly similar to the BCM59056, and will use
>> the same driver. Add compatible and specify the allowed regulator
>> nodes.
>>
>> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
>> ...
> And drop the allOf below.
> 
>>   
>>   required:
>>     - compatible
>> @@ -30,6 +31,27 @@ required:
>>   
>>   additionalProperties: false
>>   
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: brcm,bcm59054
>> +    then:
>> +      properties:
>> +        regulators:
>> +          $ref: /schemas/regulator/brcm,bcm59054.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: brcm,bcm59056
>> +    then:
>> +      properties:
>> +        regulators:
>> +          $ref: /schemas/regulator/brcm,bcm59056.yaml#
>> +
>>   examples:
>>     - |
>>       #include <dt-bindings/interrupt-controller/arm-gic.h>

"Drop the allOf" as in, drop just the "allOf" line or the entire block
with "if" statements? If it's the latter - wouldn't that break the
bindings for the "regulators" subnode?

Best regards
Artur

