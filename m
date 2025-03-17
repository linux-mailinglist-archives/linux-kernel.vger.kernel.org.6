Return-Path: <linux-kernel+bounces-564160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D9A64EFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF97188DAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B023A566;
	Mon, 17 Mar 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="pIZGW+XJ"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D3C238D32
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214912; cv=none; b=GUQTjfFx0qOslhl2nCkCCzoDVuPl5vxUoH8Do3PxC5yB/H+bQIIQhk0poB3cw6DAV3DllZg17sMn6XolNyJ7dHL7FKeL7enc5f/8QRr/aY6e4ZhN0eV/9E5s4nO21xB8+gsmZzvKF72DSscC7ktH+ZKKAPCZfhzOTqoQ+Wpcveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214912; c=relaxed/simple;
	bh=2hhxamJKnEYjgJz9HCPDDBlgMOFyLWxFx7AWrATtYGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfVc54hy54F893zwrS2OrerWAd2/q69s1je6FCOqIAP+zGo1jg/Wbvp8gLTtUc0maouf9pywPMYKNIk7J/1ygO7WEFPI9d0QXsq/k/ozRNrOcWei3SdLA4hpgvWFPaU5cpMDtMR4E0s9DG4XXkdCWu6KBGBNuASCXTISpNygXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=pIZGW+XJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b515e4521so135331339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742214910; x=1742819710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00q0lF62iZBDilWeDRlriXLySeQsOfJjRaqFJoh5fG8=;
        b=pIZGW+XJ4VqSFbjZZGvFywgqNL4kFFLYFcRiVic2bcsVQ9hL9veUgvadJQa8sAJcJ/
         f1JM69T/LRwhYG2IXBjfLB4vZeFPOA0vldvKt7JZZeQ3nyyIokso0B6yoEo5YXULxmyd
         c0K1lLXrNXDg7zRtibLpcJRGfmD7svm2CYHKxvKfNyp6DYsF2a44dbK35MycfMDds2yv
         Iou9GM7zdXOtE9YN04atY1BUoMuu8ukuGPLy1QcIn3zVFlnAPMDOdtp/0dtke8GGOix8
         9R70Qpmr6/RCo1nLOIK0u3NdKhdNWs8fr8aEQnHVLDyOL8uYxkTG9/vZEqnhSspfv9/b
         8azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742214910; x=1742819710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00q0lF62iZBDilWeDRlriXLySeQsOfJjRaqFJoh5fG8=;
        b=C2fAoA3wIDohFCj8BXLlsY5sN8RH5keigndZ4LUi1Qx3w9RlhHheUXhm1gL+sCtrg8
         4YrK7ZMg3IWY49wP8M3OGhjiAo5dXx/YnwOrDx99RNvRMAphpPXd/zvvkOu8VNuw/J67
         hfh7PDk7fxfSIhgEXXr1eMEKlqFnGgIMFIcPG31xkddg5mZ7TNXh+xCp4yE0i4Zm8tZo
         rMkHvlXGS5Kf9AwPd1zF2lML/pKL75FaRzfJICQCQnZ3Pkik+DCRldYeWp9tLYMxZAwM
         L1vaDd9ySOW35CmZLVcv+dyIMzALQbE38Rv7E/LgWrQC6WKVU/KVeloa0+P3AoD8TsZp
         RlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOntqWdAXrO+wdTgs4MVPtrMfw/i0Zuo7j8UZPHp5fNQ7wh39gStz2hQ/s7rIcYIICh7RrjelEDhDO3II=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcqr4ue4pFtxvby12Tf1IpM2lzO915SpcPrs4CfOTCmJbkjXhP
	iHe5jiDxHsh4n6/1NPBzxsvALWZRMaubnyVu0a3lk8s+ls1nkQB/6CQldC1HUoE=
X-Gm-Gg: ASbGncs6Bs918hpMdCCOHsexzmhgJc7io0KH9ebaH+WbLRVumBLLcrKnKGNRm1aX5s3
	ntzgzFSKHSh2GLHhb7+3IyzZEok6k0bOcKBMM2XzsQzHxd1VSoxmbJrKOLftTVmtcMRCswbMZZS
	0GvRuYbZ8lWdYiVuRZG0cusb6SMMp9RPk5Je29Q33gJR2Q/CEshnoZf382ISYLjO3nC04cdnE9m
	RuACnmu202O6DgWiems/S7i9BlzA3sjNE9FOpzDW+6OikH5ebTKwR/w35S+mWxqqssuAteBP5Q1
	ahAffGdmchN5j+SqUYsHr3Jl5nfZ6CKXyvFI/46AeQFaUC3/TEuyL3LGAo/6ed1ladC7nfq+6xD
	O/erTxL/E
X-Google-Smtp-Source: AGHT+IHVpD7/mZoav16FzU6IphNyJrgQsnIiWZ2iM1qY0DQdugl/0lXuxuk7bx2DwfBAOuvC4HPD+Q==
X-Received: by 2002:a05:6e02:1a26:b0:3d3:f64a:38b9 with SMTP id e9e14a558f8ab-3d483a63552mr114188275ab.15.1742214909989;
        Mon, 17 Mar 2025 05:35:09 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a83817dsm26967285ab.61.2025.03.17.05.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 05:35:09 -0700 (PDT)
Message-ID: <abdaa38e-77e4-435e-94c4-91bc24b49b02@riscstar.com>
Date: Mon, 17 Mar 2025 07:35:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/31] tty: staging/greybus: pass tty_driver flags to
 tty_alloc_driver()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan@kernel.org>, David Lin <dtwlin@gmail.com>,
 Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
 linux-staging@lists.linux.dev
References: <20250317070046.24386-1-jirislaby@kernel.org>
 <20250317070046.24386-23-jirislaby@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250317070046.24386-23-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 2:00 AM, Jiri Slaby (SUSE) wrote:
> tty_alloc_driver() is supposed to receive tty driver flags.

Looks like tty_alloc_driver() doesn't directly depend on the
two flags passed in this case, but this corrects the code.

Looks good to me.

Reviewed-by: Alex Elder <elder@riscstar.com>

> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Acked-by: Johan Hovold <johan@kernel.org>
> Cc: David Lin <dtwlin@gmail.com>
> Cc: Alex Elder <elder@kernel.org>
> Cc: greybus-dev@lists.linaro.org
> Cc: linux-staging@lists.linux.dev
> ---
>   drivers/staging/greybus/uart.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index 8eab94cb06fa..308ed1ca9947 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -948,7 +948,8 @@ static int gb_tty_init(void)
>   {
>   	int retval = 0;
>   
> -	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, 0);
> +	gb_tty_driver = tty_alloc_driver(GB_NUM_MINORS, TTY_DRIVER_REAL_RAW |
> +					 TTY_DRIVER_DYNAMIC_DEV);
>   	if (IS_ERR(gb_tty_driver)) {
>   		pr_err("Can not allocate tty driver\n");
>   		retval = -ENOMEM;
> @@ -961,7 +962,6 @@ static int gb_tty_init(void)
>   	gb_tty_driver->minor_start = 0;
>   	gb_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
>   	gb_tty_driver->subtype = SERIAL_TYPE_NORMAL;
> -	gb_tty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV;
>   	gb_tty_driver->init_termios = tty_std_termios;
>   	gb_tty_driver->init_termios.c_cflag = B9600 | CS8 |
>   		CREAD | HUPCL | CLOCAL;


