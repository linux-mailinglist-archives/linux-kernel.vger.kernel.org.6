Return-Path: <linux-kernel+bounces-576913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0862A715EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D0317109C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E9E1DDA3E;
	Wed, 26 Mar 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4DTD7Y4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88F1B4139
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989140; cv=none; b=NNfrTMKDO+mz4ZcHwh1U1A/Q0DDF6JhNVVRgYGCtlhQzdH2+pstNl1b4xqnbNy1yn62VDISCSjpGsJuncdAw6kliiu50zfJ1Nq/AvvR6tOdJZbXVmIdurScMI3CTtOapB0gpreL3UosI7ZeIPkXlBQ4YtdAvAes0sQZwpvmXTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989140; c=relaxed/simple;
	bh=XnplYuVML4RH+JsPqgWSH/ztbX4Jjen6uimGimavSLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmrZtGHOsngBDW84E5UeCaa3fQ0eDqGeb7k7JF99JgWA/CEX5sUEfGabYvIkeqScPKwco1ZcaOCnWanPmva4DdrBZDbmZtZzUZIf9HZvtKj7ZgLacfZGZ3zaVf+v1lJZW72zXpYuS0Hipt3i8emIN8ivjINMbako4CX7x/1HavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4DTD7Y4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742989136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1TSW2IN1ookhorbSOR1YQnOJVtR5fBLnVFeapHcNk0=;
	b=H4DTD7Y4G7MksAOaN6TvHWQPsS8WHq0tmi3PfbvZ6ORtC+Kh8M+tPaIuxNtnOBTNLGPzvw
	YpFf+G6XEM4CzO/f89idHSUOmlcs8C5qIvPpCXJDVBFLZidtLDm2LDVdWvbMLA/aZcEmi0
	Zp5No1kstw+QNOIQd43FNwQTnzNN3eM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-g3zaVbH8Mi6wugCOFy1Pfw-1; Wed, 26 Mar 2025 07:38:54 -0400
X-MC-Unique: g3zaVbH8Mi6wugCOFy1Pfw-1
X-Mimecast-MFC-AGG-ID: g3zaVbH8Mi6wugCOFy1Pfw_1742989133
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so5517061a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742989133; x=1743593933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1TSW2IN1ookhorbSOR1YQnOJVtR5fBLnVFeapHcNk0=;
        b=rnUyQT8lVhKbkjKIQARyuQgyMfoofDMiUP4bXPu0yHhqEVhwjbPS3h4musCSOWOdpD
         CIitYEsMoijriAd7f0cuBHTPIcDk7zmSuAxB8WjNGa7Q/fpfYH/Aq4arLx5iPPyvJZMi
         EsuvbuvEpbAcbpKGMK91ytR+opEnb/Ch/nOFeYSI/Tg0ZR55jS4/cm68PJ+NqDmQRm7K
         z5gHmikkpJYOszn/U4duDrs+FRszWK2A/O06+6ZuKHg2oQP3WU7YY0eO1WZpyb1ACSHz
         WlRon6AHAs3xLjjwDBADQPoA2v5Wdg575NYWtD64IEEUthiUKSvTI18/tRY0EVvmYHWT
         7b1w==
X-Forwarded-Encrypted: i=1; AJvYcCUcQoUw681wJ3k763vSGpd4GyG99E4LQS2r+HVZmA7tdoX7H5sk7UY6apHx/ayrnsJLwDR5z2OF8BHMyQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy19A3PZBrf8hf72tsTN3+gvHeZNtQKES1pnTOjB3MM0gmgFejP
	MgYFzVhw7M0oeuTPeuGXbVj9hgXFO0Sv1J7jjvggtXYh/2fdt1pnMkmOw7jLEn8FaaPpHpsF8z3
	Puw6Raseqq/lsA2hnYZ3e5tSE16jqUyITED/TPDcuzEhYn+95/3Lk142BCTsxeA==
X-Gm-Gg: ASbGncusdwTPtPtapvOLhOa2s2SK5qZCMTh8staqO7bpsZds1Hh4J7BKjEtuVDpy92W
	6tGwXvO395iKqgWCTTUXAxAXUfFFO/R6/hL7vzLsEctyxpevTazdLy6J3vbjirrz3jynWhFc05w
	iw41jmijaYLk2pwW2O6xYhQURiFoJpqHP7iv6LTPYskaGsbV38Mcu3pnqODIpzenFM06dMjkXyW
	gqMB7DaWDM2Gzj+gLdextv3PVs1qmu0MD6p1Hc1j84cRK6PB1lseqB7BZdToDGvaK8edvBRjB8h
	EANic/InRv2867/DbJAgqD1OS1Jfv/kkk6xxuXDoh7gKMLJrT9uSBG/a25uidFClJrbUhb+HXrV
	KZt8rn3rZ8I1h5/xAjqdg4RIQT5mLb35JCiIbTO8xZ9adbbrLdyj8dd5qVEOTn5MxAg==
X-Received: by 2002:a05:6402:1d4a:b0:5e8:bced:9ee5 with SMTP id 4fb4d7f45d1cf-5ebcd4677eemr17580333a12.18.1742989132654;
        Wed, 26 Mar 2025 04:38:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4LIDH0+/cfzodfLAMwdwoMvesHVwPnzapymDBeoYaycgFvHYk1U8+6k//KJH9mqcFoMsF6w==
X-Received: by 2002:a05:6402:1d4a:b0:5e8:bced:9ee5 with SMTP id 4fb4d7f45d1cf-5ebcd4677eemr17580314a12.18.1742989132088;
        Wed, 26 Mar 2025 04:38:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb049csm9457044a12.42.2025.03.26.04.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 04:38:51 -0700 (PDT)
Message-ID: <b7a9585e-d02d-4a73-b294-ee78eade3ffa@redhat.com>
Date: Wed, 26 Mar 2025 12:38:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5] platform/x86: asus-wmi: Add quirk for ASUS Vivobook S14
To: Kevin Robert Stravers <kevin@stravers.net>, linux-kernel@vger.kernel.org
Cc: Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "open list:ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS"
 <platform-driver-x86@vger.kernel.org>
References: <20250326113157.2341184-1-kevin@stravers.net>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250326113157.2341184-1-kevin@stravers.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kevin,

On 26-Mar-25 12:31 PM, Kevin Robert Stravers wrote:
> The ASUS Vivobook S14 will have wifi disabled on boot as well as
> resumption from suspend if the asus-wmi driver invokes rfkill functions.
> 
> This patch disables asus-wmi's rfkill usage to prevent the wifi card
> from being software disabled.

Your patch is still missing a Signed-off-by line in the commit-message.
We can only accept patches with a Signed-off-by line in the commit-message
like this:

Signed-off-by: Your Real Name <email@your.domain>

By adding this line you indicate that you are the author of the code and
are submitting it under the existing license for the file which you are
modifying (typically GPL-2.0) or that you have permission from the author
to submit it under this license. See:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Please resend your patch with a valid Signed-off-by added.

Unrelated to the S-o-b problem I wonder if you've tried setting
asus_nb_wmi.wapf=4 on the kernel commandline instead of adding
a new mechanism to disable rfkill support all together, see:

/*
 * WAPF defines the behavior of the Fn+Fx wlan key
 * The significance of values is yet to be found, but
 * most of the time:
 * Bit | Bluetooth | WLAN
 *  0  | Hardware  | Hardware
 *  1  | Hardware  | Software
 *  4  | Software  | Software
 */
static int wapf = -1;
module_param(wapf, uint, 0444);
MODULE_PARM_DESC(wapf, "WAPF value");

This would still require a quirk to do this automatically
on your model, but it would avoid the need to add a new
type of quirk.

Regards,

Hans

> ---
>  drivers/platform/x86/asus-nb-wmi.c | 13 +++++++++++++
>  drivers/platform/x86/asus-wmi.c    |  5 +++++
>  drivers/platform/x86/asus-wmi.h    |  1 +
>  3 files changed, 19 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index 3f8b2a324efd..1e6fb9308560 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -150,6 +150,10 @@ static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
>  	.ignore_key_wlan = true,
>  };
>  
> +static struct quirk_entry quirk_asus_vivobook_s14 = {
> +	.skip_rfkill = true,
> +};
> +
>  static int dmi_matched(const struct dmi_system_id *dmi)
>  {
>  	pr_info("Identified laptop model '%s'\n", dmi->ident);
> @@ -530,6 +534,15 @@ static const struct dmi_system_id asus_quirks[] = {
>  		},
>  		.driver_data = &quirk_asus_zenbook_duo_kbd,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "ASUS VivoBook S14",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "S5406SA"),
> +		},
> +		.driver_data = &quirk_asus_vivobook_s14,
> +	},
>  	{},
>  };
>  
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 38ef778e8c19..42e58a28c3e2 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2138,6 +2138,8 @@ static int asus_new_rfkill(struct asus_wmi *asus,
>  
>  static void asus_wmi_rfkill_exit(struct asus_wmi *asus)
>  {
> +	if (asus->driver->quirks->skip_rfkill)
> +		return;
>  	if (asus->driver->wlan_ctrl_by_user && ashs_present())
>  		return;
>  
> @@ -2188,6 +2190,9 @@ static void asus_wmi_rfkill_exit(struct asus_wmi *asus)
>  
>  static int asus_wmi_rfkill_init(struct asus_wmi *asus)
>  {
> +	if (asus->driver->quirks->skip_rfkill)
> +		return 0;
> +
>  	int result = 0;
>  
>  	mutex_init(&asus->hotplug_lock);
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
> index 018dfde4025e..3692de24e326 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -41,6 +41,7 @@ struct quirk_entry {
>  	bool wmi_ignore_fan;
>  	bool filter_i8042_e1_extended_codes;
>  	bool ignore_key_wlan;
> +	bool skip_rfkill;
>  	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
>  	int wapf;
>  	/*


