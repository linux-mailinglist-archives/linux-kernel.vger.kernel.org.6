Return-Path: <linux-kernel+bounces-277728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E294A559
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B16B26682
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B721D1729;
	Wed,  7 Aug 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYngykoS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A334A1DD39D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026313; cv=none; b=KzXHhFoC9o49Gz/t0mlBRygPBGAjbbJ62iiqEWe/bXKdNv2TfIXw7T/U01zi/45ypSJF7ABJ4lQr+Oqx3k0BijcvSatsit1skzvgT2NNsH6SuLNxdmrPNvb+pvHIPiAfKi9EzHqkLtnJw/Cuos4BP1VW/S/1afn7N3HfMkcBCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026313; c=relaxed/simple;
	bh=hOCZ+GOo8ddJAc837ZmiCPmlPJQZfhv/jg3HcXSwZJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XStTBo+In0rBaBMC0lw1FZ5oPlpCRiwV9R0l0B05nmm7RvYEa7skNd34yhUlsCpVEQ7+J6DRLfFM/3aifzzC/gV5TJroyo9w9HBhm1cUfj01rPOHZFBebtg3B2lpHv9NGE9TmCE+Sl9AKib8Ym6WBHfEq/n3FzD3d+S9/mpaPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYngykoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723026310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKr5o03hOgeY5mMH9I+zX5gWnfZedpywYbJmmdN0XrU=;
	b=JYngykoSLJQniC5zblbzjzLA5SEFkf/nYJg9T8xDCacwpu+yD61/J8Xz/uZwfrVTpNw6Xc
	LPvpnN3JLkeg/e1t56T3W2ZbmKLelXya5BSGsWBp1pl2HsVQVj9VTKVPZxCY6qiG02u3GA
	iIt4ip+jAWNyqjFQcKwvyyJX/lcuIc8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-ni3lf-RCOuOvIrm5PBZb-g-1; Wed, 07 Aug 2024 06:25:09 -0400
X-MC-Unique: ni3lf-RCOuOvIrm5PBZb-g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bba487c111so193333a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 03:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723026307; x=1723631107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qKr5o03hOgeY5mMH9I+zX5gWnfZedpywYbJmmdN0XrU=;
        b=jwfzoiH+IUbC07LcbEaytlvZv5DuLy1PVpoxgh5pOAGHZ7+bLmJIxPA2rOgyu6gkvG
         KeyHEBSJXZj1xDL7D4x8kPj+TpM2aDfIPITAwZcgeGljSRBDC5Ej3Wlq5SmS7ViHKhvU
         TfSCRvytFkUS4p2LGwp7aAwmKenkK39ZHsGUuMQPSVDl/8fFk4abqPJ4R7vElQe3fYn/
         GzPeYTIgja82g94OkdzvWhB0T3yn2EBzYrxHRyuekPeps5sYtGKEVo9X4LFpmjgjpJfN
         WKXkwJ8C7Mq2lNtnRgvXOvhhbjP2grGxw9E055/zSpAWuoevuhrKyFrkGDhuee9dO2/e
         E6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXLT+VACTv5lVas8cNa0Kt+mr5w2ka/ecU0T53OVMUa0oh3qzndsSlNbW92WsjG6IoJ6LiqQz2zsE3Pp8bV/3U2xG2WAtjxLJsewADZ
X-Gm-Message-State: AOJu0YzbFTl0NIco8gWZzzjcNy+DYn3EmSHiRljKNgOVrvQFj0Wmb+u2
	ndUbh4pv4ZgXTmC6vYdxON1uDIzFC1x11SqgdWmCXc4+j+vgo2EFcJS/rwN49sDJHj997MvHqvD
	t59dMB4992Z/cF5ghQ/KStk4yqH0CQeTeGOR092cTITZevzgNzZPNcB/nYGRNlQ==
X-Received: by 2002:a05:6402:40c5:b0:5b9:462d:c53c with SMTP id 4fb4d7f45d1cf-5b9462dcf53mr15779395a12.6.1723026307201;
        Wed, 07 Aug 2024 03:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKU5pngRUkJ93655Cskv4fXvNSoHRSaMMNyZsujYLi/pNlxeqKlTnLCO41rUMJegB040lfFA==
X-Received: by 2002:a05:6402:40c5:b0:5b9:462d:c53c with SMTP id 4fb4d7f45d1cf-5b9462dcf53mr15779364a12.6.1723026306697;
        Wed, 07 Aug 2024 03:25:06 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83bf38fafsm6781109a12.80.2024.08.07.03.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 03:25:06 -0700 (PDT)
Message-ID: <5145dd51-d095-4185-920e-eafb33219e07@redhat.com>
Date: Wed, 7 Aug 2024 12:25:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi video: force native for Apple MacbookPro9,2
To: Esther Shimanovich <eshimanovich@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240806-acpi-video-quirk-v1-1-369d8f7abc59@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/6/24 10:08 PM, Esther Shimanovich wrote:
> It used to be that the MacbookPro9,2 used its native intel backlight
> device until the following commit was introduced:
> commit b1d36e73cc1c ("drm/i915: Don't register backlight when another
> backlight should be used (v2)")
> This commit forced this model to use its firmware acpi_video backlight
> device instead.
> 
> That worked fine until an additional commit was added:
> commit 92714006eb4d ("drm/i915/backlight: Do not bump min brightness
> to max on enable")
> That commit uncovered a bug in the MacbookPro 9,2's acpi_video
> backlight firmware; the backlight does not come back up after resume.
> 
> Add DMI quirk to select the working native intel interface instead
> so that the backlight successfully comes back up after resume.
> 
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index c11cbe5b6eaa..2d377414f873 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -547,6 +547,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>  		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir9,1"),
>  		},
>  	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* Apple MacBook Pro 9,2 */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
> +		},
> +	},
>  	{
>  	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>  	 .callback = video_detect_force_native,
> 
> ---
> base-commit: d9ef02e56f0fd3668b6d7cb17f9399ea53f12edd
> change-id: 20240806-acpi-video-quirk-f1c9f01f07d9
> 
> Best regards,


