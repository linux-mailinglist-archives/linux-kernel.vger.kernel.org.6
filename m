Return-Path: <linux-kernel+bounces-243663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B9E9298F5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9BF283AC7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCD44D8A5;
	Sun,  7 Jul 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVFVowul"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2804AEF0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720371336; cv=none; b=OMecbuZMxCFIsXlpIg+lelIw/rBPpP3GATqR8WgfZbAbz9kjDYYhENeUGDtg2JBZIB2LP600JEw1XNzpwRMjQNWlstPQJ+f0wZ56mrqXURa4M8Av/lHbedlHaSHbF5llU6A54Pl60m1tHP0wTzfwdJueTO5LkroedcNPBhiew/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720371336; c=relaxed/simple;
	bh=CzbVOsWDdWpkYHY5sfVvV82wwbI1wiksNM9TRD668Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF+58GwpjcX5Kd0fXAPqJzt2X81PBeFKOeqxPx4TY58TsTC1s90kx+YjrQfKjeYCp8nIsEgh8BFz4+PivtOHYb2BKm6d4w0icUWAon5JqAkY3OSQV7ccOlPnF1aTvaaeuHn4F9p8s0p7tgQSkTBiFZRUdylw+v9KEi7qeF0m3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVFVowul; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720371333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yUgn9zeh8Lf45LE8ye9A2hP/w2XRLDsyivf0TMqWYOQ=;
	b=aVFVowul6w8vRbnj81xhLHaQnat04orqEshGQFyPlxDQr7oJZ/Lzhb7FTy1RwW8SGddcsB
	v6tGJjefyzJaTfAPyZ1TumgFO9DuWWCltVunILST+IW4S/+maHm2srOPuk2tzhTiys9xaa
	KXbDEo8p4Uv//7GJTCyI+d/UkKnPoc0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328--z89n6ndMHKpujmOkKmE_A-1; Sun, 07 Jul 2024 12:55:30 -0400
X-MC-Unique: -z89n6ndMHKpujmOkKmE_A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a77de2c6583so118666666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 09:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720371327; x=1720976127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUgn9zeh8Lf45LE8ye9A2hP/w2XRLDsyivf0TMqWYOQ=;
        b=eLrh8NhSbu+++Df9BuTLf/eDMqDUEFV9sy65DBwH60C529eoKX/1SmCBMIiNB1cURx
         n6bR0oIdbCZ7fAk+fBTbQrsBZJ6ryXxopOmCXtW3ReFGgT6hPVdjzV3njX6y33RiajUv
         fBjo6mkqpXTeMgl8E3FfD3bzkNEhW29PiJlTuIlLDvB+u+TB2QBEDd2sxXuoHODygUuN
         ec3tVjL1j7bMEJbugimoxKCaG5uT+YDJAAw5bqX3xLxPB6KaaD2SZpJkyhkohwS4lxG5
         mjr4oWRBRfj4jATwKoeG5mJtmccX8bWCkIcR4ccu91sBuqfRbpWkI9UfwssSSlOMJTZl
         QJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA/ujCiLT+3V6RGWrhP8WZr0JvPkgVXsATbJc2UYTwlCzv1DAqb9aI1L2L79Ogmx7ZHjQ5nPoacbXV+pSEChDx0oYCpfHmwGW25VpI
X-Gm-Message-State: AOJu0YxiPVkje96GABRSsfg8lQLLcer0Y0Y48OuavJiRo4dlgsObwtM9
	uwThnsb26sa6lzy+BcbSGnSpRKx6K2bgU7Zve3jbq5jsLbeuVyl0UcfczE/RaoyXX/lpc0gEN/o
	0HN8icLnTci/PFW5susIMYWzowdheaXmaznUtAfKUvXzVLBX/wx3x95ZHz0ONNQ==
X-Received: by 2002:a17:906:4556:b0:a72:6375:5fa7 with SMTP id a640c23a62f3a-a77ba72c53fmr602034466b.64.1720371326952;
        Sun, 07 Jul 2024 09:55:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFZghCTEp8O1D4E9CQS4aEDj/nt+bdk+H5qZ1uBdFM9K2g1BWsNpr3q2zu1OC5myUFW2bNng==
X-Received: by 2002:a17:906:4556:b0:a72:6375:5fa7 with SMTP id a640c23a62f3a-a77ba72c53fmr602033666b.64.1720371326491;
        Sun, 07 Jul 2024 09:55:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77df94aa5dsm165941066b.130.2024.07.07.09.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 09:55:25 -0700 (PDT)
Message-ID: <472cb530-b5d7-4ef2-a279-16fdbf07a014@redhat.com>
Date: Sun, 7 Jul 2024 18:55:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/60] i2c: cht-wc: reword according to newest
 specification
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-kernel@vger.kernel.org
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
 <20240706112116.24543-9-wsa+renesas@sang-engineering.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240706112116.24543-9-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/6/24 1:20 PM, Wolfram Sang wrote:
> Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
> specifications and replace "master/slave" with more appropriate terms.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/i2c/busses/i2c-cht-wc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 0209933b9a84..52e3000626c5 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Intel CHT Whiskey Cove PMIC I2C Master driver
> + * Intel CHT Whiskey Cove PMIC I2C controller driver
>   * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
>   *
>   * Based on various non upstream patches to support the CHT Whiskey Cove PMIC:
> @@ -106,7 +106,7 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static u32 cht_wc_i2c_adap_master_func(struct i2c_adapter *adap)
> +static u32 cht_wc_i2c_adap_func(struct i2c_adapter *adap)
>  {
>  	/* This i2c adapter only supports SMBUS byte transfers */
>  	return I2C_FUNC_SMBUS_BYTE_DATA;
> @@ -168,7 +168,7 @@ static int cht_wc_i2c_adap_smbus_xfer(struct i2c_adapter *_adap, u16 addr,
>  }
>  
>  static const struct i2c_algorithm cht_wc_i2c_adap_algo = {
> -	.functionality = cht_wc_i2c_adap_master_func,
> +	.functionality = cht_wc_i2c_adap_func,
>  	.smbus_xfer = cht_wc_i2c_adap_smbus_xfer,
>  };
>  
> @@ -554,6 +554,6 @@ static struct platform_driver cht_wc_i2c_adap_driver = {
>  };
>  module_platform_driver(cht_wc_i2c_adap_driver);
>  
> -MODULE_DESCRIPTION("Intel CHT Whiskey Cove PMIC I2C Master driver");
> +MODULE_DESCRIPTION("Intel CHT Whiskey Cove PMIC I2C controller driver");
>  MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
>  MODULE_LICENSE("GPL");


