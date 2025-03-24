Return-Path: <linux-kernel+bounces-573630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557F3A6D9FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E723A3AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71725E80B;
	Mon, 24 Mar 2025 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCR9NCUH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EA825E457
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818827; cv=none; b=vDth9c96jodJIon9i2Ub7rkwJSoCRfaJru2RBrlNrjedNJupRGbBWH7nmvQKzmaB2x4cZ0RmaIpSDVXtfFvZoQyvMHce93wRQnQddvfxqIv4hnZ/uKMHVbDNUxeLSBkjBuGn5IScHxZ9/dpshOalsLSooTeIOMdKGgKg1aDDKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818827; c=relaxed/simple;
	bh=h6EXQtOMm1giDo9FOnn5Hqk0DnGCyR67Eox8XU5ZNHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d52h3WY675LFvUpkv+pyoR6qrVipSEfPmCyUei1VaOpep9kDtM2C20AZMeoi7pj0iqkMZZXplY/dhnfSBDuT32LAumbLwWRk3BZ9giaF+kpYKnnNCYvP3l3ZnYP9ckDhvzziFiL538mjD6UPPmY5FhvlZDtdYS8DWq+deTbDRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCR9NCUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742818824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBvMUUbkMLRaYqxLSSI92c3hpwamAvh7kByiodVp/2g=;
	b=NCR9NCUHYYSTt0sGSSJm1R8m3+Wd2RvZu0g0zbDgJgB/4FfICVepVhQr3GoDG5Ik3KcEgA
	PtynMQXrwaLwzTf0GTvLwtO1p2wy+WWuzsruJ3Gpr4EZoj3d8eH7SoB6UGbnj0mYUr8mIB
	Wv9hPPFTyRfmKICxmgVzGZvr8RbyGNo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-MEXIjrfLMEu718BoUnTYwQ-1; Mon, 24 Mar 2025 08:20:23 -0400
X-MC-Unique: MEXIjrfLMEu718BoUnTYwQ-1
X-Mimecast-MFC-AGG-ID: MEXIjrfLMEu718BoUnTYwQ_1742818822
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so326061866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742818822; x=1743423622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBvMUUbkMLRaYqxLSSI92c3hpwamAvh7kByiodVp/2g=;
        b=jyHCd291Q1vPmhmL4lLS4N4FoUGWllbv0OG6WYFa0NsTGzLosZcOhgWbNATW6NjYyN
         EREmfkskuK9kMCk2z0ST/HmgLXaKf9e8gpVNdPu4MPL2fkdMon8CxHE4fR/UAEeJnIEE
         kNFmHGyx0dyA6s0WbOgBvvJE6tOJkZsIs8Yc7dRwTAiBeqH5wLnHUd082IWXjDgHtCvp
         spojQ58sSpDgo8hKKlY0pMTe0UJTMRUfzmUAcCnI0MdRyHXWkhbkrbaR3ZVW0ROsq6Hb
         ApIwvCT0eXYRSdHCFaUFsAV6pOIE4tQ68jAliSUW99Kz0R6Vbn60KfjBiwxvSek6DHuN
         YoDw==
X-Forwarded-Encrypted: i=1; AJvYcCWjvizR01R98RYtSdKyXIL/RAD/0IE366ztY3FOW8f1FuPKV6YE6z8K8py2tMy/iSbtAeW6mKxQzb0hXzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziuRCjtTx56cSYYVI0fuLM5HRJZe/PxNafG88wSciFK5PJcFHh
	RPZI6wg3WiLIrsvLnGsvljBKVClecJGgeKRsFTxKgpx8KaIxtDaRGkQeo0noMvRFEDgj/A/Q+ej
	26HO7EGFIRIsLpPPkQe73dNHvHUk+2EEKZZfGeDoU12qAeC3rG62/dKtsMvcOnA==
X-Gm-Gg: ASbGncsHsRLb1yrrZZaSEBTo670GgNKc/x2IrzCclrwZjKy9UUavz+sycmECOWJa0md
	UxzGiC5q3LkacUWiDbqwpwjGdG+YECHlfc/yXy9WPEB8Y+ruT9nTgtqI3Zl1yLVG2EaIIVf61wk
	ZA0PNTRybCZICq2fGG40Z+/x5X3TdBzaFlxtN+txzJfZiSTXp/ICanz9mJvAwP5oVfEIYskWeH6
	gZ00WErgVz5tX35EDXp4McbYr2Nbt7gqH9jyLTbqGiHmFCMfynGkiOhi3CVHIJyt2MPugS7S6H1
	8HRW8nt+EG8XQfRHIJQ=
X-Received: by 2002:a17:906:f59d:b0:ac2:344:a15e with SMTP id a640c23a62f3a-ac3f229ce3cmr1090886466b.22.1742818822010;
        Mon, 24 Mar 2025 05:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdipAoepu1nHwUhR/99bUNdfsf56iHHtxs7QMKyzshA4SqzjR1onmN3GV4yX3QhxM4Rn8h/Q==
X-Received: by 2002:a17:906:f59d:b0:ac2:344:a15e with SMTP id a640c23a62f3a-ac3f229ce3cmr1090882366b.22.1742818821496;
        Mon, 24 Mar 2025 05:20:21 -0700 (PDT)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbded04sm671995466b.142.2025.03.24.05.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 05:20:20 -0700 (PDT)
Message-ID: <ba25c7e1-5031-48d1-a1f8-1b25d57856f5@redhat.com>
Date: Mon, 24 Mar 2025 13:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Added support for a some new buttons in ideapad-laptop
 driver Added entries to unsuported wmi codes in ideapad_keymap[] and one
 check in wmi_nofify in order to get wmi code 0x13d to trigger
 platform_profile_cycle
To: =?UTF-8?Q?Ga=C5=A1per_Nemgar?= <gasper.nemgar@gmail.com>,
 ikepanhc@gmail.com, "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
Cc: ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20250321083003.84661-1-gasper.nemgar@gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250321083003.84661-1-gasper.nemgar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Gašper,

Than you for the new version.

On 21-Mar-25 09:30, Gašper Nemgar wrote:
> Signed-off-by: Gašper Nemgar <gasper.nemgar@gmail.com>"
> ---
>  drivers/platform/x86/ideapad-laptop.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index 30bd366d7..a03377d87 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -1308,6 +1308,16 @@ static const struct key_entry ideapad_keymap[] = {
>  	/* Specific to some newer models */
>  	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
>  	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
> +	/* Star- (User Asignable Key) */
> +	{ KE_KEY,	0x44 | IDEAPAD_WMI_KEY, { KEY_PROG1 } },

Still ack,

> +	/* Eye */
> +	{ KE_KEY,	0x45 | 	, { KEY_BRIGHTNESS_CYCLE } },

According to:

https://ardes.bg/uploads/original/lenovo-yoga-9-2-in-1-14-g9-550178.jpg

there already is brightness up/down on Fn + F5 / Fn + F6, so I would just
map this to a free (not used elsewhere on the keyboard) KEY_PROG#.

> +	/* Performance toggle also Fn+Q */
> +	{ KE_KEY,	0x3d | IDEAPAD_WMI_KEY, { KEY_PROG4 } },

I would make this KE_IGNORE with a comment that this is handled
inside the driver, following how this is done for the 0x02 / 0x03 keycodes:

        /* FnLock (handled by the firmware) */
        { KE_IGNORE,    0x02 | IDEAPAD_WMI_KEY },
        /* Esc (handled by the firmware) */
        { KE_IGNORE,    0x03 | IDEAPAD_WMI_KEY },


> +	/* shift + prtsc */
> +	{ KE_KEY,   0x2d | IDEAPAD_WMI_KEY, { KEY_CUT } },
> +	{ KE_KEY,   0x29 | IDEAPAD_WMI_KEY, { KEY_TOUCHPAD_TOGGLE } },
> +	{ KE_KEY,   0x2a | IDEAPAD_WMI_KEY, { KEY_ROOT_MENU } },
>  
>  	{ KE_END },
>  };
> @@ -2093,6 +2103,12 @@ static void ideapad_wmi_notify(struct wmi_device *wdev, union acpi_object *data)
>  
>  		dev_dbg(&wdev->dev, "WMI fn-key event: 0x%llx\n",
>  			data->integer.value);
> +				
> +		/* performance button triggered by  ...  */
> +		if ((data->integer.value | IDEAPAD_WMI_KEY) == 0x13d ) {

You can drop the  | IDEAPAD_WMI_KEY here and just write:

		if (data->integer.value == 0x3d) {

> +			platform_profile_cycle();
> +			break;
> +		}
>  
>  		/* 0x02 FnLock, 0x03 Esc */
>  		if (data->integer.value == 0x02 || data->integer.value == 0x03)

Regards,

Hans



