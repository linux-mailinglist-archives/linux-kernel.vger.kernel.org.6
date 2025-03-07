Return-Path: <linux-kernel+bounces-551188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDA0A56922
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F2A7A9AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838E421A443;
	Fri,  7 Mar 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jwjdlpw8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96821A427
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354893; cv=none; b=S7sWjVQAHJfdcbjzY9hQKSqRCowxAoy/UqRz9qiMWWY/+mTL2n2ioDMVIB0mI5bc7fsEIJCTp6SWJYnDHjrG6qA2pKKSexXMSWHY2Ha1MnMuKlsx2WOA4H4rYLc5pU1rTn7w7GYOfrV2QPZuwmfv1E/dX10HBXk7/7FeOTqeW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354893; c=relaxed/simple;
	bh=PHpi5XvyBqc7RYjd0LNOqS4ffTkxrcCU6DJ5Q+d7Jhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDUciCCpWdIBh55sfKOS6oitKrngioYRZx6hxLHhRLsR0l4dfhZ8UGaQ6l630+rvHMS2s6MfZhTeqpIwtDzdbcvDLVL+dxYKBmAX7va9zgIeVoz8IYc4x6EHsC7TShfu2SbnJfh5RmGDa9ktpRKCg92SvwbavSdOIxXPlN1yLaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jwjdlpw8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43bbb440520so21153405e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741354890; x=1741959690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wnpq90gndb3rdffDLSBDxvMtInTzFta2IqlE4IcQ4L8=;
        b=Jwjdlpw8SjVy1qcU7SyalcLvmMK8PkSzjUFBc1u49TDrTrPdF5SXLDV2Hovi0H0Afe
         L/n27LEQY50aiXlfE9N+PXCAnqa7U1qSP1ZYb3wioAEFhBitiZh3LjuCKlKyFuHjV+JI
         6xV+LPxJUXrETQ8dfVXLuoSp9q1TC7DKzxp+SnbN9fS2HgSvgnno2pX3vxw6K3kg5t2l
         LEMxo8mL7IEyWcLU3uWUk1Ow4xbIDsolxRlHuTd8sO/xP1OAcl4/76aD+Da4aNgYaRr0
         Vy3u4SHTmF71weuNnCXP5vh4QO9y9kNuBb3k74jXk0s5E/+icl0bZSTgTPRwB4rOJ7s8
         tYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741354890; x=1741959690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wnpq90gndb3rdffDLSBDxvMtInTzFta2IqlE4IcQ4L8=;
        b=Hm5dx7C4gp5LaYqa550VZ40yT0vcRdqQB43Jzi6xcSj/kYdG8n+lHoIMzopdWRwDlu
         G8Ua1FVmeZo7qKLJqFDWVJANoQSXJu2h3OuZqiWxg0rq/uOCNUoYCbFPGnTMcOrSa1aP
         hvYX3g8WD9lKG4EfzesT3HzescjpKjkALzCjwhgE25Mk8hgbRZgbAhLrQnK7mqIFtzJl
         zu8+w9iTjKnya5hYV3X/ncf7+vIzVEQvhA5xTsvT/5MakKRfBhh/pEpeoc9mfi/j4BOU
         kHNKKN8ySfVEPfiQ/6CTkkkw2z8V54x104BDrBueFkXWygAANZcNU8wHaGUMPNRs2Wrw
         kvCg==
X-Forwarded-Encrypted: i=1; AJvYcCVimgtBMM2JXJo8hZphwtxf+sQlhGhTZheLV3T/b7AFwIif0WnSp7lJkZwZB7EYIJw7UAvI4279TLRpIR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNnhZGgSWOpD/Q4VdphVHkykk1avyrgxcnFoT/vUTtWzaYWDK
	UdvJT0y4gFTXfqVQc2Y53bmcxfP47vK0U7rLagsMsDlyEZ0FoKltwYV/Oz2QEfA=
X-Gm-Gg: ASbGncsW2WpFyto4+7exXAZu5vzWcouYzqlyi4gi2lplH05Qhapkk01KyL+T4h8ZJ6O
	i/sQYgQn/l1M5l4qmPh9sXuQPakD++ip7Y1LRW4pNg/2ylqxRFuJ4wINlOivq8kguNLodxzHxqB
	CA4xUSwavSprugYql0rxrBaqodxZECaJQvkhDcupy+YJ/XY1tfjDt/aOibSLvlBvI9z/n00GKOJ
	IgCRIT5Ny+VCDsCpjbVWxpySGT/1kGT/VrIoocVQNsZc7JyW+FIrByBFI2whij9tKFHxa29WyX+
	3FIgyDIlAipe0MZLdOogXBylVxmJxlJk7vB5/S2ByWdSoTJPz+8NgbzQiID+Qep0ilP9q5IOWeB
	PnrvkRZn2
X-Google-Smtp-Source: AGHT+IG/uWf+UVgof5cubqjmo0ExDC6v6Ne493gTgOgXTmGEXD7gtw3zrQaW4WAMMzpMlDe7ybkJHQ==
X-Received: by 2002:a05:600c:524d:b0:439:86fb:7325 with SMTP id 5b1f17b1804b1-43c60231b64mr34423495e9.31.1741354890121;
        Fri, 07 Mar 2025 05:41:30 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43bd4293250sm80876855e9.16.2025.03.07.05.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 05:41:29 -0800 (PST)
Message-ID: <21ea3de4-ca42-4576-a4ec-b89b3e2a2ac9@linaro.org>
Date: Fri, 7 Mar 2025 14:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when clock source is not registered
To: Krzysztof Kozlowski <krzk@kernel.org>,
 stephen eta zhou <stephen.eta.zhou@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BYAPR12MB3205C9C87EB560CA0CC4984BD5FB2@BYAPR12MB3205.namprd12.prod.outlook.com>
 <198fe423-e797-4a82-a509-ee06ca05466e@linaro.org>
 <e6cda34e-f363-4fae-897f-f4deb7c6bddc@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e6cda34e-f363-4fae-897f-f4deb7c6bddc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Krzysztof,

On 07/03/2025 12:17, Krzysztof Kozlowski wrote:
> On 07/03/2025 09:10, Daniel Lezcano wrote:
>>
>> Hi Stephen,
>>
>> thanks for the proposed fix
>>
>> On 21/02/2025 04:46, stephen eta zhou wrote:
>>> Hi daniel
>>>
>>> While debugging on the vexpress-v2p-ca9 platform, I discovered that the read_current_timer API wasn't functioning correctly. The issue was that the SP804 driver lacked ARM32 support and did not register read_current_timer. To add ARM32 compatibility, I’ve submitted this patch. Without it, using SP804 as the timer on ARM32 causes issues with boot_init_stack_canary when inserting the canary value into the interrupt stack, and also affects entropy generation and collection, resulting in incorrect rdseed values.
>>
>> It is better to put that information in the changelog and provide a
>> fixed format of the patch description.
> Daniel,
> 
> In case you actually consider applying this - some of the patches or
> their descriptions were generated by sort of AI tools, thus approach
> with caution.
> 
> It was already pointed out that patches might be a garbage output of AI.
> Also they were not tested, even though what is claimed here "debugging
> on ...".

Oh! Thanks for letting me know that, I appreciate

I'll pay double attention to the patches.

Thanks

   -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

