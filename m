Return-Path: <linux-kernel+bounces-270433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A072943FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD411C2184B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F831EB4AD;
	Thu,  1 Aug 2024 00:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2ty9yc+"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC461EB48E;
	Thu,  1 Aug 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472872; cv=none; b=batMDaY/9kc0kyuYrrvQSFCjeF0pQ0AsZdJsbicRsr77SerzOwxI+kln33IDnkZ9R89AWPs9LZjGm9yp1Tbu2Xs/HWXIc1spOMM5Zt76NKZadew9OjWQoBh3m48M9QL7T3eyhiLiK6waDXO6K/OYWJ8Tk2Z7QGWQus4A7s9ffVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472872; c=relaxed/simple;
	bh=l0EmLdN7z5jDB8UnEkkZc4qnK9A9Sr31dW/ETAFaODU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyRb9qS7DqdWI/DgO82T5Hd47Ki5+J2IfCCgWSm4w5VheyRIAdO7RpVZimvPGZ2LCXPa7T5YpVu8+erTpusy3M0nYMO6G/cngCVRPlykqEBKmTXwrGuhxZtMBWCTDRhuVl+w86QXVwFlIiTC7RtivTWAqZgJke0UOS1z+6iTvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2ty9yc+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db16129143so3689093b6e.0;
        Wed, 31 Jul 2024 17:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722472869; x=1723077669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+SRhALzSNIYjZtYZCdYQEI+/EH5x/c0pzDejuFftYNk=;
        b=A2ty9yc+pUwwecvKYXwXhxOgeM9181/eMX/Tdc8YULOhcFmD5WOYXEuI9fgjYV6ADA
         v19f6tE8q6kkSuKVhCg6OMJds3FusW+fKgvHrGvLhVAhcnhc/nkTakbh11qzorgUfKjp
         TOf5zRKhiLfo3nUqrrMioFmp93Tqc6fGJ1vx6bWjFGD2XdhiWkp2+TqIcznZL0N9iVMg
         3oMKHsabs3kY24Vjs28m9puhiTURgQyZxBVwsVLoOa8Pk0kjxWkkNg0mH9j5LHL7rOvE
         mVW7EubV+3cRE2aDkdLJ+QfHAFz/qGYMPJ0W3XEjJBi+YZ1KzJvybpYiOeqE37k/r5aK
         qdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722472869; x=1723077669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+SRhALzSNIYjZtYZCdYQEI+/EH5x/c0pzDejuFftYNk=;
        b=HuQANukk/VGAyLwDu2nD/s5yjEi/sMHphmgSdE2asykatMNhjg1xdlZu72a93ZfCkP
         oEJ/utdwWxiaw16UlTIpTZa1ps4CtheFRSPu+mXSotLFU1car/q1NVp/nK6mKjiCHP0N
         M/SY9qLwobc7tT2sqQe5wV4Do6dL4IwJrntuvRofL179LfOd8S7GWavrK0OxxBSiJmJr
         PzJdauYUpuFByOPMs9iJcRF4AsPcw3DWWKCNfu2HgOvZM0gDqYg1hNm86ryguNzn/9gt
         80ccGaFuRMSWbQwVzcPKwW9n9tG+PBJOpeSzaidpHBaraK3BU1hFPmA/3cqOewIvTws0
         7KDw==
X-Forwarded-Encrypted: i=1; AJvYcCXFhoY4RvLo4CEBmfJ8Spt8+A2t6V+csTCYCZgYaQwRsx7hMSZkxv3CQRLDVVLFkx65LqrVuqXqx50iq/miTC19zZ3bDuxEIErmWtEXY1NYUvLAWDy6LKLGxWrdG4nET5JXUy1iHG54dg==
X-Gm-Message-State: AOJu0YzOQ1kvDN5JKS2t49UZTkKAgwR2N7PT5kV02fIaX8TPZYlW86QO
	i6gaX8XZJdQg1IkXSZik75zMW1mmAfMKEFcKsImC97YCennwJmqM
X-Google-Smtp-Source: AGHT+IF2+UXiIKmLrJ8RELf5HuGNCOKJPdjkpvdOPhQ+ZS8Luzx6Jwu6WdMqA97xvIZpCy9sBV+83w==
X-Received: by 2002:a05:6808:23d6:b0:3da:a16e:1764 with SMTP id 5614622812f47-3db511b4701mr1034618b6e.4.1722472869032;
        Wed, 31 Jul 2024 17:41:09 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7b7b029sm10935955a12.11.2024.07.31.17.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 17:41:08 -0700 (PDT)
Message-ID: <2e543ed4-929c-44df-ba42-0a6b259aeb0f@gmail.com>
Date: Thu, 1 Aug 2024 08:41:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731014313.113417-1-hpchen0nvt@gmail.com>
 <20240731014313.113417-2-hpchen0nvt@gmail.com>
 <6b1894c8-766c-4191-9f05-42f1f0a838f5@kernel.org>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <6b1894c8-766c-4191-9f05-42f1f0a838f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.



On 2024/7/31 下午 01:31, Krzysztof Kozlowski wrote:
> On 31/07/2024 03:43, Hui-Ping Chen wrote:
>> Add dt-bindings for USB2 PHY found on the Nuvoton MA35 SoC.
>>
>> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
>> ---
>>   .../bindings/phy/nuvoton,ma35d1-usb2-phy.yaml | 47 +++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
>> new file mode 100644
>> index 000000000000..88e297ba4ecf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/nuvoton,ma35d1-usb2-phy.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/nuvoton,ma35d1-usb2-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 USB2 phy
>> +
>> +maintainers:
>> +  - Hui-Ping Chen <hpchen0nvt@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35d1-usb2-phy
>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle of the system-management node.
>> +      This driver has some status bits located in the sys,
> Do not reference drivers, but hardware.

Okay. I will revise the description.



>> +      it is necessary to reference the sys link.
> This tells me nothing. You must be specific - WHAT IS THE PURPOSE of
> this syscon usage in USB2 PHY?

Sorry, I misunderstood. I will correct the description.

Thank you for the reminder.



> Best regards,
> Krzysztof


Best regards,

Hui-Ping Chen



