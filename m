Return-Path: <linux-kernel+bounces-326103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D77C976296
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B67BB212D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AB18C92F;
	Thu, 12 Sep 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="epZgXKSU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4A18C01C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726125825; cv=none; b=KxaGAnl+eZwN+Wd4V9oYrVQjZdF9IuVpGh/7PiQDLYYXLsm58RxajU20/y9WZk/bZH+Ryr/pPlKySAavOtW+JVxPXBWygCLC0wOqFP+YC1BccZ/QQH0DpIpM7S9CTBOd089NmibnwhmAr4sAhZXcdToReNn/e54HzzDt2ZF0xL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726125825; c=relaxed/simple;
	bh=b3RBYoxYxR7tmU/NA68lTy+b+/ncUB/x9ZWTx1zJqaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1swTiw7yDYMiRVEmCQv0HJlk0x4eoKodW/m77Oi/LF5GmpzvJ/PJAfvcx7+h4wbpo2e+baCHinPI6AsUUuyRYnaXFfl0SGCDc1wRkF2xyGxMWmNOjmNIVRJ1hDVqZdQtp88s/XwqBLGlzWGvVUH9amecEtBSCV5OJeg7m0cJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=epZgXKSU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso5438645e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1726125822; x=1726730622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3RBYoxYxR7tmU/NA68lTy+b+/ncUB/x9ZWTx1zJqaE=;
        b=epZgXKSU/WLfyalfbSBFmL+JoFcaX5s9j+iucVDbi6Ox0ibO4xZxTjJSxJHqRoZeUc
         GApFeI3Ti3T8Eqap+rqHGi/mHzsvwLHJ/ferowoONoHTxaiOuvSMhwFGpW6/33xOLjQb
         XBeTbFXYRlOQUQLH26pgUEvqL3odTujTpvaSlwti//xE4m54tJYWwGB2955BG1ZhTqs1
         wmg1UsCDMJmYe1JZSfOMmTjGfOHiZf5mpRsq1/eudoKLvrBNt3/2ImRL606qYgd1YwHW
         Gw5/Z058BCzO5JB0Tp8cKzecopnxsO6fpb4oLRGBHcsUVsFr8UJvyKkEXL9NycNflszu
         WJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726125822; x=1726730622;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3RBYoxYxR7tmU/NA68lTy+b+/ncUB/x9ZWTx1zJqaE=;
        b=BLxBCn6uUMKY/F6kie+0ad+VAleRk2oCvqa+3IkSwl+CmppTgAoz8Vz7nkWHfsRDrA
         FOUfL4DDGaE1P6OogeMXNXqSkzsmvQXFZMCUMRN4N9tYRLZa++EcEoI4G68+56lXQLPi
         Mvr0beyVgdwosOyNT3oKy7p3NGW7ATVaugp//8f/w3OBbbbVFtZ4lhBDEhWfyZAKvUQj
         87/03rUCLuJ8DLpCyNue2lUWpobDtkquwCFJZyc2k/uJIzDUDnAmXQEbNCRndAQPydDB
         ONAL+rQ47KaLEQkNxkx8ej+pXm55h6098JCd/ovqbiSpuGaY48A5Yfy7PT0wtDfyBV/C
         2xiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/op9V4oEN4gYpbNsGhdEPk6nzCZeMUq6KTQfWV0v2I0Ob++2NY/1Tr0Oijuw7qmAXCe5ON5e/lJ/keNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfGpCdawbDuQ3BnvINsqQ06ip+Ef/YnUFa++FOEipSFufUiD1
	RVLx7uCEgDGgOe5jUqMbPasWRss+DWlzsSDHFYmxmmcUEJWsoNhQD/2IlImwakg=
X-Google-Smtp-Source: AGHT+IFTUZrXEmATrXbBEXJoW1c2a0YR/Y2T+PSZKiUiUytls29Eqi5/26UuYIcNMD0hR1y/E/4LAA==
X-Received: by 2002:a05:600c:5249:b0:42c:d74b:eb26 with SMTP id 5b1f17b1804b1-42cdb5486e9mr15290215e9.21.1726125821750;
        Thu, 12 Sep 2024 00:23:41 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956761c6sm13557444f8f.61.2024.09.12.00.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 00:23:41 -0700 (PDT)
Message-ID: <f1daa78b-43e4-400d-bb50-9cce1b42fd86@tuxon.dev>
Date: Thu, 12 Sep 2024 10:23:40 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Add missing property
 atmel,usart-mode
To: Andrei Simion <andrei.simion@microchip.com>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240905093046.23428-1-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20240905093046.23428-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Andrei,

On 05.09.2024 12:30, Andrei Simion wrote:
> ~: make dtbs_check DT_SCHEMA_FILES=atmel,at91-usart.ymal
> -> for all boards which inherit sam9x60.dtsi: serial@200: $nodename:0:
> 'serial@200' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$
> serial@200: atmel,use-dma-rx: False schema does not allow True
> serial@200: atmel,use-dma-tx: False schema does not allow True
> serial@200: atmel,fifo-size: False schema does not allow [[16]]
> -> Means : atmel,usart-mode = <AT91_USART_MODE_SERIAL> misses for uart:
> 0,1,2,3,4,6,7,8,9,10,11,12

Can you please explain in plain English what this means? From [1]

"Once the problem is established, describe what you are actually doing
about it in technical detail. It’s important to describe the change in
plain English for the reviewer to verify that the code is behaving as you
intend it to."

Thank you,
Claudiu Beznea

[1]
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-changes

