Return-Path: <linux-kernel+bounces-315593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C396C49A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FD11C24C22
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B01E0B8E;
	Wed,  4 Sep 2024 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBkOilQe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9644240C03
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469195; cv=none; b=X9/dA2jNhVLHLiQAF4UZFeeU6uRoytV8EbAz4RZi1FGtx7Tf9y+WEei17L08kOpP04qGscN7EKrB9Z801Izu+Qi6P5eBu8QcYuYK1rGUwCahaVWodvt6lSQxG1UU0jxr7Or5r/+9sXJTBgB/mdBGjguwf3GccnvUy6fm8h3RcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469195; c=relaxed/simple;
	bh=FdKFRjKxfqgZ4ZAePiUERmZ19meUV5QJp1p3+aRRUo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY0LrxPcsekvbC4VVrFmRKBS0ElENa8UTgX9/JlJm9O+uibdvApXyFcQv1AD+AyYg0meraTzqwuT5p766/PaMR4xRoHvQPAzPRMwFhR1BgjlP61QaElF5GpIm6b80I0M34nsXHGs0mtt8fj9ybiq5xG8CRgfeLq5JwtFy0UEybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBkOilQe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725469192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JS7JkB28x15FUN4FVJqrYpTRHNCrw4xEi/Lrret8yfM=;
	b=VBkOilQeUEi8xLCG0lTODH1b0M1qeEM1YqG8RQEm01EBk3HmVcf5fZaZ6T23QK1vVZrhVA
	kCQ+5BmOvHR56imW42LfSVjDk3SSmcbio6Mcmm/Cf2TVBa/yOWOvM5Eh/0iYhUUTHbuAPc
	DciYZ9yaoHBHIg1MX2Tp6v6+OvTo2HA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-e-DgsNX3NrqVhbfbXnnEXw-1; Wed, 04 Sep 2024 12:59:51 -0400
X-MC-Unique: e-DgsNX3NrqVhbfbXnnEXw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5334aba4422so5715799e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469189; x=1726073989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JS7JkB28x15FUN4FVJqrYpTRHNCrw4xEi/Lrret8yfM=;
        b=dsuwQ0KC2nTsVjs9T8hIrDFHdpPP0eR+6Cyyfi9WaSSHWouHU0YbaEh91JeWS4bqTI
         S6oS8ZU0EJy8RKxFADCGDxmrH1+olu2FJDfqEXB48mdPGgb2VOUD42vm99iuSXUzz14w
         GVBlXMNaAnBssaxWnIyimZjIj+suMOxzraJMpsLij+x58v/clI8emQWoMzKJZu5l4uHQ
         lCOeQSLfzvaYWR+v0xwzuT3TWt97H91T7YL/qWGg0QY1T7UULWrI3NcKHGnUO7IHP44Z
         yv5aqZjFsau2rDiXfIaUFcjY2rtrPuR0l5ZEtRVXfb5Z98RHfxWMcdQFnSM3nNPxWuhC
         5B/g==
X-Forwarded-Encrypted: i=1; AJvYcCVi0pG/J9ZLDbrBRxIMOzcdLueP6+sk1isstpEf/ThfsNqJ35n2zyPZ7yVH8JWvOdNPS0VjFhyOyicctro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1qugOflIQ47NpY+wiPrx4VJKKygxIFtXhcBnIzMZSib58Cex
	bqnREZi3wyQ4Cvqvm8opQ7TosqhKJSDqYJltfDgwGFmgjqQqLzHPzznU6tbYlbmKgMXDvy117Xc
	p2H9fayHOTjwKHSkkIXC9vDyQ2a4Sx8CS5ghdC5GgGX0Y/EVZLJJYdCugxPSvOg==
X-Received: by 2002:a05:6512:68c:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-53546bb4d04mr9440203e87.56.1725469189439;
        Wed, 04 Sep 2024 09:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9B/Kw2sYApLrjKyz7ByJ58hLtcGIgW+Hr3O4jbaYLUgaa3c5CshLF9IIRJpnoQqDHMdCh2Q==
X-Received: by 2002:a05:6512:68c:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-53546bb4d04mr9440182e87.56.1725469188788;
        Wed, 04 Sep 2024 09:59:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc56f114sm124404a12.57.2024.09.04.09.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:59:48 -0700 (PDT)
Message-ID: <371e1476-1b7c-4993-b481-132b7552b572@redhat.com>
Date: Wed, 4 Sep 2024 18:59:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: lenovo-ymc: Ignore the 0x0 state
To: Gergo Koteles <soyer@irl.hu>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/24 5:38 PM, Gergo Koteles wrote:
> While booting, Lenovo 14ARB7 reports 'lenovo-ymc: Unknown key 0 pressed'
> warning. Because lenovo_ymc_probe() calls lenovo_ymc_notify() and that
> time the YMC part is not triggered yet (which is mandatory for this
> model). At the end of lenovo_ymc_notify() YMC is triggered by the
> ideapad-laptop driver and then lenovo_ymc_notify() will be called by WMI
> to report the actual value.
> 
> Add 0x0 YMC state to the sparse keymap to ignore.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Thank you for your patch, I've improved the commit message to address
Ilpo's review comments and applied this patch to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=review-hans&id=a8a2253e84dc62b0d50943408c480188a0086263

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> ---
>  drivers/platform/x86/lenovo-ymc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
> index e0bbd6a14a89..bd9f95404c7c 100644
> --- a/drivers/platform/x86/lenovo-ymc.c
> +++ b/drivers/platform/x86/lenovo-ymc.c
> @@ -43,6 +43,8 @@ struct lenovo_ymc_private {
>  };
>  
>  static const struct key_entry lenovo_ymc_keymap[] = {
> +	/* Ignore the uninitialized state */
> +	{ KE_IGNORE, 0x00 },
>  	/* Laptop */
>  	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
>  	/* Tablet */


