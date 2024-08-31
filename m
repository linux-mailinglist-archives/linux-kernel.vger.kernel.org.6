Return-Path: <linux-kernel+bounces-309913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A09671C8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D2A1F2291F
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFA1171D;
	Sat, 31 Aug 2024 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FPw+WX3S"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC610A2A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725110825; cv=none; b=QzvBp3RpnqalnsTM7WkovoZ7hGEFmqFTCabIZ1ZQeI7UjZeq2XNvhM7Ea0akze3SEdJ+f/bAD/97KSZJeLlOaxqPRlz+yOJzG34VL1/r6gz+usAQSZT0POghCD0ocJjdd6o+UG2DpF/Dgwtm+MmKaRIO87DTgar9Bd9ZhGHLJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725110825; c=relaxed/simple;
	bh=9Em9kDNaR0sRVSjhQpnsFw4mhbqJ9B3tQjGc4PYipcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ouytkJdbuGB5q2JKm7n3uBRQqtm/Olazu1T3OKGEI9uXVTpI+iRK2KpcIlMz5MqmPoHxQhUQ0rf3BmfDjDqtTeiLcX3+XM21hdeEbRXh13v2VWdeU8J1SGAQyotuDX5+D4eB8BUWZFqNEc05RHQj0mulCIViqqMCaM0bNGaRkFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FPw+WX3S; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-374c3eef39eso81876f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1725110822; x=1725715622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+BY1w5DCyLK433UsP9jZVO/x34bvrtP71tqTdXc6Pho=;
        b=FPw+WX3SZ4+PsDautXm4iPMRkgZt+sJoP5BairK6rhO6f4NukKmke5Aof3NFbrx4MU
         abQAfXbO60LZtGKv8Edfo5zKAfcRn6hkEG//HkDI/AnkCsnHQa4Sp0XAHbqUUDyJNvDJ
         A39la4w7O/ZkchRscO6LyN5G3Gs0ccI6adv2i0RsPTj7zBFaIAM5J7yTmxj9aNzd6lKi
         Y87kacCmyLtIfbm2E4i+Nxhx5+r75dKHqxki3ceI8I3/Ol+bEXX/CtL3rcyY6GtWYjrl
         1aDF9j8dTZuedjoH+Xl/Zetjotkt3evQFhE7WJoDbG2+UjWkXOaB2nLt+2FgAhcHEm53
         KeuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725110822; x=1725715622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+BY1w5DCyLK433UsP9jZVO/x34bvrtP71tqTdXc6Pho=;
        b=tYpnjLFAQCNhfI7iJkL+HZ+At60lzzKURPJ76qyzqNcRAJEI/0YX323R0BhdpAzcFE
         WI6KqmCTuiEa1jMY2LdV53aIJ100Y4wku/NuPHCXhvjIjhv6QBFMnrQ9HEsi30cQKD7q
         3vtXfpK3KUuKiTlBywWNIoWdtIjNT5uCScCA+DSy5lMeibtfSzUALyPCzUq/G46tskVq
         OgCylqug/NndvIx/60L35hVdRnNUiZaUo6768Dp8YfODvPFFY8aHeVt3pKGuf8q5dNAS
         vZGKzXVeyYxerWg35VF7vZI6jhKh+jmUVNtMXqregZ6qOZtki9zB3plEKkaMwtKiGOv4
         gQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWlQY2+gKK1/6LRAE5m8n4/fdyhKT9+ufunLqkTvCEWs4qeEvLG3mQ9mcLFwxMUJl08rxPXkDr7Ytk+v3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqauWZ5sh2aLmQkHnioRiUU2DpDgrIZWeDbJMCBuETexKD+uX3
	8XPJjmNk2VZcAtn2TDIbQ9fI7S6SM1wz1pPPDX+NcxGfKRyn0+FmOfPYfTb0ETs=
X-Google-Smtp-Source: AGHT+IEzv/eVAxRNMdU2wq4teTAlphvteYoBIdsnL81eNzTOCEnCnsDnl8blLvNt9YmJkhp8bgamrw==
X-Received: by 2002:adf:ab03:0:b0:374:c45a:7fd2 with SMTP id ffacd0b85a97d-374c45a802dmr133150f8f.62.1725110821925;
        Sat, 31 Aug 2024 06:27:01 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ba30d5b8sm2893316f8f.15.2024.08.31.06.27.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 06:27:01 -0700 (PDT)
Message-ID: <5965ac01-f420-4e5a-973a-6008d738b51a@tuxon.dev>
Date: Sat, 31 Aug 2024 16:27:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clk: at91: clk-master: increase maximum number of
 clocks
Content-Language: en-US
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1724948760.git.Ryan.Wanner@microchip.com>
 <677567f08ae588bdd9f919c6501c23be075c0efb.1724948760.git.Ryan.Wanner@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <677567f08ae588bdd9f919c6501c23be075c0efb.1724948760.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29.08.2024 19:42, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Increase maximum number of vaild master clocks. The PMC for the SAMA7D65
> requires 9 master clocks.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  drivers/clk/at91/clk-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index 15c46489ba85..7a544e429d34 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -20,7 +20,7 @@
>  
>  #define PMC_MCR_CSS_SHIFT	(16)
>  
> -#define MASTER_MAX_ID		4
> +#define MASTER_MAX_ID		9

This patch need to go before SAMA7D65 clock driver.

>  
>  #define to_clk_master(hw) container_of(hw, struct clk_master, hw)
>  

