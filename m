Return-Path: <linux-kernel+bounces-517237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D389EA37E06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD927A176F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BF1AAA1F;
	Mon, 17 Feb 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cc0x7NLC"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB9C1AAA10
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783458; cv=none; b=HLeni19o9ywRC9+vq3eXwTB3P0LFS4d6wj4PU+CJggUgglOwP4yscODtD8K/V1uzZY9Y7U3FPi0cWBU5yjjvLR1HSTf/bSnJWBAat7hacDJosaOBrIdP/pqWXuAAtytNC2TZCzOd5Uhbr4ybJbT+vPe4iXefrlfOLp1WeJCahYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783458; c=relaxed/simple;
	bh=HLjdC5s5Tz3v7HXZmU/fyqh/2tO8WiXwKjIVXQyQMEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyCocuP5OmKQaOCfarX8hhdlXKcuIFKUAU6hVBe1OlLo0vZpkVRsQcKxUTwyE0kMnRw4aGIty18kNF0SX1MkHHSNKn+ho4eAZh/7oOCrKOxNJ2AfnHn/DTpAg99QtM4YYdqM8bIngBMXGjBnROd9lyFP5Psn+QfnfbiUfidYPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cc0x7NLC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec61d0f65so856163066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739783454; x=1740388254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpE+gU66/VtFFZtfaCY3+dZAi/5PEF5XEsIVpkUzL/0=;
        b=cc0x7NLCeyUrJ3ZPFz09bmCY9UJ2GyPyRNhGnp5EJxYbjToglqrXCGmvicSe2u2qnx
         4BH/8DYEEBK77IYRGqfy98paheT6unp1hfoacn/B5bgAgAg8dxy4N3qqiJqnS57L++LK
         tovBQChaXC/g4ZivJVSOM0CF8Ixc4k+X83sLT8At0u6lqZPGAqiRHczKY0HTVUNou/Yk
         zqat050lE+hY5ooWCR1fSIy5hHufheG8qTUD/mLUPhBqeAAP4q7vS7fJDCzyZKnw0BGh
         X6v6sN9OfzfUB1/gg3o3zdck6lPBD4v6a5CSZjFPUkFtOFGncdBGpeFvT7ZfQa7dObDs
         fR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783454; x=1740388254;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpE+gU66/VtFFZtfaCY3+dZAi/5PEF5XEsIVpkUzL/0=;
        b=iM8twMf2j51kQOw4qwtSGVU2HYI/L/ZLOwvE4G4sG+BWEP6zaq3ecz3gzG5KuoMDt9
         00obxCrUNlyoDaLxMKdH7E+qtFqIwJvu8cJzSnQBLopgMJxlZH+Vwz3skTlvXueEDyJM
         /Eww7kee94hkbJqQFzGxDe6nyAaHJlraLVc0IihaolDoiZq8OWEpEjXcKJbpIifyCwZb
         o4Lms8UtjaEXpAQ2LPRTJdpTRz6gxxhzrN9cyjzbfgwFnOwMrDMl5w0hH0mL+pkn6cE2
         H7SY6d0tzxEiO+A11mXwJzcKfsX8SFYm098RvA4tm/sYiLwOzI31e4WPeROmK1KTXPWg
         Fa2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTQwUJ5VAQ0/q6UViUOOIHrQISbUo5z6VuKAOXtefu3RA6+nlxfKo1W8fXYE1b1iXDkTzHtEZHxHvBik4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwScO6iSOdYJb3JXAV1t9Vk2xDqO81pZ4G08FPMoI2r6DIqjcLx
	93EMLiQjSux7UL2nWtOdMS8CEEgHzflVbbc3c1kqjLoWSwJ1BM7ilOXoeRhUpWk=
X-Gm-Gg: ASbGncuggZfHKP70Xz40fjeae8YsivXz+TE1AFDYBBaCTtDSTPTzaJvrhOrLFGl9B24
	h+eZWuzzOO0f/UPZ99b0qCqfqbsudEyKwm+SylWe/E4b7uydwI+38+W9+ABLD5WMgVk99/Qyqks
	TOqg5lGmw/aqcj6g3fTdT9fHDdwTrCP6eqwA9MVlWn3GCoPexLB1HwnrsQlHvxxY4vbR4UH1y3h
	DHiFMmKO71WYgqL3JcQePuApUYhBnKGkXkTriP6knrr8JnzFpf8/m0oa8eiY5AcwFdEDGs6khMS
	wOxIcRlp8l6MOGDrsdFebrA=
X-Google-Smtp-Source: AGHT+IGdA34WvOQoa211cMFIH/mjnYm202WDbH4ck0vbSETl/ktewNG48mcP+GJedsZFj1k9+lMhBQ==
X-Received: by 2002:a17:907:1c21:b0:ab7:f36a:2563 with SMTP id a640c23a62f3a-abb70d3cfa1mr834993966b.21.1739783453770;
        Mon, 17 Feb 2025 01:10:53 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abba3d765acsm91405266b.130.2025.02.17.01.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:10:53 -0800 (PST)
Message-ID: <1784e8d6-c754-4e7f-ad48-611b9c392eb8@tuxon.dev>
Date: Mon, 17 Feb 2025 11:10:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] nvmem: microchip-otpc: Avoid reading a
 write-only register
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250210164506.495747-1-ada@thorsis.com>
 <20250210165050.496486-1-ada@thorsis.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250210165050.496486-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10.02.2025 18:50, Alexander Dahl wrote:
> The OTPC Control Register (OTPC_CR) has just write-only members.
> Reading from that register leads to a warning in OTPC Write Protection
> Status Register (OTPC_WPSR) in field Software Error Type (SWETYP) of
> type READ_WO (A write-only register has been read (warning).)
> 
> Just create the register write content from scratch is sufficient here.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")

Fixes tag goes above your SoB.

> ---
> 
> Notes:
>     v2:
>     - Add Fixes tag
>     - Remove temporary variable usage
>     - Reword misleading subject (s/writing/reading/)
> 
>  drivers/nvmem/microchip-otpc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
> index df979e8549fdb..e2851c63cc0b4 100644
> --- a/drivers/nvmem/microchip-otpc.c
> +++ b/drivers/nvmem/microchip-otpc.c
> @@ -82,9 +82,7 @@ static int mchp_otpc_prepare_read(struct mchp_otpc *otpc,
>  	writel_relaxed(tmp, otpc->base + MCHP_OTPC_MR);
>  
>  	/* Set read. */
> -	tmp = readl_relaxed(otpc->base + MCHP_OTPC_CR);
> -	tmp |= MCHP_OTPC_CR_READ;
> -	writel_relaxed(tmp, otpc->base + MCHP_OTPC_CR);
> +	writel_relaxed(MCHP_OTPC_CR_READ, otpc->base + MCHP_OTPC_CR);
>  
>  	/* Wait for packet to be transferred into temporary buffers. */
>  	return read_poll_timeout(readl_relaxed, tmp, !(tmp & MCHP_OTPC_SR_READ),


