Return-Path: <linux-kernel+bounces-198928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376838D7F41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C8E1C2261D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E491184D0B;
	Mon,  3 Jun 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLKb/FZg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F642ABE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407848; cv=none; b=grflrkv9XAATYE1DXMvXrTwfohOlvXfgy901GvPhxLIr85Gyls5PJgET+1DVxGffkXVxMVjSDj7Ekix2UTG+s4/z2rAmivvZFLzCfsCTvTZY+Vb9n3jch6X/nTKopM55huZ8WLFcloVfs+5sZypuBkv9L/6qgOOazaUA8Fduq9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407848; c=relaxed/simple;
	bh=nM8uSllZ7RbY1J691S8kJGCcalGOytS3CRH3nRriecg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEcbDDdm3rGiRuFc9lgTUJGDqzA2D8TTACxsFakL1K/vpO99vMY1Y+nvde4jI+EV2CkbsgvBfSVN2fYAzcv8b85hNBbaaNlFa2XGYSgvNR468trt+hj6AxEEQeJhOL1uteGAFyNi23aZZKF1q5CJzBnOxOAee6cuWP6bgvfLTpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YLKb/FZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717407845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNeEzqEwDLFqI3mQx5TerVCCfIrf8PlxwIfB2OPQ4fg=;
	b=YLKb/FZgBuLe7k0JNOs4QpjOTAxixUuSvGe5vdyEqZTecaOalJxDDWUq/apW3XPIeUz+Tu
	WI/HaziGY4ojBxaL83oyq5E6zRerg+eaOYpEPZnMxd1jO5cGrEwh5ArXtPFc6X1L/AfT0y
	xpGOq1/GzLrMbZi2osIjRb4YjfCAYe0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-KGKsBgvZOgiAdEwT9p4teA-1; Mon, 03 Jun 2024 05:44:04 -0400
X-MC-Unique: KGKsBgvZOgiAdEwT9p4teA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6861bb1c0bso149719866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407843; x=1718012643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNeEzqEwDLFqI3mQx5TerVCCfIrf8PlxwIfB2OPQ4fg=;
        b=WkQE9BRIwNdQD7TamxdYlbB1sjDUSOE7mM5TG70LXdPbcEDvqx44RatxKN4bB5G+qo
         +BL/xJlXfzAUmuPaup0Nlyx0Uwcw5M6OjDV542BBHZIpN8rdS9IZTOPQR4vVvzs0xDSn
         CSrQBrKOD3EQ0NqYxulhAEeUI8sHFfnJMZoDqaPwmpq1pw1wV1CCfnDJDUd+D9CNCuGT
         /bSZHSJAg6ONJYL7l0rSHwnljes9QDLxkkjbo0lDwtcsDq/RjHSI0C6PMI572ovDeY6E
         rvq/+ujiXZvQKkINQYejYKgoPOXCxKGjjhCW2gVE2w2AxlLUP52M1BDdSdKXQcb9waPn
         J5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVh0hYV4gjzAOPgvXZDKnAaL0m8+NRFa8IabMT5YaHnohGmz+1ipA1+B+wMd9vEwELnsTbd6JkrYeGNMYILWVxRW6dGQMGNcdgSC+x8
X-Gm-Message-State: AOJu0Yw5V66/PV+kgx8f8cvh+Cwh3UHClot9vMmitkUuTCJ2B9Sqvubq
	4HpoLqmuzIL7unPWhchXUAtn3+x39EPDtetMshzYa5FGMkVJ56mutUxnTp68VTwRcEvmjn0s3Il
	FM+inQBHZjHPWFJd3N0hlMYxr7olwY1VMxbZjVsUlEhjR5pdUUJGHPSkf/YzUrA==
X-Received: by 2002:a17:906:1b5b:b0:a68:c672:9ea9 with SMTP id a640c23a62f3a-a68c672a238mr327571166b.28.1717407842985;
        Mon, 03 Jun 2024 02:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL2jVRaMVe/2bPmtGU7yX8A5bJtJXVMPpIgslWnfKfooeBA8Go5dQoxUgh1LEK+9vpH589DQ==
X-Received: by 2002:a17:906:1b5b:b0:a68:c672:9ea9 with SMTP id a640c23a62f3a-a68c672a238mr327570166b.28.1717407842605;
        Mon, 03 Jun 2024 02:44:02 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68cf23c63esm265077366b.5.2024.06.03.02.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:44:02 -0700 (PDT)
Message-ID: <577cc35e-00c6-4893-b917-d3f44bf19191@redhat.com>
Date: Mon, 3 Jun 2024 11:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: yt2-1380: add CONFIG_EXTCON dependency
To: Arnd Bergmann <arnd@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Armin Wolf <W_Armin@gmx.de>,
 SungHwan Jung <onenowy@gmail.com>,
 Henning Schild <henning.schild@siemens.com>, Ai Chao <aichao@kylinos.cn>,
 Robert Joslyn <robert.joslyn@redrectangle.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240528115940.3169455-1-arnd@kernel.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240528115940.3169455-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/28/24 1:59 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver uses the extcon subsystem and fails to build
> when it cannot call into that subsystem:
> 
> x86_64-linux-ld: vmlinux.o: in function `yt2_1380_fc_worker':
> lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9d819): undefined reference to `extcon_get_state'
> x86_64-linux-ld: lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9d853): undefined reference to `extcon_get_state'
> x86_64-linux-ld: vmlinux.o: in function `yt2_1380_fc_serdev_probe':
> lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9da22): undefined reference to `extcon_get_extcon_dev'
> x86_64-linux-ld: lenovo-yoga-tab2-pro-1380-fastcharger.c:(.text+0xa9dc0c): undefined reference to `devm_extcon_register_notifier_all'
> 
> Add a Kconfig dependency to make it it always builds correctly.
> 
> Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcharger driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 809888e4c1e7..9f850e4617bf 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -136,6 +136,7 @@ config YOGABOOK
>  config YT2_1380
>  	tristate "Lenovo Yoga Tablet 2 1380 fast charge driver"
>  	depends on SERIAL_DEV_BUS
> +	depends on EXTCON
>  	depends on ACPI
>  	help
>  	  Say Y here to enable support for the custom fast charging protocol


