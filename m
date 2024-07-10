Return-Path: <linux-kernel+bounces-247759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C592D428
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 270671C22732
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D54193453;
	Wed, 10 Jul 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+4s8VEg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98386193474
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621440; cv=none; b=D7xOq4woOftPlMhqJDHrJD7zFKuyjSW6eFwanrNgSIM3Z0Vz7Kf4tlMC1ilAZjp2HvnO1Uej6X19ahfEHLejBITD54g/al4evJaPZNgxT342GWQTX8fZHLYYQldBy3ZwqqixB4/bqIlwUcln4K94oBr/QO/gAt8JL8A7BCB1BVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621440; c=relaxed/simple;
	bh=806bIZDj6BHtXaJLfBvXRgfnolJ0TrqnaZzVKKHc/sU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8ZLkm2o4Bnb4Z+HplIh9WgyiXykOZe+aicci5Vbmmgf6dKaK5JuKm9NzsIecsWHrcuECJKCEfVk0rj/V+Q6hKo6pbbJdHmMIazDcst1M0WVdXefbvGevRlg+jmaoVgCMJt+wBmX04Lr5q9Pr4ewj5dOEoOVyjOz9WLzXfjI2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+4s8VEg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720621437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4rv2YfuIOi4YzbG1Mj2bU65j/X6O6OaYiPmhJXSb7M=;
	b=i+4s8VEg103WbTpMBzYD29c9/0GP8Whugm0U2SA3u5rYi+HvJlQ19L/azh0nil6TlSXFMt
	uOs4D0ehgC3QxXGCE6KUcLRvwtWYp3nNUygw5b9iPMhqW2ZdMVVpGlV7GQr+9aUE1h8jVA
	q54vEob3dpn3uXUu8iZCsvaT3KC4qv0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-imovon5APXSGBy3-hAYvvw-1; Wed, 10 Jul 2024 10:23:56 -0400
X-MC-Unique: imovon5APXSGBy3-hAYvvw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-52ea249d1c9so256195e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720621434; x=1721226234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4rv2YfuIOi4YzbG1Mj2bU65j/X6O6OaYiPmhJXSb7M=;
        b=QZc9yJXbtCYP7MALvOWWXosFWjompwir1slMp8pB6KzEwFEb+Ddo0+zLt8o8X2eg7i
         5OtGTJd4GV8vPIZZ0hPLwoL+at0mHyUvwjEK7I0SwyvwvdVAcjWTkqgH1628i37hRMMB
         q9VFTLfY3zN0qvL0QWyx8Rf21m0l54S+WC/SKrSsHuWpnrLPKHxOOUklnwlGJEUWRYaW
         XJMyRQVYObe1SUMTnTwzGL8mc4URQn/CyZIwMrL3emxFnSmZf7hM/OXpNdVLC4+anea+
         tP9oL0rXSABS6FTT+2dHAg9Fo5dgmZpaWcooBCsZG3pItEnl8i/N4Cj550BhyTsYidZX
         y6tg==
X-Forwarded-Encrypted: i=1; AJvYcCW5InmMnWNe1ASIGTlmNKoX75qFcZgL0f24Fpq1mEeQ64A/AVJfKbG1MbFkFAqLTw8SPv3vHtNgg2NoMzNRRy0TxYX6hcNo8+PHdQaR
X-Gm-Message-State: AOJu0YxHTWz4VcT3o50Ijdv/JHZNhrdMPoCJVsrowMb2CX7oTlDPFIdY
	7oOHI8WdXQ/sB9BYoZGSPo1hpCIfnfeabE9N/t2+lFtWcGwSqRRV72eOwkyfQ6Z+FvJ3lDf67zE
	Rf/CQjHLXKulo13548yd/GiFVAB6rRTnWqbwz3kBVOqD0Jrw8wUlHatRsvB8GOw==
X-Received: by 2002:a05:6512:b1e:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-52eb99d207cmr4152859e87.49.1720621434797;
        Wed, 10 Jul 2024 07:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaTauYqL1weuUg5lShg9XA5vUe+mwhAk4RhHU+CPzgui7UnJVeoYukB0fatbeHpng63qd68g==
X-Received: by 2002:a05:6512:b1e:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-52eb99d207cmr4152842e87.49.1720621434354;
        Wed, 10 Jul 2024 07:23:54 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a871baasm163657566b.189.2024.07.10.07.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 07:23:53 -0700 (PDT)
Message-ID: <fdd8227d-4e72-4cac-9ab9-9b8a3de22f8e@redhat.com>
Date: Wed, 10 Jul 2024 16:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/platform: toshiba_acpi: Fix array out-of-bounds
 access
To: Armin Wolf <W_Armin@gmx.de>, coproscefalo@gmail.com
Cc: ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709143851.10097-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240709143851.10097-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/9/24 4:38 PM, Armin Wolf wrote:
> In order to use toshiba_dmi_quirks[] together with the standard DMI
> matching functions, it must be terminated by a empty entry.
> 
> Since this entry is missing, an array out-of-bounds access occurs
> every time the quirk list is processed.
> 
> Fix this by adding the terminating empty entry.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202407091536.8b116b3d-lkp@intel.com
> Fixes: 3cb1f40dfdc3 ("drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER_ON on resume on some models")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch.

I have included this patch in the fixes pull-req to Linus
which I have just send out.

Regards,

Hans







> ---
>  drivers/platform/x86/toshiba_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 3a8d8df89186..d54bccec6ad6 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -3299,6 +3299,7 @@ static const struct dmi_system_id toshiba_dmi_quirks[] = {
>  		},
>  	 .driver_data = (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOTKEY_QUICKSTART),
>  	},
> +	{ }
>  };
> 
>  static int toshiba_acpi_add(struct acpi_device *acpi_dev)
> --
> 2.39.2
> 


