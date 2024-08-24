Return-Path: <linux-kernel+bounces-300134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3095DF30
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 19:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3B82829CE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6682F4D8A7;
	Sat, 24 Aug 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="q+8E5rrz"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF344C94
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520494; cv=none; b=kzHm4YATw3lHrEZbQrYhImRKnbjqk3LUS9TtnLKKf5VmZFmgippWJ9SR4zGmQeiYt8qAabWehtzF8THEVlt5/feZdCDR123PN9j1myyxovRWTiLuyZXvB8ACBBsQmNcuqjDQUct5Uxm7uHQ34pbI/fwzlLe0tQAT6j15rRJHNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520494; c=relaxed/simple;
	bh=G+DYGeNowrK9DfjtX6jb02BsxwxQEtXCFbG3AWjzsO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuYBptWg1t1RWBC+lMXQvrzKxI3KgVTTmlDkkoJ+o8HtMRHX82SK/hd1gmPKJ9CLRCXKtpwe+xHEJ4dwOJ8JJdCcnb56OkGhyP0RRqdEdIq2cedmhk/PDUgZXEEoacTpOWTfTymDeTvzJJl73KiWyPTERKHR2qpvf5+ae2fPfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=q+8E5rrz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a83597ce5beso462645266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724520491; x=1725125291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAjX8uJ5kKnKORpPTokQbusW5FK9D7CYGqN4q6ZCkB8=;
        b=q+8E5rrzJs1nHbByqL5F5ldj9J8lnGE7cMcsM0v+iahE4FJwrhVn+qA1k0aXuGOs9c
         FY1fNbUZUP0FCNeXRT1w7P43KviW1PUcGHGojZHHoUBb+lKGaZSO00Mo5LMsuzASLl5d
         2lHScEWbd1YL/UrOv2PhJfxUSCK0Y276vLsgBZZjYSmMQSkvqsK6m/EEir70yKAhwFH+
         NXA/zfj594YKbhjiFfvDZLDfrPbxxWEKXvhq0LCAANA+pq9TIwMNytaljIVdDOxYnbD8
         kt+87HwgG37te7U7Oo59DD3rqHpidjcCe3goviC6WkB0uaeQ9158l5C8OKsrrJaoMKZE
         MpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724520491; x=1725125291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAjX8uJ5kKnKORpPTokQbusW5FK9D7CYGqN4q6ZCkB8=;
        b=agM8sqc95G0LlhQ4iXcxWWYxMCUaPnnyocSDStZ+slCCsY2HMZHMY3M7WO4LB+riq4
         hwfTK4zs771Wijqh/z0IlLxPvdtTzcZJzCABj+QNE6BO6SSMd7Z3kpzvRg/F2WHfApcN
         94Cu7226Q0N5f1kiU3tzk/5T7/eNF6Zd+RvqxpliUDabXSjHMX6DIuPTrKGdjkrxcGHs
         1ngodrh+14WPM7eDd8wnLhLKiZnx5JD1EteVb0IfWg7qHX6rIPH1gXpajtyzHaTYVYnl
         ldhxYsMXucrdrjwOkNkP0NLBHkCHxq+wvLJlWBKCNxYykeKqFVtTfamY/SRaDLLWY81f
         Pscw==
X-Forwarded-Encrypted: i=1; AJvYcCWu8HXu2k1xOsbM5LOVtuQc1hCQjeZaqPjmoIaviLBm5N/6a1Mili04WOTXf3F1M4Y5OALAAi7Jhjk0RUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynbx+6bI2MvSE12wEShUd0NsD6hR29v6RGHGkrrrdgCDCfO6TN
	fg4vnxXGih/hD/vL1TKjbFzuONcUtQ4rpRuBpShNuWvNprbQqwGue6hLA5exkcE=
X-Google-Smtp-Source: AGHT+IGkZmS3th7XQ+DNJRc7J1ksjGqSiB6v4AK9SrH8RDtAdo9Neq+o7kwWVAjvRjKkO6ui7OWhww==
X-Received: by 2002:a17:907:d89:b0:a7a:bae8:f2b5 with SMTP id a640c23a62f3a-a86a313765bmr425883266b.36.1724520490524;
        Sat, 24 Aug 2024 10:28:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2a5077sm425612966b.69.2024.08.24.10.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 10:28:10 -0700 (PDT)
Message-ID: <1f570dfd-ca07-4dfc-8c2b-de551cf24415@tuxon.dev>
Date: Sat, 24 Aug 2024 20:28:08 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>, linux-clk@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240820132730.357347-1-ada@thorsis.com>
 <20240821055136.6858-1-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240821055136.6858-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21.08.2024 08:51, Alexander Dahl wrote:
> The RTC and RTT peripherals use the "timing domain slow clock (TD_SLCK),
> sourced from the 32.768 kHz crystal oscillator.
> 
> (The previously used Monitoring domain slow clock (MD_SLCK) is sourced
> from an internal RC oscillator which is most probably not precise enough
> for real time clock purposes.)
> 
> Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
> Fixes: 5f6b33f46346 ("ARM: dts: sam9x60: add rtt")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Applied to at91-dt, thanks!


