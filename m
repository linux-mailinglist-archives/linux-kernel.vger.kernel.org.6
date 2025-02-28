Return-Path: <linux-kernel+bounces-538367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE34A497AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D7C3BA63E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25BC25BAA0;
	Fri, 28 Feb 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FNPS5DUb"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687641B4250
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739526; cv=none; b=mvQwJ7KT7euBL0HILzcu54VvRPADxdBS7YAQcwRwjYFuOt6xSD2MQDIqKzDHgxipTDe3FKYA6Jglfm7PPAJcdUGw7MD2Bak9wYvLpAi4tM6X+Xqm6zUIoqy+LDg8pWy9F1snKLLf8D5vGDZKXMRXYY3ThCUehQI5XNQq124Vr84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739526; c=relaxed/simple;
	bh=h9pmYLxfUT1aX4HqdFXVPQgImPo47G223O0cEy8gIuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b48p/kIVqpTamWV0S+u6In7pfq1lyyKailQ3wj9PLMsXT+MXinu/pUD87jS7EnvtDjWnQEFEIKVwJF8kU45ztaufa3EnCH+fu043chazQ4bpTGjUvOSLZVSx0W5EL22d82AJPszimmSpqPGYKnX2Tylzpis4E8Y1qqpVmIfhAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FNPS5DUb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso1558640f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740739522; x=1741344322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKxSQoBGw54Y+lQ4k5H4EjBxGSd128527Jyb0EoThZM=;
        b=FNPS5DUbOMygNHRFj5N4FiGcP4IJz3iX0UK0JE4/wn+l0yF/xlQeoVkqSI/Pm0qCuc
         UZp+MPCBcceFmVYTQMwxrFmda3eKHiXeTWUKEc8+JorMMg7DR0kdlpessVjoE06r/e3c
         gFo+evYanZMv8eJehUMIZhtkKgf0bUWDqVVrP1QZy88FeJWuvQSpTL2pFNWWy54DnTAu
         K5P40SNPwr6UHDyI5sFMOd1EdWt01KfsP+2oYBT4qYJCEsbsjPAITwIEKqjrawlyWudz
         QztVMyVQbi+kL12XFrIz2VVnQ0auGL1njuS+GWt3Akb0N2zQT7InQkT34eB52jps9Tv4
         8wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739522; x=1741344322;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKxSQoBGw54Y+lQ4k5H4EjBxGSd128527Jyb0EoThZM=;
        b=HX8DFnIVh1vn/vCyCmoimCbBRzJVQr4h2oIbHUo2u0Y/iwrvZHG8dY2Vg+IEyY2Vbd
         05bwGdCzNU22flbr8YprQSjvq43sKxOA6mx6BAlcQLHaf5pRpYKLuEYn7zTJSsWe0JDh
         cqQFrLvFSsw543tfLlHwrsAjS5HjhNex1y4vVKNRErRyDtZjWNFiuP+PtH2kWpEjEEo3
         ZK3r4g489bR+xBGD9Ee4x0waf91f5OqaX6Msnyu7hcJVLrvsFi+/TRa74kc00hfl07ib
         BLw/b5BwgjSg6p9DVys6cCCHMlHuT8Yw9Cr9rgfPxtcb7bAgpfEBKu9/7UP8KwsPoZ3h
         NgfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgRtR2HPOhwJb/nzZ9mDPo7ehxK4ZBCV7utWpG/04y76B9CrPZx6iPra/r5NL5mKOYAT6HEU5Vd3QgHwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOw+4FBKEt3b4kikxzRXTa3a8kkCw1IxCpirDZrRcv8/fyPgk
	D/lyMr2Kzwc1qrdGnZ5aWTqvBUYAdjPnQJQagzeufUYAGhtGILI+t3A0DV7leJg=
X-Gm-Gg: ASbGncsCZ8Gsx87mJHOqQjl6K95VjF/aFhmcNUMMq89nrc9+qSrrrIWOJM93ekkHyOM
	kEpI/fkyb1+Le30BC/lmWXtiNGRkZN7sQa3Opq+balRovD9YTvvMoSbLtUwTdiXvMBwC1f1Bi1+
	H43B74YdTzX4FYWtO7GyT7mKWKKQuUTLdq1sD6U+VNqytvMJo7+n5fYDRKe/a5NJJrc3k4Eq3ki
	GnjDDP3FY27b5zLIrWcb3scX/4vbe4EokleK4ZoZEcDpgPvIdMfuQOcMe0HuHvqfX/fLFulaZPV
	pH/pxxspI1SfU9ElyBjeWKfYzU3/PTvnQKM=
X-Google-Smtp-Source: AGHT+IGA8C/Oyk3lPD53/6NcqMxjrN9/qHSMa0fAU2vOWBAuXi/WKijGjjWcS14XZg9IhC+2eaUOzA==
X-Received: by 2002:a5d:6da3:0:b0:390:eb32:3fee with SMTP id ffacd0b85a97d-390eca80548mr2338870f8f.49.1740739521706;
        Fri, 28 Feb 2025 02:45:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b2fsm83499395e9.10.2025.02.28.02.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:45:21 -0800 (PST)
Message-ID: <f1a6e60a-1cfa-4f61-90ef-b71f4a92592f@tuxon.dev>
Date: Fri, 28 Feb 2025 12:45:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers: soc: atmel: fix the args passed to AT91_SOC
 for sam9x7 SoC
To: Manikandan.M@microchip.com, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, Varshini.Rajendran@microchip.com,
 javier.carrasco.cruz@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Dharma.B@microchip.com
References: <20250220055302.284558-1-manikandan.m@microchip.com>
 <109244f2-89af-4e08-9723-db6c6b0b26d1@tuxon.dev>
 <7c409d23-f607-44ae-8fca-70e10a7094db@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <7c409d23-f607-44ae-8fca-70e10a7094db@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.02.2025 12:05, Manikandan.M@microchip.com wrote:
> Hi Claudiu,
> 
> Apologies,
> We've just received confirmation that the sam9x7 SoC does include an 
> version ID [3:0] in the DBGU Chip ID Register and this will be updated 
> soon in the datasheet.
> Therefore, we can continue using the AT91_CIDR_MATCH_MASK for SAM9X7. I 
> will send an updated patch with the new Version Mask Macro.

Thank you for letting me know!
Claudiu


