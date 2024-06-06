Return-Path: <linux-kernel+bounces-204375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D218FE7E3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3536B26C69
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB4195B2D;
	Thu,  6 Jun 2024 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="phrv5Lvc"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC7E13E048
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680802; cv=none; b=nDX5hJ583CGWDkbSQNJk9Rwuaq4i6AXVlTHbipPMXfYxqhLhVpuiKsoodv4sFRPQafbZGBePaK8I3YkHw16JZrQJYlev72Wa2bSwE5wa4OJ6LE3MZNbye3/wPrN2NBf+786pKIrBbe8tepHolFRnK5tdA4u1Ka6K2XUj2F03g3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680802; c=relaxed/simple;
	bh=Lh2gUDPVnlN9p0WrExloiI0bv+g9JrOg7vuZHCMZA4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqmuKVN2Eb+rklPpR2veUypgroMKkSV94ShdHGw7NVVGeU3EHTgy0wZAgejMnsVpQ2WnqsI88XE4Iya35k+vWvgZeO5ChOV/Pzbz01giQeJ/xeSA/yGF8BW4uvpnIi5SRHBK+dyOKv3aK64M+BjMfLAZksmJ4zSEWCfF9xfrr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=phrv5Lvc; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a7dc13aabso1188071a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717680798; x=1718285598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9vfJnrIrJKrBEEsqJQfUNJPUu7ekbSS5ajlvoZ3oR8=;
        b=phrv5LvcdQmoAjXq+s69j0xwpCYsSyIkx9zXkzx7kR43ekX+5rtXVV1DpoT/3QGOAM
         jUxHhmq4TsTqKA3/VhmecOw2qwvOoL2eTi5+PxK4loG3v1RiRuWTIPog9jtFB6rm+5t4
         9O67ofusARYELoxg7RM2DoO5e7cV5WcR15F0yr4jkA2WkvV24/IkjRD9D5WsW5MTp9UP
         dew3TV0UE6pt3RRpNZtbUvx1kYoy1jUTce9AEB9Mg4uP0ptCyQfDTeB3NzYdvHyCPpAP
         8HlTr8JbaQ9Bn3wwf0q7evxMmwYncTwdJa8Qa+YF12LReSk4uUCIJ3dYWyKzwUe76ZNQ
         6ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680798; x=1718285598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9vfJnrIrJKrBEEsqJQfUNJPUu7ekbSS5ajlvoZ3oR8=;
        b=O9sSqQuopQHja+ymhz7ifgwSBa9wP7shDaG2JxcomUpJYj53UYT/YCIyx6X6xlmiuZ
         Regife+cuiZGVVp7B1Xizg1vzIO7ut7cdJeGO7WBYT0TkSbJE9GY60Plmq2hxkkFJQmK
         Gkxw/I6DR8hhqWGqUjtvr5ur8YEcOqJjm+AaNvltCYEGQYBlcmuLYfskztu/DYMjp4Yf
         r4OsR0NpekJgByEbGsSBICqHzSvWAFhM2Rv8I54eb8bDO/N7KiXlrLPWGZdBLNY8TBkU
         axsXtIKu6JLabaaR7Hl3EvZN6eREuFtfN6j/xbF+2wN7rixh5gI0FyYxGEwFuCwRpE19
         Ac2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcLAhGe+JwAqk1fxZro89Hxu8wk/gV88x56HcNccA8GWdCiCFTlNYFYz0SkXkPWawD0gM8ktdK5Xs51osiC0ESZB4K5+DtaS5dnc/n
X-Gm-Message-State: AOJu0Yzjh2dLhFs1EusK+dsBiEpKFRUrtlW0sxKSCSraXjw9mzaFvtjD
	g0BhC6BOKfMSi4RvBnUNsjHnph+tk9tXFSNhVXJXRVdXjRXevw4zILU7wIfDQtQ=
X-Google-Smtp-Source: AGHT+IFoJD9GtL3GCiogv6CbJkDLnJ9CENNShalKA9gLKUp/ppTsRqeS2+q+/IrI887XwCzUUFS55Q==
X-Received: by 2002:a17:906:258f:b0:a61:4224:c998 with SMTP id a640c23a62f3a-a699fcf6586mr351582866b.54.1717680798512;
        Thu, 06 Jun 2024 06:33:18 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e19dsm96579566b.164.2024.06.06.06.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:33:17 -0700 (PDT)
Message-ID: <cdd6bc25-6282-4e43-9909-16ab918ed983@linaro.org>
Date: Thu, 6 Jun 2024 14:33:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: macronix: enable quad/dual speed for
 mx25l3205d chips
To: Esben Haabendal <esben@geanix.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com>
 <20240603-macronix-mx25l3205d-fixups-v2-2-ff98da26835c@geanix.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240603-macronix-mx25l3205d-fixups-v2-2-ff98da26835c@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/24 14:09, Esben Haabendal wrote:
> Macronix engineers apparantly do not understand the purpose of having
> an ID actually identify the chip and its capabilities. Sigh.
> 
> The original Macronix SPI NOR flash that identifies itself as 0xC22016
> with RDID was MX25L3205D. This chip does not support SFDP, but does
> support the 2READ command (1-2-2).
> 
> When Macronix announced EoL for MX25L3205D, the recommended
> replacement part was MX25L3206E, which conveniently also identifies
> itself as 0xC22016. It does not support 2READ, but supports DREAD
> (1-1-2) instead, and supports SFDP for discovering this.
> 
> When Macronix announced EoL for MX25L3206E, the recommended
> replacement part was MX25L3233F, which also identifies itself as
> 0xC22016. It supports DREAD, 2READ, and the quad modes QREAD (1-1-4)
> and 4READ (1-4-4). This also support SFDP.
> 
> So far, all of these chips have been handled the same way by the Linux
> driver. The SFDP information have not been read, and no dual and quad
> read modes have been enabled.
> 
> The trouble begins when we want to enable the faster read modes. The
> RDID command only return the same 3 bytes for all 3 chips, so that
> doesn't really help.
> 
> Instead, we can use the SPI_NOR_TRY_SFDP flag, which forces the spi-nor
> system to try using SFDP, but fallback to the parameters specified in
> struct flash_info.
> 
> This way, boards using MX25L3205D will continue as before this change.
> That is without taking advantage of the 1-2-2 that it supports.
> 
> For MX25L3206E and MX25L3233F, the SFDP parameters are used, and they will
> therefore be using the optimal dual or quad mode supported by the flash
> and the SPI controller it is attached to.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index ea6be95e75a5..090f28e05a5d 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -61,7 +61,7 @@ static const struct flash_info macronix_nor_parts[] = {
>  		.id = SNOR_ID(0xc2, 0x20, 0x16),
>  		.name = "mx25l3205d",
>  		.size = SZ_4M,
> -		.no_sfdp_flags = SECT_4K,
> +		.no_sfdp_flags = SECT_4K | SPI_NOR_TRY_SFDP,
>  	}, {

let's remove support for MX25L3205D. You'll then be able to drop the
flash entry altogether and instead rely on SFDP to discover the flash's
capabilities.


