Return-Path: <linux-kernel+bounces-576529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F05A7107D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ED13AC117
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A2318B495;
	Wed, 26 Mar 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luVKq1aB"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62282176AC8;
	Wed, 26 Mar 2025 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742969928; cv=none; b=dgP6KDEU99lv+mJ1Gj71HbyMtPealI/FXtHPcUZpy4uES+mY1NFseq6OCSqpCKz3EUdgJLJIbkXKXxeNNCpGeVYnS5+eDObBIhR43Zlq/QGwj3Cl/HgWLwnnW5SWV4B9wd52VYAvDPj/llCrmT+nztPlUSfg24NQfbZMugL0QKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742969928; c=relaxed/simple;
	bh=kA3QSOsqdwnf3UkiS87cnd1QqYpSuL298aKbY6ya3bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDdzqi5FE8WWeSefjqO2E8EQ2CabvGUiQFh9UmHm0FDRaQWPvMGCAy2m5y3ZdCpKe2X1FbSsbptoTgGS7wk0mpdtuVm55gs4p9Cf1xJdNRekVHO/lTQGABH1W69aaHJhO+alF7H967eC1xr0DIMSd5tVKQWHSIHSAuw9nJQzMM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luVKq1aB; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so64604071fa.1;
        Tue, 25 Mar 2025 23:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742969924; x=1743574724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eAOoA8Jyyx94raOkZYedOk/GTaALuBA9vxSD9BrEKSI=;
        b=luVKq1aBmaY5nwllUO0ZEhoyp3RR0j/+V/dwkkME2hiVD5wYXcBggiIfEmOZuTKvtS
         vc0g57OH3AgEyFcXNgjL6lqAdEmhP1JXz4N0ARaJCvgUr/0nHLoCJMmnDnr0/SIIEyEx
         Mis6Icm/GvusH1odnDzrx7iYbYVE/f+HiUa2u7nWs3grzLZEUJB9DJ8N/eR+peOnNmUx
         Gh4xy/d0t3M2+LTlaku+8AWfUM3Mls062PftI5pxNsI1FjbHrj4UA95oO7vBRh8u5ZkV
         TDqoEUjlX1tTSD3Lh4mNxAbXJC4LUlvH84a0yoZUcQTHj7WQckMWD/0D9amVYPa+Zs1V
         putQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742969924; x=1743574724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAOoA8Jyyx94raOkZYedOk/GTaALuBA9vxSD9BrEKSI=;
        b=htnrxX2/uqLH8kTZU6XJuJrt4qVHKW/a2V9rmrQJ8V+w6xxV0V1YI43pQy8UVF6/qy
         zNBUMLqPwdhRcuN/Gf6V6btj+IC/TNeLJNABDQVaKdbSGYUtbtouwTkHzm2fiWzg+SoF
         uE+DIu7pUjBD14WpLo6mSXGLOBa/fk5I04f1I7/Ur2o3wy7I4xG8pLATb7SfbXeSVBOH
         LlAwC7j26NJuMMZt1iwlhqM3HXcm0KEDEB5l40JzMwRywGYwH0EUFXjtVdDG+YyUUuls
         1M4dI354TA+nY+82cW4rkWCPqYq3dC8DfLQIhkD17vwnKpLvPg2EXCL3f2gJs2TNzgl/
         Slxw==
X-Forwarded-Encrypted: i=1; AJvYcCW4sPFDW+beK1pOK1WWj9DyBEuYUVu9y6uptFLPd3bmAnKp+RVIvAki45GEq38HLq4VT2eP9I1/43BJ@vger.kernel.org, AJvYcCXvcxz8v3d8/2SH5/RW60T6NpunZyGTgxxFU1SSv5fsWsM7V2MCfWrgA1YC0QPJQtvpA/b1N+yPgBeMdpUy@vger.kernel.org
X-Gm-Message-State: AOJu0YwvXnXFOsE9S5/UG8fCjlaOF82oIvYA1/toBd6D18q9iLO0AUaJ
	+7YJpFyQiNpqd8oeaanlacF22CfhEsP1Q8Nl4YfwTNaul85YkWJi
X-Gm-Gg: ASbGncujTDpwE3Ka2Mwzr3tNKlH1TUVw2I7J0EdH+vcxydU+b13lfVNe/Fjhb6p/4/e
	TVSEqNTCeVajhEsJc7o117dhfm4d2Q7JnwbLcR83lyeLezW1wx99wMsPqjhIiW6bczEmcf/7sOV
	O60HUml7L6e+0Yfep4Q5M42GiCEDsMBo/s9VG9F7qntjo5tQWjU/aT4CgEC6D40yrgbXXZTkg2R
	VQyC+P9zZXoCBW1xif1Hdkdwn72xVRW1y3MNKpSdrpdWdkY6LUbEVGaodEOTgxWXDGNiiBVao1R
	bWQt92YJ+4No7EL/4Ci/WAnfB114P2t4Fd5K4Ws7/9FsrJ3Aty1djv2KqH6E52NRLbFhGZBVFvM
	jBo0CVeQ7hxGcuj6GOTM69bt9aQ==
X-Google-Smtp-Source: AGHT+IGYrBtCuxkrCo7LF9BiU28gp01SDWjHKoug1hLGxgBsDIc8wVS29wWqnyZRgRgyOdlG5CT9zw==
X-Received: by 2002:a2e:3504:0:b0:30b:9813:b010 with SMTP id 38308e7fff4ca-30d7e2f789bmr61432841fa.31.1742969924131;
        Tue, 25 Mar 2025 23:18:44 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7c1bd3sm20078391fa.12.2025.03.25.23.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 23:18:43 -0700 (PDT)
Message-ID: <acaac658-1966-405e-ac20-4ff305d0100d@gmail.com>
Date: Wed, 26 Mar 2025 08:18:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] dt-bindings: mfd: bd96802: Add ROHM BD96806
To: Conor Dooley <conor@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1742802856.git.mazziesaccount@gmail.com>
 <99ffe94d642b6c73cd5199103e65419c93214533.1742802856.git.mazziesaccount@gmail.com>
 <20250325-resent-presuming-39ad42e2ceef@spud>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250325-resent-presuming-39ad42e2ceef@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/03/2025 19:14, Conor Dooley wrote:
> On Mon, Mar 24, 2025 at 10:55:21AM +0200, Matti Vaittinen wrote:
>> The ROHM BD96806 is very similar to the BD96802. The differences visible
>> to the drivers is different tune voltage ranges.
>>
>> Add compatible for the ROHM BD96805 PMIC.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>
>> ---
>> Revision history:
>>   v1 => :
>>    - No changes
>> ---
>>   .../bindings/mfd/rohm,bd96802-pmic.yaml       | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
>> index d5d9e69dc0c2..c6e6be4015b2 100644
>> --- a/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml
>> @@ -4,23 +4,23 @@
>>   $id: http://devicetree.org/schemas/mfd/rohm,bd96802-pmic.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: ROHM BD96802 Scalable Power Management Integrated Circuit
>> +title: ROHM BD96802 / BD96806Scalable Power Management Integrated Circuit
>                                  ^ Missing space here :)
> 
>>   
>>   maintainers:
>>     - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
>>   
>>   description: |
>> -  BD96802Qxx-C is an automotive grade configurable Power Management
>> -  Integrated Circuit supporting Functional Safety features for application
>> +  BD96802Qxx-C and BD96806 are automotive grade configurable Power Management
>> +  Integrated Circuits supporting Functional Safety features for application
>>     processors, SoCs and FPGAs
>>   
>>   properties:
>>     compatible:
>> -    const: rohm,bd96802
>> +    enum:
>> +      - rohm,bd96802
>> +      - rohm,bd96806
>>   
>>     reg:
>> -    description:
>> -      I2C slave address.
> 
> I'd just drop this from the original.

Ah, thanks! I should've noticed this.

>>       maxItems: 1
>>   
>>     interrupts:
>> @@ -29,7 +29,8 @@ properties:
>>         for fatal IRQs which will cause the PMIC to shut down power outputs.
>>         In many systems this will shut down the SoC contolling the PMIC and
>>         connecting/handling the errb can be omitted. However, there are cases
>> -      where the SoC is not powered by the PMIC. In that case it may be
>> +      where the SoC is not powered by the PMIC or has a short time backup
>> +      energy to handle shutdown of critical hardware. In that case it may be
>>         useful to connect the errb and handle errb events.
>>       minItems: 1
>>       maxItems: 2
>> @@ -69,7 +70,7 @@ examples:
>>               interrupt-names = "intb", "errb";
>>   
>>               regulators {
>> -                buck1: BUCK1 {
>> +                buck1 {
> 
> Here too?

Yes! I had the node names with caps in downstream (due to a historical 
reasons :]) - and I did a last minute clean-up where I changed it to 
lowercase. Thanks for pointing these out!

Yours,
	-- Matti


