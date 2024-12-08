Return-Path: <linux-kernel+bounces-436472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0B9E8653
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335BA281531
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FEC15D5B7;
	Sun,  8 Dec 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JPtfCPYD"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264313BAD5
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675122; cv=none; b=V7pqUfOEXMuMYk8rgnLeoskNtQGjtbpeoM0n7yJkIsNDjf+3ghnJv4RUCO4sRXjwPiiYrrNbfqLt+jXQl1JvRrEz4DvifZtSvmzPGy78v0dxf/fWxOfHC6sOSZDvm26wrJ4Bfo3piPB21UzVsWY8+KBmKlKG8UkXsJZJ5A+9G6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675122; c=relaxed/simple;
	bh=XCzsuhWtTBgtikcHpQDU1X72W4M21kQHkNT9eU1FAm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLuRBY6vFV0+aRrvaZLXLTPhMY6R+xKj0dmyA8OOrHfHyMK9OrpxGjq84yM8Dx5vV/+OXz1UrrEvxnR94CGaiXTlDM3FDHfvaNGy5ZM5461u5Vbq5+GuE53M/X+UIrxmlcSdvAfANrobUJR4qjWIkQEitFOJpw/4W82UCJ9aadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JPtfCPYD; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so5666925a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675118; x=1734279918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CL3RW1M+1jqdpfrkKxaJcNdqzAjdBj4zOd/4LxQYQ28=;
        b=JPtfCPYDuQDj06h8h+BLrPJzg/AXfRYTSlqafQby1FIHDPVYsp3WwvWVeqpJgyOtLV
         9lDr2Hc+9G6pcoQZFz4Ip8sk6giEqX1uWgDYzqUV+dnAVnKUkEgnaQG/8qWOMno4jBQK
         gpdoFjrJnXRpLdZmz8pNdEVWZl2FBju7+YEULByZJ+VuEL69iosjeokNCHr/fl9JcS3B
         BJmFqJhblfn4GJvsQZlzR8AuUVnArMm00PdjQQbpLekOZ18xxr4fCSjVP11SUBdHceec
         GAwzYCe3mnmtfdVNjBdRTxUWFNCQjsWGhegiCtRVkzdKAEVOMN04nEHKFeYTlzX6NvN/
         mcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675118; x=1734279918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL3RW1M+1jqdpfrkKxaJcNdqzAjdBj4zOd/4LxQYQ28=;
        b=V4jWrMu5Act1Z5V6eBokDfdea0NES0kOWc0zhlwCNSYKEUKinqD1Mq2dFFjbVK8UUo
         c3tMrq2K0lnGCNH225wVLZeMAwN7x9GGhGKcwgtLrlhpAgrGsXJ4QdhHNxY7TWs+aL9l
         9A3V2dOhKvGKC6o6vt6dMjTkz0p8JZ1YptKPVFN2FypuJRdpAxB+OvqdZKK+kUaMBUcJ
         Mdzf+UOmhy7S1XfEt+wSSo5K8ooWECVTOYyirRsys5QoQCbmWalTtuaav4rv0/BVOX18
         4JXbxQ127K+NTAe8bx8LNbXVKiEleGkYHcYQB8yGyNfVJ54KFdFpHtBT3E7NXs5CsrRi
         oqTA==
X-Forwarded-Encrypted: i=1; AJvYcCW+1ENS/38OK+R/0sJXWbiz4tB5WheAuP/DbSPhMXKU8gPnJDTbFFu5qUVz4WevdVdFg2xE35Je6tlFc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3N0G8Sdgi9B91D12/G9rnhmpZRpOPcWIwldT50rWKj0NHR1N9
	AJ35krLXBvuQI8dGnUgDUf0rn50JWFb31JPcX4yi/cwI2lKqf/mv6Euf2Sx1dpY=
X-Gm-Gg: ASbGncsD7+VdypywCJ28MSBtfpe+Wj5Os0EflHLBV884CHeCpY+2lglh5U2jYtMBiFz
	IoBuQh9j3t5blOTjebKFOTd/ZeMAcYqU9SeGeluH5CwyVg5ld606WIOGKB9DK3YHf5AxPmQ7Wik
	We0qVtm5FMwO7f0ttr/Ofx2+VQ7OwEjUN/NoZDhVSBIfIL1ogYvCXHeMUeXmS6BMvlvBE1jgAJN
	HarLRIX+gFIvjd1FO0q6PXmHhjmCgnwWsBihZvM8o7ZcQbIn69UN2hZEHk=
X-Google-Smtp-Source: AGHT+IGJWEQkcn9gVXm4gaCzJ3nLfFkBCixjRRK2yzf+GnrblXYRmSu5ZvLGFdA9zVJtqFoG2CIf5A==
X-Received: by 2002:a05:6402:43c9:b0:5d0:cfad:f6c with SMTP id 4fb4d7f45d1cf-5d3be75abbemr10808689a12.21.1733675117744;
        Sun, 08 Dec 2024 08:25:17 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49e48sm4883698a12.30.2024.12.08.08.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:25:16 -0800 (PST)
Message-ID: <91b98edc-4313-45a8-9bfc-7df83b3d5640@tuxon.dev>
Date: Sun, 8 Dec 2024 18:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/13] dt-bindings: clocks: atmel,at91sam9x5-sckc: add
 sama7d65
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <b7a8a22a571f6fc2be56a25f26757f37fa8d2bb3.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b7a8a22a571f6fc2be56a25f26757f37fa8d2bb3.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Dharma Balasubiramani <dharma.b@microchip.com>
> 
> Add bindings for SAMA7D65's slow clock controller.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

