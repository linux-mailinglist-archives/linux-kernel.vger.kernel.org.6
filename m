Return-Path: <linux-kernel+bounces-528927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096F9A41E19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 887227A7081
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A3723372C;
	Mon, 24 Feb 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Z2iuPqeS"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD3233723
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397421; cv=none; b=U45lupAt7Y94mp+Tg1w5LNO35sNXOhkp3NnGAsyagdDtdk1BcPJtcAPJonfq4TPsr5Lkf3ZpflrXJIitVhKQq5TUMPPkXHXVZ4FZzoQPqDGGPn+44PtBi+T2F4wT8cqYXXW91AbEA6n45RFYXb7p2gllITHMzVGdQPqu6OMPVEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397421; c=relaxed/simple;
	bh=zJgi9c8h4NJMSk2MLLGhWM7ccjAIjfSWRwcx5sglEFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wco8mjkhq+e7E0Capd4V8zFPkyjUP28vCU23FzDZTmXB7eYK/gY2WCLtdQFuDGG9NIxo8Nb/Ol/HgYxgjQTq5yMSKmCZI8q0GgqLS4tlWWgJV0GGz/gR8jUhcB9etfaXuy0xCKMaPvd9Xn8GHhIn9GTztEZmNLKYeVIofsmz4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Z2iuPqeS; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf3c3c104fso730683766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 03:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740397418; x=1741002218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D6Mlr0wbAMCOEN0+YLkpDA5vstdeAdhSzTHRytWnpTE=;
        b=Z2iuPqeSdG/EFquWVQGLu+nIJnwgwVJQRoUy5COipibk12la2JwLuaiH0bLUqlp/8U
         Cljlqk6JAnzECRIX1ZGt0aaucvHzP+TJQCTGlGvTi+XOi+EFXTo/jspv0d70HdWokGCb
         zyrPz8dOf1IWXfcKIgkLu3O4voiEOJoUUzezt+wmgTdn3GkQ2zAM+uSAX3dBzrXTaHJZ
         Vp/9G4LoNx67BSEH8lolHUvmExhyflslVs+uzCEgBp9/ighGuolzRoVwfPOtzVbZ+udd
         RmUrm0VYLG6jGvqCRcBaw/71DJTSkm9F5avErSmSktWmnrJkQlS+sfM+E1Bg8jG/oL33
         Jizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397418; x=1741002218;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6Mlr0wbAMCOEN0+YLkpDA5vstdeAdhSzTHRytWnpTE=;
        b=rmvH5t/dEnTKAATzSLYjrQ1vrgEoALGV7UxokBql6oD5G+gJpMi1xYukL95pncdZ+W
         JYic3o8Au+COfe0O0CVUNkKvPKqyZeG2omZPvJOOPDlnamcdLxxhDGeUmOqITBFlGRBI
         owmpUjdytLK/ezCvD5EDFHsLYu1oFCooEsmdON52ZoAj8YGz7QVhncVn8wx5q7ydRg47
         5Xj48oWu+BlnUCtG9nUae2WQmMUfEWUuL6WTbrkUMDjpbU3W6ngzHM7F85rAqwOZ4IyX
         kB5W4lpvKELIDELnLcSl0lJR5URBFLgfioskhzocnrQj/xMQPmamuGKb/dGfI+5q51mJ
         MYVA==
X-Forwarded-Encrypted: i=1; AJvYcCUmQTRDF228Kvtcd25dX364DW3tOy0nCEVU+Q7+BdodXqwg6lvyYW/ouXNbZbNYR/5SzJwVsFJoztFf4L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN5hj7gCM+CoOuO6OsnZNAIf11tiBPH+8nGVWO/oLAu6XETlu6
	heBOzak9SXavY3EFdyOPcCkGPZzNDmbnHT8jnwHZaHLTlBZvRw+A302j2ub8brg=
X-Gm-Gg: ASbGncsIyVONm29zcEcm+KEpF+vpYo3hWLVzNhlw/YuAQOGBbwd04Lx/RZmRORoVIwS
	wdxhxKF2dki+uJMPTsUpYma5+5370Eo33XO8v0Q9c/5NzxcxL/0Y0TByW0jn5xV6wazs3wtKQ2S
	xZY+0tu4gW6aI8+uGhrNg7jepvHwsA3hcam0boQ9Mpzmd/LWhm2cEEyraZNfDSGUfp9QqJxpnSB
	wN4HFuDgvb3r2Wkhtz9HFfelbfcvJU9dyiuKZa06PTqXYYKBYewr9oTJm6gZ+EcDSbKH12j9fjw
	01w7RZfExpbmgZbXKZHNzf9mtCzF0rP3Ng==
X-Google-Smtp-Source: AGHT+IF5iaBYNZgpTldExBVQhpm8bwV77vFMEYcbfb9p2terRRNut6cbNBxpAfkhBHP6mSJK7U7EiQ==
X-Received: by 2002:a17:907:7e93:b0:abb:6b1a:7b22 with SMTP id a640c23a62f3a-abc0da3b46fmr1334031166b.29.1740397417602;
        Mon, 24 Feb 2025 03:43:37 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8ab30726sm1658222166b.153.2025.02.24.03.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 03:43:37 -0800 (PST)
Message-ID: <2ef91384-53a0-4eeb-8eee-3f704416f299@tuxon.dev>
Date: Mon, 24 Feb 2025 13:43:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] ARM: dts: microchip: sama7d65: Add watchdog for
 sama7d65
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, vkoul@kernel.org, wim@linux-watchdog.org,
 linux@roeck-us.net
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
 <05431cf86beb742a9a53336c4ec792be8bde14e2.1739555984.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <05431cf86beb742a9a53336c4ec792be8bde14e2.1739555984.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 14.02.2025 20:08, Ryan.Wanner@microchip.com wrote:
> +		ps_wdt: watchdog@e001d180 {
> +			compatible = "microchip,sama7d65-wdt", "microchip,sama7g5-wdt";
> +			reg = <0xe001d000 0x30>;

The node address and the one specified in reg don't match.
I will skip applying this.

Also, please sort the nodes by their addresses.

Thank you,
Claudiu

> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clk32k 0>;
> +		};
> +


