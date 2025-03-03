Return-Path: <linux-kernel+bounces-541174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25F2A4B997
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A88188D4D1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475A41EF0AD;
	Mon,  3 Mar 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d/m7hkht"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E861EE7AD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991233; cv=none; b=eSz0LYn0im1osdnJoU5GhGZfckt6ohJR7dQGcIVXcOD3ehJGlGdI4tVX68Txqo8bqyLxcn1SnQRDm6PQw9yOUhisIGv6fmEgayjY8Z2DT6RGgR+xTlWM3Z3lupbLHgXXtRNx2vC4VIELxhI/IARui8dqkHTRXIMY5twKWkh1fJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991233; c=relaxed/simple;
	bh=TPu0b3Yb8x9XdyZxR9D2BnVeAYiPf0X8CkpwpVfMdK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2KH3ZfHBgxl+XS5bOgAeRjyLaHfDADbxIHVDqp/rQ0tcr2Q0+8pkWTtixzCLxobp+7joiWlb6JFGpedMDT7yoyZ7GM+Z7vnFhJNr4EgM3AvRbQp/FFN9IX8lzZszCPgxr1acujV+gAbFy84KGx0nxFtEHrisIhnsYxgBHCgpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d/m7hkht; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abf45d8db04so318273866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740991230; x=1741596030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7t59WyUTPd0L7Mi3cChysUXnRM6v1fDvAcY991WF1bQ=;
        b=d/m7hkhtYbS9FQ02J6OUue9K8XWSrfTQsCQNsJrxXMnxjx014Y6lhj8GGfZ+cVKWF3
         6G4lCTOCKCMQgqPi/gOTKfc8c/oZ7g0WdDCdhU8DqXoVmXPUE3yhEVR23oi1Wr5O7Jrc
         X9YbsxPxkJfmky+wXsnCQ+CMnnS3T6nk3yzLcbJptPvxUXKrBEuYGZPOWj93D+lFsS6t
         xEeK6ZBm9K9+6z2IKe8baqMJdv8wxUH0fPpsFrwd4QMydaNxCYB8OaTo/fzYc6/pA5ZD
         D/pQq9D8ezHncVdTX3enW14hctaVjQRdh7w9o0s/hTyKPAOt8BNPnh/YajxIzKBS5fdE
         N58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991230; x=1741596030;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t59WyUTPd0L7Mi3cChysUXnRM6v1fDvAcY991WF1bQ=;
        b=awfGi8dt7KIfIWCE33greFGRZUpN9DTIFQuqMhHOgEmAGA0EclTPhTkmANI2PPzqIA
         TE6mcu1JgBMdPo78IVW8E9XSo/FLLqL+akEaFLU46FyZt7YbEshLqNDHmifWoz5W1zKg
         BSKJwnb4iA2s9MG958uXRJshp21+IaZvTjm5zN+nblyIy3/xrL3rZsRI1tzT4FA4idk/
         d+Rz5fxH5H2jHQbCIDvOQrn0oYptOOUjE7XoQKzDCEWqw6Mds2dwL6tpWqfKLPjamdQZ
         KcofCmJMw6CxsbKt+iD0B7lQj0z0kfP19+GWYUZYUTaVcs+3HYVQ/8nZA3tj0jZbaM7Q
         wnPg==
X-Forwarded-Encrypted: i=1; AJvYcCVG3tKa/QLLDQNBpNtxTEyzokUJKgfZPsCL0IpSMVP0Dd5+yEeqCQ2/tmCvNYbfvzdzWmYJCpOm63a0shU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkCl0gOyibHxBnQWqmvXksua7xqPATt4FSuFUFUBrRTTsWFg/a
	VQ2jIij32PXb3HZlqZBjoLBTPjRIZGx66MX9eFuz9GxxZfMl+dhNva3ExezBzlw=
X-Gm-Gg: ASbGnctoWQFUkYV6hKEdkWyBCJT3aRAbDlaTFgJbNBv9jybDjgR8guSxVBn1EAlPKiH
	ppG+LsvJZbwP2C6z8dHKmvvjTe/O170byRBoISZsmsR79NLppdHBBXxMXA+2T9lNXFKm0xGRDn8
	vfN+Axfown/fHp1G4Who+0C8GXjnO8CYGqYgZiu5cLs4LLI++uK3nsVHjhGBgsqZtYBQRYsTSLI
	V2QE0gqJSprr1p5qJB/AhFwPb0cBjVp0fVS7dYgXwKy54+BwtL5IBmvv+LaI9kaXQ4S/OtB/XPQ
	ResJC2Zh3Vvrek+F/jg/mQWWKCcNCl6cjYn7zEC0rw47wvM6aG8UHg==
X-Google-Smtp-Source: AGHT+IFbnHrYeaaWFN8nqN3k607A73JWI/jQQa94/Cd3rmC/xFunczpany1uHLkd1AybmzRvqJrINA==
X-Received: by 2002:a17:907:7f0f:b0:ac0:b05:f0c0 with SMTP id a640c23a62f3a-ac00b05f592mr254231866b.1.1740991230131;
        Mon, 03 Mar 2025 00:40:30 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0b98e1sm764527166b.9.2025.03.03.00.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 00:40:29 -0800 (PST)
Message-ID: <2a18e305-090c-41fe-9b27-97ebe93fd4e4@tuxon.dev>
Date: Mon, 3 Mar 2025 10:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/21] Enable Power Modes Support for SAMA7D65 SoC
To: Ryan.Wanner@microchip.com, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, sre@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 p.zabel@pengutronix.de
Cc: linux@armlinux.org.uk, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
References: <cover.1740671156.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1740671156.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27.02.2025 17:51, Ryan.Wanner@microchip.com wrote:
> Ryan Wanner (20):
>   ARM: at91: Add PM support to sama7d65
>   ARM: at91: pm: add DT compatible support for sama7d65
>   ARM: at91: PM: Add Backup mode for SAMA7D65
>   ARM: at91: pm: Enable ULP0/ULP1 for SAMA7D65

Applied to at91-soc with some adjustments, please check!

>   ARM: dts: microchip: sama7d65: Add Reset Controller to sama7d65 SoC
>   ARM: dts: microchip: sama7d65: Add Shutdown controller support
>   ARM: dts: microchip: sama7d65: Add RTC support for sama7d65
>   ARM: dts: microchip: sama7d65: Add SFRBU support to sama7d65
>   ARM: dts: microchip: sama7d65: Enable shutdown controller

Applied to at91-dt with some adjustments, please check!

Thank you!

