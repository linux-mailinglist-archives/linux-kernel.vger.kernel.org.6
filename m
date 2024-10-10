Return-Path: <linux-kernel+bounces-358700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD20998292
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF76F1C26BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E711BC092;
	Thu, 10 Oct 2024 09:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnPmsK/X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEBA1A264C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553252; cv=none; b=nWCYJiV0Boob8EjkMPhtBdPAB/+WxXKRE+77+Zt8db136B5mb74Kzl1t4cgwNO0g7KJS7IZI3bPjw3dedCJCjTjuhmIIwGvVlg1bxDsNexLHrsMlVlVEaZeIkADV1eKUIVoqmBszT221/UG53FNkeNRELYa9Zp4u1D4klkVHqs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553252; c=relaxed/simple;
	bh=e8R74kM4mPG1ed1AIErXucQF2cYAg0bgQggJFQ4Numg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TX2p12GXFAC+N7HxKa2W3Sw7lVaDCgObkp/Yqw87AD/j1a2alqlzrPsYISZTov3q3ul0S/SfDIga79bm5gAOakDka/Nt3MBK9yyZZMFzt6l+rD/IqklHFB4+ut1jiIlO7WjkCPlbQY3RgQHVt/8j0iEKa6yAJDu9MuX6IDQZNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnPmsK/X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728553250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXMNh8HkQHbT6f1Sbmj7JQ1SELTwJXctNZOXP79wsf0=;
	b=AnPmsK/XEJ+ZnTOW7STm9lTPiUPilo2E7G9C23dcfbunnOvYHguZxKu9u9BMzIF5/xCDie
	a8SQpf5O4ey6gccVO7H/y85ht4Dt39vGg5N2/dFYRtlRNlc45xhZgpQTxd2D7xYwJc2Q/L
	s0g7LUSHSO/v6qvotqzPrr4e945lWP4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-HNxxc8CCPM-rBB0W47mncQ-1; Thu, 10 Oct 2024 05:40:48 -0400
X-MC-Unique: HNxxc8CCPM-rBB0W47mncQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a994fb94446so85848766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553247; x=1729158047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXMNh8HkQHbT6f1Sbmj7JQ1SELTwJXctNZOXP79wsf0=;
        b=koMHeWWFTX10QjnocAxKMOTpWY5heryuDlujpEt2DDqGi6ULVRf1ckD07XxkBu4Wu1
         1ABzti3dANz9WLD7iNV2jfvILCsyeq8nSGn1JvhSIK7dEzjZQXlJilHIbciDOmlBFEsj
         NEPKsIwlERi2v4zw12rDVuTSMjVK/K8KKMn/ZlUv5Ms+pZ4881bEfQeEVudYCXd3GDTV
         tp/H/s0EuHgmGJU7Fv5JydZad1ZjCsOJegjLX3j6gTivXG404ZU3O6+NIOsMnQU1tb7Y
         yCF+UzCq/1tsdxKu/f671BpHvswxNciKDbOw/15SCr/Vylqa0K4NHA62eU6SPQZ6TASo
         +Alg==
X-Forwarded-Encrypted: i=1; AJvYcCVjie6gah5vdHBIcAE07AqIxhTuFeaf7gb4v5jFp50qM9+9nSO/IOq471RAA6Z8ruy34MUIrvFacqyTz6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiiVCQTP6JejDOx0v5wznEBWJ2ttj1kAS0RPNYnlyhL/yTKcQX
	BJZVdrYEKOFu4jlqG8UjzqH2KNad8y8oEpbqAhnIOKp4WQfK8sOrFTGeDlIZ/NU0rABfyMZc08W
	N7KBNLv0+V0N/JT1tC3GFmbRra+pZwLqskriGFbzSVB1R19UVYGmGwMQ5kmzUTXhTmdasLwq0
X-Received: by 2002:a17:907:d0c:b0:a98:f44d:a198 with SMTP id a640c23a62f3a-a99a0ebe7eemr258243066b.1.1728553246569;
        Thu, 10 Oct 2024 02:40:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyPVLsovtIuKX040BgGyYevVIq+FVcn4t9AAjJD1tbqlLyZN1eCnrRWTnDDqHb+AmRsjeCFg==
X-Received: by 2002:a17:907:d0c:b0:a98:f44d:a198 with SMTP id a640c23a62f3a-a99a0ebe7eemr258239666b.1.1728553246047;
        Thu, 10 Oct 2024 02:40:46 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7f27f05sm63046466b.83.2024.10.10.02.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:40:45 -0700 (PDT)
Message-ID: <d49c5a2d-3715-447f-9936-fadba12bb225@redhat.com>
Date: Thu, 10 Oct 2024 11:40:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] asus-laptop: prefer strscpy() over strcpy()
To: Abdul Rahim <abdul.rahim@myyahoo.com>, corentin.chary@gmail.com,
 luke@ljones.dev, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241009230558.51892-1-abdul.rahim.ref@myyahoo.com>
 <20241009230558.51892-1-abdul.rahim@myyahoo.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241009230558.51892-1-abdul.rahim@myyahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10-Oct-24 1:05 AM, Abdul Rahim wrote:
> The function strcpy() is depreciated and potentially unsafe. It performs
> no bounds checking on the destination buffer. This could result in
> linear overflows beyond the end of the buffer, leading to all kinds of
> misbehaviors. The safe replacement is strscpy() [1].
> 
> this fixes checkpatch warning:
>     WARNING: Prefer strscpy over strcpy
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/asus-laptop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index 9d7e6b712abf..d460dd194f19 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1832,8 +1832,8 @@ static int asus_acpi_add(struct acpi_device *device)
>  	if (!asus)
>  		return -ENOMEM;
>  	asus->handle = device->handle;
> -	strcpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
> -	strcpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
> +	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
> +	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
>  	device->driver_data = asus;
>  	asus->device = device;
>  


