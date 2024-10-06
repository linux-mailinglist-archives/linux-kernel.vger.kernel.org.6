Return-Path: <linux-kernel+bounces-352353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4C991DF4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15D01C20E06
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DADF1741EF;
	Sun,  6 Oct 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+RNSkc5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30215956C
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728211799; cv=none; b=Yr+9ndxIctY3VSeK/melwrr/nkM7lzSkcfFUrjHUC2+HG2Y+cibuHDl0dyMHme4XBUvgBUItMXsKvw5nzO86c8e+HZD2cPN+LAa9/Q3f6aaCBXNd2rBPLfo/6MU2Qe3tp3YTX7NMCy6XK/SyFjuWaco5Xd5gHFpFzVw2x5QvnMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728211799; c=relaxed/simple;
	bh=E8L96tVfgGVZ7VX9L5r18iqyQhEy1HOc44YA4bAOI/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyHy4fpGfpMKxRLN0dPbDDy0Ma0XlXFFUWr6izHf8390tjO6Q3PRnJ9Qxll5sbK8AmSdxGK9RsgHdvGw/bjAfVkYADViPIiDfEHQO+zDGx2O+mAN4K+6F2vKCaxDHkt/pWDPTlVKx7J0Q4ZzADQTdBuops3kql2WkY5nXRsjOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+RNSkc5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728211796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0I5g/3hrB2raC35TGDOkVo1grl5AIkAJOloeD3JxtA=;
	b=T+RNSkc5108ItuG1WhDxDESnhfUyOZ+6wznraFYfZUpfqyN/Prg0xU1veI8nPL6ufKnXm7
	N6w9wLv1QKuFVp7jZRClrrJzur0dSNWhnu0L5GUCTea59W0ggFA2D7JdGoIVwynvi7QlFZ
	nA9YlHxJ6AWPBWObLDdLIb23aDoADbM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-0s1CK7tRP0u2ltyNtr7p3g-1; Sun, 06 Oct 2024 06:49:55 -0400
X-MC-Unique: 0s1CK7tRP0u2ltyNtr7p3g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a994cd8089aso58860066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 03:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728211794; x=1728816594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0I5g/3hrB2raC35TGDOkVo1grl5AIkAJOloeD3JxtA=;
        b=SyjWS1v3ILk5Q2AaxxkBE3i7YMrZ+IGG4O0WaXUFEZ6cqljsZzpqzbs7fxqumwlpFb
         C0+yGlmblEW/XyghGU63BJGi3MzOa6zxrFja1sbkV+EVnEpt4YIFQG1X0bahuqnZzNep
         RNpg1/PyPbIsSd8fx45SZ6Ax0XBHEY4s0AVqqQzsnyitxKRG9JJ+KP0/6YPOc70gefzg
         QWoRhqXA1XY9rnrRe8FpbDrbamTqMSnhlX9KlmOs8ERU4mBJAuXgREMezIWcDF/GwFMb
         8+dAonCbG8xIjVYoReox6s6HQiIAysbSUC1iWNgTmHCLtfL3po6gehvwKPKU8prdWIFx
         3v5g==
X-Forwarded-Encrypted: i=1; AJvYcCUkfOMTELCX34XH1WBYR+l8NxsE7mjzLqeoB1W6XtVBTANJE0AmMVhAA6r9cpbEbKeHc5TcxkcRzTg7KLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWoTHGhEsPFn79peyAEHQWJiu8bc1xrYMkfN1PSvU2X7mekUw
	68O2ZKqsrd0pkfs84NrWqJmZ2sYMmGiYCa7EugGPdSgE0wJJKtaUnzXRXnysDg6Gzch7xVwXQjI
	6MH4oUjAZNwwFzw0VxCLglLuAv9aQP7jWr3gwFcqY2nM2zHH5S+L6uZzX2HQTuA==
X-Received: by 2002:a17:906:6a20:b0:a89:f1b9:d391 with SMTP id a640c23a62f3a-a991bd08219mr1036198966b.14.1728211794317;
        Sun, 06 Oct 2024 03:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaA+xxSBuABBBNfUx7MGmssKZawRSVqf5LpTu2EeC7zHnSUgXDHUcLau3WnsT1s4Fv2dILVw==
X-Received: by 2002:a17:906:6a20:b0:a89:f1b9:d391 with SMTP id a640c23a62f3a-a991bd08219mr1036197266b.14.1728211793924;
        Sun, 06 Oct 2024 03:49:53 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7e5544sm238105566b.202.2024.10.06.03.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 03:49:53 -0700 (PDT)
Message-ID: <263ec855-d19d-4b81-b3cd-1a7f575c9c27@redhat.com>
Date: Sun, 6 Oct 2024 12:49:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/x86: wmi: Update WMI driver API
 documentation
To: Armin Wolf <W_Armin@gmx.de>, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241005213825.701887-1-W_Armin@gmx.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241005213825.701887-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Armin,

On 5-Oct-24 11:38 PM, Armin Wolf wrote:
> The WMI driver core now passes the WMI event data to legacy notify
> handlers, so WMI devices sharing notification IDs are now being
> handled properly.
> 
> Fixes: e04e2b760ddb ("platform/x86: wmi: Pass event data directly to legacy notify handlers")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Since patch 2/2 makes non pure bugfix functional changes
I expect Ilpo to pick that one up for pdx86/for-next.

Regards,

Hans




> ---
>  Documentation/driver-api/wmi.rst | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/wmi.rst
> index 6ca58c8249e5..4e8dbdb1fc67 100644
> --- a/Documentation/driver-api/wmi.rst
> +++ b/Documentation/driver-api/wmi.rst
> @@ -7,12 +7,11 @@ WMI Driver API
>  The WMI driver core supports a more modern bus-based interface for interacting
>  with WMI devices, and an older GUID-based interface. The latter interface is
>  considered to be deprecated, so new WMI drivers should generally avoid it since
> -it has some issues with multiple WMI devices and events sharing the same GUIDs
> -and/or notification IDs. The modern bus-based interface instead maps each
> -WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it supports
> -WMI devices sharing GUIDs and/or notification IDs. Drivers can then register
> -a :c:type:`struct wmi_driver <wmi_driver>`, which will be bound to compatible
> -WMI devices by the driver core.
> +it has some issues with multiple WMI devices sharing the same GUID.
> +The modern bus-based interface instead maps each WMI device to a
> +:c:type:`struct wmi_device <wmi_device>`, so it supports WMI devices sharing the
> +same GUID. Drivers can then register a :c:type:`struct wmi_driver <wmi_driver>`
> +which will be bound to compatible WMI devices by the driver core.
> 
>  .. kernel-doc:: include/linux/wmi.h
>     :internal:
> --
> 2.39.5
> 


