Return-Path: <linux-kernel+bounces-398167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF889BE6B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14002808F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B198C1DF24A;
	Wed,  6 Nov 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZelFw1s2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDC442AB0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894556; cv=none; b=keK/XwEWf8eEflcbEQQTczjveAs0Incv0jmSo4r/lpZPQUVe53Uurl064yeQmTIdmWj/2KSsRb7OJx6z4x/+06Pj1O6UYd0jwKrn9PF6PBWR8+aXuSnFMEFWFIh7bHLDS+q9Q0SSZkJ9Fgn0JqMf41Zt1OihTMNu6ogq4oWAzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894556; c=relaxed/simple;
	bh=H7LZ266bGIcETaXKJQQxpR6qza4nwA2bu+OAgrLwPAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qvidfw0ORaGlzP2WoDKtWEvist+8RhV7aKyaK6/p/8n7jw5UXlj+EsWpOHSLkEAEWF9FX3Wfib6MbJMvESLSBQ3OWOjzl37k9k97xdUrKhbOuCW8IlwpzDYr9qOMLjc+xE6eAWGotwa3Gbh+EhgjQJ1iQGdhsYC1hXbZBubfC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZelFw1s2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730894550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHFUrZJG3IhctJbo9qudNI74wu1wMhSAFpJ8ifZ89rY=;
	b=ZelFw1s2x/GVx9COVsKOUILg4zK2n/rD5QyF2MdVfqtsJxQ9z8ij2Rtv/8Jc2D0OKK5eRJ
	73LufhfhxtDVF/l1lNbQCMv3ZELIn33AcMZhWHfSQ11Hf6SKPT6Z+JNib0XVlG9GUwoLiC
	oZ248s9Tua+oYnyv5QHK3+zrMT7bixY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-VqLVLo2NN86tdphanQV8EQ-1; Wed, 06 Nov 2024 07:02:29 -0500
X-MC-Unique: VqLVLo2NN86tdphanQV8EQ-1
X-Mimecast-MFC-AGG-ID: VqLVLo2NN86tdphanQV8EQ
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99ef476aadso529437566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 04:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894548; x=1731499348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHFUrZJG3IhctJbo9qudNI74wu1wMhSAFpJ8ifZ89rY=;
        b=n3T/K0Lcob1ll/N8ycg9/aLue2K8b03lAo3CBCxHQyz9Fdd+4TDBFoPyZ58m2fOKe/
         QRxpclmsIBEgcmTq64ZeBkG3R4DG/R6aXm92P98nRh8nc9oTpXdjFtCwYzHxscVZphVY
         RGOQh24Z5n9uiUr8Y0XZzY7wL702alVHitY8kYdnLc6szlm3INPy/FxlsnG7AGsNR2w6
         GpgTyG7ye3XVle3dP28pcM4rW+tLVWQGiMY3q4EKN8Lj+A3/UPCMxyCqoUgPh93fGgdK
         +dOBaU+PYj7C4vhDLGl2hm53IWzzVKr4NlXhdGaZO/0CHmwb4uzldW0S8SJqXSfN2gz7
         Zx3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKG/x55TzYa9U/68Uo2MAkclPWmRbbSC7lkAUiz4d4jJDQ+NfZpKryYbhyz9f6xO/P+DUP1R41gpRvYXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyumJEraO8acNV4t3xRcntPuxUNZ3/3hnT3CKc01zyvQsro55Ys
	1aS3fYQyBq2EigZxI0Kq4yiK+7Q7HQ8S7g7dnXz7Pa9su9OZFZBfHGBNBhRlyBcFMp0XYNx+l0n
	8S2gYdqjvCgnFMGDn4O6K16Gw7NKn5DITfXtCZdVcAOU/H39CZqeBQoEmMSnPEw==
X-Received: by 2002:a17:907:7e90:b0:a9d:e1d6:42a1 with SMTP id a640c23a62f3a-a9e655aa36amr1859338266b.30.1730894547927;
        Wed, 06 Nov 2024 04:02:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNJE0pGbd+J391fMlx8hWRHnGKZWnQKHUov4H3doeDcVwFWy91F0V80/t9gtBCJAkPyjoYjg==
X-Received: by 2002:a17:907:7e90:b0:a9d:e1d6:42a1 with SMTP id a640c23a62f3a-a9e655aa36amr1859335466b.30.1730894547546;
        Wed, 06 Nov 2024 04:02:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a1440sm269817566b.31.2024.11.06.04.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 04:02:27 -0800 (PST)
Message-ID: <f3a50d1a-aa0c-4cf5-9138-a1da4ebdc671@redhat.com>
Date: Wed, 6 Nov 2024 13:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Thinkpad_acpi: Fix for ThinkPad's with ECFW showing
 incorrect fan speed
To: Vishnu Sankar <vishnuocv@gmail.com>, ilpo.jarvinen@linux.intel.com,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Vishnu Sankar <vsankar@lenovo.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
References: <20241105235505.8493-1-vishnuocv@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241105235505.8493-1-vishnuocv@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6-Nov-24 12:55 AM, Vishnu Sankar wrote:
> Fix for Thinkpad's with ECFW showing incorrect fan speed.
> Some models use decimal instead of hexadecimal for the fan speed stored
> in the EC registers.
> for eg: the rpm register will have 0x4200 instead of 0x1068.
> Here the actual RPM is "4200" in decimal.
> 
> A quirk added to handle this.

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> Signed-off-by: Vishnu Sankar <vsankar@lenovo.com>

Note I have dropped this second duplicate Signed-off-by,
I have kept the first one since that matches the From: 
from this email / the git commit author field.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans





> Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 4c1b0553f872..6371a9f765c1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7936,6 +7936,7 @@ static u8 fan_control_resume_level;
>  static int fan_watchdog_maxinterval;
>  
>  static bool fan_with_ns_addr;
> +static bool ecfw_with_fan_dec_rpm;
>  
>  static struct mutex fan_mutex;
>  
> @@ -8682,7 +8683,11 @@ static ssize_t fan_fan1_input_show(struct device *dev,
>  	if (res < 0)
>  		return res;
>  
> -	return sysfs_emit(buf, "%u\n", speed);
> +	/* Check for fan speeds displayed in hexadecimal */
> +	if (!ecfw_with_fan_dec_rpm)
> +		return sysfs_emit(buf, "%u\n", speed);
> +	else
> +		return sysfs_emit(buf, "%x\n", speed);
>  }
>  
>  static DEVICE_ATTR(fan1_input, S_IRUGO, fan_fan1_input_show, NULL);
> @@ -8699,7 +8704,11 @@ static ssize_t fan_fan2_input_show(struct device *dev,
>  	if (res < 0)
>  		return res;
>  
> -	return sysfs_emit(buf, "%u\n", speed);
> +	/* Check for fan speeds displayed in hexadecimal */
> +	if (!ecfw_with_fan_dec_rpm)
> +		return sysfs_emit(buf, "%u\n", speed);
> +	else
> +		return sysfs_emit(buf, "%x\n", speed);
>  }
>  
>  static DEVICE_ATTR(fan2_input, S_IRUGO, fan_fan2_input_show, NULL);
> @@ -8775,6 +8784,7 @@ static const struct attribute_group fan_driver_attr_group = {
>  #define TPACPI_FAN_2CTL		0x0004		/* selects fan2 control */
>  #define TPACPI_FAN_NOFAN	0x0008		/* no fan available */
>  #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
> +#define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
>  
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8803,6 +8813,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('R', '1', 'D', TPACPI_FAN_NS),	/* 11e Gen5 GL-R */
>  	TPACPI_Q_LNV3('R', '0', 'V', TPACPI_FAN_NS),	/* 11e Gen5 KL-Y */
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
> +	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
>  };
>  
>  static int __init fan_init(struct ibm_init_struct *iibm)
> @@ -8847,6 +8858,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		tp_features.fan_ctrl_status_undef = 1;
>  	}
>  
> +	/* Check for the EC/BIOS with RPM reported in decimal*/
> +	if (quirks & TPACPI_FAN_DECRPM) {
> +		pr_info("ECFW with fan RPM as decimal in EC register\n");
> +		ecfw_with_fan_dec_rpm = 1;
> +		tp_features.fan_ctrl_status_undef = 1;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
> @@ -9067,7 +9085,11 @@ static int fan_read(struct seq_file *m)
>  		if (rc < 0)
>  			return rc;
>  
> -		seq_printf(m, "speed:\t\t%d\n", speed);
> +		/* Check for fan speeds displayed in hexadecimal */
> +		if (!ecfw_with_fan_dec_rpm)
> +			seq_printf(m, "speed:\t\t%d\n", speed);
> +		else
> +			seq_printf(m, "speed:\t\t%x\n", speed);
>  
>  		if (fan_status_access_mode == TPACPI_FAN_RD_TPEC_NS) {
>  			/*


