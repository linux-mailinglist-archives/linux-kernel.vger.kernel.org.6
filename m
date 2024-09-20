Return-Path: <linux-kernel+bounces-334297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCA97D546
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C27B1C21348
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211814F121;
	Fri, 20 Sep 2024 12:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjnDrqgi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905014C581
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834240; cv=none; b=a64V2XaEDIs6zM7/zyg+IwNnIpCtNUB4hn/yS8Xno5pQAmRbcSYBcEpMKtn7cVriAX7g1JUWcpolv1lcsJ8fPdv1FESOV4b0HwrcepKEjvxQwMlOhvF9nxcSNxcsmxehaPipBpSw4zBmvFj4ptNIz5zSad3JjBl0dT4b2n++xUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834240; c=relaxed/simple;
	bh=XYFh4DLN6/r6Sq85qf4bYLjUAqp38/Hg/NQArtbjRpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwXESobQWtqwAnB5rktvFGsIfXpDnj5oVoVMpzHt48Jk+zK5D8MCPRL0W9jga3gWYMUGGgr/VHdyJfdcGCcwU0DzyUjrtCNZT5ObHpO7sAdEWyaHoI+AhKT5QFEHIhyIbSh80DLg79Wd7kXqBmzxj1iTgv5LDUFeI9v0NANHqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjnDrqgi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726834237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eM2fNaRDFas29zMKWdtqBon+bSwbaG6Nc3FOrqL+huI=;
	b=GjnDrqgigaDRLgoCH7yy89nJx5JbyfW0PWFP4+lCFJ+A0M2a/X6feWbAUtBj+0hFzQLSkw
	im1ptW+/pGUOQBQiOdZq8sdYwTSRLE/fu79tAB/zuDyMO8tTJog4C3j2FVDnde7QywnrI0
	WQxzWry2rlU4sVrqoZt0M6eu329CQNk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-KRGrihpeME60lRtvS7A0fQ-1; Fri, 20 Sep 2024 08:10:36 -0400
X-MC-Unique: KRGrihpeME60lRtvS7A0fQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5356a05fc7cso2259568e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726834234; x=1727439034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM2fNaRDFas29zMKWdtqBon+bSwbaG6Nc3FOrqL+huI=;
        b=nkxMhP0ULtM0vNz7k+eBsyVejQwmCuvFulbOl2y73IjZFK1FeDCve4+3SbZqXyidgD
         p4/Z3UbpqESKzo61xm2CGj0bBtD27iWqSaw3GxAT3T1OW73afTWBc2puJ0WREu2mSwIb
         g9bpC03DWjDHW/fvJhYRqj9gm4DmuPhvMKQKTT5KSL/qk/dTi6nt7X9NFyFAIHZVbu8K
         F47F0dPk+cUGCC57eIux4+NxGy3YbdhQzRvLMegVBGYjiemLoQM0chgYD6FX0vyt5f0p
         TV4AY/lomAUN7DWcqpjGOwMIuOhDLpXBAZovzmL8G71WZRDlSLn/tcniuiAAOz9owlHg
         g3TA==
X-Forwarded-Encrypted: i=1; AJvYcCUFBrR6zZrvUJflGRtydpekQp+TJkOJKHx+/7+Ls2j0qaW+F5udnRaT7zVMBj6ZO/YP4Zl0p2VNjPBsu/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyeYbF8o5/FNZA8ecofFEKFeEaL+HmsauGUFzqJtuVHXSR5CD+
	k0X9I+lS9PjimAMvprs6RLEtqGJA8n1j1KI8KZb39FWwixiFcoJ3pmAJVHzJU0SkuaK+EqJvpjq
	e94M+MPfiA+x3QpiM2w/fXHZf0nQCSfe9JK8bXUq1ngkEnCo9KktAHxI60I5TAQ==
X-Received: by 2002:a05:6512:3dac:b0:533:71f:3a3d with SMTP id 2adb3069b0e04-536ac2e86ccmr1961533e87.24.1726834234238;
        Fri, 20 Sep 2024 05:10:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHQogLeRmFy/+WuPOpcbeCnoGIHILmzzS/u0ArVVZxjQgjr3rXN2lc/s8QND0gPFH+ZQKkNA==
X-Received: by 2002:a05:6512:3dac:b0:533:71f:3a3d with SMTP id 2adb3069b0e04-536ac2e86ccmr1961499e87.24.1726834233833;
        Fri, 20 Sep 2024 05:10:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e1a55sm838937166b.157.2024.09.20.05.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 05:10:33 -0700 (PDT)
Message-ID: <e893f91f-6f78-46ac-b28d-1e45fab892e2@redhat.com>
Date: Fri, 20 Sep 2024 14:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: abituguru: Remove unused
 ABITUGURU_TEMP_NAMES_LENGTH macro
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903025037.9711-1-bajing@cmss.chinamobile.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240903025037.9711-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Sep-24 4:50 AM, Ba Jing wrote:
> The macro ABITUGURU_TEMP_NAMES_LENGTH is never referenced in the code. Remove it.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>  drivers/hwmon/abituguru.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
> index 93653ea05430..58072af4676b 100644
> --- a/drivers/hwmon/abituguru.c
> +++ b/drivers/hwmon/abituguru.c
> @@ -95,11 +95,6 @@
>   * in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0
>   */
>  #define ABITUGURU_IN_NAMES_LENGTH	(11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14)
> -/*
> - * sum of strlen of: temp??_input\0, temp??_max\0, temp??_crit\0,
> - * temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0
> - */
> -#define ABITUGURU_TEMP_NAMES_LENGTH	(13 + 11 + 12 + 13 + 20 + 12 + 16)
>  /*
>   * sum of strlen of: fan?_input\0, fan?_min\0, fan?_alarm\0,
>   * fan?_alarm_enable\0, fan?_beep\0, fan?_shutdown\0

ABITUGURU_TEMP_NAMES_LENGTH is used further down buy only in a comment:

/* IN_NAMES_LENGTH > TEMP_NAMES_LENGTH so assume all bank1 sensors are in */
#define ABITUGURU_SYSFS_NAMES_LENGTH    ( \
        ABIT_UGURU_MAX_BANK1_SENSORS * ABITUGURU_IN_NAMES_LENGTH + \
        ABIT_UGURU_MAX_BANK2_SENSORS * ABITUGURU_FAN_NAMES_LENGTH + \
        ABIT_UGURU_MAX_PWMS * ABITUGURU_PWM_NAMES_LENGTH)

So IMHO ABITUGURU_TEMP_NAMES_LENGTH should stay so that someone
reading the comment will actually be able to understand things,
removing ABITUGURU_TEMP_NAMES_LENGTH makes the comment very
hard to understand and we want to keep the comment.

So NACK from me for this change.

Regards,

Hans



