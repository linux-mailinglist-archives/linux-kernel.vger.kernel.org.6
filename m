Return-Path: <linux-kernel+bounces-546186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F70A4F774
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAEE7A3588
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B439F1E991A;
	Wed,  5 Mar 2025 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3wFOnIo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF21E0DB3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741157291; cv=none; b=QXx3xcGyEoPgUM2aQLXz+i6On25OUWlNPPJF8c2qw7Q+LqExLL0foMBdC2DCla33EyqsTj+OfmJwsN4scnvBQ4P6GBCfLR3wErJecc6/IiT11sFw0X9bKBDY+u5C+XTgKsnAkmJ+fJ4Z+ixy0UBjCrTWyIfxYzK8MniKAOIMEJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741157291; c=relaxed/simple;
	bh=BLH6AL1TGc+pTvZHjMqurmf3rgyNZojd+7bDocgjQq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5mn8Tz4PfLfSw1EmCUsVrHeQDg7ZhCiH/V0rsqDYEEMeSLWemVvBm/C51CJTWfFbacBoj8FGgd7Wgm6y7yVKxcXuD0T8Nkpl3HC6g21GvuCrT+TA+1IeT1gbupsfg9uv5cQeunEnKtqJlhSV2X1GZQCLWlIiPPVq2EOlZoGd3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i3wFOnIo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43937d315abso7043955e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 22:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741157287; x=1741762087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SOQdhzGnQUYcwQ4uX7XN9AZhels6Wv9CSjDPBVahVNY=;
        b=i3wFOnIoZxPl58yo4Mt3GqVpIINIKfHnr1/uYRuOk13TdcHGgiCFyrRKicNjgS1weE
         dkl5oxn5CTya/AbOjXj1XIVagM33BPt6i5+bAS5+JisZwS4VX9IX0KFi1rvMazXpJNCk
         IVl1o2LhEJvFFEkrGIkXDhGPF9yYU6ZixhkzfJi1PsvqpCCIShU2DZjnEboeH+DtOboE
         QKVd8UaFLHfCSVns4zgMivaSgapL5gH3jkf+vyZGt+K/12NxOfOlgMJZbjNwwikZ/Mkq
         FZHnK8XvSytsNXmw+WXJGIVAeUn6h41DlTDX7hq/iV2kfSBfofvxvFLZ040PI64J8AW2
         Iogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741157287; x=1741762087;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOQdhzGnQUYcwQ4uX7XN9AZhels6Wv9CSjDPBVahVNY=;
        b=Utkt/BOZAj5iupXhCf3n2jiJshINknC+HF8rhWXYcBEoEMuUaT2PZKvEUVuggZs1pa
         WpY+c+x3ljK0lyjUr5LW9i9bgoaC9P1/F2YTdUlib4F3Lc9RO5xPUfut/tyqaln+xYu+
         N1eaKWJr5VeWIns1UGt4vvtmyM9tRjKLCG5wQAgDO3/voELUpOdWNkiqJEnrQ7B8Kqnw
         b+8I+yRHFBHCMwCZK3GMIzeJi/Pdah0kAa7ELwxHB3M0K7346M7FHR9s1kZsKLBixuZB
         niRoOMAwMDVHx+EG33gtoPiagloWPSQe5D2NED7wyucEZN7veOCTVjHp5RFZe6isIn9k
         uBXg==
X-Forwarded-Encrypted: i=1; AJvYcCXTPncFFwmYsZo2NbDg2Now6nPDMdH7heP05YpsTodwNWKKIlxWvLL5ydWxXMSdsShlodaK/K5GT73gB3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DyuwV/RKVdmlLmoGNRy3I570ti9VbpwdgAcU23AA5HSc0pLy
	5rv+hPjKn0YrrVbfc0kdh6cbSL8oBKDgip/plZ6lHDivcpz706NIKSWwdBVp1DHat6Ig4ULrQ5l
	HdHI=
X-Gm-Gg: ASbGncsKJ1TYTqFddETR22p8y4K/7su7noexmAQGuVmIJPAeaYojuUdC5P+iy/42dEB
	n64Uov4qOodMI4RrfKSTnD8A2K6pxslt84gh+HAyX9T3qIPn6G/C4++ylF0xhGMvp5vTGi67u1v
	Q5z+/M6YD6cUIK27ZPF7snTfSJ6kddDfNL7jkr85SWAf3wuUZlPC66CIWOLfspW1V49J0Qj2Uge
	L0xcj5dfjtcYLEQBZaMkmGTQ0CMtnRfmlS2bGqkF2Ay1O8z3GwDq2WPnvqfwGOvjc2Bdaqa9jyU
	7SgRn527czG/Ufyc8uelEIJjetzjGcKyp6CoJ/+SJpxi1UOfjNUubbV5Ciiu98w0
X-Google-Smtp-Source: AGHT+IGDXVqNPNHbmJ9TkcqIlFGmvsggbWP9OrCnQnN89kozVOt49/K8XpxmUqqWAhnMdkzyE8poWQ==
X-Received: by 2002:a5d:6c63:0:b0:38d:e078:4393 with SMTP id ffacd0b85a97d-3911f7465d9mr367912f8f.6.1741157287258;
        Tue, 04 Mar 2025 22:48:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d1dsm20209777f8f.56.2025.03.04.22.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 22:48:06 -0800 (PST)
Message-ID: <64cb6810-4a75-4313-8d66-d773798f5a1b@linaro.org>
Date: Wed, 5 Mar 2025 07:48:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/13] arm: dts: qcom: Switch to undeprecated
 qcom,calibration-variant
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
 <174110761299.741733.15423494263862521182.b4-ty@kernel.org>
 <d5l3bsozn2sauenlyjolb45hqgiiachixxycziuyfsxch3ypvd@mjb6whdyjztw>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d5l3bsozn2sauenlyjolb45hqgiiachixxycziuyfsxch3ypvd@mjb6whdyjztw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2025 21:50, Dmitry Baryshkov wrote:
> On Tue, Mar 04, 2025 at 11:00:10AM -0600, Bjorn Andersson wrote:
>>
>> On Tue, 25 Feb 2025 10:58:57 +0100, Krzysztof Kozlowski wrote:
>>> Dependency
>>> ==========
>>> RFC, because this should be merged release after driver support is
>>> merged:
>>> https://lore.kernel.org/linux-devicetree/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org/T/#t
>>>
>>> Change will affect out of tree users, like other projects, of this DTS.
>>>
>>> [...]
>>
>> Applied, thanks!
> 
> Applying it too early might break WiFi on those boards. I think

It is just non-bisectable, so that's why I put above remark.

> Krzysztof explicitly asked for it to be merged in +1 release, when the
> driver changes are in.

Yeah, that was the point.


Best regards,
Krzysztof

