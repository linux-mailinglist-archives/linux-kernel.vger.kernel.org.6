Return-Path: <linux-kernel+bounces-267347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F02941086
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD4C1F25E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC81199223;
	Tue, 30 Jul 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/42hQJ6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D949161935
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339186; cv=none; b=JdDLFJymvjExa8ufgsUFld3ijjRxz6pXqL72ZSwC7QoI5ewVpI3cBc98YfGx35+htboewCHWrcZjn5Tvqsx38YBA4H3ISGkiKLQ0CG0Uv7ARE7SkjSdUzNd6Tvmi7OE/gIDwHgAJXA1JYG2YjffHkfp1xOd+bQ4gQk/omYvkZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339186; c=relaxed/simple;
	bh=ND9dWSaPMwaSFgdy/M8+zvjQnmTpjbvQ4pmhp2iffxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/e6UhSPmzv5Kdhe3yxjVAXB1UynImtMJEVsKBro3U+BgKr+mG2xG8vfaQE85qJNEKpx7o705sVCo/GcS8m639eht80TJCMDjTG4pYTQ+LulfS3yvB4GAau8io0iC0607Cdnf3cjVlOq29jkCvoyU0tW9pJlMa6Ate3+3Q0dZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/42hQJ6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso418070666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722339183; x=1722943983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGrqCdIbJB4kLBzVc6vEIIcN2LnpLgEe9LoSmjtXu+0=;
        b=U/42hQJ6+spejMCF4H+koH80DUN5fGr9rKht9QWJaFOoMJoZEFJp0O3YSnTYA8MeL1
         DnQxV9NGz+eM6pIMuh1Df2NnHvLyYCoOQgFByjAsPDh1dbvGLR6NRSPq0HDZnxTsKrpK
         h0AKDLEhSAIp/E1EOA2bh+ohs86GfBarKrV1lz055qC3ajeCu4CQnAwkbOWaqCfsLyXL
         AJeD8swigND+yhnixzj+oGq9hqjyNNawxQEe1bo5aBLBVeN8YPoo2voahbBFzjd6RYEs
         cPWAdW1IY9mh/N3yi551Xwf/WtI4frNUCspnZkON5HCyfp9G5gN+UDeqqcmhXY51zRqK
         QL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722339183; x=1722943983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGrqCdIbJB4kLBzVc6vEIIcN2LnpLgEe9LoSmjtXu+0=;
        b=Qg2pPMLKVoDvsGQUmtjL2o03kGnOD/saSjuXcbwcSNP1WwKABpL43p9j+mXKlVlWVz
         rzUltWCnQblTWNAOdctCPHqP+AmDUCWyLRiM0OgpozdSJ2Gm9ifLISS9V95pHtMvHbi2
         3Qt/DaGELB8ZJjTS/076wQ77BCITJuXTi+oE1hQan1I1EsBxzwaLWv6HN6ksPR5cA3ag
         0QzVNGK7xwkQPSxZ1eo1PaZ85q5GdlEulaI3+jk+E1HQM51M158/6QPQrDB+6VsH2QZ/
         POcoPQgorDqRbfKc9PVmudTlRJGw1HoHmtw8q7woMvaYTCGnaPH5zbGxyRUIRztSAkh1
         1yhw==
X-Forwarded-Encrypted: i=1; AJvYcCXBDfjU0Gmlfr8TyEngqXgHTmd/fW/GD0uI67ryaj9t4yhEdDsb1a8pb0FDamAmDlhr33wXovxA1M6yo/GERcrydnH6fwh7Mudc5F8k
X-Gm-Message-State: AOJu0Yz6PWKFukD2unJHHrHAeJTMlQk/LWHaAJRW0xT1eYnQ4Q/VGN5d
	TokshLfIoWN05BFsHxg7kW5a616AU3BUEsa+ZJwTqubjwIWnHiSYOO8wlfesA2w=
X-Google-Smtp-Source: AGHT+IFMbs1ZTtf8Vsd7RnM1UPZIBl9v3hNGf7hvVfcYCgMKV5fTKWqhNUt5peDUHpXqJAPKMYSdCA==
X-Received: by 2002:a17:906:c145:b0:a77:c364:c4eb with SMTP id a640c23a62f3a-a7d4004f339mr721159866b.20.1722339182686;
        Tue, 30 Jul 2024 04:33:02 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.215])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2311asm643341366b.18.2024.07.30.04.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:33:02 -0700 (PDT)
Message-ID: <454deacb-88cc-4ab0-80b4-006d863a56d2@linaro.org>
Date: Tue, 30 Jul 2024 12:33:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: micron-st: Add n25q064a WP support
To: Michael Walle <mwalle@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
References: <20240726185825.142733-1-computersforpeace@gmail.com>
 <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <D32OADQF733D.3CVS3ZRPEBL2O@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Brian,

On 7/30/24 7:51 AM, Michael Walle wrote:
> Hi,
> 
> On Fri Jul 26, 2024 at 8:58 PM CEST, Brian Norris wrote:
>> These flash chips are used on Google / TP-Link / ASUS OnHub devices, and
>> OnHub devices are write-protected by default (same as any other
>> ChromeOS/Chromebook system). I've referred to datasheets, and tested on
>> OnHub devices.
> 
> Out of curiosity, there is also a hardware write protect switch
> somehow, right? At least that's my understanding how verify boot
> works.
> 
>>
>> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> 
> This looks good:
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> 
> But could you have a look whether this flash supports SFDP.
> According to the datasheet it looks like it does. In that case,
> could you please dump it according to:
> https://docs.kernel.org/driver-api/mtd/spi-nor.html

This would help getting rid of the no_sfdp_flags and size from the flash
definition. Another reason is that the SFDP dump can help us
differentiate between flavors of the same flash, if it'll ever be the
case, and help us keep backward compatibility.

Also, if you care, would be good to extend the SPI NOR documentation on
how one shall test the Block Protection.

Cheers,
ta

