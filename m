Return-Path: <linux-kernel+bounces-300069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFBD95DE69
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877EF2830F7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC2417A58A;
	Sat, 24 Aug 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RDf297Dm"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CCC178388
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724509972; cv=none; b=hLzIhi6Pzq0HNG2ud935elB36i1ODNqcohbuw1OlpWSu4ycJVkpCuOCGP4TrO2Rzet8yWpu+CpGMY90Bhf9j8+U2SmUkBM3z6pwfcmgGXQN/3aa/i2VL9LXHateaRC7f9MpzITDXUKD0nb6plNXeeDnwP5VpS2l4C1qGjgWI1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724509972; c=relaxed/simple;
	bh=1PsfB+rHrgqHbrQN86fjVZ6rZhaJdcoXh66gjlAH/F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bLv9Ine5Jd76dLc5S2UxAfCxTZdPiImJ0w265quVAcF13dQEy7K3ddyMkXckvETInB6MqRbl1cbJDsUgbagtDM0I0apcHNrhhKl/y00Hd1sOEoteKfjWJmTugy7yrli28uVxCN8DAEEhGxJXiMIHtSm5qK+jfHoDh3tAPhHrNPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RDf297Dm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bed05c0a2fso3639471a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724509969; x=1725114769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/TVnTWQZLeuF1YlGpoUoliOWJccvcVuCE3y4qrw9zA=;
        b=RDf297Dmv8sOMnWnnTeaZm6sa6JICwDvf3YtcdqFEYX6gfTFOlUzQI8VR/FLGThwfS
         5Pw7ajvU4yOHaQA49HjJ01IWPt5sK1i6ZcL45KCVD58KND/YYr2N8pc6Ys62g5HHTFTH
         yXP7cdkYWQPgtUJXtNujNIxKRfOZ1kylEuVCaRtG1ifIWY356tyUMtAYmL9cd1o88U28
         y053odkIodhTCrZP8loNMxytXVc9/KiUgBm1YxyudGKHYopd4JojaJhBh6tjbiDzjBTY
         TIKgxyVpNTrui9Fcjyph0RlhdE2j4m6AlFg8OU1CtxqynNy827VdifqXQ6Q0fHSa9auk
         ZzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724509969; x=1725114769;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/TVnTWQZLeuF1YlGpoUoliOWJccvcVuCE3y4qrw9zA=;
        b=b8ufdAhVim8Z9LxzSxWgr/+Nc7JBF11+c7hXVP1WpnK3beBMoz0wdhIG+KrkB5j92j
         10Sgs96nVIbl/Y9lg+XsZt1Xgp/DHJUbW+1wP6wWdFgzORylsM1zKf5RZdAs5U6qmq4D
         0+1y4LgVZP2fG2xUpnZt6YD0w0kqbFrIfLUVZVRkd2neLmfDtwGvTSwfOi/ZyvRyU7YQ
         VZyylMAdINplO/3F4+e5VWJbpf7utLXH5FY/KdngU0WjXyoyyGuGtdLutG+D2sBUv19J
         YPmgC+Ts+1bfSCY4fApYub3e+KUxjCJ+DHchFtqzl+Fpuu3bT1Ls7bWQomgA7gMDAh9p
         ifYw==
X-Forwarded-Encrypted: i=1; AJvYcCU656nmwX0lyoDvGkGtvUOrjvZFO7ube7j7JZ5vyItBTcP3IfMIkgeGKClX/GY9OQe7p8rJYF5BaTj+gG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlS6y8yQIBxtR59q3/qKHvsNfdYWdIxWx5EP9Eb25hr3/Yf1eD
	avkH7cMkv92jljhaXMIKv0TG8sfZ/wtfKPGZGRX+R2pmLNkdspypX/4i9f/JZSE=
X-Google-Smtp-Source: AGHT+IHbxK6aJ/f3L9Ar5x/8h6TtLTBqamTkvlvejj9FPZTtGh+zJ2LUqF9K0UiRaNvGOd4HXoT0WQ==
X-Received: by 2002:a17:906:fe4b:b0:a7a:bae8:f2a1 with SMTP id a640c23a62f3a-a86a54899f5mr423380466b.42.1724509968522;
        Sat, 24 Aug 2024 07:32:48 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f222b23sm413681866b.19.2024.08.24.07.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 07:32:47 -0700 (PDT)
Message-ID: <605ff021-0770-4363-9734-ad8114a429f9@tuxon.dev>
Date: Sat, 24 Aug 2024 17:32:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] ARM: dts: microchip: Remove additional compatible
 string from PIO3 pinctrl nodes
Content-Language: en-US
To: Manikandan Muralidharan <manikandan.m@microchip.com>,
 linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240814061315.112564-1-manikandan.m@microchip.com>
 <20240814061315.112564-3-manikandan.m@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240814061315.112564-3-manikandan.m@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.08.2024 09:13, Manikandan Muralidharan wrote:
> The driver data specific to each pinctrl GPIO bank compatible nodes are not
> the same and declaring additional compatible string as fallback has no
> specific purpose, hence, removing the additional compatible string from the
> pinctrl nodes in DT to comply with atmel,at91-pinctrl.txt documentation.
> 
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Applied to at91-dt, thanks!

