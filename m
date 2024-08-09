Return-Path: <linux-kernel+bounces-280421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7A94CA47
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29B11C20C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563416CD2D;
	Fri,  9 Aug 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ahENB5z+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8B16CD21
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183995; cv=none; b=reC1fKG/nhB/KrJeQWLTvv5r7rMNRy1JcP8Fpu8DDeQeZBDsb2J5Iaw5Wv6sV0vn7OXOdnkdE59OmyvG6bBRFWovmjNanAkl0AUZWZSCISIs+uoOym5sGp7JPLiU5BuBdRqQyloHOz2LPnwykt2QdD2e7CsuelYOPirCntcgZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183995; c=relaxed/simple;
	bh=LUfpBH5hJq5mJAgbujuJTG3p5WmKGZYJduZ2mr1FAHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXILkT7bWKYBvbb1MMs6E1EWoFg5jHlxOGCBM1U3a7TmxSo5GKBBhgu6r1U8kNRu/71bQylsK79gMJkAxiT74Et6z4j6P52bAptYw8P5NK5rWichCqA9e7fnoPAGLjsSYXnKuvYlFnZHu3otnc6OqJVAn3ZynoVYhc4qo3ZwsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ahENB5z+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso1923707a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723183992; x=1723788792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/PjL/AFb85dVI3DKWfWI3LllKjRgfnxTMskidgbimg=;
        b=ahENB5z+MloBxmOqNh5o1QYSYvHYkF5dx5+tdDiCVP9L4xEx4wrmiAl/juwjLX2mpw
         wbj8lUSHlXHlWn2r7PlczDt6uygdFYsB6vVM6S2Ta16pTyxFjJg/yrnz9ZIHPUOWG30r
         crinTGHDv4LAPhjqz1ZardPluk/VYGaguGTmTv5Q0LwWE0lWSEFvPol0cn97P31PblV/
         q5OpI6W6NnHGKbWfpuI5bKbKHUbgcipQLrDBzAD8Y5H3UoQG/cjt8/n7rG4HTDZ0Jqz6
         dM+4RBBr9cw8KYPesARAcXpxzERv3h1pdcoYUTuiU/qtuMbKYg9v1iTPbG5pc+mqU2G6
         e1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723183992; x=1723788792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/PjL/AFb85dVI3DKWfWI3LllKjRgfnxTMskidgbimg=;
        b=VmLmQ3eaVTkwsb0Sm+CFBv4C6diVhvMfwFQRouzyh/1sfz5sJmQpJ0YFGPEOLcBSHW
         pnFdCTozmq87Daj9JRXqMDel+sFfQHEORunjTCxX2IHHnlJ88wKO01dlIMqyo6Mfohwq
         NSOd4c5USIH7/shQb7X5TOk/QZAGtVBonYR6B+ldF4lr8Daus2JW/Er9XJdns2gJAFuy
         etn7phP6GDzv2wAPL4egd0brAAy2Pla5o/ET6x71qECsEZLiQ+gG7It/ggou9nTdeLw+
         1UO7GDe+VWD8GHPqvO+tUQYd/Ko9t1NxcUWtfmfxvAUSItzELtj+QVE/bzPAMlbubEb3
         hCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz0OQbTAZjnxCOQGJmA1BV6ERVC0jETfxN0VW+c6F998dzw5Dlnp2f6SVTSHITjISyax04tkKcrHb6uZPWNujUVlluzxwroK1O0bS7
X-Gm-Message-State: AOJu0Yxpogl07f9A0P5A1F+yfpOrfrGGA2JqnerBSzLrok+t9ZDHsyqp
	M+N41mc3Hd7CcRD+DBpw1bm+zcsXepaTPhiqF6CjvW9H3I3hgzj6HNSni7Uk8po=
X-Google-Smtp-Source: AGHT+IFnQDB/G3rJ1NYoBODYoPhd1Hk0v4H/4m5gWvj74OkkfQijLy8DyS3EE72gRgVcvkWwHXN20Q==
X-Received: by 2002:a05:6402:280a:b0:5a3:f5c6:7cd9 with SMTP id 4fb4d7f45d1cf-5bd0a65a9acmr429414a12.26.1723183992482;
        Thu, 08 Aug 2024 23:13:12 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2d3518dsm1319431a12.78.2024.08.08.23.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 23:13:12 -0700 (PDT)
Message-ID: <b2b3830e-5399-4c50-8676-b21479edebf3@tuxon.dev>
Date: Fri, 9 Aug 2024 09:13:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] ARM: dts: microchip: at91-sama7g5ek: add EEPROMs
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, brgl@bgdev.pl,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20240703084704.197697-1-andrei.simion@microchip.com>
 <20240703084704.197697-3-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703084704.197697-3-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 11:47, Andrei Simion wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Our main boot sequence is
> (1) ROM BOOT -> AT91Bootstrap -> U-Boot -> Linux Kernel.
> U-Boot is the stage where we set up the MAC address.
> Also we can skip U-Boot and use the following boot sequence :
> (2) ROM BOOT -> AT91Boostrap -> Linux Kernel.
> Add EEPROMs and nvmem-layout to describe eui48 MAC address region
> to be used for case (2).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [andrei.simion@microchip.com: Add nvmem-layout to describe eui48 mac region.
> Align compatible name with datasheet. Reword commit message.]
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>

Applied to at91-dt, thanks!

Please note that I've adjusted the commit message.
Please have a look and let me know if you disagree with the changes.

Thank you,
Claudiu Beznea

