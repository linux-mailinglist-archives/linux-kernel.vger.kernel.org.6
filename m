Return-Path: <linux-kernel+bounces-529359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46643A423DF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F7C3A8A21
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E360225A329;
	Mon, 24 Feb 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJi61wtk"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C691537AC;
	Mon, 24 Feb 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407599; cv=none; b=ALJJIbBgN95JwCmJhY7Qm3H0SzXi8uWEZHaDdubnQLGORCVKqV70R5kAl9lYsRQS7sUrjSPtCSwqzOpZ02s8d2o9Kz/u9ciZM2j8NnMRvHewEhQ0/nkGRodGbwKUQSfX+HGs/OTPpLEhMaVfVzPbiWqCmbaVxd7PTwuKW4pu7LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407599; c=relaxed/simple;
	bh=wDbiPtUfE3pBD2ibGHCUp1eNQeURYMrRbZBQxQgN6Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRiMoWKXgubt8zQV4uHUQK5mTkQEZyubz2ZNqsVAB8TwY6AvLjzOdv6mqALEknSpyS4AFPsTUYWMkRVc7tZLiRevA48/NsMWHK+0w1O9z/p3CLbtBOo4nK4zT4W2stsBRYP7L2J+bT3199pKibWeG8r3GONZ5Tspb/EWBiV7aAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJi61wtk; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6599481a12.0;
        Mon, 24 Feb 2025 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740407596; x=1741012396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35t1hJFOdpa+T0AaHCGkVAi9es9mhFSUPTxVJx4I/9w=;
        b=FJi61wtkedOmV4HEOK7e2YvQFhSlur5GH0VGy7i/hburgQa4OXk8ji4MavVwe9mQq6
         qi5IZcKci0aavGMD2ZZUZ8LAVP143hM6S44bVltFvG6A8/pK8FmSFJq/qNwmIDkKJ3BP
         PlYtJDxQYF3PLMIImcZuRCMTse6+4yZEBH5UxWD1ykpnUdsLNllGuX5+TxqHXcvGLQ4G
         EyTXJjmL5oo6YRupzgn7kJZnaCuM2nD/yFxJ50FQjSACtdtfg6T2lCADPyBvMp0feCr+
         WlxyE0A13nrczic2YiBUXS3vUJW/FziPeO1xCjtFch/4cmxld8SadFkoeyKHBsuayG7z
         ZnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407596; x=1741012396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35t1hJFOdpa+T0AaHCGkVAi9es9mhFSUPTxVJx4I/9w=;
        b=hq2GRnbpdas0ytHNEQiBgmXj2W+Exbqxlh7DSsvUKzPp/uwvdcgSrLUAMr3YG/wkEr
         61MuUugkop058PurZHmsNDKdtE0P52tyS/rY03gsg5GoC08NuvP9z4BL1//zgRWnKh4h
         R4MXIkzzyTVcNGhVd1e0mHX2Dye+MQIJQh6SkwsZcd0T9wRTNrMuoX9sw8Mfdd1HViQ5
         1hDpfZceewhPzYizC0gUAOFeromz102aJuPoq7oCVRXvgo74AeBGuMyuQjUn2FebBQQs
         gBa6K7Sjv3IFyzp+tuHyYeQ0SIfphp4VKpUdc5wWEpW7MUjMn+hYdoKJbW92+EPcF6N3
         tvcw==
X-Forwarded-Encrypted: i=1; AJvYcCUpYKxOoet6t6qbzV57Rir3J5MQEmGykDXgjrF2PculY22GzhhSVXBGadunty2ze0ZRyB65JyXmeMlL@vger.kernel.org, AJvYcCVsdOaQJFWawiVcGP3pxzqOsm+cim5peB/wHKQa7BI3ONyRc3cJ6WHjiP/FC2HokpcWNyu3kp31kJeLyOfG@vger.kernel.org, AJvYcCW989/cm+xPpYocB88fvxI/9cNNMedLOTBcL6VftzWDMQ8SBtPX0alUYUKb9TB+JGD6oDYerJLgiMm1@vger.kernel.org
X-Gm-Message-State: AOJu0YwK3CEYumjTSNzVjEsu/g61FM/0GxE81tl+uE8doF2Qm68JTYhG
	mKGi6WUJhJV3dKpZOTJCZtrcSBLaU7R6aWEQHFnxZaCKuvzBxISS
X-Gm-Gg: ASbGncuQOyEZRYW+ovsQ1hfNO2nW9RHayygwE66H1Ae9n1LEA2rqNxU3OSHWFCrS17W
	pT/55PHLadaUtT/HTkleqhb/KlHQtY6M/e308IfZ10sZ9TsA6+qG7uaaONcXizMiG77AmKMTz9f
	XpF7pxW/lVF+vCRbMwI2taMHKa0Z7WBjrHm1TiWlsW4rS0e/0HShiXA5YPpxvhkRbCKklNdh4tJ
	TFQ0uZe2NOBnipV+eIfalVp/+PKkg7K9GzYxmDUjTJvp/0Ah8K5MwO/8rMJyqNEMNoA6uvmQl7/
	51ULpUujlRTNBIRIuQ8qzil9x/vzaWq96bS7vkwfOHh62ZkmJJg=
X-Google-Smtp-Source: AGHT+IEpuzX6lyN2J9M4/ZBYAmLlIpNrQmbES6PeBLBJOGfxNsj0XhIs5KAuBO9sPVp0JF08jFkowg==
X-Received: by 2002:a05:6402:13c8:b0:5de:d803:31f3 with SMTP id 4fb4d7f45d1cf-5e0b7222fa2mr10839330a12.21.1740407595653;
        Mon, 24 Feb 2025 06:33:15 -0800 (PST)
Received: from [192.168.5.199] ([92.120.5.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2721d9sm18891253a12.56.2025.02.24.06.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 06:33:14 -0800 (PST)
Message-ID: <36451a88-bfc6-4402-8e16-890d524a9368@gmail.com>
Date: Mon, 24 Feb 2025 16:42:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT
 freq. to 800MHz
Content-Language: en-GB
To: Adam Ford <aford173@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
 Stephen Boyd <sboyd@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, linux-clk@vger.kernel.org,
 imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lucas Stach <l.stach@pengutronix.de>
References: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
 <20250221190929.31469-5-laurentiumihalcea111@gmail.com>
 <CAHCN7xL=QZHs5sD7Ja7pBOcXM8cWVQYe270EizDFN--CH_5+zQ@mail.gmail.com>
From: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
In-Reply-To: <CAHCN7xL=QZHs5sD7Ja7pBOcXM8cWVQYe270EizDFN--CH_5+zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 21.02.2025 21:37, Adam Ford wrote:
> On Fri, Feb 21, 2025 at 1:11 PM Laurentiu Mihalcea
> <laurentiumihalcea111@gmail.com> wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> AUDIO_AXI_CLK_ROOT can't run at currently requested 600MHz w/ its parent
>> SYS_PLL1 configured at 800MHz. Configure it to run at 800MHz as some
>> applications running on the DSP expect the core to run at this frequency
>> anyways. This change also affects the AUDIOMIX NoC.
> Unless I am missing something, the i.MX 8M Plus Applications Processor
> Datasheet (rev 2.1)  has a table of frequencies, and
> AUDIO_AXI_CLK_ROOT is shown to be 600MHz nominal and 800MHz for
> overdrive.  I agree that it's likely not running at 600MHz now, but
> 800MHz may be out of spec for people who are using the nominal voltage
> instead of the overdrive, since overdrive requires higher voltages
> than the nominal.
>
> adam


You're right, this would not work if someone was using

nominal voltage. Do you have an upstream board in mind/usecase which

works with nominal voltage instead of overdrive? As far as I understood from

Lucas's patch ([1]) there's no upstream board using nominal voltage?


CC-ing Lucas on this as his patch ([1]) is similar to this in that they're both

trying to use overdrive clock frequencies in the DTSI and I'd very much like

to have some sort of consistency in the DTSI if possible.



[1]: https://lore.kernel.org/imx/20250204182737.3361431-1-l.stach@pengutronix.de/


