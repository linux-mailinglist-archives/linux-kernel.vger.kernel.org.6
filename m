Return-Path: <linux-kernel+bounces-251817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF72930A36
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8735A1F2199C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D52132111;
	Sun, 14 Jul 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MteoV7rC"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7E132106
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964380; cv=none; b=LKnwDcZkpx8rvoekQrHx86QHYQipVryryfr48VFOwF49q4G7LEzlTohQZb27t0bXoAjyphVvwMl5SmX3gOPFuoP5LTRHxmaD0LnByK2ovN1hI1ZjebO3S//5GReQSV+urqzXZINzzR0SIGfckjQS38BOCfJL4NkPjnI5JS8u3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964380; c=relaxed/simple;
	bh=6MJHalS0sNrCA+xbhaPI6x2za5a/YVSdLA+2rmpP1o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFOuOvB+66coz7YXJMDmgQMX7FobHAlydBGqiOJdHw3dB32JXlH4qFZk0/yXHvttl1gmvRwfi5FLuEMJ10YNC1IEc7lswr/k5cgoT8jlygrGarQRS4fLmKgfK2E0nh97uoyt1+vwhYrAbEpJNZHsq+3gxqro1qp1UOWAkNWcUWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MteoV7rC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266f344091so25299105e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964377; x=1721569177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2hvoP8bymcjCbxd1ikVm85o7S/ITtdMUvn8D2WhS9U=;
        b=MteoV7rClLUfRgFs2GBjk9pvvw91GaJ/Tw/q7LnZXGR4Ex77WZrhD+tBSpe/TIVYS3
         pNEHBvM4YFZjzyoI+t6RcEtTRN942GPsGjo5tlo8XHj43Yhb7RU2AdBxQ1BoVzVIFaIv
         fUYT51xVDeD6KT9W9I0SrBkFVPOzbdosYiACIRBmExL1JJPq/8EoDBbevwYTd4I7s5LR
         QuRVTqVj93Ce0/z8yzanlmE+W9e78pMvzscJqUH0rwqMsNY3FLcVM8IgGejbntkVVbsq
         eqm08pGrhsPPoG2pbCaeEAfF2oeLzowZ5McWgYKDNWgYJHRHixXuUHvukCxCzVkoqZHm
         qdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964377; x=1721569177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2hvoP8bymcjCbxd1ikVm85o7S/ITtdMUvn8D2WhS9U=;
        b=mRd7vHqfSTWYAV62NfVODs0xLwoUiZp/z6m86PUK2sYJ+xq1Z8WMxblWDhbzaEJZhE
         mQfZ5qKEcP0Kgn3HefAY2t3LZ3NQZLXh8YC8CyQusRzKyKJ0oTbcbDRp6TcetBzqYMmr
         Izrlnv4xuhFrXiOu6TPJ+nsmXYoC6iD5oQe+RmCLbde7w4mcvHFVLrmI/voUhzf6BFmM
         J2kU8lbYNJ2XTKpauURrBblptwZa2T6Mv7BO2ayRfvIavdRTeJxdAdtk2crDwhg89LGq
         i6C2ACFt+Ae+UJ8+OJWO3naeQxCci5KOZ8OvfukjjLkVPnmt7zo/vpxTpATyc4bWAN60
         KqKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYmMJKqHdPu2xOK3PMpGOn4hb03BoR/pPLjUOg95CUZAcKN38q6qFvZQpNceSNbqO+CFO7yMIEeJ2vXn/1C1piLnRN5nYKRWnOfgn7
X-Gm-Message-State: AOJu0YxuQMLccyXS+s9cOMh38doa8kZah1M2jpNcBOsHiZ+r/bjlPMxD
	gPZduVjEwrfrAYD85NzGp8G5XphlpdCd3ekZpFOcJywJLHYmtFSazbUd2LB01oQ=
X-Google-Smtp-Source: AGHT+IHOmqMftI8wjJ5esGhg3yKLJXkjcJ17Z7maulQQ2gwkEzP+a0iVJeuDAaXkcdChgxLz64Bcow==
X-Received: by 2002:a05:600c:3b12:b0:426:66fb:fcd6 with SMTP id 5b1f17b1804b1-426706c64b5mr95085065e9.3.1720964376615;
        Sun, 14 Jul 2024 06:39:36 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:39:36 -0700 (PDT)
Message-ID: <dafd938f-cdee-4348-b091-fe3ed8209d53@tuxon.dev>
Date: Sun, 14 Jul 2024 16:39:35 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/27] power: reset: at91-reset: add reset support for
 sam9x7 SoC
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>, sre@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102843.196257-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102843.196257-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:28, Varshini Rajendran wrote:
> Add power reset support for SAM9X7 SoC.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/power/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index fece990af4a7..e3ebebc1f80d 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -26,7 +26,7 @@ config POWER_RESET_AT91_POWEROFF
>  config POWER_RESET_AT91_RESET
>  	tristate "Atmel AT91 reset driver"
>  	depends on ARCH_AT91
> -	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAMA5
> +	default SOC_AT91SAM9 || SOC_SAM9X60 || SOC_SAM9X7 || SOC_SAMA5
>  	help
>  	  This driver supports restart for Atmel AT91SAM9 and SAMA5
>  	  SoCs

