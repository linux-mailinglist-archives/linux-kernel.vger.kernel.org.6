Return-Path: <linux-kernel+bounces-412823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3A9D0FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676D2B25F03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B186915B102;
	Mon, 18 Nov 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+oLHsSa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF9194151
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928888; cv=none; b=ZJD4sXQLkUmbjEMrsaSmRfliHT3i/dQDP1kRfC3DT/Pjz0ep8fHDEnxOCMrledWZUeUnepeVMqkpKJMzVTFBvJTXnWDNJoJXUgUlgalw3JREfeco4ES7MuzFKey9PQ+fhu3Ib0CD1R67Eg0iaIhYACriA+HonsarBN9g4DGkoe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928888; c=relaxed/simple;
	bh=gCjdTwJtgC8pvpKGrKkLfZzj0vbHT92cffiGbzomHu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KEDRcs+ut7azkd5rRBaeTrWdo+uoxIHYItBgG8aEbWlTbRT8rsvh9acYtCW316TnRrS5Wi44Vn2k5LI0UynZjsZykenc3VZSVRR1AF1nmkV6FR3pWXi1ztEKO1iBFjtf+rSiMaYfXV4t11+iF8JB0rVsusF7iqH8azT6QY8ZyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z+oLHsSa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731928885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J/vhtRuGapTYfwMrUTXvgOIYZYR68jtcwBM26NHmo8w=;
	b=Z+oLHsSadrhu28Ja6A1T3nrGvLGGM+9W1Y02ymnndpzPCf+2FUaGH2n9d50Ao/mOhRI5+X
	xFWviNmYKWUyWDPaPl3SY3Ab8I36B+0r/8eThvdnMqmN/4rAkwsBANtFDj6mCsxiQdSG6P
	0Z7v8Gqk7Iw5Qwa7a+VHdCsPFTSCBBw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-v6i_-ZHRP--ZCQCl5c9FKA-1; Mon, 18 Nov 2024 06:21:23 -0500
X-MC-Unique: v6i_-ZHRP--ZCQCl5c9FKA-1
X-Mimecast-MFC-AGG-ID: v6i_-ZHRP--ZCQCl5c9FKA
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5cfca6de3f5so669731a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731928882; x=1732533682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/vhtRuGapTYfwMrUTXvgOIYZYR68jtcwBM26NHmo8w=;
        b=ayfuK+/EromZObFKkJgMDLfFl8EYMCRciAvpLvbj4us3t4AHLr0FEYx+slUwABjd2H
         KNqhQHzRBTr0j8xElOzBo73TIYNZsFFAVt0C9AGcHW0N8TzZEZv9dQu3hQFWqP3DtTHj
         eMAkZjevwBzSatff0buAC+DIMRC0TAdZT9n5zxYqoG8oCVdHrvBVSqlG+/1M68+EP8IM
         jnAiCkYT2yxkW6oFB+ZX0HPoRSvqOJq4PebcFkzgR1w2kBh+KB3j3cZaAMYvsk9qsXLe
         CLTKRVIQQzr7khP72qcQjcaaXM6alvDgt33mRBqjaHfY8X7FYOpIpZ4Yz4fNXzFTcb0Q
         rv9A==
X-Forwarded-Encrypted: i=1; AJvYcCXBVSkD/crLmQYqkbfgXINoadq8iQi4YS2ldW1bd34gcXTEIP4xT/Xs/oU9aXrtmgpwXkAlLQMVWsPOoJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpapyG0Wh6LkFW1M/o1EHKODvYgtw3/4vi5BQzqE3wDBTBRaKY
	3qZGv+lyadGCyG5MYGd2sVRd3TvTeO5O2jmOV/No8OPd4OBCt4r6iErXxPQXE54OJC0KF+HLAtc
	RsllsBhaC0Hmv7GvjNxmz3i5iIpvJ1yFB7ZjPcNh5P11Jk8enkkAaIsxH30/+cA==
X-Received: by 2002:a05:6402:d05:b0:5ce:fa47:18b6 with SMTP id 4fb4d7f45d1cf-5cf8fc8c279mr8212963a12.12.1731928882643;
        Mon, 18 Nov 2024 03:21:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyn/GEysF6WORMzNW3q8gK3j2rSf3hJU2HyR4Q6dLKfu1IWv3ThPBnLW69j4Xl3SiqiqZiPg==
X-Received: by 2002:a05:6402:d05:b0:5ce:fa47:18b6 with SMTP id 4fb4d7f45d1cf-5cf8fc8c279mr8212941a12.12.1731928882287;
        Mon, 18 Nov 2024 03:21:22 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfce9e1e38sm620404a12.37.2024.11.18.03.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:21:21 -0800 (PST)
Message-ID: <646da4cc-0030-4f11-8a1d-4e4aaa1f609d@redhat.com>
Date: Mon, 18 Nov 2024 12:21:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: panasonic-laptop: Return errno correctly in
 show callback
To: Yao Zi <ziyao@disroot.org>, Kenneth Chan <kenneth.t.chan@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "open list:PANASONIC LAPTOP ACPI EXTRAS DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241118064637.61832-3-ziyao@disroot.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241118064637.61832-3-ziyao@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Nov-24 7:46 AM, Yao Zi wrote:
> When an error occurs in sysfs show callback, we should return the errno
> directly instead of formatting it as the result, which produces
> meaningless output and doesn't inform the userspace of the error.
> 
> Fixes: 468f96bfa3a0 ("platform/x86: panasonic-laptop: Add support for battery charging threshold (eco mode)")
> Fixes: d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")
> Signed-off-by: Yao Zi <ziyao@disroot.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/platform/x86/panasonic-laptop.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
> index 2bf94d0ab324..22ca70eb8227 100644
> --- a/drivers/platform/x86/panasonic-laptop.c
> +++ b/drivers/platform/x86/panasonic-laptop.c
> @@ -614,8 +614,7 @@ static ssize_t eco_mode_show(struct device *dev, struct device_attribute *attr,
>  		result = 1;
>  		break;
>  	default:
> -		result = -EIO;
> -		break;
> +		return -EIO;
>  	}
>  	return sysfs_emit(buf, "%u\n", result);
>  }
> @@ -761,7 +760,12 @@ static ssize_t current_brightness_store(struct device *dev, struct device_attrib
>  static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> -	return sysfs_emit(buf, "%d\n", get_optd_power_state());
> +	int state = get_optd_power_state();
> +
> +	if (state < 0)
> +		return state;
> +
> +	return sysfs_emit(buf, "%d\n", state);
>  }
>  
>  static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,


