Return-Path: <linux-kernel+bounces-403930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E319C3CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BA0281084
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB94B189BB0;
	Mon, 11 Nov 2024 11:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RFe5ho+3"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CF13C670
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323775; cv=none; b=c5IYt1UnvCEoaB2rCZGrLhKxuOZ47Kgd2lU+4vbPrR2n7BOECKlH28oVC3e2JWczQqz5hrCmD0ecYH5uuRM7tBowl5dcLQ8Zz/xjlKM9DjdWWtGYM4SnsCrtxn91XJ/zpgVboUBMCOa1MVEhZjvWZ885uY4f2tTq8EpTVKXMM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323775; c=relaxed/simple;
	bh=driMdGrMh2CQU3EhaccQrwFYyIsDDb/uDW3/8Wb/CZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG3aIqxLiAe1jSKOkQCgftGm9hg1IkSSiL3d4uZIk5RxbkDJKF45RZ9l/myhmQepmNwZtOVEHiS0b2pJx68VYqK36WC/yFEFkdxFnlCvhmnsiUD9h43iiIpN90zvitfc6ZXwGjFlMhdIA01F1idh8zbRDg1j+bU3BIkUOOEUF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RFe5ho+3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9eb68e0bd1so625209466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731323772; x=1731928572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymcL/BmbTqU8qfDUCoVyraAtY6xWOZahvC7lOWoyBMo=;
        b=RFe5ho+3CKXVrNqbTNxvWa0N7t7htxFN003LZo5VhmJnf/rpIjbJlwJSuSDMCk34HT
         ym6NvcChK8jlHp1xmwcUF/sollyFfXuyI2aJhHO5vgEBTZi+hyUNwOdcer02RyNG95rQ
         zkrnQfHhVFxjO2M50eMNe5imd6UR62YiAbwRBK0XrQgv8cB6LEs+MmUel1rsjcmzVkcQ
         Y6B0DI9cIhuakDYR329jKK8rLZOf3kIZScynlsYNig1wh5C+L5G8WjOoeoRtdiwjhaQt
         MLp9Grht7RMNPitkE3Bf8PUAG2IsbGWZdRu3iNcEPZJTKWGdAM8Jp31KdqX/mrg6mkLi
         2hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731323772; x=1731928572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymcL/BmbTqU8qfDUCoVyraAtY6xWOZahvC7lOWoyBMo=;
        b=mMu4EnnjfDLLyIGHNZsv9DNhZLPwsklm2zOrG1bmMlaBfRuWZS/mCoUeNwZjpvE4ty
         Tziqel8bSGKUUJcakom1VNg051lnLa27CbVtc+OwlKyyb73Ph8qlAjr7YZoTwQ2XAZFy
         pcySaY2PjLW555XEIdVFasOxJEO+ZO7+k/49ax+Hk2/erSmI7aSiHpWDOnYPts/SvXYq
         76zFIJEQbnRppy0u8ABCm4iXRMxrAOsFOf8bru2YrCBl2iP1iL0ASU9L+UbnSg7HIfel
         EI4CSjHucZ1EUCfY3TFCS0JYdKrCmvfGsVRPLxdFKyNBJvq1KvCaHF+6E4VRLdDyZpzP
         GKkg==
X-Forwarded-Encrypted: i=1; AJvYcCX9Em8ZC/l4VZMC9wH6pDCYXeduJ5xTB82VW8kuE1obsbtU1UbJc9uywzOBvJT5xzy3a762Gdcg1SLmsGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdy9CuX9D7UduUsI0zb7WzF3vuvNzxZdH8fAhPr2cA5JCp/SJt
	X5hctOoOddJOteX8M6Y7H/OwdTmnIJ9q9tb61eBxubTolREz4CTnRAwBoD76uJE=
X-Google-Smtp-Source: AGHT+IEIXXKEeW8AK/XEUpMILAea87VIswegaWQL9LSGa2DctrGMApRhmo53B5f76Sl4Kpl0fHqtKw==
X-Received: by 2002:a17:907:94ca:b0:a99:2ab0:d973 with SMTP id a640c23a62f3a-a9ef001b427mr1296793366b.55.1731323771938;
        Mon, 11 Nov 2024 03:16:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176cbsm593593066b.23.2024.11.11.03.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 03:16:11 -0800 (PST)
Message-ID: <42c5da73-466e-4238-8862-dbe727d3bf3f@tuxon.dev>
Date: Mon, 11 Nov 2024 13:16:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] ASoC: sh: rz-ssi: Terminate all the DMA
 transactions
Content-Language: en-US
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 lgirdwood@gmail.com, broonie@kernel.org, magnus.damm@gmail.com,
 linus.walleij@linaro.org, perex@perex.cz, tiwai@suse.com,
 p.zabel@pengutronix.de, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-gpio@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20241108104958.2931943-1-claudiu.beznea.uj@bp.renesas.com>
 <20241108104958.2931943-7-claudiu.beznea.uj@bp.renesas.com>
 <87ldxqmwdc.wl-kuninori.morimoto.gx@renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <87ldxqmwdc.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Kuninori,

On 11.11.2024 02:45, Kuninori Morimoto wrote:
> 
> Hi Claudiu
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> In case of full duplex the 1st closed stream doesn't benefit from the
>> dmaengine_terminate_async(). Call it after the companion stream is
>> closed.
>>
>> Fixes: 26ac471c5354 ("ASoC: sh: rz-ssi: Add SSI DMAC support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> (snip)
>>  sound/soc/renesas/rz-ssi.c | 8 ++++++--
> 
> We are now using "renesas" dir, so, you want to use "ASoC: renesas:"
> instead of "ASoC: sh:" in Subject ?

You're right! I'll update it.

Thank you,
Claudiu Beznea


> 
> 
> Thank you for your help !!
> 
> Best regards
> ---
> Kuninori Morimoto

