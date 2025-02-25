Return-Path: <linux-kernel+bounces-531396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A324A43FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DA1888AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D955B268FCC;
	Tue, 25 Feb 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXHxO5t8"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7F268692;
	Tue, 25 Feb 2025 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740488469; cv=none; b=swinGHElCYV5hm+tzC1k37rX5VLXA16xcyGW0qGZRnJTnm7sm5B0A7XZvueG4sb8cYw0QzdiI5kQZoAHD4tfRIJZ0A56uYuxlRELNvh6B0WO61aBP9HcmFUDk0J2/cWjNqc38QGXswsAlEzBJK9cCa2ZMPyBvsHFf1tMVUmW3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740488469; c=relaxed/simple;
	bh=AKvP+DezHDrhfDtylWSDmU/7GAvJdbJyTqTNlabVW5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mXD4xYcyYH03BYfD8pM9sSheJGSNTIEbHa+nPDbVoervZ2AlAs2g5heAqKhOQCAqeRJaPAUuDmWrl8eZkv6fxQ9/xTACpLSOZ4SK7fpIVbFEbwi3wkkFDecXm+7SenEDWK8emvPcnUSIYCW8X7Hi1tuDRoP5glCvLgDg8dwYIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXHxO5t8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2211acda7f6so123676775ad.3;
        Tue, 25 Feb 2025 05:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740488466; x=1741093266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HdGuQ3/vwWjs2RU0n+dwr9k7gSuPaWOEQnPNggnl1RI=;
        b=kXHxO5t8dpZAI2xpQwQsyIPDrx4fEeoudzQFQ0miNQeYoZ+NYxGceAWHvd/Ht93x82
         0ic1thY1i0csusQ+qTMCoiCABWFzgANqBdiKOT5ofVxeUPgYKA3w9sdYBGDPivKnBU2R
         Dn3aJnnGKZBa9s8a5PtX/bb7bDLhPCaYNqebHLABkDLyxJFl7Q/2XpqlFNRASuybEKc2
         gwvKKojzM5gj8tvPeW6akUn+hAoMrlYHlii0BkfBCam0oP5cl5MDWrtD8E29EibEivJq
         UOGxcwXnDoimwyc1wCZK8KvaYcIvjXjrieqNbck5a9RwA2SjxTtV6OML+6bo75W2KD0q
         7Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740488466; x=1741093266;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdGuQ3/vwWjs2RU0n+dwr9k7gSuPaWOEQnPNggnl1RI=;
        b=sP8yEVG+MjZM5Uvr1EHsFURKbeTLcGJyPn+RolAQpYHk0/icbOJnVjTGd3OJ2X+mWi
         gAXMPOVsdpBtQkmXpUr7D3zd+Aj8uUKUw63T640+HB59qqWevoGZ9SGSChgv83Y5eugK
         yc0XVMKdgLg+QGJWJFZNNNAcp4mgtBGNcmKdE2tbFkZTW/mGVzd0c4Fv+UmnG48HFUNO
         rNFIz5s3KjkJOCFJE5/yLEElo/HtqxJLkZ+PNsgw8dgPTZG4JMAUMICy+8iLfaI/Eyzt
         bJeZ8vgkGvPY4xnNWwJ9l1HORDGD05z9+j3a58NtuBFhuyVdLp3kKvcs4ROPhcdTzLiq
         0huQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz2Mh/HTWW51W+TB+H3zyF1Vq7oByE2cXgRxO06Bf66SMPZEjeuShNLCCjirxdiZbnxyBjsbzFyesZKQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD3hbL29ejRA3L5RknU6VKFSNuMq9lkgYKOize0taQnvxnpUM6
	f21Gr9hjYgvU/RBOU3wYIsfC9qlyVKVwNMo+BlBdVXy53XxIdnWA
X-Gm-Gg: ASbGncvOpkZRnMmlqJ/zhjrb1++otvIuBQlDzdwcD/5fiFWmY07xb2pXny0VzSMgXpU
	lkD/Aq8IfhDrOz1xydwN2PGuetXJg8E0c5prAleJir1o9oXdEjlJuJU1n88v3o3VNyLAIHkGkZ+
	HtLapbjJ8giIy4xSoUfK9DnKhHDHhethmjok5DNls9GtOc9mMn6q3bOFlC6fJZeigWl/S5mZI+5
	kfA67IvkGRIm8GAmMPKgK4NmuifhP0XSg6K4EZ8EnRZApbDlGhWuWH6p0NTsOVe5rdXjzbYIAcE
	d26pntmeuR94rOdfAPue8MpqefmJc9fUWOztmSOThYSvhUOAJavjAMXH+VWEi/YNQ9iKcRNaZ5I
	=
X-Google-Smtp-Source: AGHT+IHikX61hxM2jp13oWdo08Fi3FYem1okkUrzV6Z5/PsyOEByZ+f2+YqA2hZFKuCir0VjtLCptQ==
X-Received: by 2002:a17:902:f54e:b0:216:7926:8d69 with SMTP id d9443c01a7336-2219ffbfff7mr272908735ad.47.1740488466341;
        Tue, 25 Feb 2025 05:01:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a095865sm13318445ad.145.2025.02.25.05.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 05:01:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8b59c8d0-4710-48ab-ad70-b2eddc74fa9e@roeck-us.net>
Date: Tue, 25 Feb 2025 05:01:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] hwmon: (acpi_power_meter) Replace hwmon_device_register
To: Huisong Li <lihuisong@huawei.com>, jdelvare@suse.com
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, liuyonglong@huawei.com
References: <20250225085158.6989-1-lihuisong@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20250225085158.6989-1-lihuisong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/25/25 00:51, Huisong Li wrote:
> When load this mode, we can see the following log:
> "power_meter ACPI000D:00: hwmon_device_register() is deprecated. Please
>   convert the driver to use hwmon_device_register_with_info()."
> 
> So replace hwmon_device_register with hwmon_device_register_with_info.
> 
> To avoid any changes in the display of some sysfs interfaces, some of
> necessary changes in hwmon.c must be made:
> 1> For 'power1_average_interval_max/min' interface, insert 'average' to the
>     string corresponding to hwmon_power_average_interval_max/max in
>     hwmon_power_attr_templates[]. I guess that is what's missing.
> 2> Add some string attributes in power sensor type because of below items:
>     a) power1_accuracy  --> display like '90.0%'
>     b) power1_cap_hyst  --> display 'unknown' when its value is 0xFFFFFFFF
>     c) power1_average_min/max --> display 'unknown' when its value is
>                                   negative.
> Note: All the attributes modified above in hwmon core are not used by other
> drivers.
> 

That is not a reason to change the ABI, much less so hiding the change
in a driver patch.

Guenter


