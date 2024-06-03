Return-Path: <linux-kernel+bounces-198853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5D78D7E55
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8888D281318
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9F7F47B;
	Mon,  3 Jun 2024 09:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ha02Sbz8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805C5FDA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406203; cv=none; b=GYQLS165jbKNgmWlkh4M53gA5YGkoY7qnQv7RlPD3AE8/oLxnaICnbsGTq7hoc1ztiEooBdt34NEzwz1S/4TizUVtREXBrdGtOliGSV2ojeIJT7uFLXdghZorfYCW0cDpYUUowfmMl696/0s4j7DAcucRS1mQz8rYwLR7wTpluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406203; c=relaxed/simple;
	bh=ImHt7Zo3bC3AcAH6+P9BA7vqDiszxaZntToY+2lkWmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe9sVjRtQxqvGe8dgn0Nooc2qqgbgQInBTTR0Zhf2lH4I361+FBq6EEjOkb+oDuqMRrQmIM8GjDmhyfxewj8+Fyg5uTk1oJtnwZyrNgg3tiNKniQsFnvbVGM453SuRhaSL4AKMUAf91dcJIg8BDYsiLntxGvrIF5ZjQcHGNT9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ha02Sbz8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717406200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ER449LmaSckkw0lE9Rnq7WLr5seCu4LCDcpsoMn1VAg=;
	b=ha02Sbz8D9KBAremrNqChFdMk11lZVoYY4uwFhc/6WZ6+YFiK+llKtuC/0XrVIkU36V9Zl
	Ael1dpH0OUCGdOHNkXBguIR813htmmhQ7zZFodoKLhJwmdrr/rhlkE1kxq1voUsOcVSfJD
	fjaRJJLXUEawLeGyq+kJ7V5knKYH2h8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-9nYSV_c_P02eZer28fdVrQ-1; Mon, 03 Jun 2024 05:16:37 -0400
X-MC-Unique: 9nYSV_c_P02eZer28fdVrQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a68e0faf1f6so57759266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 02:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717406196; x=1718010996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ER449LmaSckkw0lE9Rnq7WLr5seCu4LCDcpsoMn1VAg=;
        b=I6RZkm6UiTT2qnL0U5yqxx9Xg8Fv4XQlhZE/wlL5VlYdTuP42DoqgaxKra1ptouRkY
         9IlI1tlmVeyovrg/cUUvOIgmnqpYHVf98BNNEb6cJb+8CdmWuWy0s7pbSHiCBULoCyN/
         eLQomgu5TwRX9q1RfbUKGWcPIMnOmIvWI83f+PrDtRyqQTwqqPEtWJr2/TZeuAa+7pQx
         9g80MGzDi+uTXIa3kWMwd+4tTL1EWatwbwOWMhhMyosaf1Dhkv+fsBkd4KskNKAeqavH
         gRu/uMj0GJrSfkvpSk40jwgi2eoUf+rnYatPlexPvMKgpk6WwA8b82TYKVLmULKYHXa6
         cD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAL8Wx7Zp6YLIovCNRMlVu1yB7W0wqExzCKUgoAx7pw8D5T3hG4uBITcDuZdP3cSoEDEq2cPv85U1JKQH92lsjSfoQ97kKHE6RKSJC
X-Gm-Message-State: AOJu0YwVK/C6bnoKmEWZamOB4BH8nbI1DJA42YmgHShypf95FxBpQqsC
	ArdcPL/gQpIfLMrCknxwE/O/F1LvTTx3QbcwZ+rZF7xCLBJt/E9bX0xyxSv0a0KGU7N4moSRHKS
	JEotDS3ynC9hAeX+1+EQWkclabUIOZUIoIcAUwceCmv+on8wOdTWs3XQz9B0LMg==
X-Received: by 2002:a17:907:3fa6:b0:a69:180e:9dde with SMTP id a640c23a62f3a-a69180e9e03mr102605066b.26.1717406196040;
        Mon, 03 Jun 2024 02:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7yp9unRJH++xLy+GgIWNG4UQ4k52l26EQdjCKCjPLXFaFHYNHG+T5/e4WkozKTS/UOAX1Wg==
X-Received: by 2002:a17:907:3fa6:b0:a69:180e:9dde with SMTP id a640c23a62f3a-a69180e9e03mr102603466b.26.1717406195678;
        Mon, 03 Jun 2024 02:16:35 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68fbf068fesm186916366b.26.2024.06.03.02.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 02:16:35 -0700 (PDT)
Message-ID: <6629757d-fa07-450f-9de8-bcda54d42067@redhat.com>
Date: Mon, 3 Jun 2024 11:16:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/7] platform/x86: touchscreen_dmi: Use 2-argument
 strscpy()
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Jorge Lopez <jorge.lopez2@hp.com>, Li Zetao <lizetao1@huawei.com>,
 Simon Trimmer <simont@opensource.cirrus.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-input@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Mark Pearson <markpearson@lenovo.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>
References: <20240602090244.1666360-1-andy.shevchenko@gmail.com>
 <20240602090244.1666360-8-andy.shevchenko@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240602090244.1666360-8-andy.shevchenko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/2/24 10:58 AM, Andy Shevchenko wrote:
> Use 2-argument strscpy(), which is not only shorter but also provides
> an additional check that destination buffer is an array.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Since the code being modified only exists on the fixes branch I've merged
this as a fix now.

I know this is more of a cleanup then a pure fix, but since the DMI quirks
always get updated through the fixes branch this avoids conflicts.

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Regards,

Hans



> ---
>  drivers/platform/x86/touchscreen_dmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 2d9ca2292ea1..879a63e4ecd0 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -1907,7 +1907,7 @@ static int __init ts_parse_props(char *str)
>  	u32 u32val;
>  	int i, ret;
>  
> -	strscpy(orig_str, str, sizeof(orig_str));
> +	strscpy(orig_str, str);
>  
>  	/*
>  	 * str is part of the static_command_line from init/main.c and poking


