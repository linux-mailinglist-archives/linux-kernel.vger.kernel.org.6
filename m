Return-Path: <linux-kernel+bounces-297807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6295BDF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DAFB253A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C061CFED2;
	Thu, 22 Aug 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZ9Dyy4i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362B1CDA1C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349895; cv=none; b=mXfRVsRt65xEUNGogBHPAY1y+r8FhT7gjWrMUCA8qFv2GveM4Pbh8lKNGGZUtznH1t3l8aCECOleOAQ5pM8CB+8Dxj2gA4NRfY9vCCDj4EucSHyJN+WUXbbIymy5vRPLYGSLLYc2uYOLoibuJ371ke4aPV3mn5ABVvk2yN4TADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349895; c=relaxed/simple;
	bh=22LkK5Q1Veaz9Mb1zYBbVIj2dXiCPlbXlwB1IfPgj7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm1WHsA3slJDf4d8vAf/fF+xfaObujoPxwYe+ySS2wGen993lSXZo0oscgExWpwTDrZJvTJ4Zl5+ATTBYXYsiqLXgiE7zFkVKSvO02y+1/3h3wNQygKcOtrw8K1cYY4vWIVCZlXRPpoHuFwHFAbaSJSuBjbfb+twACMeByRdyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZ9Dyy4i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724349893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEQT24HTH/UP2orz6Wh0q+3NPw1eci4EU9RHhKZFX2g=;
	b=gZ9Dyy4i2I/RO5Tuqj2k1VfoMGDN0QpRWt9IxMTOKHQF6EdvYJbdWgRocnDWDxlhULs5QY
	KRXixziIR38UuFrZlCPbsNUvpSLbnJm/ekyGyePOyVQqua6fvsAc7xsXvmI127Ato0EWI5
	FbNC3uitiJOLUOqf/+ieE+PevbHP1Io=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-jrcgtz4nOu-vF6FLniY6_g-1; Thu, 22 Aug 2024 14:04:49 -0400
X-MC-Unique: jrcgtz4nOu-vF6FLniY6_g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso8341705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349886; x=1724954686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEQT24HTH/UP2orz6Wh0q+3NPw1eci4EU9RHhKZFX2g=;
        b=S4nwCBBisygvblEuqMMx2ZbU2F501N/3ZWW0YNIKFxVsFaY96eADQFMPUQ6rk0X8NK
         zrmHOQLKEB9K0C7YwS04NtvAhP6SvS+YOG4P1YLUv5PmLomWAWK2Fu37+0Sqz7bPksSK
         C2Uav16q9mQk+PxFjLb2NJm8BphRdQ8P3uaG9bkde55h6wGnRTOHTs+DoqXCF4Q/WsqP
         vOcAhy416uUuQsNjSBf48n5M9ztCyYYOMn3Y0xuvkzCoCPTq969OfhOwlAPa20eulqOp
         SY8BmBBFt4Fy16v1+lXxwCCgvKeX4HhyZnU6//JtRtxTDzoQlRCb5kUQD7IwIhWQZEdL
         yV0g==
X-Forwarded-Encrypted: i=1; AJvYcCVF4umdNnjTLf7ch779+uI63+wE1D/kw2lbk+jzEWP+aE81NIWbCJoGWhIzhI5cpsA0ARAhWH74qpDxWNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3s4RtXu95fv4bIN95FEUKxzKMas5Ysjoj4jiGrcUx/nRDMuh
	RANsJO59SQCdllxF5VgYxx9A2DFIM7kkXEzSBckK/rgIwywVeccKrSb7Wt8ej6yiTQmcPSQSDbe
	uG1DeLMo3PZ8qV8tQuZP8eztJdx4OE37eSH2/jBWA7u83/EWFezb4rjUFuxBirA==
X-Received: by 2002:adf:f24d:0:b0:367:9088:fecd with SMTP id ffacd0b85a97d-37308c08c62mr1716033f8f.7.1724349886330;
        Thu, 22 Aug 2024 11:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6SUIKLE1JQjtqs6HrdTaFyqHHZmF+U8ofr6ynQWzY+vpqwb/HUy6nOYotftRU637wSsXYJg==
X-Received: by 2002:adf:f24d:0:b0:367:9088:fecd with SMTP id ffacd0b85a97d-37308c08c62mr1716018f8f.7.1724349885823;
        Thu, 22 Aug 2024 11:04:45 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c9064sm1152586a12.73.2024.08.22.11.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 11:04:45 -0700 (PDT)
Message-ID: <f3baa8c0-3363-4f0c-be86-83be2ec4d373@redhat.com>
Date: Thu, 22 Aug 2024 20:04:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] platform/x86: wmi: Pass event data directly to legacy
 notify handlers
To: Armin Wolf <W_Armin@gmx.de>, james@equiv.tech, jlee@suse.com,
 corentin.chary@gmail.com, luke@ljones.dev, matan@svgalib.org,
 coproscefalo@gmail.com, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>
Cc: ilpo.jarvinen@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240822173810.11090-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240822173810.11090-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/24 7:38 PM, Armin Wolf wrote:
> The current legacy WMI handlers are susceptible to picking up wrong
> WMI event data on systems where different WMI devices share some
> notification IDs.
> 
> Prevent this by letting the WMI driver core taking care of retrieving
> the event data. This also simplifies the legacy WMI handlers and their
> implementation inside the WMI driver core.
> 
> The first patch converts all legacy WMI notify handlers to stop using
> wmi_get_event_data() and instead use the new event data provided by
> the WMI driver core.
> The second patch fixes a minor issue discovered inside the
> hp-wmi-sensors driver, and the remaining patches perform some cleanups.
> 
> The patch series was tested on a Dell Inspiron 3505 and a Acer Aspire
> E1-731 and appears to work.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Guenter / Jean may I have your ack for merging the small
drivers/hwmon/hp-wmi-sensors.c changes through the pdx86
tree ?

Regards,

Hans


> 
> Armin Wolf (5):
>   platform/x86: wmi: Pass event data directly to legacy notify handlers
>   hwmon: (hp-wmi-sensors) Check if WMI event data exists
>   platform/x86: wmi: Remove wmi_get_event_data()
>   platform/x86: wmi: Merge get_event_data() with wmi_get_notify_data()
>   platform/x86: wmi: Call both legacy and WMI driver notify handlers
> 
>  drivers/hwmon/hp-wmi-sensors.c           |  20 +---
>  drivers/platform/x86/acer-wmi.c          |  16 +--
>  drivers/platform/x86/asus-wmi.c          |  19 +--
>  drivers/platform/x86/dell/dell-wmi-aio.c |  13 +--
>  drivers/platform/x86/hp/hp-wmi.c         |  16 +--
>  drivers/platform/x86/huawei-wmi.c        |  14 +--
>  drivers/platform/x86/lg-laptop.c         |  13 +--
>  drivers/platform/x86/msi-wmi.c           |  20 +---
>  drivers/platform/x86/toshiba-wmi.c       |  15 +--
>  drivers/platform/x86/wmi.c               | 143 ++++++-----------------
>  include/linux/acpi.h                     |   3 +-
>  11 files changed, 53 insertions(+), 239 deletions(-)
> 
> --
> 2.39.2
> 


