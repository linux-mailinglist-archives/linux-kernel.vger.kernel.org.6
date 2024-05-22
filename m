Return-Path: <linux-kernel+bounces-186279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7710F8CC21F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196FE1F237ED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3D140381;
	Wed, 22 May 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaTV1i6l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29F8140361
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716384553; cv=none; b=Hlvp8h6Sf80KgQOgCI5/8nO5JaaIj2Bj7tVRQVePM5v1zFobCJh+tN+jOXYsYx49YoqH3hQWtBCt3UKXop0kev5FJwYVXeJs4+P9MkG69c/oddDXWkzLzq2uriGXrw6hkIdEZ/CqE1xYP38qbINYoGg3D9tZHqDcUu6CvyAR/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716384553; c=relaxed/simple;
	bh=5sakKOKAmbCrsEjASnjL7UgkTgHABzWbOCfbUd+pBkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtic/scMkklaqG82paIwbP2thafPJ0HlIdsQn/7QoJLztM3U8dqMhZkj1L/tZkLaKws05dQVJG5l+rz5w/HWmt1/9ePegxDCe2rssqgd7dVgn18nPrQ74/aeKzsxaEf1wVp2SoFx0ZbDRBD8uJGo4fuTwTyQW7B9e3OG3M5al1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CaTV1i6l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716384551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vlxAhypZGuJ51fiH3I4BvsR7+m69A2J2YkZeHnupay4=;
	b=CaTV1i6lg20U8LNIZN02wd987zwpUnlxWA2Sxnhu7HJt2XZEnb4HZ1tfLv7b9Hv+gQl+d8
	327dvmm+J7s0zf36IxVVsQ4TOVIhiRlMY9DW8W5ovKBQRJSuBl4IFAl30eGOJanfgBGa9a
	yg5LSIaiTGxC2+yr42r6rMlbOHNkUJI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-YtWxIqaRPya--jjGhOWrJA-1; Wed, 22 May 2024 09:29:08 -0400
X-MC-Unique: YtWxIqaRPya--jjGhOWrJA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a5a1b50d45cso60269366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716384547; x=1716989347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlxAhypZGuJ51fiH3I4BvsR7+m69A2J2YkZeHnupay4=;
        b=e+9i35e5QTmqEGhwo1iwcJXU32OD9Qvr7XlgwyU9h4hOxktLxKv8czhNs1yITYfLV+
         TPSqtM5f1qbRhlh6Gor+nqUpDubd39Z/dTx5D2Qt2sed3YJ/jTNydU4lqicvp9LCNeOf
         YA9Kf0rM2O42YDWm8ZQKAPbE7e0Wn95mRc6ykozB05pI7Bx6WD8XZIkTbyu+JAdPoeDa
         6nycD8dY9NxJwXgYRp2beL620i+ruEGYoK9K5qIOfG3/N6ngKVsl4dqBhaBNYzGw5N/9
         DqIpn4NLUaEJRj8lmH0bxo8RoPklU34Zivbi177C6tdUURLJ8aTR0fCVYylgDsp1RSEB
         6Dtg==
X-Forwarded-Encrypted: i=1; AJvYcCVhpoC82NiKu5d+r8fLqjHMMjsdSZW161zRJ3oQFo6hTjgeZg4VGeIa0zIEt3CsiORAkoD+owgmWlDE/PBQlG5T5n41NISBmenSrpv5
X-Gm-Message-State: AOJu0YwNx780MGpOqTehcL5Zc/PnbsRYUKelF8FM8ntFuUmyWEdBVNAa
	khPIqxCKJlHwsVBG4vkgU+I8Rul1orro8CadXd0dsYihaOFWPwCaZyydwLAy6fwEc+Wben1K5a3
	I1AB3K/8+N3cCFkrsnZvNnYQaLQfAguEfgo9Go2MxW3YCLiaKsoVZaMvrY04HZUR5Akx02g==
X-Received: by 2002:a17:906:d0db:b0:a59:b4e8:d925 with SMTP id a640c23a62f3a-a62280964f9mr126366666b.34.1716384547168;
        Wed, 22 May 2024 06:29:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtb1pBEHqfSS0/fLHCW2NnVfu+WU48owlxpl2PgihyF4jDO2x1GADbGyTyJtG37fRQ3GEQYA==
X-Received: by 2002:a17:906:d0db:b0:a59:b4e8:d925 with SMTP id a640c23a62f3a-a62280964f9mr126364966b.34.1716384546632;
        Wed, 22 May 2024 06:29:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17894d57sm1789138166b.73.2024.05.22.06.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 06:29:06 -0700 (PDT)
Message-ID: <bdfc7022-f8a0-4d07-b301-5d00ecb86ea6@redhat.com>
Date: Wed, 22 May 2024 15:29:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Select INPUT_SPARSEKMAP in
 Kconfig
To: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <20240522074813.379b9fc2@gandalf.local.home>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240522074813.379b9fc2@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 5/22/24 1:48 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Now that drivers/platform/x86/thinkpad_acpi.c uses
> sparse_keymap_report_event(), it must select INPUT_SPARSEKMAP in its
> Kconfig option otherwise the build fails with:
> 
>   ld: vmlinux.o: in function `tpacpi_input_send_key':
>   thinkpad_acpi.c:(.text+0xd4d27f): undefined reference to `sparse_keymap_report_event'
>   ld: vmlinux.o: in function `hotkey_init':
>   thinkpad_acpi.c:(.init.text+0x66cb6): undefined reference to `sparse_keymap_setup'
> 
> Fixes: 42f7b965de9d ("platform/x86: thinkpad_acpi: Switch to using sparse-keymap helpers")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I'll include this in the next pdx86 fixes pull-request for Linus.

Regards,

Hans

> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0ec952b5d03e..1953317541ea 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -515,6 +515,7 @@ config THINKPAD_ACPI
>  	select NVRAM
>  	select NEW_LEDS
>  	select LEDS_CLASS
> +	select INPUT_SPARSEKMAP
>  	help
>  	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
>  	  support for Fn-Fx key combinations, Bluetooth control, video


