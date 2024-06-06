Return-Path: <linux-kernel+bounces-204439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042C8FEE20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576051C25215
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21C51C2221;
	Thu,  6 Jun 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIhqFYC4"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73401C0DC2;
	Thu,  6 Jun 2024 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683560; cv=none; b=WqYZoaHGrhpuCq2yQ2Wqjpo6g9Qagb/ytAnBS1Zo9wCg1EoOq/8J2F5E6ma8MKOQs6FTqlVw56dyrRhFkapftIqEYtF086SrFEtQU0HqC5xJnArgQfdNj/8QlCW14VMKE9gvQa/T7xb54xMbeJsoCGVxfzo8f7gOzycaDB4byD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683560; c=relaxed/simple;
	bh=EIN+KuUQmKGM4LQhb84pnUKc3j3RvgGFbJhMtBtv63I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfwrcOKQxX0TvmT2PtCFhPx8ZTHdhHm0iZ0fkldO3eyvcZ7YgAX+Jyg2tn6bin9Nzo7kqVhoIWoU9+AnFeBDpCkssKUvCl6zyjFfsW46EF5UrH84H1i/nc+UiVbZMgGIkxCfU9E3eS1ssssmejzl2TctqS8KcVIfj0RBL4+Z2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIhqFYC4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1006440b3a.0;
        Thu, 06 Jun 2024 07:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717683558; x=1718288358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcbWossHxFAPWhaCt0jaKVByCwga+fTczv+uXxjTlu0=;
        b=OIhqFYC4jGwWY+9iFJSrz/vhxDx8jIXoIT/qW/m1VY34nyuoL4hlkA1ZfnjTW1+fyN
         v7urIQrG8yXSi7Ty3GNa8v7rlDNLf5bTzraPNvXq6uIYzKWwhxNuB5qSM7lTKx6y+ou1
         324wCln80TlRfv+Hz5yaC5aKAsKBzkG17vdyp6nqb28VsKoeZNWtWgHT5zNFm03we9Jy
         tkaYH3r1K+X0FFg95ksDFzvbuiazswobVFxHnJlKmPWBUYl3oVKCRQoUFdkqPrj0B/QO
         lyX9DT7+pB+HZJ4hSTDulIxM+aHiLRM6srpXf8kZrSXMKw86sBMi6i6wT+9zUclPwm/c
         /D6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683558; x=1718288358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcbWossHxFAPWhaCt0jaKVByCwga+fTczv+uXxjTlu0=;
        b=gvskTnY/cW+UZE4/MV3Ynj1hpzpNkUjSP/qPHJUiH3vai8PLsXZ8qHZ4TgCm/2GoP/
         +6LpukE/N+IumBeLcfscCmNIW6b7vPntdxvSnuryy4NxfQth+WkkfcIbi4B70jouUMa+
         DRgGPL8hfHlkG7cBXL83s4d5jGtqUuavsE3KwJM5APONYPL2NYyQwNj+Bn6UlHvWBasU
         1ia+ExNeiFRqQZJVvqLGxJA64bctKh6D/vjdtjP1BwbpegY/W7q3Hlkc52SZ8yIMGPf2
         u+8wT2aa9bAsBtD9JaYKYsmZv6CejBdnI85iHiTdHl3HWBNKaEDdh7ljU8bkJ8Rz7VHq
         G8Bw==
X-Forwarded-Encrypted: i=1; AJvYcCW3cTgCH0NBpHhCAfTuoS474/hlK/b8Sh3fBYLO5eXxoyUUak+cLmBHvENQtd4ubjKHpNvYFo18AHYwREI7ewZ0f37DWpNQwqggKRQIWsbu5WGla2cAhf+fN2Txqi/UeyvBLh38ArozwA==
X-Gm-Message-State: AOJu0YyXr37PVh1TLzHtIIyMihQrEHwbRbMys9YFc/Puql/8/jI6Oqg+
	GawFAsHERzbxFr4sTFSfKDoFHtbPMJCHATKixJQHJ+9vCIqK2Lrc
X-Google-Smtp-Source: AGHT+IGW51mR4NTliKKpbb6mL8Di0ngne/w1f8Ev53XXXVhQjFI9ZzWUelNFBR3sa/34xvYKydHeSA==
X-Received: by 2002:a05:6a20:3c8d:b0:1af:9edd:9cb3 with SMTP id adf61e73a8af0-1b2b7414232mr7369811637.17.1717683557519;
        Thu, 06 Jun 2024 07:19:17 -0700 (PDT)
Received: from [10.7.27.90] ([103.170.1.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd495062sm1146384b3a.119.2024.06.06.07.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 07:19:17 -0700 (PDT)
Message-ID: <c32b902e-0338-436b-85e1-827c48e0ee2b@gmail.com>
Date: Thu, 6 Jun 2024 19:49:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: mt6358: Convert to dtschema
Content-Language: en-US, ar-LB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240518081621.63386-1-agarwala.kartik@gmail.com>
 <c05f91f5-a878-4f36-b325-0ac8e038a7e5@linaro.org>
From: Kartik Agarwala <agarwala.kartik@gmail.com>
In-Reply-To: <c05f91f5-a878-4f36-b325-0ac8e038a7e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/20/24 12:39 PM, Krzysztof Kozlowski wrote:
> On 18/05/2024 10:16, Kartik Agarwala wrote:
>> Convert Mediatek MT6358 Audio Codec bindings from text to dtschema.
>>
>> Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
>> ---
>>  .../bindings/sound/mediatek,mt6358.yaml       | 47 +++++++++++++++++++
>>  .../devicetree/bindings/sound/mt6358.txt      | 26 ----------
>>  2 files changed, 47 insertions(+), 26 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>> new file mode 100644
>> index 000000000..f57ef2aa5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt6358.yaml
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/mediatek,mt6358.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek MT6358 Audio Codec
>> +
>> +maintainers:
>> +  - Kartik Agarwala <agarwala.kartik@gmail.com>
>> +
>> +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +  The communication between MT6358 and SoC is through Mediatek PMIC wrapper.
>> +  For more detail, please visit Mediatek PMIC wrapper documentation.
>> +  Must be a child node of PMIC wrapper.
> 
> Did you update the PMIC wrapper binding with ref to this?
> 

Hi Krzysztof, 

I apologize incase this is something obvious but I am still not sure
if I understand what you expect here. Could you please explain this
a bit more? I thought that you wanted me to convert the Mediatek PMIC 
wrapper but it already seems to be in DT-Schema format.[1]

[1]: https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/soc/mediatek/mediatek%2Cpwrap.yaml

Thanks and Regards,
Kartik Agarwala

