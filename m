Return-Path: <linux-kernel+bounces-291955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596A956952
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6A81C215E2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B7C166F18;
	Mon, 19 Aug 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jE44LQ6g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CE13DBA0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067101; cv=none; b=sVxBnb8fIq/++w/zMPkJEvDosCeAI3Ws/o0YJVpIut37KuB7W4a9Mq908QaPUye3IZ+MagKXXaT/u/NjtbGL+ujL3ly7CndhZstiFnQx+HbskddtVNwXyx7GQb52CFcpRmas/fGFG8gWUSf8hT35JwaZx48b03ZOMyCYBk9PWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067101; c=relaxed/simple;
	bh=Ky/B3NXca3X7lFkRgPJNmQFGjEKyiSbafchOr6X2S7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ogvtxSOQgwxuFIXIDeNXYIZTJnGSj72wt9TKjwKgsgUqNV3yoxXXS9r1GVyLDOKrCIZl5poN6Vat+v2J9Le4eaD91HjOQMsKEQky7QWToINGPz6xT65edkjHBecy6GsVkJBCuETEH7mHiwtAd8fNWwtxNxmc/A8FpLeVEkJvxXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jE44LQ6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724067098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPrDOhvYjrt1xlh8GqTfb3Bq+qp7wGx4/YKlG6mzg6U=;
	b=jE44LQ6gkHVtiLFkxwOl/sAu8pa1/0Fv0R6NcBM2fUv325AQUtv+Q9KZLI82c5rqm8VJkP
	YtyxvU36U9E+KNfzYfu5MFxCfr/Fe4MNrdUzc+iJRLWczeglew+MlXIFBUzWDFq+9Skf5I
	5a7o6LC5Ww2O9lOZcJi/qD1Wae8ccfc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-pNlkl_fXM_qbu-63YGs0mw-1; Mon, 19 Aug 2024 07:31:37 -0400
X-MC-Unique: pNlkl_fXM_qbu-63YGs0mw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5becb612a13so2041514a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067096; x=1724671896;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPrDOhvYjrt1xlh8GqTfb3Bq+qp7wGx4/YKlG6mzg6U=;
        b=iS+Kj8hwkMxmfeTV3FDu2bXNp5BLsal7blKZp/vDj8M2GX42tAMDoYJGyHb5IOMl/1
         ZPuw7YWoM2WTfWG2D0oZouh4MX2OEWOvfvB+CUoZZ7HxO+l5KhVbiLUl8IPbnN/1ptuo
         rQfCPXTpMmo4seY0Php5YmM14VKx5o+8qRHfgUI1A1FW0PVVeGsuFDA9HYv4l3vV16ln
         w7iKVVZ9qYM9TX1ygCx21GuQwIUnAJY+hw5txUcnYRXFnM/fBDrSt7rBoJOSkErhqFzs
         ss+tvZW1TspDIxKL/rKE+jg2Uk2p6THN5MA52N7TdCU7A7NY790ev82Yx/ayHBUmXkwh
         yVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeWBEND9CxsFfCpflxCxGtTPrTkMPTdjYAwkmLnyusd4VnGuAdkDs2dzmx0MIW6WHAMJz2ZJQXID4Brv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIveXWqJRVEWvLgbq9pNp2gMxfPtYcNGZm4SIlx9i/6MAiR+Ex
	Ps/NegaEe3Uh+JHllPpMhORLgaCVF+g8nlBwTRKFBruyOE+5Bc9HphPVReP8nFn3gsSX6glp9mK
	W3Yd+p/fSnYDK99MAomK1aih1HvLbkQuO776BbdtrYT2WlV49SO6kmjYFh3iPXQ==
X-Received: by 2002:a05:6402:540d:b0:5be:f348:314e with SMTP id 4fb4d7f45d1cf-5bef34834d5mr2510361a12.36.1724067095989;
        Mon, 19 Aug 2024 04:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdL6ead+DHbFwkhYgQIEnqJvT9c+TaKaavUabxtrQK/ZUjhzqan4aYpkDtTYbYTspGUnk5pw==
X-Received: by 2002:a05:6402:540d:b0:5be:f348:314e with SMTP id 4fb4d7f45d1cf-5bef34834d5mr2510339a12.36.1724067095302;
        Mon, 19 Aug 2024 04:31:35 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe12eccsm5719952a12.58.2024.08.19.04.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:31:34 -0700 (PDT)
Message-ID: <318e1059-1c92-4cc5-a7ef-9284f7c5aa37@redhat.com>
Date: Mon, 19 Aug 2024 13:31:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] clocksource: acpi_pm: Add external callback for
 suspend/resume
To: Marek Maslanka <mmaslanka@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org
References: <935e8c82-3c91-4c9a-8e43-e6045b28279d@redhat.com>
 <20240812184150.1079924-1-mmaslanka@google.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240812184150.1079924-1-mmaslanka@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/12/24 8:41 PM, Marek Maslanka wrote:
> Provides the capability to register an external callback for the ACPI PM
> timer, which is called during the suspend and resume processes.
> 
> Signed-off-by: Marek Maslanka <mmaslanka@google.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> ---
> Changes in v6:
> - Add the acpi_pmtmr_unregister_suspend_resume_callback function to remove callback
> - Add EXPORT_SYMBOL_GPL to the added functions
> - Link to v5: https://lore.kernel.org/lkml/20240812043741.3434744-1-mmaslanka@google.com/
> ---
> ---
>  drivers/clocksource/acpi_pm.c | 32 ++++++++++++++++++++++++++++++++
>  include/linux/acpi_pmtmr.h    | 13 +++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
> index 82338773602ca..b4330a01a566b 100644
> --- a/drivers/clocksource/acpi_pm.c
> +++ b/drivers/clocksource/acpi_pm.c
> @@ -25,6 +25,10 @@
>  #include <asm/io.h>
>  #include <asm/time.h>
>  
> +static void *suspend_resume_cb_data;
> +
> +static void (*suspend_resume_callback)(void *data, bool suspend);
> +
>  /*
>   * The I/O port the PMTMR resides at.
>   * The location is detected during setup_arch(),
> @@ -58,6 +62,32 @@ u32 acpi_pm_read_verified(void)
>  	return v2;
>  }
>  
> +void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data)
> +{
> +	suspend_resume_callback = cb;
> +	suspend_resume_cb_data = data;
> +}
> +EXPORT_SYMBOL_GPL(acpi_pmtmr_register_suspend_resume_callback);
> +
> +void acpi_pmtmr_unregister_suspend_resume_callback(void)
> +{
> +	suspend_resume_callback = NULL;
> +	suspend_resume_cb_data = NULL;
> +}
> +EXPORT_SYMBOL_GPL(acpi_pmtmr_unregister_suspend_resume_callback);
> +
> +static void acpi_pm_suspend(struct clocksource *cs)
> +{
> +	if (suspend_resume_callback)
> +		suspend_resume_callback(suspend_resume_cb_data, true);
> +}
> +
> +static void acpi_pm_resume(struct clocksource *cs)
> +{
> +	if (suspend_resume_callback)
> +		suspend_resume_callback(suspend_resume_cb_data, false);
> +}
> +
>  static u64 acpi_pm_read(struct clocksource *cs)
>  {
>  	return (u64)read_pmtmr();
> @@ -69,6 +99,8 @@ static struct clocksource clocksource_acpi_pm = {
>  	.read		= acpi_pm_read,
>  	.mask		= (u64)ACPI_PM_MASK,
>  	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.suspend	= acpi_pm_suspend,
> +	.resume		= acpi_pm_resume,
>  };
>  
>  
> diff --git a/include/linux/acpi_pmtmr.h b/include/linux/acpi_pmtmr.h
> index 50d88bf1498d7..0ded9220d379c 100644
> --- a/include/linux/acpi_pmtmr.h
> +++ b/include/linux/acpi_pmtmr.h
> @@ -26,6 +26,19 @@ static inline u32 acpi_pm_read_early(void)
>  	return acpi_pm_read_verified() & ACPI_PM_MASK;
>  }
>  
> +/**
> + * Register callback for suspend and resume event
> + *
> + * @cb Callback triggered on suspend and resume
> + * @data Data passed with the callback
> + */
> +void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data);
> +
> +/**
> + * Remove registered callback for suspend and resume event
> + */
> +void acpi_pmtmr_unregister_suspend_resume_callback(void);
> +
>  #else
>  
>  static inline u32 acpi_pm_read_early(void)


