Return-Path: <linux-kernel+bounces-373293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6689A54C2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 17:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850A51C20CFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE600193417;
	Sun, 20 Oct 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bVl5JsDw"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35D192D6C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729438450; cv=none; b=UsjSJ50eEvzdbmtdz4c37b1NJbd0mXnlVUXVMvZFB4qMB1a/Pt/G+pIPCq1HXSc+JnfLU2KSo4xkST8Hl8Qjx2YkMKcqrJ8KXTJZ0KzdrEp+yxvs42scdI2xk0ShGhQiMLrOnpHxhjODshTsEsRXlxaCL4K+crLb0w8oT/np1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729438450; c=relaxed/simple;
	bh=0xjvtoloZfE9E4bN7ATN5VNPFrMJa0b9V65OPffNRDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDTg6FzFRy29X3XOGRo0V6bsghTWV+Sm/jLX9sb6CYYZlE3lAUzBRZI/S+wyz42lHzQwPo88+9QT+I8cC9YgWd7h5aXmALGIOx1Wfuqdgwx8hHKIzgUSg2cmHBi8/f4eRNM70ksF8w6GtKnnp25LXvRJK8BTEav9ZWcR2Ta/niI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bVl5JsDw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d3ecad390so3371898f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 08:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1729438446; x=1730043246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHoF0+jy08+d0tzw5wdsCud86iYNSnmDm7vWUTpb7kM=;
        b=bVl5JsDwsjetVHIgWQi8cEmLd5Gxi+zE3mxicL2lhqPRp68X2mgHxGQhE7X3tcgSQP
         ZlppY7loXEbwbMpCF9vQBmdV1ivje3PAbdmoUO9J9+eX6HeYCmopWcEqPkRt9Y+RXXf+
         IgzCqeptZcnNTIXx6Q54g6y9nW4dF+orG/e+zrtBKAYH+uQODDszdkIg+lN3MxQpGJba
         TbJ5KbkQVb5uEGef9ETqqxVHCeop1t9MlOIyVezlHBZWTdL013Nv1pamiVPqVlFAOFuD
         iF7a0xGPklLU4thSHCaCHd3ihG0Up+8ZpgkmTYr1zAyBh7EkCVq53eBQ6NHzlONJD1j+
         iwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729438446; x=1730043246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHoF0+jy08+d0tzw5wdsCud86iYNSnmDm7vWUTpb7kM=;
        b=moNUJImWiatKLr6vVTsdZqwCUtiD9q6FfUibWYJ7nLjHKRRV4ta9djC3ay7hi6QbsL
         PP7UR2plZS3m1M0kGHzuzjvwnUjjLFoOKZxgZ4KnnbTc0AjhVnm4H4U8cwziQKqSRaPM
         iEvU5c15gblmNabzlJJbJMJDoeykZPZkmTlF49GD6zQiOO933USXJzcWuZGNfMIyayWx
         xW+98+P1GOMkPW08XCJ1N4EFqXiPPLVkZZqqY22qRapNiIO+uswJJa6T9vMq8nurTbqX
         gPj8Cu5XaLinbszS0Dtum0y6w+hGwcI8e5BOmUrqtve2NngcstXHRob0wL4AjeVzSl9R
         OTXw==
X-Forwarded-Encrypted: i=1; AJvYcCWxWGI5PFhfw7LxaldF+CU6W4jq9GbRDJBOI9RNcKZMnG8egrcQOT7rt5PDQK5QSp8U8P9GlhJvZ3WmKCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoOzrqWXiSNYO7OnJvIrncc0I1n/ApEq7826LXsZFEgRd1IO4P
	IQ4tGUc6wTZ9L+5xKxq9QFr9gIPNqVJyY9ZXQ+Eh2R/CDA7kI83rYAGg4lA2gxk=
X-Google-Smtp-Source: AGHT+IEWdM3R1s0Duv6iO8wCESNGfP4LSs7tVFDEZBXcZpXSwYCb4zP4707JgH7ciHfeDYs0Xb3lcg==
X-Received: by 2002:adf:e84f:0:b0:37c:cce8:4acc with SMTP id ffacd0b85a97d-37d93da3dd9mr9248445f8f.13.1729438445641;
        Sun, 20 Oct 2024 08:34:05 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9432fsm1961891f8f.83.2024.10.20.08.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 08:34:05 -0700 (PDT)
Message-ID: <b35e66b9-2748-4d2d-abcb-69c780df0912@tuxon.dev>
Date: Sun, 20 Oct 2024 18:34:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: microchip: sam9x60: Add missing property
 atmel,usart-mode
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240912093307.40488-1-andrei.simion@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240912093307.40488-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.09.2024 12:33, Andrei Simion wrote:
> Add the atmel,usart-mode property to the UART nodes. This ensures
> compliance with the atmel,at91-usart.yaml schema and resolves the errors
> below:
> serial@200: $nodename:0: 'serial@200' does not match
> '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
> serial@200: atmel,use-dma-rx: False schema does not allow True
> serial@200: atmel,use-dma-tx: False schema does not allow True
> serial@200: atmel,fifo-size: False schema does not allow [[16]]
> 
> These errors indicate that the property
> atmel,usart-mode = <AT91_USART_MODE_SERIAL> is missing for
> UART nodes 0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 11, and 12.
> 
> Fixes: 99c808335877 ("ARM: dts: at91: sam9x60: Add missing flexcom definitions")
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Applied to at91-dt, thanks!

I moved the newly added properties near the other vendor specific
properties to cope with DT coding style. Please have a look and let me know
if something is wrong.

