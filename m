Return-Path: <linux-kernel+bounces-363510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858B99C350
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8676E283B23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955B153824;
	Mon, 14 Oct 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/J00+On"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175914B080
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894557; cv=none; b=t0PAugOnobYCR29iCIbLUnqye7Bvxx4vfFIz7Cd6m6diXNZaK8PNR0ZzqW3hhuawOupIM8/Nf4kWzpHTL60a38VuT1RgqPKncEynRF+LiyiZvJDoIg0ScMkSLFmXmsz1/ZGCv9nIIn9YINvTVQbK6Iwi3i3E7hLmwLjLMBjrPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894557; c=relaxed/simple;
	bh=vcsyM6w5SlFGcrqYwvPSlCYxhrylpBGSgkSppQKyoMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LM2AqkF/R4KF63HDxqbzcVkJ0d0BTlO8cuTWydkYEU3kpZ96wxziJbdwFDHU1OUfT4bSlP1dF7AwL/zn/nBjtjiTM0A94ZEYf4FpYg0KssxKOah4sfEKIxb97uxcuETN7IxpQ8M8R+IQxOh+qOshFizjiVzP7th5Fo5rx5B5vwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/J00+On; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so5155855a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728894554; x=1729499354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d91S4I2UZXSrPkvBmzWLzGhfndrc3g6nHTmmorzhjG0=;
        b=Y/J00+On/d61hVADEtYz3uS6t5dKHc54godDGnjpaJkZ1zLI9q6t+CNjT/uphLX5zd
         FhS2ibIHEZ7gKQatxAWxWYhgW0F2PCsqeFMI47HCcX33i49GZdIRsE7gVMlCGfndLwf2
         v1QVXn22JOqS5nPvmTE97APswVBJ8BJY+uJazKFWdIfEesazy8GZJ0BVuQJ8FjS5jEGX
         IGQAp2HzRz7wLrrO9rTvzNGnd68q+cZCM+XXb7pFyqDRrpXiqPDh2hlsyRaoUsjMkJ4p
         T4ls0wgs7c2dafM58NkvITSRFbnyAcXLcnOEp5tUAQuHt+s7aYDbh5i1Hs8GgHiY46rD
         +6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894554; x=1729499354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d91S4I2UZXSrPkvBmzWLzGhfndrc3g6nHTmmorzhjG0=;
        b=m0ZOB+4KtKjECuLBtVovicfJAfedd2FEtaIWZL8cPPSoXqdBAvZ+EmkK+sMNUTUs7i
         n1jIzNXr33jKmZiFffLBNW8kjLD81IuHYs5l/F8YIvGLk/yZxJLwDhTj4Woq2poGTSMY
         9gKYWwX5jQs2LJJCbALhUevwis5UvZB30x2pw22I2JlEdTHCwTd31jm5ahutmdZg6EN7
         AvS68y25h7Rd2I/bR+lAMp7DYMl/D5/MrMmwXxxlKbLHjEIcOqk9yiJKCNMFtxRV4KIq
         v3D4+zy8fNgobQcFGkc0qPG7QWemhEI88e1JFdFEHnnqQxlBHoeH92V5dl+ySo240Wpm
         b8RA==
X-Forwarded-Encrypted: i=1; AJvYcCXj5OeAsQkSu6D0eJhnG1OPI2Y4jFhFvUQMFjrMqDKL+rHWZfoTdlsLQUc4+rNqLy9s+kwXB+TEjGxSR4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmfkFsY1Nsavr12MTfzlOss2S0ZDkQSSj9kqBstpbr+WebfE0H
	X7ul1RXO459eMiCxt2+Zm31dJreIHwRBljn3ofYbFrWjyuFYeImrDK+4y/NX4Kg=
X-Google-Smtp-Source: AGHT+IF6RwCW+FyEK3/Fal9ivHW7iWGPlCDb/O1Fkx9nd90PKRCkEMCBSO4PJJepAjsrqveEArsROw==
X-Received: by 2002:a05:6402:1e8b:b0:5c8:79fa:2e4f with SMTP id 4fb4d7f45d1cf-5c948d764e2mr7389203a12.32.1728894554097;
        Mon, 14 Oct 2024 01:29:14 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937153032sm4707474a12.53.2024.10.14.01.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:29:13 -0700 (PDT)
Message-ID: <ca48de1b-b45e-4b27-a186-3bb7eb5859fa@linaro.org>
Date: Mon, 14 Oct 2024 09:29:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: dt-bindings: Remove assigned-clock-* from
 various schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Martin Kepplinger <martink@posteo.de>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "Paul J. Murphy" <paul.j.murphy@intel.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Martin Hecht <martin.hecht@avnet.eu>, Zhi Mao <zhi.mao@mediatek.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Mikhail Rudenko <mike.rudenko@gmail.com>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Dongchun Zhu <dongchun.zhu@mediatek.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Todor Tomov <todor.too@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-0-a2bb12a1796d@linaro.org>
 <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-1-a2bb12a1796d@linaro.org>
 <w4ta26svh34gojqpakrgp5cpsempedkewkmbllyvs5z5fm274z@jqs3tvunxq2s>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <w4ta26svh34gojqpakrgp5cpsempedkewkmbllyvs5z5fm274z@jqs3tvunxq2s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2024 08:43, Krzysztof Kozlowski wrote:
>> -  - assigned-clocks
>> -  - assigned-clock-rates
> That's not extraneous, but has a meaning that without assigned-clocks
> this device or driver will not operate.
> 
> File should rather stay as is.

Hmm, I've obviously missed a trick here.

I'll check it out.

---
bod

