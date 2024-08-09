Return-Path: <linux-kernel+bounces-280363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF44D94C990
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4E42867BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7536E16C42C;
	Fri,  9 Aug 2024 05:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYGHd5ER"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F7166318
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 05:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723180750; cv=none; b=CKCos5zBrQRettdxt5X2PHkoiVLNHPRdV/ALjZiOBjYWn4bdZaTWbToViBeT9a9rlYDBDOsG4SXmVPmW7afdZQjuwPvg7fYv52XCfSLoqeZ/NOAfal0bsVtFK3p2Ab2Fu7x59xVasGaNQD/yZ8qLM3fs5HPBt7vNtOJPURvqSss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723180750; c=relaxed/simple;
	bh=sdCvMXF9TFM4HuOz+VdMAKWSHVj7OkVSVAFc7PaBdUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7ZQPtdRd+gcSFsqLKcJLgNjKDTNOCZBJ0LhQ5l2njjnyRtflJclZb7/VpfzmUeYISOUqFSR9rUYMjk6FEW+hmqEXxZZD1fphIpCwIJ0m6oXZF7PtESG9T1imMMt084IuOvMHZRpC6uO10zuY4QwW8hy+PKjdo8Uyub7GSK30Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYGHd5ER; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efdf02d13so3113837e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 22:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723180747; x=1723785547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C/At96fwm/0vuo5rxb7LENebY76zwf8pGxV6uNLWAXU=;
        b=eYGHd5EREl8qJnT6NEoZGmbmXxNdTDObk4uxWXPjeUddxteFfkxpCpYiDxszQW4P7h
         1Ia4EShGEb+36L7vLqJMW5motSDkX6HfjCthny4aWb61Z6LFCwTKsBE8Jvi1aFtGq24O
         rqX6A58KlLcWV7pFAfodEEKNcOzDScGg7TxDckcbo/kL3VPKTVczhWshoE2UaIgki+pS
         UHtpJaKroFE3rkFYB51pdF20v+o6fwEM4WHRtKCZ/Pe9c7IiZRNyf8GuDOqyMmH4xLNV
         2pCq7VQxLukGOMNrS23h2ubCQ/zY+oFyh+vgITgO7pD2d7imTPnBi1PSC8NinvQlJ8un
         6nXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723180747; x=1723785547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C/At96fwm/0vuo5rxb7LENebY76zwf8pGxV6uNLWAXU=;
        b=gB0bpMwl2NOQlFGADnNEOIWJS/t5cc86RxBLYppJvHdJC/mNQwwljrnlanoF1Rmwpi
         F1no8O1dunUw+uW2wONZ8mxVAHodTPUuQf+BARfmAV/l8IA+lAmT7ek5ZG+pbnlwkL4k
         VKl96u3TZtLxKadH0+Zcp7f3OKAWy94RQU2YpNKQWe2jmAPklNL46N38Bzv0vnZXFPlo
         YQMIUf88fdqVrTEfC3gAaivNO6m+R8LNLrM5mDMmhq8RJz6v+LQMEQFOI7hb2Dlvge4q
         Exn0ZIQRs7hr59tldJA9lvjG680kox5o8IkSI6thlSQUFRokykPEQOUy/1It2CxI+ksH
         oQdw==
X-Forwarded-Encrypted: i=1; AJvYcCXzN6Enaltk6WRUm/lvVSGb2r3o9z6YFLLwuBgfXxz/9BMKkpGsmmKYUfGmrVsSVx9EjjzgRDnYRN+OoB0xkzqXkESfEw02aC6a+LWD
X-Gm-Message-State: AOJu0YxwqNVywv+WS0n3dEV+CAUOBMkln18QaCwkfaW4Z7Nmu72+slj/
	C+2vZpG5sHkKTVM6/3sqULqNPbjfo7M9rFYt5/YDRYLCrCwSyCl7
X-Google-Smtp-Source: AGHT+IFr4tRhAN+m1UK5bde7o8Nw8VfIksmu8ZC92MIOyBYmlFib22BBcLffkYIjw2LOurGpL6ct8w==
X-Received: by 2002:a05:6512:3d90:b0:52c:d628:c77c with SMTP id 2adb3069b0e04-530ee9f4360mr349892e87.43.1723180746218;
        Thu, 08 Aug 2024 22:19:06 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd? ([2a10:a5c0:800d:dd00:8cfe:d6e7:6701:9dfd])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530de47c584sm858002e87.266.2024.08.08.22.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 22:19:05 -0700 (PDT)
Message-ID: <1e3b0045-049d-4a09-b645-40ff82e0a43b@gmail.com>
Date: Fri, 9 Aug 2024 08:19:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqdomain: Cleanup domain name allocation
To: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1723120028.git.mazziesaccount@gmail.com>
 <7a048c0139e79beb46d887b0cd5a620963ff8ef8.1723120028.git.mazziesaccount@gmail.com>
 <877ccqvkfm.ffs@tglx> <874j7uvkbm.ffs@tglx>
Content-Language: en-US, en-GB
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <874j7uvkbm.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 23:19, Thomas Gleixner wrote:
> irq_domain_set_name() is truly unreadable gunk. Clean it up before adding
> more.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   kernel/irq/irqdomain.c |  104 +++++++++++++++++++++++++------------------------
>   1 file changed, 55 insertions(+), 49 deletions(-)

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


