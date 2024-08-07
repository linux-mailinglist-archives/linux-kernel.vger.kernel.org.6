Return-Path: <linux-kernel+bounces-277648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B894A441
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7341F281C3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3521CCB46;
	Wed,  7 Aug 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="kBGr66Ba"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74F6D1B4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022673; cv=none; b=hdBUE/bZvQBeAvwooz10gJucREfQ9aQ3WbOOZEnU7cd3Leic2j9HTu/cJ4gwTvfMU0R9M+0+UcjcZ2ZkKNKcCVvZl64chTFErHG6fLCK6YmvZkIkx2h9NGT8FkKyZWgoFn/CVqlyj0ulHGgHp91lcqQV6LUoeWBMfLsPp7FCeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022673; c=relaxed/simple;
	bh=bmNNDqeFo0fMTzvHS6jtF7fSAgNTqZ7flns0YOd3/ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+SiYdC3evu/NmQtGJacCiYg4Rxg3RjfOV+9reapJmeCvsovA7ztD+kG6nqEzIn8viwuj3rznf/vfYoMUjXvXzqPbHnmLXgd2/H5cwWpr9wD3tdal05lLw5YNTl5VEOCkdgIFTNg8ms08iGaWEpYDT9+3siXenBlfAsdViHg6a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=kBGr66Ba; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc4fcbb131so13450605ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723022671; x=1723627471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8FROlorW16Zop1LbDsLiZBpuBm4Au9Y6KtWsJXN+Z00=;
        b=kBGr66BaHmu3K/Sa2YLBtoBtxdD6UWGHDV5GbWqRLH41hOeFA1zfUO2hjvqkLJSQ7B
         6sI8eybw/AYes+9pU267Su66gZ8maFTo3hOPuweVHFRAkIkY+cjvJ+yss4w7KkK3PlbE
         FE0SP9ibMXzItu/TvlldAKOWYQclZargcedLZDuVtgqxvMjoZY/HuOxlOTQ/M0NdI7SD
         Lv485wpBQauhq97j5kxIBLH4FxRnjGdBc/JYazItA2f1nAKTEGozGP8aFEQxsmUksYZN
         Vj3P/A45prUj63o3XS2nzxlakWhKa2Ir38OSksJ2odIPqPlk0mK6kUSdAe0T+HRaD+51
         M2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022671; x=1723627471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FROlorW16Zop1LbDsLiZBpuBm4Au9Y6KtWsJXN+Z00=;
        b=dBtjq2/MTiLoz1T+KsBB4tDPUCiFsI7tEG7M3iIMuIyH4+lkH5BK6Z0MRKFp6nk4Cp
         2xHYNUk22C45VyNYv+4lUNGo1/6wqefFyRXdjtNWCSQCF/J+gLB5/s/P/F3IMLSGTV7G
         GW2IniSEhhKpaOL+w+1rzHN0tFpYFlYuR8YvgQqSeiOPEUIGrGc4zuY1E8txdv5Tdvky
         MGupUxVbvrHVB/i+fjWbuSGJPdpRuVX5l3aNxM2aEOs0/4MOmmxzmE0c4PnNWjmUBcsX
         Qi1jpcY0KaXuTufoI9jLqkzH1IfnHwAbn5neNa+6FjuSms+5sG6WukQr9NG0aGD2nq+c
         qR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUk1pNlhlC2DxqxIwG0XVm33hnHtLeoEyrS3LT60NYKL8IfxwpTQS3NukghDt9u2ky0dbYAJVSvyn//FniQcPGiLQpi/7tNneO6Kiw
X-Gm-Message-State: AOJu0Yzh0WIg6dd7VU4x1G1sf6BegyPpvhwIDH3EZ0RP/BcxcTy6+Qna
	q6AwRKVTlCyBffvmhcptzhhccYWgPxrhXnMndRKvpplLfMy0DEaRkx9JSKV75p0xoC8ENfhJkOj
	crks0lg==
X-Google-Smtp-Source: AGHT+IG9Ngcy5IvNGg0A8Puz7JeQ55YvdVlMQJe76hw9S2YP6DI0q5U9+upeIiWRzv8d4EAl7xlNtQ==
X-Received: by 2002:a17:902:ce8c:b0:1fd:a0e9:910 with SMTP id d9443c01a7336-1ff574a6ff9mr213460025ad.62.1723022671052;
        Wed, 07 Aug 2024 02:24:31 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2007d1184d9sm22821265ad.216.2024.08.07.02.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:24:30 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:54:25 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250_platform: remove ACPI_PTR() annotation
Message-ID: <ZrM9SRgRLYXIL8B1@sunil-laptop>
References: <20240807075751.2206508-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807075751.2206508-1-arnd@kernel.org>

On Wed, Aug 07, 2024 at 09:57:43AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The acpi_platform_serial_table[] array is defined globally without
> an #ifdef check for CONFIG_ACPI, so ACPI_PTR() makes no sense
> here:
> 
> drivers/tty/serial/8250/8250_platform.c:271:36: error: 'acpi_platform_serial_table' defined but not used [-Werror=unused-const-variable=]
>   271 | static const struct acpi_device_id acpi_platform_serial_table[] = {
> 
> Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index 306b488aa996..c9ef988d58b3 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -281,7 +281,7 @@ static struct platform_driver serial8250_isa_driver = {
>  	.resume		= serial8250_resume,
>  	.driver		= {
>  		.name	= "serial8250",
> -		.acpi_match_table = ACPI_PTR(acpi_platform_serial_table),
> +		.acpi_match_table = acpi_platform_serial_table,

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Thanks!
Sunil

