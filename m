Return-Path: <linux-kernel+bounces-277986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4DA94A914
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCF1C225E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA121E4AF;
	Wed,  7 Aug 2024 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="acwjPtsv"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED05B1EB4B4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038802; cv=none; b=JK3XUbZ1FJd4fzJJMYBspF4u3D7PsV5y4LdAK5mwZbGLPXobBJOiJ9bnS6vNofzbmbR1KNQGzSTY2gJGPUfNwgkXXX9fBpDrxYRmmRayhQoFoaln+AncV8SulZh2BFlIpqJwKMejDKX5vYtBQ0baw4Q0Ffpmr4U5hOraew7ilY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038802; c=relaxed/simple;
	bh=NRqiEnBiimHoingme0qVJPrkh4WXTxTwsQB1Q7Y4gKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyFiIFD+KFxc/shTYdGkfGvarLel9FHUMjeW+bZLAzHSN8dCbKZWuHxDSvDIwOdSb5IaZtqcNjOcAHQ+wGYGFSfSm0xLQ4a37iIFfyYQJELKWK7GOIfqsZVCDHJmOd7MkTHWi0LwC57vwv04FJGViMVXnlWqpGNz3KKqU1R5A3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=acwjPtsv; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so2009957a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723038799; x=1723643599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIu6O+iMzaxlTo7+/E6XE3a2FAHks2o/pMfGehr4SyQ=;
        b=acwjPtsvpKCewGLDC+c1KH/QucmcvkdNXNWH/p8B4s5FQWSXFfErMgPn/OwUTfqmsK
         j0gjjodWYrWgX8dtk/7fVbWZVdmCLnIfIsmoBFeJF1tVlgtGr9FkP2b9bHKD9ED6AWN8
         +WsO5dTojhZtWNiJgyAohXysRdaaPANBip6HNrZMEoCv1Z/EZP9Q6JICGeyy5c9mqqh/
         Las+pzMRD8iR/LCfG/x0/C0jxd0Cpeu0DtTxswrVe3CHnUZ2DGsqRtp/tOXgP9w7Zpby
         j7HBf2IbXpKex74vfpOmx0Il3mNu0vMUvH9RtnYwOIj46U9k6g3wO4RByTkxLHuVJ47L
         yu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038799; x=1723643599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIu6O+iMzaxlTo7+/E6XE3a2FAHks2o/pMfGehr4SyQ=;
        b=kdJO9ongbJAOj8NMtbuAjJobzFycrA7Jt5/50WHn7Q1XXIV5ADnC1cTLW1Arjo379I
         h7THyjm5GXN+5jxq47IxDLcNTc/t3RnQlF/bhlA1zj7qii6qvAo3nmHX/BiEIyMioYsm
         PH+EErcvJCaVtRl3BXKnaRJl0/EnpttSRd57AqMNA3duvePaq/fQ/tYFt9YDByakdZKe
         4y+05fO8+m6DE5KS2S4A02y9geyB2nAQjtHkKVNYhidLFHz3UanaohtiTfYEaUxARfTX
         N29iR3LtcJYJaxukEwuVe+LBX60t2mIwVv7WygEv4hIIwuZZqEmAOViEJm/crrWZeY6H
         mFfA==
X-Forwarded-Encrypted: i=1; AJvYcCVRJZCurOe2dJM4FnB7LNI+shIlzb1a1PHaGSIS0I4BpjvBCo620B7qiYF8GaQ5qgLawIg8PcT14YLAbAPV44xSJ200jVOnR6T9TbwS
X-Gm-Message-State: AOJu0YwPTiH+c8l0MSPcC+VHj89DLhVmzuHJD34EvzhMRB8xrkM/0kjZ
	QqoBZbLBwtgdmZkPJ01zADpSMce+nqdr0QROobCsVb2MbJ+d+a0S9FVqK/MNeF8=
X-Google-Smtp-Source: AGHT+IHR+S+EBDdfTlDpuRP9UXE7ZPm7Fw3uAAffraz5Q9GDxJ8ZoP7KdHbWzr+B8x/S7xiFhH8MmQ==
X-Received: by 2002:a17:907:7204:b0:a7a:b070:92d1 with SMTP id a640c23a62f3a-a7dc517b48dmr1376018166b.46.1723038799127;
        Wed, 07 Aug 2024 06:53:19 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c67a43sm639660866b.96.2024.08.07.06.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 06:53:18 -0700 (PDT)
Message-ID: <cef7b260-7f47-4acd-9d6c-d26b7f8cc7bf@linaro.org>
Date: Wed, 7 Aug 2024 14:53:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tty: serial: samsung_tty: simple cleanups
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jiri Slaby <jirislaby@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240806-samsung-tty-cleanup-v1-0-a68d3abf31fe@linaro.org>
 <2024080714-spongy-wannabe-7a9e@gregkh>
 <5e73f1b405e06f9ee796d3b7002933f75613728a.camel@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5e73f1b405e06f9ee796d3b7002933f75613728a.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/7/24 1:00 PM, André Draszik wrote:
> On Wed, 2024-08-07 at 13:09 +0200, Greg Kroah-Hartman wrote:
>> On Tue, Aug 06, 2024 at 04:29:44PM +0100, André Draszik wrote:
>>> While looking through the samsung tty driver, I've spotted a few things that
>>> can be simplified by removing unused function arguments and by avoiding some
>>> duplicated variables and casting.
>>>
>>> There are no functional changes here.
>>>
>>> Signed-off-by: André Draszik <andre.draszik@linaro.org>
>>> ---
>>> André Draszik (2):
>>>       tty: serial: samsung_tty: drop unused argument to irq handlers
>>>       tty: serial: samsung_tty: cast the interrupt's void *id just once
>>
>> This series blows up the build for me, are you sure you tested it?
>>
>> drivers/tty/serial/samsung_tty.c: In function ‘s3c64xx_serial_handle_irq’:
>> drivers/tty/serial/samsung_tty.c:948:45: error: passing argument 1 of ‘s3c24xx_serial_rx_irq’ discards ‘const’ qualifier from pointer
>> target type [-Werror=discarded-qualifiers]
>>   948 |                 ret = s3c24xx_serial_rx_irq(ourport);
>>       |                                             ^~~~~~~
>> drivers/tty/serial/samsung_tty.c:856:68: note: expected ‘struct s3c24xx_uart_port *’ but argument is of type ‘const struct
>> s3c24xx_uart_port *’
>>
>> And so on...
> 
> Looks like I had Werror disabled and therefore just missed them. Sorry for that.
> 

Same on my side. Any idea why CONFIG_WERROR is not enabled by more
archs? I see just the two:
arch/x86/configs/i386_defconfig:CONFIG_WERROR=y
arch/x86/configs/x86_64_defconfig:CONFIG_WERROR=y

