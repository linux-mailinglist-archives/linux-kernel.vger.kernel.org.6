Return-Path: <linux-kernel+bounces-542597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2525EA4CB74
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC113A2FB4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EFA22F16E;
	Mon,  3 Mar 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aGVYKuGy"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FA22ACE7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028213; cv=none; b=kmsLKTVzwWCOFW5n0PRg5Q2y3YjFaUecVkRQRwXtn6oFsysvtQwB5FO/iMOQv+TVKTZd6J1JTmsRZS5lSNZQbBrGTB5+WRTmRlrz5akTujHKK6NmFfPSLaj6V5D2F4xu9X/n+kcHglgetUwxDz+4SfM6oH/dRE0UHBzcRJtpy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028213; c=relaxed/simple;
	bh=I+YMifaWTe/KtcKWykwnguS02DQwUt/9Nd7ZBZTaipM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=emVD+1IwQV5y4iyckTE2Pg3o0Evj33Nx/Nay3soXULmWyRfUhYKCLPsCoBaeZdzgxvAeHqFHIWtWmuPl26vGxRz05dI/NGoY/Kp85AVLY53NK48H+mrkrvQUF0nm483tKHQ4eL4meF0WnQFaiYgjWdZ4gLzJ3J75JKCIL5b39mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aGVYKuGy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bbb440520so16872725e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741028210; x=1741633010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByURWW4/51grEFFoJ5cNbGWq84mjT1dgOMDzzVdymTY=;
        b=aGVYKuGyOfyU9UcQavzr01XQNPAZs5kAe6gKMjYHl4T7XQjPiPHek5YgM1iqH/1oDM
         M0xI8p3Ty1nK0IPEGz9ZQi0Ti2fi764sF/BZDfJRzJncCTkfG/BV4xA7z4hwkmtdzjLI
         BspErz0GpDg707j8UFSbl1drZaCkibpsQkcmK2/+F4wB8YW+ednOV946QvKqE1UxUMYL
         uahffyCxut23erQrfWsI577jiTlvec0IJqDVFYy29BKWM5xvEgAdxqXmM1yboAzK/geS
         YhgO5eOFtBbhSGu7L54G/fhZfS116c/uvGPtEOEtEQR/7yKFHqyulGPuVWupTgeZ9s2S
         7XqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028210; x=1741633010;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByURWW4/51grEFFoJ5cNbGWq84mjT1dgOMDzzVdymTY=;
        b=g2I/J1yf6EAhd61Uh2+ymDVKFGurPYybY/BRM/DK3nBJiyCfcG/Pc0tHI3d+nUR+rT
         gr7bowRQQQUATc4ckUX1LQegd34+b4vY/STdsCKmTw/R/2bYRLb6ZvzXhz3m09kxh2Bk
         c6Q6EZihmtHgS+PXRCTsYbbWFyvWH89t9YrFNqZmKN/aToBLIwiknV8hZVgZBRmD4jyc
         J/1iTmZF/THSd9EnEozitze/sazRhCDSjOUlr5UVBmriihq0U3pbKEsnLwzaznySv01h
         tBLGCkHksTAysJi4VjiDt11GYjL3HhAnMfm/wBHkkg02jpX5wa7S5RcSjEozUa5ioZYH
         uGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqu2FlrDp57F//McT55MtzXjcBEGqELcteWF0dKwMIjfXKIEV/cfT8nmdzHO6UOW/uO7yHsbezuWGWrp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8td07asB4Ma/Am1NAaiPh2w/dcKflpbo5lU6P+yhs6V2blQ3R
	6+ezT5mlxZ9dLeGQjJAYTNejMb3z8qt5sO2+OCySr/K+9M5nXm/rtjRY/3hodt/djq3BiGjIaow
	7Q4k=
X-Gm-Gg: ASbGncsz0RuIogiMa9dRgTMdE9UmpUtCmp9yI+yPQZfWOh35itxs6T0vrqqeAmDnwxk
	nOJromRpciC4QNXubVED1DloKDl+K/IGaQxmoWqLUgNZQ9SJKwaFBR6oRBH8cOBv118GtdX6f7T
	UHfGv1wy/EEO6RM9mKFOOgGAW3zM7KuI+bLMG5APuT+9lSjQY+6a1iXxLRKVxZd6silBGYFw2sH
	bYrrH6eB9hOdOeWOQx3T09M9TuFUMMkkGW6Z47+P8P11lesr3CJBXrTfJg09HrRyGrsDV1sqUoX
	FMMcED1VKctPf+CsV+6jpvegeT8iw0AwvbYincYZphSeQADuIEtDGw==
X-Google-Smtp-Source: AGHT+IGVUE0CQu4ReThqwR4ny9E8a1exZ2jLsRFt7w170BeB8vADyu6EQUUGy2xTMtQFYKiXpDs9Pg==
X-Received: by 2002:a05:600c:4fd3:b0:439:a255:b2ed with SMTP id 5b1f17b1804b1-43ba66e5f09mr144551665e9.9.1741028209871;
        Mon, 03 Mar 2025 10:56:49 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc9c0fb1esm12229025e9.20.2025.03.03.10.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:56:49 -0800 (PST)
Message-ID: <39213e99-3041-4602-9dd2-536e9b09ad11@tuxon.dev>
Date: Mon, 3 Mar 2025 20:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add System Components for Microchip SAMA7D65 SoC
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, wim@linux-watchdog.org, linux@roeck-us.net
Cc: vkoul@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1740675317.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1740675317.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.02.2025 17:24, Ryan.Wanner@microchip.com wrote:
> Ryan Wanner (2):
>   ARM: dts: microchip: sama7d65: Add watchdog for sama7d65

Applied to at91-dt, thanks!

