Return-Path: <linux-kernel+bounces-436451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A494E9E8603
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9056418831E8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169D315624B;
	Sun,  8 Dec 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hcnwq8px"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D315414B955
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733672983; cv=none; b=SBKL6w110xnzfFabJjBrtmdtOi7CEJWc4+i1XR4GnIgAKfelo6m9nl2h1efPM8jPpVKh7GIU/WtwsIcmCGN5M1RMmv5phl+3ELDkAMU3fo0CsY6IFOF6XfQ8JYm5fyntlERFl403Am2H3BrF2/1iGvn86A9HJ1DCkgCxa+onFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733672983; c=relaxed/simple;
	bh=FKwkqAFv71qi5Y5KBLNFvGBUWlg4JVujuFsRQTqhs80=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mu/K14oIMskbzgeQzk2U/nwsMnhOickgObKwj9isYF2tlV9fHlCgnXAYEnRvHCGQQiLwScGFhz9Lyo3mnaB5aX7UZ9GyHPHadBtCjpiVjlLltZwWzqMSPmJ+Z3ZIuR4MrZp80lAcAB2QBIPkFTvGVxyswiiLtYw2VZ9VyYjFB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hcnwq8px; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434e69857d9so6934955e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733672980; x=1734277780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSND8gKPpnPHIOd0ZAFXzWeCT+o/x2u1iq0um13sDc0=;
        b=hcnwq8pxYK/VGgZzQ7As6MT/j//HWIdISaONnWlLrqsUK33ZeQv1vV3Q48Py/TNa1i
         qw4uWtMNOzLmWLcyfxUvU0m5A4GEnKrNj0LiGK/3Ncc8ElMJMEb3xMWt3aloDsZQ1xzo
         YE86xs45alSS6+51aMOOeZc/rUqcDhLuwKHgEm8kBs8VVW9sE8AzYw+YQbh9xT18nqzF
         TyM38sI0JvyxYXPlAiUQAaDtSiKEmNviCBrmbJdtxpt/YlDUCcAHBeJt/wDJZmza86L2
         CEhMvlYa2FlqPIodn4IL9iGdh8mCPXodaMtfqv/vo1EhjOEhcNKvTBJ4jKpi5o1YZXiF
         d5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733672980; x=1734277780;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSND8gKPpnPHIOd0ZAFXzWeCT+o/x2u1iq0um13sDc0=;
        b=i0M0woaLsqOnHO4H4/J3whKDcNM4LIA1HcteOMq0a0We4HyZsx2TmZxC59uFvn05bA
         yVzEi6PRUeT2qInTNEnfxc9XKzetYDAPKkykLr8ruggIivE9l2yNcA3sxFVrh9fVMLxK
         3IITUe/qDPzNGCHMJes6d2asqqMKD6AxsEKpnuJeZWnsYCf39kWg9B81+4/aldzeoEdc
         Y4NfxXceOE09Nin3SROVR6mqoEZpkmzdQwlW4Yldtzcuo8n4vyRjldB52Vb5eDvXnvYP
         kxqxq36ma+e3S3kWFez3gOMg8Xf0wWtu9RLuzbwhzkdF+5GxKmsJdw39CtYC2J1WqFHK
         Pq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKrbSUXmBtmOPwP2JqHe9HUhiuOJvLhrVJmdxDQrQzXw3Gsw0BA+/VGRtcC2h1R2tYpSC+4MN7bA18DMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46R/opBa0IMGviif+dTc4G1/pwKUI0HoSYK+Gw0Y4ELM+IBsk
	st1KubHC8WlWVAwFSP0SvM8KSf5H4Kv9bwTkZ1RZthZrSVbdnyKYQqBnn8gHu9g=
X-Gm-Gg: ASbGncthC3Gl8UPbK0pgZ9ZcZvad149Eyfp7WOnnIdJQ9N0RHeWwx1gt5Q3wdFayN8H
	SpQkrkXYQfEls0QvP99s50XZ8F4MqXKbCOGexGinjVeLyaa29vsLsIjx38TPUyx8+HMbPfmEl2h
	hHF/k6Gtq4hts66A+MovRaIvXrbUvA9cglpjhL3R+DLgYP4PDDAocuEA2jr0qzP22h13scoLsYl
	FzQ7AfF5rqGSX9gMlxxeEk9vBb1pbJecFAjdQqWrAwXyTZRQNmEdM+/8UU=
X-Google-Smtp-Source: AGHT+IGq4cGYPhA6KCSTjdpGb4CgHZ99GQRGPwYyuWrGpVCbMvRBa8NBW7ybgFDZX5516r+i/hv+ZQ==
X-Received: by 2002:a05:600c:4e45:b0:434:f2af:6e74 with SMTP id 5b1f17b1804b1-434f2af711emr18175215e9.15.1733672980031;
        Sun, 08 Dec 2024 07:49:40 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eba653a0sm50093225e9.22.2024.12.08.07.49.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 07:49:38 -0800 (PST)
Message-ID: <a93bd8ed-39e2-4f19-99c0-1d9c11c694df@tuxon.dev>
Date: Sun, 8 Dec 2024 17:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add power monitor support on sam9x75-curiosity board
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241122080523.3941-1-mihai.sain@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241122080523.3941-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.11.2024 10:05, Mihai Sain wrote:
> Mihai Sain (2):
>   ARM: dts: microchip: sam9x7: Move i2c address/size to dtsi
>   ARM: dts: microchip: sam9x75_curiosity: Add power monitor support

Applied to at91-dt, thanks!

