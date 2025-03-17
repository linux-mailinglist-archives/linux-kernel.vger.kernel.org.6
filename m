Return-Path: <linux-kernel+bounces-564577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 094D2A657B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47434175899
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D6A1991CB;
	Mon, 17 Mar 2025 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLh3hSu6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A14579D0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227876; cv=none; b=t9GiGdFb4BsuaOv5zkv4p1WVh78Z3ZwL62F2p6RyGF0oMRkIg5h9Bl68xO0GkzIKz0+kbeRVcX12UTtujf7hbHYEJGUEGBTqBN5LG6WWI12LRQq4/B0DFNgOxW4sSmCCI4t2eD0d71ASBM+RRnzmBb+Uyfy5h3mVgOIZXK//n/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227876; c=relaxed/simple;
	bh=Uoc1DrwhFhqKapvK2aZfs21XdFLHjo6sg1n08s0IZcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MFRYWfcMbqakmEOfEDGBywTX/SF6ZPvU262MbgWnL9AypsQKTOgWGqnQ+K38GePPGC5rmx9WUqvt3LIt6MMHN0N/swNjcTyiMc+yn6c76Ly025DHhnHNIaaA1APmEYPjP7OLe5Q3Rs5lTO/+Dt1c1Fs8AinDiS9++bYxYYl4cj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLh3hSu6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742227874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gMxOns8OLCANHT+gWoMrsh+8iH9de53W50uJK8mjjKs=;
	b=NLh3hSu68cB2WRwyIKYfBSiNqUQ9Ql+qImttmx2aBgu8K8hbD29rx+Y7QQ0dLCTbyw9/PR
	vxHuU9pfePpay9CFAUk0u0nSb2fgFIlSMWnGQ0Hp2GYeRgnlx0n80a3r8I3Xc5RaLsu6Lp
	vK2pjvDYqyh4JEycVwqxsVODGqDz2DI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-MhDTfCRtM5CDv5deZP1QBA-1; Mon, 17 Mar 2025 12:11:11 -0400
X-MC-Unique: MhDTfCRtM5CDv5deZP1QBA-1
X-Mimecast-MFC-AGG-ID: MhDTfCRtM5CDv5deZP1QBA_1742227870
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac286ad635bso534660066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742227870; x=1742832670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMxOns8OLCANHT+gWoMrsh+8iH9de53W50uJK8mjjKs=;
        b=TvjEHdohSRQOpsBmfBiESkInvaVdxZK9Y1+2eeR0JItykirI7C9hPZ46v7y9i85sbK
         eFgVJ/YVtLurbTtWXBxZYE9pDWyaFjpBIpzB29dt/irPbg5tebCl1V2gpbL3WFzmuNvb
         kCcrW/eteL28wfjJod++vhnHi+eYpctmv0Can/u+q1hk3oTRQoYu+SloM2crS4YOI281
         4BrHfXoQcs+vTH3Iny7YIeCSCGriYp26eZa2NQpOKNBgprKo333UpoTC02GfEjwSD04U
         TVghB3cZr5M7JUoTU1/9tDjdfju67/tgwbAca/2n3UqoCAtJt6mDMvSyuWUUZ8mQwGhu
         ur8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPHXMLznClh5ppgOPO5A4p3iFj7zFGzFsnIepj59mHIRo9FxrMddVVwwucErkWwJNYPUHlk1i5oEyr6OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+6k3t0aal7YnsClup/RMwyJAc6Fu6k5RWq5KWjSRCmLT7VfK
	wZ+oPPVBvBpanX45XZdt8nhYGDV8f5ogoV6LIvMg6xgQH351ZVu+mEHxgPrfU2G4v3mazRthN9d
	+gTcZxvZ3GXcj2/BSJjT2YJ9g+XuAJ/yUk7ru3Z6deV+f4bfErj4BOrmRSdkSyvDNSPh+RpGN
X-Gm-Gg: ASbGnctiY2ZOgeILJQuFV8rThUSIw6Ydfm6Vn5pj0rZEEDpb9dYLRUrNRIOxX3qoCVJ
	E6OdErheUUYQcWyESYGb5O9cGZh1VM6lOFjXe76jp7GM5j4gSQhHZuts6L1g1p4EeeOH2HL0GIl
	CF/EfIFWLjfB7NE6O6tAiKkF680ijDVittmLJLp8Jx+kgeEuTPjKqhxubQX6lGnBEsnlJvXPiuD
	XCHIc7gbvz7KMWzsWhv4Q7jy79RON8ZVhS/B66qcDeQzmd3jOz9x0JdcPKkn8FxCRmCux9l3/Gx
	WnnTWCUgrBx9c3WevPoqsh75B1n6mXwnZsHQEvdIcqDvd1nXCc5VzVXgVxLkt5QY2IQeCdMUF/G
	6CEjxnVen8dWURnudkbz4nRfngpl+GVM+h/zQ+R67iaiuFFSLxFGfNiVioAnKJ5Dp2g==
X-Received: by 2002:a17:906:ee85:b0:ac2:d6d1:fe65 with SMTP id a640c23a62f3a-ac38d515007mr31490566b.41.1742227869880;
        Mon, 17 Mar 2025 09:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0sssDA3BQRaSOyamV/S0PXeQ9xKfhQPA6HZicsQtZlhud1G2Kdvgy67YBjeYvH5sJJ0eE7Q==
X-Received: by 2002:a17:906:ee85:b0:ac2:d6d1:fe65 with SMTP id a640c23a62f3a-ac38d515007mr31484766b.41.1742227869395;
        Mon, 17 Mar 2025 09:11:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314858a8fsm676871266b.80.2025.03.17.09.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 09:11:08 -0700 (PDT)
Message-ID: <d9da58be-7a83-4007-8ea7-8c6d6005094a@redhat.com>
Date: Mon, 17 Mar 2025 17:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/13] power: supply: add inhibit-charge-awake to
 charge_behaviour
To: Antheas Kapenekakis <lkml@antheas.dev>,
 platform-driver-x86@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Joaquin Ignacio Aramendia <samsagax@gmail.com>,
 Derek J Clark <derekjohn.clark@gmail.com>,
 Kevin Greenberg <kdgreenberg234@protonmail.com>,
 Joshua Tam <csinaction@pm.me>, Parth Menon <parthasarathymenon@gmail.com>,
 Eileen <eileen@one-netbook.com>, linux-kernel@vger.kernel.org,
 sre@kernel.org, linux@weissschuh.net
References: <20250317155349.1236188-1-lkml@antheas.dev>
 <20250317155349.1236188-13-lkml@antheas.dev>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250317155349.1236188-13-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Mar-25 4:53 PM, Antheas Kapenekakis wrote:
> OneXPlayer devices have a charge inhibit feature
> that allows the user to select between it being
> active always or only when the device is on.
> 
> Therefore, add attribute inhibit-charge-awake to
> charge_behaviour to allow the user to select
> that charge should be paused only when the device
> is awake.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Thanks, patch looks good to me, FWIW:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  Documentation/ABI/testing/sysfs-class-power | 11 ++++++-----
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  drivers/power/supply/test_power.c           |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 2a5c1a09a28f9..78afb2422fc5a 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -508,11 +508,12 @@ Description:
>  		Access: Read, Write
>  
>  		Valid values:
> -			================ ====================================
> -			auto:            Charge normally, respect thresholds
> -			inhibit-charge:  Do not charge while AC is attached
> -			force-discharge: Force discharge while AC is attached
> -			================ ====================================
> +			===================== ========================================
> +			auto:                 Charge normally, respect thresholds
> +			inhibit-charge:       Do not charge while AC is attached
> +			inhibit-charge-awake: inhibit-charge only when device is awake
> +			force-discharge:      Force discharge while AC is attached
> +			===================== ========================================
>  
>  What:		/sys/class/power_supply/<supply_name>/technology
>  Date:		May 2007
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index edb058c19c9c4..8d036faf220ec 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -140,6 +140,7 @@ static const char * const POWER_SUPPLY_SCOPE_TEXT[] = {
>  static const char * const POWER_SUPPLY_CHARGE_BEHAVIOUR_TEXT[] = {
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO]		= "auto",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE]	= "inhibit-charge",
> +	[POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE]	= "inhibit-charge-awake",
>  	[POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE]	= "force-discharge",
>  };
>  
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 2a975a110f485..958e0c0cf2876 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -214,6 +214,7 @@ static const struct power_supply_desc test_power_desc[] = {
>  		.property_is_writeable = test_power_battery_property_is_writeable,
>  		.charge_behaviours = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE)
> +				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE)
>  				   | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE),
>  	},
>  	[TEST_USB] = {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b2921624..bb8e9e62ce834 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -212,6 +212,7 @@ enum power_supply_usb_type {
>  enum power_supply_charge_behaviour {
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO = 0,
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE,
> +	POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE_AWAKE,
>  	POWER_SUPPLY_CHARGE_BEHAVIOUR_FORCE_DISCHARGE,
>  };
>  


