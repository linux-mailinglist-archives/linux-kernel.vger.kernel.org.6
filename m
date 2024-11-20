Return-Path: <linux-kernel+bounces-415399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D759D358E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF6E1F22879
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7945A1714CD;
	Wed, 20 Nov 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax0Rbykp"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DE15B547;
	Wed, 20 Nov 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091696; cv=none; b=G2+oHQMmy0rtT86AJmNkYxJu0TLRE+QJk7UuoiOnAeHJUE7BLNBVe1MJoU9EktKFufbvQIxmwFnzCpyV2HHFYOp92kc7oU4DUKF6w2uDpmNb3G/EUpnYf9a5bMYZG1osQMOhvg7ax+bvif+gTF7AMW4RXAPlz/qZzwe2NXC62gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091696; c=relaxed/simple;
	bh=gJf8KkykDhkqdPk/zByKQs5feI7RZ+KmYJqtgsBYOac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ry3mWAjoi1ESbwi/dBTtGSugSgSYV1tRvZ3Bx51jb3XfBocwJDxoua/pqI9AfpkcxFvRw9rAVjRhyTI4VcHZJTfJhnuf9TdTCTgFNSg6v2eP+ojrKT7rOaQKwAZq2mR7v42Lw0BRXqZeMfkhHvV5pGkalJXvVaR8vIF8+Rv7aHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax0Rbykp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9eb3794a04so778310866b.3;
        Wed, 20 Nov 2024 00:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732091693; x=1732696493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZpGB3gn1k+A89OIAwadfCUnL30RH857Ljr3wZqpohk=;
        b=Ax0RbykpMV+zLWexLV000DgBk23WZShb+JkHRmDwHDeKtnfI+E+3HssZ3Sp+gXX/+u
         lHcfvWV70yvxWuhtRJsVMaQz9f6CvtigCQ6F921YVHCCYROTZJp4HMKYW9n3avkxF/jE
         IpczT2Gnryh3YhyWzmKekJl5+hu6pNZwRTEMyvAsKEVMATe+r80R9NKIrQc5hkBsP+Zu
         fgpoHISzVe0piM5njabb0f50Cn8etYJsB67kTUAnVliuMRc/kkvzTImBLYZxQlk5FRkK
         fHbF7JHyOxXuGoEARrXXSmcbvrXj23OeN8O3xJ7tEFnqoDt7+vQIinA80N/pf0B4vrG0
         wSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732091693; x=1732696493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZpGB3gn1k+A89OIAwadfCUnL30RH857Ljr3wZqpohk=;
        b=k3fusm4nznBTLU6K51UX/cxK2rlTpExhqG/cVlBmWLpuIILrJzx2K8I3UOyqvKY7WO
         0H3+EDTD4TWw+Wxw+Jarx9AaXsDZwI5hXyOhnRgwU3sznuMBuQ5eN8hxsE00qFe811gR
         iaCXjpiEY1XGP7Nz0Jl7vnGEDURgKJktCRA0tzFsPOhTBGOq/SI6PSfO2sTkCcNKjHXW
         m422fNL5UIspl8T4YASiLw2LuAz2dc4UCS772ctLqZWd4FKJ0EXQSYbww0hAis4IYh6r
         7djuxumypSyGwBcbGHsyl0k1AV7TVaejo9lj5ZWRcXuMxYBlUwrs0JebBMEy1nR7Kyx6
         FDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpbpjf7YT3C6pXQuEAVAmGdAvWbRgsL/ADGM7sI7CPe1l0mHyJFH1FMrJegxCt1XV0oEvOZvk8YcEw@vger.kernel.org, AJvYcCUvSWcS9v9Ss29H5VQOIwhNV1AxzB2xd856CJpT76kqLOLYv5t5P3V/igNNH1Y3H+QhS51xwFhhUDaHnA84@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLKiRMByi4zckioW7bw1ZSwL7zVjMkIxVkND1a/h6T6gIEELO
	FOlms03bJAL1InJOWHn+NtiTV4Q5UAeGqOtHM809Q05ma19hdgig
X-Google-Smtp-Source: AGHT+IEvl73IvjHMDmWuPSwElKpJPW9hrZHFr3uhcPc+30Ttx5IP0BbniIngL57kRXyo0uXkW91kPA==
X-Received: by 2002:a17:906:4fd0:b0:aa4:a814:3f78 with SMTP id a640c23a62f3a-aa4dd53db6bmr149013366b.1.1732091693418;
        Wed, 20 Nov 2024 00:34:53 -0800 (PST)
Received: from ?IPV6:2a02:e98:40:8092:7852:d118:dec4:8e58? ([2a02:e98:40:8092:7852:d118:dec4:8e58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e046891sm739424566b.171.2024.11.20.00.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 00:34:53 -0800 (PST)
Message-ID: <83c8487c-2c50-4315-8244-ff80632165e9@gmail.com>
Date: Wed, 20 Nov 2024 09:34:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: Conor Dooley <conor@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
 <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
 <20241115-happy-garter-2cf65f4b1290@spud>
Content-Language: cs, en-US
From: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>
In-Reply-To: <20241115-happy-garter-2cf65f4b1290@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

> On Fri, Nov 15, 2024 at 03:58:06PM +0100, Kryštof Černý via B4 Relay wrote:
>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>
>> Adds the newly added vcc-supply property to bindings.
> 
> This commit message is a circular argument. You're adding it to the
> binding, which of course means it is newly added.

You are right, I will replace with "Adds the vcc-supply property to 
bindings." in the next version.

>>
>> Signed-off-by: Kryštof Černý <cleverline1mc@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/w1/maxim,ds2482.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>> index 422becc6e1fa8d58665c5586ebdc611cd0b2c760..a6b9e0658ec858cb24b21cf64443a061bb43e4ef 100644
>> --- a/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>> +++ b/Documentation/devicetree/bindings/w1/maxim,ds2482.yaml
>> @@ -25,6 +25,9 @@ properties:
>>     reg:
>>       maxItems: 1
>>   
>> +  vcc-supply:
>> +    description: phandle of the regulator that provides the supply voltage.
> 
> "vcc-supply: true" should suffice.
> 

Right, I suppose you mean to remove the description and just have 
"vcc-supply: true".
If so, could you explain why no description? Is it some standard property
or because the name is self-explanatory? If you mean to keep both, 
please reply.

>> +
>>   required:
>>     - compatible
>>     - reg
>>
>> -- 
>> 2.39.5
>>
>>

Thank you for review,
Kryštof Černý

