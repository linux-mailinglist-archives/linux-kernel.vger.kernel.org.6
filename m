Return-Path: <linux-kernel+bounces-356385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC15996049
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE832B238AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7C11741CB;
	Wed,  9 Oct 2024 07:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OyE5r9XT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC4684E18
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728457484; cv=none; b=lyQh0fV+8qzXSqkfEa2+sDeICt9VWnr4wONK6x1VpBXttmMje5gZpx6AEYUragvV84jiPYJIhYdQlXvMKZtDdlZZlxQDJ11H7KYbBuBwnLsxsRXsepIYXsPDukYWbfcHALI7qcKu6ORXqMiafKOS5sWnrpqq5V8WSvUuznzjmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728457484; c=relaxed/simple;
	bh=CKDfNvEKun/hTGUH19g24WhkuP6g/yZddhrJZZwRzF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9P9c9of4RyMDMqyIyID9Zmi80YcSVv3WUJvFwKeIG3fPh87sHwe3AKLbklFxyB7Cj7vbAktLq0dUMuhYnMn8wbsFxb4fhkGqtzvFClQDoUJ3WgVwd+lAiglW7z5uvZuSp4pDMR9NhfD5BcNABik9fOcPue2sAbnsxh/tkvVyPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OyE5r9XT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9982f90e92so104215966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728457481; x=1729062281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isepMyIDGBARY+Wk6dt2vyjqYIPIN9/Qq6sVGyD17bQ=;
        b=OyE5r9XTCfzVzagYJs/AK42tmFNONnYVqqRNlADfudazbG02xb0gG6zbefQm60ebN/
         N+8tTCkYyvFGbMNosJumV4pPwwJRSsqiD5XLfH1TULTuiQX6jp3fp6gX00n/HzcdBqX8
         I4R6SsXGIE1EeBAIeV4LsVLVW+UwtaYCmuQ9vClA+KUDta2EjI+24T9jUseTqPwqYL8W
         nXTLcbZ11hK35EXsFBGLw7Llm1V6y1lErK4q0jb6t0lmIJ6hbfz85FSqq6nzHVHOBDq3
         jYwdg2Z5VsPiLuw6DDPUgrzpTj5Qap1PTK7gOk035HCVgR3qTdQMgHWPJZBscPXcFjXX
         UFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728457481; x=1729062281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isepMyIDGBARY+Wk6dt2vyjqYIPIN9/Qq6sVGyD17bQ=;
        b=f/gA4ITK7hDMCT4TODgfkuZDcv+O+M5G7+T06D2m7WDZcpPK8VI2YngiEfrvYyVNDL
         rnYW/101oPinGbDQRZPwKAXSvf9327W0pxHJvWkOdwGRSjDKKEfmu/+UR9jspLMUb6wu
         sxTA9gFwnzoxUMu86Q2jodhlv8+ZWxffQ/wlLsR70Sj8SAtxmMEV/Ldj9f1aJCQp49ZE
         YfkZnDwPkCXdoOerSkHNx0DA26lZzCnpmzmoqojjCZZ64IWEqhy8aFAIPMrG4b74lJ/+
         CC1dxNStkP6/kL1ZrIABJqkqkTNbjVa1K4SmKsIkModMj+61XYdHBPf7uj7QNPntiPua
         D1Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVnnSAsOhwB24AD1HO4n8upPTV/h/HfXpGjAcifQczhgdE9m9AYf5dP0hJOu1gVmpHGIJaDLAlPp8cjCoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxWVpRVOYoTjMqKDL+eLL/0bWNW3O9sw+ADqEsg9jh6JykPms
	M3dc/S4wf6kCt9luIUzkL01sM0882TJIBaa/4hLyCa+XDKOFcLQ0Ol8ix2AkwwY=
X-Google-Smtp-Source: AGHT+IHRoy+LihTskkAwr/q35H2Ce9Os6ZVGomzYDuXPMhc69JXN6kMqqu0ww3xNiefFurKnotDiSQ==
X-Received: by 2002:a17:907:97d1:b0:a8a:6bd8:b671 with SMTP id a640c23a62f3a-a9967854f95mr666509866b.5.1728457480841;
        Wed, 09 Oct 2024 00:04:40 -0700 (PDT)
Received: from [192.168.0.157] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995a54ddf3sm323437066b.216.2024.10.09.00.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:04:40 -0700 (PDT)
Message-ID: <cda8786a-493b-4838-8da9-5aa64c7603ae@linaro.org>
Date: Wed, 9 Oct 2024 08:04:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: atmel-quadspi: Print the controller version and used
 irq
To: Mark Brown <broonie@kernel.org>
Cc: Mihai Sain <mihai.sain@microchip.com>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241008083226.51163-1-mihai.sain@microchip.com>
 <1c525e43-d71c-4c4a-a8ac-96627cd6ea7e@linaro.org>
 <ZwUJiAj_ZVztLvS5@finisterre.sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZwUJiAj_ZVztLvS5@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/8/24 11:29 AM, Mark Brown wrote:
> On Tue, Oct 08, 2024 at 10:34:39AM +0100, Tudor Ambarus wrote:
>> On 10/8/24 9:32 AM, Mihai Sain wrote:
> 
>>> Add support to print the controller version and used irq
>>> similar to other at91 drivers (spi, twi, usart).
> 
>>> +	dev_info(&pdev->dev, "AT91 QSPI Controller version %#x (irq %d)\n",
>>> +		 atmel_qspi_read(aq, QSPI_VERSION), irq);
> 
>> This pollutes the console. Better to add a dev_dbg if you care.
>> And irq number doesn't bring too much value as you can see it in dt,
>> isn't it?
> 
> The objective of bringing the various AT91 drivers into consistency does
> seem useful so if this isn't OK for this driver we should probably

right, consistency is good.

> update the other drivers as well.  Ensuring that people can get at the

Can be a goal. My point was that printing too much info in the boot log
may hide other more important information. Printing IP versions, irqs,
dma channels acquired (or worse, that a driver probed successful) shall
be part of debug prints if someone cares.

> IP version does feel useful, I guess it could also be a sysfs thing?

I'd also consider debugfs for IP version, it has less restrictions.

Mihai, do as you find best, it's just a suggestion.

