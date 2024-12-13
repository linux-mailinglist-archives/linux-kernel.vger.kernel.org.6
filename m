Return-Path: <linux-kernel+bounces-444637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4F9F0A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1B4188C0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677291C3BF9;
	Fri, 13 Dec 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vratCu3Z"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054E1C1F03
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087028; cv=none; b=kKg+KAaBAU1X9pU/HY8iiP78Z+oRrFOs37iCnCW5eh+UoF9gEitv2rTZVEkPXBRsJBMo/Yyah/rq1w8leO1Q+PE4lpszmEZFw/c1nimCrQVsJ8mCbAi88VV4IvC1+UY98n7WdF+HkGJEH5wKI8wxafgXZcZxulmf7i4RBClVBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087028; c=relaxed/simple;
	bh=gA3Q4ub77tN7sCgmbLmkx712qJth2K3MCOGVKBn36q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDRK2mNkiUgn/vdJ6gIWv6JYMrEMTLVe7Y/ejJIZfLvYO5UEX7pd/uoThGmHWAUwQNRBSJaUSdbPNsCZUk90b51cGnph9UnQJPXqadnigTX2nMXc9VCfebkbYaco6xfRcd3+NYh8b6W+4Ru2z6q1MePMT0Yflg6EaLHDKFm5/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vratCu3Z; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5401c2bb7ccso213750e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 02:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734087024; x=1734691824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsMZoEd++TbxWw8duLL2sE2JWkwl2EC+I98Ex9pn+ng=;
        b=vratCu3ZOK2VjDZsyyhZXVv9HNetkP/G4PvP+34XY1/d+M2FUCE7vzT1LnnU2g6+Fl
         IOTvH5GXU/PjR8LtEF4LsaM1hQd5p7EFaIHDjNWmaHcZ4zdLjZDYR9mVgm8KbXwWiMLy
         m0NTcUV7sj8tLlFzUrKU3vyd6rJH9ESvg4Zb7uSfRcNJdYux600bygK421n5ybWhpZF1
         YIOeLHaILcPxIQ15A4Pa5G1QfbCZDIqTzkOMdGhrCvJHQY/wxXo/0AYkqNrRE6SwJ4ti
         IS7AnupvBIzj/Rw5sr1BB6Lj0lvBSUDy1K7xdfUqJP7BIIJyBVlMf+aw/nO8PpuelNJ1
         KqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734087024; x=1734691824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsMZoEd++TbxWw8duLL2sE2JWkwl2EC+I98Ex9pn+ng=;
        b=rOANJpPTU24eqacYK8aVVa/tmb5TI5C6cjPiWYieeX2H1oG/ugwWfNEkE8hCEh71fg
         KXDOCIdxYuHM/P7Diz3DBsAd3OdDL9NxpzOuIgU2ECvJLAh15ysvKi8i1kUPGNIM1EuB
         bQ09pQIdF1JG4/nkMhLhc7FkauCrNln+Ql+E7vK6K1VheHP/KqA7jzcf08rsP2cHj6zO
         TqeyJPI43RnYdkN1en36SAuWwjqRJIIcTrWteXeMLW/UlsCV4PbkVcNvsbBQOpEKGRZg
         XfBR9+msy5Gcrx9CbaOOTHevLUr4g7+JjDRZpJaCuyB38VuA1PvAyIjFPpLNJJJtafkg
         K0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX/vS2JULoS4ig0AbnHkAN7NqGq4OOjiM80OELMRVyrh3JWIhGI8I3vHwTEOV42eVVd02Ujo2iHQhFjIak=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAWr0s2Dlm7Y4cwIcVE/bP87bAJ8gUYWxsgNMkynFVl3qcgiz
	Qmz/SjKBo1J/D6PaGTE+Sa8BKe8qOE4OWkHcJCsdowZXrcGpnC5d57qLkhU30uY=
X-Gm-Gg: ASbGncss8ZdAuX+aaoeswV9qPeFknqOAtyTddC2cd3n+EpsNHb0m/kunJFynXqhVprs
	ucvdVtZfuLtDXtc68E94KEQWNE0EysrC7L700k9RGALdqBtifmASFfhbDZtP4ERpU/rt2WwIsR0
	xq4qX2jAU+zt0HMQETfp6mo3Wlg4SXGu6+rVd3IVO060VRD7ZugZVURztuBVVWI1wOTi2KWsYEo
	+zEG+4Nf2pOkinKPRIl77I66GD2J3fDPedjajeiOp8oWpen/rlh6oGiJaX/HHHjaBUtLCBzCGc1
	4c+BMGdWGZxdd+RCf1r1H2bDolXK4i5kD04=
X-Google-Smtp-Source: AGHT+IGw9a1uX5hBegI8/sPSllQufUgfjzOPxBgUy3/5ZZqbN7RuVYinY4oCJlX1bIMH1dO35Vhc1Q==
X-Received: by 2002:a05:6512:1594:b0:540:1b7e:c8ee with SMTP id 2adb3069b0e04-54090557f27mr229332e87.4.1734087023952;
        Fri, 13 Dec 2024 02:50:23 -0800 (PST)
Received: from [192.168.1.4] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54016a1cea6sm1888692e87.41.2024.12.13.02.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 02:50:22 -0800 (PST)
Message-ID: <e4bd515a-eb98-4ea1-8d73-4ba5e7c9b66e@linaro.org>
Date: Fri, 13 Dec 2024 12:50:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: dt-bindings: media: camss: Restrict bus-type
 property
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Barnabas Czeman <barnabas.czeman@mainlining.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, David Heidelberg
 <david@ixit.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209-camss-dphy-v1-0-5f1b6f25ed92@fairphone.com>
 <20241209-camss-dphy-v1-1-5f1b6f25ed92@fairphone.com>
 <nqggstwkytqxpxy3iuhkl6tup5elf45lqi3qlgyv6eaizvnfdr@2uy57umdzqfa>
Content-Language: ru-RU
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <nqggstwkytqxpxy3iuhkl6tup5elf45lqi3qlgyv6eaizvnfdr@2uy57umdzqfa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/24 11:34, Krzysztof Kozlowski wrote:
> On Mon, Dec 09, 2024 at 01:01:05PM +0100, Luca Weiss wrote:
>> The CSIPHY of Qualcomm SoCs support both D-PHY and C-PHY standards for
>> CSI-2, but not any others so restrict the bus-type property describing
>> this to the supported values.
>>
>> The only exception here is MSM8916 which only supports D-PHY. C-PHY was
>> introduced with newer SoCs.
>>
>> Do note, that currently the Linux driver only supports D-PHY.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   .../bindings/media/qcom,msm8916-camss.yaml         |  8 ++++++
>>   .../bindings/media/qcom,msm8953-camss.yaml         | 15 +++++++++++
>>   .../bindings/media/qcom,msm8996-camss.yaml         | 20 +++++++++++++++
>>   .../bindings/media/qcom,sc8280xp-camss.yaml        | 20 +++++++++++++++
>>   .../bindings/media/qcom,sdm660-camss.yaml          | 20 +++++++++++++++
>>   .../bindings/media/qcom,sdm845-camss.yaml          | 20 +++++++++++++++
>>   .../bindings/media/qcom,sm8250-camss.yaml          | 30 ++++++++++++++++++++++
>>   7 files changed, 133 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
>> index 9cc0a968a401836814560c1af3ee84d946500b4f..3de2a3d2b5b761106975aab65ff614b2ef579ef5 100644
>> --- a/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
>> +++ b/Documentation/devicetree/bindings/media/qcom,msm8916-camss.yaml
>> @@ -94,6 +94,10 @@ properties:
>>                   minItems: 1
>>                   maxItems: 4
>>   
>> +              bus-type:
>> +                enum:
>> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
>> +
>>               required:
>>                 - data-lanes
>>   
>> @@ -113,6 +117,10 @@ properties:
>>                   minItems: 1
>>                   maxItems: 4
>>   
>> +              bus-type:
>> +                enum:
>> +                  - 4 # MEDIA_BUS_TYPE_CSI2_DPHY
>> +

But is it really needed to specify the single supported bus-type?

I believe it is not, at least it's not ever done for other media devices
like sensors.

Here I would prefer to get a comment from Linux Media and/or DTB experts.

--
Best wishes,
Vladimir

