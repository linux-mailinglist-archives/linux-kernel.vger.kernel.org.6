Return-Path: <linux-kernel+bounces-546292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A2FA4F8CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B9F3A9D85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6AF1F4194;
	Wed,  5 Mar 2025 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oUDbmfB0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993C1F150D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163415; cv=none; b=exQxh3TvCZqbs8DYhfV4XkFjcUetimecFNSqCpKa7WTqFfARsV6Lhz94OE0Z6NXS5PR02pMb1W2yfgD42eEk46+sV/iSi/HOPJ8p2LyQtLaHIeK07uHdgfAhXMhtWgrWZDqvX4rdYpubi5Y0oIuK9O3UG3xKzBBLXr/9Ndo3Spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163415; c=relaxed/simple;
	bh=7zIERAh8EpXhm6h89t7KnxUmJQwcOwho5sALkg39q5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjNvsQXRyY/Wz+B7vqqiHijTNF7bwl0BpvjkwefMT1OAyFczzVCsSUFfIbuY7tfHRY2VOtHRWub0QTLBrpcQW9oMLBpH1fxCD4NF5vkfqiMeiy2K8h5jXX0p49dfsY/3lsgE448Is3QKeoCTybCQ+jCoR7ITUCu5e7kr456XGdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oUDbmfB0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390eb7c1024so3763089f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741163412; x=1741768212; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pRZw5w+2U2qZZUcZUPyn53QbNuJsJLbWvkiinmtjsk=;
        b=oUDbmfB08255YHGP697eyTIiS1KxIiBBUIf2ONlLq5Qth9GngoetTc0sbam+3PZt7y
         pgJIz+ieTPJj6PRMiGucNLwRpzzE6RzYMQn3zCZfAg6aTfFzrN4Rdc9SQFDoECM6O5Gv
         cYTm9pKHCoPWTEfdmu+nqQArpyejEPUu1RX1ElPS27y38zja9tLGQFRxbyjwpn9S6IZP
         HgkJQAhXKtqTk/xx98GxleyVx3/drECyDm8qIkVZfMzzGbVyilT020ADZ+iryBNPn4xn
         J5pb62vgk1vzQVR/eyxfWmSmyij8ZaQ1ZG0PhxL+9vtBTQz6TiEnMtxhjzNtzWlcwIoT
         4/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163412; x=1741768212;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/pRZw5w+2U2qZZUcZUPyn53QbNuJsJLbWvkiinmtjsk=;
        b=sZZJImwkuUWOP/c2oaEU9c0YJjhCSzHgrpUIXLw0A2acDRCX3wnAaL7IUdEjokSgcy
         MrVCmwPVGe6BiyhCGmXu+f+SWihtkaO+PqldWejwiGq0o+B7zSsmlyhDqrpoOelX/TRQ
         Nh2QcAceyEWbiPvIIEDJ/8BeQ9Vx+WrXb4iqsJvU98Crjg4QRIhx1uEzZxHgJ9JeF29J
         kOlWqDRtn65QZRZGT3+WfI1jdc50hE6rPgzj7scS7NZdfwKtaqroACtdzv/wQVroFQAV
         39hettRyB8/LoLBbH1uFYo68P75VxBiPLWHW+Q0dYq28dfRVEnNdnb5wNuMCEgciTop7
         Y8iw==
X-Forwarded-Encrypted: i=1; AJvYcCXI41ZBeOazpJqReHj0xDpLvtAN0tcF2FAKL6hlHVFOhSx3WLP2zi62BEbIV+8/lhZJQdzbDM5TJaIzYIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEDhlV+VbkhFmCpdgcD/pvXqSKAORlQhDJyba8O29yPPHKpthF
	BUwwEb9CqU8wYNocjNwjs2OCYXZHkrlzH0bP4hvtym99/Qauvt3KTYor8Xaulxg=
X-Gm-Gg: ASbGncsjvrlxdR17PYVe35WafhivGWs8j+a7ypSs+5+Qt7Vpba08RgBQf5MTwo0ykke
	C67zhyqwU4UjYlfZbiVQ71vzQ9Z6YSKmhQAX0jOczmvFa94qCkOGJM2Styi3XY0dzgRI/v/nOFw
	W22417C2+rh0Ex00OkClzDS3BiUj2/+PqwDw/RnA7x0KmCgI+q2CNqRR7+/FhgqMOEYLdhZnE27
	5i4zqKzDvhqfI8kNRJX+pu1p9qLlATViB5diszAAyH+VJGIZwNV+AGgpOhVANAHdfykKxIbiDlj
	pZAo69gERUyJLjWrDzdk70zPnyjEBqFgtm8x43XiMRgAqVKtnKV7dQ==
X-Google-Smtp-Source: AGHT+IFSdzvWtn7tTFdb3Ley/k3biVDCTE4cufgwD5dIqDrEulteNMEUpYhuCzwhg513O9Qc/kl5+Q==
X-Received: by 2002:a5d:5986:0:b0:38f:4d20:4a0a with SMTP id ffacd0b85a97d-3911f756bb8mr1512469f8f.28.1741163411612;
        Wed, 05 Mar 2025 00:30:11 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cdbsm20550527f8f.54.2025.03.05.00.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:30:11 -0800 (PST)
Message-ID: <1e33b374-0454-4d03-a673-75f36e6fabfc@tuxon.dev>
Date: Wed, 5 Mar 2025 10:30:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sama7g5: add ADC hw trigger edge
 type
To: nayabbasha.sayed@microchip.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250304-sama7g5-hw-trigger-enable-v1-1-61b5618285f0@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250304-sama7g5-hw-trigger-enable-v1-1-61b5618285f0@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04.03.2025 08:15, Nayab Sayed via B4 Relay wrote:
> From: Nayab Sayed <nayabbasha.sayed@microchip.com>
> 
> Set ADC trigger edge type property as interrupt edge rising value.
> 
> Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>

Applied to at91-dt, thanks!

