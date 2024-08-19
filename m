Return-Path: <linux-kernel+bounces-291961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E67E956965
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36EA1C21618
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC930166F0D;
	Mon, 19 Aug 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eAxtgtM4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B215DBB2
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724067327; cv=none; b=caqbH/5HHIeDYVnCr9havO8W1HnFUILvd2EyjuDjst/AiR1RhuP2VWzGfFyLyRhxGhmRWkW469lejQPdYYKy83cPguUwQKikB8mSJos0COoWHtJO8hoGHDARUZAgfpUrNnxy7u3XWFa9x4R1BVPLM8ZARBSSiX2CYIm/huaLy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724067327; c=relaxed/simple;
	bh=MDedqQPB6dsaMEONikTl/1RMQRCp7sK3bf066RpPqks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3dTUPSo/9dw/pvQMNTp3kHalntKkPGcrzWFLp5UZ5CsAQ+9HIFMHUtg4kKPJEGAH5TW1h2yhzg9Z7L7PIC7M3ZjQBkEdCtfdJNwIFzZSFPrkxU5W2QsX7PtYgufTpCPOrH2mjuKpuXxagOU0nk3UfhbNz5KiDhG9iFBI0vLzwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eAxtgtM4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724067324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M20arWskVFP5YK7nPxzcg+NGtMqFGh7nnimh7RRgstg=;
	b=eAxtgtM40vae9o7YJj1ZXYEW+73At6t7caNblO4EZnVB1o1w5JG/0VBrxlOToIwcPa7ZRD
	P//mFnMBxRfyKy5KcRArCkyPYigMXNJ/l53pfRD9DounvHj/MMPz2/x5PNAxQAk9hIZr9E
	it8claRuq9NnA1ZCrnREebm5jqW9NCU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-pLrkqFZvN_KBCwWydrp-3w-1; Mon, 19 Aug 2024 07:35:23 -0400
X-MC-Unique: pLrkqFZvN_KBCwWydrp-3w-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef2907e21bso37126611fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724067321; x=1724672121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M20arWskVFP5YK7nPxzcg+NGtMqFGh7nnimh7RRgstg=;
        b=wyDBdwIRcswVK1lDmvfOLAQhBh2Nl+Fpf7feMIXZ1obRdHGKwIpAqpwvAlaEUB78mV
         MHZDYATJxJkweuGanCp8WNdfgwRIA3r1GCH7eEEIAFwJKyC4rDmc+QmLdQRKFD+6o+a3
         OLl0I5UkcndMYYAqlWNFQT5mTYOYlruUI+SE2336f2JepR8iTnKsh53l2w3ylq3hWfb/
         lwROhBuFM2r12Z7c02MZ2x6HqSJf3p8PzOcTM3ePXDihrrJz615uJ+SRVmVKPDPMqBNv
         OhY5IIYuBFFsP6tVfea7b76s8OWCu5nrztxL3I9OQG9ZvRRPVop5knGSykwUgWdBTvW4
         mADw==
X-Forwarded-Encrypted: i=1; AJvYcCV41gsHN14A4OJ0xdxcjPIMxgVWicSmVRdXAkc5wGMNdb1p4iX8Od4JhAwr0rtJduorWEfhkdz3LEF8w8tXakHTYVXHlKLYCP25gGX2
X-Gm-Message-State: AOJu0Yxd8lvjdB5Ko7vakx+ab4e7LjC6i1ynUNIkwu7nYLKCOUcigjtp
	oyoR7yPL2THk3rxCYsQ9NRaPIqdPxLu8OoSpF1q9Nmxd+56RAyu7Klp3M9JDhQ/ud03GgWIh/C9
	LBz8ZBB1WZKUm4NIFQTuZkIfte33yO1nzj3f33a9gJRZdwDi72WIcyzVkUOK7klCzNtxbCA==
X-Received: by 2002:a05:651c:2127:b0:2ef:2638:48cd with SMTP id 38308e7fff4ca-2f3c8f25920mr53992321fa.30.1724067321141;
        Mon, 19 Aug 2024 04:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu6wabqdvyZOV6LacydGRyY+oQdph0qcbAV72zEz3kI7ReYJSbU0pZSWAgPxgWsS9ToNBIbg==
X-Received: by 2002:a05:651c:2127:b0:2ef:2638:48cd with SMTP id 38308e7fff4ca-2f3c8f25920mr53992011fa.30.1724067320473;
        Mon, 19 Aug 2024 04:35:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc082f4dsm5436179a12.96.2024.08.19.04.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:35:20 -0700 (PDT)
Message-ID: <e0068ba6-c211-4878-8f16-fe97746c2a56@redhat.com>
Date: Mon, 19 Aug 2024 13:35:19 +0200
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

Daniel / Thomas I believe this series is ready for merging now,
do you want to merge this through the tree for drivers/clocksource ?

Or shall I merge this through the platform-drivers-x86 tree ?

In case of the latter may I please have your Acked-by for patch 1/2 for ths ?

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


