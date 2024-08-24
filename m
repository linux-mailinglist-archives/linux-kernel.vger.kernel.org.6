Return-Path: <linux-kernel+bounces-300063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EF95DE51
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C655BB2109D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12950176AA9;
	Sat, 24 Aug 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="a3CXnEL7"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9691D545
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724508943; cv=none; b=ajztPmp2QmKwQyfX4Zj1XcEbTr/6s1bHEXxiys8mFvOg/SaKzDc+4wrjUWQaZeUy/GyAFGaAymqYhM7yAgb5lmHH7f2kJmDiJCrZm9VWLLU6t0mf3m6IPnZvZj/UADk46K/34+a9nrH7VenWMLujaKzy6/5edHR6HjEGwqmYOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724508943; c=relaxed/simple;
	bh=ylyyc5upqH2H63Bat8/KTYVk99gT+edO+ULoJdpozlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENvSARMA5RrHNiMllNWs8FtQbEzEN6KaK9DX/hjcit7J4xfAUbhkRrUN1PKH3WTzRXREQ7RDuyPptBCcoeVa/JloT/ykKw2KjkcqNM2KgqQna1foBf/OPgC2IOqfFt9DfMbiaidJyVDY7sB1QkuRCxTO0Ww3/r+SQtzR9ev8V3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=a3CXnEL7; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83562f9be9so288241766b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724508938; x=1725113738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UfsvyUgRM9vDT3+qEMPlkf4NcRqOaBZ3rc+Db/x0GR8=;
        b=a3CXnEL7RJ2Pc5HfkuxtzMyxGuFEaqRl3Ztc+BA6TLiHb6qh72FmngmhH+waib0lJK
         GcwaJDv6Lfh8Y2WF2BU9iPkdLqjdKn4AUC2ewjJmkEAwoTrvdfrYNpXMNRKSl2onT9dN
         RwnAme8Pc3ToAWYeal5DyFBOP9hXziw1pzQdL2W6J5NBMBhAjGy2mVeDcJ9igKMj9qK9
         L7kV9CkWicSLexUBUL6aEx5XLaI39/DppUx3LNz24+6jBaX6OQ2+X+X+i0FQzTalphpk
         KscZEcKk3aPbLekBW6sT3HZxVkQzVvkAkdf4vtG3dKI+R4HjNJlnK9ypX8a0qwEihU+m
         6x/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724508938; x=1725113738;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfsvyUgRM9vDT3+qEMPlkf4NcRqOaBZ3rc+Db/x0GR8=;
        b=f9mpSpY7WB8g01xBgL8Pc4+IgkAjDmVpTU/y8Sb8q/r9EjWk0qQJSd28Ddn6D6PH1A
         7XUZBc8GOOIJHmEjEX76v79TmiD0dgdRRL/+HRq7YurxcV1koqx8WSwMiS81ykA5NHFt
         aOLUJo0TrpDAipT+zCouzg0DtE5zS5p+zeg9qey/L7arG+4fUuXq3RKxezjJW0GZIGy9
         hLWJkEE+5zFvkwsaHhbiwBxiJNZRcCUsHxuzOWdEij6Q5rQ2uceNbkNQ2tswo8dl0hsw
         87q9H/CoCbhsimX4XXYLXOntnHQpNLG3QcFG9LLAQH6Y1GBzIzIt16VHTVFZN+/LWSyu
         IaKw==
X-Forwarded-Encrypted: i=1; AJvYcCXTSV57RwuBxa2ujAIFtmjI/S6cQEmlJW970xK5aqjR2BSV4p0HBkIDKsru/NKUfZxIJPFWlW/tJI0fQGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw1bgpv3kOAQi8oygPNgrS5gHNh74WtGY/axwPZapdIr4/y2Zm
	ztP5HJM2KzNueLxRlhOjemGKNM+M8YzWXjW+ExCSg2coz2TDEX88R69Oc6flriM=
X-Google-Smtp-Source: AGHT+IGDP/v0cG7L2RbBg8rsiuhnZQtctkJOokkQMWP1zT1B3q1fVN7UF/HlJDGt+p7Jv2G/uMdoGg==
X-Received: by 2002:a17:907:3da0:b0:a86:817e:d27b with SMTP id a640c23a62f3a-a86a54b05f3mr386595566b.43.1724508937735;
        Sat, 24 Aug 2024 07:15:37 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f3a20sm403725266b.195.2024.08.24.07.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 07:15:37 -0700 (PDT)
Message-ID: <ca140cf2-1773-4f5b-babe-3e11d579e71e@tuxon.dev>
Date: Sat, 24 Aug 2024 17:15:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add input voltage suppliers for PMIC MCP16502
 regulators
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, broonie@kernel.org,
 lgirdwood@gmail.com, nicolas.ferre@microchip.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, alexandre.belloni@bootlin.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240812135231.43744-1-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.08.2024 16:52, Andrei Simion wrote:
> In this series of patches, support for the *-supply property [1]  is added
> (correlated with supply_name [2]) from the core regulator.
> Link [1]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L471
> Link [2]: https://github.com/torvalds/linux/blob/master/drivers/regulator/core.c#L2064
> 

[ ... ]

> 
> Andrei Simion (7):

[ ... ]

>   ARM: dts: microchip: at91-sama7g5ek: Add reg_5v to supply PMIC nodes
>   ARM: dts: microchip: at91-sama7g54_curiosity: Add reg_5v to supply
>     PMIC nodes
>   ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC nodes
>   ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PMIC
>     nodes
>   ARM: dts: microchip: sama5d29_curiosity: Add reg_5v to supply PMIC
>     nodes

Applied to at91-dt, thanks!

